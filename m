Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE8DBC282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 16:53:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tprz8-0007BX-Ap; Wed, 05 Mar 2025 11:52:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tpryz-00079n-61
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:52:34 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tpryx-0005vR-BB
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:52:32 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-223fb0f619dso16184635ad.1
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 08:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741193550; x=1741798350; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Gm/+QPCZu1UmTd5EB4JJzZIhgR34GrlUDa94v6dTbV0=;
 b=DMOWmnmgB955nWv1WO0TuSCjiDadUmRlwI023QmMGzTgjS6Unwa/7gbjyZIPmjDBvR
 NnhBhNsm7eoF283LF1FRPDHFqk4cIotUPE/sVQUuChsyneXxVTyzfz30gELQ/vbJjOB/
 cmwU8vGFjTIRYiFed/5aK/y1RF31aBzidA26hkLdQU1NfJnHRpzhfXs5RyWL9o03+hg5
 8Pe7LT69wJVdZ9M2eRMoG1RhTet3HAuhOHiNbVfT8BAGJeFFHYAhdXkWHcHU4GHUAHT1
 raEl9spyTUCNc8y0//NCXXiui8udMzAXWzvKSuivnnT8+K5QjacxCFvL1cvk8dciUW1X
 3UZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741193550; x=1741798350;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gm/+QPCZu1UmTd5EB4JJzZIhgR34GrlUDa94v6dTbV0=;
 b=FWSqNAFmUyI7EwY2Lha0JYQ15Ax09b3UMh12S2gDlujJpFaC5gHHSgTOepHmrGRIDb
 We8PA38y0z8v6aKfsOU2KUA2NY97DW152ZwPu7IW4+hL79QQnDOtv4qJOoezvsFG6t8d
 vmQv3Naihy3SnRkrvrrtoE5btab8XVTu939iBzi3q6IKhjrcdC79FJDxrU32Q+vbi+pH
 RKYQbPteiTtelPLULYa7r2HbcEbQZIP7uh2OhEhzjZxEvVW7NPoNcObg0sNikIt5gIdq
 0O1kgycbhIeY1yKOexw99wPlbnxTjjpL57rsfaUjk4k3cWP22tq/a6Zf6L0bG9KT3lJT
 tgjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+uXUVz5W1+6VpSL/j5PdysREH8cxjR3qR2sX/qDV2RBPg/GNjzNMfX3abRxFgf5mhc+J1l9YKQM/W@nongnu.org
X-Gm-Message-State: AOJu0Ywr6nu0TMcPeafHRcuvIzeQT27AixeBlvdw7jfVBT1pKIM0OQgz
 RudjpLo1enMyUxCyValX/VgPcXqdaKb6IYBc8z713Ajky1ykeNl4OGGa+UZuOE4=
X-Gm-Gg: ASbGncuieFbOTNeBzX+fug32e5kuYQClE/vttZMMzrWUOOoN77yFleNW3Y0y+gFd4Dh
 BZ/wsXgoLOmoS0QnAZFJ3OyXrSSomZRv3AFWPOwQX2/dXA/qX0f4cblzDBs7PstOtEsan4sMq31
 TKa27y450eMUNYKI6LWLtbai1TvgB4aT4VhSDBy286xbFS1RJ3EDdLt71rG0aqJDnl4ZDr77d3w
 kDivI4qyr5TRp6Ud7N7LXcPH9iQv0ZA21gBCNdw+FP9Wpar76HU/q+BbsrlAaNHcncgJUac8pJR
 iUxVZ8cNh4k3v2z3icAJE8PE+gK8GRjbW/pAook9qekwDNWLu7q2N2hulA==
X-Google-Smtp-Source: AGHT+IHUQLN+UE66LLyb9QL2RLG/E5/qamim3O0wvOh7yEsA/jhb7guLXbnLCgDJ9OvHWSIxqB8IoQ==
X-Received: by 2002:a17:902:d48c:b0:21f:81f4:21b8 with SMTP id
 d9443c01a7336-223f1d3bf88mr45170625ad.50.1741193549733; 
 Wed, 05 Mar 2025 08:52:29 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223ff94dc8bsm7617555ad.2.2025.03.05.08.52.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 08:52:29 -0800 (PST)
Message-ID: <a0a8faf3-5ab0-4b9d-9517-1aff3b7cdaaf@linaro.org>
Date: Wed, 5 Mar 2025 08:52:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/4] hw/ppc: Remove TARGET_PPC64 use in
 ppc_create_page_sizes_prop()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20250305161248.54901-1-philmd@linaro.org>
 <20250305161248.54901-5-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250305161248.54901-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

