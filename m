Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12AB9C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 23:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpc28-0004Kk-UK; Tue, 04 Mar 2025 18:50:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tpc27-0004KF-Fq
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 18:50:43 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tpc25-0005we-Dy
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 18:50:43 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-223378e2b0dso90789005ad.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 15:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741132239; x=1741737039; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3KA4kOsXG4HsQv1fjtnrxIQuAes4+qnibWGFvq/i5yc=;
 b=s2bmusFZLyr7kHbcyjVhFwIBEGf5L6OqC3HsKyDIMkvKabyFpmDafw9n3sKK1zZg1a
 KtDWZHz0TL+0tAv3c+ERlnLpDidRGHirqXexA0e9RBoKocF38xl7zu+n48f+9bNOJ93c
 +z6yfh1E1no49In14ss/yNGRXJSE3CtWkIA1rs36lFYaYMwAGRcLbwX6bBc+KQfPOCKA
 J6VKcfadLDFALt7d7lg5uWwmmmMSG70z+2N+LT5DGkeCrP7cOrli0goag14/lgkQlMLB
 x0/N2brFOeXilnU1s9gh5L0v1fyaDGWlrJAnqDxGL0l8yfTGdS7e6RoChpdlBaGXJQH6
 yn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741132239; x=1741737039;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3KA4kOsXG4HsQv1fjtnrxIQuAes4+qnibWGFvq/i5yc=;
 b=Pmfuq0KPeeByl3k4xxx9NlbDGNdOVSfSI9wtwHmf2bcgMZG+bcvFEO/AlpkngMJVPY
 DX52TYwPRaVP3aVWcaGALPmMgSNuClfRU6qIqhtMq5jXdnDeiMzzdzdkUu5rCjXyaL/4
 v9khSa+KU92YGygbhXwBlZuU10KKTq4bl1pq2+/7BAL34ZVxtz4/rgo6pvgxs1QLNl0A
 q0N35nFRc00QhfFS3GhgwMF/dQHT0j48EA6AhjqdSTdRwaUc0+7YEn1Y3Nqniu1nUZkP
 8dwg4E2TPLYe/NGSgqzI/GpQn5vXlL9IWHg0Zbh3HtAWcWQ1TM46ZHs9lVadXbwt6Pgm
 hXXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBY/70COCAKWy8/x4MEh2OFo/FoUnBZr1eDvWTTYVSl3orBRZOL2MOW8n85ghjFhIZbHnrWvyCqZdi@nongnu.org
X-Gm-Message-State: AOJu0Yyu8c1Q7rynjvotxw6cK/Kd9gdNeh6MhZFMF2LKrGdaDM6tRXm9
 3uNpXwLaioHvUYt6RQKGboIbkArfuzKT5u0GOZVtp3skaNV+aDyLwWRpzFSGkS4=
X-Gm-Gg: ASbGncvijLjO6fOHqiosNpcP7Vm9P3G5vUZvaPufqRyn+svd0RrxjEshyRovVw7J0qQ
 cT8t0nEUsD+yUH6SfZWPofYgHgrIqgOqleh6kpDOycJBJiM+7nle6oaJgiVjFQaqSaI7VlvV3Y1
 kTWkzx9ZTdgjEk7EQx/4rr6THpONfx6wyXOBu+sUmh4qOI/1RJxytjQjKe5CyeU41flZWkIksWI
 3/pEbS31GtAzo0qXA0qU727XncK9ykvivefKC5+SlPO+Yz9y2EGx8XJkoH55nVtvjryVS1ROWf8
 csFFJbYuz+GVYg+UwTiMVe34j7trUE2wv5ijuDNYqt/ibyhCy2gxgnJSQw==
X-Google-Smtp-Source: AGHT+IFNRrtxn9Y4/qJWn9MnJOFYOrebvBCD3WsBQ42Qzw6WkR3I6lCePq41eg7vyyhc/dGFwvXf/A==
X-Received: by 2002:a17:902:ce12:b0:223:5a6e:b2c with SMTP id
 d9443c01a7336-223f1cd7430mr17458655ad.17.1741132239320; 
 Tue, 04 Mar 2025 15:50:39 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2235052a622sm101520655ad.231.2025.03.04.15.50.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 15:50:38 -0800 (PST)
