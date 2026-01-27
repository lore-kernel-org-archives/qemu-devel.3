Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAEBCD2FED9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkoBu-0003BL-G6; Tue, 27 Jan 2026 13:53:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBZ-0002x1-7q
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBX-0000h2-ND
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769539986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6LzUki+sPhQhvyEIU1MKBUpR5kFqW6js0HgQEmVSfWo=;
 b=XzTB3HSHXkJs7uOrIO+QacVLaAAkw5khPVB8bBtdInjTALW7WXRsM/0MGriGUB1t7j3Xsj
 ZZ725J2NJmLUjyhDYJXjKW+RiOXhPp0syK+P4MM93DuA4QunIUWP0uCxzi/hOYhVEUk25W
 LKk0L3f4uSXwwSVUfZdGhvidco0xIIU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-3Y3GiM9WOoOBkkDd-0_y_Q-1; Tue, 27 Jan 2026 13:53:05 -0500
X-MC-Unique: 3Y3GiM9WOoOBkkDd-0_y_Q-1
X-Mimecast-MFC-AGG-ID: 3Y3GiM9WOoOBkkDd-0_y_Q_1769539985
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-894709fbae5so199286146d6.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 10:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769539985; x=1770144785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6LzUki+sPhQhvyEIU1MKBUpR5kFqW6js0HgQEmVSfWo=;
 b=dYhVuFTfTfXWImUQ2LdHv6o8eCfRxZSKZUmirLspRQZMBERhkEPd9Hti19qITf9KXv
 YjCvKWXRxncELf+A/2mdMfbqUZTVY5HXU2GocFtDtOg2HvnAAb909O08Pp8lpP3vq/9Z
 SjG9tNUcQvTlPs3w/n8FwNWCtFfLIXQHq7ooGfgzSM54EvDW7GKdLu3okXQG5i0cA0s8
 PLPo8fY4mBjy9+NStEEF1X5IBcp83kAxeYGGyCvj9g9l0IMZOOUQLvT6Rrb7SrxtLITW
 ywON0JtwpEcX0NEADW5F/vn9GiMpSTY3UEqNjoD+SlkmGUhEnK32ZHryrBUUJkq/8gN7
 IZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769539985; x=1770144785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6LzUki+sPhQhvyEIU1MKBUpR5kFqW6js0HgQEmVSfWo=;
 b=P74R+KhAr2crXFJPE/QWrDK/nN4j++/ubdAOZQVaK/nDda+v7bnerEeQ87o7HWtcA6
 7r9p2uHaIqJZ11v1+m8EdzHRTn1+5oKEGPobIEokDvcondFWC23ZlrA5oHCH4jOJi8yy
 7cPBM9fSBeO78JWh4cKcxIXewZuvEDOqeN+ytF//q6yzBZ7lBAqa12ML31ZIMz/WoSms
 C+z3O0RRNwNpv7NIQLzkV1ajBIihEmytnp9WDdn4DmkHhXp7cl41ydLeTT/Lj8+Vgag1
 dhp8gEjq85MU5RxwL1AvFrqN2IAdet0rVM2WL7JQezHoTOlb/MBTF9ZuB9H51Ulm++Gv
 w0tw==
X-Gm-Message-State: AOJu0YzAMJYoKXkpYw81c19X7Izyd+V2iC67aFTYmUEVjZkJePSj1i9D
 5xSM6rMcCBhqRsD4fkLPWohucT07d3/lsWBC3x8sBzpVwktYAiAtcEWYFvDgZcdwh2cqjzZBAGa
 kFBwWnzfUhO6sGguYh6/X3N5EdCCgUpCk89gy38F1BZfcllprUVY60d2s80dcee9ImmKRY6PJYL
 v2hnvnzaKm1JJM1hJ7cYmDx6WeBTK+VaFfhA9ggw==
X-Gm-Gg: AZuq6aJ2Av7xDMnVyz1kfaJ/OB/kiVhWiBnTqNEBX+Oe7sMhX/sP+wcj07DVWtaCkcB
 zAOE1lUxGxyW85NhfzzhqldP6S/PZdwrZYjusG0Pn5Uq3H1mnpZ2YsMRl4kyvz/HA0nKTBOic1m
 FP7u7Vj4hVJ/ALsg54p7wjrBwpVs2afhGcvhXXSeXwzuKMk9WiZN1nGJYPhbM/VEhhSuLpJvcol
 SHmBTItuR75X2Po+4hIBqGqCRADpABGqsJG+gaC+JYAbfzYByABXOLfU77yiRyMtSL/YzsVtjHF
 Jm4669sxHJwfE8sy9BFJkplqEixIrv8/CgoMNfzTwWY2hFYPW+yVF+UHjfksoWhNO803s5wsZL5
 7
X-Received: by 2002:a05:6214:c4d:b0:890:58b4:3e7c with SMTP id
 6a1803df08f44-894cc8fdc8amr38580266d6.33.1769539984768; 
 Tue, 27 Jan 2026 10:53:04 -0800 (PST)
X-Received: by 2002:a05:6214:c4d:b0:890:58b4:3e7c with SMTP id
 6a1803df08f44-894cc8fdc8amr38579976d6.33.1769539984232; 
 Tue, 27 Jan 2026 10:53:04 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-894d3740e54sm2338466d6.35.2026.01.27.10.53.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 10:53:03 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Lukas Straub <lukasstraub2@web.de>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v2 06/24] migration: Remove call to send switchover start
 event in colo/savevm
Date: Tue, 27 Jan 2026 13:52:36 -0500
Message-ID: <20260127185254.3954634-7-peterx@redhat.com>
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

COLO (in case of periodically checkpointing) already have switchover
happened before hand.  This switchover_start feature never applies to COLO.

Savevm for snapshot doesn't have switchover phase and VM is stopped for the
whole process.

Remove both.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/colo.c   | 2 --
 migration/savevm.c | 1 -
 2 files changed, 3 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index e05736ecf0..c344943173 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -453,8 +453,6 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
         goto out;
     }
 
-    qemu_savevm_maybe_send_switchover_start(s->to_dst_file);
-
     /* Note: device state is saved into buffer */
     ret = qemu_save_device_state(fb);
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 529cf310e0..d41be3a4a2 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1830,7 +1830,6 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
 
     ret = qemu_file_get_error(f);
     if (ret == 0) {
-        qemu_savevm_maybe_send_switchover_start(f);
         qemu_savevm_state_complete_precopy(f, false);
         ret = qemu_file_get_error(f);
     }
-- 
2.50.1


