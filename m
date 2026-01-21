Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F1FC44508
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 22:34:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viglo-0007fS-Vd; Wed, 21 Jan 2026 17:33:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vigln-0007eu-Go
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 17:33:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vigll-0003gu-Nj
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 17:33:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769034825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BEWZVIKSCHJzFmzyUxO8KkGG7d5cJbi2hrksbi97pLg=;
 b=NXazk1jllzKTVGf2LeLCCKQyZutPmgzgGM2i0T2vlLqY46aRZwuup2DtFB5IzlEMpJ+3TJ
 r1IyJ9w7VvfHyAr3fnULzzooAvwcY4uzbi+icy0E7XqSqWkPzksp8EoCWE5L9RS73Hcavv
 xPhYqL5A7A2ZvtgHK4raVjH1IDpBNnE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-QgRYv9GnOfi4hyjmQHLSlQ-1; Wed, 21 Jan 2026 17:33:43 -0500
X-MC-Unique: QgRYv9GnOfi4hyjmQHLSlQ-1
X-Mimecast-MFC-AGG-ID: QgRYv9GnOfi4hyjmQHLSlQ_1769034823
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8823f4666abso9589566d6.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 14:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769034823; x=1769639623; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BEWZVIKSCHJzFmzyUxO8KkGG7d5cJbi2hrksbi97pLg=;
 b=URRY7sGxM4Iq/V8dGi5ElNpHMkpr0yGFzLa/NWC1CPEZ80QelshPYa5+senxlujaVR
 9v1Jj/l3z1jj2AmTSlV5a/xo4RWnfo439VGIRShrhUtucqksCESCtQBngwCkI2AEe/w4
 6Fpa60ys1KKlifN2Kqy2LQis3pwbrly84eOol/4kpCBmSmqkS50xaQAgU3x2pkSIODLj
 of6ttq9qrq4Wf+G1aCVCpLBWPUAx1OXtId1w8GFgZaA1LGGfr6qDw+B3XSyjgVJcYLYw
 0X/jvluF0B4aAd8REYlV+iFu1JYvK1Gl8cjCfm1XT1d8sgHfpJWBjTjAuKDKBucCujmV
 nV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769034823; x=1769639623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BEWZVIKSCHJzFmzyUxO8KkGG7d5cJbi2hrksbi97pLg=;
 b=pbfE3Ict1KVVUH4e3gqTaEZgDAJ3BQX9x1EP80UqbfnBnb/fQ71ir6MMvICcfH1NoH
 U5GtVc/FM38YuJUnKaXPrIU1k2yusWtRQPVVb1nLKYMWE9Gq4Q+NPIXDY6xamcqZ9WWR
 Ax0fk02X9uwTVgb06tMMZ5swMz+UjEezHwVzaVWQT1HZDVW05gMeoDK7FKh/sM358gFX
 KEgU4oTPBHdtrKrijr0RfvMLA3EqETannt3nw4/C8CWA7PIXLwYJb8FhKUsIpNBfUtpF
 DuLiz69owEUhPEhmnLAurDagVpCbzY0tcWm14VnU+9pemkp8cKy6P0VFOTyu+/gcK/EK
 DvPQ==
X-Gm-Message-State: AOJu0YxldTczREyXLVkF/IcEvGq6q3tTIWf8HimpMZb8OTdnIr/0CFh4
 gzz/hImaWqL1qWm8MLXWn+z4Su0pnEwD/DkvcnE9aFtCP4jlxJEm7pfWlpXm6+HoV/q5FKKkbcB
 /kdzrxjRJPss0RkVk4dp0vSaRw6ooPNivzDTe8lJyS3w7ywDIXx9s6QS3+QFRCtfbYVPH6XYWOE
 06b/RHd2EaJvW32Fi8e+7DQfEmmFc2G3a9jrandw==
X-Gm-Gg: AZuq6aI72wE560kn1yEIBOhO1Lzk9zgU1DHatPndInXJ7WRBRVxavEkksClgNu3evRR
 LG37zhIt2wdoXqgfAYGvBZe1CKblai4i3vvcAA1bGJLSzLX+pyG5M3AlIMtBFTXvf1BxOoE1/nV
 xX/ExE+YRnrlz+Rb23DrnPN29gzWZJiYCS7RwtTP0X1LZbC2T3QuYiWhgt2DFSp2nWcbcH8jSKJ
 8sQT04sFWwvYue7eD8AX1dP/5gmQzS86rLf7YZczGCjh8gp5pLdnGOX/I6lhr/kkJ34OF4uOKYd
 190U0M+Wum2IjwOHYdFifDnXVOUQJD2zKj8ZZInjF16xvKk7qsSaIWPccvAoSi0Ksn4BcQvMs5B
 0
X-Received: by 2002:a05:6214:f22:b0:894:7798:8f6 with SMTP id
 6a1803df08f44-894779809c2mr39882546d6.5.1769034822928; 
 Wed, 21 Jan 2026 14:33:42 -0800 (PST)
X-Received: by 2002:a05:6214:f22:b0:894:7798:8f6 with SMTP id
 6a1803df08f44-894779809c2mr39882196d6.5.1769034822439; 
 Wed, 21 Jan 2026 14:33:42 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89470b0ac3fsm25598306d6.25.2026.01.21.14.33.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 14:33:41 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Juraj Marcin <jmarcin@redhat.com>,
 peterx@redhat.com
Subject: [PATCH 02/10] migration: Use qemu_savevm_send_header() in
 qemu_save_device_state()
Date: Wed, 21 Jan 2026 17:33:27 -0500
Message-ID: <20260121223336.3381912-3-peterx@redhat.com>
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

Reduces duplication of the other path where we also send the same header.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index e26656cca3..64bf445c98 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1872,8 +1872,7 @@ int qemu_save_device_state(QEMUFile *f)
     SaveStateEntry *se;
 
     if (!migration_in_colo_state()) {
-        qemu_put_be32(f, QEMU_VM_FILE_MAGIC);
-        qemu_put_be32(f, QEMU_VM_FILE_VERSION);
+        qemu_savevm_send_header(f);
     }
     cpu_synchronize_all_states();
 
-- 
2.50.1


