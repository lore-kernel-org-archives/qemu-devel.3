Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F8FD10F9972
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:35:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYdR-0002z9-Ks; Wed, 08 Apr 2026 15:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gyorgy.tamasi@gmail.com>)
 id 1wAY7k-0007sf-Vz
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:59:37 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gyorgy.tamasi@gmail.com>)
 id 1wAXTf-0001Xt-Fd
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:18:13 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-59e4a04f059so31074e87.2
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 11:18:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775672287; cv=none;
 d=google.com; s=arc-20240605;
 b=TKLcFJDjOYgNilffejBvS3SfzU2vGyKD0Z2m40ZNjjT+Bm+VAgr6lSMnhonAub7XUM
 +u0ceM7GSiFLD3AXndu59fXbpmjtFt547FtnjO6V44eM0g0p5Oy1vNNu71CuFHxIthRP
 Yp1+XoqgafSkIDOrCC6dikJG5Otd80MkSrRloAAnr2P5+cImN8/7Eh+1qK29TvJngw8F
 qs+uX7FqpZGvqWdRTF88FgSLQwAg2zDWZFXBmpXI+Y5A80JKO8GaZuzeb6mOxhn0JdZ0
 MGbPvM5VigyY8eupeKegXjsB3EcG/zPC/wWKuIZFMIs+aeO7q7U5Ioc4TIZwzMFbQ/+O
 wsgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=DdY65THGCt+j324uTVY1lckFxe0r0DZNbYDq2J6s7b8=;
 fh=QX3eyJ+nqDBgQmzOU8uQalw74caV/wOxgOWcbkaaANo=;
 b=iR1LltfYEVLZsCZ4cEc6Ytfxq5JSWDC85NVH6BtQWDBQUsyQFjNqrn1gLcbiaiNL4l
 jgoTXpm67xfOGKeu9JVjLxnTUw4uN2hPzGYa4dh9gsyq1xjlygE2kjH/5E9kTfGCglms
 nIM4hcNX9TOvZm1TcucoxlHEfJ7r88afRNEvbqY1XO3s/0C0hfpyka5wMgFIbBRai1VC
 fdVbZXLTvIkm1t68o/HNxI1VRAkQMJpInnz+4gx1mFsSXzAK8Xvbg/ngV4YXEB/NhVsN
 QtIX/OJEitmk467BG2LlMq8EiNy/XjDwyXezOHI4NI2QePnmzNEWwI9nt74pYrxrK05a
 vdeg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775672287; x=1776277087; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=DdY65THGCt+j324uTVY1lckFxe0r0DZNbYDq2J6s7b8=;
 b=BjYMNvFVH0WDJtl64dFHrlQW/PuCBUNVPw5NsVbylYIh2nBNPDhehJ/JHWGXvf6LbI
 /9weKo/5ASJMZDNNlLp6RcrGENtBOUTi/RK0HzSR7kjeMTP80AwY1QMzMIDVhQs39WRq
 6JHdHCruzdoLXCC15sBoyHQ9Z7IIr9j3nPbzMcTodjLHBQu8729DvnQzIbGv/QZdYDyW
 yDGaPFcN6z4xdn5CWyk2Am9NB4XwaGvZLAsl0XFCI0ChamS0uIeX7AUZJSQLwgVBM1Vp
 U795/m4LdmbiPt6VyXNmwo2NXH1P9rI0RtsW1bnk0WfjmyxfjP4jX9X+CkNLC0iWha97
 MPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775672287; x=1776277087;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DdY65THGCt+j324uTVY1lckFxe0r0DZNbYDq2J6s7b8=;
 b=pSor/SdfGKqItO9VeHJ/vYQgt4WHZbmsvzC+5ENJessLPBx/QNAisQsJrEB+mOe9we
 tyVVp/VAhnM8RnRgdEjQhPrwN7xHtNXKKwceM/ocLKAnP+dA2V9PV7+5z5UN/wmfUdR0
 2MyKUqOWuDB9bn28Dv0lW4Sjj/xkJvKA0QVELN6iK6llhwhNznaHlGU5pbEPhxNHCpTi
 NCu2vtp1pS6rNFsJfBoQIj28AkJKAAJo2VeMxVdvPIHMbFVMSNQMaeYVh0REDKmX+GJV
 3+A9x8r03UaHliAUpxOrR0rs2BtM8jucohkQXhCdXtWsEdw7CXiyrCet6Rdzb8oL/Ln1
 HvJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtx5L5heQWB6rMzLArpHnkyuFjzGfYHv3dr4/VlrAPzS/0IBQMAnpwTFUq3Ekad5PH7Lzwumf+jZe/@nongnu.org
