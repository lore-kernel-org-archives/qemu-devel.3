Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D76C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 16:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD3vZ-0008UG-91; Thu, 08 May 2025 12:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uD3v5-0008CZ-Un
 for qemu-devel@nongnu.org; Thu, 08 May 2025 12:16:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uD3v4-0007he-IQ
 for qemu-devel@nongnu.org; Thu, 08 May 2025 12:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746720981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SL4P6zjxi3eHKmbO6XFzi9rgIjlHs8jYLeIdHJXZ30w=;
 b=g6OYDHViy6SG1xeogs2XNqkXhhf3qf3eL9FJqrZnK5gOck2W7LTACvnIm3E+8y5N/wfmia
 85BghHiO2xQN4DonaRS+lRQVRjPKHb8CBVkh3oe3TYDJh8nN4IaSCYa3z7ZMuorVWHnLO8
 b6Yi9BAdaT+FImP0M1MQM2f4o0dCGQ0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-127-WWzN9ky8MCGwuWN-R9latA-1; Thu,
 08 May 2025 12:16:18 -0400
X-MC-Unique: WWzN9ky8MCGwuWN-R9latA-1
X-Mimecast-MFC-AGG-ID: WWzN9ky8MCGwuWN-R9latA_1746720977
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE2291956089; Thu,  8 May 2025 16:16:16 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.138])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 903E8180049D; Thu,  8 May 2025 16:16:11 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, devel@lists.libvirt.org,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, John Snow <jsnow@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 6/6] include/hw/boards: add warning about changing deprecation
 logic
Date: Thu,  8 May 2025 17:15:36 +0100
Message-ID: <20250508161536.865866-7-berrange@redhat.com>
In-Reply-To: <20250508161536.865866-1-berrange@redhat.com>
References: <20250508161536.865866-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

If we change the deprecation logic in include/hw/boards.h, we must make
a corresponding change to docs/conf.py and docs/about/deprecated.rst.
Add comments to these files as a warning to future maintainers to keep
these files in sync.

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 docs/conf.py        | 4 ++++
 include/hw/boards.h | 6 +++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/docs/conf.py b/docs/conf.py
index 248ff8cf5d..f892a6e1da 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -136,6 +136,10 @@
     else:
         minor += 1
 
+# These thresholds must match the constants
+# MACHINE_VER_DELETION_MAJOR  & MACHINE_VER_DEPRECATION_MAJOR
+# defined in include/hw/boards.h and the introductory text in
+# docs/about/deprecated.rst
 ver_machine_deprecation_version = "%d.%d.0" % (major - 3, minor)
 ver_machine_deletion_version = "%d.%d.0" % (major - 6, minor)
 
diff --git a/include/hw/boards.h b/include/hw/boards.h
index a6784fe984..a7b1fcffae 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -636,7 +636,11 @@ struct MachineState {
 /*
  * How many years/major releases for each phase
  * of the life cycle. Assumes use of versioning
- * scheme where major is bumped each year
+ * scheme where major is bumped each year.
+ *
+ * These values must match the ver_machine_deprecation_version
+ * and ver_machine_deletion_version logic in docs/conf.py and
+ * the text in docs/about/deprecated.rst
  */
 #define MACHINE_VER_DELETION_MAJOR 6
 #define MACHINE_VER_DEPRECATION_MAJOR 3
-- 
2.49.0


