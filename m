Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4728FE77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 18:46:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNG6F-0004be-Bu; Mon, 16 Dec 2024 13:45:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNG6C-0004bJ-Tv
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 13:45:44 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNG6A-0007A3-Oj
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 13:45:44 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2163b0c09afso39270145ad.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 10:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734374741; x=1734979541; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1QI3Q1VrbGLDEPrXtWUxIIZQsJFXPGXY/fM/X+hSsys=;
 b=qWoQGTG0Z7xur+b5ZBNjYp/BSEQOY/9vS8dosB0qykOZyc38woxGV0rM+sX+TQ7+7E
 /BmP8Hv14z8Hb8guFFLPTtzI7Un411CUqYupIqFpoTc49FPwKV5T4cdGC2j7sfHiEHjQ
 9MqnDV3EsBW7451u6h/2H2t5uGaqWWg8ZOb/d97VX3+Q01I9Nb1Fp9WQOuNyHZO+B8I6
 dLhHC8V19rW1ZnEu9EfhrMXl5GKrKX2XmBB4R1BJ3Vd4b0bQKT7IFHQacTJfCj2lQg9Y
 RdHIIm14IiHRzdpcory0Kq+d/3dzuGapsA85SQbd5sgGL24UD3YJw00P4K+F94ZmLvzF
 jDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734374741; x=1734979541;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1QI3Q1VrbGLDEPrXtWUxIIZQsJFXPGXY/fM/X+hSsys=;
 b=NCMnZwWI93yqJZHyKQOvPfRS6Ci+p9KnSYQ29h8yOFrdlKsfjbjHoj6+HOm/WPvNhM
 uuYI3YwGI4Iv+RufmJ3bW9FSwIQ/1u+aag3aLRrNcJ5II4wMXIkAnI6DLBxxXqrZxtF/
 OPTyf/dvIKxkAtG5FtUkYvAq07bMA4NzyrYmtkY08Mh1WEZc8py72qIiFU+wVmhZ7W7I
 tdKBcTZNHdAauCOIGT9wElHtT9JNEjV1PM/nixXFoFQ79aJUMeXKzkU7PhhbGjnYCDdc
 gDLCMMY725TWL5EA2FRWcpKrkTauHzos9ysziKYhvoq6ioKT6MIqr5RsH0nxAIpSEC1a
 wv3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpjWpogcEgT2kFTPNDRSOk6qpdn0+LVeILRYP+P/kIRcugZfmguBdCS627tV1XndgW3Z+BeyC3wV5f@nongnu.org
X-Gm-Message-State: AOJu0YxZkUFi3XiHZo8fDZqnDraV8pVymXhItoyOVFpuim6+Tl0r9cfW
 ZXJia/y+2GofD79rn6KwKHyTzGVcivJ6clLZIEYGQT+qASUa4sykLwPqrvgDBdM=
X-Gm-Gg: ASbGncuBBSzyBKX2DV1eAUZAZe7Vre5Cu7hvFGfNn27T/HwtCaGDp//VXZp+dJ7BsFo
 8Tbt2Y96WDO0wSP2VvF4d0DitGeqploa18QBFF/V0jCYjUZsXkvZEJR5Ic6aeWMJSWE1p2KNGR3
 BeFH0rPFu/sJvUjvOibiSH4wXAjeX3U/fEmk1xDdbGyixL+/XBBE0YHLj76a20NyG2VCoYkf0BI
 5JvAxpWlc8sJySG2tpsMSwPELg7TQeJhq+Fa6yfBghCXYHEp3/G+QkFz88hHIMj9HG/URLG381m
 vOy9oMmVck2JnoKVVsoSgejALKLo
X-Google-Smtp-Source: AGHT+IF38vZUxBGAJha6Kdm77eDa42HnfL8DoKr0PkHws/5KDelgR+61oEEJzTOjELEDEHWYu24chA==
X-Received: by 2002:a17:902:d491:b0:216:7761:cc4d with SMTP id
 d9443c01a7336-21892a7e987mr164535985ad.55.1734374740661; 
 Mon, 16 Dec 2024 10:45:40 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1e50021sm45757565ad.133.2024.12.16.10.45.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2024 10:45:40 -0800 (PST)
Message-ID: <bf824af9-3351-40b6-8d94-e51187295d49@linaro.org>
Date: Mon, 16 Dec 2024 10:45:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: contrib/plugins does not build on 32-bit host
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <dbb6dbf1-1ceb-48c0-8174-ee5dea7533dc@linaro.org>
 <718f3f80-eb3b-4d9b-b2a0-24946a8c5b79@linaro.org>
 <03bf8242-8dd7-43ae-a0a5-3f304aa546bd@linaro.org>
 <ae5c9de4-67e5-4a37-a184-eb4017723725@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <ae5c9de4-67e5-4a37-a184-eb4017723725@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

