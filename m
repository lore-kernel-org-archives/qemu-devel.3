Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63611CCD19F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 22:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAy66-00082j-Qh; Mon, 20 Oct 2025 18:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wesley.hershberger@canonical.com>)
 id 1vAy63-0007mX-BH
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:11:19 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wesley.hershberger@canonical.com>)
 id 1vAy5z-0006Mt-EL
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:11:19 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 37CAC3F520
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 22:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1760998270;
 bh=U1YmKo/4Hr9HOKQfhHCBNXegFHBiId9t/MSvJ1/9iO4=;
 h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc;
 b=ApyyRuQ8MWU0rWh5rsf805H2HMTfr/nxV+U3LskiAxkQCmYF9hBntIr6mem/lfKv7
 6Fk7mPQp4NnEWDCfQxnsr5TcSnCXASWRmN2OnPjqqBRDUr5IiXkJo2iPAVJ7yPtjwx
 xBz8chsQqhq9q5s1d24qsV2QBsBlxXrlC8Ow8kv3HPab/1W0HgLRrgj90t4LOiyXYt
 yK5+ztpTr0uRdTwCRZ7QX01d4jUYif8jWg6SsPFV8MiHe2Y/6DzDO46HM1j+0jfGft
 vK6UcTvHRvFjDscitoWVjLHnGS+ea7eTBt0awAQ2rU5crz2/CI0Lw3RADXlVAqIX1/
 GXvU8TJoh9+Ims+9HC7u5IzR81/LfNhBL8N1I/0JhLTuxV0WcZ29CQHeO+aqfNVzW+
 cQZvH0MkU8SM5Jm6TXZKPtmSSLlpZnA8Ks+JRvhLt/YSsVw7xp/7+7AhbTagzjzMkI
 oK1vo0MA/Qe4mTvojgYj+JwYVcFXk9PmYUvWt//voKRFEQRg+x5yHPveNYRO8ZsK7U
 O8+zKwLDVQ2LDTHJd4/+S5wEBbRkRbtH+IGICt+cVvqtJq2tDCEhlG6Ho6IClkVeDx
 LqoLpHodzEUjzQP56e/gQ6XbDr1ypmmNEy54zYRf0oFYWKBjfl2npmA/T1rFW8dzuv
 K498beFVTgSfKMKXwcOj6bDA=
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-429278a11f7so53275065ab.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 15:11:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760998269; x=1761603069;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U1YmKo/4Hr9HOKQfhHCBNXegFHBiId9t/MSvJ1/9iO4=;
 b=H5bGOWdAIFbcGJ0EPvOza0CSZs9qjWyI3uhNg43aH43+AySt4knNEXIX3Zh4fs+5WB
 c9+MmbjmQ5jJV9hW4ht0/8FcZ+yvAdCggUZ6nP2GDf6WP0LgUqVelYj9zlev296JwkRW
 TzAdq4mqo3FYDmDlHnD73AoVpa40UuN4mDAoDp8A5Id3YIVwLUb/L+A/bY0+Z9IQxMg2
 8x2ZynlW61hcHBz8hi814uA0eihy9W/nKLZFac7DcwJDod7jnAjbY3YhbIzZ7uNQRuQ3
 mXN4xCjjSQjfS6pUu/EcqyTVVzyufj27bREUUuykZDQSug1lAdr8fyH/Xg61bi2rQ/0A
 K2Jg==
X-Gm-Message-State: AOJu0YyOmCNAalOSRs7YUhLFGFYjJNOLpAvYjYRNAEC1GPp8Ps+MgG36
 /4HZxEQ4H4IQizI5klny8h1w5W1sZ1OCG/2ihLooM7gCmMcXtUVt+wtXUIsKt19M6m7hx3i6RuA
 eQGLx4PVELUDq1anYuFqwbtXA4cuX66pdU/npsOZrVGHkF910Ht6xhO4Dp8MaimBULAwhrQMd
X-Gm-Gg: ASbGncsRGzkrTFoiYkcHC585TGLAe9I3iaTvkXuLuKcjoJGJTsagYMYYNGXe+HOrQkc
 JAn0zjTqinv9YAUD/rTjgXIUaeLS7Co3pFHc3mckc8cMN7T7cEbLKdY5eKLwLDyXzVZtBGLc2HE
 PjegFkVIb2Xag8alUkSzXCPCEtgbR/GLMDM/d06i+q7M7WLDjL6Rq3CIRc99h7xBk5ziB8xvVXk
 lltHWg1BLhu7f+6E2zGZqW5OqR8LIqGhQL0T4o4QI6vQf1zUNvkqs5WeozUzGq9SVD7VrJoMw9q
 bbxnh5Ijt89bcEPMw3quxAA2/yRdZYtvtiVuVWe80Mbx+/VDYrj1gOOL5NhUuumxHom+S8l7fsM
 o2khJ4xUYgqXHAT+Y
X-Received: by 2002:a92:cd82:0:b0:426:39a:90f1 with SMTP id
 e9e14a558f8ab-430c527dc54mr202745085ab.18.1760998269027; 
 Mon, 20 Oct 2025 15:11:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwwL3idue5mS4ANYfXk8A6rk74rOAD/9DmfCEIpLW4lERIj8ND8YwBMMkg53SeIuRRL+U8gQ==
