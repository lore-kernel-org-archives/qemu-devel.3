Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A523DC98304
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96yV-0005jp-Ut; Tue, 22 Sep 2026 16:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96y5-0004Z1-35
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:19:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96xz-00085J-83
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aNGh1j8BNlQMzzH9Zq5A4MnslWOxyHVIf55UJ+B2Vzg=;
 b=iJiyqtb9svhU9jy6f+vyJN/vZOaOZljus7XDikK+CaaPcGW69fit3zWF4C3d6nexI++xwZ
 lgxKSe642RuDCl9pSBPPJVLON1ltf1htbgj2WRny/TfDbaEyvZqXzs3xY9H4bsIj0ag7Sm
 JokpSfVtQ5FgqulRla70OFuX29LqmRE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-Rin677QlPC-87uGqOFGCwQ-1; Tue,
 22 Sep 2026 16:19:46 -0400
X-MC-Unique: Rin677QlPC-87uGqOFGCwQ-1
X-Mimecast-MFC-AGG-ID: Rin677QlPC-87uGqOFGCwQ_1790108385
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52BD91800596; Tue, 22 Sep 2026 20:19:45 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 796C31800361; Tue, 22 Sep 2026 20:19:44 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:17 +0400
Subject: [PATCH 10/88] tests/qemu-iotests: do no interpret backslash as escape
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-10-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=734;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=0vJS6PzUtY3n6k3SocU+dXxAUgqKNBfyZx9jXyheUzU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKun8Ei0BYR8/VKKhreaW7rNvnU7M/+4Hg5Y
 IxQJzgyv1uJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLirgAKCRDa6OEJdZac
 5cDvEACITzyzemBc5A8mQSel8lvKf+5wR7CWMxK+xzMpjLd11oPQsJwLcZyWVtkN9fqYOFW4xVi
 +wn3bH6dp0yaA6Pqiaon0Sxwmwd1SRlfDBEHPYtwPDw5d4H7zOP1oSYGLkW//Gj038C9UIIfA1o
 6yNze3RcSd5yE3i7YqecIs5gWjxQUfVWcm3Hvh/2+wQ0jVpQ2Lmq/vFeNqq4Kog6AaZiyNEg7S1
 8DmZf5vmV2KiMcxXD5DZkgn6TuCXC3O9dGGdu2ZY7oidzaoGkN4yFTf4ouZpYND9Z8xdh/4ivMa
 jQ/rS7zqg3FLu8KAT3M64A5df9c70JE1wb32Q7G4X+mdM2E3rYrEP+WH12Qw986t/NhdRfZRysy
 6eDgj3TYdFfLzXcGra9IwvZfHNqnXlK+TjCCCgNkfyC5nks+4FrLsdadDjgawYMTLtlsl62c2zJ
 kHKdJNvccAmgbncW5feEzcMmxWeo/vLSIF1O48YZmAhLk65NsiU7+tqJWU+p7VcN/u4Q8hI/ppe
 RVitWrdkNgtK2Jb+L1AsJiYUTvyIf9p7CYgsonfm1WrJ3OGvjvUeutur5PxcuTiPjbEpzCFM3W7
 oCSb8fiUBHnqbdVEqrx2atl8wsNNKXntVb5GK7Fr0SC0I7QEGBKfJqTZVSt8Ld46mDpjEMDwG1N
 TuhOcAlVPWBq45g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

\n in the JSON becomes just n. Fix read command output using -r.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/common.qemu | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/common.qemu b/tests/qemu-iotests/common.qemu
index 0f1fecc68edf..e5b6a6a87494 100644
--- a/tests/qemu-iotests/common.qemu
+++ b/tests/qemu-iotests/common.qemu
@@ -90,7 +90,7 @@ _timed_wait_for()
         read_timeout=
     fi
 
-    while IFS= read ${read_timeout} resp <&${QEMU_OUT[$h]}
+    while IFS= read -r ${read_timeout} resp <&${QEMU_OUT[$h]}
     do
         if [ -n "$capture_events" ]; then
             capture=0

-- 
2.56.0.rc0.29.g47ce80527c56


