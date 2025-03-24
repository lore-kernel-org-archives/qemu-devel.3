Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724A4C36005
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 21:40:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twpWD-0003zB-P1; Mon, 24 Mar 2025 17:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twpWC-0003z3-B6
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 17:39:36 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twpWA-000744-9J
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 17:39:36 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso80812075ad.1
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 14:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742852370; x=1743457170; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xpFk3+xFGifOlApECbh08psA2Fh6Yltkthx2WwGXEu8=;
 b=rUcy+AOwhQ2zbLXLuuEGGzOYhlz5ar8zmlJ7LlQPkcTwWbmeFwqc0xV+Nl7csCNuRx
 atqtrIRopp8lEA9MBdC1OwNJD+v8zQMH3Gje/eUmxiPtUeMpQq5hrWtcJ43YKQ7SrMNY
 0O+rzvSuTNoZgBOD4JzqdCkQZtxTDr4hYvbF1RPEzNWfLgl5Y47GIgNgBvOgyzOy0Hvl
 /wG55dla0urdzk5T5/txXueNosgBlQu0SffERj6yIZ+Eo3mI90/dWrctXgwbNPUkrcbD
 s1Jks4jjBvcae8DXgwLkRs2xWDAyhYcCXsXfBm1FRCgkmhuH7rjoFbLYZCCCZL8pLTZ2
 VYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742852370; x=1743457170;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xpFk3+xFGifOlApECbh08psA2Fh6Yltkthx2WwGXEu8=;
 b=e+v5YZpSpTgIUui+CN+gTxVh5+Q+ArDsPjpEpRQ6oyJRX9vjmUj0klpi1zOwtc3UOe
 QWbbkECoDT0Zm2+SP1lgsyYFYZDX0nL/Tk9KSqeg5mdaIJRM26yLa1TKieTOotMcc8eb
 4WP+4n7KNBfXdZHGb/QF+y/8Ge/X8JAO+cM/xmh5NffQtejAexPVOcxYTXv+hUEGfg8K
 QqMXD59SREn5vel7VqYXWDKgf9BVH3s2ChdMJy+B9ZJ4dsuI1WsBMJGgZgpr7tvWQQV9
 Ad7IDEQyJ4HYXhlNGy2mGLMMdW5swy7sl/VKjMhzbP4SxorPt288CvCzvaeu5pHdGQ77
 phpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1DZhD0fQo0pg372GHYWhvATPropAhuYDBBw5qT/b1k9yWTDUprPUhAIVCAYEHvCq+VCa5/Y6fHfmu@nongnu.org
X-Gm-Message-State: AOJu0YxvokSkzW/6q+Crwcu/X5QG5PD4LoYNbANX/79v/4iP19UbaGpJ
 h/b/HMlKjvfDcrlVKnvdbPU5etNhl7igJMb/MMP78E07eerw5WVlhLk8TaAOyOs=
X-Gm-Gg: ASbGncuFsuGHTXoXE4VLWCJCG+fFMn1NL+GdeWzIzzpWUxm7gu52djzhIWsnxySQJC4
 97aV5RVmmZgZgJm+mK4QPxRMgTebVg3n645L8z2F5VSt6b3sQkxIU5qbhudCdJI9hbmDk/mj6/9
 vCU1xSF5c9M5ui8ew4BmvaCF31iLlmZDk4HKZcj8QmLqPuT1o6lI7Caa1VQ2xNMWkKouoM+AOwG
 MSAY0cXGoqLudzrtyjkxDqfaBKWyLIXnklFgXN0/rRADHGs5acEYh6xiTVPznwwcFYMPszBcABb
 ZqRQWlp/PV5KPLHEcTKxAiyPhsp0O4eISNhJuiWiAJ8QTDkfXo38XPcNxg==
