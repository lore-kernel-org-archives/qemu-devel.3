Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A61C28B24
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:26:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdGy-0001y3-NR; Fri, 07 Mar 2025 14:22:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqdDf-00040y-IH
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:18:52 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqdDc-0005Jf-8H
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:18:51 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2239c066347so42388725ad.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741375126; x=1741979926; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ipNYvIfGy9HCoQoe95qjnIHQHz6NRkZlcZWjnotENhs=;
 b=PP4mL/xJ7Ih65FYKirOMOe6EzepjHCib9vCbXkh7m9TnJkocgtPKp600ZkBAoLOA2B
 qR14WkEETWv373O5OkPzJO9j4tMPhCSVy59D6/1S9dLpqRHsES8tLSGqWmOGQwRhKPMN
 MwWEaxNGfJ/RF55BL1WXAiEP4nZ1AJUVL62RSposGWpt5+UkSC8ic76g5DzehWya+eWp
 CCeIJYMg6OjzFRHVUbFlGapoDL+m2pnWl9m5XlTlQVOlRHvA/28m/uIip6AJoP6OjXdJ
 HGcryCT1m8vg9I75FEeSxI5HnReSh+xPxmKd+sp+gdOndJype1z7mMBf4tkG/QNCgmfu
 rBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741375126; x=1741979926;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ipNYvIfGy9HCoQoe95qjnIHQHz6NRkZlcZWjnotENhs=;
 b=tphQ/t2XqGgnWD9VE+sXjglQppeAwGm8UW7yKfTaHcTkmxvlFP/v4JlV/nbEaZitCn
 SZSCt7AoGgUyZFbUAVM+U2OHRwRDycI6XfaMYpsEll9RPC1DluckOctdi1OqyY7LFw4Q
 GUCdWfJORbQD6gMKaSfMjDpj1pF/u9FH1PTq3lS0eeDw57N9nx1eWSzskAV+AKbYisvM
 r7MalGaaktVi4Uvr/mM0kDPP+b25Y0LmBhqGJKHVL/12l1xDWuRfpN6/zYUWzXDW0PU5
 8PnEbSkORNgfCxK1cpn+yKwGDi7iuyN9eHfMiJCO/YbgQsLzjTHaswb94zZT2cDxWGHG
 LBJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwVsfyVeYioU3col/+M4W2oj/Zu083FgMOM6CV8NSk343i0WnvFIyV0bJ/V+lrI/MoF25/8/T9Vk+2@nongnu.org
X-Gm-Message-State: AOJu0YxI4eFT7SdrWtO7+/goe4v7oI7+hXr8sSBDdQ/Q9yeQbZ4L7KtL
 8Iiz5LKScWetQXQ5T3NiqG/bh/KNhKzjb3ToTJyBI5Q0R8ZYPXjS6/R4BJB94wg=
X-Gm-Gg: ASbGncuRTZqBQloKZt8mnPl6mjUQN2lW21uau8cx3dwaEzAUKhgw5gItcwGgun2bmrf
 r3s0CdDi78ZlHs3SMXvY7e0nyW5JusEzZlLPqoLT/bI6Ay9WWKTZvp5qiizh3UAVWlxZRfW/3LI
 tpoKk9BiOgpjeuUyFwD3+CHy7x68TIkR7vcMLwZjSxN2+EogBIsEfDx5/D8F9FKeDoPHUYABc+1
 1F9txQKXdDi9N0e+5j/57igFI4719JUzkkk5BZv2nKfayaIky7OBmbQfwwtFAWmlWF8GiZoj22l
 cs+fZzsCMUoJ5dxlaEBqEpWKjMhuv1xsEUA2+gKMue/9KLVkaiEz9JjXLA==
X-Google-Smtp-Source: AGHT+IE0ktWZg6kUQjqKpbuS3MyU7bxSsG+GT0spGEIEs+xSxG1l+PxJ1p/cqv6pse/p+Lgki+OoTw==
X-Received: by 2002:a17:902:f547:b0:224:d72:920d with SMTP id
 d9443c01a7336-22428c056a5mr68176855ad.37.1741375126480; 
 Fri, 07 Mar 2025 11:18:46 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-224109e944csm33899445ad.74.2025.03.07.11.18.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 11:18:46 -0800 (PST)
Message-ID: <86a37660-51be-4777-8bc0-794efc189a60@linaro.org>
Date: Fri, 7 Mar 2025 11:18:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/14] system/iommufd: Introduce iommufd_builtin() helper
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 kvm@vger.kernel.org, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Peter Xu <peterx@redhat.com>, Daniel Henrique Barboza
 <danielhb413@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-s390x@nongnu.org, Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 David Hildenbrand <david@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20250307180337.14811-1-philmd@linaro.org>
 <20250307180337.14811-11-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250307180337.14811-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

