Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9337DC28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 19:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvLo1-0003tX-Db; Thu, 20 Mar 2025 15:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvLn2-00035R-GC
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 15:42:55 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvLn0-0008Gr-OJ
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 15:42:52 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-224191d92e4so24774645ad.3
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 12:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742499769; x=1743104569; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G0AEfQRk1HyxDN1rNugcfjkcXy9GNLJe54yuEZAkHSg=;
 b=yoNNgsRe2kdVc7itLqJDy5FFCJFwIcqftNP6Ik+BGY6lyaYoZjFkRu8990gje0G50+
 iJD6EyZTQzD24slVxbxje9ZWFICIl5DPtlF9paVtyMYF8SC1bgbGfNa8WfYIBCyjQpBL
 MeYXCF5ffCAEH2QM9Srk8nq2JnRoC3IXMNQRIg4R4e+fDsihG0nqz+sIXc0wL0E8He5D
 L161mgKiPVFgToCtzwiJbRk3KmHWIVEW0BlIo5e/8uzH4dAcRp2SOHd5ZtNfAbXr6KWb
 QgnaU1N5/z+ugcTaq3kTo2PoVU4tzXdjPA4H9r6MzN561DE8XoBhhg+JxnWKRPOCqy1M
 XduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742499769; x=1743104569;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G0AEfQRk1HyxDN1rNugcfjkcXy9GNLJe54yuEZAkHSg=;
 b=LRuE3bAVEcC/JimrPdxZ77Wo/qs/IO5Hw1Iw4K2KHSf5I174M9oHG/w+uh9RMIuZak
 UEoLf2J/G8WB0C40vOQG1ZD8Wbt9ukgfo53iPiD9o/gL5noFdSRxyvSTgFanZmWBnGmQ
 i0BNk/JYfw6zUHbekWWS+5lwUgHZ6UVnTlZ0nxrfRDD1tObIeCDyCE3pVwbopeuO2cwe
 0YcdZdDuQxYTAcQQ88Mzc9wS1rnyLBIopVzoWsuJz4vXR98+C/7YJrgo8JKvyg7f+oWI
 bnD8N9m9vw7MZuNFT5MtMq1ai4FB43Im1y+9xdZ8E6SBy1ks9oLocFn3U2Z7w71XCcI+
 /Tmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwa1YeCS0MofY3aNjp11PrH+OeulYkKfnT66lEw+kmiwVWS0Evrw/Qh6Qs8Io0iBr2FnWdq14QZcMw@nongnu.org
X-Gm-Message-State: AOJu0YwN3iQYjblL7hXz7ziI+SBVa0kVwNQ3+GONcY0XJ/fuvgsKp0NB
 MXI6aewqmv1A7ZJ6BckEDtvccrSJtFJVt4kwoFnUXP//lNS2BRA85bSSs7ABVIM=
X-Gm-Gg: ASbGncsnjkSAuJQcnqtKLM9LPYaaH6XJobsL8GpgLWg/wOW0xBZBQYLS65s3ed4jLu7
 Bm/1HoyYcvrUpkB2JHvs3ehQ5p+ONr8247ur8b/Vva91gJCQgK4ObPWFgxzvs3qbaN7uCw0KLsK
 mbPB0Xy+PSXhHMpTIe7kgJeVihkqqfv/wfb34bmTp165VoTHq80PJq7hP7JFyuLaPkBIx8udtWE
 366GdBkIWyyzypIfixbNuSCGt8y3YATfrWDgI+t1I5hEeF/u/6aYSq73V5r190DEQ8biAshKScq
 OOTSf3zyJ7Uhhvfpur08tuQ4+JTb9sHgZRYdhLWETIUsHdX4kO+Idxlebw==
X-Google-Smtp-Source: AGHT+IFgJCbMzTGbeWoMX//toeZsQ5JHXO+vw5ladHiYw8vEcgutw76JIuyJHKEsluDQEpheraunHA==
X-Received: by 2002:a05:6a21:9185:b0:1f5:6e00:14c4 with SMTP id
 adf61e73a8af0-1fe43477c1cmr948910637.42.1742499769410; 
 Thu, 20 Mar 2025 12:42:49 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73905fd6557sm217847b3a.64.2025.03.20.12.42.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 12:42:49 -0700 (PDT)
Message-ID: <44b007cc-f7ea-4191-a911-c5c3984df99a@linaro.org>
Date: Thu, 20 Mar 2025 12:42:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] target/ppc: make ppc_maybe_bswap_register static
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, qemu-arm@nongnu.org,
 Greg Kurz <groug@kaod.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20250319182255.3096731-1-alex.bennee@linaro.org>
 <20250319182255.3096731-7-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250319182255.3096731-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

