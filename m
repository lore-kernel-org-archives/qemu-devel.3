Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F65FA1FC2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 15:40:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFZg7-0001v1-Up; Wed, 22 Apr 2026 11:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lex.bailey@lowrisc.org>)
 id 1wFZg5-0001tn-FA
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 11:39:49 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lex.bailey@lowrisc.org>)
 id 1wFZg1-0000gc-6W
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 11:39:49 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-483487335c2so55974465e9.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 08:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lowrisc.org; s=google; t=1776872383; x=1777477183; darn=nongnu.org;
 h=in-reply-to:subject:autocrypt:from:content-language:references:cc
 :to:user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=enmOA39POkkaOgp9PoQTlsHtShptC0r9dKtcKBZ7in8=;
 b=LsWY5grtO8wlVL0xjPp0Ct8jLYAlSUAp0wR3NYIqSEubYTquWMMn/N7Q41LcqrToes
 rpHjLNiMTLlv9O3knafXcEpfM9YVSbme5UeEx418qT90PtwNq3U50/HE7gqsfHrFEZB2
 O+G3aDUeJAaeRQUo6CTOXTiaB2Lgtq8LfhQSq/a+VyubSb2JSsv+Tx7gQcC4AWbBJ8ux
 RNowku7vYb3NqNxSOAez2J+Y43QGrF6nMPLJ4RSkz5ITckUfj8qrmdRIJFGQJniGTXP3
 ILtbg2NI4DTPHR/ocfwPwmyyL9i8sqnMFCnBI/nqVLWScNlTjOIYi6L48Zx+6vxWGT6Q
 4+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776872383; x=1777477183;
 h=in-reply-to:subject:autocrypt:from:content-language:references:cc
 :to:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=enmOA39POkkaOgp9PoQTlsHtShptC0r9dKtcKBZ7in8=;
 b=jVLYu5sZYfSDeyTHM8Rvx2UNet+rKQUdZS9sIMu4eqhKh+xTURNOYbxhQb4hvuucZW
 2sLKLdHqyyZwwRQ2QjfeJoc4150w/Pfxg8b/pD+hi7JP+idun14bEevXpvLjJgAyza1b
 WNuL0LM/sNFaH/lRSDGcQ6aOZDEB9tyOxfwoO1pPtoEcVnQZApaKpCnECwHm5Yj3rnZ4
 x8dlulnH3BicqFSXbQuacd2ahoujrYn83njwQnEDLR4/xgxxn6ul618pG0RrNzM/5tDt
 iQmtXY+KtQJe7igVIkT4HR3mMpRJwGOWJqvSy9Ma8Qo0QGHQ4VV5kbz0twLNKE2DvJWO
 HYBg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+evdYF+RvZS4m1vvvaEy+QfGHFnrm85NqohhlQGKen7FiIjZxmpEZ4klsnY3xZZ7BP0V8Yxt8VXpoB@nongnu.org
X-Gm-Message-State: AOJu0Yxz52pZYgZvBjq82bZQJezm9rk6/In1AElfpVv3WLsqNZDzaE3V
 /y3bAWWmwvXjLDpSyOlMVtXF635EKSu3iO+wAj3bwH0bSN3OdNR6zzVkPq7WwmdN0go=
X-Gm-Gg: AeBDiev157+T4Dne/pvaWS+V+XKD2C+ocRHz8zPYVM/p+xbX2aU1ZdYgJjJHyrOKHMz
 qcyfOWy9sUuIDZEyyHw/bixkxUmIIAQibZ0g9k/ex//aHBJx06kvio6wfvPsd9pyjWYrpDxmgUt
 iboAKo+TUZAAGRkhxPYeM34AJ8YnuQw7gs+tpVKPMCt93/WfDoQ04HT6MIDa+PY3hKrTrB5kJg3
 4NrI/JHHL7a59FNCO4P8jqoAOJ5Tkp87YwiG2Gp0Ovr4IXKLXqyyxCs5FuFmbikgECmsh5iMiuA
 5Xcgyx4nuachrLGbIdQhdn43J42cl11B01KGFrcKzUl6SeaRZ4lPS6kWTfX7Bn7rq+6aNt4Cmov
 UqH4JYo9l7Ypsm6ZODtu6Q+Hjj+D2FqER7dage8GrCxBHQw5pAb2Eu7ABP/KesXpG9oxW7dy4RL
 6qKlA5initWRwlNjai0t1fchFZQlEyr1k6ue9pCCcp0PA/
X-Received: by 2002:a05:600c:8883:b0:48a:5821:5ff2 with SMTP id
 5b1f17b1804b1-48a582167c7mr79206285e9.8.1776872382815; 
 Wed, 22 Apr 2026 08:39:42 -0700 (PDT)
Received: from [192.168.102.59] ([217.155.172.86])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891f4016bbsm70220345e9.4.2026.04.22.08.39.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 08:39:42 -0700 (PDT)
Message-ID: <460c22c9-b9bb-4e68-a793-85ddd598a311@lowrisc.org>
Date: Wed, 22 Apr 2026 16:39:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-devel@nongnu.org,
 Amit Kumar-Hermosillo <amitkh@google.com>,
 nabihestefan <nabihestefan@google.com>
References: <177618728515.4917.14466194789826252277-0@git.sr.ht>
 <177618728515.4917.14466194789826252277-10@git.sr.ht>
 <CAKmqyKOKNQwNtzX+wHepEX4OpVqAA2pkXfcP18k=8Wd+8ZM06Q@mail.gmail.com>
Content-Language: en-US
From: Lex Bailey <lex.bailey@lowrisc.org>
Autocrypt: addr=lex.bailey@lowrisc.org; keydata=
 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
 WZXWKp/svUI=
Subject: Re: [PATCH qemu v3 10/10] ot_uart: switch from clock driven
 transmission to reg R/W driven transmission
In-Reply-To: <CAKmqyKOKNQwNtzX+wHepEX4OpVqAA2pkXfcP18k=8Wd+8ZM06Q@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------jW7wtI0uKw3Kd2fF9l0Lmm9a"
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=lex.bailey@lowrisc.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------jW7wtI0uKw3Kd2fF9l0Lmm9a
Content-Type: multipart/mixed; boundary="------------watcVXhDbzCyh9oNau7qMzZw";
 protected-headers="v1"
From: Lex Bailey <lex.bailey@lowrisc.org>
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-devel@nongnu.org,
 Amit Kumar-Hermosillo <amitkh@google.com>,
 nabihestefan <nabihestefan@google.com>
Message-ID: <460c22c9-b9bb-4e68-a793-85ddd598a311@lowrisc.org>
Subject: Re: [PATCH qemu v3 10/10] ot_uart: switch from clock driven
 transmission to reg R/W driven transmission
References: <177618728515.4917.14466194789826252277-0@git.sr.ht>
 <177618728515.4917.14466194789826252277-10@git.sr.ht>
 <CAKmqyKOKNQwNtzX+wHepEX4OpVqAA2pkXfcP18k=8Wd+8ZM06Q@mail.gmail.com>
In-Reply-To: <CAKmqyKOKNQwNtzX+wHepEX4OpVqAA2pkXfcP18k=8Wd+8ZM06Q@mail.gmail.com>

--------------watcVXhDbzCyh9oNau7qMzZw
Content-Type: multipart/mixed; boundary="------------I4VVdbcefGfWqcFuuZcmJUsU"

--------------I4VVdbcefGfWqcFuuZcmJUsU
Content-Type: multipart/alternative;
 boundary="------------Eir2eoxj8u07m0KvBs2nRDhb"

