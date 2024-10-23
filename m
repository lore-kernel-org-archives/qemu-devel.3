Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E0DCFA47E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 21:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3j8t-0007dA-JA; Wed, 23 Oct 2024 17:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3j8s-0007cz-D6
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 17:43:46 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3j8q-0001M8-Ky
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 17:43:46 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2e2bb1efe78so195648a91.1
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 14:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729719823; x=1730324623; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nQFXy86PDJxoYWPGqTgn3dF2EXcNElTuSJa67zdqoEo=;
 b=opUuPjPweWD+Rgz4giDOtJ1sxqBovdtBbTHe5upp70e7jRz5HxcCRwrDwfnon8f/gE
 L0s8Yz4SskffsdhshqWDXbMEcPkmgCMb1N5X+xObC0nanuKX7AawPxHjhjzCIDYibmXn
 wjJP5LygSrtRTbp7fuLfaw8rDj+FQiljuq+VgHLNaItCdmMBlnIiJYDRQVBoJ6R/fT62
 akEapYPIu9HlYXsPQFdkW+4I8AjjS0xLAccpk2LfyL7dK/uYSDMt7Q2e8vDdOh4gAM5Z
 2osM3vsO785aoCJqRZEntYwUD6S6XhIQc49SmfpwzS2NEKk7S4udRhrswcfuYs4pl8aS
 xGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729719823; x=1730324623;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nQFXy86PDJxoYWPGqTgn3dF2EXcNElTuSJa67zdqoEo=;
 b=AAT3KkRUxIfztwfD2BJHsVlRGgQWrKhBrXcbjCtl6IAEmK69o/stB5ku6TmGV7a7ct
 ipS1M3a7GQUq37DjcuADHVFt7uNpLZjtIEQIFxgnCijvqB3OIwhHKv9GU2qneF6li4a2
 deIKw+G9yaRjcZEa3r4RJtNkAEq2MnDVoFSYabxqCkTKTsXqVohyyjqu8tWbUewdvtZL
 /cyQblPQy1RgoSIYbh0CouVuj49m8lcxd/+udqmJ+fnSHYU3SyWtE1+5oWkqV+BGH/+R
 jnRq6w1GewgFFkDgjbmgFAkFVt6JKhhifd30YRc5jD1P4OXrjzPozttlyrrBx1ytaRlx
 sFSg==
X-Gm-Message-State: AOJu0YwnvP+NldZMa0eaQjnjfSTQQEDGE4Z22fQzmKf2uw5RmAXnB8Ru
 M1EdBMraK4gT2a/azUFeVajT+GETC9onEs8YaaNYQP9tpUrbvc48iq1wCJPLigY=
X-Google-Smtp-Source: AGHT+IGTHYc5nDMpP6DfIZ6RMRBpulbb10ZThaedSDRmmHaM9l5Yfx9Kng5Obytbm4Yi3JGqsNGLlA==
X-Received: by 2002:a17:90a:cf11:b0:2e2:a5fd:7e4c with SMTP id
 98e67ed59e1d1-2e76a700374mr5683950a91.8.1729719823004; 
 Wed, 23 Oct 2024 14:43:43 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e76df2a9fesm1982008a91.8.2024.10.23.14.43.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2024 14:43:42 -0700 (PDT)
Message-ID: <c371e0ea-3488-4adc-8e1d-b02137c621c0@linaro.org>
Date: Wed, 23 Oct 2024 14:43:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tap-win32: fix format-truncation warning
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>
References: <20241023183009.1041419-1-pierrick.bouvier@linaro.org>
 <875xpilhu6.fsf@draig.linaro.org>
 <0ec19690-760a-4726-baa9-6073c193dc3c@linaro.org>
 <2816a9e4-1cb0-476d-b0b1-8040086f0d3a@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <2816a9e4-1cb0-476d-b0b1-8040086f0d3a@linaro.org>
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

