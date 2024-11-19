Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9426D62068
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 16:56:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDRW4-0006YI-Sk; Tue, 19 Nov 2024 11:55:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tDRVx-0006Vg-Jx
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 11:55:47 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tDRVv-00061O-Ch
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 11:55:45 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7ae3d7222d4so3582314a12.3
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 08:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732035338; x=1732640138; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NSnW+Kri/kanWHeCTIghDBDlzmrEcu9zDmYU34nx1vs=;
 b=oueQ9AL1jzQ/kILCxOt20j55kBTTW1KWpeBPILmlbeKw6+sXtDyRmNDgCPYuFgD5zV
 AzrNzwQjOPRJ6OBs4VlB10mwbtuRDOSd4Un3y0mr3b58Iacrqlyzp7eMXK764B092S41
 CDQa9Xep4tyxaWNzdDCHJxP5rtuN+QCydgE85airc0ABplxdbycALfNeI2SkbQv8Fzcl
 uTb3dj4Pojpt7U7pbLVste2uebbTphL9Bi7ulYNghbINq1hEgQ8E0f2fAxCS2ZSsZRh2
 2AxUtY8FvxnLt0UL+fzaaNh5BfKRX9hu/ipm69CKCs+N6oMY0F1sFM3GfJSJNgXZfP9K
 0JOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732035338; x=1732640138;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NSnW+Kri/kanWHeCTIghDBDlzmrEcu9zDmYU34nx1vs=;
 b=HXRdzIcSrPbQEPgbEOBb7zV+nup6bSEyMDU+u+AfXpbNFT/BuO8iWH1GVxqU9MRv3P
 MylK94VV7IrQYMUUdt9MXKoyoAiLCr77eiDYP/OW0ICcMktL8fcnVzzBGNryKY3w7XwS
 8NvFSnOd/SnMyrRk8L8o6J7c0qj3I/TyOSIixpU7VUid71dYF7ING+Tm8izS2X67jmkp
 stTOUHFnfLNzx1MLN2pee0DsGko/wpWF0Mjh0RthivLHvX9SGwP+L1oMN4Wdt/AY2f0a
 oPe5igk/ZHAAYyYNQRdtDMqUhKk9LVVnKZ9rw/BBtaZ6wZyYaRaN10MWpcMAraKGYsTV
 qp1g==
X-Gm-Message-State: AOJu0YwoeLLt+ToVAdloWix7MJyLnWvRrohivybWotpk6vLNQVgWOo4L
 b0Z7IO/NwY2mq6/c+Ny6cabxogk+Q92r4/w3xSeuWtB+xr1JMUiQhu8PEr/2yu0=
X-Google-Smtp-Source: AGHT+IEo9Gyldwd8zVNXwwsPWA5ahdbPngHTUWiSJyziS69prW8XIMUS0jTCbVpVW+KR+zTLuTQLhg==
X-Received: by 2002:a05:6a20:3d82:b0:1db:9280:6d1f with SMTP id
 adf61e73a8af0-1dc909be805mr25602294637.0.1732035337713; 
 Tue, 19 Nov 2024 08:55:37 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7f8c1c172d1sm7998533a12.16.2024.11.19.08.55.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Nov 2024 08:55:37 -0800 (PST)
Message-ID: <618dded9-1380-4f3e-9a5d-f42b4540b798@linaro.org>
Date: Tue, 19 Nov 2024 08:55:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] plugins: generate list of symbols automatically
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
References: <20241112212622.3590693-1-pierrick.bouvier@linaro.org>
 <87wmgzpb0g.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87wmgzpb0g.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52a.google.com
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

