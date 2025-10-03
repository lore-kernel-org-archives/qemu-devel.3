Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C414CCD182
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 15:42:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4htj-0004oa-9d; Fri, 03 Oct 2025 11:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htP-0004jZ-Gx
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:40:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htC-0007NV-Jl
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:40:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759506001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PTgnvWqV0Dcjp7h/w+B8vYIAC0K0cwa6DdGQw4OrniU=;
 b=C4ge4Xwzevt2RVUS4BYVHDWWVpKWn0CAaGkimdWZwj/xn3oe02ydaU/pbNAlD3mSDyPyUs
 JTwrJUQShIL0VK+3jIqvxJa55mf4ma0RW94DdKtdVq8SfEtswuI5YiR9L4xA1UCpQ8o2OC
 XQY0N4Az3IxCxsH78eyXnNPGtfBmvwY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673--98GsGlGNiWM9ysMUeiV4Q-1; Fri, 03 Oct 2025 11:40:00 -0400
X-MC-Unique: -98GsGlGNiWM9ysMUeiV4Q-1
X-Mimecast-MFC-AGG-ID: -98GsGlGNiWM9ysMUeiV4Q_1759505999
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8741223accfso49078306d6.1
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:39:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759505999; x=1760110799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PTgnvWqV0Dcjp7h/w+B8vYIAC0K0cwa6DdGQw4OrniU=;
 b=BKvY+fTVYTr/zcvDb/0OZz2vOD/hSWwYIHK5qApEpG5Sb1WLMJGjxkzaXQeCxcfjsh
 h3Xb5uOKjKZmqhM69jFokbAAeokEdACM/0aBvOnKbPROpnEfPQpobsah67OUOMqBVmle
 5T2F699L3BJTRA31AyyQTgoxXFzIU/H3bDHRuMgPwbNpG0ZbWd5nc4kVOi+SVjsqxG9W
 NESiGQxbrXvtujq4fVubP4d+ikXCdC4ytRAKDi/Cd/V31xCKgz4a0UIRxFkr+TF8JC89
 WNAKEekaEpMAmpa1gtgs5R32T8Q8ARGUHreU5Q7oI5KCaulnI0FonjjRzbdP132VVf13
 TbKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSeW2OPV0RkmV0krODrycML+TSHsfhPRwy81TdOZH76k5vavR2JGYxcFxgQnlcTistCkAfhWHHh6+G@nongnu.org
X-Gm-Message-State: AOJu0YyhsE0cLWqYeJGXOAtpr3S2Ki0FGaoH8kK3W0m9zLQ4o8oRltNJ
 9mVZqLgNGmV9x7vGoohltxdqGt1iYcg7rSIKI+LiVcezvMYjGtpjyBrdJ65yBFvi8Rsn5+w6nrn
 MHHYkAsYHijHjMw5hRAJQ823HewZZ7TbHeACQNufCHbsAG2/AaPeug+v4
X-Gm-Gg: ASbGncskgXmi8KiF4BzwVPzJcA3vZV0TEwTNKdYym3PrbnKLyOZ2dhqewj6vOJ+HtJ7
 nNxZNXI6aDKXzKHw4dg/ozHZTfWsDFcW4REXQebcI7KIOvHtb18kcd7MpmNtht3eEujit918YgL
 KHecrW5AQ+v7j/SVRmfhnVtJqxdasV7Ta0CFgOXcgKrBcSgKqy5Eu2QeDhDB+30vPh8CO08yo/S
 ZZF757AhAkyMFdowrdA3BKsulGqLoQNinGPWYnMei1wb6TvbArxcpnnTRz9rmGijbKx801oMaoR
 iRmYyE0HJHAuUmoUaLx070QVYBPGJ44LLib+2Q==
X-Received: by 2002:a05:6214:1d2c:b0:86c:12e3:53d with SMTP id
 6a1803df08f44-879dc8428bcmr42784906d6.40.1759505999175; 
 Fri, 03 Oct 2025 08:39:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXCHXZTDaExsVr5NE79l3oHWn39T6dkWBmTVG8E7IqIDpvqPWS2k3eG6HJqVy6d3IEhHBDBw==
X-Received: by 2002:a05:6214:1d2c:b0:86c:12e3:53d with SMTP id
 6a1803df08f44-879dc8428bcmr42784436d6.40.1759505998647; 
 Fri, 03 Oct 2025 08:39:58 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb53d91fsm40656746d6.23.2025.10.03.08.39.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 08:39:57 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Arun Menon <armenon@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 04/45] migration: push Error **errp into vmstate_load()
Date: Fri,  3 Oct 2025 11:39:07 -0400
Message-ID: <20251003153948.1304776-5-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251003153948.1304776-1-peterx@redhat.com>
References: <20251003153948.1304776-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

From: Arun Menon <armenon@redhat.com>

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.
It is ensured that vmstate_load() must report an error
in errp, in case of failure.

The errors are temporarily reported using error_report_err().
This is removed in the subsequent patches in this series
when we are actually able to propagate the error to the calling
function.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Arun Menon <armenon@redhat.com>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Link: https://lore.kernel.org/r/20250918-propagate_tpm_error-v14-4-36f11a6fb9d3@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 8ac3d33814..fffea57cd9 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -963,14 +963,20 @@ void vmstate_unregister(VMStateIf *obj, const VMStateDescription *vmsd,
     }
 }
 
-static int vmstate_load(QEMUFile *f, SaveStateEntry *se)
+static int vmstate_load(QEMUFile *f, SaveStateEntry *se, Error **errp)
 {
+    int ret;
     trace_vmstate_load(se->idstr, se->vmsd ? se->vmsd->name : "(old)");
     if (!se->vmsd) {         /* Old style */
-        return se->ops->load_state(f, se->opaque, se->load_version_id);
+        ret = se->ops->load_state(f, se->opaque, se->load_version_id);
+        if (ret < 0) {
+            error_setg(errp, "Failed to load vmstate version_id: %d, ret: %d",
+                       se->load_version_id, ret);
+        }
+        return ret;
     }
     return vmstate_load_state(f, se->vmsd, se->opaque, se->load_version_id,
-                              &error_fatal);
+                              errp);
 }
 
 static void vmstate_save_old_style(QEMUFile *f, SaveStateEntry *se,
@@ -2692,6 +2698,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
     SaveStateEntry *se;
     char idstr[256];
     int ret;
+    Error *local_err = NULL;
 
     /* Read section start */
     section_id = qemu_get_be32(f);
@@ -2741,10 +2748,11 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
         start_ts = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
     }
 
-    ret = vmstate_load(f, se);
+    ret = vmstate_load(f, se, &local_err);
     if (ret < 0) {
         error_report("error while loading state for instance 0x%"PRIx32" of"
                      " device '%s'", instance_id, idstr);
+        error_report_err(local_err);
         return ret;
     }
 
@@ -2769,6 +2777,7 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
     uint32_t section_id;
     SaveStateEntry *se;
     int ret;
+    Error *local_err = NULL;
 
     section_id = qemu_get_be32(f);
 
@@ -2794,10 +2803,9 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
         start_ts = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
     }
 
-    ret = vmstate_load(f, se);
+    ret = vmstate_load(f, se, &local_err);
     if (ret < 0) {
-        error_report("error while loading state section id %d(%s)",
-                     section_id, se->idstr);
+        error_report_err(local_err);
         return ret;
     }
 
-- 
2.50.1