T24gMy83LzI1IDEwOjAzLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gaW9t
bXVmZF9idWlsdGluKCkgY2FuIGJlIHVzZWQgdG8gY2hlY2sgYXQgcnVudGltZSB3aGV0aGVy
DQo+IHRoZSBJT01NVUZEIGZlYXR1cmUgaXMgYnVpbHQgaW4gYSBxZW11LXN5c3RlbSBiaW5h
cnkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhp
bG1kQGxpbmFyby5vcmc+DQo+IC0tLQ0KPiAgIGRvY3MvZGV2ZWwvdmZpby1pb21tdWZkLnJz
dCB8IDIgKy0NCj4gICBpbmNsdWRlL3N5c3RlbS9pb21tdWZkLmggICAgfCA4ICsrKysrKysr
DQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kb2NzL2RldmVsL3ZmaW8taW9tbXVmZC5yc3QgYi9kb2Nz
L2RldmVsL3ZmaW8taW9tbXVmZC5yc3QNCj4gaW5kZXggM2QxYzExZjE3NWUuLjA4ODgyMDk0
ZWVlIDEwMDY0NA0KPiAtLS0gYS9kb2NzL2RldmVsL3ZmaW8taW9tbXVmZC5yc3QNCj4gKysr
IGIvZG9jcy9kZXZlbC92ZmlvLWlvbW11ZmQucnN0DQo+IEBAIC04OCw3ICs4OCw3IEBAIFN0
ZXAgMjogY29uZmlndXJlIFFFTVUNCj4gICAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAg
DQo+ICAgSW50ZXJhY3Rpb25zIHdpdGggdGhlIGBgL2Rldi9pb21tdWBgIGFyZSBhYnN0cmFj
dGVkIGJ5IGEgbmV3IGlvbW11ZmQNCj4gLW9iamVjdCAoY29tcGlsZWQgaW4gd2l0aCB0aGUg
YGBDT05GSUdfSU9NTVVGRGBgIG9wdGlvbikuDQo+ICtvYmplY3QgKHdoaWNoIGF2YWlsYWJp
bGl0eSBjYW4gYmUgY2hlY2tlZCBhdCBydW50aW1lIHVzaW5nIGBgaW9tbXVmZF9idWlsdGlu
KClgYCkuDQo+ICAgDQo+ICAgQW55IFFFTVUgZGV2aWNlIChlLmcuIFZGSU8gZGV2aWNlKSB3
aXNoaW5nIHRvIHVzZSBgYC9kZXYvaW9tbXVgYCBtdXN0DQo+ICAgYmUgbGlua2VkIHdpdGgg
YW4gaW9tbXVmZCBvYmplY3QuIEl0IGdldHMgYSBuZXcgb3B0aW9uYWwgcHJvcGVydHkNCj4g
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvc3lzdGVtL2lvbW11ZmQuaCBiL2luY2x1ZGUvc3lzdGVt
L2lvbW11ZmQuaA0KPiBpbmRleCBjYmFiNzViZmJmNi4uY2U0NTkyNTQwMjUgMTAwNjQ0DQo+
IC0tLSBhL2luY2x1ZGUvc3lzdGVtL2lvbW11ZmQuaA0KPiArKysgYi9pbmNsdWRlL3N5c3Rl
bS9pb21tdWZkLmgNCj4gQEAgLTYzLDQgKzYzLDEyIEBAIGJvb2wgaW9tbXVmZF9iYWNrZW5k
X2dldF9kaXJ0eV9iaXRtYXAoSU9NTVVGREJhY2tlbmQgKmJlLCB1aW50MzJfdCBod3B0X2lk
LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKipl
cnJwKTsNCj4gICANCj4gICAjZGVmaW5lIFRZUEVfSE9TVF9JT01NVV9ERVZJQ0VfSU9NTVVG
RCBUWVBFX0hPU1RfSU9NTVVfREVWSUNFICItaW9tbXVmZCINCj4gKw0KPiArc3RhdGljIGlu
bGluZSBib29sIGlvbW11ZmRfYnVpbHRpbih2b2lkKQ0KPiArew0KPiArICAgIGJvb2wgYW1i
aWcgPSBmYWxzZTsNCj4gKw0KPiArICAgIHJldHVybiBvYmplY3RfcmVzb2x2ZV9wYXRoX3R5
cGUoIiIsIFRZUEVfSU9NTVVGRF9CQUNLRU5ELCAmYW1iaWcpIHx8IGFtYmlnOw0KPiArfQ0K
PiArDQo+ICAgI2VuZGlmDQoNClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVy
cmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQoNCg==

