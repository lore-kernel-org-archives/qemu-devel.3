Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7182ECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 14:46:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so27r-0002H1-2r; Tue, 10 Sep 2024 10:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so27m-0001xr-3V
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:45:48 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so27j-0002qY-4N
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:45:45 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-6e7b121be30so3637300a12.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 07:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725979538; x=1726584338; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bS1uaeiA2qzCfufSwt86f2yxHhL6VkmwiCgjK4QoTfE=;
 b=aAJAEYlWQH7moehWBxJUrv54/yxIcxZHsl7CFDpDswC0+8U7n+VRJocKgcAIHt1l2r
 JKE8hTHijcrfuTO6W56ko7xNHsOEP2G7RbhJnsGg93ioxytpUPQZDN96GS6SsgTdTBsE
 tHGUQkRoEqUK7bGmrx1MpZDV1XSskZ2cHcBXwHcI+VM3mrWaNOJT5GLR6dKVkHzSSzzn
 y7lUv9jVvSjGJRCYtPtO4Uaxxy3BoJ2/rCvomI24pXuudSP2mR6rHupzcU6DJqypbqJ/
 E0QXWV1BjZBcGI/kqul/GH3iKNKEBAERwQpws9mL/aoMrDAI4GTXWKa2ig6knqENH3Ow
 voGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725979538; x=1726584338;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bS1uaeiA2qzCfufSwt86f2yxHhL6VkmwiCgjK4QoTfE=;
 b=Fimb92Ap4iuVXB3WOe1p1b/c7UL+ELMoM3fXhW6iIcf9AWg9+CIeRHOKvhBYD7zWZ5
 sc1sAFI5GVYaNCAZRn+01GVPcvNxc6bvmpZkfzxqSJyXxWCXxY5L8pPpYv46FVLbWRJ5
 deghNRt6g5P+BKh9zI/HXZ9c73q/miGnY0R+u4vEHMfIezFEjlPU7a/oVSHny/CbmkUC
 GeXSjgTbJiZ8bE3cL3jt2CRF2MY1gZAW2hx8Je7PQbRTOtleLi32bp4rPRXMCGPb8WI3
 axa9ox/KnVnBp8dyc8au4DzNJzHjw7oPMVPne9yDvPfsR7z0VXWe0yQ1o8G4Q54/junx
 /kpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcjuyu3plRabDlfEgkDlxppAUuL01Co5Lfl2RbEfLiDzR1YKMp7vBnBtKJ9GwKfvjoG7GY/7hoxrBu@nongnu.org
X-Gm-Message-State: AOJu0YymB7xjPHwVn+akSM7ZXsOLaDmtVd/CU7GRTBT7FtgT3qdI8aIt
 Zu+beherYksioL/O0kVpuJViznY9mhdBAF0lTXJWw0onHKPo1wAtwLQI3xaJKfk=
X-Google-Smtp-Source: AGHT+IG+TjhcgpBQzdG682QzQHjM9xCXeHO9pUyCcyNxFg1IaKiuRJgWF33XTc1WRzTmKT8PAh4D9w==
X-Received: by 2002:a05:6a20:c703:b0:1cf:590f:ddbc with SMTP id
 adf61e73a8af0-1cf5e0b7845mr1420892637.18.1725979537868; 
 Tue, 10 Sep 2024 07:45:37 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::9633? ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71909003c57sm1450130b3a.89.2024.09.10.07.45.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 07:45:37 -0700 (PDT)
Message-ID: <b3de06df-3f90-4e71-b923-f9f7a4fa0584@linaro.org>
Date: Tue, 10 Sep 2024 07:45:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/26] deprecation: don't enable TCG plugins by default on
 32 bit hosts
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Beraldo Leal <bleal@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Maydell
 <peter.maydell@linaro.org>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 devel@lists.libvirt.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
References: <20240910140733.4007719-1-alex.bennee@linaro.org>
 <20240910140733.4007719-12-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240910140733.4007719-12-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x534.google.com
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

