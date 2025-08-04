Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C3CC87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 15:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiww8-0004cB-DM; Mon, 04 Aug 2025 11:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uivXR-0005nd-JK
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 09:47:41 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uivXP-0002Zi-QF
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 09:47:41 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-af93c3bac8fso421820866b.2
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 06:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754315258; x=1754920058; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Wbu96umnDhrqnXsA31ZGGYO94kVucZ/SNX5BmpI69LY=;
 b=Kq383Ha8qfbAnYYymHd2rrcFALceZU+VIzIcKBWC+9oy0gh8/pN3azIUyM3NTwsVOK
 DRYE/M6yUzLqzuwBscTSz7f4WLQBcTiJnfvpXILHYmFbirE/EKLcV8EfefPld+emm8IX
 nVl0V6M10bCQlumi1jRP01ix6p02bcGv6kf16nt0VJnZEWG1GsPwaArHb9DGw6pqmGPO
 DRdIm/wSJknq2a0tYQWSzvxaDY9JOCjpAjQ8Jfd5G11gKanmzYyXqhfiDtFI0loBZeMf
 hnRDhK9AakxpqPm9O0Hmz1GImnm/oVVxNLR/kCZdSN1eufy3pSxBecG/bNO8FBXGGo0P
 znQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754315258; x=1754920058;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wbu96umnDhrqnXsA31ZGGYO94kVucZ/SNX5BmpI69LY=;
 b=AdwLDGtqC7Z2U6mW90YOn1Ch5bi5mIb9NXyKLUMD21I3QWqW5nliaSCVJYZPR0QD6A
 9nIu92d/YtMy41l5Pw1p8hyx1IZSSv5jeKbE8Z6auNTcsa3uMV7NtDBmKGVq6c2Jvwsc
 2qu3BG70wlHE4u3esUU3HSX7RdmsRUDWHaK7hfYtOnyAktak0IamOVEzj8/SNOgZ/Fiv
 PQTQvXM7C2BkL6ktUWHvF/Qfuv9DM0L6o1OMEo3lNReEKYOZ9fGeExc5CmPtyppnoRi5
 IXEwWkSVgUQplT+iD+FI6oR2DVCfcuI2rgFR/O9r1wqP2lOGdJTCRpqnJAV5MsYeMcaj
 baVA==
X-Gm-Message-State: AOJu0YxOF55quJg6HElgOTF5FAvGDvnJ/m1+CPZFs/o+gsw9wHcAXh22
 M1Fv9lGOUWPFzrrNwA1dTN/4a9+aicVmjKN0btMNjHdgOu/ECAdIjaM7wHMTup1dq40=
X-Gm-Gg: ASbGncubpd9zTzHfBdpv+13Kmo2xbrMMsHs1f/5+qyQJMqTspzzxemiNWCr99jBR+tP
 UTfRVvNTmntZrj4FZo9PEK8t6a9+RxAU/89TlvAabA3x9hSwehAV1rsh7wCo5OwOyaB4pldFDf/
 NBDh2mYG4xigZsluKfzNwfwb7ZfHUhQAjFYULGsUcawjdJBK/meYN4WL1y4VpOImtB7nNw7r3TP
 gpuTEyxeRk1MWXyZPJ7r+qsh4GAHVRXN9R6BGs4oiObbft5yM2UVde6GB7zQHE0P19Xkwc9IxxO
 titjaBYpklBFaTPiWDyUvbXM43isPm99yzVGR/Di1aAhsEaGqzxZNNSfgQUodcN5iZWwuPU76bU
 dnw1L1WgpIWsxYaomSnFFgGs61+UiJ0K5gccyWjabhvzXhl5To4/HwV4a8xOKNltYGDQ4DKAEeu
 heQA==
X-Google-Smtp-Source: AGHT+IGeok3AT9EM5+EyEyOC1yWlkSGisfJyqDb8TV7it5uIabJl3zpJ1FNVKBjSCLqIyEWa8p6aug==
X-Received: by 2002:a17:907:d86:b0:aec:f8bb:abeb with SMTP id
 a640c23a62f3a-af9401c3223mr940541166b.42.1754315257893; 
 Mon, 04 Aug 2025 06:47:37 -0700 (PDT)
