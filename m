Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DFFF10D14A4
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 11:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7B97-0003bV-Ck; Mon, 30 Mar 2026 07:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w7B8h-0003Rk-Uf
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:50:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w7B8f-0005wP-VM
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774871436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5fKt7A2FD1i1SFTtrZ6g0b8Qc8madY+JGGQ0SAw4LSg=;
 b=GL6lC1BHccK6bWNl+fR1DlLwW+cdK2zcrIYDE/QaGinB83D7G5o0OI05b4HM2lC3LO239T
 xd4vtID+xu/oUAzoPfwlvAaVmCxdN7yDoPKuCBhKKNKzs8aNjlDZyorUJNtd14SFUMkidP
 rK5xBsgpkFOmy8N4nK62dLoVFwRiNRk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-Vno_V2PkOwyCRYN7gdjzEw-1; Mon, 30 Mar 2026 07:50:35 -0400
X-MC-Unique: Vno_V2PkOwyCRYN7gdjzEw-1
X-Mimecast-MFC-AGG-ID: Vno_V2PkOwyCRYN7gdjzEw_1774871435
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43cfc3bf7f6so1449277f8f.2
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 04:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774871433; x=1775476233; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5fKt7A2FD1i1SFTtrZ6g0b8Qc8madY+JGGQ0SAw4LSg=;
 b=Nw+H6iCTgyJxRyB1285wQaitr/8FF7t+KGxyutvLIGUaTmcQq9y+ijK3y1gltjfdD3
 OKmCd7ALWzWgJCVPjMaLeGj9e//X1EyVcaxd76qcUiIDf5sFiCcKd4BdUTdYNyXvAchX
 lanYyEU5dQuImwgnGfTcb7PeQcQIsp925vBgUCru7/VB5+OR2CftwZCHgSRSQvAoNFAl
 aNDdrvLCrjKo4HKvAL96gehwbUf3kuyeJ3nW8PTX/hcpjwISWIB6/VVwOfsM/LFfFHPU
 HvUl5pac5tmc++ewV2mlrNj/akKIwFmQFViysWMUx5g5pH5KgIDXx+MqsOFyUliTh8+K
 jHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774871433; x=1775476233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5fKt7A2FD1i1SFTtrZ6g0b8Qc8madY+JGGQ0SAw4LSg=;
 b=Mqm6DCu8KvZnvXx2dONzRUWwGw+NeM/57tVIAab21aH/lh/d0bkoKlilJK3mr+AP16
 lzODYGf2rXbkzmQaJgFDcyolM+K1mC5xycLMRh69pZdLtHZUyzDkRi0G1OjML5O4RPX7
 MslJ6vAyLg8zGeHDCTo6eFF1xxf7SgKLH/lYmBK5woYOn2EYrqKYZKc8Tn2b9uImlCki
 Y6+gz32tnOhwCtEb+kCnj/23FOlm/Xvu8EqxYpnhYgl+xpCUl7tONslcQwqTzdRWKw0S
 +8mly5RQZLzch03Q8lMJ8PsJuIxfq8DBmxXNdWAzE64uo1UsFw3HOBLNXjZvTkdCqoVh
 aWUQ==
X-Gm-Message-State: AOJu0YxuQ9KrS61OD/SX6bHmhdMZ26WXznXemf0LzWf4qb6uMzVHLe7z
 KkZ2sK+DoTfa4mcRK7c/t8KXDNWYk+ggm6C+5scHckq9SnRpVj2QanKLtvpHkvUHJ3/mNzGQqZ8
 9ieGJiSL2v/ZQe5INbjysjcNcIb7P07/9uNxwQrqNRMOXDtSFGV3fMkSHPGq1BW0ItZ8ZtZHEL9
 sF3+eVPUMJZnDt4awEPDjH+O72k2JFWTbo9vhBIjM/
