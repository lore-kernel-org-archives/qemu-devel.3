Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 985FEC369AB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Apr 2025 01:00:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5wYe-0006P4-9L; Fri, 18 Apr 2025 20:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5wYc-0006OW-KD
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 20:59:46 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5wYa-0001RX-Tn
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 20:59:46 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-af51596da56so1930369a12.0
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 17:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745024382; x=1745629182; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U/22It/k1QN5W0U3MbF9ZxLR0hb/4G8pj2FOWykjsU0=;
 b=feRPhVXUgJJg3s9Sxqupw7NIYK/bjDGtP6K8WuV2DXbKt9w+2Jkz232hrRYKFEQ2ZI
 eScreFuYIt5XYg8twk7e94o0HvIs9SaU6A2NCMgPgz4Ma8veaITapFqaLZ3bw7O851NY
 qtDjjOmmjshpLbV42w1pK2BAA8wRGXOQh39tcytEkcTAv2y3kfE9+dEdCmga/kuOocuN
 Q8uHkrsq6W9eLnZdaoSD6DUbYnrmq7p8/k8fuvz59ZXSbBQvJcJ85j/FLADmamyBGrtJ
 xU930ff4WxFpYcio3ePLk9Q2d4RquMrCCXzF4AlJYNZ3Nj1h/Zg6vq5OVGQteTDcS6lZ
 DSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745024382; x=1745629182;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U/22It/k1QN5W0U3MbF9ZxLR0hb/4G8pj2FOWykjsU0=;
 b=VduU3b//PR2sQE24QzBRDTwZzPcKLvpUXZ1KDEKHNQj88m6ll0SKSpEzLy3DSnNnOM
 Hfucn5PT90s9VEm7AcqP2Ne1hQRmNMS/T9esixSzqB8VHkIslq4HZNvm+l1vnPHf5wBz
 Fyuqe5JXL6Id96TNMQwAfD9xkhbmgx//u8BHN4cYKZ23Eqb2fJ37y9bKPDqspi6AU6oI
 hwH5ybbda6b8lHpUYhhebP/fUA6j+QDQxDIH1h3Rw2Rq8OXgoqc3o8nXB1J8riJMZjO9
 YRU5r9EhbcmtG7aaPMN5/HJyYTXuXncJTsgyIZ0odvoVdnL4euxUUDcuYDyFRYQDDuiJ
 Pq2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwa75QJ0KB3wWspqhGTTmXwfuO3cGrxKG60v3fcMIB1svQJ3Iz6FHizQYS1a/g3DYs4I6Ail9Nzd4d@nongnu.org
X-Gm-Message-State: AOJu0YzQq+38QpeyebjF81kCBBYBAt4BiX6jF0EoeJIjjKqPjnFXHhz+
 lScvSTc3PTdyOId1XkZZptIqzodkyZgagS3iRxU4j2tAr0mj3Hn6WBicfXNMBl0=
X-Gm-Gg: ASbGncv5eHs/xqb2fRTbsrKCaDhpkfUA/Iat/u0gYTLdZoDBQDqjb++6HbTTIKZYm5Z
 wKZ4tlHx8hL/UzObomctZOwtm+tIA9d9N2vE9k2sHAJkJ4nD73Z84VZOa846pMB/0WW0e22JM+G
 umd28qE/Z7BK88uAOrRDzO3VpJXfawSqx1TmxcKHFZepW2vQUuPfq6Ao/bNAJCH9l5klnsmh2si
 Gv0FI8lDZKoMhGGw/Y22eoQGC5uQY2zCBX5fnAZRhneg8aV0Lxxy29ANtv5F32L1xCpfn16pLPf
 j6BrQy6fIdyTjEmJCpA+ZtnUf3f7KI5HEl6b09CeF02G+v1snem/uw==
X-Google-Smtp-Source: AGHT+IEfwzRKM2WH+TFIlalJSYFvlAaOLUlm0dL0Gm8jVYQinNbzMjkTvAe2BDsjoIH5oDkhqSpGXA==
X-Received: by 2002:a17:903:1cd:b0:21f:4649:fd49 with SMTP id
 d9443c01a7336-22c5361a27cmr61972505ad.49.1745024382453; 
 Fri, 18 Apr 2025 17:59:42 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50ed2971sm22966085ad.210.2025.04.18.17.59.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 17:59:42 -0700 (PDT)
Message-ID: <77abf226-32ca-4c2f-b855-8b774ddb4e9f@linaro.org>
Date: Fri, 18 Apr 2025 17:59:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 07/14] meson: Prepare to accept per-binary
 TargetInfo structure implementation
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20250418172908.25147-1-philmd@linaro.org>
 <20250418172908.25147-8-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250418172908.25147-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x535.google.com
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

