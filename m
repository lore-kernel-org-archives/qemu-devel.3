Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0CE0CDE00E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 21:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcrUz-0007kL-2r; Thu, 25 Jun 2026 17:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrUu-0007Yk-Rs
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:20:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrUh-0003aZ-HR
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:20:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782422418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yxvj36VhLZ4K4hFt17jHRxD7HzRdTAOS+0IhywHutVI=;
 b=RviXrf2/BXRqBK+nDha2/HKy1nc6YDydoDUNPEvGNZbuOo4lRCmxCT94Y1JM94eRK2UdCn
 wK2G4WNAKETn5SoknUk04e+H6xmWZ7haFAEPTF26dsVZki/UT+k944jVg5CMisvn765Nnf
 Jipen2sh6GUCxq1XaLe6OYkneZxY/uE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-PwXXNHnxMkuczUCKXt8PdQ-1; Thu,
 25 Jun 2026 17:20:17 -0400
X-MC-Unique: PwXXNHnxMkuczUCKXt8PdQ-1
X-Mimecast-MFC-AGG-ID: PwXXNHnxMkuczUCKXt8PdQ_1782422416
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E8CB187311E; Thu, 25 Jun 2026 21:20:16 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8E164195608D; Thu, 25 Jun 2026 21:20:15 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 26 Jun 2026 01:19:09 +0400
Subject: [PATCH v2 08/39] system: decouple qmp_inject_nmi() from Monitor
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260626-qemu-no-hmp-v2-8-8af31bc54c61@redhat.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
In-Reply-To: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1472;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=nniyeCdT7aYf3nKVdm9bUAQZLwv8F/CBtyNTOyMrLcI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqPZtcmfYc+KcfExUEyy1vKZeWZEeewig0hbE5e
 Ad5s364QOyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaj2bXAAKCRDa6OEJdZac
 5XItD/4t/NqhJ8Fea89VYEj3wocoJTpDsmp27YHlGSUIGE8fKC7mR0wIIQnZ8omzWgaIf0dNZlp
 AsV0mmO4QOCdpsaeGuqF5Ttf8QOQqB1Pq6wlfCZE3IfUrn24dnPKhPvuXsWbsDHP4m1/+/DfqDl
 Pz4YgNl9UWwoI3JloLYohzPCQBgCY02hPsZ1W5MJXU1xgt95Gyh4ryXMp7sqKCVWsoR14iSY0mp
 gyo3V0txOE/MdTILl7eqDHQPCm+3cTBGoyQzySpxsIGvh6ozsDhW0Kf4brNtLoL1ea3CbqLCn7G
 uaD7gDc6OXjrk8+T5nlVQ11xaaBmhdNI1CM3FdjAxIFjDLH2N5XMz/pFlTW7AY9tsaPewcwSb04
 T3hSx3XUJLNEnnfsMUE07lroZnKPGNWtmIwLymAnVAFZV3zyXLozqI0bxs3YV+ajWwtvfo2w4Zm
 7Vw11Ni13q+yzuqJq41nTn0BIJFPrnahLVKnEKU3FcR2PM20q9+y07evMNZf71nU8+Zn3wqWMlL
 WkfTyML1O4bo1fxxTiURGBwQV8bAkL+f95HmpfVj7Ll4Vgba5EYDiaFnqPpOnP55FIBjAKzge1W
 mJSp8/lW6LxXhUMXQ8WVdjJylnHkN7VYHfHU/Vzs4mbW5ld4fclo1ZP3Y9E5Ca5JD/hQl8J4VwS
 +XP06clH8ksyz6A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Use first_cpu directly instead of going through monitor_get_cpu_index(),
as this is HMP-territory. QMP doesn't have a `cpu` command, we should
add arguments instead when needed.

Update the inject-nmi doc to accurately describe per-architecture NMI
delivery.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qapi/machine.json | 5 +++--
 system/cpus.c     | 7 +++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 685e4e29b87..03461f5f723 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -432,8 +432,9 @@
 ##
 # @inject-nmi:
 #
-# Injects a Non-Maskable Interrupt into the default CPU (x86/s390) or
-# all CPUs (ppc64).  The command fails when the guest doesn't support
+# Injects a Non-Maskable Interrupt into the virtual machine.  The NMI
+# is delivered to all vCPUs (x86, hppa, ppc64) or to the first vCPU
+# (s390).  The command fails when the guest doesn't support
 # injecting.
 #
 # Since: 0.14
diff --git a/system/cpus.c b/system/cpus.c
index 49f6daec3cd..6e3ef0afeca 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -915,6 +915,9 @@ exit:
 
 void qmp_inject_nmi(Error **errp)
 {
-    nmi_monitor_handle(monitor_get_cpu_index(monitor_cur()), errp);
+    int cpu_index = UNASSIGNED_CPU_INDEX;
+    if (first_cpu) {
+        cpu_index = first_cpu->cpu_index;
+    }
+    nmi_monitor_handle(cpu_index, errp);
 }
-

-- 
2.54.0


