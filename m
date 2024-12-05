Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBBDE7717A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 18:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJGCz-0008Pk-Vd; Thu, 05 Dec 2024 13:04:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJGCt-0008Nz-6m
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 13:04:07 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJGCq-00066g-8h
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 13:04:06 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21145812538so9984255ad.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 10:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733421842; x=1734026642; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MaAYbjNGW8R6NddESSFBtMvXX9rcH3zIWlg8fyl9/fQ=;
 b=nDkQx7q1shlfw0aMNt867LR4F5dIXvUrgnXOzZEnSGPsa+8JLzsigJ4No9DAENM1JI
 9fqKBRi19T/WuoJM0bwKuXvgE86Z0EJWXpy9Qa9hMVB813q3UN9A7147hJwbqPfvJvBY
 cqQGMYpVGjnBijhdyGIFV6b+dAKOFXmCGzSojOgWWTL1pyixtstS670Cd7Ut8Nnc83Je
 7a7TLeh/7B4WE4sCeXZSMBynKBeCZzsmKXvN+MLydR4dSRmyv3z0iWXWnCnRHhnfAav8
 0MSytzAFwzBJLf0FJ0XS4WbWJkpBJpOJt0DfLyVtYwfq4V9VANK3cY1+PEUX2Be+LR4M
 Ev5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733421842; x=1734026642;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MaAYbjNGW8R6NddESSFBtMvXX9rcH3zIWlg8fyl9/fQ=;
 b=QPsN9tNlI9M9XetCiMk99FmVghFF8daXyOd1FVzdpisX2SrU7nAsUNXk+SHFtNGm1Z
 ynOOpPIHPaHZlUxP4/HKLx0aF0R3FctGQy61ZnVRnxPpjztVovR+NITXcm7aL9skseqS
 GTR3mbX355v8AMjLLFQl61xfmjoEoDpgKCKxygkXSPphSiaEesh+uMLEZnrRZGl1ShNk
 Dy1amS6gF7dtYMdDNO7sHO/Ofhj4RiX9DOKr4Gj/8tlKledUcIBAeSOXY2CVFjT7Co/i
 tRB/BJzVPtCiBKBkE2rjn0xrW1hTK4OdxD+1UqeaQgmrgDGCgeTiILxhZo+xYMH+6baT
 tX2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVC90N5cCeh5lRermdwJvXBREtjDsMNPhf2+6/+jSZgmDvo1QOKHVX1ynbJ3rBN80JnsdEOoPKPws0j@nongnu.org
X-Gm-Message-State: AOJu0Yyc8pNlsMSkzHN7Jcqj9pnCd9Y5NexRvT3yDmH2cmIAVBrnDDXe
 zn8pCm7qi8QGCwR1ffIE47hs/fZcNA9GDJq5OTvHyzmZag1LW4kZ9ijp11yQnhc=
X-Gm-Gg: ASbGnctkyzFETzgjRyXO5/mCFSkguwThOSH9NW+bUSPeCJcPZMhj96ds3ZC9OdpWcng
 /RlLp4TXcgujHNCAg1KhS0j5FeGII10M8ViD9/wn4c14TFfRrzyu1UNDCDrkGeRcPg+mNlqBR6h
 XdtM3LMszTz+P5xQ1PyYzMTyAd8rRaI9dYgATKqYcIQSByh5bN9r4ALaozyyDZPqaeiysP8p1Dk
 v5L8o/MND/hv+1RuOAbVMDqYnX1svJUxGv3gjyTDchXyI8uLSNMTcZEdGXIP9EuBkPyEGqCkJLg
 Xswb+Zsnoly5cPmFaii6fg==
X-Google-Smtp-Source: AGHT+IF1teHSvazkGFlu4v9HhscF9eLqZQXCSYVDXOjTx9v1rL3bYc/ztHe8pt+0V31naoXsQEAtCQ==
X-Received: by 2002:a17:902:cec7:b0:215:3661:747e with SMTP id
 d9443c01a7336-215bcfc5c76mr123274415ad.8.1733421842116; 
 Thu, 05 Dec 2024 10:04:02 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215f8e61ef7sm15450595ad.95.2024.12.05.10.04.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 10:04:01 -0800 (PST)
