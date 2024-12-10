Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E89E77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 18:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL5FJ-0002Zq-AH; Tue, 10 Dec 2024 13:46:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tL5FD-0002Z3-Sd
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 13:46:04 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tL5FC-0006Tk-BS
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 13:46:03 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2161eb94cceso28251895ad.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 10:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733856360; x=1734461160; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ffbuJ42Ho65DPrmwcOgTn+LC56h3261OKBUdYOoYrHs=;
 b=Smh2Que4UynJrAvdMiw3Xv3XuIInTwSZnPCFa7xm/kgR7Qdt+FyTexmwYttYsapCfo
 juPubuPsq8dydDn//eIh9jSqgQYq3m3fYKOlXH22vRlxwWVkpNE22GzZYWctWDATcH1Z
 6mHeotfpZV7e04kQJ8hms1/um0TyU3qn4vEZsAyf9DZqpL7fGXaQy8OsLjrllZVBFUCQ
 Dkd8gC+IZVGzQiB1s5APwUDv8lllGeYNJT0DZfped7Hc7CR7r+EFWacjehgfxvtN3JM+
 bJOKDWuTqN35llNIkqNR5lFIgfdrrM2S+1SNXS1ql/7AqD+rvYhODzl/SK30HX68sW25
 SZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733856360; x=1734461160;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ffbuJ42Ho65DPrmwcOgTn+LC56h3261OKBUdYOoYrHs=;
 b=kyLst308M6ZpiWQPkUll7xCXoQlYl9emq2U50h4ZHPlL62Z6D6/mWRI1goBxJV1iKP
 g4n1KVLBxGWuEZm+eOxyiK/JNrtSDxRjIzXEiKpmLcJ9E/2nE6CAXc5jF6v24jnmKIif
 +jDlQQAKcmme+QKhpxWRA+tMbIl9yhJlbM4rGnCA4gIeGuwS7bZRrlgHS0/fENbhED7b
 ScqhRJXV0NwGXjFl658aB89GAYjjEFenZY//QezIvN531MFBsmlMXvO5UOPEhxWHDgPY
 s1k/xuESdzhSY1jNf6qTgGervtZ8cNWRPT4YfJ/Rm536DZAQNT03qTZV+yQ6rwIkamUx
 kp/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6XrS/+va9c5jNrvFPj7phbu6WonCgm9DuKO6nUgpZ0ll+kaYGhQ+6Nk5n6arU0l+DDpQBfwaItid8@nongnu.org
X-Gm-Message-State: AOJu0YxLyj8InoTYnzFOnC0+Dn4XYW2971YBLaZGbsWKxO60BAdIRYxH
 GHMdCeN6DV6xaV1T6sd8I/gBVgnpIT8u8QACu3VVsYBOJC/0NyTKxxCWj70HNXk=
X-Gm-Gg: ASbGncvMXhbI53lhPgsO2oiMChzcZR6aovhT9s7gedmxPM2KzfNzyv8+1twt7I2Q+0g
 FH7WKmXqLyppOwz+K6kRTQTmlgpjaQuSQ5aR5H9QsxU0AVdjg3R0FftFxNGztJ+oYZh/G8wdq73
 N+uL6gGdPe8vtIZlbOrgQUD+5GuNnfof0lAKAPziR+gt8a4LJ7ED04RqKwz/4PXAYaR58KfI2mK
 lSsNvH0iHxAgkkZ3iJdTYzvM8tfpj/6chp3YtQo8YzywOqdDXgT2KN5L8jicKdoQb0o3iy1Efd3
 a/rIE2oc/9kNk/5iTziTTyT8uQ==
X-Google-Smtp-Source: AGHT+IFRRwRFAKBVVl+H1qwOyp1x4ZViOpASQr1Z/KSjX/os4AR5CA8euiLIIVCzaZV0c3VIpjeh8Q==
X-Received: by 2002:a17:902:d4cb:b0:216:7761:cc49 with SMTP id
 d9443c01a7336-217785158cfmr2663575ad.47.1733856360360; 
 Tue, 10 Dec 2024 10:46:00 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2164252350dsm45456205ad.43.2024.12.10.10.45.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2024 10:45:59 -0800 (PST)
Message-ID: <235dde7a-1535-4268-a450-6c2407ace2c9@linaro.org>
Date: Tue, 10 Dec 2024 10:45:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] docs/devel/style: add a section about bitfield,
 and disallow them for packed structures
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20241128201510.869974-1-pierrick.bouvier@linaro.org>
 <20241128201510.869974-3-pierrick.bouvier@linaro.org>
 <73cdfb51-aef9-4731-914a-7687f988997e@linaro.org>
 <a88854b4-5004-4734-9fc4-6f34eafba5a9@redhat.com>
 <1424773d-1e06-4581-bd5b-6b216e4bad5b@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <1424773d-1e06-4581-bd5b-6b216e4bad5b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

