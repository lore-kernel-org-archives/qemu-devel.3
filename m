Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E73C3600C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 15:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txShD-0000xb-KC; Wed, 26 Mar 2025 11:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1txSh7-0000ve-Th
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 11:29:30 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1txSh6-0005jd-9B
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 11:29:29 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2243803b776so501285ad.0
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 08:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743002966; x=1743607766; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dfqmbKEui0Y+dnYt+gvqNHIaZaXd3gfYw6dZUrVJyL8=;
 b=huWRI416ppKtPMhXwTn+BWxb1S2deT6F0if5PKE1n5CBoElKdH/1zxbxlibT8iZ70V
 D/Ybt0AfLyAwHI/UW/PsAVrTCaq0aW6O9bztafIdUgpsvO1hAd+2kPYndskVjg5NhCDB
 zy6J57p/fC9eBkdUMJYXpMi4ggBYYi5sF/f62yfN9hwAbzAiLcp6APi9zHkgr22y7Eet
 +d7uKw9SN0trgQOYGI4fE4Dm/WOdpf/cQDQTyiK3j3aml6BgCahMdLhAJwHBbCcXCOYD
 MaeDBQZRyOxDent4AwnLpugMWlBLQ0JtxjRZAblEk1c4xumN7vder0UOBEnKbQewo8BR
 ONXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743002966; x=1743607766;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dfqmbKEui0Y+dnYt+gvqNHIaZaXd3gfYw6dZUrVJyL8=;
 b=TFBrZlY8L2/nGMCds4J6KHDNd5d7dgP5FoVwv1Kkc57GXoOw7eVZnr746oB/ThQh3s
 z1YWWu4ANkK1Zl+kqx3WRX8fWtYfIizoUZoGubkkfViYBUYwG4OcWEwNodRNxQS8YGDO
 kJ7xuLKKVKmSlzXwsnnFYUrnBPkknLNfE+04l+8Atxz0KJX814RJaFylnOZA3T6Owm7z
 9Td0lvEhln/EVzR/oSMhqsFNZC98x3yz8VAvsyTfOKUl+Dw1m+LGZwClO2CVrnjTBBtF
 kZ0mpyXiiCwqIzMvYTqAfR2QDykd13/C1HyZezuhQCIHEghl4EwJGAKOptY1FdfQb/C4
 0mPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8ip+SygrIjscJMWOdzB94Fm9FgdiJeLagiiVlZa7nqqlh1fS0Chq8KS0ha6kD0K8VDRyT4iwW9DGs@nongnu.org
X-Gm-Message-State: AOJu0Yxp58UHtWWDETarS3kmyYFlcAV8zpSHFAgeVsWvQv3Nlm+AnL4J
 gzUXoyF40B205VTivTFBxTglXH+cuLYXb00t3NEfnkX1JGQiZrFiOuUuooelOWjeyROuK1yMoyZ
 v
X-Gm-Gg: ASbGncu9ZtwBHJQ/Fa15ASuRwYZl4ySGYmnaJUyZo5euSMxAq1whccTOrd9dUALscTM
 SKOl4pprw72UctMm1Mbi/gCiFg+6w5aaUHFzCkFHhD3LRiVyFwp1VQzvtOGlvB6fGAQ6IgAOL1P
 cN5YyAQF9doW75IZEX/6xZFuYsJ+z5weMcRx+vndpi9+vzNeG6a9DG9qnZp8e3gAqar1/6hOfHd
 LALL6nZA/nXpIZA+OQ5eIRwsnPNRjFOHE5mJwYsPdumo5LY4PateY81/hFmxf8eJ7mad22iJUhv
 mnXU9UKjCi+IOgJKp8+H81DtIxd/MiKpjmf3JFnslZ0ffsG85CQbasdCbA==
X-Google-Smtp-Source: AGHT+IHO0kmF9ekXQ2x5CtOc5Nqy9pB4G3xEdN22zkjtcnuef0X3499e78nw24UHza9Nm1C1zQo+6w==
X-Received: by 2002:a17:903:228c:b0:220:ff3f:6cba with SMTP id
 d9443c01a7336-22780e02a3emr372867625ad.38.1743002966389; 
 Wed, 26 Mar 2025 08:29:26 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811bc272sm111122885ad.146.2025.03.26.08.29.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Mar 2025 08:29:25 -0700 (PDT)
