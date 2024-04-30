Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701B5C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 06:46:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1hFK-0002ly-5L; Tue, 30 Apr 2024 02:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s1hFE-0002k0-1D
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 02:45:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s1hFC-00044O-9w
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 02:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714459536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=iwgGsWCndrhEfGDCpQF2tQ24jDruM2CXUo07bzIqmx8=;
 b=hGUFtVNGioAm/E8EIwCbLFXR1Q64/wt5SZjVr9bhIh29d5xf1zyPoHinsu8Y7dVsYSlc/v
 vjQwI1WhYN11cBUirW09wnIGLjaYYsGr6B+5GANlEMCk8vGIsLQJgTy9O2stmS6nqH1r73
 xFZl+Qfb7ICvsNT8/oC1TAheidAke0g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-F6XcohnJPeSEoPwK4_U9Iw-1; Tue, 30 Apr 2024 02:45:33 -0400
X-MC-Unique: F6XcohnJPeSEoPwK4_U9Iw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AEA1D1049C9A;
 Tue, 30 Apr 2024 06:45:32 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.79])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D0352EC683;
 Tue, 30 Apr 2024 06:45:29 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: devel@lists.libvirt.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH] docs/about: Automatically deprecate versioned machine types
 older than 6 years
Date: Tue, 30 Apr 2024 08:45:29 +0200
Message-ID: <20240430064529.411699-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Old machine types often have bugs or work-arounds that affect our
possibilities to move forward with the QEMU code base (see for example
https://gitlab.com/qemu-project/qemu/-/issues/2213 for a bug that likely
cannot be fixed without breaking live migration with old machine types,
or https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg04516.html or
commit ea985d235b86). So instead of going through the process of manually
deprecating old machine types again and again, let's rather add an entry
that can stay, which declares that machine types older than 6 years are
considered as deprecated automatically. Six years should be sufficient to
support the release cycles of most Linux distributions.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/about/deprecated.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 6d595de3b6..fe69e2d44c 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -220,6 +220,17 @@ is a chance the code will bitrot without anyone noticing.
 System emulator machines
 ------------------------
 
+Versioned machine types older than 6 years
+''''''''''''''''''''''''''''''''''''''''''
+
+Starting with the release of QEMU 10.0, versioned machine types older than
+6 years will automatically be considered as deprecated and might be due to
+removal without furthor notice. For example, this affects machine types like
+pc-i440fx-X.Y, pc-q35-X.Y, pseries-X.Y, s390-ccw-virtio-X.Y or virt-X.Y where
+X is the major number and Y is the minor number of the old QEMU version.
+If you are still using machine types from QEMU versions older than 6 years,
+please update your setting to use a newer versioned machine type instead.
+
 Arm ``virt`` machine ``dtb-kaslr-seed`` property (since 7.1)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
-- 
2.44.0


