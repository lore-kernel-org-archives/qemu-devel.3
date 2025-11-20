Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76162CF6499
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 00:18:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLsMO-0003Am-1l; Wed, 19 Nov 2025 19:17:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLsMM-0003AE-0f
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 19:17:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLsMK-0007RQ-Ci
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 19:17:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763597831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BBW85pbyW1JiYUXYRrf6v5xu2V5GcK8qF6OmC8TQVL4=;
 b=FerCf5DdMMk1PxSmrE4tsNlKRfmvqfu4fsYT9rSo+frELzWmID33Pmeqb+Zk/WACCu1qz1
 mfITx+551epyIUc2d8p2uE2bC8eL19QTgS9ITpZeoFcnC+goC5rBQ5hDZihVxCoUoijxNa
 VWm+r0eAtiBJRjYZJaIUo8XuELdCEus=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-OcSFa8JpPvSbWuOcVMKAhg-1; Wed, 19 Nov 2025 19:17:10 -0500
X-MC-Unique: OcSFa8JpPvSbWuOcVMKAhg-1
X-Mimecast-MFC-AGG-ID: OcSFa8JpPvSbWuOcVMKAhg_1763597829
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477b8a667bcso4031755e9.2
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 16:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763597828; x=1764202628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BBW85pbyW1JiYUXYRrf6v5xu2V5GcK8qF6OmC8TQVL4=;
 b=Pe5hK9dL/zAaSc9x5jOKftMYcwUeoirOY6fzV88yv0idjQgL/yk0W67XuzWGURBGu1
 +ltMiXVL9tymFH25cFJ9u4UHgEZ7VKUjcLfCEGy1vjb5sV76+qN+gWPvZGyxf5Et+QOC
 Py8GvDAm78xlRIuNKEO+wQ6m77/pc+Sy2Bq/Y6MeQc7hurZN3McVPBcOBSV2lPBFEUce
 45CDTf2m7cOOEhTwJUr1VlaBnYenmlUnjei4VqBm39mQWiXKg1xPy1AY7DW4ODmv0dRc
 o/ZeCSwI97IotdnoQqfNyMzfyXuRcE0Z5BY0zWH72T7Vto1v5Z/x0IYWWul2RO4k3eoi
 hUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763597828; x=1764202628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BBW85pbyW1JiYUXYRrf6v5xu2V5GcK8qF6OmC8TQVL4=;
 b=qp8E9BWAJPESwDfcfTXceaH68HFBoRjPXmyFcvBOGXgu9XRRtXBmjV5TzexWomMNgK
 /eFHLwxOmezLpfCpNsGSVoAnxsBtLam+FT9scvbAoew/DR+DU4hYAFcI3zbobAZztuY9
 2LJ9dbtuHin0gecBewyU+5VioV0qFZMAv/yVQwjWTfvVTocXOZ1Je4mGcLyOO0jYYcwC
 /75qWTQXRXE3uw8ozvS3HCRlxdIFt9kfCmd/jicVrLhpdEdIOWjsmXlR8Au863m1QMQI
 OpHz9VxLgeK2gZXAUbGZsFpqdYaGtRaFNfOuXRU5Voza+kbXDCmc8EjYjAIjdToeZNLI
 fgaQ==
X-Gm-Message-State: AOJu0Yw3sZoXCelLMgaTAqCWZPJpVNXm1B4y+5pYADdHXC4vT46OI/by
 wuAedhAw2WkqmpsNlfH5Yw8Lh5bb9JjnBtoQUebJHEXxIJ++hf+3kUzfrlXgJudoqkHI61wspgD
 4wwYyiQ0b+lLos/kQoSaCP3dA14LXrrJ099VtBGvicH/B1rWPSeHJsk6/ewMKvEhGpolkr6HbcS
 aRuluGUC07ZlUNQDUw7mY2hm5PKMfHH17AOT7J20uK
X-Gm-Gg: ASbGncvKXvh/E44tuHxIDa1bYMpBpm52VktJ99J2jg9nvBcMsFdEnMbcfTv430Z11XC
 5NY7cosdup2c0sZgtEiKEWgil9THde+K+qSRrYtCxf0LMpz8d8kNIYGcbhNJYaX6TTeEa040xgR
 28C1HRciQIyKXFQz5zIDhM2Cy/WVkXbOYM8CgwQuuwOcRdqFfSALGxS0vcTm9gckVuoeNvZpbyO
 UCrRNakmBNTUgIhl8rT0rX+YcXkSy6QvLgpz8Dy8t1WoMQhxFAFGVOJIDIiHvdGVoYcYtCZ1gnX
 PQsm4kp6eh5PpMzKYHp9H7wNlHlb4twVSEWnLk/bUVpARHa+tZuEsupc8FyjyCxE+oSCjJFaiCz
 bhdKKNh+btOH49HCzT3LS4Mcb6Bxbh0RKXY1b7cKVpa/36Khj9DiqNntDkVMrPLWFIFoA5GH29T
 7ezcRcxBYcPi8kBno=
X-Received: by 2002:a05:600c:4f8b:b0:477:79c7:8994 with SMTP id
 5b1f17b1804b1-477b8a9f74cmr10963975e9.30.1763597827590; 
 Wed, 19 Nov 2025 16:17:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhiraFOWeMl5xdxy+IzthTwaC9fPlXW9vvn6cc2zJbPvyMRPj6fHJ3A9aRgpAYXLRpq/f5ow==
X-Received: by 2002:a05:600c:4f8b:b0:477:79c7:8994 with SMTP id
 5b1f17b1804b1-477b8a9f74cmr10963585e9.30.1763597825876; 
 Wed, 19 Nov 2025 16:17:05 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fb8a29sm1903427f8f.30.2025.11.19.16.17.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 16:17:04 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/10] target/i386: fix stack size when delivering real mode
 interrupts
Date: Thu, 20 Nov 2025 01:16:45 +0100
Message-ID: <20251120001649.1085913-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251120001649.1085913-1-pbonzini@redhat.com>
References: <20251120001649.1085913-1-pbonzini@redhat.com>
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