T24gMTIvMTQvMjQgMDQ6MzUsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPiBP
biAxNC8xMi8yNCAwNjoyOSwgUmljaGFyZCBIZW5kZXJzb24gd3JvdGU6DQo+PiBPbiAxMi8x
My8yNCAyMTo0NCwgUGllcnJpY2sgQm91dmllciB3cm90ZToNCj4+PiBIaSBSaWNoYXJkLA0K
Pj4+DQo+Pj4gT24gMTIvMTMvMjQgMTM6NDcsIFJpY2hhcmQgSGVuZGVyc29uIHdyb3RlOg0K
Pj4+PiBIaSwNCj4+Pj4NCj4+Pj4gU2V2ZXJhbCBvZiB0aGUgcmVjZW50IGNvbnRyaWIvcGx1
Z2lucy8gcGF0Y2hlcyBkbyBub3QgYnVpbGQgb24gZS5nLg0KPj4+PiBhcm0zMi4NCj4+Pj4g
QWxsIG9mIHRoZSBpc3N1ZXMgYXJlIHJlbGF0ZWQgdG8gY2FzdGluZyBiZXR3ZWVuIHBvaW50
ZXJzIGFuZA0KPj4+PiB1aW50NjRfdDsgdGhlcmUgaXMgYSBXZXJyb3INCj4+Pj4gZ2VuZXJh
dGVkIGZvciBjYXN0aW5nIGJldHdlZW4gcG9pbnRlcnMgYW5kIGludGVnZXJzIG9mIGRpZmZl
cmVudCBzaXplcy4NCj4+Pj4NCj4+Pj4gSSBzdXNwZWN0IGFsbCBvZiB0aGUgaW5zdGFuY2Vz
IHdpbGwgbmVlZCB0byB1c2Ugc2VwYXJhdGUgc3RydWN0dXJlcw0KPj4+PiB0byBzdG9yZSB1
aW50NjRfdA0KPj4+PiB3aXRoaW4gdGhlIGhhc2ggdGFibGVzLsKgIFRoZSBoYXNoIHZhbHVl
cyB0aGVtc2VsdmVzIGNhbiB1c2UNCj4+Pj4gdWludHB0cl90LCBhcyAiaGFzaCIgYnkNCj4+
Pj4gZGVmaW5pdGlvbiBsb3NlcyBkYXRhLg0KPj4+Pg0KPj4+PiBUaGUgZm9sbG93aW5nIGlz
ICpub3QqIGEgc3VnZ2VzdGVkIHBhdGNoLCBqdXN0IHRvdWNoZXMgZXZlcnkgcGxhY2UNCj4+
Pj4gd2l0aCBhbiBlcnJvciB0bw0KPj4+PiBoaWdobGlnaHQgYWxsIG9mIHRoZSBwbGFjZXMu
DQo+Pj4+DQo+Pj4NCj4+PiBUaGlzIGlzIHNvbWV0aGluZyBJIGFscmVhZHkgdHJpZWQgdG8g
Zml4IHRoaXMgd2F5LCBidXQgYWxhcywgY2FzdGluZw0KPj4+IHZhbHVlcyBpcyBub3QgZW5v
dWdoLCB3ZSBtaWdodCBsb3NlIGluZm9ybWF0aW9uIChpbiB0aGUgY2FzZSB3aGVyZQ0KPj4+
IGd1ZXN0IGlzIDY0IGJpdHMpLiBTb21lIHBsdWdpbnMgbmVlZCBhIHJlZmFjdG9yaW5nIHRv
IGFsbG9jYXRlIGRhdGENCj4+PiBkeW5hbWljYWxseSwgaW5zdGVhZCBvZiBoaWRpbmcgaXQg
dW5kZXIgYSBwb2ludGVyLg0KPj4+DQo+Pj4gU2VlIHRoaXMgcHJldmlvdXMgc2VyaWVzOg0K
Pj4+IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDI0MDgxNDIzMzY0NS45NDQzMjctMS0N
Cj4+PiBwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmcvDQo+Pj4NCj4+PiBGaW5hbGx5LCB3
ZSBkaXNjdXNzZWQgaXQgd2FzIG5vdCB3b3J0aCB0aGUgZWZmb3J0LCBhbmQgQWxleCBzaW1w
bHkNCj4+PiBkZWFjdGl2YXRlZCBwbHVnaW5zIGJ5IGRlZmF1bHQgZm9yIDMyIGJpdHMgcGxh
dGZvcm0sIHNvIGl0IHNob3VsZCBub3QNCj4+PiBiZSBidWlsdCBmb3IgYXJtIDMyIGJpdHMu
IElmIHdlIHJlYWxseSBoYXZlIHNvbWVvbmUgdGhhdCBuZWVkcyB0aGlzDQo+Pj4gdXNlY2Fz
ZSwgd2UgbWlnaHQgbWFrZSB0aGUgZWZmb3J0LCBidXQgZm9yIG5vdywgaXQgZG9lcyBub3Qg
c2VlbSB3b3J0aA0KPj4+IHRoZSBoYXNzbGUuDQo+IA0KPiBUaGlzIGlzOg0KPiANCj4gY29t
bWl0IGNmMmE3OGNiYmI0NjNkNTcxNmRhOTgwNWM4ZmM1NzU4OTM3OTI0ZDgNCj4gQXV0aG9y
OiBBbGV4IEJlbm7DqWUgPGFsZXguYmVubmVlQGxpbmFyby5vcmc+DQo+IERhdGU6ICAgTW9u
IFNlcCAxNiAwOTo1Mzo0MyAyMDI0ICswMTAwDQo+IA0KPiAgICAgICBkZXByZWNhdGlvbjog
ZG9uJ3QgZW5hYmxlIFRDRyBwbHVnaW5zIGJ5IGRlZmF1bHQgb24gMzIgYml0IGhvc3RzDQo+
IA0KPiAgICAgICBUaGUgZXhpc3RpbmcgcGx1Z2lucyBhbHJlYWR5IGxpYmVyYWxseSB1c2Ug
aG9zdCBwb2ludGVyIHN0dWZmaW5nIGZvcg0KPiAgICAgICBwYXNzaW5nIHVzZXIgZGF0YSB3
aGljaCB3aWxsIGZhaWwgd2hlbiBkb2luZyA2NCBiaXQgZ3Vlc3RzIG9uIDMyIGJpdA0KPiAg
ICAgICBob3N0cy4gV2Ugc2hvdWxkIGRpc2NvdXJhZ2UgdGhpcyBieSBvZmZpY2lhbGx5IGRl
cHJlY2F0aW5nIHN1cHBvcnQgYW5kDQo+ICAgICAgIGFkZGluZyBhbm90aGVyIG5haWwgdG8g
dGhlIDMyIGJpdCBob3N0IGNvZmZpbi4NCj4gDQo+IC4uLg0KPiANCj4gK1RDRyBQbHVnaW4g
c3VwcG9ydCBub3QgZW5hYmxlZCBieSBkZWZhdWx0IG9uIDMyLWJpdCBob3N0cyAoc2luY2Ug
OS4yKQ0KPiArJycnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycn
JycnJycnJycnJycnJycnJycnJycnJycnDQo+IA0KPiAuLi4NCj4gDQo+IC1pZiB0ZXN0ICIk
cGx1Z2lucyIgIT0gIm5vIjsgdGhlbg0KPiAraWYgdGVzdCAiJHBsdWdpbnMiICE9ICJubyIg
JiYgdGVzdCAkaG9zdF9iaXRzIC1lcSA2NDsgdGhlbg0KPiAgICAgIHBsdWdpbnM9eWVzDQo+
IA0KPj4gSG1tLsKgIEkgZGlkbid0IGRlbGV0ZSBteSAzMi1iaXQgYnVpbGQgdHJlZSwgYnV0
IGl0IGNlcnRhaW5seSByZS0NCj4+IGNvbmZpZ3VyZWQuwqAgSWYgcGx1Z2lucyBhcmUgc3Vw
cG9zZWQgdG8gYmUgZGlzYWJsZWQsIHNvbWV0aGluZyBtYXkgYmUNCj4+IHdyb25nIHRoZXJl
Li4uDQo+Pg0KDQpUbyBhZGQgbW9yZSBkZXRhaWxzLCBtb3N0IG9mIHRoZSBwcm9ibGVtcyB3
aXRoIHBsdWdpbnMgY29tZXMgZnJvbSANCmNvbnZlcnRpbmcgdWludDY0IHRvIHBvaW50ZXJz
LCBmb3IgdXNlIGluIGhhc2ggdGFibGVzLg0KDQpUaGUgbWFjcm9zIEdJTlRfVE9fUE9JTlRF
UiBhbmQgR1VJTlRfVE9fUE9JTlRFUiBhcmUgY2FzdGluZyB0byBsb25nIA0KYmVmb3JlIGNh
c3RpbmcgdG8gcG9pbnRlciwgc28gdGhleSBpbmhpYml0IHRoZSBjb252ZXJzaW9uIHdhcm5p
bmcgd2UgDQpzaG91bGQgbm9ybWFsbHkgaGF2ZS4gSU1ITywgaXQncyBhIGJhZCB0aGluZyBh
bmQgdmVyeSBlcnJvciBwcm9uZSBldmVuIA0KdGhvdWdoIHRoZSBHbGliIGRvY3VtZW50YXRp
b24gbWVudGlvbnMgdGhpcy4NCg0KSW4gc2hvcnQsIHRoZSBiZXN0IHdheSB0byBkZWFsIHdp
dGggdGhpcyB3b3VsZCBiZSBnZXQgcmlkIG9mIA0KR1VJTlRfVE9fUE9JTlRFUiBhbmQgR0lO
VF9UT19QT0lOVEVSIGluIHBsdWdpbnMgY29kZSwgYW5kIGZpeCBhbGwgdGhlIA0Kd2Fybmlu
Z3MgcmVsYXRlZC4NCg0KPj4NCj4+IHJ+DQo+Pg0KPiANCg0K

