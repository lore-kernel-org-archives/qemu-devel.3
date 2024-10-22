Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7386ACDD0EA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 20:38:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3LdU-0002K0-6E; Tue, 22 Oct 2024 16:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3LdQ-0002JX-IS
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 16:37:45 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3LdO-0008HU-Ts
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 16:37:44 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-71eb1d0e3c2so2716405b3a.2
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 13:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729629461; x=1730234261; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f5sdSPp62Q75k/UPTlmS2tewvumj3hSalan6FnEOZPk=;
 b=pD9pFtqVddxnNhgfSwdKTIEAkF4XbM0EK5E2WEz8qQbuxxlzFFoPhf2EOntGov2xT3
 jCSOA6EzkJ45hZB+2XjL4+egMDN/EULZgiaeaBbjkJkjFA4AU/tEmOGaMZvCtVV4mHtP
 qoj5nSuUSw78jFyihdd02i0iPZRWh2F9eblULuvpihQ2X6zvXoDG5X5g09HFr5ryV8Y1
 hgUrDsYgpvjtg5kHShrX7nokFdRHjE4eMvAOhhW7LjMnkqdPlcmkdG8DRkKdjwQAAZDN
 SmsLJAnWfHD0sa3sjbDPvVi4VXA0UIYQIlXNaoqghPZhqIxoWJzccHCEkjSANtUyR2Pr
 vPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729629461; x=1730234261;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f5sdSPp62Q75k/UPTlmS2tewvumj3hSalan6FnEOZPk=;
 b=Z5qF4YZFsGyWCLLBmQjZxAX0Td+s9LmLgKt7G8uLp9ieiGiFJI2fTzPFOOkko7mVzj
 RgrdmSWcQXrgSEba3jm8nhHO6DpK5m4FvM9FyqCH26xoIbuJwQxYwwSFmypaItq0F2o7
 NLrMw7vF8i+kQwQORG6QPyGMKxS6cZltwVkG5vhK+EEfTxOOXZtp2w5Qq77L1+zuDg6h
 QHrK6PlbNyHkuld87lcsOABcg6x7DmRenxePN0fpRD9hMQbBasAed5L7DZEyHT0Gomsy
 Jl4KoMRNHKufsCQV/l59gR59Ti7HFPQQAe8iTBu+fLEInIKS3IqNblY4wK+mHuJfRqKo
 22fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQ1MUGC+SNjo2yygYMryybpekNPHKIFL5KSrs2aWNpksx+eOvFZTBLz4EPM9bLz4BnL6xNILD76XFA@nongnu.org
X-Gm-Message-State: AOJu0YzpDJRPq9kisQEGzqahWp6AJFelHtqPElcM9KlPKOpbTBjWs5qg
 9vBjGO8ICnReI2oZjvvMdnUOntxdN7ayT6ba/qLa1877QyBq88hzl+H/WX90Bdo=
X-Google-Smtp-Source: AGHT+IHBgvymnZDA1aAIEhXx4lrpTcO5QXRmbjHef4foA8M1Uym7OgXgjk3rpWC2gUn74uJXA5Ecbw==
X-Received: by 2002:a05:6a00:8c3:b0:71e:a3:935b with SMTP id
 d2e1a72fcca58-72030cd2654mr594674b3a.25.1729629461420; 
 Tue, 22 Oct 2024 13:37:41 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec141507csm5125532b3a.215.2024.10.22.13.37.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 13:37:41 -0700 (PDT)
Message-ID: <10600e67-2d97-4cfb-829f-34e740e47e2b@linaro.org>
Date: Tue, 22 Oct 2024 13:37:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/20] config/targets: update aarch64_be-linux-user gdb
 XML list
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 devel@lists.libvirt.org, Cleber Rosa <crosa@redhat.com>,
 kvm@vger.kernel.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241022105614.839199-1-alex.bennee@linaro.org>
 <20241022105614.839199-13-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241022105614.839199-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

T24gMTAvMjIvMjQgMDM6NTYsIEFsZXggQmVubsOpZSB3cm90ZToNCj4gQXR0ZW1wdGluZyB0
byBydW4gdGhlIGJpbmFyeSBhc3NlcnRzIHdoZW4gaXQgY2FuJ3QgZmluZCB0aGUgWE1MIGVu
dHJ5Lg0KPiBXZSBjYW4gZml4IGl0IHNvIHdlIGRvbid0IGFsdGhvdWdoIEkgc3VzcGVjdCBv
dGhlciBzdHVmZiBpcyBicm9rZW4uDQo+IA0KPiBGaXhlczogaHR0cHM6Ly9naXRsYWIuY29t
L3FlbXUtcHJvamVjdC9xZW11Ly0vaXNzdWVzLzI1ODANCj4gU2lnbmVkLW9mZi1ieTogQWxl
eCBCZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5hcm8ub3JnPg0KPiAtLS0NCj4gICBjb25maWdz
L3RhcmdldHMvYWFyY2g2NF9iZS1saW51eC11c2VyLm1hayB8IDIgKy0NCj4gICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9jb25maWdzL3RhcmdldHMvYWFyY2g2NF9iZS1saW51eC11c2VyLm1hayBiL2NvbmZp
Z3MvdGFyZ2V0cy9hYXJjaDY0X2JlLWxpbnV4LXVzZXIubWFrDQo+IGluZGV4IDc3OGQyMmIy
YTkuLmRjZWY1OTdhODAgMTAwNjQ0DQo+IC0tLSBhL2NvbmZpZ3MvdGFyZ2V0cy9hYXJjaDY0
X2JlLWxpbnV4LXVzZXIubWFrDQo+ICsrKyBiL2NvbmZpZ3MvdGFyZ2V0cy9hYXJjaDY0X2Jl
LWxpbnV4LXVzZXIubWFrDQo+IEBAIC0xLDcgKzEsNyBAQA0KPiAgIFRBUkdFVF9BUkNIPWFh
cmNoNjQNCj4gICBUQVJHRVRfQkFTRV9BUkNIPWFybQ0KPiAgIFRBUkdFVF9CSUdfRU5ESUFO
PXkNCj4gLVRBUkdFVF9YTUxfRklMRVM9IGdkYi14bWwvYWFyY2g2NC1jb3JlLnhtbCBnZGIt
eG1sL2FhcmNoNjQtZnB1LnhtbCBnZGIteG1sL2FhcmNoNjQtcGF1dGgueG1sDQo+ICtUQVJH
RVRfWE1MX0ZJTEVTPSBnZGIteG1sL2FhcmNoNjQtY29yZS54bWwgZ2RiLXhtbC9hYXJjaDY0
LWZwdS54bWwgZ2RiLXhtbC9hYXJjaDY0LXBhdXRoLnhtbCBnZGIteG1sL2FhcmNoNjQtbXRl
LnhtbA0KPiAgIFRBUkdFVF9IQVNfQkZMVD15DQo+ICAgQ09ORklHX1NFTUlIT1NUSU5HPXkN
Cj4gICBDT05GSUdfQVJNX0NPTVBBVElCTEVfU0VNSUhPU1RJTkc9eQ0KDQpSZXZpZXdlZC1i
eTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0K

