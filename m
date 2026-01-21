Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B52C44500
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 22:34:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viglw-0007jY-HF; Wed, 21 Jan 2026 17:33:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1viglv-0007j0-KB
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 17:33:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1viglu-0003id-6S
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 17:33:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769034833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CQXlbY1XO0ZC3utBeZ4/x+lzfr2Kk4C5uHBUNcqvbWk=;
 b=WJ8FtXakAOpn3a+1OwsB3M+XhBtbtHY2106HwuNxual14KS68zDgYhSzF6R3W484F5HpnQ
 nVMT+Vd52UXEi0Dx1i+Mpb9xaWsqQq8ZEGk2ffSG1w1QHLtmSgdIEl0nkyefBAxICEL0s7
 d9AVG/s6CF2JlKUgMbs0LyqTyqaSYw8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-CFwg4gK_OW6cPtuKtlNc3Q-1; Wed, 21 Jan 2026 17:33:52 -0500
X-MC-Unique: CFwg4gK_OW6cPtuKtlNc3Q-1
X-Mimecast-MFC-AGG-ID: CFwg4gK_OW6cPtuKtlNc3Q_1769034832
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8c6a4c50fe5so114276585a.3
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 14:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769034831; x=1769639631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CQXlbY1XO0ZC3utBeZ4/x+lzfr2Kk4C5uHBUNcqvbWk=;
 b=VBNTdeAnWJ8N84W9OZT5tkKz1CxQKYmUIDhjcOelMbwfc3ngFhlKZMF6RuxaN3fFwE
 aDr3+1UCU4A9wonPrhJwEXC9lCKZUDo0YZI5ngxs+lQ10d16ymwq9Y96yeBT3PUuKst4
 kGnV3D4bHup0A6C0fW9Vu1GQNX+SUOdauJnsKQHIFPEa85naQGczYF155SH/N64Px4/l
 W6s5w79av2N3Ng4AT40I7X1TzrfemzbHgv9fUBMwaNqS/wyXxz8LF9d4kRzlhlg62z/7
 1nu7QGu3jO4EhEd/c108lSAjxXBzbz/zaLD+vSRubO6enppzEB0e5tugRvGMhxXJuf9h
 cVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769034831; x=1769639631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CQXlbY1XO0ZC3utBeZ4/x+lzfr2Kk4C5uHBUNcqvbWk=;
 b=Jpus7VCZgZp+k0VhT5RaeJQf1IBXTIluhCa6c5nsErnXeC+jvJUj01o3zyzKwo4zNq
 B0K+9xr/TanCY7eYr6Sx5ezygWatSUmmEd2CnvGylv/sf8ymbiVmXzQKP0n7nCnvY9uy
 MnBkNhSTtFsgbVug1tVShCyduel6G1NCQV2EuxQ7djPrIEqAZEdLNy99R2dvqngc88bi
 dkfz7veRux0rMPUFlMAujiOLCXeNcoy3rwhe83Q9EIbhGAXBqr2oF4hLKXsf1BPlP1CL
 jHIcDpCHLsgt02FmxIVWru0pAjXoSXRbz6r+R1BmalTaXhUIDzqHReo7Fa1Z7bE2T8+h
 vykg==
X-Gm-Message-State: AOJu0Yy6G5g3Dy0aJqujwMPemb81aWlEGziz5+p8qzoZEEsU5N0/M9do
 RXNMNHgjjkAjVys6qq2ITQiH29eEGqOLmHXkfRb06bSTHQdKjKSe58srrrhd5tQvvt01fEmRTcC
 W3hIuikwZDgr0vW9BdIVBRX7k4A6gQhBNfBhjogoP2B4YNnKEwA9D92Okv7isYnrEuT3vP318Tw
 ML5EKc4cRliaRgrjpyzYjD+8yItEQibavFYunSKA==
X-Gm-Gg: AZuq6aKIx7QT8jlgweEimNxr2cS89tcuruICva4NkziYr567Hmh0Rv4V5bswYzqy18b
 K5eY3nFX2fhC3RpCF/jPfnOzxlHQeBwZQzfevUnmXF0ip+1Crx/0i+6kxy3TIbCC+jL/tjI9XaO
 Grh+JsdAOeiDF2fI941ffxjKKO5TZDTtRdvif9c63mQP1ZzEXK+ueqorSBP1YMHus2mthHvj4J1
 0nAuJy2lAucemia3mDw5GF63Y7rkZ3eRU1MXBt2K57A50urQ/Wo7g5antsEDBpy9FruAFwWNfip
 BmnEopdz7XCXitObnQj9vXxZQxoLJBDgHzivse1SXNrVgy7tL5qMhGwPZ0Fr38wYFwtIPtN7Mtu
 j
X-Received: by 2002:a05:620a:4004:b0:8b6:164e:e0c with SMTP id
 af79cd13be357-8c6a68ec429mr2823196885a.25.1769034831473; 
 Wed, 21 Jan 2026 14:33:51 -0800 (PST)
X-Received: by 2002:a05:620a:4004:b0:8b6:164e:e0c with SMTP id
 af79cd13be357-8c6a68ec429mr2823194185a.25.1769034831043; 
 Wed, 21 Jan 2026 14:33:51 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89470b0ac3fsm25598306d6.25.2026.01.21.14.33.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 14:33:50 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Juraj Marcin <jmarcin@redhat.com>,
 peterx@redhat.com
Subject: [PATCH 09/10] migration/colo: Move qemu_fflush() closer to its user
 for fb
Date: Wed, 21 Jan 2026 17:33:34 -0500
Message-ID: <20260121223336.3381912-10-peterx@redhat.com>
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

COLO caches all device states in a buffer channel `fb'.  Flush it right
before pushing the buffer to make sure everything needed will be flushed,
add a comment explaning it.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/colo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index f92803dd29..e2307f1907 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -472,8 +472,6 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
     qemu_savevm_state_complete_precopy_iterable(s->to_dst_file, false);
     qemu_put_byte(s->to_dst_file, QEMU_VM_EOF);
 
-    qemu_fflush(fb);
-
     /*
      * We need the size of the VMstate data in Secondary side,
      * With which we can decide how much data should be read.
@@ -484,6 +482,8 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
         goto out;
     }
 
+    /* Flush to make sure everything lands bioc->data */
+    qemu_fflush(fb);
     qemu_put_buffer(s->to_dst_file, bioc->data, bioc->usage);
     ret = qemu_fflush(s->to_dst_file);
     if (ret < 0) {
-- 
2.50.1


