Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 707FDFF8868
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 11:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHgn0-0007Ej-4S; Tue, 28 Apr 2026 07:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wHgmp-0007Da-Qf
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 07:39:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wHgmn-0001J1-13
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 07:39:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777376366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3SazA5Xw4Hmq1HIjiUcMR8iiKWvF+yJktiDoLpOBKpE=;
 b=gh7xy15PXDZWcNfAzU7sP/gotRQIyVWEVODlMVTuxFIC24Oymt/fEl/g+IluLtRALe+fXN
 At8xWk1KlTxhc4XhROE1QYkKvcNGmCpeSlnSofBrSleVDd664m6bL4xoQQW+kosS9SjseH
 qsCF5Dh9j1O5I+hp+9h8DRKFr1an3qA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-398-bbxFz4V3MSyG1XR4e4gIIA-1; Tue,
 28 Apr 2026 07:39:22 -0400
X-MC-Unique: bbxFz4V3MSyG1XR4e4gIIA-1
X-Mimecast-MFC-AGG-ID: bbxFz4V3MSyG1XR4e4gIIA_1777376361
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8CF3F19560B7; Tue, 28 Apr 2026 11:39:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.9])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A4F8195608E; Tue, 28 Apr 2026 11:39:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0926321E6A28; Tue, 28 Apr 2026 13:39:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,  Peter Xu
 <peterx@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  qemu-devel
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 12/18] migration: VMStateInfo: introduce new handlers
 with errp
