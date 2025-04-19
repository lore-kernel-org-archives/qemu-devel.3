Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD597C369AB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Apr 2025 00:59:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5wXq-00053j-2Y; Fri, 18 Apr 2025 20:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5wXk-00050q-DR
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 20:58:54 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5wXi-0001Oa-JC
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 20:58:52 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-739b3fe7ce8so2118138b3a.0
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 17:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745024329; x=1745629129; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yMUgBX97BA5gUjbIRik66Qq6B7w8Su8DopV5HeI3ufM=;
 b=rFLOIy6sZJk3Xwq4KZ+tLlwx9N3fDb2cvsPsS1F2iAyRHYrYkRwJOsULQvBCBzM89c
 4LXeGJWHSVZVMCRd2GftWj8jT6YH32mTuc9VgEayyv8AJfSMewqogiO/TI2RDq0gkm8y
 9s2CZ4d/9WWMZ2JhxCq3qfXFGxpIbg90k6FsbvQAb/kehvkPOZXF3rV1BaT6FmoxE//h
 lindEZNR3oDj7mCfKwxKbfwKn88/cp12k4nE8MXfuQ2ki1vr0oUwMlG8FgFyik9h/qnW
 OzyJT578dMB/jV0iaeK3N7/o+AFiqipxDXWzlSosJljORhCD3Q9qYt8pDBs6S+1VDdA1
 UUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745024329; x=1745629129;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yMUgBX97BA5gUjbIRik66Qq6B7w8Su8DopV5HeI3ufM=;
 b=t6XcfUQ9aeSm2icmdL6jtN2AtNAY4it0FTmD7HEjU3vqLsfteskcGPFrlCPF/V0wHf
 6OISe9UriFAfqd/+McNDuqbZblM7My2sI+2mK6z+H5/c/nd5RUOe+JtDH3nDtxw4eQ1t
 4fyWasY9HfwOPC9BtvbI0qr/v2/v1QJTLrmKv9Z+PhKidYzjzSAdvFcaWlzx40IyxJ3y
 ux9QxAUgYw8jwwsIZKU9DEVudQ6fk3ntBmpKLh9LiqIAa94KcM/JLM2OrpjnyP3nn1gQ
 pjzg4MDphh587Mg0zIIKE3hZzn3cZmCsWofC/ugBfz2JanoGanU+58WQF9acYz34gHs2
 2q4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWm33GwS00NCnl4uEhnYivZfA7SbBmK4VlkSTQrDC7P6kNJB4An/vBdAoW+JkLDfEJRPyqr5CMkEXxL@nongnu.org
X-Gm-Message-State: AOJu0Yws01uPz63DAwHF3i/tPFe/+jtatJDiER7iywkQfo9xZDq++Q9a
 AsEvSe08JROkZKW0fGqaIwKM+XkY5aKXtCrm3wadqYD5GSV81pg52Ta6npdrLcY=
X-Gm-Gg: ASbGncuK73WZHCWoVPEKW7V+QadICAXNhLww+RyOwiUjxAiU5JvIix7ptHG4xMBM9vu
 ONN6oGqWo4PfdQqQ6+xqJz+W4jtTVLWWquiM0rh3BGY0cEQ8vWscQalHKsg0ijNzipqJLvBldE9
 lT066WRYPRO8AtP6/XTrucSoTLP375RiOcIwjKXrR1ORRNAZHZnwyOp3NSqSjIs6YNTraSADLCq
 3SP7Ow7orh1OxGD3U1E82alZakoG4InEHemuiM5TxSUp3B1jHNR910xSU0NHX356aqsLaRpp+tZ
 FqMuylyPCU9IQSQaIodqYwUdLsjngMTGxTjE3pcrT8I21qCUTnstmA==
X-Google-Smtp-Source: AGHT+IHAfDoWslAQ+MiRdzlA9leS93PvvIZW8GqdRv2NGgAK6wjFVxwBhdSL2XOjSyhJP4be2bDczg==
X-Received: by 2002:aa7:9306:0:b0:736:d6da:8f9e with SMTP id
 d2e1a72fcca58-73dc119fb18mr5945299b3a.0.1745024328734; 
 Fri, 18 Apr 2025 17:58:48 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbf8e4a98sm2330898b3a.58.2025.04.18.17.58.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 17:58:48 -0700 (PDT)
Message-ID: <c75ed890-9a82-47b2-b5b7-7ea811125ba3@linaro.org>
Date: Fri, 18 Apr 2025 17:58:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 04/14] hw/arm: Register
 TYPE_TARGET_ARM/AARCH64_MACHINE QOM interfaces
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20250418172908.25147-1-philmd@linaro.org>
 <20250418172908.25147-5-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250418172908.25147-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

