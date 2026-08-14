Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE49C5CFCF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 18:04:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuwGW-0005Eu-3E; Fri, 14 Aug 2026 14:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuwGV-0005Eg-5t
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 14:04:23 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuwGT-00051Q-Hn
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 14:04:22 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2caea3f742bso23151575ad.0
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 11:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786730660; x=1787335460; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SfzeJBQw5NKfrCBNiollXEtLzMySSyzkzNLWVNoMiMQ=;
 b=eR+zDELGg5NBf9Mmkt9Rq1zcsxx8O5wNLzTDtAdN2cmgWkvWViwDqIe92oqFACzvwg
 VRsWPkDJriljBl+NsvQZRzV5jUB04z+whxkMLcj6shF8bBpVBlRg1sd5g8WGEtJTrpoM
 OC2fOJVlz41Dc8e/bJKZOrbJ2pb2OBx53x32enj1XdsLIwK7G8dA72CX5QGxk+2aVsjb
 0C/pj55iahWFmJfsVGaFbzi5wh9eixmGQt8yTaJyf6e4PBRdUPkyH5qlZ4nlgh9UNQpe
 6JSsLZDmjYG7n/yYmcj7NoSJCXkAaYG8j0zY7kKQy1mu5ev0Rm+9/pY4BAsyOAMt0Y6W
 X38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786730660; x=1787335460;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SfzeJBQw5NKfrCBNiollXEtLzMySSyzkzNLWVNoMiMQ=;
 b=Xw71k2fzwI2JxRQi+8CG91giN12BaWeiBq7Q/BLzpcK1HJURlvL5LhAK3QkcxJH01b
 LFfmU9msCJnNF2REuAKm+PgDEs/q5x8Aq2JZ8OEM31n5H6xzKdhgPxPoggAzUkamP0T+
 0762XWYa02w4uMMclSe5Y+qsFTh26EJkDOXyULeo42aDRWRt1y5gv5vjHmLcyCqc5TtD
 5SahsDpDEohTQj12d6ITwArqAEgU2WUSsfT2tW3mOJ6RvblQMyuP39F2GOpHzKZxOu7E
 Y9CIjeQU4n7RjfOkAocPc7Y6qDq8bHN4L9dxkIjkcdcNBuYrT8MvOCZjNjz6quDZiK4u
 dGeQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrJ29vjRzmsqGq6i2isoOE+LbTsZr2dE7/m27OROiFi4u8+U9JFH/mY7XAhUbo3pLD1Z2ow32a3/Kzh@nongnu.org
X-Gm-Message-State: AOJu0Yx1R1D/RSVCafUTCRp0zUL8FgqzKRL4QW0FIW+jf6v1XegkLKmx
 HuBVxA7YIGwkpMo21nK7qCmzMwI2ZhweXarJBOjALcKCg8GUaeyxIr/H3jbEtd+rm2e+tp/sOIQ
 lIIdb
X-Gm-Gg: AR+sD11HP9PankYxPR61mDKT7RwBH3ZPJt1VIJsCH/zeAPeZ8t3+zjBLEo7FITb4RPM
 xJkKD/P++vuHpxcN9M8sN/z7afXzH1kvnkVx3OEQ4VyPrxEOhhR8UE3iANWTcVbhl/jFSK+wDlL
 OZi/M7VAm6RM7nm1HVVp7C7kxodTW2T65u4WcitZ6BpidGfeNDutB46ciBzT1v4VEyWyuTyH2dJ
 k403z1MYfuCA2/y6ESSUpWnId3uefoV4VFwandmhX8qtbz899PpjIaAeQOJxibq332cqP9ysgT1
 gH+jOAcBe1Jj5Pb9LPYXf22K8skCxghKXP9TRRiDOOrKLpvgLEmdeWj7emFbXQacR6WODhS9Doi
 xpcl0H0LwBQwOYZF7cUvrE+HvHSFlqCLDrBaNuihAB5AilgU5o7bFHtuwsgI5jUlRowFZC8X9Sk
 2sif8dIE0SbFdS2ELLyJglVDAb3h6cKGqc1Wq7oZvyQFjD1Wv3Xk/XJKutMC/47tupwajdDMitU
 1cnnZH3i5/CdmtUp+0BwD6FJa3d
X-Received: by 2002:a17:90b:1a87:b0:38e:57a3:f218 with SMTP id
 98e67ed59e1d1-3933b956294mr8533255a91.13.1786730659946; 
 Fri, 14 Aug 2026 11:04:19 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3933b79af0esm1430250a91.4.2026.08.14.11.04.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2026 11:04:19 -0700 (PDT)
Message-ID: <f9ca0aeb-736b-475f-87c8-bbeb0d00a4d0@linaro.org>
Date: Fri, 14 Aug 2026 11:04:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/6] qom-qdev queue 20260814
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-devel@nongnu.org
References: <20260814113044.2416794-1-mark.caveayland@nutanix.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260814113044.2416794-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 8/14/26 04:30, Mark Cave-Ayland wrote:
> [MCA: This PR is signed using a new, separate Nutanix key: please update your
>   gpg keys first before processing! ]
> 
> The following changes since commit 539bc315538afe036a4b99088659aa82e3b489f2:
> 
>    Merge tag 'pull-loongarch-20260813' ofhttps://github.com/bibo-mao/qemu into staging (2026-08-13 07:16:25 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/mcayland-ntx/qemu.git tags/qom-qdev-20260814
> 
> for you to fetch changes up to 6b97f3d4d6a5c3017f6f7655019097c777f5eb86:
> 
>    qom/object.c: rename object_class_property_uint*_ptr() to object_class_static_property_uint*_ptr() (2026-08-14 11:31:18 +0100)
> 
> ----------------------------------------------------------------
> qom-qdev queue


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.2 as appropriate.

r~

