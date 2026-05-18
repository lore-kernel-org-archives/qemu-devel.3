Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA80CD4F50
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 16:04:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP0QU-0000zB-RF; Mon, 18 May 2026 12:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wP0Po-0000EY-RH
 for qemu-devel@nongnu.org; Mon, 18 May 2026 12:02:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wP0Pn-0005Iz-9z
 for qemu-devel@nongnu.org; Mon, 18 May 2026 12:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779120117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S1qpIroQyaGIbCB6MQky+U4C7yjILb1PZ8jYJABwVSg=;
 b=LbH/FdXgASAEX6kUXAKOHkGTnTGA5unFQPf3YVf/Y8C/3eeUvAgI6RlknEkeiyX6djmGgf
 /2Agq3d34i21cbW9/sSKRLyHERjVJjew8PJ1550XslQrP/D7ByfL281Pp5IgHQL4wmGcAU
 0TMk1GctkrOaFkLH5iY+n3au+Xe9rPE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-lqSYKzOWMDavvf4o4eOjCg-1; Mon,
 18 May 2026 12:01:53 -0400
X-MC-Unique: lqSYKzOWMDavvf4o4eOjCg-1
X-Mimecast-MFC-AGG-ID: lqSYKzOWMDavvf4o4eOjCg_1779120112
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 614791800344; Mon, 18 May 2026 16:01:52 +0000 (UTC)
Received: from berrange.com (unknown [10.44.32.79])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6708730001A2; Mon, 18 May 2026 16:01:48 +0000 (UTC)
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
Subject: [PATCH v8 12/16] iotests: validate dmsetup result in test 128
Date: Mon, 18 May 2026 17:00:47 +0100
Message-ID: <20260518160051.903616-13-berrange@redhat.com>
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

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
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
2.54.0


