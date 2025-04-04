Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BBA1C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 17:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0kZs-0002sR-Dm; Fri, 04 Apr 2025 13:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0kZN-0002OY-Co
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:11:13 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0kZF-0005nr-Mw
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:11:03 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-739525d4e12so2121588b3a.3
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 10:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743786656; x=1744391456; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ckL7Fb5GDj/IricNcyvb07rljvUodmmO72TlYmYgnRs=;
 b=A+27UbsBv/9yI5o6Py3ta1sKI4tvl72hzvivHDRO+V9PSjL/YOUN+qooFjr5N0HFwL
 akKlE+RVZ8gZBToQnsYOQZx4ZMIilM0swzgnXdfaByr7wg4HMwVJJArXHhBDzibF2rhn
 D34uJ4VIK6Xuwlji3fZG7wsaOr56Rue3kYlGOekd7877Hr6FjsvWCIVIKNS0R6GN+iJw
 D760/CsnBUI0QZfmYA5TNWQtec+ADjSnNkCXm2im3bCdwWlOZ4k/eesjsngTFfMEExOj
 ERc7JHSfg+BxvK+/I/m5dQnaW5w8vHiCSVCkZBMRbwNjU/ZpUF/NYIby3gLOxsVI2xc5
 0wQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743786656; x=1744391456;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ckL7Fb5GDj/IricNcyvb07rljvUodmmO72TlYmYgnRs=;
 b=nK8Kg/fx5BAahc3N9fPhNfnPEilDZ1wfoedSM0nENvDn5oCpd9f7i3beab/8TR11cw
 1QwNLgz6AorEO7yf2nrKckaNbAYj4cO8D+iojjr9G4ArvQfTws1oLYjkt5uLD7leR1S9
 q7+/HlxieQjNMCXvVRTuBzV5LkE1dteJLMRh3jgf9LcCrHTAbkZXv4uZexSNkZmy2yMX
 loJvCIapJaCQ34ygpDE5ObBhqd/Tbbi/6JSGxw65VKxiNWUYHywnYm/9ex8AKAdYBPAc
 w2DoYBCUyKzKhOb4QHQGwjxnJoiYrwH77Cs6vTKZW7n0kP5Y8XqHuE01gdT/PVrCeG82
 /Jzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8cIu+l4TQ0GldN+pT8AYfWlQ4adkjZcPYbBzNXl3GOWTCQ/JqZ0MFyWQJUxbKccheDBjr5FLUQlJT@nongnu.org
X-Gm-Message-State: AOJu0Yxsy9wMnyHnCxemlhJb9FvUWVgU/Uf164dyFR1AliYYZt9TR9A1
 SRLoJ9uh04SQatlkmh94VvnuMOTXDUi69v+Bi5B4IiwZmomj89ZurWmV/fuvdGY=
X-Gm-Gg: ASbGnctOiwu0iDidifQbcDYL9L0EjERTN22hzWzrdy2yWWebvqoYof7Z5vHq5njF64c
 byenLhwBJqmQAx+LkWtix1bLo+j71jfn4gNlQ9gmySwv2zwbEfuCPKEqkAHRKPynDoUyIBnbN+w
 0IaJ3lmrBm5BcTpts0yO7kcSwMZK8p7AZ65LdYW8cGZantvFbG/lXsdDjA5hXUMAnuqCW/M5Om0
 4eh61QeD3MLWBDP3nPWXyrzV3AY6zchgskchZf/W23+8LgNGqrr7HfwlhxF6tLuGXp1TdBQdODH
 1ehN4e1MzZodRP7iKqX0JVeSif94BnxJKWb/bSCSTxrOUMWsQDiffzZ50vC/UnINX5Zk
X-Google-Smtp-Source: AGHT+IF/HdSeuS3Pk5Dz7tDiS73n1LAGHcgicZhGqP9vxERc1OdnV6x2+DOwaGO9A+Y0VKNCu5YPKg==
X-Received: by 2002:a17:90b:5605:b0:2ff:58c7:a71f with SMTP id
 98e67ed59e1d1-306a4b86cc0mr4196976a91.32.1743786655878; 
 Fri, 04 Apr 2025 10:10:55 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3057ca498c6sm4357416a91.13.2025.04.04.10.10.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 10:10:55 -0700 (PDT)
