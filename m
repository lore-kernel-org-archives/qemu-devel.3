Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB55D3C546
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 13:18:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTK4F-0004og-7X; Wed, 10 Dec 2025 08:17:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTK44-0004m6-0g
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:17:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTK42-0002ye-4Q
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:17:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765372625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QH+Y8iuc84iMUyZHmPFJU0rIEXvwiqoYIaZMOnYdPHc=;
 b=Huql9+wGs9Vw4F7hVJxAGYoRg/2RK/bmqXkkF6qg2wXXB9clavG5Cut3SdlKitBExnMawn
 VFtBa8qXiFXQNMdr41cvYlKpPVMjc9gmPjbYmfWy2gsHPH1vhULoetnZpfJRcesIQuj4Ii
 io7WerTMbb1AOJETLw8X9wIopEc2p7I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-up0V7FkiMneITzidZcFSVA-1; Wed, 10 Dec 2025 08:17:03 -0500
X-MC-Unique: up0V7FkiMneITzidZcFSVA-1
X-Mimecast-MFC-AGG-ID: up0V7FkiMneITzidZcFSVA_1765372623
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47910af0c8bso47638325e9.2
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 05:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765372622; x=1765977422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QH+Y8iuc84iMUyZHmPFJU0rIEXvwiqoYIaZMOnYdPHc=;
 b=Ax0eMlfkbZ8aVd+WvwdkgEEb9WQ/QkFjkqmtn4ityNnANmDIwfBvYYbErC5O6Bty+i
 VC9k2YJuJc4p3EnZGBa87gTVceA9vVxf9IqngRFLxTpQf7riVHYgd6mEDJT0Msjtllpy
 SyYP0jzwyGjQ4wVafoNOURRhM9+2wpS7WuXmeojPLYM2Vc8dvTtos8H6p+1F/8tVlg5o
 XE+TM7bu/s1g8QwQKTUlJyiN0I8gw5auQJkRLNqdIHdrx8krW55G7Jwqr8AJWZBzfcVr
 78ilMMdZf3rEGLjVw8b0MXOEMMuL2xgMP9eip+phnDN1z7M1nD03h6vBzOe0R0eX/1BX
 V83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765372622; x=1765977422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QH+Y8iuc84iMUyZHmPFJU0rIEXvwiqoYIaZMOnYdPHc=;
 b=oD1NYrfyViVO+Dmzi42rXxogSqVsMK2QevVcvR7YgbNsMeoquTIKev+HSDQCsb9nr3
 CynLE3beUXNFxNoGAYVVT2tS6vd50khJbbXhyMOn+jp+QjzShU8Juk+963JfVAez4nlA
 dxX2hU1hNxm0Y/N9D2GQDHGYyLawzdbfGhbvBLEtugpCVNIG6e1Fh2mEQ07WMTgOlGrd
 XCzmV61xviMVsj5n/uo/CLbQZfm3hchRPvBCnn73UBuem6dXkKIZXQL//gO44739E8XH
 bftilu1Wcn0tfiZTQrYGK+QmKfKdVLvjiIoai4RVY8Wby9L1gzYMBdSUqqPbg9GrKxdw
 jeKg==
X-Gm-Message-State: AOJu0YzOOS2UJXpa9y7xp2P0SQ7WR7v272QvhTam6YXStEBcEzC0Eob3
 4Bs3f5UN7kfWw9eFia3hhWb2vPjWTTJQpFhH+QlvtVDEC+6JykIORHUe8mwkAvUks4PzRz4QLZ+
 KIZOkbeKu5/4IZFlXSKAJd0PN2GVlwhx4+wy825CX8W0vW1xHR8L4hrJTij9zlLfXcF5d8Ae3NK
 YeumTNton+fa8yTQVbJiBrp9dPkwxJqy3tqc2Vel52
X-Gm-Gg: ASbGncstMwwmWiaZULuBS/p3RUelZ4WtAK3JYBme80PhyVHxtFbc5JG1+1V3YxCsrdA
 OQf6nFQSfz2vQzuQyc1E9dT9oCQNzvvnvaYpZy0XvxLwhRq/EYxqxu7QGmdMHKZPMc9xxFVg7J1
 fWRjDhtGyTKLggsknV9piyKOp2KHArN2yFblBplcQP3pA/CQamncIjPcUqnv+6xkL2dpifJUwCi
 yIwfyTBHrGaXbL5j0n7C7ZAdSSJxfLV15C4iAl5ID1sK4x6h7gvAJlzYx0dEaCTxrLcmTbGFrZi
 qvTc2BPIEqmG5fEOt82c4qMwhPjDIQTISLxbaizSb5J00fjSVjgSP2Ltd8TeeIj7FgbSDOiAzU1
 BIHyDj8k38pvrqBtzYznmpryxX9JvRp+cGgraEG//W2bIyoXQJQOvdwJNYU0bWgEDIl/BuOCNzA
 8z1hQC/pXW//GoFc0=
X-Received: by 2002:a05:600c:444a:b0:45b:7d77:b592 with SMTP id
 5b1f17b1804b1-47a8380c62dmr26142415e9.12.1765372622174; 
 Wed, 10 Dec 2025 05:17:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEf+aV8DKFmOx+7sXtF15PevEzVJEZPKDusv9hK/HNPUaFFegu0cP/VEPsy+Rs7x4Msc7Q1LA==
X-Received: by 2002:a05:600c:444a:b0:45b:7d77:b592 with SMTP id
 5b1f17b1804b1-47a8380c62dmr26142035e9.12.1765372621590; 
 Wed, 10 Dec 2025 05:17:01 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a7da2d3e9sm39401025e9.17.2025.12.10.05.16.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 05:16:59 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/18] target/i386/tcg: update cc_op after PUSHF
Date: Wed, 10 Dec 2025 14:16:38 +0100
Message-ID: <20251210131653.852163-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210131653.852163-1-pbonzini@redhat.com>
References: <20251210131653.852163-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

PUSHF needs to compute the full eflags, set the cc_op to
CC_OP_EFLAGS.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/emit.c.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 1a7fab9333a..22e53f5b000 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -3250,6 +3250,8 @@ static void gen_PUSHF(DisasContext *s, X86DecodedInsn *decode)
     gen_update_cc_op(s);
     gen_helper_read_eflags(s->T0, tcg_env);
     gen_push_v(s, s->T0);
+    decode->cc_src = s->T0;
+    decode->cc_op = CC_OP_EFLAGS;
 }
 
 static MemOp gen_shift_count(DisasContext *s, X86DecodedInsn *decode,
-- 
2.52.0


