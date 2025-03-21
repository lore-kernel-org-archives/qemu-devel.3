Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 712B1C36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvgiv-0001PU-Ab; Fri, 21 Mar 2025 14:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvgia-0000yg-Of
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:03:44 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvgiZ-0003Bb-5E
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:03:40 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-225b5448519so46878635ad.0
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742580218; x=1743185018; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=18hw0dX9w0gS5rfgx/WRyWNrIzeCjI1VIirdEzk9CYI=;
 b=pNpGcqMUYjLm2hNKRwXBlfUUlFyYl1dsck3JFOtp+zUMqI6UzoJcZxGDrcsftDUrqj
 q1hhEAFKcjwNT0eS3mTHk9AjrEqQ/RufHhB58aPnzSEbDjTQWY8d/tOrcU4aeZkcS5Wa
 h5N/L+TjkeIp7O3YPcc4sU8Tqpawa+OFbsX1Agr4sOTNagHE1wJZyeO/OlTj04E54xsJ
 j0V4tT0ssxaSKczYd5WlxOD1QSkG0xPADoy7ZZdFex/q3zjL60A0ilkMMJspyRXDAPnp
 2CZ85J+I7ZdGrNDRiuAa2YaMxjpZkrucuT4oETLA398Aq1LKKQCr3577fSAGrJuIonJ9
 HiKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742580218; x=1743185018;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=18hw0dX9w0gS5rfgx/WRyWNrIzeCjI1VIirdEzk9CYI=;
 b=vtqDatvl9J81bn034Waqvn5WZ3p1/X3ltOQvFzSDiyl+fqFa23rYrpfJgLCqiYEE0n
 vS+wM5slcE95T6SGi+pjAPrUDh8ln6Ji6r9I7T0cQc04DIQ3kXsWkyVkhtYyTyMXUVzM
 0j9wTKx0F+n5BhE9jigPOdUVtMvFlP45pFk3NDV+hD23P9KCPqBTRKWcaaxoJ3rIIt1s
 QcEq/qwg+H0/LVABpQa38PabezEVZDLFQDgn/VFXH949hkSejXjyWeA3ektXMonW/1rf
 Jkn/baEbxSx62CM/xXVaKorGO90mKqJG3Bwx8JGL9pmTApOl4/nAbYU5eKyrwfTy0Kcu
 NuQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWC989k8hsKE8AMpi3OFkDOGMYHZNIeBDu5ioa3nK2+m3bX3rmWFbExZWvyT6rmDCi6w3G1G41j0/O4@nongnu.org
X-Gm-Message-State: AOJu0YxxEC4VFsCy/fbMv7LTlLgIvagw7yBB4uiIKI7C5h4LAk/ojdgb
 HR7iKXYggn1uuS8Cj9EkqpwqD/YsflvYy75WgNi8OhA9pbF4b7FO71DmpNQd4LA=
X-Gm-Gg: ASbGncsr8Xe3GvWtWVpOd4+h/iB5s81FDvMEnx2KGtILBjq9wKhoJhdrF/KDNqTlP5Q
 jLuM/skHM9rSv1A8PymqUNrmTt+jFI1Qg5+CrfM3RALALH2VnzguQt5MMK8phlPODTDTSkEvqpb
 AbkMl+Mu7BzC3OR88i0f0uSdOs//lfbAaaQnjuStUb8cV67ZQLgPBxGxrym4CjjHbd0yL/3vllX
 1AuGEo8dQIZTkBGd5I993/izUNMaWOLsAXUFYT5YI1qEqZIfbA7CSiuW7CQ8lYdiPpLXlBrPlvx
 DClu1bTXJaUE/Izkff3ZMttny9JqQHugIKHx2miRRhCy4oKVmxn/lYIuxNVdh0buJs4sCA==
X-Google-Smtp-Source: AGHT+IFnAckRz806aDdrGrin3j94VrMGJD2FNVxzOsrYO8NMiC9Ap0p2OVzqKmIeTEkSZBoWn37V9A==
X-Received: by 2002:a17:902:d511:b0:21f:61a9:be7d with SMTP id
 d9443c01a7336-22780e259c5mr66331095ad.49.1742580217459; 
 Fri, 21 Mar 2025 11:03:37 -0700 (PDT)
Received: from [172.16.224.217] ([209.53.90.26])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811da97esm20182295ad.192.2025.03.21.11.03.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 11:03:36 -0700 (PDT)
Message-ID: <e1461596-0f10-441b-894c-5cc956122961@linaro.org>
Date: Fri, 21 Mar 2025 11:03:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/42] accel/tcg: Use cpu_ld*_code_mmu in translator.c
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
 <20250318213209.2579218-13-richard.henderson@linaro.org>
 <f3b98848-70b7-4ece-8ba2-43f0e07302ac@linaro.org>
 <0d51b754-14bf-4a05-864e-0e3e7e5be2cd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <0d51b754-14bf-4a05-864e-0e3e7e5be2cd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

