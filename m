Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA339D6CFAA
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 23:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vj3iM-0004z4-Jw; Thu, 22 Jan 2026 18:03:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vj3iK-0004xR-Ky
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 18:03:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vj3iJ-0007VW-8s
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 18:03:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769123022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sJVnKFurjfOzRxE0fGeLT7o1Vv1nXq2SFkrz7rX6drA=;
 b=bdtF+yLoQOosOrs61Vc613GHvyaSj2cMFKFqhkW4NPYiinxiEbIiZWJkS5TLJnH1WDywjD
 WYlQHXMPZI+fyvV/DadoUg0Yd3sV7P6LCV8hTucreOC79C/qSJlMrVfw0RL5mQo5SFpti5
 pIP+Vokloqt+XMJEPoAVolP/vn5F7ro=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-QtOBzQnNMuSfBIHyLo1vPQ-1; Thu, 22 Jan 2026 18:03:41 -0500
X-MC-Unique: QtOBzQnNMuSfBIHyLo1vPQ-1
X-Mimecast-MFC-AGG-ID: QtOBzQnNMuSfBIHyLo1vPQ_1769123021
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8946b186018so61522226d6.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 15:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769123020; x=1769727820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sJVnKFurjfOzRxE0fGeLT7o1Vv1nXq2SFkrz7rX6drA=;
 b=sahKaAZ3opRuHF4szuZXdUEVHn+x4e3Kyz9KpmyJ5FpzOklfnLL77iNYzt+ioQ1rj5
 bSauFBK0yCqqG8ic/cuTQtl9PmQpnIzmH4bStl8MOgmqVP583eYqAgAnyfvZFasdlhDv
 Es7Fe4HwahnUqYzN1GiaGWNBn+CIAXXl3mVPsnXJ2Qp5AvnQi1VdvW7MmWLm8l2licuA
 FkbdHXw9EZzi54Qv6ca2ZtQyn3kYEqSW1EW5Zo9IpQu4AEPtLdTrcp3Rulox1Fv9fZ+l
 9trNvVJFwOBe+OFScHKqOE/AaAgp8cuK7WuN9WJXyzE0S+SXxmABr+WVUhtu27MMb4i0
 qgzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769123020; x=1769727820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sJVnKFurjfOzRxE0fGeLT7o1Vv1nXq2SFkrz7rX6drA=;
 b=TTJ58oxhlL6haDgitxGe3yg4WF351xX+47p3TOaFGNpcbXKMleqzbxh4sOD9LCINie
 HJKZTofcGlhztyUKIE9wOaIPyl1DpHS2W2HbtYl8h3Q+6Cf+19BNBsV/XrnHf8ok16m5
 7uGh4D7JIgMysz7qNi5wTYirf6NQr3eWTftp0ybqRlNqjzCzQ8Wec2cjD1zasodZMb5u
 9RFEbJbw2nx9toit8h7raRVQk29SESsOUHqOLZLmaQWKoc0y/V3VfYirRSjm24BzV2tF
 qyCP7xanuHEBBz1itc77WMJSew9ceHL9o4wUYdeEfRu5vjMHURD2Bf/p7QQ6bzE/+eVH
 k+aQ==
X-Gm-Message-State: AOJu0YytVJB9iW7MCqSFYDjvi9avnr1aaSLOScBJ1EIPmRkpuFxKW18G
 CGymDmsZb6tPbUI1+Yp1ln1cvd49bxLniAT8/1coJTgXilOBdtOoCWW+B9sf+NX3eHUFG/mZ3Vn
 h1XbsLwuQ1vOEOoUN8tjphS7UIxsxaOQoMfu9XFop2Cbu/pclM9akAWY1miEyA8zPE0Ui5GGBfJ
 WX6O/jKT53YWK7Duy7vJJn0d9KWjxW5ELgC5SSNg==
X-Gm-Gg: AZuq6aKgtxL5Wc00FwSxR9wT7LkJ4Lu6j+q0QMNGgBRFYb205GxyoIWFvOaG9Ter7iJ
 Ov/HXw0+P2SPvtqxOVXTywS25mMnw5qLLn1UVFpoESmfHq/EaLasOz3ywa4pRe+qGMcX1yii1ut
 yJi0+cUEWarTslLWreTbHxYJycUqO3ODRbGl7tR0aOCGTAMea81Aa2FIKU2CLEohbgtbtIw86Of
 PJEKKBT+5Njg/oISFF5sPW8L8n4fVTPXZXUTIqKQwUZHI3uGEbt4l0gJaS5CPmGX2W15Vz5d9sX
 n4Gr7UFK1oWGH0TZNwMRwi024vwTEkuu2SerH7+8lVn4vVYstNE5o9dUGS8uwtQOjtL60XRsm+C
 w
X-Received: by 2002:a05:6214:e47:b0:87c:28cc:9e69 with SMTP id
 6a1803df08f44-8949023c3bcmr16412996d6.55.1769123020263; 
 Thu, 22 Jan 2026 15:03:40 -0800 (PST)
X-Received: by 2002:a05:6214:e47:b0:87c:28cc:9e69 with SMTP id
 6a1803df08f44-8949023c3bcmr16412616d6.55.1769123019789; 
 Thu, 22 Jan 2026 15:03:39 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c6e37d2a56sm41032785a.20.2026.01.22.15.03.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 15:03:39 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 peterx@redhat.com
Subject: [PATCH 4/5] migration: Drop explicit block activation in postcopy
 fail path
Date: Thu, 22 Jan 2026 18:03:30 -0500
Message-ID: <20260122230331.3543312-5-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260122230331.3543312-1-peterx@redhat.com>
References: <20260122230331.3543312-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 1d9a2fc068..5bef14ea99 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2910,7 +2910,6 @@ fail:
     if (ms->state != MIGRATION_STATUS_CANCELLING) {
         migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILED);
     }
-    migration_block_activate(NULL);
     bql_unlock();
     return -1;
 }
-- 
2.50.1


