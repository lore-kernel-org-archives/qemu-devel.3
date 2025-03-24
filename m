Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF360C36008
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 19:31:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twnUn-0007qU-G6; Mon, 24 Mar 2025 15:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twnUc-0007ph-U9
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 15:29:53 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twnUb-0005Z8-Ba
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 15:29:50 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-227b828de00so28982335ad.1
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 12:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742844588; x=1743449388; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1gUOcoZKrG0/H247Yd/mAPl9poiLhT/i9E2w+eB/X+g=;
 b=QUwV3ZZ0OxJqd7Ox8xGQWfGpyrCsWHs8Tgo1wS6fcHfD9CBGnaTJ/yy0g7r2DG5eXZ
 QD1J+LRtXf9+8uYAl2IYzlvhmhc3ocRCUojVKZ/Ie5DWx6rLwSlz1WvaM+Y65+pirbZy
 gE3185HBs8vzcRuY2L3bycZxi7PIo4fqxcJrXXS16jROf9rES2Ye84E2ELFsSEzjSj/S
 bAj75b7IWlIv6YOWjkMx91+UkiLpvDNvPQsjvER6qxznwMnPV7S5EgUzqOfJBBGRmrZU
 Q2od9SRpodJqc9sDFFD3MMc+SsVDXJZmK+jgKtE2jpPkT6aM4LVRCZd+OcRNMaI3iC3U
 e/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742844588; x=1743449388;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1gUOcoZKrG0/H247Yd/mAPl9poiLhT/i9E2w+eB/X+g=;
 b=QjjUhlEOhiqZ+vxzy/OPg5fxcMzNxcs7UgyKLbAvkXm8Yf0roc91z210c2AJEGUWct
 IDDqti56Y3xHJX0OuCc2mi1vj7EF7Cl10s6x/KLHIMr3g+f82sum4JjBAAEECtR/G4Ib
 uS5RBZYAm9gprS+qC5qEGK7tXkt8fSNKcMDzzFabT4WqSQvm5Kai2Y6zk3rFp0HeEt5h
 s4o5FAsUZvulF8LD3AyiOE93HhxeqJQv1IdS3pHoGUt1e1HQ+IH92FpodEIn75KEZCjS
 bQBu7hov+kPgba17Vo1z14VwDWtbEzxXOg4GfhOjKv6sjedV4Tu366EWBEBowSwOxooL
 160g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7qYpaimuvwCFonD+cq3tNmgPrNz6oda8pid7cSWprf4LKYs90IekcilhJZ7SGlJ0dl/tgowwRbXXa@nongnu.org
X-Gm-Message-State: AOJu0YywJUAjRDy/fQ7agvzTRS60EdcnEDKOezD6BF2/StzL7EK439ny
 +YhSvWuZ/A5t01MYkjS50Gh5C5tYSKkfwrYQpwTCb+RuSfcnWayze7aXB9wz1+s=
X-Gm-Gg: ASbGncvTJzQD7EbsQm+BnUQp33cxuFwi7UTMXFKGSd+wm8rNXmMebRg+RW8mAu7dPlw
 LsAmkPmT6l+mWJIEkxY0VLlITXgwxbfatAH1idCVloDp8pGCPIb4MhBTWNAtL6WQTz5pKYqULXp
 3aMBH6TQeqZJa/YJscEmRrRiCPFdkEvX5AMfokM9iFk9/u/DaCJqKGJt4guT/vI6sluanAGBj0r
 KfsfmwNxhPW2s5XhEUd8bI/DMBL1RDnRfhXge9mfmeR/qKL9sB1cUWhgA1ev2SvmQ2J+MHfRwqy
 G/WAig9wXHHTpD9WsHMWIcyonNqHhhxF177/ph/T/df3g0lKIyLReE7YUQ==
X-Google-Smtp-Source: AGHT+IGGYsjhX7I7RU76Us6G+2Nch1LnIuc5jadip1mEvQxLqxby8JHpciyNivOWWbUIAH2SajLwVw==
X-Received: by 2002:a17:902:ecc4:b0:224:1ec0:8a0c with SMTP id
 d9443c01a7336-22780da4003mr222366165ad.29.1742844587546; 
 Mon, 24 Mar 2025 12:29:47 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811bd195sm74815175ad.132.2025.03.24.12.29.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 12:29:47 -0700 (PDT)
Message-ID: <7a60e516-e224-4766-830d-20e14bba3c8e@linaro.org>
Date: Mon, 24 Mar 2025 12:29:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/11] target/ppc: convert gdbstub to new helpers
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-ppc@nongnu.org,
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
 <20250324102142.67022-10-alex.bennee@linaro.org>
 <c99b4b18-2222-4868-9e2d-78305e530663@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <c99b4b18-2222-4868-9e2d-78305e530663@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