In-Reply-To: <de48c866-6018-4a5f-9129-2c1d184f4495@redhat.com> (Paolo
 Bonzini's message of "Tue, 28 Apr 2026 10:39:43 +0200")
References: <20260304212303.667141-1-vsementsov@yandex-team.ru>
 <20260304212303.667141-13-vsementsov@yandex-team.ru>
 <d80e91c1-2cbb-4081-a923-7b0c1da3b7cc@redhat.com>
 <f7525a89-7878-43e8-b791-69829589666f@yandex-team.ru>
 <CABgObfbz98A0P4_FAqeKVk_fS+o_3=79agYz=qwnMdmg-h2L-Q@mail.gmail.com>
 <b47b83aa-c574-4a38-bad2-4f42d6a7c597@yandex-team.ru>
 <de48c866-6018-4a5f-9129-2c1d184f4495@redhat.com>
Date: Tue, 28 Apr 2026 13:39:17 +0200
Message-ID: <878qa72u1m.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.109,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4gd3JpdGVzOg0KDQo+IE9uIDQvMjgv
MjYgMTA6MTcsIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+PiBbYWRkIE1h
cmt1c10NCj4+IE9uIDI3LjA0LjI2IDIyOjExLCBQYW9sbyBCb256aW5pIHdyb3RlOg0KPj4+DQo+
Pj4NCj4+PiBJbCBsdW4gMjcgYXByIDIwMjYsIDE1OjE5IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2ll
dnNraXkgPHZzZW1lbnRzb3ZAeWFuZGV4LXRlYW0ucnUgPG1haWx0bzp2c2VtZW50c292QHlhbmRl
eC10ZWFtLnJ1Pj4gaGEgc2NyaXR0bzoNCj4+Pj4NCj4+Pj4gT24gMjYuMDQuMjYgMTE6MzMsIFBh
b2xvIEJvbnppbmkgd3JvdGU6DQo+Pj4+PiBPbiAzLzQvMjYgMjE6MjIsIFZsYWRpbWlyIFNlbWVu
dHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4+Pj4gK8KgwqDCoCBib29sIGNvcm91dGluZV9taXhl
ZF9mbiAoKmxvYWQpKFFFTVVGaWxlICpmLCB2b2lkICpwdiwgc2l6ZV90IHNpemUsDQo+Pj4+Pj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgY29uc3QgVk1TdGF0ZUZpZWxkICpmaWVsZCwNCj4+Pj4+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBFcnJvciAqKmVycnApOw0KPj4+Pj4+ICvCoMKgwqAgYm9vbCBjb3JvdXRpbmVfbWl4
ZWRfZm4gKCpzYXZlKShRRU1VRmlsZSAqZiwgdm9pZCAqcHYsIHNpemVfdCBzaXplLA0KPj4+Pj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGNvbnN0IFZNU3RhdGVGaWVsZCAqZmllbGQsDQo+Pj4+Pj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgSlNPTldyaXRlciAqdm1kZXNjLA0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEVycm9y
ICoqZXJycCk7DQo+Pj4+PiBVc2Ugdm9pZCBmdW5jdGlvbnMgZm9yIGNhbGxiYWNrcywgd2l0aCBh
IHdyYXBwZXIgYWRkaW5nIHRoZSBib29sIHR5cGUuIFdoaWxlIGJvb2wvZXJycCBpcyBwcmVmZXJy
ZWQgaW4gZ2VuZXJhbCwgZm9yIGNhbGxiYWNrcyBpdCBwcm92aWRlcyBOIG9wcG9ydHVuaXRpZXMg
dG8gZ2V0IGl0IHdyb25nIGluc3RlYWQgb2YganVzdCBvbmUuDQo+Pj4+Pg0KPj4+Pg0KPj4+PiBI
bW0sIGZvciBub3csIHRoZSBzZXJpZXMgaXMgYWxyZWFkeSBtZXJnZWQuDQo+Pj4+DQo+Pj4+IE5l
eHQsIEknbSB1bnN1cmUsIGhvdyBjYWxsYmFja3MgYXJlIGRpZmZlcmVudCBmcm9tIG90aGVyIGZ1
bmN0aW9ucyBhcm91bmQgZXJyb3JzPw0KPj4+DQo+Pj4gQXMgSSB3cm90ZSBhYm92ZSwgY29uZnVz
aW5nIHRoZSAqZXJyb3IgPT0gTlVMTCBhbmQgYm9vbCByZXR1cm4gdmFsdWUgaXMgYXZvaWRlZCB3
aXRob3V0IG11Y2ggZXh0cmEgZWZmb3J0IGZvciBjYWxsYmFja3MgKG9yIG90aGVyIGtpbmRzIG9m
IHZpcnR1YWwgZnVuY3Rpb25zKSBsLCBiZWNhdXNlIHRoZXJlIGlzIGEgc2luZ2xlIGNhbGxlci4g
U28gdGhlIGJhbGFuY2UgYmV0d2VlbiAiYXZvaWRpbmcgdGhlIHBvc3NpYmlsaXR5IG9mIGdldHRp
bmcgdGhlIHJldHVybiB2YWx1ZSB3cm9uZyIgYW5kICJjb252ZW5pZW5jZSBvZiBoYXZpbmcgYSBy
ZXR1cm4gdmFsdWUiIHRpbHRzIG1vcmUgdG93YXJkcyB0aGUgZm9ybWVyLg0KDQpCdWcgcGF0dGVy
bnM6DQoNCjEuIFNldCBhbiBlcnJvciwgaW1tZWRpYXRlbHkgcmV0dXJuIHN1Y2Nlc3MuICBJIGNh
bid0IHJlbWVtYmVyIHNlZWluZw0KdGhpcy4NCg0KMi4gU2V0IGFuIGVycm9yLCBmb3JnZXQgdG8g
cmV0dXJuLCBzb21laG93IHN1cnZpdmUgYWxsIHRoZSB3YXkgdG8gdGhlDQpub3JtYWwgc3VjY2Vz
cyByZXR1cm4uICBJJ3ZlIHNlZW4gYW5kIGZpeGVkIHRoaXMuICBSZXR1cm5pbmcgdm9pZCBkb2Vz
DQpub3QgaGVscCBhdCBhbGwgaGVyZS4NCg0KMy4gU2V0IGFuIGVycm9yLCBnb3RvIGVycm9yIGV4
aXQgd2l0aG91dCBmbGlwcGluZyB0aGUgcmV0dXJuIHZhbHVlDQp2YXJpYWJsZSBmcm9tIHN1Y2Nl
c3MgdG8gZmFpbHVyZS4gIEkndmUgc2VlbiBhbmQgZml4ZWQgdGhpcywgdG9vLiAgQmVzdA0KdG8g
aW5pdGlhbGl6ZSB0aGUgcmV0dXJuIHZhbHVlIHZhcmlhYmxlIHRvIGZhaWx1cmUsIGFuZCBmbGlw
IGl0IHRvDQpzdWNjZXNzIG9ubHkgd2hlbiBzdWNjZXNzIGlzIGVuc3VyZWQuICBPZiBjb3Vyc2Us
IHRoYXQgZmxpcCBjYW4gYmUNCmZvcmdvdHRlbiBhcyB3ZWxsIGlmIGl0J3MgbmVlZGVkIGluIG11
bHRpcGxlIHBsYWNlcy4gIFRoYXQncyByYXJlLg0KQW55d2F5LCByZXR1cm5pbmcgZWxpbWluYXRl
cyB0aGlzIGJ1ZyBwYXR0ZXJuLg0KDQpUaGUgbGFzdCBvbmUgZG9lcyBzb21lIHRpbHRpbmcuDQoN
ClRpbHRpbmcgdGhlIG90aGVyIHdheToga2VlcGluZyB0aGUgcnVsZXMgc2ltcGxlIGFuZCBjb25z
aXN0ZW50IHdpdGgNCkdFcnJvcidzLg0KDQo+PiBVbmRlcnN0YW5kLiBIbS4NCj4+DQo+PiBBbiBh
bHRlcm5hdGl2ZSBmb3IgdGhpcyBzaW5nbGUtY2FsbGVyIGNhc2UsIGlzIGp1c3QgYWRkIGFuIGFz
c2VydGlvbiBpbnRvIHRoaXMgY2FsbGVyOg0KPj4NCj4+IGJvb2wgd3JhcHBlciguLi4sIGVycnAp
IHsNCj4+ICDCoMKgIEVSUlBfR1VBUkQoKTsNCj4+ICDCoMKgIGJvb2wgb2sgPSB4LT5mb28oLi4u
LCBlcnJwKTsNCj4+ICDCoMKgIGFzc2VydChvayA9PSAhKCplcnJwKSk7DQo+PiAgwqDCoCByZXR1
cm4gb2s7DQo+PiB9DQo+DQo+IEkgZG9uJ3QgdGhpbmsgdGhpcyBtYWtlcyBzZW5zZSwgdGhlIGFz
c2VydGlvbiBtb3ZlcyBhIGNvbXBpbGUtdGltZSBndWFyYW50ZWUgdG8gYSBydW4tdGltZSBndWFy
YW50ZWUgd2hpY2ggaXMgc3RyaWN0bHkgd29yc2UuDQo+DQo+IFRoZXJlIGFyZSBtYW55IG1vcmUg
ZXhhbXBsZXMgb2Ygdm9pZCtlcnJwIGNhbGxiYWNrcyB0aGFuIGJvb2wrZXJycCwgdGhlIG1vc3Qg
aW1wb3J0YW50IG9uZSBiZWluZyAucmVhbGl6ZSBmb3IgZGV2aWNlcy4gIEEgcXVpY2sgZ3JlcCwg
d2hpY2ggaXMgY2VydGFpbmx5IG5vdCBmdWxseSBhY2N1cmF0ZSwgc2hvd3MgNjMgdnMuIDI3Og0K
Pg0KPiAkIGdpdCBncmVwIC13ICd2b2lkLiooXCouKmVycnAnIHwgd2MgLWwNCj4gNjMNCj4gJCBn
aXQgZ3JlcCAtdyAnYm9vbC4qKFwqLiplcnJwJyB8IHdjIC1sDQo+IDI3DQoNClllcy4gIEF0IHNv
bWUgcG9pbnQsIEkgYnJpZWZseSBjb25zaWRlcmVkIHVwZGF0aW5nIHRoZW0gdG8gcmV0dXJuIGJv
b2wNCmZvciBydWxlcyBjb25mb3JtYW5jZSwgYnV0IGRlY2lkZWQgaXQgd2Fzbid0IHdvcnRoIGl0
Lg0KDQo+IEluIG1hbnkgY2FzZXMgdGhlcmUgYXJlIGp1c3QgdHdvIG9yIHRocmVlIGltcGxlbWVu
dGF0aW9uIHNvIEkgd291bGRuJ3QgZ28gdG8gZ3JlYXQgbGVuZ3RocyB0byBjaGFuZ2UgaXQgZXZl
biBpZiBJIGRpc2FncmVlLiAgQnV0IGZvciB2bXN0YXRlIChlLmcuIHByZV9sb2FkX2VycnAgYW5k
IGZyaWVuZHMpIHRoaXMgaXMgbm90IGdvaW5nIHRvIGJlIHRoZSBjYXNlIGluIHRoZSBsb25nIHJ1
biwgYW5kIGl0J3MgbW9yZSBzaW1pbGFyIHRvIHRoZSBkZXZpY2UgY2FzZS4NCg0KV2Ugc2hvdWxk
IGFsd2F5cyBiZSB3aWxsaW5nIHRvIGFjY2VwdCByZWFzb25lZCBleGNlcHRpb25zIHRvIHJ1bGVz
Lg0KSG93ZXZlci4uLg0KDQo+Pj4+IEknbSBub3Qgc3VyZSB0aGF0IG1ha2luZyB3cmFwcGVycywg
d2hpY2ggd2lsbCBoYXZlIHRvIHVzZSBFUlJQX0dVQVJEIGFuZCBjaGVjaw0KPj4+PiAqZXJycCBm
b3IgdGhlIGVycm9yIGlzIGEgZ29vZCBwcmFjdGljZS4gSWYgaXQgaXMsIGl0IHdvdWxkIGJlIGdv
b2QgdG8gc3RhcnQgYnkNCj4+Pj4gbW9kaWZ5aW5nIHRoZSBkb2N1bWVudGF0aW9uIGluIGluY2x1
ZGUvcWFwaS9lcnJvci5oIHRvIG1lbnRpb24gdGhlIGV4Y2x1c2lvbg0KPj4+PiBmb3IgY2FsbGJh
Y2tzLg0KDQouLi4gZXhwbGFpbmluZyB0aGVtIGluIGRvY3VtZW50YXRpb24gaXMgZGVzaXJhYmxl
Lg0K