--------------Eir2eoxj8u07m0KvBs2nRDhb
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPbiAxNi8wNC8yMDI2IDAzOjIxLCBBbGlzdGFpciBGcmFuY2lzIHdyb3RlOg0KPiBPbiBX
ZWQsIEFwciAxNSwgMjAyNiBhdCAzOjIy4oCvQU0gfmxleGJhaWxleWxvd3Jpc2MNCj4gPGxl
eGJhaWxleWxvd3Jpc2NAZ2l0LnNyLmh0PiB3cm90ZToNCj4+IEZyb206IExleCBCYWlsZXk8
bGV4LmJhaWxleUBsb3dyaXNjLm9yZz4NCj4+DQo+PiB0aGlzIGNvbW1pdCByZW1vdmVzIHRo
ZSBuZWVkIGZvciB0aGUgdGltZXIgYnkgaW5zdGVhZCB0cmFuc21pdHRpbmcgZnJvbSB0aGUg
VFgNCj4+IGZpZm8gYW55IHRpbWUgaXQgaGFzIGRhdGEgaW4gaXQgYW5kIGl0IGlzIGVuYWJs
ZWQuIFRoaXMgY2FzZSBjYW4gb25seSBhcmlzZQ0KPj4gZnJvbSBhIHdyaXRlIHRvIG9uZSBv
ZiB0aGUgcmVnaXN0ZXJzIGluIHRoZSBVQVJULCBzbyB0aGUgZGV2aWNlIHdpbGwgc3RpbGwg
d29yaw0KPj4gZnVsbHkgd2l0aG91dCB0aGUgdGltZXIuDQo+ICBGcm9tIG1lbW9yeSB0aGUg
dGltZXIgd2FzIGluY2x1ZGVkIHRvIG1vcmUgYWNjdXJhdGVseSBtb2RlbCByZWFsDQo+IGhh
cmR3YXJlLCB3aGljaCBkb2Vzbid0IHdyaXRlIGluc3RhbnRseSBhbmQgaW5zdGVhZCBoYXMg
YSBkZWxheS4NCj4NCj4gSSBhbHNvIHJlbWVtYmVyIHRoYXQgaWYgd2UgZG9uJ3QgaGF2ZSB0
aGUgdGltZXIgYW5kIGRlbGF5IHRoZSBVQVJUIGluDQo+IFRvY2sgd291bGRuJ3Qgd29yaywg
YXMgVG9jayBleHBlY3RlZCBhIGRlbGF5IGJldHdlZW4gd3JpdGluZyB0aGUNCj4gYnVmZmVy
cyBhbmQgdGhlIGludGVycnVwdCBvY2N1cnJpbmcuIEhhdmUgeW91IHRlc3RlZCB0aGF0IFRv
Y2sgc3RpbGwNCj4gd29ya3MgYWZ0ZXIgdGhpcyBjaGFuZ2U/DQo+DQo+IEFsaXN0YWlyDQoN
CkkgaGF2ZSBmZXRjaGVkIGFuZCBidWlsdCB0b2NrIGFuZCBydW4gdGhlIGVhcmxncmV5IHRl
c3RzIHdpdGggcWVtdS4NCg0KSSB0ZXN0ZWQgdGhyZWUgc2NlbmFyaW9zOg0KDQoxLiBSdW5u
aW5nIG9uIHRoZSBzYW1lIGNvbW1pdCBoYXNoIGFzIHJ1bnMgaW4gdG9jaydzIENJLg0KDQoy
LiBSdW5uaW5nIG9uIHRoZSBjb21taXQgdXBvbiB3aGljaCBJIGJhc2VkIHRoZXNlIGNoYW5n
ZXMNCg0KMy4gUnVubmluZyB3aXRoIGFsbCBteSBwcm9wb3NlZCBjaGFuZ2VzIGluY2x1ZGVk
Lg0KDQpBbGwgdGhyZWUgb2YgdGhlc2UgcHJvZHVjZSB0aGUgc2FtZSBvdXRwdXQsIHdoaWNo
IGNvbWVzIHRocm91Z2ggdGhlIFVBUlQgDQpvbiB0aGUgb3BlbnRpdGFuLCBhbmQgSSBoYXZl
IGNoZWNrZWQgdG8gYmUgc3VyZSBpdCBpcyB1c2luZyB0aGUgbmV3IGNvZGUgDQppbiB0aGUg
Y2FzZSBvZiBzY2VuYXJpbyAzLg0KDQpJJ20gbm90IHN1cmUgd2hhdCBleGFjdGx5IHRob3Nl
IHRlc3RzIGRvLCBhbmQgc28gSSBkb24ndCBrbm93IGlmIHRoZXkgDQpyZWx5IGF0IGFsbCBv
biBhbnkgb2YgdGhlIGludGVycnVwdHMsIElzIHRoYXQgYSBzdWZmaWNpZW50IHRlc3Q/IE9y
IGlzIA0KdGhlcmUgc29tZXRoaW5nIGVsc2UgSSB3b3VsZCBuZWVkIHRvIHRlc3QgZm9yIHRo
aXM/DQoNCj4NCj4+IFNpZ25lZC1vZmYtYnk6IExleCBCYWlsZXk8bGV4LmJhaWxleUBsb3dy
aXNjLm9yZz4NCj4+IC0tLQ0KPj4gICBody9jaGFyL290X3VhcnQuYyAgICAgICAgIHwgOTEg
KysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+PiAgIGh3L2NoYXIv
dHJhY2UtZXZlbnRzICAgICAgfCAgMiArLQ0KPj4gICBpbmNsdWRlL2h3L2NoYXIvb3RfdWFy
dC5oIHwgMTUgKystLS0tLQ0KPj4gICAzIGZpbGVzIGNoYW5nZWQsIDQwIGluc2VydGlvbnMo
KyksIDY4IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody9jaGFyL290X3Vh
cnQuYyBiL2h3L2NoYXIvb3RfdWFydC5jDQo+PiBpbmRleCA5MTBiZWYwMGYyLi5hZjBjZjll
ZTFhIDEwMDY0NA0KPj4gLS0tIGEvaHcvY2hhci9vdF91YXJ0LmMNCj4+ICsrKyBiL2h3L2No
YXIvb3RfdWFydC5jDQo+PiBAQCAtMjAsOSArMjAsMTAgQEANCj4+ICAgI2luY2x1ZGUgInFl
bXUvb3NkZXAuaCINCj4+ICAgI2luY2x1ZGUgImh3L2NoYXIvb3RfdWFydC5oIg0KPj4gICAj
aW5jbHVkZSAicWVtdS9maWZvOC5oIg0KPj4gKyNpbmNsdWRlICJxYXBpL2Vycm9yLmgiDQo+
PiArI2luY2x1ZGUgImNoYXJkZXYvY2hhci1mZS5oIg0KPj4gICAjaW5jbHVkZSAiaHcvY29y
ZS9jcHUuaCINCj4+ICAgI2luY2x1ZGUgImh3L2NvcmUvaXJxLmgiDQo+PiAtI2luY2x1ZGUg
Imh3L2NvcmUvcWRldi1jbG9jay5oIg0KPj4gICAjaW5jbHVkZSAiaHcvY29yZS9xZGV2LXBy
b3BlcnRpZXMuaCINCj4+ICAgI2luY2x1ZGUgImh3L2NvcmUvcWRldi1wcm9wZXJ0aWVzLXN5
c3RlbS5oIg0KPj4gICAjaW5jbHVkZSAiaHcvY29yZS9yZWdpc3RlcmZpZWxkcy5oIg0KPj4g
QEAgLTE1Miw2ICsxNTMsMTggQEAgc3RhdGljIGJvb2wgb3RfdWFydF9pc19yeF9lbmFibGVk
KGNvbnN0IE90VUFSVFN0YXRlICpzKQ0KPj4gICAgICAgcmV0dXJuIEZJRUxEX0VYMzIocy0+
cmVnc1tSX0NUUkxdLCBDVFJMLCBSWCk7DQo+PiAgIH0NCj4+DQo+PiArc3RhdGljIHZvaWQg
b3RfdWFydF9jaGVja19iYXVkcmF0ZShjb25zdCBPdFVBUlRTdGF0ZSAqcykNCj4+ICt7DQo+
PiArICAgIHVpbnQzMl90IG5jbyA9IEZJRUxEX0VYMzIocy0+cmVnc1tSX0NUUkxdLCBDVFJM
LCBOQ08pOw0KPj4gKw0KPj4gKyAgICB1bnNpZ25lZCBiYXVkcmF0ZSA9ICh1bnNpZ25lZCko
KCh1aW50NjRfdCluY28gKiAodWludDY0X3Qpcy0+cGNsaykgPj4NCj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIChSX0NUUkxfTkNPX0xFTkdUSCArIDQpKTsNCj4+
ICsNCj4+ICsgICAgaWYgKGJhdWRyYXRlKSB7DQo+PiArICAgICAgICB0cmFjZV9vdF91YXJ0
X2NoZWNrX2JhdWRyYXRlKHMtPm90X2lkLCBzLT5wY2xrLCBiYXVkcmF0ZSk7DQo+PiArICAg
IH0NCj4+ICt9DQo+PiArDQo+PiAgIHN0YXRpYyBpbnQgb3RfdWFydF9jYW5fcmVjZWl2ZSh2
b2lkICpvcGFxdWUpDQo+PiAgIHsNCj4+ICAgICAgIE90VUFSVFN0YXRlICpzID0gb3BhcXVl
Ow0KPj4gQEAgLTI4NCw3ICsyOTcsNiBAQCBzdGF0aWMgdm9pZCBvdF91YXJ0X3htaXQoT3RV
QVJUU3RhdGUgKnMpDQo+Pg0KPj4gICBzdGF0aWMgdm9pZCB1YXJ0X3dyaXRlX3R4X2ZpZm8o
T3RVQVJUU3RhdGUgKnMsIHVpbnQ4X3QgdmFsKQ0KPj4gICB7DQo+PiAtICAgIHVpbnQ2NF90
IGN1cnJlbnRfdGltZSA9IHFlbXVfY2xvY2tfZ2V0X25zKFFFTVVfQ0xPQ0tfVklSVFVBTCk7
DQo+PiAgICAgICBpZiAoZmlmbzhfaXNfZnVsbCgmcy0+dHhfZmlmbykpIHsNCj4+ICAgICAg
ICAgICBxZW11X2xvZ19tYXNrKExPR19HVUVTVF9FUlJPUiwgIm90X3VhcnQ6IFRYIEZJRk8g
b3ZlcmZsb3ciKTsNCj4+ICAgICAgICAgICByZXR1cm47DQo+PiBAQCAtMzA1LDkgKzMxNyw2
IEBAIHN0YXRpYyB2b2lkIHVhcnRfd3JpdGVfdHhfZmlmbyhPdFVBUlRTdGF0ZSAqcywgdWlu
dDhfdCB2YWwpDQo+PiAgICAgICBpZiAob3RfdWFydF9pc190eF9lbmFibGVkKHMpKSB7DQo+
PiAgICAgICAgICAgb3RfdWFydF94bWl0KHMpOw0KPj4gICAgICAgfQ0KPj4gLQ0KPj4gLSAg
ICB0aW1lcl9tb2Qocy0+Zmlmb190cmlnZ2VyX2hhbmRsZSwgY3VycmVudF90aW1lICsNCj4+
IC0gICAgICAgICAgICAgIChzLT5jaGFyX3R4X3RpbWUgKiA0KSk7DQo+PiAgIH0NCj4+DQo+
PiAgIHN0YXRpYyB2b2lkIG90X3VhcnRfcmVzZXRfZW50ZXIoT2JqZWN0ICpvYmosIFJlc2V0
VHlwZSB0eXBlKQ0KPj4gQEAgLTMyOCwxMSArMzM3LDYgQEAgc3RhdGljIHZvaWQgb3RfdWFy
dF9yZXNldF9lbnRlcihPYmplY3QgKm9iaiwgUmVzZXRUeXBlIHR5cGUpDQo+PiAgICAgICBv
dF91YXJ0X3Jlc2V0X3R4X2ZpZm8ocyk7DQo+PiAgICAgICBvdF91YXJ0X3Jlc2V0X3J4X2Zp
Zm8ocyk7DQo+Pg0KPj4gLSAgICBzLT50eF9sZXZlbCA9IDA7DQo+PiAtICAgIHMtPnJ4X2xl
dmVsID0gMDsNCj4+IC0NCj4+IC0gICAgcy0+Y2hhcl90eF90aW1lID0gKE5BTk9TRUNPTkRT
X1BFUl9TRUNPTkQgLyAyMzA0MDApICogMTA7DQo+PiAtDQo+PiAgICAgICAvKg0KPj4gICAg
ICAgICogZG8gbm90IHJlc2V0IGBzLT5pbl9icmVha2AsIGFzIHRoYXQgdHJhY2tzIHdoZXRo
ZXIgd2UgYXJlIGN1cnJlbnRseQ0KPj4gICAgICAgICogcmVjZWl2aW5nIGEgYnJlYWsgY29u
ZGl0aW9uIG92ZXIgVUFSVCBSWCBmcm9tIHNvbWUgZGV2aWNlIHRhbGtpbmcNCj4+IEBAIC0z
OTksMTkgKzQwMywxNiBAQCBzdGF0aWMgZ2Jvb2xlYW4gb3RfdWFydF93YXRjaF9jYih2b2lk
ICpkb19ub3RfdXNlLCBHSU9Db25kaXRpb24gY29uZCwNCj4+ICAgICAgIHJldHVybiBGQUxT
RTsNCj4+ICAgfQ0KPj4NCj4+IC1zdGF0aWMgdWludDY0X3Qgb3RfdWFydF9nZXRfYmF1ZChP
dFVBUlRTdGF0ZSAqcykNCj4+ICtzdGF0aWMgdm9pZCBvdF91YXJ0X2Nsb2NrX2lucHV0KHZv
aWQgKm9wYXF1ZSwgaW50IGlycSwgaW50IGxldmVsKQ0KPj4gICB7DQo+PiAtICAgIHVpbnQ2
NF90IGJhdWQ7DQo+PiArICAgIE90VUFSVFN0YXRlICpzID0gb3BhcXVlOw0KPj4NCj4+IC0g
ICAgYmF1ZCA9ICgocy0+cmVnc1tSX0NUUkxdICYgUl9DVFJMX05DT19NQVNLKSA+PiAxNik7
DQo+PiAtICAgIGJhdWQgKj0gY2xvY2tfZ2V0X2h6KHMtPmZfY2xrKTsNCj4+IC0gICAgYmF1
ZCA+Pj0gMjA7DQo+PiArICAgIGdfYXNzZXJ0KGlycSA9PSAwKTsNCj4+DQo+PiAtICAgIGlm
IChiYXVkKSB7DQo+PiAtICAgICAgICB0cmFjZV9vdF91YXJ0X2NoZWNrX2JhdWRyYXRlKHMt
Pm90X2lkLCBiYXVkKTsNCj4+IC0gICAgfQ0KPj4gKyAgICBzLT5wY2xrID0gKHVuc2lnbmVk
KWxldmVsOw0KPj4NCj4+IC0gICAgcmV0dXJuIGJhdWQ7DQo+PiArICAgIC8qIFRPRE86IGRp
c2FibGUgVUFSVCB0cmFuc2ZlciB3aGVuIFBDTEsgaXMgMCAqLw0KPj4gKyAgICBvdF91YXJ0
X2NoZWNrX2JhdWRyYXRlKHMpOw0KPj4gICB9DQo+Pg0KPj4gICBzdGF0aWMgdWludDY0X3Qg
b3RfdWFydF9yZWFkKHZvaWQgKm9wYXF1ZSwgaHdhZGRyIGFkZHIsIHVuc2lnbmVkIGludCBz
aXplKQ0KPj4gQEAgLTU1Myw4ICs1NTQsNiBAQCBzdGF0aWMgdm9pZCBvdF91YXJ0X3dyaXRl
KHZvaWQgKm9wYXF1ZSwgaHdhZGRyIGFkZHIsIHVpbnQ2NF90IHZhbDY0LA0KPj4gICAgICAg
ICAgIC8qIFRoaXMgd2lsbCBhbHNvIHNldCBhbiBJUlEgb25jZSB0aGUgYWxlcnQgaGFuZGxl
ciBpcyBhZGRlZCAqLw0KPj4gICAgICAgICAgIGJyZWFrOw0KPj4gICAgICAgY2FzZSBSX0NU
Ukw6DQo+PiAtICAgICAgICBzLT5yZWdzW1JfQ1RSTF0gPSB2YWx1ZTsNCj4+IC0NCj4+ICAg
ICAgICAgICBpZiAodmFsdWUgJiBSX0NUUkxfTkZfTUFTSykgew0KPj4gICAgICAgICAgICAg
ICBxZW11X2xvZ19tYXNrKExPR19VTklNUCwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAiJXM6IFVBUlRfQ1RSTF9ORiBpcyBub3Qgc3VwcG9ydGVkXG4iLCBfX2Z1bmNfXyk7
DQo+PiBAQCAtNTc3LDEwICs1NzYsMTkgQEAgc3RhdGljIHZvaWQgb3RfdWFydF93cml0ZSh2
b2lkICpvcGFxdWUsIGh3YWRkciBhZGRyLCB1aW50NjRfdCB2YWw2NCwNCj4+ICAgICAgICAg
ICAgICAgcWVtdV9sb2dfbWFzayhMT0dfVU5JTVAsDQo+PiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIiVzOiBVQVJUX0NUUkxfUlhCTFZMIGlzIG5vdCBzdXBwb3J0ZWRcbiIsIF9f
ZnVuY19fKTsNCj4+ICAgICAgICAgICB9DQo+PiAtICAgICAgICBpZiAodmFsdWUgJiBSX0NU
UkxfTkNPX01BU0spIHsNCj4+IC0gICAgICAgICAgICB1aW50NjRfdCBiYXVkID0gb3RfdWFy
dF9nZXRfYmF1ZChzKTsNCj4+IC0NCj4+IC0gICAgICAgICAgICBzLT5jaGFyX3R4X3RpbWUg
PSAoTkFOT1NFQ09ORFNfUEVSX1NFQ09ORCAvIGJhdWQpICogMTA7DQo+PiArICAgICAgICB1
aW50MzJfdCBwcmV2ID0gcy0+cmVnc1tSX0NUUkxdOw0KPj4gKyAgICAgICAgcy0+cmVnc1tS
X0NUUkxdID0gdmFsdWUgJiBDVFJMX01BU0s7DQo+PiArICAgICAgICB1aW50MzJfdCBjaGFu
Z2UgPSBwcmV2IF4gcy0+cmVnc1tSX0NUUkxdOw0KPj4gKyAgICAgICAgaWYgKGNoYW5nZSAm
IFJfQ1RSTF9OQ09fTUFTSykgew0KPj4gKyAgICAgICAgICAgIG90X3VhcnRfY2hlY2tfYmF1
ZHJhdGUocyk7DQo+PiArICAgICAgICB9DQo+PiArICAgICAgICBpZiAoKGNoYW5nZSAmIFJf
Q1RSTF9SWF9NQVNLKSAmJiBvdF91YXJ0X2lzX3J4X2VuYWJsZWQocykgJiYNCj4+ICsgICAg
ICAgICAgICAhb3RfdWFydF9pc19zeXNfbG9vcGFja19lbmFibGVkKHMpKSB7DQo+PiArICAg
ICAgICAgICAgcWVtdV9jaHJfZmVfYWNjZXB0X2lucHV0KCZzLT5jaHIpOw0KPj4gKyAgICAg
ICAgfQ0KPj4gKyAgICAgICAgaWYgKChjaGFuZ2UgJiBSX0NUUkxfVFhfTUFTSykgJiYgb3Rf
dWFydF9pc190eF9lbmFibGVkKHMpKSB7DQo+PiArICAgICAgICAgICAgLyogdHJ5IHNlbmRp
bmcgcGVuZGluZyBkYXRhIGZyb20gVFggRklGTyBpZiBhbnkgKi8NCj4+ICsgICAgICAgICAg
ICBvdF91YXJ0X3htaXQocyk7DQo+PiAgICAgICAgICAgfQ0KPj4gICAgICAgICAgIGJyZWFr
Ow0KPj4gICAgICAgY2FzZSBSX1dEQVRBOg0KPj4gQEAgLTYyOCwyNSArNjM2LDYgQEAgc3Rh
dGljIHZvaWQgb3RfdWFydF93cml0ZSh2b2lkICpvcGFxdWUsIGh3YWRkciBhZGRyLCB1aW50
NjRfdCB2YWw2NCwNCj4+ICAgICAgIH0NCj4+ICAgfQ0KPj4NCj4+IC1zdGF0aWMgdm9pZCBv
dF91YXJ0X2Nsa191cGRhdGUodm9pZCAqb3BhcXVlLCBDbG9ja0V2ZW50IGV2ZW50KQ0KPj4g
LXsNCj4+IC0gICAgT3RVQVJUU3RhdGUgKnMgPSBvcGFxdWU7DQo+PiAtDQo+PiAtICAgIC8q
IHJlY29tcHV0ZSB1YXJ0J3Mgc3BlZWQgb24gY2xvY2sgY2hhbmdlICovDQo+PiAtICAgIHVp
bnQ2NF90IGJhdWQgPSBvdF91YXJ0X2dldF9iYXVkKHMpOw0KPj4gLQ0KPj4gLSAgICBzLT5j
aGFyX3R4X3RpbWUgPSAoTkFOT1NFQ09ORFNfUEVSX1NFQ09ORCAvIGJhdWQpICogMTA7DQo+
PiAtfQ0KPj4gLQ0KPj4gLXN0YXRpYyB2b2lkIGZpZm9fdHJpZ2dlcl91cGRhdGUodm9pZCAq
b3BhcXVlKQ0KPj4gLXsNCj4+IC0gICAgT3RVQVJUU3RhdGUgKnMgPSBvcGFxdWU7DQo+PiAt
DQo+PiAtICAgIGlmIChzLT5yZWdzW1JfQ1RSTF0gJiBSX0NUUkxfVFhfTUFTSykgew0KPj4g
LSAgICAgICAgb3RfdWFydF94bWl0KHMpOw0KPj4gLSAgICB9DQo+PiAtfQ0KPj4gLQ0KPj4g
ICBzdGF0aWMgY29uc3QgTWVtb3J5UmVnaW9uT3BzIG90X3VhcnRfb3BzID0gew0KPj4gICAg
ICAgLnJlYWQgPSBvdF91YXJ0X3JlYWQsDQo+PiAgICAgICAud3JpdGUgPSBvdF91YXJ0X3dy
aXRlLA0KPj4gQEAgLTY2NSwxNSArNjU0LDEyIEBAIHN0YXRpYyBpbnQgb3RfdWFydF9wb3N0
X2xvYWQodm9pZCAqb3BhcXVlLCBpbnQgdmVyc2lvbl9pZCkNCj4+DQo+PiAgIHN0YXRpYyBj
b25zdCBWTVN0YXRlRGVzY3JpcHRpb24gdm1zdGF0ZV9vdF91YXJ0ID0gew0KPj4gICAgICAg
Lm5hbWUgPSBUWVBFX09UX1VBUlQsDQo+PiAtICAgIC52ZXJzaW9uX2lkID0gMiwNCj4+IC0g
ICAgLm1pbmltdW1fdmVyc2lvbl9pZCA9IDIsDQo+PiArICAgIC52ZXJzaW9uX2lkID0gMywN
Cj4+ICsgICAgLm1pbmltdW1fdmVyc2lvbl9pZCA9IDMsDQo+PiAgICAgICAucG9zdF9sb2Fk
ID0gb3RfdWFydF9wb3N0X2xvYWQsDQo+PiAgICAgICAuZmllbGRzID0gKGNvbnN0IFZNU3Rh
dGVGaWVsZFtdKSB7DQo+PiAgICAgICAgICAgVk1TVEFURV9TVFJVQ1QodHhfZmlmbywgT3RV
QVJUU3RhdGUsIDEsIHZtc3RhdGVfZmlmbzgsIEZpZm84KSwNCj4+ICAgICAgICAgICBWTVNU
QVRFX1NUUlVDVChyeF9maWZvLCBPdFVBUlRTdGF0ZSwgMSwgdm1zdGF0ZV9maWZvOCwgRmlm
bzgpLA0KPj4gLSAgICAgICAgVk1TVEFURV9VSU5UMzIodHhfbGV2ZWwsIE90VUFSVFN0YXRl
KSwNCj4+IC0gICAgICAgIFZNU1RBVEVfVUlOVDY0KGNoYXJfdHhfdGltZSwgT3RVQVJUU3Rh
dGUpLA0KPj4gLSAgICAgICAgVk1TVEFURV9USU1FUl9QVFIoZmlmb190cmlnZ2VyX2hhbmRs
ZSwgT3RVQVJUU3RhdGUpLA0KPj4gICAgICAgICAgIFZNU1RBVEVfQVJSQVkocmVncywgT3RV
QVJUU3RhdGUsIFJFR1NfQ09VTlQsIDEsIHZtc3RhdGVfaW5mb191aW50MzIsDQo+PiAgICAg
ICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCksDQo+PiAgICAgICAgICAgVk1TVEFURV9F
TkRfT0ZfTElTVCgpDQo+PiBAQCAtNzA4LDEwICs2OTQsNiBAQCBzdGF0aWMgdm9pZCBvdF91
YXJ0X2luaXQoT2JqZWN0ICpvYmopDQo+PiAgIHsNCj4+ICAgICAgIE90VUFSVFN0YXRlICpz
ID0gT1RfVUFSVChvYmopOw0KPj4NCj4+IC0gICAgcy0+Zl9jbGsgPSBxZGV2X2luaXRfY2xv
Y2tfaW4oREVWSUNFKG9iaiksICJmX2Nsb2NrIiwNCj4+IC0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgb3RfdWFydF9jbGtfdXBkYXRlLCBzLCBDbG9ja1VwZGF0ZSk7DQo+
PiAtICAgIGNsb2NrX3NldF9oeihzLT5mX2NsaywgT1RfVUFSVF9DTE9DSyk7DQo+PiAtDQo+
PiAgICAgICBmb3IgKHVuc2lnbmVkIGluZGV4ID0gMDsgaW5kZXggPCBPVF9VQVJUX0lSUV9O
VU07IGluZGV4KyspIHsNCj4+ICAgICAgICAgICBzeXNidXNfaW5pdF9pcnEoU1lTX0JVU19E
RVZJQ0Uob2JqKSwgJnMtPmlycXNbaW5kZXhdKTsNCj4+ICAgICAgIH0NCj4+IEBAIC03MzUs
OCArNzE3LDcgQEAgc3RhdGljIHZvaWQgb3RfdWFydF9yZWFsaXplKERldmljZVN0YXRlICpk
ZXYsIEVycm9yICoqZXJycCkNCj4+DQo+PiAgICAgICBnX2Fzc2VydChzLT5vdF9pZCk7DQo+
Pg0KPj4gLSAgICBzLT5maWZvX3RyaWdnZXJfaGFuZGxlID0gdGltZXJfbmV3X25zKFFFTVVf
Q0xPQ0tfVklSVFVBTCwNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBmaWZvX3RyaWdnZXJfdXBkYXRlLCBzKTsNCj4+ICsgICAgcWRldl9pbml0X2dw
aW9faW5fbmFtZWQoREVWSUNFKHMpLCAmb3RfdWFydF9jbG9ja19pbnB1dCwgImNsb2NrLWlu
IiwgMSk7DQo+Pg0KPj4gICAgICAgZmlmbzhfY3JlYXRlKCZzLT50eF9maWZvLCBPVF9VQVJU
X1RYX0ZJRk9fU0laRSk7DQo+PiAgICAgICBmaWZvOF9jcmVhdGUoJnMtPnJ4X2ZpZm8sIE9U
X1VBUlRfUlhfRklGT19TSVpFKTsNCj4+IGRpZmYgLS1naXQgYS9ody9jaGFyL3RyYWNlLWV2
ZW50cyBiL2h3L2NoYXIvdHJhY2UtZXZlbnRzDQo+PiBpbmRleCAxN2NjOWFkMmQ1Li5jODU5
ZDhhZjRlIDEwMDY0NA0KPj4gLS0tIGEvaHcvY2hhci90cmFjZS1ldmVudHMNCj4+ICsrKyBi
L2h3L2NoYXIvdHJhY2UtZXZlbnRzDQo+PiBAQCAtMTQzLDcgKzE0Myw3IEBAIGh0aWZfdWFy
dF93cml0ZV90b19ob3N0KHVpbnQ4X3QgZGV2aWNlLCB1aW50OF90IGNtZCwgdWludDY0X3Qg
cGF5bG9hZCkiZGV2aWNlOiBodGlmX3VhcnRfdW5rbm93bl9kZXZpY2VfY29tbWFuZCh1aW50
OF90IGRldmljZSwgdWludDhfdCANCj4+IGNtZCwgdWludDY0X3QgcGF5bG9hZCkgImRldmlj
ZTogJXUgY21kOiAlMDJ1IHBheWxvYWQ6ICUwMTYiIFBSSXg2NA0KPj4NCj4+ICAgIyBvdF91
YXJ0LmMNCj4+IC1vdF91YXJ0X2NoZWNrX2JhdWRyYXRlKGNvbnN0IGNoYXIgKmlkLCB1bnNp
Z25lZCBiYXVkKSAiJXM6ICV1IGJwcyINCj4+ICtvdF91YXJ0X2NoZWNrX2JhdWRyYXRlKGNv
bnN0IGNoYXIgKmlkLCB1bnNpZ25lZCBwY2xrLCB1bnNpZ25lZCBiYXVkKSAiJXM6IEAgJXUg
SHo6ICV1IGJwcyINCj4+ICAgb3RfdWFydF9jb25uZWN0X2lucHV0X2Nsb2NrKGNvbnN0IGNo
YXIgKmlkLCBjb25zdCBjaGFyICogc3JjbmFtZSkgIiVzOiAlcyINCj4+ICAgb3RfdWFydF9k
ZWJ1Zyhjb25zdCBjaGFyICppZCwgY29uc3QgY2hhciAqbXNnKSAiJXM6ICVzIg0KPj4gICBv
dF91YXJ0X2lvX3JlYWRfb3V0KGNvbnN0IGNoYXIgKmlkLCB1aW50MzJfdCBhZGRyLCBjb25z
dCBjaGFyICpyZWduYW1lLCB1aW50MzJfdCB2YWwsIHVpbnQzMl90IHBjKSAiJXM6IGFkZHI9
MHglMDJ4ICglcyksIHZhbD0weCV4LCBwYz0weCV4Ig0KPj4gZGlmZiAtLWdpdCBhL2luY2x1
ZGUvaHcvY2hhci9vdF91YXJ0LmggYi9pbmNsdWRlL2h3L2NoYXIvb3RfdWFydC5oDQo+PiBp
bmRleCAyZjUzOGUxZjZmLi43YzJiNWYzNDU3IDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9o
dy9jaGFyL290X3VhcnQuaA0KPj4gKysrIGIvaW5jbHVkZS9ody9jaGFyL290X3VhcnQuaA0K
Pj4gQEAgLTIzLDExICsyMyw4IEBADQo+PiAgICNpbmNsdWRlICJody9jb3JlL3N5c2J1cy5o
Ig0KPj4gICAjaW5jbHVkZSAicWVtdS9maWZvOC5oIg0KPj4gICAjaW5jbHVkZSAiY2hhcmRl
di9jaGFyLWZlLmgiDQo+PiAtI2luY2x1ZGUgInFlbXUvdGltZXIuaCINCj4+ICAgI2luY2x1
ZGUgInFvbS9vYmplY3QuaCINCj4+DQo+PiAtI2RlZmluZSBPVF9VQVJUX0NMT0NLIDUwMDAw
MDAwIC8qIDUwTUh6IGNsb2NrICovDQo+PiAtDQo+PiAgICNkZWZpbmUgVFlQRV9PVF9VQVJU
ICJvdC11YXJ0Ig0KPj4gICBPQkpFQ1RfREVDTEFSRV9UWVBFKE90VUFSVFN0YXRlLCBPdFVB
UlRDbGFzcywgT1RfVUFSVCkNCj4+DQo+PiBAQCAtMzksMTMgKzM2LDYgQEAgc3RydWN0IE90
VUFSVFN0YXRlIHsNCj4+ICAgICAgIE1lbW9yeVJlZ2lvbiBtbWlvOw0KPj4gICAgICAgcWVt
dV9pcnEgaXJxc1s5XTsNCj4+DQo+PiAtICAgIHVpbnQzMl90IHR4X2xldmVsOw0KPj4gLQ0K
Pj4gLSAgICB1aW50MzJfdCByeF9sZXZlbDsNCj4+IC0NCj4+IC0gICAgUUVNVVRpbWVyICpm
aWZvX3RyaWdnZXJfaGFuZGxlOw0KPj4gLSAgICB1aW50NjRfdCBjaGFyX3R4X3RpbWU7DQo+
PiAtDQo+PiAgICAgICB1aW50MzJfdCByZWdzWzEzXTsgLyogTGVuZ3RoIG11c3QgYmUgdXBk
YXRlZCBpZiByZWdzIGFkZGVkIG9yIHJlbW92ZWQgKi8NCj4+DQo+PiAgICAgICBGaWZvOCB0
eF9maWZvOw0KPj4gQEAgLTUzLDEwICs0MywxMSBAQCBzdHJ1Y3QgT3RVQVJUU3RhdGUgew0K
Pj4gICAgICAgdWludDMyX3QgdHhfd2F0ZXJtYXJrX2xldmVsOw0KPj4gICAgICAgYm9vbCBp
bl9icmVhazsNCj4+ICAgICAgIGd1aW50IHdhdGNoX3RhZzsNCj4+ICsgICAgdW5zaWduZWQg
cGNsazsgLyogQ3VycmVudCBpbnB1dCBjbG9jayAqLw0KPj4gKyAgICBjb25zdCBjaGFyICpj
bG9ja19zcmNfbmFtZTsgLyogSVJRIG5hbWUgb25jZSBjb25uZWN0ZWQgKi8NCj4+DQo+PiAg
ICAgICBjaGFyICpvdF9pZDsNCj4+IC0gICAgQ2xvY2sgKmZfY2xrOw0KPj4gLQ0KPj4gKyAg
ICBEZXZpY2VTdGF0ZSAqY2xvY2tfc3JjOw0KPj4gICAgICAgQ2hhckZyb250ZW5kIGNocjsN
Cj4+ICAgICAgIGJvb2wgb3ZlcnNhbXBsZV9icmVhazsgLyogU2hvdWxkIG1vY2sgYnJlYWsg
aW4gdGhlIG92ZXJzYW1wbGVkIFZBTCByZWc/ICovDQo+PiAgICAgICBib29sIHRvZ2dsZV9i
cmVhazsgLyogQXJlIGluY29taW5nIGJyZWFrcyB0ZW1wb3Jhcnkgb3IgdG9nZ2xlZD8gKi8N
Cj4+IC0tDQo+PiAyLjQ5LjENCj4+DQotLSANCkxleCBCYWlsZXkgKHRoZXkvdGhlbSkNCmxv
d1JJU0MgQy5JLkMuIDcgSGlsbHMgUm9hZCwgQ2FtYnJpZGdlLCBDQjIgMUdFLCBVSy4gUmVn
aXN0ZXJlZCBpbiANCkVuZ2xhbmQgJiBXYWxlcyAwOTI3MjI4MyBsZXguYmFpbGV5QGxvd3Jp
c2Mub3JnDQo=
--------------Eir2eoxj8u07m0KvBs2nRDhb
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF=
-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class=3D"moz-cite-prefix">On 16/04/2026 03:21, Alistair Francis
      wrote:<br>
    </div>
    <blockquote type=3D"cite"
