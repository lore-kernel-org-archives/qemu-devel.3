Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D347FC98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 15:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9OxW-0002gq-0B; Wed, 23 Sep 2026 11:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1x9OxU-0002gh-Ep
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 11:32:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1x9OxS-0007SU-FE
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 11:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790177548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gmCqkw2syoISQfO25eqYofziPfT/MN13qZO8+jzu+7o=;
 b=hT9jttbIkBm7h3ZI0yU4VnS3/DJ46UQKlpThUmdvhXmkR3LOrcVdi8Mj7XJzYGPfHbT8Ki
 WAlEba6dYMtHlWS62HQG7LduUv6kiyd4+DLx3UKBzl1AEtEu4/UMrXio7A7Htt9P25Y1Du
 XPrWBM2x3KijVXu5DF4VS99Nsxnh5vU=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-FpaWP8EfN5ecHltK0cOpJw-1; Wed, 23 Sep 2026 11:32:27 -0400
X-MC-Unique: FpaWP8EfN5ecHltK0cOpJw-1
X-Mimecast-MFC-AGG-ID: FpaWP8EfN5ecHltK0cOpJw_1790177546
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-892be308859so24522077b3.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 08:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790177546; x=1790782346; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gmCqkw2syoISQfO25eqYofziPfT/MN13qZO8+jzu+7o=;
 b=FeFTuQzS2Ygt6N5d6Y+BGsZMXVyfLCXsBIVMGBHpMBKka9cMSiXnUcIMN9x4k1G0Es
 k3k5cUozs0Cm+nxaHhCFL8A6fKDgopKExT2iiYMPTVlh94jZLGBZ9UnR/qR/OFzNMN2I
 DKHyRpHylGskGV5A++0xYOPzKy3o0JMeTaJqZmE46cDgQUImvI1xZX0aPENYqVR9vcQW
 PoIBy8u8iKssTu5VCNyL9HdoJ3Vu4AHa5QxThoDiS6u/dwOoTXUnbXQnmvtC1QuFDWUy
 RF5ER64kW/keQg1dEp3O0ADhRYq+sUvWc/E2+VFxJYHrdTYsuBb54NlIj0T19oOPGBtg
 eS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790177546; x=1790782346;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gmCqkw2syoISQfO25eqYofziPfT/MN13qZO8+jzu+7o=;
 b=iBrTfhzr1kPdV6lmMjBm6BxPoEHpoeq6la4Hmn0L4YNj9tB4z+dL2WuoTnp4EEB3kg
 XrF48A0rvl3jPIB20WJd50l7oME8YkIaf2C+aWObf+Qr1hkKXYErfB7cqx/UZwcoTWYE
 wwG8wTENlWEhqHbz/7400ooU3kvEg3+0sU5KuhTFTe13Z05qq99lndojqZGzfQIi2/uN
 V/8ilsdfbLb/hfzHyUQ4T+ab/Gwb1TiQqIKVWKSTXJp1m3aAn8ARQWKShpZv6OzafKij
 Z6o8MX9raJvjBXleFBHn7uaTHpMX/kQznvWwFVXjnVmBxQkAjtgCNFaMRmktUHyKIKWg
 pUog==
X-Forwarded-Encrypted: i=1;
 AKwUvBwrIj+pEh5dj5hXPp/nrEenkmHC+lmoCDs4rCi2G4mo4axIBSz4jKIwCOWdh5Hfnz6ykJ9FU4uBHycK@nongnu.org
X-Gm-Message-State: AFuF++m3i82T7l+TQvbdeS5Mo4/IT33NtzJS4EeeKf+V8kW4a1VIAWzQ
 xRxbPhzKJbyrvCB0RzNB2JHBs5A1lcYkw25nEXijORTTJDnGERe7wh/ld+8/6zq/PEUidEhCkbT
 8c8fV7D43vFgxp7q9BUdzTmIUPlBiEO+WcBTd7ogLA1BjcuyY/+2WGUXj