X-Google-Smtp-Source: AGHT+IGZqLHayvKML/zg3A0Uw0HN5WCVfcxmA/qqebH3Sv94i9r9fjScUbwOWTcR86T3yI2DCcOpuQ==
X-Received: by 2002:a17:902:ccc4:b0:223:3eed:f680 with SMTP id
 d9443c01a7336-2265e743eb3mr283621475ad.18.1742852370362; 
 Mon, 24 Mar 2025 14:39:30 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f3b40esm76131915ad.12.2025.03.24.14.39.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 14:39:29 -0700 (PDT)
Message-ID: <801ec860-0a47-43c2-a7c4-bf0af7f0f6ab@linaro.org>
Date: Mon, 24 Mar 2025 14:39:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/30] exec/target_page: runtime defintion for
 TARGET_PAGE_BITS_MIN
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
 <20250320223002.2915728-18-pierrick.bouvier@linaro.org>
 <2e667bb0-7357-4caf-ab60-4e57aabdceeb@linaro.org>
 <e738b8b8-e06f-48d0-845e-f263adb3dee5@linaro.org>
 <a67d17bb-e0dc-4767-8a43-8f057db70c71@linaro.org>
 <216a39c6-384d-4f9e-b615-05af18c6ef59@linaro.org>
 <c0e338f5-6592-4d83-9f17-120b9c4f039e@linaro.org>
 <ebd25730-1947-4360-af36-cf1131f4155c@linaro.org>
 <c1b7b73e-0a59-46cf-bf33-5712df5d9b75@linaro.org>
 <392cd6e5-0c73-4702-8733-d3047db76f77@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <392cd6e5-0c73-4702-8733-d3047db76f77@linaro.org>
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

