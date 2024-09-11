Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6D0EE0213
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 15:30:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soPI7-0003Rn-Qh; Wed, 11 Sep 2024 11:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1soPI0-000343-ND
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 11:29:52 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1soPHz-0003Ix-13
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 11:29:52 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-71911585911so1540124b3a.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 08:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726068589; x=1726673389; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V6m6vNQT7mJMu+b2f7V4GrIIRmDUGYZa9xv/2BTcLJk=;
 b=M3IggeYeaVABOb8LOGAQsCfP5jRM63+fYdZ7pclMv743VK96cEEeTGE7Y9tyTJExNg
 Weoz1B50o7tKhu2/V4rn0vi/MJhaBBg0mB8RKeYi09d8gF3fXhIKsHZoXL+AKK4Y8po8
 WMIY/RI3m3qbTrbk7voAonD4ZfdYphB4YYdgrTaI5+z4voqGXSk0eRWRuzt3UO5TZ8lR
 yZvvBiqvv9bQDyY7JDn04/hi/wFACWDGNIi/HhPs4v3Sc0r89yX01FsJSy6BDccpgP7d
 9cjn8jz3DFdL0GMKJlf6ZwEMTuE1CGoRnf+JB0b+efLcDrKpypcYMtoxYT+LUFPP1GlP
 VH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726068589; x=1726673389;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V6m6vNQT7mJMu+b2f7V4GrIIRmDUGYZa9xv/2BTcLJk=;
 b=ZHcNczYnQCjJXo42BnhSwP28HEgqEAz69YBU899OD5gghvM6Zlbf6hs2qW1Fi5OAhv
 L/RmDhrh/1RAeLPFS0VASvmyG19QMX7ATewFmV50+SxGJprwjCkclwShfOhLXehpvLRu
 FijMybojExkqsmCD5q3c1Snqe3sv2tm071mzfSRMleKi0PSiCrujfcqD9GDypssClDD4
 2aa7J59gRj3x+JlqxPzpJxTH0zkAI2uWwknoj9xRHhbWMSQZ8wo7MMvy3GauTcOXw0tf
 SqcD0MsDbIOaorknT9kqbxZkuPM4GkkuKA4JxnGa+h7rMSFBn+YWCFDwCCNnU6KXVFzv
 fc7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3t2wCaD3lG5WF4DR/53niSecb8UbfVfa1RO//QUlykdJKetWtBU8DEOzNuFLlUKLKK6HVFCSnYbjh@nongnu.org
X-Gm-Message-State: AOJu0YwV4bUr4qzavR/2JaimJiL5XEYI/3vgdn+NpjN1rniv3zwkC0uu
 7cDDFhSYVTlO4FL4hbmwz0+6Edx2rbXwPVN0lP2Vnj7THrfZwv4HNRsl0vxUKEQ=
X-Google-Smtp-Source: AGHT+IFOkNi5En1U6atzM/outL/IcTJ5jnm+OY7uZvi8WoE+fRnOsRoNmau22JwZlSN5pOufV3D+eQ==
X-Received: by 2002:a05:6a00:8584:b0:717:9296:b45f with SMTP id
 d2e1a72fcca58-71916e47608mr4240873b3a.8.1726068589407; 
 Wed, 11 Sep 2024 08:29:49 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::9633? ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fc8253sm3115128b3a.37.2024.09.11.08.29.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 08:29:48 -0700 (PDT)
Message-ID: <4a965b71-0c58-4e55-a78b-7df8195f495c@linaro.org>
Date: Wed, 11 Sep 2024 08:29:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/39] hw/pci: replace assert(false) with
 g_assert_not_reached()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, "Richard W.M. Jones" <rjones@redhat.com>, 
 Joel Stanley <joel@jms.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Corey Minyard <minyard@acm.org>, Eric Farman <farman@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Keith Busch <kbusch@kernel.org>,
 WANG Xuerui <git@xen0n.name>, Hyman Huang <yong.huang@smartx.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jesper Devantier <foss@defmacro.it>, Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov
 <imammedo@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, Fam Zheng
 <fam@euphon.net>, qemu-s390x@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 Laurent Vivier <lvivier@redhat.com>, Rob Herring <robh@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Helge Deller <deller@gmx.de>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Klaus Jensen <its@irrelevant.dk>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Jason Wang <jasowang@redhat.com>
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-20-pierrick.bouvier@linaro.org>
 <3a7fc1f2-1468-46a8-9075-7b1bf1bd6149@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <3a7fc1f2-1468-46a8-9075-7b1bf1bd6149@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

