Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA94FC87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 15:17:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiww2-0003vB-IX; Mon, 04 Aug 2025 11:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uivXO-0005fE-MS
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 09:47:39 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uivXM-0002YW-BN
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 09:47:38 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-61571192c3aso4213420a12.2
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 06:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754315254; x=1754920054; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hEvV4qFqWB9cTuaBcclspfI/a8mVi5g2F2fZs6PHmRM=;
 b=hrlDy2b3moG2wV+Bo/09h9QcfwprdxaBwxW8qcICA09S8X4xO9X+AalFFATV+cBtOB
 8JfzhwJAUMtTfNHexDkj5jwB88RXcU5XfRuI8OQ7AyNdSIJL9UUDGMtYZpZFGBCLFHpf
 e6CaWvyjiXe+AB+4alZxzdINwfSVNXqLIQK/Eax+DWEed3KAezYWIYy4LrZ7mta8xskF
 QboPB+esvmPZElLce6hnDQv6uXW55DQhLS3cJuCJOzrErtfKsNGM6UYX5iXMIJGIWBOS
 SXg58aWy4K6a32l5/FrA6WnM6yl4ndW4XU/VXLPcoefCutIEGO51nJQ1ZMmb1v3nu+9n
 uqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754315254; x=1754920054;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hEvV4qFqWB9cTuaBcclspfI/a8mVi5g2F2fZs6PHmRM=;
 b=Z9onuYwsEbwEEs9YmNhAnKJ5ew3c28Kw0MonatuxOee6el/Kmo93te9FXOPL2curg8
 ULbagNfCOoi1/WVwMgdG1D227PEpq64GY99fAES0waC9iS8Wyh9Jv3n+4+VmsS530pXG
 IWekqkcCVJ6ywSLfEAnk051/eNyENZ1CNEimxr4eRUz2WE00mlDk40TCCny26NxZC076
 BIO84uHFBGPdcybfGnK22H196KjTPPkLy0ACRwUL/JVG1u8QmK7dZ3WilDMj66Y4Zi+1
 RbIDBOumQrtzP9tqg1QImjAbt1arQYsxVQkpLMyIgC/R9RMfItpfZGO4tmEQmuznl84Z
 Jl+A==
X-Gm-Message-State: AOJu0Yyg44bk/8tlqWwFGax4sibukEUd+x2X3BLsCEIaWC18BSm9U7gs
 32cXxcL0EyRePqgFh2GxRlX3hPRpq4Mj5UrAI9ohfeJwsyGF85hgtCx/w7M3Ae4kFuc=
X-Gm-Gg: ASbGncvZjaDMeYRbFbgq1/ODtLHQhvGI1pdg+fk382womWBlc4q/3C/jH31euUmEOjX
 n9Ql5bVPGUCkFzkmITk4z4siy8H5JexLhTf/GSoC1qBw6j7aB1UNg+HlgSToL9KYy7T1DkZEB63
 EHySX9+EfkwOYjY6CSJmDsdglzMy7s5GRrdzlFiOiTb2SX5q0uUafdcgUQgYlZAzz8y/ICMFZ4s
 H+LS5n1DNdVnwRyPi0IIx40i772P1UYh5yqr2jD+3U9SpIKDreSMv8y4bgTa05FnEtCZ0vZlBai
 L/VkMuCcJb+ELLn9NVSqhp67iAsV5OiTmzk2cBv/CPhyw86n1CO5i4FBPWomiwxr1A7ibXkCpDB
 K/eaAQpg7k5HngMeQcp6oyxnYTcbcQUl95mHI6mzvk6BYVNns3KGrryN9Tzf5KVwOvpM=
X-Google-Smtp-Source: AGHT+IFAlqNGj+0nkPhQ+9IT3H+LbzRMYlhKz0ws80qY5loS3glrxXNT+jp2M/5wAQAouxqQmz9vaQ==
X-Received: by 2002:a05:6402:354f:b0:607:28c9:c3c9 with SMTP id
 4fb4d7f45d1cf-615e6ebc8bemr9194835a12.6.1754315254472; 
 Mon, 04 Aug 2025 06:47:34 -0700 (PDT)
