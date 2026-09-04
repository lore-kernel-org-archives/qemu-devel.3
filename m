Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1610C624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2a5W-0003nP-ED; Fri, 04 Sep 2026 16:00:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a5J-0003AT-ML
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:00:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a5I-0008H8-8Z
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788552022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LxoEY/uHRXi4qMzgkcEFrcFfNXHjpLx0KFyuPTVlyBE=;
 b=cR7Yh95j4M3paWPSHFU5uhkH3dRrowu4dPZDIB6zlXutfICrGwXsg8IHlwmOuwqpjqygSG
 MovXxw2xip9j+eD6oA9vBdcm5bbXcAOsPwGpnpd+X+hDLEfKNokn+4jGs9q910kZlew7w3
 dI0EFxh7ylzZw1C7QdiVjfw0eBJkc3Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592--MbMRRKTPharnmlF8vLWzg-1; Fri,
 04 Sep 2026 16:00:18 -0400
X-MC-Unique: -MbMRRKTPharnmlF8vLWzg-1
X-Mimecast-MFC-AGG-ID: -MbMRRKTPharnmlF8vLWzg_1788552017
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B4D918E9B2C; Fri,  4 Sep 2026 20:00:17 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BB9ED30002F4; Fri,  4 Sep 2026 20:00:15 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 23:58:18 +0400
Subject: [PATCH v4 35/75] block/throttle-groups: fix throttle properties
 typename
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-qom-qapi-v4-35-a985f168e938@redhat.com>
References: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
In-Reply-To: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
 Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1072;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=yr36TEgtI5Y04PbneexOLq85ZeIO8zZMxEncXro3aZg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmyLKUzf8oGlv5kVVnrA5VQ5TSbVydjZXqId8G
 RM49msRNHeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapsiygAKCRDa6OEJdZac
 5Z1CD/4ld6pKbspfB7P0DJRQvtCuyymJ0VBfEedqin/gSoQcNC9kaxsScxgwrBLHXPABxS77Dsc
 qkf5H13k40tmFL0X3UNO/R+UGYpvC1c7SVFjnG41aBTFdm0rDFauFghv+2nP78eHGoeICk81k/e
 R9iJ9fzfpgJ9oVWSBvEBrcLjPD7luPCB3SaK8ht+6sFNwZ/zDYKZpyEdNekdjyp9SM87AUxwvH5
 G127jaiYrt1+46gAVRHIWBp8XnhD+o/r6DC658fSIQR3vwsjy9oQOFz+liBOc89oSa1bn6Un5ZG
 kxPhDbK4kwx86lFWcEGLEuIjDMfEaiKTCh80ENNO+t6cUB419LRG3FhzXNU5LT7ifrel5a+uoL+
 v4hnjg4B6RzaQgtjUOiWyddktVOpPW4XVTEAeWU64Fl/2tUVuAHcLVaq/ZoDeGAPsnDY3xqROmU
 eSe1FSASI7wLQyq5Ez8Wsi2dD4pib+aXlAdhtXYSSkYl7n2W2snkRLtb9i8cYtbxU3uB+VGARyX
 DqdYDh16eLkCWvRxc4HW+rQ0Q1H9lX2TTU0Y+dTIagEazsVNScKoViPkYuHisOG/I5R5LoJu9/s
 Jh80WMXhV9jwzyAsUnqQ1E5e3P2pPwvFmAWUYs+BkhBLhMnzS8OJ29Kj/K/2RMeG8YWu1A4WXY8
 7yJ1luJ/K/zAYEQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The getter and setter use visit_type_int64, not visit_type_int.

Fixes: 432d889e55e2 ("block: convert ThrottleGroup to object with QOM")
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 block/throttle-groups.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index a9d3aea3b54e..6312157802da 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -985,7 +985,7 @@ static void throttle_group_obj_class_init(ObjectClass *klass,
     for (i = 0; i < sizeof(properties) / sizeof(ThrottleParamInfo); i++) {
         object_class_property_add(klass,
                                   properties[i].name,
-                                  "int",
+                                  "int64",
                                   throttle_group_get,
                                   throttle_group_set,
                                   NULL, &properties[i]);

-- 
2.55.0.543.g5ebe2ebe4ea8


