Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F34B3E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 18:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXlZg-0002dk-GC; Tue, 14 Jan 2025 13:23:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tXlZc-0002ZN-Jf
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 13:23:33 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tXlZb-0004NN-1M
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 13:23:32 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2161eb95317so104210745ad.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 10:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736879009; x=1737483809; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YfibVc8Vdktjuc3UhTFI6rFsbdmzWqCTl06AX/tpZco=;
 b=WRNRa1dz6ByLn5xevKJZVryPRqcXHh10Ou0E0YVplHoMcBMXncM1GTlKrdQtxkUWjI
 QLPDlGHOZF2LQ4MYwxTq5S0B4QZ3uZBXlfbCOToHpeULWh8HKc9EHs2KTznchlQejQgr
 WsINIgiBqgNQKvi/GU+EQ99hqKAZ3r/p9bj+OD//naDB32s9pjb9857So501ZSErFlot
 I1LejvGd/vHGON+oIf2/Kyjb5Hr7Gpmifm22QNPXG637ZzWEgqkRG5DQAyBh1QSrIQuc
 VxX6DUhB2WM7xSsQNVhi1Y/xA/ruXJ0awfHi+aqV4ZDHsILfhWdBdh+vFxoLBMOtVz2A
 oGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736879009; x=1737483809;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YfibVc8Vdktjuc3UhTFI6rFsbdmzWqCTl06AX/tpZco=;
 b=BYE5+2cxlwGSHBzohIu1TCj0o2th1cXalqPD9mVuro1K+MmxrTVMVY21n7jyXAzw07
 S953MhB9n9nxZwjMKo1SyjS/UGC2lRqCrdgc86cM/b5zVmw6oR/POEj9ZZRN6IbNwGtb
 4ucK8z4N4Hx0gszyZE8aUnNI1lEAgMHtUIXM04cfw7G6G9nfzEwKpDrPybOR3Tpi6Ajg
 7QpXk/mhU9tbAi6nIskCxgM+BtRtQERVN2vczys/rgh4Js4nmEnqhmo6TUGeddRIxE0R
 +g9cQ1MW8LWA7dw9QZNtuHjp70a3bROonR6GR2+W4HKCk/Tbf0LfNPyqPc4erhK20gHP
 GMhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUb2lU7WUvzdL2EtP/YYFSTktsUlN1P2t68hpsJmMj1GKX734iEAcM3B5t+nIBWYN9XlVjK0cyzGCpf@nongnu.org
X-Gm-Message-State: AOJu0YzQWw7+ndcN1wFqQK/ZWX1vp088wlTA6qsAF1OIZn73F1V6+fY8
 BrIwZLWYnKgMYyuJmGZVstfzQXkYhygYkn+QZ3eZC3d9YCpnXCZQfJZPzNtAvWs=
X-Gm-Gg: ASbGnctAIJFP0dnZBEan0FmqP0lSIx7ckh6MTDy8p2BGSnibZknBULd8AD4rM6swf+p
 9fTGgo974gLnBzT/nMQSvA9wRJAD1W6AyWEbFoFuwfLD7RkDsC6/mFkp2JJ+ZJ7mO31m1KtUTli
 6gX1JevxpIOhaQsyh2FELLOdJppBOn4+l31Gl6v8RNrvXoVjCNa82YsvxzE6p/DrgTUJtse0bV3
 VJ9+u8mgQD8HGO6aoMhs8ZWQcAjkfpulrxNsHbI03r6wr6oYNx0zKBVaDdNGIfRG/G5aQ==
X-Google-Smtp-Source: AGHT+IEQl43CRbuiZj76UMCndJClJerI3E8tsyy15s4lxMuL065XuvJxlWHdJT+tKauileST7nXtBw==
X-Received: by 2002:a05:6a00:ad0:b0:725:e957:1dd1 with SMTP id
 d2e1a72fcca58-72d21fde02dmr34781851b3a.17.1736879009522; 
 Tue, 14 Jan 2025 10:23:29 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72d406a57dcsm7917126b3a.170.2025.01.14.10.23.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 10:23:29 -0800 (PST)
Message-ID: <2c1b32d5-215b-48cf-b2da-220752532dfb@linaro.org>
Date: Tue, 14 Jan 2025 10:23:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 26/37] plugins: fix kdoc annotation
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Stefan Weil <sw@weilnetz.de>
References: <20250114113821.768750-1-alex.bennee@linaro.org>
 <20250114113821.768750-27-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250114113821.768750-27-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

T24gMS8xNC8yNSAwMzozOCwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBUaGUgZnVuY3Rpb24g
aXMgcWVtdV9wbHVnaW5fbWVtX2dldF92YWx1ZSgpDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBB
bGV4IEJlbm7DqWUgPGFsZXguYmVubmVlQGxpbmFyby5vcmc+DQo+IC0tLQ0KPiAgIGluY2x1
ZGUvcWVtdS9xZW11LXBsdWdpbi5oIHwgMiArLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
cWVtdS9xZW11LXBsdWdpbi5oIGIvaW5jbHVkZS9xZW11L3FlbXUtcGx1Z2luLmgNCj4gaW5k
ZXggMGZiYTM2YWUwMi4uM2E4NTBhYTIxNiAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9xZW11
L3FlbXUtcGx1Z2luLmgNCj4gKysrIGIvaW5jbHVkZS9xZW11L3FlbXUtcGx1Z2luLmgNCj4g
QEAgLTU4Myw3ICs1ODMsNyBAQCBRRU1VX1BMVUdJTl9BUEkNCj4gICBib29sIHFlbXVfcGx1
Z2luX21lbV9pc19zdG9yZShxZW11X3BsdWdpbl9tZW1pbmZvX3QgaW5mbyk7DQo+ICAgDQo+
ICAgLyoqDQo+IC0gKiBxZW11X3BsdWdpbl9tZW1fZ2V0X21lbV92YWx1ZSgpIC0gcmV0dXJu
IGxhc3QgdmFsdWUgbG9hZGVkL3N0b3JlZA0KPiArICogcWVtdV9wbHVnaW5fbWVtX2dldF92
YWx1ZSgpIC0gcmV0dXJuIGxhc3QgdmFsdWUgbG9hZGVkL3N0b3JlZA0KPiAgICAqIEBpbmZv
OiBvcGFxdWUgbWVtb3J5IHRyYW5zYWN0aW9uIGhhbmRsZQ0KPiAgICAqDQo+ICAgICogUmV0
dXJuczogbWVtb3J5IHZhbHVlDQoNClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxw
aWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQoNCg==

