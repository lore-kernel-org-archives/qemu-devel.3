Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E5D6C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgE1-0005qt-Ev; Thu, 28 Aug 2025 13:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdRt-0008Tk-2u
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:17:59 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdRq-0005bm-1r
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:17:56 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-71d603b62adso8521037b3.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756390670; x=1756995470; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BBtkKY8w6xcEs73+TJgkEPOAbQNImmjwL4WLhW8fu4o=;
 b=XgPCaSaJE3TJaOXvU0fbeD2gaNkgTGm52CDibgzHeAv3sawGohjs4dWd6iLItIagO9
 olQKxxpKetsyIRZEIHlThzMBg6tcL7tkQiwtWLKNNa5hpUQ2V+qOyaV8QLLnxjETC6Od
 TQ2khs+MTfP7XXxXV3MaaTiK+I69Lo2TA21orknEhaKl1EP9YdFjTKN0+yyCsKYVX76b
 iofn8cn9P2xn1rOP65JwQglH/NjoHYgQ7qeOh+X224C8y/dGcnPC4NWEDNPdXLXH7mKX
 E9A7/mNo1vcO3usxisyiACjdd2t7Ejop6dik816ydO0rYywpkI1qX+W9F3QTUQ2zsJuy
 Q3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756390670; x=1756995470;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BBtkKY8w6xcEs73+TJgkEPOAbQNImmjwL4WLhW8fu4o=;
 b=uk/9z5aXzs5Hb4rdY0IZ2gty5Tvsk3+2q6ddkBSLMlT2xvFjnpPvY1MW6mlZk/ZhG+
 UXl9nuq3fzySCOaQHOqiZphKlKtUjvBO8aZMRvsyxtoP0319t3YVv2oFWXy/dTLWRuNz
 rNJtLhENBnbQTFKld2+su6JdiHxZHVsQ0nD5lDM/wrt3qDeXg6XJt8hqQ8jrkAg0BIoq
 DJeSxxGlHTIJ8m2zWJGq+eBEbxE2k9KNwqqBcELpCQSBOr7/20vHASgz0mULANrxuwpA
 rF7Fh7sflHnpt9ZmG6NHifLyZ4wIh4Y9+1EW2ourKv4Dfrmi+n+PM4n1jtYosEsqkmeZ
 0BBw==
X-Gm-Message-State: AOJu0YwiHz6eOwd3B4pm+pbYkjl44+WOCo62eA9SC2KqX4vi2LwoQ6kS
 nzg5IxElld0pYRHcgkXCz4scGr7dkfRplNt/OotDLMLpJiAUHf9SjTeI31uFEXKWKPDjp6+kHzr
 Vn0dQe9bkAnrvM1CeQLCET+D1JRTlCT5BJnRrDFYDqA==
X-Gm-Gg: ASbGncuwicER/SWIwKsBt3xdq8aK66K3D4Mr0KRjL5EzICrGz5NecIJ+/Wxz5xQyrGm
 6lm57HV3daqoBrhnh+B5fsZ422fMyg1gHEeKwUbfp66eTJKaKYLymFDwi7GACWFEltRr+lK2omv
 a8Du+v7eC2M9Qdf3Jc/g+eEUKBpbo/MEYVNIj4lAYxFcEmel4KW+7M3QbozTj5xqpesfHbaL/Qi
 g8Vvr1JP8bnISJ4Jyw=
X-Google-Smtp-Source: AGHT+IG9kEcsLcD4ODzIrY4mbq9nxdh11n3N/dHSKEu9PDdWV5eIGZ8EDR16nKS/RXMb9IToOAntblotquLmJ5hdFYQ=
X-Received: by 2002:a05:690c:7005:b0:721:369e:44ce with SMTP id
 00721157ae682-721369e6557mr104665367b3.33.1756390669552; Thu, 28 Aug 2025
 07:17:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-3-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 15:17:38 +0100
X-Gm-Features: Ac12FXwG5twVUEzbGSrLhR77kUtPt7AYbRADsiexKnxgOu_nXHgUWqHf19ZCMJ4
Message-ID: <CAFEAcA_Jnp17ZFu1yZoedmor56F3ckFS_LzFPk3WautN7R5QSQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/87] linux-user/i386: Convert target_elf_gregset_t to
 a struct
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Thu, 28 Aug 2025 at 13:08, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c | 40 +++++++++++++++++++++-------------------
>  1 file changed, 21 insertions(+), 19 deletions(-)
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

