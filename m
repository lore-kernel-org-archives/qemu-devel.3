Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDE7C87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 15:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uix1I-0002op-9u; Mon, 04 Aug 2025 11:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uivXQ-0005hq-8W
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 09:47:40 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uivXN-0002Yv-9i
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 09:47:39 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6157ed5dc51so7780531a12.1
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 06:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754315256; x=1754920056; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LMgCrR6KlknYh+ENybJoq0RqAETuG6eMroYq7thwFcY=;
 b=sxOgOFjIyMhowtgPS6PXLRh8njZsIb7EhCo0m821r6F7KPlCHxsT4f4DqHjzkGlaGz
 V0Uagi6CoG/fQbqFQfaG796hSJg36uN/ZODv2q74wUN5JkFTo1qzOznShhOZgRzu9Xkg
 ns1PbY27rQheQj9tFhROvZYqSyHk/GvT6VGeA9QTrIVbK2Jc8uxPDG/TACR/FogOzdTG
 J7vMlqB4TpDo547+o1cC0YqOrUeWkSPLdbfZwxm2gYLf7jHebp7CoJebOtwM84tDyj4a
 JzYp7pqmo8BJzLWiAVN5ubaK+mkf5sBTe2iv5Z3cRyIJMLdC4gQn4cnD/4eBd1iQyAKf
 58Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754315256; x=1754920056;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LMgCrR6KlknYh+ENybJoq0RqAETuG6eMroYq7thwFcY=;
 b=LhtRGTyyx2vciLmdt+qaeQttLFPKCdlUttTJWrI5d7S5fuAodAiPZzSp4mIuDtLOiN
 YZ5Tvw2ZeWV8GJDTow4kIxEjiYNWLKkYcDpAA8NTjsHwDUscIx1HfMLoUJibirOzJIKt
 S5h0aOyas0QUgd9nbr+xBIrcXgZi9CTMRTH8SdiGSYHjPXJAxgyZjJxafRoPtna8l7in
 SaDaPf05ZTMm3hBl0KdFCsorD32Xit0rH3PbDSUE3kI/MJuWcDVDcDyKPtP4oSZSDw4K
 amCP8Q7vCsFg54chPVodP6iVysi77wh+NvDBeVkhKFG1ybIPcpj4FfIUbmkrMndoMTvS
 JjsQ==
X-Gm-Message-State: AOJu0YznUzF0QqNObV45jyKex9kV1BPqUn4vEwCftPjNZe4bGMBxoHBo
 MPpNj+lSoc1A98TehhE4gTYUN6cyI1a1QzbIuTFG7Om1SXwYNk/rdVzh5ccRMGnaDQI=
X-Gm-Gg: ASbGncu6b+bKGL0Pb8aoo2yKomCQdCHw+sOnakw71j+qnqGdBbMBBIbr6PS0bla8eDG
 +PtMbnYv/G5Ef8AVft7/gzV0V8U76Xrle8di0BoMEhszjfn6ReUhWrkodQcvjbSwNxUla/o8pJX
 GFputGcgpHv0w1e9fEH3ZgJw9+VIIYznujhWtJYIGB6sOtLQ3P+SbdDZ49ti8ms/TfjdNAOQuIV
 v1aZAs7hUVJiBg0OJJs/VSj5h50ZqNLoUciGseYnGHysPnxi/noJ1gnGfw9SosZaWbQsnyNkHPy
 bc5t94Eo9CTfyKgT2TNkylk9D4CoH2H0udqRot3J6hW6cUYo+VfsXnavaI9MQeFOWPB/2de2CzV
 HEvxIHg2pFQ4S2h4iDhN7dt8S+7F0GcqYRc9K6EVp+2s7XquYzjVdsudcO6CIu+MZmr4=
X-Google-Smtp-Source: AGHT+IFqOd9wQ9qUvXAzSSypDy8vF0aKHLWLlZv7VxJ/ZQ1eozu+WxLgzwynxPNhVI4/RJK6/T0AYw==
X-Received: by 2002:a05:6402:34c9:b0:615:a5d5:972c with SMTP id
 4fb4d7f45d1cf-615e6eb5b7emr8745017a12.6.1754315255602; 
 Mon, 04 Aug 2025 06:47:35 -0700 (PDT)
