Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5A0C3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 12:48:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uApnv-0006vV-M7; Fri, 02 May 2025 08:47:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uApnq-0006uq-60
 for qemu-devel@nongnu.org; Fri, 02 May 2025 08:47:42 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uApno-0007vl-C8
 for qemu-devel@nongnu.org; Fri, 02 May 2025 08:47:41 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39ac8e7688aso1375232f8f.2
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 05:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746190058; x=1746794858; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7s8A52G4FFIf4gsa/3QPjcg6BWvLhHTy9zX8xBcoRuc=;
 b=NnxBie/mG5QyvI3Xd1PZzFrc6ULiEN1udYkwFVoHZL09g/QgPLHw8ZdmeOEnInEKPa
 ZwJ/8B87cNJBxAFTdcv/g96VZkExrZaMW5yGCvyJGq/l/SLhsGe6lanPLrhownoaKWvP
 SuIZkXB6DO8CaAsU6vbVmDvoGKy2wD9Ls0ZiFBpjlujo8m8YDMJXSF/99Sz8Wtg/23OR
 9JFiOgcRl3kXxk7DuG6nMAChtBTq7bx2GRVGotZowxh/W54gvsVcwksau4GnfTyBOiWF
 1BRrCDT+WZAFm1aLOuvFAj1fh5CffR+ntCOIYffC5qIKnZTNDLNsRDO/lnIYJyGuhg/X
 ZZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746190058; x=1746794858;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7s8A52G4FFIf4gsa/3QPjcg6BWvLhHTy9zX8xBcoRuc=;
 b=qKembWCmhYqG7Kz0zDrGaGgiI0kXWGS6w1rL0p1h/hhhahK9HXet0NaofuwgSpxTJH
 KGwy4xbW2uKvuhyt2UnVnXeYMLduPP9rtkfzyoJ1nwkH6vs7rI5/T91EHujgGb8mJ+5x
 9/OXOn6jNEcqjKhpiCyZae3erRiRkGXhPpj1MnkXQnqwQSLiX6V32mrVoj4k7Sh+oUE8
 f5Ucz1KxqxpwL192Ayzkj4H7sfbkkFYsghfggpTnV7XoP75sg53FJykord7qJLYGkI9i
 JoeJF8dR7Xu8IH0awZyADSSpVuNuEHsvU/kiNJbNEMJhm6IFDiVsb/iXmDJEYJjnJewD
 o76w==
X-Gm-Message-State: AOJu0YzVsUSCGCkkFzCNlkUAG9IXvq6/XwO6u/vKry02twW/1NsqddmN
 Y++shutLAF9ug7NcQfrRovLTdXnoSzmITDtxuBy1I9CN7Z1QFeD/4RlHFcy6NnrczBGifu7NESj
 ghFg=
X-Gm-Gg: ASbGncvvg2zS5SKCU+TE9To6bdJpmtOJ2B8GPUKGCmkCxogsmKxKSWcnLrvcAbLpnYv
 hNUkOixmsHFXqrXN+hXzINf18eViEj/OxeBKHAvk+Xu/UhVwblNG9EgoDIqkfB66skwcFPaEvXa
 JCtiI1o9FG/zpLgIxGZ9DwNIxJNmTNUMZ98vfZyPKao6joj2M6DmgyNncef+V2DTbzWCVatAlgN
 bDaLwV8RNLzC2iUSM7h/uCp/mhWpG3DSlUOMXosmMvO6EkYMwqc1QigjsWxVeGBs2eg8uVhFiMW
 i6A5jWzHPQHGEkSWIF7A5rRdrt4ojzrTcXVB37a3SoOLoUJgYpHm1hKwz+v/sJMQPDBjtbddlBq
 Cod7oHQ==
X-Google-Smtp-Source: AGHT+IEk+vS0zK4/AbjgnBXSQz3ZaCLrGkP9Fe5NXQHXPqWZqs8p6UYJNRx0L1Sq6+uBsqOusrT6Jg==
X-Received: by 2002:a05:6000:250e:b0:39c:142c:e889 with SMTP id
 ffacd0b85a97d-3a099ade119mr2003182f8f.27.1746190058441; 
 Fri, 02 May 2025 05:47:38 -0700 (PDT)
Received: from meli-email.org (adsl-37.37.6.161.tellas.gr. [37.6.161.37])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae0d15sm2132881f8f.13.2025.05.02.05.47.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 05:47:38 -0700 (PDT)
Date: Fri, 02 May 2025 15:45:23 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-rust@nongnu.org
Subject: Re: [PATCH 4/9] rust: qemu_api_macros: use "let ... else"
User-Agent: meli/0.8.12
References: <20250502102323.104815-1-pbonzini@redhat.com>
 <20250502102323.104815-5-pbonzini@redhat.com>
In-Reply-To: <20250502102323.104815-5-pbonzini@redhat.com>
Message-ID: <svmwvd.2r122ko0uqc0j@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42e.google.com
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

On Fri, 02 May 2025 13:23, Paolo Bonzini <pbonzini@redhat.com> wrote:
>"let ... else" is useful when visiting syntax trees, to avoid multiple
>levels of indentation.
>
>Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>---
> rust/qemu-api-macros/src/lib.rs | 84 ++++++++++++++++-----------------
> 1 file changed, 40 insertions(+), 44 deletions(-)
>


Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

