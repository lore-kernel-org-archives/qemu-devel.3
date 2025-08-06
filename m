Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2134C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 16:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujgg7-0001uR-VU; Wed, 06 Aug 2025 12:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wojtekka@toxygen.net>)
 id 1ujfr1-0002n0-7x; Wed, 06 Aug 2025 11:14:59 -0400
Received: from sender2-of-o55.zoho.eu ([136.143.171.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wojtekka@toxygen.net>)
 id 1ujfqz-0006PU-Bm; Wed, 06 Aug 2025 11:14:58 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1754493288; cv=none; d=zohomail.eu; s=zohoarc; 
 b=iHeCyGBynqzFcXPKnHSWinoLxEgglhCmnzJcS2Gkqkxx7tLzmiC81Z7DA1k+YjM080716/wEMcini3N630lWyozBc3fr2jfqxOMIof/tr6u92Yd1JEpO4oZUU0dOtoyUppVLKNw1uNhjF0b3M4SmTtxvDKhh8j3YoJbSTSSp+SE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu;
 s=zohoarc; t=1754493288;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ujgz+ZrlhTRCgwpLXv/5o6qTwG3nJq9mjFcFXeyvx6g=; 
 b=KRvrjIflc2uyh07Ohb6jQJ5iJTnWrqrw82bNflZlse85hZSmkY6jPlsbXl1CWtT1KIvNErxC0RcQ7kp5TZNRQtkr5yX8DJYcknY+uaQV7JdoupiSHTEbTHJMQV26j6bcBGcMzY/TL3oe1MD/TjkT2XQPOtwg5ej76HgVyLkHWjE=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
 dkim=pass  header.i=toxygen.net;
 spf=pass  smtp.mailfrom=wojtekka@toxygen.net;
 dmarc=pass header.from=<wojtekka@toxygen.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754493288; 
 s=zmail; d=toxygen.net; i=wojtekka@toxygen.net;
 h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
 bh=ujgz+ZrlhTRCgwpLXv/5o6qTwG3nJq9mjFcFXeyvx6g=;
 b=ZKi3RUS5SFOrTBaw17q1KIyxfMTSpIPIdjMNxM08oLzRF3aLLo1iIsh+C2pZjPQW
 110mN0olGfpkeAsxhDTiXYMxZtp+meTccqrVkHwgW+yiwQ4dtL8p2ViibQk4SptWgHr
 /ZXSYcxCrMwBEts6hpcuYdRbqJ8Agv/dYOMcLTQU=
Received: by mx.zoho.eu with SMTPS id 175449328548041.81503987997121;
 Wed, 6 Aug 2025 17:14:45 +0200 (CEST)
Message-ID: <64eab7c0760b9e8742feca2aa68dea94d6bfe631.camel@toxygen.net>
Subject: Re: [PATCH qemu 1/2] Don't reverse bFLT endianess when not needed
From: Wojtek Kaniewski <wojtekka@toxygen.net>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Date: Wed, 06 Aug 2025 17:14:44 +0200
In-Reply-To: <e1fe443a-b715-41e8-a292-98449468e321@vivier.eu>
References: <175270306503.19369.144677794735042916-1@git.sr.ht>
 <e1fe443a-b715-41e8-a292-98449468e321@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.171.55; envelope-from=wojtekka@toxygen.net;
 helo=sender2-of-o55.zoho.eu
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 06 Aug 2025 11:27:14 -0400
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

T24gVGh1LCAyMDI1LTA3LTE3IGF0IDA4OjQ4ICswMjAwLCBMYXVyZW50IFZpdmllciB3cm90ZToK
PiBMZSAxNi8wNy8yMDI1IMOgIDIxOjI0LCB+d29qdGVra2EgYSDDqWNyaXTCoDoKPiA+IEZyb206
IFdvanRlayBLYW5pZXdza2kgPHdvanRla2thQHRveHlnZW4ubmV0Pgo+ID4gCj4gPiBiRkxUIGZv
cm1hdCBpcyBiaWctZW5kaWFuLiBnZXRfdXNlcl91YWwoKSByZXR1cm5zIGhvc3QgdmFsdWUgc28g
Zm9yCj4gPiBsaXR0bGUtZW5kaWFuIHRhcmdldCBhbmQgbGl0dGxlLWVuZGlhbiBob3N0IGl0J3Mg
bmVjZXNzYXJ5IHRvCj4gPiByZXZlcnNlCj4gPiB3b3JkcyB1c2luZyBudG9obCgpLiBGb3IgYmln
LWVuZGlhbiB0YXJnZXRzIHdlIGVuZCB1cCB3aXRoCj4gPiBpbmNvcnJlY3QKPiA+IGVuZGlhbmVz
czoKPiA+IAo+ID4gwqDCoMKgwqAgJCBxZW11LW02OGstc3RhdGljIC4vdGVzdAo+ID4gwqDCoMKg
wqAgQklORk1UX0ZMQVQ6IHJlbG9jIG91dHNpZGUgcHJvZ3JhbSAweDgwMWYwMDAwICgwIC0KPiA+
IDB4NDFmMC8weDFlNDApCj4gPiDCoMKgwqDCoCBBYm9ydGVkIChjb3JlIGR1bXBlZCkKPiA+IAo+
ID4gRm9yIGNvbXBhcmlzb24gdGhlIG91dHB1dCBvZiBgZmx0aGRyYCBmb2xsb3dzOgo+ID4gCj4g
PiDCoMKgwqDCoCAkIG02OGstZWxmLWZsdGhkciAtUCAuL3Rlc3QKPiA+IMKgwqDCoMKgIC4vdGVz
dAo+ID4gwqDCoMKgwqDCoMKgwqDCoCBNYWdpYzrCoMKgwqDCoMKgwqDCoCBiRkxUCj4gPiDCoMKg
wqDCoMKgwqDCoMKgIFJldjrCoMKgwqDCoMKgwqDCoMKgwqAgNAo+ID4gwqDCoMKgwqDCoMKgwqDC
oCBCdWlsZCBEYXRlOsKgwqAgVHVlIEp1bCAxNSAyMzowMjowMCAyMDI1Cj4gPiDCoMKgwqDCoMKg
wqDCoMKgIEVudHJ5OsKgwqDCoMKgwqDCoMKgIDB4NDQKPiA+IMKgwqDCoMKgwqDCoMKgwqAgRGF0
YSBTdGFydDrCoMKgIDB4MWU4MAo+ID4gwqDCoMKgwqDCoMKgwqDCoCBEYXRhIEVuZDrCoMKgwqDC
oCAweDIwNWMKPiA+IMKgwqDCoMKgwqDCoMKgwqAgQlNTIEVuZDrCoMKgwqDCoMKgIDB4NDBhMAo+
ID4gwqDCoMKgwqDCoMKgwqDCoCBTdGFjayBTaXplOsKgwqAgMHgxMDAwCj4gPiDCoMKgwqDCoMKg
wqDCoMKgIFJlbG9jIFN0YXJ0OsKgIDB4MjA1Ywo+ID4gwqDCoMKgwqDCoMKgwqDCoCBSZWxvYyBD
b3VudDrCoCAweDE3Cj4gPiDCoMKgwqDCoMKgwqDCoMKgIEZsYWdzOsKgwqDCoMKgwqDCoMKgIDB4
MiAoIEhhcy1QSUMtR09UICkKPiA+IMKgwqDCoMKgwqDCoMKgwqAgUmVsb2NzOgo+ID4gwqDCoMKg
wqDCoMKgwqDCoCAjCXJlbG9jwqDCoMKgwqDCoCAowqAgYWRkcmVzcyApCWRhdGEKPiA+IMKgwqDC
oMKgwqDCoMKgwqAgMAkweDAwMDAxZjgwICgweDAwMDAxZjgwKQkzYzIwMDAwMAo+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF5eXl5eXl5eCj4gPiDCoMKgwqDCoMKgwqDC
oMKgIDEJMHgwMDAwMWY4NCAoMHgwMDAwMWY4NCkJM2MzMDAwMDAKPiA+IMKgwqDCoMKgwqDCoMKg
wqAgMgkweDAwMDAxZjg4ICgweDAwMDAxZjg4KQkzYzIwMDAwMAo+ID4gwqDCoMKgwqDCoMKgwqDC
oCAuLi4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogV29qdGVrIEthbmlld3NraSA8d29qdGVra2FA
dG94eWdlbi5uZXQ+Cj4gPiAtLS0KPiA+IMKgIGxpbnV4LXVzZXIvZmxhdGxvYWQuYyB8IDIgKysK
PiA+IMKgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPiA+IAo+ID4gZGlmZiAtLWdp
dCBhL2xpbnV4LXVzZXIvZmxhdGxvYWQuYyBiL2xpbnV4LXVzZXIvZmxhdGxvYWQuYwo+ID4gaW5k
ZXggNGJlYjNlZDFiOS4uYWZhZmY0YWM0NCAxMDA2NDQKPiA+IC0tLSBhL2xpbnV4LXVzZXIvZmxh
dGxvYWQuYwo+ID4gKysrIGIvbGludXgtdXNlci9mbGF0bG9hZC5jCj4gPiBAQCAtNDEzLDcgKzQx
Myw5IEBAIHN0YXRpYyBpbnQgbG9hZF9mbGF0X2ZpbGUoc3RydWN0IGxpbnV4X2JpbnBybSAqCj4g
PiBicHJtLAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVsb2NhdGVkIGZp
cnN0KS7CoCAqLwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGdldF91c2VyX3Vh
bChyZWx2YWwsIHJlbG9jICsgaSAqCj4gPiBzaXplb2YoYWJpX3Vsb25nKSkpCj4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRUZBVUxUOwo+ID4gKyNpZiAhVEFS
R0VUX0JJR19FTkRJQU4KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlbHZhbCA9IG50
b2hsKHJlbHZhbCk7Cj4gPiArI2VuZGlmCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBp
ZiAoZmxhdF9zZXRfcGVyc2lzdGVudChyZWx2YWwsICZwZXJzaXN0ZW50KSkKPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGludWU7Cj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBhZGRyID0gZmxhdF9nZXRfcmVsb2NhdGVfYWRkcihyZWx2YWwpOwo+IAo+IEkg
dGhpbmsgdGhlIG50b2hsKCkgc2hvdWxkIGJlIHJlbW92ZWQgdG90YWxseSBhbmQKPiBmbGF0X3Nl
dF9wZXJzaXN0ZW50KCkgCj4gc2hvdWxkIHVzZSBwdXRfdXNlcl91YWwoKS4KPiAKPiBDb3VsZCB5
b3UgdGVzdCB0aGlzPwoKZmxhdF9zZXRfcGVyc2lzdGVudCgpIGlzIGp1c3QgYSBuby1vcCBtYWNy
byBjb3BpZWQgZnJvbSBMaW51eCBrZXJuZWwKaW1wbGVtZW50YXRpb24gYW5kIGhhcyBiZWVuIHJl
bW92ZWQgZnJvbSB0aGUgdXBzdHJlYW0gYSBjb3VwbGUgb2YgeWVhcnMKYWdvIFsxXS4gVGhlIGFj
dHVhbCBhZGRyZXNzIGlzIHJlbG9jYXRlZCBieSBmbGF0X2dldF9yZWxvY2F0ZV9hZGRyKCkgYQps
aW5lIGJlbG93IHNvIGl0IG5lZWRzIHRvIGJlIGluIGhvc3QtZW5kaWFuLiBEcm9wcGluZyBudG9o
bCgpIHdvdWxkCmJyZWFrIGl0IGZvciBsaXR0bGUtZW5kaWFuIHRhcmdldHMgYmVjYXVzZSBiRkxU
IGJ5IGRlZmluaXRpb24gaXMgYmlnLQplbmRpYW4uCgpJcyB0aGVyZSBhIG1hY3JvIHNpbWlsYXIg
dG8gZ2V0X3VzZXJfdWFsKCkgYnV0IHdpdGhvdXQgYW55IGVuZGlhbmVzcwpjb252ZXJzaW9uPyBU
aGUgY2xvc2VzdCB0aGluZyBJIGZvdW5kIHdhcyBsZGxfcCgpLCBidXQgSSBhc3N1bWUgaXQncwpu
b3QgdGhlIGJlc3QgaWRlYSBkdWUgdG8gbGFjayBvZiBsb2NraW5nLgoKKEFuZCBzb3JyeSBmb3Ig
c3VjaCBhIGxhdGUgcmVzcG9uc2UuIEkgaGF2ZW4ndCB1c2VkIG1haWxpbmcgbGlzdHMgZm9yCnll
YXJzIGFuZCBpdCB0b29rIG1lIHdheSB0b28gbG9uZyB0byBnZXQgbXkgb2xkIGUtbWFpbCBhY2Nv
dW50IHRvIHdvcmsKcHJvcGVybHkuKQoKUmVnYXJkcywKV29qdGVrCgpbMV0KaHR0cHM6Ly9naXRo
dWIuY29tL3RvcnZhbGRzL2xpbnV4L2NvbW1pdC8yZjMxOTZkNDliMWUxMGYxZDRiYzY0Y2NlMDBk
Yzk1ZmRlMmIwY2UxCgo=


