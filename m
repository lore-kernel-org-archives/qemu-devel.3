Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C08E8CD4F21
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 08:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wO9xH-00087B-Go; Sat, 16 May 2026 04:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wO9xF-0007uE-C0
 for qemu-devel@nongnu.org; Sat, 16 May 2026 04:01:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wO9xD-0007lY-OY
 for qemu-devel@nongnu.org; Sat, 16 May 2026 04:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778918459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u94aymaMQos4Ok1FqE43DnNiM5L1ZW3yqR+cto55E4c=;
 b=V8c7buO6Y6JElkRMf6fwSt6XuSXwO2Qg24F6evk2T8n1st+Aez3gHJvTPXQ7XbkYHMxLXt
 a79zCBH7r/nHz0vFro7NmbbNLkUxNSTges2vcPYg0xz12DVSbUCtINLQK0czm+xpnoLuQ5
 jnFouIPOFG34HoY48F0fUactXBWM5S8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-XvjIIlTVMA6nxBI9R1sBCw-1; Sat,
 16 May 2026 04:00:56 -0400
X-MC-Unique: XvjIIlTVMA6nxBI9R1sBCw-1
X-Mimecast-MFC-AGG-ID: XvjIIlTVMA6nxBI9R1sBCw_1778918456
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 032FE195606C
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 08:00:56 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CD54530001A2; Sat, 16 May 2026 08:00:54 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 16 May 2026 11:59:16 +0400
Subject: [PATCH v3 17/24] hw/i386/pc: free pcspk on finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260516-qom-tests-v3-17-3f20c3a029a7@redhat.com>
References: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
In-Reply-To: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1234;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=nx/Hm05PL6UbVe3ziRxkh2R3TZg6+6BhzI4zbHucfHg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqCCPPy8Px4iYVo3xLAAr6D3bC8A6YjjA1DEUfr
 YuaD1Y7GhGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaggjzwAKCRDa6OEJdZac
 5XUnD/wKHo3AlwLZxfxRM0cCAZB33bckddJtizWd3Ieo9vLZh9SsHE+xLxhI1XnPJDAuS4f4yIo
 iLEKq7sFeo3jk8aAQAF6JdGWkpBNLe/Wl4KygPQw86RYAyUpIqIwnfAycpEVpf7pjSBcvnVFMlC
 5jTdRP1j+DlC97opRglpIfwP3vvYUdi+Obm2SU74M605jG+J/pa8PNycCgPBeeCAKM/4nOS9XM9
 3HJor5p4KpXIQM/Se0C3Na3Dj1NemUX8OhF1Ydq4xHyQCMjQLzgdfhFVKpQGUU0DN5rX/AHb2MH
 lVu1HkTZFfAEK5k5E6vzg6k4+Us5+xAwW+waOkKyJbsOGLRCGL8W3Y9NVCZAN7OrhdBxgtRq7xr
 jGFVMQxcJNp68lXzW+y4oa2to9yecGoy7irfk2SNwrzM+rBzB0/OqSV84DaKBA/vUNgs+qdF9DF
 EQvG7Bq8EwfhpEx5PsERzxnBSlhbWDg7qIWFTsyW3WyWpFnqR3uzoUzllhkCNg+d3r5CLl7gGSj
 dndrAR42UeSWK4VPVTydS8SauE3dKl65lbIotsGIVRAQaRm0LQooWP83fOxRgcbch9jVNVIMmcL
 I1YrfKNrA9jQ1t9w76pvHMO5CkBPZTSofkfKZI52ueAFPLXXf7fRWWQZmt8O8xLM3k424zbSTET
 HLdN6cwd0bbYqMw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


