Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C32C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 07:45:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV5Gm-00055Y-PZ; Wed, 31 Jan 2024 02:44:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rV5Gl-00055C-83
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 02:44:27 -0500
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rV5Gj-0002Cl-JA
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 02:44:26 -0500
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-51032e62171so5419443e87.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 23:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706687063; x=1707291863; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hWWDk6+ztZqMUebEsD++MYY+N5BofUj8+AjrfcH7kO8=;
 b=owmeuvcovGCGGjCA0BjkAj8YTbX3MQtUFGEkL+IgU6SRCV+yyB19SbaI+kKsct+SPZ
 f74t7JrWrixF6VoNJ7kzspf9kvn6LgDsHTckROaAIk8SSZJaMaq7u462RKmx0ov3OVYe
 75dj73i5jZEY3biitbRwiv/kAHeSZnzUcEZMO7UeNNa8GBAwkC+mvqYVX6sEM4r10fox
 gwsEhzYIDKHcLakgPBZLyIqDAefhJrjaw0Ncfk2uMp4I2BrVs5L9Yp/c3pRkgYRnyiaa
 83b9Tc4TDEnRStqv5m+DOcuBbyirfBDg8+XgA0/L0WM/hhgCJf2wqoCXszDnpXc8sicl
 lWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706687063; x=1707291863;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hWWDk6+ztZqMUebEsD++MYY+N5BofUj8+AjrfcH7kO8=;
 b=uTJMTkQH8Hn6EGekgBkMy5I9aYsYK3GIiG835bGeEC2RW6Z538Vh2Eb0gmSFtWIGYf
 79YeIcZOPLioE4g4ENUdOw3pp49VEti9nV4Nka6aWx6JwRey0YaVRi9qniuqKcePTFNk
 lyRRywjVV5Ez+ID8UTW+fhEZC61gFVPaK2mmw25GQ2f7gtX5SVsE02H1KaKDB9rTb8Xa
 2Dm70v7KVthVFyV4/lkOr+JvMnk+Ec/D/DLA1BJuPoD5u+nrYTJBbeh5joojeWv6Bcxs
 1isyZeqBbL+EeOnzjs46IlFM433d3HRC9PGLjPEb7vid6PsZZHumy4DcfShJGXdRM+rM
 YlQw==
X-Gm-Message-State: AOJu0YzMm/MQpsDNB+UcTdoyLH46M6CBEVB4vqrepJSIP+zeH5yeokgs
 /2agD4PUXzLMVHm9g7ROCXk+uvQ19ZDwm8O4eZOKwn3wtmsUzKAC3jnoxHgSzWfUsAQGgJmxujT
 l
X-Google-Smtp-Source: AGHT+IFD5fNEY4M/yGkS/li93LoQR63U96XuUsJvEVIdRkhp1z4131S4tK+FFkscxrtbPUGtEU0lAA==
X-Received: by 2002:ac2:5159:0:b0:510:15aa:ef16 with SMTP id
 q25-20020ac25159000000b0051015aaef16mr604030lfd.58.1706687063560; 
 Tue, 30 Jan 2024 23:44:23 -0800 (PST)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 z12-20020a7bc7cc000000b0040efb503d58sm736488wmk.28.2024.01.30.23.44.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jan 2024 23:44:23 -0800 (PST)
Message-ID: <ebbd8949-fb51-4cd0-9fe0-0fbd765c8331@linaro.org>
Date: Wed, 31 Jan 2024 11:44:18 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/14] plugins: scoreboard API
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20240118032400.3762658-1-pierrick.bouvier@linaro.org>
 <20240118032400.3762658-3-pierrick.bouvier@linaro.org>
 <87il3grut0.fsf@draig.linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87il3grut0.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

