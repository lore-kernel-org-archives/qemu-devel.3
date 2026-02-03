Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A82E1E8307F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 10:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnDSF-0007Xe-PP; Tue, 03 Feb 2026 05:16:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vnDS3-0007FI-BZ
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 05:16:10 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vnDS1-0002EC-6r
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 05:16:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770113748; x=1770718548; i=lukasstraub2@web.de;
 bh=g0D4GD0whMF9S+29OO1evM+fgXXSpdPHCqCK+yS42Eg=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Ek4p92pMTuruLIswcU5yy5aqZ0HN51jmH7wpsNsmxl+9L2tLI9ftd3pBqckoFt1E
 TOuo+Gdtq5mzh6deMWk9bjjMNQjNaDEy9TmAWW9Th/XkSLbbxEnrJ1bJo9V8iWpP2
 ZAM7Afa0089qYUcfjL0/Fn1vbBd0zwmOmEyYOquqlAqzSw5oRyi1t8oD6m8Z04KFd
 FN3lc+VVjVX4m+YWBGxBItxEFCzIqsKIPkWoCTNJjjhE9S3neiNYyUsJxEAu8yWoT
 0URlzG7XSUXN0ESrWfBWcAL71sHLzd1CtlBo5HSACZdA7VgryeW1ndu1dKksjR4ow
 YuLvWavna2w2HvisIw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M9IOj-1vt0jc3ViB-00EsWH; Tue, 03
 Feb 2026 11:15:47 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 03 Feb 2026 11:15:09 +0100
Subject: [PATCH v5 03/16] colo: Setup ram cache in normal migration path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260203-colo_unit_test_multifd-v5-3-57508b7389f6@web.de>
References: <20260203-colo_unit_test_multifd-v5-0-57508b7389f6@web.de>
In-Reply-To: <20260203-colo_unit_test_multifd-v5-0-57508b7389f6@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2711; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=1mMhTslV7cg6iKWHsOFtaZSmCzWFWpfBUGInMbVbPoU=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpgcrPz+oJVfgNF+iPIzBYA7kUkouY8XQPm9/hP
 7L3MF2FL7mJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYHKzwAKCRA1qwsonF2y
 WMYPD/4+JZIrIESYr/DgLTse4SrpAPmx7LHOcdR4mtsyy1E+py2FFDniWg5QULfv1TNGp9G49aK
 DyW3CvauY5xaS6HqDj7H7rgKT7q+aGd8rdv3VUUve8hRLSpir+IV5VJCkv+AI9OJ3sTat99SPxv
 5wGKXOQ23xCfbL/096mlrFdG7MBZiU8kwLsHY45/+TXt0J3fyOmdNFA+k6nxpiWErObV9E37nJD
 RVT4tL2j3xGvbptETRwJdV0PfX9NlShihsHtIYr3EJGRYyfzKKzihUt2v0VBHror0wX4tz8iUVk
 Ytgu4jec/vueMDTDoaUYuLL87jKlMs62ZtLhThRzFKq7Enblge9qXUY996xaeHJFc7j3+jPjM4e
 6BK2+4yFg78NJDvjax10FOwVM0MDhoVfEYoutWdxcqXplv0PZ20Z+lRX7AEFXyPjAL0j4adRj+M
 aLb+sGojGZHXe4lVjEnIBlMmWmlksVVJkFw6rMqDkAhSiE93Kjvy67XYTRYb7UgXVCiY8XZ3Fga
 u2ZfSvGeltmIMtMV5Hd44M2/wi1nc72+9WY8iUQfDGfSKQSKQVW8knP+AuAy/+G5+/PkEEf47zU
 uKtsBUR7LlVhFccuJBlzJANl0Ve++MS6w4uOVjobSlGrs8GpxD6T9B9Fc+7xsVePQmsHPGtIcdl
 WWOB5TIBM0JFyDw==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:hwr9goDchxV9PwMFe6y6Q7YYxOTP5EImtGj+HomWbgkJJhQT3OR
 6a9qKizP3xEhi+k6DsLCELhsHNTHjlurvJ+Fzl+WkPkZ20xGLQjD95mwlT9Olfs/HhXEG+Y
 7Zw3z73Kul7U54qgRIgJI+SY8aYjq7Zy/SiW14LMS6b6+z5QlS5Skf3lrBT+mPZmMWyXMDw
 vWJAR3XzBVTWrAIJ8s5Wg==