T24gMy81LzI1IDA4OjEyLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gQ2hl
Y2sgdGhlIGJpbmFyeSBpcyBidWlsdCBmb3IgNjQtYml0IFBQQyBhdCBydW50aW1lLA0KPiBy
ZW1vdmluZyB0aGUgbmVlZCBmb3IgVEFSR0VUX1BQQzY0ICNpZmRlZidyeS4NCj4gDQoNClNh
bWUgZ29lcyBoZXJlLCB3ZSB3YW50IGEgdGFyZ2V0X2lzX3BwYzY0KCkgZnVuY3Rpb24uDQpB
cyB3ZWxsLCBtb2RpZnlpbmcgaHcvcHBjIHN0dWZmIHNob3VsZCBiZSBpbiBhbiBpbmRlcGVu
ZGVudCBzZXJpZXMgDQppZGVhbGx5LCB0byBrZWVwIGl0IG1vcmUgY2xlYXIuDQoNCj4gU2ln
bmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3Jn
Pg0KPiAtLS0NCj4gICBody9wcGMvZmR0LmMgfCA1ICsrKy0tDQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9ody9wcGMvZmR0LmMgYi9ody9wcGMvZmR0LmMNCj4gaW5kZXggMDgyOGFkNzI1NDguLmJh
ZTI2OWM3MmFjIDEwMDY0NA0KPiAtLS0gYS9ody9wcGMvZmR0LmMNCj4gKysrIGIvaHcvcHBj
L2ZkdC5jDQo+IEBAIC04LDEyICs4LDEyIEBADQo+ICAgICovDQo+ICAgDQo+ICAgI2luY2x1
ZGUgInFlbXUvb3NkZXAuaCINCj4gKyNpbmNsdWRlICJxZW11L2xlZ2FjeV9iaW5hcnlfaW5m
by5oIg0KPiAgICNpbmNsdWRlICJ0YXJnZXQvcHBjL2NwdS5oIg0KPiAgICNpbmNsdWRlICJ0
YXJnZXQvcHBjL21tdS1oYXNoNjQuaCINCj4gICANCj4gICAjaW5jbHVkZSAiaHcvcHBjL2Zk
dC5oIg0KPiAgIA0KPiAtI2lmIGRlZmluZWQoVEFSR0VUX1BQQzY0KQ0KPiAgIHNpemVfdCBw
cGNfY3JlYXRlX3BhZ2Vfc2l6ZXNfcHJvcChQb3dlclBDQ1BVICpjcHUsIHVpbnQzMl90ICpw
cm9wLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplX3QgbWF4
c2l6ZSkNCj4gICB7DQo+IEBAIC0yMSw2ICsyMSw4IEBAIHNpemVfdCBwcGNfY3JlYXRlX3Bh
Z2Vfc2l6ZXNfcHJvcChQb3dlclBDQ1BVICpjcHUsIHVpbnQzMl90ICpwcm9wLA0KPiAgICAg
ICBpbnQgaSwgaiwgY291bnQ7DQo+ICAgICAgIHVpbnQzMl90ICpwID0gcHJvcDsNCj4gICAN
Cj4gKyAgICBhc3NlcnQobGVnYWN5X2JpbmFyeV9pc182NGJpdCgpKTsNCj4gKw0KPiAgICAg
ICBmb3IgKGkgPSAwOyBpIDwgUFBDX1BBR0VfU0laRVNfTUFYX1NaOyBpKyspIHsNCj4gICAg
ICAgICAgIFBQQ0hhc2g2NFNlZ21lbnRQYWdlU2l6ZXMgKnNwcyA9ICZjcHUtPmhhc2g2NF9v
cHRzLT5zcHNbaV07DQo+ICAgDQo+IEBAIC00Niw0ICs0OCwzIEBAIHNpemVfdCBwcGNfY3Jl
YXRlX3BhZ2Vfc2l6ZXNfcHJvcChQb3dlclBDQ1BVICpjcHUsIHVpbnQzMl90ICpwcm9wLA0K
PiAgIA0KPiAgICAgICByZXR1cm4gKHAgLSBwcm9wKSAqIHNpemVvZih1aW50MzJfdCk7DQo+
ICAgfQ0KPiAtI2VuZGlmDQoNCg==