X-Gm-Message-State: AOJu0YwD8ijKCELriTlBij+gBoKkpiVZBbXsmjQxJimc+0fwvqG9esqx
 626NdaH6/EmGOgsJWJ7X3HW+TXlCFv7FKpnTnpXnnG758IJtcwnY1mmWD/79wzl+Tx1zx/e6eKe
 EcsXeK8BXpqqSJA6sBzm/AeVrIQBr7IU=
X-Gm-Gg: AeBDies0HssuQ1UbRXOy0n26i85VgBybzRrsLBMAOY6C6c8zu1Cm68VWxCR33H6AhGK
 ai5A4m6Bxs/ExaVUqdspgBGHH4NoXCjO3GhCJYfzDnemag6eSF62dXcWuVopr1UVQ+3X2bOkYp1
 yiGDkBnBi2G8kaejOlE0QYEoyxe5wXiUkwXX1V0bN9X7wJk97Dd0I0KBO1Kr6EFy2JQEq/by95s
 YuBbzWl/BzE3tIjyHEqmGLl8hQY8hdYDkqmjb7RGuk0xh/HRtPqsaOzy35ZeGPcGcFoPc8XIBHq
 8ZfDltkoE9XjgBsl6UXb+OURDNiMB+OpjxHs3AgF
X-Received: by 2002:a05:6512:b07:b0:5a2:c404:838a with SMTP id
 2adb3069b0e04-5a3e7c47ec8mr171815e87.36.1775672287095; Wed, 08 Apr 2026
 11:18:07 -0700 (PDT)
MIME-Version: 1.0
From: Gyorgy Tamasi <gyorgy.tamasi@gmail.com>
Date: Wed, 8 Apr 2026 20:17:54 +0200
X-Gm-Features: AQROBzBaxnNTPuS56QXuNhgxeMjx0PK7BB5AOy52cdRuPj639yQ5Gl65wWBMXsM
Message-ID: <CAFsMJvCLRw2Q=4muDNG1Ojj3oL+UgTrVzpYM6VULRvdFxgR=KA@mail.gmail.com>
Subject: [PATCH] linux-user: fix usage of struct target_stat64 for
 TARGET_LOONGARCH64 in syscall_defs.h
To: laurent@vivier.eu
Cc: pierrick.bouvier@linaro.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=gyorgy.tamasi@gmail.com; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 08 Apr 2026 15:32:16 -0400
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

In a 64bit LoongArch64 env (both TARGET_LOONGARCH and
TARGET_LOONGARCH64 are defined!) we can not use the struct
target_stat64 for data-transfer, since this struct target_stat64 is
defined for 32bit environments with its int-sized (4byte) st_*time
sec/nsec components.
The user side compiler headers of the LoongArch64 env uses long-sized
(8byte) st_*time sec/nsec components.

(This is similar to the case of 32bit vs. 64bit RISCV: the original
code does not use struct target_stat64 in 64bit RISCV env, when both
TARGET_RISCV and TARGET_RISCV64 are defined.)

This fix is important for LoongArch64 ABI1.0, where stat() is using an
fstatat syscall with this struct target_stat64, if its usage is
enabled.
(In case of LoongArch64 ABI2.0 stat() uses statx syscall, where this
problematic struct target_stat64 is not used, struct statx is correct
in the LoongArch64 env.)
See also: https://gitlab.com/qemu-project/qemu/-/work_items/3371

Signed-off-by: Gyorgy Tamasi <gyorgy.tamasi@gmail.com>
---
 linux-user/syscall_defs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 679af640c0..6967306be4 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2005,7 +2005,7 @@ struct target_stat {
     abi_uint __unused5;
 };

-#if !defined(TARGET_RISCV64)
+#if !defined(TARGET_RISCV64) && !defined(TARGET_LOONGARCH64)
 #define TARGET_HAS_STRUCT_STAT64
 struct target_stat64 {
     abi_ullong st_dev;
--
2.43.0

