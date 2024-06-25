Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E61C30658
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 12:38:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM5R8-0002mA-Mm; Tue, 25 Jun 2024 08:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sM5R5-0002lq-SA
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 08:38:11 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sM5R4-0001nT-6e
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 08:38:11 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-57d20d89748so5272476a12.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 05:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719319088; x=1719923888; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9LcDom/wVqNmQl300icvpwvtnNCGto/IwSgDicC/7L4=;
 b=J+P3hsLdSX9TZd/uifyaiKFlEDGvFGOwhzsCpjXHjILgJdMzfT/Y8A3Kz30sKN5WVJ
 A5wsEbkiaDbY3kbM1uBsx8vp7+8vs6g4Jz7gRdfP/X/NL5QeSWc2KyY9R8L+ept/K13Y
 fyCVP3nKyyJne/hH1l8KI7+2+UJYpfS8Z9JjCJu7EZyuY8d0OGaSQs0eK+x0x/RG6cEH
 gda9QGksHGIKNXN6m4vK94jjIZtI5sUCd+HLk7iskhtGPIb+Z1/wfTkzNzI7DdstGWHH
 yOZa7RR7y1fubj42ihwU3nmYsv+i/CKvmqKkqkmWlbfjE79zgCy+5QIjQQkK3fRMo57z
 7RFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719319088; x=1719923888;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9LcDom/wVqNmQl300icvpwvtnNCGto/IwSgDicC/7L4=;
 b=klTAP/0pitTEywVDZMOpQr8kByW1C4GKrItvXgNTMHfU2nHhBawyeBA8P3XfB729IC
 dMCGrt/3KpgyuYqx5s/iUaCvluxu1RebHnumI/M36PtUMHvWxWg4kucwk2saygK0Ywkp
 9GkhL/WqM4QxP/mQTaJWMa1moPsSXQknj3OHX3j1cnWWfbwbkTj26R+Rw7fCwr1pShC2
 25f9gmRrkECizkCdgO6fXnRq71zmvnNCGmWPFXeTJnWj0vJiLmqL2zwRGP4yhwqQeF8b
 7OtDgEzNT7UYeuo7Mpy2xtgNXV7roE72McQGrCbmgouGbVEofA1/7IQm1PZH/VmdTzUg
 FQjw==
X-Gm-Message-State: AOJu0YwT7j3uwXxuQUjOo5l4aWwC4+B8kLuNaIlAWCBEMMkJIzuxWZIM
 DwNZara0G1/3noMgf/Edejfez9OEC2ycb7H8BYZe95JtZk3SqXLVruhBWoDqUG5UMlleiAFtDEi
 kBrQryW+JRbwM3yPbvjWNrW67O5wm5/gJfMVigg==
X-Google-Smtp-Source: AGHT+IFGCAJQspL6zRNsg2TXkLZhU95Tm/WQRjKMy/0RNgUXA67ShpSy4NqfDOVCXp/DdcwDmb0tM5Jb3k8LiH1kG/8=
X-Received: by 2002:a50:d6c1:0:b0:57a:322c:b1a5 with SMTP id
 4fb4d7f45d1cf-57d4a03e9e5mr5568989a12.38.1719319088337; Tue, 25 Jun 2024
 05:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240625050810.1475643-1-richard.henderson@linaro.org>
 <20240625050810.1475643-7-richard.henderson@linaro.org>
In-Reply-To: <20240625050810.1475643-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Jun 2024 13:37:57 +0100
Message-ID: <CAFEAcA_o_eZcmR9esDvyeDQJagCnXGYjBC=u_3RiEjgSP+Fkrw@mail.gmail.com>
Subject: Re: [PATCH 06/13] target/arm: Convert SUDOT, USDOT to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Tue, 25 Jun 2024 at 06:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/a64.decode      |  3 +++
>  target/arm/tcg/translate-a64.c | 35 ++++++++--------------------------
>  2 files changed, 11 insertions(+), 27 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

