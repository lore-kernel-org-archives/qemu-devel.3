Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F53D3CC9F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 16:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgQWx-0007kU-Mt; Thu, 15 Jan 2026 11:49:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vgQWb-0007W7-IX
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 11:48:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vgQWa-0003xR-16
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 11:48:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768495723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JN46k4IKDfvc8nKMlY0GOdbyNPNsphPRE/DkfvMnpXs=;
 b=SaLrFpj+fKNRagtdI68iGIbAZ8OJBZEshmeV2Kb6a9qTutNWjyTf76sz1Cp/2GFHI8+mtX
 qsN9iBuE43z5VoTP1Ev0OWR4yRk2uadnbRWXgViyuQJQhmc9Vmfm8lKQGnwwCwGk0ybKVo
 8wrXWRLhZK7FFSe78NJULxOfXwnPI60=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-398-M5jIipQSPzeImbCYYOmywA-1; Thu,
 15 Jan 2026 11:48:40 -0500
X-MC-Unique: M5jIipQSPzeImbCYYOmywA-1
X-Mimecast-MFC-AGG-ID: M5jIipQSPzeImbCYYOmywA_1768495719
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0350F18002C2; Thu, 15 Jan 2026 16:48:39 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.98])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4FD681800285; Thu, 15 Jan 2026 16:48:36 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 11/14] tests: validate dmsetup result in test 128
Date: Thu, 15 Jan 2026 16:47:53 +0000
Message-ID: <20260115164756.799402-12-berrange@redhat.com>
In-Reply-To: <20260115164756.799402-1-berrange@redhat.com>
References: <20260115164756.799402-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The I/O test 128 uses 'dmsetup create' to create a device, optionally
using sudo to elevate privileges.

This dmsetup command works in GitLab CI, however, the test then fails
with a missing device name:

  1..1
  # running raw 128
  not ok raw 128
  ----------------------------------- stderr -----------------------------------
  --- /builds/berrange/qemu/tests/qemu-iotests/128.out
  +++ /builds/berrange/qemu/build/scratch/raw-file-128/128.out.bad
  @@ -1,5 +1,5 @@
   QA output created by 128

   == reading from error device ==
  -read failed: Input/output error
  +qemu-io: can't open device /dev/mapper/eiodev16546: Could not open '/dev/mapper/eiodev16546': No such file or directory
   *** done

  (test program exited with status code 1)

It is believed that this is due to the build env using a manually
populated /dev, such that the device mapper node won't ever appear.
It is not a race, since a test adding a sleep did not result in the
device appearing.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qemu-iotests/128 | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/qemu-iotests/128 b/tests/qemu-iotests/128
index d0e00d24b1..d75b1a451a 100755
--- a/tests/qemu-iotests/128
+++ b/tests/qemu-iotests/128
@@ -42,6 +42,12 @@ _setup_eiodev()
 		echo "0 $((1024 * 1024 * 1024 / 512)) error" | \
 			$cmd dmsetup create "$devname" 2>/dev/null
 		if [ "$?" -eq 0 ]; then
+			DEV="/dev/mapper/$devname"
+			if ! -e $DEV
+			then
+				_notrun "Device $DEV not appearing"
+			fi
+
 			sudo="$cmd"
 			return
 		fi
-- 
2.52.0