X-Gm-Gg: ATEYQzzuQqODn0aqb3JIGR+Iur+QrblnVqLf9EqDiBht1aNHnYAe8TQvBmZWHdTtW/6
 g+JUm7pk5cEyVfwkT67BW2lGk9c6LYM9sNVvGPQWfInVensGhypG8aQxoxvlEXwST9QC5dK4fA0
 AVJcmbb63MR3ruLm0WdlWeN9WrFEoTCMdLCGoPHpF4bBLNIrHR3A48GbaB314ooURx/TPzQLEml
 z7b9NzfwSSCgNLlx80475kWv6mK9ifAVWjfJsg8b0JOr6EYy+k8Es3H1uSXLa1bnXCBcUifZSNd
 sl2VsVmkj3nlftmC78k4NQmNb4kb4Jv1A06DXiQTwcTiG1iE3aDegx+yOZiJx9cS6OlISPw3nud
 V4Shvm1F6nZYgNWhn44otH8b/jhZ8VKdtT7s9Ysf4v3T2oFrxaz2NDSLmuuWLCfgsZcXrsOaP8I
 mtxl1iXOkQ+bHMYqcy0AGSrX5s
X-Received: by 2002:a05:600c:1593:b0:485:3bc7:a231 with SMTP id
 5b1f17b1804b1-487341a3df0mr70764595e9.29.1774871433294; 
 Mon, 30 Mar 2026 04:50:33 -0700 (PDT)
X-Received: by 2002:a05:600c:1593:b0:485:3bc7:a231 with SMTP id
 5b1f17b1804b1-487341a3df0mr70764275e9.29.1774871432709; 
 Mon, 30 Mar 2026 04:50:32 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48727c0cdf6sm221937835e9.2.2026.03.30.04.50.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 04:50:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Yuma Kurogome, Ricerca Security, Inc." <yumak@ricsec.co.jp>
Subject: [PULL 05/12] hpet: fix bounds check for s->timer[]
Date: Mon, 30 Mar 2026 13:50:09 +0200
Message-ID: <20260330115017.256211-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330115017.256211-1-pbonzini@redhat.com>
References: <20260330115017.256211-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Fix an off-by-one issue in QEMU's HPET read and write MMIO handlers.
Both handlers check timer_id > s->num_timers instead of timer_id >=
s->num_timers, allowing a guest to access one timer beyond the valid
range.

The affected slot is initialized properly in hpet_realize, which goes
through all HPET_MAX_TIMERS elements of the array, so even though
it is not reset in hpet_reset() the bug does not cause any use of
uninitialized host memory.  Because of this, and also because (even
though HPET_MAX_TIMERS is 32) the HPET only has room for 24 timers in
its MMIO region, the bug has no security implications.

Commit 869b0afa4fa ("rust/hpet: Drop BqlCell wrapper for num_timers",
2025-06-06) silently fixed the same bug in rust/hw/timer/hpet/src/device.rs.

Reported-by: Yuma Kurogome, Ricerca Security, Inc. <yumak@ricsec.co.jp>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/timer/hpet.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 767093c431a..42285cff762 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -464,13 +464,14 @@ static uint64_t hpet_ram_read(void *opaque, hwaddr addr,
         }
     } else {
         uint8_t timer_id = (addr - 0x100) / 0x20;
-        HPETTimer *timer = &s->timer[timer_id];
+        HPETTimer *timer;
 
-        if (timer_id > s->num_timers) {
+        if (timer_id >= s->num_timers) {
             trace_hpet_timer_id_out_of_range(timer_id);
             return 0;
         }
 
+        timer = &s->timer[timer_id];
         switch (addr & 0x1f) {
         case HPET_TN_CFG: // including interrupt capabilities
             return timer->config >> shift;
@@ -564,13 +565,15 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
         }
     } else {
         uint8_t timer_id = (addr - 0x100) / 0x20;
-        HPETTimer *timer = &s->timer[timer_id];
+        HPETTimer *timer;
 
         trace_hpet_ram_write_timer_id(timer_id);
-        if (timer_id > s->num_timers) {
+        if (timer_id >= s->num_timers) {
             trace_hpet_timer_id_out_of_range(timer_id);
             return;
         }
+
+        timer = &s->timer[timer_id];
         switch (addr & 0x18) {
         case HPET_TN_CFG:
             trace_hpet_ram_write_tn_cfg(addr & 4);
-- 
2.53.0


