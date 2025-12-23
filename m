Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED58E6F098
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 14:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY3Pw-0002FX-8M; Tue, 23 Dec 2025 09:31:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3P6-00016F-Bx
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3P3-0003kf-9h
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766500220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JqwNvMrsGtX06aW/fAOs3pT2SsT5wFnHsxM699N92Tk=;
 b=RmUSied+uZ8lAOpZN2S/UqrbwTWeWIQpvSE95tH/4IVrDZTHqIKPiizCiak/YY6NPxQFnd
 VRm2btSn3gb0Hs78IUPJ6jmwdAFDAMYYiB2vnKLAX1V6Feg2H2W3ohAiHzClPFB5Z4BIWs
 zP84QY6POIksf5kPnxtAWu6R5P6VBWE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-Pl_F6EIeOnCKJPX-pk-MeA-1; Tue, 23 Dec 2025 09:30:19 -0500
X-MC-Unique: Pl_F6EIeOnCKJPX-pk-MeA-1
X-Mimecast-MFC-AGG-ID: Pl_F6EIeOnCKJPX-pk-MeA_1766500219
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8b22ab98226so1731633485a.2
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 06:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766500218; x=1767105018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JqwNvMrsGtX06aW/fAOs3pT2SsT5wFnHsxM699N92Tk=;
 b=hrwc2bqVfIJ/Y6jFNkw114rVewAgflqqSNN6Xc+9PHmDzk5s7aSPhy/B5euCpMkMA1
 uKgSVI9UzxvIROqsAsFYN7CFh8h8cQhCUhYy2MMiXh1p79dxCNCihdSqPSCC3go/t6Ys
 xaJVzDCNVwnxis77eT26M784eWD4vshO9F4r864sQ1k2Giwj4P5Mq6b3D7V+gS5gOgur
 SSix3XlQ76ajGR5vLbQBCEfSIbqSr7POiYByNwn227DhSkI4j7QR5U7gO6pNrCELP91b
 gi1NYI1+mqMX0CDoQmPaKZDsoEZYSnK+kZjY0IvE0aya3NmuOS6oUU9thFSzIPiiAg14
 AMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766500218; x=1767105018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JqwNvMrsGtX06aW/fAOs3pT2SsT5wFnHsxM699N92Tk=;
 b=tN1Zga3wXlGoMxldiq2NKvgMfiAdAi3OVxQ/WOtmQOvpgMGa3M84bMtPUtvlKL0YPH
 gwaT2drWXBJzJqY5ut4lWrEw5FS79eJJ793lL71Tegtf3TqvyxPySA3HsTDez4+NsCiN
 tBBH/zQX+pzeORQ+PNVPOnrk16rgp0A4mZQRwmMbf8TzdjxMxLw0oRQnsDBEwEUhP5vB
 P0L1Qm8ew3Ng+52MqeqGDPbXHxagjhsHtQBTXGeeb2Rw8etj7UujXA3brCXHaUrwbm1c
 ZvGRp0Pr4+lphZ+6n3boiuMSVXZ8dUyLLWOpZxusBDOKTP6/zeGlbbzXnIxnqZtIqRU6
 dprA==
X-Gm-Message-State: AOJu0Ywby9eR9InpWSssropAZRA7DKK2fbw6nGTYZC/6k2ilncJ8hT2x
 J5wcnHEN05hSvRpT/dN5pGSTWKOjFvJ6l5pR2nFJqT9w1KlhLXN8WPvxObm9+nYCpi8+HeqjCJc
 mfASl5K2V6nI0vKFgPvqPGYyXp8PlHYDfvm46EI7JK3j3fQRIawHNYNezXdBp/FYrkU7xlEcaHP
 J/KxgbCkKcbQRwtV5XV52c0e0Cuda0PtQfIH8ysg==
X-Gm-Gg: AY/fxX5+LQv7q2vCGyYs2KS+msPLwR+t1vAkw+W33q4DC3tfG9TilEMQnkfd6v25KvA
 yY1A3HkvoiCyog0V5AKnFWMK1Qq/y+lU1xEXhy3dcuNkJOeZs+2oLEprq7MpgbuSoAFCRRwX+yw
 OeNnDL7/ijYsnkYDKU4XPjAdjZSuXlQ4+SDvhmJiCgl8/AJG+sHyg1SOX9iheHyjM+zE0v0mc9r
 Av0sTFOAPltvSognAiCoMD68/qNO8r2moO7ajbMGaY5+wQRGfxbpTRbBAnbP3TTR/usf9yJmMn9
 omYXSJkFuhpEym1VAVpEr4v7g4XccjgQd9pIQLGSr7g/Q3gUSlV2eBxXy7w5pbu7RitX8SDHzm1
 aHv8=
X-Received: by 2002:a05:620a:1a0b:b0:8b2:ea5a:4152 with SMTP id
 af79cd13be357-8c08fd1a9c1mr2461004485a.87.1766500217984; 
 Tue, 23 Dec 2025 06:30:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjxGaf7w9uh/GvaOsOYiM62EG0AViskxAhyQmRS6Oc59z3kaGetqAFIlJlRoG082tOT1nTow==
X-Received: by 2002:a05:620a:1a0b:b0:8b2:ea5a:4152 with SMTP id
 af79cd13be357-8c08fd1a9c1mr2460996885a.87.1766500217433; 
 Tue, 23 Dec 2025 06:30:17 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c096787536sm1096163285a.4.2025.12.23.06.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 06:30:17 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
	Peter Xu <peterx@redhat.com>
Subject: [PULL 13/31] migration/options: Add x-ignore-shared
Date: Tue, 23 Dec 2025 09:29:41 -0500
Message-ID: <20251223142959.1460293-14-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251223142959.1460293-1-peterx@redhat.com>
References: <20251223142959.1460293-1-peterx@redhat.com>
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

This aids scriptings only.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20251205172054.288909-1-peterx@redhat.com
[peterx: make the property x-ignore-shared to match, per cedric]
[peterx: fix over-80 line]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/options.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/options.c b/migration/options.c
index e78324b80c..ea19b2c7cd 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -203,6 +203,8 @@ const Property migration_properties[] = {
                         MIGRATION_CAPABILITY_SWITCHOVER_ACK),
     DEFINE_PROP_MIG_CAP("x-dirty-limit", MIGRATION_CAPABILITY_DIRTY_LIMIT),
     DEFINE_PROP_MIG_CAP("mapped-ram", MIGRATION_CAPABILITY_MAPPED_RAM),
+    DEFINE_PROP_MIG_CAP("x-ignore-shared",
+                        MIGRATION_CAPABILITY_X_IGNORE_SHARED),
 };
 const size_t migration_properties_count = ARRAY_SIZE(migration_properties);
 
-- 
2.50.1


