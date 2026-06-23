Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CEADCDB479
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 12:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc0YO-0004VI-SW; Tue, 23 Jun 2026 08:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wc0YK-0004UZ-OI
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 08:48:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wc0YE-0006z2-9s
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 08:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782218903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gOsG14fEqTlYQ297R49E+Gd2yYFc8Kw5gv+a8J9fr4M=;
 b=f5axdb/roxNxke44FG3J34KrldKkFs+tyeFbwW1OJW6C7vIMkjdG7w64iY0J5BR2ksNTuU
 nDdiwJFFNXJlmJBwVls7fFXpC4FyEomr7+BKyun/pyHqO2r6XJ3tDQ22mIiPjgrAeTM+Lf
 2xvEUY+ILivvSzEgOeNxLDUZ36z5+9s=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-hOFi3nwJNhqJvGVQxdtQKg-1; Tue, 23 Jun 2026 08:48:21 -0400
X-MC-Unique: hOFi3nwJNhqJvGVQxdtQKg-1
X-Mimecast-MFC-AGG-ID: hOFi3nwJNhqJvGVQxdtQKg_1782218901
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-517c65c019bso140800401cf.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 05:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782218901; x=1782823701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gOsG14fEqTlYQ297R49E+Gd2yYFc8Kw5gv+a8J9fr4M=;
 b=oxk3JmkoM++pi7Ne1b+g6dgeHpQaPh8J5y6wfupd7xulGv6s/FHW7MI6o44Ba8M3Oz
 r2qrjaFgmkPeGUUyJBzXRhVOu6ovUR157ePrk33V6iM81jArbuGE6LVy3qEetgPdytGM
 5K13aOUzPECFF+YN25gv9FHC+23NAq4L2+H7lGd9Leoqye8P73A/wtclrR4gsplcWuhv
 61LuBDEiE/tw9iC1PKlL+qfKESIagpzRPNoNZiaQhdOa77XEq2aWCzNvTV8IvZIO/t2d
 PrVtOPqFSuOukHRQuwtOGsswsXMkddbYztCU4k0FzNvJ0PIxq5999eVwk6ZKfsfFoMTQ
 Q2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782218901; x=1782823701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gOsG14fEqTlYQ297R49E+Gd2yYFc8Kw5gv+a8J9fr4M=;
 b=DhZ1J14+2XfAStztMA4OXtMILnKNYesc/SVcvWqL27i2Ew2rqcfkqxrzv6U2xbQZuV
 eSQ/BNV8D/OYY59DkQplG2ZnCeJh32O6l02aT4HBWhvN6PAMH1R+Jj4ZieaH08BB5TdX
 TP3c05i+fdSUZ4AvwLcdVgmyqsGH38CCadxwYt0W5m5GItllgHrixFp5rIa70ZTPsOcj
 JcgM+qk22VexbHlhjjJLRNe3/GCLhTA/GY3KY1KaYrh0DV37Hhv1K3VvNI82pgpMpska
 45pOCRBE8BUujtLrj9BP+AUtWbAACEcDLOdSY21Jn0harhKf+dibDEeG+sxAu0vp+9Ad
 4icA==
X-Gm-Message-State: AOJu0YwdpvhxCLev6dRDz1Mr/FUeAQomukj0ywqFGZFHesxG0PkZ3ZD4
 07EPBu56ufSa2OjplaQchbiE7yKPlzdHcJ9Iy2ff2i707JI5v1d8fzwDWszOP3i0Hh+rvxm0nov
 sgTN9kktA3HyZJdlNnZvGUrM20jMkelkzWMjzc9HEdnGd2pGrvK7OvGsDmo4j3uxQC1e8VhPcFC
 7V+5YIPiPTgcXwQeSgfEDViyKaVL2Gglg2jMjtaw==
X-Gm-Gg: AfdE7ckqvP6y+XQ/k83qNzG2AgCw+9IGnOiTwArKwMZ8WObc4qddh5J3pQtENJaU7OK
 KML4D2xt6WQW6w9q1RPB1OwK+EhflSgFfu7O5VoKGpeK4qnRcQyItT2qM7gC1fdVquj9V6Um6uJ
 7ULOkegLmHkOISz/YPwuQglLpBcgNYbFhxZzw2C5FqwEr0wyP/3rVhrcwexDwHb+1QkL0XfQScO
 o6Q+yAQV661hWhEdrOC4BMcMeai8/EXF1oGZvV+momgGrfgxj83FOrq8iorayAcR9yn7EVOFEUq
 NKG93pTLBbaxgNqVHX0FL2Z3EIaDgvNXIzEUQMstqbGv+2exK90rWMXE70P8MzeubD51g4CW7O9
 Txw==
X-Received: by 2002:a05:622a:1a81:b0:516:e10f:7140 with SMTP id
 d75a77b69052e-51a55d479c7mr30830321cf.35.1782218900840; 
 Tue, 23 Jun 2026 05:48:20 -0700 (PDT)
X-Received: by 2002:a05:622a:1a81:b0:516:e10f:7140 with SMTP id
 d75a77b69052e-51a55d479c7mr30829791cf.35.1782218900251; 
 Tue, 23 Jun 2026 05:48:20 -0700 (PDT)
Received: from x1.com ([174.91.117.157]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51a51106a09sm22288351cf.0.2026.06.23.05.48.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 05:48:17 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PULL 02/18] qapi/migration: Remove @cpr-exec-command doc in
 MigrationParameter
Date: Tue, 23 Jun 2026 08:47:43 -0400
Message-ID: <20260623124759.125399-3-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623124759.125399-1-peterx@redhat.com>
References: <20260623124759.125399-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This parameter was developed during similar window when the deduplication
work was done in commit 2220c2b9ef ("qapi/migration: Don't document
MigrationParameter"), hence it was overlooked.

Remove the leftover parameter.  After all, MigrationParameter is already in
the exception list of the doc sanity checker.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Link: https://lore.kernel.org/r/20260528201236.359452-1-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 27a7970556..e8756308cf 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -804,10 +804,6 @@
 # Migration parameters enumeration.  The enumeration values mirror the
 # members of @MigrationParameters.
 #
-# @cpr-exec-command: Command to start the new QEMU process when @mode
-#     is @cpr-exec.  The first list element is the program's filename,
-#     the remainder its arguments.  (Since 10.2)
-#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay, @x-rdma-chunk-size, and
-- 
2.54.0


