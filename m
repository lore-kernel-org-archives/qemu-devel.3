Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 842B5CE8D7A
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Nov 2025 01:55:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vK5Uu-0000o1-5A; Fri, 14 Nov 2025 20:54:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vK5Ua-0000kM-15
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 20:54:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vK5UY-0005iO-62
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 20:54:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763171656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=BBW85pbyW1JiYUXYRrf6v5xu2V5GcK8qF6OmC8TQVL4=;
 b=dKcqdeq2i3eDThdt9yNM/+LMM10syZjjjAqGoGsZ75W9SLgkHYBfPFcNN4qF5evplhs02b
 X9yv28BvUZ+B8AUKIjd5siABl93lqLHygBpXzgCaYsNgKJHsJMB5Cc3Qbf+WjJHMiOXQcF
 IqoeR98O958uY8EINCBted/+D0z+VE4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-7Kecvu4aPxm7prejczPHuQ-1; Fri, 14 Nov 2025 20:54:14 -0500
X-MC-Unique: 7Kecvu4aPxm7prejczPHuQ-1
X-Mimecast-MFC-AGG-ID: 7Kecvu4aPxm7prejczPHuQ_1763171653
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42b2c8fb84fso1444599f8f.2
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 17:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763171652; x=1763776452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=BBW85pbyW1JiYUXYRrf6v5xu2V5GcK8qF6OmC8TQVL4=;
 b=GH1vUM0b6qFEJe+lAH/+LWUqiL1KuvY2GUkLCE0JAxQf56fVRjtDdxcGNc5kut4Y+q
 32OWvGEze0EfqLdbfGk/MsQYINM8htuGHsMTqzH1Yj4BZad+icg9JrBK52vFJteFedkm
 bgbOyh/bDRPtzl0KmFrD4RQmiMRTXKuQ5d0os0I1PkQZ0+DFfKTk5/tDEGUySrwRAZHT
 VFVU6GgDtFjnrLLXgKsq9jdpkikkV5VWSnHI3/ZPSZcCi5meYK4EPYGIdTXy9wB73Fkh
 J19vjmEa/OjP6fMzZID1/O5GcNpj6dcQX6SEkG5j8jH696swQwHh1x0Y/vMP5FnafKXY
 E4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763171652; x=1763776452;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BBW85pbyW1JiYUXYRrf6v5xu2V5GcK8qF6OmC8TQVL4=;
 b=lEIU9g5YKoaW8+oYhl0zh5sTWdhgmmR6qbAvJOszxv1LV1JYSSNpDqI5G0WmQ1keZt
 7SrfCtpxYZ3c46J8/zP4wr/YjkZP3uC91snq0A8hiCZcgYnsq6/MEMSQ/z8XKJ/TABhg
 CBA/uA7d4AyrBHmBRiiftpQp5sLPomGPy/2eM0mrYwHce6LwMGXQdGsatfQ8SjXOfzgI
 ycWoUx5Zaa5naZbBk5J3QwHBo5sKX2O3NJ/AbM7YeZOMKvH2kSwYnA/nSp7S7L8E4Rxs
 KxV1+cLcVNGvDAU7r8UB1KIvOJj+oV/ez3zNLFDYmu2kwfGeuUfTNAiFtTN2AY7EJXJU
 Xycg==
X-Gm-Message-State: AOJu0Yw8iMZxEzWNyEvBSA8eIAbvolBv0WD2Fw31ZLGZvKEyW5eE2j9p
 Vf5RDxmygglp9VLm4k/jTqK4QXBXA+YmlOFlYQcSq5elmwSUD0eddz3JPT9fbayMZmLOYtMgBa9
 pw5LErTltq5X//8y9/NaMAQucsuSQWNwZv1Z0ru0aVs03A4quh+Dx0I9NHki4t0SywXDI1e7qHX
 wtLGbq02yqzmDvPuW5u9/SqZhDg/hDjbQmu0vkdLzi
X-Gm-Gg: ASbGncv1qBSnaIT88gNBfFhL6u531xFMa3q38JO1jXxjSG/pnPSx90CeFoUjf7dD0PI
 uJUkohtdGmhEw7D9iHAsj/ZLeP7OduwQrNbHSWRu4kfQYSNoYAu2tZyiW0PHuJ5k+1kQSMU04Ez
 WVkQIUIPUAyz16Ec1HhEpQvdeLIx8uit9wJmwBLwjTC6ncbon7kaJvqd9NarMwvn2ukT1ZDD+X7
 IylL6b4sqwcXhax0Rhh8tRnhzfsAeJ4LCCIksGzP6GT0pzOk6SR1IBBX3AoJ//xsEP9HbgHxAsK
 aIqpz5xekL+RaSS/CFTCaC8nISVorRPyPAm1gJUNxh+itMMG007zH/cug/pLxfIRhxOYQVOgdtk
 /sYz7Wt/uMJbRnoRlJHvBZDSJ+Ya89+Niy48zYfXnKB6A8uw50U6tyuqxxC4JrM+uIYhxVVwvBa
 vBzlhU
X-Received: by 2002:a05:6000:4202:b0:429:f050:adbb with SMTP id
 ffacd0b85a97d-42b5935092dmr5177652f8f.26.1763171652356; 
 Fri, 14 Nov 2025 17:54:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHq8ID3s468c3qzhuCX5QPsJ8YWwZfDsvD6WgZz4C259WST5rafZdlmB8nqCbeBx6mRuoljvg==
X-Received: by 2002:a05:6000:4202:b0:429:f050:adbb with SMTP id
 ffacd0b85a97d-42b5935092dmr5177642f8f.26.1763171651813; 
 Fri, 14 Nov 2025 17:54:11 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53f206e2sm13085855f8f.41.2025.11.14.17.54.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 17:54:11 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] target/i386: fix stack size when delivering real mode
 interrupts
Date: Sat, 15 Nov 2025 02:54:10 +0100
Message-ID: <20251115015410.185195-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

The stack can be 32-bit even in real mode, and in this case
the stack pointer must be updated in its entirety rather than
just the bottom 16 bits.  The same is true of real mode IRET,
for which there was even a comment suggesting the right thing
to do.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1506
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/seg_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 667b1c38696..227336c4ef2 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -1161,7 +1161,7 @@ static void do_interrupt_real(CPUX86State *env, int intno, int is_int,
     sa.env = env;
     sa.ra = 0;
     sa.sp = env->regs[R_ESP];
-    sa.sp_mask = 0xffff;
+    sa.sp_mask = get_sp_mask(env->segs[R_SS].flags);
     sa.ss_base = env->segs[R_SS].base;
     sa.mmu_index = x86_mmu_index_pl(env, 0);
 
@@ -1964,7 +1964,7 @@ void helper_iret_real(CPUX86State *env, int shift)
     sa.env = env;
     sa.ra = GETPC();
     sa.mmu_index = x86_mmu_index_pl(env, 0);
-    sa.sp_mask = 0xffff; /* XXXX: use SS segment size? */
+    sa.sp_mask = get_sp_mask(env->segs[R_SS].flags);
     sa.sp = env->regs[R_ESP];
     sa.ss_base = env->segs[R_SS].base;
 
-- 
2.51.1


