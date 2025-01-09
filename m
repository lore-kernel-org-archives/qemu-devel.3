Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C91CCE7719C
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 22:35:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tW17J-000435-1X; Thu, 09 Jan 2025 17:35:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tW17H-00042O-Aq
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 17:35:03 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tW17E-0005TB-8l
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 17:35:02 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-216401de828so23066345ad.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 14:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736462098; x=1737066898; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ocudPSrd7bh25c3DjeRi/mUbtR38t3MmjG56HYooUig=;
 b=QhMab/qBJUojk+tnBZxk1GOd/Ua2smo5d3BS9YBVNSqFp/Wa0X7a4JyaLcPpj8iKN7
 4DvUEfD0Xnd+vxV75iZarjGbfZioADgRJIfifS79bFQVbS+eoFtP1E8hxBKvOcO9NXjA
 D7unATmzHiyK1UzW//RbC67GL4eRq6bOdrv8bK5Kt5j5NgAstPfdxtDGCS5hO1Y71JTl
 G28a4qe4NQ2206l7K/2+0okMa/M9tN0oa5cg7xHvZvepxfw8L61VH4QrHFdtbgieQHHW
 GTYZiaQyWBVBOX/uU5o4MziXKxL7N3Ke6l7NjGljz9IXt4J/R2QU6CbsEd9pPGqKzd8R
 EmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736462098; x=1737066898;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ocudPSrd7bh25c3DjeRi/mUbtR38t3MmjG56HYooUig=;
 b=qcNWNSs2wdtBTaEbkOyXSVffgUW77DmOXiSPcPxEa4wVgOIrNoG1CvjZFslmUfJMm5
 xx2YpdMSe4nk/QjONWiNErSlY5/YBJSIwNAAWdM/8MUDIno6pmzCIgbNShwVu0AoChyZ
 GWV+Z2nbs83BCjXjxgyYmmYTJQtVpgEpQX4o0fPbakcyG7HR2tTxjW4DNAld0A73w7EZ
 Nolhs+fAuaXl54MA0K/R+SfTDUBTNYpq9FIjixDNqLgNQsarPNZgZY0XnOflwKYXivnv
 65iB1+Rx4yvS2CaGIvTx7hsE2RtDFQV77EhJteAS1QFq/QCO81UUs4L1gF7hgFf62vqz
 vFDw==
X-Gm-Message-State: AOJu0Yz+1E5y7vBJP3iLKAwWtcZKz40Jm0VL4sBX9ocVm8mWnzqTg5kl
 rKnM4iqc2jfwSvKiuHyGdYPJlC09Jfk7JUR5nb4eSWTFYkQ//biHGXHCZKK837mDsDei+G128pM
 /
X-Gm-Gg: ASbGncvThP31IFejRMCmxgHs5aTx+5qa8JHD3/E9w+NG9/2nqJFHyWZCXG7k99AuQ3U
 A4cZO+YF57tBaTddQulj1BNeju0SH1Hq8DdwUMgrQYeTnMwc3laaUfg3f6lgIVuF8kREIJ8c7/t
 7p5kp3YKlOZdCGagpj1cNFxGIkbzFubf+5Ifer0WKQ3u1icqn7z0Pe+70rV/VCduqR27+MqMESG
 AxriOOOiIdMvXg6q0+3TuO1u9MdsWopqUjdGhxZ2Wiy4bgdFXpT7GkjB3hFSTqEnvTcXA==
X-Google-Smtp-Source: AGHT+IFgkLOpb1cOh8YIFnS6T8rN42OFqecrTbhUW4Q4j3Nx7lHrkzzcFz8sqavIGzZcvQxa3+xiuA==
X-Received: by 2002:a17:902:f54d:b0:216:1543:1962 with SMTP id
 d9443c01a7336-21a83f5fbd5mr107811565ad.23.1736462098423; 
 Thu, 09 Jan 2025 14:34:58 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f22f090sm2769625ad.190.2025.01.09.14.34.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 14:34:58 -0800 (PST)
Message-ID: <da194afa-53d7-47f6-92d9-fa7535acdb98@linaro.org>
Date: Thu, 9 Jan 2025 14:34:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 04/11] vvfat: fix ubsan issue in create_long_filename
Content-Language: en-US
To: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
References: <20241228115446.2478706-1-mjt@tls.msk.ru>
 <20241228115446.2478706-5-mjt@tls.msk.ru>
 <8b48dcab-0a29-4e1c-803b-6279b276a1c4@t-online.de>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <8b48dcab-0a29-4e1c-803b-6279b276a1c4@t-online.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

