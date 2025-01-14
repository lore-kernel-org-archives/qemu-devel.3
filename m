Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A8A6E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 23:08:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXq0y-0001rM-1F; Tue, 14 Jan 2025 18:08:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXq0v-0001qZ-SW
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 18:08:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXq0u-00043H-0u
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 18:08:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736896078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3J/rPBYuBb2FewjBzx58s7MHMBJWtOIl+Z3hEAriHYI=;
 b=WyEuC454pPO/PL6UA+5E+RblCoSSPUv5pfCHoZReq02+iTBs8getnt6M43KG8ELKa6jJca
 hqYR6Bz89bHK6dsD0uTkiRJmQEkha8QSdso950IC+Z6+MyMfMtev1JGn0+8KpFtE1civii
 ryeRa8B+HZW78GGOoYcji0X8gJiuwiI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-eUUhcY8MPDWjG5gB5KlaCg-1; Tue, 14 Jan 2025 18:07:57 -0500
X-MC-Unique: eUUhcY8MPDWjG5gB5KlaCg-1
X-Mimecast-MFC-AGG-ID: eUUhcY8MPDWjG5gB5KlaCg
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6d8edb40083so5804186d6.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 15:07:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736896076; x=1737500876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3J/rPBYuBb2FewjBzx58s7MHMBJWtOIl+Z3hEAriHYI=;
 b=ZKe8CgPIpCDXz/WWomYS+e05iBuZlRygSowK7ldum3cNEh8xdiyYXhLilQdhJauEWQ
 HN3dG7mjZDq+m1NECwfLhw2qaSY/3L4cyE5PjlvrDRWAin+pKWRVAFE2bh2/9O9hKaf6
 nge2Fy6ccj2e6HCu0AB0Pikf+x9a4POvmb+Bzi3gpLhAyenuLL261aVMLw2nBFbb2ODd
 D2CYHk2DYXiBNWtDUC6Uud/pB3sZjMV1dERd8dLb5bx2BBMZ8nBCJZMODmS24hVy+8ZR
 G7Auopr/kUgUWZWoZ6xGO2ZJ+BEKLEWD9zCcD1ZoAugJOiAEZWk1KCDkBJwrTmksaYbS
 zniA==
X-Gm-Message-State: AOJu0YzjNVHTlnWJjfl5dGbRDStCkwZURFtdwbgWKjjOlkUnyZ8euD9g
 18uvSJuLmE2zJI0EDPS/EZ+cd0VdKMdk5ORgIQwL+q3XmUHEJT1pqfmbYnFisp9v4ifLD6mdt9o
 0UP8LV6eEnGbJg2qyZxaMNHsHvuQnxyQg7A4OuDV32b1z3/htNkfmQgXrlU/UmAhZAb7VRc7Jdz
 kqMwyh+db6S6E5ukF5+OuAwT/Q+b/erbw34g==
X-Gm-Gg: ASbGncvGKoax2pKb24i5QWtavb2LZkVzx39D+9JfTJmpbdoxRzdT+VmGEjwk653mre1
 hKeMX/p28IiNWbDdyHZOvOymYnrgMl6MvBtfOhk1NULDV9LkJyqU7gdk/OBcO4E2fpx6bFSTxy4
 c91ksQRmejMuzabwoEkXW/2igioHDwnZF11sB/6ioroXk1KH9iJRJmgoFWGdQdb2nlvKuN9o9Ds
 dp9UeuuDlYPjA/J2ai0etepIygA3CYiwEpsrjRM9oKG0q/Lvh/uDOuPMfqtGIcqaA5tpm+1RaoD
 GLNsoDMNUAkX9h6tWfNE8p2tKZ/jKTN+
X-Received: by 2002:a05:6214:4304:b0:6d8:94f4:d2aa with SMTP id
 6a1803df08f44-6e192ba8f77mr13300656d6.13.1736896076597; 
 Tue, 14 Jan 2025 15:07:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEA1j1uzcCfD952uDr001iSj5ctgQyLTwui95k2K9oiuvWnqScV+0HA6nI8eJD/RzYSP7FyHw==
X-Received: by 2002:a05:6214:4304:b0:6d8:94f4:d2aa with SMTP id
 6a1803df08f44-6e192ba8f77mr13300426d6.13.1736896076320; 
 Tue, 14 Jan 2025 15:07:56 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46c873cd1b0sm59268971cf.49.2025.01.14.15.07.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 15:07:55 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 04/16] migration: Avoid two src-downtime-end tracepoints for
 postcopy
Date: Tue, 14 Jan 2025 18:07:34 -0500
Message-ID: <20250114230746.3268797-5-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250114230746.3268797-1-peterx@redhat.com>
References: <20250114230746.3268797-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.794,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Postcopy can trigger this tracepoint twice, while only the 1st one is
valid.  Avoid triggering the 2nd tracepoint just like what we do with
recording the total downtime.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 0eb28e850d..e1fc1a7fdc 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -125,9 +125,8 @@ static void migration_downtime_end(MigrationState *s)
      */
     if (!s->downtime) {
         s->downtime = now - s->downtime_start;
+        trace_vmstate_downtime_checkpoint("src-downtime-end");
     }
-
-    trace_vmstate_downtime_checkpoint("src-downtime-end");
 }
 
 static bool migration_needs_multiple_sockets(void)
-- 
2.47.0


