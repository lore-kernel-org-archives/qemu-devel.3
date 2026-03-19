Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 762421091916
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 22:07:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3LWY-0006nU-Mb; Thu, 19 Mar 2026 18:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=531a4ae9e=graf@amazon.de>)
 id 1w3LWX-0006n7-7h
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 18:07:25 -0400
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([35.155.198.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=531a4ae9e=graf@amazon.de>)
 id 1w3LWV-0005HA-JX
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 18:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1773958043; x=1805494043;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=gQYTzIpVSh0gYF212DDpMGnhSn/k8muuIZ/AvblcFO8=;
 b=LVXJS8UGocuLryuDbQbpuiZn2366sWz2LybaB9EtIJu2YAVnjjS/081H
 qbZfp1l+BsGfr2/Sc0tSBjhlFrqyBpS38aQUY9rN7V+G9TNDP8lvkGF77
 cLGBRLMw6sbENPrsKCoiuL2mLNHh04R3H3XahmvkTi5ROnCOMPV2CQ/qT
 KZ/BmU7/Z9Bb8zbh/vwPcPfRzkw0p2R7+7lWQKUraNGyFxAtLKfTUzjrB
 vN/UDYqT2Bha9aHyiskod4dSbJmDaAGv2a6JqjGCsx7Or7SideDE/1s67
 JuvZ3xTd41ySZW26Za9F2opdvdmoRASBIcR7+6375UPXODlxcpLo7XpaK w==;
X-CSE-ConnectionGUID: UhlKhegNRnaUUvb7E51EVA==
X-CSE-MsgGUID: yWH1Z1FLQvu8VJHZ67g5jw==
X-IronPort-AV: E=Sophos;i="6.23,130,1770595200"; d="scan'208";a="15304443"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 22:07:16 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:12155]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.176:2525]
 with esmtp (Farcaster)
 id 3a0b0542-b394-45ec-b15b-42e815cc95f1; Thu, 19 Mar 2026 22:07:16 +0000 (UTC)
X-Farcaster-Flow-ID: 3a0b0542-b394-45ec-b15b-42e815cc95f1
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 19 Mar 2026 22:07:15 +0000
Received: from [0.0.0.0] (172.19.99.218) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Thu, 19 Mar 2026
 22:07:13 +0000
Message-ID: <a0ca78c0-bdad-41cd-93f2-cecb8c032912@amazon.com>
Date: Thu, 19 Mar 2026 23:07:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 08/10] vmstate: Implement load of ptr marker in
 vmstate core
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
CC: <qemu-devel@nongnu.org>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 Juraj Marcin <jmarcin@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, Juan Quintela
 <quintela@trasno.org>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260317232332.15209-1-peterx@redhat.com>
 <20260317232332.15209-9-peterx@redhat.com> <87a4w335d7.fsf@suse.de>
 <abxxS10KOBTg6GXH@x1.local>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <abxxS10KOBTg6GXH@x1.local>
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D032UWB001.ant.amazon.com (10.13.139.152) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=35.155.198.111;
 envelope-from=prvs=531a4ae9e=graf@amazon.de;
 helo=pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