T24gNC8xOC8yNSAxMDoyOSwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IElm
IGEgZmlsZSBkZWZpbmluZyB0aGUgYmluYXJ5IFRhcmdldEluZm8gc3RydWN0dXJlIGlzIGF2
YWlsYWJsZSwNCj4gbGluayB3aXRoIGl0LiBPdGhlcndpc2Uga2VlcCB1c2luZyB0aGUgc3R1
Yi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGls
bWRAbGluYXJvLm9yZz4NCj4gLS0tDQo+ICAgbWVzb24uYnVpbGQgICAgICAgICAgICAgICAg
IHwgOSArKysrKysrKy0NCj4gICBjb25maWdzL3RhcmdldHMvbWVzb24uYnVpbGQgfCAzICsr
Kw0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQ0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBjb25maWdzL3RhcmdldHMvbWVzb24uYnVpbGQN
Cj4gDQo+IGRpZmYgLS1naXQgYS9tZXNvbi5idWlsZCBiL21lc29uLmJ1aWxkDQo+IGluZGV4
IDE2OGIwN2I1ODg3Li5iMGQ0YTlmY2QzNiAxMDA2NDQNCj4gLS0tIGEvbWVzb24uYnVpbGQN
Cj4gKysrIGIvbWVzb24uYnVpbGQNCj4gQEAgLTMyMTYsNiArMzIxNiw3IEBAIGNvbmZpZ19k
ZXZpY2VzX21ha19saXN0ID0gW10NCj4gICBjb25maWdfZGV2aWNlc19oID0ge30NCj4gICBj
b25maWdfdGFyZ2V0X2ggPSB7fQ0KPiAgIGNvbmZpZ190YXJnZXRfbWFrID0ge30NCj4gK2Nv
bmZpZ190YXJnZXRfaW5mbyA9IHt9DQo+ICAgDQo+ICAgZGlzYXNzZW1ibGVycyA9IHsNCj4g
ICAgICdhbHBoYScgOiBbJ0NPTkZJR19BTFBIQV9ESVMnXSwNCj4gQEAgLTM4MDksOSArMzgx
MCw5IEBAIHNwZWNpZmljX3NzLmFkZChmaWxlcygncGFnZS10YXJnZXQuYycsICdwYWdlLXZh
cnktdGFyZ2V0LmMnKSkNCj4gICANCj4gICBjb21tb25fc3MuYWRkKGZpbGVzKCd0YXJnZXRf
aW5mby5jJykpDQo+ICAgc3lzdGVtX3NzLmFkZChmaWxlcygndGFyZ2V0X2luZm8tcW9tLmMn
KSkNCj4gLXNwZWNpZmljX3NzLmFkZChmaWxlcygndGFyZ2V0X2luZm8tc3R1Yi5jJykpDQo+
ICAgDQo+ICAgc3ViZGlyKCdiYWNrZW5kcycpDQo+ICtzdWJkaXIoJ2NvbmZpZ3MvdGFyZ2V0
cycpDQo+ICAgc3ViZGlyKCdkaXNhcycpDQo+ICAgc3ViZGlyKCdtaWdyYXRpb24nKQ0KPiAg
IHN1YmRpcignbW9uaXRvcicpDQo+IEBAIC00MjcyLDYgKzQyNzMsMTIgQEAgZm9yZWFjaCB0
YXJnZXQgOiB0YXJnZXRfZGlycw0KPiAgICAgICBhcmNoX3NyY3MgKz0gZ2Ric3R1Yl94bWwN
Cj4gICAgIGVuZGlmDQo+ICAgDQo+ICsgIGlmIHRhcmdldCBpbiBjb25maWdfdGFyZ2V0X2lu
Zm8NCj4gKyAgICBhcmNoX3NyY3MgKz0gY29uZmlnX3RhcmdldF9pbmZvW3RhcmdldF0NCj4g
KyAgZWxzZQ0KPiArICAgIGFyY2hfc3JjcyArPSBmaWxlcygndGFyZ2V0X2luZm8tc3R1Yi5j
JykNCj4gKyAgZW5kaWYNCj4gKw0KPiAgICAgdCA9IHRhcmdldF9hcmNoW3RhcmdldF9iYXNl
X2FyY2hdLmFwcGx5KGNvbmZpZ190YXJnZXQsIHN0cmljdDogZmFsc2UpDQo+ICAgICBhcmNo
X3NyY3MgKz0gdC5zb3VyY2VzKCkNCj4gICAgIGFyY2hfZGVwcyArPSB0LmRlcGVuZGVuY2ll
cygpDQo+IGRpZmYgLS1naXQgYS9jb25maWdzL3RhcmdldHMvbWVzb24uYnVpbGQgYi9jb25m
aWdzL3RhcmdldHMvbWVzb24uYnVpbGQNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5k
ZXggMDAwMDAwMDAwMDAuLmU5YTVmN2IwNzhlDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIv
Y29uZmlncy90YXJnZXRzL21lc29uLmJ1aWxkDQo+IEBAIC0wLDAgKzEsMyBAQA0KPiArZm9y
ZWFjaCB0YXJnZXQgOiBbJ2FybS1zb2Z0bW11JywgJ2FhcmNoNjQtc29mdG1tdSddDQo+ICsg
IGNvbmZpZ190YXJnZXRfaW5mbyArPSB7dGFyZ2V0IDogZmlsZXModGFyZ2V0ICsgJy5jJyl9
DQo+ICtlbmRmb3JlYWNoDQoNClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVy
cmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQoNCg==

