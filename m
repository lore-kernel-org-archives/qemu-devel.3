Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1053CE6F090
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 14:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY3Pu-00024w-Qa; Tue, 23 Dec 2025 09:31:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3P2-000156-VU
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3P0-0003jc-T4
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766500218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cEFBdIohS4062D+O/J++uj/ToEv6MawI3RRAwg3mQ+g=;
 b=ce3dK+rUXqYi3sUAj8KJ7zGAdZT39mNMPjIvKBAs1UXleqiOwttNNl0E6jKLdeB8atv71d
 rDUdDLfg/M5WxLjKYmQqA27DJ2upsjLiKBYXWr1ccPIZJ5jN2TIlajG9hr+7Y6YOOVLUYH
 ApXionGBNEbO0Q/ECWUIsLYVaiTuyjk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-abAEsoRcMpWc9fTLno0Yyw-1; Tue, 23 Dec 2025 09:30:16 -0500
X-MC-Unique: abAEsoRcMpWc9fTLno0Yyw-1
X-Mimecast-MFC-AGG-ID: abAEsoRcMpWc9fTLno0Yyw_1766500216
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8b22d590227so628686085a.1
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 06:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766500215; x=1767105015; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cEFBdIohS4062D+O/J++uj/ToEv6MawI3RRAwg3mQ+g=;
 b=seUqBs90/ZmFgY2bzSQpLvAXH++1PXZtT5uxKQQLrmmQtYQHpTVzdwMCIfD8uGwGeJ
 md/9sTUlgSt0PkpCsa7UpusLVXWj5my5DUIabY21yqY7ZXvM9D89R5MDyy1vwd1R0lV+
 /eE3PiGNlkcVzhX0SxTHy++O7LMx9Q1iLRDfZx9DNrNvh1Q0t5acdlwXy3h90Q7mRnM4
 ImOTMGbE2Z053uI+VE0b0fSvFUbl1n+Pams3fLyYAqgj4fYJYVfRABJPwM585TXmsDVr
 HAjTMLbEAI4LfYLyhSRPMBgZH5tWbLghtbgdcyXOqZXrtllv9LYVjnnRY3RemR6SZAKK
 P5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766500215; x=1767105015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cEFBdIohS4062D+O/J++uj/ToEv6MawI3RRAwg3mQ+g=;
 b=stkSkfNyrL/SiL3b3CLniNKpSzyKFLTv0Z9MlDopMYzhhpT6PDYGwlQXlK6GXc+KwI
 2Ot6Pd/NiUJ4U2wpwvoFR0q72KuRDsGdoYeXNQhR7rD5x/je5sjbtwvemwEQ6oOf8++w
 6hIg9AGKIrAqKNZ2zH+niHv6tDK/N72kh0XhfjHIsESUwCjMbKdh5Whti53TyYveYaE0
 UWtxB1RFC5f22YoDorfAQW+RTcO9jk1pjtAKoax8ROlDTZGPLhvkY/yR65pKx2cpv4Dp
 PH4Ee6IrAg4//xWoimWo4uYkdpzfydMl9JiY+Ae8rlRPIPfsVokSO4uaScmo9oTLeB2A
 4isw==
X-Gm-Message-State: AOJu0Yx8JdoFX4r6Eae4n9uByEwgfL2mHxtpyME8Ao2wbD6tfRNV/S2W
 k+TLXl19I+5xzWO3qBbgw5X5NeMDBHVdXAsNbGgNrEAvTAa9YOoKQ+56hYcCA8olqjDjcOJJ7CY
 r8xZZdbbSAYNnNzI4vy+JcgVAkPz7Tp7UWso+eFcVgmZ43c/j/DT9tkLQ2jucFGmaIAaLbESdhP
 LP7MchA37FBK5o9Dtuwu3HYcvAJ7FJE0T/Bae3Kw==
X-Gm-Gg: AY/fxX7kfBddmPeXdETDtKanLHSguw0e7SCcCYweQNWYYyigmzBR3P46o6OC1pGNg/h
 1o4sHlylGZYuKg8nV2HZaY0ir5JWYkG2z8a1uf32L5ewnN1DNnzl0PrgFdcc9zkMegSZ6IFb4Er
 +4Axbk0d0NhLc6fAZvwfiTud7xBx4Neb4hT4tTy86LKJBBJTHwbOhAbGX0Kk5Pk6nYvLVEDLbTy
 w4BI9kpHm1JZQsJCKyCDwNwrRBpEZDQzstl80a9L/PjnpvlW55y1+c41bT7w5vEc6TrfewUiZQR
 USiM9eW5ehBcbnuOFIbtaN4wjKW/B4+0PPWubu9zV49Ux6dArb+F+AbvyYSJ8/X46BJBiiXRXM1
 9KF4=
X-Received: by 2002:a05:620a:4149:b0:8b2:4b6:22d4 with SMTP id
 af79cd13be357-8c09002816emr2306246785a.84.1766500215194; 
 Tue, 23 Dec 2025 06:30:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9zCst7YcBgDo7sAKqu/hFO3OAETyOpzVWg+oqVNLEzBIzmVXoSV5ED7/pGRXdXoknLsrupA==
X-Received: by 2002:a05:620a:4149:b0:8b2:4b6:22d4 with SMTP id
 af79cd13be357-8c09002816emr2306234285a.84.1766500214441; 
 Tue, 23 Dec 2025 06:30:14 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c096787536sm1096163285a.4.2025.12.23.06.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 06:30:13 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 10/31] migration: Make multifd_recv_terminate_threads() own the
 error
Date: Tue, 23 Dec 2025 09:29:38 -0500
Message-ID: <20251223142959.1460293-11-peterx@redhat.com>
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

Make multifd_recv_terminate_threads() take ownership of the error always.
Paving way for making migrate_set_error() to take ownership.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Link: https://lore.kernel.org/r/20251201194510.1121221-7-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 651ea3d14b..52e4d25857 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1068,6 +1068,7 @@ static void multifd_recv_terminate_threads(Error *err)
     if (err) {
         MigrationState *s = migrate_get_current();
         migrate_set_error(s, err);
+        error_free(err);
         if (s->state == MIGRATION_STATUS_SETUP ||
             s->state == MIGRATION_STATUS_ACTIVE) {
             migrate_set_state(&s->state, s->state,
@@ -1434,7 +1435,6 @@ static void *multifd_recv_thread(void *opaque)
 
     if (local_err) {
         multifd_recv_terminate_threads(local_err);
-        error_free(local_err);
     }
 
     rcu_unregister_thread();
@@ -1535,7 +1535,7 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
     if (use_packets) {
         id = multifd_recv_initial_packet(ioc, &local_err);
         if (id < 0) {
-            multifd_recv_terminate_threads(local_err);
+            multifd_recv_terminate_threads(error_copy(local_err));
             error_propagate_prepend(errp, local_err,
                                     "failed to receive packet"
                                     " via multifd channel %d: ",
@@ -1551,7 +1551,7 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
     if (p->c != NULL) {
         error_setg(&local_err, "multifd: received id '%d' already setup'",
                    id);
-        multifd_recv_terminate_threads(local_err);
+        multifd_recv_terminate_threads(error_copy(local_err));
         error_propagate(errp, local_err);
         return;
     }
-- 
2.50.1