T24gMy8yMi8yNSAxMzo1NSwgUmljaGFyZCBIZW5kZXJzb24gd3JvdGU6DQo+IE9uIDMvMjEv
MjUgMTc6MjAsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBPbiAzLzIxLzI1IDE3OjAx
LCBQaWVycmljayBCb3V2aWVyIHdyb3RlOg0KPj4+IE9uIDMvMjEvMjUgMTU6MTksIFJpY2hh
cmQgSGVuZGVyc29uIHdyb3RlOg0KPj4+PiBPbiAzLzIxLzI1IDEzOjExLCBQaWVycmljayBC
b3V2aWVyIHdyb3RlOg0KPj4+Pj4gT24gMy8yMS8yNSAxMjoyNywgUmljaGFyZCBIZW5kZXJz
b24gd3JvdGU6DQo+Pj4+Pj4gT24gMy8yMS8yNSAxMTowOSwgUGllcnJpY2sgQm91dmllciB3
cm90ZToNCj4+Pj4+Pj4+IE1tbSwgb2sgSSBndWVzcy7CoCBZZXN0ZXJkYXkgSSB3b3VsZCBo
YXZlIHN1Z2dlc3RlZCBtZXJnaW5nIHRoaXMgd2l0aCBwYWdlLXZhcnkuaCwgYnV0DQo+Pj4+
Pj4+PiB0b2RheSBJJ20gYWN0aXZlbHkgd29ya2luZyBvbiBtYWtpbmcgVEFSR0VUX1BBR0Vf
QklUU19NSU4gYSBnbG9iYWwgY29uc3RhbnQuDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pg0KPj4+Pj4+
PiBXaGVuIHlvdSBtZW50aW9uIHRoaXMsIGRvIHlvdSBtZWFuICJjb25zdGFudCBhY2Nyb3Nz
IGFsbCBhcmNoaXRlY3R1cmVzIiwgb3IgYSBnbG9iYWwNCj4+Pj4+Pj4gKGNvbnN0KSB2YXJp
YWJsZSB2cyBoYXZpbmcgYSBmdW5jdGlvbiBjYWxsPw0KPj4+Pj4+IFRoZSBmaXJzdCAtLSBj
b25zdGFudCBhY3Jvc3MgYWxsIGFyY2hpdGVjdHVyZXMuDQo+Pj4+Pj4NCj4+Pj4+DQo+Pj4+
PiBUaGF0J3MgZ3JlYXQuDQo+Pj4+PiBEb2VzIGNob29zaW5nIHRoZSBtaW4oc2V0X29mKFRB
UkdFVF9QQUdFX0JJVFNfTUlOKSkgaXMgd2hhdCB3ZSB3YW50IHRoZXJlLCBvciBpcyB0aGUN
Cj4+Pj4+IGFuc3dlciBtb3JlIHN1YnRsZSB0aGFuIHRoYXQ/DQo+Pj4+DQo+Pj4+IEl0IHdp
bGwgYmUsIHllcy4NCj4+Pj4NCj4+Pj4gVGhpcyBpc24ndCBhcyBoYXJkIGFzIGl0IHNlZW1z
LCBiZWNhdXNlIHRoZXJlIGFyZSBleGFjdGx5IHR3byB0YXJnZXRzIHdpdGgNCj4+Pj4gVEFS
R0VUX1BBR0VfQklUUyA8IDEyOiBhcm0gYW5kIGF2ci4NCj4+Pj4NCj4+Pj4gQmVjYXVzZSB3
ZSBzdGlsbCBzdXBwb3J0IGFybXY0LCBUQVJHRVRfUEFHRV9CSVRTX01JTiBtdXN0IGJlIDw9
IDEwLg0KPj4+Pg0KPj4+PiBBVlIgY3VycmVudGx5IGhhcyBUQVJHRVRfUEFHRV9CSVRTID09
IDgsIHdoaWNoIGlzIGEgYml0IG9mIGEgcHJvYmxlbS4NCj4+Pj4gTXkgZmlyc3QgdGFzayBp
cyB0byBhbGxvdyBhdnIgdG8gY2hvb3NlIFRBUkdFVF9QQUdFX0JJVFNfTUlOID49IDEwLg0K
Pj4+Pg0KPj4+PiBXaGljaCB3aWxsIGxlYXZlIHVzIHdpdGggVEFSR0VUX1BBR0VfQklUU19N
SU4gPT0gMTAuDQo+Pj4+DQo+Pj4NCj4+PiBPay4NCj4+Pg0KPj4+ICDCoCBGcm9tIHdoYXQg
SSB1bmRlcnN0YW5kLCB3ZSBtYWtlIHN1cmUgdGxiIGZsYWdzIGFyZSBzdG9yZWQgaW4gYW4N
Cj4+PiBpbW11dGFibGUgcG9zaXRpb24sIHdpdGhpbiB2aXJ0dWFsIGFkZHJlc3NlcyByZWxh
dGVkIHRvIGd1ZXN0LCBieSB1c2luZw0KPj4+IGxvd2VyIGJpdHMgYmVsb25naW5nIHRvIGFk
ZHJlc3MgcmFuZ2UgaW5zaWRlIGEgZ2l2ZW4gcGFnZSwgc2luY2UgcGFnZQ0KPj4+IGFkZHJl
c3NlcyBhcmUgYWxpZ25lZCBvbiBwYWdlIHNpemUsIGxlYXZpbmcgdGhvc2UgYml0cyBmcmVl
Lg0KPj4+DQo+Pj4gYml0cyBbMC4uMikgYXJlIGJzd2FwLCB3YXRjaHBvaW50IGFuZCBjaGVj
a19hbGlnbmVkLg0KPj4+IGJpdHMgW1RBUkdFVF9QQUdFX0JJVFNfTUlOIC0gNS4uVEFSR0VU
X1BBR0VfQklUU19NSU4pIGFyZSBzbG93LA0KPj4+IGRpc2NhcmRfd3JpdGUsIG1taW8sIG5v
dGRpcnR5LCBhbmQgaW52YWxpZCBtYXNrLg0KPj4+IEFuZCB0aGUgY29tcGlsZSB0aW1lIGNo
ZWNrIHdlIGhhdmUgaXMgdG8gbWFrZSBzdXJlIHdlIGRvbid0IG92ZXJsYXANCj4+PiB0aG9z
ZSBzZXRzICh3b3VsZCBoYXBwZW4gaW4gVEFSR0VUX1BBR0VfQklUU19NSU4gPD0gNykuDQo+
Pj4NCj4+PiBJIHdvbmRlciB3aHkgd2UgY2FuJ3QgdXNlIGJpdHMgWzMuLjgpIGV2ZXJ5d2hl
cmUsIGxpa2UgaXQncyBkb25lIGZvcg0KPj4+IEFWUiwgZXZlbiBmb3IgYmlnZ2VyIHBhZ2Ug
c2l6ZXMuIEkgbm90aWNlZCB0aGUgY29tbWVudCBhYm91dCAiYWRkcmVzcw0KPj4+IGFsaWdu
bWVudCBiaXRzIiwgYnV0IEknbSBjb25mdXNlZCB3aHkgYml0cyBbMC4uMikgY2FuIGJlIHVz
ZWQsIGFuZCBub3QNCj4+PiB1cHBlciBvbmVzLg0KPj4+DQo+Pj4gQXJlIHdlIHN0b3Jpbmcg
c29tZXRoaW5nIGVsc2UgaW4gdGhlIG1pZGRsZSBvbiBvdGhlciBhcmNocywgb3IgZGlkIEkN
Cj4+PiBtaXNzIHNvbWUgcGllY2Ugb2YgdGhlIHB1enpsZT8NCj4+Pg0KPj4NCj4+IEFmdGVy
IGxvb2tpbmcgYmV0dGVyLCBUTEJfU0xPV19GTEFHUyBhcmUgbm90IHBhcnQgb2YgYWRkcmVz
cywgc28gd2UgZG9uJ3QgdXNlIGJpdHMgWzAuLjIpLg0KPj4NCj4+IEZvciBhIGdpdmVuIFRB
UkdFVF9QQUdFX1NJWkUsIGhvdyBkbyB3ZSBkZWZpbmUgYWxpZ25tZW50IGJpdHM/DQo+IA0K
PiBBbGlnbm1lbnQgYml0cyBhcmUgdGhlIGxlYXN0IHNpZ25pZmljYW50IGJpdHMgdGhhdCBt
dXN0IGJlIDAgaW4gb3JkZXIgdG8gZW5mb3JjZSBhDQo+IHBhcnRpY3VsYXIgYWxpZ25tZW50
LiAgVGhlIHNwZWNpZmljIGFsaWdubWVudCBpcyByZXF1ZXN0ZWQgdmlhIE1PX0FMSUdOIGV0
IGFsIGFzIHBhcnQgb2YNCj4gdGhlIGd1ZXN0IG1lbW9yeSByZWZlcmVuY2UuDQo+IA0KPiBJ
IHRoaW5rIHRoZSBwaWVjZSB5b3UncmUgbWlzc2luZyBpcyB0aGUgc29mdG1tdSBmYXN0IHBh
dGggdGVzdCBpbiB0aGUgZ2VuZXJhdGVkIGNvZGUuDQo+IA0KPiBXZSBiZWdpbiBieSBpbmRl
eGluZyB0aGUgdGxiIHRvIGZpbmQgYW4gZW50cnkuICBBdCB0aGF0IGluZGV4LCB0aGUgZW50
cnkgbWF5IG9yIG1heSBub3QNCj4gbWF0Y2ggYmVjYXVzZSAoMSkgd2UgaGF2ZSBuZXZlciBs
b29rZWQgdXAgdGhlIHBhZ2Ugc28gdGhlIGVudHJ5IGlzIGVtcHR5LCAoMikgd2UgaGF2ZQ0K
PiBsb29rZWQgdXAgYSBkaWZmZXJlbnQgcGFnZSB0aGF0IGFsaWFzZXMsIG9yICgzKSB0aGUg
cGFnZSBpcyBwcmVzZW50IGFuZCAoM2EpIGNvcnJlY3QsIG9yDQo+ICgzYikgaW52YWxpZGF0
ZWQsIG9yICgzYykgc29tZSBvdGhlciBjb25kaXRpb24gdGhhdCBmb3JjZXMgdGhlIHNsb3cg
cGF0aC4NCj4gDQo+IFRoZSB0YXJnZXQgYWRkcmVzcyBhbmQgdGhlIGNvbXBhcmF0b3IgaGF2
ZSBzZXZlcmFsIGZpZWxkczoNCj4gDQo+ICAgICBwYWdlIGFkZHJlc3MgICBbNjMgLi4uIFRB
UkdFVF9QQUdFX0JJVFNdDQo+ICAgICBwYWdlIGZsYWdzICAgICBbVEFSR0VUX1BBR0VfQklU
UyAtIDEgLi4uIFRBUkdFVF9QQUdFX0JJVFMgLSA1XQ0KPiAgICAgdW51c2VkICAgICAgICAg
W1RBUkdFVF9QQUdFX0JJVFMgLSA2IC4uLiBhbGlnbl9iaXRzXSwgb3IgZW1wdHkuDQo+ICAg
ICBhbGlnbm1lbnQgICAgICBbYWxpZ25fYml0cyAtIDEgLi4uIDBdLCBvciBlbXB0eQ0KPiAN
Cj4gSW4gdGhlIGNvbXBhcmF0b3IsIHRoZSB1bnVzZWQgYW5kIGFsaWdubWVudCBiaXRzIGFy
ZSBhbHdheXMgemVybzsgdGhlIHBhZ2UgZmxhZ3MgbWF5IGJlDQo+IG5vbi16ZXJvIGluIG9y
ZGVyIHRvIGZvcmNlIHRoZSBjb21wYXJpc29uIHRvIGZhaWwuDQo+IA0KPiBJbiB0aGUgdGFy
Z2V0IGFkZHJlc3MsIHdlIG1hc2sgdGhlIHBhZ2UgZmxhZ3MgYW5kIHVudXNlZCBiaXRzOyBp
ZiB0aGUgYWxpZ25tZW50IGJpdHMgb2YNCj4gdGhlIGFkZHJlc3MgYXJlIHNldCwgdGhlbiB0
aGUgYWRkcmVzcyBpcyBvZiBjb3Vyc2UgdW5hbGlnbmVkIGFuZCBzbyB0aGUgY29tcGFyaXNv
biBmYWlscy4NCj4gDQo+IEluIG9yZGVyIGZvciBhbGwgdGhpcyB3b3JrLCB0aGUgYWxpZ25t
ZW50IGZpZWxkIGNhbm5vdCBvdmVybGFwIHRoZSBwYWdlIGZsYWdzLg0KPiANCj4gVGhlIG1h
eGltdW0gYWxpZ25tZW50IGN1cnJlbnRseSB1c2VkIGJ5IGFueSBndWVzdCBpcyA1IGJpdHMs
IGZvciBBcm0gTmVvbiwNCj4gd2hpY2ggbWVhbnMgdGhlIG1pbmltdW0gdmFsdWUgZm9yIFRB
UkdFVF9QQUdFX0JJVFNfTUlOIGlzIDEwLg0KPiANCg0KVGhhbmtzLCBJIHRoaW5rIEkgY2Fu
IGZpbmFsbHkgdW5kZXJzdGFuZCBiZXR0ZXIgd2hhdCBwcmVwYXJlX2hvc3RfYWRkciANCmlz
IGRvaW5nLCB3aGljaCB5b3UgbWVudGlvbmVkIHdoZW4gd2UgdGFsa2VkIGFib3V0IHRoYXQg
d2Vla3MgYWdvLg0KQW5kIHRodXMsIGdyYXNwIHdoYXQgaXMgcmVhbGx5IG91ciBmYXN0IHBh
dGggZm9yIE1NVSBlbXVsYXRpb24uDQoNClRoYXQncyBwcmV0dHkgbmVhdCBieSB0aGUgd2F5
LCBpbmNsdWRpbmcgb3VyIGhldXJpc3RpYyB0byByZXNpemUgdGhlIFRMQiANCml0c2VsZi4N
Cg0KPiANCj4gcn4NCg0K

