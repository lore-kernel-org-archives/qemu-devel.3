Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C66F3D2FEDE
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:54:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkoCg-0004aA-VP; Tue, 27 Jan 2026 13:54:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBa-0002yn-0l
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBY-0000hJ-7d
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769539987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RcEEeA3IAzUX6E/mkEQIUngWTHTkfCumqYLXJe5PBpQ=;
 b=gUezxJrmws0CCtoopefbejnsZR0VkGmea7QJlUgEUmiS0q3XJoxzqk4TEjKD0FxgFBM5cy
 D89XxHQoOGrl5nt/bebooet+FYwLgmW6rwcr2FhVNS7rMfICgdvVLB1/fbXz9T5q4F71Xw
 Eff9loTVKMWk1CORmux8xXqTbkkrxIk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-ZtASXJwWNbOJ07ksYl0RUQ-1; Tue, 27 Jan 2026 13:53:04 -0500
X-MC-Unique: ZtASXJwWNbOJ07ksYl0RUQ-1
X-Mimecast-MFC-AGG-ID: ZtASXJwWNbOJ07ksYl0RUQ_1769539984
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-894769f8732so290376226d6.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 10:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769539983; x=1770144783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RcEEeA3IAzUX6E/mkEQIUngWTHTkfCumqYLXJe5PBpQ=;
 b=g2yjqHldyr6InyZBQyfzceljY8xhoOKrM/BmCkuQfLRSc6eetu4yDtg3GSe8AELMc3
 Cf4NznKW5m1aEh2t+txcMZCjsGhDlZtSio//CNZO64gmh6fO+QXImUFRQT8RfNBT8AEb
 Ml5tT74+OblJhUaPFHN7LaQf6102Gs5gpCDkqFGD6NWPTu80XfT2QZwxjgRhmFNQ2+0n
 h1dkdvNg/I0HHuOUbXo2C/PMYKr1saLrXvLm6suTdOhX9H+Tk4cZawGL8li8lnSYlWCm
 wJITgIuz1czuJHyomh97UqTzOGf6mBCn2gY5nBApc5zQajoCxTrZIInKc8SKE1sxhrNo
 1ELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769539983; x=1770144783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RcEEeA3IAzUX6E/mkEQIUngWTHTkfCumqYLXJe5PBpQ=;
 b=dz/EdziWqTuzEPojINFWQEPxltZOgcRf1MvPioPjO2QJMl4Qee1xdiuRnlNO4iiNlr
 gCPZLvg0+N6SqwH6vsWWZjJd3oSM26Z80CtA/aJ7SbwvtF4Tc2Ea61rsOtJDBlHvfBKj
 kQsTQzlzOVfbHOeYdff+LlLe1L7WT2ipu83NsjjublRDGGJPxF9apmFAcDaoqHbbotIv
 cixOCetH4AmrkrhIZEwms7fbHEFF/7zittfQSjpKzw3jD5SQA/QPHJqjiM90DY/lbOsX
 GIMbXd+09Q3PA+jdOHvxJ17riaMm0Coo4PyhYg8KDQBd8f6WemAebbUWYa2T3dfG8BUZ
 +9vA==
X-Gm-Message-State: AOJu0Yw3lCsn0Q6krwohZJcjTuX7szsvaGWXQdwL00UIaGut8p7kgzez
 nOsJl19Ze8cfxLPV2ElASn0LvtPYQqChUq/x2I7Ji3K35bQVfZpilKlvIlX0aP87JO3cV/fl8bk
 nLgtOQKFOBv0KJ9u+8IpXlh1kafcwLBxfR7P7mXlVDwNcepTU3KwBZxG9kgIZjnaWy0DHCHARqH
 UTKGsjr09/7he/DHUuseuzYMgyO8h8ZGSedUNOEA==
X-Gm-Gg: AZuq6aKo2NBq4Wp2fe1WWplLGz1X0OHqlAKisyphzGxbWwA464Po1Cvh1Atgb49z/VV
 XlPKCIaYAQJg94IcF48Ct0r1bCAlNr+0rEyl7HhujbECPyxZiCeVgYLca6mkjVdqMnFlZ5lNEvo
 rQCQ5rg37tgupJ8+oUKm905C2BygMb0II+iUBWx0BETQF5Uk+PiiBqgqr+knHmIIVL2TSrEfAuo
 yjyqmvfYWugdpsRr2flONogqw1v7eWULbY+1h19VkYNrybJBVIWik8n/t8K9vcDIkRNv7RFN6yZ
 zj3Bsgze0rdLMLB9/JlEaz26bT0vBVkAwKnPk+2+PIMZnq6jIfYOGUf6TuMhpUWx8B3OgvDYE9X
 v
X-Received: by 2002:a05:6214:f2c:b0:894:6e62:ac9b with SMTP id
 6a1803df08f44-894cc93d518mr37561496d6.57.1769539983306; 
 Tue, 27 Jan 2026 10:53:03 -0800 (PST)
X-Received: by 2002:a05:6214:f2c:b0:894:6e62:ac9b with SMTP id
 6a1803df08f44-894cc93d518mr37561116d6.57.1769539982764; 
 Tue, 27 Jan 2026 10:53:02 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-894d3740e54sm2338466d6.35.2026.01.27.10.53.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 10:53:02 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Lukas Straub <lukasstraub2@web.de>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v2 05/24] migration/colo: Unwrap qemu_savevm_live_state()
Date: Tue, 27 Jan 2026 13:52:35 -0500
Message-ID: <20260127185254.3954634-6-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260127185254.3954634-1-peterx@redhat.com>
References: <20260127185254.3954634-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

It's only used in COLO path and only contains two calls.  Unwrap the
function.  It paves way for further reduce special COLO paths on sync.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.h | 1 -
 migration/colo.c   | 3 ++-
 migration/savevm.c | 7 -------
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/migration/savevm.h b/migration/savevm.h
index 5d815af742..528607f09e 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -64,7 +64,6 @@ void qemu_savevm_send_postcopy_ram_discard(QEMUFile *f, const char *name,
                                            uint64_t *start_list,
                                            uint64_t *length_list);
 void qemu_savevm_send_colo_enable(QEMUFile *f);
-void qemu_savevm_live_state(QEMUFile *f);
 int qemu_save_device_state(QEMUFile *f);
 
 int qemu_loadvm_state(QEMUFile *f, Error **errp);
diff --git a/migration/colo.c b/migration/colo.c
index db783f6fa7..e05736ecf0 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -471,7 +471,8 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
      * TODO: We may need a timeout mechanism to prevent COLO process
      * to be blocked here.
      */
-    qemu_savevm_live_state(s->to_dst_file);
+    qemu_savevm_state_complete_precopy(s->to_dst_file, true);
+    qemu_put_byte(s->to_dst_file, QEMU_VM_EOF);
 
     qemu_fflush(fb);
 
diff --git a/migration/savevm.c b/migration/savevm.c
index f1cd8c913d..529cf310e0 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1854,13 +1854,6 @@ cleanup:
     return ret;
 }
 
-void qemu_savevm_live_state(QEMUFile *f)
-{
-    /* save QEMU_VM_SECTION_END section */
-    qemu_savevm_state_complete_precopy(f, true);
-    qemu_put_byte(f, QEMU_VM_EOF);
-}
-
 /* Is a save state entry iterable (e.g. RAM)? */
 static bool qemu_savevm_se_iterable(SaveStateEntry *se)
 {
-- 
2.50.1


