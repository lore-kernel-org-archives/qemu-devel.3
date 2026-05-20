Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE7D0CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPoZG-00028Q-NV; Wed, 20 May 2026 17:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoZF-00025x-7U
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:35:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoZD-0007R8-H5
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779312902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ww+L13ede0UXhmY2UazMQx/EusMUshqnbpbJrwfXvmQ=;
 b=CfmQY+v7JjZj/ysfMYO0U+h44ti6ksifFoJudmXlR42xBKpeRlh8CoMWd6kC3cA017GLN6
 wJ2M4/7YGldGxJV1xtJ5VdL40SA1RbqUjxIihHE2yYoSEcCO2UF5AJ28c6slIXiKuLY3dR
 yJal3KcPvZFw8H6ViDQH5bN9OIHuCHo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-8icP_BXeMlCejOqUQumzpA-1; Wed, 20 May 2026 17:35:01 -0400
X-MC-Unique: 8icP_BXeMlCejOqUQumzpA-1
X-Mimecast-MFC-AGG-ID: 8icP_BXeMlCejOqUQumzpA_1779312901
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8acadca1ac4so78742346d6.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 14:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779312901; x=1779917701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ww+L13ede0UXhmY2UazMQx/EusMUshqnbpbJrwfXvmQ=;
 b=kftrS1mA+V/ShsN03yQxJuLMi9cX2VU+kIeP6y03KOLgN1LRC/dTPIG8AJiM4jJVh6
 IW9jVoxp5JMsI1nqTDYJhXCcgL8+75sTDo83ZbOC4LZKLecpXPGhbpglYRBSQzpOLBOW
 707TzwApDEc7OV9jmaUq2DEWccnDXj4v5JXa3vhL8WVzEWc0m04RTCeXb4ARq+dZAqPr
 Mf46Wh4ZQhGOdHYNFHvZrW6pXEJlEsdkBMFvvnF612KFafSmUKC03aLmwnLm1fdgAr4W
 RCXEvI16DI3iEc+2JVFEYvnbpStC+OFmN1IXpkX2ltWBNuPm5EWVcyWbMFx72poL1dxk
 55rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779312901; x=1779917701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ww+L13ede0UXhmY2UazMQx/EusMUshqnbpbJrwfXvmQ=;
 b=q2rmRTGHvP0XDbveyTYEiGLkBBqwbnMdkfYfzUIreYwvpdFJnE50wBsEBfGSnpPp4G
 f3IRdcR5z8/ZoTGYFC5ozSmM2geO/hJHlOj2DzlwPGN93tg2D5FnFH/jYx32+UBL2yP+
 JSU1eqYfOzqycX4qaciwY+AvFxuilB33teB6ouWWqn500Q0U04iFFPVqLKcWm3Bw300y
 betZjeM7fQ3Wi4+wE6qUyfhH7YsymA/BUh3HA3dnQIauk7rfAGAst99xWVyGR930NudZ
 Ekqc+r98DiadR2QqtSN2IhaTy93r3O95jvLJAn5BrpOUX3/aDI39FdNW6eZSTM6lJOIM
 VkHA==
X-Gm-Message-State: AOJu0YzYhny5n/z6r9eKou+M81iPUNWxWgpmkpjFM9N7hoAfTV7Ws9A+
 P5xT8PO5L/F7EZn4NMuv9wtc9weae2qrbsAzra05HQofGi6kvBkHLt6/6ISO2AtLDfZrlQEogbL
 yTK27uXUXp1pdomMRS1ct1x51wHd4n8E9DihUNJufeNuEo6kLVEa0tW9L1TlESUfYUuX8sQhv8/
 uYyEm3oOU8u+eST/nZG2FLSyAlZXZgj4i3hQIZhw==
X-Gm-Gg: Acq92OFiSK0B15RroC9JJPLcHhnYZNJJ4t+c52pkDNYnvZ/XeFRN2f2WaaFePYyZ/r8
 nL0frpeugsG/TzvWQPPksMqzuGFpL5X6k98rYChdEkMyCqnhtVmgB1VwLxFJcKcnA3qBzqtbDhS
 vnbQ3dZjhcktTYIWzdCgO2PgExlxOJjCGrW/jXjmK+15v4KtHWUPx6gL5xApjj1cVRzgBGAwtCS
 9hZUu8/XLn/qGbbzsJQKeLqqdKM2sEYUjccpW6rhsa6SLxJQ5a722Yfd/ETSxyGmJu17m9QkiRr
 1mKlPo6+0BrigZGv+psQehiLk2ZAuPM5/SuHbs/cllvmnHK3wmQ0kaPLSQt3WoCELhfunk5xvH4
 3dr5K9A7hm4ocpkFyh2rz5TM1SVKffkmJ9XPmut1jy5ljM/2Bpq4uNLQ=
X-Received: by 2002:a05:6214:418f:b0:89c:a2b2:8d44 with SMTP id
 6a1803df08f44-8cc6e382071mr3664686d6.39.1779312900618; 
 Wed, 20 May 2026 14:35:00 -0700 (PDT)
X-Received: by 2002:a05:6214:418f:b0:89c:a2b2:8d44 with SMTP id
 6a1803df08f44-8cc6e382071mr3664136d6.39.1779312900022; 
 Wed, 20 May 2026 14:35:00 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca360b362fsm133062716d6.22.2026.05.20.14.34.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 14:34:58 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Bin Guo <guobin@linux.alibaba.com>
Subject: [PULL 24/29] migration/savevm: use stack-allocated bitmap in
 configuration_validate_capabilities
Date: Wed, 20 May 2026 17:33:52 -0400
Message-ID: <20260520213357.40646-25-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520213357.40646-1-peterx@redhat.com>
References: <20260520213357.40646-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Bin Guo <guobin@linux.alibaba.com>

configuration_validate_capabilities() allocates a bitmap on the heap
to track source capabilities via bitmap_new()/g_free().  Since
MIGRATION_CAPABILITY__MAX is a small compile-time constant (< 64),
a heap allocation for a bitmap this small is wasteful: it adds
malloc/free overhead and a potential cache miss for a transient
8-byte allocation.

Replace with DECLARE_BITMAP() on the stack and bitmap_zero() to
initialize.  This eliminates the heap round-trip entirely.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20260518110112.21395-5-guobin@linux.alibaba.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index d1dd696c17..23adaf9dd9 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -347,10 +347,10 @@ static bool configuration_validate_capabilities(SaveState *state)
 {
     bool ret = true;
     MigrationState *s = migrate_get_current();
-    unsigned long *source_caps_bm;
+    DECLARE_BITMAP(source_caps_bm, MIGRATION_CAPABILITY__MAX);
     int i;
 
-    source_caps_bm = bitmap_new(MIGRATION_CAPABILITY__MAX);
+    bitmap_zero(source_caps_bm, MIGRATION_CAPABILITY__MAX);
     for (i = 0; i < state->caps_count; i++) {
         MigrationCapability capability = state->capabilities[i];
         set_bit(capability, source_caps_bm);
@@ -373,7 +373,6 @@ static bool configuration_validate_capabilities(SaveState *state)
         }
     }
 
-    g_free(source_caps_bm);
     return ret;
 }
 
-- 
2.53.0


