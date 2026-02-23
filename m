Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D38FEA4FBE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 13:38:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuW8J-0003VL-UO; Mon, 23 Feb 2026 08:37:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cuiweixie@gmail.com>)
 id 1vuSeP-000774-4g
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:54:49 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cuiweixie@gmail.com>)
 id 1vuSeN-0007dy-LP
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:54:48 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2ad617d5b80so24606865ad.1
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 01:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771840485; x=1772445285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nYXJBIBhE1cZ0PkHfYiNTM7fV8EBmuDPKFj9SMEW57M=;
 b=So+4rVJI7IR1Yz6j8tLcLNaBJLUsgzVtIhVZ4EJVT+tkLMtxDFFQftAlwMGud4J2LS
 hvfCfMDpMXLes7vc0R/PG2FQ0RVxT6mqYglBS3QLzQvNRy93++4x2evfDmBxQPLbeQoZ
 9P1TBVZf/oTQwevOekE6dIBwcm2gi89p1XuQa2ZyatHq647iLqm/Hl0nnwruWR9zMNFy
 0d3juePVE0Liu4aXm5T3ZtHKJkK3pieSzYB1AJwcnXSJDd7vFTgDCZ+1YDnjZYXfhPms
 DsvMOsEMKQjnYaryYF6MohAAkDAG3xPimDwP2ur001YHooPzdl2jJWS9aZoQY0wl8+tt
 E1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771840485; x=1772445285;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nYXJBIBhE1cZ0PkHfYiNTM7fV8EBmuDPKFj9SMEW57M=;
 b=HwdNDZtTIFM0PKYlAJZ69B9mbzyZGMs2sk8fITctkcUbj1RKtoNIDblkiyUmV/z+WF
 bUk8V5UNPPIoTp56rE3dLmeNLjrDx1hzpQ7zF0NDlt2GnssXVVko8frRlcg5C1S5bj6O
 ybNooaB4kwGSOQZ5t1vX7WOFaj/pQjgQ4wxOxG7qKoyCaYwj36JiKIoU2IlN4Kz/EVCG
 f/VT51PmxJ+D58tlzLWN70BeCOqX7NUonAaG+FqZuCrsFHQuwmhwaxOjD+CT870v/EC3
 lJbHViCem25VNZ0b4jnJWf6IqezlMrgi4J9z8c1cQ1PHSSzngyTb55F/96u+uXtUbgXS
 3fhQ==
X-Gm-Message-State: AOJu0YxcPbA4bnZ0Vy92DeH5nJG9px2GXAc36TyjOeWGohmpUpTqwcqM
 bLzJG1jDY+aEiFaC7syYdKS5YeC+x5d+yfE0q5JWuezaLMHLPuOi1s+AaTJ4Xg==
X-Gm-Gg: ATEYQzxGSrOVNyrnxuonIMQ3JK17cP7VvAXLdBRoyzqNWitIuKvfxcIfKy10m2GZ2EX
 lV1rtdL55xF6bt4DzAmJb9OmZuqJPco74PUNAOLEpZB609a/oLjk6aFLRNlBbuMtP5pjiHIgK0I
 29Z4Wcj5bqseDBMJUuJJHxS2NLQspgVSxurEDH3WvEbN+3WKnVe3QCG83fodkqXo9NLLzE3LJF5
 zYKHkU436giSSkDVzRMEUeFI5GKXlHZdyGM90kvI4i0D7q++hcp++5eagpbvoiauTPZoKXDApoZ
 166RcOX7p2knndJKO7ZcQlU8bPq6ruHB3sj7mtpAkVd7g+yLhRqArRoFKER8/4+KnAfrYPrgawF
 SXvLAkYbBga6B6jBpUtPj4ZIW0BoMGwYrkWtbi/kSuuKzHHq5pRSJ5XObu0SCpYLwdkyfLrEL1X
 GSJeXgAifbIQM82DBZhGbuqxHLQJWATEHVHuA0
X-Received: by 2002:a17:902:f706:b0:2ab:344e:13fd with SMTP id
 d9443c01a7336-2ad7456c8acmr63163845ad.54.1771840484997; 
 Mon, 23 Feb 2026 01:54:44 -0800 (PST)
Received: from 192.168.2.102 ([120.235.196.245])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad74f619f8sm69158395ad.36.2026.02.23.01.54.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Feb 2026 01:54:44 -0800 (PST)
From: Weixie Cui <cuiweixie@gmail.com>
To: qemu-devel@nongnu.org
Cc: Weixie Cui <cuiweixie@gmail.com>
Subject: [PATCH] fix: copy paste bug
Date: Mon, 23 Feb 2026 17:54:36 +0800
Message-Id: <20260223095436.61247-1-cuiweixie@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=cuiweixie@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 23 Feb 2026 08:37:47 -0500
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

---
 hw/ssi/xilinx_spips.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index a4718fb72d..f6e717bc01 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -369,7 +369,7 @@ static void xilinx_spips_reset(DeviceState *d)
     memset(s->regs, 0, sizeof(s->regs));
 
     fifo8_reset(&s->rx_fifo);
-    fifo8_reset(&s->rx_fifo);
+    fifo8_reset(&s->tx_fifo);
     /* non zero resets */
     s->regs[R_CONFIG] |= MODEFAIL_GEN_EN;
     s->regs[R_SLAVE_IDLE_COUNT] = 0xFF;
@@ -397,7 +397,7 @@ static void xlnx_zynqmp_qspips_reset(DeviceState *d)
     memset(s->regs, 0, sizeof(s->regs));
 
     fifo8_reset(&s->rx_fifo_g);
-    fifo8_reset(&s->rx_fifo_g);
+    fifo8_reset(&s->tx_fifo_g);
     fifo32_reset(&s->fifo_g);
     s->regs[R_INTR_STATUS] = R_INTR_STATUS_RESET;
     s->regs[R_GPIO] = 1;
-- 
2.39.5 (Apple Git-154)