Message-ID: <a019e4b3-5470-45c6-ae73-14cc7d145376@linaro.org>
Date: Fri, 4 Apr 2025 09:52:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 13/19] accel: Replace CPU_RESOLVING_TYPE ->
 target_cpu_type()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250403234914.9154-1-philmd@linaro.org>
 <20250403234914.9154-14-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250403234914.9154-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

T24gNC8zLzI1IDE2OjQ5LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gU2ln
bmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3Jn
Pg0KPiAtLS0NCj4gICBhY2NlbC9hY2NlbC10YXJnZXQuYyB8IDYgKysrKy0tDQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9hY2NlbC9hY2NlbC10YXJnZXQuYyBiL2FjY2VsL2FjY2VsLXRhcmdldC5j
DQo+IGluZGV4IDMzYTUzOWI0Y2JiLi45ZTllNzBiZTg3NiAxMDA2NDQNCj4gLS0tIGEvYWNj
ZWwvYWNjZWwtdGFyZ2V0LmMNCj4gKysrIGIvYWNjZWwvYWNjZWwtdGFyZ2V0LmMNCj4gQEAg
LTI1LDYgKzI1LDcgQEANCj4gICANCj4gICAjaW5jbHVkZSAicWVtdS9vc2RlcC5oIg0KPiAg
ICNpbmNsdWRlICJxZW11L2FjY2VsLmgiDQo+ICsjaW5jbHVkZSAicWVtdS90YXJnZXRfaW5m
by5oIg0KPiAgIA0KPiAgICNpbmNsdWRlICJjcHUuaCINCj4gICAjaW5jbHVkZSAiYWNjZWwv
YWNjZWwtY3B1LXRhcmdldC5oIg0KPiBAQCAtODgsMTcgKzg5LDE4IEBAIHN0YXRpYyB2b2lk
IGFjY2VsX2luaXRfY3B1X2ludGVyZmFjZXMoQWNjZWxDbGFzcyAqYWMpDQo+ICAgICAgIGNv
bnN0IGNoYXIgKmFjX25hbWU7IC8qIEFjY2VsQ2xhc3MgbmFtZSAqLw0KPiAgICAgICBjaGFy
ICphY2NfbmFtZTsgICAgICAvKiBBY2NlbENQVUNsYXNzIG5hbWUgKi8NCj4gICAgICAgT2Jq
ZWN0Q2xhc3MgKmFjYzsgICAgLyogQWNjZWxDUFVDbGFzcyAqLw0KPiArICAgIGNvbnN0IGNo
YXIgKmNwdV9yZXNvbHZpbmdfdHlwZSA9IHRhcmdldF9jcHVfdHlwZSgpOw0KPiAgIA0KPiAg
ICAgICBhY19uYW1lID0gb2JqZWN0X2NsYXNzX2dldF9uYW1lKE9CSkVDVF9DTEFTUyhhYykp
Ow0KPiAgICAgICBnX2Fzc2VydChhY19uYW1lICE9IE5VTEwpOw0KPiAgIA0KPiAtICAgIGFj
Y19uYW1lID0gZ19zdHJkdXBfcHJpbnRmKCIlcy0lcyIsIGFjX25hbWUsIENQVV9SRVNPTFZJ
TkdfVFlQRSk7DQo+ICsgICAgYWNjX25hbWUgPSBnX3N0cmR1cF9wcmludGYoIiVzLSVzIiwg
YWNfbmFtZSwgY3B1X3Jlc29sdmluZ190eXBlKTsNCj4gICAgICAgYWNjID0gb2JqZWN0X2Ns
YXNzX2J5X25hbWUoYWNjX25hbWUpOw0KPiAgICAgICBnX2ZyZWUoYWNjX25hbWUpOw0KPiAg
IA0KPiAgICAgICBpZiAoYWNjKSB7DQo+ICAgICAgICAgICBvYmplY3RfY2xhc3NfZm9yZWFj
aChhY2NlbF9pbml0X2NwdV9pbnRfYXV4LA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBDUFVfUkVTT0xWSU5HX1RZUEUsIGZhbHNlLCBhY2MpOw0KPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBjcHVfcmVzb2x2aW5nX3R5cGUsIGZhbHNlLCBhY2MpOw0KPiAg
ICAgICB9DQo+ICAgfQ0KPiAgIA0KDQpQbGVhc2Ugc3F1YXNoIHdpdGggcmVsYXRlZCBjb21t
aXQuDQoNClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVy
QGxpbmFyby5vcmc+DQoNCg==

