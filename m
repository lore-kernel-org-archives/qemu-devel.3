Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE207C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 19:12:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twnCQ-0006ZN-4Q; Mon, 24 Mar 2025 15:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twnCG-0006Wm-U6
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 15:10:54 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twnCD-0003B5-RS
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 15:10:52 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-224341bbc1dso90531605ad.3
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 12:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742843448; x=1743448248; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cCN1PPxlnvR+MkOsUHuI7T4XnPJQV06okAj3aUlcfTE=;
 b=ZeCIeIyRmvNiyBAZSG2bR9Eo66leKOUcNUM67XeT9m+ByGL4XsoMV8mzgBLpwwCXz8
 SoNUxDl+O9/lJ0jZglbraR5PnTLv9Ua0COplKMYMOTgDMR40QCbZbprXLzXq9Nu9kA6n
 fKr3EWQxnTzijQllY4JPDX4G8jFIDRsRGeEtYEU0ymDaddK3JX8DAXSUbKBjf6fY52ZC
 OA45su1TWN/2W+9qqlFIY9Of+2qCRzcZmkyTPY5YD5KDFyr8vFvnOS8sSz37GjxVCxrt
 R9WY/YIA0pXG9Se+sGIki+9TLwU6cwI6ymmgqV43Ib5jYTO0V12lRxqOqeFs2IH41LaO
 LwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742843448; x=1743448248;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cCN1PPxlnvR+MkOsUHuI7T4XnPJQV06okAj3aUlcfTE=;
 b=Wn8C3n3QyZgBey39VYrXO/zYfPSCF2LnRtFMeQKCVXO4IiM1VBoAIzkhY/4FPIL6Ry
 F2hU4tMurjiRiLVnd5jdTBB1LT1r1HRprGXs7ERGiKlJkpHH/4ktVvD6kAhBBDdJMw75
 y2g7Uvax8eot+o5Lrr4WsbUEBLjrOoCdC3plPW71F0D51qhSu0nTj3NuR+HQ8HJNbk6h
 evMnhLjemRCZMBHqXQSkuQ9QVsjalP9+euSanFvYik3WmbOoeh4tdEor6cjJoT96vGQK
 uoycYUEbsW/L6YdQdaTMYnnigSXPOVKzRQViO+eITO/kFyCO0L/S3xYEwtCSIl+sJlyc
 yRIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXt/5ptpg0dTCRxubxyY9LTAf0pDsIDKUDE72412cTUWxFRMGQfbzcrza9XBv8eDt7SSG4ri5r3+pF3@nongnu.org
X-Gm-Message-State: AOJu0Ywdvq7ox+EnaYMGOwe9ePpCytWxRn/hJW0ye4uv6VmOEeO6PrsZ
 pcTrhH0FH7sl57UM468/8lljH+dNScJJ8IREMKg0F804nqsvlwOPiPvIixJE+vI=
X-Gm-Gg: ASbGnctW3wF64flgA/1ZhSwIK8WGuML7sXoiZ5vGCdvB4NGLTuKmfHSQ7erHrEzCLwd
 kxENHA3fCIS1ITUS8CYrjEuyExCMSF9Q92wnipdBOFJc82W8nNQIEJkWD4IVqHWYeemaeoN9WjK
 /gI7gLSW5tf3B6FL58/WPqZ3wWLaXGyoJf0Rih7Jpd0yCAebueXgdtyI7NuYocxNK4l7LNoe4Ij
 HZctlEDp+plrMb4y1lVTHYN3grajc/ugVQpl1cnNJHGr4i96wF8d2LxLSQCV//Qp7bHT4ViNqBY
 Yu66Bo9M+WETCTXIqwUrCEbiStmUXy/EcBMyeRBmy75rUyo5ibg1UILqJg==
X-Google-Smtp-Source: AGHT+IFil7KX7Vu1aU1hudwEPqXKdOzFRoDOpkYAmHN4hhgNm+72loWDIt1EYT2QbsEZLptQ6v/FOw==
X-Received: by 2002:a17:903:41cf:b0:224:78e:4ebe with SMTP id
 d9443c01a7336-22780e0a917mr189591895ad.33.1742843447711; 
 Mon, 24 Mar 2025 12:10:47 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811c6ecdsm74782645ad.107.2025.03.24.12.10.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 12:10:47 -0700 (PDT)
