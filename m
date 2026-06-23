Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CDB3CDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 12:50:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc0Yb-0004a3-A4; Tue, 23 Jun 2026 08:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wc0YZ-0004Z2-Vs
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 08:48:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wc0YX-00072K-Mv
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 08:48:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782218925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mZZ5ZaBX0C10PgcNf3Ut2LEa7FLXeBfT5W3Q2HnKEVA=;
 b=TYJQ+V2PNDrTdpiF2yCasAfRMpUrtwd8GNIVm6K61OIbhB+WnMdYkjHLxfk6kyqOlj7vo7
 1zxavMPiyrdejrCcu6m1AJSu3Lzxva77pz9eQ/zm7pdYTDgy+qwHdPOJ1E4EZsslCgHNDD
 xvbuipjafAHrB6wwwqJvv72srC1QzSQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-QtUX3Fb7OwGJ16SZshrWww-1; Tue, 23 Jun 2026 08:48:44 -0400
X-MC-Unique: QtUX3Fb7OwGJ16SZshrWww-1
X-Mimecast-MFC-AGG-ID: QtUX3Fb7OwGJ16SZshrWww_1782218923
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5195760750bso108328461cf.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 05:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782218923; x=1782823723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mZZ5ZaBX0C10PgcNf3Ut2LEa7FLXeBfT5W3Q2HnKEVA=;
 b=s31PDra9uY8z5UTLL1Dux7/BIzqfeXpww9UNj+mJJX2fLjmbFDpBPm2SeL7ttO8Axx
 XuMADgDBv59IT3j6LWowv4CrEtKLxviApvtUxUAxkCCQ4Fhy07Fpu74Fa5HfM/vZAX4h
 6i7IxiT4E7POilmYDe/ENNYjib1VmlAazGC2iRvPYMgJe3SMnYMXHpKUO5yqStB/RJKi
 3p/2/l6hqDIr8jp4bpbey97J1Wfs1lKMkTL1cPK4llxda+GwTVwoAeimpTE/YYlwjgaq
 7mG+XPDv8y7eq1a2a3eavGw6e4ggDmj98p4Vru+F800teK+L5O/BuwZnp1Yg33v4iRPJ
 erEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782218923; x=1782823723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mZZ5ZaBX0C10PgcNf3Ut2LEa7FLXeBfT5W3Q2HnKEVA=;
 b=kAx78LvIAcfp3OE/cmpVWjL+le8RMkQUMAlPd6OmfNy1AzgqoKrevVVK9iabVDIvJU
 AyW3glYeEDr+qlRFAavXY+7Pm+8MLf4XjwjCXF/zlLitqXGpTM8pn1qyxdj2MvIFljA7
 Qyc4iT8m3zUjaAbWQJT8eyD45YBpwUrf3MYx/dFbR2vpTmbf+CqIZ+7xCtE+F64bUb3V
 Ws63mydEDrvDdFiEqnVZU93qvfKlL3HsypZIq9NEqKB8mPb1OvTwT+ThcPmQMIavQqLn
 ACON/27SzxHlawVNQJMnfOPKu02lmekOeLayCWW9ZbCqvVnHkE8rTLZX//U5UuxpvmRE
 fGUQ==
X-Gm-Message-State: AOJu0Yw85+d5crySeQ7qpB7Ia3PEZwfWBuJ+N9fgL7QajQgakdl0dcH1
 lDsh1mFoydSFICJVIxvmAL7K9JY6J8rEZbzqMvopk0TK7IwVGJMLbIatYoVBF060SIcxFE/PTjR
 hW8j56GFTIo4j0z0sxI4NUQPwcUZLtzdR01Ty0HCuvTTZ6T3DrAsc6d/rd5pCTzRwMfPDql+O2M
 QQFRIhBlB/4iZJupe/Nbmh4wr7nwxvsj69DAFiBw==
X-Gm-Gg: AfdE7clgT+4n4omlKZIqiFOySsMi/fLlPKv2iB0XLsxY3ayzqpITaKU7ofTw18T1PcV
 tl0wRXfqwArf1EYv1/sg+3MqG5POj0kvLANiRFE5XvThRz2T9fJc4DQxctz4nSrcU+DFTpYu58i
 xd+BPutjsx2qBVu4zMgoAuHeXhZCLTxDEAUMfzC8PBgIvGtJEBnaoub0NU4734foreZCL68GJxo
 7d1zKMgPB2XIBBLbe3Ka8RvbhLkWBCmDfEQ42ZWJGnLMrHKp7kuuG9pQ0mM9sBRxUgyvMbt5aLP
 tP/IhF8wD4VCyiYAnEtTmuhaQpRGH1Qr1/QPr6Y6fG0RKLV+PMmrjuSiL6s7UhXsKLhjTuWJhbn
 TNw==
X-Received: by 2002:a05:622a:1a8a:b0:516:e6f3:c1f with SMTP id
 d75a77b69052e-51a55b21c1amr33095221cf.47.1782218923240; 
 Tue, 23 Jun 2026 05:48:43 -0700 (PDT)
X-Received: by 2002:a05:622a:1a8a:b0:516:e6f3:c1f with SMTP id
 d75a77b69052e-51a55b21c1amr33094631cf.47.1782218922526; 
 Tue, 23 Jun 2026 05:48:42 -0700 (PDT)
Received: from x1.com ([174.91.117.157]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51a51106a09sm22288351cf.0.2026.06.23.05.48.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 05:48:41 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 15/18] system/physmem: destroy ram block attributes before
 RCU-deferred reclaim
Date: Tue, 23 Jun 2026 08:47:56 -0400
Message-ID: <20260623124759.125399-16-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623124759.125399-1-peterx@redhat.com>
References: <20260623124759.125399-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

ram_block_attributes_destroy() was called from reclaim_ramblock(), which
runs as an RCU callback deferred by call_rcu().

However,when the RamDiscardManager is finalized, it will assert that its
source_list is empty in the next commit. Since the RCU callback hasn't
run yet, the source added by ram_block_attributes_create() is still
attached.

Move ram_block_attributes_destroy() into qemu_ram_free() so the source
is removed synchronously. This is safe because qemu_ram_free() during
shutdown runs after pause_all_vcpus(), so no vCPU thread can
concurrently access the attributes via kvm_convert_memory().

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20260604-rdm5-v5-8-5768e6a0943d@redhat.com
[peterx: rebase on top of qemu_ram_free() change]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 system/physmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/physmem.c b/system/physmem.c
index db8ad84ab6..c4bfb57625 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2582,7 +2582,6 @@ static void reclaim_ramblock(RAMBlock *block)
     }
 
     if (block->guest_memfd >= 0) {
-        ram_block_attributes_destroy(block->attributes);
         close(block->guest_memfd);
         ram_block_coordinated_discard_require(false);
     }
@@ -2610,6 +2609,7 @@ void qemu_ram_free(RAMBlock *block)
     qatomic_set(&ram_list.mru_block, NULL);
     /* Write list before version */
     qatomic_store_release(&ram_list.version, ram_list.version + 1);
+    g_clear_pointer(&block->attributes, ram_block_attributes_destroy);
     call_rcu(block, reclaim_ramblock, rcu);
     qemu_mutex_unlock_ramlist();
 }
-- 
2.54.0


