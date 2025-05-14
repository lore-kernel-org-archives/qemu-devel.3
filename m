Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31FD9C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 11:29:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFAHJ-0001XF-CE; Wed, 14 May 2025 07:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uFAHH-0001WY-Rl
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:27:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uFAHF-0002D5-OZ
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747222076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TMK/dwdAcqCseMWCo3KAdAF6oQvlt27Nw/U0VtzB3/o=;
 b=P3p6lYPUtP6Mq/E7El5ZITjGna16OcSdrcONT7p+nL6P8p+WmbD9FImC9J4ovlSwX5Go95
 /irvMRixU8Hr9U5KaZZcuGDLJ3XA8Tqia19DySRqDkKC5Qqlddasj/8OQm6qFCG7V6nQ1v
 VoqCiWA8WEoxOelqOTdGl7JA6kUOdXY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-U1rjxvfQOaqo3hqsrQow_A-1; Wed,
 14 May 2025 07:27:55 -0400
X-MC-Unique: U1rjxvfQOaqo3hqsrQow_A-1
X-Mimecast-MFC-AGG-ID: U1rjxvfQOaqo3hqsrQow_A_1747222074
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D1A71195608D; Wed, 14 May 2025 11:27:53 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-219.str.redhat.com
 [10.33.192.219])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 38D5719560A3; Wed, 14 May 2025 11:27:52 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-stable@nongnu.org,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/13] s390x: Fix leak in machine_set_loadparm
Date: Wed, 14 May 2025 13:27:30 +0200
Message-ID: <20250514112733.456644-11-thuth@redhat.com>
In-Reply-To: <20250514112733.456644-1-thuth@redhat.com>
References: <20250514112733.456644-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Fabiano Rosas <farosas@suse.de>

ASAN spotted a leaking string in machine_set_loadparm():

Direct leak of 9 byte(s) in 1 object(s) allocated from:
    #0 0x560ffb5bb379 in malloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:69:3
    #1 0x7f1aca926518 in g_malloc ../glib/gmem.c:106
    #2 0x7f1aca94113e in g_strdup ../glib/gstrfuncs.c:364
    #3 0x560ffc8afbf9 in qobject_input_type_str ../qapi/qobject-input-visitor.c:542:12
    #4 0x560ffc8a80ff in visit_type_str ../qapi/qapi-visit-core.c:349:10
    #5 0x560ffbe6053a in machine_set_loadparm ../hw/s390x/s390-virtio-ccw.c:802:10
    #6 0x560ffc0c5e52 in object_property_set ../qom/object.c:1450:5
    #7 0x560ffc0d4175 in object_property_set_qobject ../qom/qom-qobject.c:28:10
    #8 0x560ffc0c6004 in object_property_set_str ../qom/object.c:1458:15
    #9 0x560ffbe2ae60 in update_machine_ipl_properties ../hw/s390x/ipl.c:569:9
    #10 0x560ffbe2aa65 in s390_ipl_update_diag308 ../hw/s390x/ipl.c:594:5
    #11 0x560ffbdee132 in handle_diag_308 ../target/s390x/diag.c:147:9
    #12 0x560ffbebb956 in helper_diag ../target/s390x/tcg/misc_helper.c:137:9
    #13 0x7f1a3c51c730  (/memfd:tcg-jit (deleted)+0x39730)

Cc: qemu-stable@nongnu.org
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Message-ID: <20250509174938.25935-1-farosas@suse.de>
Fixes: 1fd396e3228 ("s390x: Register TYPE_S390_CCW_MACHINE properties as class properties")
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 431d6b782a8..f69a4d8ed31 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -771,6 +771,7 @@ static void machine_set_loadparm(Object *obj, Visitor *v,
     }
 
     s390_ipl_fmt_loadparm(ms->loadparm, val, errp);
+    g_free(val);
 }
 
 static void ccw_machine_class_init(ObjectClass *oc, const void *data)
-- 
2.49.0