SGkgVm9sa2VyLA0KDQpPbiAxMi8yOS8yNCAwMToyNCwgVm9sa2VyIFLDvG1lbGluIHdyb3Rl
Og0KPj4gRm91bmQgd2l0aCB0ZXN0IHNic2FyZWYgaW50cm9kdWNlZCBpbiBbMV0uDQo+Pg0K
Pj4gWzFdIGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDI0MTIwMzIxMzYyOS4yNDgyODA2
LTEtcGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnLw0KPj4NCj4+IC4uL2Jsb2NrL3Z2ZmF0
LmM6NDMzOjI0OiBydW50aW1lIGVycm9yOiBpbmRleCAxNCBvdXQgb2YgYm91bmRzIGZvciB0
eXBlICd1aW50OF90IFsxMV0nDQo+PiAgICAgICMwIDB4NTYxNTFhNjZiOTNhIGluIGNyZWF0
ZV9sb25nX2ZpbGVuYW1lIC4uL2Jsb2NrL3Z2ZmF0LmM6NDMzDQo+PiAgICAgICMxIDB4NTYx
NTFhNjZmM2Q3IGluIGNyZWF0ZV9zaG9ydF9hbmRfbG9uZ19uYW1lIC4uL2Jsb2NrL3Z2ZmF0
LmM6NzI1DQo+PiAgICAgICMyIDB4NTYxNTFhNjcwNDAzIGluIHJlYWRfZGlyZWN0b3J5IC4u
L2Jsb2NrL3Z2ZmF0LmM6ODA0DQo+PiAgICAgICMzIDB4NTYxNTFhNjc0NDMyIGluIGluaXRf
ZGlyZWN0b3JpZXMgLi4vYmxvY2svdnZmYXQuYzo5NjQNCj4+ICAgICAgIzQgMHg1NjE1MWE2
Nzg2N2IgaW4gdnZmYXRfb3BlbiAuLi9ibG9jay92dmZhdC5jOjEyNTgNCj4+ICAgICAgIzUg
MHg1NjE1MWEzYjhlMTkgaW4gYmRydl9vcGVuX2RyaXZlciAuLi9ibG9jay5jOjE2NjANCj4+
ICAgICAgIzYgMHg1NjE1MWEzYmI2NjYgaW4gYmRydl9vcGVuX2NvbW1vbiAuLi9ibG9jay5j
OjE5ODUNCj4+ICAgICAgIzcgMHg1NjE1MWEzY2FkYjkgaW4gYmRydl9vcGVuX2luaGVyaXQg
Li4vYmxvY2suYzo0MTUzDQo+PiAgICAgICM4IDB4NTYxNTFhM2M4ODUwIGluIGJkcnZfb3Bl
bl9jaGlsZF9icyAuLi9ibG9jay5jOjM3MzENCj4+ICAgICAgIzkgMHg1NjE1MWEzY2E4MzIg
aW4gYmRydl9vcGVuX2luaGVyaXQgLi4vYmxvY2suYzo0MDk4DQo+PiAgICAgICMxMCAweDU2
MTUxYTNjYmU0MCBpbiBiZHJ2X29wZW4gLi4vYmxvY2suYzo0MjQ4DQo+PiAgICAgICMxMSAw
eDU2MTUxYTQ2MzQ0ZiBpbiBibGtfbmV3X29wZW4gLi4vYmxvY2svYmxvY2stYmFja2VuZC5j
OjQ1Nw0KPj4gICAgICAjMTIgMHg1NjE1MWEzODhiZDkgaW4gYmxvY2tkZXZfaW5pdCAuLi9i
bG9ja2Rldi5jOjYxMg0KPj4gICAgICAjMTMgMHg1NjE1MWEzOGFiMmQgaW4gZHJpdmVfbmV3
IC4uL2Jsb2NrZGV2LmM6MTAwNg0KPj4gICAgICAjMTQgMHg1NjE1MTkwZmNhNDEgaW4gZHJp
dmVfaW5pdF9mdW5jIC4uL3N5c3RlbS92bC5jOjY0OQ0KPj4gICAgICAjMTUgMHg1NjE1MWFh
Nzk2ZGQgaW4gcWVtdV9vcHRzX2ZvcmVhY2ggLi4vdXRpbC9xZW11LW9wdGlvbi5jOjExMzUN
Cj4+ICAgICAgIzE2IDB4NTYxNTE5MGZkMmI2IGluIGNvbmZpZ3VyZV9ibG9ja2RldiAuLi9z
eXN0ZW0vdmwuYzo3MDgNCj4+ICAgICAgIzE3IDB4NTYxNTE5MTBhMzA3IGluIHFlbXVfY3Jl
YXRlX2Vhcmx5X2JhY2tlbmRzIC4uL3N5c3RlbS92bC5jOjIwMDQNCj4+ICAgICAgIzE4IDB4
NTYxNTE5MTEzZmNmIGluIHFlbXVfaW5pdCAuLi9zeXN0ZW0vdmwuYzozNjg1DQo+PiAgICAg
ICMxOSAweDU2MTUxYTdlNDM4ZSBpbiBtYWluIC4uL3N5c3RlbS9tYWluLmM6NDcNCj4+ICAg
ICAgIzIwIDB4N2Y3MmQxYTQ2MjQ5IGluIF9fbGliY19zdGFydF9jYWxsX21haW4gLi4vc3lz
ZGVwcy9ucHRsL2xpYmNfc3RhcnRfY2FsbF9tYWluLmg6NTgNCj4+ICAgICAgIzIxIDB4N2Y3
MmQxYTQ2MzA0IGluIF9fbGliY19zdGFydF9tYWluX2ltcGwgLi4vY3N1L2xpYmMtc3RhcnQu
YzozNjANCj4+ICAgICAgIzIyIDB4NTYxNTE3ZTk4NTEwIGluIF9zdGFydCAoL2hvbWUvdXNl
ci8ud29yay9xZW11L2J1aWxkL3FlbXUtc3lzdGVtLWFhcmNoNjQrMHgzYjliNTEwKQ0KPj4N
Cj4+IFRoZSBvZmZzZXQgdXNlZCBjYW4gZWFzaWx5IGdvIGJleW9uZCBlbnRyeS0+bmFtZSBz
aXplLiBJdCdzIHByb2JhYmx5IGENCj4+IGJ1ZywgYnV0IEkgZG9uJ3QgaGF2ZSB0aGUgdGlt
ZSB0byBkaXZlIGludG8gdmZhdCBzcGVjaWZpY3MgZm9yIG5vdy4NCj4gDQo+IEhpIFBpZXJy
aWNrLCBNaWNoYWVsLA0KPiANCj4gdGhpcyBwYXRjaCBicmVha3MgdGhlIGNyZWF0aW9uIG9m
IGxvbmcgZmlsZW5hbWVzIGluIHRoZSB2dmZhdCBkcml2ZXIuDQo+IA0KPj4gVGhpcyBjaGFu
Z2Ugc29sdmVzIHRoZSB1YnNhbiBpc3N1ZSwgYW5kIGlzIGZ1bmN0aW9uYWxseSBlcXVpdmFs
ZW50LCBhcw0KPj4gYW55dGhpbmcgd3JpdHRlbiBwYXN0IHRoZSBlbnRyeS0+bmFtZSBhcnJh
eSB3b3VsZCBub3QgYmUgcmVhZCBhbnl3YXkuDQo+IA0KPiBUaGlzIGFzc3VtcHRpb24gaXMg
d3JvbmcuIFRoZSBndWVzdCByZWFkcyB0aGUgYnl0ZXMgd3JpdHRlbiBwYXN0IHRoZQ0KPiBl
bnRyeS0+bmFtZSBhcnJheSBpbiB0aGUgMzIgYnl0ZSBkaXJlbnRyeV90IHN0cnVjdHVyZS4g
QSBMRk4gZGlyZW50cnkNCj4gc3RydWN0dXJlIGlzIGRpZmZlcmVudCBmcm9tIGEgcmVndWxh
ciBkaXJlbnRyeSBzdHJ1Y3R1cmUuDQo+IA0KPiBZb3UgcGF0Y2ggbGltaXRzIHRoZSBsb25n
IGZpbGUgbmFtZSB0byA1IFVDUy0yIGNoYXJhY3RlcnMgb3V0IG9mDQo+IHBvc3NpYmxlIDEz
IFVDUy0yIGNoYXJhY3RlcnMgcGVyIExGTiBlbnRyeS4NCj4gDQo+IFRvIHJlcHJvZHVjZSB0
aGUgaXNzdWU6DQo+IA0KPiBPbiB0aGUgaG9zdDoNCj4gfj4gbWtkaXIgdnZmYXQtZHJpdmUN
Cj4gfj4gdG91Y2ggInZ2ZmF0LWRyaXZlL2ZpbGUgd2l0aCBhIGxvbmcgbmFtZS50eHQiDQo+
IA0KPiBhbmQgc3RhcnQgUUVNVSB3aXRoIC1ibG9ja2Rldg0KPiBkcml2ZXI9dnZmYXQscmVh
ZC1vbmx5PXRydWUsZGlyPS4vdnZmYXQtZHJpdmUsbm9kZS1uYW1lPWRpc2stZCxsYWJlbD1o
b3N0ZHJpdmUNCj4gLWRldmljZSBzY3NpLWhkLGJ1cz1zY3NpMC4wLHNjc2ktaWQ9MCxsdW49
MSxkcml2ZT1kaXNrLWQNCj4gDQo+IE9uIHRoZSBndWVzdCB3aXRob3V0IHRoaXMgcGF0Y2g6
DQo+IH4gIyBtb3VudCAtdCB2ZmF0IC1vIHJvIC9kZXYvc2RiMSAvbW50DQo+IH4gIyBscyAv
bW50DQo+IGZpbGUgd2l0aCBhIGxvbmcgbmFtZS50eHQNCj4gDQo+IE9uIHRoZSBndWVzdCB3
aXRoIHRoaXMgcGF0Y2g6DQo+IH4gIyBtb3VudCAtdCB2ZmF0IC1vIHJvIC9kZXYvc2RiMSAv
bW50DQo+IH4gIyBscyAvbW50DQo+IGZpbGUNCj4gfiAjIGxzIC9tbnQgfCB4eGQNCj4gMDAw
MDAwMDA6IDY2NjkgNmM2NSAyMDBhwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBmaWxlIC4NCj4gDQoNClRoYW5rcyB2ZXJ5IG11Y2ggZm9y
IGFuYWx5emluZyBhbmQgZml4aW5nIHRoZSB1bmRlcmx5aW5nIGlzc3VlIFZvbGtlci4NCg0K
SSB3YXMgbm90IHN1cmUgd2hhdCB3YXMgaGFwcGVuaW5nIGhlcmUsIGJ1dCBkb2luZyBtZW1v
cnkgYWxpYXNpbmcgd2l0aCANCnR3byBkaWZmZXJlbnQgc3RydWN0cyBpcyBkZWZpbml0ZWx5
IGEgc3VzcGljaW91cyBwYXR0ZXJuLg0KSSdsbCB0ZXN0IHRoZSBwYXRjaCB5b3Ugc2VudCwg
YW5kIGdpdmUgYSByZXZpZXcgb25jZSBJIGNoZWNrIGl0IHdvcmtzLg0KDQpSZWdhcmRzLA0K
UGllcnJpY2sNCg0KPiBXaXRoIGJlc3QgcmVnYXJkcywNCj4gVm9sa2VyDQo+IA0KPj4NCj4+
IFNpZ25lZC1vZmYtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGlu
YXJvLm9yZz4NCj4+IFJldmlld2VkLWJ5OiBNaWNoYWVsIFRva2FyZXYgPG1qdEB0bHMubXNr
LnJ1Pg0KPj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBUb2thcmV2IDxtanRAdGxzLm1zay5y
dT4NCj4+IC0tLQ0KPj4gICBibG9jay92dmZhdC5jIHwgNCArKysrDQo+PiAgIDEgZmlsZSBj
aGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYmxvY2svdnZm
YXQuYyBiL2Jsb2NrL3Z2ZmF0LmMNCj4+IGluZGV4IDhmZmU4YjNiOWIuLmYyZWFmYWE5MjMg
MTAwNjQ0DQo+PiAtLS0gYS9ibG9jay92dmZhdC5jDQo+PiArKysgYi9ibG9jay92dmZhdC5j
DQo+PiBAQCAtNDI2LDYgKzQyNiwxMCBAQCBzdGF0aWMgZGlyZW50cnlfdCAqY3JlYXRlX2xv
bmdfZmlsZW5hbWUoQkRSVlZWRkFUU3RhdGUgKnMsIGNvbnN0IGNoYXIgKmZpbGVuYW1lKQ0K
Pj4gICAgICAgICAgIGVsc2UgaWYob2Zmc2V0PDIyKSBvZmZzZXQ9MTQrb2Zmc2V0LTEwOw0K
Pj4gICAgICAgICAgIGVsc2Ugb2Zmc2V0PTI4K29mZnNldC0yMjsNCj4+ICAgICAgICAgICBl
bnRyeT1hcnJheV9nZXQoJihzLT5kaXJlY3RvcnkpLHMtPmRpcmVjdG9yeS5uZXh0LTEtKGkv
MjYpKTsNCj4+ICsgICAgICAgIC8qIGVuc3VyZSB3ZSBkb24ndCB3cml0ZSBhbnl0aGluZyBw
YXN0IGVudHJ5LT5uYW1lICovDQo+PiArICAgICAgICBpZiAob2Zmc2V0ID49IHNpemVvZihl
bnRyeS0+bmFtZSkpIHsNCj4+ICsgICAgICAgICAgICBjb250aW51ZTsNCj4+ICsgICAgICAg
IH0NCj4+ICAgICAgICAgICBpZiAoaSA+PSAyICogbGVuZ3RoICsgMikgew0KPj4gICAgICAg
ICAgICAgICBlbnRyeS0+bmFtZVtvZmZzZXRdID0gMHhmZjsNCj4+ICAgICAgICAgICB9IGVs
c2UgaWYgKGkgJSAyID09IDApIHsNCj4gDQoNCg==

