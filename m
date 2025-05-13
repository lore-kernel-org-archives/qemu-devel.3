Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F03AC3ABCB
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 02:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEfNX-0003bE-66; Mon, 12 May 2025 22:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1uEfNV-0003b3-85
 for qemu-devel@nongnu.org; Mon, 12 May 2025 22:28:21 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1uEfNT-0007eY-Bl
 for qemu-devel@nongnu.org; Mon, 12 May 2025 22:28:20 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-30ac24ede15so6571161a91.2
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 19:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747103297; x=1747708097; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zDg2z4v3LtTa1nKLYBAOICeIZJbGCH9SMmAdTm/cHzs=;
 b=Op/DKKxOVfFnvgN3NImrumRrbNYkgV+r6YXwB7iy0tGNomMheXQ2pWPE64P9+h56nS
 uZgM8nmWiePy4BTgxVkJ4VjuBzrNoTaZrDacqLJw0gEmTmlnEAXPeykJNC9NOnASuDB/
 e+2kj4v+Ff2AhfWt1QdEBKCSOqhHEMMQnagQCT4AYUM43JU+IjwyFlDEV/rUw/9XpQLG
 V8vcunVf/Crt/6bGJDljXzJEq6eddUuTodcPPQ9y5HRqAs7bInD82TWNziTIz65XfUPq
 fuX6zhC+bdaPOWmpWEzKdvVfENd7EKmjVT/W/jAx2Fy7NVgsq8JkUa1uuUGwk20x0f3K
 I3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747103297; x=1747708097;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zDg2z4v3LtTa1nKLYBAOICeIZJbGCH9SMmAdTm/cHzs=;
 b=g0PhUbImto9Zl4FkTN8K31t2tj9RSrFOS4SiUsoujtt/wHWWykHbBsYXC6HHr8Zkk5
 OKCHNapiAS+sXItqU4J9Plzeef0wuio/4RoN/iyDXRQRLuPDUQlhRFknEw79+ynTHTe/
 7tzhzn53hrywXpOyGj04+jcmc2H7ZRMXIBfmgyUHlFnJ5tC1DvRDtavLXqHBVhF4HxIh
 K+7aUE6S011E8fSjurDrkKlxdMA/3zo1ui947YH7fNk66SHE2cyYZW/OQN83zzltyfc4
 oPgeBnTgyn6+ZYYV6rdvmqCDisGRSVBX5pvatAW1rrXFzr3OJJOl2CnEM5HH4fNNM5DH
 kl0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkO7ol3M7s7GoxGuumCleEoeXWj0BP6Q1urrFSBdwLEDxLQfeYwZqCj9/R5HaYay81edYLS5R/mgvV@nongnu.org
X-Gm-Message-State: AOJu0YyIaUhnPI0rDK/48+IBwmtTc5S4AW27hVtJy9rAPxS84ECnpFrr
 oxJOBN7hBjnVWh7HZNjQ2IDCbAD/k10f97njewh1PJQnGCZupdzhvTvz6za2
X-Gm-Gg: ASbGncv9fAPE00KUv9/s9qQ4LT1k+7VvKRNG6BRO8jP/obg7aXPTgjx9/LqwgrwZ5K4
 WvyVNSfPSQwfTYIkgxY99+sUcx0Nt98N7kifETrUImN6vqvTYnJ4Pb3KgYnfDgwaQM44oJrzrQl
 zsHYib/gnRqcLY2bD1U2ypf/t4o+SkPQvgvCOPm1z9y1rkoM9p4BbpWj0PAjwjI1biXXc5VPJH3
 14h6NrWkdA2b2/RWOiIs7NiqtN07Ii1O3Nq5w9lF2a7JQm9xEB4QysiZQeiIphWSDGlWnbU8hSG
 ecHbnql72dw30UFTHiL9/ocA5Qai63C2vMqj4M5EM5i7uSpPU81cZIKdD63Jn5U=
X-Google-Smtp-Source: AGHT+IFC3JcJhorJTep9Bb4C9fccMd3CTXAAQCHmcW75oBvCgXh/4vywaWIYdC1BkJGJDpMvInQGsQ==
X-Received: by 2002:a17:90b:2882:b0:2f9:c56b:6ec8 with SMTP id
 98e67ed59e1d1-30c3ce05a2emr26714686a91.10.1747103297392; 
 Mon, 12 May 2025 19:28:17 -0700 (PDT)
Received: from [10.239.152.184] ([134.134.139.75])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30ad4fe213bsm9472555a91.34.2025.05.12.19.28.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 19:28:16 -0700 (PDT)
Message-ID: <ffa687c30c11429767d48c9d1358c729d1e49e8f.camel@gmail.com>
Subject: Re: [PATCH 8/9] ui/gtk-gl-area: Render guest content with padding
 in fixed-scale mode
