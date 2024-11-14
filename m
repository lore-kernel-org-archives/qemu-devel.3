Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 995DED41C00
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 04:12:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBRD1-00043l-9b; Wed, 13 Nov 2024 23:11:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBRCz-00042V-8d
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 23:11:53 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBRCx-0003hS-RQ
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 23:11:53 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7f71f2b136eso104747a12.1
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 20:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731557510; x=1732162310; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oq8ZFiqY5hOBspLrityVjNiFRVTtpqycD9ZCTgsskLw=;
 b=AT3w1C9ebaSDDxzIVLn7/G2YNI+pn+CwhM0GnksaQupokCe18YR0lTq1Zj+sceIEdD
 AIwM20BvrdAaypcer0ZKps7BAQCzLgWvZtqsKGEaOu1HiC724hc9/dS9+lxVL2PskPuA
 fRx21yKoJ/Y4mA1eZZ9IKyUIkxxnuDNSWCUqm3aACjSR/GjAGMD1EJ6dXZ2AF2g0/tTS
 G6IXP/dui9MgtotFffQOq1BUg+rIUsOih8CbfIrKTLK01FTulR8nNXDmub04tQKC17CC
 gFVhx/gHTXnnrZb/znBu/h8pqs3wua55W4RhcCBSArbxdFBP1+Cux3klivCyC7ARt+Tn
 U5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731557510; x=1732162310;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oq8ZFiqY5hOBspLrityVjNiFRVTtpqycD9ZCTgsskLw=;
 b=mrjYJQX7/+YtAlLU+49CC1HNEwZsBb+/IBxuxCWkFqKC+Rqodogk/5AcEHW2OS1KQR
 sqQHvXxLJHSir7cEBzyBjHS+xGExNS3UyW0sEwhcOSq6ycX7KKRfeeKxAQXPrVdDrKag
 /PFD0XHTWS34EQmXPBR0ZP69NRKKv5pQ2cqTNw6tFrDxRGt8P+tpWleP+RhkkAL4nf1u
 RxsFZnCFS1MIn3r0MmUBC8XU4FRUMjJEmJeq0hj5xUEQRhSwlyh1OEM8phO2n1cxUP59
 rg6HeQ5vZsCK9YH92HAxJrGvl81EeA/uDI8wCzEvrgEry8y8cNY0S2mip5blS0cWP+R7
 51Dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVD7CyPBAESlz8x7QO6jGpkvUqw1Grsc8HEBIBc6IFlu65ESpkNi0anasyhj0O7uyns/aDjsagf+Q44@nongnu.org
X-Gm-Message-State: AOJu0YxIoRjx+8cnHeNxM0okE1EdpJ1g0nNLxJdbAzynyccKTjhZGF92
 trNpsd3p87J97viTNtYgeO1aDnlYe9dJw5Gwyux9zaAqFUqR/atRWc0LcoSgC/M=
X-Google-Smtp-Source: AGHT+IHqdt5ajiplTEaovUDLGl51afHdEnTQZFliWrlTx+v1CRNbAMpFrwaeese2sJlT/0cOEXoObA==
X-Received: by 2002:a05:6a21:33a2:b0:1d9:18af:d150 with SMTP id
 adf61e73a8af0-1dc229d5f22mr32400641637.21.1731557510608; 
 Wed, 13 Nov 2024 20:11:50 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a6e6fabsm253911b3a.67.2024.11.13.20.11.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2024 20:11:50 -0800 (PST)
Message-ID: <4e6b9e45-0401-4fd0-a7c3-63cf6e4f444a@linaro.org>
Date: Wed, 13 Nov 2024 20:11:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/24] target/arm/mte: Restrict 'exec/ram_addr.h' to
 system emulation
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, 
 Peter Xu <peterx@redhat.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-s390x@nongnu.org
References: <20241114011310.3615-1-philmd@linaro.org>
 <20241114011310.3615-10-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114011310.3615-10-philmd@linaro.org>
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

DQoNCk9uIDExLzEzLzI0IDE3OjEyLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToN
Cj4gImV4ZWMvcmFtX2FkZHIuaCIgY29udGFpbnMgc3lzdGVtIHNwZWNpZmljIGRlY2xhcmF0
aW9ucy4NCj4gUmVzdHJpY3QgaXRzIGluY2x1c2lvbiB0byBzeXNlbXUgdG8gYXZvaWQgYnVp
bGQgZXJyb3JzDQo+IHdoZW4gcmVmYWN0b3JpbmcuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQ
aGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+IC0tLQ0KPiAg
IHRhcmdldC9hcm0vdGNnL210ZV9oZWxwZXIuYyB8IDIgKysNCj4gICAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L2FybS90Y2cv
bXRlX2hlbHBlci5jIGIvdGFyZ2V0L2FybS90Y2cvbXRlX2hlbHBlci5jDQo+IGluZGV4IDlk
MmJhMjg3ZWUuLmIwMTdiMjZkMDcgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9hcm0vdGNnL210
ZV9oZWxwZXIuYw0KPiArKysgYi90YXJnZXQvYXJtL3RjZy9tdGVfaGVscGVyLmMNCj4gQEAg
LTIzLDcgKzIzLDkgQEANCj4gICAjaW5jbHVkZSAiaW50ZXJuYWxzLmgiDQo+ICAgI2luY2x1
ZGUgImV4ZWMvZXhlYy1hbGwuaCINCj4gICAjaW5jbHVkZSAiZXhlYy9wYWdlLXByb3RlY3Rp
b24uaCINCj4gKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQ0KPiAgICNpbmNsdWRlICJleGVj
L3JhbV9hZGRyLmgiDQo+ICsjZW5kaWYNCj4gICAjaW5jbHVkZSAiZXhlYy9jcHVfbGRzdC5o
Ig0KPiAgICNpbmNsdWRlICJleGVjL2hlbHBlci1wcm90by5oIg0KPiAgICNpbmNsdWRlICJo
dy9jb3JlL3RjZy1jcHUtb3BzLmgiDQoNClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVy
IDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQoNCg==

