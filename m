Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA87D24470
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:34:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJJf-0005aO-H7; Fri, 11 Oct 2024 13:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1szJ9K-0007ge-Cz
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:10:02 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1szJ9I-0003MA-UH
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:09:58 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7ea53eaf604so694405a12.0
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 10:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728666595; x=1729271395; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bmgflE2zoSkPjlqlCWN52X+hS0qvFXB4kKy+1n6oiE0=;
 b=x94VaIBfvHeVCWhIsGjfH7CDaOCa3UqxurKuKlWv1AMY0J1EMt8RnoXEnaT92VvtsR
 QZWTKz9etWXUQ0zbCGKOUDAVQ1S3V1FbowoK6HU2Zq6bgbJOnOsvaxOwdChCMAzyKK0j
 wsfaZ5h6sT7cbZE5jSUU49wm1L0aQCy3LE0dQyHSjRUIF3EkGRfK/pdqUdZMCZIdtF67
 ZMRzZuUfqArVgg1rw+RDS1go1lYM2r2qHvVLP6WRhKTwsJfAoKKlr4uRjZd00gJGzckQ
 V0oR47bg4k7jspvH7m7KbmQw06+IOfD7oSR/fsE8p56AHtipyFXCGdxV4j2GJbUWCMz9
 axCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728666595; x=1729271395;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bmgflE2zoSkPjlqlCWN52X+hS0qvFXB4kKy+1n6oiE0=;
 b=S9BSMOXHpKaBPeOcyUBy0SsuQ9vLGwGjvcyWiv0JVAdR8higsRzfBLZpm44uxFgGTI
 L8ekO/B1SA0i0Ou9iAnRXjFpGaRaq2wsEvDJMHDFr8ZMzRO5vkZ6zT8WU/mSvhCXBaAj
 Ib9Wcn2aut7X99Ei1q/e2vM2ONI77veiCXW6lwJ+LMT1TUTVX5N8bOfMyLpIHuUrd5LK
 7MTo36oAngFQ7I6ssaVJEexw610mbv4s6eHykpxG+uv3B4HRtXb+ZY/+DRFM2mBA2zkl
 XKWQ2QKKsi7106YqlXxl0z2hFIw6bMGK3wkTdNHPQvYqqgoOWGSpxuXtcqSDeEk07YoS
 cSUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDWpOJjtJN2PprlhlqBnOPb1LxcnYKgCCdP81QIPa+SmzsfnOHuKVNgDp2tE/q3nSky8j/RSb1wE4W@nongnu.org
X-Gm-Message-State: AOJu0Yw46cIUL1E7Dow5Dnkti3nyIHhVFkfau71KlVJLfJ1ilvhcZHiO
 P2/p7d7jfSASO9/752WbYnAS05UiorBktBVof5cCoD73G4QMn72L00fPB42kOP8=
X-Google-Smtp-Source: AGHT+IGRuP/rzU6XRPaLAZ3t/rLp27bfPr6nXvr7IFX6HsI99CuuZkMoh4TL+ybYqfMszbQowcdT7g==
X-Received: by 2002:a05:6a21:e8b:b0:1d8:a759:5265 with SMTP id
 adf61e73a8af0-1d8bcfa571bmr3911131637.37.1728666594903; 
 Fri, 11 Oct 2024 10:09:54 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e2a9f6c0dsm2807172b3a.51.2024.10.11.10.09.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Oct 2024 10:09:54 -0700 (PDT)
Message-ID: <4df7a020-2eae-404f-bd2d-93a4c6dba66e@linaro.org>
Date: Fri, 11 Oct 2024 10:09:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/23] accel/tcg: Split out tlbfast_flush_range_locked
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241009150855.804605-1-richard.henderson@linaro.org>
 <20241009150855.804605-5-richard.henderson@linaro.org>
 <8bbac2bf-704a-4c4c-ae7a-996f5a04038f@linaro.org>
 <2daacd1c-1efb-4990-852b-a7e6ae1bd1d4@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <2daacd1c-1efb-4990-852b-a7e6ae1bd1d4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x529.google.com
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

T24gMTAvOS8yNCAxODoyMCwgUmljaGFyZCBIZW5kZXJzb24gd3JvdGU6DQo+IE9uIDEwLzkv
MjQgMTY6MDUsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+Pj4gQEAgLTcyMCwxMyArNzI4
LDEwIEBAIHN0YXRpYyB2b2lkIHRsYl9mbHVzaF9yYW5nZV9sb2NrZWQoQ1BVU3RhdGUgKmNw
dSwgaW50IG1pZHgsDQo+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm47DQo+Pj4gIMKg
wqDCoMKgwqAgfQ0KPj4+ICvCoMKgwqAgdGxiZmFzdF9mbHVzaF9yYW5nZV9sb2NrZWQoZCwg
ZiwgYWRkciwgbGVuLCBtYXNrKTsNCj4+PiArDQo+Pj4gIMKgwqDCoMKgwqAgZm9yICh2YWRk
ciBpID0gMDsgaSA8IGxlbjsgaSArPSBUQVJHRVRfUEFHRV9TSVpFKSB7DQo+Pj4gIMKgwqDC
oMKgwqDCoMKgwqDCoCB2YWRkciBwYWdlID0gYWRkciArIGk7DQo+Pj4gLcKgwqDCoMKgwqDC
oMKgIENQVVRMQkVudHJ5ICplbnRyeSA9IHRsYl9lbnRyeShjcHUsIG1pZHgsIHBhZ2UpOw0K
Pj4+IC0NCj4+PiAtwqDCoMKgwqDCoMKgwqAgaWYgKHRsYl9mbHVzaF9lbnRyeV9tYXNrX2xv
Y2tlZChlbnRyeSwgcGFnZSwgbWFzaykpIHsNCj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB0bGJfbl91c2VkX2VudHJpZXNfZGVjKGNwdSwgbWlkeCk7DQo+Pj4gLcKgwqDCoMKgwqDC
oMKgIH0NCj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgIHRsYl9mbHVzaF92dGxiX3BhZ2VfbWFz
a19sb2NrZWQoY3B1LCBtaWR4LCBwYWdlLCBtYXNrKTsNCj4+PiAgwqDCoMKgwqDCoCB9DQo+
Pj4gIMKgIH0NCj4+DQo+PiBXaHkgZG9uJ3Qgd2UgaGF2ZSB0aGUgc2FtZSBraW5kIG9mIGNo
YW5nZSBmb3IgdGxiX2ZsdXNoX3Z0bGJfcGFnZV9tYXNrX2xvY2tlZD8NCj4+DQo+PiBXZSBr
bm93IGhhdmUgdHdvIGxvb3BzIChmb3IgZW50cnkgbWFzaywgYW5kIGZvciBwYWdlIG1hc2sp
Lg0KPiANCj4gSXQgZ29lcyBhd2F5IGluIHBhdGNoIDE1Lg0KPiANCj4gcn4NCg0KUmlnaHQs
IGxvb2tzIGdvb2QuDQpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2su
Ym91dmllckBsaW5hcm8ub3JnPg0K