X-Gm-Gg: AYBFou2gNYTJsCoSRWFY5DKk4j2k6Ri+fux2d6UuT/psoJmXV8y28xbm/0xKwKr9gc/
 aEtapUPstDQO3qHuYfsdYG5u6sIT6WVmYDF7biDqrWA1FeozPla3oPoUpUutCGfK+pOilisYnWp
 pBD1ZyaLggmAyBitzIOgljSIG8mH4eiRiyOPA8NrqsEEZ95jK6YYHzaG47escG2Xcz+GBOJxdm4
 wubejBEpEbbW8mF9HxWebHMtVD70v3kzuslWcCh1st6x/ZLRLZHewkRb2WHcvvutGqLf4dGpB5b
 GgvH72hxd+dsi3HKUJJrUrj+UNTzNMfQSiSbhUMD2A6RRgSmYaRAgHO9YJWQRx9DZN15a5hjNqC
 AlwbC7TWQI/zVAV4vO9vGwfysDoivEr+tD6d7pUUnGdeW0sO55IvWbN36NEfYS4YTBuRP7e8r5p
 cCR9hv70U4
X-Received: by 2002:a05:690c:34c9:b0:89a:63bc:8d7 with SMTP id
 00721157ae682-8a45d3d1e10mr15939627b3.97.1790177546279; 
 Wed, 23 Sep 2026 08:32:26 -0700 (PDT)
X-Received: by 2002:a05:690c:34c9:b0:89a:63bc:8d7 with SMTP id
 00721157ae682-8a45d3d1e10mr15939167b3.97.1790177545667; 
 Wed, 23 Sep 2026 08:32:25 -0700 (PDT)
Received: from mlevitsk-thinkpadt14gen3.ibmmarkh.csb
 (pool-173-33-204-162.cpe.net.cable.rogers.com. [173.33.204.162])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-532eb212b33sm21865441cf.15.2026.09.23.08.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 08:32:25 -0700 (PDT)
Message-ID: <8fd04ba4a6076feca2c2fc02c56dde56ab4dc0fa.camel@redhat.com>
Subject: Re: [PATCH] system: fix buffer overflow in tdx_parse_panic_message
From: "mlevitsk@redhat.com" <mlevitsk@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Mauro Matteo Cascella <mcascell@redhat.com>, Jordy Zomer
 <jordyzomer@google.com>
Date: Wed, 23 Sep 2026 11:32:24 -0400
In-Reply-To: <d92766bd-b542-477f-9caa-c09978080858@redhat.com>
References: <20260923004553.100732-1-mlevitsk@redhat.com>
 <d92766bd-b542-477f-9caa-c09978080858@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
MIME-Version: 1.0
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