T24gMy8yMC8yNSAxNzo0OCwgUmljaGFyZCBIZW5kZXJzb24gd3JvdGU6DQo+IE9uIDMvMTgv
MjUgMTc6MjMsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+Pj4gIMKgIHVpbnQ2NF90IHRy
YW5zbGF0b3JfbGRxKENQVUFyY2hTdGF0ZSAqZW52LCBEaXNhc0NvbnRleHRCYXNlICpkYiwg
dmFkZHIgcGMpDQo+Pj4gIMKgIHsNCj4+PiAtwqDCoMKgIHVpbnQ2NF90IHJhdywgdGd0Ow0K
Pj4+ICvCoMKgwqAgdWludDY0X3QgdmFsOw0KPj4+IC3CoMKgwqAgaWYgKHRyYW5zbGF0b3Jf
bGQoZW52LCBkYiwgJnJhdywgcGMsIHNpemVvZihyYXcpKSkgew0KPj4+IC3CoMKgwqDCoMKg
wqDCoCB0Z3QgPSB0c3dhcDY0KHJhdyk7DQo+Pj4gLcKgwqDCoCB9IGVsc2Ugew0KPj4+IC3C
oMKgwqDCoMKgwqDCoCB0Z3QgPSBjcHVfbGRxX2NvZGUoZW52LCBwYyk7DQo+Pj4gLcKgwqDC
oMKgwqDCoMKgIHJhdyA9IHRzd2FwNjQodGd0KTsNCj4+PiAtwqDCoMKgwqDCoMKgwqAgcmVj
b3JkX3NhdmUoZGIsIHBjLCAmcmF3LCBzaXplb2YocmF3KSk7DQo+Pj4gK8KgwqDCoCBpZiAo
IXRyYW5zbGF0b3JfbGQoZW52LCBkYiwgJnZhbCwgcGMsIHNpemVvZih2YWwpKSkgew0KPj4+
ICvCoMKgwqDCoMKgwqDCoCBNZW1PcElkeCBvaSA9IG1ha2VfbWVtb3BfaWR4KE1PX1VRLCBk
Yi0+Y29kZV9tbXVpZHgpOw0KPj4+ICvCoMKgwqDCoMKgwqDCoCB2YWwgPSBjcHVfbGRxX2Nv
ZGVfbW11KGVudiwgcGMsIG9pLCAwKTsNCj4+PiArwqDCoMKgwqDCoMKgwqAgcmVjb3JkX3Nh
dmUoZGIsIHBjLCAmdmFsLCBzaXplb2YodmFsKSk7DQo+Pj4gIMKgwqDCoMKgwqAgfQ0KPj4+
IC3CoMKgwqAgcmV0dXJuIHRndDsNCj4+PiArwqDCoMKgIHJldHVybiB0c3dhcDY0KHZhbCk7
DQo+Pj4gIMKgIH0NCj4+PiAgwqAgdm9pZCB0cmFuc2xhdG9yX2Zha2VfbGQoRGlzYXNDb250
ZXh0QmFzZSAqZGIsIGNvbnN0IHZvaWQgKmRhdGEsIHNpemVfdCBsZW4pDQo+Pg0KPj4gSWYg
SSB1bmRlcnN0YW5kIGNvcnJlY3RseSwgY3B1X2xkcV9jb2RlX21tdSBwZXJmb3JtcyB0aGUg
dHN3YXAgY2FsbCB3ZSB1c2VkIHRvIGJlZm9yZS4NCj4gDQo+IEluY29ycmVjdDogY3B1X2xk
cV9jb2RlX21tdSBoYXMgbm8gdHN3YXAuDQo+IA0KPiBJdCBoYXMgYSBjb25kaXRpb25hbCBi
c3dhcCwgaWYgTU9fQlNXQVAgaXMgc2V0LCBidXQgdGhhdCdzIG5vdCB0cnVlIGZvciB0aGUg
TU9fVVEgdXNlZA0KPiBoZXJlLiAgVGhlcmVmb3JlIGJvdGggdGhlIGRpcmVjdCBsb2FkIGlu
IHRyYW5zbGF0b3JfbGQgYW5kIHRoZSBjcHVfbGQqX2NvZGVfbW11IGZ1bmN0aW9uDQo+IGNh
bGwgYm90aCBwcm9kdWNlIGhvc3QtZW5kaWFuIHZhbHVlcy4NCj4gDQo+IFRoZXJlZm9yZSB0
aGUgdHN3YXAgYXQgdGhlIGVuZCBjb3JyZWN0bHkgc3dhcHMgaG9zdCB0byB0YXJnZXQtZW5k
aWFubmVzcy4NCj4gDQoNCk9oIHJpZ2h0LCBtaXNzZWQgdGhhdC4NCg0KPiANCj4gcn4NCg0K