Message-ID: <29bab4b4-9b9d-4093-ada4-96f2d11f5ede@linaro.org>
Date: Wed, 26 Mar 2025 08:24:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 5/8] target/mips: Replace ldtul_p() ->
 ldn_p(sizeof(target_ulong))
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo
 <arikalo@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20250325154058.92735-1-philmd@linaro.org>
 <20250325154058.92735-6-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250325154058.92735-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

T24gMy8yNS8yNSAwODo0MCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IFJl
cGxhY2UgdGhlIHNpbmdsZSBsZHR1bF9wKCkgY2FsbCBieSBhIGdlbmVyaWMgbGRuX3AoKSBv
bmUuDQo+IE5vIGxvZ2ljYWwgY2hhbmdlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGhpbGlw
cGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiAtLS0NCj4gICB0YXJn
ZXQvbWlwcy9nZGJzdHViLmMgfCA5ICsrKysrLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA1
IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGFy
Z2V0L21pcHMvZ2Ric3R1Yi5jIGIvdGFyZ2V0L21pcHMvZ2Ric3R1Yi5jDQo+IGluZGV4IDE2
OWQ0NzQxNmE2Li5iOWZjNjY3MzczZSAxMDA2NDQNCj4gLS0tIGEvdGFyZ2V0L21pcHMvZ2Ri
c3R1Yi5jDQo+ICsrKyBiL3RhcmdldC9taXBzL2dkYnN0dWIuYw0KPiBAQCAtNzksMTIgKzc5
LDEzIEBAIGludCBtaXBzX2NwdV9nZGJfd3JpdGVfcmVnaXN0ZXIoQ1BVU3RhdGUgKmNzLCB1
aW50OF90ICptZW1fYnVmLCBpbnQgbikNCj4gICB7DQo+ICAgICAgIENQVU1JUFNTdGF0ZSAq
ZW52ID0gY3B1X2Vudihjcyk7DQo+ICAgICAgIHRhcmdldF91bG9uZyB0bXA7DQo+ICsgICAg
c2l6ZV90IHJlZ3NpemUgPSBzaXplb2YodG1wKTsNCj4gICANCj4gLSAgICB0bXAgPSBsZHR1
bF9wKG1lbV9idWYpOw0KPiArICAgIHRtcCA9IGxkbl9wKG1lbV9idWYsIHJlZ3NpemUpOw0K
PiAgIA0KPiAgICAgICBpZiAobiA8IDMyKSB7DQo+ICAgICAgICAgICBlbnYtPmFjdGl2ZV90
Yy5ncHJbbl0gPSB0bXA7DQo+IC0gICAgICAgIHJldHVybiBzaXplb2YodGFyZ2V0X3Vsb25n
KTsNCj4gKyAgICAgICAgcmV0dXJuIHJlZ3NpemU7DQo+ICAgICAgIH0NCj4gICAgICAgaWYg
KGVudi0+Q1AwX0NvbmZpZzEgJiAoMSA8PCBDUDBDMV9GUCkgJiYgbiA+PSAzOCAmJiBuIDwg
NzIpIHsNCj4gICAgICAgICAgIHN3aXRjaCAobikgew0KPiBAQCAtMTA0LDcgKzEwNSw3IEBA
IGludCBtaXBzX2NwdV9nZGJfd3JpdGVfcmVnaXN0ZXIoQ1BVU3RhdGUgKmNzLCB1aW50OF90
ICptZW1fYnVmLCBpbnQgbikNCj4gICAgICAgICAgICAgICB9DQo+ICAgICAgICAgICAgICAg
YnJlYWs7DQo+ICAgICAgICAgICB9DQo+IC0gICAgICAgIHJldHVybiBzaXplb2YodGFyZ2V0
X3Vsb25nKTsNCj4gKyAgICAgICAgcmV0dXJuIHJlZ3NpemU7DQo+ICAgICAgIH0NCj4gICAg
ICAgc3dpdGNoIChuKSB7DQo+ICAgICAgIGNhc2UgMzI6DQo+IEBAIC0xNDQsNSArMTQ1LDUg
QEAgaW50IG1pcHNfY3B1X2dkYl93cml0ZV9yZWdpc3RlcihDUFVTdGF0ZSAqY3MsIHVpbnQ4
X3QgKm1lbV9idWYsIGludCBuKQ0KPiAgICAgICAgICAgYnJlYWs7DQo+ICAgICAgIH0NCj4g
ICANCj4gLSAgICByZXR1cm4gc2l6ZW9mKHRhcmdldF91bG9uZyk7DQo+ICsgICAgcmV0dXJu
IHJlZ3NpemU7DQo+ICAgfQ0KDQpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGll
cnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0KDQo=

