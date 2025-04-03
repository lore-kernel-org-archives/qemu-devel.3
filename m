Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E120C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 18:11:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0P25-0008Vz-GV; Thu, 03 Apr 2025 14:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0P1p-0008TP-3z
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 14:11:02 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0P1n-00083N-7X
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 14:11:00 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2240b4de12bso18287715ad.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 11:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743703857; x=1744308657; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sFuWA1Pi4yJxbUpXTT7NhlD+VJizUaRWXMfFweYfZ4A=;
 b=LS0UF76W79xc4vszTo0ql5Go2WDMVe5oj8cmrwI2CG6aTaPl+BJM6KXcU53i7fc5ec
 fxRaezNxY4Bn/GwWF4OBbXq3sdSVF8aOm880i0NWB/GWDyGM0h6kptUZTHyvMEhG99wf
 tFC5v80NvS+oj1o3JE9HFZdp26JlrW2X0IEnxXfFb+QXE+HxJwyPCFwprZRSB3uzU73t
 3EoB9lmwkPSiYnxC3RRoT9+fSG5VyggwC/stBbkIfcmmpEOCQSev2LZv0g5lrO2Wypw+
 3Vwkzitz4j/w7ofHm2D6NHIBXlAmaxvPrTyO0R3CbiwSwhEC4c83ZN7ZBu1RU16/eV0F
 qacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743703857; x=1744308657;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sFuWA1Pi4yJxbUpXTT7NhlD+VJizUaRWXMfFweYfZ4A=;
 b=j8zGesOSHYdr6K0lfxpfIB41Ry127xnnow/IPCpqMrhDe/d49vySDL0DTC9d6itPX3
 9cbVlm9IKLEOXf2vG78f48BkvhMu6X772/0FamieSvzxisly0MVe49st+wSeLW/FD7XR
 NM+4i0WtXiyIFeksrPxpL/0Vaky2oqUOzjIusCD/s6J/xilzmPncF8SV1mlM1lGq7r3f
 0df7a9KqDMyt64sVfSd6nqr1uJulkIPquYvfaNsgRO4d+G+ruY2zKkkzs4yXvuTnBusb
 6NkBBkLcPW9y23aJY31m5c/dlQ0JRjzwSH1oubz/gkqePppjIyv5GsqaL7+EPvqoHJ/I
 BIsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcpmv2pPXoVB4rio5DDtkBCSwdxEj4JMOWW77qB0/8Q1FhR+E2Qzmhn6kgwujq5xB2eOGDymCzgFbn@nongnu.org
X-Gm-Message-State: AOJu0Yy2wq7Ss/c55sRIEj4+ZhFaDFiKI5qcRPO2/RZzOuo2k75fa2JE
 s/UaHzph533DZYwpwPKG7Du1RYI9dRbsJDG7FuaAHAspbmjyfcOADdpzjSgXUio=
X-Gm-Gg: ASbGnctFrIdkMEhVF3XV4rItoYy6F2K3xisOpNCu9nz3TBytniucYnErNoFeeYpfeVK
 jogrgsvdoJ+4uxJ44woUmTWaWiYCYDPxMjOYix2rsOMNd2RNlzE/4a/Cim6vhNT8DaGKvhRrBeg
 HtdYlxGE1sH7oJ1voCjSUDopSUg429ZbQns1cNxIM4KNHr9WJDcMzdLtXfiisRzMmy4VQULqbHV
 5R6rvgTmwebcmvYhPbvpx8s2Vf9Xfpsvh17MuZzsp9AXRx8W6aUVGt6teMiAk8fIRx5HPShgR76
 SkP7hbwIe//YNviprGFeHZVRGP7UDgahI/uRaiA35sQqfZy8NziG2ig2qw==
X-Google-Smtp-Source: AGHT+IFeI3mRQyM8XLix8Ruxw8mRekAOGrAd0bQfB2m5jFOPp29ywAdKUV/8Q9GUh7qadNo6kpAE1w==
X-Received: by 2002:a17:902:d2c3:b0:220:e023:8fa6 with SMTP id
 d9443c01a7336-22a8a0b413dmr897675ad.50.1743703857027; 
 Thu, 03 Apr 2025 11:10:57 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af9bc330489sm1519898a12.32.2025.04.03.11.10.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 11:10:56 -0700 (PDT)