Message-ID: <9edeb890-9822-4a43-ae36-621509f94de0@linaro.org>
Date: Mon, 24 Mar 2025 12:10:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] gdbstub: conversion to runtime endianess helpers
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
 David Hildenbrand <david@redhat.com>
References: <20250324102142.67022-1-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250324102142.67022-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

T24gMy8yNC8yNSAwMzoyMSwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBUaGUgYWltIG9mIHRo
aXMgd29yayBpcyB0byBnZXQgcmlkIG9mIHRoZSBlbmRpYW4gYXdhcmUgaGVscGVycyBpbg0K
PiBnZGJzdHViL2hlbHBlcnMuaCB3aGljaCBkdWUgdG8gdGhlaXIgdXNlIG9mIHRzd2FwKCkg
bWVhbiB0YXJnZXQNCj4gZ2Ric3R1YnMgbmVlZCB0byBiZSBidWlsdCBtdWx0aXBsZSB0aW1l
cy4gV2hpbGUgdGhpcyBzZXJpZXMgZG9lc24ndA0KPiBhY3R1YWxseSBidWlsZCBlYWNoIHN0
dWIgb25jZSBpdCBpbnRyb2R1Y2VzIGEgbmV3IGhlbHBlciAtDQo+IGdkYl9nZXRfcmVnaXN0
ZXJfdmFsdWUoKSB3aGljaCB0YWtlcyBhIE1lbU9wIHdoaWNoIGNhbiBkZXNjcmliZSB0aGUN
Cj4gY3VycmVudCBlbmRpYW4gc3RhdGUgb2YgdGhlIHN5c3RlbS4gVGhpcyB3aWxsIGJlIGEg
bG90IGVhc2llciB0bw0KPiBkeW5hbWljYWxseSBmZWVkIGZyb20gYSBoZWxwZXIgZnVuY3Rp
b24uDQo+IA0KPiBUaGUgbW9zdCBjb21wbGV4IGV4YW1wbGUgaXMgUFBDIHdoaWNoIGhhcyBh
IGhlbHBlciBjYWxsZWQNCj4gcHBjX21heWJlX2Jzd2FwX3JlZ2lzdGVyKCkgd2hpY2ggd2Fz
IGRvaW5nIHRoaXMuDQo+IA0KPiBUaGlzIGlzIHN0aWxsIGFuIFJGQyBidXQgSSd2ZSBzcHVu
IG91dCB2MiBmb3IgZnVydGhlciBkaXNjdXNzaW9uLg0KPiANCj4gSW4gdjI6DQo+IA0KPiAg
ICAtIGRyb3AgdWludDhfdCBjYXN0aW5nIGFuZCB1c2Ugdm9pZCBhcyBDIGludGVuZGVkIDst
KQ0KDQpDIGFsbG93cyB0aGF0IHBlcm1pc3NpdmVseSwgYW5kIGl0IGNhbiBiZSBjb252ZW5p
ZW50IHdoZW4gdW5kZXJseWluZyANCnR5cGUgaXMgcmVhbGx5IHVua25vd24uIEJ1dCBpbiBv
dXIgY2FzZSwgaXQncyBvbmx5IHR3byB2YXJpYW50cy4NCg0KSWYgcmVhbGx5IGl0IGh1cnRz
IHRvIHJlcGxhY2UgY2FsbGVycywgX0dlbmVyaWMgaXMgYXQgbGVhc3QgYSBiZXR0ZXIgDQpz
b2x1dGlvbiB0aGFuIGludm9raW5nIHRoZSB2b2lkKiBoYW1tZXIuDQoNCj4gICAgLSBhZGQg
c3BlY2lmaWMgMzIvNjQgYml0IGhlbHBlcnMgd2l0aCB0eXBlIGNoZWNraW5nIGFuIGFzc2Vy
dGlvbg0KPiAgICAtIHZhcmlvdXMgdHdlYWtzIGFuZCBmaXhlcyAoc2VlIGluZGl2aWR1YWwg
Y29tbWl0cykNCj4gDQo+IFRoZXJlIGFyZSBhIGZldyBvdGhlciBtaXNjIGNsZWFuLXVwcyBJ
IGRpZCBvbiB0aGUgd2F5IHdoaWNoIG1pZ2h0IGJlDQo+IHdvcnRoIGNoZXJyeSBwaWNraW5n
IGZvciAxMC4wIGJ1dCBJJ2xsIGxlYXZlIHRoYXQgdXAgdG8gbWFpbnRhaW5lcnMuDQo+IA0K
PiBBbGV4IEJlbm7DqWUgKDExKToNCj4gICAgaW5jbHVkZS9leGVjOiBmaXggYXNzZXJ0IGlu
IHNpemVfbWVtb3ANCj4gICAgaW5jbHVkZS9nZGJzdHViOiBmaXggaW5jbHVkZSBndWFyZCBp
biBjb21tYW5kcy5oDQo+ICAgIGdkYnN0dWI6IGFzc2VydCBlYXJsaWVyIGluIGhhbmRsZV9y
ZWFkX2FsbF9yZWdzDQo+ICAgIGdkYnN0dWI6IGludHJvZHVjZSB0YXJnZXQgaW5kZXBlbmRl
bnQgZ2RiIHJlZ2lzdGVyIGhlbHBlcg0KPiAgICB0YXJnZXQvYXJtOiBjb252ZXJ0IDMyIGJp
dCBnZGJzdHViIHRvIG5ldyBoZWxwZXJzDQo+ICAgIHRhcmdldC9hcm06IGNvbnZlcnQgNjQg
Yml0IGdkYnN0dWIgdG8gbmV3IGhlbHBlcnMNCj4gICAgdGFyZ2V0L3BwYzogZXhwYW5kIGNv
bW1lbnQgb24gRlAvVk1YL1ZTWCBhY2Nlc3MgZnVuY3Rpb25zDQo+ICAgIHRhcmdldC9wcGM6
IG1ha2UgcHBjX21heWJlX2Jzd2FwX3JlZ2lzdGVyIHN0YXRpYw0KPiAgICB0YXJnZXQvcHBj
OiBjb252ZXJ0IGdkYnN0dWIgdG8gbmV3IGhlbHBlcnMNCj4gICAgdGFyZ2V0L21pY3JvYmxh
emU6IGNvbnZlcnQgZ2Ric3R1YiB0byBuZXcgaGVscGVyDQo+ICAgIGluY2x1ZGUvZ2Ric3R1
YjogYWRkIG5vdGUgdG8gaGVscGVycy5oDQo+IA0KPiAgIGluY2x1ZGUvZXhlYy9tZW1vcC5o
ICAgICAgICB8ICAgNCArLQ0KPiAgIGluY2x1ZGUvZ2Ric3R1Yi9jb21tYW5kcy5oICB8ICAg
MiArLQ0KPiAgIGluY2x1ZGUvZ2Ric3R1Yi9oZWxwZXJzLmggICB8ICAgNCArLQ0KPiAgIGlu
Y2x1ZGUvZ2Ric3R1Yi9yZWdpc3RlcnMuaCB8ICA1NSArKysrKysrKysrDQo+ICAgdGFyZ2V0
L3BwYy9jcHUuaCAgICAgICAgICAgIHwgICA4ICstDQo+ICAgZ2Ric3R1Yi9nZGJzdHViLmMg
ICAgICAgICAgIHwgIDI1ICsrKystDQo+ICAgdGFyZ2V0L2FybS9nZGJzdHViLmMgICAgICAg
IHwgIDU1ICsrKysrKy0tLS0NCj4gICB0YXJnZXQvYXJtL2dkYnN0dWI2NC5jICAgICAgfCAg
NTMgKysrKysrLS0tLQ0KPiAgIHRhcmdldC9taWNyb2JsYXplL2dkYnN0dWIuYyB8ICA0OSAr
KysrLS0tLS0NCj4gICB0YXJnZXQvcHBjL2dkYnN0dWIuYyAgICAgICAgfCAxOTcgKysrKysr
KysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tDQo+ICAgMTAgZmlsZXMgY2hhbmdlZCwg
MjkyIGluc2VydGlvbnMoKyksIDE2MCBkZWxldGlvbnMoLSkNCj4gICBjcmVhdGUgbW9kZSAx
MDA2NDQgaW5jbHVkZS9nZGJzdHViL3JlZ2lzdGVycy5oDQo+IA0KDQo=

