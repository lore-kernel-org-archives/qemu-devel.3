Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F1DEC282EC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 17:23:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsmGZ-00044l-07; Thu, 13 Mar 2025 13:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tsmGW-000444-SU
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 13:22:40 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tsmGV-0008BY-4r
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 13:22:40 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cfb6e9031so11898915e9.0
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 10:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741886555; x=1742491355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EI+KOHZxHsLr/5FkYVDIZUyFsf3PC75VlTlB1d57+yE=;
 b=ebGu0yCOPiytDGwNAPPohzpToAilyEt7kX+x6AYA3ut7goCEqxBUG28F6neYXIfhK2
 +8f20S8V6kgFclNxU9dBEUXcJ3X2xJX2jAQRsMyDyrchX03P77VsvbmjrRBeQzCQInnW
 O+/Y7Tlg5LeBsROXSnD4KMJ+boDFt2xUb2md+bH68ARlZSYY1sgJlE9+e/RhDnzVzwF4
 4ELeRgJfbi04uq9LPQmFTYWOjJs/AOn1sSs0q3xaaxfy/1HYD9secE2hjWVHMjsFCi71
 x33tcE8vwrWTdL0g+/2NuXCPe8E296E4Jkp1Dp3o+buCyGpb4CBUd/rYOEYgA1QZCuTq
 vD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741886555; x=1742491355;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EI+KOHZxHsLr/5FkYVDIZUyFsf3PC75VlTlB1d57+yE=;
 b=v1xiBZHnuGZY1vV1WZUD6ZwBFZP3evbkzTxMb2J+6jTHhsZ/ZDnhVku9dpOgOU90xL
 L5xVm62Z5ZlRcGGMdbrTqTtV/131LXvmlo99MrWoHM6NY6Q1+4Oasu01C2ZxBkN6D2og
 I2ZwXaS2Z2oI+/yy1y8QhHKIzwOrmTJrEfNouXGPE0Re1W8nAHBfXiIo1qxN6lD/w/XK
 pp3r0+Q4JL/T1NldX3S1zkEwSVOxq+EWo3/rTRXFG4tlhIMdO5Kpshh5YF2PHLCEDAnb
 eeY2v+ASEOTz5RqWT8HQ9/AKwZOM9NlhVvfEB4JiktRA+TWtQB9+wB2ExUIHx7zI2R7I
 S+9g==
X-Gm-Message-State: AOJu0YxbbUKUROcv5eEJrKJn8omTECrm0cNo7TJEwV00YLhLwP6y5v2c
 wtU/StkfjHRgz/+reB5hAQ99sHUQobgs4JSFBiGY0ZTrzl61YxatwKrdp62fwkk=
X-Gm-Gg: ASbGncv9Z3aUZ4NGrS+0KlJ9TcAqt/zQf0Sg1iuwIuFdhjoHIdxwBvlAwNejdRVlEju
 1Lv4pl6a/Pxx+mfXLJ06ek6HVqEJDS0/MvUZ8pKMX7OVkJYfh8unijqgZMVZlZjHQQnRWVDP09b
 icIW0bjY9Y+U+cks3zlCX4eEBSgAvPaoFdG+Vp+kb5mO/uV9hdDD2Cxy0re4SJ5MrDSFdOBQ/q2
 n37KIO8b1MF75nZILjCyGx18gRR2UfCrzKHvnmbfeZ+zAFiAfgZRsxZCOBdcU+7sRA4+GQEoCuL
 eP15H6wuA5HB7Gxd9iMY+8OAWaFHlt6GPygYYZ+C5s23M4luwB2pq1vyqQ==
X-Google-Smtp-Source: AGHT+IFBDsEbj+AlVZoJEN2OthRlw8Hw9vaLfQN1r72gKPiF04HddOlZ1drmD2O3Po+tcQel0pTyPA==
X-Received: by 2002:a05:600c:3b95:b0:43c:f75a:eb54 with SMTP id
 5b1f17b1804b1-43d1d8b0efamr5158845e9.13.1741886555593; 
 Thu, 13 Mar 2025 10:22:35 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d188afff0sm26850425e9.6.2025.03.13.10.22.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 10:22:35 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 395E55F8C7;
 Thu, 13 Mar 2025 17:22:34 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  pierrick.bouvier@linaro.org,
 pbonzini@redhat.com,  philmd@linaro.org
Subject: Re: [PATCH 23/37] include/system: Move exec/ram_addr.h to
 system/ram_addr.h
In-Reply-To: <20250313034524.3069690-24-richard.henderson@linaro.org> (Richard
 Henderson's message of "Wed, 12 Mar 2025 20:45:03 -0700")
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-24-richard.henderson@linaro.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Thu, 13 Mar 2025 17:22:34 +0000
Message-ID: <87h63w4zhh.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> Convert the existing includes with sed.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/{exec =3D> system}/ram_addr.h | 7 +++----
>  accel/kvm/kvm-all.c                 | 2 +-
>  accel/tcg/cputlb.c                  | 2 +-
>  accel/tcg/translate-all.c           | 2 +-
>  hw/ppc/spapr.c                      | 2 +-
>  hw/ppc/spapr_caps.c                 | 2 +-
>  hw/ppc/spapr_pci.c                  | 2 +-
>  hw/remote/memory.c                  | 2 +-
>  hw/remote/proxy-memory-listener.c   | 2 +-
>  hw/s390x/s390-stattrib-kvm.c        | 2 +-
>  hw/s390x/s390-stattrib.c            | 2 +-
>  hw/s390x/s390-virtio-ccw.c          | 2 +-
>  hw/vfio/common.c                    | 2 +-
>  hw/vfio/container.c                 | 2 +-
>  hw/vfio/iommufd.c                   | 2 +-
>  hw/vfio/migration.c                 | 2 +-
>  hw/vfio/spapr.c                     | 2 +-
>  hw/virtio/virtio-mem.c              | 2 +-
>  migration/ram.c                     | 2 +-
>  system/memory.c                     | 2 +-
>  system/physmem.c                    | 2 +-
>  target/arm/tcg/mte_helper.c         | 2 +-
>  target/ppc/kvm.c                    | 2 +-
>  target/s390x/kvm/kvm.c              | 2 +-
>  MAINTAINERS                         | 2 +-
>  25 files changed, 27 insertions(+), 28 deletions(-)
>  rename include/{exec =3D> system}/ram_addr.h (99%)
>
> diff --git a/include/exec/ram_addr.h b/include/system/ram_addr.h
> similarity index 99%
> rename from include/exec/ram_addr.h
> rename to include/system/ram_addr.h
> index 3d8df4edf1..65f8f37b2a 100644

After rebase:

modified   hw/vfio/common.c
@@ -30,7 +30,6 @@
 #include "system/address-spaces.h"
 #include "system/memory.h"
 #include "system/ram_addr.h"
-#include "exec/ram_addr.h"
 #include "exec/target_page.h"
 #include "hw/hw.h"
 #include "qemu/error-report.h"
modified   hw/vfio/iommufd.c
@@ -25,7 +25,6 @@
 #include "qemu/cutils.h"
 #include "qemu/chardev_open.h"
 #include "pci.h"
-#include "system/ram_addr.h"
=20
 static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr io=
va,

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