Message-ID: <3e3ed3bc-1271-4cea-b46e-73fafd492285@linaro.org>
Date: Thu, 3 Apr 2025 11:10:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] accel/tcg: add get_virtual_clock for TCG
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Burton <mburton@qti.qualcomm.com>,
 Alwalid Salama <asalama@qti.qualcomm.com>, Laurent Vivier
 <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20250403113851.4182190-1-alex.bennee@linaro.org>
 <20250403113851.4182190-2-alex.bennee@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250403113851.4182190-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

T24gNC8zLzI1IDA0OjM4LCBBbGV4IEJlbm7DqWUgd3JvdGU6DQo+IFJhdGhlciB0aGFuIGFs
bG93aW5nIGNwdXNfZ2V0X3ZpcnR1YWxfY2xvY2soKSB0byBmYWxsIHRocm91Z2ggdG8NCj4g
Y3B1X2dldF9jbG9jaygpIGludHJvZHVjZSBhIFRDRyBoYW5kbGVyIHNvIGl0IGNhbiBtYWtl
IGEgZGVjaXNpb24NCj4gYWJvdXQgd2hhdCB0aW1lIGl0IGlzLg0KPiANCj4gSW5pdGlhbGx5
IHRoaXMganVzdCBjYWxscyBjcHVfZ2V0X2Nsb2NrKCkgYXMgYmVmb3JlIGJ1dCB0aGlzIHdp
bGwNCj4gY2hhbmdlIGluIGxhdGVyIGNvbW1pdHMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBB
bGV4IEJlbm7DqWUgPGFsZXguYmVubmVlQGxpbmFyby5vcmc+DQo+IC0tLQ0KPiAgIGFjY2Vs
L3RjZy90Y2ctYWNjZWwtb3BzLmMgfCA2ICsrKysrKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA2
IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9hY2NlbC90Y2cvdGNnLWFjY2Vs
LW9wcy5jIGIvYWNjZWwvdGNnL3RjZy1hY2NlbC1vcHMuYw0KPiBpbmRleCBkOWI2NjJlZmUz
Li4xNDMyZDFjNWIxIDEwMDY0NA0KPiAtLS0gYS9hY2NlbC90Y2cvdGNnLWFjY2VsLW9wcy5j
DQo+ICsrKyBiL2FjY2VsL3RjZy90Y2ctYWNjZWwtb3BzLmMNCj4gQEAgLTE5Nyw2ICsxOTcs
MTEgQEAgc3RhdGljIGlubGluZSB2b2lkIHRjZ19yZW1vdmVfYWxsX2JyZWFrcG9pbnRzKENQ
VVN0YXRlICpjcHUpDQo+ICAgICAgIGNwdV93YXRjaHBvaW50X3JlbW92ZV9hbGwoY3B1LCBC
UF9HREIpOw0KPiAgIH0NCj4gICANCj4gK3N0YXRpYyBpbnQ2NF90IHRjZ19nZXRfdmlydHVh
bF9jbG9jayh2b2lkKQ0KPiArew0KPiArICAgIHJldHVybiBjcHVfZ2V0X2Nsb2NrKCk7DQo+
ICt9DQo+ICsNCj4gICBzdGF0aWMgdm9pZCB0Y2dfYWNjZWxfb3BzX2luaXQoQWNjZWxPcHND
bGFzcyAqb3BzKQ0KPiAgIHsNCj4gICAgICAgaWYgKHFlbXVfdGNnX210dGNnX2VuYWJsZWQo
KSkgew0KPiBAQCAtMjEyLDYgKzIxNyw3IEBAIHN0YXRpYyB2b2lkIHRjZ19hY2NlbF9vcHNf
aW5pdChBY2NlbE9wc0NsYXNzICpvcHMpDQo+ICAgICAgICAgICAgICAgb3BzLT5nZXRfdmly
dHVhbF9jbG9jayA9IGljb3VudF9nZXQ7DQo+ICAgICAgICAgICAgICAgb3BzLT5nZXRfZWxh
cHNlZF90aWNrcyA9IGljb3VudF9nZXQ7DQo+ICAgICAgICAgICB9IGVsc2Ugew0KPiArICAg
ICAgICAgICAgb3BzLT5nZXRfdmlydHVhbF9jbG9jayA9IHRjZ19nZXRfdmlydHVhbF9jbG9j
azsNCj4gICAgICAgICAgICAgICBvcHMtPmhhbmRsZV9pbnRlcnJ1cHQgPSB0Y2dfaGFuZGxl
X2ludGVycnVwdDsNCj4gICAgICAgICAgIH0NCj4gICAgICAgfQ0KDQpSZXZpZXdlZC1ieTog
UGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0KDQo=