T24gMTEvMTkvMjQgMDY6MTMsIEFsZXggQmVubsOpZSB3cm90ZToNCj4gUGllcnJpY2sgQm91
dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPiB3cml0ZXM6DQo+IA0KPj4gTm93
IHRoYXQgbWVzb24gYnVpbGQgZm9yIHBsdWdpbnMgd2FzIG1lcmdlZCwgd2UgY2FuIGNsZWFu
dXAgYW5vdGhlciBwYXJ0IHdpdGgNCj4+IHRoZSBzeW1ib2xzIGZpbGUuDQo+PiBJdCBoYXMg
dG8gYmUga2VwdCBpbiBzeW5jIGJldHdlZW4gdGhlIGhlYWRlciAocWVtdS1wbHVnaW4uaCkg
YW5kIHRoZSBzeW1ib2xzDQo+PiBmaWxlLiBUaGlzIGhhcyBwcm92ZWQgdG8gYmUgZXJyb3Ig
cHJvbmUgYW5kIHRlZGlvdXMuDQo+Pg0KPj4gV2Ugc29sdmUgdGhpcyBieSBnZW5lcmF0aW5n
IHRoaXMgbGlzdCBmcm9tIGhlYWRlciBkaXJlY3RseSB1c2luZyBhIHB5dGhvbg0KPj4gc2Ny
aXB0LiBEZXBlbmRlbmNpZXMgYXJlIHRyaWdnZXJlZCBjb3JyZWN0bHksIGFuZCB0aGUgZmls
ZSBpcyByZWdlbmVyYXRlZCBpZiB0aGUNCj4+IGhlYWRlciBpcyBtb2RpZmllZCwgYXMgZXhw
ZWN0ZWQuDQo+Pg0KPj4gdjQ6DQo+PiBmaXggc2Vjb25kIHBhdGNoIHRvIGFwcGx5IGNsZWFu
bHkgb24gbWFzdGVyICh3YXMgYXBwbGllZCBmcm9tIGEgcHJldmlvdXMgc2VyaWVzDQo+PiB0
byBlbmFibGUgd2luZG93cyBjbGFuZyBidWlsZCBiZWZvcmUpLg0KPiANCj4gUXVldWVkIHRv
IHBsdWdpbnMvbmV4dCwgdGhhbmtzLg0KPiANCj4gSSdtIG5vdCBzdXJlIGlmIGl0IG1lZXRz
IHRoZSBjcml0ZXJpYSBmb3IgOS4yIHBvc3QgZnJlZXplIGFsdGhvdWdoIGl0DQo+IHNlZW1z
IHByZXR0eSBzYWZlIGZyb20gbG9va2luZyBhdCBpdC4NCj4gDQoNCkl0IGlzIG5vdCBjaGFu
Z2luZyBvciBpbnRyb2R1Y2luZyBhIG5ldyBmZWF0dXJlLCBhbmQgY2FuIGJlIHNlZW4gYXMg
Y29kZSANCmZpeC4gSSB0ZXN0ZWQgdGhhdCBpdCBidWlsdCBvbiBNYWNPUywgV2luZG93cyBh
bmQgTGludXggKGluY2x1ZGluZyANCmV4ZWN1dGluZyBhIHBsdWdpbikgc28gaXQgc2hvdWxk
IGJlIHNhZmUgdG8gaW50ZWdyYXRlIGl0Lg0KDQpObyB3b3JyaWVzIGlmIHlvdSBwcmVmZXIg
dG8gd2FpdCwganVzdCB3YW50ZWQgdG8gbWFrZSBzdXJlIGl0J3MgaW4gDQpiZWZvcmUgYW55
IG5ldyBwbHVnaW5zIEFQSSBpcyBpbnRyb2R1Y2VkIDopDQoNCj4+DQo+PiBQaWVycmljayBC
b3V2aWVyICgzKToNCj4+ICAgIHBsdWdpbnM6IGFkZCBtaXNzaW5nIGV4cG9ydCBmb3IgcWVt
dV9wbHVnaW5fbnVtX3ZjcHVzDQo+PiAgICBwbHVnaW5zOiBkZXRlY3QgcWVtdSBwbHVnaW4g
QVBJIHN5bWJvbHMgZnJvbSBoZWFkZXINCj4+ICAgIHBsdWdpbnM6IGVyYWRpY2F0ZSBxZW11
LXBsdWdpbnMuc3ltYm9scyBzdGF0aWMgZmlsZQ0KPj4NCj4+ICAgTUFJTlRBSU5FUlMgICAg
ICAgICAgICAgICAgICAgIHwgIDEgKw0KPj4gICBpbmNsdWRlL3FlbXUvcWVtdS1wbHVnaW4u
aCAgICAgfCAgMSArDQo+PiAgIHBsdWdpbnMvbWVzb24uYnVpbGQgICAgICAgICAgICB8IDEy
ICsrKysrLS0NCj4+ICAgcGx1Z2lucy9xZW11LXBsdWdpbnMuc3ltYm9scyAgIHwgNTkgLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gICBzY3JpcHRzL3FlbXUtcGx1
Z2luLXN5bWJvbHMucHkgfCA0NSArKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICA1
IGZpbGVzIGNoYW5nZWQsIDU2IGluc2VydGlvbnMoKyksIDYyIGRlbGV0aW9ucygtKQ0KPj4g
ICBkZWxldGUgbW9kZSAxMDA2NDQgcGx1Z2lucy9xZW11LXBsdWdpbnMuc3ltYm9scw0KPj4g
ICBjcmVhdGUgbW9kZSAxMDA3NTUgc2NyaXB0cy9xZW11LXBsdWdpbi1zeW1ib2xzLnB5DQo+
IA0K

