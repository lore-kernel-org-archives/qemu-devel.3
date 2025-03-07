Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C41FC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:15:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqd9t-0004Ez-J2; Fri, 07 Mar 2025 14:14:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqd9p-00044v-C4
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:14:54 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqd9n-0007lc-5H
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:14:52 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ff087762bbso3451495a91.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741374889; x=1741979689; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xS48sSfR/nqvciBSEcVtX4LFE00mJJmnZli1lqwc2I8=;
 b=PR1mFnTOnYf41mMmgbckvvzkM46DyLIC695tjFkmIWhCR4e3PP/75Me8xT55LbLliN
 xJSSVNTJ/6dBpECu2wgINKjtwHFd65dXVA/mxYLdlZVDLGYOJdT3gVqFzDtW/NkxuCs2
 kYTMGrfPHO19F6ihUxpkAGPu6B0b9XnFOCLkGn6YxrFHP+Ik26Tin2oAR+fbPzgD1dCz
 2wbElI4Tu4WC1NfZnAzEOd/PKKnFSOKs153PEFwA8K54svsm0F6FJNv/MO2o9Nf24fm3
 rT8YgshMdRr/jq9eT9PvqaNPxgplTmmsj95ZdMDF0aOv32X6SJPw8VApxZXL2oiW6lm3
 ljLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741374889; x=1741979689;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xS48sSfR/nqvciBSEcVtX4LFE00mJJmnZli1lqwc2I8=;
 b=gXw/Da5gL4tjJCJ7PSnwN3m0OAhdZF085f+HGj1CD4fD3r9EVf2ibpoqC0BMOsmkwT
 Vtp72VfJLabOnmmk3sf9kS1TzbTWxxjGhMKWKN15yO4NrYMXi1u+HanaDsKOt963hxDu
 Jx9cDg0zpavwaWEc65i0mFkuORB9B4to+RWBw66cVyAUxZUV5Uiz6D7l4I4/ZLb2d6H2
 XYWVrUn1iJfQJjMSj9Exnlo6aTy+A4hn8BUVa0pT00Zz23Jq8Rm2g4whjxBL0jHeSDW2
 FJ2O7AsTvfXvxGbArBttzGrhXacwKb6Fn6LVHwqPYK8A+RpgGOuHFa4iGp8W372aRxxo
 fA0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWn9YbxK1YOG856nEsaoh5+Gw2UUmbaMYx6OZ/NtjxCL5dYpYRGdEtqDYNHz9jD//UrmEJwYx7NjwaB@nongnu.org
X-Gm-Message-State: AOJu0YyXjA/BSAwgJwAI+amdnavg7/RKEL+ig8G6yyWrWu7SkrQUO4GQ
 PEu9y7Kpy4K2iEmg9iQ+oSqbV86d4kcnq5yG9MrfP4mOsdF+vSDpo5Xb9i9e74I=
X-Gm-Gg: ASbGnct0FsPT4JU6lPvzHaGnYTrpKgOawEsX2eaiEAbV/nrY0eSQhHkYTOFGzdYc91u
 3pkahMrVfy3H1AHkt4HRE9Xpb+uBn8/DoFNVI6I3ITHv9IfZBIUgw8rlU/q3StorJPJMt6fVM5q
 xjeLL5w4peg5gRhd5NrGjUq+k8+Q8gAQomTD2RfqY01n2PrimwoUBiVxjxWYg+xMA7FfZr0wD4r
 jP1a69XyFGqvXU6HhXdJ+TfRnZJgA7jCGj+Z7AH6R5TuGkhQYYShH9LoYVhtCUGJmSqY7fkb0zw
 HseMEsEFOFMbh0o0qRP9IaR4n1dhL3GMpcF6+1QprjEWABusPll1XYhnDA==
X-Google-Smtp-Source: AGHT+IE73Alk6UcBWkg7YWfas3SGCUdlCaGCInmV4gpMnbflJafpM2h5wcqHKXoJ2T/ROUJtTSsGkg==
X-Received: by 2002:a17:90b:4b11:b0:2fe:994d:613b with SMTP id
 98e67ed59e1d1-2ff7cf2b59fmr7212164a91.35.1741374889557; 
 Fri, 07 Mar 2025 11:14:49 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff728a901bsm3014197a91.49.2025.03.07.11.14.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 11:14:49 -0800 (PST)
Message-ID: <59b3d1a3-541d-47a1-abd0-e649e9007990@linaro.org>
Date: Fri, 7 Mar 2025 11:14:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] hw/vfio/common: Include missing 'system/tcg.h'
 header
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
 <20250307180337.14811-2-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250307180337.14811-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102a.google.com
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

T24gMy83LzI1IDEwOjAzLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gQWx3
YXlzIGluY2x1ZGUgbmVjZXNzYXJ5IGhlYWRlcnMgZXhwbGljaXRseSwgdG8gYXZvaWQNCj4g
d2hlbiByZWZhY3RvcmluZyB1bnJlbGF0ZWQgb25lczoNCj4gDQo+ICAgIGh3L3ZmaW8vY29t
bW9uLmM6MTE3Njo0NTogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9u
IOKAmHRjZ19lbmFibGVk4oCZOw0KPiAgICAgMTE3NiB8ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdGNnX2VuYWJsZWQoKSA/IERJUlRZX0NMSUVOVFNf
QUxMIDoNCj4gICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIF5+fn5+fn5+fn5+DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBN
YXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+IC0tLQ0KPiAgIGh3L3ZmaW8v
Y29tbW9uLmMgfCAxICsNCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4g
DQo+IGRpZmYgLS1naXQgYS9ody92ZmlvL2NvbW1vbi5jIGIvaHcvdmZpby9jb21tb24uYw0K
PiBpbmRleCA3YTQwMTBlZjRlZS4uYjE1OTZiNmJmNjQgMTAwNjQ0DQo+IC0tLSBhL2h3L3Zm
aW8vY29tbW9uLmMNCj4gKysrIGIvaHcvdmZpby9jb21tb24uYw0KPiBAQCAtNDIsNiArNDIs
NyBAQA0KPiAgICNpbmNsdWRlICJtaWdyYXRpb24vbWlzYy5oIg0KPiAgICNpbmNsdWRlICJt
aWdyYXRpb24vYmxvY2tlci5oIg0KPiAgICNpbmNsdWRlICJtaWdyYXRpb24vcWVtdS1maWxl
LmgiDQo+ICsjaW5jbHVkZSAic3lzdGVtL3RjZy5oIg0KPiAgICNpbmNsdWRlICJzeXN0ZW0v
dHBtLmgiDQo+ICAgDQo+ICAgVkZJT0RldmljZUxpc3QgdmZpb19kZXZpY2VfbGlzdCA9DQoN
ClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFy
by5vcmc+DQoNCg==

