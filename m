Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4DD7C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 18:32:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4l4p-0006Kf-KU; Tue, 15 Apr 2025 14:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4l4i-0006Ih-Ov
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 14:32:01 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4l4g-000088-6I
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 14:32:00 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-736b0c68092so5085881b3a.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 11:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744741915; x=1745346715; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9BiYlB475ZiZKtvtTxgCOcQH9yHln3t38TcLxq3k9aA=;
 b=smfhNFAOuW4aSXESMsQ12wSar2uOoWsVnK8m8vGWAeFEuL6TLFy/Kcfn1HspPDFMLD
 tuliajIyCzhCBeM1a4L7I7HiFaecwP1l+2NuEwbrXoPQPJVslFSkl3MXd2mR1U4tIVjM
 RhwvD8OLaIciXrahE7i/84JxHliC5VCRtnX3jlwVRcZfehHCLqJAdvRol4OKRJCVkVQT
 otbpuWkBJV+YEoPGdhlhA8k5hrM0IAiPNbuKEGyB93m8nLKEVAv+bipzpWCFLw9Gpce/
 Z7+Ot+AGl/15Pl1M96OLvEMeun1b/Q4VI8kf+FUCC4nhkCg+RMsNbGYcFr39JpL1M7oP
 sw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744741915; x=1745346715;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9BiYlB475ZiZKtvtTxgCOcQH9yHln3t38TcLxq3k9aA=;
 b=X7gztXYoo5HfT20RQruqh4sHxPydmOSft2hBSehjzyg/XXTV8btMdlaoGbddnTI4Gq
 qKvo5YC5+cPlPZ+stSbeuYvFAtoGxurpalQ/EQ71iFQpEwYas+POu3bbaYFmVRcc4dUo
 rwNQe1JO/v+Mh7BmWpouWjUSjG5YlLAFFadyXyMQkg/zviqLGYXEoOKH2xT/2bx1rTLw
 HGQ0OogtKjBPh1NfPsHBiZ6OeBEAFMECjBdYYf5p8BE7Ycp/iPrf1lnfhobVvHe95sEU
 4NlFAQJ5MTuQDEIgLHp873GCa8HQ53lD3GZxl01vEDyNEvomVZJ92LFpKjtkNvBHWFMc
 uquw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVt+o8+ef1OG8ozfuNgSUeh5QizbjwmQk5FpOB+GqvaGFnzEh4yV/g+JBCgxNQgxACroNqH9NUxsoQI@nongnu.org
X-Gm-Message-State: AOJu0YyghKMDXMS59S0s0qPr3ev2j2BVIpj5S7OUXhFOpkzB94957+OA
 KK9TMbQb+2HuZlcVtMCbpHO408lO0y3agvzZUAAjUtz5JKhNjzf8RUggLmoHMx8=
X-Gm-Gg: ASbGncsR4lMoQejxfttkqNFRYYiF780/+tWVOC5gb/FHahtisEqkDPVU4HdBuCv6dlR
 F171oqw8ihpr67qXq6nMjlLbpjjotOWWic7utQHgifv4nirGBNCEbG8TStRGBnefsC3qwbqLQIe
 9NfwUFGZJvqd5QgV357oLGHkXzQBVQ8UkSGyBYSZwyFEpRPHll2RimZyNxjdnnEwLZuB9RdMkDA
 4ivu5RV6IgAs3RzOQhsJW/DitpbFYEKw2WUi3OtaKEZ7RAojUnPJHy17T1S3GysayO9+ZmPP9uA
 YAfUzNT1MFE9AOqDEv5PEP7kgbSIndQo6cr0iiW8wl+FjiZfiagsWA==
X-Google-Smtp-Source: AGHT+IEoMOTyHrHEGg/BOgOuOa/9gmOSoW11aB86XjkeNrvTJz76POF04CCRWT57Ctx8/nsdjaW0Rw==
X-Received: by 2002:a05:6a21:114f:b0:1f5:87ea:2a10 with SMTP id
 adf61e73a8af0-203adfb15c1mr45787637.9.1744741915323; 
 Tue, 15 Apr 2025 11:31:55 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b02a0818248sm11416629a12.9.2025.04.15.11.31.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 11:31:54 -0700 (PDT)
