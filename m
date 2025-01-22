Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19181C02182
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 00:47:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taOtV-0008Kz-MP; Tue, 21 Jan 2025 19:46:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1taOtO-0008Hq-12
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 19:46:54 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1taOtJ-0000Ck-8W
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 19:46:48 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21bc1512a63so115568895ad.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 16:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737506803; x=1738111603; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QbYquItV4kFCzmVBn/fL5QDKIuY2gDJWl2x6MQp39oA=;
 b=oBnVNeoGrf1CnFteSK8njxNGRYBvbyzi+L4E7mcR8R7kP2/JuXaP5c2s4y94GZgObk
 uNE/Gp2sKDR6hGLoiN88HxaUzZ6njbMv+HIqthUNaYdbjFxygjkkQeAhib60jOs46y0V
 tLNGC5b63ihZZ/691cuF5YF8D+yZCawo8YlDpkSgF4lhVhkR9tNAr4qx17URdLmBbZCJ
 +atp2RefpQ2sNcWfaYtWH1h+Uq4aVbOTziMIu5eJ6TTb7aqPtRtVj1lNztAf4HYyyvP8
 iI2sNvgWdeDsD2UFVua6GLMUu8X/Q9YwK7J31dbiYWOGI9+mUIS3jLXQXE6erOP2QNbJ
 IQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737506803; x=1738111603;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QbYquItV4kFCzmVBn/fL5QDKIuY2gDJWl2x6MQp39oA=;
 b=iumgjjuazztQ1NLB/o6HX3ef1S1l7tB4uYxS/Z7m6/Ff1vzyVZzJjVePtV2M9n9d/V
 +8MUA4kHXIPIJdgBBJRsuj3sgVAH3+woL1OJVwH9oLx3PgglI9aClSE5pmTHG70jQQbY
 4LdJOlQB0Y1mb3n4W6EnR7qh+VPkeNvgingQHA8XgdV0ewy/ehgnqOydKlwOzJXhnNC0
 rYw/iKRCz4gJByzXCiD8q9NWBV9o4l/IF8gV4uR+tU0VfgflTOx2TvuBwJx2u6CyTi4F
 sEOw1mfFmCTTdS4KEXhw3UaEVU7vopVsDV53RZ9nCGTOdrquXDrU+9aK8ieH+pq42k6N
 a87g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXetN8lgdayhLIxVPqqen8M4VMIehd1WeGP91Hi+kgFXqKgxUao9yQcXNe0J/omXzbBSy/TF5fKSv9G@nongnu.org
X-Gm-Message-State: AOJu0YzS5hC0gUYY+aRY188trdDOhVhGYRSnHRmzFjdWimCkDBcYWbBA
 uKz9S0xv64+LpOSQCwBeu+R7sl3UwTILpb1mBO3QVFDw0mxp8qvxq4hkc+fRJjg=
X-Gm-Gg: ASbGnctADNGTZ42iftWLXjZKTUC+qYDy2ExyfjFY0s9o399CR/hwBUYoWx5s1O36e9w
 CcXpNbhJc7B44VO7a6Dw2puJ2rZDZ4Ft8HYjCF2RQLiGhZc1Wk7ZECd8BySwVWHpKN8TsZJPZb3
 c3xLPEzUKphbi/htHBJWv44faEl0PFNcqZdnGU6FUvuUbGDEPjulusmvAdeTyNTb1ZdH7X67Zkh
 igdf4qutcZ9nHjszcrkKHQ14MVvdx9HD6YfKohpg2/nQv2lZvK2vdWbqkDU1FLh3TDLw2FQhh9g
 l0wiamE=
X-Google-Smtp-Source: AGHT+IE8s78+evqAW8jDwLXISWLqvN4QJ++S1jkt0NJINR85T0tA2cnoVGdxbY+pylonCc5iStdHQw==
X-Received: by 2002:a05:6a20:72a1:b0:1dc:2365:4d7d with SMTP id
 adf61e73a8af0-1eb2148dfedmr27216351637.16.1737506803149; 
 Tue, 21 Jan 2025 16:46:43 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72dab7f086csm9943973b3a.11.2025.01.21.16.46.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 16:46:42 -0800 (PST)