From: Weifeng Liu <weifeng.liu.z@gmail.com>
To: "Kim, Dongwon" <dongwon.kim@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Date: Tue, 13 May 2025 10:28:14 +0800
In-Reply-To: <PH8PR11MB6879607C14D7E5BB7FCDAAD1FA96A@PH8PR11MB6879.namprd11.prod.outlook.com>
References: <20250511073337.876650-1-weifeng.liu.z@gmail.com>
 <20250511073337.876650-9-weifeng.liu.z@gmail.com>
 <PH8PR11MB6879607C14D7E5BB7FCDAAD1FA96A@PH8PR11MB6879.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
MIME-Version: 1.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=weifeng.liu.z@gmail.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

SGksCgpPbiBUdWUsIDIwMjUtMDUtMTMgYXQgMDA6MzcgKzAwMDAsIEtpbSwgRG9uZ3dvbiB3cm90
ZToKPiBIaSwKPiAKPiA+IFN1YmplY3Q6IFtQQVRDSCA4LzldIHVpL2d0ay1nbC1hcmVhOiBSZW5k
ZXIgZ3Vlc3QgY29udGVudCB3aXRoCj4gPiBwYWRkaW5nIGluCj4gPiBmaXhlZC1zY2FsZSBtb2Rl
Cj4gPiAKPiA+IEluIGZpeGVkLXNjYWxlIG1vZGUgKHpvb20tdG8tZml0PWZhbHNlKSwgd2UgZXhw
ZWN0IHRoYXQgc2NhbGUKPiA+IHNob3VsZCBub3QKPiA+IGNoYW5nZSwgbWVhbmluZyB0aGF0IGlm
IHdpbmRvdyBzaXplIGlzIGxhcmdlciB0aGFuIGd1ZXN0IHN1cmZhY2UsCj4gPiBwYWRkaW5nIGlz
Cj4gCj4gIyBAem9vbS10by1maXQ6IFpvb20gZ3Vlc3QgZGlzcGxheSB0byBmaXQgaW50byB0aGUg
aG9zdCB3aW5kb3cuwqAgV2hlbgo+ICPCoMKgwqDCoCB0dXJuZWQgb2ZmIHRoZSBob3N0IHdpbmRv
dyB3aWxsIGJlIHJlc2l6ZWQgaW5zdGVhZC7CoCBJbiBjYXNlCj4gdGhlCj4gI8KgwqDCoMKgIGRp
c3BsYXkgZGV2aWNlIGNhbiBub3RpZnkgdGhlIGd1ZXN0IG9uIHdpbmRvdyByZXNpemVzCj4gI8Kg
wqDCoMKgICh2aXJ0aW8tZ3B1KSB0aGlzIHdpbGwgZGVmYXVsdCB0byAib24iLCBhc3N1bWluZyB0
aGUgZ3Vlc3Qgd2lsbAo+ICPCoMKgwqDCoCByZXNpemUgdGhlIGRpc3BsYXkgdG8gbWF0Y2ggdGhl
IHdpbmRvdyBzaXplIHRoZW4uwqAgT3RoZXJ3aXNlIGl0Cj4gI8KgwqDCoMKgIGRlZmF1bHRzIHRv
ICJvZmYiLsKgIChTaW5jZSAzLjEpCj4gCj4gQ3VycmVudCBkZWZpbml0aW9uIHNheXMgdGhlIGhv
c3Qgd2luZG93IHNob3VsZCBiZSByZXNpemVkIHRvIGZpdCB0aGUKPiBzaXplIG9mIHRoZSBndWVz
dCBzdXJmYWNlIGluc3RlYWQuIFdvdWxkbid0IHBhZGRpbmcgYWNjb21tb2RhdGUgdGhpcz8KPiAK
ClllYWgsIHdpbmRvdyB3aWxsIGJlIHJlc2l6ZWQgdG8gZml0IHRoZSBzaXplIG9mIGd1ZXN0IHN1
cmZhY2UgaW4gZml4ZWQtCnNjYWxlIG1vZGUuIEhvd2V2ZXIsIHVzZXJzIGFyZSBzdGlsbCBhbGxv
d2VkIHRvIHJlc2l6ZSB0aGUgd2luZG93IHRvIGEKbGFyZ2VyIHNpemUgYW5kIHRoaXMgaXMgY2Fz
ZSB3aGVyZSBwYWRkaW5nIGlzIHJlcXVpcmVkLCBvdGhlcndpc2UgdGhlCmZpeGVkLXNjYWxlIGFz
c3VtcHRpb24gaXMgYnJva2VuLiBJbiBmYWN0LCBnbD1vZmYgbW9kZSBlbXBsb3lzIHBhZGRpbmcK
dG8gcHJlc2VydmUgc2NhbGUgYWxyZWFkeSBidXQgZ2w9b24gbW9kZSBkb2Vzbid0IGZvbGxvdyB0
aGlzIGJlaGF2aW9yLAp3aGljaCwgSU1PLCBpcyBhIGRlZmVjdCB0aGF0IHRoaXMgcGF0Y2ggaXMg
dHJ5aW5nIHRvIGNvcnJlY3QuCgpCZXN0IHJlZ2FyZHMsCldlaWZlbmcKCj4gPiBzdXBwb3NlZCB0
byBiZSBhZGRlZCB0byBwcmVzZXJ2ZSB0aGUgc2NhbGUuIEhvd2V2ZXIsIGluIE9wZW5HTCBtb2Rl
Cj4gPiAoZ2w9b24pLCBndWVzdCBzdXJmYWNlIGlzIGFsd2F5cyBwYWludGVkIHRvIHRoZSB3aG9s
ZSBjYW52YXMKPiA+IHdpdGhvdXQgYW55Cj4gPiBwYWRkaW5nLiBUaGlzIGNoYW5nZSB0cmllcyB0
byBmaXggdGhpcyBidWcgYnkgYWRkaW5nIGFwcHJvcHJpYXRlCj4gPiBwYWRkaW5nCj4gPiB3aGVu
IGRyYXdpbmcgc3VyZmFjZXMuCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IFdlaWZlbmcgTGl1IDx3
ZWlmZW5nLmxpdS56QGdtYWlsLmNvbT4KPiA+IC0tLQo+ID4gwqB1aS9ndGstZ2wtYXJlYS5jIHwg
MzMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystCj4gPiDCoDEgZmlsZSBjaGFuZ2Vk
LCAzMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gPiAKPiA+IGRpZmYgLS1naXQgYS91
aS9ndGstZ2wtYXJlYS5jIGIvdWkvZ3RrLWdsLWFyZWEuYyBpbmRleAo+ID4gZGI5M2NkNjIwNC4u
ODE1MWNjNDEzYwo+ID4gMTAwNjQ0Cj4gPiAtLS0gYS91aS9ndGstZ2wtYXJlYS5jCj4gPiArKysg
Yi91aS9ndGstZ2wtYXJlYS5jCj4gPiBAQCAtNDQsNyArNDQsOSBAQCB2b2lkIGdkX2dsX2FyZWFf
ZHJhdyhWaXJ0dWFsQ29uc29sZSAqdmMpwqAgI2VuZGlmCj4gPiDCoMKgwqDCoCBpbnQgcHcsIHBo
LCBncywgeTEsIHkyOwo+ID4gwqDCoMKgwqAgaW50IHd3LCB3aDsKPiA+ICvCoMKgwqAgaW50IHd3
X3N1cmZhY2UsIHdoX3N1cmZhY2U7Cj4gPiDCoMKgwqDCoCBpbnQgZmJ3LCBmYmg7Cj4gPiArwqDC
oMKgIGludCB3eF9vZmZzZXQsIHd5X29mZnNldDsKPiA+IAo+ID4gwqDCoMKgwqAgaWYgKCF2Yy0+
Z2Z4Lmdscykgewo+ID4gwqDCoMKgwqDCoMKgwqDCoCByZXR1cm47Cj4gPiBAQCAtNjEsNiArNjMs
MTcgQEAgdm9pZCBnZF9nbF9hcmVhX2RyYXcoVmlydHVhbENvbnNvbGUgKnZjKQo+ID4gCj4gPiDC
oMKgwqDCoCBnZF91cGRhdGVfc2NhbGUodmMsIHd3LCB3aCwgZmJ3LCBmYmgpOwo+ID4gCj4gPiAr
wqDCoMKgIHd3X3N1cmZhY2UgPSBmYncgKiB2Yy0+Z2Z4LnNjYWxlX3g7Cj4gPiArwqDCoMKgIHdo
X3N1cmZhY2UgPSBmYmggKiB2Yy0+Z2Z4LnNjYWxlX3k7Cj4gPiArCj4gPiArwqDCoMKgIHd4X29m
ZnNldCA9IHd5X29mZnNldCA9IDA7Cj4gPiArwqDCoMKgIGlmICh3dyA+IHd3X3N1cmZhY2UpIHsK
PiA+ICvCoMKgwqDCoMKgwqDCoCB3eF9vZmZzZXQgPSAod3cgLSB3d19zdXJmYWNlKSAvIDI7Cj4g
PiArwqDCoMKgIH0KPiA+ICvCoMKgwqAgaWYgKHdoID4gd2hfc3VyZmFjZSkgewo+ID4gK8KgwqDC
oMKgwqDCoMKgIHd5X29mZnNldCA9ICh3aCAtIHdoX3N1cmZhY2UpIC8gMjsKPiA+ICvCoMKgwqAg
fQo+ID4gKwo+ID4gwqDCoMKgwqAgaWYgKHZjLT5nZnguc2Nhbm91dF9tb2RlKSB7Cj4gPiDCoMKg
wqDCoMKgwqDCoMKgIGlmICghdmMtPmdmeC5ndWVzdF9mYi5mcmFtZWJ1ZmZlcikgewo+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybjsKPiA+IEBAIC03OSwxMSArOTIsMjkgQEAgdm9p
ZCBnZF9nbF9hcmVhX2RyYXcoVmlydHVhbENvbnNvbGUgKnZjKQo+ID4gwqDCoMKgwqDCoMKgwqDC
oCBnbEJpbmRGcmFtZWJ1ZmZlcihHTF9SRUFEX0ZSQU1FQlVGRkVSLCB2Yy0KPiA+ID4gZ2Z4Lmd1
ZXN0X2ZiLmZyYW1lYnVmZmVyKTsKPiA+IMKgwqDCoMKgwqDCoMKgwqAgLyogR3RrR0xBcmVhIHNl
dHMgR0xfRFJBV19GUkFNRUJVRkZFUiBmb3IgdXMgKi8KPiA+IAo+ID4gK8KgwqDCoMKgwqDCoMKg
IGlmICh3eF9vZmZzZXQgPiAwKSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnbEVuYWJs
ZShHTF9TQ0lTU09SX1RFU1QpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ2xTY2lzc29y
KDAsIDAsIHd4X29mZnNldCAqIGdzLCB3aCAqIGdzKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGdsQ2xlYXIoR0xfQ09MT1JfQlVGRkVSX0JJVCk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBnbFNjaXNzb3IoKHd3IC0gd3hfb2Zmc2V0KSAqIGdzLCAwLCB3eF9vZmZzZXQgKiBncywg
d2gKPiA+ICogZ3MpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ2xDbGVhcihHTF9DT0xP
Ul9CVUZGRVJfQklUKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdsRGlzYWJsZShHTF9T
Q0lTU09SX1RFU1QpOwo+ID4gK8KgwqDCoMKgwqDCoMKgIH0KPiA+ICvCoMKgwqDCoMKgwqDCoCBp
ZiAod3lfb2Zmc2V0ID4gMCkgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ2xFbmFibGUo
R0xfU0NJU1NPUl9URVNUKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdsU2Npc3Nvcigw
LCAwLCB3dyAqIGdzLCB3eV9vZmZzZXQgKiBncyk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBnbENsZWFyKEdMX0NPTE9SX0JVRkZFUl9CSVQpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZ2xTY2lzc29yKDAsICh3aCAtIHd5X29mZnNldCkgKiBncywgd3cgKiBncywgd3lfb2Zmc2V0
Cj4gPiAqIGdzKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdsQ2xlYXIoR0xfQ09MT1Jf
QlVGRkVSX0JJVCk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnbERpc2FibGUoR0xfU0NJ
U1NPUl9URVNUKTsKPiA+ICvCoMKgwqDCoMKgwqDCoCB9Cj4gPiArCj4gPiDCoMKgwqDCoMKgwqDC
oMKgIGdsVmlld3BvcnQoMCwgMCwgcHcsIHBoKTsKPiA+IMKgwqDCoMKgwqDCoMKgwqAgeTEgPSB2
Yy0+Z2Z4LnkwX3RvcCA/IDAgOiB2Yy0+Z2Z4Lmg7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgIHkyID0g
dmMtPmdmeC55MF90b3AgPyB2Yy0+Z2Z4LmggOiAwOwo+ID4gwqDCoMKgwqDCoMKgwqDCoCBnbEJs
aXRGcmFtZWJ1ZmZlcigwLCB5MSwgdmMtPmdmeC53LCB5MiwKPiA+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAwLCAwLCBwdywgcGgsCj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgd3hfb2Zmc2V0
ICogZ3MsIHd5X29mZnNldCAqIGdzLAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICh3dyAtIHd4X29mZnNldCkgKiBncywgKHdoIC0gd3lfb2Zm
c2V0KQo+ID4gKiBncywKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgR0xfQ09MT1JfQlVGRkVSX0JJVCwgR0xfTkVBUkVTVCk7wqAKPiA+ICNp
ZmRlZiBDT05GSUdfR0JNCj4gPiDCoMKgwqDCoMKgwqDCoMKgIGlmIChkbWFidWYpIHsKPiA+IC0t
Cj4gPiAyLjQ5LjAKPiA+IAo+IAo+IFRoYW5rcwo=


