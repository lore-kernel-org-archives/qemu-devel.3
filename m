Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00227C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhZB-0003Q3-V3; Fri, 04 Jul 2025 10:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXhUN-0003Uv-9L
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:34:07 -0400
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXhUL-0000Jd-Qj
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:34:06 -0400
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e8187601f85so949490276.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639642; x=1752244442; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YYYLt+ac5CIf9dBt7IH0LmdYNv3xWnYYDj4nIFCxzhI=;
 b=PwSLNIo6cXzC3Yk69f4Lj4+CV3qKiuqQZM/E9zh1up8awznUMTWTdhr5Ev+zmQHrC2
 raQwBIniDtaj2YwFnpEcFRCMzsgHhpT4qSU68FU0CKER4N0tDGnnQmKD1JGTjutJKVUf
 ZYyJgi+qc3MAEYdq15juxzKn5K7SqfKCxUwDV25AilVciOUU/T50J5Xt8rPLl7euUROo
 k3HOcfn2Q55YgfIQyhC7LOr23/g5LgNccaFIZhIGUhXogqgH2CzIKPxtzPhaQiH60fsr
 XYUS/MvUPOUXDFkI06jCZ7EFZZ3KhASwwIxd8sPYET5lwzKV7XcscmPcC2rWPpfjwxvO
 Mq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639642; x=1752244442;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YYYLt+ac5CIf9dBt7IH0LmdYNv3xWnYYDj4nIFCxzhI=;
 b=OTX92aq9mdWjXXHGh09mu/bvdOOM4YBYxWrDueIdrCFVoGatSg90bjEeZ/ZZE62AkR
 ZoX58/2fqtn1/zkbdYRggu0xuW8GxeNJELRd6KjlJlMYc0fIH+p0OrNMb0N89IpEzDUl
 DS/E7auDImft6BSd1+2J4LdtLU5XK7tGOnNWHudnaX1jWa1brTfcdn22WvfSKSI3EKWn
 gnixtzQQYZX+cUbCZ82Y/IV6KYcs+/1twJiAMFXHifTImK3HEJhLX54rggPbM3apM91J
 uOGsD6UjL8Xl2aaxqL8uzfh2Fh6l5XM0s3H/1hRhnXxLCpw9SM+kyQ7R6UtLjF3z6UoL
 oemg==
X-Gm-Message-State: AOJu0Ywz8ojaUApbfdYPn4RbsY0SGUWdqChj12h6VlQplEQNgVu6UE8s
 CdgpdKiNgHUWtUZcLYQy7GRHoI4dO7kSXgIWyBY4r7B+HO0PDMDm7661UvIvjfpcy+DK6rpqaen
 PyMBFoifmC1+IGR/wWwNRh+FUjtHqo3xzR6g32qLyqQ==
X-Gm-Gg: ASbGncuzzVF2kkDNLDrYQ2oTtiV9wEvfo/i9Xo08wkLpP7GhpyRQ9b0R+k2xgUlM7qG
 z2OZeu3v3b0Oi2PkCqnuxyvz+VS/xBj6VOxsTAZ8RNoEOINcJmDn57G3Dbzm7nb3O8pCBku5Ktw
 clabvDI6gKRe8JS18n7yYueYZhEY7b+1KtNY5slCngtKWs
X-Google-Smtp-Source: AGHT+IGGWjiUy1zt9qpf9bCJgl+mcl5h86VbUIKN9UOtzkXg2MLAQr6R/IPiyOlqe3l3oesZWFegYgW2/LTQZvCB3ao=
X-Received: by 2002:a05:690c:7201:b0:70e:404:85e5 with SMTP id
 00721157ae682-71668bf9aa1mr41866647b3.11.1751639642495; Fri, 04 Jul 2025
 07:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
 <20250704142112.1018902-75-richard.henderson@linaro.org>
In-Reply-To: <20250704142112.1018902-75-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jul 2025 15:33:50 +0100
X-Gm-Features: Ac12FXyfduQyR44u3uijABXG1p87m_gk94VYea0mjgJGYU52LqJftifHNcBKPoQ
Message-ID: <CAFEAcA9q7yi1UZ_89GEtifVgk=TTB1hC=zgrnOKA-d=ZdwE-iA@mail.gmail.com>
Subject: Re: [PATCH v4 074/108] target/arm: Split out do_whileg from
 helper_sve_whileg
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb33.google.com
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

On Fri, 4 Jul 2025 at 15:25, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/sve_helper.c | 39 +++++++++++++++++++------------------
>  1 file changed, 20 insertions(+), 19 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

