Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA80CD4F26
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 07:46:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbvpI-0002nA-M1; Tue, 23 Jun 2026 03:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wbvp8-0002Y2-4h
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:45:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wbvp3-00082V-EM
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782200728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w+Oi233XiBxp+rpO5j9u0aVn45NZSh3AuQTspxE9xl8=;
 b=Erx6E+chSzk1K89vCWcyEnGeAEiE/qX+opUNEji+Z/icC8ApXiF8Owgv+VhV3jvJM/mClo
 47JyC2S5AbUGz2x7ReAm0SkfaxrZ3S/YkfL/Wa0K1Tfhhf9JVymhKAVCykqIF8iSxJtN+k
 UjNGJoeNM7qypU+ba6jjPv3RbGRBsdU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-274-6ea64Rp0O6C9vxr2gkD27g-1; Tue,
 23 Jun 2026 03:45:25 -0400
X-MC-Unique: 6ea64Rp0O6C9vxr2gkD27g-1
X-Mimecast-MFC-AGG-ID: 6ea64Rp0O6C9vxr2gkD27g_1782200723
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BD2AA180266F; Tue, 23 Jun 2026 07:45:23 +0000 (UTC)
Received: from localhost (unknown [10.44.22.10])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2CB37195608E; Tue, 23 Jun 2026 07:45:21 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 23 Jun 2026 11:44:23 +0400
Subject: [PATCH v4 08/34] util: make notifer_remove() safer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260623-b4-ui-v4-8-4656aec3398d@redhat.com>
References: <20260623-b4-ui-v4-0-4656aec3398d@redhat.com>
In-Reply-To: <20260623-b4-ui-v4-0-4656aec3398d@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=675;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=UOpL3VWQfoL9NOG90tt8t0YDaaO8SV+WZheSRGL3tSg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqOjldnUDfhay5qYVxTKoID4KfQVnAC9Qf6MizD
 zblU2u0WzOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajo5XQAKCRDa6OEJdZac
 5RCeD/9XJgqvpJBbwo7HcLEujafVO1Zyftq0VAoTD787cYpjYgob2ZdqYKfkY7l+VCphMrSY3bO
 sPszJx2nfLmNoqgFtPMw1Xtzr73//fE+D2gHbAyOiKnebYkL2QbJxjuAnZEnzkffbYjP2bc4cxk
 /D1SY76WCCPxYeUOf4Sil7SRGiD1ysGUZraNnoZ6QtBZmNc/eRS84gyXkotrINLu8dqvYuwNOa9
 xkryqnqAtUsUmtL8LaDTs6H/zHVNBV3Iy18Xjfe4Z13aOAFK/lJFFYNf1w1pm9FGRthNDqBO3Iw
 etqXuqbQvujjYCozkPYpj05aP4qAV3/8u+9FuGvQmEsfXoRMqoMtkbVphgRPJPIAF+s3fczdATd
 oAQzPx/LhSijr05X+sS/EP+o/Y690bkOLyE3euLr3CAZ0Ewo1kJ0k5W/8vmuK3mssOrzIYI9gGd
 PiokNVSSH5jtEsr9CgIQbXw+tHRcx6+U/XufLANi06rtxEBDZeBLmMhQH9lXJWQJrh/PGyhqhbZ
 KMWhaDRhriMw3iUnCEK3W75bUe7zKyYcha0DaUkm8CAcnrdaHKnHKVeNsZaMicKK824V0H7v1Ue
 JBUpdAliN2O6KIOV/HMx20FR+m1pWDklNwOeVchJfl3hO9oR2fm8UnNNZKmBzzr20AKyb0PwoWc
 9sQ+u5n7ijTq/Kw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Allow to call multiple time notifier_remove() safely.
This shoudn't impact performance in any measurable way...

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 util/notify.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/notify.c b/util/notify.c
index c6e158ffb33..24420a7288e 100644
--- a/util/notify.c
+++ b/util/notify.c
@@ -28,7 +28,7 @@ void notifier_list_add(NotifierList *list, Notifier *notifier)
 
 void notifier_remove(Notifier *notifier)
 {
-    QLIST_REMOVE(notifier, node);
+    QLIST_SAFE_REMOVE(notifier, node);
 }
 
 void notifier_list_notify(NotifierList *list, void *data)

-- 
2.54.0


