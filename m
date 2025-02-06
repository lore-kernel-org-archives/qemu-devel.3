Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E617C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 09:59:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfyf8-0000HX-7n; Thu, 06 Feb 2025 04:59:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tfyf5-00008q-Vw
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 04:59:08 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tfyf2-0006JN-Er
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 04:59:07 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21f21cc7af5so9465625ad.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 01:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738835942; x=1739440742;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uCI4X5t3ctqe+eI91egl8+b7NybtBjs0uaXRxYcMVbo=;
 b=b8S/r/+MZugP/Dp+YtxI3MuLQufNvi1cMDt8SlnwFkRH9paYOaDmnod90iJKxMlIwF
 w8nGhgJWUnGzT0twkCb7lNX6Rlaa4eT4I4wj5lu3lvHlJzBYvpbSns7R8YHZ/hmCiogY
 z3w4CzioVfne/+8sONT5wv66+XGL5cha0KrEvWR9bsk9Y3OG282R3YLpyGk3QpD5Sh/s
 ADClBxJ7R1lIEz54iIdyBi+BH/MoylPAau/E0TEOPOCTBtvf3D5fjkFkT5A62WS6U7bu
 enj6GlvpFCXEOaHoWNJxX6v4nkFWniAMdtngalPcKjLc1iL3IrdrJPrJJB2eVzrS3Ygz
 Us4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738835942; x=1739440742;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uCI4X5t3ctqe+eI91egl8+b7NybtBjs0uaXRxYcMVbo=;
 b=ELmkZ6pXcs39Bb9GDzoizD1UF+u7yFA7Cpt2PFmfjGbqpbMmZiyiz7YhVyGhWWVaaU
 lECGfbP73iTAnrF4TMEsQg8Pc4tSz3ku0cscGW4kbxQ/oP9EYpwYCDVNYiY0jVSzy2dm
 wg5NZULk0M2vUoBCMyLKPoDjfARleOGeSbMULgZnLUW4qLuKyrbbxo02hf0tRfFUr1cU
 bPAEynPSAcZeGeRLQyTelHSlOnbn8u/Cgi0MyQTG1tiqX7N2Sq964FRnwxPQhVMzfljB
 Xdo82J4sTKtPmTYa7YIldyoFBdm56yZEYj1snX5v9luy2Z8NspjGz3APxGiiq0zPTGxl
 OAMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6Z+wN5MKtm/6ITxh15838i/8+q9aY+RKV8PdTdKOc1+KA5YvWq2M0e0GoiRR3G3J8JsZBKVdNOA0s@nongnu.org
X-Gm-Message-State: AOJu0YxmVPqffkleOlDJFnSGThxPqiKH8paSrtT8l2Pz+0Ik81l31igH
 qdKfpTug2eqA+QzesGfXMOXrB3i1qPd8CdATy9MROWleNJQvPOwSa+GN1sWo7CM=
X-Gm-Gg: ASbGncv4d96QJHQ6VDBGmJQPJMrqR+UUz27VTQtZXxtsMNKOqR1rrTAzO40xIV/SCH7
 OHjLDJpt5h6yVC2d6jgZoSV7oNrbbN70oR6R3l0cWnnURZEWjbsgw0GQMHA/cBG7Ziwv45F8OFg
 wF+gdp1YOi7C1tCjW46m6u/d8SPQrk7y8UN1X4ThNSHVPkvzZPnLzrNWOnQvo8HbTbP4MQvGc4O
 X+NnclCTYYaBWPUIMxymCuqlxRUxO6ZQ+baKD+6gZupEoaLtybjLPw4m/WCuN6h3PlEY5sxSXul
 Pl+VBt3aWMDHGWIcG1953ZlqWnJ9
X-Google-Smtp-Source: AGHT+IFo9FQRKiSEr84rYbIzNC1Qr3LX5OCVei9VUzM4nrwgcWGStPhACpZ34LvSjxomGkfXfP8Jqg==
X-Received: by 2002:a17:903:46d0:b0:21e:ffaf:8908 with SMTP id
 d9443c01a7336-21f17ecbd38mr110409025ad.34.1738835942149; 
 Thu, 06 Feb 2025 01:59:02 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f365616ecsm8768815ad.100.2025.02.06.01.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 01:59:01 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v2 0/2] Minor mhpmevent related fixes
Date: Thu, 06 Feb 2025 01:58:45 -0800
Message-Id: <20250206-pmu_minor_fixes-v2-0-1bb0f4aeb8b4@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANWHpGcC/3WNwQ7CIBBEf6XZsxhYRIkn/8M0TUu3dg+FBpRoG
 v5d7N3jm8mb2SBRZEpwbTaIlDlx8BXw0ICbe/8gwWNlQIlGKmXEury6hX2I3cRvSuLS42BJn42
 lE1RrjbQXVbq3lWdOzxA/+0FWv/T/VlZCCqdRWzvSNEi8Rc4hsXdHFxZoSylfy7JggbEAAAA=
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Atish Patra <atishp@rivosinc.com>, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=atishp@rivosinc.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Here are two small fixes around mhpmevent encoding and reset value.
The first patch is picked from the platform specific event encoding
series[1].

[1] https://lore.kernel.org/qemu-devel/20241009-pmu_event_machine-v1-0-dcbd7a60e3ba@rivosinc.com/

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
Changes in v2:
- Replace GENMASK_ULL with MAKE_64BIT_MASK
- Applied RB/AB tags.
- Link to v1: https://lore.kernel.org/r/20250115-pmu_minor_fixes-v1-0-c32388defb02@rivosinc.com

---
Atish Patra (2):
      target/riscv: Fix the hpmevent mask
      target/riscv: Mask out upper sscofpmf bits during validation

 target/riscv/cpu_bits.h | 5 ++---
 target/riscv/pmu.c      | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)
---
base-commit: 3f26a7a370c11c7dff68dabcccc19c4e0de901e4
change-id: 20250115-pmu_minor_fixes-7a2b8e3658e4
--
Regards,
Atish patra


