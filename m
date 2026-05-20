Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C83CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPoZ3-0001W1-Kv; Wed, 20 May 2026 17:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoZ2-0001Vj-5w
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:34:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoZ0-0007LM-4S
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:34:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779312889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nqzSTOzRibhDdsnp1HWGTR+Xg0xg8YgkZnT6OTbnNts=;
 b=SEHQSt3nrN2427OJXUBxvf2qtf770LXsFdze1Wu9XgCHTfDBx165Y/JIVXlS1ozjdjl3Ly
 BAMXPqGzOdBx1Na0aqczNzTstBv0tht4qergda4dpzHit1AxKQUuSQ12mf5HHVfoA8kxGX
 64jUNNKKuYaes2jCNnPJ0u9dNsSp38A=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-N4gUBW3xM6uUG0T7MX3PvQ-1; Wed, 20 May 2026 17:34:48 -0400
X-MC-Unique: N4gUBW3xM6uUG0T7MX3PvQ-1
X-Mimecast-MFC-AGG-ID: N4gUBW3xM6uUG0T7MX3PvQ_1779312887
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8acb26fbbb2so30945196d6.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 14:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779312887; x=1779917687; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nqzSTOzRibhDdsnp1HWGTR+Xg0xg8YgkZnT6OTbnNts=;
 b=pKLJqHBaP+26UtnT+vDal8Csx4JTprLWRmeFDhFW0D+HPNSs1Hm6ggDMP49dGG/txs
 s4OVU1Ve0+h8npiA9wABT18U9wphUQh5sIf7PcfKhRpUL5AnUrKX9Iy1H0kULjkUl6dr
 BjQlhkmWLKsRds9mbtIqu4C1VGPtdkAqRYW+eFrbRFfLSf9ahhHHiij/+xDXcNUVWgnf
 c0cu+JRFX8DcSfhKtuulcvVpQuP3SE5K+xH2IXs69swyOriY1Dv466hm7YIo+nTFxCNz
 s4Yu6+6eteH318384t7iv+sRCivKEvgzaU/lcYSFQlrKtgejzXoEGlsqySO/qSR55+W/
 BDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779312887; x=1779917687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nqzSTOzRibhDdsnp1HWGTR+Xg0xg8YgkZnT6OTbnNts=;
 b=W6LgjZ57GNIHw0uY6B0nFInv32dg9kk0nwKOKScr0Q6yHqo1p/KHU+xOJljfTrooVA
 MFxNwJE7+huC0M+/nwAE1z0GOmmqmfxx0aDio1fmNWCXXr+FMWOcNMFV8WCceD0k8J0v
 KB+UVkSoaNYuUA6EoZw6dJnfegoarFDRq20XHhvcSLZjwcfg6NzH5MqxbMtaUR2oXwUV
 TGEWmKejvW+aw6caQawovn1dl3CC/Fu6LeuFTVz8XX1EHmt72INHk4m0dD0J5ZUnBpIj
 XQ3EBdD1KWV+pekBVikQS7XYsXic68lEfCKjazo4vEd0jvgZmRVFXjtxRIbWd4ZDBy2s
 LfJA==
X-Gm-Message-State: AOJu0YwuHo7wfbNlhZ58AEk2GwJ+dZNDnH5oIRB2Gozn73gzMMwu3xaq
 xYcgtcP2r/rI8u/VhJOHxmeGVjw26n7OFbETlNXRxaUnQOVHFnA/9YCgema6MuicYiWAqlH3kRh
 X9l1nvZJo34JCYR+R9d/ax3SeMVeaBrAwHHlBrj45JYfZcMoeM2zKR3vA64x9DYVW3pfQ3DFnJD
 rnozBrP3LIFIFiGL3Uxm0Kb8FYzCXzeBpyePrO0g==
X-Gm-Gg: Acq92OHYMZulESaSyaHNH1Fq9X+wg967U4LbfWVVSvuSn/b1rvHhyIgCsBMPilWUDoB
 /WVyOHISwgnk1HQ65h6UDG0mKAJRNU4gLbXOSdSoBZfDt2tDPmOdi8r47eHOIJKXo2BhjjJfRoa
 gGAdZUKR+5jFy/xGs2kIcbg8vyNJtoEjwNm1CmL5M983CBybVYwjqW0jq6wBsfF5oj7Eh6BoWbH
 KuccVDP91BjzgZHa3VxT/t6lcpVK6VYhFXB88QT/bpkeS0K2r9fsf15TgjgO+hbLvkw4HDiJleO
 KxF1vYesFhMdSpgwQT4zs9olU75Z3njIUZz8t/gwL4sOluJfIrO6QYBoXtJy4+9+DTMOOD0koN7
 lgi6Cjldp4x0vbkpPr6yJ1X/hHhSfWXR7fvJO+6e0i6E7
X-Received: by 2002:a05:6214:4286:b0:8ca:207d:50c8 with SMTP id
 6a1803df08f44-8cc6e30abf2mr4543466d6.16.1779312887422; 
 Wed, 20 May 2026 14:34:47 -0700 (PDT)
X-Received: by 2002:a05:6214:4286:b0:8ca:207d:50c8 with SMTP id
 6a1803df08f44-8cc6e30abf2mr4542616d6.16.1779312886631; 
 Wed, 20 May 2026 14:34:46 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca360b362fsm133062716d6.22.2026.05.20.14.34.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 14:34:43 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
	Peter Xu <peterx@redhat.com>
Subject: [PULL 18/29] tests/qtest/migration: Use defer for auto-converge
Date: Wed, 20 May 2026 17:33:46 -0400
Message-ID: <20260520213357.40646-19-peterx@redhat.com>
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

From: Fabiano Rosas <farosas@suse.de>

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20260505160915.25558-13-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/precopy-tests.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index 246f9fd555..bf01fde8b2 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -268,7 +268,7 @@ static void test_auto_converge(char *name, MigrateCommon *args)
     int64_t percentage;
     const int64_t init_pct = 5, inc_pct = 25, max_pct = 95;
 
-    if (migrate_start(&from, &to, uri, &args->start)) {
+    if (migrate_start(&from, &to, "defer", &args->start)) {
         return;
     }
 
@@ -284,6 +284,7 @@ static void test_auto_converge(char *name, MigrateCommon *args)
 
     wait_for_serial("src_serial");
 
+    migrate_incoming_qmp(to, uri, NULL, "{}");
     migrate_qmp(from, to, uri, NULL, "{}");
 
     /* Wait until throttling begins */
-- 
2.53.0