Ck9uIDE5LjAzLjI2IDIyOjU3LCBQZXRlciBYdSB3cm90ZToKPiBDQVVUSU9OOiBUaGlzIGVtYWls
IG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBvcmdhbml6YXRpb24uIERvIG5vdCBjbGlj
ayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgY2FuIGNvbmZpcm0gdGhlIHNl
bmRlciBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZlLgo+Cj4KPgo+IE9uIFRodSwgTWFyIDE5
LCAyMDI2IGF0IDA1OjU2OjUyUE0gLTAzMDAsIEZhYmlhbm8gUm9zYXMgd3JvdGU6Cj4+IFBldGVy
IFh1IDxwZXRlcnhAcmVkaGF0LmNvbT4gd3JpdGVzOgo+Pgo+Pj4gVGhlIGxvYWRlciBzaWRlIG9m
IHB0ciBtYXJrZXIgaXMgcHJldHR5IHN0cmFpZ2h0Zm9yd2FyZCwgaW5zdGVhZCBvZiBwbGF5aW5n
Cj4+PiB0aGUgaW5uZXJfZmllbGQgdHJpY2ssIGp1c3QgZG8gdGhlIGxvYWQgbWFudWFsbHkgYXNz
dW1pbmcgdGhlIG1hcmtlciBsYXlvdXQKPj4+IGlzIGEgc3RhYmxlIEFCSSAod2hpY2ggaXQgaXMg
dHJ1ZSBhbHJlYWR5KS4KPj4+Cj4+PiBUaGlzIHdpbGwgcmVtb3ZlIHNvbWUgbG9naWMgd2hpbGUg
bG9hZGluZyBWTVNELCBhbmQgaG9wZWZ1bGx5IGl0IG1ha2VzIGl0Cj4+PiBzbGlnaHRseSBlYXNp
ZXIgdG8gcmVhZC4gIFVuZm9ydHVuYXRlbHksIHdlIHN0aWxsIG5lZWQgdG8ga2VlcCB0aGUgc2Vu
ZGVyCj4+PiBzaWRlIGJlY2F1c2Ugb2YgdGhlIEpTT04gYmxvYiB3ZSdyZSBtYWludGFpbmluZy4u
Cj4+Pgo+PiAvcmFtYmxlCj4+IElzIHRoZSBKU09OIGJsb2IgQUJJPyBDYW4gd2Uga2lsbCBpdD8K
PiBZZWFoLCB0aGF0J3MgYSBmYWlyIHJhbWJsZS4gIEkgaGFkIHNvbWV0aW1lcyB0aGUgc2FtZSBm
ZWVsaW5nIHRoYXQgSSB3aXNoZWQKPiBpdCBub3QgYmUgdGhlcmUsIGl0J2xsIHNhdmUgcXVpdGUg
c29tZSB3b3JrLi4KPgo+IFBlciBteSBsaW1pdGVkIHVuZGVyc3RhbmRpbmcgb2YgcmVhZGluZyB0
aGUgY29kZSBpbiB0aGUgcGFzdCwgdGhlIHBsYW4gMTAKPiB5ZWFycyBhZ28gd2FzIGhhdmluZyB0
aG9zZSBibG9iIHRvIGFsd2F5cyBiZSB0b2dldGhlciB3aXRoIHRoZSBiaW5hcnkKPiBzdHJlYW0g
c28gdGhhdCB0aGUgc3RyZWFtIChlc3BlY2lhbGx5IHdoZW4gY2F1c2luZyBsb2FkaW5nIGZhaWx1
cmVzLi4pIHdpbGwKPiBiZSBwYXJzYWJsZSBhbmQgaXQncyBlYXNpZXIgdG8ga25vdyB3aHkgdGhl
IGxvYWQgZmFpbC4KPgo+IEhvd2V2ZXIgSSBhbHNvIGNvbmZlc3MgaW4gdGhlIHBhc3QgZmV3IHll
YXJzIHNpbmNlIEkgd29ya2VkIG9uIG1pZ3JhdGlvbiwgSQo+IG5ldmVyIHVzZWQgaXQgdG8gZGVi
dWcgYW55IHJlYWwgVk1TRCBpc3N1ZXMuLgo+Cj4gSSB0aGluayBvbmUgcmVhc29uIG1pZ2h0IGJl
IHRoYXQgd2hlbiBtaWdyYXRpb24gd2FzIHZlcnkgbmV3IGFuZCB3aGVuCj4gZGV2aWNlIGVtdWxh
dGlvbiBkZXZlbG9wZXJzIHdlcmUgZWFzaWVyIHRvIG1lc3MgdGhpbmdzIHVwLCBjcmFzaCBoYXBw
ZW4KPiBtb3JlLCBhbmQgYXQgdGhhdCB0aW1lIHRoaXMgdG9vbCBoZWxwcyBkZWJ1Z2dpbmcgdGhp
bmdzLiAgSXQnbGwgYWxzbyBhbG1vc3QKPiBtYWtlIHRoZSBWTSBkdW1wIHNlbGYtZXhwbGFuYXRv
cnkuCj4KPiBOb3dhZGF5cywgd2UgYWRkZWQgbW9yZSBjb2RlcyBpbnRvIG1pZ3JhdGlvbiB0byBo
ZWxwLCBlLmcuLCBJIHJlY2FsbCB3ZQo+IGFkZGVkIHRoaW5ncyBsaWtlIFFFTVVfVk1fU0VDVElP
Tl9GT09URVIgYW5kIGxpa2VseSBtb3JlIGFmdGVyIHRoZSB2bWRlc2MsCj4gd2hpY2ggY2FuIGFs
c28gaGVscCB0byBpZGVudGlmeSBWTVNEIGlzc3VlcyBkaXJlY3RseSBmcm9tIGRlc3QgUUVNVSBl
cnJvcnMuCj4KPiBMZXQgbWUgY29weSBzb21lIG1vcmUgcGVvcGxlIHRvIHNlZSBpZiB0aGVyZSdz
IGFueSB0aG91Z2h0cyBvciBpbnB1dHMgb24KPiB0aGUgSlNPTiBibG9icy4uCgoKSSBhZGRlZCBh
bmQgdXNlZCBpdCBmb3IgMiBwdXJwb3NlczoKCjEuIFRvIG1ha2UgdGhlIGFjdHVhbCBjb250ZW50
IG9mIHRoZSBkZXZpY2Ugc3RhdGUgbW9yZSBjbGVhcmx5IHZpc2libGUuIApJdCBjYW4gaGVscCB0
byBzdGFyZSBhdCBhIGRldmljZSBzdGF0ZSBkdW1wIHRvIGZpbmQgb3V0IHdoYXQncyBnb2luZyB3
cm9uZy4KMi4gVG8gYWxsb3cgZm9yIHN0YXRlIGRpZmZpbmcuIFdoZW4gSSBpbnRyb2R1Y2VkIGl0
LCBJIHdvdWxkIGRvIGEgCm1pZ3JhdGlvbiB0byBmaWxlLCBydW4gbXkgdGVzdCwgZG8gYW5vdGhl
ciBtaWdyYXRpb24gYW5kIHRoZW4gZGlmZiB0aGUgCnZtc3RhdGVzLiBUaGF0IHdheSBJIGNvdWxk
IGVhc2lseSBzZWUgd2hhdCBhY3R1YWxseSBjaGFuZ2VkIGJldHdlZW4gdGhlIApydW5zLiBJdCBo
ZWxwZWQgbWUgaWRlbnRpZnkgYSBmZXcgQ1BVIHJlZ2lzdGVyIHN0YXRlIGlzc3Vlcy4KCkkgZG9u
J3QgYmVsaWV2ZSBJIGV2ZXIgZW5kZWQgdXAgdXNpbmcgaXQgdG8gZGVidWcgbGl2ZSBtaWdyYXRp
b24gaXNzdWVzIDopLgoKCkFsZXgKCgoKCkFtYXpvbiBXZWIgU2VydmljZXMgRGV2ZWxvcG1lbnQg
Q2VudGVyIEdlcm1hbnkgR21iSApUYW1hcmEtRGFuei1TdHIuIDEzCjEwMjQzIEJlcmxpbgpHZXNj
aGFlZnRzZnVlaHJ1bmc6IENocmlzdG9mIEhlbGxtaXMsIEFuZHJlYXMgU3RpZWdlcgpFaW5nZXRy
YWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIgMjU3NzY0IEIKU2l0
ejogQmVybGluClVzdC1JRDogREUgMzY1IDUzOCA1OTcK


