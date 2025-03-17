Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD74C35FF3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 16:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuDG0-0001IB-AF; Mon, 17 Mar 2025 12:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuDFV-000189-Et
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:23:38 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuDFT-0005S4-EG
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:23:33 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2243803b776so43995295ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 09:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742228610; x=1742833410; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sKr9XFjs1j3JnKD94M/Tx7jfbE8ZM92q5J988gfEeRo=;
 b=MM/XFxRMLV0EMskT8qN7ErcNb3FsEhByPruJsJmk+kvR9kiDLmTw2VtgworbAW8/6K
 BYK2p0+mnNZYgYGUzGrVddP4jzEIaRUdOXB5iYbhVL7SgaNdGe0lYCrVN2l89oBXqtra
 vYZMYpi425+0Qt201ZsAEbK/u9k1oOn69n0ymNaT2qjQru6Nm5nTKY0pt94GPbhvKgM9
 52sTyQRGtpERh80nCTwL3zDLpfsclDXs93z1pu/9KYt6ixvYJMVJjGeFJgvbu7D2fFKb
 MjmcTUpFEabdZEbxIWjUAIv42vR1TglX9WrAy9qoSRuPnNvPauejyKTeP6NgI7ufzNcZ
 gZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742228610; x=1742833410;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sKr9XFjs1j3JnKD94M/Tx7jfbE8ZM92q5J988gfEeRo=;
 b=n1w9neeZf3SRy8NwejqKaEz9346lf8QWf2tGSilrui8rFGhZxMR21E8hv+vskv00pV
 O1vMKZEu2gtNcXcaCOAjQkTMZh6xROtwFiaOJyIYkr6rOiNoFnagvNX1HiN+L1bVMCEc
 YacoXOOGCiMBnUmPZtQOQtTDujq7/iT5mbJdXwaxDBty3K6afeI4wKoj547ywaGYkVNK
 PzBHNTkssPxzc4aoes05mR/J4j1YqOqjMF2bTPpwI9Ib32n9dp+7trGnLu0L54Hfba5c
 3+IgmnWFvjdLx9x8n9Cj2NYdAUet5ldZCYWwYhd73M2b5oN251wN8ja++c57qEaMlkp6
 7skw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGIJVo/7BuEF/cJ7bAd/OTGPp4Jrbk3d3rVSXkhRTnUTYYCyEsdzr/OxEcB8N2ZdpKRnnGL14Zja+U@nongnu.org
X-Gm-Message-State: AOJu0YyeVZQL0nfZPh3KG1ElnYsdSD6/sFvRIFzBVluHO1K78tMhf/ty
 hDIhfO1FIrwKVYbsGZi3EBEXmDMdy1peG+fhoJIOpMn1rnIsiUmH7g5ntLdmMKc=
X-Gm-Gg: ASbGncvfhe63IvavWez9BLwCORRWXzowJo01oIkaVCcHxRkkS1YcwT6JUPjLyImoYuU
 d58IMY2dFPPsEE/9t+e4iHSL79qnqB6kv97kC2UZhMQoTxazF1OY5/I41yuVML4qOyFXRej179M
 6Ic5SbjcQrHrThQSO4swjtuyZufO5e6F0a3A2y4JgBrgSI1nQol4cQrOMNN6sz6nSJ69bD/S7TH
 rAFj+MNLsVT/JVAzcanMGO0ujNo1v1HIHw2KEtFz2a4uBa55Z+rs7nnyG5hRqMFIFplE6E4dV2W
 yUJnkK3k0AGkcMmR6L8263bmGUCmzkz5HTtNSofcwFlatQODIRqVDqkuaw==
X-Google-Smtp-Source: AGHT+IFd/uM2Eyyw0DFIFajF5XSuMgsstPxtiNmVOwXtH2dVJtkbhwy1LysXbxTDj14C7HBghjQBCA==
X-Received: by 2002:a17:902:dace:b0:223:635d:3e38 with SMTP id
 d9443c01a7336-2262c536a0fmr1800175ad.15.1742228609750; 
 Mon, 17 Mar 2025 09:23:29 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6ba6c6bsm77093925ad.150.2025.03.17.09.23.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 09:23:29 -0700 (PDT)
Message-ID: <76dbdfb0-01dd-4b31-abf7-060dd05f507a@linaro.org>
Date: Mon, 17 Mar 2025 09:23:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] accel/tcg: Remove unnecesary inclusion of
 memory-internal.h in cputlb.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250317161329.40300-1-philmd@linaro.org>
 <20250317161329.40300-2-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <20250317161329.40300-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

T24gMy8xNy8yNSAwOToxMywgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IEF0
IHNvbWUgcG9pbnQgY3B1dGxiLmMgc3RvcHBlZCBkZXBlbmRpbmcgb24gdGhlDQo+ICJleGVj
L21lbW9yeS1pbnRlcm5hbC5oIiBoZWFkZXIuIENsZWFuIHRoYXQgbm93Lg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3Jn
Pg0KPiAtLS0NCj4gICBhY2NlbC90Y2cvY3B1dGxiLmMgfCAxIC0NCj4gICAxIGZpbGUgY2hh
bmdlZCwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FjY2VsL3RjZy9jcHV0
bGIuYyBiL2FjY2VsL3RjZy9jcHV0bGIuYw0KPiBpbmRleCBmYjIyMDQ4ODc2ZS4uNTAwN2Jk
YmNkNzUgMTAwNjQ0DQo+IC0tLSBhL2FjY2VsL3RjZy9jcHV0bGIuYw0KPiArKysgYi9hY2Nl
bC90Y2cvY3B1dGxiLmMNCj4gQEAgLTI2LDcgKzI2LDYgQEANCj4gICAjaW5jbHVkZSAiZXhl
Yy9jcHVfbGRzdC5oIg0KPiAgICNpbmNsdWRlICJleGVjL2NwdXRsYi5oIg0KPiAgICNpbmNs
dWRlICJleGVjL3RiLWZsdXNoLmgiDQo+IC0jaW5jbHVkZSAiZXhlYy9tZW1vcnktaW50ZXJu
YWwuaCINCj4gICAjaW5jbHVkZSAiZXhlYy9yYW1fYWRkci5oIg0KPiAgICNpbmNsdWRlICJl
eGVjL21tdS1hY2Nlc3MtdHlwZS5oIg0KPiAgICNpbmNsdWRlICJleGVjL3RsYi1jb21tb24u
aCINCg0KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJA
bGluYXJvLm9yZz4NCg0K

