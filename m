Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B4AC531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 15:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnHqp-0001PT-Sa; Fri, 24 Jul 2026 11:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wnHqh-0001On-Kj
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 11:30:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wnHqe-0001fz-W4
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 11:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784907004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t72qd/5MMeISsDYxcEFSV8VQkDzS+BmegPPiwhmLeO8=;
 b=BqLOW8CNlSWAL6wiJ1tyKLDK8w4CW4qQHDbTkF0ZukXN1BjVVUAc60mXlC//vTmmeJq2La
 pRc9PTAzdhAnt0KJQbDxnhwonBLX6OozpQmLrxeJASfiKF7isj4OXppsklx61Gj0L6Ig2q
 0HRvYDlU1cmQihjUpAbUWUKJcehLP3U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-Kgkep8pyOgmLwPhwjnP6ug-1; Fri, 24 Jul 2026 11:23:33 -0400
X-MC-Unique: Kgkep8pyOgmLwPhwjnP6ug-1
X-Mimecast-MFC-AGG-ID: Kgkep8pyOgmLwPhwjnP6ug_1784906612
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4956b4cfe19so5399735e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 08:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784906612; x=1785511412; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=t72qd/5MMeISsDYxcEFSV8VQkDzS+BmegPPiwhmLeO8=;
 b=HloEUnrWVae4EVmzjBARdRYJL9yN52fmqDYHnl/93RJB5x4sYArwgUB+MrfngvrAXa
 TmlcxxdMqcIWHeGX2uZD4ifMnUoYEiU/ZsgnLq56GITXtO1fYMg3XQwaJzFy7Rdhjtbn
 bmRElbsH9d2IOGHRe3b1J/7S36Tcs6q+xKD7NI5+AZ3rCCluguNUYZ3nNwB6WseYxvao
 keaREodNA4hl4g/XZUK+Zo2yYnjtZ1rwVcborGjEmC6BJesQluvEF4Wuk8J7nuz7pi7a
 Cu//mk9aLNczcgbsoYLvR1/0WhW4mqEcM5ZLom99VuPVgAC6zHH/tIXw18TXnnYMXlog
 vmzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784906612; x=1785511412;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=t72qd/5MMeISsDYxcEFSV8VQkDzS+BmegPPiwhmLeO8=;
 b=qtrQccqQQwtZBjs8Gi6kj8kSouW0i4yY1R3+rgl0WkMwxkJ0owVjiNS58K2thJF8Lx
 76Up6cEx+EuEnysfXro5aML95CB+KeqaQzQlTxbzvqm5QbhGeGSmGlwBDCJhG1PJxPxL
 B6fFp43IWaRaTXqxpwFEBbjJcAEMGIPX1L939TnsG5Q7qiOvZmkJ+8bP7Z4+kCZBoeup
 UUVtFWbpPQ2aC8394Z042BX7m5YRo9UfBeQfxrAgzB6yRvfA9dnCMs4Iv3gUEuSTzSNs
 NSAzWHC1/yHiqcPEow69zbE8Q+ugOYlDMM75PMGmgLOPUnoHJZZIjxiqNVKM40sMSJ0a
 aghw==
X-Gm-Message-State: AOJu0Yxc8gEcbSX8EK0L5g9eTQDnXQ1/ktSWsu21frJqg13fyE2zhTf3
 NTg9z3HdeNcEKp1La84FA3amAyoVbCalCsKeLk+HYwJje6Jh2mcxilLgIlOKeF/Nbw4X1jnCc5G
 UOGAO49Z4fGeyZ9rXjCdQk8GVidvoIN41Ou4tW9x+FABFZlT3fBITrCl6
X-Gm-Gg: AR+sD129KD1ts/fWaqmxav48Uk422hSW8zo+/F7vBaHXF8PNTV5Qw/JgKeBoz/pdvxP
 WIylQNFH050lh3TO2cTQawcc2Iv32NJyO5pM1sWdNhSsNbj8VAiUqpS2/CY/62BxqHFikIzr0di
 4URWQ3B9BzHW9ufV/nUN+Rjs+Ssf9Nr6D1eYoht0wb4smz0LSpqJwHDw5yjxgg6/bQCkpLLnuRA
 1t8L7+O3S3aFl14mWfSiGp7L+JqyZGYJhXdvGMksGHg7LZ6so63rKtt3JDq0U1HhUSI/zMuBHzL
 n89lFp8TLZEsSQ9jZKQvPallfBvUCeQo+84IBiyOdTmTm+q5oihzyJVnEq7PQNxjqZWr8hFj+gx
 2ggi13HWU/m0PRQT9511L6L02QDhJcTAwDqyhPj6d9WPFISJZbAS/pHNl2qQ=
X-Received: by 2002:a05:600c:6dd6:b0:493:eed4:7210 with SMTP id
 5b1f17b1804b1-49573cc97c2mr64644985e9.11.1784906612040; 
 Fri, 24 Jul 2026 08:23:32 -0700 (PDT)
X-Received: by 2002:a05:600c:6dd6:b0:493:eed4:7210 with SMTP id
 5b1f17b1804b1-49573cc97c2mr64644815e9.11.1784906611695; 
 Fri, 24 Jul 2026 08:23:31 -0700 (PDT)
Received: from localhost
 (p200300cfd7075d8bc03b74903e90fa9c.dip0.t-ipconnect.de.
 [2003:cf:d707:5d8b:c03b:7490:3e90:fa9c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957b842691sm60213175e9.1.2026.07.24.08.23.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 08:23:31 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: [PATCH 6/6] hw/scsi-disk: Fix accounting for IGNORE, ret > 0
Date: Fri, 24 Jul 2026 17:23:15 +0200
Message-ID: <20260724152315.234183-7-hreitz@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724152315.234183-1-hreitz@redhat.com>
References: <20260724152315.234183-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When encountering SCSI error status (ret > 0), accounting is left to
scsi_handle_rw_error(), but the BLOCK_ERROR_ACTION_IGNORE path in turn
leaves accounting (block_acct_done()) to the caller, so neither side
does it.  Fix this by unconditionally calling block_acct_done() in the
IGNORE path.  Yes, this will often result in it being called twice, but
that is a no-op, as block_acct_done() resets the cookie type to
BLOCK_ACCT_NONE, and will only do accounting if the type is not
BLOCK_ACCT_NONE.

(And given that the conditions on who does what accounting are quite
confusing in scsi-disk, for me at least, I prefer this unconditional
call rather than guard it with a condition that has no obvious reason.)

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 hw/scsi/scsi-disk.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 1b0cce128c5..92b63b64d56 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -318,6 +318,13 @@ static bool scsi_handle_rw_error(SCSIDiskReq *r, int ret, bool acct_failed)
         return true;
 
     case BLOCK_ERROR_ACTION_IGNORE:
+        /*
+         * The caller may have already finalized the accounting cookie
+         * (e.g. scsi_dma_complete() for ret < 0), but calling
+         * block_acct_done() afterwards is fine (just a no-op).  Just
+         * make sure all cookies are indeed accounted at some point.
+         */
+        block_acct_done(blk_get_stats(s->qdev.conf.blk), &r->acct);
         return false;
 
     case BLOCK_ERROR_ACTION_STOP:
-- 
2.55.0