UI-OutboundReport: notjunk:1;M01:P0:g3pRwUpgKVg=;YH0wBcM48LdwPo7gsnTDTTAGwpr
 3/QcTR1rXYh3fG6I2caAn7rER5CWoeWBmcQRncoFAL6zwSxrDEsOVBAA+mPvPkrCkOdCXRSxC
 Va3/5zA+2ssMbHTjFZ4RWc9WRG31Lmqr2+LF/YH8UEnpjkbN/dJVFNbAK6FtpSxyrb4pVR1sW
 dIqdw2QKntgU+N36BxnhHqPyjLnU/0rqmr3JqM7MNnH0XJwnWaWJgAu95yry3YI7y8+OEQgB0
 kAUDdeaeGvOrUElw8G4jx6a3kl2nNeDoMLZQ5KTEEL1avInT0UWoSA6ptJVIeM78i39x9cJPl
 S/oJtiHVseg8hpouXmtf92m0ftgEjJL+/SmVYHaaA805hy7podeeeyBeyZqG8pFfn7ym1ui+C
 1mBGSvlyfAJAMeDzPukxugW5OKVQjBN7yL6H3ZVg0CQjm6Tm192qwlnfwKTXZfH7wb9+EihbQ
 pIR+4125Am0b+afm+82EGdaL7usHqaSsPFslMrGdC5GDRfY8e9tfBh32n5uAH9FT+4UzI/g0+
 kvtxx3LNDM+fkJ1g2xvFkZ7qFJEoLUXegodoUJEbg5wbuHjKJdtkIxf8u2wD72aTBBYIFdx9P
 ++YJnT0QL5sj7nObEPCgoPi2VQntvyik8l2kzuaamnKkH83npOcI3Sxk5Y34Qvk2wx31rajyt
 nEp07I8Dd1d0q4PY25PIbFX9vSc4DS6YAbMfx86C7spacBdvwi543klD7MYOnv5UX1qinUcAZ
 B2sukwTmCBwc5MJ1gynDEzuZG42RwguUptnbK83rgz8CrEAZC6bQ8xoGEWELKiWrNAB9RFsV7
 nnrunZmaATfyQZ3F1U1Tex+y0QwgV9Kwn/Tkoc+xoH++QRssVAEt+pHjpWnwIi4jXigl1+Anp
 zVLqZeMvX9eW+ekpUsrBGjlmXvJDS/vZeLPgXVlPlLDSM6P1IDkl4ViZQzHJHRUQfcXTPVaWC
 c/R5LzK5LWJrKoYqFMLocr91o+5QpTUu4q+UVsgHkS7Rvd00gd2VNTh+iv1/3nCEnxqZjUomg
 83/Vk34nS0icBgM2bhut3YJ9/pWqwBMu48GQgwZvBefKFZDj04dB7pW812lk0j2Yo4hGK//2p
 gsCfinevpczBwSLcz0Xafb88Uj13x/tvW4SauE3taYOKqr3NKUI0pLaPss6C1XYwgb1NgObkn
 YrbQNfBpPLtpZGM2mAo6j/Zxo/uW3o6PvCRbbi5QblGLpdo9BqkddUVbAJN1la1MMiIFYVI1m
 dRx6aHXcUDxaEVAWdIVeErXDooe76y4uHbur+iGJ4lThT7T33nniLbe2nOcTuWe53CQ4yYmKI
 qYqD+U78z0q6WK0StMm5Sgp9LHKly4o/qUm+avlerubTP17J65rEGKC0JvOL9eFDpneelSINf
 q13viYWNGVkTAiLPMXzO6tMBdIeEo8O09dyX9x/qmkG9BWMt0qj9XLU8+vytF2I8pPSZzqlhl
 lclEBI4QyO1fVf5oldMwUrQ3nioFawzSvRTcBwQm7I6/3qqJfl7ZDQ6vf+Ahe8mgUST5o9rRb
 GHttZ4QsiTN7ffojLNa9XIoYMn7aZAYt5EL9lQ7wyVuhQUu/CY6RnAlfwpR2raxFhTPdov1ks
 OS5ZGzLVTa28K1Ot4MWZoTl98Exx91Cop+sp3vWPbK5XclF26JTz7rrDXeBFDx9rTOM1MwQnZ
 T4ByRN0K5Ykf8bH2U2I/d6ud3MiRDo3CPGkVH42L+i5FvYJAGT8O9hz0qbgoSmKfwpVwgsFxO
 el8DfHocr1Cirgq2Go374zR8TyN3nNzi9LO2pUf7Ci5K5zpJ80/A1wSF2ZKkUDk9D8xlvIE7J
 sGzIb1EwnzTdWVVfMcyiY/CEFm5boigOelkznfUkr9guZIZPGnfTIrPniVxMOxeTp7uol7om3
 enMjrgYjEbIAuJIkJYG5BOG5Fq3Q6XkMBAEAJlnl1epbwH+OhozI6qjQMw3o6cccDM+5cYS6J
 94EyynDsoukJ2wGpFbBfs9E6SVptZvtKG0yMkx+1Wa6Qg/VWrIiV8P6ToFu/SdBL/oemhRjwE
 soFel6j1sFVxPhdcI5cdVUaHaiaGlaaAtci41BvV3OfBAXrvgv1Xfv2sqqQBNbYIWndtFc3jv
 YuBaFHIlfFgtIB3wkKfobPFzimmkveD7Ma91Y0JxSRtd4FAUrNVctbFPUazOJHiof5zTJJuFy
 6HHc0C4cGMG1VwMSTb74C62txgbfD1IrUR8o4ckCUx7yKh/3cNdKz7AxLJYflfLLp4KTjC4lO
 BoF9FTZ9dQn0qMnOf5jlB2yVccW521KionGSe71jh4jbPioSv2aqpRNaM3KyDZDDzCZ2hyy1l
 jFy246eAWXEns3wsOTKwPQvEclqjtmahtimDMlkKYhQyeiL4QRGxZHBo/RvL2xN0Fz0fkrQCE
 DxjIgrwBB+VIgf9hcy2svhcD1KOUOqPizgrPh/j/og+JxnPTNYgvNpQNVatz9Hiq/Axu6YiI4
 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
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Since
121ccedc2b migration: block incoming colo when capability is disabled