T24gMy8xOS8yNSAxMToyMiwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBJdCdzIG5vdCB1c2Vk
IG91dHNpZGUgb2YgdGhlIGdkYnN0dWIgY29kZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFs
ZXggQmVubsOpZSA8YWxleC5iZW5uZWVAbGluYXJvLm9yZz4NCj4gLS0tDQo+ICAgdGFyZ2V0
L3BwYy9jcHUuaCAgICAgfCAxIC0NCj4gICB0YXJnZXQvcHBjL2dkYnN0dWIuYyB8IDIgKy0N
Cj4gICAyIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9wcGMvY3B1LmggYi90YXJnZXQvcHBjL2NwdS5o
DQo+IGluZGV4IDFlODMzYWRlMDQuLjk1MGJiNmUwNmMgMTAwNjQ0DQo+IC0tLSBhL3Rhcmdl
dC9wcGMvY3B1LmgNCj4gKysrIGIvdGFyZ2V0L3BwYy9jcHUuaA0KPiBAQCAtMzAxNiw3ICsz
MDE2LDYgQEAgc3RhdGljIGlubGluZSBib29sIHBwY19pbnRlcnJ1cHRzX2xpdHRsZV9lbmRp
YW4oUG93ZXJQQ0NQVSAqY3B1LCBib29sIGh2KQ0KPiAgIA0KPiAgIHZvaWQgZHVtcF9tbXUo
Q1BVUFBDU3RhdGUgKmVudik7DQo+ICAgDQo+IC12b2lkIHBwY19tYXliZV9ic3dhcF9yZWdp
c3RlcihDUFVQUENTdGF0ZSAqZW52LCB1aW50OF90ICptZW1fYnVmLCBpbnQgbGVuKTsNCj4g
ICB2b2lkIHBwY19zdG9yZV92c2NyKENQVVBQQ1N0YXRlICplbnYsIHVpbnQzMl90IHZzY3Ip
Ow0KPiAgIHVpbnQzMl90IHBwY19nZXRfdnNjcihDUFVQUENTdGF0ZSAqZW52KTsNCj4gICB2
b2lkIHBwY19zZXRfY3IoQ1BVUFBDU3RhdGUgKmVudiwgdWludDY0X3QgY3IpOw0KPiBkaWZm
IC0tZ2l0IGEvdGFyZ2V0L3BwYy9nZGJzdHViLmMgYi90YXJnZXQvcHBjL2dkYnN0dWIuYw0K
PiBpbmRleCAzYjI4ZDRlMjFjLi5jMDllOTNhYmFmIDEwMDY0NA0KPiAtLS0gYS90YXJnZXQv
cHBjL2dkYnN0dWIuYw0KPiArKysgYi90YXJnZXQvcHBjL2dkYnN0dWIuYw0KPiBAQCAtODEs
NyArODEsNyBAQCBzdGF0aWMgaW50IHBwY19nZGJfcmVnaXN0ZXJfbGVuKGludCBuKQ0KPiAg
ICAqIFRBUkdFVF9CSUdfRU5ESUFOIGlzIGFsd2F5cyBzZXQsIGFuZCB3ZSBtdXN0IGNoZWNr
IHRoZSBjdXJyZW50DQo+ICAgICogbW9kZSBvZiB0aGUgY2hpcCB0byBzZWUgaWYgd2UncmUg
cnVubmluZyBpbiBsaXR0bGUtZW5kaWFuLg0KPiAgICAqLw0KPiAtdm9pZCBwcGNfbWF5YmVf
YnN3YXBfcmVnaXN0ZXIoQ1BVUFBDU3RhdGUgKmVudiwgdWludDhfdCAqbWVtX2J1ZiwgaW50
IGxlbikNCj4gK3N0YXRpYyB2b2lkIHBwY19tYXliZV9ic3dhcF9yZWdpc3RlcihDUFVQUENT
dGF0ZSAqZW52LCB1aW50OF90ICptZW1fYnVmLCBpbnQgbGVuKQ0KPiAgIHsNCj4gICAjaWZu
ZGVmIENPTkZJR19VU0VSX09OTFkNCj4gICAgICAgaWYgKCFGSUVMRF9FWDY0KGVudi0+bXNy
LCBNU1IsIExFKSkgew0KDQpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJp
Y2suYm91dmllckBsaW5hcm8ub3JnPg0KDQo=

