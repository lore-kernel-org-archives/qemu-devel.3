Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F56E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 17:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLmtV-0006oV-2z; Thu, 12 Dec 2024 12:22:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLmtN-0006mS-8F
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 12:22:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLmtG-0006mY-WF
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 12:22:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734024137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qns/X8H2PNJ05wsGWyjsR/L+wlODTrfFTvyB/zyipf8=;
 b=bLbXmtifw+ysx+4NpsY2ubBP17Pw13xsmjd+GnqxXe8tiJJ4+/OBuqQiLe2oftv3BQ+foC
 UVoX2sSpx5/D/G+7/6RecW+F6fNmv2z4UBbL6ckdmQMXJSDoru1LydWTH/YiRuJdVq/W++
 YOGGR3COpB2dqE4By3PMMD6ydxuVt4s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-UIiAOvAoMW-pjaCVcgUL7A-1; Thu, 12 Dec 2024 12:22:16 -0500
X-MC-Unique: UIiAOvAoMW-pjaCVcgUL7A-1
X-Mimecast-MFC-AGG-ID: UIiAOvAoMW-pjaCVcgUL7A
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43582d49dacso7948885e9.2
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 09:22:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734024134; x=1734628934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qns/X8H2PNJ05wsGWyjsR/L+wlODTrfFTvyB/zyipf8=;
 b=OYqmuzs1yQZg1XJunMHgLRvegEdNbYLezOcpFKIiStnlQLtGIUDcHg2k3zlSFk2I+m
 wF+YMrc9z52n32cHIZy0ApHsSJkjz1zoPGVtowQ5UbLv5oUb/+AemLbzV3qe9yJHQ+O7
 3+TtGsmfq5WrsVooPHZxxyVvLh0nYMdoY1wXzzVyySErG0W3kkuGGjduaJoG5Un4w0aJ
 ZAKonV92rY1GAnHkDItD+jBpHw0hncV941PVg2HTtwwj+cQ5/ERQaFVlwWq6NGUutMKQ
 KwLfzTyJELFswR0SLSYsXQPagAm0atKJa9BzO/I3IS00w7PpZ1+mZYXAPdSTYK8yXdkj
 qDHg==
X-Gm-Message-State: AOJu0Yx53eQpcn4STgmMsoq44gpvYfskyDfOF+Rfl/pbMcNP2zMQl4kj
 HnL8Lm49rX8RrQJaxb//W7IhbH2vUKE8ErNc/DkpWlO3N/N6/HIE2/wRYeFZmB+WjnDSiPrSvSe
 2rME3SYteqe8cSxzLzH8MMFEYyc5S8M6ocwCjQXvskfafQCYX9qjJfo3NVgWc2hq3EaVh/5PMmP
 EMjFFpGfEgUUfwk1vrOy4qOfmGNqRDF4infpbi
X-Gm-Gg: ASbGncuevHBD1DBErx8ddhKuCMRaNZhVMM2piUWP+VCEHvN4jjoyyOuAMXknJBZ4EYH
 drDyBqwqfrE6hwb1a3/LlGwynbUAA8RKndSYBJZ7XRF0qVJENxeLdkNu4BaZid3NI93F93XH/+/
 iP1B4SvS1NokD8Aa3e8tMzx0GYDJ2mRW+ETJocqrduuYfWvMlnBL4QWNk1kMTyL7wwfOEzQeklv
 FoiWgIQjZLXfpZ4QmSSSoX+3jookekFgZiccaW14jjSGfze9zZ44aLunA2t
X-Received: by 2002:a05:600c:3593:b0:435:294:f1c8 with SMTP id
 5b1f17b1804b1-43622883637mr31159165e9.28.1734024133906; 
 Thu, 12 Dec 2024 09:22:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbopeWngomw2GJnLUPpY65052E82dIWyU/Xh4pmo+qt4fFEVBFBxQb/yuBEwHKpSSHpc/W6A==
X-Received: by 2002:a05:600c:3593:b0:435:294:f1c8 with SMTP id
 5b1f17b1804b1-43622883637mr31158895e9.28.1734024133412; 
 Thu, 12 Dec 2024 09:22:13 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4362555334bsm22739135e9.1.2024.12.12.09.22.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 09:22:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	qemu-rust@nongnu.org
