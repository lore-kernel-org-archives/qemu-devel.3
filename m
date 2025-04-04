Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57DDC3601A
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 17:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0kZp-0002hZ-Q6; Fri, 04 Apr 2025 13:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0kZM-0002OZ-EI
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:11:13 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0kZJ-0005om-UU
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:11:04 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3014cb646ecso1657499a91.1
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 10:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743786660; x=1744391460; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rPc/MCa8AVhqjTQuOvmlBjYQr2O+5Yx/zGm14QeeZZY=;
 b=nLD3/Am92l9A2s2uDvSmGfmXQWiH6c7yJLq3SyBoeFVHU2+BjilRrvpoxmOG2fYPtF
 jGMUr4H+dh1YBI9dFA/k99po0rQTpKH6fzcVZoVt2lq5HyOr7Nd18nsazbznAbJzkWOg
 pSRxtjQP2zcEy//l4eNTNkr1mKAzqwPf1gNCxnY2uYjbBc9KN3mTDs7MLgdjqreUUCE7
 zjFTT0MUuB64MVA/rky/xrZZvFtHYyIw2hieXQVLuzUjgaP3LWAfOpQyN9H6ZDqM3ON8
 NZ5JzkAMj8wlzCp7J0nR2CbigIMy5zzQiV6CihRUPGOnVclW10qCGn91r3i97m23DmAB
 D/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743786660; x=1744391460;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rPc/MCa8AVhqjTQuOvmlBjYQr2O+5Yx/zGm14QeeZZY=;
 b=VfRxzXUsbhhfndb3km94iYmfh1dYYYd64CpkQp71+rmdvrc6PU71dEDalgabOuTcAA
 zIHM7989YMIeeEvfDZj14pvLsoRSI7DvIl65zU82HhbEh69bY3++xvzMvdr34Ngug8vr
 V9Cr7/IEfuHpCkfKS/0B9c7wNbjLb2fsn1CHsxZ37MNTWhl+h//YPoLeG0148WHS5vHC
 fK1bFvXCu20aVjIPUa8fJm0WFGHwnGeh8PkVY2OBD5+OTjxk02E05SS2CGPrgUr/poAz
 VRD9+MgVCYIsuz+SMaiG42RVTF1EX0Zrppn42E5UWRtXsi9qtXk3KDsop4Sra35SGOp3
 IiFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWke9juEmi2xXCCM25ALL7NMEBsvz87cAAEgGhPR/AagcWmYrjALZf9OB0xbDgPW+1bVoQZ1jRQb5iz@nongnu.org
X-Gm-Message-State: AOJu0Yx6m+hD51PyofG30V8CFQ5SaXsN6agSk3jErJ3lE8gcrDLGaS1H
 zDhD7FhqHpoRx35k6vKo6lmaKLHFlNBno9dkET0uKAxROKbIi2c2AXs9mnaBOQs=
X-Gm-Gg: ASbGncs/85OhMcuiiQ8hpVcFiR/IT957RclVBa9iH5OP41Vry/7JWVQ9quY2FceEgg0
 xNRPGdFU7F1haCNNXJih/SLx5lIInwxZtR0eVWIA74JUVhApsxCdK4hVz19614S5oEuJ5+3Wiv9
 W/WGtMvtWnIze5wCX/W35hO9cbox6P3Pnf2uxmmPYlDV0XGk1rOAxQuqmdiR8ZvHf/j09eKZ7sx
 yLfUoxcVorwhEPN2XnLHqCrHjtcnMQzdtN2eVUAuYVKocem7C/ThvULw6imFp32yoiMlG6kT+LR
 HbjMVjZpCL5qMn7TnYtxE6mILXrOtHHxbvfza6+mjUlZogydNhhr0qoHfFwVx1K2zLUK
X-Google-Smtp-Source: AGHT+IFRbGOF24Zt312ixS3JvitDIPjgHjhq7Ye5qBSvKPNRA12fjMTGX6E+nDmooOHsO8eJgpl42A==
X-Received: by 2002:a17:90b:2710:b0:2f9:9ddd:689b with SMTP id
 98e67ed59e1d1-306a48ff309mr5699104a91.22.1743786659943; 
 Fri, 04 Apr 2025 10:10:59 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3057ca498c6sm4357416a91.13.2025.04.04.10.10.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 10:10:59 -0700 (PDT)
