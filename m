Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E60D31767
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 16:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8McW-0006Ao-Gg; Tue, 05 Nov 2024 11:41:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t8McT-0006AZ-Ds
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 11:41:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t8McR-0003hc-69
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 11:41:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730824885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f3ip2nYKth2PEdXSfE3aRQW4q4Rkyvz2xu0u8v85oaw=;
 b=IYEdAwW+vtx3aSulBWllZTzRin18A4IwL2A0JPsrIHc/E2GTI6W31GKRMbqs8JRL2x0RpB
 PQo27pT+Oezzw0PkxkzVYaCxnqAZKhMwu3AZgedUzE9tYA5hRHwhnBsY9KVvpL1P81ppCL
 iIjYhHJjyY7fMi0wb4UxK1YukkncoAA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-E6hxKpwwOi-mnvWOm07JMQ-1; Tue, 05 Nov 2024 11:41:23 -0500
X-MC-Unique: E6hxKpwwOi-mnvWOm07JMQ-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-460b8f4bab8so115174561cf.2
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 08:41:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730824883; x=1731429683;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f3ip2nYKth2PEdXSfE3aRQW4q4Rkyvz2xu0u8v85oaw=;
 b=qsY/ErwvWU1dQY6Uxq4HTk7BSlBEU7vMeEdepy0hsChdPVW0uStkzqL5fJLWe24NUI
 AVCK0tmO+ie5oU5Tnu6wnFK4sj/Vc1e9Nxbfyxh8w/IARhkqFw8/Yw7aEdzX4IffRfU1
 6IWvS6U3A1/owwyfG+yh3Q/QPhmDKa+d52aDquzCoLbkqSJcWHUHkXrxRKfmauYTwPPf
 VO2amnMlVtKL/Lu4eTIU1X/C5DCl6qhLumZ9amxMhO3U0eJd90HjYR00aszmMrmPBT/P
 oQTaACGL2nnCf4gTlsP8wXWel6Dd5Lbsq5Y2SXwu7CUgxIeJJQc9q1l6SrV7/pSaU1w7
 3Yjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdZF1uV1XMuK/H1L1JNUq2WKY6BEDQd3svT90yIhx7e0ynxl09Nliflvhc7FV58rTVutK4+8Nkcz/y@nongnu.org
X-Gm-Message-State: AOJu0YwwFUQoYIXZttgzslk0f0v/W0asU4GLhaW7b1wI/YZHErbgr1/6
 a/Iuoan8XWr8ophi6BPA7DgUYaT+QhV5kiBvR9YIhxwJaBiGbcbDCZh2bnlpkEoxAGHDprEuW8q
 8kERMkZnp18bGayYpjdVt2U7Mz8FAlJkuuThSlpTVVnetFbefn/5x
X-Received: by 2002:a05:622a:1b8b:b0:461:39ce:2218 with SMTP id
 d75a77b69052e-4613c1c9f98mr570115641cf.57.1730824882704; 
 Tue, 05 Nov 2024 08:41:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH29zbhGNpSWjC9aiVSzvnyRkvPCynbl187Lfam/AKo3nxxDtZ5Dchu0NZzne3JFORjM/Ce9w==
X-Received: by 2002:a05:622a:1b8b:b0:461:39ce:2218 with SMTP id
 d75a77b69052e-4613c1c9f98mr570115261cf.57.1730824882271; 
 Tue, 05 Nov 2024 08:41:22 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-462ad0ae823sm61248451cf.33.2024.11.05.08.41.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 08:41:21 -0800 (PST)
Date: Tue, 5 Nov 2024 11:41:18 -0500
From: Peter Xu <peterx@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: test regression - qemu:block-slow+slow / io-raw-055
Message-ID: <ZypKrpbo28zrEamP@x1n>
References: <b8806360-a2b6-4608-83a3-db67e264c733@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b8806360-a2b6-4608-83a3-db67e264c733@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Mon, Nov 04, 2024 at 07:41:44PM -0800, Pierrick Bouvier wrote:
> Hi,
> 
> this test was recently broken by 34a889 (migration: Drop
> migration_is_idle()).
> 
> Reproduce with:
> meson test -C build -t 1 --setup slow  --num-processes 1 --print-errorlogs
> io-raw-055 --verbose
> 
> 1/1 qemu:block-slow+slow / io-raw-055        RUNNING
> >>> ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1
> MALLOC_PERTURB_=29 MESON_TEST_ITERATION=1
> PYTHON=/home/user/.work/qemu/build/pyvenv/bin/python3 G_TEST_SLOW=1
> SPEED=slow MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1
> /home/user/.work/qemu/build/pyvenv/bin/python3
> /home/user/.work/qemu/build/../tests/qemu-iotests/check -tap -raw 055
> --source-dir /home/user/.work/qemu/tests/qemu-iotests --build-dir
> /home/user/.work/qemu/build/tests/qemu-iotests
> ▶ 1/1 raw 055                                FAIL
> 1/1 qemu:block-slow+slow / io-raw-055        ERROR           11.06s exit
> status 1
> ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
> ✀ ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
> stderr:
> --- /home/user/.work/qemu/tests/qemu-iotests/055.out
> +++ /home/user/.work/qemu/build/scratch/raw-file-055/055.out.bad
> @@ -1,5 +1,215 @@
> -........................................
> +......ERROR:qemu.qmp.qmp_client.qemu-1856388:Failed to receive Greeting:
> EOFError
> +ERROR:qemu.qmp.qmp_client.qemu-1856388:Failed to establish session:
> EOFError

Thanks for the report.

I don't know how this was triggered, looks like current_migration wasn't
set at all for some reason..

Could you try below change to see whether it can fix there too (it worked
here)?

===8<===
From d33ad33854d36c04260150ee817b984f48da46c6 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Tue, 5 Nov 2024 11:29:07 -0500
Subject: [PATCH] migration: Check current_migration in migration_is_running()

Report shows that commit 34a8892dec broke iotest 055:

https://lore.kernel.org/r/b8806360-a2b6-4608-83a3-db67e264c733@linaro.org

When replacing migration_is_idle() with "!migration_is_running()", it was
overlooked that the idle helper also checks for current_migration being
available first.

The check would be there if the whole series was applied, but since the
last patches in the previous series rely on some other patches to land
first, we need to recover the behavior of migration_is_idle() first before
that whole set will be merged.

I left migration_is_active / migration_is_device alone, as I don't think
it's possible for them to hit his case (current_migration not initialized).
Also they're prone to removal soon from VFIO side.

Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>
Fixes: 34a8892dec ("migration: Drop migration_is_idle()")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index aedf7f0751..8c5bd0a75c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1117,6 +1117,10 @@ bool migration_is_running(void)
 {
     MigrationState *s = current_migration;
 
+    if (!s) {
+        return false;
+    }
+
     switch (s->state) {
     case MIGRATION_STATUS_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
-- 
2.45.0


-- 
Peter Xu