T24gV2VkLCAyMDI2LTA5LTIzIGF0IDE2OjM2ICswMjAwLCBQYW9sbyBCb256aW5pIHdyb3RlOgo+
IE9uIDkvMjMvMjYgMDI6NDUsIE1heGltIExldml0c2t5IHdyb3RlOgo+ID4gdGR4X3BhcnNlX3Bh
bmljX21lc3NhZ2UgaGFzIGNvZGUgdGhhdCBkZXRlY3RzIGlmIHRoZSBndWVzdCBzdXBwbGllZAo+
ID4gbWVzc2FnZSBjb250YWlucyBzb21lIHVucHJpbnRhYmxlIGNoYXJhY3RlcnMgYW5kIGluIHRo
aXMgY2FzZSBwcmludHMgYSBoZXggZHVtcC4KPiA+IAo+ID4gVGhlIGNvZGUgaGFzIGEgYnVnOiBp
dCBhbGxvY2F0ZXMgMyBieXRlcyBmb3IgJ3NwcmludGYoIiUwMnggIiknLAo+ID4gYnV0IHNwcmlu
dGYgaW4gdGhpcyBjYXNlIGFjdHVhbGx5IHdyaXRlcyA0IGJ5dGVzLCBiZWNhdXNlIGl0IGFkZHMg
dGhlIE5VTEwKPiA+IHRlcm1pbmF0b3IuCj4gPiAKPiA+IFRvIGZpeCB0aGlzLCBqdXN0IHVzZSBx
ZW11X2hleGR1bXBfbGluZSBpbnN0ZWFkLgo+ID4gVGhpcyBwYXRjaCB3YXMgb25seSBjb21waWxl
IHRlc3RlZC4KPiA+IAo+ID4gUmVwb3J0ZWQtYnk6IEpvcmR5IFpvbWVyIDxqb3JkeXpvbWVyQGdv
b2dsZS5jb20+Cj4gPiBSZXNvbHZlczogaHR0cHM6Ly9naXRsYWIuY29tL3FlbXUtcHJvamVjdC9x
ZW11Ly0vd29ya19pdGVtcy8zOTA1Cj4gPiBTaWduZWQtb2ZmLWJ5OiBNYXhpbSBMZXZpdHNreSA8
bWxldml0c2tAcmVkaGF0LmNvbT4KPiA+IC0tLQo+ID4gwqAgc3lzdGVtL3J1bnN0YXRlLmMgfCAz
NSArKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ID4gwqAgMSBmaWxlIGNoYW5n
ZWQsIDcgaW5zZXJ0aW9ucygrKSwgMjggZGVsZXRpb25zKC0pCj4gPiAKPiA+IGRpZmYgLS1naXQg
YS9zeXN0ZW0vcnVuc3RhdGUuYyBiL3N5c3RlbS9ydW5zdGF0ZS5jCj4gPiBpbmRleCBkM2U2NGQy
YjYyNTguLmViZjA5YjE5MmI0ZSAxMDA2NDQKPiA+IC0tLSBhL3N5c3RlbS9ydW5zdGF0ZS5jCj4g
PiArKysgYi9zeXN0ZW0vcnVuc3RhdGUuYwo+ID4gQEAgLTUwLDYgKzUwLDcgQEAKPiA+IMKgICNp
bmNsdWRlICJxZW11L3NvY2tldHMuaCIKPiA+IMKgICNpbmNsdWRlICJxZW11L3RpbWVyLmgiCj4g
PiDCoCAjaW5jbHVkZSAicWVtdS90aHJlYWQuaCIKPiA+ICsjaW5jbHVkZSAicWVtdS9jdXRpbHMu
aCIKPiA+IMKgICNpbmNsdWRlICJxb20vb2JqZWN0LmgiCj4gPiDCoCAjaW5jbHVkZSAicW9tL29i
amVjdF9pbnRlcmZhY2VzLmgiCj4gPiDCoCAjaW5jbHVkZSAic3lzdGVtL2NwdS10aW1lcnMuaCIK
PiA+IEBAIC03NjAsMTAgKzc2MSw5IEBAIHN0YXRpYyB2b2lkIHFlbXVfc3lzdGVtX3dha2V1cCh2
b2lkKQo+ID4gwqDCoMKgwqDCoCB9Cj4gPiDCoCB9Cj4gPiDCoCAKPiA+IC1zdGF0aWMgY2hhciAq
dGR4X3BhcnNlX3BhbmljX21lc3NhZ2UoY2hhciAqbWVzc2FnZSkKPiA+ICtzdGF0aWMgR1N0cmlu
ZyAqdGR4X3BhcnNlX3BhbmljX21lc3NhZ2UoY2hhciAqbWVzc2FnZSkKPiA+IMKgIHsKPiA+IMKg
wqDCoMKgwqAgYm9vbCBwcmludGFibGUgPSBmYWxzZTsKPiA+IC3CoMKgwqAgY2hhciAqYnVmID0g
TlVMTDsKPiA+IMKgwqDCoMKgwqAgaW50IGxlbiA9IDAsIGk7Cj4gPiDCoCAKPiA+IMKgwqDCoMKg
wqAgLyoKPiA+IEBAIC03ODQsMzIgKzc4NCwxMSBAQCBzdGF0aWMgY2hhciAqdGR4X3BhcnNlX3Bh
bmljX21lc3NhZ2UoY2hhciAqbWVzc2FnZSkKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gPiDC
oMKgwqDCoMKgIH0KPiA+IMKgIAo+ID4gLcKgwqDCoCBpZiAobGVuID09IDApIHsKPiA+IC3CoMKg
wqDCoMKgwqDCoCBidWYgPSBnX21hbGxvYygxKTsKPiA+IC3CoMKgwqDCoMKgwqDCoCBidWZbMF0g
PSAnXDAnOwo+ID4gK8KgwqDCoCBpZiAocHJpbnRhYmxlKSB7Cj4gPiArwqDCoMKgwqDCoMKgwqAg
cmV0dXJuIGdfc3RyaW5nX25ldyhtZXNzYWdlKTsKPiA+IMKgwqDCoMKgwqAgfSBlbHNlIHsKPiA+
IC3CoMKgwqDCoMKgwqDCoCBpZiAoIXByaW50YWJsZSkgewo+ID4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgLyogMyA9IGxlbmd0aCBvZiAiJTAyeCAiICovCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBidWYgPSBnX21hbGxvYyhsZW4gKiAzKTsKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGZvciAoaSA9IDA7IGkgPCBsZW47IGkrKykgewo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBpZiAobWVzc2FnZVtpXSA9PSAnXDAnKSB7Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIH0gZWxzZSB7Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgc3ByaW50ZihidWYgKyAzICogaSwgIiUwMnggIiwgbWVzc2FnZVtpXSk7Cj4gPiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0K
PiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChpID4gMCkgewo+ID4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAvKiByZXBsYWNlIHRoZSBsYXN0ICcgJyhzcGFjZSkgdG8gTlVM
TCAqLwo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBidWZbaSAqIDMgLSAxXSA9
ICdcMCc7Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9IGVsc2Ugewo+ID4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBidWZbMF0gPSAnXDAnOwo+ID4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfQo+ID4gLcKgwqDCoMKgwqDCoMKgIH0gZWxzZSB7Cj4gPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBidWYgPSBnX3N0cmR1cChtZXNzYWdlKTsKPiA+IC3CoMKgwqDCoMKgwqDCoCB9
Cj4gPiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHFlbXVfaGV4ZHVtcF9saW5lKE5VTEwsIG1lc3Nh
Z2UsIGxlbiwgMSwgMCk7Cj4gPiDCoMKgwqDCoMKgIH0KPiA+IC0KPiA+IC3CoMKgwqAgcmV0dXJu
IGJ1ZjsKPiA+IMKgIH0KPiA+IMKgIAo+ID4gwqAgdm9pZCBxZW11X3N5c3RlbV9ndWVzdF9wYW5p
Y2tlZChHdWVzdFBhbmljSW5mb3JtYXRpb24gKmluZm8pCj4gPiBAQCAtODU0LDExICs4MzMsMTEg
QEAgdm9pZCBxZW11X3N5c3RlbV9ndWVzdF9wYW5pY2tlZChHdWVzdFBhbmljSW5mb3JtYXRpb24g
KmluZm8pCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgaW5mby0+dS5zMzkwLnBzd19tYXNrLAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGluZm8tPnUuczM5MC5wc3dfYWRkcik7
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqAgfSBlbHNlIGlmIChpbmZvLT50eXBlID09IEdVRVNUX1BB
TklDX0lORk9STUFUSU9OX1RZUEVfVERYKSB7Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBj
aGFyICptZXNzYWdlID0gdGR4X3BhcnNlX3BhbmljX21lc3NhZ2UoaW5mby0+dS50ZHgubWVzc2Fn
ZSk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBHU3RyaW5nICptZXNzYWdlID0gdGR4X3Bh
cnNlX3BhbmljX21lc3NhZ2UoaW5mby0+dS50ZHgubWVzc2FnZSk7Cj4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBxZW11X2xvZ19tYXNrKExPR19HVUVTVF9FUlJPUiwKPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiXG5URFggZ3Vl
c3QgcmVwb3J0cyBmYXRhbCBlcnJvci4iCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIiBlcnJvciBjb2RlOiAweCUiIFBSSXgzMiAiIGVy
cm9yIG1lc3NhZ2U6XCIlc1wiXG4iLAo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGluZm8tPnUudGR4LmVycm9yX2NvZGUsIG1lc3NhZ2UpOwo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlu
Zm8tPnUudGR4LmVycm9yX2NvZGUsIG1lc3NhZ2UtPnN0cik7Cj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBnX2ZyZWUobWVzc2FnZSk7Cj4gCj4gRnJlZWluZyB0aGUgR1N0cmluZyogbGVh
a3MgbWVzc2FnZS0+c3RyLgo+IAo+IFRoZSBlYXNpZXN0IHdheSB0byBkbyBpdCwgd2hpY2ggSSBo
YXZlIHNxdWFzaGVkIG9uIHRvcCBvZiB5b3VyIHBhdGNoLCBpcwo+IAo+IMKgwqDCoCBnX2F1dG9w
dHIoR1N0cmluZykgbWVzc2FnZSA9IC4uLgo+IAo+IGFuZCBkcm9wcGluZyB0aGUgZ19mcmVlKG1l
c3NhZ2UpIGxpbmUuwqAgU2VlIGZvciBleGFtcGxlIHNkYnVzX3dyaXRlX2R1bXAoKS4KCk9vcHMs
IHRoYW5rcyBmb3IgZml4aW5nIHRoaXMsIEkgdGhvdWdodCBhYm91dCB0aGF0IGdfZnJlZSgpLCBi
dXQgSSBndWVzcyBub3QgZW5vdWdoLgoKQmVzdCByZWdhcmRzLAoJTWF4aW0gTGV2aXRza3kKCj4g
Cj4gUGFvbG8K


