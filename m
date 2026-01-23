Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4720D72345
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 08:33:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjCal-0008Sn-Ey; Fri, 23 Jan 2026 03:32:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1vjCaa-0008Pt-Qk
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 03:32:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1vjCaX-00035w-Iq
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 03:32:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769157136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JmvJUEjMunp7RWLRJR2drOXmWJeDy2VfUZjyXh3PrEs=;
 b=eYr5z6j/uvPYVjxqqujxU19kSC0wW2YSNGA57Mp6aJ6K2UjjfTCsSMcX5RdlDHW306js5T
 3uBljnqvT3cK5p+FP6rUkuuR7ICWaRFuKoC3KEzKVZxCZSO+MQp7uJxadPXZPzk1TA7FEm
 ldnQFjZYmFvRS4rkWE/M0PlBtLUPemk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-D8kmxRNGPy2fiuUEidxOqA-1; Fri,
 23 Jan 2026 03:32:14 -0500
X-MC-Unique: D8kmxRNGPy2fiuUEidxOqA-1
X-Mimecast-MFC-AGG-ID: D8kmxRNGPy2fiuUEidxOqA_1769157133
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FD4A180035C; Fri, 23 Jan 2026 08:32:13 +0000 (UTC)
Received: from osteffen-laptop.redhat.com (unknown [10.44.34.167])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 192991800577; Fri, 23 Jan 2026 08:32:09 +0000 (UTC)
From: Oliver Steffen <osteffen@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Luigi Leonardi <leonardi@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>,
 Oliver Steffen <osteffen@redhat.com>
Subject: [PATCH 1/3] docs/interop: Add vtpm feature firmware.json
Date: Fri, 23 Jan 2026 09:32:02 +0100
Message-ID: <20260123083204.999920-2-osteffen@redhat.com>
In-Reply-To: <20260123083204.999920-1-osteffen@redhat.com>
References: <20260123083204.999920-1-osteffen@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=osteffen@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Some firmwares provide a virtual (emulated) TPM device to the guest.
Add a corresponding "vtpm" item to the FirmwareFeature enum to reflect
that.

Signed-off-by: Oliver Steffen <osteffen@redhat.com>
---
 docs/interop/firmware.json | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index da0362a2c0..12eb1fd79c 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -222,6 +222,8 @@
 #     loading the firmware into flash the 'stateless' setup should be
 #     used.  It is recommened to load the firmware into memory though.
 #
+# @vtpm: The firmware provides a virtual TPM device.
+#
 # Since: 3.0
 ##
 { 'enum' : 'FirmwareFeature',
@@ -230,7 +232,7 @@
              'intel-tdx',
              'enrolled-keys', 'requires-smm',
              'secure-boot', 'host-uefi-vars',
-             'verbose-dynamic', 'verbose-static' ] }
+             'verbose-dynamic', 'verbose-static', 'vtpm' ] }
 
 ##
 # @FirmwareFormat:
-- 
2.52.0


