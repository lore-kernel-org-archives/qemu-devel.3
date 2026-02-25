Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526A3F55449
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv5wd-0004PE-FE; Tue, 24 Feb 2026 22:52:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5wb-0004I8-NI
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:52:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5wa-0008GT-9m
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:52:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771991531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=thQ4vULn8MJGwudrFdz+jwz4Emm4K/23KKcSKWDfVRw=;
 b=UHQYKQ3mNXJF3ypf5z6ck6WIBmYy4G8r/6Kd8AwRFAhi4N1G04JiLn1ahZcxCM8M0HK0YS
 sXiecUeMpfkxpnfR51uIqzDWYlZ/1ucochjNGmVB9U53Y2lWKwL9Om4OzQIUxX5rChufuI
 4nRPxRIxH0bKaF4+k8xQImoEan9zC7c=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-wR854OFXPiugZrT0UmMqmg-1; Tue, 24 Feb 2026 22:52:09 -0500
X-MC-Unique: wR854OFXPiugZrT0UmMqmg-1
X-Mimecast-MFC-AGG-ID: wR854OFXPiugZrT0UmMqmg_1771991528
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-358f4ed4eceso986311a91.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771991528; x=1772596328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=thQ4vULn8MJGwudrFdz+jwz4Emm4K/23KKcSKWDfVRw=;
 b=Vw0Stm/gJnZINF05pLGFCQak0PxCDVrIJbTjBA8TAOrla7VyM0YnlFCNQn3yO9hA8F
 zc3snTL8C+A52coOzMiESxXB+Sd97+geWlT8To2nfOySnBwm+IMv9ODOZz7pPahLFOLS
 PMEhqrdQQgub/XcpUYLljMkmgjaBO3b8gLYjMYH8khiwAMgCIvCVGW4Ji0GW6bkDNcO3
 X2OZ/k6fiD908rirYldFYkisbvYJuj2G5oKaaAVeY+06ENdeWrXD10YcTGPdphVR141B
 49ESmEgNlMz41ffanLrzDOJGn1DkADIYAARA8btiS5AFBC77egcgA3sYn89DDYVyH6QF
 KmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991528; x=1772596328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=thQ4vULn8MJGwudrFdz+jwz4Emm4K/23KKcSKWDfVRw=;
 b=UDdY4xECFWmsmg9e/tv2BhyXxciLTLzRevrPvn7bW3vyOyeNDKHog1E33ArQ65VGd2
 wOOmRQvEoxS9uSGeHmnol5+wfpGZlLl6INX14khPpqoXGKEOoA4P31Ui0huGUTBlQIPE
 I/PcMd3fPre1ItxDnabsdih4MbKkaD8gF9M6yCiVZoEPf8GB7FAvhNaDdvuPAm2iVHx8
 S1cz3SA5m0WP7TQiZCt2Db5VKbP6lRmehiVzauXwOrurSCeGUgk5DT4sHlujHMa88gKn
 REaUgPjQWNvzLJaQYgmaFUsxHibGyLliK9J5njyjJTJpTqnM+gsrcuN2AJIgKz/ZFsSr
 oR2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCURdeKfvrVptyMjwnScdI7VeyJQgCHnZK+C6KGoyRRFKQ43MPJriwJ+MsUV+T2c6WUe8T3hezcIpGZf@nongnu.org
X-Gm-Message-State: AOJu0YxnOWNcjFedzf2Db+fuTVuObwFjbMf+PB8l9vDX/PVcMOOg/7Ya
 c90pSpf3fcyUiSGnUvV/0bo75Tc+8shz3cCE071Jd+JjQJANO9HFEc6jle/bvgDcCTfUw+AyqS4
 TAyD0UTxwX4QmsF1en+r6vr7ceYnutQ8nqtNsnWYaFaC47ChwY1i5uXsH
X-Gm-Gg: ATEYQzzFzaDiQoqACVP0oNIsU8MMfyLgsQBDmzm1/cRp04z5LACKFjetaw/a424ZYxN
 ta7dEIsi6+A5LWX49MI9u5vdIg/fKrP5BJdDo4x5Ox+3+xFwX2I2PA1JZN5+Bq70XzeKuV6hXNz
 uoKAUz5s4/J8ONpmLAWBISo4qKG0jDzM3fH/jah0vQ9V1BWb4Q8inT5LfMdjDPbXWQtv2zNqqwh
 +mS7Ot1l4xSO1Zg+fUtB8Fw50DueJrWF3D44zyuCPelPTV0U20Cdg2cX16E2EdWVpNC/cDhAc0C
 HB3op1bzQEztM9tg7KNGAdWw+RDoozR572vtw2jKWOGdMo/miDC9RxxA4DKIWv0OEqynV36plR2
 Oovdz59lT+mf2ybCrBPZI0g9k38ELCKKCJRSO/pTm1CqMxA2OiZu7Hsc=
X-Received: by 2002:a17:90b:58e7:b0:354:9b3f:710b with SMTP id
 98e67ed59e1d1-358ae8a423amr11898562a91.19.1771991527925; 
 Tue, 24 Feb 2026 19:52:07 -0800 (PST)
X-Received: by 2002:a17:90b:58e7:b0:354:9b3f:710b with SMTP id
 98e67ed59e1d1-358ae8a423amr11898544a91.19.1771991527585; 
 Tue, 24 Feb 2026 19:52:07 -0800 (PST)
Received: from rhel9-box.lan ([122.176.129.56])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-359018838b2sm1186006a91.5.2026.02.24.19.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 19:52:07 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, pbonzini@redhat.com,
 ani@anisinha.ca, Prasad Pandit <pjp@fedoraproject.org>,
 qemu-devel@nongnu.org
Subject: [PATCH v6 35/35] migration: return EEXIST when trying to add the same
 migration blocker
Date: Wed, 25 Feb 2026 09:19:40 +0530
Message-ID: <20260225035000.385950-36-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260225035000.385950-1-anisinha@redhat.com>
References: <20260225035000.385950-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Currently the code that adds a migration blocker does not check if the same
blocker already exists. Return an EEXIST error code if there is an attempt to
add the same migration blocker again. This way the same migration blocker will
not get added twice.

Suggested-by: Prasad Pandit <pjp@fedoraproject.org>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 migration/migration.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index a5b0465ed3..1eb75fb7fb 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1702,6 +1702,10 @@ static int add_blockers(Error **reasonp, unsigned modes, Error **errp)
 {
     for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
         if (modes & BIT(mode)) {
+            if (g_slist_index(migration_blockers[mode],
+                                 *reasonp) >= 0) {
+                return -EEXIST;
+            }
             migration_blockers[mode] = g_slist_prepend(migration_blockers[mode],
                                                        *reasonp);
         }
-- 
2.42.0