Subject: [PATCH 1/7] rust: pl011: fix declaration of LineControl bits
Date: Thu, 12 Dec 2024 18:21:58 +0100
Message-ID: <20241212172209.533779-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212172209.533779-1-pbonzini@redhat.com>
References: <20241212172209.533779-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The bits in the LineControl struct were backwards. :(

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/lib.rs | 82 +++++++++++++++++------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.rs
index 4dc0e8f345f..d5089f78854 100644
--- a/rust/hw/char/pl011/src/lib.rs
+++ b/rust/hw/char/pl011/src/lib.rs
@@ -319,32 +319,21 @@ fn default() -> Self {
     /// Line Control Register, `UARTLCR_H`
     #[doc(alias = "UARTLCR_H")]
     pub struct LineControl {
-        /// 15:8 - Reserved, do not modify, read as zero.
-        _reserved_zero_no_modify: u8,
-        /// 7 SPS Stick parity select.
-        /// 0 = stick parity is disabled
-        /// 1 = either:
-        /// • if the EPS bit is 0 then the parity bit is transmitted and checked
-        /// as a 1 • if the EPS bit is 1 then the parity bit is
-        /// transmitted and checked as a 0. This bit has no effect when
-        /// the PEN bit disables parity checking and generation. See Table 3-11
-        /// on page 3-14 for the parity truth table.
-        pub sticky_parity: bool,
-        /// WLEN Word length. These bits indicate the number of data bits
-        /// transmitted or received in a frame as follows: b11 = 8 bits
-        /// b10 = 7 bits
-        /// b01 = 6 bits
-        /// b00 = 5 bits.
-        pub word_length: WordLength,
-        /// FEN Enable FIFOs:
-        /// 0 = FIFOs are disabled (character mode) that is, the FIFOs become
-        /// 1-byte-deep holding registers 1 = transmit and receive FIFO
-        /// buffers are enabled (FIFO mode).
-        pub fifos_enabled: Mode,
-        /// 3 STP2 Two stop bits select. If this bit is set to 1, two stop bits
-        /// are transmitted at the end of the frame. The receive
-        /// logic does not check for two stop bits being received.
-        pub two_stops_bits: bool,
+        /// BRK Send break.
+        ///
+        /// If this bit is set to `1`, a low-level is continually output on the
+        /// `UARTTXD` output, after completing transmission of the
+        /// current character. For the proper execution of the break command,
+        /// the software must set this bit for at least two complete
+        /// frames. For normal use, this bit must be cleared to `0`.
+        pub send_break: bool,
+        /// 1 PEN Parity enable:
+        ///
+        /// - 0 = parity is disabled and no parity bit added to the data frame
+        /// - 1 = parity checking and generation is enabled.
+        ///
+        /// See Table 3-11 on page 3-14 for the parity truth table.
+        pub parity_enabled: bool,
         /// EPS Even parity select. Controls the type of parity the UART uses
         /// during transmission and reception:
         /// - 0 = odd parity. The UART generates or checks for an odd number of
@@ -355,21 +344,32 @@ pub struct LineControl {
         /// and generation. See Table 3-11 on page 3-14 for the parity
         /// truth table.
         pub parity: Parity,
-        /// 1 PEN Parity enable:
-        ///
-        /// - 0 = parity is disabled and no parity bit added to the data frame
-        /// - 1 = parity checking and generation is enabled.
-        ///
-        /// See Table 3-11 on page 3-14 for the parity truth table.
-        pub parity_enabled: bool,
-        /// BRK Send break.
-        ///
-        /// If this bit is set to `1`, a low-level is continually output on the
-        /// `UARTTXD` output, after completing transmission of the
-        /// current character. For the proper execution of the break command,
-        /// the software must set this bit for at least two complete
-        /// frames. For normal use, this bit must be cleared to `0`.
-        pub send_break: bool,
+        /// 3 STP2 Two stop bits select. If this bit is set to 1, two stop bits
+        /// are transmitted at the end of the frame. The receive
+        /// logic does not check for two stop bits being received.
+        pub two_stops_bits: bool,
+        /// FEN Enable FIFOs:
+        /// 0 = FIFOs are disabled (character mode) that is, the FIFOs become
+        /// 1-byte-deep holding registers 1 = transmit and receive FIFO
+        /// buffers are enabled (FIFO mode).
+        pub fifos_enabled: Mode,
+        /// WLEN Word length. These bits indicate the number of data bits
+        /// transmitted or received in a frame as follows: b11 = 8 bits
+        /// b10 = 7 bits
+        /// b01 = 6 bits
+        /// b00 = 5 bits.
+        pub word_length: WordLength,
+        /// 7 SPS Stick parity select.
+        /// 0 = stick parity is disabled
+        /// 1 = either:
+        /// • if the EPS bit is 0 then the parity bit is transmitted and checked
+        /// as a 1 • if the EPS bit is 1 then the parity bit is
+        /// transmitted and checked as a 0. This bit has no effect when
+        /// the PEN bit disables parity checking and generation. See Table 3-11
+        /// on page 3-14 for the parity truth table.
+        pub sticky_parity: bool,
+        /// 15:8 - Reserved, do not modify, read as zero.
+        _reserved_zero_no_modify: u8,
     }
 
     impl LineControl {
-- 
2.47.1


