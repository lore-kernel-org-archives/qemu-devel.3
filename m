Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA70C28B28
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 02:11:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trSbY-0000hd-6J; Sun, 09 Mar 2025 22:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trSbI-0000gO-5y
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 22:10:43 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trSbG-0006Z7-Fu
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 22:10:39 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-224341bbc1dso33730795ad.3
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 19:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741572637; x=1742177437; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wf1m1/zuuUt9Sa/sWao+aE4RHawG8odqXAwi31KcpoI=;
 b=f3IAk8t/DqVH7iQ9ikjSDoHdKTxrq+X4/1x8GOLHGJif0TNoQH+GySotlbn7h5Cp7O
 sRip0j7ZYJhAzOaS5WsZ5R/Sqkl299VkDCv2NbUZtVkXDL2+kjPn8H8j248+/YD0jt6B
 dZfJNRKAYycYZpe68kwaeSo9DnjvjzjpebJzqS7XEEGUnD566exfK68doj7dJjIGp9PT
 or0Y0/9yS9kc504PkiwMtGoN72VU7ZFkBIey+gCKCX4qV8tn7Sto8IHZlOuncprlFwGa
 T7QtMLCgOs4chLARcq/9/5wJfMPRxHR86m/iBmSr7uBA6WU4p24Xb6gl0liGQeTxhOGo
 nUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741572637; x=1742177437;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wf1m1/zuuUt9Sa/sWao+aE4RHawG8odqXAwi31KcpoI=;
 b=fvOy51aLPNt0NqZ1aZL8SrdxInSaJCgPPFzZtcMM5MrGSRHIqTaz0og/fDMidsjTk5
 rltBfz3f9cGkYJX/rWF0fAqJsCrfUvSDknXUdSlEv6m7rmbgHYPt8iu8h1EfK/ODAmFo
 0VdLNn13SLTenE15zhKrNhqdotwG6VHR4qtyATEWcieE5YVOFIdTI0E3kTXcJxm/LOJy
 EahZvnYbtaQ7B4BxNmbf7qihhLJTTlAS0Im52LEi91CMPEUYaTaP7fJYSsOW1MPPxAnP
 HWfmXirfcYoBEMRQNhvbiZtkFeuhERFApaM4dxv9/gyLhtuAj9ZlXns144E4NzBAzJW7
 69mQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUByYv0jo59KqOtNmMqSIyTFgyjCCUaJDgX6VyiOfdMR4Nm0JeAOiZTbdTtN+PbZ48CKCwyn3whKDnA@nongnu.org
X-Gm-Message-State: AOJu0YwfFl7lbYYW5K5ghh4Fg/5uARi3/bIJObaz/G6EWv71bdU1MwM9
 3+f30+kZWPJA6Fu0tBansdr0+HueKNcHWAsROWX6h8U/CBwFKWmI+B+c7hqgfy0=
X-Gm-Gg: ASbGncsJD1InzEG3DCYkm1YQ/+j06BGzm1UsG7TX/RRYa67+W/OT3iUxCgv+nxEhLsc
 6bpmUSqze8k9s+Bo7pZSjJuFEJZJptfvSkCgrOR1YGWlAt8ZRand1LqFnNUwB2SwwO0hneo9Vbl
 dr6AypRJvCRCZRF1jL/GrYIj8DJ9SHdV+4QsQCmuzzF52BXAW4zF9pqfwfjtNZCE5f+I5Nc8Wbu
 g27MulOpF0Usj2BlErlCGDPpEFTqA1ERSTju4m2guo/dRXbXZIcF+5CrEqzn4jMpeC7OUlb2epL
 EM5WICEc2r/d0D0ENC/G5Yj6ohXgyN7BCk3JPulTTi6BELNKm2B+PTzbKA==
X-Google-Smtp-Source: AGHT+IG5824u/Paw5A4ROCYDa6rpBTdV46omB9ADq9EuByBKeioJgUejdzkOM2/mOEgR3EARM7VYmA==
X-Received: by 2002:a05:6a00:1956:b0:736:4c93:1bdf with SMTP id
 d2e1a72fcca58-736aaac7777mr18584825b3a.18.1741572636966; 
 Sun, 09 Mar 2025 19:10:36 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736d8f0ea83sm915535b3a.143.2025.03.09.19.10.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Mar 2025 19:10:36 -0700 (PDT)
Message-ID: <5bbbc0ce-5a83-4574-bca6-a2c9ea87a4e2@linaro.org>
Date: Sun, 9 Mar 2025 19:10:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] hw/hyperv: remove duplication compilation units
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 alex.bennee@linaro.org, qemu-devel@nongnu.org,
 Marcelo Tosatti <mtosatti@redhat.com>, richard.henderson@linaro.org,
 manos.pitsidianakis@linaro.org
References: <20250307215623.524987-1-pierrick.bouvier@linaro.org>
 <8c511d16-05d6-4852-86fc-a3be993557c7@linaro.org>
 <8d2a19a8-e0a4-4050-8ba5-9baa9b47782f@maciej.szmigiero.name>
 <91ddf98c-3a5d-404b-9e80-ed4580c1c373@linaro.org>
 <440fe370-a0d3-4a32-97e2-e5f219f79933@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <440fe370-a0d3-4a32-97e2-e5f219f79933@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

