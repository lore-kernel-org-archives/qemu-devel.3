Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7D2CDE00B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 21:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcrVk-0002AU-Pl; Thu, 25 Jun 2026 17:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrVh-0001rB-MI
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:21:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrVe-0003l2-54
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782422477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BDNq0Jn1G3l2ITQQ3JXhQNcg0DMRRd1rLiTd5+ILQqw=;
 b=HLZfPdnexb2PIdh7ilVdJiVlPTCvMGBHIeGCNZcEZ/WWSruBZKf3MlBMgYeKZQVemcHHnh
 NmJmvxdL8Uew+0YZoW1xjnggcHA/lv+uNAnpbxfxlgWuyUW6GTzz847jyy4opgFuCv2764
 wUN+DIw1ck7W4PSEL7MRpOYk7pG5HXE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-308-kkei26l3OCCH7RZRyUvOvg-1; Thu,
 25 Jun 2026 17:21:15 -0400
X-MC-Unique: kkei26l3OCCH7RZRyUvOvg-1
X-Mimecast-MFC-AGG-ID: kkei26l3OCCH7RZRyUvOvg_1782422474
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B0BF71806CA9; Thu, 25 Jun 2026 21:21:14 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7C5EA31D2; Thu, 25 Jun 2026 21:21:13 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 26 Jun 2026 01:19:20 +0400
Subject: [PATCH v2 19/39] tests/qemu-iotests/205: fix race in
 assertExportNotFound
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260626-qemu-no-hmp-v2-19-8af31bc54c61@redhat.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
In-Reply-To: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1417;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=7IeWmVBR5ELo9JBkMzgfOKrPFErr8GlSRKnuYx5o2UU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqPZtdHsvd3wVEnBi7ADUccf7Spm+FvJ3hDM1R0
 a5t4d837taJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaj2bXQAKCRDa6OEJdZac
 5SxBD/0TgJ9K2cMdRQVLqxSApJwVARIDiKXHa3wQgdCIl2fcbp3TM9DostP1VQ7u5dNWAXIesdr
 ijh0/YolLPIDoARM8tSakNo8My+VrqNuWklFHCvW4sdADulnjlQ9a+Jv48954B73EpJFNPqKnTj
 A21CvIQdWVa8+Pd4hw3eswK386sxp5bVL8fVlqHQ5v3YKi8LHmUtaXsbfmJ5PhA/ITsHMsSj6IT
 M+p3Pja3+pITwUQoN+nVRlxpjP5Tv4Nkf6HMnUwHxwT+xEwd3AIupArVd4ogO3ox0Q6PQVCHP2k
 0/hpcO1OxVI0I/fO2hsf0VsjJnBFyrwa9B6CEgEnQEfFwpdbRiWwqbBW2j/NgV+4k+DfsSQ8P6b
 u1JIFdWvXmlH/OIw1lsyw0SD5OJgdPYPA98ajVZ3a5a/T+6sVyKLIGuf4DJfmS96oNC++CethZ7
 m5mh+DIn2051pbr4Z3qrkt0UY0AurV80AduOB8BfO7rNkd0RWGwdYD/jaT5bq/1TUFhGm0xudK/
 mOD/AqZ99Oia1hiZNV8msAt0VzZyKRBfZQhQYmr0pcQUoFqDyVgE20Vz0+N+3TITosXsydyTW3q
 Yu40YbyfuGQzhcGZ43TEhawoQyqX4RwuYmUPmy/EYFECI0sOPLlp05t0seGnnxRf32Ho2ZDu/TC
 lIsWj4NFUamIFHQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

After nbd-server-remove with mode=hard and an active client, the
export is removed from the NBD export list synchronously but remains
in the block export list until async cleanup completes (via
blk_exp_delete_bh bottom-half). A subsequent nbd-server-remove call
may find the export still in the block list with user_owned=false,
returning "already shutting down" instead of "not found".

Accept both error messages in assertExportNotFound, since both
indicate the export is no longer usable.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/205 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/205 b/tests/qemu-iotests/205
index 2370e1a138b..78459065418 100755
--- a/tests/qemu-iotests/205
+++ b/tests/qemu-iotests/205
@@ -60,7 +60,9 @@ class TestNbdServerRemove(iotests.QMPTestCase):
 
     def assertExportNotFound(self, name):
         result = self.vm.qmp('nbd-server-remove', name=name)
-        self.assert_qmp(result, 'error/desc', "Export 'exp' is not found")
+        desc = result.get('error', {}).get('desc', '')
+        self.assertIn(desc, ("Export '%s' is not found" % name,
+                             "Export '%s' is already shutting down" % name))
 
     def assertExistingClients(self, result):
         self.assert_qmp(result, 'error/desc', "export 'exp' still in use")

-- 
2.54.0


