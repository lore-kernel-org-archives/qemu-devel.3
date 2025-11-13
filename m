Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52015CD98FC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 22:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJgEf-0007KS-UP; Thu, 13 Nov 2025 17:56:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vJgES-0006po-Pv
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 17:56:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vJgEQ-0000o6-Vh
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 17:56:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763074558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hHjfl9rVQmmybVck7H3LmIjKk8i40tWeUooDERZaD9g=;
 b=V+0JXkpye3cQlN34yAAmygCYRSYfR8ZxZaU2g+3qzFhUzd41mRHNHUcbE+m3jeaGL5BPdu
 rGTuPPr6V3OzGYE61ZNradhABB8lxk6wq5C9MgrSsPd+YnSaXumHg+21dOlBZ/FodtIIoQ
 VS8s2UFBm6dGTo7HjOC76Io1G44jkdE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-DkIbsLd0Oei1toe7f-mKXw-1; Thu,
 13 Nov 2025 17:55:55 -0500
X-MC-Unique: DkIbsLd0Oei1toe7f-mKXw-1
X-Mimecast-MFC-AGG-ID: DkIbsLd0Oei1toe7f-mKXw_1763074554
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 228D518AB40A; Thu, 13 Nov 2025 22:55:54 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.22])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E2C0D1955F1B; Thu, 13 Nov 2025 22:55:52 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PULL 14/15] tests/qemu-iotests: Fix broken grep command in iotest 207
Date: Thu, 13 Nov 2025 16:55:10 -0600
Message-ID: <20251113225531.1077484-31-eblake@redhat.com>
In-Reply-To: <20251113225531.1077484-17-eblake@redhat.com>
References: <20251113225531.1077484-17-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Message-ID: <20251113080525.444826-1-thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
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


