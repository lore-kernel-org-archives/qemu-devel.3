Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12406C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 17:10:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trgda-0001en-0b; Mon, 10 Mar 2025 13:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trgdD-0001ZK-L8
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 13:09:41 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trgd6-0000fK-BD
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 13:09:34 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-224171d6826so68341755ad.3
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 10:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741626560; x=1742231360; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ar2fDRYVLvzDtElaIHkq6rp/JBiCngd5o7ifJ3MEghM=;
 b=uvrXsq4z3sTOQqspAYjJZrxDyaLC9mWf/JWZOxky2gmcwbyCZrcRuVhoKSUeEj7p+H
 zlbCoBIVUovArisFOa1dVfRQbpjYgYYhAGHQxgfPzRtsxS4WHleP6y4TUHH2QoZl1u9m
 DTS+VKMXsFu2xP8ljHSePCEJ40lwa7dhmFLcGt55sQ1iSBo5QbAi46kj1dWazd0DOU8Y
 7A9h5/MwA62VZIDN3JSrnZmwwKrhWxPN7LQ4lWnexvbWTpt1U7qa8irwW4bY8soAeOpR
 GJoDviOhexmQ/d9A8/T0/El2Q10NfM6dp+G6yKOO38vd7I9tXcGKjYf6ypkwKYRH9ifW
 vvuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741626560; x=1742231360;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ar2fDRYVLvzDtElaIHkq6rp/JBiCngd5o7ifJ3MEghM=;
 b=BvQhplZqP+nbG+fzFq3XA8kuZyoM40BiD+NfPXirAnIinfO73rS86IpRMO09RaXXa7
 uUR0nKW0RE3UAd1jYwybmwR5pb0yWpAzijr0bQPRM8KmEFQjJ7asdUtFWoecRSLyQkEF
 blU6H9WJD4sgS6drT/i/60gRKEXKIV932C1NTa4I3hE4TnbUfMI1JEJTT4HLd0NCp9+p
 kxC1hWDow9Pmtg/8VIb5nwN3iDm/IDqm58kSrbJ/rIzSw46cmXlbdPMVHWmEiEQHDJjJ
 92MOv/y3L23n5d8TXGChx3aWZTGbBDXIFQxD4jtmDyHiXEDD9BtPEk/ypm6qS1eLnqMg
 W9kQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHQ921IZvdIOHEFst/8q90+2YbvpMTr386hwnIbsrBVhjnQEXpWZyJuHJHxAYx16H6EBZnhcltDzL/@nongnu.org
X-Gm-Message-State: AOJu0YzRTxix6+h1VTsZC//t5dg5Qu8iXJkdtCReUmHpBQQJVzTdYAFS
 QH7eg7GFvjIhnuTCjCVSKNu0hMPBMwsHjUZGAU/a6BbyTh1LCTD07F7X4fl+nf0=
X-Gm-Gg: ASbGncsaHA0lfRmo7gnFKi9Ol5EYV7e6On6M/pqbQaZY0jnLG+GKfpSNRrAr2A3xE4s
 7D9WQJxFOJD5eHpe0xgFC9NIEAuMuUrY70rKG9MjUaEZ1DiWn6Ip7bns0a7xqtwoDs4BOXvXhOi
 AreP43gzyngyvfvY8oBBbfmQ0/NW9kD5rudaDIDNPi5dd1VFOq1fw92x0DvmU2bDZaZPv8Q/HQc
 92/+CCHV+cupp3lH9jlGG1b5aiE1Juttt/+nav1OjMkFbTYuvlwQii8xIMfpWjNn4nTB2VmpL/I
 13Ddu5WobHxEavZPbAWPEYYl4c4zD0iEhWqJywMekfG98W/E0p4GprpBqg==
