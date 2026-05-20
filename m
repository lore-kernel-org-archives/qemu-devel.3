Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD579CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 16:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPjgA-00068t-Ku; Wed, 20 May 2026 12:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wPjfu-0005qf-OK
 for qemu-devel@nongnu.org; Wed, 20 May 2026 12:21:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wPjfl-0008UD-NW
 for qemu-devel@nongnu.org; Wed, 20 May 2026 12:21:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779294087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ynNoKp1399ThNit6mItDV+aSFCek+66uccDM7kPqA/o=;
 b=UEhCXevXtEpPF5uKC2U1veiSOY6ffEVqyZAAtgM5T8hYFyLm0BgVa9+Oh+6x3NvqBJqBS5
 EBWLKHrh4N6kg1OBgJGKPDuAnbGhV2fJSgQ5ofNnlMk9DS/UPLci7Se1ggnnM7fNnjJ1aJ
 liOrFDTU6s0etcZ6r0Pa1scGB03ukjM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-182-9ofTEChYOuGx-wZTUzwV6Q-1; Wed,
 20 May 2026 12:21:23 -0400
X-MC-Unique: 9ofTEChYOuGx-wZTUzwV6Q-1
X-Mimecast-MFC-AGG-ID: 9ofTEChYOuGx-wZTUzwV6Q_1779294082
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F2AB0195608A; Wed, 20 May 2026 16:21:21 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.34.136])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B5A0719560A6; Wed, 20 May 2026 16:21:19 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Farhan Ali <alifm@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PULL 01/11] target/s390x: restore cpu_models for system builds
Date: Wed, 20 May 2026 18:21:05 +0200
Message-ID: <20260520162115.1613601-2-clg@redhat.com>
In-Reply-To: <20260520162115.1613601-1-clg@redhat.com>
References: <20260520162115.1613601-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Eric Farman <farman@linux.ibm.com>

Commit 0b83acf2f05 stated:

    Introduce a source set common to system / user. Start it
    with the files built in both sets: 'cpu_models_user.c'
    and 'gdbstub.c' No logical change intended.

Except that's not true:

    git show 0b83acf2f0 | grep cpu_models
        with the files built in both sets: 'cpu_models_user.c'
    +  'cpu_models_user.c',
    -  'cpu_models_system.c',
    -  'cpu_models_user.c',

Restore the s390x_user_ss section, move "cpu_models_user.c" back
into it, and re-add "cpu_models_system.c" to the common_system
section.

Reported-by: Cédric Le Goater <clg@redhat.com>
Fixes: 0b83acf2f05 ("target/s390x: Introduce common system/user meson source set")
Signed-off-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260511163541.192533-1-farman@linux.ibm.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 target/s390x/meson.build | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/s390x/meson.build b/target/s390x/meson.build
index bc4459e8ed7b036e2ee5668dd338c5785a364fc0..c2cb4aca469ab49a43c22800c996cf94b09fd572 100644
--- a/target/s390x/meson.build
+++ b/target/s390x/meson.build
@@ -22,7 +22,6 @@ gen_features_h = custom_target('gen-features.h',
 
 s390x_common_ss.add(gen_features_h)
 s390x_common_ss.add(files(
-  'cpu_models_user.c',
   'gdbstub.c',
 ))
 
@@ -39,6 +38,11 @@ s390x_common_system_ss.add(files(
   'mmu_helper.c',
   'sigp.c',
   'cpu-system.c',
+  'cpu_models_system.c',
+))
+
+s390x_user_ss.add(files(
+  'cpu_models_user.c',
 ))
 
 subdir('tcg')
-- 
2.54.0


