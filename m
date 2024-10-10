Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E17CED611
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 00:51:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syhO4-0002P9-C4; Wed, 09 Oct 2024 20:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1syhO2-0002P0-Ah
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 20:50:38 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1syhO0-0008NZ-Qs
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 20:50:38 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20c5a7b2908so2728435ad.1
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 17:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728521434; x=1729126234; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1DO+mBdQNH95pTvtYwJJin8F60G3lSS7BUk0PSccvWg=;
 b=qgZnQde/Pbiapw2k/uX3ivxDZtPZTi+3Kv7EcHf4gVjLyh5g8KK+t2dtFwtjZ0UNA7
 qkntVYNNxdQnq7q7/5cDN9EN5WQQ1VdRs7HlcI2AufRNiJeDS76I12x9gm5EDwP1UODV
 x9/m/+M/cpfvDwU5Nmjb9BA9Y79VyBabsh9mAzBJxcYgvBFNGwP+AvjnNRhlxyknpJps
 IqwWjpKAghjnpAcdqaMC/iOTqC94FGI8mdaCcyf26ct/c65VNKv7ucHCs3SXz+I4mEF+
 hoeJOcA+jhdWSCzuVLpNrAV22dndglFTO/L2/SabEfQnN+myvWStGDW1uUbDH3aesA8b
 dDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728521434; x=1729126234;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1DO+mBdQNH95pTvtYwJJin8F60G3lSS7BUk0PSccvWg=;
 b=hrdOkfYLcx4QEbzjPfBhfD7z0NoY2FXKRDjFZ7UpnYY+pzklATjNYMyA0Z5WSgtZDv
 nV36e+k4SM9G6lnNR3vSxbdEm95oENMe9XrvT4cJ+pKszhvGcpNc6acsdW2od5u5P2Qz
 9sb8rFFYYgUwuvdDHYZ3I1x6bo/2QN+Hxr5jmRglkDS5xfnXBq8IsfrDJPUACtinxRKR
 3U0xL9XD2RMHCRiDB6pTYvXVbsYoWsUZ7EttVfANKUoD6qI5vJEeNEvsCQECEjOqlYtw
 WW4JPOwnKYZNJgwzuRwsp3/jVTjJ7teTxEjIXp8SQad0Oo35fWovEXRpWc7O0np5tHi6
 OS9Q==
X-Gm-Message-State: AOJu0Yzdcb9uwEteMmX3l5atJB4EPWESPVyT47QLm5jfVWtMgAKP0nxK
 ZI9pyJf0WpNmFvWZBc9fPIlNf/2p0BuON9s/Bw1DVeIk935mGLjg8ZjCY+JbLNU56jh1U0xAJg1
 ilyA=
X-Google-Smtp-Source: AGHT+IHyPXAxBuFc46m1d/80p57Thf2b1ShsxUBB2uipGE8fYlt4Lo4t/KUTeZhwvLxwkyRwm8Jz3g==
X-Received: by 2002:a17:902:e743:b0:206:b04e:71b3 with SMTP id
 d9443c01a7336-20c6378eb11mr79249475ad.51.1728521433851; 
 Wed, 09 Oct 2024 17:50:33 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8bae3f87sm300335ad.9.2024.10.09.17.50.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2024 17:50:33 -0700 (PDT)
Message-ID: <f233d9ea-eeb3-4fe2-9057-1a540b17909f@linaro.org>
Date: Wed, 9 Oct 2024 17:50:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/23] accel/tcg: Convert victim tlb to IntervalTree
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org
References: <20241009150855.804605-1-richard.henderson@linaro.org>
 <2d59794c-ae72-a3c5-85fa-01f0354c1e4c@eik.bme.hu>
 <3e2c31f1-5650-45c6-967a-f13038ba4236@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <3e2c31f1-5650-45c6-967a-f13038ba4236@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

