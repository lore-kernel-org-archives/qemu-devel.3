Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E46C5DF66
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 10:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuSmD-0005xz-Pd; Thu, 13 Aug 2026 06:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wuSmC-0005xY-9x
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 06:35:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wuSmA-0000BS-Tz
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 06:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786617306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ds3ELgiFjPHuwUmXMHjb6LoAFKBT/u0B05y4PCqDrU0=;
 b=NXx+NLc6wU8Dsaz01fPm+esFP8s9tI00Art1IoNgpC5MkZ9KB4NmvR/FsYxykQpmhj8roi
 6JRprYUCb8BEfO7gwPZUL6AOkcPhPhv3vKXnqGCFsQzQkRKW6B/Yc/4bALMRqc6Xa6QfQi
 2eftEsvGepREU4i0Uz272RHk0RIH7g8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-VVeHvi0EMByRj8FkW2KSUQ-1; Thu, 13 Aug 2026 06:35:05 -0400
X-MC-Unique: VVeHvi0EMByRj8FkW2KSUQ-1
X-Mimecast-MFC-AGG-ID: VVeHvi0EMByRj8FkW2KSUQ_1786617304
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e475f83a2so3127931a91.1
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 03:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786617304; x=1787222104; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ds3ELgiFjPHuwUmXMHjb6LoAFKBT/u0B05y4PCqDrU0=;
 b=PHUfR1mksJy2RIGC+5ZXSP7MmnG9wxoi2I7iKmthVEPUrJGEGIaSGvg8zC2ySNTgX9
 kgq3zI59sbwQZtBpGJ+SzsqjnoEv9jgXepr16rrt3hemwA8OIM9tlocZur/697e4GQYn
 PqgPn04c41vtx8t5al82SOcZkeZPT5OOa/wsUXVJUVjLxHgtzBgajqWhcUan8F1sgYKQ
 A53RL3R7Z47lrDTq7XgnmLNSLmxcYrE/HoYXDj7Dp4yVxs2UWmu5qnmlWqZW4PTaZiY0
 DT9NliP5xMVFj8vh+WfvfgLPFuNRzIMhc2accIqFkZHAqHvLwi/WVCP0NIbRYXZ5IS4C
 EZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786617304; x=1787222104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ds3ELgiFjPHuwUmXMHjb6LoAFKBT/u0B05y4PCqDrU0=;
 b=d6tCoDqDdv0+tyeySm5NsGDmb+9aeKvhc09oJAHpvZSf/K+/KW6I37PG4iPR38+MkD
 W1ROE/WHtwZldBiH38VnLy9S43s+arnp80mw8G4wNk0n3IzYo106wSg96dGFGP0oSvbq
 p9wuL3Q3Iy2zbj1DU14rXQVZZ3ClWq1TyUt0MwocfvdvAdP+cICzn0wdwnbveWZ1uWcv
 iGpNdwehjCnxo3tzaax1K3CbCufDZrhqJL6VWds+NpijYb0q0nCclkHWTSjlVWR96sDN
 fqbaDO1Fsi0i5qz7WNVVQkkW7TmEjJsRwrwEIObOd0/b/V2+x6XVA3LccpGSJWKFZdyw
 AAQQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RonemQane/MDbATX1qW1N8McPt0b6MJN3j7NXaCAVFEmdITNRYtcjTuQYOxgsPMgAi3UiUEDWZb9nSQ@nongnu.org
X-Gm-Message-State: AOJu0YxvPq7g39D5uuLWcH+wND/nuqfAstfaArYM/dqjU+8xKYZhWCp6
 8/GhA6qUKhk0ZigJIj/kNQJRx8YqZ10D7kCxWf0+y2ENzAm69IApIKiyv1tL1rPEIDBGJ1DkohY
 4jyvy6GHB/N0cBG7/qmMKtEQURvdMX0edNQB4YCPyyjumG5Sc3w4oohvlch8CjTg7
X-Gm-Gg: AR+sD10vLPtckZRf/4iDEM2HfOViRTh/gUpFgKMCMlm+9RLH9GTRVvlWTl9qa4LcY7T
 lkGJ+/JQcR4RM3qmc1xt5BPPUhTM2PSBemAPbIQ67W9+RftDie4rKjShbps6EYNgMyVQI8hHI22
 1nsFiKnWC8fejazb6V0dZkysuq6QjzDgVfGFQ14RQghdMmAKS1kNt9E2GNDyX3s1zFOvzheEvMj
 ZYlc8Z/r2G97Vw0Bkd8+1u2pPW21ijrAoyvgTo8iFCSQP0jtQvlVyelwDS6Hb0nFIVxRSJfiWw3
 N//uqkvLV2/hO7bGI+zC/Lr/faVANpePeH9Zo1W2irRmL36b6imNDcoBv+BvNa36uoCprZviSnt
 6F93vQNTERNkdyNY81uya+MbBmqcwctIV4w==
X-Received: by 2002:a17:90b:5310:b0:38e:2524:724f with SMTP id
 98e67ed59e1d1-3931e232118mr5315307a91.12.1786617303837; 
 Thu, 13 Aug 2026 03:35:03 -0700 (PDT)
X-Received: by 2002:a17:90b:5310:b0:38e:2524:724f with SMTP id
 98e67ed59e1d1-3931e232118mr5315260a91.12.1786617303326; 
 Thu, 13 Aug 2026 03:35:03 -0700 (PDT)
Received: from rhel9-box.lan ([106.219.133.98])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3931ced0781sm2918093a91.11.2026.08.13.03.35.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 03:35:03 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: ani@anisinha.ca, agraf@csgraf.de, graf@amazon.com, qemu-devel@nongnu.org
Subject: [PATCH v5 05/11] backends/igvm: add a tracepoint for
 qigvm_cleanup_memory
Date: Thu, 13 Aug 2026 16:04:07 +0530
Message-ID: <20260813103425.24474-6-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260813103425.24474-1-anisinha@redhat.com>
References: <20260813103425.24474-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

Useful for debugging memory region cleanups.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 backends/igvm.c       | 1 +
 backends/trace-events | 1 +
 2 files changed, 2 insertions(+)

diff --git a/backends/igvm.c b/backends/igvm.c
index 9b101c8182..7b7bdc72b7 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -1120,6 +1120,7 @@ void qigvm_cleanup_memory(IgvmCfg *cfg)
 
     QTAILQ_FOREACH_SAFE(imr, &cfg->memory_regions, next, tmp)
     {
+        trace_qigvm_cleanup_memory(imr->mr->name);
         memory_region_del_subregion(get_system_memory(), imr->mr);
         vmstate_unregister_ram(imr->mr, NULL);
         QTAILQ_REMOVE(&cfg->memory_regions, imr, next);
diff --git a/backends/trace-events b/backends/trace-events
index 009a25b0be..9b7b9b7d68 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -33,3 +33,4 @@ igvm_reset_hold(int type) "type=%u"
 igvm_reset_exit(int type) "type=%u"
 igvm_file_loaded(const char *fn, int32_t handle) "fn=%s, handle=0x%x"
 igvm_process_file(int32_t handle, bool context_only) "handle=0x%x context-only=%d"
+qigvm_cleanup_memory(const char* name) "freeing mr %s"
-- 
2.42.0


