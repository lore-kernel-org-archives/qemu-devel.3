Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 502A7C36008
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 19:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twnAM-0004WB-5n; Mon, 24 Mar 2025 15:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twnA2-0004Hk-AK
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 15:08:36 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twn9z-0002mW-AY
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 15:08:34 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22409077c06so94717595ad.1
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 12:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742843310; x=1743448110; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3hxd9TjbuxbbcSjEYfZrsu0AQmn+kcJqOpgfKlf0s18=;
 b=ZnVHktgE8oMGJ1/qPHF1BnDx/LHEA60wGzOQHp6PRVWhzeHpLlks5/tSluTMv1yFHt
 qCmOTD4rvppjRnTt9FducCMVIheItMFnfXemprJuvMNk81x4Di6CPC8blALDwTfslmfv
 soalrnvVzvFR0nlyRNP8YzzAYm26kaxNTV1PBAO/h7KJy9sYQhCsIdIoq++o7baEH+q0
 EB+ABNaQHuuZH8XUwLo5X7gutLNfD2GxLvinRgC3j/rRjVZMlr8cic+zRruu2UHIGoMq
 vAAS0JNfQAFs6n6TKObIXz1igI0f/d+Phu4Yj+whX4Hb+XgStMVzCuPZIoGg+4SzF/qw
 cg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742843310; x=1743448110;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3hxd9TjbuxbbcSjEYfZrsu0AQmn+kcJqOpgfKlf0s18=;
 b=vTtFWn9/657d0Lo3ItWrZJjbSvH8P16cBqvAYlRHo7zf8qoYse6SqujZBuj2+IBXI7
 UI77L+TN4BEs+LJ1n4DNNt3A0WAfD9PSSE9LgRA/vznOfAGZWdD41nF9rZz4nZ4uCENx
 y3Go1Sazo12xgHWL5gdJ4xPJyA0pb6r8VQAzvDQb9Mjt8PdQId1rkwtfReNFfqYrPxvx
 NOyAKWp9RafZJMhiEkEwLe4pm38xfgvISwFLN9WfhLju+nsHwpSavoxyGUPbPBlkUjod
 J9EFRkjkqB7JIqT4e0RVctj7OSPJyPU3Y8ptMtZ7VM/E4TUKjpZRzjkJhyq23u8VsH8p
 Cdqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwksq24G1b5Cn+Sn/zu2x5LSAmls1hdbqOMSbYf+kKR2glNQMJ8OkMP5LXWz6AyKLvEO/98OPsPFaT@nongnu.org
X-Gm-Message-State: AOJu0YxojSNwA/vvQaXMP2C0QTruj7P2y0t9LNMIFQvkNlfHsVCjEBnl
 LITmz46YTE7qJeqaPVxXshsFgFF+0zBLs3dEDvkFneyfhwNbhwK8RBBUagYDTgg=
X-Gm-Gg: ASbGncsVPQBEulC6IlRSsQcm+iMG9U83lBz3DLK9S9LFRpVW1I0ymre03q1Uu4ZJmcm
 ckV/XjvL2Gzgjjbw0uhO9SO6QeTDIDliuRsvBSAFanwsznJK1Fw549yVo004NTNRukXATezag5C
 WEXcKQZfBICFwAxSHRylzIplLTRB2qDJpEXpRgH3NZXsfQHJrb6jUg5DbDAuv9xqoUZFclVGfZw
 h4QNEzWvkfNTExX6XQqq6LgZA/8zwVptTbshTunSmNLe75WmOXawkoaDQwuXmtWE60pUnJzYJKC
 oQJ6EwYN9dufdaX0e2MPYxp7IuqqFwdOmAXpLap3IY0JhPJn4pi2f9kLiA==
X-Google-Smtp-Source: AGHT+IEXNdbwNQppmYqzEzNovtbETxCADLuZzrBPE/gdXQXMi/p+ji+5wXCtxNdSyQQaivhkUEEM5Q==
X-Received: by 2002:a05:6a00:4fc7:b0:736:326a:bb3e with SMTP id
 d2e1a72fcca58-73905a13e8fmr21613771b3a.15.1742843309548; 
 Mon, 24 Mar 2025 12:08:29 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73905fab72asm8388431b3a.27.2025.03.24.12.08.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 12:08:29 -0700 (PDT)
Message-ID: <0e93f4d6-16ca-4462-a621-dcbc200685e7@linaro.org>
Date: Mon, 24 Mar 2025 12:08:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] include/exec: fix assert in size_memop
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>
References: <20250324102142.67022-1-alex.bennee@linaro.org>
 <20250324102142.67022-2-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250324102142.67022-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

T24gMy8yNC8yNSAwMzoyMSwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBXZSBjYW4gaGFuZGxl
IGxhcmdlciBzaXplZCBtZW1vcHMgbm93LCBleHBhbmQgdGhlIHJhbmdlIG9mIHRoZSBhc3Nl
cnQuDQo+IA0KPiBGaXhlczogNGI0NzNlMGM2MCAodGNnOiBFeHBhbmQgTU9fU0laRSB0byAz
IGJpdHMpDQo+IFNpZ25lZC1vZmYtYnk6IEFsZXggQmVubsOpZSA8YWxleC5iZW5uZWVAbGlu
YXJvLm9yZz4NCj4gDQo+IC0tLQ0KPiB2Mg0KPiAgICAtIGluc3RlYWQgb2YgMTI4IHVzZSAx
IDw8IE1PX1NJWkUgZm9yIGZ1dHVyZSBwcm9vZmluZw0KPiAtLS0NCj4gICBpbmNsdWRlL2V4
ZWMvbWVtb3AuaCB8IDQgKystLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9leGVjL21l
bW9wLmggYi9pbmNsdWRlL2V4ZWMvbWVtb3AuaA0KPiBpbmRleCA0MDdhNDdkODJjLi42YWZl
NTBhN2QwIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2V4ZWMvbWVtb3AuaA0KPiArKysgYi9p
bmNsdWRlL2V4ZWMvbWVtb3AuaA0KPiBAQCAtMTYyLDggKzE2Miw4IEBAIHN0YXRpYyBpbmxp
bmUgdW5zaWduZWQgbWVtb3Bfc2l6ZShNZW1PcCBvcCkNCj4gICBzdGF0aWMgaW5saW5lIE1l
bU9wIHNpemVfbWVtb3AodW5zaWduZWQgc2l6ZSkNCj4gICB7DQo+ICAgI2lmZGVmIENPTkZJ
R19ERUJVR19UQ0cNCj4gLSAgICAvKiBQb3dlciBvZiAyIHVwIHRvIDguICAqLw0KPiAtICAg
IGFzc2VydCgoc2l6ZSAmIChzaXplIC0gMSkpID09IDAgJiYgc2l6ZSA+PSAxICYmIHNpemUg
PD0gOCk7DQo+ICsgICAgLyogUG93ZXIgb2YgMiB1cCB0byAxMjguICAqLw0KPiArICAgIGFz
c2VydCgoc2l6ZSAmIChzaXplIC0gMSkpID09IDAgJiYgc2l6ZSA+PSAxICYmIHNpemUgPD0g
KDEgPDwgTU9fU0laRSkpOw0KPiAgICNlbmRpZg0KPiAgICAgICByZXR1cm4gKE1lbU9wKWN0
ejMyKHNpemUpOw0KPiAgIH0NCg0KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBp
ZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCg0K

