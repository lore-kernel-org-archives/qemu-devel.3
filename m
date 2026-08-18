Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C5AC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:21:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwHsn-0000T2-GD; Tue, 18 Aug 2026 07:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHsm-0000Rj-70
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:21:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHsk-0006tI-T1
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:21:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787052086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=52B+cezrQHzT0zd35ucqxSU8iLa7FBbZbRVCJ0ZJ2ig=;
 b=CFIKMG5KWMDkSFgi4v5mo3pBlYGKIje86GT4PMS+6e/Z0EzidiYc66uvGw+dWIJ4GKKxNe
 Xm7Q20hP95THxlG+EfwFqalDweHvmt5yKP4xeqifUuQb2jCfL7Z1lj0aeXwEimHGBtzFzE
 5JV6NPE9TB40qPyockwzVkyjpLyO9sM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-uzK2xJKUOom0G9WtHCffoA-1; Tue,
 18 Aug 2026 07:21:22 -0400
X-MC-Unique: uzK2xJKUOom0G9WtHCffoA-1
X-Mimecast-MFC-AGG-ID: uzK2xJKUOom0G9WtHCffoA_1787052081
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B1AAB1956088; Tue, 18 Aug 2026 11:21:21 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A24FE1800346; Tue, 18 Aug 2026 11:21:18 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 15:11:03 +0400
Subject: [PATCH v3 36/74] iothread: fix poll properties typename
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-qom-qapi-v3-36-24b8bbbe3d86@redhat.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
In-Reply-To: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1792;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=yUhjsAWjAjI4UlFAo1X5XNJdCst9OFyK65nGBG7/6jU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhD26NIta3Uq7OL25Ayo6C8UwGyH2ojOi7AgFH
 qYPeUZ3us2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoQ9ugAKCRDa6OEJdZac
 5YXWD/oDSq8Aw08vOn5JX/33YY7IO6wXjo9g1xV8VaAvhVK0iHKK1FzkoleSrCqMyoV3ykUpaYz
 cpbJu56nLVTej32NeEoVot+1+Kt4O0B/ARNl7Rge6QtNEYB9Q4Kzsdd+07NGZXXB02rQjA/V9g9
 8r4ONuLRLl+lLLUnBCMIgnQq4PlyouWmJnVe2MQvBBlRblZkmgRum6C8cSvARFFOP3MgyuewCHW
 0c3OpZU+pdQ0tBTCTvCxM3eZOM4t/+SLCsdRSwvEBr4oy8UTHHybMIocAVxyxip5hCZODAMXY3u
 XsFA+xu3FN1nAaIsjONC5dvlka3vSM7UZIkaZtdu2lF1j6SuSXqaeNxiG3MmvIBxwKkmXdsUZ6W
 vF2WcBjQiJ0cH68URcznsmPB3EShf1RzqhaqSfVEM6HSQFM2nKaNDOYkOPceLeAAtro+98r42Jv
 fhhYPDhyCC1IUXgXf14p0nnFNcKnPcHZzZBKbIJeGBT0/9d8g65nN4jEWB/3mF+sRs2eN34Ju38
 Xx+YDsKtoKhL1BbrJsdFLzpD1D00krunJYfHussnhxIlQ56dxk7YhLP6tbsEKFPkVKiyGIwevJt
 S8MoOxKV0aI6KwZEc5Bnsju3h3CkWqirtl3o4YxqhklRCUyvXO8dwGdB0RbyTfnsNYDDBRIg5Cj
 hWEq0F4iY/Ojmeg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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

The getter and setter use visit_type_int64, not visit_type_int.

Fixes: 0d9d86fb4df4 ("iothread: add polling parameters")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 iothread.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/iothread.c b/iothread.c
index 3558535b40f5..76eea6df3861 100644
--- a/iothread.c
+++ b/iothread.c
@@ -315,19 +315,19 @@ static void iothread_class_init(ObjectClass *klass, const void *class_data)
     bc->init = iothread_init;
     bc->update_params = iothread_set_aio_context_params;
 
-    object_class_property_add(klass, "poll-max-ns", "int",
+    object_class_property_add(klass, "poll-max-ns", "int64",
                               iothread_get_poll_param,
                               iothread_set_poll_param,
                               NULL, &poll_max_ns_info);
-    object_class_property_add(klass, "poll-grow", "int",
+    object_class_property_add(klass, "poll-grow", "int64",
                               iothread_get_poll_param,
                               iothread_set_poll_param,
                               NULL, &poll_grow_info);
-    object_class_property_add(klass, "poll-shrink", "int",
+    object_class_property_add(klass, "poll-shrink", "int64",
                               iothread_get_poll_param,
                               iothread_set_poll_param,
                               NULL, &poll_shrink_info);
-    object_class_property_add(klass, "poll-weight", "int",
+    object_class_property_add(klass, "poll-weight", "int64",
                               iothread_get_poll_param,
                               iothread_set_poll_param,
                               NULL, &poll_weight_info);

-- 
2.55.0.543.g5ebe2ebe4ea8