Message-ID: <c08a859c-be9a-42cd-b261-44981b6a5b4c@linaro.org>
Date: Tue, 21 Jan 2025 16:46:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] accel/tcg: Implement cpu_exec_reset_hold() on user
 emulation
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
References: <20250102182521.65428-1-philmd@linaro.org>
 <20250102182521.65428-4-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250102182521.65428-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

T24gMS8yLzI1IDEwOjI1LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gQ29t
bWl0IGJiNmNmNmYwMTY4ICgiYWNjZWwvdGNnOiBGYWN0b3IgdGNnX2NwdV9yZXNldF9ob2xk
KCkNCj4gb3V0Iikgd2FudGVkIHRvIHJlc3RyaWN0IHRsYl9mbHVzaCgpIHRvIHN5c3RlbSBl
bXVsYXRpb24sDQo+IGJ1dCBpbmFkdmVydGVudGx5IGFsc28gcmVzdHJpY3RlZCB0Y2dfZmx1
c2hfam1wX2NhY2hlKCksDQo+IHdoaWNoIHdhcyBiZWZvcmUgY2FsbGVkIG9uIHVzZXIgZW11
bGF0aW9uIHZpYToNCj4gDQo+ICAgIFJlYWxpemUgLT4gUmVzZXQgLT4gY3B1X2NvbW1vbl9y
ZXNldF9ob2xkKCkNCj4gDQo+IFNpbmNlIHRocmVhZHMgKHZDUFVzKSB1c2UgYSBjb21tb24g
Q1BVSnVtcENhY2hlLCB3aGVuIG1hbnkNCj4gdGhyZWFkcyBhcmUgY3JlYXRlZCAvIGpvaW5l
ZCwgdGhleSBldmVudHVhbGx5IGVuZCByZS11c2luZw0KPiBhIENQVUp1bXBDYWNoZSBlbnRy
eSwgd2hpY2ggd2FzIGNsZWFyZWQgd2hlbiB0aGUgZmlyc3QgdkNQVQ0KPiB3YXMgYWxsb2Nh
dGVkICh2aWEgUmVhbGl6ZSkgYnV0IHRoZW4gc3RheWVkIGRpcnR5LCBsZWFkaW5nIHRvOg0K
PiANCj4gICAgVGhyZWFkIDEgInFlbXUtczM5MHgiIHJlY2VpdmVkIHNpZ25hbCBTSUdBQlJU
LCBBYm9ydGVkLg0KPiAgICBfX3B0aHJlYWRfa2lsbF9pbXBsZW1lbnRhdGlvbiAodGhyZWFk
aWQ9PG9wdGltaXplZCBvdXQ+LCBzaWdubz1zaWdub0BlbnRyeT02LCBub190aWQ9bm9fdGlk
QGVudHJ5PTApIGF0IC4vbnB0bC9wdGhyZWFkX2tpbGwuYzo0NA0KPiAgICA0NCAgICAgIC4v
bnB0bC9wdGhyZWFkX2tpbGwuYzogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeS4NCj4gICAg
KGdkYikgYnQNCj4gICAgIzAgIF9fcHRocmVhZF9raWxsX2ltcGxlbWVudGF0aW9uICh0aHJl
YWRpZD08b3B0aW1pemVkIG91dD4sIHNpZ25vPXNpZ25vQGVudHJ5PTYsIG5vX3RpZD1ub190
aWRAZW50cnk9MCkgYXQgLi9ucHRsL3B0aHJlYWRfa2lsbC5jOjQ0DQo+ICAgICMxICAweDAw
MDA3ZmZmZjdjNDFlOGYgaW4gX19wdGhyZWFkX2tpbGxfaW50ZXJuYWwgKHNpZ25vPTYsIHRo
cmVhZGlkPTxvcHRpbWl6ZWQgb3V0PikgYXQgLi9ucHRsL3B0aHJlYWRfa2lsbC5jOjc4DQo+
ICAgICMyICAweDAwMDA3ZmZmZjdiZjJmYjIgaW4gX19HSV9yYWlzZSAoc2lnPXNpZ0BlbnRy
eT02KSBhdCAuLi9zeXNkZXBzL3Bvc2l4L3JhaXNlLmM6MjYNCj4gICAgIzMgIDB4MDAwMDdm
ZmZmN2JkZDQ3MiBpbiBfX0dJX2Fib3J0ICgpIGF0IC4vc3RkbGliL2Fib3J0LmM6NzkNCj4g
ICAgIzQgIDB4MDAwMDdmZmZmN2JkZDM5NSBpbiBfX2Fzc2VydF9mYWlsX2Jhc2UgKGZtdD0w
eDdmZmZmN2Q1MWE5MCAiJXMlcyVzOiV1OiAlcyVzQXNzZXJ0aW9uIGAlcycgZmFpbGVkLlxu
JW4iLCBhc3NlcnRpb249YXNzZXJ0aW9uQGVudHJ5PTB4NTU1NTU1NmQ3MWI4ICJjcHUtPmFj
Y2VsIiwNCj4gICAgICAgIGZpbGU9ZmlsZUBlbnRyeT0weDU1NTU1NTZkNzBlMCAiY3B1LXRh
cmdldC5jIiwgbGluZT1saW5lQGVudHJ5PTE1OCwgZnVuY3Rpb249ZnVuY3Rpb25AZW50cnk9
MHg1NTU1NTU2ZDcyNjAgPF9fUFJFVFRZX0ZVTkNUSU9OX18uMz4gImNwdV9leGVjX3JlYWxp
emVmbiIpIGF0IC4vYXNzZXJ0L2Fzc2VydC5jOjkyDQo+ICAgICM1ICAweDAwMDA3ZmZmZjdi
ZWJlYjIgaW4gX19HSV9fX2Fzc2VydF9mYWlsIChhc3NlcnRpb249YXNzZXJ0aW9uQGVudHJ5
PTB4NTU1NTU1NmQ3MWI4ICJjcHUtPmFjY2VsIiwgZmlsZT1maWxlQGVudHJ5PTB4NTU1NTU1
NmQ3MGUwICJjcHUtdGFyZ2V0LmMiLCBsaW5lPWxpbmVAZW50cnk9MTU4LA0KPiAgICAgICAg
ZnVuY3Rpb249ZnVuY3Rpb25AZW50cnk9MHg1NTU1NTU2ZDcyNjAgPF9fUFJFVFRZX0ZVTkNU
SU9OX18uMz4gImNwdV9leGVjX3JlYWxpemVmbiIpIGF0IC4vYXNzZXJ0L2Fzc2VydC5jOjEw
MQ0KPiAgICAjNiAgMHgwMDAwNTU1NTU1NWQ0NGNhIGluIGNwdV9leGVjX3JlYWxpemVmbiAo
Y3B1PWNwdUBlbnRyeT0weDU1NTU1NTdjMjhjMCwgZXJycD1lcnJwQGVudHJ5PTB4N2ZmZmZm
ZmZlMTQwKSBhdCBjcHUtdGFyZ2V0LmM6MTU4DQo+ICAgICM3ICAweDAwMDA1NTU1NTU1OWY1
MGIgaW4gczM5MF9jcHVfcmVhbGl6ZWZuIChkZXY9MHg1NTU1NTU3YzI4YzAsIGVycnA9MHg3
ZmZmZmZmZmUxYTApIGF0IHRhcmdldC9zMzkweC9jcHUuYzoyNjENCj4gICAgIzggIDB4MDAw
MDU1NTU1NTYzZjc4YiBpbiBkZXZpY2Vfc2V0X3JlYWxpemVkIChvYmo9PG9wdGltaXplZCBv
dXQ+LCB2YWx1ZT08b3B0aW1pemVkIG91dD4sIGVycnA9MHg3ZmZmZmZmZmUyZTApIGF0IGh3
L2NvcmUvcWRldi5jOjUxMA0KPiAgICAjOSAgMHgwMDAwNTU1NTU1NjQzNjVkIGluIHByb3Bl
cnR5X3NldF9ib29sIChvYmo9MHg1NTU1NTU3YzI4YzAsIHY9PG9wdGltaXplZCBvdXQ+LCBu
YW1lPTxvcHRpbWl6ZWQgb3V0Piwgb3BhcXVlPTB4NTU1NTU1N2E5MTQwLCBlcnJwPTB4N2Zm
ZmZmZmZlMmUwKSBhdCBxb20vb2JqZWN0LmM6MjM2Mg0KPiAgICAjMTAgMHgwMDAwNTU1NTU1
NjQ2YmJiIGluIG9iamVjdF9wcm9wZXJ0eV9zZXQgKG9iaj1vYmpAZW50cnk9MHg1NTU1NTU3
YzI4YzAsIG5hbWU9bmFtZUBlbnRyeT0weDU1NTU1NTZlOGFlMiAicmVhbGl6ZWQiLCB2PXZA
ZW50cnk9MHg1NTU1NTU3YzY2NTAsIGVycnA9ZXJycEBlbnRyeT0weDdmZmZmZmZmZTJlMCkN
Cj4gICAgICAgIGF0IHFvbS9vYmplY3QuYzoxNDcxDQo+ICAgICMxMSAweDAwMDA1NTU1NTU2
NGE0NWYgaW4gb2JqZWN0X3Byb3BlcnR5X3NldF9xb2JqZWN0IChvYmo9b2JqQGVudHJ5PTB4
NTU1NTU1N2MyOGMwLCBuYW1lPW5hbWVAZW50cnk9MHg1NTU1NTU2ZThhZTIgInJlYWxpemVk
IiwgdmFsdWU9dmFsdWVAZW50cnk9MHg1NTU1NTU3YTdhOTAsIGVycnA9ZXJycEBlbnRyeT0w
eDdmZmZmZmZmZTJlMCkNCj4gICAgICAgIGF0IHFvbS9xb20tcW9iamVjdC5jOjI4DQo+ICAg
ICMxMiAweDAwMDA1NTU1NTU2NDcyMjQgaW4gb2JqZWN0X3Byb3BlcnR5X3NldF9ib29sIChv
Ymo9MHg1NTU1NTU3YzI4YzAsIG5hbWU9bmFtZUBlbnRyeT0weDU1NTU1NTZlOGFlMiAicmVh
bGl6ZWQiLCB2YWx1ZT12YWx1ZUBlbnRyeT10cnVlLCBlcnJwPWVycnBAZW50cnk9MHg3ZmZm
ZmZmZmUyZTApDQo+ICAgICAgICBhdCBxb20vb2JqZWN0LmM6MTU0MQ0KPiAgICAjMTMgMHgw
MDAwNTU1NTU1NjQwMjdjIGluIHFkZXZfcmVhbGl6ZSAoZGV2PTxvcHRpbWl6ZWQgb3V0Piwg
YnVzPWJ1c0BlbnRyeT0weDAsIGVycnA9ZXJycEBlbnRyeT0weDdmZmZmZmZmZTJlMCkgYXQg
aHcvY29yZS9xZGV2LmM6MjkxDQo+ICAgICMxNCAweDAwMDA1NTU1NTU1OWJiNTQgaW4gY3B1
X2NyZWF0ZSAodHlwZW5hbWU9PG9wdGltaXplZCBvdXQ+KSBhdCBody9jb3JlL2NwdS1jb21t
b24uYzo1Nw0KPiAgICAjMTUgMHgwMDAwNTU1NTU1NTlhNDY3IGluIG1haW4gKGFyZ2M9NCwg
YXJndj0weDdmZmZmZmZmZWFhOCwgZW52cD08b3B0aW1pemVkIG91dD4pIGF0IGxpbnV4LXVz
ZXIvbWFpbi5jOjgxMQ0KPiANCj4gSGF2ZSBjcHVfZXhlY19yZXNldF9ob2xkKCkgY2FsbCB0
aGUgY29tbW9uIHRjZ19leGVjX3Jlc2V0KCkNCj4gaGVscGVyIG9uIHVzZXIgZW11bGF0aW9u
LCBldmVudHVhbGx5IGNhbGxpbmcgdGNnX2ZsdXNoX2ptcF9jYWNoZSgpLg0KPiANCj4gRml4
ZXM6IGJiNmNmNmYwMTY4ICgiYWNjZWwvdGNnOiBGYWN0b3IgdGNnX2NwdV9yZXNldF9ob2xk
KCkgb3V0IikNCj4gUmVwb3J0ZWQtYnk6IElseWEgTGVvc2hrZXZpY2ggPGlpaUBsaW51eC5p
Ym0uY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhp
bG1kQGxpbmFyby5vcmc+DQo+IC0tLQ0KPiAgIGFjY2VsL3RjZy91c2VyLWV4ZWMtc3R1Yi5j
IHwgNCAtLS0tDQo+ICAgYWNjZWwvdGNnL3VzZXItZXhlYy5jICAgICAgfCA1ICsrKysrDQo+
ICAgMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvYWNjZWwvdGNnL3VzZXItZXhlYy1zdHViLmMgYi9hY2NlbC90
Y2cvdXNlci1leGVjLXN0dWIuYw0KPiBpbmRleCA0ZmJlMmRiZGM4OC4uMmRjNmZkOWM0ZTgg
MTAwNjQ0DQo+IC0tLSBhL2FjY2VsL3RjZy91c2VyLWV4ZWMtc3R1Yi5jDQo+ICsrKyBiL2Fj
Y2VsL3RjZy91c2VyLWV4ZWMtc3R1Yi5jDQo+IEBAIC0xNCwxMCArMTQsNiBAQCB2b2lkIHFl
bXVfaW5pdF92Y3B1KENQVVN0YXRlICpjcHUpDQo+ICAgew0KPiAgIH0NCj4gICANCj4gLXZv
aWQgY3B1X2V4ZWNfcmVzZXRfaG9sZChDUFVTdGF0ZSAqY3B1KQ0KPiAtew0KPiAtfQ0KPiAt
DQo+ICAgLyogVXNlciBtb2RlIGVtdWxhdGlvbiBkb2VzIG5vdCBzdXBwb3J0IHJlY29yZC9y
ZXBsYXkgeWV0LiAgKi8NCj4gICANCj4gICBib29sIHJlcGxheV9leGNlcHRpb24odm9pZCkN
Cj4gZGlmZiAtLWdpdCBhL2FjY2VsL3RjZy91c2VyLWV4ZWMuYyBiL2FjY2VsL3RjZy91c2Vy
LWV4ZWMuYw0KPiBpbmRleCAwNTYxYzRmNmRjNy4uOTI2NDBmMDdlZDcgMTAwNjQ0DQo+IC0t
LSBhL2FjY2VsL3RjZy91c2VyLWV4ZWMuYw0KPiArKysgYi9hY2NlbC90Y2cvdXNlci1leGVj
LmMNCj4gQEAgLTQwLDYgKzQwLDExIEBAIF9fdGhyZWFkIHVpbnRwdHJfdCBoZWxwZXJfcmV0
YWRkcjsNCj4gICANCj4gICAvLyNkZWZpbmUgREVCVUdfU0lHTkFMDQo+ICAgDQo+ICt2b2lk
IGNwdV9leGVjX3Jlc2V0X2hvbGQoQ1BVU3RhdGUgKmNwdSkNCj4gK3sNCj4gKyAgICB0Y2df
ZXhlY19yZXNldChjcHUpOw0KPiArfQ0KPiArDQo+ICAgdm9pZCBjcHVfaW50ZXJydXB0KENQ
VVN0YXRlICpjcHUsIGludCBtYXNrKQ0KPiAgIHsNCj4gICAgICAgZ19hc3NlcnQoYnFsX2xv
Y2tlZCgpKTsNCg0KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJv
dXZpZXJAbGluYXJvLm9yZz4NCg0K

