Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4B4C44508
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 22:34:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viglu-0007iS-Ly; Wed, 21 Jan 2026 17:33:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vigls-0007hL-Tg
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 17:33:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1viglr-0003hq-Ic
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 17:33:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769034830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2KwvTwTZNUx6XnV2kEuNhbSXL8eCltMIYuLBDkLqe2k=;
 b=h/HtmXycMSWHzz1s4uSvS4Baki0oakVq8sZQmx79vg3/KG4Qk2hnlyy2TX9PS3BscoMOn8
 kgsY65WbvgUbZLUUgjM+RPYUnD6KCbPsaoxtgUCbJBcVPYeFRwHozMqZq+0OdTXvKeopzq
 pKj6vqcZH+GbpxP+NqSpiWP0tRc3HlU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-Huw-2kPROnGvPs5vemwCaw-1; Wed, 21 Jan 2026 17:33:49 -0500
X-MC-Unique: Huw-2kPROnGvPs5vemwCaw-1
X-Mimecast-MFC-AGG-ID: Huw-2kPROnGvPs5vemwCaw_1769034829
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-88a2f8e7d8dso12273726d6.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 14:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769034829; x=1769639629; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2KwvTwTZNUx6XnV2kEuNhbSXL8eCltMIYuLBDkLqe2k=;
 b=R2kkvxJ1IyfWuHjr4I63jlPYCcH/kUJ6AQ6d0/ykKB+AjvdvPPwwa5HghpGpKlyseQ
 Kti+KPHiZnYHM3/PTyXB9Un3WGBwXivHHKltmzMfnKIZ1/xZV1f6595Tf55phxVuyOkh
 R4JRP8fjUQPsUAoSoNEEU4UZ+LD7RzMG5Sbk72IOQ8Gd60kswLdo2vJhezKt/SATP+xv
 09qVPNaZXVNZA5DiZFsWAFb1b8Vx5UCDjz8pVhZiXjZl3ulld4xw+nM0c3vRp0jHN1cK
 AgiHZ4kikA6526yt4XGr+ipZjuM6vjqhG5nKiStSvDLKa4mmA8NEq1P4cY8ngxsmYLXk
 cVVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769034829; x=1769639629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2KwvTwTZNUx6XnV2kEuNhbSXL8eCltMIYuLBDkLqe2k=;
 b=fPAyoDbs8zAaBd9Z92DWHQEpvyE6w1SJ1IvbF06KCWRdJQB8+e8FxMD0b1Vc7e6JcY
 tnpvDaWYM3TGLmNZ/HuLiooZ9yNthf2EE2QGNjI7/7ISZB2rt2JIXmf3jyS/gYX5p5x+
 EJawMRBkDGoiYAxlh3p/IWiFuSTAMUdN6e4B32t1HQqt6s8NQvp/JU8vaX1asLm/Uq0p
 jAEb/ScbGgHEZy4532YuXjCIqweCrZw50T/hSsp19hOfKLsyPyJNmAekWGSH180hOOMk
 CSNu+4QJbP72C1UiT/JKO/pXRUSbo+wZs8d9tcp+afor4+LU/Kz534u+cGSPzth6RD5p
 wDrA==
X-Gm-Message-State: AOJu0YyBEUTSxlIJ3k2KQpNJo9bVTo43ugiT0YbI9KWXFpDDl+jcLXlb
 nKQp/hQLMjW6RfzXc9wPjGMkmLmUcSAyFLmaAal78TmfJWn7KdAC7ahb2W9dJOIFw4kEYw5beSx
 qdxnLKGzZAcpiKd6HszE039dmhQXral+W57d2yO3/sSNzv3UI5vOJ54EelQCwkDLUofEEPqDq+l
 Xng47ZZ3yJH1B9GdGjbPhfCYLKqKrTsCT9c9plVA==
X-Gm-Gg: AZuq6aLb6NDAMNou3Ym0xMXCF2UZ9dVXZ578Uk1CNkmOdixP0dvzDJWo4VT+gc7ULfu
 /UWzGQGnH5ANjRHy3MrxMn3eYOQLqKM65df3uSPe1fP6TWtLofcIoHvlxxZkyIxcsQhJwwWOkbd
 jnIewd9jz5FWMZO/7FGMtMNTw0/nbPnk05Yf8cca99xGhFjkgrpmVfIqbT+4UZ78WD4YHLObbex
 xFnd6Wjar6Io/FYuoJ0HkCUgo7naD6LnL+tqe3+7PzwlEf070o8n277Lzvi05hkBrA1zObAOKAz
 GmOhzjTJi9MD/ajMFFmSjFHEEbrqvdLM6FZsyt41y5+RTLaq2HHBBCRIL1IuSn7Sx/lRPTLAUyS
 T
X-Received: by 2002:a05:6214:238b:b0:890:65fa:1ec2 with SMTP id
 6a1803df08f44-8942dd3ff30mr303011176d6.29.1769034828813; 
 Wed, 21 Jan 2026 14:33:48 -0800 (PST)
X-Received: by 2002:a05:6214:238b:b0:890:65fa:1ec2 with SMTP id
 6a1803df08f44-8942dd3ff30mr303010736d6.29.1769034828326; 
 Wed, 21 Jan 2026 14:33:48 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89470b0ac3fsm25598306d6.25.2026.01.21.14.33.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 14:33:47 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Juraj Marcin <jmarcin@redhat.com>,
 peterx@redhat.com
Subject: [PATCH 06/10] migration/colo: Remove call to send switchover start
 event
Date: Wed, 21 Jan 2026 17:33:31 -0500
Message-ID: <20260121223336.3381912-7-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260121223336.3381912-1-peterx@redhat.com>
References: <20260121223336.3381912-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
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

COLO (in case of periodically checkpointing) already have switchover
happened before hand.  This switchover_start feature never applies to COLO.
Remove it.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/colo.c | 2 --
 1 file changed, 2 deletions(-)

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
 
-- 
2.50.1


