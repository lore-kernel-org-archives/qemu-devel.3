Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA17CCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 16:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8LnF-00028E-1W; Mon, 13 Oct 2025 12:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8LnC-00027s-MZ
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 12:53:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8Ln9-00089d-UZ
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 12:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760374377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=9ROpKTB+0L5bDWmD9B011KEbtMbuEJDM80v6afnyP4o=;
 b=Vpd8Qr/1u4Zt/oYEp204stl2RhiKVN3/YjueqaBfq/yf31LnrMFz7ZtOVmFKNTFiyHeFTk
 NL5798Z+yq/NO95VGxoYSShoX3I0QcIlmvOXzptjOkrV3VeMks32qGh1gge4w2qD4z8HxA
 6lNAL1QnJWuyRvV3A8KrbfLLumjdSSw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-zrANM8w-NiOIrZcQ_Bkh1Q-1; Mon, 13 Oct 2025 12:52:55 -0400
X-MC-Unique: zrANM8w-NiOIrZcQ_Bkh1Q-1
X-Mimecast-MFC-AGG-ID: zrANM8w-NiOIrZcQ_Bkh1Q_1760374374
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e47d14dceso23515605e9.2
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 09:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760374373; x=1760979173;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9ROpKTB+0L5bDWmD9B011KEbtMbuEJDM80v6afnyP4o=;
 b=D7c5CF+UEAR2PI9eFQt9BS/lsO+3PtI3dQI0T4M2eIyCYJlZ4EOWgMP+MJT3BNwJ6a
 u+nOWd/LQF3l4IDqpiUeFpDd6iYrGlHk69ujDANmxbvEZT6NpPVFa0LNdXbEcsqYI2VU
 rdBee0b6PFiBV7moKEaFt9dTd0IZTCxBUqSTvz3RJmtDFpvMXtwqANf4mvL7WRKTegL8
 HJYV7K2nVCpJowjDM2qfSegdK1Zti00TB9OmZTGdKtb844fnYctJEgzs5iUs9VPOCBK0
 wFtfqu+v5gYeEvctBLNvE+o0nv48nCOlgs7664Pfwo62D+S1EkwGgJusIrf5/Xz8EZI1
 liRw==
X-Gm-Message-State: AOJu0Yz3MIMlPrfWIlWwpG690kH1acmkETC3Wr6Ga+pgcNRAVD1oU6Nq
 XmwhQdLEDfuyczTcg5a3FGnG30AmVdeMxHp9NAsY8glpaOy9l4HFDXcV2wDvxAv2exO8FLwhk3M
 zFXeM97NtCYipM9EUKh7SUrZKyOPrx7giywenFY98IniiUp5Y09eA3edM0ba8oh9PI3yrX2BLiT
 CjJKPblPb2AcDkz6Q86Hc/Dc/ONXOBV+xfcNBFgKuj
X-Gm-Gg: ASbGncuqUMcBjNBPn19heM4pnul4vbsy3wf36Bom483rB412KHV7sbnY9XIV1ro8Xt0
 vJIStbHFGURh55KpjXq8ipVjzuGKvPuCIxSpWNcqfBFLqJnHBUOn3ekS/uZHInr17cK4Ak53za7
 Wi6TWRsNGl+wl3cCHHiqVgYcpJJURg9xgw4IsaHmV84bdQgloKnIKu6Zm3tq8YRrBHAvoU9FLHT
 Y3+4j2UoWf0wyn9i2yCNWicWGLHQu8/Dp5knPUZ2FliT/Md2174lRYGy7v7r4irYzIGLahCkFB0
 vRDGWrkLELjaue7ESAWafNNguZ9NTvhIq8jC0ZBPAOGTnsO0eQbhdxyfg6OI8r7Hb7P+YDvPnCs
 AfoEv6jIsbyVciwLZC4JHQ0XUbPTRO9sCqkUpw1R4l8Q=
X-Received: by 2002:a05:600c:820a:b0:46c:e3df:529e with SMTP id
 5b1f17b1804b1-46fa9af9019mr156081455e9.19.1760374373573; 
 Mon, 13 Oct 2025 09:52:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTpbZjIFjvl/BR/8AmthcqfLW27tXPicAXur8epFXINsapt9qkmUPtId8LihZ62Iya+KCLKw==
X-Received: by 2002:a05:600c:820a:b0:46c:e3df:529e with SMTP id
 5b1f17b1804b1-46fa9af9019mr156081335e9.19.1760374373166; 
 Mon, 13 Oct 2025 09:52:53 -0700 (PDT)
Received: from [192.168.10.48] ([151.61.22.175])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb482ba41sm195893785e9.4.2025.10.13.09.52.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Oct 2025 09:52:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH] rust: hpet: fix fw_cfg handling
Date: Mon, 13 Oct 2025 18:52:51 +0200
Message-ID: <20251013165251.1004096-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

HPET ids for fw_cfg are not assigned correctly, because there
is a read but no write.  This is caught by nightly Rust as
an unused-assignments warning, so fix it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/timer/hpet/src/fw_cfg.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/hw/timer/hpet/src/fw_cfg.rs b/rust/hw/timer/hpet/src/fw_cfg.rs
index e569b57b93b..bb4ea8909ad 100644
--- a/rust/hw/timer/hpet/src/fw_cfg.rs
+++ b/rust/hw/timer/hpet/src/fw_cfg.rs
@@ -40,7 +40,7 @@ pub(crate) fn assign_hpet_id() -> Result<usize, &'static str> {
         assert!(bql::is_locked());
         // SAFETY: all accesses go through these methods, which guarantee
         // that the accesses are protected by the BQL.
-        let mut fw_cfg = unsafe { *addr_of_mut!(hpet_fw_cfg) };
+        let fw_cfg = unsafe { &mut *addr_of_mut!(hpet_fw_cfg) };
 
         if fw_cfg.count == u8::MAX {
             // first instance
@@ -60,7 +60,7 @@ pub(crate) fn update_hpet_cfg(hpet_id: usize, timer_block_id: u32, address: u64)
         assert!(bql::is_locked());
         // SAFETY: all accesses go through these methods, which guarantee
         // that the accesses are protected by the BQL.
-        let mut fw_cfg = unsafe { *addr_of_mut!(hpet_fw_cfg) };
+        let fw_cfg = unsafe { &mut *addr_of_mut!(hpet_fw_cfg) };
 
         fw_cfg.hpet[hpet_id].event_timer_block_id = timer_block_id;
         fw_cfg.hpet[hpet_id].address = address;
-- 
2.51.0


