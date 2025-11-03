Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DEDCCCFA03
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 21:07:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG1lR-0000xc-PV; Mon, 03 Nov 2025 16:06:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lN-0000vm-4V
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:06:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lD-0005Dq-VB
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:06:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762204000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TgTvwcoVK4MIab8Yq/SxirUQSgGyWAAVwBn3bLNVjNo=;
 b=eKf6gktn+750PKH/U+UKxNa80z3WUObj/brN47Eb4nF6GpFobVLJfq4VvDV/2IU7pTlHkc
 fqKZGEFby6e+BFOzuxW8cRs0Bsqa+UpnXXtCmOOh44yHA99v4q+69mB5GgalS/TrHJfAV8
 2m5gMDOeMe3CsjJQi0bhDLINdsDSB84=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-r8z-gm2GOUG1heQeedKlvQ-1; Mon, 03 Nov 2025 16:06:39 -0500
X-MC-Unique: r8z-gm2GOUG1heQeedKlvQ-1
X-Mimecast-MFC-AGG-ID: r8z-gm2GOUG1heQeedKlvQ_1762203999
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-891504015e5so1501263385a.3
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 13:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762203998; x=1762808798; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TgTvwcoVK4MIab8Yq/SxirUQSgGyWAAVwBn3bLNVjNo=;
 b=lcKKHDF7x5nWoawVibhYPS7rv5jMJzKNV3S947T5KuHrZenpPgsraPMDKatqOzNroj
 nKG2TW2G/amXQeTxj+TCu9rpvx1Nejz4wyIleYjwMIua0oRgZUg9xYWkqkbxiy69EviU
 AV1ueXHyLccnz8l2vgjhGLGEcXxMkivVql46bU9OBKH4l9L6F+SVxdIb9m4vLZGieHRo
 Uhas2ERHdsKAl27Aqs6dWGfZzb7OLMG/BZFnYomNa3I26PmgdGcc1vNZVRHQk3gd+sXm
 mtrZEBxguXqjUy8JlLS0DmmQ1/n2QAZ9HkEnYm/N8TCEuY3Epfo0q/0bGAoa9QDNNF1q
 blJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762203998; x=1762808798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TgTvwcoVK4MIab8Yq/SxirUQSgGyWAAVwBn3bLNVjNo=;
 b=fgbpRKG7UV7YVLbGdj31H3Vw2RpPNmmJcjouPPnJh5uvlCoPX+1f8SE47cs5siix9M
 1oS/9dCcaGZq3jHSjlWwLIxwvBbG2UNGvt7RAMArILHgAGX9gw8kVTEUjcpck8TNYRuv
 VdW0vbJNJZp998N+XovvrlvK4SKwXYoGEFQUfQi3CdAhjQQ+DyxUV31uZhr8h8X8gzBv
 JqXEpYw8f9f0tSeZACSA5YrWviJx5aHrEBbBzVUBgXBaBmDQJcvR3znmauDZmAfhKBlx
 kR7w8FzHAaZfCSTCPNhkAtWAv79+V0IpsSZ9dphRliRtgjxIcp1tY5YPbidagx25FqIb
 tRxg==
X-Gm-Message-State: AOJu0YzWeT8e1vbbMehjbhxht0zYAvXEtV4Vwby0E1PojnE5PvV/0jYj
 livog3BOMnZa2bWD6J/3S5pK3kEF0GIKTvsEnbE/+vWYX58fEdnhgWp3BaEfoolEMLBF9fxTpxR
 eTFu6aZJ/hX7uIblU7aip84mqnAmRFFqaGm+01nmvwrTQnX5QhQPhEYgnTqZEnO31KI+Mlf+JR5
 a4DJ2qtheRFDT7yPrJAUR+XAbeIMX7drB0eplpxg==
X-Gm-Gg: ASbGncvPQXMG+pVRwU5pHBW9D9L4y2LJFK2GCQrZJ2kljAvtfjkY4nZQH+0m2B1iLQn
 zVrwmkpDo4KEYUWLz3YQSNJauU5GsDzYZpkXRBGjFiCJWb77W03uRfgdRBYjqC6W2FHBHqKUlss
 xG4zMNSXC+UfEftZWrK2GdvXsK5afRY51U8lFO6tu7ChNLN0sEapG65u0CgncjrLs2JmQv3CmJJ
 5Vvo5PoPa0nL7EptC/XIA5sUVentpDR1GmbkU+DTJyXLLGNpvOhylLvBLFtIuRi37qYZairZrNa
 MutikMvGKApXadUbc0gGojfsDEq3VvNyqG8ZBBgbGfCxy7ua1Vm2bd8GeZN042vY
X-Received: by 2002:a05:620a:4493:b0:892:5b57:ea3c with SMTP id
 af79cd13be357-8ab98eb5112mr1582829385a.2.1762203998429; 
 Mon, 03 Nov 2025 13:06:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKk0+JecMyMrdeB4AH7b+wJtIJTmyQ3kLsh8hUyco40zH0J3CHSG+eze+pk1lTcXuOL7GYLg==
X-Received: by 2002:a05:620a:4493:b0:892:5b57:ea3c with SMTP id
 af79cd13be357-8ab98eb5112mr1582821785a.2.1762203997719; 
 Mon, 03 Nov 2025 13:06:37 -0800 (PST)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b0f5468968sm57428185a.19.2025.11.03.13.06.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 13:06:36 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Arun Menon <armenon@redhat.com>
Subject: [PULL 07/36] migration: Fix error leak in postcopy_ram_listen_thread()
Date: Mon,  3 Nov 2025 16:05:56 -0500
Message-ID: <20251103210625.3689448-8-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251103210625.3689448-1-peterx@redhat.com>
References: <20251103210625.3689448-1-peterx@redhat.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

As reported and analyzed by Peter:

https://lore.kernel.org/r/CAFEAcA9otBWtR7rPQ0Y9aBm+7ZWJzd4VWpXrAmGr8XspPn+zpw@mail.gmail.com

Fix it by freeing the error.  When at it, always reset the local_err
pointer in both paths.

Cc: Arun Menon <armenon@redhat.com>
Resolves: Coverity CID 1641390
Fixes: 94272d9b45 ("migration: Capture error in postcopy_ram_listen_thread()")
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20251021220407.2662288-2-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index aafa40d779..232cae090b 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2136,17 +2136,18 @@ static void *postcopy_ram_listen_thread(void *opaque)
         if (postcopy_state_get() == POSTCOPY_INCOMING_RUNNING &&
             !migrate_postcopy_ram() && migrate_dirty_bitmaps())
         {
-            error_report("%s: loadvm failed during postcopy: %d. All states "
+            error_report("%s: loadvm failed during postcopy: %d: %s. All states "
                          "are migrated except dirty bitmaps. Some dirty "
                          "bitmaps may be lost, and present migrated dirty "
                          "bitmaps are correctly migrated and valid.",
-                         __func__, load_res);
+                         __func__, load_res, error_get_pretty(local_err));
+            g_clear_pointer(&local_err, error_free);
             load_res = 0; /* prevent further exit() */
         } else {
             error_prepend(&local_err,
                           "loadvm failed during postcopy: %d: ", load_res);
             migrate_set_error(migr, local_err);
-            error_report_err(local_err);
+            g_clear_pointer(&local_err, error_report_err);
             migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
                                            MIGRATION_STATUS_FAILED);
         }
-- 
2.50.1


