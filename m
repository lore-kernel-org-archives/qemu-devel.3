Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8DBAC369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 12:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9Nxr-00048d-4b; Mon, 28 Apr 2025 08:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liucong2565@phytium.com.cn>)
 id 1u9Nxk-00048A-EG
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 08:51:56 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liucong2565@phytium.com.cn>) id 1u9Nxc-0002Rq-Uh
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 08:51:55 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwDXN03YeQ9oWQM2AA--.6726S2;
 Mon, 28 Apr 2025 20:51:36 +0800 (CST)
Received: from liucong2565$phytium.com.cn ( [175.0.73.0] ) by
 ajax-webmail-mail (Coremail) ; Mon, 28 Apr 2025 20:51:30 +0800 (GMT+08:00)
X-Originating-IP: [175.0.73.0]
Date: Mon, 28 Apr 2025 20:51:30 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: liucong2565@phytium.com.cn
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: "Dmitry Osipenko" <dmitry.osipenko@collabora.com>,
 "Sean Christopherson" <seanjc@google.com>, Jiqian.Chen@amd.com,
 akihiko.odaki@daynix.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, gert.wollny@collabora.com,
 gurchetansingh@chromium.org, hi@alyssa.is, honglei1.huang@amd.com,
 julia.zhang@amd.com, kraxel@redhat.com, marcandre.lureau@redhat.com,
 mst@redhat.com, pbonzini@redhat.com, philmd@linaro.org,
 pierre-eric.pelloux-prayer@amd.com, qemu-devel@nongnu.org,
 ray.huang@amd.com, robdclark@gmail.com, roger.pau@citrix.com,
 slp@redhat.com, stefano.stabellini@amd.com, xenia.ragiadakou@amd.com,
 zzyiwei@chromium.org
Subject: Re: Re: [PATCH v11 04/10] virtio-gpu: Support asynchronous fencing
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT6 build
 20250327(ab59d9cc) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-8dfce572-2f24-404d-b59d-0dd2e304114c-icoremail.cn
In-Reply-To: <87cycw61m8.fsf@draig.linaro.org>
References: <20250310120555.150077-5-dmitry.osipenko@collabora.com>
 <20250410095454.188105-1-liucong2565@phytium.com.cn>
 <d0e9e72a-02bf-4f1e-abe0-6e8d0d089b29@collabora.com>
 <5514d916.6d34.19622831b11.Coremail.liucong2565@phytium.com.cn>
 <425ebb80-4348-46f3-878b-054800a8fe85@collabora.com>
 <f662c725-e40e-43eb-b155-2440cff34324@collabora.com>
 <2d6e3b03.bb9.1967717fa84.Coremail.liucong2565@phytium.com.cn>
 <03414f52-def8-4b50-8da4-69b722dfc758@collabora.com>
 <87cycw61m8.fsf@draig.linaro.org>
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: 18MlVGZvb3Rlcl90eHQ9NDU3MTozODM=
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <3118467e.dc3.1967c73dca7.Coremail.liucong2565@phytium.com.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: AQAAfwAXryjTeQ9oTFkGAA--.1490W
X-CM-SenderInfo: 5olxu0lqjskluv6sx5pwlxzhxfrphubq/1tbiAQANCmgNN+cIgAAT
	so
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=liucong256
 5@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3uFWUWFyrurykuFW3JF43Wrg_yoWkAF4rp3
 WrAayUAw1UK3W7G3yfJr48ArW8JFWUWr47Jw1xKrZ8Jw1UJr1DXr9xKFWxJ3Wjg3WYqrs8
 tw17Zws8Ar1jyrDanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=liucong2565@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SSB1c2VyIFBoeXRpdW0gRDMwMDAgOCBDb3JlLCBhbmQgSSBhbSBub3Qgc3VyZSBpZiBpdCBoYXMg