T24gMTIvMTAvMjQgMDI6MTAsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPiBP
biAxMC8xMi8yNCAwODo1MiwgVGhvbWFzIEh1dGggd3JvdGU6DQo+PiBPbiAwOS8xMi8yMDI0
IDIxLjMzLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4+PiBPbiAyOC8xMS8y
NCAyMToxNSwgUGllcnJpY2sgQm91dmllciB3cm90ZToNCj4+Pj4gU2lnbmVkLW9mZi1ieTog
UGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0KPj4gLi4u
DQo+Pj4+ICtGb3IgdGhpcyByZWFzb24sIHdlIGRpc2FsbG93IHVzYWdlIG9mIGJpdGZpZWxk
cyBpbiBwYWNrZWQgc3RydWN0dXJlcw0KPj4+PiBhbmQgaW4gYW55DQo+Pj4+ICtzdHJ1Y3R1
cmVzIHdoaWNoIGFyZSBzdXBwb3NlZCB0byBleGFjdGx5IG1hdGNoIGEgc3BlY2lmaWMgbGF5
b3V0IGluDQo+Pj4+IGd1ZXN0DQo+Pj4+ICttZW1vcnkuIFNvbWUgZXhpc3RpbmcgY29kZSBt
YXkgdXNlIGl0LCBhbmQgd2UgY2FyZWZ1bGx5IGVuc3VyZWQgdGhlDQo+Pj4+IGxheW91dCB3
YXMNCj4+Pj4gK3RoZSBvbmUgZXhwZWN0ZWQuDQo+Pj4+ICsNCj4+Pj4gK1dlIGFsc28gc3Vn
Z2VzdCBhdm9pZGluZyBiaXRmaWVsZHMgZXZlbiBpbiBzdHJ1Y3R1cmVzIHdoZXJlIHRoZSBl
eGFjdA0KPj4+PiArbGF5b3V0IGRvZXMgbm90IG1hdHRlciwgdW5sZXNzIHlvdSBjYW4gc2hv
dyB0aGF0IHRoZXkgcHJvdmlkZSBhDQo+Pj4+IHNpZ25pZmljYW50DQo+Pj4+ICttZW1vcnkg
dXNhZ2Ugb3IgdXNhYmlsaXR5IGJlbmVmaXQuDQo+Pj4NCj4+PiBJIGRvbid0IHRoaW5rIHdl
IHNob3VsZCBtZW50aW9uICJzaWduaWZpY2FudCBtZW1vcnkgdXNhZ2UgYmVuZWZpdCIuDQo+
Pg0KPj4gV2h5IG5vdD8gVGhhdCdzIHRoZSBwb2ludCBvZiBiaXRmaWVsZHMsIGlzbid0IGl0
PyBPciBkbyB5b3UgbWVhbiBpdCdzDQo+PiBpbmNsdWRlZCBpbiAidXNhYmlsaXR5IGJlbmVm
aXQiIGFscmVhZHk/DQo+IA0KPiBUbyBub3QgZ2VuZXJhdGUgYSByZWFjdGFuY2UgZWZmZWN0
IDopIERldmVsb3BlcnMgdHJ5aW5nIHRvIG9wdGltaXplDQo+IG1lbW9yeSB1c2FnZSB2aWEg
Yml0IGZpZWxkIHVzZXMgaXMgZXh0cmVtZWx5IHJhcmUgKGF0IGxlYXN0IGluIHRoZQ0KPiBR
RU1VIGNvbW11bml0eSkuDQo+IA0KPiBBbnlob3csIEkgZG9uJ3Qgb2JqZWN0IHRvIHRoaXMg
cGF0Y2ggYXMgaXMuDQoNCkkgYXNrZWQgaW5pdGlhbGx5IGlmIHdlIHNob3VsZCBzaW1wbHkg
YWR2aXNlIGFnYWluc3QgdXNpbmcgYml0ZmllbGRzLCANCmJ1dCBpdCB3YXMgbm90IGNsZWFy
bHkgYW5zd2VyZWQgaWYgd2Ugd2FudCB0byBkbyB0aGlzIG9yIG5vdC4NCg0KIEZyb20geW91
ciBhbnN3ZXJzLCBpdCBzZWVtcyB0aGF0IHBlb3BsZSBkbyBub3QgaGF2ZSBhIGJpYXMgdG93
YXJkcyANCnVzaW5nIGJpdGZpZWxkcyBmb3IgbWVtb3J5IHVzYWdlIG9wdGltaXphdGlvbnMs
IHNvIG1heWJlIHdlIHNob3VsZCANCnNpbXBseSBkaXNjb3VyYWdlIHVzaW5nIHRoZW0gYXQg
YWxsLg0KVGhlIG9ubHkgY2FzZSBJIHRoaW5rIG9mIHdvdWxkIGJlIGEgc3BlY2lmaWMgc3Ry
dWN0IGZvcm1hdCBleGNoYW5nZWQgDQp3aXRoIHRoZSBvdXRzaWRlIHdvcmxkLCBidXQgbW9z
dCBvZiB0aGUgZXhwZXJpZW5jZWQgZGV2ZWxvcGVycyBrbm93IHRoYXQgDQp1c2luZyBiaXRm
aWVsZHMgaW4gInB1YmxpYyIgZm9ybWF0cyBpcyBhIHBvb3IgcHJhY3RpY2UuDQoNCiBGcm9t
IGFsbCB0aGF0LA0KV2hhdCBzaG91bGQgd2Ugc2F5IGluIHRoZSBkb2MgdGhlbj8NCg==

