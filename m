Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 071A8C36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 17:45:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvgQg-0001e7-9s; Fri, 21 Mar 2025 13:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvgQE-0001J8-DM
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 13:44:47 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvgQA-0006Kk-EN
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 13:44:41 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-301d6cbbd5bso3995280a91.3
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 10:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742579069; x=1743183869; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GSy130gmSfXTr3mzJJIykDrva4YZMOUUArAaXfWj1sA=;
 b=RetvuKVJMJzu2POJCvVwjlP4JeJ75sqGI37I03ki7ANaMiBEw5FQFYZMQUwls+Hfxj
 +TTiQgGWbwSvsUYso+yUNsSNH+4GWW35sfj0aZ+9z7RZP8Q+x1hS5aJSA8Y9BKUkilJl
 W7ADj8wLZW+rHlaa8sUPLNAF2w+h2sI6CKM5Gax6UphFDZXylmUByJLiTPWnW1rvYMYH
 mPWSzSCl9UDSzF3tjdqHRWKkNNnWV82okdHAkR+7fpsnLPatZo6Xspw6R0V9Ikam9Ue7
 px+lx1Dl1xCVTyZUltzMF+b8KlxKRfuoXHF69OnYuq0+2Rd9vPGlw55wXZqwt8ZTfXVf
 IqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742579069; x=1743183869;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GSy130gmSfXTr3mzJJIykDrva4YZMOUUArAaXfWj1sA=;
 b=vrlDS/D6jIqhoKYKImb3wgey8vKe/foE/7SbIAtjNq0IZdIX7ECSbOX7xW4cDK4haz
 cgL08iGE5fB1uuWaB06SvLvuI1ska7F6VyoVE4Kx3I+2+bzB09jDU8H7kKSejlvBW2P/
 O7tha4V5RAZkaICjP9Ufs0QpMKuLUOIuOGQJa3/8r2g3Gx6YlpRNW3yFKJ8PIv+WXte5
 6u/GB2epL0FqelJxiStrkydZyVHXt/9Rng4VhGJOY8c6eZmVAlU5y6CyeS4XmYZpurOe
 UW/+XYnYhjhcTObabMj9dhHqye/bKwAO/0gQsnbCm9e0H/O+jWy2y78PT2Vdn+bwb1/S
 3uDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYHRUb78fLmkf/gYuLDh4nn/3MzchrBcWmY+gKqd9XYJHmTwLRemLm9LH7zRvTg9SrpmGeQThie8Gv@nongnu.org
X-Gm-Message-State: AOJu0YzIBh/TkhpqnH/tEuP1OFVaEMOV6QUDXFs8d9Hwmy4tiv6KQp8b
 FbrI2r923a3qrI298SXvzH1U2dYSiD/Yl+b2jA9L9OEF1gZpWXDI140E0c356Lg=
X-Gm-Gg: ASbGncuz0eF4adFjJDfj8UfFmqvfIPcWU8KJ5osC0ZoWhAEPvlGIvLVBr1I6VKpwvSd
 aSJo2+nPcSSo2oAAd5WNqrAgRVi1vsl71q+YChJJFE0vV4k/3HHeoCtIsk3KDTBEUPwPWI+XOcW
 vKPLPqdQzFxnfO9DW9TMWyky1H9auFG3mFsK4HmA9kV4EU5UlhUSkBewFL2SnAUZfPvs7dLg6b/
 JBQ6W1xqwuohAl0s9D2GdEcaWf6uZzRTuLrjMC5oJCBnr82M+Kn50N3sMe4b0Uh7B06cJaDYww6
 NxE5fgKJtj/7drtrzIRAh2vcfXe33W55ziXYr/MjqQj81UK58qiPPID8I9I=
X-Google-Smtp-Source: AGHT+IFIu03/yX87yjk2Y5orWOkD85HLUZVR2F0fdtrtn45zMEM5RoF4BLzGoqIAqrCESGK13WFPDw==
X-Received: by 2002:a17:90b:2d4c:b0:2ee:9e06:7db0 with SMTP id
 98e67ed59e1d1-3030fe8dd62mr6566233a91.11.1742579069469; 
 Fri, 21 Mar 2025 10:44:29 -0700 (PDT)
Received: from [172.16.224.217] ([209.53.90.26])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf63716fsm6401462a91.47.2025.03.21.10.44.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 10:44:29 -0700 (PDT)
Message-ID: <a0d8b695-5e8d-4eaf-8395-383347de3fa6@linaro.org>
Date: Fri, 21 Mar 2025 10:44:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 2/4] tcg: Simplify tcg_req_mo() macro
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Anton Johansson <anjo@rev.ng>
References: <20250321125737.72839-1-philmd@linaro.org>
 <20250321125737.72839-3-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250321125737.72839-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102e.google.com
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

