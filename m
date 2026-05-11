Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD44BCD484E
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 20:22:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMX8m-0003Gx-Ub; Mon, 11 May 2026 16:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wMX8g-0002jR-VL
 for qemu-devel@nongnu.org; Mon, 11 May 2026 16:22:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wMX8f-0001zC-9f
 for qemu-devel@nongnu.org; Mon, 11 May 2026 16:22:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778530923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x8Qmpo6a6KqNjqYgOJX9U9yGoThB2VAWHy8SqRE6iCQ=;
 b=DTHBtUSJmiLpkNAlFu34hqNCNXrB83tHcA2mRTGvQVZFxOC3KiuMF7xwcH4oVedrLEQ7ts
 HF3Y7E+oDGftFKskKYwp+9MHii6k1ED+EB+HEzmZY7Z+u6uIAfdkasIYGQk/WNtNIpuQyG
 zlDRFOqPPIqOEsfVU388hq5687VkZw8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-6oakSBQ0NguyzgKX2TmwVw-1; Mon,
 11 May 2026 16:22:00 -0400
X-MC-Unique: 6oakSBQ0NguyzgKX2TmwVw-1
X-Mimecast-MFC-AGG-ID: 6oakSBQ0NguyzgKX2TmwVw_1778530919
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 69FEB180035D; Mon, 11 May 2026 20:21:59 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E5EC230001BE; Mon, 11 May 2026 20:21:57 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 08/24] hw/i386/x86: free oem_id and oem_table_id on finalization
Date: Tue, 12 May 2026 00:20:54 +0400
Message-ID: <20260511202111.3091440-9-marcandre.lureau@redhat.com>
In-Reply-To: <20260511202111.3091440-1-marcandre.lureau@redhat.com>
References: <20260511202111.3091440-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

x86_machine_initfn allocates oem_id and oem_table_id via g_strndup,
but no instance_finalize existed for x86_machine_info, so these
strings were never freed when the object was destroyed.

Add x86_machine_finalize to release both fields.

Fixes: d07b22863b8e ("acpi: Move setters/getters of oem fields to X86MachineState")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
2.54.0