Received: from [127.0.1.1] (athedsl-4441708.home.otenet.gr. [79.129.182.92])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-615a8f15d9fsm6850590a12.17.2025.08.04.06.47.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 06:47:34 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 04 Aug 2025 16:47:14 +0300
Subject: [PATCH RFC 1/5] rust/bindings: add trace headers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-rust_trace-v1-1-b20cc16b0c51@linaro.org>
References: <20250804-rust_trace-v1-0-b20cc16b0c51@linaro.org>
In-Reply-To: <20250804-rust_trace-v1-0-b20cc16b0c51@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 alex.bennee@linaro.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1100;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=oF/2Jbbj/kJRLShPsty+hf1YAhHddpc/rIM+iPuPKJc=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9rTG56dU1TRFV6Y3RSOHpLK2RqcVF5YnhGRFpXCjZ5MkZ4eHRpNXhBd1JlWTNk
 Wm1KQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUpDNTh3QUt
 DUkIzS2Nkd2YzNEowSkswRC80OFJCNUhRQ1Y0WEp5MFVmSEJZV3NjTFRqeWZZS0xtZFJ0WGxOSg
 p2OGdRay91c3VWendFVzBGNnVWUGRzY3MrOHdDYnRKRi9nMWt5SW9vbWlaRG9LWDdqNkFVMmZxK
 25yRGJiUGt5Cm41S045RlVoVnN4V05Sd09BZTY2cEJiRTFRMzRWQUFNNWtpQUMva09kaFFyNFBu
 UVpyMEtFbWNuUVVybENxUEMKTnRhbU1zQTEzUFJmR2QwYURVNHFEaC9nQWlKL0M4NTV0TmU0WXU
 5SittWWZmNS9TdVdDRWNGNi81SW9CV0g4WQpIN1ZsY3hVR3FPbzB2RXc2VmZ0bWxDVkx6RzFwZn
 hyWFQxMGRSQ3hsS2lxeCtqYlpqWFhiWFEvTkZvVWVXZFNtClNVVHZtOWErMGZPYzhVN2k1c1JWM
 mlnUUp3MHp3eDNRZVNLczdZWkhTVFJ6OWo3V1dGUEVvK20rQmVBODhYN0QKbnVvc0xSRkkrNjZI
 SENGQWUyeWJyVGFhKzNLakhSYWFQNU9FcE1pcFBrakhLUXJZK0YxUTFIN2phVHF2VGtDRQp2bU5
 RU1ZDcVV4WUxtTEQ1cDBxR3VZTkFyOEFVRkZJMU9VMlJhemMxdndUck9wZVVZN3hKWHllRUF5Mj
 N0V2M1CkdTNjA3ejk5OE5YWWE5UWR1blVjRzF1QjYvOTE4RzdNTlloWnV4dm5BaVBjeUl2cjRYU
 28wRlVldlhnOGt5OEkKMWdWeVlhbVZ1aFBKa29lazZoYVZWMlorcUVKTkRtUjI2Ui81VTNkWjhq
 dUxieHIyL1BZSmwwNytrNkpleHZqeAo5N05ydTM3ZDBjd1E5M3hUY3VWaDFTV0Y0NlZFQkZZaXB
 lMnBLekpkQTkrV0JGV1VEdkZXWFRodkhEMHZCR1BaCjlENWx5UT09Cj14dmViCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x532.google.com
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
 rust/qemu-api/src/bindings.rs | 3 +++
 rust/qemu-api/wrapper.h       | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.rs
index b8104dea8bea4348987978d5041cfc58e4d15a8f..d863b8bd7ecd449b5fe5c6f1be3bd7b4251b2883 100644
--- a/rust/qemu-api/src/bindings.rs
+++ b/rust/qemu-api/src/bindings.rs
@@ -56,3 +56,6 @@ unsafe impl Sync for VMStateField {}
 
 unsafe impl Send for VMStateInfo {}
 unsafe impl Sync for VMStateInfo {}
+
+unsafe impl Send for TraceEvent {}
+unsafe impl Sync for TraceEvent {}
diff --git a/rust/qemu-api/wrapper.h b/rust/qemu-api/wrapper.h
index 15a1b19847f2f2ab1a1a856621abb64f757070ea..540ef5eeac840deadd2e9a6f0dcd154f8dc1487a 100644
--- a/rust/qemu-api/wrapper.h
+++ b/rust/qemu-api/wrapper.h
@@ -69,3 +69,5 @@ typedef enum memory_order {
 #include "qemu/timer.h"
 #include "system/address-spaces.h"
 #include "hw/char/pl011.h"
+#include "trace/event-internal.h"
+#include "trace/control-internal.h"

-- 
2.47.2


