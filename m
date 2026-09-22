Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F776C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x972T-0001Py-Kj; Tue, 22 Sep 2026 16:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x971v-0000RJ-1J
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:23:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x971t-0000Ut-EA
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:23:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GrpBqUXeC/DgTI1ceWzLEG29wOaAQIV2yhaVFaojsLc=;
 b=JxuUdnckUv8ZTW9Aau5EkkWaroKzajdRKf4whp3E/B6z3jr41uxAqwPPtmvhVfHiMg7Xvs
 nIpKwPd/wsovPmelfWlYMaAID942WOABIhZC4vtkHIsft6fbUbcUznK4f9MGK7VVkO3lqJ
 f1kQ4WjXBcN9A39HXB8cyJkPa1T2VmE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-9gVVur3QNxuaPyN9YoeB4w-1; Tue,
 22 Sep 2026 16:23:49 -0400
X-MC-Unique: 9gVVur3QNxuaPyN9YoeB4w-1
X-Mimecast-MFC-AGG-ID: 9gVVur3QNxuaPyN9YoeB4w_1790108628
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 966671800596; Tue, 22 Sep 2026 20:23:48 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 89FBC180034C; Tue, 22 Sep 2026 20:23:47 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:18:25 +0400
Subject: [PATCH 78/88] qemu-iotests/182: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-78-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1051;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=VgNH8Xn8plg4jtJaaQTpiN6uMmsqW9QWi+JUc5TV58Y=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKzZf/IizyUAZFSKADTEoV4XGK/IEJP7zUOa
 HBN0VB4qSuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLiswAKCRDa6OEJdZac
 5cppD/9KfFhs+T1NTvDKtTtGblrIYE4H+l6gT38kjmppnK/e8iW/wt3LAYcCaXTwChQewBZxcbe
 rGnY0gdk/UEytNwXsWOJ3xPUYapBGXd1E8Tn5KIEvf5lMhAT/IQY+cuVACiQs2iXcs9ekqsa1B6
 kBqPezzKooixJ1f37RCoDlHyiEat/R+43EJsomMet/iVAz7qitIF4F8KfLsLKUQR/2syMmcKRE8
 17wblACVmXU4jVNzlUBEgBUdm8LrWcWMOk1dvlkvIJ0nvEL7KKFKpY4w6d+aHSBu01dzS2hBHLd
 HxPGZ88mZilslOtAqn3W2zgnw0gq1ZQocMgME6/zN1C9CckY1Sh3vSdpGC7nUR2/wQBgBBHvogr
 XCS1Kp1Ydcl5HcxHV9v08GzoaxYxjXJwY3VLtOuT8bNlDKxNsbhM+ctNCau20ufSK3iT9okc+Vb
 WuJD7ofiqJVppvKJEr/iGglf05CLz/NGEZF3LpdKvSvS4odgZjM2wC+TJl9NC2OtIdkuNYw+URf
 eQokRINJ+f/85t4CXAYz3a7Qg/XM2D0AhbNbLLPhE9PFT1PRUmB6xb0QhaUxjNg9SfoU3K6b+KG
 dEs6iBKF/Zcom/yDJmCJ7XevHuUtuEqIVLjQX3fzlgvKgFVUJekzpL0TL1d/zcrh0hzbJs/bvt1
 iqNaHrdrd57V0WA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Replace -monitor stdio with -qmp stdio for the second QEMU instance
that tests file locking.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/182 | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/182 b/tests/qemu-iotests/182
index af5eeb599c18..f0b8bd1ad2b2 100755
--- a/tests/qemu-iotests/182
+++ b/tests/qemu-iotests/182
@@ -55,10 +55,11 @@ _launch_qemu -drive file=$TEST_IMG,if=none,id=drive0,file.locking=on \
 
 echo
 echo "Starting a second QEMU using the same image should fail"
-echo 'quit' | $QEMU -nographic -monitor stdio \
+echo '{"execute":"qmp_capabilities"}
+{"execute":"quit"}' | $QEMU -nographic -qmp stdio \
     -drive file=$TEST_IMG,if=none,id=drive0,file.locking=on \
     -device virtio-blk,drive=drive0 2>&1 | _filter_testdir 2>&1 |
-    _filter_qemu |
+    _filter_qemu | grep -v '^{' |
     sed -e '/falling back to POSIX file/d' \
         -e '/locks can be lost unexpectedly/d'
 

-- 
2.56.0.rc0.29.g47ce80527c56