x-colo capability needs to be always enabled on the incoming side.
So migration_incoming_colo_enabled() and migrate_colo() are equivalent
with migrate_colo() being easier to reason about since it is always true
during the whole migration.

Use migrate_colo() to initialize the ram cache in the normal migration pat=
h.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/migration.c | 18 ++++++++++++++----
 migration/savevm.c    | 14 +-------------
 2 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index b103a82fc0b83009d01d238ff16c0a542d83509f..a73d842ad8b060dc84273ade36=
ef7dc8b87421f3 100644
=2D-- a/migration/migration.c
+++ b/migration/migration.c
@@ -630,10 +630,6 @@ int migration_incoming_enable_colo(Error **errp)
         return -EINVAL;
     }
=20
-    if (ram_block_discard_disable(true)) {
-        error_setg(errp, "COLO: cannot disable RAM discard");
-        return -EBUSY;
-    }
     migration_colo_enabled =3D true;
     return 0;
 }
@@ -770,6 +766,20 @@ process_incoming_migration_co(void *opaque)
=20
     assert(mis->from_src_file);
=20
+    if (migrate_colo()) {
+        if (ram_block_discard_disable(true)) {
+            error_setg(&local_err, "COLO: cannot disable RAM discard");
+            goto fail;
+        }
+
+        ret =3D colo_init_ram_cache(&local_err);
+        if (ret) {
+            error_prepend(&local_err, "failed to init colo RAM cache: %d:=
 ",
+                          ret);
+            goto fail;
+        }
+    }
+
     mis->largest_page_size =3D qemu_ram_pagesize_largest();
     postcopy_state_set(POSTCOPY_INCOMING_NONE);
     migrate_set_state(&mis->state, MIGRATION_STATUS_SETUP,
diff --git a/migration/savevm.c b/migration/savevm.c
index 3dc812a7bbb4e8f5321114c9919d4619798fed5e..0353ac2d0de819b6547a1f771e=
6a4c3b8fb1e4ef 100644
=2D-- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2407,19 +2407,7 @@ static int loadvm_process_enable_colo(MigrationInco=
mingState *mis,
                                       Error **errp)
 {
     ERRP_GUARD();
-    int ret;
-
-    ret =3D migration_incoming_enable_colo(errp);
-    if (ret < 0) {
-        return ret;
-    }
-
-    ret =3D colo_init_ram_cache(errp);
-    if (ret) {
-        error_prepend(errp, "failed to init colo RAM cache: %d: ", ret);
-        migration_incoming_disable_colo();
-    }
-    return ret;
+    return migration_incoming_enable_colo(errp);
 }
=20
 static int loadvm_postcopy_handle_switchover_start(Error **errp)

=2D-=20
2.39.5


