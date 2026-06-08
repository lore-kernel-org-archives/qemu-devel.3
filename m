Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D46CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:17:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWUEb-0007Zl-Ev; Mon, 08 Jun 2026 03:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUEa-0007Zb-LR
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:17:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUEW-0008Ko-3q
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:17:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780903035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G5SzvzpXGBk9fZpb0FRhhyEQyeRaoQnIRBj/ot4ruJI=;
 b=KghYeVMBsIAcxoC4fpDF3DZr8zAlzhYtr/m9NKrOkWNo9w40hsWllLRgUXAomH+0DSTnye
 sEtl2O2GyPqVwbOLG/GverhmbK+Mv+frge1u4h73f2BmvJuTcSvEY1yIMKILnHVgyXNYVM
 MPmrYihmi54/9Wzl2jOJ117kdqRnlY8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-ZIZyOojlOASGOtK0OiVeMQ-1; Mon,
 08 Jun 2026 03:17:12 -0400
X-MC-Unique: ZIZyOojlOASGOtK0OiVeMQ-1
X-Mimecast-MFC-AGG-ID: ZIZyOojlOASGOtK0OiVeMQ_1780903031
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A1A31955E94; Mon,  8 Jun 2026 07:17:00 +0000 (UTC)
Received: from localhost (unknown [10.44.22.16])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EB559180049F; Mon,  8 Jun 2026 07:16:58 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 08 Jun 2026 11:16:22 +0400
Subject: [PATCH v2 04/33] scripts/lsan_suppressions: suppress fontconfig leaks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260608-b4-ui-v2-4-9ea6355ea08f@redhat.com>
References: <20260608-b4-ui-v2-0-9ea6355ea08f@redhat.com>
In-Reply-To: <20260608-b4-ui-v2-0-9ea6355ea08f@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=842;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=3FLGohYn6yxaHskRhEfW2sASVFQSoADTVQldsLNnhHQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqJmxIsmyj4dpHC8QwMKXSF8wcic02Pz4GZjHK8
 vX1cbBD8paJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiZsSAAKCRDa6OEJdZac
 5espEACe7yPFCosPWFi2BoI0CKpg2PvWwxrYPKDEZxGhR5TyWPG9oFepCaedzZbNlaTlKswRnnJ
 SKlqtxlKuVc20cxK3L/o+RRr+5neWUboeYelKEMrIZ2qJOJiX6F1cIoCpwYsL8sGEc15Rwfesx5
 po+4iFSYfBts0fEZ034kvDfDy7rvDpXwy4lLfV1Zn89luVLgsnZzHI18CPwWxyC8q2H9Rn6JsES
 G7noCyXESeOcBDZE93/RCY+MlzISqfvRxwzIXfJY4uDsokvryeDnegwGU67ltsppa62gYet7e5V
 zaVgtXyxP/9527+ohyZtXez1Fo8nP1IrBV66Nfp3DiSXzlZ2QOM5oB7389TziMYX8pY6a2IaIVK
 b4t9KLr26isnhafS3tBPEintHeInNAC8JRs1DCFfIoPkTDgy69xiZNsVDZJNlymJnAxTR2AIvYB
 SARmO3wUrSAXZBMtBLpQMSJCqQ3EAaDjCuaNVlgPwTszs6+ui3TGl+iIxLQ/KnZN8NENDWQOTsb
 d1yXZhTM/Df9AWvvKOWkO9ot3xuU+4tylyksTKrp6BCn3+l0wKhYXYDPGos/LA0o2DQGVJkNlRM
 GcNCnOKGwU0olFekExFphHog/N2GwOD/7m7XgQK85Y3g2BI3VSbOX1Wz+lXlWL4tgGSUrjNdA35
 V0eHlgFrMWmZWEg==
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

Those are annoying reports for gtk/sdl etc.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 scripts/lsan_suppressions.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/lsan_suppressions.txt b/scripts/lsan_suppressions.txt
index 30256bc6d01..f3b827facff 100644
--- a/scripts/lsan_suppressions.txt
+++ b/scripts/lsan_suppressions.txt
@@ -10,6 +10,10 @@ leak:/lib64/libtcmalloc_minimal.so.4
 # libxkbcommon also leaks in qemu-keymap
 leak:/lib64/libxkbcommon.so.0
 
+# libfontconfig leaks are notorious, for ex
+# https://gitlab.freedesktop.org/fontconfig/fontconfig/-/work_items/519
+leak:libfontconfig.so
+
 # g_set_user_dirs() deliberately leaks the previous cached g_get_user_*
 # values. This is documented in upstream glib's valgrind-format
 # suppression file:

-- 
2.54.0


