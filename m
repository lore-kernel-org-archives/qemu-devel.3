Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 247D4D2FED9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkoCk-0004zb-MY; Tue, 27 Jan 2026 13:54:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBc-00032n-JZ
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBa-0000iM-Qn
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769539990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YRGJSJKdyQVd/Cr4isDC+mRPgefExLoIMOCxpKtf0ro=;
 b=HHvCzPEh5F9/9IlgWXUFEn6cFbUB87l/yS0Ovw6Nds4W2kgkdgI7TE9F+mx/H9VyjT7uYC
 aXLrE4hKgvLekoHMfsRPw64ZTPaMEdt1+NHxqzxEiztsDrrg981UBru+CAG76+WIxJNnuO
 xPFUJG7uqnevmbsSYoEyo4Aoj+qhuNI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-lqcKdswJMGyRxcRuL05FYQ-1; Tue, 27 Jan 2026 13:53:08 -0500
X-MC-Unique: lqcKdswJMGyRxcRuL05FYQ-1
X-Mimecast-MFC-AGG-ID: lqcKdswJMGyRxcRuL05FYQ_1769539988
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8946b186018so252497386d6.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 10:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769539988; x=1770144788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YRGJSJKdyQVd/Cr4isDC+mRPgefExLoIMOCxpKtf0ro=;
 b=GftCUbQhDCt8rtsrXdSPpLnC5lKhY5XFH45Yb8j1FG9yCsVhjLuDJWa/t9cF0/bIG2
 neb1PVOusRc+4KP3gYa7NNqb5i6CU/b2GPA6ALY5w4pGtM92Y5NwHGVzjHvvzv9nB7nr
 ZUX4K6X+FmSY3KinRloWDUqHxxKID67R+EfiE+mxW4c/cxEIxBdUYum5iK9dY4nh9Rcz
 ORaBLsZGMPn7yHljSTwxBH/DaMsucj0FnMZtv9Q20dqhaIoFfx7wng3f/0mfZVZHracX
 DGt4O+alrc5hLF5cdz8/4roO3yVQiSh2huOmGDXDFEaG4YidYEkc1obvAzhOEmsF0++L
 s5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769539988; x=1770144788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YRGJSJKdyQVd/Cr4isDC+mRPgefExLoIMOCxpKtf0ro=;
 b=wa+D3HsEBl1qeoCdiy1mG9+I7oB77KZ9CzSBHkDqUmH26iObe6N8QabQTA1B4Ddv0l
 rDgkUqbzJcsYn3ayAIopA7mdudyP5ynUXAwwahABRhrTj3dNirASonusLDd1sBpm/aGH
 ycsSG5O/qRRgVtCDwl7ADLZ30WXYn0xTk2Tj7+5WFPmw7Rxh9iS+uFPUoTaUA01kQEbc
 /rnkWX8OviCo1xRIzdXIJNVxloxi3zr1hvu81URSnWB4nUsx489Hm9JgmQHtJB+UM/eC
 b9xXrJjH1j0vq5XvIGigk97H9yLKeaYY36gPwjSinKaI2NPRNDZE97rn/63WLv1cXLLJ
 he+w==
X-Gm-Message-State: AOJu0YwOPwvRhksXOUjTpfu145btw50HDJVVGEb8UmA5FdIrUh9K4I2/
 udIQniqw9cXmu2kYHdFmg783j4Lx7sAr53e3kdjxZdnOwV0Tch6nmdXR4H1LWjLaPhBwtJWXfKM
 XoCnONEKakjaswfg1MCtO7kNJJ0X/gCDd1C9/8MgsxGDwFqf7cAQ+LSaYM+/XDG9kww0d2vlFRm
 a77ryB5oDdNousm+aPp1QBa66gC2cttuTooi77gg==
X-Gm-Gg: AZuq6aKQvihLn8m+4Lykp/CctZzoGMcBEjniGRm6XUfeQwQG0496U5Ckn1NsSMeyLl9
 4qtkzS1HoAYOUbG1uGih7rkW1oS32zIZ3MUszMiVYclVh5msyTU8f6bDZTk3GatHxvjT4L5Ozia
 SWA2MII7nACv75/iMABt3JPl8ZSZfU7pdNZGS4tBUi+LoaF+jyJDih8sn40jDuNrQdAgpIsG7nO
 sAT5tfWYy6A79N4OvbZmN68ekdlrVMHfRKQ2QJ8ZFF156ma/AkNN3zOGM8CkRG4UC6FMPerqXTv
 GGHRlr6iXenrkwmNbGKmOWhhi/N1MCyD8sve0iO2vI625fGvWPK5jh4lAtlfoERfb+ULlzbRnwr
 9
X-Received: by 2002:a05:6214:21e3:b0:7e3:cc6e:3c89 with SMTP id
 6a1803df08f44-894cc955bf3mr38752366d6.56.1769539987752; 
 Tue, 27 Jan 2026 10:53:07 -0800 (PST)
X-Received: by 2002:a05:6214:21e3:b0:7e3:cc6e:3c89 with SMTP id
 6a1803df08f44-894cc955bf3mr38752016d6.56.1769539987283; 
 Tue, 27 Jan 2026 10:53:07 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-894d3740e54sm2338466d6.35.2026.01.27.10.53.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 10:53:06 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Lukas Straub <lukasstraub2@web.de>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v2 09/24] migration/colo: Document qemu_fflush(fb)
Date: Tue, 27 Jan 2026 13:52:39 -0500
Message-ID: <20260127185254.3954634-10-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260127185254.3954634-1-peterx@redhat.com>
References: <20260127185254.3954634-1-peterx@redhat.com>
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

COLO caches all device states in a buffer channel `fb'.  Add some comments
explaining the flush, that (1) it's the `fb' not the main channel, (2) on
what it updates.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/colo.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index f92803dd29..1b94e0f0ee 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -472,12 +472,14 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
     qemu_savevm_state_complete_precopy_iterable(s->to_dst_file, false);
     qemu_put_byte(s->to_dst_file, QEMU_VM_EOF);
 
-    qemu_fflush(fb);
-
     /*
      * We need the size of the VMstate data in Secondary side,
      * With which we can decide how much data should be read.
+     *
+     * Flush the qemufile cache to make sure both bioc->usage and
+     * bioc->data contains the latest info.
      */
+    qemu_fflush(fb);
     colo_send_message_value(s->to_dst_file, COLO_MESSAGE_VMSTATE_SIZE,
                             bioc->usage, &local_err);
     if (local_err) {
-- 
2.50.1


