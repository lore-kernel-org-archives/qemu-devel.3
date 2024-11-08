Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D969ED5C0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 12:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9OQY-000346-BK; Fri, 08 Nov 2024 07:49:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1t9OQU-00033f-8z
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 07:49:22 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1t9OQI-0005iz-BT
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 07:49:12 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a99eb8b607aso288050166b.2
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 04:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731070148; x=1731674948; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8PGC57rPE2ZorSk7APAKrg/IMxYZqZFCaWHvpIqOIms=;
 b=dg+bgJ+qtZ9yIcAMobM0SwiLqnlFvhC4sOAuBy/I7NJ9lqxOhnZvN87vo3JZkQd+ks
 WXiBJNqNixxstReyNRUl4GA31JwR6Jc5yl7bietjBRsutgtkzQ/9M5qAiopH+a8El+lE
 L6dw91tXr07nkqAMEJK7qYEBxSgho782qhHxqSMmNRfBn7qe59ZexZJ4RdVcmoiX3EPK
 582Qol9ipoVgb7PQEh13gjA9yiNPjqKa8s8naKbCEUs88hYcP8fEsvXnHu9hKXK1lWOh
 oIahqaBbWGRc4JDqFGb6T6na+CSvOvrMKB0qtd8PubVFt+1e2eOiDiynueEdk5knGk0G
 Y//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731070148; x=1731674948;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8PGC57rPE2ZorSk7APAKrg/IMxYZqZFCaWHvpIqOIms=;
 b=c/nef53UI48dj42AJtbzM6sVIVmxU8FOMFSCXGiU0axrq2KmzVjf1VGNT+7TRs3DNH
 iHmIpwrJCUrPqgmOmDmtwFkd3aktzhdgTZwE/7oSrMb1OK6Z4lqtw3zdWAdoNCPGXkHI
 IJT1C1oqeuL+gX2kJ9v6y6BUaI2Y896aOvN7KukvTAL9g+HxPONFTrDISKF5C8zCQoVp
 Aor/wKGq0Kr70g+2hvgS01Ax9lnY+2t5qkGGOQFj14pj2n0gVuq0dQeNznCbC+G0Y2IR
 WmsCB68jBDOGixwpQQfNyU1nYZCBJ37feChAPFTUP6vRjK4EbzkBSYhVffs6wgK+eB+c
 emjw==
X-Gm-Message-State: AOJu0YxAInDh5WdWoDceeWa0ru2MB+CDgXzSrpJtH88X4T3fqFKIrLsU
 wQeDDw70LsqfsAcu8qLAkAzhDqkiT9MERRifKhR0l+o8ComtWi6+RNsccA==
X-Google-Smtp-Source: AGHT+IHVkFimwALOchQj7VND8K34cJ05xDKD3nQgORoRX5GlnnqiHOB0BK+Uxl97CHjLzb3uro9WOg==
X-Received: by 2002:a17:906:ee8b:b0:a9a:1585:dd3b with SMTP id
 a640c23a62f3a-a9eeff0e35emr234137866b.21.1731070148080; 
 Fri, 08 Nov 2024 04:49:08 -0800 (PST)
Received: from corvink-nb.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0a4c3f5sm230072966b.76.2024.11.08.04.49.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 04:49:07 -0800 (PST)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH] hw/igd: fix calculation of graphics stolen memory
Date: Fri,  8 Nov 2024 13:49:04 +0100
Message-ID: <20241108124904.93201-1-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Corvin Köhne <c.koehne@beckhoff.com>

When copying the calculation of the stolen memory size for Intels integrated
graphics device of gen 9 and later from the Linux kernel [1], we missed
subtracting 0xf0 from the graphics mode select value for values above 0xf0.
This leads to QEMU reporting a very large size of the graphics stolen memory
area. That's just a waste of memory. Additionally the guest firmware might be
unable to allocate such a large buffer.

[1] https://github.com/torvalds/linux/blob/7c626ce4bae1ac14f60076d00eafe71af30450ba/arch/x86/kernel/early-quirks.c#L455-L460

Fixes: 8719224166832ff8230d7dd8599f42bd60e2eb96
Signed-off-by: Corvin Köhne <c.koehne@beckhoff.com>
---
 hw/vfio/igd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index a95d441f68..732f9c37a6 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -498,7 +498,7 @@ static int igd_get_stolen_mb(int gen, uint32_t gmch)
         if (gms < 0xf0)
             return gms * 32;
         else
-            return gms * 4 + 4;
+            return (gms - 0xf0) * 4 + 4;
     }
 }
 
-- 
2.47.0