T24gNC8xOC8yNSAxMDoyOCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IERl
ZmluZSB0aGUgVFlQRV9UQVJHRVRfQVJNX01BQ0hJTkUgYW5kIFRZUEVfVEFSR0VUX0FBUkNI
NjRfTUFDSElORQ0KPiBRT00gaW50ZXJmYWNlIG5hbWVzIHRvIGFsbG93IG1hY2hpbmVzIHRv
IGltcGxlbWVudCB0aGVtLg0KPiANCj4gUmVnaXN0ZXIgdGhlc2UgaW50ZXJmYWNlcyBpbiBj
b21tb24gY29kZSBpbiB0YXJnZXRfaW5mby1xb20uYyB1c2VkDQo+IGJ5IGFsbCBiaW5hcmll
cyBiZWNhdXNlIFFPTSBpbnRlcmZhY2VzIG11c3QgYmUgcmVnaXN0ZXJlZCBiZWZvcmUNCj4g
YmVpbmcgY2hlY2tlZCAoc2VlIG5leHQgY29tbWl0IHdpdGggdGhlICdub25lJyBtYWNoaW5l
KS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGls
bWRAbGluYXJvLm9yZz4NCj4gLS0tDQo+ICAgaW5jbHVkZS9ody9hcm0vbWFjaGluZXMtcW9t
LmggfCAxOCArKysrKysrKysrKysrKysrKysNCj4gICB0YXJnZXRfaW5mby1xb20uYyAgICAg
ICAgICAgICB8ICA5ICsrKysrKysrKw0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMjcgaW5zZXJ0
aW9ucygrKQ0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2h3L2FybS9tYWNoaW5l
cy1xb20uaA0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvYXJtL21hY2hpbmVzLXFv
bS5oIGIvaW5jbHVkZS9ody9hcm0vbWFjaGluZXMtcW9tLmgNCj4gbmV3IGZpbGUgbW9kZSAx
MDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAuLmExNzIyNWY1ZjkyDQo+IC0tLSAvZGV2L251
bGwNCj4gKysrIGIvaW5jbHVkZS9ody9hcm0vbWFjaGluZXMtcW9tLmgNCj4gQEAgLTAsMCAr
MSwxOCBAQA0KPiArLyoNCj4gKyAqIFFPTSB0eXBlIGRlZmluaXRpb25zIGZvciBBUk0gLyBB
YXJjaDY0IG1hY2hpbmVzDQo+ICsgKg0KPiArICogIENvcHlyaWdodCAoYykgTGluYXJvDQo+
ICsgKg0KPiArICogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIN
Cj4gKyAqLw0KPiArDQo+ICsjaWZuZGVmIEhXX0FSTV9NQUNISU5FU19RT01fSA0KPiArI2Rl
ZmluZSBIV19BUk1fTUFDSElORVNfUU9NX0gNCj4gKw0KPiArI2RlZmluZSBUWVBFX1RBUkdF
VF9BUk1fTUFDSElORSBcDQo+ICsgICAgICAgICJ0YXJnZXQtaW5mby1hcm0tbWFjaGluZSIN
Cj4gKw0KPiArI2RlZmluZSBUWVBFX1RBUkdFVF9BQVJDSDY0X01BQ0hJTkUgXA0KPiArICAg
ICAgICAidGFyZ2V0LWluZm8tYWFyY2g2NC1tYWNoaW5lIg0KPiArDQo+ICsjZW5kaWYNCj4g
ZGlmZiAtLWdpdCBhL3RhcmdldF9pbmZvLXFvbS5jIGIvdGFyZ2V0X2luZm8tcW9tLmMNCj4g
aW5kZXggYTZmZDhmMWQ1YTMuLjdmZDU4ZDI0ODE4IDEwMDY0NA0KPiAtLS0gYS90YXJnZXRf
aW5mby1xb20uYw0KPiArKysgYi90YXJnZXRfaW5mby1xb20uYw0KPiBAQCAtOCw4ICs4LDE3
IEBADQo+ICAgDQo+ICAgI2luY2x1ZGUgInFlbXUvb3NkZXAuaCINCj4gICAjaW5jbHVkZSAi
cW9tL29iamVjdC5oIg0KPiArI2luY2x1ZGUgImh3L2FybS9tYWNoaW5lcy1xb20uaCINCj4g
ICANCj4gICBzdGF0aWMgY29uc3QgVHlwZUluZm8gdGFyZ2V0X2luZm9fdHlwZXNbXSA9IHsN
Cj4gKyAgICB7DQo+ICsgICAgICAgIC5uYW1lICAgICAgICAgICA9IFRZUEVfVEFSR0VUX0FS
TV9NQUNISU5FLA0KPiArICAgICAgICAucGFyZW50ICAgICAgICAgPSBUWVBFX0lOVEVSRkFD
RSwNCj4gKyAgICB9LA0KPiArICAgIHsNCj4gKyAgICAgICAgLm5hbWUgICAgICAgICAgID0g
VFlQRV9UQVJHRVRfQUFSQ0g2NF9NQUNISU5FLA0KPiArICAgICAgICAucGFyZW50ICAgICAg
ICAgPSBUWVBFX0lOVEVSRkFDRSwNCj4gKyAgICB9LA0KPiAgIH07DQo+ICAgDQo+ICAgREVG
SU5FX1RZUEVTKHRhcmdldF9pbmZvX3R5cGVzKQ0KDQpSZXZpZXdlZC1ieTogUGllcnJpY2sg
Qm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0KDQo=

