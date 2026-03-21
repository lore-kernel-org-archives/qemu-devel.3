Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF7E1099B59
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 00:50:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3kWZ-0005Q7-1Z; Fri, 20 Mar 2026 20:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1w3kWX-0005Pg-7P
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 20:49:05 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1w3kWV-000257-N5
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 20:49:04 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2ab39b111b9so5253775ad.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 17:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774054142; x=1774658942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j2p6psSGBay8A2Y7TVO3feWIFubdiokxQDyyjj14QeI=;
 b=EwA2zkQLcbnGLhtMRuJWNsC+rsmc3dHm/SjXwpew1mVdywl2AJaVUL8u+2oUs3hv8J
 uoM1Ekb402XjYrNkMy7fCrBp1fK2H+8qa3faAaOcpSJvdN/t/Peypk0kNzcfXpSg4o/L
 23wZTDgUx/SfPNMHdeIMUCDlX2ss3PUHbZGB0fAtX0KoEWZzFLMul+3lLNMp/GmzMOv2
 Vd3rGFDjwxzyps475o0aVd1C6DeqzTprI7TSOmjEJhWNC+TsdrVQecsFxHnbC2/Q74TA
 W7+7znr2kXzFlfJN+HR8zL/85KksXfRsYpWEc8qDX6CdoQLrk/KkXgDW/mcEvGaQtrVC
 IWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774054142; x=1774658942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j2p6psSGBay8A2Y7TVO3feWIFubdiokxQDyyjj14QeI=;
 b=jyrwJ12OMH1ADe88YCAAdXSlaHCMEezQtOd7Il0zciSuYr0IQqE7BxwUAgudOt3WM0
 3qhOwThaHkCuxScJfqCP/yczbWZnWemjW8qJZrK4voSZCcITb/2R66wKYnjMX4u8XeYy
 L4AqI+jU2WHb0vkzlOAFsTmowsGfc9c8KvD641LoeRbtRoc4L65sy8AUIHiC3/dMwOgv
 5Z+R4koX6ZdbVEGFhr4q0RVsEXwIE3ktiDuETl3fNm4lY43Ps1hlHlFX0lQT1m09Ze2Z
 AQARHmdxtbwrHiXNPYFP8nuTDka3i/vzSiFSRd89oSeM9W4ML1ji6yg7R7UfNS0R+R12
 owqQ==
X-Gm-Message-State: AOJu0Yw/td+YgucDeNRJHp66ZJExgcBcw4T7WXHhuIvl9SgZfcd27uXF
 hVfUQuvFlbjtyTPBSj4xlnqgdof7NpW0eYTBT3EKz7wAoG0CM4+bc7zL2Ngn9g==
X-Gm-Gg: ATEYQzzvqyNHE2auqitHZcN1Utq9iQ4kf6QKh0IIvrBmRx1jCMyAnPdgjERY4kVkh2j
 Ry12m/ottAQztzZ+tAw5qiSeYndNH2VOma812+3yZrj0MpilZD+mpHXlvOwdagyf33V6AEX/Oog
 4w/aUStJZvLFibCKr4UI3zZOmy6IIr4GQhKcXXKcV3rGmHLXanzK9UBYatTx3hOjzd8bE9GLZZl
 PtJ739Pwpv6PNXUmiY+NXd0a8oQp6mO4AJK4w7soDM2nhRJADg8jZUqUaL03GcMUnhRcjQR4DK+
 Wn4MF2P3CUiI5ZGOdOSJa57Lbqjp2orcXkQ/UI6uboLOHtl6i7gsvh7OUfpfjALl05ZfqUyb1fl
 IV1S+F3GZyWk0T/VM879pLTLZgoHiUKfkj3pbJyPQXkVKglOzRl5YdhxEEH7Y2AmyQa4rtxE3N+
 34cb03ym9v1MS5DYQGuWrIkRTdpzoH3XLQ+zQVp1dWMo6GM+Nluu05VFcj2c62WB3HtKWY
X-Received: by 2002:a17:902:dac9:b0:2b0:6f7e:6f3d with SMTP id
 d9443c01a7336-2b082826fa4mr45149225ad.53.1774054141807; 
 Fri, 20 Mar 2026 17:49:01 -0700 (PDT)
Received: from lima-default (103.95.112.190.qld.leaptel.network.
 [103.95.112.190]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b083527f84sm34637685ad.18.2026.03.20.17.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 17:49:01 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Subject: [PATCH 1/3] bsd-user: Fix unlock_user API usage
Date: Sat, 21 Mar 2026 10:48:34 +1000
Message-ID: <20260321004836.500390-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260321004836.500390-1-npiggin@gmail.com>
References: <20260321004836.500390-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Fix errors in unlock_user() calls:
- unlock_user() with len=1 instead of len=written
- unlock_user() with len=1 instead of len=0

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 bsd-user/bsd-misc.c | 2 +-
 bsd-user/bsd-misc.h | 2 +-
 bsd-user/bsdload.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
index 3e1968718f..eac3edb8ac 100644
--- a/bsd-user/bsd-misc.c
+++ b/bsd-user/bsd-misc.c
@@ -95,7 +95,7 @@ abi_long host_to_target_semarray(int semid, abi_ulong target_addr,
     for (i = 0; i < nsems; i++) {
         __put_user(array[i], host_array + i);
     }
-    unlock_user(array, target_addr, 1);
+    unlock_user(array, target_addr, nsems * sizeof(unsigned short));
     return 0;
 }
 
diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
index 13e40d9cde..13abc7e3b1 100644
--- a/bsd-user/bsd-misc.h
+++ b/bsd-user/bsd-misc.h
@@ -211,7 +211,7 @@ static inline abi_long do_bsd___semctl(int semid, int semnum, int target_cmd,
         break;
     }
 out:
-    unlock_user(target_un, un_ptr, 1);
+    unlock_user(target_un, un_ptr, 0);
     return ret;
 }
 
diff --git a/bsd-user/bsdload.c b/bsd-user/bsdload.c
index 5b3c061a45..9ea3b93825 100644
--- a/bsd-user/bsdload.c
+++ b/bsd-user/bsdload.c
@@ -30,7 +30,7 @@ abi_long memcpy_to_target(abi_ulong dest, const void *src,
         return -TARGET_EFAULT;
     }
     memcpy(host_ptr, src, len);
-    unlock_user(host_ptr, dest, 1);
+    unlock_user(host_ptr, dest, len);
     return 0;
 }
 
-- 
2.51.0


