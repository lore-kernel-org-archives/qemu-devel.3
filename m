Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD065CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:34:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPoYT-00012L-GD; Wed, 20 May 2026 17:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoYS-000124-Fu
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:34:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoYQ-0007Bd-Mx
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:34:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779312853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JarksJJvOXkWRCIzYOKZ6st1XxnR9hO1RJWv1BwlUzo=;
 b=InKPYBwMr5m2sMmLmDgreJ9LmxEJxYXEuhfWDGe/0sCA/pAqSU2qp7nyKVCG87s2pGv3TI
 7By4FvRTTT4XS4c7kagfQT4kX4gRJEL0vYWG0BrGcs5oS8viraRav1bxy9zS4CMfMkZE21
 AhawExFcivyjWAnN1+okIbsERIFh/0w=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-1n3JhGyVOUK3xLSZ8o9hkA-1; Wed, 20 May 2026 17:34:12 -0400
X-MC-Unique: 1n3JhGyVOUK3xLSZ8o9hkA-1
X-Mimecast-MFC-AGG-ID: 1n3JhGyVOUK3xLSZ8o9hkA_1779312852
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8aca29dcd69so155641836d6.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 14:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779312852; x=1779917652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JarksJJvOXkWRCIzYOKZ6st1XxnR9hO1RJWv1BwlUzo=;
 b=NgzrCeAdocQgWfmOUfHvv+9xNXfEvPe7jLEgXshvKXfjjwZGXo9h9JpG/MssKE5Pdb
 zz2IKm4J2PCUTKDW+1uGBW4sjmqOzQhN6hHTpgn1yIXQWNWQETJG96ZX558skXxVXDTW
 4bXmRbah2kHYB6qQ3uR1q8B3cDiI44HhmSOAPB9S6hgdTJS/744Wbb77apQSRZKL/321
 TbNhfYv4ozMyfujyjMc55q2YUpBy4YNTQblMWp4ped2Lvcaxq4CBhVxiTag1QXgK14GX
 dL5Jfp0aaGoR4FpJc9Alzk8Ov2t62Ba0/ywPL1amDM618EHlONOBJmO124ZhpWm4iTBk
 ZG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779312852; x=1779917652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JarksJJvOXkWRCIzYOKZ6st1XxnR9hO1RJWv1BwlUzo=;
 b=C8hmO1kvATQdmDS/hqeEd9PrslCmrJ9QgDzuSQ7HbYsh7g44vc618Buw8rcbXKY8wo
 ddj99kg3tF+/bHaovy3Y0K3MYDEQPkJBN/4v1h6Hf3JbLuUM0C5HDHIuK89fLSpTTG7F
 gJY/I2NMWmAzoF7h9LuKo+i6PVg+sZqQggAgWOjL2wbnWVospwDzAJN+uZTZwAd5yvio
 O+IGavOvg1CpKL6sglNdw2VxghxVt+Hf00xW7/9eUEStZFvYImwLCn6jtAjyaXqqDNNW
 g7ZVGPfS12SOjhrLnyF2q8TNn4ZlsmoZLNkTNzwu9gn/Z65GV7D1qi7jBazfPidGFFSu
 E7dg==
X-Gm-Message-State: AOJu0Yw2iCr14jqE2PYS6z8EMY1PsUEoSacGkoVAYrdbhNpV9c6ki8FC
 H/f7PBTF9K5ryGGgJ9ID4CXrs5I9n/a/ZvzF2aorbrsQ28nvmqpo6+gUCRnp5iNVm+J7y3th86M
 EWPdRTqbfQxT4LHk6bpie7sGKOZ+caWL+6Z+CaZpIdLvRd8npQUWEntvECHN+CXpohJ/9zNOm8Q
 A/0aKnYP/zZA8+7X7Jn3UBEwvfwpUEwBSSsfrniw==
