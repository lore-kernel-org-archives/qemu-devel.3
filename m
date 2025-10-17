Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2910CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:23:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kKP-0006Ec-DJ; Fri, 17 Oct 2025 09:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9kKN-0006DI-J9
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:17:03 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9kKF-00063J-G7
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:17:02 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-781421f5be6so25797557b3.0
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760707009; x=1761311809; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7TPU5XqP3DgREr2vUJwqsd5twFBOrmveHWArUFDvCoI=;
 b=SjhF/+SOXpAJZsQDEj4ZnJxOHWRgsaWGPQ1BhwXzkkCAgeEW3bz8ZN9WyjpaLn4h95
 JjqjyzUchhZDFeaw8NWilmxSq8KVGcl8W6Dq4/KwCOHDNLyx9XqPxTVaJQ2+pJbl4VOU
 /lVLAHu0xEazi89MMpd5fySmKWsre9kXLdf6rIJx43Jk0DW+qPGBqQt1MOiRxQdTthnO
 WYuxDCTKZDlGzm27UWmxs2KeY4b5ErPcW8wdl7w9voL+IJ6j3iu32LWUbwMyeKadaQ0a
 j4PRIzQ6+16rE8QqRXsWG0P2F4cjWNcpFzmRLs3JnGOC93GM/PomJ6D+lST9MjqqTF7J
 /Gtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760707009; x=1761311809;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7TPU5XqP3DgREr2vUJwqsd5twFBOrmveHWArUFDvCoI=;
 b=T7nm9GUl860im/XViAuJuCC0I0n5RypWZTaJEEG8UNDrMrhE5gUgiY4MtxhZOS7RPW
 91Je4Xq/Fb4mL9vDMZdw0dWzptQL0bUPupn94RNl7orWuxh3dvBEePq3wyfxWLtXJlzt
 iXEj8mpS8Gh45ZjOnIOwOgd5xvJmyaHNsKuPgCLIJhTccu3Q5ILW6VEuQiFnRLIUc+jI
 kmug9LNKxkz7TXHUWz/8wOVF+R/DJHr50S4korNGK5eUJsnf2tI9pawh7N5FRDjjDo8N
 X2TfNYmv/TPbTTLhoVBKqWTBsh70scPAZAjupz3f84qxr7dTe4JYUAI5qX4jVaXQ0DDq
 q2Vg==
X-Gm-Message-State: AOJu0YxfSah1ycSeNHPIxLMWbGH0KVu1ET6ibYxhfRT1SmB3UcuMBJmo
 ChhQb+NCrftcC9wqPQSVp6xl7TSswhRFpizarOmfWgXD/y9j54xdwHQ58J6XekJsrcswvN6YC5X
 +oSpgI0IJhG5IsliCIiU67tMYl3pOa9vQN34FJ3XeBw==
X-Gm-Gg: ASbGncuviBHqJRsCNE7nLEm/ikQsVbVoiKVWmSqb/pMn82trqCsKe4GyZFPvFtpN+2H
 F2TQfJ2HQo9cF+Cm9ktAfq4xpjITkP/i8nzcITa8yEWLdV/+2RZUAE1bSNBJDzs7NFH0yle4vvG
 CZZhgLfM8QLBrrn4KyXFZgwHl7tG//i3uO3O4VlDBQbOXEq/za4nXDRDG/nQ+G1Sa5n3hfraZBc
 1DNdCnKditmOvpnbePHf6mW5fHjrIC3OR6h2gd09nv5hoQ4KxGdBgNcdDKHDQ==
X-Google-Smtp-Source: AGHT+IHwySxUilY92HgXDaux84iUgENGKAIJAHBXR0V+ON2rRNJk+W0Xo8Pm52WGJhpdIKlLwlsip11NJLkiJRfbuE4=
X-Received: by 2002:a53:acd1:0:10b0:63e:1ee2:eb12 with SMTP id
 956f58d0204a3-63e1ee2eca8mr945659d50.23.1760707009646; Fri, 17 Oct 2025
 06:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <20251014200718.422022-1-richard.henderson@linaro.org>
 <20251014200718.422022-10-richard.henderson@linaro.org>
In-Reply-To: <20251014200718.422022-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Oct 2025 14:16:37 +0100
X-Gm-Features: AS18NWDpYkVCRIj3ds21V59gW47gXG4-rIpsqOQH9vIE9rVvvij0DqbY2vp8krY
Message-ID: <CAFEAcA_DVB6tdyLjHn6TcwKP14-gSwGyzjmv5vDZJbmYLVY+WQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/37] target/arm: Merge arm_gen_one_feature_sysreg
 into the single caller
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 14 Oct 2025 at 21:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/gdbstub.c | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)
>


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

