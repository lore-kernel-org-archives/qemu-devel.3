Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B275CD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:42:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZE6p-0003mT-PX; Mon, 15 Jun 2026 16:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE6o-0003fz-NK
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:40:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE6n-0002z1-6V
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781556036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VDdHV+u5xVOm5TX5OuF03EeIEtdxGVK2RRenyTDI5LA=;
 b=V90nJRy9b3XFAKz+/Z1htzze1an2167w7AVMP9x6cVsxYQmDoeaZ/OGk6G8Mv0326pLoXq
 S720fw+Y34dfUnOqCO3GRmaz1em4588keJnMAfWSsm6hD/3E/zYy8IIaHfEQHfkQ1fPray
 HCFRqwCAksd4fX4GIgSVJKLaQUTZorw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-jiPscIUcOdyQYCM7YZNKhA-1; Mon,
 15 Jun 2026 16:40:33 -0400
X-MC-Unique: jiPscIUcOdyQYCM7YZNKhA-1
X-Mimecast-MFC-AGG-ID: jiPscIUcOdyQYCM7YZNKhA_1781556032
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8399719540C8; Mon, 15 Jun 2026 20:40:32 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 35105175F; Mon, 15 Jun 2026 20:40:30 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 16 Jun 2026 00:37:58 +0400
Subject: [PATCH v2 32/53] i386/cpu: convert strList property to QAPI-aware
 registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260616-qom-qapi-v2-32-cc9396b9c18c@redhat.com>
References: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
In-Reply-To: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=853;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=pRtghQRGIgiJRIEH4EbO7vUwTGl/maCWO7Fl2qaxKGo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMGKPFZpnkh0CneUTj3gPQ33HKKYd0SU6vhBwE
 kkeIIzRxBGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajBijwAKCRDa6OEJdZac
 5RJ4D/9rXM1D7Cpw2A0icaUPtsHmWGBDuXXftAZWgcZp3YDU+PY4UK6lbrTibGmFwoqyxrYC+6A
 rB5INdgWtTn1kkwkK23gGSZBqBUFmPqaA2kPdwIJ084DqV/R+JUt++z8ad+NrEeX+9dqzuioquz
 XpuS+gLBVBjteWjMgIl2dyXhr3J1dO2Xpv1swZeuCgxg4pRaaB8udFWohNbHf2AF2/IDfHWLahq
 8dhhtr/3kRzAvJXFbBDeQQeF7I8WpydGeVk0RzX0HgeKoKImiZldHPnmL38R1Xfez+P3v4p4VOP
 Fwncsf4XRfywnt7WYjfOsdBk51M0DYl2lw6z3XoXeE6mJUnTzgzSxROfsmxnT8bP7D5uyJxZbw6
 O90AdUXvVBPS/s6tKNmQaSTJpSy8m2cyKZFwe5fbmU7Qx5pUPpsjb5lEWUzTcj1mY1iDpJPQ4K3
 AdFmtcIuUvDzy6/wQ3EVHz7Pxc5mjLlOCwHKHK5fgJvWWDpvJM9jr8E8uBFKBKRk9kloScoxBJV
 1pF4Wrz6C0cYbJNA1iBeLYEieor7q5EaNcV/Bg79hQ0hX1/OIW7p1Yk857y/Wtm24D4Pnh4Ltws
 6YVBt2tLEfyXSEAjdwrqXh3V1h9BADUrVGnItK+Ki8qfS/GxsAKtaTQRW9LSOWcr0fg+stQg0xk
 G/uAxxA+3warXtQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/i386/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 58c78a8c607..7a3ca9af02b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10963,7 +10963,8 @@ static void x86_cpu_common_class_init(ObjectClass *oc, const void *data)
      * QMP command: they list the features that would have prevented the
      * CPU from running if the "enforce" flag was set.
      */
-    object_class_property_add(oc, "unavailable-features", "strList",
+    object_class_property_add_qapi(oc, "unavailable-features",
+                              &strList_type_info,
                               x86_cpu_get_unavailable_features,
                               NULL, NULL, NULL);
 

-- 
2.54.0


