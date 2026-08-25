Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB7EC61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 19:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wywYF-0005Gg-VA; Tue, 25 Aug 2026 15:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywYE-0005Cw-Ln
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:11:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywYD-00044H-1y
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:11:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787685070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mpb/2b3qMFQzTLzTCER3qNfrQzUe3H5wt66hPLCR09I=;
 b=URWxBQtqY8omK4E+r0cYKzHJkkHZ50XjncRCrTT5YIj84vhV5GwHybomK4iEoU6UayNptB
 UJ1eRJEiIfmVlFs8vwvq+DFjcGZtNdQcA7/BqYSzTiTgqXyzWvkh/v5wkWTFwjjiE2GOKj
 hyxUs90PjKBJZRJm+fquEQE3mohOKBA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-2xD1sbghNOmoCBF7nApFbw-1; Tue,
 25 Aug 2026 15:11:08 -0400
X-MC-Unique: 2xD1sbghNOmoCBF7nApFbw-1
X-Mimecast-MFC-AGG-ID: 2xD1sbghNOmoCBF7nApFbw_1787685067
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 10A631953943; Tue, 25 Aug 2026 19:11:07 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 42DED18005B4; Tue, 25 Aug 2026 19:11:05 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 23:09:24 +0400
Subject: [PATCH v4 17/49] tests/qemu-iotests/205: fix race in
 assertExportNotFound
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-qemu-no-hmp-v4-17-af60857c2fbe@redhat.com>
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1493;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=skNsYNNV1xMEy9mfAYu0UimfTtL6eome8md1k82hjKA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjeiHEzoWa/QVyCu2VNLj2ztQsaGS58+bqg94R
 GPNYNaFILmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao3ohwAKCRDa6OEJdZac
 5eGfD/wNuSoC9HZBH4mB6ql2ngog4Q4Z43keZHid7/jTG4QyESdCxDkviF9pGQqqFadHRO/60RO
 ABBW8qXUXpSQYXvS2M33FQdC6+fEfJJd+7SpxR6+080fYZYFLKOvDeevNeBIHWT7/zlEK6GcsYo
 0PppoF9voH88gs29KeYPvp6zGEVcQ+sWoB8oXp8IFT+6snLWmrwcoEot0oko8mbhxsvMgrFBdCr
 VpP6Fwu6h4mfiVaq086JbkjRmDeoJGOX1KixtrRAwfONZPbcUKPJTNlb/mUg5CHLtDy+ae26NAq
 W12qanRdUet3KE6GZt3rQF7U/M+WGLYYvM9eext9YmrgP8fT0IHt1QPC+QBDvzrFqyiQR1rXkVe
 3J0JQd/7pmRpskrhV2frzbWI19HLwjZYEOhiJXIb4qZSF8+Kzrbj8oxTuDh3G4w/2sSJ57HHLCo
 YZAH927fW5V36oCAdYL+UxYCeOpRg7KIjZdxUXltg43aN0TruJMXYh3nOE0JTXAUUb7kNUoajU9
 xfiX0/Z0QUYwhdRbRbOM8w75g5bDph8abJQKikASlQpSc/pkHgOsV+GG1Bn3hY4JkYd7D8hT+F7
 m5yw9K3Vw5x8vxbcbp3RlBMEPGKNTneZUKE+eyxAQZDLvI5dNMoe1bI7gRmt1ULESDquzkBUE+B
 N3f9Q4mIihIKKDw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

After nbd-server-remove with mode=hard and an active client, the
export is removed from the NBD export list synchronously but remains
in the block export list until async cleanup completes (via
blk_exp_delete_bh bottom-half). A subsequent nbd-server-remove call
may find the export still in the block list with user_owned=false,
returning "already shutting down" instead of "not found".

Accept both error messages in assertExportNotFound, since both
indicate the export is no longer usable.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/205 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/205 b/tests/qemu-iotests/205
index 2370e1a138b1..78459065418c 100755
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
2.55.0.543.g5ebe2ebe4ea8