T24gMy8yNC8yNSAxMDozOSwgUmljaGFyZCBIZW5kZXJzb24gd3JvdGU6DQo+IE9uIDMvMjQv
MjUgMDM6MjEsIEFsZXggQmVubsOpZSB3cm90ZToNCj4+ICsgICAgI2lmZGVmIFRBUkdFVF9C
SUdfRU5ESUFODQo+PiArICAgIE1lbU9wIGVuZCA9IE1PX0JFOw0KPj4gKyAgICAjZWxzZQ0K
Pj4gKyAgICBNZW1PcCBlbmQgPSBNT19MRTsNCj4+ICsgICAgI2VuZGlmDQo+PiArI2VuZGlm
DQo+IA0KPiBUaGF0J3Mgd2hhdCBNT19URSBpcyBmb3IuDQo+IA0KPj4gKy8qDQo+PiArICog
SGVscGVycyBjb3BpZWQgZnJvbSBoZWxwZXJzLmgganVzdCBmb3IgaGFuZGxpbmcgdGFyZ2V0
X3Vsb25nIHZhbHVlcw0KPj4gKyAqIGZyb20gZ2Ric3R1YidzIEdCeXRlQXJyYXkgYmFzZWQg
b24gd2hhdCB0aGUgYnVpbGQgY29uZmlnIGlzLiBUaGlzDQo+PiArICogd2lsbCBuZWVkIGZp
eGluZyBmb3Igc2luZ2xlLWJpbmFyeS4NCj4+ICsgKi8NCj4+ICsNCj4+ICsjaWYgVEFSR0VU
X0xPTkdfQklUUyA9PSA2NA0KPj4gKyNkZWZpbmUgbGR0dWxfcChhZGRyKSBsZHFfcChhZGRy
KQ0KPj4gKyNkZWZpbmUgZ2RiX2dldF9yZWdsX3ZhbHVlKG0sIGIsIHYpIGdkYl9nZXRfcmVn
NjRfdmFsdWUobSwgYiwgdikNCj4+ICsjZWxzZQ0KPj4gKyNkZWZpbmUgbGR0dWxfcChhZGRy
KSBsZGxfcChhZGRyKQ0KPj4gKyNkZWZpbmUgZ2RiX2dldF9yZWdsX3ZhbHVlKG0sIGIsIHYp
IGdkYl9nZXRfcmVnMzJfdmFsdWUobSwgYiwgdikNCj4+ICsjZW5kaWYNCj4gDQo+IFN1cmVs
eSB5b3UncmUgbm90IGludGVuZGluZyB0byByZXBsaWNhdGUgdGhpcyBpbiBhbnkgdGFyZ2V0
IHRoYXQgY2FuIGhhdmUgbXVsdGlwbGUgc2l6ZXM/DQo+IFRoaXMgaXMgbm90IGFuIGltcHJv
dmVtZW50Lg0KPiANCg0KSWYgSSdtIGNvcnJlY3QgKGFuZCBmcm9tIHYxKSwgcHBjIGlzIHRo
ZSBvbmx5IGFyY2hpdGVjdHVyZSBoYXZpbmcgDQpyZWdpc3RlcnMgZGVmaW5lZCB3aXRoIHRh
cmdldF9sb25nIHR5cGVzLg0KDQpTbyBhdCB0aGUgdGltZSBJIHN1Z2dlc3RlZCB0byBlaXRo
ZXIgbW92ZSB0aGUgbWFjcm8gZGVmaW5pdGlvbiBpbiBhIA0KaGVhZGVyIChoZWxwZXJzLXRh
cmdldC5oKSBhbmQgZGVhbCB3aXRoIHBwYyBsYXRlciwgb3IgcmVwbGFjZSBwcGMgDQpyZWdp
c3RlcnMgZGVmaW5pdGlvbiwgd2hpY2ggaXMgc3VyZWx5IG1vcmUgY29tcGxpY2F0ZWQgdG8g
ZG8gYXQgdGhlIG1vbWVudC4NCg0KTW92aW5nIG1hY3JvIGRlZmluaXRpb24gZGlyZWN0bHkg
aW4gdGhpcyBmaWxlIChpZiBpdCdzIHJlYWxseSB0aGUgb25seSANCm9uZSBuZWVkaW5nIGl0
KSBpcyBvayBmb3IgbWUgYXMgd2VsbC4NCg0KPiANCj4gcn4NCg0K