X-Google-Smtp-Source: AGHT+IEZx7yvI3cxwYSXRf6Drui3lVIq/g2e8BTdmkwMhIa1X1xLAPxc9N1ZtVCurWiE1pterDVHlw==
X-Received: by 2002:a17:902:f70c:b0:223:f408:c3e2 with SMTP id
 d9443c01a7336-2242888a8bbmr270719015ad.14.1741626559698; 
 Mon, 10 Mar 2025 10:09:19 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-224109de180sm80843005ad.46.2025.03.10.10.09.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 10:09:19 -0700 (PDT)
Message-ID: <4c2ee71d-6d7c-436d-8608-e4aec71c4df0@linaro.org>
Date: Mon, 10 Mar 2025 10:09:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/16] qemu/bswap: implement {ld,st}.*_p as functions
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
 <20250310045842.2650784-6-pierrick.bouvier@linaro.org>
 <4ac28725-33bc-4b29-a941-03784566d330@linaro.org>
 <6a0cd17e-1c76-4b2d-b781-ea7f438cc4b2@linaro.org>
 <6dc11a37-06d7-400a-b45e-a151d660eb6f@linaro.org>
 <15816b7b-f120-4235-a1a9-333bc0f69fe1@linaro.org>
 <e20b6a44-b371-4154-8dc9-5f3cb4a3f570@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <e20b6a44-b371-4154-8dc9-5f3cb4a3f570@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

