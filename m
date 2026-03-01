Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91932FD0078
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 21:39:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwoU1-00046K-Oo; Sun, 01 Mar 2026 16:37:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwoU0-00045s-48
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 16:37:48 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwoTy-00041r-IP
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 16:37:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772401064; x=1773005864; i=lukasstraub2@web.de;
 bh=YSxykUnLHj+SuX5ceNRivJWw7C8CFbfonhplWMaurEo=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=rluHx2P9Ulz7fvGk0GIdbFxNB8skpQoLD5epV3ycNkn+eWXUbsa44A//hqfCOPT9
 0RV0B0S0+cHcPfwVD8ju5+yNaNUVgiuvgX1wX6QrhsDu5uaC39V0OhP0nK6Jtv9Rj
 zUYEA311Ruo/UMPZagt5a05oodLcZFtbWsf6m8Mk7VcYuq2Q0dwxSD6kSuKf2MS4H
 x00s4xXx8xLr7oiO50tu1kOq186KQN5l67pSHb0wq4HDQJvhBcqreDcwh+4zkXmz5
 zuESrqMbK5ClQmAvwSMB9iarIj4Y9rucgDCkWUo4JwqPw3/+i2Fy7UbRq5WKzH5qI
 Yh0FsS/pB2m3+KVL8Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTfol-1w72A92iJp-00YLBd; Sun, 01
 Mar 2026 22:37:44 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sun, 01 Mar 2026 22:37:31 +0100
Subject: [PATCH v11 11/21] colo: Hold the BQL while sending ram state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260301-colo_unit_test_multifd-v11-11-14c8a70c36df@web.de>
References: <20260301-colo_unit_test_multifd-v11-0-14c8a70c36df@web.de>
In-Reply-To: <20260301-colo_unit_test_multifd-v11-0-14c8a70c36df@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1103; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=RA7Q8b6eDwgtboLVRiR+7AHIKPUv7kjwK/dVBwC/CXE=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppLGhseDfNLscFmV/Jap0eWrbLhhVQzivy7XJ5
 4BucIrTz2qJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaSxoQAKCRA1qwsonF2y
 WIbPEACQgYXBweaCeMbHYYgJUn7p1H35AMKWY6pybPiKIbs+SR1e8j50LmvxvApjqSnn6IasLHx
 34uC6t7jWe4sE+GMyAJehNXhORfKSEqBW4kijOupfI9JCgwUZYe5QqVTfu7PQxkujwgwHmkbRTm
 qzQpa3bT9nBVTYCgeBxAMex5mTpTn3Zj1ckq5Sv43Jq4YsI/ZpBgA2kwyP99ofTZlUzZsB7iclY
 HVJQXzDhPboNzdK4mDy0Knjy/NvnejhjINCQRMm9wJ0tfFfot87l/7g7esJp0YI8RyQnM0SSc1a
 QT6wPkL3tHgdrcNCNa5rsacc5/peQhCqXTieHWcoBsXwFjeWe8NBzqyX9DIhJ7CRaRwaOfEn3q/
 GwPARyKL52LRsx+cboJ7gFFkzI3RVKhndm/j81BK3287vRYHg7sU7Phrb2WHNYFbn92Ai7+xjt6
 FhJA6Y+FG88rxtcH48kSdskXfvBWlBiBUEvIAjzEu6317PY71wSGf9VdBSr8UDCHG8T/1kdT5ez
 UKFvAe4gaQcQhkQMTzTQ9s2Fd85OmDhFaAjKCoY9aYOpCAaMsv3A5isUph/MiLRZBf63+V6E1fk
 6PqkjmE0Ut/vftzU6xymfBDPUsnfSPBS/jG0jVvmwnqNP4jMgIo03XANAzCcFVYuXSQxNi8uMlh
 3Wnjrqq0X3CbUAA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:4yNG7vvOc0Pt9lCoWIXDXbKOPEzygPIm6kVvVc2NFys7fVILmPd
 xcPpxgXyG29ntkZOHNOGjLEFNmfhNJeLHZ5nDfme8O2XBZCli0AFayxwQb9jS9Dx3Lg0BQA
 1+fLlv019OHzxSdvU/py5sciN0NhhebWYUN2T1MMAZZr9B0HB0Ml1F2aaOsEH7KptCchgK1
 wtlFunfQsmN45t1JtO3Qw==
UI-OutboundReport: notjunk:1;M01:P0:fGUfB6S5BJs=;KrmupWKudVbsnnjm4V0k0lIWDat
 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
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

qemu_savevm_state_complete_precopy() requires that BQL is held.

This fixes a crash when running with TCG accel.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/colo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index dc7cfa81ef7db78e3ee372642de48567c5bc06eb..3297aa593cd9f87bf101359846=
4cc581a9d23531 100644
=2D-- a/migration/colo.c
+++ b/migration/colo.c
@@ -455,9 +455,8 @@ static int colo_do_checkpoint_transaction(MigrationSta=
te *s,
=20
     /* Note: device state is saved into buffer */
     ret =3D qemu_save_device_state(fb, &local_err);
-
-    bql_unlock();
     if (ret < 0) {
+        bql_unlock();
         goto out;
     }
=20
@@ -471,6 +470,7 @@ static int colo_do_checkpoint_transaction(MigrationSta=
te *s,
      */
     qemu_savevm_state_complete_precopy_iterable(s->to_dst_file, false);
     qemu_savevm_state_end(s->to_dst_file);
+    bql_unlock();
=20
     /*
      * We need the size of the VMstate data in Secondary side,

=2D-=20
2.39.5


