Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF05D232E4
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 06:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve5hH-0003dq-F7; Fri, 09 Jan 2026 01:10:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ve5hF-0003U0-Je
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:10:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ve5hC-000248-7q
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:10:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767939000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fgj8pvbvthRlo9FnyrCS1GGkicJwklm/0pxb2aMTRKs=;
 b=Yfhhc6jdocIbcKg9HNlAQ5Ja1xWedUEwNX7h62+cdPj3dfPlx7uTHjvPAZb+thcLFrE0hl
 Zhyfn261cIcagPv3ivNIAVX2iqel8IegrG2GrTtv0U5LYRm9KjWFOAgnb136zm8f+wR9AX
 TV0o6ef2HJZ5ttVMfTsqCX7fFVQoQh4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-NapTIJ8LNUqL8UkZBF-mlg-1; Fri,
 09 Jan 2026 01:09:56 -0500
X-MC-Unique: NapTIJ8LNUqL8UkZBF-mlg-1
X-Mimecast-MFC-AGG-ID: NapTIJ8LNUqL8UkZBF-mlg_1767938995
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67A701956046; Fri,  9 Jan 2026 06:09:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A954B1956048; Fri,  9 Jan 2026 06:09:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 61C1921E6934; Fri, 09 Jan 2026 07:09:52 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH] system: Convert qemu_arch_available() to TargetInfo API
In-Reply-To: <b51889b4-b101-4618-83dd-2d7be9a97f0c@linaro.org> (Pierrick
 Bouvier's message of "Thu, 8 Jan 2026 10:53:10 -0800")
References: <20260107181025.51276-1-philmd@linaro.org>
 <9910e23d-b0ed-4211-994f-3fe97cc2d204@linaro.org>
 <dd020b19-3d3f-430c-9ff2-43787e9318c0@linaro.org>
 <b51889b4-b101-4618-83dd-2d7be9a97f0c@linaro.org>
Date: Fri, 09 Jan 2026 07:09:52 +0100
Message-ID: <87secf5nbj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

UGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPiB3cml0ZXM6DQoN
Cj4gT24gMS84LzI2IDg6MzIgQU0sIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPj4g
T24gOC8xLzI2IDAxOjM2LCBQaWVycmljayBCb3V2aWVyIHdyb3RlOg0KPj4+IE9uIDEvNy8yNiAx
MDoxMCBBTSwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+Pj4+IEdldCB0aGUgYmFz
ZSBhcmNoX21hc2sgZnJvbSB0aGUgY3VycmVudCBTeXNFbXVUYXJnZXQsDQo+Pj4+IG1ha2luZyBx
ZW11X2FyY2hfYXZhaWxhYmxlKCkgdGFyZ2V0LWFnbm9zdGljLg0KPj4+Pg0KPj4+PiBXZSBkb24n
dCBuZWVkIHRoZSBwZXItdGFyZ2V0IFFFTVVfQVJDSCBkZWZpbml0aW9uIGFueW1vcmUsDQo+Pj4+
IHJlbW92ZSBpdC4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1E
YXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KDQpbLi4uXQ0KDQo+Pj4+IEBAIC0zMyw2ICszNCw0
NiBAQCBTeXNFbXVUYXJnZXQgdGFyZ2V0X2FyY2godm9pZCkNCj4+Pj4gIMKgwqDCoMKgwqAgcmV0
dXJuIGFyY2g7DQo+Pj4+ICDCoCB9DQo+Pj4+ICtib29sIHFlbXVfYXJjaF9hdmFpbGFibGUodW5z
aWduZWQgcWVtdV9hcmNoX21hc2spDQo+Pj4+ICt7DQo+Pj4+ICvCoMKgwqAgc3RhdGljIGNvbnN0
IHVuc2lnbmVkIGJhc2VfYXJjaF9tYXNrW1NZU19FTVVfVEFSR0VUX19NQVhdID0gew0KPj4+PiAr
wqDCoMKgwqDCoMKgwqAgW1NZU19FTVVfVEFSR0VUX0FBUkNINjRdwqDCoMKgwqDCoMKgwqAgPSBR
RU1VX0FSQ0hfQVJNLA0KPj4+PiArwqDCoMKgwqDCoMKgwqAgW1NZU19FTVVfVEFSR0VUX0FMUEhB
XcKgwqDCoMKgwqDCoMKgwqDCoCA9IFFFTVVfQVJDSF9BTFBIQSwNCj4+Pj4gK8KgwqDCoMKgwqDC
oMKgIFtTWVNfRU1VX1RBUkdFVF9BUk1dwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA9IFFFTVVfQVJD
SF9BUk0sDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBbU1lTX0VNVV9UQVJHRVRfQVZSXcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgPSBRRU1VX0FSQ0hfQVZSLA0KPj4+PiArwqDCoMKgwqDCoMKgwqAgLyoN
Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgIFtTWVNfRU1VX1RBUkdFVF9IRVhBR09OXcKgwqDCoMKgwqDC
oMKgID0gUUVNVV9BUkNIX0hFWEFHT04sDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCAqLw0KPj4+PiAr
wqDCoMKgwqDCoMKgwqAgW1NZU19FTVVfVEFSR0VUX0hQUEFdwqDCoMKgwqDCoMKgwqDCoMKgwqAg
PSBRRU1VX0FSQ0hfSFBQQSwNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIFtTWVNfRU1VX1RBUkdFVF9J
Mzg2XcKgwqDCoMKgwqDCoMKgwqDCoMKgID0gUUVNVV9BUkNIX0kzODYsDQo+Pj4+ICvCoMKgwqDC
oMKgwqDCoCBbU1lTX0VNVV9UQVJHRVRfTE9PTkdBUkNINjRdwqDCoMKgID0gUUVNVV9BUkNIX0xP
T05HQVJDSCwNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIFtTWVNfRU1VX1RBUkdFVF9NNjhLXcKgwqDC
oMKgwqDCoMKgwqDCoMKgID0gUUVNVV9BUkNIX002OEssDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBb
U1lTX0VNVV9UQVJHRVRfTUlDUk9CTEFaRV3CoMKgwqDCoCA9IFFFTVVfQVJDSF9NSUNST0JMQVpF
LA0KPj4+PiArwqDCoMKgwqDCoMKgwqAgW1NZU19FTVVfVEFSR0VUX01JQ1JPQkxBWkVFTF3CoMKg
ID0gUUVNVV9BUkNIX01JQ1JPQkxBWkUsDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBbU1lTX0VNVV9U
QVJHRVRfTUlQU13CoMKgwqDCoMKgwqDCoMKgwqDCoCA9IFFFTVVfQVJDSF9NSVBTLA0KPj4+PiAr
wqDCoMKgwqDCoMKgwqAgW1NZU19FTVVfVEFSR0VUX01JUFM2NF3CoMKgwqDCoMKgwqDCoMKgID0g
UUVNVV9BUkNIX01JUFMsDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBbU1lTX0VNVV9UQVJHRVRfTUlQ
UzY0RUxdwqDCoMKgwqDCoMKgID0gUUVNVV9BUkNIX01JUFMsDQo+Pj4+ICvCoMKgwqDCoMKgwqDC
oCBbU1lTX0VNVV9UQVJHRVRfTUlQU0VMXcKgwqDCoMKgwqDCoMKgwqAgPSBRRU1VX0FSQ0hfTUlQ
UywNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIFtTWVNfRU1VX1RBUkdFVF9PUjFLXcKgwqDCoMKgwqDC
oMKgwqDCoMKgID0gUUVNVV9BUkNIX09QRU5SSVNDLA0KPj4+PiArwqDCoMKgwqDCoMKgwqAgW1NZ
U19FTVVfVEFSR0VUX1BQQ13CoMKgwqDCoMKgwqDCoMKgwqDCoMKgID0gUUVNVV9BUkNIX1BQQywN
Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgIFtTWVNfRU1VX1RBUkdFVF9QUEM2NF3CoMKgwqDCoMKgwqDC
oMKgwqAgPSBRRU1VX0FSQ0hfUFBDLA0KPj4+PiArwqDCoMKgwqDCoMKgwqAgW1NZU19FTVVfVEFS
R0VUX1JJU0NWMzJdwqDCoMKgwqDCoMKgwqAgPSBRRU1VX0FSQ0hfUklTQ1YsDQo+Pj4+ICvCoMKg
wqDCoMKgwqDCoCBbU1lTX0VNVV9UQVJHRVRfUklTQ1Y2NF3CoMKgwqDCoMKgwqDCoCA9IFFFTVVf
QVJDSF9SSVNDViwNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIFtTWVNfRU1VX1RBUkdFVF9SWF3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgPSBRRU1VX0FSQ0hfUlgsDQo+Pj4+ICvCoMKgwqDCoMKgwqDC
oCBbU1lTX0VNVV9UQVJHRVRfUzM5MFhdwqDCoMKgwqDCoMKgwqDCoMKgID0gUUVNVV9BUkNIX1Mz
OTBYLA0KPj4+PiArwqDCoMKgwqDCoMKgwqAgW1NZU19FTVVfVEFSR0VUX1NINF3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgID0gUUVNVV9BUkNIX1NINCwNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIFtTWVNf
RU1VX1RBUkdFVF9TSDRFQl3CoMKgwqDCoMKgwqDCoMKgwqAgPSBRRU1VX0FSQ0hfU0g0LA0KPj4+
PiArwqDCoMKgwqDCoMKgwqAgW1NZU19FTVVfVEFSR0VUX1NQQVJDXcKgwqDCoMKgwqDCoMKgwqDC
oCA9IFFFTVVfQVJDSF9TUEFSQywNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIFtTWVNfRU1VX1RBUkdF
VF9TUEFSQzY0XcKgwqDCoMKgwqDCoMKgID0gUUVNVV9BUkNIX1NQQVJDLA0KPj4+PiArwqDCoMKg
wqDCoMKgwqAgW1NZU19FTVVfVEFSR0VUX1RSSUNPUkVdwqDCoMKgwqDCoMKgwqAgPSBRRU1VX0FS
Q0hfVFJJQ09SRSwNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIFtTWVNfRU1VX1RBUkdFVF9YODZfNjRd
wqDCoMKgwqDCoMKgwqDCoCA9IFFFTVVfQVJDSF9JMzg2LA0KPj4+PiArwqDCoMKgwqDCoMKgwqAg
W1NZU19FTVVfVEFSR0VUX1hURU5TQV3CoMKgwqDCoMKgwqDCoMKgID0gUUVNVV9BUkNIX1hURU5T
QSwNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIFtTWVNfRU1VX1RBUkdFVF9YVEVOU0FFQl3CoMKgwqDC
oMKgwqAgPSBRRU1VX0FSQ0hfWFRFTlNBLA0KPj4+PiArwqDCoMKgIH07DQo+Pj4+ICsNCj4+Pg0K
Pj4+IEp1c3QgYSByZW1hcms6IGlzIHRoYXQgd29ydGggaGF2aW5nIHRoZSAic3RhdGljIGNvbnN0
IiBhcnJheSBhcHByb2FjaA0KPj4+IHdoZW4gd2UgY291bGQgaGF2ZSBhIHByb3BlciBzd2l0Y2gg
dGhhbiBjYW4gYmUgY2hlY2tlZCBmb3INCj4+PiBleGhhdXN0aXZlbmVzcyB3aXRoIGNvbXBpbGVy
IHdhcm5pbmdzIGluc3RlYWQ/DQo+Pg0KPj4gSSB0aG91Z2h0IDQwIExvQyB3b3VsZCBiZSBzaW1w
bGVyIHRvIHJldmlldyB0aGFuIDgwLCBhbmQgaXQgd2FzDQo+PiBzaW1wbGVyIHRvIGdlbmVyYXRl
IHRoZSB0ZW1wbGF0ZSBpbiBiYXNoLg0KDQpJIGZpbmQgdGhlIGFycmF5IHNvbHV0aW9uIG11Y2gg
ZWFzaWVyIHRvIGdyYXNwIGF0IGEgZ2xhbmNlLiAgVGhlDQppbml0aWFsaXplciBzaG93cyB0aGUg
bWFwcGluZyBjb25jaXNlbHkuICBXaXRoIGEgc3dpdGNoLCB0aGVyZSdzIG5vaXNlDQphcm91bmQg
dGhlIG1hcHBpbmcsIGFuZCB0aGUgZmFjdCB0aGF0IGFsbCBhbGwgc3dpdGNoIGNhc2VzIGRvIG5v
dGhpbmcNCmJ1dCBhc3NpZ24gYSBjb25zdGFudCB0byB0aGUgc2FtZSB2YXJpYWJsZSBpcyBub3Qg
b2J2aW91cyBhdCBhIGdsYW5jZS4NCg0KPj4gQmVzaWRlcywgd2UgZG9uJ3QgdXNlIGNvbXBpbGVy
IHdhcm5pbmdzIGZvciBlbnVtIChzdWNoIC1Xc3dpdGNoKQ0KPj4gZHVlIHRvIFFBUEk6DQo+PiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjMwMzE1MTEyODExLjIyMzU1LTEt
cGhpbG1kQGxpbmFyby5vcmcvDQo+PiANCj4NCj4gUmVhZGluZyB0aGUgdGhyZWFkIGFib3ZlLCB0
aGUgb25seSBtZW50aW9uIEkgZmluZCBpcyB0aGUgM3JkIGNvbW1pdCB0aGF0IHByZWNpc2VseSBj
aGFuZ2UgZGVmaW5pdGlvbiBiZWNhdXNlIC1Xc3dpdGNoIGlzIGVuYWJsZWQgd2l0aCBjbGFuZy4N
Cj4NCj4gQW5kIGl0J3Mgbm90IG9ubHkgYSBjbGFuZyB0aGluZywgZ2NjIGhhcyBpdCBpbiBXYWxs
IGFsc28gWzFdLg0KPg0KPiBJIGRvbid0IG1pbmQgdGhlIGFycmF5IGFwcHJvYWNoLCBidXQgbWF5
YmUganVzdCBhZGQgYSAqc3RhdGljKiBhc3NlcnQgbWFraW5nIHN1cmUgKFNZU19FTVVfVEFSR0VU
X19NQVgtMSA9PSBTWVNfRU1VX1RBUkdFVF9YVEVOU0FFQikgc28gdGhpcyBmaWxlIHdpbGwgYnJl
YWsgYXMgc29vbiBhcyB0aGVyZSBpcyBhIG5ldyB0YXJnZXQgYWRkZWQuIEl0J3Mgc2ltcGxlIGFu
ZCB0aGUgbmV4dCBkZXZlbG9wZXIgd2hvIHdvbid0IGhhdmUgdG8gZGVidWcgdGhpcyB3aWxsIHRo
YW5rIHlvdS4NCg0KV29uJ3QgaGVscCB3aGVuIG5ldyBlbnVtIHZhbHVlcyBhcmUgYWRkZWQgaW4g
dGhlIG1pZGRsZS4gIFdlIGtlZXAgdGhlbQ0KYWxwaGFiZXRpY2FsbHkgc29ydGVkLi4uDQoNCldl
IGNvdWxkIHVzZSBhIHNpbXBsZSBydW4tdGltZSBhc3NlcnRpb246DQoNCiAgICBhcmNoX21hc2sg
PSBxZW11X2FyY2hfbWFzayAmIGJhc2VfYXJjaF9tYXNrW3RhcmdldF9hcmNoKCldOw0KICAgIGFz
c2VydChhcmNoX21hc2spOw0KICAgIHJldHVybiBhcmNoX21hc2s7DQoNCldvcmtzIGJlY2F1c2Ug
dGhlIFFFTVVfQVJDSF9GT08gYXJlIGFsbCBub24temVyby4NCg0KUGljayB5b3VyIHBvaXNvbi4N
Cg0KPiBbMV0gaHR0cHM6Ly9nY2MuZ251Lm9yZy9vbmxpbmVkb2NzL2djYy0xNC4yLjAvZ2NjL1dh
cm5pbmctT3B0aW9ucy5odG1sDQo+DQo+Pj4NCj4+PiBCZXlvbmQgdGhhdCwNCj4+PiBSZXZpZXdl
ZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0K


