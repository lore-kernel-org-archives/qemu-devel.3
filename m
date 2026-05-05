Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B0ECD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 20:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKMM9-0004Qg-2B; Tue, 05 May 2026 16:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKMM2-0004NS-6V
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:26:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKMM0-0002aa-Fg
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778012811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MrH4nxdY2z2cb6i8OQLnpO0ege44PFcIyn690wvAT/8=;
 b=aZsMaKQ8VwV7xKqJvn4vCCfK38JdDPhN1qsxEixvQj7FG1rvT1KuQWk6PfxY9+qLpkAvXP
 q3/dASt9O63NabAWbszxokxzgMZ65hnW50erNUcWgirl7ut3zgYQVRHPV6XPguWpsrjoy7
 ssl9nhTaQDx2+MejICWpmyv3z1jJ3DI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-2P-krHfOOAKJzVrno4yVGg-1; Tue, 05 May 2026 16:26:50 -0400
X-MC-Unique: 2P-krHfOOAKJzVrno4yVGg-1
X-Mimecast-MFC-AGG-ID: 2P-krHfOOAKJzVrno4yVGg_1778012810
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8acb26fbbb2so90523556d6.2
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 13:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778012809; x=1778617609; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MrH4nxdY2z2cb6i8OQLnpO0ege44PFcIyn690wvAT/8=;
 b=mmED+GT6omG/CJegGd3EmBC7ZSs+4TV5hGeD5aOiqpi9q8I/znhJcXeFIV6DomJN1r
 Hkr+gXV9+Hy/vK0bKJ0zP5S8sKK4/1R5PYmi+/VgtMc7n238VJU01qSoohNrPUttCamT
 MlUCfzvBULh8CoPtSn6mke/pZy0JoSsSZs9BK98cVi/gI98wIrJmp0/7oODdFMIB2YT2
 EhnOblfJaxR6DBQaO/glJlhPGA5FXExca3ewn+cCYtC6IAR9IScNLR2FvzyuCa+xqdWk
 nOq1DP//rXlBy30gu9gR033Mdlc2nydMKwyJh/Z/NhYEAmGsp5Mf508+6bS+6ryrow4Q
 ousw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778012809; x=1778617609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MrH4nxdY2z2cb6i8OQLnpO0ege44PFcIyn690wvAT/8=;
 b=P7tlNNlhn1L7NnZihByL6XRo1VLCfYS6dfBuKZawE0VaJPl65D+5A2Y9N2QZeNHnyW
 xVCWjdBtTVzQ8urmqeQidUuEaHPI/FCDuNGeQkkTFXfFtyBB+HxRcwGrt+OvNZplxv1u
 AnC7eDtrbDAgMZvHG7/9wbb0BEv1SuuJKIR9bhIbvAwJBGUCBphBqVJ6VmqIg1nEPkJt
 MAtrpG51cZjMTZ3Oz22SMLqKvs+XSKGFDoDWYOb7WL+ClHuHj/beHEKitb0v5IQ3ztNB
 9qOomILu3J+vIg/pe6VShBTT6rlaQnX6noG/U8uk6V8ycbMX97DVnieHG0VfczGSy42n
 Y6Mg==
X-Gm-Message-State: AOJu0YwrnUnR+rX8kWWFC5x5WdA1YsOSGOcN1+MAC+mZ6UDhA6xR2fjq
 Y8w1U+AAc87e/H3EpmENtNHCa6k17QWsM2apwJHv5fgB2ooQF2aUufwwwD8cELKDR+zGeWDERg1
 QcOTVTNvrrc3o84LOEDua0xnuEKOsv/Kqq73t8CVNEJrbfgOvKK30fOknopk0Ei8ebGnVWD07tf
 ZhbViSBLMvAvSjMRbu3mnfg/yGwJ7vh3a1yH75Dg==
X-Gm-Gg: AeBDieuM8XJ+OHELJZLWySf7N7XU4RmD7C/WSzjmpjK5+5uYpTFh75rGYqFHS7tIFJ0
 i5WnFzGm14EjKoLeaW+CQ55s5PYCyG6PFTeCqnmVsyRNQsmaGqoVjlq7k2Nj3nacgnd00L0Ya0T
 /zFC+rAb5aKZq5+KsnLKb/Gjvgdmt+0S46pRWsDh7z3N8fc9ZcOaY9U2JlehflVr+h4glo7Smpa
 QqNCQTM0JkomSAvPOxQ28m5xncft3duAjxKfDjpA3jYC+r10kFPGYQUlI/dbLkN9xqOLsB39b9S
 mD69Xy1qft6V7hAnHbU/rMrB+YN2oMe87/ri0uc54gYBighESQc5yX7b+ncQOqWG5LNHeETjXEZ
 ++v1Pa8Szyl3ElJb6uky8MzNfSQ3KbmTAg9kb+G7bN/edeNZ6q5IYMhQ=
X-Received: by 2002:a05:6214:468d:b0:89c:ede4:ea35 with SMTP id
 6a1803df08f44-8bc449aff84mr4877976d6.24.1778012809254; 
 Tue, 05 May 2026 13:26:49 -0700 (PDT)
X-Received: by 2002:a05:6214:468d:b0:89c:ede4:ea35 with SMTP id
 6a1803df08f44-8bc449aff84mr4877256d6.24.1778012808652; 
 Tue, 05 May 2026 13:26:48 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b53c6b8123sm155283806d6.35.2026.05.05.13.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 13:26:48 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, qemu-stable@nongnu.org,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 04/23] migration: Fix low possibility downtime violation
Date: Tue,  5 May 2026 16:26:21 -0400
Message-ID: <20260505202640.1011006-5-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505202640.1011006-1-peterx@redhat.com>
References: <20260505202640.1011006-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
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

When QEMU queried the estimated version of pending data and thinks it's
ready to converge, it'll send another accurate query to make sure of it.
It is needed to make sure we collect the latest reports and that equation
still holds true.

However we missed one tiny little difference here on "<" v.s. "<=" when
comparing pending_size (A) to threshold_size (B)..

QEMU src only re-query if A<B, but will kickoff switchover if A<=B.

I think it means it is possible to happen if A (as an estimate only so far)
accidentally equals to B, then re-query won't happen and switchover will
proceed without considering new dirtied data.

It turns out it was an accident in my commit 7aaa1fc072 when refactoring
the code around.  Fix this by using the same equation in both places.

Fixes: 7aaa1fc072 ("migration: Rewrite the migration complete detect logic")
Cc: qemu-stable@nongnu.org
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Link: https://lore.kernel.org/r/20260421202110.306051-3-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 6e4988a590..5f4efb1fe5 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3258,7 +3258,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
          * postcopy started, so ESTIMATE should always match with EXACT
          * during postcopy phase.
          */
-        if (pending_size < s->threshold_size) {
+        if (pending_size <= s->threshold_size) {
             qemu_savevm_state_pending_exact(&must_precopy, &can_postcopy);
             pending_size = must_precopy + can_postcopy;
             trace_migrate_pending_exact(pending_size, must_precopy,
-- 
2.53.0