T24gMy8xMC8yNSAwOTo1MywgUmljaGFyZCBIZW5kZXJzb24gd3JvdGU6DQo+IE9uIDMvMTAv
MjUgMDk6NDMsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBPbiAzLzEwLzI1IDA5OjM3
LCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90ZToNCj4+PiBPbiAzLzEwLzI1IDA5OjE0LCBQaWVy
cmljayBCb3V2aWVyIHdyb3RlOg0KPj4+PiBPbiAzLzEwLzI1IDA5OjA4LCBSaWNoYXJkIEhl
bmRlcnNvbiB3cm90ZToNCj4+Pj4+IE9uIDMvOS8yNSAyMTo1OCwgUGllcnJpY2sgQm91dmll
ciB3cm90ZToNCj4+Pj4+PiBGb3Igbm93LCB0aGV5IGFyZSBkdXBsaWNhdGUgb2YgdGhlIHNh
bWUgbWFjcm9zIGluIGNwdS1hbGwuaCB0aGF0IHdlDQo+Pj4+Pj4gZWxpbWluYXRlIGluIG5l
eHQgY29tbWl0Lg0KPj4+Pj4+DQo+Pj4+Pj4gS2VlcCBjb2RlIHJlYWRhYmxlIGJ5IG5vdCBk
ZWZpbmluZyB0aGVtIHdpdGggbWFjcm9zLCBidXQgc2ltcGx5IHRoZWlyDQo+Pj4+Pj4gaW1w
bGVtZW50YXRpb24uDQo+Pj4+Pj4NCj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBQaWVycmljayBC
b3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo+Pj4+Pg0KPj4+Pj4gV2h5
IGRvIHlvdSB3YW50IHRoZXNlIGluIGJzd2FwLmgsIHJhdGhlciB0aGFuIHRzd2FwLmg/DQo+
Pj4+PiBUaGV5J3JlIHRhcmdldCBzd2FwcywgYWZ0ZXIgYWxsLg0KPj4+Pj4NCj4+Pj4+DQo+
Pj4+PiByfg0KPj4+Pg0KPj4+PiBObyBwcmVmZXJlbmNlIG9uIHRoYXQsIEkgc2ltcGx5IGFk
ZGVkIHRoZW0gdG8gdGhlIHNhbWUgZmlsZSB0aGFuIHRoZWlyIGV4cGxpY2l0IGVuZGlhbm5l
c3MNCj4+Pj4gdmFyaWFudC4gV291bGQgeW91IHByZWZlciB0aGUgZW5kaWFubmVzcyBhZ25v
c3RpYyB2YXJpYW50IHRvIGJlIGluIHRzd2FwLmggaW5zdGVhZD8NCj4+Pg0KPj4+IEkgdGhp
bmsgSSB3b3VsZC4NCj4+DQo+PiBPaywgSSB3aWxsIG1vdmUgaXQuDQo+Pg0KPj4+DQo+Pj4g
SW4gYWRkaXRpb24sIEkgdGhpbmsgd2Ugd2FudA0KPj4+DQo+Pj4gI2lmZGVmIENPTVBJTElO
R19QRVJfVEFSR0VUDQo+Pj4gI2RlZmluZSB0YXJnZXRfd29yZHNfYmlnZW5kaWFuKCnCoCBU
QVJHRVRfQklHX0VORElBTg0KPj4+ICNlbHNlDQo+Pj4gYm9vbCB0YXJnZXRfd29yZHNfYmln
ZW5kaWFuKHZvaWQpOw0KPj4+ICNlbmRpZg0KPj4+DQo+Pj4gbW92aW5nIHRoZSBjb25kaXRp
b25hbCBmcm9tIGFyb3VuZCB0YXJnZXRfbmVlZHNfYnN3YXAganVzdCBiZWxvdy4NCj4+Pg0K
Pj4+IFdpdGggdGhhdCwgd2UgZWxpbWluYXRlIHRoZSBleHRyYSBicmFuY2ggdGhhdCB5b3Un
cmUgb3RoZXJ3aXNlDQo+Pj4gYWRkaW5nIHRvIHRhcmdldC1zcGVjaWZpYyBjb2RlIHdpdGgg
dGhpcyBwYXRjaC4NCj4+Pg0KPj4NCj4+IEkgdW5kZXJzdGFuZCB0aGUgY2hhbmdlIHJlcXVl
c3RlZCwgYnV0IHNob3VsZCB3ZSByZWFsbHkgYWltIGluIHRoYXQgZGlyZWN0aW9uPyBJbiB0
aGUgZW5kLA0KPj4gaWYgd2UgcHVyc3VlIHRoZSBjb21waWxhdGlvbiB1bml0cyBkZWR1cGxp
Y2F0aW9uLCB0aGUgYnJhbmNoIHdpbGwgYmUgcHJlc2VudCBhbnl3YXkuDQo+Pg0KPj4gSSdt
IG9rIHdpdGggeW91ciBjaGFuZ2UsIGp1c3QgYXNraW5nIGlmIHdlIHJlYWxseSB3YW50IHRv
IHByZXNlcnZlIHRhcmdldCBzcGVjaWZpYyBjb2RlDQo+PiB1bnRpbCB0aGUgImVuZCIuDQo+
IA0KPiBBbGwgb2YgdGFyZ2V0LyBpcyB0YXJnZXQgc3BlY2lmaWMuICBEZS1kdXBsaWNhdGlv
biB3aWxsIG5vdCBlbGltaW5hdGUgdGhhdC4NCj4gDQoNCk15IHZvY2FidWxhcnkgd2FzIHdy
b25nIGhlcmUuIEkgbWVhbnQgImlmIHdlIHdhbnQgdG8gcHJlc2VydmUgdGFyZ2V0IA0Kc3Bl
Y2lmaWMgbWFjcm9zIiB1bnRpbCB0aGUgZW5kLg0KU3VyZSwgdGhlcmUgd2lsbCBhbHdheXMg
YmUgY29tcGlsYXRpb24gdW5pdHMgKGRldmljZXMsIGNwdXMsIGhlbHBlcnMsIA0KLi4uKSBz
cGVjaWZpYyB0byBhIHRhcmdldC4gSSBqdXN0IHdvbmRlciBpZiBzdGlja2luZyB0byBpZmRl
ZiBwYXJhZGlnbSANCmZvciB0aGlzIGtpbmQgb2YgY29kZSBpcyB3b3J0aCB0aGUgIm9wdGlt
aXphdGlvbiIgd2UgYXJlIHN1cHBvc2VkIHRvIGdldC4NCg0KSSdsbCBhZGQgdGhlIGNoYW5n
ZSByZXF1ZXN0ZWQuDQoNCj4gDQo+IHJ+DQoNCg==