X-Gm-Gg: Acq92OEQWE7e9tpChfrkmUobID1zUzcSykXRrf9j3QToOguI5c9xE45lUSzyEAYzdcu
 g8xBQ4dg3vk3Pb4TFp5C4m78aZxq2a7jDOK/b4gLUamyBSgh9v8nUmlY99HmQrPqBJfLGpjNS33
 Yu/yZDCOw23MJmKtKwwjEwCcTxqwocbeFeCNNgCUUTkJi0lGcQ7hjKmK/ziLTezOePiw/jovlK2
 OttlfOl/jFJv9bcUAsK6lbJfK3hOQSMgtJviStJIk93YG3lR1D/VRcdu5vun/Uqrk7jZsjuBaBO
 +KYqg/z4eQTXAu7QtMWg4+fLgI1daKqX1Z6tyByYIE5kB/OQhxKXlzcZzn/xgWEm214zWerbg8o
 IGSYdhx5K7bfJhGL+ekfFbSAAmij3ZlXgszMGwhnSv8Mh
X-Received: by 2002:a05:6214:300f:b0:8be:35bd:8273 with SMTP id
 6a1803df08f44-8cc6e324402mr4590506d6.12.1779312851909; 
 Wed, 20 May 2026 14:34:11 -0700 (PDT)
X-Received: by 2002:a05:6214:300f:b0:8be:35bd:8273 with SMTP id
 6a1803df08f44-8cc6e324402mr4589706d6.12.1779312851148; 
 Wed, 20 May 2026 14:34:11 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca360b362fsm133062716d6.22.2026.05.20.14.34.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 14:34:08 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 03/29] migration: Fix possible division by zero on calc
 expected downtime
Date: Wed, 20 May 2026 17:33:31 -0400
Message-ID: <20260520213357.40646-4-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520213357.40646-1-peterx@redhat.com>
References: <20260520213357.40646-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

Commit dd4fe8844b changed the reporting of expected downtime behavior, so
that the value will be calculated on-demand.  One side effect on the change
is QEMU will allow the calculation to happen anytime even if there's no
transfer happening for a short while.

PeterM reported an ubsan report from clang when running migration-test with
aarch64 binary on x86_64 hosts.  I can also reproduce if I run the test
concurrently so some of the src QEMU may not get chance to push any data,
causing mbps to be 0:

../migration/migration.c:1051:12: runtime error: -nan is outside the range of representable values of type 'long'

Fix it by properly handle both Inf and Nan to return INT64_MAX.

Add a rich comment, per PeterM's suggestion.

Link: https://lore.kernel.org/r/CAFEAcA-MYH6C39xO0OLx4-M5pKurJpurwRsMqZe9q=W-NShAbw@mail.gmail.com
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Fixes: dd4fe8844b ("migration: Calculate expected downtime on demand")
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Link: https://lore.kernel.org/r/20260511182432.1333467-1-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index b6f78eb3ac..05f10e4576 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -63,6 +63,7 @@
 #include "system/dirtylimit.h"
 #include "qemu/sockets.h"
 #include "system/kvm.h"
+#include "math.h"
 
 #define NOTIFIER_ELEM_INIT(array, elem)    \
     [elem] = NOTIFIER_WITH_RETURN_LIST_INITIALIZER((array)[elem])
@@ -1044,12 +1045,29 @@ static bool migrate_show_downtime(MigrationState *s)
 /* Return expected downtime (unit: milliseconds) */
 int64_t migration_downtime_calc_expected(MigrationState *s)
 {
+    double expected_ms;
+
     if (mig_stats.dirty_sync_count <= 1) {
         return migrate_downtime_limit();
     }
 
-    return mig_stats.dirty_bytes_last_sync /
+    expected_ms = mig_stats.dirty_bytes_last_sync /
         migration_get_switchover_bw(s) * 1000;
+
+    /*
+     * If we haven't been able to transfer any data, the result here could
+     * be NaN (for 0 / 0) or infinity (something else / 0).
+     *
+     * Return INT64_MAX as our best approximation to "this will take
+     * forever to complete". If the problem is transient (e.g. we just
+     * haven't started to transfer yet) we'll recalculate to a more
+     * accurate figure later.
+     */
+    if (isnan(expected_ms) || expected_ms >= (double)INT64_MAX) {
+        return INT64_MAX;
+    }
+
+    return (int64_t) expected_ms;
 }
 
 static void populate_time_info(MigrationInfo *info, MigrationState *s)
-- 
2.53.0