T24gMy85LzI1IDE3OjE0LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gT24g
MTAvMy8yNSAwMDozMywgUGllcnJpY2sgQm91dmllciB3cm90ZToNCj4+IEhpIE1hY2llaiwN
Cj4+DQo+PiBPbiAzLzcvMjUgMTQ6MzEsIE1hY2llaiBTLiBTem1pZ2llcm8gd3JvdGU6DQo+
Pj4gSGkgUGhpbGlwcGUsDQo+Pj4NCj4+PiBPbiA3LjAzLjIwMjUgMjM6MjUsIFBoaWxpcHBl
IE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPj4+PiBIaSBNYWNpZWosDQo+Pj4+DQo+Pj4+IE9u
IDcvMy8yNSAyMjo1NiwgUGllcnJpY2sgQm91dmllciB3cm90ZToNCj4+Pj4+IFdvcmsgdG93
YXJkcyBoYXZpbmcgYSBzaW5nbGUgYmluYXJ5LCBieSByZW1vdmluZyBkdXBsaWNhdGVkIG9i
amVjdA0KPj4+Pj4gZmlsZXMuDQo+Pj4+DQo+Pj4+PiBQaWVycmljayBCb3V2aWVyICg3KToN
Cj4+Pj4+ICDCoMKgwqAgaHcvaHlwZXJ2L2h2LWJhbGxvb24tc3R1YjogY29tbW9uIGNvbXBp
bGF0aW9uIHVuaXQNCj4+Pj4+ICDCoMKgwqAgaHcvaHlwZXJ2L2h5cGVydi5oOiBoZWFkZXIg
Y2xlYW51cA0KPj4+Pj4gIMKgwqDCoCBody9oeXBlcnYvdm1idXM6IGNvbW1vbiBjb21waWxh
dGlvbiB1bml0DQo+Pj4+PiAgwqDCoMKgIGh3L2h5cGVydi9oeXBlcnYtcHJvdG86IG1vdmUg
U1lOREJHIGRlZmluaXRpb24gZnJvbSB0YXJnZXQvaTM4Ng0KPj4+Pj4gIMKgwqDCoCBody9o
eXBlcnYvc3luZGJnOiBjb21tb24gY29tcGlsYXRpb24gdW5pdA0KPj4+Pj4gIMKgwqDCoCBo
dy9oeXBlcnYvYmFsbG9vbjogY29tbW9uIGJhbGxvb24gY29tcGlsYXRpb24gdW5pdHMNCj4+
Pj4+ICDCoMKgwqAgaHcvaHlwZXJ2L2h5cGVydl90ZXN0ZGV2OiBjb21tb24gY29tcGlsYXRp
b24gdW5pdA0KPj4+Pg0KPj4+PiBJZiB5b3UgYXJlIGhhcHB5IHdpdGggdGhpcyBzZXJpZXMg
YW5kIHByb3ZpZGUgeW91ciBBY2stYnkgdGFnLA0KPj4+PiBJIGNhbiB0YWtlIGl0IGluIG15
IG5leHQgaHctbWlzYyBwdWxsIHJlcXVlc3QgaWYgdGhhdCBoZWxwcy4NCj4+Pg0KPj4+IFRo
ZXJlJ3Mgbm90aGluZyBvYnZpb3VzbHkgd3JvbmcgaW4gdGhlIHBhdGNoIHNldCwNCj4+PiBi
dXQgaWYgd2UgY2FuIGRlZmVyIHRoaXMgdG8gTW9uZGF5IHRoZW4gSSBjb3VsZCBkbw0KPj4+
IGEgcnVudGltZSBjaGVjayB3aXRoIGEgV2luZG93cyBWTSB0b28uDQo+Pj4NCj4+DQo+PiB0
aGlzIHNlcmllcyBuZWVkcyBzb21lIGZpeHVwIGFmdGVyIHRoZSBtZXJnZSBvZiA1OGQwMDUz
OiBpbmNsdWRlL2V4ZWM6DQo+PiBNb3ZlIFRBUkdFVF9QQUdFX3tTSVpFLE1BU0ssQklUU30g
dG8gdGFyZ2V0X3BhZ2UuaC4NCj4+DQo+PiBJJ2xsIHJlLXNwaW4gaXQgbGF0ZXIsIHNvIGRv
bid0IHdhc3RlIHlvdXIgdGltZSB0cnlpbmcgaXQuDQo+IA0KPiAxLCAyICYgNCBhcmUgbm90
IGFmZmVjdGVkLiBVbnRpbCBzb21lb25lIG9iamVjdCwgSSBwbGFuIHRvIGluY2x1ZGUgdGhl
bQ0KPiBpbiBteSBuZXh0IGh3LW1pc2MgcHVsbCByZXF1ZXN0IG9uIFR1ZXNkYXkuDQoNClRo
YW5rcyBQaGlsbGlwZS4NCg==

