Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E04DCD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 16:04:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP0QX-0001CA-Dl; Mon, 18 May 2026 12:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wP0Q3-0000N0-Bh
 for qemu-devel@nongnu.org; Mon, 18 May 2026 12:02:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wP0Q0-0005on-MR
 for qemu-devel@nongnu.org; Mon, 18 May 2026 12:02:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779120131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7WmkbRyCOvc8KhMxUJJu07mhxWy5DTBCisJMQWdsY70=;
 b=Tp6eEsl92YtPUFK+kqfzYOhwV/NaOcu/Or6sOb63+eLmnvtKwOxsDRG27NGs2TRuxiLBO5
 VlkwSDkIodw/9BAdJeRvpeCqjE8OPCPosoHaSxUv2Fkrk9DrxdBnEZT22O3ReZ2Q69CiTi
 SmOY0CiiB9eGVJcL1yPd1OUAwMzCToE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-7KXHr2xcMzeHcCYt8KYEag-1; Mon,
 18 May 2026 12:02:06 -0400
X-MC-Unique: 7KXHr2xcMzeHcCYt8KYEag-1
X-Mimecast-MFC-AGG-ID: 7KXHr2xcMzeHcCYt8KYEag_1779120125
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 738F6195605C; Mon, 18 May 2026 16:02:05 +0000 (UTC)
Received: from berrange.com (unknown [10.44.32.79])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8A5B630001A2; Mon, 18 May 2026 16:02:01 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v8 15/16] gitlab: add jobs for thorough block tests
Date: Mon, 18 May 2026 17:00:50 +0100
Message-ID: <20260518160051.903616-16-berrange@redhat.com>
In-Reply-To: <20260518160051.903616-1-berrange@redhat.com>
References: <20260518160051.903616-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

CI is only exercising the qcow2 'auto' tests currently. As a result we
get no exposure of changes which cause regressions in other block format
drivers.

This adds new CI jobs for each block format, that will run the target
'make check-block-$FORMAT'. The jobs are separate so that we have the
ability to make each format gating or not, depending on their level
of reliability.

The 'centos' image is used to run the I/O tests since several tests
have an implicit dependency on x86_64-softmmu, and thus break with
other architecture targets. The 'centos' build job is the only one
that creates the x86_64-softmmu target in CI. Ideally this target
portability in I/O tests would be fixed to avoid this limitation.

Acked-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .gitlab-ci.d/buildtest.yml | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 4b1949a3a5..cf0281ecd6 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -174,6 +174,24 @@ build-system-centos:
       x86_64-softmmu rx-softmmu sh4-softmmu
     MAKE_CHECK_ARGS: check-build
 
+
+# NB: block-XXX jobs use 'centos' since that is the build
+# job that provides the x86_64-softmmu.  Some I/O tests
+# are currently buggy and blindly assume characteristics
+# of x86 (such as PCIe) causing failures with other arches
+
+block:
+  extends: .native_test_job_template
+  needs:
+    - job: build-system-centos
+      artifacts: true
+  variables:
+    IMAGE: centos9
+    MAKE_CHECK_ARGS: "check-block-$FORMAT"
+  parallel:
+    matrix:
+      - FORMAT: [luks, nbd, parallels, qcow2, qed, raw, vdi, vhdx, vmdk, vpc]
+
 # Previous QEMU release. Used for cross-version migration tests.
 build-previous-qemu:
   extends: .native_build_job_template
-- 
2.54.0