T24gMS8yNi8yNCAxOToxNCwgQWxleCBCZW5uw6llIHdyb3RlOg0KPj4gKyAgICAgICAgbmVl
ZF9yZWFsbG9jID0gVFJVRTsNCj4+ICsgICAgfQ0KPj4gKyAgICBwbHVnaW4uc2NvcmVib2Fy
ZF9zaXplID0gY3B1LT5jcHVfaW5kZXggKyAxOw0KPj4gKyAgICBnX2Fzc2VydChwbHVnaW4u
c2NvcmVib2FyZF9zaXplIDw9IHBsdWdpbi5zY29yZWJvYXJkX2FsbG9jX3NpemUpOw0KPj4g
Kw0KPj4gKyAgICBpZiAoZ19oYXNoX3RhYmxlX3NpemUocGx1Z2luLnNjb3JlYm9hcmRzKSA9
PSAwKSB7DQo+PiArICAgICAgICAvKiBub3RoaW5nIHRvIGRvLCB3ZSBqdXN0IHVwZGF0ZWQg
c2l6ZXMgZm9yIGZ1dHVyZSBzY29yZWJvYXJkcyAqLw0KPj4gKyAgICAgICAgcmV0dXJuOw0K
Pj4gKyAgICB9DQo+PiArDQo+PiArICAgIGlmIChuZWVkX3JlYWxsb2MpIHsNCj4+ICsjaWZk
ZWYgQ09ORklHX1VTRVJfT05MWQ0KPj4gKyAgICAgICAgLyoqDQo+PiArICAgICAgICAgKiBj
cHVzIG11c3QgYmUgc3RvcHBlZCwgYXMgc29tZSB0YiBtaWdodCBzdGlsbCB1c2UgYW4gZXhp
c3RpbmcNCj4+ICsgICAgICAgICAqIHNjb3JlYm9hcmQuDQo+PiArICAgICAgICAgKi8NCj4+
ICsgICAgICAgIHN0YXJ0X2V4Y2x1c2l2ZSgpOw0KPj4gKyNlbmRpZg0KPiANCj4gSG1tIHRo
aXMgc2VlbXMgd3JvbmcgdG8gYmUgVVNFUl9PTkxZLiBXaGlsZSB3ZSBkb24ndCBleHBlY3Qg
dG8gcmVzaXplIGluDQo+IHN5c3RlbSBtb2RlIGlmIHdlIGRpZCB3ZSBjZXJ0YWlubHkgd2Fu
dCB0byBkbyBpdCBkdXJpbmcgZXhjbHVzaXZlDQo+IHBlcmlvZHMuDQo+IA0KDQpBZnRlciBp
bnZlc3RpZ2F0aW9uLCBjdXJyZW50X2NwdSBUTFMgdmFyIGlzIG5vdCBzZXQgaW4gY3B1cy1j
b21tb24uYyBhdCANCnRoaXMgcG9pbnQuDQoNCkluZGVlZCB3ZSBhcmUgbm90IG9uIGFueSBj
cHVfZXhlYyBwYXRoLCBidXQgaW4gdGhlIGNwdV9yZWFsaXplX2ZuIHdoZW4gDQpjYWxsaW5n
IHRoaXMgKHRocm91Z2ggcWVtdV9wbHVnaW5fdmNwdV9pbml0X2hvb2spLg0KDQpPbmUgb2J2
aW91cyBmaXggaXMgdG8gY2hlY2sgaWYgaXQncyBOVUxMIG9yIG5vdCwgbGlrZToNCi0tLSBh
L2NwdS1jb21tb24uYw0KKysrIGIvY3B1LWNvbW1vbi5jDQpAQCAtMTkzLDcgKzE5Myw3IEBA
IHZvaWQgc3RhcnRfZXhjbHVzaXZlKHZvaWQpDQogICAgICBDUFVTdGF0ZSAqb3RoZXJfY3B1
Ow0KICAgICAgaW50IHJ1bm5pbmdfY3B1czsNCg0KLSAgICBpZiAoY3VycmVudF9jcHUtPmV4
Y2x1c2l2ZV9jb250ZXh0X2NvdW50KSB7DQorICAgIGlmIChjdXJyZW50X2NwdSAmJiBjdXJy
ZW50X2NwdS0+ZXhjbHVzaXZlX2NvbnRleHRfY291bnQpIHsNCiAgICAgICAgICBjdXJyZW50
X2NwdS0+ZXhjbHVzaXZlX2NvbnRleHRfY291bnQrKzsNCiAgICAgICAgICByZXR1cm47DQog
ICAgICB9DQoNCkRvZXMgYW55b25lIHN1Z2dlc3QgYW5vdGhlciBwb3NzaWJsZSBmaXg/IChs
aWtlIGRlZmluZSBjdXJyZW50X2NwdSANCnNvbWV3aGVyZSwgb3IgbW92aW5nIHFlbXVfcGx1
Z2luX3ZjcHVfaW5pdF9ob29rIGNhbGwpLg0K

