Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F5AFC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdEz-0007H0-Fq; Fri, 07 Mar 2025 14:20:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqdC0-0000mG-6Z
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:17:09 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqdBy-0004dU-A5
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:17:07 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2fee4d9c2efso4047626a91.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741375024; x=1741979824; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TzEbOmVXQDlnSwoPF3mwpzDJqDbMB8350tOtQgJiO80=;
 b=O1SJhdziU9honodtwH+eP0uS+V/TONltx7v3Vrj+zXNxmaqxDLHRVzIac6sdBDmZbi
 s/1cjcb1keaSJdPxN4ON3zTFlpNZ6ION8Vor9JVpzHg+PeNPVh7QZxdAL78Z58vtobiG
 wNOD1cgXuLATUJAgE6GucEc0V0R5XbCjym0OeuqJyagnsISL07q7DPF6Ay7I3CDwxonB
 0vKhC5CcnKFDQXmpFPFY+tyTxvsMEKx9b6twtM2EnHFix1tw/VaS/kQ/xBla2K/PMgAP
 bfsDUlAxaSRvwZs+Uut4ed+D9Ad0WwgMyCmenn8wLmrHNiVqymsgt1RoTTTOJ9+26iAc
 z+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741375024; x=1741979824;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TzEbOmVXQDlnSwoPF3mwpzDJqDbMB8350tOtQgJiO80=;
 b=rIdtZ0glS61gdK9XxkmY3ptdPWBHMh4SYBlvHtnplu0uGOcCNoeP7x1OBPzZRF1YLl
 5Klrx+nJKlVVOcC0Th/EzBeitkJ4nXnC6ihz/5BGK7+XcSSklzP75DuRUKrQlH3GXX/l
 HtNBm+ijFpVwMQr1l0naXs0fBRhI205UhX4OCPBMx1//wmUca2g20/Eui0PClBc+C4f4
 IE0BpAasitbMRHJ2Xlb3mE5CBo2b2YojSfQrkbqpgF9AtDGBYrvx3oIF+ljJsP2p8MZ+
 ty8XQ4N4DeyN/61cav+tPynGO1BT2wJQE05IBkJ4lXu3zRmOF0vG/V5k98u9i95gjq2Y
 zSdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWy5G455j1v/0JAI7ikN/CjBX161R36hv5DBMQpgXFcGi8RR7tPky17LazjFykLuuHZzMb1gu227owi@nongnu.org
X-Gm-Message-State: AOJu0YwA1ZsEVDB3h/kTvwOhArufuXm97iznkBeu4q1mlrc6sbjd4YuN
 cyO+zXXXmSjsofAaLmqVFd+AH5RZDcRMxdwpgCQN1UiLNcLKIOV8dxgN1leAao8=
X-Gm-Gg: ASbGnctS/6MrSfB3nH9pD5A4svYaj1SruGTHOz6nMm6Vmwu5KSElJlifK1rUEaCyumW
 fMSiaepQ6mj84zHMH4iV1oTMijrDXJk+xWrx0CWzkfy6xcGyrBR/ebNfDCRRDbjnSfF+XeF5ynC
 4BHbwpAzVrPRZXTIlbr+eiCoAZm/DKXU8eCk4HzcgK8caJdFNWVj5aCNhXaEZla0GCMye0qBR93
 xKaHlpUMKiX+Q8hUV5SevYMI2WZar6EozQV/tkibxpJnKr2GwDWJHSJdqwVyON0wyvvK5yoypCy
 4wAvCi5s2X8sYLGnpX1xQnCp28E3lJrhmWdD05VAmIGdS1Uzc/r4QEpK/g==
X-Google-Smtp-Source: AGHT+IFUGyuXXgaCFQ/kQBvTj8R3BVURDVdf+5unR3AF11B+xPkdApcT4KkZRjFsM6nojEJmjsYMtQ==
X-Received: by 2002:a17:90b:1d8e:b0:2ee:f19b:86e5 with SMTP id
 98e67ed59e1d1-2ff7ce6fd4amr8066324a91.14.1741375024209; 
 Fri, 07 Mar 2025 11:17:04 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff6933b039sm3418753a91.1.2025.03.07.11.17.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 11:17:03 -0800 (PST)
Message-ID: <24645792-462c-4e18-b4c9-912d649b7130@linaro.org>
Date: Fri, 7 Mar 2025 11:17:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] hw/vfio: Compile display.c once
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
 <20250307180337.14811-8-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250307180337.14811-8-philmd@linaro.org>
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

T24gMy83LzI1IDEwOjAzLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gZGlz
cGxheS5jIGRvZXNuJ3QgcmVseSBvbiB0YXJnZXQgc3BlY2lmaWMgZGVmaW5pdGlvbnMsDQo+
IG1vdmUgaXQgdG8gc3lzdGVtX3NzW10gdG8gYnVpbGQgaXQgb25jZS4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4N
Cj4gLS0tDQo+ICAgaHcvdmZpby9tZXNvbi5idWlsZCB8IDQgKysrLQ0KPiAgIDEgZmlsZSBj
aGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9ody92ZmlvL21lc29uLmJ1aWxkIGIvaHcvdmZpby9tZXNvbi5idWlsZA0KPiBpbmRl
eCBmZWE2ZGJlODhjZC4uOTZlMzQyYWE4Y2IgMTAwNjQ0DQo+IC0tLSBhL2h3L3ZmaW8vbWVz
b24uYnVpbGQNCj4gKysrIGIvaHcvdmZpby9tZXNvbi5idWlsZA0KPiBAQCAtNSw3ICs1LDYg
QEAgdmZpb19zcy5hZGQoZmlsZXMoDQo+ICAgKSkNCj4gICB2ZmlvX3NzLmFkZCh3aGVuOiAn
Q09ORklHX1BTRVJJRVMnLCBpZl90cnVlOiBmaWxlcygnc3BhcHIuYycpKQ0KPiAgIHZmaW9f
c3MuYWRkKHdoZW46ICdDT05GSUdfVkZJT19QQ0knLCBpZl90cnVlOiBmaWxlcygNCj4gLSAg
J2Rpc3BsYXkuYycsDQo+ICAgICAncGNpLXF1aXJrcy5jJywNCj4gICAgICdwY2kuYycsDQo+
ICAgKSkNCj4gQEAgLTI4LDMgKzI3LDYgQEAgc3lzdGVtX3NzLmFkZCh3aGVuOiAnQ09ORklH
X1ZGSU8nLCBpZl90cnVlOiBmaWxlcygNCj4gICBzeXN0ZW1fc3MuYWRkKHdoZW46IFsnQ09O
RklHX1ZGSU8nLCAnQ09ORklHX0lPTU1VRkQnXSwgaWZfdHJ1ZTogZmlsZXMoDQo+ICAgICAn
aW9tbXVmZC5jJywNCj4gICApKQ0KPiArc3lzdGVtX3NzLmFkZCh3aGVuOiAnQ09ORklHX1ZG
SU9fUENJJywgaWZfdHJ1ZTogZmlsZXMoDQo+ICsgICdkaXNwbGF5LmMnLA0KPiArKSkNCg0K
UmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJv
Lm9yZz4NCg0K

