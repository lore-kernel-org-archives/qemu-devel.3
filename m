Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8408FC3600C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 15:30:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txShM-0000z0-Ql; Wed, 26 Mar 2025 11:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1txShB-0000wy-R5
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 11:29:34 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1txSh8-0005jw-Jm
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 11:29:32 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-223fd89d036so5385ad.1
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 08:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743002969; x=1743607769; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zq/joS+HJJ9v1Cpn9ANzVwd1fpYaGmlm73OBPNu6u6c=;
 b=vDJw2E7oPKlEOTEk6POZ8WRSY0DOzV7D4t/Bvx324x5V3BSERuwIQNpkB2wwWqkyKR
 QbvV6RxzTdCzNQRxX9432JvB08cjmaPcXVQRuNN5GNt5vc17hqparvt8xBDadAgk5tdP
 3ots5YCZA6UsRCyqjAaLtgHCQun1yme+n7feMCA7cSabC0B2ZYMsPAsJ/D+A8fC8Y4ul
 pWp8QtXos5jV6VpwqeiVd/ArTKPfvJft1GUOFya2xbHy4GC6HfnR7/sb/WhJU498nb72
 qBJ4wRA07qLAwFv2gQaIavCfAUGolJQUeX1HhzKDIb17uZ0JQm9uewSzrkBn/z453U2o
 hW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743002969; x=1743607769;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zq/joS+HJJ9v1Cpn9ANzVwd1fpYaGmlm73OBPNu6u6c=;
 b=Os9Fp55eXGrIsNzxX/W3RCnnV9TqUIosa3nxrVrzxHgnY3WmoIkFgGsTtrkODS6tZK
 8cW9tvqSQ6dzT7e6TByg1TYnLhxJrLK9lu5KxAFeTSh6PNBjEGxACOIQe4haQSfMoerq
 SSRCnc4C5eKmPIcIn6Oi1Y0t2AI3bLT9utSYfJ5CRWEA2Mioc2lvhOdNLN4DA3IKAnZt
 P1VbxnQzLxeJfRFKschfVI4QTHVfdh312JtxufF2xGPQKNa3SeKEtEsvcpW/YUhXh2Sf
 iaFkN1i+DstBGO3XIKw73FYi0EUQKcrVIrZc+dmQjmDnxgxyvqBa0WVNkDA2+4gZGgT5
 Jw6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvowOESGjAtjzzHxQBZTgKXTzxIK68xWk6vcgzHMScnN1w0PbmlxKWOeqVfbbiU5mang5J6Pp6ro//@nongnu.org
X-Gm-Message-State: AOJu0YxDnFf7gbAcE31Ihy0vbh58nUkPxvvx0R9+YHciqJvqD5+c0C6Z
 a40/kVL/iWLiI5E4URxhh0TkcR4q30onEERQeytt5wttz8F10GmBfi28feLY7PQ=
X-Gm-Gg: ASbGncshXhYjftYwYjEp8FvElEKcRhj5qiV/t7C4I50Z+nm8dTzsfjokrLV+lOigYL8
 uqmZw5SGZCUtIAA9d2Ha16MsJvFietzapl7ck6JsYkO/le2GWdPbcJQ2Zn4sK9RzSy8YzZqa1EP
 lJsl7PphYXGCUecFng5iwUO7T9+0kv6rpuR3cGz6E/GUtD+YRrIOphHUjVlJ/84Dr9tvy50v2RS
 WOMBZSYA5tLn6UZu4xKQ5WbHqlEnRGzOhyNkIdedi2e+OCjZzTRyOLxBRjZ/TIb1Y/hp5x0sod5
 jJyNf88Vdg2TGvFQD9e1UoMvlGrO9lq+rgBDAxMvXuPqk/5+KyVA3siVWw==
X-Google-Smtp-Source: AGHT+IF3MZ6eE8ok+RUoxtMZfqMauvzPWlrbaB43J+qcnlb4q0wGni3TB9l0MtANJW4hFTW/UOAjmw==
X-Received: by 2002:a17:902:e886:b0:227:eb61:34b8 with SMTP id
 d9443c01a7336-227eb615177mr84716625ad.25.1743002968632; 
 Wed, 26 Mar 2025 08:29:28 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811bc272sm111122885ad.146.2025.03.26.08.29.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Mar 2025 08:29:28 -0700 (PDT)
Message-ID: <2c70b4b7-6df7-4735-a7d3-a79c0dc06332@linaro.org>
Date: Wed, 26 Mar 2025 08:28:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 7/8] target/mips: Get CPU register size using
 mips_cpu_is_64bit()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo
 <arikalo@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20250325154058.92735-1-philmd@linaro.org>
 <20250325154058.92735-8-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250325154058.92735-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

T24gMy8yNS8yNSAwODo0MCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IENQ
VSByZWdpc3RlcnMgc2l6ZSBpcyBzdGF0aWMgYW5kIGRlcGVuZHMgb24gdGhlIHR5cGUgb2Yg
Q1BVLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBo
aWxtZEBsaW5hcm8ub3JnPg0KPiAtLS0NCj4gICB0YXJnZXQvbWlwcy9nZGJzdHViLmMgfCA3
ICsrKysrKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L21pcHMvZ2Ric3R1Yi5jIGIvdGFy
Z2V0L21pcHMvZ2Ric3R1Yi5jDQo+IGluZGV4IGI5ZmM2NjczNzNlLi44NGZkM2RlNDEzNyAx
MDA2NDQNCj4gLS0tIGEvdGFyZ2V0L21pcHMvZ2Ric3R1Yi5jDQo+ICsrKyBiL3RhcmdldC9t
aXBzL2dkYnN0dWIuYw0KPiBAQCAtNzUsMTEgKzc1LDE2IEBAIGludCBtaXBzX2NwdV9nZGJf
cmVhZF9yZWdpc3RlcihDUFVTdGF0ZSAqY3MsIEdCeXRlQXJyYXkgKm1lbV9idWYsIGludCBu
KQ0KPiAgICAgICByZXR1cm4gMDsNCj4gICB9DQo+ICAgDQo+ICtzdGF0aWMgc2l6ZV90IG1p
cHNfcmVnc2l6ZShNSVBTQ1BVICpjcHUpDQo+ICt7DQo+ICsgICAgcmV0dXJuIG1pcHNfY3B1
X2lzXzY0Yml0KGNwdSkgPyBzaXplb2YodWludDY0X3QpIDogc2l6ZW9mKHVpbnQzMl90KTsN
Cj4gK30NCj4gKw0KPiAgIGludCBtaXBzX2NwdV9nZGJfd3JpdGVfcmVnaXN0ZXIoQ1BVU3Rh
dGUgKmNzLCB1aW50OF90ICptZW1fYnVmLCBpbnQgbikNCj4gICB7DQo+ICAgICAgIENQVU1J
UFNTdGF0ZSAqZW52ID0gY3B1X2Vudihjcyk7DQo+ICAgICAgIHRhcmdldF91bG9uZyB0bXA7
DQo+IC0gICAgc2l6ZV90IHJlZ3NpemUgPSBzaXplb2YodG1wKTsNCj4gKyAgICBzaXplX3Qg
cmVnc2l6ZSA9IG1pcHNfcmVnc2l6ZShNSVBTX0NQVShjcykpOw0KPiAgIA0KPiAgICAgICB0
bXAgPSBsZG5fcChtZW1fYnVmLCByZWdzaXplKTsNCj4gICANCg0KUmV2aWV3ZWQtYnk6IFBp
ZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCg0K

