Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A19FAFF886D
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:45:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRsZ-0002R6-OP; Mon, 27 Apr 2026 15:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRs9-0001nk-4V
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:44:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRs7-0007vq-7l
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:44:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777319038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FjtgSdF/RmKZsYPVx79tmSgU9IPq9ejhGQ1cMOPcuRs=;
 b=Ybz9liMvSiAQNcxUhu9XsFJ/l9eOZMDgxDqSVvQnqbmz5oVIkiuSX44Citx4/DQ/kuhJVx
 UJNwVuzFkYrwZzUbedHOCJpC6eHSuK0hMv8H3ZhduQGMlmy+0675qzz0uwyWVN8hWXOwwl
 B906fVBEY4WHZuPEgdeVWzZn6L70RwU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-NHRMhUqBMceaEsuhhYz0cw-1; Mon,
 27 Apr 2026 15:43:57 -0400
X-MC-Unique: NHRMhUqBMceaEsuhhYz0cw-1
X-Mimecast-MFC-AGG-ID: NHRMhUqBMceaEsuhhYz0cw_1777319036
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 36C56195609D; Mon, 27 Apr 2026 19:43:56 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D61581800352; Mon, 27 Apr 2026 19:43:54 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Apr 2026 23:42:14 +0400
Subject: [PATCH 15/41] hw/i386/x86: free oem_id and oem_table_id on
 finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-qom-tests-v1-15-c413f3605311@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1380;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=xERWYRvCuiLTWF3DPmtzusKt3TfQ56Tk1JuAhFbMaJw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp77wUdq/Ah6awE67u+JM6xKjDPtqDWwrspPswn
 bwx9l2qBDmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCae+8FAAKCRDa6OEJdZac
 5bt4D/9TLOyiF/NMkcEgHcxikbz8iBM/t4O0SpFAHIjWf/NZrlNSJaEycYalGNUoD8W7qbbn3Ww
 ZJd4mrRuytXzTQTkS3oqNZLW0ADhV3r4vu2ZOCzDudfpiRQdPRFoP4DWo2PXo/DAzbtNH1KZOSG
 A3gEdFXQjEzRcY4VyCscVSCs57tWZXe1FdTCJNKiXZnI2zDp4QIZPYlm1OqttLdYzYyKZoIem13
 Nh3XwRMKQOfT1xLoeqCNy6mA4jLxZyAKUwRUuITk2bWHFsDQblt95Rmulvz52Tan5pdiAZw0bLz
 HP7iZRUjTt0GGz+VOpP1iF/3/S9v6ca6iRGmq2UvPJmI+24MgSaZ+0FUH32Gknn87pUPyal9Ugj
 krqdRsz0S+3I08+z7jjZ3KNE21fWCmRmdAnwFyoDdAHuM0e9t49Qjwmr68RijbXi2PUDzXVK6x7
 ZvBSWTD071aRR+Swrs0BkObJc6IVdmr2oK68lJouLJZWMsEHk4ZQzi6UuCISnTzRMdoZ0n4joTX
 f7iA4HNEjUp1h2TO/gfngtvMC6JUMq2kH09cy8KSGfiRLzFSrO/ioZAg+X00RvwwevBHG9E6oFl
 rugkX+g58JNpBiJ2NF5TVvCElWw//JFA4eAe5+fbIOqvhgM6/PH/bI761+qRfr7855ecZviUS7s
 3yEzpZkKgDhGvcA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

x86_machine_initfn allocates oem_id and oem_table_id via g_strndup,
but no instance_finalize existed for x86_machine_info, so these
strings were never freed when the object was destroyed.

Add x86_machine_finalize to release both fields.

Fixes: d07b22863b8e ("acpi: Move setters/getters of oem fields to X86MachineState")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/i386/x86.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 01872cba073..dc7f0d56b01 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -372,6 +372,14 @@ static void x86_machine_initfn(Object *obj)
     x86ms->above_4g_mem_start = 4 * GiB;
 }
 
+static void x86_machine_finalize(Object *obj)
+{
+    X86MachineState *x86ms = X86_MACHINE(obj);
+
+    g_free(x86ms->oem_id);
+    g_free(x86ms->oem_table_id);
+}
+
 static void x86_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -445,6 +453,7 @@ static const TypeInfo x86_machine_info = {
     .abstract = true,
     .instance_size = sizeof(X86MachineState),
     .instance_init = x86_machine_initfn,
+    .instance_finalize = x86_machine_finalize,
     .class_size = sizeof(X86MachineClass),
     .class_init = x86_machine_class_init,
     .interfaces = (const InterfaceInfo[]) {

-- 
2.53.0