cite=3D"mid:CAKmqyKOKNQwNtzX+wHepEX4OpVqAA2pkXfcP18k=3D8Wd+8ZM06Q@mail.gm=
ail.com">
      <pre wrap=3D"" class=3D"moz-quote-pre">On Wed, Apr 15, 2026 at 3:22=
=E2=80=AFAM ~lexbaileylowrisc
<a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:lexbaileylowrisc@git.sr=
=2Eht">&lt;lexbaileylowrisc@git.sr.ht&gt;</a> wrote:
</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"" class=3D"moz-quote-pre">
From: Lex Bailey <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:lex.ba=
iley@lowrisc.org">&lt;lex.bailey@lowrisc.org&gt;</a>

this commit removes the need for the timer by instead transmitting from t=
he TX
fifo any time it has data in it and it is enabled. This case can only ari=
se
from a write to one of the registers in the UART, so the device will stil=
l work
fully without the timer.
</pre>
      </blockquote>
      <pre wrap=3D"" class=3D"moz-quote-pre">
=46rom memory the timer was included to more accurately model real
hardware, which doesn't write instantly and instead has a delay.

I also remember that if we don't have the timer and delay the UART in
Tock wouldn't work, as Tock expected a delay between writing the
buffers and the interrupt occurring. Have you tested that Tock still
works after this change?