Message-ID: <c0a07893-85ae-4f33-89af-51e3c94034fa@linaro.org>
Date: Fri, 4 Apr 2025 09:57:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 16/19] accel: Make AccelCPUClass structure
 target-agnostic
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250403234914.9154-1-philmd@linaro.org>
 <20250403234914.9154-17-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250403234914.9154-17-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1032.google.com
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

T24gNC8zLzI1IDE2OjQ5LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gSW5j
bHVkZSBtaXNzaW5nICJody9jb3JlL2NwdS5oIiBoZWFkZXIgaW4gImFjY2VsL2FjY2VsLWNw
dS5oIiB0byBhdm9pZDoNCj4gDQo+IGluY2x1ZGUvYWNjZWwvYWNjZWwtY3B1LXRhcmdldC5o
OjM5OjI4OiBlcnJvcjogdW5rbm93biB0eXBlIG5hbWUgJ0NQVUNsYXNzJw0KPiAgICAgMzkg
fCAgICAgdm9pZCAoKmNwdV9jbGFzc19pbml0KShDUFVDbGFzcyAqY2MpOw0KPiAgICAgICAg
fCAgICAgICAgICAgICAgICAgICAgICAgICAgICBeDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQ
aGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+IC0tLQ0KPiAg
IGluY2x1ZGUvYWNjZWwvYWNjZWwtY3B1LXRhcmdldC5oIHwgMTIgKy0tLS0tLS0tLS0tDQo+
ICAgaW5jbHVkZS9hY2NlbC9hY2NlbC1jcHUuaCAgICAgICAgfCAyMyArKysrKysrKysrKysr
KysrKysrKysrKw0KPiAgIGFjY2VsL2FjY2VsLXRhcmdldC5jICAgICAgICAgICAgIHwgIDEg
LQ0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25z
KC0pDQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvYWNjZWwvYWNjZWwtY3B1LmgN
Cj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2FjY2VsL2FjY2VsLWNwdS10YXJnZXQuaCBi
L2luY2x1ZGUvYWNjZWwvYWNjZWwtY3B1LXRhcmdldC5oDQo+IGluZGV4IDM3ZGRlN2ZhZTNl
Li42ZmViMzQ0ZTI5YiAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9hY2NlbC9hY2NlbC1jcHUt
dGFyZ2V0LmgNCj4gKysrIGIvaW5jbHVkZS9hY2NlbC9hY2NlbC1jcHUtdGFyZ2V0LmgNCj4g
QEAgLTIxLDIxICsyMSwxMSBAQA0KPiAgICAqLw0KPiAgIA0KPiAgICNpbmNsdWRlICJxb20v
b2JqZWN0LmgiDQo+ICsjaW5jbHVkZSAiYWNjZWwvYWNjZWwtY3B1LmgiDQo+ICAgI2luY2x1
ZGUgImNwdS5oIg0KPiAgIA0KPiAgICNkZWZpbmUgVFlQRV9BQ0NFTF9DUFUgImFjY2VsLSIg
Q1BVX1JFU09MVklOR19UWVBFDQo+ICAgI2RlZmluZSBBQ0NFTF9DUFVfTkFNRShuYW1lKSAo
bmFtZSAiLSIgVFlQRV9BQ0NFTF9DUFUpDQo+IC10eXBlZGVmIHN0cnVjdCBBY2NlbENQVUNs
YXNzIEFjY2VsQ1BVQ2xhc3M7DQo+ICAgREVDTEFSRV9DTEFTU19DSEVDS0VSUyhBY2NlbENQ
VUNsYXNzLCBBQ0NFTF9DUFUsIFRZUEVfQUNDRUxfQ1BVKQ0KPiAgIA0KPiAtdHlwZWRlZiBz
dHJ1Y3QgQWNjZWxDUFVDbGFzcyB7DQo+IC0gICAgLyo8IHByaXZhdGUgPiovDQo+IC0gICAg
T2JqZWN0Q2xhc3MgcGFyZW50X2NsYXNzOw0KPiAtICAgIC8qPCBwdWJsaWMgPiovDQo+IC0N
Cj4gLSAgICB2b2lkICgqY3B1X2NsYXNzX2luaXQpKENQVUNsYXNzICpjYyk7DQo+IC0gICAg
dm9pZCAoKmNwdV9pbnN0YW5jZV9pbml0KShDUFVTdGF0ZSAqY3B1KTsNCj4gLSAgICBib29s
ICgqY3B1X3RhcmdldF9yZWFsaXplKShDUFVTdGF0ZSAqY3B1LCBFcnJvciAqKmVycnApOw0K
PiAtfSBBY2NlbENQVUNsYXNzOw0KPiAtDQo+ICAgI2VuZGlmIC8qIEFDQ0VMX0NQVV9IICov
DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2FjY2VsL2FjY2VsLWNwdS5oIGIvaW5jbHVkZS9h
Y2NlbC9hY2NlbC1jcHUuaA0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAw
MDAwMDAwMC4uOWU3ZWVkZTdjM2MNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9pbmNsdWRl
L2FjY2VsL2FjY2VsLWNwdS5oDQo+IEBAIC0wLDAgKzEsMjMgQEANCj4gKy8qDQo+ICsgKiBB
Y2NlbGVyYXRvciBpbnRlcmZhY2UsIHNwZWNpYWxpemVzIENQVUNsYXNzDQo+ICsgKg0KPiAr
ICogQ29weXJpZ2h0IDIwMjEgU1VTRSBMTEMNCj4gKyAqDQo+ICsgKiBTUERYLUxpY2Vuc2Ut
SWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcg0KPiArICovDQo+ICsNCj4gKyNpZm5kZWYg
QUNDRUxfQ1BVX0gNCj4gKyNkZWZpbmUgQUNDRUxfQ1BVX0gNCj4gKw0KPiArI2luY2x1ZGUg
InFvbS9vYmplY3QuaCINCj4gKyNpbmNsdWRlICJody9jb3JlL2NwdS5oIg0KPiArDQo+ICt0
eXBlZGVmIHN0cnVjdCBBY2NlbENQVUNsYXNzIHsNCj4gKyAgICBPYmplY3RDbGFzcyBwYXJl
bnRfY2xhc3M7DQo+ICsNCj4gKyAgICB2b2lkICgqY3B1X2NsYXNzX2luaXQpKENQVUNsYXNz
ICpjYyk7DQo+ICsgICAgdm9pZCAoKmNwdV9pbnN0YW5jZV9pbml0KShDUFVTdGF0ZSAqY3B1
KTsNCj4gKyAgICBib29sICgqY3B1X3RhcmdldF9yZWFsaXplKShDUFVTdGF0ZSAqY3B1LCBF
cnJvciAqKmVycnApOw0KPiArfSBBY2NlbENQVUNsYXNzOw0KPiArDQo+ICsjZW5kaWYgLyog
QUNDRUxfQ1BVX0ggKi8NCj4gZGlmZiAtLWdpdCBhL2FjY2VsL2FjY2VsLXRhcmdldC5jIGIv
YWNjZWwvYWNjZWwtdGFyZ2V0LmMNCj4gaW5kZXggNmZhNWMzZWYwNGUuLjc2OWE5MDIzMGJm
IDEwMDY0NA0KPiAtLS0gYS9hY2NlbC9hY2NlbC10YXJnZXQuYw0KPiArKysgYi9hY2NlbC9h
Y2NlbC10YXJnZXQuYw0KPiBAQCAtMjcsNyArMjcsNiBAQA0KPiAgICNpbmNsdWRlICJxZW11
L2FjY2VsLmgiDQo+ICAgI2luY2x1ZGUgInFlbXUvdGFyZ2V0X2luZm8uaCINCj4gICANCj4g
LSNpbmNsdWRlICJjcHUuaCINCj4gICAjaW5jbHVkZSAiYWNjZWwvYWNjZWwtY3B1LXRhcmdl
dC5oIg0KPiAgICNpbmNsdWRlICJhY2NlbC1pbnRlcm5hbC5oIg0KPiAgIA0KDQpSZXZpZXdl
ZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0K
DQo=