YSBicm9rZW4gUENJLgoKaHR0cHM6Ly93d3cuY3B1YmVuY2htYXJrLm5ldC9jcHUucGhwP2NwdT1B
Uk0rUGh5dGl1bStEMzAwMCs4K0NvcmUrMjUwMCtNSHoKCgpSZWdhcmRzLApjb25nCgoKPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2VzLS0tLS0KPiBGcm9tOiAiQWxleCBCZW5uw6llIiA8YWxleC5iZW5u
ZWVAbGluYXJvLm9yZz4KPiBTZW5kIHRpbWU6TW9uZGF5LCAwNC8yOC8yMDI1IDE4OjA3OjExCj4g
VG86ICJEbWl0cnkgT3NpcGVua28iIDxkbWl0cnkub3NpcGVua29AY29sbGFib3JhLmNvbT4KPiBD
Yzog5YiY6IGqIDxsaXVjb25nMjU2NUBwaHl0aXVtLmNvbS5jbj4sICJTZWFuIENocmlzdG9waGVy
c29uIiA8c2VhbmpjQGdvb2dsZS5jb20+LCBKaXFpYW4uQ2hlbkBhbWQuY29tLCBha2loaWtvLm9k
YWtpQGRheW5peC5jb20sIGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20sIGNocmlzdGlhbi5rb2Vu
aWdAYW1kLmNvbSwgZ2VydC53b2xsbnlAY29sbGFib3JhLmNvbSwgZ3VyY2hldGFuc2luZ2hAY2hy
b21pdW0ub3JnLCBoaUBhbHlzc2EuaXMsIGhvbmdsZWkxLmh1YW5nQGFtZC5jb20sIGp1bGlhLnpo
YW5nQGFtZC5jb20sIGtyYXhlbEByZWRoYXQuY29tLCBtYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5j
b20sIG1zdEByZWRoYXQuY29tLCBwYm9uemluaUByZWRoYXQuY29tLCBwaGlsbWRAbGluYXJvLm9y
ZywgcGllcnJlLWVyaWMucGVsbG91eC1wcmF5ZXJAYW1kLmNvbSwgcWVtdS1kZXZlbEBub25nbnUu
b3JnLCByYXkuaHVhbmdAYW1kLmNvbSwgcm9iZGNsYXJrQGdtYWlsLmNvbSwgcm9nZXIucGF1QGNp
dHJpeC5jb20sIHNscEByZWRoYXQuY29tLCBzdGVmYW5vLnN0YWJlbGxpbmlAYW1kLmNvbSwgeGVu
aWEucmFnaWFkYWtvdUBhbWQuY29tLCB6enlpd2VpQGNocm9taXVtLm9yZwo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjExIDA0LzEwXSB2aXJ0aW8tZ3B1OiBTdXBwb3J0IGFzeW5jaHJvbm91cyBmZW5j
aW5nCj4gCj4gRG1pdHJ5IE9zaXBlbmtvIDxkbWl0cnkub3NpcGVua29AY29sbGFib3JhLmNvbT4g
d3JpdGVzOgo+IAo+ID4gT24gNC8yNy8yNSAxNDo1Mywg5YiY6IGqIHdyb3RlOgo+ID4+IEhpIERt
aXRyeSwKPiA+PiAKPiA+PiBUaGUgdmlyZ2xyZW5kZXIgcGF0Y2ggY2FuIGZpeCB0aGUgdmlyZ2wg
aXNzdWUsIGJ1dCB0aGUgbmF0aXZlIGNvbnRleHQgc3RpbGwgZmFpbHMgdG8gcnVuIG9uIG15IG1h
Y2hpbmUuCj4gPj4gSSdtIG5vdCBzdXJlIGlmIGFueW9uZSBoYXMgc3VjY2Vzc2Z1bGx5IHJ1biBp
dCBvbiBhbiBBUk02NCBtYWNoaW5lIGJlZm9yZS4KPiA+Cj4gPiBUaGFua3MgZm9yIHRoZSB0ZXN0
aW5nIQo+ID4KPiA+PiBXaGVuIHJ1bm5pbmcgd2l0aCBWZW51cywgdGhlIHZpcnR1YWwgbWFjaGlu
ZSBjYW4gc3VjY2Vzc2Z1bGx5IHJ1biB2a2N1YmUuIEhvd2V2ZXIsIHdoZW4gdXNpbmcgdGhlIG5h
dGl2ZSBjb250ZXh0LCBhIEtWTSBlcnJvciBpcyB0cmlnZ2VyZWQuIEJvdGggbXkgZ3Vlc3QgYW5k
IGhvc3Qga2VybmVscyBhcmUgYWxyZWFkeSB1cGRhdGVkIHRvIHZlcnNpb24gNi4xNC4KPiA+PiAK
PiA+PiBIZXJlIGFyZSB0aGUgY29tbWFuZHMgYW5kIGVycm9yIG1lc3NhZ2VzIEkgZW5jb3VudGVy
ZWQ6Cj4gPj4gCj4gPj4gYGBgCj4gPj4gcGh5dGl1bUB1YnVudHU6fi93b3JraW5nL3ZpcmdscmVu
ZGVyZXIkCj4gPj4gL29wdC9uYXRpdmUtY29udGV4dC12MTEvYmluL3FlbXUtc3lzdGVtLWFhcmNo
NjQgLS1tYWNoaW5lCj4gPj4gdmlydCxhY2NlbD1rdm0sbWVtb3J5LWJhY2tlbmQ9bWVtMSAtY3B1
IGhvc3QgLXNtcCA0IC1tIDRHIC1kcml2ZQo+ID4+IGZpbGU9L2hvbWUvcGh5dGl1bS93b3JraW5n
L3VidW50dTI0LjA0LWFhcmNoNjQtbmF0aXZlLWNvbnRleHQsZm9ybWF0PXJhdyxpZj12aXJ0aW8K
PiA+PiAtYmlvcyAvdXNyL3NoYXJlL0FBVk1GL0FBVk1GX0NPREUubXMuZmQgLW5ldGRldiB1c2Vy
LGlkPW5ldDAgLWRldmljZQo+ID4+IHZpcnRpby1uZXQtcGNpLG5ldGRldj1uZXQwIC1kZXZpY2UK
PiA+PiB2aXJ0aW8tZ3B1LWdsLGhvc3RtZW09NEcsYmxvYj1vbix2ZW51cz1vbiAtb2JqZWN0Cj4g
Pj4gbWVtb3J5LWJhY2tlbmQtbWVtZmQsaWQ9bWVtMSxzaXplPTRHIC1kaXNwbGF5Cj4gPj4gc2Rs
LGdsPW9uLHNob3ctY3Vyc29yPW9uIC1kZXZpY2UgdXNiLWVoY2ksaWQ9dXNiIC1kZXZpY2UKPiA+
PiB1c2ItbW91c2UsYnVzPXVzYi4wIC1kZXZpY2UgdXNiLWtiZCxidXM9dXNiLjAKPiA+PiBwaHl0
aXVtQHVidW50dTp+L3dvcmtpbmcvdmlyZ2xyZW5kZXJlciQgCj4gPj4gcGh5dGl1bUB1YnVudHU6
fi93b3JraW5nL3ZpcmdscmVuZGVyZXIkCj4gPj4gL29wdC9uYXRpdmUtY29udGV4dC12MTEvYmlu
L3FlbXUtc3lzdGVtLWFhcmNoNjQgLS1tYWNoaW5lCj4gPj4gdmlydCxhY2NlbD1rdm0sbWVtb3J5
LWJhY2tlbmQ9bWVtMSAtY3B1IGhvc3QgLXNtcCA0IC1tIDRHIC1kcml2ZQo+ID4+IGZpbGU9L2hv
bWUvcGh5dGl1bS93b3JraW5nL3VidW50dTI0LjA0LWFhcmNoNjQtbmF0aXZlLWNvbnRleHQsZm9y
bWF0PXJhdyxpZj12aXJ0aW8KPiA+PiAtYmlvcyAvdXNyL3NoYXJlL0FBVk1GL0FBVk1GX0NPREUu
bXMuZmQgLW5ldGRldiB1c2VyLGlkPW5ldDAgLWRldmljZQo+ID4+IHZpcnRpby1uZXQtcGNpLG5l
dGRldj1uZXQwIC1kZXZpY2UKPiA+PiB2aXJ0aW8tZ3B1LWdsLGhvc3RtZW09NEcsYmxvYj1vbixk
cm1fbmF0aXZlX2NvbnRleHQ9b24gLW9iamVjdAo+ID4+IG1lbW9yeS1iYWNrZW5kLW1lbWZkLGlk
PW1lbTEsc2l6ZT00RyAtZGlzcGxheQo+ID4+IHNkbCxnbD1vbixzaG93LWN1cnNvcj1vbiAtZGV2
aWNlIHVzYi1laGNpLGlkPXVzYiAtZGV2aWNlCj4gPj4gdXNiLW1vdXNlLGJ1cz11c2IuMCAtZGV2
aWNlIHVzYi1rYmQsYnVzPXVzYi4wCj4gPj4gZXJyb3I6IGt2bSBydW4gZmFpbGVkIEJhZCBhZGRy
ZXNzCj4gPj4gIFBDPTAwMDBlMmJjYmJmMzFhYjAgWDAwPTAwMDBlMmJjOWMzYWUwNjAgWDAxPTAw
MDBlMmJjN2MwMmFmMDAKPiA+PiBYMDI9MDAwMDAwMDAwMDAwMDAxNCBYMDM9MDAwMGUyYmM5YzNh
ZTAwMCBYMDQ9MDAwMGUyYmM3YzAyYWYxNAo+ID4+IFgwNT0wMDAwZTJiYzljM2FlMDc0IFgwNj0w
MDAwMDAwMDAwMDAwMjAwIFgwNz0wMDAwZTJiYzdjMDJhOGY4Cj4gPj4gWDA4PTAwMDAwMDAwMDAw
MDAwZGUgWDA5PTAwMDAwMDAwMDAwMDAyMDAgWDEwPTAwMDAwMDAwMDAwMDEwMDAKPiA+PiBYMTE9
MDAwMDAwMDAwMDAwMDAwNCBYMTI9MDAwMGUyYmM3YzAwMDBiMCBYMTM9MDAwMDAwMDAwMDAwMDAw
MQo+ID4+IFgxND0wMDAwMDAwMDAwMDAwMDIwIFgxNT0wMDAwZTJiYzllNDY1ZjkzIFgxNj0wMDAw
ZTJiY2FkNmEwMWYwCj4gPj4gWDE3PTAwMDBlMmJjYmJmMzFhODAgWDE4PTAwMDAwMDAwMDAwMDAw
OTMgWDE5PTAwMDAwMDAwMDAwMDAwNjAKPiA+PiBYMjA9MDAwMDAwMDAwMDAwMDA3NCBYMjE9MDAw
MGUyYmM5ZTQ2YzVmMCBYMjI9MDAwMGUyYmM5YzNhZTAwMAo+ID4+IFgyMz0wMDAwMDAwMDAwMDAw
MDc0IFgyND0wMDAwYzAyMjQxZGE4M2IwIFgyNT0wMDAwYzAyMjQxZGE4NWEwCj4gPj4gWDI2PTAw
MDBjMDIyNDFkYTg1YTAgWDI3PTAwMDAwMDAwMDAwMDAwMTQgWDI4PTAwMDBlMmJjOWU0NmM1ZjAK
PiA+PiBYMjk9MDAwMGUyYmM5ZTQ2YzYxMCBYMzA9MDAwMGUyYmNhYzgwOWMzOCAgU1A9MDAwMGUy
YmM5ZTQ2YzUxMAo+ID4+IFBTVEFURT0yMDAwMTAwMCAtLUMtIEVMMHQKPiA+PiBwaHl0aXVtQHVi
dW50dTp+L3dvcmtpbmcvdmlyZ2xyZW5kZXJlciQgdW5hbWUgLWEKPiA+PiBMaW51eCB1YnVudHUg
Ni4xNC4xLTA2MTQwMS1nZW5lcmljICMyMDI1MDQwNzEwNDggU01QIFBSRUVNUFRfRFlOQU1JQyBN
b24gQXByICA3IDExOjM0OjM3IFVUQyAyMDI1IGFhcmNoNjQgYWFyY2g2NCBhYXJjaDY0IEdOVS9M
aW51eAo+ID4+IGBgYAo+ID4KPiA+IEFsZXggQmVubsOpZSByZXBvcnRlZCB0aGUgdmVyeSBzYW1l
IHByb2JsZW0gd2l0aCBLVk0gb24gQVJNICsgbmF0aXZlIGN0eAo+ID4gQU1EIGRHUFUgaW4gdGhl
IHBhc3QuIFlvdSBtYXkgdHJ5IHRvIGFkZCBlcnJvciBtZXNzYWdlcyB0bwo+ID4gdmlydC9rdm0v
a3ZtX21haW4uYyBvZiBob3N0IExpbnV4IGtlcm5lbCB0byBmaW5kIGZyb20gd2hlcmUgS1ZNIGVy
cm9yCj4gPiBvcmlnaW5hdGVzLiBTb3VuZHMgbGlrZSBwYWdlIHJlZmNvdW50aW5nIG1heSBiZSBu
b3Qgd29ya2luZyBwcm9wZXJseQo+ID4gb24gQVJNLgo+IAo+IEFsc28gd2hhdCBoYXJkd2FyZSBp
cyB0aGUgbWFjaGluZT8gVGhlIEFWQSAoYW5kIG1vc3QgdGhpbmdzIHdpdGggdGhlCj4gc2FtZSBj
aGlwc2V0KSBoYXZlIGEgYnJva2VuIFBDSSB3aGljaCBuZWVkcyBhIHdvcmthcm91bmQgZm9yIHVu
YWxpZ25lZAo+IFNJTUQgYWNjZXNzOgo+IAo+ICAgaHR0cHM6Ly9naXRodWIuY29tL3N0c3F1YWQv
bGludXgvdHJlZS90ZXN0aW5nL2FsdHJhLXR3ZWFrcy1mb3ItZ3B1Cj4gCj4gPgo+ID4gK0NDOiBT
ZWFuIENocmlzdG9waGVyc29uCj4gCj4gLS0gCj4gQWxleCBCZW5uw6llCj4gVmlydHVhbGlzYXRp
b24gVGVjaCBMZWFkIEAgTGluYXJvCg0KDQrkv6Hmga/lronlhajlo7DmmI7vvJrmnKzpgq7ku7bl
jIXlkKvkv6Hmga/lvZLlj5Hku7bkurrmiYDlnKjnu4Tnu4fmiYDmnIks5Y+R5Lu25Lq65omA5Zyo
57uE57uH5a+56K+l6YKu5Lu25oul5pyJ5omA5pyJ5p2D5Yip44CC6K+35o6l5pS26ICF5rOo5oSP
5L+d5a+GLOacque7j+WPkeS7tuS6uuS5pumdouiuuOWPryzkuI3lvpflkJHku7vkvZXnrKzkuInm
lrnnu4Tnu4flkozkuKrkurrpgI/pnLLmnKzpgq7ku7bmiYDlkKvkv6Hmga/jgIINCkluZm9ybWF0
aW9uIFNlY3VyaXR5IE5vdGljZTogVGhlIGluZm9ybWF0aW9uIGNvbnRhaW5lZCBpbiB0aGlzIG1h
aWwgaXMgc29sZWx5IHByb3BlcnR5IG9mIHRoZSBzZW5kZXIncyBvcmdhbml6YXRpb24uVGhpcyBt
YWlsIGNvbW11bmljYXRpb24gaXMgY29uZmlkZW50aWFsLlJlY2lwaWVudHMgbmFtZWQgYWJvdmUg
YXJlIG9ibGlnYXRlZCB0byBtYWludGFpbiBzZWNyZWN5IGFuZCBhcmUgbm90IHBlcm1pdHRlZCB0
byBkaXNjbG9zZSB0aGUgY29udGVudHMgb2YgdGhpcyBjb21tdW5pY2F0aW9uIHRvIG90aGVycy4=


