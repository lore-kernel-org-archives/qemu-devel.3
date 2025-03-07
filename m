Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E74C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:15:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdAb-0005yC-0Q; Fri, 07 Mar 2025 14:15:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqdA3-0004qR-Dx
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:15:09 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqd9x-0007nW-RJ
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:15:07 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2fee4d9c2efso4044708a91.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741374900; x=1741979700; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ofp3lIgWhJlI+W74KkGN0cIXfacVx3s4ofrNFqbS9aQ=;
 b=WWOHc8JULwjpn6vwQOUE6g5ymkutEow+3pryi6M5tgq8zGRFoj9957R4vky4dSrcre
 A5DqcN2GgNG4IdaydSy7mhJhJ7vpRdfYWxHisuSD8suMdT2onDSuBsQ1GgXbdvJiyKC+
 ZX84waz91ejxTkGJAhRblmXTGOiw3W1QsFfj6p4Nqip7vPhEXcVDzz9uDVEs3IEP3L7S
 YHmXle5YYhhYHe5MNKAAg5SQJHFeZ1oOWcvedjExOx5evXn5oufMRKstVD1fjUlVG+My
 5tDgCFp+mxXzUrfP9FUm3vwy7GmAzzFjIZvVF3zZwnD+zp2mJ12VKZRXO254R0EyMbLQ
 8/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741374900; x=1741979700;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ofp3lIgWhJlI+W74KkGN0cIXfacVx3s4ofrNFqbS9aQ=;
 b=lrEX63bGfsmUDqKpUQDoEKsKKWmEQ0kuRUzzvjfvN5uUJFM2vwYm5Ip28rT5A5xedi
 MBT3agGr9CufBtFN3ZXi8U+KDbt1aRbIJenghM62TxmmrrKTMyPsXz0peK9i2dfZlZHS
 lBE2JiXCWB0A/1D5AY8XHGLjw1yuT1jcVW1jtAANL0KygYFjNG9nPstcYF0nLNI/XQYA
 2y+E8p8Qhn1W009hXNIQcUiaSTJpMcOJLIf1+dE72FrQthDEpN/uYriP2lE1GuPybFg7
 8LjkOlQI1k8HzQaAxd6irPLPRmcDKQrZBoRRS/VkI9HzG9oQ2Qbtb06pu3UTGO7+4iLh
 1aHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUc+HaL4rSf0uhD9oaKRDptSLblDOBAzcmXat+Yy/qgnZBzEEA602yDgOwnh/ycD3h8VFduyGIi1Up4@nongnu.org
X-Gm-Message-State: AOJu0YzOL68vfUuV8Ybs2A8i/vU3Fj4s7B05kD6fTDAUCFPYWWEgKNHs
 L3eR5r6PAsF0LnUEle/XX3l3vJ6nzaZgYMiGT6F8mYAJGslXXVWyN2Lh+YUeShI=
X-Gm-Gg: ASbGncvVi/bz+s/lOn1ruhyx8zbF8TOgzcTPPJctRiG18n/n9ILvg6wl+2CMGI3rfgD
 mw/UwLv93sznFiielV4SHUWB8cA/tVvPhaVjeLbV7+cVZthCmmBXhnImXGNlCup8nf9pJT5Mn1k
 ftKWWK21dfl/bs1Fbwo9IT18x6BE9YeOWtifoZ5voyvlCeDen4l7wz+VrFBc5i5LtzAX7mB+ssi
 vLfPbPz17+KiqgckgFzH37SE3LpyXTsvVbbnr4G22YjL+FpGXn4XSNLpFNJ1WEtrpgLo3wbpEbM
 66zpDPZCOSt4hoE/cJgj+2BU9lwZILZSWyUPBI7I9rf/4N4dxyfirArt0g==
X-Google-Smtp-Source: AGHT+IFumWQakier/Zrq1NKxQVuU8mKCzVTuS9e63eP54WYdDSOTwVpwYCN3lB4CTfz5lr+l3Kb7Tw==
X-Received: by 2002:a17:90b:4ad0:b0:2ff:6fc3:79c4 with SMTP id
 98e67ed59e1d1-2ff7cef5cdamr6843613a91.27.1741374900071; 
 Fri, 07 Mar 2025 11:15:00 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e826141sm5300523a91.48.2025.03.07.11.14.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 11:14:59 -0800 (PST)
Message-ID: <02102ee8-dd7f-47af-afa4-d113d461249c@linaro.org>
Date: Fri, 7 Mar 2025 11:14:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] hw/vfio/spapr: Do not include <linux/kvm.h>
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
 <20250307180337.14811-3-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250307180337.14811-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102d.google.com
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

T24gMy83LzI1IDEwOjAzLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gPGxp
bnV4L2t2bS5oPiBpcyBhbHJlYWR5IGluY2x1ZGUgYnkgInN5c3RlbS9rdm0uaCIgaW4gdGhl
IG5leHQgbGluZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1
ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj4gLS0tDQo+ICAgaHcvdmZpby9zcGFwci5jIHwg
MyAtLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9ody92ZmlvL3NwYXByLmMgYi9ody92ZmlvL3NwYXByLmMNCj4gaW5kZXggYWQ0
YzQ5OWVhZmUuLjliNWFkMDViYjFjIDEwMDY0NA0KPiAtLS0gYS9ody92ZmlvL3NwYXByLmMN
Cj4gKysrIGIvaHcvdmZpby9zcGFwci5jDQo+IEBAIC0xMSw5ICsxMSw2IEBADQo+ICAgI2lu
Y2x1ZGUgInFlbXUvb3NkZXAuaCINCj4gICAjaW5jbHVkZSA8c3lzL2lvY3RsLmg+DQo+ICAg
I2luY2x1ZGUgPGxpbnV4L3ZmaW8uaD4NCj4gLSNpZmRlZiBDT05GSUdfS1ZNDQo+IC0jaW5j
bHVkZSA8bGludXgva3ZtLmg+DQo+IC0jZW5kaWYNCj4gICAjaW5jbHVkZSAic3lzdGVtL2t2
bS5oIg0KPiAgICNpbmNsdWRlICJleGVjL2FkZHJlc3Mtc3BhY2VzLmgiDQo+ICAgDQoNClJl
dmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5v
cmc+DQoNCg==