T24gMTAvOS8yNCAxMDoxMCwgUmljaGFyZCBIZW5kZXJzb24gd3JvdGU6DQo+IE9uIDEwLzkv
MjQgMDk6MjcsIEJBTEFUT04gWm9sdGFuIHdyb3RlOg0KPj4gT24gV2VkLCA5IE9jdCAyMDI0
LCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90ZToNCj4+PiBCYXNlZC1vbjogMjAyNDEwMDkwMDA0
NTMuMzE1NjUyLTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZw0KPj4+ICgiW1BBVENI
IHYzIDAwLzIwXSBhY2NlbC90Y2c6IEludHJvZHVjZSB0bGJfZmlsbF9hbGlnbiBob29rIikN
Cj4+Pg0KPj4+IFRoZSBpbml0aWFsIGlkZWEgd2FzOiBob3cgbXVjaCBjYW4gd2UgZG8gd2l0
aCBhbiBpbnRlbGxpZ2VudCBkYXRhDQo+Pj4gc3RydWN0dXJlIGZvciB0aGUgc2FtZSBjb3N0
IGFzIGEgbGluZWFyIHNlYXJjaCB0aHJvdWdoIGFuIGFycmF5Pw0KPj4+DQo+Pj4gVGhpcyBp
cyBhbiBpbml0aWFsIGluc3RhbGxtZW50IGFsb25nIHRoZXNlIGxpbmVzLsKgIFRoaXMgaXMg
YWJvdXQNCj4+PiBhcyBmYXIgYXMgSSBjYW4gZ28gd2l0aG91dCBmaXJzdCBjb252ZXJ0aW5n
IGFsbCB0YXJnZXRzIHRvIHRoZQ0KPj4+IG5ldyB0bGJfZmlsbF9hbGlnbiBob29rLsKgIElu
ZGVlZCwgdGhlIGZpbmFsIHR3byBwYXRjaGVzIHdpbGwgbm90DQo+Pj4gY29tcGlsZSB3aXRo
IGFsbCB0YXJnZXRzIGVuYWJsZWQsIGJ1dCBoaW50IGF0IHRoZSBkaXJlY3Rpb24gb2YNCj4+
PiB0aGUgbmV4dCBzdGVwcy4NCj4+Pg0KPj4+IEkgZG8gbm90IGV4cGVjdCBsYXJnZSBwZXJm
IGNoYW5nZXMgd2l0aCB0aGlzIHBhdGNoIHNldC7CoCBJIHdpbGwNCj4+PiBiZSBoYXBweSBp
ZiBwZXJmb3JtYW5jZSBjb21lcyBvdXQgZXZlbi4NCj4+DQo+PiBUaGVuIHdoYXQncyB0aGUg
cG9pbnQ/DQo+IA0KPiBFdmVudHVhbGx5IGZpeGluZyB0aGUgcGFnZSBzaXplID4gVEFSR0VU
X1BBR0VfU0laRSBwZXJmb3JtYW5jZSBpc3N1ZXMuDQo+IA0KPiBFLmcuIHdpdGggYSAxNmsg
b3IgNjRrIGFhcmNoNjQgZ3Vlc3Qga2VybmVsLCB3ZSBzdGlsbCBoYXZlIFRBUkdFVF9QQUdF
X1NJWkUgYXQgNGssIHNvIGFsbA0KPiBndWVzdCBwYWdlcyBhcmUgImxhcmdlIiwgYW5kIHNv
IHJ1biBpbnRvIG91ciBjdXJyZW50IGJlaGF2aW91ciBvZiBmbHVzaGluZyB0aGUgZW50aXJl
IHRsYg0KPiB0b28gb2Z0ZW4uDQo+IA0KPiBFdmVuIHdpdGhvdXQgdGhhdCwgSSBleHBlY3Qg
ZnVydGhlciBjbGVhbnVwcyB0byBpbXByb3ZlIHBlcmZvcm1hbmNlLCB3ZSdyZSBqdXN0IG5v
dCB0aGVyZSB5ZXQuDQo+IA0KPiANCj4gcn4NCj4gDQoNCkRvZXMgbWVyZ2luZyBwYWdlcyBv
dmVyIGEgZ2l2ZW4gcmFuZ2UgYmUgc29tZXRoaW5nIHdlIGNvdWxkIGJlbmVmaXQgZnJvbSAN
CnRvbz8gSW4gdGhpcyBjYXNlLCBlbnRyaWVzIGluIG91ciB0bGJ0cmVlIHdvdWxkIGhhdmUg
dmFyeWluZyBzaXplLCANCmFsbG93aW5nIHVzIHRvIGNvdmVyIG1vcmUgc3BhY2Ugd2l0aCBh
IHNpbmdsZSBlbnRyeS4NCg0KSXQgd291bGQgYWxsb3cgdXMgdG8gaGF2ZSBhIG1vcmUgc2hh
bGxvdyB0bGJ0cmVlIChnaXZlbiB0aGF0IGl0J3MgDQpyZWJhbGFuY2VkIHdoZW4gbW9kaWZp
ZWQpIGFuZCBzcGVlZCB1cCB3YWxraW5nIG9wZXJhdGlvbnMuDQoNCkknbSBub3Qgc3VyZSBp
ZiBpdCBjYW4gaGVscCBwZXJmb3JtYW5jZSB3aXNlIHRob3VnaC4NCg==