T24gOS8xMC8yNCAwNzowNywgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBUaGUgZXhpc3Rpbmcg
cGx1Z2lucyBhbHJlYWR5IGxpYmVyYWxseSB1c2UgaG9zdCBwb2ludGVyIHN0dWZmaW5nIGZv
cg0KPiBwYXNzaW5nIHVzZXIgZGF0YSB3aGljaCB3aWxsIGZhaWwgd2hlbiBkb2luZyA2NCBi
aXQgZ3Vlc3RzIG9uIDMyIGJpdA0KPiBob3N0cy4gV2Ugc2hvdWxkIGRpc2NvdXJhZ2UgdGhp
cyBieSBvZmZpY2lhbGx5IGRlcHJlY2F0aW5nIHN1cHBvcnQgYW5kDQo+IGFkZGluZyBhbm90
aGVyIG5haWwgdG8gdGhlIDMyIGJpdCBob3N0IGNvZmZpbi4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IEFsZXggQmVubsOpZSA8YWxleC5iZW5uZWVAbGluYXJvLm9yZz4NCj4gDQo+IC0tLQ0K
PiB2Mg0KPiAgICAtIGRvbid0IG1hbnVhbGx5IHNldCBiYXNlZCBvbiBDUFUgdHlwZSwgdXNl
IF9fU0laRU9GX1BPSU5URVJfXw0KPiAtLS0NCj4gICBkb2NzL2Fib3V0L2RlcHJlY2F0ZWQu
cnN0IHwgMTEgKysrKysrKysrKysNCj4gICBjb25maWd1cmUgICAgICAgICAgICAgICAgIHwg
MjEgKysrKysrKysrKysrKysrKysrKystDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAzMSBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZG9jcy9hYm91
dC9kZXByZWNhdGVkLnJzdCBiL2RvY3MvYWJvdXQvZGVwcmVjYXRlZC5yc3QNCj4gaW5kZXgg
ODhmMGYwMzc4Ni4uZjdjN2MzM2QzOSAxMDA2NDQNCj4gLS0tIGEvZG9jcy9hYm91dC9kZXBy
ZWNhdGVkLnJzdA0KPiArKysgYi9kb2NzL2Fib3V0L2RlcHJlY2F0ZWQucnN0DQo+IEBAIC0x
ODQsNiArMTg0LDE3IEBAIGJlIGFuIGVmZmVjdGl2ZSB1c2Ugb2YgaXRzIGxpbWl0ZWQgcmVz
b3VyY2VzLCBhbmQgdGh1cyBpbnRlbmRzIHRvIGRpc2NvbnRpbnVlDQo+ICAgaXQuIFNpbmNl
IGFsbCByZWNlbnQgeDg2IGhhcmR3YXJlIGZyb20gdGhlIHBhc3QgPjEwIHllYXJzIGlzIGNh
cGFibGUgb2YgdGhlDQo+ICAgNjQtYml0IHg4NiBleHRlbnNpb25zLCBhIGNvcnJlc3BvbmRp
bmcgNjQtYml0IE9TIHNob3VsZCBiZSB1c2VkIGluc3RlYWQuDQo+ICAgDQo+ICtUQ0cgUGx1
Z2luIHN1cHBvcnQgbm90IGVuYWJsZWQgYnkgZGVmYXVsdCBvbiAzMi1iaXQgaG9zdHMgKHNp
bmNlIDkuMikNCj4gKycnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycn
JycnJycnJycnJycnJycnJycnJycnJycnJycnJw0KPiArDQo+ICtXaGlsZSBpdCBpcyBzdGls
bCBwb3NzaWJsZSB0byBlbmFibGUgVENHIHBsdWdpbiBzdXBwb3J0IGZvciAzMi1iaXQNCj4g
K2hvc3RzIHRoZXJlIGFyZSBhIG51bWJlciBvZiBwb3RlbnRpYWwgcGl0ZmFsbHMgd2hlbiBp
bnN0cnVtZW50aW5nDQo+ICs2NC1iaXQgZ3Vlc3RzLiBUaGUgcGx1Z2luIEFQSXMgdHlwaWNh
bGx5IHBhc3MgbW9zdCBhZGRyZXNzZXMgYXMNCj4gK3VpbnQ2NF90IGJ1dCBwcmFjdGljZXMg
bGlrZSBlbmNvZGluZyB0aGF0IGFkZHJlc3MgaW4gYSBob3N0IHBvaW50ZXINCj4gK2ZvciBw
YXNzaW5nIGFzIHVzZXItZGF0YSB3aWxsIGxvc2UgZGF0YS4gQXMgbW9zdCBzb2Z0d2FyZSBh
bmFseXNpcw0KPiArYmVuZWZpdHMgZnJvbSBoYXZpbmcgcGxlbnR5IG9mIGhvc3QgbWVtb3J5
IGl0IHNlZW1zIHJlYXNvbmFibGUgdG8NCj4gK2VuY291cmFnZSB1c2VycyB0byB1c2UgNjQg
Yml0IGJ1aWxkcyBvZiBRRU1VIGZvciBhbmFseXNpcyB3b3JrDQo+ICt3aGF0ZXZlciB0YXJn
ZXRzIHRoZXkgYXJlIGluc3RydW1lbnRpbmcuDQo+ICAgDQo+ICAgU3lzdGVtIGVtdWxhdG9y
IENQVXMNCj4gICAtLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiBkaWZmIC0tZ2l0IGEvY29uZmln
dXJlIGIvY29uZmlndXJlDQo+IGluZGV4IDQwMTg2ZDg2NWUuLjE0NTgxYzFiOWEgMTAwNzU1
DQo+IC0tLSBhL2NvbmZpZ3VyZQ0KPiArKysgYi9jb25maWd1cmUNCj4gQEAgLTUxNiw2ICs1
MTYsMjUgQEAgY2FzZSAiJGNwdSIgaW4NCj4gICAgICAgOzsNCj4gICBlc2FjDQo+ICAgDQo+
ICsjIE5vdyB3ZSBoYXZlIG91ciBDUFVfQ0ZMQUdTIHdlIGNhbiBjaGVjayBpZiB3ZSBhcmUg
dGFyZ2V0aW5nIGEgMzIgb3INCj4gKyMgNjQgYml0IGhvc3QuDQo+ICsNCj4gK2NoZWNrXzY0
Yml0X2hvc3QoKSB7DQo+ICtjYXQgPiAkVE1QQyA8PEVPRg0KPiArI2lmIF9fU0laRU9GX1BP
SU5URVJfXyAhPSA4DQo+ICsjZXJyb3Igbm90IDY0IGJpdCBzeXN0ZW0NCj4gKyNlbmRpZg0K
PiAraW50IG1haW4odm9pZCkgeyByZXR1cm4gMDsgfQ0KPiArRU9GDQo+ICsgIGNvbXBpbGVf
b2JqZWN0ICIkMSINCj4gK30NCj4gKw0KPiAraWYgY2hlY2tfNjRiaXRfaG9zdCAiJENQVV9D
RkxBR1MiOyB0aGVuDQo+ICsgICAgaG9zdF9iaXRzPTY0DQo+ICtlbHNlDQo+ICsgICAgaG9z
dF9iaXRzPTMyDQo+ICtmaQ0KPiArDQo+ICAgaWYgdGVzdCAtbiAiJGhvc3RfYXJjaCIgJiYg
ew0KPiAgICAgICAhIHRlc3QgLWQgIiRzb3VyY2VfcGF0aC9saW51eC11c2VyL2luY2x1ZGUv
aG9zdC8kaG9zdF9hcmNoIiB8fA0KPiAgICAgICAhIHRlc3QgLWQgIiRzb3VyY2VfcGF0aC9j
b21tb24tdXNlci9ob3N0LyRob3N0X2FyY2giOyB9OyB0aGVuDQo+IEBAIC0xMDI4LDcgKzEw
NDcsNyBAQCBpZiB0ZXN0ICIkc3RhdGljIiA9ICJ5ZXMiIDsgdGhlbg0KPiAgICAgZmkNCj4g
ICAgIHBsdWdpbnM9Im5vIg0KPiAgIGZpDQo+IC1pZiB0ZXN0ICIkcGx1Z2lucyIgIT0gIm5v
IjsgdGhlbg0KPiAraWYgdGVzdCAiJHBsdWdpbnMiICE9ICJubyIgJiYgdGVzdCAkaG9zdF9i
aXRzIC1lcSA2NDsgdGhlbg0KPiAgICAgcGx1Z2lucz15ZXMNCj4gICAgIHN1YmRpcnM9IiRz
dWJkaXJzIGNvbnRyaWIvcGx1Z2lucyINCj4gICBmaQ0KDQpUaGFua3MsIGl0IHNob3VsZCBv
cGVuIHRoZSBkb29yIHRvIGJlIGFibGUgdG8gYnVpbGQgcGx1Z2lucyB3aXRoIG1lc29uLg0K
UmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJv
Lm9yZz4NCg==

