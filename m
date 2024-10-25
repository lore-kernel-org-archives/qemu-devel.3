Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5531D149E8
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 19:34:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Q47-0002H1-7z; Fri, 25 Oct 2024 15:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t4Q46-0002Gs-Em
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 15:33:42 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t4Q44-0005S5-SY
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 15:33:42 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-208cf673b8dso21147225ad.3
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 12:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729884819; x=1730489619; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=goD0f+AQMVIxHUzPE+CFK5b34QvMUXgPi1YqdiwIaMw=;
 b=yj/fTMgpR0NlM01G1qggUdBVZDrOETx4rbYtiBFTSUIA1HPUlbP6/cOt/fzi1+FnuH
 ubIoMmlU/7ZPMa1hNN/fcv7oSvFnvMU+ljNfGdbvOA6o/Nfa0ioU4a7Fr55FTFiJJkAg
 fMFhHrfBPKmmTBfrDhTYJMjUbOL9KhyBxzE4XsHw5k9Y29caq0wVJJfyYkpzimsM0Cfl
 W0C4ytHbqBNlhOg6NufXZ3i6zSqXrHnkKhSrmkv+STki602j9489Ve3KYhj3Ar5VvXRe
 CadXATx3QzXa9mJ2v05nQju+3+RDejRyZ4QGG5no1kdAo+HT+D4IdeuDE6ZRx0H8xLuw
 siiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729884819; x=1730489619;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=goD0f+AQMVIxHUzPE+CFK5b34QvMUXgPi1YqdiwIaMw=;
 b=aI9XXwQd1k/+KPJrKPeg67CeSQAJc2jew2I0mCp77yUBw7x0pu1oWXnIov5zDeqDjm
 XdmH2BO31nNHNGjIJCgL7jIrb2SE+qhDiMt5QtBS6x1FrOEiHuMcAR4rNfH2dCpoP4i7
 dtI1SCWkNVtmRNoh13TzThA73PM+epu+30XCEyRTHKnDjBzYzEfMKq4mwuTMlq5pvehg
 3CXlIuS+InK6oeUAF5BqCOUakemukbSMozHxqHi3s5PFGCBFzWerUKZnIUqA48KwBLQc
 m52NLopaKgSSutVo+ZyROyxwmDon5OWdPEYdpgqwv6ekJzjtT32N0JU2EItBZ+afvdko
 wuBg==
X-Gm-Message-State: AOJu0Yx/JlHR8FksvxrV1n5TJU+2mKpBC0G7saqHiboV4FR/J8eo7Y2O
 4hLyija6JhqFQYSYuLxqsfsh1xoZAllNjTsS12fElOBUoMv6Q2aqhE4LYUFisBQ=
X-Google-Smtp-Source: AGHT+IElWWE9qNDaxP5NzNMzEjtb1OGtit7mbEuid4M4ankGRilFjfVu4LGGyEnK79QMe588hqvObA==
X-Received: by 2002:a17:903:230e:b0:20c:bf43:938e with SMTP id
 d9443c01a7336-210c68d3ee4mr3193965ad.15.1729884819385; 
 Fri, 25 Oct 2024 12:33:39 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-210bc066488sm12644755ad.277.2024.10.25.12.33.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 12:33:38 -0700 (PDT)
Message-ID: <55e547b1-0c6f-41cd-ad61-86b53fe1f1cb@linaro.org>
Date: Fri, 25 Oct 2024 12:33:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/23] ci: enable rust in the Debian and Ubuntu system
 build job
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Junjie Mao <junjie.mao@hotmail.com>,
 "P. Berrange, Daniel" <berrange@redhat.com>
References: <20241025160209.194307-1-pbonzini@redhat.com>
 <20241025160209.194307-24-pbonzini@redhat.com>
 <8b1fc9e7-7387-4386-b759-9c15873a1bd1@linaro.org>
 <CABgObfYtjfv0N3mwT4OzYFrcMujxmgQcsFkuRAQDOEPvx06NWA@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CABgObfYtjfv0N3mwT4OzYFrcMujxmgQcsFkuRAQDOEPvx06NWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

