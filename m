Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C825F364B2
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 19:07:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAuic-0007Lm-O0; Thu, 09 Apr 2026 15:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAuia-0007L3-R9
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 15:07:08 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAuiZ-00033l-DY
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 15:07:08 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-6500eae6d2fso1659059d50.1
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 12:07:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775761626; cv=none;
 d=google.com; s=arc-20240605;
 b=jT9DYtBJXZHUSMRkHoaYrFEwREgeo4RIARiYC5cS2nJrGJ6Dym+gC0UWE71hsu88Wp
 /jwA5aO88O1V0OLFxqk3vDZQkXFTSWZzzOSh2uiFWjNPZaLzMY20xym9+l+GI48ANprL
 F9UAKXp3VUgsht4JO4L6njTJXIHBfzqBJmqzZYq4ZleXIikY0WbIPoKYPB/JC8hxKSf+
 ERZI6OUnqmoAHBPfvo/W0j1iHstHYgz26Y3/0X+2hXMMWERelbVC/qpUkbouHiQZkVGZ
 1hbkdY6Fg9119fIgbljWKf+LUlV179JARzwVM/0h/BO3+XIr3eTNJkNlgiEOEioWRdKc
 CHgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VCDUOnUjYsgKHbUr94QqzMix7XhtwcU4xW+CD4gMNVg=;
 fh=6f2ksvrcNK0+UxfJWTqhzPgT+A1saGHsnWpNshlAcaw=;
 b=ffVj8o4Guq3aP0eQ2XDN9/Ktks3V0DiG2DhqiRCS4nIl+zOztbyQE2v40OfXx2uMFU
 QQYjDWqeKekowVFtgK5i5Q0ccloWmzw2gBT2HjA9B+a3qU+EJvTVEGsWW4ObxGaPQ0Gc
 PEyTQGRdUV0QHwY6+0G8fRNXiB1sEn1eIZb7hRBd1rEWGM88CVRKJmBV0ew0h7qVHwla
 bW6Qo31at7Bn0yrNM4swGtCif7F2Csg+zskZI20Rr+7JfdlfmXZn1AW7qgpBE6MuzSlj
 90Dob2sptvaeFE3pN25GqH04F8DkcLz46ooaZyn0D014VVb0JT2k8FB5Cnt0kH4IJmyU
 qP3A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775761626; x=1776366426; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VCDUOnUjYsgKHbUr94QqzMix7XhtwcU4xW+CD4gMNVg=;
 b=Xo0hcWTkS5OAZSMaZcsGOc93LOPCRdm2k3pmw158rmxsiaELhbagpIyrE15Hg6YVaD
 nG75owccc/RfiJ1ldTfFW3p0Oazs3GyZmBRKXR7QyTC/yx3gOcEJgBaC4emzKpN3tpm5
 yeRObIU6ENgO5xM8443aOSjDC9cuD1P2FnS1mjqi93kWrXqI9i2QGgLp42cPFza8l4Y7
 RdTdJvh5LjF/kV/gs0bU4wgKmceiR8XCRr0FwHIUCCTav6bDlgFapShY7s9toUWue3eL
 AmYlOm4GjpT+dI2jAvCu+VKagoS8+Ggmaaf0XUC8VZb6UokVaGZkECOe8zfjgVeJH77I
 x/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775761626; x=1776366426;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VCDUOnUjYsgKHbUr94QqzMix7XhtwcU4xW+CD4gMNVg=;
 b=qEqxuIQp+P4rtqmWiEin6hdjbDciDN0l9qbHAvpUQ7JJTO6hQsj2T1WRMsUiDf2iKm
 IdNoTQUmOajPhF1F2fAkKbRfek++cfPJvsMzM5ePWwa9JL9udS4Evxi3+jVXC2haj38K
 9/AfnnR5kwS1xnVwQ1JIId2A8+fFOkgV4RYJMsrPUkVmjJcXcMq414544KP/dEfpzpHG
 IFLSAfCmKkH4T0j7rhpw4yWddNEC5uZbDnBmT8yy9axdx5+dwKFrMs0o4COPg3Rf5GSQ
 8K+Nh+Y389cTFRp6nygoquriTSG2oFZUkgWUrZ8TyIVFuT/ACrPhMKBj/08KX1o3qV2k
 KRRQ==
X-Gm-Message-State: AOJu0Yy4v40k2mQrC3FZzB9QLoe5oWR2RSJ9o1HPI3bX6TnRvlVG2bFU
 jyJ3F9YOhkd31Ef2cn/aRrrkM71OBOZ99XkqTheO9Wchcjc1+qQzCPJYdBogkSurdx+hojDVXjH
 qV4XhLnYTXwOXzfXhRz2OZPdu8ed4176jwyEaOpdN3w==
X-Gm-Gg: AeBDies/2IQGvne5fTI+zxVHFk1P1ZGk3+UHl8fJM27dBhtM9X8IXjP2N0Y9oMK6bsc
 vDjRu1jpUbY/2LrEwXOrJhqdV/o5Ywv1exZaV6r8dqbb+AI359sxwqKdLh06tgXxeTolSwcbtBb
 Jcb3UC9CH2O9pl2Fm0pvY7cQk4XfXCXdH7PshHVgj4J232kAzCgodCJJzrCUO0sykTakg4HixSo
 taqhGe9865/sKrww0LQkKH2rEKzDZ7PaJp8W3CP6q6UEFvgjRmPdnkiIPNVS1j9DVD1EouYu+uS
 u8Rb7x9nam3h7ChrJYXQclnhTTK2dpSV70pUgorcBlHk2qzXV/CvfJiPid5XnYj9yGE=
X-Received: by 2002:a05:690e:d5b:b0:650:7511:789 with SMTP id
 956f58d0204a3-65198b56614mr187656d50.32.1775761625740; Thu, 09 Apr 2026
 12:07:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260317175744.32469-1-lucaaamaral@gmail.com>
 <20260409175234.40792-1-lucaaamaral@gmail.com>
In-Reply-To: <20260409175234.40792-1-lucaaamaral@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Apr 2026 20:06:54 +0100
X-Gm-Features: AQROBzATEW7_n-8rIJ_dlFdmJLtfB8kWhpFaZ2Te9cl9Ji6HKCB-46EM42_U7w0
Message-ID: <CAFEAcA8rF3nuUTd7ARkcGpr-sA1DYJEJc-2E_URQt6nr8u6cGQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] hvf: map granule abstraction, configurable IPA,
 and MAP_FIXED alignment fix
To: Lucas Amaral <lucaaamaral@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, agraf@csgraf.de, 
 mohamed@unpredictable.fr, alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 9 Apr 2026 at 18:52, Lucas Amaral <lucaaamaral@gmail.com> wrote:
>
> Ping.
>
> https://patchew.org/QEMU/20260317175744.32469-1-lucaaamaral@gmail.com/
>
> Mohamed gave Reviewed-by on v2 (nits addressed in v3/v4). Patches still
> apply cleanly on current master.

This is on my todo list to look at; I've been prioritizing 11.0
work while we're in freeze.

thanks
-- PMM

