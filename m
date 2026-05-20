Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B01CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPooa-00074F-2u; Wed, 20 May 2026 17:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPooZ-00073u-Fk
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:50:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPooY-0004Hd-0n
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:50:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779313853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DaxMm+ATW0XH2SRjrJ9nzr1kVlKpgwqFzKFlBZW+20c=;
 b=KSU/TccKXEboQOCTR8xvhVmJ3ys0aCs3YZHtRKPgaVGpqBi4dP/yK80nGAC91jggMQwwl3
 90EWOAgOwDmoDuV6x4m5dMs/W2czcSyxLXKzvfPSjb5YWoDICC8HAUyhJJHrLKJmezO64N
 xqHNDqclWhPH85O9YXBnjw7N4eShYug=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58-0_IIJDd8NWCGaVjxaSuj0w-1; Wed,
 20 May 2026 17:50:51 -0400
X-MC-Unique: 0_IIJDd8NWCGaVjxaSuj0w-1
X-Mimecast-MFC-AGG-ID: 0_IIJDd8NWCGaVjxaSuj0w_1779313850
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 881DF1800343
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 21:50:50 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B53B018004A3; Wed, 20 May 2026 21:50:46 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 May 2026 01:49:08 +0400
Subject: [PATCH 07/40] system: decouple qmp_inject_nmi() from Monitor
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-qemu-no-hmp-v1-7-d104f809e145@redhat.com>
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
In-Reply-To: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1472;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=UITm5A9BOl36Q/cBlizyzMSRl4g2E0zRKS3yWKFt7nQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqDiyCmx70+e9oWUCQahL+F4WRSrzFDVZ23sBEO
 Ny1NxEYUHCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCag4sggAKCRDa6OEJdZac
 5fBED/9Oko5SEO6aRawDyf+d+2kZ90xzeUn/8M4Y9+STE0J5UeJGBsn9vHfu+dkKT7TUyvRUGqF
 +L5heGzzyXoJXCI8GkVUSeHs+OcdBD1NZO7G2us/Ce0hYO5aKCcrtJZFvfY43fxaJfV4EMKcVX8
 y7It5cjiVZ7XAr79EVq+3+qjoo4vK/37kZfHuJxr1cGLH7q3cgYgWI7wNTGY0u05FhaMoPDKK1g
 n9ryZvpzwSmOj/DACgRlCQamgEOMDES84/mlPD0rGs+oVLeo3mi5bxCAIQGgykwmvnkays/bRy5
 ofeFc99DxCVGBEtKZ7ki1CvfqFXaW9y0Ecc+yIO4Cyl0++UxzBrzMMF/F3OnIHY9QHd/LEy8QqX
 mGnOYyZTQuO37P1guCwclt6Tx5B/ArgKuFaXmZXQg/pJkneqX8jR5PZsAIHfl9jAkf3BQJQUb1X
 MC6HZ5fZxsnZcKokP1S6Aavry/JI1K6A6WRS8/ADgekfUX/+S4rEDT1SkL6wJKPOxmUCE2W+JQr
 9XeXZFo0DdFEIr+Q0zJP7JVQ2NsgHY7XTy1/E9ye0jXRJBp+T3GuowRtPM5+r1Slm3V3YVkPsKI
 Vvu3+ySjEgc09+P1N47tksePdDPhhWWhQx9yIoB6OX0hxhxXeqYo5UE8h667kJghvSeLiQlr628
 ftK1IRyCtJaqanw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
index bded87feb1c..0089eef9b1c 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -913,6 +913,9 @@ exit:
 
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


