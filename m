Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A309FD88C6
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 22:33:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w05d4-0001Ji-92; Tue, 10 Mar 2026 18:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w05ct-0001FM-FA
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:32:31 -0400
Received: from v512.v5f06b487.use4.send.mailgun.net ([143.55.232.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w05cr-00073S-0D
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:32:31 -0400
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 57917ef65112c470180084f856c5f7712aac849ef81fb92c87640db6965eaa77 with SMTP id
 69b09bf53b0c4bd463bb5ccf; Tue, 10 Mar 2026 22:32:21 GMT
X-Mailgun-Sending-Ip: 143.55.232.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1773181940;
 bh=rXfpG4nL42XYnvWsqn0QK5bvRHgOmZdHIV+J4k3iOnE=;
 h=X-Mailgun-Dkim:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Developer-Signature:X-Developer-Key:From:Reply-to:Subject:Date:
 Message-id:To:Cc:Mime-version:Content-type:
 Content-transfer-encoding:In-reply-to:References;
 b=VyGgyZ57rkW3AYu9dqODR4zh+fijSXHVwXrREo0OM8X5dyVOcKcmR2HakzPNN6Fp9
 s8HZoG1mtimXM3EXowyIsiesG8d/d6VNDQUtZTYgKhKozza2f59Au5VRVRzwQnDeE6
 n3s4Uybbwt4MTqDGdiUGyHyMKfhz2atCll1GKbob5Y9c6aafjfR6PcU2ZK7dJvjWAH
 byt5GN3tsHhMxvx5MB5HOR62Jrat8OqN2h0iPar+Z/BlqzS4zUDtN1Ucu+k4hKf1By
 ZzSXhkH/+5swXiEmGexH8Z6UvQzalSyf1qv6eXgtd9EQLEIdMvouFuPlOD0lG2ZG3h
 1/8dfbDeye5Xg==
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
Date: Tue, 10 Mar 2026 17:31:46 -0500
Subject: [PATCH 06/15] hw/alpha/dp264: Add CPUs as children of the machine
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-MS-Reactions: disallow
Message-Id: <20260310-qomify-alpha-v1-6-4375b00a85ff@yodel.dev>
References: <20260310-qomify-alpha-v1-0-4375b00a85ff@yodel.dev>
In-Reply-To: <20260310-qomify-alpha-v1-0-4375b00a85ff@yodel.dev>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Yodel Eldar <yodel.eldar@yodel.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=968; i=yodel.eldar@yodel.dev; 
 h=from:subject:message-id;
 bh=dhBnD80mxjeUB0KSrkt/Yjdy/BPFojJeZrKWCGqe2Ho=; 
 b=owGbwMvMwCU29Z3/drNU3zWMp9WSGDI3zP64JiDXulfTwO6mn/LtitibPzJ339fcoHvdrPfo+
 xyDFfscO0pZGMS4GGTFFFkun5U465C7uytt5Y/7MHNYmUCGMHBxCsBE/FYx/M/O6jm66ar3zCdq
 f56+0K+QcLhmoLqhJ9dZY7bwwq7/OyQY/kf1JvRaPP/OmnFJ3fxhq97GR1xix8O29m0wtOmfunP
 xEl4A
X-Developer-Key: i=yodel.eldar@yodel.dev; a=openpgp;
 fpr=D3CD18CD406DBB8A66A9F8DF95EE4FB736654DAC
Received-SPF: pass client-ip=143.55.232.12;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=v512.v5f06b487.use4.send.mailgun.net
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HELO_STATIC_HOST=-0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Replace cpu_create() calls with object_new(). Then, add the
CPUs as children of the Clipper. Finally, realize and unref
them.

Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
---
 hw/alpha/dp264.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index f036d72268..b2ef423f93 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -67,7 +67,11 @@ static void clipper_init(MachineState *machine)
     /* Create up to 4 cpus.  */
     memset(cpus, 0, sizeof(cpus));
     for (i = 0; i < smp_cpus; ++i) {
-        cpus[i] = ALPHA_CPU(cpu_create(machine->cpu_type));
+        g_autofree char *name = g_strdup_printf("cpu[%ld]", i);
+        Object *cpu = object_new(machine->cpu_type);
+        object_property_add_child(OBJECT(machine), name, cpu);
+        qdev_realize_and_unref(DEVICE(cpu), NULL, &error_fatal);
+        cpus[i] = ALPHA_CPU(cpu);
     }
 
     /*

-- 
2.53.0


