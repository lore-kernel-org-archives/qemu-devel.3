Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 304A6CD4F52
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 08:06:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJSKn-0005x1-7n; Thu, 13 Nov 2025 03:05:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vJSKl-0005w4-LP
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 03:05:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vJSKj-0007pJ-19
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 03:05:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763021131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=r9hU7gAfIUyV1gpY4cQP4wGH1aPlOqr1F4XOSHuQDZ8=;
 b=Yl/pTnP80nIV4GsjWTPYYTCKbh6pe/ShckTfai7qvhRcAZm0VFi3oD9v53lnjc8QTwSyXG
 NzttYRzhArifRKh5zt/gXaiNd4zvYjARQTfi1xz2FS9AzMHahVIG4VJwgqy1ZfNBE/KwkR
 +LdvNfdZK2A19txVWBt80tGw+1THh/Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-bSluoKzBOLGu3dvUD_mbiA-1; Thu,
 13 Nov 2025 03:05:29 -0500
X-MC-Unique: bSluoKzBOLGu3dvUD_mbiA-1
X-Mimecast-MFC-AGG-ID: bSluoKzBOLGu3dvUD_mbiA_1763021129
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A59131953998; Thu, 13 Nov 2025 08:05:28 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.127])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CA11219560BE; Thu, 13 Nov 2025 08:05:26 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>,
	qemu-block@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] tests/qemu-iotests: Fix broken grep command in iotest 207
Date: Thu, 13 Nov 2025 09:05:25 +0100
Message-ID: <20251113080525.444826-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

Running "./check -ssh 207" fails for me with lots of lines like this
in the output:

+base64: invalid input

While looking closer at it, I noticed that the grep -v "\\^#" command
in this test is not working as expected - it is likely meant to filter
out the comment lines that are starting with a "#", but at least my
version of grep (GNU grep 3.11) does not work with the backslashes here.
There does not seem to be a compelling reason for these backslashes,
so let's simply drop them to fix this issue.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qemu-iotests/207 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/207 b/tests/qemu-iotests/207
index 41dcf3ff55e..ceab990e648 100755
--- a/tests/qemu-iotests/207
+++ b/tests/qemu-iotests/207
@@ -119,7 +119,7 @@ with iotests.FilePath('t.img') as disk_path, \
     iotests.img_info_log(remote_path)
 
     keys = subprocess.check_output(
-        'ssh-keyscan 127.0.0.1 2>/dev/null | grep -v "\\^#" | ' +
+        'ssh-keyscan 127.0.0.1 2>/dev/null | grep -v "^#" | ' +
         'cut -d" " -f3',
         shell=True).rstrip().decode('ascii').split('\n')
 
-- 
2.51.1


