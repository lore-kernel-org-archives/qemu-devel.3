Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F9CC531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 16:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnIVN-0001Et-TZ; Fri, 24 Jul 2026 12:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wnIVM-0001EV-Rz
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 12:12:08 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wnIVK-0000SG-Gc
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 12:12:08 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-69c20ba892eso2577732a12.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 09:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1784909524; x=1785514324; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EPPZCjJMQ21CQWHkaW7tkwX2xR7f0vAQARhPJw47Wn0=;
 b=ZG6IrreTCRsMPfhRUzmBo3v3l8yj5pGJeZK9bJ1Cxex95jRiqAvXaRGT9hlytY6H4V
 PGJcTgw227hVAa4JJwJ8gDlZx96gwJwtFZN/ncHD6bAhOdkHSxyoAhMgdYWhWkgl71Tg
 y++QzAMxraXRMGILG7mTETv9lbEOb2VLPGj7Zcg39+GeTD5D+TKroB6WLFjLjJYnJfmf
 OznXERwIvwE/WE09ZypLHmHiaS0CvH2efGDTEdvRkE8wXN7hUkdKoNTwhRhPfodSO34u
 346qffokFa/wVH25GVuAs8yWl3x43yGRBxwSG5/IyF4wszl732WeVFfERks/RXDtH1lr
 WTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784909524; x=1785514324;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EPPZCjJMQ21CQWHkaW7tkwX2xR7f0vAQARhPJw47Wn0=;
 b=DniJHyOenBPZv4u8JtHYko6bLsT4nyXscb6jxp1zUaZmgiKWhnTu3d8BCOfazTjuOu
 IXjbedpuaAqmPV2f2B4e/sryfwud2qktNvSDzXJZEm0peW63rWqh+wXY8rGsNghNkztr
 ace7cZsFj1uxBvpB8vm7w6rFxQThVi064+xeXLY2cOP3hg/XzjAcSZ6IDu/3Bz/1kH99
 YXP6/JN8sZHw9V8cTaRC+O9sl5yqxAJQHWWMMghVx2/w4FS+tjwMuuN+5nF28pOZYunA
 zB4Rhq3IZDkK4ApOkopz0+1zFFz5JwXp+yyOrcqaaxg7pkQIHR9RD5I0iIuGZ1dwkiRy
 j7CA==
X-Forwarded-Encrypted: i=1;
 AHgh+RomIGFg5l1c15PAcRrxlhKCvfxZft6cG0EVPN/v3JAe0eHDCFdTFmgZrgKS5NwMA2lYB1fV9zfFVbef@nongnu.org
X-Gm-Message-State: AOJu0YyGi9gWiMeMJjrLTyQoTP40ovjQTxyG6FCbQFkMlxK39ZL0M9QN
 DRJo5KvwHVRNZrDJ4iOMby3GZJKFkkEJ563HLEgadEyZkwYpVy06LBxsm0fV2lhxccUBv2t2M/o
 7YtLz
X-Gm-Gg: AR+sD12ODR2E+VLlmCuZs+x6/0+rKaJXDw/8iJmDJIyEkSw6Z276d1/KtUc5XV8lmbG
 kyR0FqivD+zBc7m6qREIRjHIxTRKw87WnFAO7GOJBPtHv6MizbnkIgwdb9xaU6qNmCLaUvH6zgX
 bCyYhQZc3wfLPD+xuoZIw/dKblyV51UDReBw1f7m+b3jOQMf+grVwtk3ZztfLegEHSharZTmwJi
 wgMoR8AGRNnZdR6I4aRuugft9V+aftRVAqGb78rAQxwNyAru+KM4306DPUwOAgQN+Epi7lHfUXK
 p1yKI27Vsig99/s271W7Y3UO6Mbp5k1j2Xa5iO1dQ9BHEHidQE7jDJk/Nb1ycFKcDiqSGXHF5kS
 ZbxCYsFoOH+MOKNioZ+YXfB/UlVj8/SbVT1+LitEXbR7NiW+FcVyKYfHZU1kkd1n6bOE=
X-Received: by 2002:a17:907:84d:b0:c1c:4b2f:797c with SMTP id
 a640c23a62f3a-c1f134c2882mr71386966b.14.1784909522761; 
 Fri, 24 Jul 2026 09:12:02 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:4f7d:7b60:9d07:3a1b])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69fb50bd30fsm215764a12.5.2026.07.24.09.12.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 09:12:01 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Eric Blake <eblake@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 1/1] block-common: fix BDRV_WANT_PRECISE duplicating
 BDRV_WANT_OFFSET_VALID
Date: Fri, 24 Jul 2026 18:11:58 +0200
Message-ID: <20260724161158.445561-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=den@openvz.org; helo=mail-ed1-x532.google.com
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

Should OR in BDRV_WANT_ALLOCATED instead.

Actually there is not problem within the code right now as the value is
used as enum rather than flags but that is for now. Let us stay on the
safe side.

Fixes: c33159dec790 ("block: Expand block status mode from bool to flags")
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Eric Blake <eblake@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
---
NOTE: technically we can just remove extra BDRV_WANT_OFFSET_VALID but for me
      proposed change seems more logically correct.

 include/block/block-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/block/block-common.h b/include/block/block-common.h
index 895ea17541..3932ff8615 100644
--- a/include/block/block-common.h
+++ b/include/block/block-common.h
@@ -351,7 +351,7 @@ typedef enum {
 #define BDRV_WANT_OFFSET_VALID  BDRV_BLOCK_OFFSET_VALID
 #define BDRV_WANT_ALLOCATED     BDRV_BLOCK_ALLOCATED
 #define BDRV_WANT_PRECISE       (BDRV_WANT_ZERO | BDRV_WANT_OFFSET_VALID | \
-                                 BDRV_WANT_OFFSET_VALID)
+                                 BDRV_WANT_ALLOCATED)
 
 typedef QTAILQ_HEAD(BlockReopenQueue, BlockReopenQueueEntry) BlockReopenQueue;
 
-- 
2.53.0


