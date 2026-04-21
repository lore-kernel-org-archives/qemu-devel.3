Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11EDF94CA7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 20:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFHb0-0000vL-48; Tue, 21 Apr 2026 16:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFHax-0000uO-57
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 16:21:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFHav-0008Ea-O8
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 16:21:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776802877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UOUGF+QQnpU6zuXw4cpQjrOpyCI1FWQp+UCrmmzO7fY=;
 b=gZqbwQ8fbI+QiIH6w1LaADuMx6iumg5xw5Qxi8gJeTF5yP0qHsmjp70WlQ8Snt9H3gcgq4
 kqTM0MucCqSJToapQPEa6bo2ZAtvPumyckisRn2abk+YtPrp/PobhmiKMF6nGFaw5D4s4y
 AgkZTnK33EHv7YW4K5I20u1K3hAShj4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-rMp3wfI4OUGSJi_-dTljew-1; Tue, 21 Apr 2026 16:21:15 -0400
X-MC-Unique: rMp3wfI4OUGSJi_-dTljew-1
X-Mimecast-MFC-AGG-ID: rMp3wfI4OUGSJi_-dTljew_1776802875
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b220c72bbso121111691cf.1
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 13:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776802875; x=1777407675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UOUGF+QQnpU6zuXw4cpQjrOpyCI1FWQp+UCrmmzO7fY=;
 b=frH0k11zEaHOarOqx173vSfbXFoPPjx7bQ0skYN/DhlsUmNUKkx5mKEy5ZcZ6ZOkfp
 ydGH0ZvSLuGV9TB8k8h8Xe83A53IsPYZXYVUi3vj3jadZleRlXuSwxKVyiK/OBhQQI8/
 425k4ztIx94HXm3ytFPQkgwZPhCrgpjldIYGpFkiFO+N0WL7LDDaeiopFgG2Enw8PRdN
 j4mEogzENc14EskHcf2KyLoScvt2DjzAv9dBWWiNuqudXn/WwMG+YY6kL7qF7vVBJQGD
 5SXGTYMLiGI4kNgKrOgdDEHUb0K3b4fzpdkEvraysM7qbWFMKia7NC7VXyXUEPFU3PFj
 Z00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776802875; x=1777407675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UOUGF+QQnpU6zuXw4cpQjrOpyCI1FWQp+UCrmmzO7fY=;
 b=gH9pWq6bq/ufaEbln7S2XdNYisELDSbwxR1zFe9NYVQnCXpR+xBJYKbwzW1xmb3Ci6
 g1AD5BWqnHyqqe/vLQX8rFrrcIGYmn6qkJ58xTfcvZ6tKiks/spJC7vRNpGw3LqlNJEG
 trnff06qKL6MAKPtGbIgNysYcY2CWqIynduMrsYR5q/fewFgJ2bFY1nW24tBnQEUdG9v
 vTQM2of3qxjug3wickDP/dXJYMjrfcLopbfkSD3JKy/ysX3sdeSzsWewZ6i4HTOBqA30
 1GvIp4WUX5gTksjmLawoNXimEjy8jRr2qp+xkc5IFWeLJuJnREc503CfhP0oHmrVTrp7
 9XFw==
X-Gm-Message-State: AOJu0YwzI4ht9lQlCtrno/8g0JWMEQfcrTlJ93aOjLS3OwxPnUUyF56Z
 TNtGLcfbwPPif2EgI0T2mQJGxUqAHkf/sJo+ueZ0QEKbPl/du9FQYwOgtij+yPZjv8RVq4Gf0qC
 w3GxA2QfEHtcAUxImE3trEjHxwckaJY4P0+9n0WZywzJ0PjmYCJdAtLB5xaClMa7o0NUDxjDyBW
 dB0BLYv+LJIrr/8PbqS4jlG4Fh5MzoX3qAxRfm1g==
X-Gm-Gg: AeBDieuZSZSH6VE+zYBlgHOeIQO5VdfPZ0Fo6WBH0Zg5Ed6fJFyCtcH7pnCcCd+dOku
 0hnIRS3h14nkvOWfloToC4ZTjEwfCuOOKXODzKOf/Dl5lntdmMaRCaK9O9q4WWtqncPH7lW7BTY
 z+a4jMyRHA1LlwBkDDzjZsQjbd+L3q8TTDCQ+pwwPes6vMKpA5shaZRiDLh4Jx4hpJB5BKpuuj4
 wKw0IRUjyLh+qSowvaHzAB4aGdTNaWtjlrGddDEp9fDF+en1tLArfO8caB++NHY7HxRgNhemF7e
 MZpWYUfAeQX9d1DinNnUQQ57l0srBoMFpw3eBBIodHlHRbFnQc+NVtBzdrua5YhqH7yzvHG+jT6
 c0+Cq+oWR7Y+2XFrkPj9Jjt9Gz16ovIkmYhT/49krcY85QX1dWRiq2GC/Pg==
X-Received: by 2002:a05:622a:1e12:b0:509:4198:5468 with SMTP id
 d75a77b69052e-50e36823a7dmr302362301cf.8.1776802875047; 
 Tue, 21 Apr 2026 13:21:15 -0700 (PDT)
X-Received: by 2002:a05:622a:1e12:b0:509:4198:5468 with SMTP id
 d75a77b69052e-50e36823a7dmr302361691cf.8.1776802874558; 
 Tue, 21 Apr 2026 13:21:14 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ae5c26csm114343556d6.31.2026.04.21.13.21.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 13:21:13 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 Zhiyi Guo <zhguo@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Juraj Marcin <jmarcin@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH v2 01/16] qemu-iotests: Add query-migrate test for dirty-bitmap
Date: Tue, 21 Apr 2026 16:20:55 -0400
Message-ID: <20260421202110.306051-2-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421202110.306051-1-peterx@redhat.com>
References: <20260421202110.306051-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This helps me to identify a hang issue with some recent change in
migration.  Add this into the test suite.

Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Eric Blake <eblake@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test b/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
index c519e6db8c..67d69d9d1e 100755
--- a/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
+++ b/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
@@ -162,8 +162,14 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
 
         self.vm_a.cmd('migrate', uri='exec:cat>' + fifo)
 
+        # Verify query-migrate working with dirty-bitmaps in precopy mode
+        self.vm_a.qmp('query-migrate')
+
         self.vm_a.cmd('migrate-start-postcopy')
 
+        # Verify query-migrate working with dirty-bitmaps in postcopy mode
+        self.vm_a.qmp('query-migrate')
+
         event_resume = self.vm_b.event_wait('RESUME')
         self.vm_b_events.append(event_resume)
         return (event_resume, discards1_sha256, all_discards_sha256)
-- 
2.53.0


