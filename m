Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE8BCF65CB
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 09:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkJ9E-0001kG-KY; Mon, 26 Jan 2026 04:44:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vkJ9D-0001iH-6W
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 04:44:39 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vkJ9A-00014W-Sy
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 04:44:38 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-29f2676bb21so44110565ad.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 01:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769420675; x=1770025475; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=h3TrHTeaWpaoUakjRDj68rNy/00gB9mvgtDT0XiwlKc=;
 b=ZQ1/xSXXinr879kr12e9LSFxDVn6TsKoJnQPOLH8Je2MBGjxfC3kPOgJiR4naps8e4
 jCoIIPKtqc6dmY6+kOZ2WOv8X6NGVXzMGls1jwqqGIADheFimibnLdaUoNK6XG56EkeW
 XS/yAZZX6YWrx8eQpHMoMjui/GBhqdka1HfoGj+gjupl2ms3bqKBP+jnhYN6v2Nm8eRC
 E9jsJgt/JHYq76P+dbPC48brjywPU418FNQAJpQlD3Wyi4hJvpoHLHa4w/o5p6/fA/e9
 w8w9vzZS1R8UEkjEHZdPaP72Ov2yOhf7/Ct9BoCnEKpZh36doppUgIcWkRd88nulLCBB
 zvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769420675; x=1770025475;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h3TrHTeaWpaoUakjRDj68rNy/00gB9mvgtDT0XiwlKc=;
 b=HZhFbmWIKK2sf5YDE/85SKn2un2FlJvjfAvzgmPOy8ahAf3q05aWYUFxUTQtUiVOz1
 z3sgv5oree6CPEQsbgMBItGEQrghNVJsiM+ckmCrkG7vdkxWAPS15Cs4HKDNhj8uScj4
 0E6ELPiSy2zu7ZV16f259Pbv/Y9VQL5bcVdJhBDMlDvwSSo/p5z5t+HdTDs7E3TmGaxJ
 68d1dMzA9V80aBwpRz8WmYP0LI0MyfvWVuP0ybHZeRQ17J470kOR6V6Njj/0y4BBrmWb
 YoXrwWd8fGBzsYjmLxxx/vyzbfNAVZAFBvx43mhgajEKyX9IGKfDpTuRRIlRpuq24rwm
 9g/A==
X-Gm-Message-State: AOJu0YyoLGR1Oou0PDQVPsi7hLehchZ4M6/BARdJlYBgAH4kI4mVaShI
 Iz4rqaREYp0luu21odCBGL2p+dZ/fatxNuyBxim2CNTp3xOXoOJFJbPFFz95IIqf
X-Gm-Gg: AZuq6aKdX0IfuCe4ElMG/0meehTUe4PFHUQ7IbVIHeAmXr+/bs3bHC2U+9rFryNp+O+
 qQxwhvZwGOWoV+3rcjPGRDhr4s/VswxQlMSb2ROIof8X1xo0MfYVdCeUXWQ9xqG7nIY3dymZ6CX
 KffqB14vwN9VBdCYmiL4aw+xWH/SCX1oAETLbtYjiHsLDmeVis5aKQ87UzgEo9FuA2rHhtiy2d9
 uYK2nCaKtf5fluyr231cX7GKuKG0DQFPXwGlEDmaEqKR3VWsp9GHzKtC9jgorJRRpNqeCCT5qNF
 YbVtAppT73fnKCh2IIejtcvkRWrBZYcHyFYB+R86p2RrC68pZuRIQOd8B/2DfBEE86n0/nWoV7K
 93gSX4JqDaMISLFRmwgOm0J7X/fiY35BJqVGZ/A7bpnG6Mxyk/sQF3jnsU8PtJBx9APEzT3wuCx
 eVvqiIv+1Nin1W4Sc=
X-Received: by 2002:a17:902:e5d0:b0:295:425a:350e with SMTP id
 d9443c01a7336-2a845240123mr33974585ad.8.1769420675124; 
 Mon, 26 Jan 2026 01:44:35 -0800 (PST)
Received: from localhost.localdomain ([180.87.170.15])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a802f978d2sm85605585ad.52.2026.01.26.01.44.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Jan 2026 01:44:34 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>,
	qemu-stable@nongnu.org
Subject: [RESEND PATCH V3 1/3] qapi/misc: Fix missed query-iothreads items
Date: Mon, 26 Jan 2026 17:44:20 +0800
Message-ID: <20260126094422.23116-1-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x62b.google.com
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

The example is incomplete: it misses members @poll-max-ns, @poll-grow,
@poll-shrink, @aio-max-batch.  Messed up in commit 5fc00480ab1
(monitor: add poll-* properties into query-iothreads result) and
commit 1793ad0247c (iothread: add aio-max-batch parameter).

cc: qemu-stable@nongnu.org

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 qapi/misc.json | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index 28c641fe2f..1f5062df2a 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -117,11 +117,19 @@
 #     <- { "return": [
 #              {
 #                 "id":"iothread0",
-#                 "thread-id":3134
+#                 "thread-id":3134,
+#                 "poll-max-ns":32768,
+#                 "poll-grow":0,
+#                 "poll-shrink":0,
+#                 "aio-max-batch":0
 #              },
 #              {
 #                 "id":"iothread1",
-#                 "thread-id":3135
+#                 "thread-id":3135,
+#                 "poll-max-ns":32768,
+#                 "poll-grow":0,
+#                 "poll-shrink":0,
+#                 "aio-max-batch":0
 #              }
 #           ]
 #        }
-- 
2.49.0