X-Received: by 2002:a92:cd82:0:b0:426:39a:90f1 with SMTP id
 e9e14a558f8ab-430c527dc54mr202744805ab.18.1760998268668; 
 Mon, 20 Oct 2025 15:11:08 -0700 (PDT)
Received: from resolute.lxd ([147.219.77.79]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-5a8a95fed44sm3285643173.2.2025.10.20.15.11.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 15:11:08 -0700 (PDT)
From: Wesley Hershberger <wesley.hershberger@canonical.com>
Date: Mon, 20 Oct 2025 17:10:56 -0500
Subject: [PATCH] stream: Remove bdrv from job in .clean()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-fix-3149-v1-1-04b2d4db5179@canonical.com>
X-B4-Tracking: v=1; b=H4sIAG+z9mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyMD3bTMCl1jQxNL3TQDw8RUM6O0RFPjZCWg8oKiVKAc2Kjo2NpaADi
 vABVaAAAA
X-Change-ID: 20251020-fix-3149-f01ae62fa53c
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org, 
 Wesley Hershberger <wesley.hershberger@canonical.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1919;
 i=wesley.hershberger@canonical.com; h=from:subject:message-id;
 bh=SeydvP7pX9q1Gfc78TPLuAocZyTx+Zp/obLcLEeb4AE=;
 b=owEB7QES/pANAwAKAfkogKziOh25AcsmYgBo9rN3+oc6KoTrOoqC4q8luCOh6AW7AUlFAVYvU
 d4AB1ucEC6JAbMEAAEKAB0WIQQsIHxFLwpehxEbQ8r5KICs4joduQUCaPazdwAKCRD5KICs4jod
 uflKDACsfRHluaHu9hxYx+FigfIytrIF6xnb2QA569c+NVhJQGTMWUCCy/dd2u3NpJonYT1CZ+8
 biVhWhA5v4HycnlOmNs3pJtFyO98tGOKdiZJyvCtcyh1mg1YEEoR+c5eHpq4BVwcZ7CWoKCrUEy
 98X/M0SL/6M3A7LaQIf5PjnKUOABDEF9uJFExBpdMlPXPb7AsLY9Z2ij6+ojJvKbHIeIAveF7Eo
 3/HP9wB9eh/b7zeZul8T0+GzunUOM7cqH6u+1H+ffCtwY23Vg9T0swchan7JDR/zBOHs/SOjADH
 VlIZrnin/thDl5AiiGn45egCsZkAUbbnsq94o98xwXnpzIyvAikBXVCoAQNIHESSzbu4ei8jJ1y
 xSCoUOLl6k1XgvF3MPN4itMzzMR6ybQq5dOO7kh7kjm+RkB5NjrbDAR2sqJt+nonCKU1CiuXVZP
 SlFu8AQxnHXmbI6LghnlkTkdUUrTHDhpopY0DD+abqrmkZZHXpxAa/P+4820q7rheMTqc=
X-Developer-Key: i=wesley.hershberger@canonical.com; a=openpgp;
 fpr=2C207C452F0A5E87111B43CAF92880ACE23A1DB9
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=wesley.hershberger@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is similar to bdc4c4c5e372756a5ba3fb3a61e585b02f0dd7f4
(qmp blockdev-backup). The cor_filter_bs was added to the blockjob as
the main BDS (by passing it to block_job_create), so
bdrv_cor_filter_drop doesn't actually remove it from global_bdrv_states.

This can cause races with qmp query-named-block nodes as described in
 #3149.

As in bdc4c4c, there is no function to remove just the cor_filter_bs
from the job, so drop all the job's nodes as they are no longer needed.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3149
Buglink: https://bugs.launchpad.net/bugs/2126951
Signed-off-by: Wesley Hershberger <wesley.hershberger@canonical.com>
---
This patch fixes the issue described in Gitlab #3149. Please see the bug
for additional context & reproducer for the issue.

I'm happy to discuss alternative approaches or resubmit as needed.

`make check-block` passes locally.

A review would be greatly appreciated as a customer's production is
impacted.

First-time patch mailer so please pardon any mistakes.
---
 block/stream.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/stream.c b/block/stream.c
index c0616b69e259bf5a9b146dadd9dbac62bfaa9f23..1733abd8f96d7847701f54a7a55d3284387b8582 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -132,6 +132,12 @@ static void stream_clean(Job *job)
 {
     StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
 
+    /*
+     * The job still holds a reference to cor_filter_bs; drop all bdrv to
+     * ensure that it is unref-ed
+     */
+    block_job_remove_all_bdrv(&s->common);
+
     if (s->cor_filter_bs) {
         bdrv_cor_filter_drop(s->cor_filter_bs);
         s->cor_filter_bs = NULL;

---
base-commit: 3a2d5612a7422732b648b46d4b934e2e54622fd6
change-id: 20251020-fix-3149-f01ae62fa53c

Best regards,
-- 
Wesley Hershberger <wesley.hershberger@canonical.com>