Message-ID: <f8a90e7b-daa7-4c87-9702-e80e9d5b162e@linaro.org>
Date: Tue, 15 Apr 2025 11:31:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] system/main: transfer replay mutex ownership from
 main thread to main loop thread
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>
References: <20250410225550.46807-1-pierrick.bouvier@linaro.org>
 <20250410225550.46807-2-pierrick.bouvier@linaro.org>
 <D94EWG4QRMFP.123EPDW889YVC@gmail.com>
 <7e760e04-0571-48f3-9aa7-e71c631dcaff@linaro.org>
 <dee088aa-436f-48dc-8a28-f675de42767b@linaro.org>
 <5cac93d4-e5a6-42b0-8f7b-5a273168a450@linaro.org>
 <D96V6HTTNOF1.3DDO2NQ0AUEA0@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <D96V6HTTNOF1.3DDO2NQ0AUEA0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

T24gNC8xNC8yNSAxOTo0MSwgTmljaG9sYXMgUGlnZ2luIHdyb3RlOg0KPiBPbiBUdWUgQXBy
IDE1LCAyMDI1IGF0IDE6MjQgQU0gQUVTVCwgUGllcnJpY2sgQm91dmllciB3cm90ZToNCj4+
IE9uIDQvMTQvMjUgMDM6MjUsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPj4+
IE9uIDEyLzQvMjUgMTk6MjQsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+Pj4+IE9uIDQv
MTEvMjUgMjI6MzAsIE5pY2hvbGFzIFBpZ2dpbiB3cm90ZToNCj4+Pj4+IE9uIEZyaSBBcHIg
MTEsIDIwMjUgYXQgODo1NSBBTSBBRVNULCBQaWVycmljayBCb3V2aWVyIHdyb3RlOg0KPj4+
Pj4+IE9uIE1hY09TLCBVSSBldmVudCBsb29wIGhhcyB0byBiZSByYW4gaW4gdGhlIG1haW4g
dGhyZWFkIG9mIGEgcHJvY2Vzcy4NCj4+Pj4+PiBCZWNhdXNlIG9mIHRoYXQgcmVzdHJpY3Rp
b24sIG9uIHRoaXMgcGxhdGZvcm0sIHFlbXUgbWFpbiBldmVudCBsb29wIGlzDQo+Pj4+Pj4g
cmFuIG9uIGFub3RoZXIgdGhyZWFkIFsxXS4NCj4+Pj4+Pg0KPj4+Pj4+IFRoaXMgYnJlYWtz
IHJlY29yZC9yZXBsYXkgZmVhdHVyZSwgd2hpY2ggZXhwZWN0cyB0aHJlYWQgcnVubmluZw0K
Pj4+Pj4+IHFlbXVfaW5pdA0KPj4+Pj4+IHRvIGluaXRpYWxpemUgaG9sZCB0aGlzIGxvY2ss
IGJyZWFraW5nIGFzc29jaWF0ZWQgZnVuY3Rpb25hbCB0ZXN0cyBvbg0KPj4+Pj4+IE1hY09T
Lg0KPj4+Pj4+DQo+Pj4+Pj4gVGh1cywgYXMgYSBnZW5lcmFsaXphdGlvbiwgYW5kIHNpbWls
YXIgdG8gaG93IEJRTCBpcyBoYW5kbGVkLCB3ZSByZWxlYXNlDQo+Pj4+Pj4gaXQgYWZ0ZXIg
aW5pdCwgYW5kIHJlYWNxdWlyZSB0aGUgbG9jayBiZWZvcmUgZW50ZXJpbmcgbWFpbiBldmVu
dCBsb29wLA0KPj4+Pj4+IGF2b2lkaW5nIGEgc3BlY2lhbCBjYXNlIGlmIGEgc2VwYXJhdGUg
dGhyZWFkIGlzIHVzZWQuDQo+Pj4+Pj4NCj4+Pj4+PiBUZXN0ZWQgb24gTWFjT1Mgd2l0aDoN
Cj4+Pj4+PiAkIG1lc29uIHRlc3QgLUMgYnVpbGQgLS1zZXR1cCB0aG9yb3VnaCAtLXByaW50
LWVycm9ybG9ncyBcDQo+Pj4+Pj4gZnVuYy14ODZfNjQteDg2XzY0X3JlcGxheSBmdW5jLWFy
bS1hcm1fcmVwbGF5IGZ1bmMtYWFyY2g2NC0NCj4+Pj4+PiBhYXJjaDY0X3JlcGxheQ0KPj4+
Pj4+ICQgLi9idWlsZC9xZW11LXN5c3RlbS14ODZfNjQgLW5vZ3JhcGhpYyAtaWNvdW50DQo+
Pj4+Pj4gc2hpZnQ9YXV0byxycj1yZWNvcmQscnJmaWxlPXJlcGxheS5sb2cNCj4+Pj4+PiAk
IC4vYnVpbGQvcWVtdS1zeXN0ZW0teDg2XzY0IC1ub2dyYXBoaWMgLWljb3VudA0KPj4+Pj4+
IHNoaWZ0PWF1dG8scnI9cmVwbGF5LHJyZmlsZT1yZXBsYXkubG9nDQo+Pj4+Pj4NCj4+Pj4+
PiBbMV0gaHR0cHM6Ly9naXRsYWIuY29tL3FlbXUtcHJvamVjdC9xZW11Ly0vY29tbWl0Lw0K
Pj4+Pj4+IGY1YWIxMmNhYmE0ZjE2NTY0NzljMWZlYjUyNDhiZWFjMWM4MzMyNDMNCj4+Pj4+
Pg0KPj4+Pj4+IEZpeGVzOiBodHRwczovL2dpdGxhYi5jb20vcWVtdS1wcm9qZWN0L3FlbXUv
LS9pc3N1ZXMvMjkwNw0KPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFBpZXJyaWNrIEJvdXZpZXIg
PHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCj4+Pj4+PiAtLS0NCj4+Pj4+PiAgIMKg
IHN5c3RlbS9tYWluLmMgfCA0ICsrKysNCj4+Pj4+PiAgIMKgIDEgZmlsZSBjaGFuZ2VkLCA0
IGluc2VydGlvbnMoKykNCj4+Pj4+Pg0KPj4+Pj4+IGRpZmYgLS1naXQgYS9zeXN0ZW0vbWFp
bi5jIGIvc3lzdGVtL21haW4uYw0KPj4+Pj4+IGluZGV4IGVjYjEyZmQzOTdjLi4xYzAyMjA2
NzM0OSAxMDA2NDQNCj4+Pj4+PiAtLS0gYS9zeXN0ZW0vbWFpbi5jDQo+Pj4+Pj4gKysrIGIv
c3lzdGVtL21haW4uYw0KPj4+Pj4+IEBAIC0yNSw2ICsyNSw3IEBADQo+Pj4+Pj4gICDCoCAj
aW5jbHVkZSAicWVtdS9vc2RlcC5oIg0KPj4+Pj4+ICAgwqAgI2luY2x1ZGUgInFlbXUtbWFp
bi5oIg0KPj4+Pj4+ICAgwqAgI2luY2x1ZGUgInFlbXUvbWFpbi1sb29wLmgiDQo+Pj4+Pj4g
KyNpbmNsdWRlICJzeXN0ZW0vcmVwbGF5LmgiDQo+Pj4+Pj4gICDCoCAjaW5jbHVkZSAic3lz
dGVtL3N5c3RlbS5oIg0KPj4+Pj4+ICAgwqAgI2lmZGVmIENPTkZJR19TREwNCj4+Pj4+PiBA
QCAtNDQsMTAgKzQ1LDEyIEBAIHN0YXRpYyB2b2lkICpxZW11X2RlZmF1bHRfbWFpbih2b2lk
ICpvcGFxdWUpDQo+Pj4+Pj4gICDCoCB7DQo+Pj4+Pj4gICDCoMKgwqDCoMKgIGludCBzdGF0
dXM7DQo+Pj4+Pj4gK8KgwqDCoCByZXBsYXlfbXV0ZXhfbG9jaygpOw0KPj4+Pj4+ICAgwqDC
oMKgwqDCoCBicWxfbG9jaygpOw0KPj4+Pj4+ICAgwqDCoMKgwqDCoCBzdGF0dXMgPSBxZW11
X21haW5fbG9vcCgpOw0KPj4+Pj4+ICAgwqDCoMKgwqDCoCBxZW11X2NsZWFudXAoc3RhdHVz
KTsNCj4+Pj4+PiAgIMKgwqDCoMKgwqAgYnFsX3VubG9jaygpOw0KPj4+Pj4+ICvCoMKgwqAg
cmVwbGF5X211dGV4X3VubG9jaygpOw0KPj4+Pj4+ICAgwqDCoMKgwqDCoCBleGl0KHN0YXR1
cyk7DQo+Pj4+Pj4gICDCoCB9DQo+Pj4+Pj4gQEAgLTY3LDYgKzcwLDcgQEAgaW50IG1haW4o
aW50IGFyZ2MsIGNoYXIgKiphcmd2KQ0KPj4+Pj4+ICAgwqAgew0KPj4+Pj4+ICAgwqDCoMKg
wqDCoCBxZW11X2luaXQoYXJnYywgYXJndik7DQo+Pj4+Pj4gICDCoMKgwqDCoMKgIGJxbF91
bmxvY2soKTsNCj4+Pj4+PiArwqDCoMKgIHJlcGxheV9tdXRleF91bmxvY2soKTsNCj4+Pj4+
PiAgIMKgwqDCoMKgwqAgaWYgKHFlbXVfbWFpbikgew0KPj4+Pj4+ICAgwqDCoMKgwqDCoMKg
wqDCoMKgIFFlbXVUaHJlYWQgbWFpbl9sb29wX3RocmVhZDsNCj4+Pj4+PiAgIMKgwqDCoMKg
wqDCoMKgwqDCoCBxZW11X3RocmVhZF9jcmVhdGUoJm1haW5fbG9vcF90aHJlYWQsICJxZW11
X21haW4iLA0KPj4+Pj4NCj4+Pj4+IERvIHdlIGFjdHVhbGx5IG5lZWQgdG8gaG9sZCByZXBs
YXkgbXV0ZXggKG9yIGV2ZW4gYnFsKSBvdmVyIHFlbXVfaW5pdCgpPw0KPj4+Pj4gQm90aCBz
aG91bGQgZ2V0IGRyb3BwZWQgYmVmb3JlIHdlIHJldHVybiBoZXJlLiBCdXQgYXMgYSBzaW1w
bGUgZml4LCBJDQo+Pj4+PiBndWVzcyB0aGlzIGlzIG9rYXkuDQo+Pj4+Pg0KPj4+Pg0KPj4+
PiBGb3IgdGhlIGJxbCwgSSBkb24ndCBrbm93IHRoZSBleGFjdCByZWFzb24uDQo+Pj4+IEZv
ciByZXBsYXkgbG9jaywgd2UgbmVlZCB0byBob2xkIGl0IGFzIGNsb2NrIGdldHMgc2F2ZWQg
YXMgc29vbiBhcyB0aGUNCj4+Pj4gZGV2aWNlcyBhcmUgaW5pdGlhbGl6ZWQsIHdoaWNoIGhh
cHBlbnMgYmVmb3JlIGVuZCBvZiBxZW11X2luaXQuDQo+Pj4NCj4+PiBDb3VsZCBiZSB3b3J0
aCBhZGRpbmcgYSBjb21tZW50IHdpdGggdGhhdCBpbmZvcm1hdGlvbi4NCj4+Pg0KPj4NCj4+
IEluIGNhc2Ugc29tZW9uZSBpcyBjdXJpb3VzIGFib3V0IGl0LCBjaGFuZ2luZyBkZWZhdWx0
IHN0YXRlIG9mIGxvY2sgY2FuDQo+PiBhbnN3ZXIgd2h5IGl0J3MgbmVlZGVkLCBhcyBpdCBj
cmFzaGVzIGltbWVkaWF0ZWx5IG9uIGFuIGFzc2VydC4NCj4gDQo+IFRoYXQgYWxsIHNvdW5k
cyByZWFzb25hYmxlIGVub3VnaCBhbmQgZ29vZCBpbmZvLiBJJ20gbm90IHN1Z2dlc3Rpbmcg
dG8NCj4gcmVtb3ZlIHRoZSBsb2NrIGZyb20gcWVtdV9pbml0KCkgYnkgYXNzdW1pbmcgd2Ug
YXJlIGluIGluaXQgYW5kIGluaXQgaXMNCj4gc2luZ2xlIHRocmVhZGVkIChJIGFncmVlIGl0
J3MgZ29vZCBwcmFjdGljZSB0byBrZWVwIGxvY2tpbmcgY29uc2lzdGVudCkuDQo+IA0KPiBN
eSBxdWVzdGlvbiB3YXMgbW9yZSB0aGF0IHdlIHNob3VsZCBtb3ZlIHRoZSBsb2NrcyB0aWdo
dGVyIGFyb3VuZA0KPiB0aGUgb3BlcmF0aW9ucyB0aGF0IHJlcXVpcmUgdGhlbS4gTW92ZSB0
aGUgdW5sb2NrIGludG8gcWVtdV9pbml0KCkuDQo+IA0KPiBDb21taXQgZjVhYjEyY2FiYTRm
MSBkaWRuJ3QgaW50cm9kdWNlIHRoaXMgcHJvYmxlbSwgY29jb2FfbWFpbigpDQo+IGFscmVh
ZHkgaW1tZWRpYXRleSBjYWxsZWQgYnFsX3VubG9jaygpIHNvIGVmZmVjdGl2ZWx5IHRoZSBp
c3N1ZSBpcw0KPiBzdGlsbCB0aGVyZS4gVGhlIG9yaWdpbmFsIGRlc2lnbiBiZWZvcmUgY29j
b2EgSSBndWVzcyB3YXMgdGhhdCBxZW11X2luaXQNCj4gd291bGQgaW5pdCB0aGluZ3MgdW5k
ZXIgdGhlIHNhbWUgY3JpdGljYWwgc2VjdGlvbiBhcyBxZW11X21haW5fbG9vcCgpIGlzDQo+
IHRoZW4gY2FsbGVkLCB3aGljaCBpcyByZWFzb25hYmxlIGFuZCBjb25zZXJ2YXRpdmUuIEl0
IHdvdWxkIGhhdmUgYmVlbg0KPiBnb29kIHRvIHNlZSB0aGlzIGJxbCBzcGxpdCBnZXQgYSBz
cGVjaWZpYyBwYXRjaCB0byBlcHhsYWluIHdoeSBpdCdzIG5vdA0KPiBuZWVkZWQgYWNyb3Nz
IHFlbXVfaW5pdCBhbmQgcWVtdV9tYWluX2xvb3AsIGJ1dCBubyBiaWcgZGVhbCBub3cuDQo+
IA0KDQpMb29raW5nIG1vcmUgY2xvc2VseSwgYnFsX2xvY2sgZW5zdXJlIHZjcHVzIGRvbid0
IHN0YXJ0IGV4ZWN1dGluZyANCmFueXRoaW5nIGJlZm9yZSBpbml0IGlzIGNvbXBsZXRlZC4g
U28gd2UgcmVhbGx5IHdhbnQgdG8gaG9sZCB0aGUgbG9jayANCnRocm91Z2ggYWxsIHFlbXVf
aW5pdCgpLg0KDQpDb25jZXJuaW5nIHJlcGxheV9sb2NrLCBkdXJpbmcgaW5pdCwgaWNvdW50
X2NvbmZpZ3VyZSBjYWxscyANCnFlbXVfY2xvY2tfZ2V0X25zLCB0aGF0IGNhbGxzIHJlcGxh
eV9zYXZlX2Nsb2NrLCB3aGljaCBleHBlY3RzIHRvIGhhdmUgDQp0aGUgbG9jay4gVGh1cywg
d2Ugc2hvdWxkIGhvbGQgdGhlIGxvY2ssIGF0IGxlYXN0IGR1cmluZyBpY291bnQgDQpjb25m
aWd1cmF0aW9uLg0KDQo+IFRoZSBwYXRjaCBpcyBmaW5lIGZvciBhIGZpeCwgY291bGQgSSBz
dWdnZXN0IGFub3RoZXIgcGF0Y2ggdGhhdA0KPiBtb3ZlcyB0aGUgbG9jayBuYXJyb3dlciBh
bmQgcGVyaGFwcyBhZGRzIGEgZmV3IHdvcmRzIG9mIGNvbW1lbnQ/DQo+IA0KDQpXZSB3b3Vs
ZCBzdGlsbCBuZWVkIHRvIGFjcXVpcmUgbG9ja3MgaW4gcWVtdV9kZWZhdWx0X21haW4oKSBh
bnl3YXkuDQoNCkZvciBicWwsIHdlIGRlZmluaXRlbHkgd2FudCB0byBob2xkIGl0IGFueXRp
bWUgdGhyb3VnaCBpbml0LCBzbyB0aGUgDQpzY29wZSBpcyBlbmQgb2YgaW5pdC4NCkZvciBy
ZXBsYXlfbG9jaywgaXQgY291bGQgYmUgbW92ZWQgYXJvdW5kIHBhcnRzIHRoYXQgZXhwZWN0
IGl0IGR1cmluZyANCmluaXRpYWxpemF0aW9uLCBidXQgd2hhdCB3b3VsZCBiZSB0aGUgYmVu
ZWZpdCwgY29uc2lkZXJpbmcgb25seSBvbmUgDQp0aHJlYWQgaXMgcnVubmluZyBkdXJpbmcg
aW5pdD8NCg0KTW92aW5nIGxvY2tzIG5hcnJvd2VyIGlzIHVzdWFsbHkgbWFkZSB0byBhbGxv
dyBtb3JlIGNvbmN1cnJlbmN5LCBhdCB0aGUgDQpwcmljZSBvZiBpbmNyZWFzZWQgY29tcGxl
eGl0eS4gSW4gaW5pdCBwaGFzZSwgb25seSBvbmUgdGhyZWFkIHJ1bnMgDQphbnl3YXksIHNv
IHRoZXJlIGlzIG5vIGJlbmVmaXQgdG8gZG8gYW55dGhpbmcgYXJvdW5kIGhlcmUuDQoNCldo
YXQgd2UgY291bGQgZXZlbnR1YWxseSBkbyBpcyBtb3ZlIHRob3NlIHVubG9jayBhdCB0aGUg
ZW5kIG9mIA0KcWVtdV9pbml0LCBidXQgSU1ITywgaXQncyBtb3JlIHJlYWRhYmxlIHRvIHNl
ZSB0aGUgbG9jay91bmxvY2sgc2NoZW1lIGluIA0KYSBzaW5nbGUgcGxhY2UsIGluIHN5c3Rl
bS9tYWluLmMuDQpBcyB3ZWxsLCBJIHRoaW5rIGl0J3MgYmV0dGVyIHRvIGhhdmUgYSBzaW5n
bGUgY29kZSBwYXRoIGZvciBsb2NrL3VubG9jaywgDQp3aGV0aGVyIHdlIHVzZSBhIGJhY2tn
cm91bmQgdGhyZWFkIG9yIG5vdCAodnMgYWRkaW5nIGEgYm9vbCBwYXJhbWV0ZXIgdG8gDQpx
ZW11X2RlZmF1bHRfbWFpbigpIHNheWluZyBpZiB3ZSBhcmUgaW4gdGhlIHNhbWUgdGhyZWFk
LCBvciBhIGRpZmZlcmVudCANCm9uZSkuDQoNCj4gVGhhbmtzLA0KPiBOaWNrDQoNCg==