T24gOS8xMC8yNCAyMjo1MCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IEhp
IFBpZXJyaWNrLA0KPiANCj4gT24gMTEvOS8yNCAwMDoxNSwgUGllcnJpY2sgQm91dmllciB3
cm90ZToNCj4+IFNpZ25lZC1vZmYtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJv
dXZpZXJAbGluYXJvLm9yZz4NCj4+IC0tLQ0KPj4gICAgaHcvcGNpL3BjaS1zdHViLmMgfCA0
ICsrLS0NCj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2h3L3BjaS9wY2ktc3R1Yi5jIGIvaHcvcGNp
L3BjaS1zdHViLmMNCj4+IGluZGV4IGYwNTA4NjgyZDJiLi5jNjk1MGUyMWJkNCAxMDA2NDQN
Cj4+IC0tLSBhL2h3L3BjaS9wY2ktc3R1Yi5jDQo+PiArKysgYi9ody9wY2kvcGNpLXN0dWIu
Yw0KPj4gQEAgLTQ2LDEzICs0NiwxMyBAQCB2b2lkIGhtcF9wY2llX2Flcl9pbmplY3RfZXJy
b3IoTW9uaXRvciAqbW9uLCBjb25zdCBRRGljdCAqcWRpY3QpDQo+PiAgICAvKiBrdm0tYWxs
IHdhbnRzIHRoaXMgKi8NCj4+ICAgIE1TSU1lc3NhZ2UgcGNpX2dldF9tc2lfbWVzc2FnZShQ
Q0lEZXZpY2UgKmRldiwgaW50IHZlY3RvcikNCj4+ICAgIHsNCj4+IC0gICAgZ19hc3NlcnQo
ZmFsc2UpOw0KPj4gKyAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOw0KPj4gICAgICAgIHJl
dHVybiAoTVNJTWVzc2FnZSl7fTsNCj4gDQo+IFRoZSB0YWlsIG9mIHRoaXMgc2VyaWVzIHJl
bW92ZSB0aGUgdW5yZWFjaGFibGUgJ2JyZWFrJyBsaW5lcy4NCj4gV2h5ICdyZXR1cm4nIGxp
bmVzIGFyZW4ndCBwcm9ibGVtYXRpYz8gSXMgdGhhdCBhIEdDQyBUU2FuIGJ1Zz8NCj4gDQoN
Ckl0J3MgcmVsYXRlZCB0byBob3cgY29udHJvbCBmbG93IGFuYWx5c2lzIHdvcmtzLCBidXQg
SSBkb24ndCBoYXZlIGEgDQpkZWVwZXIgYW5zd2VyLiBJIHJlcG9ydGVkIHRoZSBpc3N1ZSB3
aXRoICdicmVhaycgZm9yIGdjYyBhbmQgdGhlIHNhbWUgDQpidWcgd2FzIGNyZWF0ZWQgc2V2
ZXJhbCB5ZWFycyBhZ28sIHNvIGl0IHdhcyBqdXN0IG1hcmtlZCBhcyBkdXBsaWNhdGUuDQoN
CkknbGwgY2xlYW4gdGhlIGV4dHJhIHJldHVybiB3aXRoIGhhdmUgdGhvdWdoLCBhcyBwYXJ0
IG9mIHYyLg0KDQo+PiAgICB9DQo+PiAgICANCj4+ICAgIHVpbnQxNl90IHBjaV9yZXF1ZXN0
ZXJfaWQoUENJRGV2aWNlICpkZXYpDQo+PiAgICB7DQo+PiAtICAgIGdfYXNzZXJ0KGZhbHNl
KTsNCj4+ICsgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsNCj4+ICAgICAgICByZXR1cm4g
MDsNCj4+ICAgIH0NCj4+ICAgIA0KPiANCg==

