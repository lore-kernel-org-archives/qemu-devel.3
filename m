Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B0EC79FA0
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:16:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3ZBf-00059K-CF; Mon, 07 Sep 2026 09:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3ZBS-0004oj-4l
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:14:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3ZBN-0006bm-Le
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:14:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788786884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vLNU8deII2YV/Np0anR9mXTsHZWaHsyFpOSn0YczNCY=;
 b=JDTCQ2NTX9fQ4OWTmEKP2lAmlZUB8qcwcMWd6eX8i2gKTpEcTCABT2naIJ9OUvXFy7/4Bi
 arwx4NS/SvFnrze2VohK/Gf6H2zoAh5IGja5cGggf+eZLnfsFyrURCd4rbdYw6CxTuTNR1
 eshsc5NyJeQutLJh6W2o0Moq+rjq3Tg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-348-bQCOLrmBPAmEUJ9UsJydQg-1; Mon,
 07 Sep 2026 09:14:39 -0400
X-MC-Unique: bQCOLrmBPAmEUJ9UsJydQg-1
X-Mimecast-MFC-AGG-ID: bQCOLrmBPAmEUJ9UsJydQg_1788786877
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A46C1954AE0; Mon,  7 Sep 2026 13:14:37 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5E5F91956044; Mon,  7 Sep 2026 13:14:36 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 07 Sep 2026 17:14:03 +0400
Subject: [PATCH v3 9/9] qtest: compile out HMP helper when !CONFIG_HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260907-nohmp-v3-9-c11e7d0d3d7d@redhat.com>
References: <20260907-nohmp-v3-0-c11e7d0d3d7d@redhat.com>
In-Reply-To: <20260907-nohmp-v3-0-c11e7d0d3d7d@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, qemu-arm@nongnu.org, 
 Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1572;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Xa0/LC6u8sESL2zvgI9W3vBYiovc4bTzR3MiwSE4zLE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnriYFdxCxVJrms6n297kkOV79mUx0r1631Aqu
 gJGPXXGZQqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap64mAAKCRDa6OEJdZac
 5QifD/4uBSsWz1T/mipf8zo+3g7fr6YcKTvyaJsKNFLIJ+SeeAMoSDnSi0fBw1THJfmlTZrWbJ8
 fVNn4Xkp9dj7hxJFAK5LHWFH21F19PqcCtn9/T4JzO0WoD1ypeJOUaFwdabKaZp+JK2srSA4Ljq
 tb2djvvuw5/FsN+ENFUr27hbDVpFlUpxuXJwMK1qmPoAofh3adzdgwmTzxUmgqvczKm0o/s8fVy
 e7/IT8faGw1aDKOTg4nR13gxAtfkop2bm58mi6SAiog2rVtW9fdcTkBM1OpgIAJg6qXlruHAy+2
 RhlfJFGCInFs1VTolRYicgyywI/mW702OL1oLT0mgIyvwdh/75GOqAWNqaLmuZV0+WKR0qqrwJy
 +7FsCpnBjLzdbXhDwj/P2iHtA9fU+S3euozFgJwCW/ZLj/qdtWev56RXFHsWxnvKFvwU+vWMNMv
 oAI8FepNXZzpgBvZ1i9hwWXV6F/GPVemesJOVHEw44YRbir7DLR7J2yjgd/7XRaJCeh46FTl6p+
 9YIV/Ql4/eYlvNzMT5Y14y3BTbabToVI8ifwdFX2awWHqdXuWL7uDYuxiqbBPgKagxXDH1+5TRi
 uP/z0dXuk6jsBbfglpR2VY9j5cT5bdbT/lDl1yzAseWOe+Ow+X6EUoJf2MAWJJKH4Sgd5c+wpa2
 /dTrCKfmR0S3itQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

This should help prevent introducing HMP tests inadvertently.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/libqtest.c | 2 ++
 tests/qtest/libqtest.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 370f79a3b6fb..05d884761540 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -1021,6 +1021,7 @@ void qtest_qmp_job_wait(QTestState *s, const char *job_id)
     qobject_unref(response);
 }
 
+#ifdef CONFIG_HMP
 char *qtest_vhmp(QTestState *s, const char *fmt, va_list ap)
 {
     char *cmd;
@@ -1048,6 +1049,7 @@ char *qtest_hmp(QTestState *s, const char *fmt, ...)
     va_end(ap);
     return ret;
 }
+#endif
 
 void qtest_qemu_io(QTestState *s, const char *device,
                    const char *fmt, ...)
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index f06e061d214b..20982d3fe8dd 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -409,6 +409,7 @@ QDict *qtest_qmp_event_ref(QTestState *s, const char *event);
  */
 void qtest_qmp_job_wait(QTestState *s, const char *job_id);
 
+#ifdef CONFIG_HMP
 /**
  * qtest_hmp:
  * @s: #QTestState instance to operate on.
@@ -434,6 +435,7 @@ char *qtest_hmp(QTestState *s, const char *fmt, ...) G_GNUC_PRINTF(2, 3);
  */
 char *qtest_vhmp(QTestState *s, const char *fmt, va_list ap)
     G_GNUC_PRINTF(2, 0);
+#endif
 
 /**
  * qtest_qemu_io:

-- 
2.55.0.543.g5ebe2ebe4ea8