Received: from [127.0.1.1] (athedsl-4441708.home.otenet.gr. [79.129.182.92])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-615a8f15d9fsm6850590a12.17.2025.08.04.06.47.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 06:47:35 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 04 Aug 2025 16:47:15 +0300
Subject: [PATCH RFC 2/5] rust/qemu-api/log: add Log::Trace variant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-rust_trace-v1-2-b20cc16b0c51@linaro.org>
References: <20250804-rust_trace-v1-0-b20cc16b0c51@linaro.org>
In-Reply-To: <20250804-rust_trace-v1-0-b20cc16b0c51@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 alex.bennee@linaro.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=786;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=pk38yZHd4Z7OGorg/EcCACOf8ud5WhK9Uhm8ny8k1HI=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9rTG56S3drWlExMnV5ejBVenhXL0ZTN3ZjQlBqCmlhd1AvaUtwMEdDejBFQjF5
 cWFKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUpDNTh3QUt
 DUkIzS2Nkd2YzNEowRklWRC85c0J0aGdCN0YrVllYaUhSK3liT2JNM3hEOENZay9GYndWOUpBeA
 pKY3VZUTlnU1ZrQWluM21UTDh1NGRaRmJHYlMrQmdhSUR5Ym5jMEg1TjlxaDRicno1VjBNYXZoY
 TVOVGZLOFc5CmZGWG5waktqTVVDYmJMZGZaZnhnUjZnaFlFRnlxQXZzakdiTW9MU2ExQjFFZ2FS
 Szh2eWhuSk45SGFHTFpSSGcKOWlDN25mZXZlbHVRUjh6Q1FoVGc0bkhuSHRLS0lvVjQyek5ZMGt
 1ek41eVZsWjY0aDJZTE4yY3BxVUZ6K0lERwp4Y29OcDlDNTZmQlZrVEMxYXRkcnVmRjd6Rm1Pek
 tFV0NZNmtabklBN3Zzdk5WOVNTekxveEpDYTFHcTVoQzRUCmZ1Qlh4RjBleDhoQmZsZGtpOVpHR
 lFoL3dWUEpjV3l5NGVZUTlOMFFheGordEM3dkZBMVpnWWhYZTFsOFN0SlEKSEZRS1d6SjNCRSsw
 OXVncWY1V0M5MjJiUWkrUllJa2ttNW9FaU8vR3Z2SUJkenU2b3AwQ0F5Y0w1UnRzVmdNdAp3aDY
 xUU5ORDVqVDZVdE9nWEZYL0JkVUl2aHcwZFRTN2VRTXNkQ0VTN0hQVE1EU3laSDVIQ0lLTjdWUn
 ZTUkVECnUwd3FRbzAxd29KZEdrYjVPejMrYkljeEQ1UkJrVDFKTDFrZmxQekV6Mkhtc3d5VTRDe
 GhHcW5TQXVqZndDQzMKNHhlRHVUb3Z5ckhka2liQlpDMDlCVnkxQ0xweGpCdHpxRkMrNnlIWndH
 RUFLUU1CLytDOEkvKzVtN29Va2RGMgpDa29xWnArRkxWNnF6WHd2eWZVY2c1cXA0TFprN3Y0NCt
 oaU5QZ0pQQ2NCSmQzMHFSYnU5aDdBNEdldmkxQUJDCmYvNWZNZz09Cj1obHdlCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 rust/qemu-api/src/log.rs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rust/qemu-api/src/log.rs b/rust/qemu-api/src/log.rs
index a441b8c1f2e61b6aba95a3679ca9c426ab890c19..750ff4b4d878fabeac0bc2b28d291db4b824c760 100644
--- a/rust/qemu-api/src/log.rs
+++ b/rust/qemu-api/src/log.rs
@@ -23,6 +23,10 @@ pub enum Log {
     /// Log guest access of unimplemented functionality.
     /// Corresponds to `LOG_UNIMP` in the C implementation.
     Unimp = bindings::LOG_UNIMP,
+
+    /// Log trace item.
+    /// Corresponds to `LOG_TRACE` in the C implementation.
+    Trace = bindings::LOG_TRACE,
 }
 
 /// A RAII guard for QEMU's logging infrastructure.  Creating the guard

-- 
2.47.2


