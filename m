Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B9E5C3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 21:51:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uExWs-0000KS-T4; Tue, 13 May 2025 17:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uExWp-0000F2-HX
 for qemu-devel@nongnu.org; Tue, 13 May 2025 17:51:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uExWj-0004NA-JI
 for qemu-devel@nongnu.org; Tue, 13 May 2025 17:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747173064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TpqkEldXSwd+AgCYvr0r/GGU1qK+OxBHgrOzBpHO1og=;
 b=Vsodacmb1AaVCEXDJczBydBbo7mVPwduZn86L1g/rZH+RzK5V5kc6TDwL/EayLUOLcSCYk
 rOIddFRS3fi5wRZUvGc1/rhDNZfWFCD4iFfsgCGbTNQQNr9wdRLepPq0ln4Bk5ANkIOYbB
 ZVWM1dL5PURGECQwM0KOiLYAaXFOkV8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-JXK0E-b4OS6Wk6iWCmCAyg-1; Tue, 13 May 2025 17:51:03 -0400
X-MC-Unique: JXK0E-b4OS6Wk6iWCmCAyg-1
X-Mimecast-MFC-AGG-ID: JXK0E-b4OS6Wk6iWCmCAyg_1747173062
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7c53e316734so1049228085a.2
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 14:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747173062; x=1747777862;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TpqkEldXSwd+AgCYvr0r/GGU1qK+OxBHgrOzBpHO1og=;
 b=QcnvoOWkprwSXksqAmkE9b+B96bFfw3xslbUAzmTfNdoAYSSolqKIJ9u7EjFTUl5KE
 ghXmYWrRkI4Y+HVku/RYBhcmIohurU2AVpi3f6fkM0SvVvVquTMD+C81i2YYrPMl1Igi
 7Xh4wzvKt9Ch15V4CzqFtugo4R+URFwX1/6lLXfIkp0EGUETxJJI0TwHWizPF77uPLPR
 pDSXM7xQoxK2EF540vwPKO+hOkdaFhwqr4oZLJBPM5Rf16xlMjrQ+fV+dI7F++PDlglc
 +xTGyqM4FGBx6JOsEEMs9OCGNsoE6/zHENSKPE8Uz/oAIaMrIwmmlF8dZL6dXfswD/ff
 Dn6g==
X-Gm-Message-State: AOJu0YyegEZrwapS1AOhozGS81CmimSwGLhOmXaWqVNZ0TqC7s0Wga3m
 tOFUqupPu3lK0aIJtPpnqkN5actVNMk8KC8jshsWkqCGz4NEvkU4h88YFzb7F1QIAJNsFIdt2eb
 5K+v+ChgMOMxAlZB20Jvfm06gkQitpQkapbe1TTGZF85NBbxP66zJ
X-Gm-Gg: ASbGncucmlMNaPn5BWqWbNXDNlf550maBWV0+d9LhI51D68X9y8hRolL2WIYhuJzSqe
 WTiV3W4p8fqRcgBvR3BAXlA8CnnZ5ZGQtZODhjA9cDG4CstfwC2MKDl3yr26Jj4Mpq3BZTPCgu3
 RfBjWdoNNP8TU2WG27dMmHVOOwbMWzePXvafWkUXq12eEHKh7OJ9M9PybP88RJ8pf0Zg/rwLT7x
 33+GmscQ/VR9lD/cGa1a6EhHNM4r6cX7NTLamTbTlRGXMcUPhnUrPfbwe8uIjXlcfp3zEsCk4v3
 DGw=
X-Received: by 2002:a05:620a:294a:b0:7c7:a62f:341b with SMTP id
 af79cd13be357-7cd287c4939mr180962385a.8.1747173062388; 
 Tue, 13 May 2025 14:51:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFQNkv3Z1LoUaqgCcZLh0092YmZA7POx2jGXprhJVsqfcFKPh9fkSdjS92aT7SjZ4wZxC6vQ==
X-Received: by 2002:a05:620a:294a:b0:7c7:a62f:341b with SMTP id
 af79cd13be357-7cd287c4939mr180959985a.8.1747173062064; 
 Tue, 13 May 2025 14:51:02 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd00fe77c6sm753615085a.108.2025.05.13.14.51.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 14:51:01 -0700 (PDT)
Date: Tue, 13 May 2025 17:50:58 -0400
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v11 0/3] Allow to enable multifd and postcopy migration
 together
Message-ID: <aCO-wlBjV8E8DCdn@x1.local>
References: <20250512125124.147064-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250512125124.147064-1-ppandit@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, May 12, 2025 at 06:21:21PM +0530, Prasad Pandit wrote:
> From: Prasad Pandit <pjp@fedoraproject.org>
> 
>  Hello,
> 
> * This series (v11) fixes spelling and capitalisations glitches and
>   does some refactoring and reordering changes as suggested in the
>   review of v10.
> ===
> 67/67 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test                 OK             196.69s   81 subtests passed
> ===

I queued it with some renames in the last test file, the fixup attached,
please let me know if anyone sees any issues.

In general, I put all the new tests under /migration/multifd+postcopy/,
rather than using different path.

Thanks,

===8<===

From 89c22f1c5fbb4afdf5bf3f3b0ef2dae162094488 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Tue, 13 May 2025 17:46:24 -0400
Subject: [PATCH] fixup! tests/qtest/migration: add postcopy tests with multifd

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/postcopy-tests.c | 4 ++--
 tests/qtest/migration/tls-tests.c      | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/migration/postcopy-tests.c b/tests/qtest/migration/postcopy-tests.c
index eb637f94f7..3773525843 100644
--- a/tests/qtest/migration/postcopy-tests.c
+++ b/tests/qtest/migration/postcopy-tests.c
@@ -137,9 +137,9 @@ void migration_test_add_postcopy(MigrationTestEnv *env)
             "/migration/postcopy/recovery/double-failures/reconnect",
             test_postcopy_recovery_fail_reconnect);
 
-        migration_test_add("/migration/postcopy/multifd/plain",
+        migration_test_add("/migration/multifd+postcopy/plain",
                            test_multifd_postcopy);
-        migration_test_add("/migration/postcopy/multifd/preempt/plain",
+        migration_test_add("/migration/multifd+postcopy/preempt/plain",
                            test_multifd_postcopy_preempt);
         if (env->is_x86) {
             migration_test_add("/migration/postcopy/suspend",
diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index 50a07a1c0f..46b48ef78c 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -816,9 +816,9 @@ void migration_test_add_tls(MigrationTestEnv *env)
                            test_postcopy_preempt_tls_psk);
         migration_test_add("/migration/postcopy/preempt/recovery/tls/psk",
                            test_postcopy_preempt_all);
-        migration_test_add("/migration/postcopy/multifd/recovery/tls/psk",
+        migration_test_add("/migration/multifd+postcopy/recovery/tls/psk",
                            test_multifd_postcopy_recovery_tls_psk);
-        migration_test_add("/migration/postcopy/multifd/preempt/recovery/tls/psk",
+        migration_test_add("/migration/multifd+postcopy/preempt/recovery/tls/psk",
                            test_multifd_postcopy_preempt_recovery_tls_psk);
     }
 #ifdef CONFIG_TASN1
-- 
2.49.0


-- 
Peter Xu