T24gMTAvMjMvMjQgMTQ6MzAsIFJpY2hhcmQgSGVuZGVyc29uIHdyb3RlOg0KPiBPbiAxMC8y
My8yNCAxMzoxNSwgUGllcnJpY2sgQm91dmllciB3cm90ZToNCj4+IE9uIDEwLzIzLzI0IDEy
OjUwLCBBbGV4IEJlbm7DqWUgd3JvdGU6DQo+Pj4gUGllcnJpY2sgQm91dmllciA8cGllcnJp
Y2suYm91dmllckBsaW5hcm8ub3JnPiB3cml0ZXM6DQo+Pj4NCj4+Pj4gU2ltcGx5IGluY3Jl
YXNlIGRlc3RpbmF0aW9uIGJ1ZmZlciBzaXplIHNvIHRydW5jYXRpb24gY2FuJ3QgaGFwcGVu
Lg0KPj4+Pg0KPj4+PiAiY2MiICItbTY0IiAiLUlsaWJjb21tb24uYS5wIiAiLUlzdWJwcm9q
ZWN0cy9kdGMvbGliZmR0Ig0KPj4+PiAiLUkuLi9zdWJwcm9qZWN0cy9kdGMvbGliZmR0Ig0K
Pj4+PiAiLUlEOi9hL190ZW1wL21zeXM2NC9taW5ndzY0L2luY2x1ZGUvcGl4bWFuLTEiDQo+
Pj4+ICItSUQ6L2EvX3RlbXAvbXN5czY0L21pbmd3NjQvaW5jbHVkZS9nbGliLTIuMCINCj4+
Pj4gIi1JRDovYS9fdGVtcC9tc3lzNjQvbWluZ3c2NC9saWIvZ2xpYi0yLjAvaW5jbHVkZSIN
Cj4+Pj4gIi1JRDovYS9fdGVtcC9tc3lzNjQvbWluZ3c2NC9pbmNsdWRlL25jdXJzZXN3Ig0K
Pj4+PiAiLWZkaWFnbm9zdGljcy1jb2xvcj1hdXRvIiAiLVdhbGwiICItV2ludmFsaWQtcGNo
IiAiLVdlcnJvciINCj4+Pj4gIi1zdGQ9Z251MTEiICItTzIiICItZyIgIi1mc3RhY2stcHJv
dGVjdG9yLXN0cm9uZyIgIi1XZW1wdHktYm9keSINCj4+Pj4gIi1XZW5kaWYtbGFiZWxzIiAi
LVdleHBhbnNpb24tdG8tZGVmaW5lZCIgIi1XZm9ybWF0LXNlY3VyaXR5Ig0KPj4+PiAiLVdm
b3JtYXQteTJrIiAiLVdpZ25vcmVkLXF1YWxpZmllcnMiICItV2ltcGxpY2l0LWZhbGx0aHJv
dWdoPTIiDQo+Pj4+ICItV2luaXQtc2VsZiIgIi1XbWlzc2luZy1mb3JtYXQtYXR0cmlidXRl
IiAiLVdtaXNzaW5nLXByb3RvdHlwZXMiDQo+Pj4+ICItV25lc3RlZC1leHRlcm5zIiAiLVdv
bGQtc3R5bGUtZGVjbGFyYXRpb24iICItV29sZC1zdHlsZS1kZWZpbml0aW9uIg0KPj4+PiAi
LVdyZWR1bmRhbnQtZGVjbHMiICItV3NoYWRvdz1sb2NhbCIgIi1Xc3RyaWN0LXByb3RvdHlw
ZXMiDQo+Pj4+ICItV3R5cGUtbGltaXRzIiAiLVd1bmRlZiIgIi1XdmxhIiAiLVd3cml0ZS1z
dHJpbmdzIg0KPj4+PiAiLVduby1taXNzaW5nLWluY2x1ZGUtZGlycyIgIi1Xbm8tcHNhYmki
ICItV25vLXNoaWZ0LW5lZ2F0aXZlLXZhbHVlIg0KPj4+PiAiLWlxdW90ZSIgIi4iICItaXF1
b3RlIiAiRDovYS9xZW11L3FlbXUiICItaXF1b3RlIg0KPj4+PiAiRDovYS9xZW11L3FlbXUv
aW5jbHVkZSIgIi1pcXVvdGUiDQo+Pj4+ICJEOi9hL3FlbXUvcWVtdS9ob3N0L2luY2x1ZGUv
eDg2XzY0IiAiLWlxdW90ZSINCj4+Pj4gIkQ6L2EvcWVtdS9xZW11L2hvc3QvaW5jbHVkZS9n
ZW5lcmljIiAiLWlxDQo+Pj4+IC4uL25ldC90YXAtd2luMzIuYzogSW4gZnVuY3Rpb24gJ3Rh
cF93aW4zMl9vcGVuJzoNCj4+Pj4gLi4vbmV0L3RhcC13aW4zMi5jOjM0MzoxOTogZXJyb3I6
ICclcycgZGlyZWN0aXZlIG91dHB1dCBtYXkgYmUgdHJ1bmNhdGVkIHdyaXRpbmcgdXAgdG8N
Cj4+Pj4gMjU1IGJ5dGVzIGludG8gYSByZWdpb24gb2Ygc2l6ZSAxNzYgWy1XZXJyb3I9Zm9y
bWF0LXRydW5jYXRpb249XQ0KPj4+PiAgwqDCoCAzNDMgfMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICIlc1xcJXNcXENvbm5lY3Rpb24iLA0KPj4+PiAgwqDCoMKgwqDCoMKgIHzCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXn4NCj4+Pj4gIMKgwqAgMzQ0IHzC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBORVRXT1JLX0NPTk5FQ1RJT05TX0tFWSwgZW51
bV9uYW1lKTsNCj4+Pj4gIMKgwqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB+
fn5+fn5+fn4NCj4+Pj4gSW4gZnVuY3Rpb24gJ2dldF9kZXZpY2VfZ3VpZCcsDQo+Pj4+ICDC
oMKgwqDCoCBpbmxpbmVkIGZyb20gJ3RhcF93aW4zMl9vcGVuJyBhdCAuLi9uZXQvdGFwLXdp
bjMyLmM6NjE2OjEwOg0KPj4+PiAuLi9uZXQvdGFwLXdpbjMyLmM6MzQxOjk6IG5vdGU6ICdz
bnByaW50Zicgb3V0cHV0IGJldHdlZW4gOTIgYW5kIDM0Nw0KPj4+PiBieXRlcyBpbnRvIGEg
ZGVzdGluYXRpb24gb2Ygc2l6ZSAyNTYNCj4+Pg0KPj4+IElzIHRoZSBjb21waWxlciBtaW4v
bWF4IG1heGluZyB3aGF0IFVDUy0xNiBvciBVVEYtOCBtaWdodCBwYWNrIGludG8gdGhhdCBz
dHJpbmc/DQo+Pj4+DQo+Pg0KPj4gWWVzLCBlbnVtX25hbWUgKHVzZWQgdG8gY29tcG9zZSBm
aW5hbCBzdHJpbmcpIGlzIGFscmVhZHkgc2l6ZWQgMjU2LCBzbyByZXN1bHQgKm1heSogYmUN
Cj4+IGJpZ2dlci4gSSdtIG5vdCBzdXJlIGl0IHdvdWxkIGhhcHBlbiBpbiB0aGUgcmVhbCB3
b3JsZCB0aG91Z2guDQo+IA0KPiBUaGVyZSBhcmUgc2V2ZXJhbCBwYXRjaGVzIGZvciB0aGlz
LCBtb3N0IHJlY2VudGx5Og0KPiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1k
ZXZlbC8yMDI0MTAwODIwMjg0Mi40NDc4LTEtc2hlbnRleUBnbWFpbC5jb20vDQo+IA0KPiAN
Cj4gcn4NCg0KVGhhbmtzIGZvciBwb2ludGluZyBpdCBSaWNoYXJkLg0KVGhlIGxpbmtlZCBw
YXRjaCBpcyBiZXR0ZXIgdGhhbiBjdXJyZW50IGFwcHJvYWNoLCBzbyBpdCBzaG91bGQgYmUg
ZmF2b3JlZC4NCg0KUmVnYXJkcywNClBpZXJyaWNrDQo=