Received: from [127.0.1.1] (athedsl-4441708.home.otenet.gr. [79.129.182.92])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-615a8f15d9fsm6850590a12.17.2025.08.04.06.47.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 06:47:37 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 04 Aug 2025 16:47:17 +0300
Subject: [PATCH RFC 4/5] rust/pl011: impl Copy, Clone for RegisterOffset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-rust_trace-v1-4-b20cc16b0c51@linaro.org>
References: <20250804-rust_trace-v1-0-b20cc16b0c51@linaro.org>
In-Reply-To: <20250804-rust_trace-v1-0-b20cc16b0c51@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 alex.bennee@linaro.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=744;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=Om9Apvwjl3yaG2PEd/tsN7AFucqCNXgbE+oPqw1/2PM=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9rTG4wdmI5R2VIb1FQZmpUdWRiWHBlSkxnd2lqCktlQUVUNnR5aHRXOEVXdXFC
 MTJKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUpDNTlBQUt
 DUkIzS2Nkd2YzNEowR2tURC85c08yY2hEN3AwS2dCaGgzTUtWY09mU3lXRjAwWXMyL1ZHazZVTA
 o0aWdWblVCNTAzQ05FL0oyaTNCbDBMNmdJbjVnbEtva05LczBWem9waEhBKzRrRkRsSkpNc0ZRZ
 2pEVDIyRVFjClpFU3Rsd2IrYUxsV0hXczdzMW1vcStHOFNOUnBNRHc2SzRzcW9GTXZ6bXVyc3Nv
 Q25EVkNiRlRwZkJoNUh1aVMKMFcwR0Jwb09hdjV2SnlaaEVBdFpmZ0V2R3FrenhiNHF2bENqUDd
 tcUYvMURkSzNGZExUbkRkc0R6a3I5eG9sZwpLOG1oWWJ3T004SkRKZ1JtVEZTZGNPbzBsL01CVW
 Jla0dVUWQ5cFBZQ3UxUWhINFlHbFlTUVpIcmYwTzBnTVpUCmo3SlVsMkRlUlVQZUtpd084aklwQ
 VdsODlJbHEwaVNrc0VsVmQvY3BhZE5CcGJ4eEllbmFvNmw4UFZvdEhHTjQKbkNwa2V1eXlVM0w5
 RHdhTUNkVUcxMElwQkJ6Vzh1LzJhU3J1WnJ5VXZNUWpnT0o5RFR0dzByOE92ZWltaUlNcApZdWd
 kZFNxSXFiRW9aN2tXOGdJWDZQVHpjSENMSzZsM3hkaUJLWXZVRGY5LzNPSzVad3NrT1ZzeDVVcU
 V5dUJmCjZiVksydHQxdU5Ea041amFWVm92bU1vUExyTm10MExHREM1ajI3aUlLYS9sN21VcEtKZ
 WFoeTJaRUtpL0pycFkKYm9Jdm1rNFZEczBJMWJINTBtV0VHNGE3TXpOMnlMOVN0OGUzaEJrWmZj
 bDhZOEkxSkJNVlRiblYrYXZKWkk2dwo5elZTYzM5cFJjY0ZJTC9CS2V0UWZ1YVVBUkVPQjEvQ0p
 JUVQvTFBBMTRPVnhIOEpLbE1UMEZzZXpxWk01MnJLCnZNUFNDdz09Cj1OQWlKCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 rust/hw/char/pl011/src/registers.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/hw/char/pl011/src/registers.rs b/rust/hw/char/pl011/src/registers.rs
index 7ececd39f8616e0b1dee999bbe31dc5dc70e209e..3201932daf8f4a71d95374073c4c259698dec2bb 100644
--- a/rust/hw/char/pl011/src/registers.rs
+++ b/rust/hw/char/pl011/src/registers.rs
@@ -16,7 +16,7 @@
 #[doc(alias = "offset")]
 #[allow(non_camel_case_types)]
 #[repr(u64)]
-#[derive(Debug, Eq, PartialEq, qemu_api_macros::TryInto)]
+#[derive(Copy, Clone, Debug, Eq, PartialEq, qemu_api_macros::TryInto)]
 pub enum RegisterOffset {
     /// Data Register
     ///

-- 
2.47.2