Alistair</pre>
    </blockquote>
    <p>I have fetched and built tock and run the earlgrey tests with
      qemu.</p>
    <p>I tested three scenarios:</p>
    <p>1. Running on the same commit hash as runs in tock's CI.</p>
    <p>2. Running on the commit upon which I based these changes</p>
    <p>3. Running with all my proposed changes included.</p>
    <p>All three of these produce the same output, which comes through
      the UART on the opentitan, and I have checked to be sure it is
      using the new code in the case of scenario 3.</p>
    <p>I'm not sure what exactly those tests do, and so I don't know if
      they rely at all on any of the interrupts, Is that a sufficient
      test? Or is there something else I would need to test for this?</p>=

    <blockquote type=3D"cite"
cite=3D"mid:CAKmqyKOKNQwNtzX+wHepEX4OpVqAA2pkXfcP18k=3D8Wd+8ZM06Q@mail.gm=
ail.com">
      <pre wrap=3D"" class=3D"moz-quote-pre">

</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"" class=3D"moz-quote-pre">
Signed-off-by: Lex Bailey <a class=3D"moz-txt-link-rfc2396E" href=3D"mail=
to:lex.bailey@lowrisc.org">&lt;lex.bailey@lowrisc.org&gt;</a>
---
 hw/char/ot_uart.c         | 91 ++++++++++++++++-----------------------
 hw/char/trace-events      |  2 +-
 include/hw/char/ot_uart.h | 15 ++-----
 3 files changed, 40 insertions(+), 68 deletions(-)

