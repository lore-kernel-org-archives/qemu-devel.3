Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0233EC531C9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 14:01:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wncw4-0003jy-1j; Sat, 25 Jul 2026 10:01:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wncvz-0003el-4k
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 10:00:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wncvx-00054I-T7
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 10:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784988057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sgwF7jkNJLhj6j+139aaPY14IWX2xoRAqge3G7njsEU=;
 b=XaZyYOo/g6i+grb2CSczgfC5dgP36YDMsR7iAQqASh3OdNDw2M1Tkj+Lr/aQweMnAoL7Hv
 6tz0Ft7lKHmDTdP59lp+ikFvCWz6zDRcq4jjahHUJxU56DHJWAKWEAG06AuZGV48nu8jPA
 ExQb7svlezwRxs3kk1KFoO5elB/6kJc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-37-sxELkOo0Nxm4eGyza9UWKA-1; Sat,
 25 Jul 2026 10:00:53 -0400
X-MC-Unique: sxELkOo0Nxm4eGyza9UWKA-1
X-Mimecast-MFC-AGG-ID: sxELkOo0Nxm4eGyza9UWKA_1784988051
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 60D4319560AD; Sat, 25 Jul 2026 14:00:51 +0000 (UTC)
Received: from localhost (unknown [10.44.22.7])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C102018001DA; Sat, 25 Jul 2026 14:00:49 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 25 Jul 2026 18:00:07 +0400
Subject: [PATCH 6/7] migration/multifd: fix Error leak in
 multifd_recv_terminate_threads()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260725-fix2-v1-6-5c9a6ce7b96a@redhat.com>
References: <20260725-fix2-v1-0-5c9a6ce7b96a@redhat.com>
In-Reply-To: <20260725-fix2-v1-0-5c9a6ce7b96a@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Jonathan Cameron <jic23@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Fam Zheng <fam@euphon.net>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>, 
 linux-cxl@vger.kernel.org, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=654;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=8V4SbETfqA20e58q6VCGWaqhSb6JTXgkzFqcys/62CY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZMFmNAkgl2xEbUo9EDHoKtnbnGWWKiCA9f1c7
 w/JnJfJ58CJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamTBZgAKCRDa6OEJdZac
 5QEfEACXyaWaIRPdYyDbzJF90W4hI7CRu9vhXtTaIGGqKUdpKEw1dDd+TxowUq8CqLugHr6cK3q
 +uwLO9+gCkfgquQzkACO3h8Wwp++W5hOiHyahV2wpaupJMcGtxax0YfPcwRv4D6yU7AjOggAyOg
 YSbepCIij7JVEY8iMrfWA/sPc5mBOM0xYAg1rFk6EckJi94w/AAmVxi/gMcEELYvCm9r4eQxakA
 H35K21T38uvL4CmSCr0U//Dcvojofk4oDD4hfp+/5lheKFdqHB5kp1xqnxTJaAgdjXXlg/OgYHa
 QvtUMXERNQzTLKni1pUFJ2rt00UCs3MZjroibopQ5kzmJii0v78wVUiwML3wiqnAdV4hcwe0165
 PNpUKm8kTpb9Hq7rkYJe0rbUkcuJH8eATFR7zOJUHfhWIRBrux9acLWCX6fWYHWdPg6HHQMwrAu
 Rb1g2ZUo5vHsldTRZReSywB5opuObrjrBBTPI1DjFZYO9m+L7z7+Q+JJp2St8S3S6IzTCQ8O/Js
 p9tleZPkzskXqY5eoko5AZJqhTAKIM4XTZrIXEYy4tAl1Z/p5uWzolvN5WhASqgXG3J4h/CbMmX
 BlC6MjnuqcL2393G5ry/ylUOV3O1xvMlxSS16o80yn8/2hfmPJcOLfmtDTRmw4ldy0dvQ1ORtTY
 /G2CvnqnmyOd28w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

If err != NULL, free it.

Fixes: 11dd7be57524 ("migration/multifd: Remove p->quit from recv side")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 migration/multifd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/multifd.c b/migration/multifd.c
index dbad525d2a28..503014f76ba5 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1056,6 +1056,7 @@ static void multifd_recv_terminate_threads(Error *err)
     trace_multifd_recv_terminate_threads(err != NULL);
 
     if (qatomic_xchg(&multifd_recv_state->exiting, 1)) {
+        error_free(err);
         return;
     }
 

-- 
2.55.0