T24gMTAvMjUvMjQgMTI6MjcsIFBhb2xvIEJvbnppbmkgd3JvdGU6DQo+IA0KPiANCj4gSWwg
dmVuIDI1IG90dCAyMDI0LCAyMDo1NSBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2
aWVyQGxpbmFyby5vcmcgDQo+IDxtYWlsdG86cGllcnJpY2suYm91dmllckBsaW5hcm8ub3Jn
Pj4gaGEgc2NyaXR0bzoNCj4gDQo+ICAgICBPbiAxMC8yNS8yNCAwOTowMiwgUGFvbG8gQm9u
emluaSB3cm90ZToNCj4gICAgICA+IFdlIGhhdmUgZml4ZWQgYWxsIGluY29tcGF0aWJpbGl0
aWVzIHdpdGggb2xkZXIgdmVyc2lvbnMgb2YgcnVzdGMNCj4gICAgICA+IGFuZCBiaW5kZ2Vu
LsKgIEVuYWJsZSBSdXN0IG9uIERlYmlhbiB0byBjaGVjayB0aGF0IHRoZSBtaW5pbXVtDQo+
ICAgICAgPiBzdXBwb3J0ZWQgdmVyc2lvbiBvZiBSdXN0IGlzIGluZGVlZCAxLjYzLjAsIGFu
ZCAwLjYwLnggZm9yIGJpbmRnZW4uDQo+ICAgICAgPg0KPiAgICAgID4gU2lnbmVkLW9mZi1i
eTogUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbQ0KPiAgICAgPG1haWx0bzpw
Ym9uemluaUByZWRoYXQuY29tPj4NCj4gICAgICA+IC0tLQ0KPiAgICAgID7CoCDCoC5naXRs
YWItY2kuZC9idWlsZHRlc3QueW1sIHwgNCArKy0tDQo+ICAgICAgPsKgIMKgMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gICAgICA+DQo+ICAg
ICAgPiBkaWZmIC0tZ2l0IGEvLmdpdGxhYi1jaS5kL2J1aWxkdGVzdC55bWwgYi8uZ2l0bGFi
LWNpLmQvYnVpbGR0ZXN0LnltbA0KPiAgICAgID4gaW5kZXggYWJhNjVmZjgzM2EuLjhkZWFm
OTYyN2NiIDEwMDY0NA0KPiAgICAgID4gLS0tIGEvLmdpdGxhYi1jaS5kL2J1aWxkdGVzdC55
bWwNCj4gICAgICA+ICsrKyBiLy5naXRsYWItY2kuZC9idWlsZHRlc3QueW1sDQo+ICAgICAg
PiBAQCAtNDAsNyArNDAsNyBAQCBidWlsZC1zeXN0ZW0tdWJ1bnR1Og0KPiAgICAgID7CoCDC
oCDCoCDCoGpvYjogYW1kNjQtdWJ1bnR1MjIwNC1jb250YWluZXINCj4gICAgICA+wqAgwqAg
wqB2YXJpYWJsZXM6DQo+ICAgICAgPsKgIMKgIMKgIMKgSU1BR0U6IHVidW50dTIyMDQNCj4g
ICAgICA+IC3CoCDCoCBDT05GSUdVUkVfQVJHUzogLS1lbmFibGUtZG9jcw0KPiAgICAgID4g
K8KgIMKgIENPTkZJR1VSRV9BUkdTOiAtLWVuYWJsZS1kb2NzIC0tZW5hYmxlLXJ1c3QNCj4g
ICAgICA+wqAgwqAgwqAgwqBUQVJHRVRTOiBhbHBoYS1zb2Z0bW11IG1pY3JvYmxhemVlbC1z
b2Z0bW11IG1pcHM2NGVsLXNvZnRtbXUNCj4gICAgICA+wqAgwqAgwqAgwqBNQUtFX0NIRUNL
X0FSR1M6IGNoZWNrLWJ1aWxkDQo+ICAgICAgPg0KPiAgICAgID4gQEAgLTcxLDcgKzcxLDcg
QEAgYnVpbGQtc3lzdGVtLWRlYmlhbjoNCj4gICAgICA+wqAgwqAgwqAgwqBqb2I6IGFtZDY0
LWRlYmlhbi1jb250YWluZXINCj4gICAgICA+wqAgwqAgwqB2YXJpYWJsZXM6DQo+ICAgICAg
PsKgIMKgIMKgIMKgSU1BR0U6IGRlYmlhbg0KPiAgICAgID4gLcKgIMKgIENPTkZJR1VSRV9B
UkdTOiAtLXdpdGgtY29yb3V0aW5lPXNpZ2FsdHN0YWNrDQo+ICAgICAgPiArwqAgwqAgQ09O
RklHVVJFX0FSR1M6IC0td2l0aC1jb3JvdXRpbmU9c2lnYWx0c3RhY2sgLS1lbmFibGUtcnVz
dA0KPiAgICAgID7CoCDCoCDCoCDCoFRBUkdFVFM6IGFybS1zb2Z0bW11IGkzODYtc29mdG1t
dSByaXNjdjY0LXNvZnRtbXUgc2g0LXNvZnRtbXUNCj4gICAgICA+wqAgwqAgwqAgwqAgwqBz
cGFyYy1zb2Z0bW11IHh0ZW5zYS1zb2Z0bW11DQo+ICAgICAgPsKgIMKgIMKgIMKgTUFLRV9D
SEVDS19BUkdTOiBjaGVjay1idWlsZA0KPiANCj4gICAgIERvIHlvdSB0aGluayBpdCBjb3Vs
ZCBiZSB2YWx1YWJsZSB0byBoYXZlIGEgdGhpcmQgam9iIGZvciBSdXN0IHdpdGg6DQo+ICAg
ICAtIHVidW50dTIyMDQgb3IgZGViaWFuIHdpdGggbGF0ZXN0IHJ1c3RjL2NhcmdvL2JpbmRn
ZW4sIHNvIHdlIG1heQ0KPiAgICAgZGV0ZWN0DQo+ICAgICByZWdyZXNzaW9ucyB3aGVuIHRo
b3NlIGFyZSB1cGRhdGVkLg0KPiANCj4gDQo+IE5vdGUgdGhhdCBhcGFydCBmcm9tIHRoZXNl
IHR3byBqb2JzIHdlIGhhdmUgRmVkb3JhIHdpdGggcnVzdHVwLWluc3RhbGxlZCANCj4gbmln
aHRseSAoaW4gbWFzdGVyKSBhbmQgRmVkb3JhIHdpdGggZGlzdHJvIFJ1c3QgdG9vbCBjaGFp
biAocGF0Y2hlcyANCj4gcG9zdGVkKS4gV291bGQgdGhhdCBwcm92aWRlIHRoZSBzYW1lIChv
ciBzaW1pbGFyIGVub3VnaCkgc2NlbmFyaW8/DQo+IA0KDQpJdCBjb3ZlcnMgdGhlIG5lZWQg
eWVzLg0KU2luY2Ugd2UgZG9uJ3QgbmVlZCBhbnkgbmlnaHRseSBmZWF0dXJlIHRvIGJ1aWxk
IHRoZSBjb2RlLCBtYXliZSB3ZSANCmNvdWxkIHRhcmdldCBsYXN0IHN0YWJsZSBpbnN0ZWFk
Lg0KRm9yIGZlZG9yYSB2cyB1YnVudHUvZGViaWFuLCBJIGRvbid0IGhhdmUgYW55IHN0cm9u
ZyBvcGluaW9uLg0KDQo+IFBhb2xvDQo+IA0KPiANCj4gICAgIFRoaXMgd2F5LCB3ZSB3b3Vs
ZCB0ZXN0ICgyMjA0ICsgbWluLCBkZWJpYW4gKyBtaW4sIGxhdGVzdCksIHdoaWNoDQo+ICAg
ICBzaG91bGQNCj4gICAgIGVuc3VyZSBSdXN0IGNvZGUgd2lsbCBidWlsZCBjb3JyZWN0bHkg
b24gb2xkZXIgYW5kIG5ld2VyIHN5c3RlbXMuDQo+IA0KPiAgICAgUGllcnJpY2sNCj4gDQo=