Message-ID: <67a10cba-5bb8-4dda-a7c7-c7a3637bb1b3@linaro.org>
Date: Tue, 4 Mar 2025 15:50:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Building QEMU as a Shared Library
Content-Language: en-US
To: Saanjh Sengupta <saanjhsengupta@outlook.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: "amir.gonnen@neuroblade.ai" <amir.gonnen@neuroblade.ai>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <PS2P216MB1388380FEF72AF5916FD9B59CCC62@PS2P216MB1388.KORP216.PROD.OUTLOOK.COM>
 <befaccff-5885-4e8d-a397-29df6cdaa7d9@linaro.org>
 <30a35e73-2f72-4e1c-b38f-c744b6884706@linaro.org>
 <SE1SPRMB0015BDAF043E9103B24B9973CCC82@SE1SPRMB0015.KORP216.PROD.OUTLOOK.COM>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <SE1SPRMB0015BDAF043E9103B24B9973CCC82@SE1SPRMB0015.KORP216.PROD.OUTLOOK.COM>
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

SGkgU2FhbmpoLA0KDQpkZXBlbmRpbmcgd2hhdCB5b3UgYXJlIHRyeWluZyB0byBhY2hpZXZl
IGV4YWN0bHksIHBsdWdpbnMgY2FuIHByb3ZpZGUgYSANCnNvbHV0aW9uLiBJdCdzIGNvbnZl
bmllbnQgYW5kIHlvdSBjYW4gc3RheSBvbiB0b3Agb2YgUUVNVSB1cHN0cmVhbSwgDQp3aXRo
b3V0IGhhdmluZyB0byBjcmVhdGUgYSBkb3duc3RyZWFtIGZvcmsuDQoNCldlIGFscmVhZHkg
aGF2ZSBwbHVnaW5zIGZvciBzdG9wcGluZyBhZnRlciBhIGdpdmVuIG51bWJlciBvZiANCmlu
c3RydWN0aW9ucywgb3Igc2xvdyBkb3duIGV4ZWN1dGlvbiBvZiBhIFZNOg0KDQojIHN0b3Ag
YWZ0ZXIgZXhlY3V0aW5nIDEnMDAwJzAwMCBpbnN0cnVjdGlvbnM6DQokIC4vYnVpbGQvcWVt
dS1zeXN0ZW0teDg2XzY0IC1wbHVnaW4gDQouL2J1aWxkL2NvbnRyaWIvcGx1Z2lucy9saWJz
dG9wdHJpZ2dlcixpY291bnQ9MTAwMDAwMCAtZCBwbHVnaW4NCg0KIyBleGVjdXRlIG5vIG1v
cmUgdGhhbiAxJzAwMCcwMDAgaW5zdHJ1Y3Rpb25zIHBlciBzZWNvbmQ6DQokIC4vYnVpbGQv
cWVtdS1zeXN0ZW0teDg2XzY0IC1wbHVnaW4gDQouL2J1aWxkL2NvbnRyaWIvcGx1Z2lucy9s
aWJpcHMuc28saXBzPTEwMDAwMDAgLWQgcGx1Z2luDQoNCllvdSBjYW4gc2VlIHNvdXJjZSBj
b2RlIGFzc29jaWF0ZWQgKC4vY29udHJpYi9wbHVnaW5zL3N0b3B0cmlnZ2VyLmMgYW5kIA0K
Li9jb250cmliL3BsdWdpbnMvaXBzLmMpLCB0byBpbXBsZW1lbnQgc29tZXRoaW5nIHNpbWls
YXIgdG8gd2hhdCB5b3UgDQp3YW50LCBidXQgYmFzZWQgb24gdGltZS4NCldvdWxkIHRoYXQg
c2F0aXNmeSB5b3VyIG5lZWQ/DQoNClJlZ2FyZHMsDQpQaWVycmljaw0KDQpPbiAzLzMvMjUg
MjE6NTMsIFNhYW5qaCBTZW5ndXB0YSB3cm90ZToNCj4gDQo+IA0KPiBIaSwNCj4gDQo+IFRo
YW5rIHlvdSBzbyBtdWNoIGZvciB5b3VyIGlucHV0cy4gSSB3YXMgYWJsZSB0byBjcmVhdGUg
dGhlIC5zbyBmaWxlIG9mIA0KPiBRRU1VLg0KPiANCj4gQWN0dWFsbHksIHdoYXQgd2UgYXJl
IHRyeWluZyBpcyB0byB1bmRlcnN0YW5kIGFuZCBleHBsb3JlIHBvc3NpYmlsaXRpZXMgDQo+
IG9mIFZpcnR1YWwgVGltZSBDb250cm9sIGluIFFFTVUuIEluIHNob3J0LCB3aGF0IEkgbWVh
biB0byBzYXkgaXMgYW4gDQo+IGFwcHJvYWNoIHZpYSB3aGljaCBJIGNhbiB0ZWxsIFFFTVUg
dG8gZW11bGF0ZSBmb3IgWFlaIHRpbWUgd2hlbiB0aGUgSSANCj4gZ2l2ZSBhIHRyaWdnZXIg
YW5kIHRoZW4gcGF1c2UgdGhlIGVtdWxhdGlvbiBieSBpdHNlbGYgYWZ0ZXIgdGhlIFhZWiB0
aW1lIA0KPiBpcyBjb21wbGV0ZWQuDQo+IA0KPiBPbiB0aGF0IGZyb250IGl0c2VsZiwgZG8g
eW91IGhhdmUgYW55IGlucHV0cy9pZGVhcyByZWdhcmRpbmcgdGhlIHNhbWU/DQo+IA0KPiAN
Cj4gUmVnYXJkcw0KPiBTYWFuamggU2VuZ3VwdGENCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+
ICpGcm9tOiogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3Jn
Pg0KPiAqU2VudDoqIFR1ZXNkYXksIEZlYnJ1YXJ5IDI1LCAyMDI1IDY6Mjk6NDQgQU0NCj4g
KlRvOiogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPjsgUGFv
bG8gQm9uemluaSANCj4gPHBib256aW5pQHJlZGhhdC5jb20+OyBNYXJjLUFuZHLDqSBMdXJl
YXUgPG1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbT4NCj4gKkNjOiogYW1pci5nb25uZW5A
bmV1cm9ibGFkZS5haSA8YW1pci5nb25uZW5AbmV1cm9ibGFkZS5haT47IHFlbXUtIA0KPiBk
ZXZlbEBub25nbnUub3JnIDxxZW11LWRldmVsQG5vbmdudS5vcmc+OyBTYWFuamggU2VuZ3Vw
dGEgDQo+IDxzYWFuamhzZW5ndXB0YUBvdXRsb29rLmNvbT4NCj4gKlN1YmplY3Q6KiBSZTog
QnVpbGRpbmcgUUVNVSBhcyBhIFNoYXJlZCBMaWJyYXJ5DQo+IEhpIFNhYW5qaCwNCj4gDQo+
IGhlcmUgaXMgYSBtaW5pbWFsIHBhdGNoIHRoYXQgYnVpbGRzIG9uZSBzaGFyZWQgbGlicmFy
eSBwZXIgdGFyZ2V0IChhcmNoLA0KPiBtb2RlKSB3aGVyZSBhcmNoIGlzIGNwdSBhcmNoLCBh
bmQgbW9kZSBpcyBzeXN0ZW0gb3IgdXNlciwgYW5kIGxhdW5jaA0KPiBzeXN0ZW0tYWFyY2g2
NCB0aHJvdWdoIGEgc2ltcGxlIGRyaXZlcjoNCj4gDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9w
Ym8tbGluYXJvL3FlbXUvY29tbWl0LyANCj4gZmJiMzljYzY0Zjc3ZDRiZjFlNWU1MDc5NWM3
NWI2MjczNWJmNWM1ZiA8aHR0cHM6Ly9naXRodWIuY29tL3Biby1saW5hcm8vIA0KPiBxZW11
L2NvbW1pdC9mYmIzOWNjNjRmNzdkNGJmMWU1ZTUwNzk1Yzc1YjYyNzM1YmY1YzVmPg0KPiAN
Cj4gV2l0aCB0aGlzLCBpdCBjb3VsZCBiZSBwb3NzaWJsZSB0byBjcmVhdGUgYSBkcml2ZXIg
dGhhdCBjYW4gZXhlY3V0ZSBhbnkNCj4gZXhpc3RpbmcgdGFyZ2V0LiBJdCdzIGEgc29ydCBv
ZiBzaW5nbGUgYmluYXJ5IGZvciBRRU1VLCBidXQgc2hhcmVkDQo+IG9iamVjdHMgYXJlIG1h
bmRhdG9yeSwgYW5kIGR1cGxpY2F0ZXMgYWxsIHRoZSBRRU1VIHN0YXRlLiBTbyB0aGVyZSBp
cyBubw0KPiByZWFsIGJlbmVmaXQgY29tcGFyZWQgdG8gaGF2aW5nIGRpZmZlcmVudCBwcm9j
ZXNzZXMuDQo+IA0KPiBJbiBtb3JlLCB0byBiZSBhYmxlIHRvIGRvIGNvbmN1cnJlbnQgZW11
bGF0aW9ucywgdGhlcmUgYXJlIG11Y2ggbW9yZQ0KPiBwcm9ibGVtcyB0byBiZSBzb2x2ZWQu
IFFFTVUgc3RhdGUgaXMgY29ycmVjdGx5IGtlcHQgcGVyIHRhcmdldCwgYnV0IGFsbA0KPiBv
dGhlciBsaWJyYXJpZXMgc3RhdGVzIGFyZSBzaGFyZWQuIFRoZXJlIGFyZSB2YXJpb3VzIGlz
c3VlcyBpZiB5b3UNCj4gbGF1bmNoIHR3byBlbXVsYXRpb25zIGF0IHRoZSBzYW1lIHRpbWUg
aW4gdHdvIHRocmVhZHM6DQo+IC0gZ2xpYiBnbG9iYWwgY29udGV4dA0KPiAtIHFlbXUgY2Fs
bHMgZXhpdCBpbiBtYW55IHBsYWNlcywgd2hpY2ggc3RvcHMgdGhlIHdob2xlIHByb2Nlc3MN
Cj4gLSBwcm9iYWJseSBvdGhlciB0aGluZ3MgSSBkaWRuJ3QgZXhwbG9yZQ0KPiANCj4gQXQg
dGhpcyBwb2ludCwgZXZlbiB0aG91Z2ggcWVtdSB0YXJnZXRzIGNhbiBiZSBidWlsdCBhcyBz
aGFyZWQgb2JqZWN0cywNCj4gSSB3b3VsZCByZWNvbW1lbmQgdG8gdXNlIGRpZmZlcmVudCBw
cm9jZXNzZXMsIGFuZCBpbXBsZW1lbnQgc29tZSBmb3JtIG9uDQo+IElQQyB0byBzeW5jaHJv
bml6ZSBhbGwgdGhpcy4NCj4gQW5vdGhlciBwb3NzaWJpbGl0eSBpcyB0byB0cnkgdG8gYnVp
bGQgbWFjaGluZXMgd2l0aG91dCB1c2luZyB0aGUNCj4gZXhpc3RpbmcgbWFpbiwgYnV0IEkn
bSBub3Qgc3VyZSBpdCdzIHdvcnRoIGFsbCB0aGUgaGFzc2xlLg0KPiANCj4gV2hhdCBhcmUg
eW91IHRyeWluZyB0byBhY2hpZXZlPw0KPiANCj4gUmVnYXJkcywNCj4gUGllcnJpY2sNCj4g
DQo+IE9uIDIvMjQvMjUgMDE6MTAsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0K
Pj4gQ2MnaW5nIG91ciBtZXNvbiBleHBlcnRzDQo+PiANCj4+IE9uIDIyLzIvMjUgMTQ6MzYs
IFNhYW5qaCBTZW5ndXB0YSB3cm90ZToNCj4+PiBIaSwNCj4+Pg0KPj4+IEkgcmVmZXJyZWQg
dG8geW91ciBtYWlsaW5nIGNoYWlucyBvbiBzdWdnZXN0aW5nIFFFTVUgdG8gYmUgYnVpbHQg
YXMgYQ0KPj4+IHNoYXJlZCBsaWJyYXJ5Lg0KPj4+DQo+Pj4gKkNoYW5nZSBtZXNvbi5idWls
ZCB0byBidWlsZCBRRU1VIGFzIGEgc2hhcmVkIGxpYnJhcnkgKHdpdGggUElDIGVuYWJsZWQN
Cj4+PiBmb3Igc3RhdGljIGxpYnJhcmllcykqDQo+Pj4gKg0KPj4+ICoNCj4+PiBDb3VsZCB5
b3UgcGxlYXNlIHN1Z2dlc3Qgd2hhdCBleGFjdGx5IGhhcyB0byBiZSBlbmFibGVkIGluIHRo
ZSBtZXNvbi5idWlsZD8NCj4+Pg0KPj4+IEkgYW0gY29uZnVzZWQgb24gdGhhdCBmcm9udC4N
Cj4+Pg0KPj4+IFJlZ2FyZHMNCj4+PiBTYWFuamggU2VuZ3VwdGENCj4+IA0KPiANCg0K

