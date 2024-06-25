Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE82C3064D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 17:37:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM9ys-00022O-U4; Tue, 25 Jun 2024 13:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbouman03@gmail.com>)
 id 1sM7Yx-0003iz-Hz
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 10:54:27 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbouman03@gmail.com>)
 id 1sM7Yv-0003Ih-QA
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 10:54:27 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-57d20d89748so5472806a12.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 07:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719327264; x=1719932064; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FTEABTvUlmGhewuD80/IM0/j/3yvJVyKCKjnPPFuNU0=;
 b=k8HYSXgd51oJj2eU40HRf/HIBE+3Du/YmvD+/xaCUftsZsmKY4W52lbpHunHHd2G2b
 WYEjX9X+geTYDM4W/Kf5IVt1Q+5sqSYw6UcNoLd/Gyo/Wg/3TPiBFc2l1QPgNXdjtzLN
 yCO6ynYV8PXX60f8ZrVqlDngKdpxKUjFkV2fPyHTpu0jai0H0YN1i5xQgoTJ/m4PGT+E
 c6rH1SJkkMd0R6dnCYTLA9UeOX0XesBR0svcDG7m21lyZqAwtk7qeUvZkfrwyN40xjI0
 wT6Kz2mVB+mTH5qkG9AMTK4keLaua5bgSVCfbuH6e0O+bheDBLte0qxLxMk/0wVO1KpB
 w2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719327264; x=1719932064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FTEABTvUlmGhewuD80/IM0/j/3yvJVyKCKjnPPFuNU0=;
 b=tsEr1NAqyOhdOecHBkxXHhA7HTmYCSW1g6TOVzUSAKCtpwkn+pnAH2rTUNXA7W/2fi
 sVU+QcUffss9nWgXmTWQlTBh0XaNkt5SrOHzhUUHJIfppEoQ1lJ/ws+INT88gQQmUhK5
 KxMDzffMitIZFbcO0t6cDMQ2r2y4b9dfDfniTStozY5XYczoAckp049xhzzTfKueEpKq
 HTXj8rpX8vukqtzq+mxjOxqu0WwW5Ac4DZPSfUfF/Yu9m0PfQzuP5Oms5hqyH2bgt2yg
 NB96VkZAbXGNjluCvlsnXVDO6YODsGqut1C7OkYFgZ4I+MSLx0VP3hEkKfYatAA3Gp4/
 fSTg==
X-Gm-Message-State: AOJu0YzG4BgFuz2eC/KmckTMZ/07IezynkMWUThUuO+7F+jHxBjvzX/W
 E8dbgf4yI+IwQUyKOEILw7sss4VyjhiaRR90KX3aCMQvFkmFFZQfl7zexA==
X-Google-Smtp-Source: AGHT+IHX12OXseF02pCwYdu3uF8zcxfHzMRAHLlJqHuLhiPN/zKgFHLh+cXRKPot5fkv3+UKKUv1uQ==
X-Received: by 2002:a50:8ad7:0:b0:57d:692:33ee with SMTP id
 4fb4d7f45d1cf-57d4a03eba4mr5905730a12.36.1719327264064; 
 Tue, 25 Jun 2024 07:54:24 -0700 (PDT)
Received: from 41414141.home (84-82-177-210.fixed.kpn.net. [84.82.177.210])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57d3042d421sm6092740a12.42.2024.06.25.07.54.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 07:54:23 -0700 (PDT)
From: David Bouman <dbouman03@gmail.com>
To: qemu-devel@nongnu.org
Cc: David Bouman <dbouman03@gmail.com>
Subject: [PATCH 4/4] hw/usb/u2f-passthru: Implement FIDO U2FHID keep-alive
Date: Tue, 25 Jun 2024 16:53:50 +0200
Message-Id: <20240625145350.65978-5-dbouman03@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625145350.65978-1-dbouman03@gmail.com>
References: <20240625145350.65978-1-dbouman03@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=dbouman03@gmail.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 25 Jun 2024 13:25:51 -0400
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

FIDO U2FHID features a keep-alive response command (code 0xbb). A
keep-alive response signifies that the request is being processed
and the transaction should not be closed yet.

u2f-passthru does not recognize this command, and hence closes the
transaction prematurely upon receiving it. This prevents some U2F
security keys from being passed through correctly (Yubikey 4/5).

Fix this by recognizing the keep-alive response and, if received,
by keeping the transaction alive regardless of the resp_bcnt limit.

Signed-off-by: David Bouman <dbouman03@gmail.com>
Fixes: 299976b050bf (hw/usb: Add U2F key passthru mode)
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2293
---
 hw/usb/u2f-passthru.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/usb/u2f-passthru.c b/hw/usb/u2f-passthru.c
index d0fb7b377c..c1e4db3467 100644
--- a/hw/usb/u2f-passthru.c
+++ b/hw/usb/u2f-passthru.c
@@ -296,10 +296,14 @@ static void u2f_passthru_recv_from_host(U2FPassthruState *key,
         return;
     }
 
+    bool keepalive = false;
     if (packet_is_init(packet)) {
         transaction->resp_bcnt = packet_init_get_bcnt(packet);
         transaction->resp_size = PACKET_INIT_DATA_SIZE;
 
+        if (packet->init.cmd == U2FHID_CMD_KEEPALIVE)
+            keepalive = true;
+
         if (packet->cid == BROADCAST_CID) {
             /* Nonce checking for legitimate response */
             if (memcmp(transaction->nonce, packet->init.data, NONCE_SIZE)
@@ -312,7 +316,7 @@ static void u2f_passthru_recv_from_host(U2FPassthruState *key,
     }
 
     /* Transaction end check */
-    if (transaction->resp_size >= transaction->resp_bcnt) {
+    if (!keepalive && transaction->resp_size >= transaction->resp_bcnt) {
         u2f_transaction_close(key, cid);
     }
     u2f_send_to_guest(&key->base, raw_packet);
-- 
2.34.1