diff --git a/hw/char/ot_uart.c b/hw/char/ot_uart.c
index 910bef00f2..af0cf9ee1a 100644
--- a/hw/char/ot_uart.c
+++ b/hw/char/ot_uart.c
@@ -20,9 +20,10 @@
 #include "qemu/osdep.h"
 #include "hw/char/ot_uart.h"
 #include "qemu/fifo8.h"
+#include "qapi/error.h"
+#include "chardev/char-fe.h"
 #include "hw/core/cpu.h"
 #include "hw/core/irq.h"
-#include "hw/core/qdev-clock.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-properties-system.h"
 #include "hw/core/registerfields.h"
@@ -152,6 +153,18 @@ static bool ot_uart_is_rx_enabled(const OtUARTState =
*s)
     return FIELD_EX32(s-&gt;regs[R_CTRL], CTRL, RX);
 }

+static void ot_uart_check_baudrate(const OtUARTState *s)
+{
+    uint32_t nco =3D FIELD_EX32(s-&gt;regs[R_CTRL], CTRL, NCO);
+
+    unsigned baudrate =3D (unsigned)(((uint64_t)nco * (uint64_t)s-&gt;pc=
lk) &gt;&gt;
+                                   (R_CTRL_NCO_LENGTH + 4));
+
+    if (baudrate) {
+        trace_ot_uart_check_baudrate(s-&gt;ot_id, s-&gt;pclk, baudrate);=

+    }
+}
+
 static int ot_uart_can_receive(void *opaque)
 {
     OtUARTState *s =3D opaque;
@@ -284,7 +297,6 @@ static void ot_uart_xmit(OtUARTState *s)

 static void uart_write_tx_fifo(OtUARTState *s, uint8_t val)
 {
-    uint64_t current_time =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     if (fifo8_is_full(&amp;s-&gt;tx_fifo)) {
         qemu_log_mask(LOG_GUEST_ERROR, "ot_uart: TX FIFO overflow");
         return;
@@ -305,9 +317,6 @@ static void uart_write_tx_fifo(OtUARTState *s, uint8_=
t val)
     if (ot_uart_is_tx_enabled(s)) {
         ot_uart_xmit(s);
     }
-
-    timer_mod(s-&gt;fifo_trigger_handle, current_time +
-              (s-&gt;char_tx_time * 4));
 }

 static void ot_uart_reset_enter(Object *obj, ResetType type)
@@ -328,11 +337,6 @@ static void ot_uart_reset_enter(Object *obj, ResetTy=
pe type)
     ot_uart_reset_tx_fifo(s);
     ot_uart_reset_rx_fifo(s);

-    s-&gt;tx_level =3D 0;
-    s-&gt;rx_level =3D 0;
-
-    s-&gt;char_tx_time =3D (NANOSECONDS_PER_SECOND / 230400) * 10;
-
     /*
      * do not reset `s-&gt;in_break`, as that tracks whether we are curr=
ently
      * receiving a break condition over UART RX from some device talking=

@@ -399,19 +403,16 @@ static gboolean ot_uart_watch_cb(void *do_not_use, =
GIOCondition cond,
     return FALSE;
 }

-static uint64_t ot_uart_get_baud(OtUARTState *s)
+static void ot_uart_clock_input(void *opaque, int irq, int level)
 {
-    uint64_t baud;
+    OtUARTState *s =3D opaque;

-    baud =3D ((s-&gt;regs[R_CTRL] &amp; R_CTRL_NCO_MASK) &gt;&gt; 16);
-    baud *=3D clock_get_hz(s-&gt;f_clk);
-    baud &gt;&gt;=3D 20;
+    g_assert(irq =3D=3D 0);

-    if (baud) {
-        trace_ot_uart_check_baudrate(s-&gt;ot_id, baud);
-    }
+    s-&gt;pclk =3D (unsigned)level;

-    return baud;
+    /* TODO: disable UART transfer when PCLK is 0 */
+    ot_uart_check_baudrate(s);
 }

 static uint64_t ot_uart_read(void *opaque, hwaddr addr, unsigned int siz=
e)
@@ -553,8 +554,6 @@ static void ot_uart_write(void *opaque, hwaddr addr, =
uint64_t val64,
         /* This will also set an IRQ once the alert handler is added */
         break;
     case R_CTRL:
-        s-&gt;regs[R_CTRL] =3D value;
-
         if (value &amp; R_CTRL_NF_MASK) {
             qemu_log_mask(LOG_UNIMP,
                           "%s: UART_CTRL_NF is not supported\n", __func_=
_);
@@ -577,10 +576,19 @@ static void ot_uart_write(void *opaque, hwaddr addr=
, uint64_t val64,
             qemu_log_mask(LOG_UNIMP,
                           "%s: UART_CTRL_RXBLVL is not supported\n", __f=
unc__);
         }
-        if (value &amp; R_CTRL_NCO_MASK) {
-            uint64_t baud =3D ot_uart_get_baud(s);
-
-            s-&gt;char_tx_time =3D (NANOSECONDS_PER_SECOND / baud) * 10;=

+        uint32_t prev =3D s-&gt;regs[R_CTRL];
+        s-&gt;regs[R_CTRL] =3D value &amp; CTRL_MASK;
+        uint32_t change =3D prev ^ s-&gt;regs[R_CTRL];
+        if (change &amp; R_CTRL_NCO_MASK) {
+            ot_uart_check_baudrate(s);
+        }
+        if ((change &amp; R_CTRL_RX_MASK) &amp;&amp; ot_uart_is_rx_enabl=
ed(s) &amp;&amp;
+            !ot_uart_is_sys_loopack_enabled(s)) {
+            qemu_chr_fe_accept_input(&amp;s-&gt;chr);
+        }
+        if ((change &amp; R_CTRL_TX_MASK) &amp;&amp; ot_uart_is_tx_enabl=
ed(s)) {
+            /* try sending pending data from TX FIFO if any */
+            ot_uart_xmit(s);
         }
         break;
     case R_WDATA:
@@ -628,25 +636,6 @@ static void ot_uart_write(void *opaque, hwaddr addr,=
 uint64_t val64,
     }
 }

-static void ot_uart_clk_update(void *opaque, ClockEvent event)
-{
-    OtUARTState *s =3D opaque;
-
-    /* recompute uart's speed on clock change */
-    uint64_t baud =3D ot_uart_get_baud(s);
-
-    s-&gt;char_tx_time =3D (NANOSECONDS_PER_SECOND / baud) * 10;
-}
-
-static void fifo_trigger_update(void *opaque)
-{
-    OtUARTState *s =3D opaque;
-
-    if (s-&gt;regs[R_CTRL] &amp; R_CTRL_TX_MASK) {
-        ot_uart_xmit(s);
-    }
-}
-
 static const MemoryRegionOps ot_uart_ops =3D {
     .read =3D ot_uart_read,
     .write =3D ot_uart_write,
@@ -665,15 +654,12 @@ static int ot_uart_post_load(void *opaque, int vers=
ion_id)

 static const VMStateDescription vmstate_ot_uart =3D {
     .name =3D TYPE_OT_UART,
-    .version_id =3D 2,
-    .minimum_version_id =3D 2,
+    .version_id =3D 3,
+    .minimum_version_id =3D 3,
     .post_load =3D ot_uart_post_load,
     .fields =3D (const VMStateField[]) {
         VMSTATE_STRUCT(tx_fifo, OtUARTState, 1, vmstate_fifo8, Fifo8),
         VMSTATE_STRUCT(rx_fifo, OtUARTState, 1, vmstate_fifo8, Fifo8),
-        VMSTATE_UINT32(tx_level, OtUARTState),
-        VMSTATE_UINT64(char_tx_time, OtUARTState),
-        VMSTATE_TIMER_PTR(fifo_trigger_handle, OtUARTState),
         VMSTATE_ARRAY(regs, OtUARTState, REGS_COUNT, 1, vmstate_info_uin=
t32,
                       uint32_t),
         VMSTATE_END_OF_LIST()
@@ -708,10 +694,6 @@ static void ot_uart_init(Object *obj)
 {
     OtUARTState *s =3D OT_UART(obj);

-    s-&gt;f_clk =3D qdev_init_clock_in(DEVICE(obj), "f_clock",
-                                  ot_uart_clk_update, s, ClockUpdate);
-    clock_set_hz(s-&gt;f_clk, OT_UART_CLOCK);
-
     for (unsigned index =3D 0; index &lt; OT_UART_IRQ_NUM; index++) {
         sysbus_init_irq(SYS_BUS_DEVICE(obj), &amp;s-&gt;irqs[index]);
     }
@@ -735,8 +717,7 @@ static void ot_uart_realize(DeviceState *dev, Error *=
*errp)

     g_assert(s-&gt;ot_id);

-    s-&gt;fifo_trigger_handle =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
-                                          fifo_trigger_update, s);
+    qdev_init_gpio_in_named(DEVICE(s), &amp;ot_uart_clock_input, "clock-=
in", 1);

     fifo8_create(&amp;s-&gt;tx_fifo, OT_UART_TX_FIFO_SIZE);
     fifo8_create(&amp;s-&gt;rx_fifo, OT_UART_RX_FIFO_SIZE);
diff --git a/hw/char/trace-events b/hw/char/trace-events
index 17cc9ad2d5..c859d8af4e 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -143,7 +143,7 @@ htif_uart_write_to_host(uint8_t device, uint8_t cmd, =
uint64_t payload) <a class=3D"moz-txt-link-rfc2396E" href=3D"device:htif_=
uart_unknown_device_command(uint8_tdevice,uint8_tcmd,uint64_tpayload)">"d=
evice:
 htif_uart_unknown_device_command(uint8_t device, uint8_t cmd, uint64_t p=
ayload) "</a>device: %u cmd: %02u payload: %016" PRIx64

 # ot_uart.c
-ot_uart_check_baudrate(const char *id, unsigned baud) "%s: %u bps"
+ot_uart_check_baudrate(const char *id, unsigned pclk, unsigned baud) "%s=
: @ %u Hz: %u bps"
 ot_uart_connect_input_clock(const char *id, const char * srcname) "%s: %=
s"
 ot_uart_debug(const char *id, const char *msg) "%s: %s"
 ot_uart_io_read_out(const char *id, uint32_t addr, const char *regname, =
uint32_t val, uint32_t pc) "%s: addr=3D0x%02x (%s), val=3D0x%x, pc=3D0x%x=
"
diff --git a/include/hw/char/ot_uart.h b/include/hw/char/ot_uart.h
index 2f538e1f6f..7c2b5f3457 100644
--- a/include/hw/char/ot_uart.h
+++ b/include/hw/char/ot_uart.h
@@ -23,11 +23,8 @@
 #include "hw/core/sysbus.h"
 #include "qemu/fifo8.h"
 #include "chardev/char-fe.h"
-#include "qemu/timer.h"
 #include "qom/object.h"

-#define OT_UART_CLOCK 50000000 /* 50MHz clock */
-
 #define TYPE_OT_UART "ot-uart"
 OBJECT_DECLARE_TYPE(OtUARTState, OtUARTClass, OT_UART)

@@ -39,13 +36,6 @@ struct OtUARTState {
     MemoryRegion mmio;
     qemu_irq irqs[9];

-    uint32_t tx_level;
-
-    uint32_t rx_level;
-
-    QEMUTimer *fifo_trigger_handle;
-    uint64_t char_tx_time;
-
     uint32_t regs[13]; /* Length must be updated if regs added or remove=
d */

     Fifo8 tx_fifo;
@@ -53,10 +43,11 @@ struct OtUARTState {
     uint32_t tx_watermark_level;
     bool in_break;
     guint watch_tag;
+    unsigned pclk; /* Current input clock */
+    const char *clock_src_name; /* IRQ name once connected */

     char *ot_id;
-    Clock *f_clk;
-
+    DeviceState *clock_src;
     CharFrontend chr;
     bool oversample_break; /* Should mock break in the oversampled VAL r=
eg? */
     bool toggle_break; /* Are incoming breaks temporary or toggled? */
--
2.49.1

</pre>
      </blockquote>
    </blockquote>
    <div class=3D"moz-signature">-- <br>
      Lex Bailey (they/them)<br>
      <span style=3D"font-size:0.5em;color:#777777;">lowRISC C.I.C. 7
        Hills Road, Cambridge, CB2 1GE, UK. Registered in England &amp;
        Wales 09272283
        <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:lex.bailey@l=
owrisc.org">lex.bailey@lowrisc.org</a></span></div>
  </body>
</html>

--------------Eir2eoxj8u07m0KvBs2nRDhb--

--------------I4VVdbcefGfWqcFuuZcmJUsU
Content-Type: application/pgp-keys; name="OpenPGP_0x7CBB20D40B55582C.asc"
Content-Disposition: attachment; filename="OpenPGP_0x7CBB20D40B55582C.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
WZXWKp/svUI=3D
=3DQ1uI
-----END PGP PUBLIC KEY BLOCK-----

--------------I4VVdbcefGfWqcFuuZcmJUsU--

--------------watcVXhDbzCyh9oNau7qMzZw--

--------------jW7wtI0uKw3Kd2fF9l0Lmm9a
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsD5BAABCAAjFiEEq6gR1Rj7FCIRoDCVfLsg1AtVWCwFAmno67wFAwAAAAAACgkQfLsg1AtVWCww
lQwAhAhIA3xn9diW8ni039V0fvebHxn6eV28BRzP6NAGy7aVlYpIP6gZHY6JUaCDNo3iHYhWa4oY
vWPlQR49K+NhtXswiCa8ULJfVBDvDHqcAkSdbb9Itgb/ynBlmiCDsvu/vUClKv2RU9/zzfDWhLCI
e7YeOCKP6uFM/IGjGhsa9Vbzj3VRLpIlfxgB4XPKrvYejRZQB7c/J7rJzbnn+tEk5SzgPQGUbKnW
EjJ1RtDomBRtRwbXrm+NkaTrS36RygbCqjg7XrYbIYKU5iDKfWm4IlIiWW4A/o/SEL3s2tUyg5O9
9/TNNYP4QY221ByIFHEF6W7NLizz4X/61nfIvBp/XDvlSoC7eeBHejb/NQ636cLlqMLaaIac6L19
X7P4cgE2GxqfqVNJxiTAtvtdveiNDhy+xYkCwn21fNZy8LxbeEVUOjv6T7cNi7+sfqYu5NlsGj77
qBVnEvIogW1ke4qEPyELJYWTHuFChhmJhxT60eWaBXxCxvAr2f6ZrM1IAZcZ
=i3DE
-----END PGP SIGNATURE-----

--------------jW7wtI0uKw3Kd2fF9l0Lmm9a--

