Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 820CBCD6E75
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2026 05:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVjPD-0003Ho-7k; Sat, 06 Jun 2026 01:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVjPB-00037D-9n
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 01:17:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVjP9-0008JU-QN
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 01:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780723027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vs+pOjW26KjxQCHZrQ+kCzdjFkWO5ZRcdNEGFNTZkO4=;
 b=KWdzU59N9J9kKal0CvV+PEKaXHo5xrn8QGggXNNbB3O131bHomRQwQ0ah8FHgABbut3xg9
 KlhUW+QykcT22glDpCEVheBwO2C60SdIyCCNl9kUK9Mjv04h6Un4RUzsmgsxLrs5xQfNuj
 fUu/ko3swqMuaBqMUASR/NidC61V4ws=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-i7eXIUnMMeSG2wCiIUi0ew-1; Sat,
 06 Jun 2026 01:17:05 -0400
X-MC-Unique: i7eXIUnMMeSG2wCiIUi0ew-1
X-Mimecast-MFC-AGG-ID: i7eXIUnMMeSG2wCiIUi0ew_1780723024
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A786195608F
 for <qemu-devel@nongnu.org>; Sat,  6 Jun 2026 05:17:04 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 56589180049F; Sat,  6 Jun 2026 05:17:02 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 06 Jun 2026 09:15:48 +0400
Subject: [GIT PULL v2 16/23] hw/i386/pc: free pcspk on finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260606-qom-tests-v2-16-55832d978a9f@redhat.com>
References: <20260606-qom-tests-v2-0-55832d978a9f@redhat.com>
In-Reply-To: <20260606-qom-tests-v2-0-55832d978a9f@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
X-Developer-Signature: v=1; a=openpgp-sha256; l=1290;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=GcZTfkVfLUK9g6SdJBjC2sL2vzj7syFt54aMh0Kvqn4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqI6z1p7dhUkeGL1FLyS8HaAzJpDmEn2SEhk/sS
 sI2UwAAgJCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiOs9QAKCRDa6OEJdZac
 5WfkEACy/JEeXX+4FrQl1jX8TiB1vsFpMvIfLCfq1kzVfgVw+Dt1rLB5uZgex+wIr1pL19InNTR
 di8VFsaGzk8IF2z7neTuQOf+Sf7+bt0uBohyenQJU6sGU6VzQKgghcTRwDQN1cwiv441Uk1YlTk
 UmXV/Qu66igPBPuMzne90IVklzCNqzZ6en9VFJwc7HIR6XyOLqHUm5mbqVrCH+BkuxuY0uoWnRr
 3BWpcbloBsFstVMZLplQ046EI9+erkqIcAbWn81CX1HKgElUN0cNBt2mDXrZ0meZjS1fL7OfQ5X
 KbooWvcXkL4klhBzgwo3YSR/dqF0gwG2UwoW9/a0DFvfGrpfHRC76al0ZcGIzeimGPCfFMgP8eo
 TkvlqgZUY1SvQSNrIbmY11qqEtw02d3LJEBzIolSH/HLCXLWoKdppAAvW6sIp9QkC5InxPNSpqE
 a3ZsEI5ehYuegR3z0LbIG6A428mqoBr9ieJTRpQ38MAIXedZJ+b5BLb6QBCCEDTiG55oYliez/2
 NrFrypj0E6MSYYDhd7qEqyptlYpXfPCsXw799LtJ3pe7ahmzBleKp0/onZzuYP1Lo402p/MoaTO
 EQFSbKPgl530SSYwZX+Ao9UcxV4LALEnvHoZD3YVDbgOmDQdYPr1k15HNZ5a6275CnYq0Edcutf
 MKt77HyBWB7R+DQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

Add pc_machine_finalize() to unref the pcspk device when it was never
realized. Once realized, the bus owns it and no action is needed.

Fixes: 6b8d1416482f ("audio: create pcspk device early")
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/i386/pc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2ecad3c503f..7b6ad97e5a9 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1610,6 +1610,15 @@ static void pc_machine_initfn(Object *obj)
     }
 }
 
+static void pc_machine_finalize(Object *obj)
+{
+    PCMachineState *pcms = PC_MACHINE(obj);
+
+    if (pcms->pcspk && !qdev_is_realized(DEVICE(pcms->pcspk))) {
+        object_unref(OBJECT(pcms->pcspk));
+    }
+}
+
 static void pc_machine_reset(MachineState *machine, ResetType type)
 {
     CPUState *cs;
@@ -1748,6 +1757,7 @@ static const TypeInfo pc_machine_info = {
     .abstract = true,
     .instance_size = sizeof(PCMachineState),
     .instance_init = pc_machine_initfn,
+    .instance_finalize = pc_machine_finalize,
     .class_size = sizeof(PCMachineClass),
     .class_init = pc_machine_class_init,
     .interfaces = (const InterfaceInfo[]) {

-- 
2.54.0