Message-ID: <a9401d13-d23b-4d18-841e-4239e216168f@linaro.org>
Date: Thu, 5 Dec 2024 10:04:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] docs/system/arm/fby35: document execute-in-place
 property
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-arm@nongnu.org,
 Troy Lee <leetroy@gmail.com>, Peter Maydell <peter.maydell@linaro.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 alex.bennee@linaro.org, Alistair Francis <alistair@alistair23.me>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20241204203912.3037515-1-pierrick.bouvier@linaro.org>
 <20241204203912.3037515-3-pierrick.bouvier@linaro.org>
 <c2e4c538-2e0b-4882-8a92-6ff439cebd09@kaod.org>
 <3ba7dabb-67cf-450f-828c-5adf7332fc91@linaro.org>
 <96b027f9-3637-4416-9eba-a175635026ca@kaod.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <96b027f9-3637-4416-9eba-a175635026ca@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

T24gMTIvNS8yNCAwOToyOSwgQ8OpZHJpYyBMZSBHb2F0ZXIgd3JvdGU6DQo+IE9uIDEyLzUv
MjQgMTg6MDksIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBPbiAxMi81LzI0IDAwOjE4
LCBDw6lkcmljIExlIEdvYXRlciB3cm90ZToNCj4+PiBIZWxsbyBQaWVycmljaywNCj4+Pg0K
Pj4+IFRoYW5rcyBmb3IgaW1wcm92aW5nIHRoZSBkb2N1bWVudGF0aW9uICENCj4+Pg0KPj4+
IE9uIDEyLzQvMjQgMjE6MzksIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+Pj4+IFNpZ25l
ZC1vZmYtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9y
Zz4NCj4+Pj4gLS0tDQo+Pj4+ICDCoMKgIGRvY3Mvc3lzdGVtL2FybS9mYnkzNS5yc3QgfCAz
ICsrKw0KPj4+PiAgwqDCoCAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+Pj4+
DQo+Pj4+IGRpZmYgLS1naXQgYS9kb2NzL3N5c3RlbS9hcm0vZmJ5MzUucnN0IGIvZG9jcy9z
eXN0ZW0vYXJtL2ZieTM1LnJzdA0KPj4+PiBpbmRleCBiZjZkYTZiYWEyYS4uZWQ5ZmFlZjM2
M2MgMTAwNjQ0DQo+Pj4+IC0tLSBhL2RvY3Mvc3lzdGVtL2FybS9mYnkzNS5yc3QNCj4+Pj4g
KysrIGIvZG9jcy9zeXN0ZW0vYXJtL2ZieTM1LnJzdA0KPj4+PiBAQCAtNDUsMyArNDUsNiBA
QCBwcm9jZXNzIHN0YXJ0cy4NCj4+Pj4gIMKgwqDCoMKgwqDCoCAkIHNjcmVlbiAvZGV2L3R0
eTAgIyBJbiBhIHNlcGFyYXRlIFRNVVggcGFuZSwgdGVybWluYWwgd2luZG93LCBldGMuDQo+
Pj4+ICDCoMKgwqDCoMKgwqAgJCBzY3JlZW4gL2Rldi90dHkxDQo+Pj4+ICDCoMKgwqDCoMKg
wqAgJCAocWVtdSkgY8KgwqDCoMKgwqDCoMKgwqDCoMKgICMgU3RhcnQgdGhlIGJvb3QgcHJv
Y2VzcyBvbmNlIHNjcmVlbiBpcyBzZXR1cC4NCj4+Pj4gKw0KPj4+PiArVGhpcyBtYWNoaW5l
IG1vZGVsIHN1cHBvcnRzIGVtdWxhdGlvbiBvZiB0aGUgYm9vdCBmcm9tIHRoZSBDRU8gZmxh
c2ggZGV2aWNlIGJ5DQo+Pj4+ICtzZXR0aW5nIG9wdGlvbiBgYGV4ZWN1dGUtaW4tcGxhY2Vg
YC4NCj4+Pg0KPj4+IENvdWxkIHdlIGFkZCBhIGxpbmsgdG8gdGhlICJCb290IG9wdGlvbnMi
IHNlY3Rpb24gb2YgdGhlDQo+Pj4gIkFzcGVlZCBmYW1pbHkgYm9hcmRzIiBkb2N1bWVudCBp
bnN0ZWFkID8NCj4+Pg0KPj4NCj4+IFRoZSBwcm9ibGVtIGlzIHRoYXQgdGhlIGFzcGVlZCBi
b2FyZCBoYXMgb3RoZXIgb3B0aW9ucyAoZm1jLW1vZGVsLCBzcGktbW9kZWwpLCBzbyBpdCB3
b3VsZCBiZSBjb25mdXNpbmcgZm9yIHRoZSByZWFkZXIuDQo+IA0KPiBvay4gSnVzdCB0byBj
bGFyaWZ5LCB0aGUgQXNwZWVkIG1hY2hpbmVzIGFsd2F5cyBib290IGZyb20gQ0UwIChpZiB5
b3UNCj4gZXhjbHVkZSByYWluaWVyKS4NCj4gDQoNCk9rLCBJIHdhcyBub3QgYXdhcmUgb2Yg
dGhhdC4NCkknbSBub3QgZmFtaWxpYXIgd2l0aCB0aG9zZSBtYWNoaW5lIG1vZGVscywgYW5k
IGp1c3QgaGF2ZSBiZWVuIGEgDQpkb2N1bWVudGF0aW9uIHVwZGF0ZXIgaGVyZSwgc28gbXkg
a25vd2xlZGdlIGlzIGxpbWl0ZWQuDQoNCj4gV2l0aCB0aGUgImV4ZWN1dGUtaW4tcGxhY2Ui
IG9wdGlvbiwgdGhlIENQVSBmZXRjaGVzIGluc3RydWN0aW9ucyB0bw0KPiBleGVjdXRlIGJ5
IHJlYWRpbmcgQ0UwIGFuZCBub3QgZnJvbSBhIHByZWxvYWRlZCBST00gaW5pdGlhbGl6ZWQg
YXQNCj4gbWFjaGluZSBpbml0IHRpbWUuIEkgdGhpbmsgaXQgaXMgZ29vZCB0byBtZW50aW9u
IHRoZSBkaWZmZXJlbmNlIGFuZA0KPiB0aGUgaW1wYWN0IG9uIHBlcmZvcm1hbmNlIDogSXQg
aXMgbW9yZSBhY2N1cmF0ZSBtb2RlbGluZyBidXQgc2xvd2VyLg0KPiANCg0KSSdsbCBhZGQg
dGhpcy4NCg0KVGhpcyBtYWNoaW5lIG1vZGVsIHN1cHBvcnRzIGVtdWxhdGlvbiBvZiB0aGUg
Ym9vdCBmcm9tIHRoZSBDRTAgZmxhc2ggDQpkZXZpY2UgYnkgc2V0dGluZyBvcHRpb24gYGBl
eGVjdXRlLWluLXBsYWNlYGAuIFdoZW4gdXNpbmcgdGhpcyBvcHRpb24sIA0KdGhlIENQVSBm
ZXRjaGVzIGluc3RydWN0aW9ucyB0byBleGVjdXRlIGJ5IHJlYWRpbmcgQ0UwIGFuZCBub3Qg
ZnJvbSBhIA0KcHJlbG9hZGVkIFJPTSBpbml0aWFsaXplZCBhdCBtYWNoaW5lIGluaXQgdGlt
ZS4gQXMgYSByZXN1bHQsIGV4ZWN1dGlvbiANCndpbGwgYmUgc2xvd2VyLg0KDQpJcyB0aGF0
IG9rIGZvciB5b3U/DQoNCj4+IEl0J3Mgd29ydGggcmVwZWF0aW5nIHdoYXQgdGhlIG9wdGlv
biBtZWFucyBJTUhPLg0KPiANCj4gc3VyZS4gbnAuDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBD
Lg0KDQo=

