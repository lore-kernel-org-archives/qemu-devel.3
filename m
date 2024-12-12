Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F840E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 19:28:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLoqp-0005eM-6G; Thu, 12 Dec 2024 14:27:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tLoqZ-0005Ms-Kc
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 14:27:39 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tLoqT-0005PW-32
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 14:27:39 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21619108a6bso8002635ad.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 11:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734031650; x=1734636450; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G68eKO78OMuRs+0C3zZ7sV9CBAsHbjoXzn66FWuvmks=;
 b=woYNGYm1t4Gm9vpSn1qGlFuESU02GWddQkC28dk910hJVSQuSlbo1xE/mggl0RzCry
 meKA8/yYFKiwrL/fe1qxp6ZlkvpKYLUDzYq9WypRJl2eDXBUQHhMC01wUMvZokDc7Qr3
 gcxlR/tqNW7ZCVaRbFtb3LjaCxJLUdgVff976tXsZeEAOpetC/q0jgV1rUa4G0s9cMZ5
 DKUMa/GaE1YZZb0OssB+auHgqY1nxXWhimgK9ykgRiRp8PY4374qNR5HJkKxZ5LLBB7K
 Vv6ka4Krs3S/+mHCUJ0EOyv7gYQvBJ0It9k9IrZ12+3ot7LhUSa3n7pY1eh4WP9khEyi
 drGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734031650; x=1734636450;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G68eKO78OMuRs+0C3zZ7sV9CBAsHbjoXzn66FWuvmks=;
 b=O9rpC5rCBcsUYIYc4nayyfc9fwN2WIayCnwgt5i34zIs/ZT56LIdIQ49fCCzotRkLo
 Jn8VnPTYtPcK0/4YgN4w+CveBe6tfGrNtWD1OIgVxHW9tiCyO/yQpznukk9L+zcwpgA7
 n89RqZkd0wmhwlNei8rpi7gk+0k8WKv8yQOiBbG6bUWefUlWMiqqwGB2+BCoOdj66xkw
 HuVZXr59OXPgcWzrjKDOD+Uu2yGZCIDWYQlrHQEfmejIyuz7Fl76yW6RiNrhox+pdI8c
 vd5OFrW9LUEhlMulMi5MSF9VlMMiQ/ya9v/knUkeU2aFAB/M2MdZAn0gfcgvc9MRLm8Z
 JIOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVeqNz0AUw01xANLAYBdFgNzrHkg6IXA87I0BQQKDIkIl0/QrTPSOjwbFPSxtx0y3vklaTeb/Dm4pu@nongnu.org
X-Gm-Message-State: AOJu0Yz9cygKOqA4TsIEUN6Q0+uYVLG9GQTpaRtyTZWIPuHqH7d9EIuc
 6yl0PdAocQ99dTyIDw4JsspqZc72S0oUyBg87IW31AI8NPIfrue9RAdBr36L1jY=
X-Gm-Gg: ASbGncsjVdDjZzmIQquH65uZNIf2AC+cASfLX+7vemVt19INYB7Egid9d4lyn1CtgNQ
 ilaHA1NiR+0roiVGTz+TN+JDyi/knCNd8lsLHL1szXMwdOvl2X2p9fvty8eezllhO8jYsotKwPL
 ldHwBiToRrjokYrjCcNtMEi6cy9gCzy+K4u3SOSJAfmszq2fD2sqGDSh8BaK7OUwic5VdV6B++G
 +xiDgqHhHgYDczxP+QN7cmiWk9J4X0o35c7wxNI9YBNEMRqmj1toik9MionnSDGTMSDlpceSHoQ
 PbyhiBoXeXawUIQSqCTx6Eh1wCe3
X-Google-Smtp-Source: AGHT+IHPp5n+c13VZzY7/1wFGe/HnnmHCkYcwpd/oLYt/YV8NA7gSjxaPa90rG8wnyTUD0wlv1leoA==
X-Received: by 2002:a17:903:1cd:b0:216:526a:53df with SMTP id
 d9443c01a7336-217786a2d42mr123238475ad.54.1734031650237; 
 Thu, 12 Dec 2024 11:27:30 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f142d90be3sm1654780a91.7.2024.12.12.11.27.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 11:27:29 -0800 (PST)
Message-ID: <e11e7874-f26b-4eb2-9f8d-9f4fddc961f6@linaro.org>
Date: Thu, 12 Dec 2024 11:27:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/18] user: Declare cpu_loop() once in 'user/cpu_loop.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20241212185341.2857-1-philmd@linaro.org>
 <20241212185341.2857-18-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241212185341.2857-18-philmd@linaro.org>
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