T24gMy8yMS8yNSAwNTo1NywgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE5v
dyB0aGF0IFRDR19HVUVTVF9ERUZBVUxUX01PIGlzIGFsd2F5cyBkZWZpbmVkLA0KPiBzaW1w
bGlmeSB0aGUgdGNnX3JlcV9tbygpIG1hY3JvLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGhp
bGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiAtLS0NCj4gICBh
Y2NlbC90Y2cvaW50ZXJuYWwtdGFyZ2V0LmggfCA5ICstLS0tLS0tLQ0KPiAgIGFjY2VsL3Rj
Zy90Y2ctYWxsLmMgICAgICAgICB8IDMgLS0tDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMTEgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYWNjZWwv
dGNnL2ludGVybmFsLXRhcmdldC5oIGIvYWNjZWwvdGNnL2ludGVybmFsLXRhcmdldC5oDQo+
IGluZGV4IDJjZGYxMWM5MDVlLi4xY2IzNWRiYTk5ZSAxMDA2NDQNCj4gLS0tIGEvYWNjZWwv
dGNnL2ludGVybmFsLXRhcmdldC5oDQo+ICsrKyBiL2FjY2VsL3RjZy9pbnRlcm5hbC10YXJn
ZXQuaA0KPiBAQCAtNTAsMTcgKzUwLDEwIEBAIEdfTk9SRVRVUk4gdm9pZCBjcHVfaW9fcmVj
b21waWxlKENQVVN0YXRlICpjcHUsIHVpbnRwdHJfdCByZXRhZGRyKTsNCj4gICAgKiBtZW1v
cnkgb3JkZXJpbmcgdnMgdGhlIGhvc3QgbWVtb3J5IG9yZGVyaW5nLiAgQSBub24temVybw0K
PiAgICAqIHJlc3VsdCBpbmRpY2F0ZXMgdGhhdCBzb21lIGJhcnJpZXIgaXMgcmVxdWlyZWQu
DQo+ICAgICoNCj4gLSAqIElmIFRDR19HVUVTVF9ERUZBVUxUX01PIGlzIG5vdCBkZWZpbmVk
LCBhc3N1bWUgdGhhdCB0aGUNCj4gLSAqIGd1ZXN0IHJlcXVpcmVzIHN0cmljdCBvcmRlcmlu
Zy4NCj4gLSAqDQo+ICAgICogVGhpcyBpcyBhIG1hY3JvIHNvIHRoYXQgaXQncyBjb25zdGFu
dCBldmVuIHdpdGhvdXQgb3B0aW1pemF0aW9uLg0KPiAgICAqLw0KPiAtI2lmZGVmIFRDR19H
VUVTVF9ERUZBVUxUX01PDQo+IC0jIGRlZmluZSB0Y2dfcmVxX21vKHR5cGUpIFwNCj4gKyNk
ZWZpbmUgdGNnX3JlcV9tbyh0eXBlKSBcDQo+ICAgICAgICgodHlwZSkgJiBUQ0dfR1VFU1Rf
REVGQVVMVF9NTyAmIH5UQ0dfVEFSR0VUX0RFRkFVTFRfTU8pDQo+IC0jZWxzZQ0KPiAtIyBk
ZWZpbmUgdGNnX3JlcV9tbyh0eXBlKSAoKHR5cGUpICYgflRDR19UQVJHRVRfREVGQVVMVF9N
TykNCj4gLSNlbmRpZg0KPiAgIA0KPiAgIC8qKg0KPiAgICAqIGNwdV9yZXFfbW86DQo+IGRp
ZmYgLS1naXQgYS9hY2NlbC90Y2cvdGNnLWFsbC5jIGIvYWNjZWwvdGNnL3RjZy1hbGwuYw0K
PiBpbmRleCBjMWEzMGIwMTIxOS4uY2I2MzJjYzhjYzcgMTAwNjQ0DQo+IC0tLSBhL2FjY2Vs
L3RjZy90Y2ctYWxsLmMNCj4gKysrIGIvYWNjZWwvdGNnL3RjZy1hbGwuYw0KPiBAQCAtNzcs
OSArNzcsNiBAQCBzdGF0aWMgYm9vbCBkZWZhdWx0X210dGNnX2VuYWJsZWQodm9pZCkNCj4g
ICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gICAgICAgfQ0KPiAgICNpZmRlZiBUQVJHRVRf
U1VQUE9SVFNfTVRUQ0cNCj4gLSMgaWZuZGVmIFRDR19HVUVTVF9ERUZBVUxUX01PDQo+IC0j
ICBlcnJvciAiVEFSR0VUX1NVUFBPUlRTX01UVENHIHdpdGhvdXQgVENHX0dVRVNUX0RFRkFV
TFRfTU8iDQo+IC0jIGVuZGlmDQo+ICAgICAgIHJldHVybiB0cnVlOw0KPiAgICNlbHNlDQo+
ICAgICAgIHJldHVybiBmYWxzZTsNCg0KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIg
PHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCg0K

