Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A65DC9833F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBB0H-000587-Rl; Mon, 28 Sep 2026 09:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB0G-00057h-6g
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:02:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB0E-0004Ki-M7
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790600562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j5c0biV9iQHx94S6dDH/D1q56dQuwxRdl/1B0iDzMA0=;
 b=Ei8yKL5i1CLZSQnyY9anUE2YViaYcYySURHREc04shoWxtqErdkGIuXl84LLDDefWT3y5o
 /gpD7J48SA0MP8EQDgvM9CDzgvtxwn6hsVRyZlK9qrwDQvgAS/WV24xhRb93hosoBtZwwM
 3ErOaQFGCWxQsxRSKu0L5nDx7A36Kg8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-cx3CwlAoODiEVq8N4YF58g-1; Mon, 28 Sep 2026 09:02:40 -0400
X-MC-Unique: cx3CwlAoODiEVq8N4YF58g-1
X-Mimecast-MFC-AGG-ID: cx3CwlAoODiEVq8N4YF58g_1790600559
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-c293e604f0eso286385166b.3
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 06:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790600559; x=1791205359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=j5c0biV9iQHx94S6dDH/D1q56dQuwxRdl/1B0iDzMA0=;
 b=oRrpIysehxVpcxKlJZ8hfIll2URB1ZkgNHkMS337U0HI2FC7hTqtbzkXlFqm+LLdWH
 7J9Mog4Jve2fEViwO41V9PCp+XeBFeb8hWZMqz1qWGQIppKBjhnvuLpiUfC8TOcejaGD
 I8kBEU6uIzIg8llcc/IKcUwDuEUVwyWeurYbAvW/e+KRZCGQrp4OYXYr9A2EUhakuJvo
 gD4wzIW66RE5MDkUykBmSCOxm9SpAC1gvYIhGs130wGVzUfGM8a/EAwT0z5T2v7dwef/
 apajSL9k4FFDrsgm58QtKGdZ67yikPip0ME7DFt6z8qr9kiCk0KrKGoVhzdINIbHM29k
 NMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790600559; x=1791205359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=j5c0biV9iQHx94S6dDH/D1q56dQuwxRdl/1B0iDzMA0=;
 b=eHSyib1TOQzk6ijzD0vFMkAIhzfJcyLFUVo9jEsgTz3M+yLzqGTWELpGZ9HV3wxc5R
 pHe7pHUgyVK+VZiczCSdTOgRe2DVVFi+qcFbXzLOByGOV+gj5jZsvipOjaFYX6WD4O14
 HEDFwy6Vz3rwCk/9TJ4dzMlxGmjI0qGvR9Hm1GJBy1FACmNu7yv81oqLKQ0yN2wn/j0D
 g6TEoNtZGXZ5phpqTNWlh3HSjdP6g3VtxedR765uEJAthcsoJG7ZAwQSjbihg4z44R8U
 RYOwYIZ5xiiuEgBZCLZbJYH5d9L3rnP82Qx5C7RM7p8kxGivfeBwssjMV9yF3x7gY3vU
 EV3g==
X-Gm-Message-State: AFuF++mhBgSoKAmVMBZijDe6BDPewSuyDQw/J5sehP4Q4R3++aaCMVxD
 y6W9MQvA+IbS0ot0cgKmQlroqD8Y8iqu7ptKnKouF2VzPtxbTQLnv5qcNVl9OYIMsSsoRQ8ldgK
 LaQ90ijgCQgWOFolSCO2uEyKNZvFbS4qrVN71Q8/F14BKb7u/+VciXumfl4KUsEc18/mwe4KlMc
 oxDkV9ZjRGQkRVZmy2GorKWNQCQOL0H6PQUYqndf0A
X-Gm-Gg: AYBFou3gEt6OvaDO/1hmoqRQEZmuTnZNBTPux12M9bszlr2mqSMN9RpKC/NlHqBD6KI
 yUGh69dhnC9rvfG5Ewx+MfkkhUMRhCvHHOOR3h3/qFzFQanpoev67EZ4NNrUTK55Fm056m0gUb3
 aAD63sWJ/bBbcPT1G4WC4emWwOACVneu22hC1RLuUZ0vsBY/FLyPmiwxxObkrdweGTWOVOHuGw3
 A6za6sz3SyonM/fTRNCJ+7CJCYsLSDCCb8zDh1MK5xOoXM3/MkMAnPYAI7UNY1R4MlTIrQLciBx
 OQ/vP2zr4bHONlA0uESEQtr35+Dct3HZ/zRD+5/+1Sj+kUuWhyKz9x18BGyMpRDwGJhntkqo/Qi
 8WY13Mglges1XyEoK3L1AduRsqIsBqnLPmCI8qvcq5UYD08vtFY5xfwA7VlPoGIek/6n3m9lcZx
 GtgdTz
X-Received: by 2002:a17:907:6d04:b0:c2d:cdc6:8279 with SMTP id
 a640c23a62f3a-c2dcdc68aa7mr281236766b.0.1790600558952; 
 Mon, 28 Sep 2026 06:02:38 -0700 (PDT)
X-Received: by 2002:a17:907:6d04:b0:c2d:cdc6:8279 with SMTP id
 a640c23a62f3a-c2dcdc68aa7mr281234666b.0.1790600558453; 
 Mon, 28 Sep 2026 06:02:38 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2dd1153f09sm186727066b.15.2026.09.28.06.02.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 06:02:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/30] target/i386/tcg: compute C of CC_OP_ADOX without going
 through helper
Date: Mon, 28 Sep 2026 15:02:00 +0200
Message-ID: <20260928130228.877003-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928130228.877003-1-pbonzini@redhat.com>
References: <20260928130228.877003-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

With the CC_OP_ADOX cc_op, the carry flag remains in CC_SRC just like
with CC_OP_EFLAGS.  Add CC_OP_ADOX to the same gen_prepare_eflags_c
fast path as CC_OP_EFLAGS, to avoid generating a helper call.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index d8de290acb6..d13e8cdf3f0 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -924,6 +924,7 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
                              .rhs_type = CC_PREPARE_DIRECT };
 
     case CC_OP_EFLAGS:
+    case CC_OP_ADOX:
     case CC_OP_SARB ... CC_OP_SARQ:
         /* CC_SRC & 1 */
         return (CCPrepare) { .cond = TCG_COND_TSTNE,
-- 
2.55.0


