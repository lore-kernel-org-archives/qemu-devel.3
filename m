Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E7FECD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPopk-0004Vy-8A; Wed, 20 May 2026 17:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPopi-0004Tq-Vp
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:52:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPoph-0004ir-CL
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779313924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IZtUzZpbpf9YYm5RHL11hpLjPNLROe9A2vYPhB1Pxo0=;
 b=WFtY9ldkI/g+RQknzHzOerumJEc1Rg2XDcI86lwchSawYs/NFPyUidQ3Uh53F2m/IdBOXg
 9hmiwLzV+GtduWTEeB38wB7xKL9GnLhLQRSpn1O5J2vsuvweAzeW+EyWrYWbOe8Vh5lSdN
 P4m4cotM1jee/GJgfLWeeGriH7a9vUk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-qeQhkSDoN3OVRHDw8ec2fQ-1; Wed,
 20 May 2026 17:52:03 -0400
X-MC-Unique: qeQhkSDoN3OVRHDw8ec2fQ-1
X-Mimecast-MFC-AGG-ID: qeQhkSDoN3OVRHDw8ec2fQ_1779313922
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4ED091956095
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 21:52:02 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A4CD51800576; Wed, 20 May 2026 21:52:00 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 May 2026 01:49:20 +0400
Subject: [PATCH 19/40] tests/qemu-iotests/copy-before-write: convert to QMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-qemu-no-hmp-v1-19-d104f809e145@redhat.com>
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
In-Reply-To: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3450;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=cY5OL3HTF9JMTQj/3Myv8kv0xhi8eNvqsNljyBUmFeg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqDiyD5kG7eRhXfizk8uDOVB3MbJ+OTkEoXHYL4
 DBcBjjK4VOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCag4sgwAKCRDa6OEJdZac
 5Wa4D/9Dd9UKFGEBU1Et1g4zxXTV86RUmMwXU1esuMlQrrnQh/2PnyfZVVfZTuSG7j+h4E4ILuJ
 RcXAyJenQK8qkxoaC3QPY6WtZiJhHojKdvUA3jdBGoZ++XBm9ooUgCvgQzzIe3QRETD7rWQL0br
 Z0S2MNNM4woqDrxm7QtzcR/mJnwrhJrBlFjrJ9hQxDQSVnr9CE/qedU0v8kXtGbakYS3XANBf+y
 qBLD3gmMpJxrw+9ya/cM60g065qt3lM0mOdW7S93YRrHpGmNzTfPgcAOlb/tUKnWNKS571j9tVn
 fO7mgXtzxkqfXknysDpu6QTBchRqiSdqdPrrxQZO2I//wJ0yvzrlDdpJwr1ITCodDgZWOX1y+Km
 bslLMn9MT7WFCbaH0tp+tgisiv0f7+kEIMUvnzw6pDP5C9YyyNiAIbYfot03TmjoBWxkkw7MDEJ
 b1s2oKAcOKpUa1Gam8qSLoCRgsabF1+i+Gfg6ZFeAP3ZnZcxqIbC28YqNLce7hISy50Wd/a0pKn
 UDaFwpf3tm2pvDcK32rbs54bGK8psitLThukF1C/ZY62kEynW0PJOM91xwcHmARO3MzOnX61MwI
 fb7C0ifH0KqPUsWQgUFb5H/H2M8LsHBmJGAPuoj1V/CLnijeBV7vPOFGRlIMVna/fkHbT6xa+XE
 oiCWymnUqpMv7AQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/tests/copy-before-write | 42 +++++++++++++++---------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/tests/qemu-iotests/tests/copy-before-write b/tests/qemu-iotests/tests/copy-before-write
index 11a9562067b..339bd0de644 100755
--- a/tests/qemu-iotests/tests/copy-before-write
+++ b/tests/qemu-iotests/tests/copy-before-write
@@ -85,13 +85,13 @@ class TestCbwError(iotests.QMPTestCase):
             'file': 'cbw'
         })
 
-        result = self.vm.qmp('human-monitor-command',
-                             command_line='qemu-io cbw "write 0 1M"')
-        write_res = result['return']
+        result = self.vm.qmp('x-qemu-io',
+                             device='cbw', command='write 0 1M')
+        write_res = result.get('error', {}).get('desc', '')
 
-        result = self.vm.qmp('human-monitor-command',
-                             command_line='qemu-io access "read 0 1M"')
-        read_res = result['return']
+        result = self.vm.qmp('x-qemu-io',
+                             device='access', command='read 0 1M')
+        read_res = result.get('error', {}).get('desc', '')
 
         self.vm.shutdown()
         log = self.vm.get_log()
@@ -148,13 +148,13 @@ class TestCbwError(iotests.QMPTestCase):
             'file': 'cbw'
         })
 
-        result = self.vm.qmp('human-monitor-command',
-                             command_line='qemu-io cbw "write 0 1M"')
-        write_res = result['return']
+        result = self.vm.qmp('x-qemu-io',
+                             device='cbw', command='write 0 1M')
+        write_res = result.get('error', {}).get('desc', '')
 
-        result = self.vm.qmp('human-monitor-command',
-                             command_line='qemu-io access "read 0 1M"')
-        read_res = result['return']
+        result = self.vm.qmp('x-qemu-io',
+                             device='access', command='read 0 1M')
+        read_res = result.get('error', {}).get('desc', '')
 
         self.vm.shutdown()
         log = self.vm.get_log()
@@ -266,18 +266,18 @@ read 1048576/1048576 bytes at offset 0
             'file': 'cbw'
         })
 
-        result = self.vm.qmp('human-monitor-command',
-                             command_line='qemu-io cbw "write 0 512K"')
-        write1_res = result['return']
+        result = self.vm.qmp('x-qemu-io',
+                             device='cbw', command='write 0 512K')
+        write1_res = result.get('error', {}).get('desc', '')
 
         # We need second write to trigger throttling
-        result = self.vm.qmp('human-monitor-command',
-                             command_line='qemu-io cbw "write 512K 512K"')
-        write2_res = result['return']
+        result = self.vm.qmp('x-qemu-io',
+                             device='cbw', command='write 512K 512K')
+        write2_res = result.get('error', {}).get('desc', '')
 
-        result = self.vm.qmp('human-monitor-command',
-                             command_line='qemu-io access "read 0 1M"')
-        read_res = result['return']
+        result = self.vm.qmp('x-qemu-io',
+                             device='access', command='read 0 1M')
+        read_res = result.get('error', {}).get('desc', '')
 
         self.vm.shutdown()
         log = self.vm.get_log()

-- 
2.54.0


