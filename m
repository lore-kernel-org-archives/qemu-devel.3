Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C7C3D1951D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 21:37:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkUG7-0003ol-DA; Mon, 26 Jan 2026 16:36:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkUG5-0003kG-CS
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 16:36:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkUG3-0003Md-VP
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 16:36:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769463387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wjvmilWuHa/g+TZvKS56qSu8dynrYCrt9ztlOJrDTaM=;
 b=DA3D7fwzfuVFmzPcMMS/BAB/YK7mKu33VgVY+XzzH/cpiqCZBCPQ1BChVdc4Octc4mP2qU
 sKt1Jk2LNfFiQbz3Nv/yZRKfvuKK9C62ce+eVUsZrGpJDxz5fU7X8Y841qcVhSG4s86ZIH
 r0ZjfjLPmc6rlJtf0uO80e1x9E7BmLY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-MAaU1zW_OWiLgAcR7aC1uA-1; Mon, 26 Jan 2026 16:36:25 -0500
X-MC-Unique: MAaU1zW_OWiLgAcR7aC1uA-1
X-Mimecast-MFC-AGG-ID: MAaU1zW_OWiLgAcR7aC1uA_1769463384
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5014936958cso186003351cf.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 13:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769463383; x=1770068183; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wjvmilWuHa/g+TZvKS56qSu8dynrYCrt9ztlOJrDTaM=;
 b=ALGZhOWjbyF/HpiQQ7ar/1qQPeMTKzFOV8SdkuG8fWCVffPTlWbnzpV55WQsGZhQ9/
 dgC4ETN5mTW58yS1Q5veZWvVbAcI/sk9i51V2Yk4T7d5aqHJvmnVqk31PVNqaj17e2n1
 ce1cNnCqLtGbMk2vjn+M1yD/ovcSnZE2D6DK320xVJqpXmw3XZ5JL9O3qDhtc5iEq0W4
 Di5ACYJ71Gn8McLq9bOyVT4O7dKSv4+Z5c/M5XrY2A/zYcTmV2x6/NkQKB0/XVJ2ikRg
 AdXe7BzmsowCCWufj2QXwy0ryOm68E3Tl04mI6iRFIWrLPDVO1ctJMbGAfu/zFCIG8kf
 5Dfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769463383; x=1770068183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wjvmilWuHa/g+TZvKS56qSu8dynrYCrt9ztlOJrDTaM=;
 b=uDeo2dBZH9aRsRgyRQPHiOIcD9AfgOeUmvgLyUiY5FWlM036Ly/SBOJk3nhCWi2XVq
 j0kdcpbynfT14fCSMr1zdSulNOHkmK3QOyNp4407ptJwkw3l1UO3caHUGUsNXdRl2QZM
 aDtXtgMrbr7++AEs0aPdRm+gfSdAkJynaayjPuLVeUHJilUD+oIeDs4uNyZr6cDCQe0Z
 xX5R6kU7D4GXGB120UHGp40Uu4/vrNs/VKF6dh/ZbkvhX0SSlwZmcY/5wW1Scl+rb8I6
 GA/ZbHefCnnylrH0f9AGi5+urUnCDv+HILnmhoUUnYr1Eh+F3STo/WizWSCokRQelF5l
 rfVw==
X-Gm-Message-State: AOJu0YyIPqE9gQPls8L0LGJE9mpUNPvSwrfwrqFnLf2ZA07X1q4JC8M0
 2bxlgmPDeSIb+87gk6/Co39MhV/NEZu/wV3G/uDNIeaS8lijP4Lli2PTcaXtyXu0Vb+wYuGOSlz
 rvwN542kXclcLL3Dyx7sZm8bjBU4mTzap77EbdoG3oc2K/sF8+jBkPrgd0+1U03Kg/bPgnXz2in
 zVdKKmCUyg7QLCIPnV2KgTvgdLr+/kxdoYxnfu2A==
X-Gm-Gg: AZuq6aJ78NotwGC7SrFT+WjwfSzisA1xWJbO5JEGPgHjr+06ZfW/F/OL7H2PnqD6tOV
 n/gFWQ/zb4OQvTAzyz1aYsUMidjDxRZL8BdBjyk5iBq7Otx6QnAfMDG9Dlt3djx4/zASCzCf96i
 LjYjBD+6mNCrHq/a0d3KgR9mV/lRwC+AlFRSgkJGFwj4FjcRlE8uk8w4vbqn/0ddPqcI/H0yLP8
 /mg6e8Dz11EBjw3y3UIlkS7lrHRE5fyGlb4Ht0KFc27/r3+KKaLu2lmNDPMte9Cf6/0h8kvlj3g
 Q1wPC7YqkfRI3OWpm43thOT0Th2a3GeXmk8eukiU5o8utSDviqCdkHRXM8fL1dx+ksrkDAzsHKt
 I
X-Received: by 2002:ac8:7fd4:0:b0:502:9f0c:79f2 with SMTP id
 d75a77b69052e-50314c690b7mr75949151cf.44.1769463383446; 
 Mon, 26 Jan 2026 13:36:23 -0800 (PST)
X-Received: by 2002:ac8:7fd4:0:b0:502:9f0c:79f2 with SMTP id
 d75a77b69052e-50314c690b7mr75948871cf.44.1769463383044; 
 Mon, 26 Jan 2026 13:36:23 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-502f7f9cd9esm89769281cf.33.2026.01.26.13.36.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 13:36:22 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Prasad Pandit <ppandit@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v2 4/5] migration: Drop explicit block activation in postcopy
 fail path
Date: Mon, 26 Jan 2026 16:36:13 -0500
Message-ID: <20260126213614.3815900-5-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260126213614.3815900-1-peterx@redhat.com>
References: <20260126213614.3815900-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Postcopy (in failure path) should share with precopy on disk reactivations.
Explicit activiation should used to be fine even if called twice, but after
26f65c01ed ("migration: Do not try to start VM if disk activation fails")
we may want to avoid it and always capture failure when reactivation
happens (even if we do not expect the failure to happen).  Remove this
redundant call.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 8d1c294b47..a5b0561cbe 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2643,7 +2643,6 @@ fail:
     if (ms->state != MIGRATION_STATUS_CANCELLING) {
         migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILED);
     }
-    migration_block_activate(NULL);
     bql_unlock();
     return -1;
 }
-- 
2.50.1


