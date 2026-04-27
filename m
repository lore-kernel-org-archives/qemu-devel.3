Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A52FAFF886D
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:45:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRse-00037h-Bg; Mon, 27 Apr 2026 15:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRsH-0001zZ-BY
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:44:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRsF-0007x7-Vi
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777319047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+CKxosstsBFm9NGxdMF/2Vjh6b8zrpeqrvImdWrXbxY=;
 b=gkg7q72uj4HImrTTosgTwGOIwrQm3lAErXEH51bVAIIFV0zFvQmTBoo4M7jqBckXU47a2S
 mXNZQmi7E6iI5s7UksXZEMW8OeyJstUgacc8WsrAkotSVtZ1F7nnyzfTo7JMe/v0O8yWFl
 mC5EZUnabopt96GAs39JsfhylvXVwDA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-ZIyzNzX8Mba14BW0169wTA-1; Mon,
 27 Apr 2026 15:44:03 -0400
X-MC-Unique: ZIyzNzX8Mba14BW0169wTA-1
X-Mimecast-MFC-AGG-ID: ZIyzNzX8Mba14BW0169wTA_1777319042
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A2AB819560B9; Mon, 27 Apr 2026 19:44:02 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4F4BA195608E; Mon, 27 Apr 2026 19:44:00 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Apr 2026 23:42:15 +0400
Subject: [PATCH 16/41] hw/core/machine: free shim_filename on finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-qom-tests-v1-16-c413f3605311@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=718;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=stDB52tVG7otdFKkTlHIFtUfl3V1tWQRHiMH9NIjmEQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp77wUAEBYx0UiBUk6IBWs+snbdteWNiVc6yRh4
 /sTIDiKSYiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCae+8FAAKCRDa6OEJdZac
 5fylEACp/1gNYLHgJXwWzxyPzCitUqJL842m6rlm69GC8jCRyvOmDAeG/QCrU3OD2100QPImeXN
 d17O5fKB+7eqrX2arfXeNOqxVEVB+kmdFXGsks2PIGhoL3UJIVDx2Pqq+oHn4qVzsHFC4eFkSGG
 XnZ87zJMqIH6KVTBh5ATRnKaKirxE3PrUx49fNsnb3mpK7t0fzW8rfYqOcrvEDm/x4kpUxt/JzP
 zjsEdWNdeffn5LVM1WxBO1JlAbpG8+PzqmhYjuwSuCxGLxNgzMckCp0dP2V560/x1XBtzYSAGoa
 igz05Tlv8qE9LRJKpgley0ODyyMdDg/Zu9vr+KPScVoH3H+CC+PVSFl8DB/gOdOGdip0SjU7Px4
 BZBW3Cp8TvoB/L3Yh2pC9kEk2BxiBzKKn8eM5660ZgDEVsZfEq4z8U/P7AIjmk6ouEKsk+zrFjE
 XPoklbi2n4vUCqqCmvZHOs4fQLI+hvKU1ovyED+1a6HOZKbIfOCxE3XnFRE8A0hZzohixRrG6tl
 PCHBsvxb9E4TQp0XykYT6+4/PRzDehWaehIrZyRmN65C/llRfFhZV3bteTzVOtcihhBLRXSGu0P
 IPWnEBU5DBRDVUmHNyuDvdo5sEbALHAOKvo1IoFH6ge5FwTuLPymJTZbSu8lQ09DyuQf4/0lJXz
 KEnQ7wdnOWlKx3A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

machine_set_shim allocates shim_filename via g_strdup, but
machine_finalize did not free it.

Fixes: a5bd044b1579 ("x86/loader: add -shim option")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/core/machine.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 1b661fd36ae..6a7fb312eb6 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1282,6 +1282,7 @@ static void machine_finalize(Object *obj)
     MachineState *ms = MACHINE(obj);
 
     machine_free_boot_config(ms);
+    g_free(ms->shim_filename);
     g_free(ms->kernel_filename);
     g_free(ms->initrd_filename);
     g_free(ms->kernel_cmdline);

-- 
2.53.0


