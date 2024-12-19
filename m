Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E2BFE7718B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 08:37:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOBym-0006sT-Vl; Thu, 19 Dec 2024 03:33:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOByj-0006gQ-Jq
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOByg-0005G2-6z
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734597229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HLrfooTNBj4iNgOLqb5Ydjdi9unX3dn8owNvgl6hDAs=;
 b=ezccKb+tHaJxiQGbINl/9m6X48MapNa9nnk9PGl0REhwm7wl490WG5bHWUZJG5fu3l7bhd
 SDquZdA236FgXkSj/a2R4y4PkweFtoRWWEuTF72Uhd1USzKMzzDQNYhK2YXqiKUU93OIXu
 IJnubanH0rZHrDOo58ZqIRi0x0l8LBo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-BG5j7_ByP4CkC7YF_6_gNQ-1; Thu, 19 Dec 2024 03:33:48 -0500
X-MC-Unique: BG5j7_ByP4CkC7YF_6_gNQ-1
X-Mimecast-MFC-AGG-ID: BG5j7_ByP4CkC7YF_6_gNQ
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4361f371908so4283395e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 00:33:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734597226; x=1735202026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HLrfooTNBj4iNgOLqb5Ydjdi9unX3dn8owNvgl6hDAs=;
 b=AZQl1q5HFMjVm/Ev/9aUJ8TNO0UEnrbYA1rt+mRLBqX9vEEwrIHzv/3kY+np9HIEoH
 fYNktil80DYnlimWT+W+nJEd9PC4YyfY+5cIV/DFCFL4tzN/FKf5Y4GEpv18PXB3fMLZ
 5jIIAq461ycAI6unLRXPF48Htk5B0R2eQk/hy4v3qdGwmeD4SphVZuHbg7+LiltJcSfM
 dCiifoc2bT9mTyq/3YZSnpcg9MRG4IzLcOgL4dZUek3O3NgMKjtvX/InCWq4fWdLZSB8
 DrjYCL9C0/FzCtLMyUclXhkd3gYh8DTgKTJP4OA934ttBfTgLMVP6crZAYLOVuG+bmxi
 MPLg==
X-Gm-Message-State: AOJu0YznCjKN5pyvx+ZYymQm1fDxEHusOweNX7vCzgia9zaeZ5ldjj4T
 dwmZ62daHUlCFtqgG8d4VnZMDjLa1J0Zd32go/DlSic+9cNa0jf90AWm2MBvHWcXxlHrNKBQ5NI
 rhiYKobbDx4d9HGt/tOd8FuRaio7oIMMy2VPCodQhP9j50Z3ufbNCr9T7e7DDhR9qnjgnNeh4Iv
 baEdetkrDCUi7A50AAPM4oTH4BBikU1E4Eln0L
X-Gm-Gg: ASbGncsfJEY2mR69xVVsgfORBSe4jadGcnxjXa/y4Qp389VfgvlOsEnztH4wrRKr974
 LEka0Kcn2hIAY2BhL+FhaBmmNQEtvD/P7hEKfM6FfhKMlT9sKxxjl5sSJZezAYtfwHsuxKFnHYi
 QxrUMVdeL9V+WGHlqrnqT0xUv7c49sJill8EkiQ2HvWfKoL3kbZxM2lnlsVvctjOMtxEyUwYMzR
 4ztQzxz6VR3mhvTtgofnnFrC+i7/8J0Aip+WFN2cPzcS73UCSwcrGp6oy9+
X-Received: by 2002:a05:600c:4586:b0:434:f586:753c with SMTP id
 5b1f17b1804b1-43655341348mr47632745e9.7.1734597225601; 
 Thu, 19 Dec 2024 00:33:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJTxGPQXyWfsoNvpTggTdyX7K8DAvvijr2gt16sCgoGWG/brNtkf9fEokzDOh0TlRipa9iSg==
X-Received: by 2002:a05:600c:4586:b0:434:f586:753c with SMTP id
 5b1f17b1804b1-43655341348mr47632395e9.7.1734597225026; 
 Thu, 19 Dec 2024 00:33:45 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8acc02sm973305f8f.104.2024.12.19.00.33.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 00:33:43 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 35/41] rust: pl011: fix declaration of LineControl bits
Date: Thu, 19 Dec 2024 09:32:22 +0100
Message-ID: <20241219083228.363430-36-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219083228.363430-1-pbonzini@redhat.com>
References: <20241219083228.363430-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
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


