Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E0FED41C00
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 04:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBRCg-0003qb-OR; Wed, 13 Nov 2024 23:11:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBRCf-0003nc-5E
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 23:11:33 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBRCc-0003dE-GI
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 23:11:32 -0500
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-71815313303so95782a34.1
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 20:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731557489; x=1732162289; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I/qS5fjAunvnhRwFeKvQTgVQs7ykDsgCGDV2Gh2Fd7w=;
 b=IaXuFeanvdkn58ZQikKstjiSaRn4zOrKBYp/6poNsVUXSXUfTKCCOce3WT8D8oKNoT
 8hfGzf7dNN1R0Wkr0B0WdXnIUmOadeXSUx3TZJjRcIakEMuVrnGU+80kqvY/5BhcebIb
 I6S//HwvDTjX5YgY8i5kfjWqcEp8XY5lr75xTDiLX9OpCrRymJPjs1m3igJ24niuULDo
 9QUdEr5Rt48Z4jRdZM6X0sCh5Jl9ESFR2jiGc84GhZRSLg/Q5Jf3mWn3UKYxmoHk+vJn
 Uq1iuUYa03zCbs24Bw/BQvCIGnL3qKNbNUMId4rRbwCrw7n38XnDD/6pyKrPNQ7YTRXH
 Kn5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731557489; x=1732162289;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I/qS5fjAunvnhRwFeKvQTgVQs7ykDsgCGDV2Gh2Fd7w=;
 b=rStuJLQkYdM4wZ0gP+Gi1obbyV8RV+R3SJ1tllYXTMvukVmKPk09wIbMcEzNu5f38O
 lET49/qUjEWg2ANA0o2ssuI+//39OKY9uFkhiKLZIVDKc0SoGUv06SDGUEmm3Svl6lHK
 il7VvDVISg5qYAlR5eCDKzVPemHEFf1rsdTnMEoZwxM0zQUOYJDW3qp9IALxe/TSk9bZ
 GjbQAsCvA40ENW9MnV/afwxny0dE0DbQvJ9gclCGEA1juLdZpfTSW7F+OaAVQ2KSP9PM
 X1X8qZnl4F1nDkv4rAiVDwaR4HwfwsCHT28FTr9T6EePA/yA1S0XIyrs2npaOiTi4rhh
 Vn+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDwBhOk/7bTxK/AX9/zNBBADku/5oDi9DpX/pAHV3E/zrnEB7fLN8SUZHUi/b2dPNG34wd3+gTT2pI@nongnu.org
X-Gm-Message-State: AOJu0Yypb+puxFaLJcwQddnohwKaEMw818T8sBr057RPGI1A61ly6Uod
 G0IgRGRKrsOzdqduh/3k1Sh2XJBBMzBCc/s/UJjuib+sLEMG/LxYbQzuMDhPZIk=
X-Google-Smtp-Source: AGHT+IHyRDYqz+YJmQ9XIjXfV5d5YqMbBQezSo2mZx761MrDq8+J3aN2YeIUrI4DiKzqtTyQjhxlCw==
X-Received: by 2002:a05:6830:d8d:b0:718:cde:ea55 with SMTP id
 46e09a7af769-71a1c1f8ae3mr20229295a34.18.1731557489084; 
 Wed, 13 Nov 2024 20:11:29 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7f8b39af5e2sm132319a12.73.2024.11.13.20.11.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2024 20:11:28 -0800 (PST)
Message-ID: <0c8569ff-149a-41fa-a141-7a2d355901a6@linaro.org>
Date: Wed, 13 Nov 2024 20:11:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/24] target/rx/cpu: Include missing
 'exec/translation-block.h' header
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
 <20241114011310.3615-7-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114011310.3615-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-ot1-x32a.google.com
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
Cj4gVGhlIFRyYW5zbGF0aW9uQmxvY2sgc3RydWN0dXJlIGlzIGRlY2xhcmVkIGluDQo+ICJl
eGVjL3RyYW5zbGF0aW9uLWJsb2NrLmgiLCBhbG9uZyB3aXRoIHRoZSBUQg0KPiBjb21waWxl
IGZsYWcgZGVmaW5pdGlvbnMuIEluY2x1ZGUgdGhlIGhlYWRlcg0KPiBpbiBvcmRlciB0byBh
dm9pZCB3aGVuIHJlZmFjdG9yaW5nOg0KPiANCj4gICAgdGFyZ2V0L3J4L2NwdS5jOjUwOjQy
OiBlcnJvcjogdXNlIG9mIHVuZGVjbGFyZWQgaWRlbnRpZmllciAnQ0ZfUENSRUwnDQo+ICAg
ICAgIDUwIHwgICAgIHRjZ19kZWJ1Z19hc3NlcnQoIXRjZ19jZmxhZ3NfaGFzKGNzLCBDRl9Q
Q1JFTCkpOw0KPiAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgXg0KPiAgICB0YXJnZXQvcngvY3B1LmM6NTE6MjE6IGVycm9yOiBpbmNvbXBs
ZXRlIGRlZmluaXRpb24gb2YgdHlwZSAnc3RydWN0IFRyYW5zbGF0aW9uQmxvY2snDQo+ICAg
ICAgIDUxIHwgICAgIGNwdS0+ZW52LnBjID0gdGItPnBjOw0KPiAgICAgICAgICB8ICAgICAg
ICAgICAgICAgICAgIH5+Xg0KPiAgICBpbmNsdWRlL3FlbXUvdHlwZWRlZnMuaDoxMTY6MTY6
IG5vdGU6IGZvcndhcmQgZGVjbGFyYXRpb24gb2YgJ3N0cnVjdCBUcmFuc2xhdGlvbkJsb2Nr
Jw0KPiAgICAgIDExNiB8IHR5cGVkZWYgc3RydWN0IFRyYW5zbGF0aW9uQmxvY2sgVHJhbnNs
YXRpb25CbG9jazsNCj4gICAgICAgICAgfCAgICAgICAgICAgICAgICBeDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+
DQo+IC0tLQ0KPiAgIHRhcmdldC9yeC9jcHUuYyB8IDEgKw0KPiAgIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yeC9jcHUuYyBi
L3RhcmdldC9yeC9jcHUuYw0KPiBpbmRleCA2NWE3NGNlNzIwLi45NDVhZTZlOWU1IDEwMDY0
NA0KPiAtLS0gYS90YXJnZXQvcngvY3B1LmMNCj4gKysrIGIvdGFyZ2V0L3J4L2NwdS5jDQo+
IEBAIC0yMyw2ICsyMyw3IEBADQo+ICAgI2luY2x1ZGUgIm1pZ3JhdGlvbi92bXN0YXRlLmgi
DQo+ICAgI2luY2x1ZGUgImV4ZWMvZXhlYy1hbGwuaCINCj4gICAjaW5jbHVkZSAiZXhlYy9w
YWdlLXByb3RlY3Rpb24uaCINCj4gKyNpbmNsdWRlICJleGVjL3RyYW5zbGF0aW9uLWJsb2Nr
LmgiDQo+ICAgI2luY2x1ZGUgImh3L2xvYWRlci5oIg0KPiAgICNpbmNsdWRlICJmcHUvc29m
dGZsb2F0LmgiDQo+ICAgI2luY2x1ZGUgInRjZy9kZWJ1Zy1hc3NlcnQuaCINCg0KUmV2aWV3
ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4N
Cg0K

