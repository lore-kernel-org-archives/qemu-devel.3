Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB347CAC5AD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 21:56:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqgAI-0006OH-MX; Tue, 17 Sep 2024 17:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqgAG-0006N9-A4
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 17:55:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqgAE-0004hO-A8
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 17:55:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726610113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uETirslRtXhm+HFuN3lM3k4dcuoD9xd+DaieOslfWmM=;
 b=NHc1jFZzMrbKJ+msjpDZEL86/AM6K+DmnxMcqWbnp4LBaltLioNWi9iO6bIRsDLUWwnxSK
 AC5KU25HATyUCXo23rhcX/qXwcTw3Dq5ht7lghU96X6YHn+35RhPK/MsUHon0BNjn+tLpE
 PutuafEvQJ+CEJznL0ddQiecBoOAjWc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-PZZ4RUiPPkGW65cRmg16Eg-1; Tue, 17 Sep 2024 17:55:12 -0400
X-MC-Unique: PZZ4RUiPPkGW65cRmg16Eg-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7a9c0f3638aso1423123185a.2
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 14:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726610111; x=1727214911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uETirslRtXhm+HFuN3lM3k4dcuoD9xd+DaieOslfWmM=;
 b=MsEtv5Ann+YgxNCdWvsOoZJUnoUuxOWnhcG867wCLAXs7zct71cx5JPM2BjrfYpXd2
 MfuS3us77au08YWdQzeHPilGrlZEFj61RIiT3AXscRJPa8IPd6IpOebmXArRQolcq2uN
 6bfu6C2Fw9ckgsv3YYBnCdYLHASoWuvZq9Iuk9MuMT/GXr0Dj1j/qkGM1WhWjdvRKRu6
 GPAVKdI6uQmkQiWtpc0H0fA+ExatRXwz6cy8yhV8fdU1r+3l7oMheUsQJ18MU2V0wipW
 dCKtpxlajVYxKjqYww7QT+yR4OdrJkATGECZTDgE/F56sffLZTpNykzOvLAYGyUHMc6u
 lprg==
X-Gm-Message-State: AOJu0YwcRjqqZUqV5miPBksnaCPXgcfosnPxZaQnL2lsOTZJFi3DVgZi
 qil4gCB2wqJE9PTXsa7o8Te7tY5rlvPbOfGjZD2Q8t4dIzCw1GfkUskF3jYr7vCzxj1WnEIFruK
 JRQ6Osq1orkqtnFDFiT5y0YjRqILWR7KE1lRIA32M/kyXyph9EXg/aEFcAf4kfDb0RYT2+iLXfe
 lIpxUqJsc5B3JUscUOS/4oN6HE9NpFwcHWsg==
X-Received: by 2002:a05:620a:1790:b0:7a9:af05:79e2 with SMTP id
 af79cd13be357-7a9e5f1b17bmr3792680285a.26.1726610111327; 
 Tue, 17 Sep 2024 14:55:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAnBASfE9SnecLi6pMoj39yG26gvDGeA9O3HMsAV4/U6AZWqqWrpefKKy+qXfgu4WqXhlGuw==
X-Received: by 2002:a05:620a:1790:b0:7a9:af05:79e2 with SMTP id
 af79cd13be357-7a9e5f1b17bmr3792676185a.26.1726610110894; 
 Tue, 17 Sep 2024 14:55:10 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ab3e97c9fasm402869685a.28.2024.09.17.14.55.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 14:55:09 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 1/6] tests/qtest/migration: Move a couple of slow tests under
 g_test_slow
Date: Tue, 17 Sep 2024 17:55:01 -0400
Message-ID: <20240917215506.472181-2-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240917215506.472181-1-peterx@redhat.com>
References: <20240917215506.472181-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The xbzrel and vcpu_dirty_limit are the two slowest tests from
migration-test. Move them under g_test_slow() to save about 40s per
run.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240911145204.17692-1-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-test.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index d6768d5d71..814ec109a6 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -3803,8 +3803,10 @@ int main(int argc, char **argv)
 
     migration_test_add("/migration/precopy/unix/plain",
                        test_precopy_unix_plain);
-    migration_test_add("/migration/precopy/unix/xbzrle",
-                       test_precopy_unix_xbzrle);
+    if (g_test_slow()) {
+        migration_test_add("/migration/precopy/unix/xbzrle",
+                           test_precopy_unix_xbzrle);
+    }
     migration_test_add("/migration/precopy/file",
                        test_precopy_file);
     migration_test_add("/migration/precopy/file/offset",
@@ -3979,7 +3981,7 @@ int main(int argc, char **argv)
     if (g_str_equal(arch, "x86_64") && has_kvm && kvm_dirty_ring_supported()) {
         migration_test_add("/migration/dirty_ring",
                            test_precopy_unix_dirty_ring);
-        if (qtest_has_machine("pc")) {
+        if (qtest_has_machine("pc") && g_test_slow()) {
             migration_test_add("/migration/vcpu_dirty_limit",
                                test_vcpu_dirty_limit);
         }
-- 
2.45.0


