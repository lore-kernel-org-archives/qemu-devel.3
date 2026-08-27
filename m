Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD738C61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:15:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzarh-0002hD-NS; Thu, 27 Aug 2026 10:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzarg-0002gb-Lz
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:14:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzarY-0005l8-V4
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:14:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787840032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b5m3PCBo4qZ8ZChzlOr1MQQV5+IdqKQ4NKkucVjzKRs=;
 b=alHCZYyDLREdoeTKtRYUMBe1+mJ0hE3S2nd9uyjyw0wiGGjfnuS2fEqhiCCyrglgE1PpZJ
 UYeToYRwATsx8hv3TiXc2FBxsYg+mEfRes1vZ3As9UmNYjfg60j7I8JQL/IoDdCUoBcWDK
 IqZMiFC24eNcWazNHKvCG36U49uPYQg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-ZYwWhEsvPZSnpwJ5WvV8yg-1; Thu, 27 Aug 2026 10:13:50 -0400
X-MC-Unique: ZYwWhEsvPZSnpwJ5WvV8yg-1
X-Mimecast-MFC-AGG-ID: ZYwWhEsvPZSnpwJ5WvV8yg_1787840029
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49b0e6638e3so5624455e9.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787840029; x=1788444829; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=b5m3PCBo4qZ8ZChzlOr1MQQV5+IdqKQ4NKkucVjzKRs=;
 b=Dr/uUL8sWgQ5IQoGwvhHGTsf9NrLbeOdQafkDVxRHA/a1qGZPUTJTgHQlPkgAj+QIJ
 NsY/2bomNBa1/uCSE/lkbs3MUw5xSKKSKBHm1d5kHMytXoYmXSGkcAVACQbETkG6FAIP
 c2v4VTo8gJ4o6p8Tq/zut8GyDpn2+L6l9iFdMbJ7N+qcOQsSwXEApHjfakz3O4jnwmEw
 Iq1ROzkI6rQ2EIywMfaNqPCPf0PXDMihEytEVuDa0CxtzZFj+Ax+OGv+K1XPrxI9LMl0
 zsi3Rs4hbpzLSPL0bc0z9mZoulHc/l8LMpn3uwrbc79vevQon1XuhKHDZ38X4N1EiQSC
 3Xmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787840029; x=1788444829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=b5m3PCBo4qZ8ZChzlOr1MQQV5+IdqKQ4NKkucVjzKRs=;
 b=TUqsSr52esxp4So9+89oyB4Cxx0PVfNTbTnSiy/IjTFIGcYl4L6IcUBGoxf4Ot4vRD
 E2qGI1RfUoK/vR6cifp7JejoTwuIMC9G/voPSDAWXMa7IisVlMRgHQ1JXT+LsrEzorcT
 jkGl1moxIwiVTaW79ncs15MD7lLNJPoXAJo55YnsoKSJhaq3L3EG+fvOkLds4CVPBVhq
 9wvx0cONJdZSrTU/j3xN5mH+b5L/SJl2vYbKT+DB7DQqNyNUI4W3Pkidk/NqNdCMIGBH
 3oPIVGAYgKaFiIxCm9M9/AQHGz35j2Ya4iFB9R7J+B7jRk2dVNyqzzPZaHdYP4HIbRa2
 BqWg==
X-Gm-Message-State: AFuF++mz2ELZwd8j1RqV5jhbcmFts2FGGELgDtSIP85Btn2lrcIxJsX+
 q6ezgk4LakURJ+zY6sGlTzkrXWOJw9ncYl8Mpa4BC9Cj80uxxwMEsCvl4Xh+gQ/V8pigimX26cy
 wtFmN8zHfiPaR5KyKV9rWSnUAN5lNV6ST61Qid3ZpoKkzqW2xbBRU1vsQXSqq8ixVtuEXDbXe9w
 HuGARrHzCBZ/5m8mmOGwKMNhowdc8Onm0nBVUGQrS5
X-Gm-Gg: AR+sD11XBqQ3w1qexDXHb/RU4w6E1mS3LlTxmo3JWimJW5TjF/ggwN3XDWgyCJcT2Ib
 N4VeHHB3tTGGXiNHVUDMMiDILnbhaP3B9zMhXmLmAf4BseSljOshgdOlxSmDc4Wd5PWIIob02Sc
 U6LTyu5CQoGPYdXAOyE+fYIbEEv4oCpNYUU2SChqql89MOgmP6fzPINoj+XDAZFvAZCb6l/0JQW
 fPxfSIluNSZeINGR9Q10qqoaK+C5hipE3uALcGH0mDhjJ9pCFO7IjX+k/8xUmROOqrmm287UEUK
 qPgI08moeM55aE7SLmjfK90ckxHBk9f2Z1RlxD/WbtjZ+Fv081qo7NkcFoK89oqky6UWUhNlfvH
 IN8MnKV+XV2eeH5tF6S2Urrkfdc7l4TsSH4BavyrHBQhCG4sNCHvNMpGvsu9gezUX8wWGZSfYGR
 +t51M=
X-Received: by 2002:a05:600c:4e15:b0:49b:8e8f:a409 with SMTP id
 5b1f17b1804b1-49b8e8fa4a6mr66882385e9.13.1787840029412; 
 Thu, 27 Aug 2026 07:13:49 -0700 (PDT)
X-Received: by 2002:a05:600c:4e15:b0:49b:8e8f:a409 with SMTP id
 5b1f17b1804b1-49b8e8fa4a6mr66881185e9.13.1787840028890; 
 Thu, 27 Aug 2026 07:13:48 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.151.49])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dd55283esm54934805e9.2.2026.08.27.07.13.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 07:13:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/23] rust: hpet: fix clippy needless_range_loop
Date: Thu, 27 Aug 2026 16:12:59 +0200
Message-ID: <20260827141314.1099352-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827141314.1099352-1-pbonzini@redhat.com>
References: <20260827141314.1099352-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Nightly clippy is a bit smarter and recognizes one more loop
that it wants to be written with iterators.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/timer/hpet/src/device.rs | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index ec0bca4496d..89ba7a5c4d2 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -938,9 +938,7 @@ fn post_load(&self, _version_id: u8) -> Result<(), migration::Infallible> {
         let mut regs = self.regs.borrow_mut();
         let cnt = regs.counter;
 
-        for index in 0..self.num_timers {
-            let tn_regs = &mut regs.tn_regs[index];
-
+        for tn_regs in regs.tn_regs.iter_mut().take(self.num_timers) {
             tn_regs.update_cmp64(cnt);
             tn_regs.last = CLOCK_VIRTUAL.get_ns() - NANOSECONDS_PER_SECOND;
         }
-- 
2.55.0