T24gMTIvMTIvMjQgMTA6NTMsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPiBE
ZWNsYXJlIGNwdV9sb29wKCkgb25jZSBpbiAidXNlci9jcHVfbG9vcC5oIi4NCj4gYnNkLXVz
ZXIgZ2V0cyB0aGUgR19OT1JFVFVSTiBhdHRyaWJ1dGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+IC0tLQ0K
PiAgIGJzZC11c2VyL3FlbXUuaCAgICAgICAgICAgICB8IDIgKy0NCj4gICBpbmNsdWRlL3Vz
ZXIvY3B1X2xvb3AuaCAgICAgfCAyICsrDQo+ICAgbGludXgtdXNlci91c2VyLWludGVybmFs
cy5oIHwgMSAtDQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYnNkLXVzZXIvcWVtdS5oIGIvYnNkLXVz
ZXIvcWVtdS5oDQo+IGluZGV4IDA0ZmFlZTQ1OWRmLi4zZWFhMTRmM2Y1NiAxMDA2NDQNCj4g
LS0tIGEvYnNkLXVzZXIvcWVtdS5oDQo+ICsrKyBiL2JzZC11c2VyL3FlbXUuaA0KPiBAQCAt
MjYsNiArMjYsNyBAQA0KPiAgICNpbmNsdWRlICJleGVjL2V4ZWMtYWxsLmgiDQo+ICAgDQo+
ICAgI2luY2x1ZGUgInVzZXIvYWJpdHlwZXMuaCINCj4gKyNpbmNsdWRlICJ1c2VyL2NwdV9s
b29wLmgiDQo+ICAgI2luY2x1ZGUgInVzZXIvcGFnZS1wcm90ZWN0aW9uLmgiDQo+ICAgDQo+
ICAgZXh0ZXJuIGNoYXIgKiplbnZpcm9uOw0KPiBAQCAtMTg3LDcgKzE4OCw2IEBAIGFiaV9s
b25nIGRvX29wZW5ic2Rfc3lzY2FsbCh2b2lkICpjcHVfZW52LCBpbnQgbnVtLCBhYmlfbG9u
ZyBhcmcxLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhYmlfbG9uZyBhcmc1
LCBhYmlfbG9uZyBhcmc2KTsNCj4gICB2b2lkIGdlbXVfbG9nKGNvbnN0IGNoYXIgKmZtdCwg
Li4uKSBHX0dOVUNfUFJJTlRGKDEsIDIpOw0KPiAgIGV4dGVybiBfX3RocmVhZCBDUFVTdGF0
ZSAqdGhyZWFkX2NwdTsNCj4gLXZvaWQgY3B1X2xvb3AoQ1BVQXJjaFN0YXRlICplbnYpOw0K
PiAgIGNoYXIgKnRhcmdldF9zdHJlcnJvcihpbnQgZXJyKTsNCj4gICBpbnQgZ2V0X29zdmVy
c2lvbih2b2lkKTsNCj4gICB2b2lkIGZvcmtfc3RhcnQodm9pZCk7DQo+IGRpZmYgLS1naXQg
YS9pbmNsdWRlL3VzZXIvY3B1X2xvb3AuaCBiL2luY2x1ZGUvdXNlci9jcHVfbG9vcC5oDQo+
IGluZGV4IDhlMmRmMjMyNzU4Li5iMGQ0NzA0MDE4ZCAxMDA2NDQNCj4gLS0tIGEvaW5jbHVk
ZS91c2VyL2NwdV9sb29wLmgNCj4gKysrIGIvaW5jbHVkZS91c2VyL2NwdV9sb29wLmgNCj4g
QEAgLTIzLDYgKzIzLDggQEANCj4gICAjaW5jbHVkZSAiZXhlYy9sb2cuaCINCj4gICAjaW5j
bHVkZSAic3BlY2lhbC1lcnJuby5oIg0KPiAgIA0KPiArR19OT1JFVFVSTiB2b2lkIGNwdV9s
b29wKENQVUFyY2hTdGF0ZSAqZW52KTsNCj4gKw0KPiAgIHZvaWQgdGFyZ2V0X2V4Y2VwdGlv
bl9kdW1wKENQVUFyY2hTdGF0ZSAqZW52LCBjb25zdCBjaGFyICpmbXQsIGludCBjb2RlKTsN
Cj4gICAjZGVmaW5lIEVYQ1BfRFVNUChlbnYsIGZtdCwgY29kZSkgXA0KPiAgICAgICB0YXJn
ZXRfZXhjZXB0aW9uX2R1bXAoZW52LCBmbXQsIGNvZGUpDQo+IGRpZmYgLS1naXQgYS9saW51
eC11c2VyL3VzZXItaW50ZXJuYWxzLmggYi9saW51eC11c2VyL3VzZXItaW50ZXJuYWxzLmgN
Cj4gaW5kZXggNDZmZmMwOTNmNDAuLmI5YjA1YzFkMTFmIDEwMDY0NA0KPiAtLS0gYS9saW51
eC11c2VyL3VzZXItaW50ZXJuYWxzLmgNCj4gKysrIGIvbGludXgtdXNlci91c2VyLWludGVy
bmFscy5oDQo+IEBAIC02NSw3ICs2NSw2IEBAIGFiaV9sb25nIGRvX3N5c2NhbGwoQ1BVQXJj
aFN0YXRlICpjcHVfZW52LCBpbnQgbnVtLCBhYmlfbG9uZyBhcmcxLA0KPiAgICAgICAgICAg
ICAgICAgICAgICAgYWJpX2xvbmcgYXJnNSwgYWJpX2xvbmcgYXJnNiwgYWJpX2xvbmcgYXJn
NywNCj4gICAgICAgICAgICAgICAgICAgICAgIGFiaV9sb25nIGFyZzgpOw0KPiAgIGV4dGVy
biBfX3RocmVhZCBDUFVTdGF0ZSAqdGhyZWFkX2NwdTsNCj4gLUdfTk9SRVRVUk4gdm9pZCBj
cHVfbG9vcChDUFVBcmNoU3RhdGUgKmVudik7DQo+ICAgYWJpX2xvbmcgZ2V0X2Vycm5vKGFi
aV9sb25nIHJldCk7DQo+ICAgY29uc3QgY2hhciAqdGFyZ2V0X3N0cmVycm9yKGludCBlcnIp
Ow0KPiAgIGludCBnZXRfb3N2ZXJzaW9uKHZvaWQpOw0KDQpSZXZpZXdlZC1ieTogUGllcnJp
Y2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0KDQo=

