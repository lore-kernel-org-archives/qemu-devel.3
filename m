Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14FA1E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 19:24:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLonX-0000gN-Ek; Thu, 12 Dec 2024 14:24:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tLonO-0000fy-W2
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 14:24:24 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tLonK-0004s8-Kn
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 14:24:22 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-728ea1573c0so878197b3a.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 11:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734031456; x=1734636256; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fcnrF6x20Hr18VP6Q9DwgomhZf0cb3WPi2ptDodkd8M=;
 b=bHjcd+oh2RHhpnt8C3WZZ7fKQi0NWEf3h6Gc/M7uYsAe75QA/tuKHK67AUb72NgVu2
 Qx2Ict/a1ACl1JhCzovb+xr+v8GbdMnLGwQSkH+osqMvOYGFxtDmE2pIaN+urqb/dJFM
 VGUdbY7gdC4oHQGiAGVmviAXVJsafAWxsnS9goZwJRsUvctGrazofWIXKAw23YALd5O4
 4+ipxyi5mJgla4pbbC2Awa1b7T2vINuOB1AF2Bndr3u0JwvPtI4cb4q7g9+180g9bmSF
 rTD0aCeZ5zbgiOjBrZ7Hc3GdH67ocD+BqT0ZbIvrW+GpQK9r95TDKMXeDdmrCVO7jjzi
 5PKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734031456; x=1734636256;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fcnrF6x20Hr18VP6Q9DwgomhZf0cb3WPi2ptDodkd8M=;
 b=e46bwT2IrppleP/CKznk1GS/IfZHBAtWRqYcf1qLBJpCqqN5X1btYv/hxzyvq//Fcs
 4WV0djjIHTEu6xXbvbGo0y38Lm1Q96cA2JkLhnG6Ww3GWROtxi3hIISMo2qyFZuWcS+4
 LwnXF2aYzWhQP56K1KHLx5suHBRXn5KxLISWuzek3AKD3FEixY9evj8a5Nxs1WYgfgCY
 CAmpq7PuWuiNRht2mmGLYceBcyeycJFTjYaCdu8IWGXcPdRAXltfDboiWXNlUf7htdvK
 2JqxvozDi/7YjjHppQ2ke3K8nM2grUbws6y7y6T/VCkv5D/6UMuHGmIrBqRptJaFmggd
 RaKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXYO+KxfZpVO5o4+Pye7A3oXQnabXJe7AmgvfF2ZTjiDQAM4Lne8P19QDMxIt7lMVpGFT8xdDjDtZ2@nongnu.org
X-Gm-Message-State: AOJu0YycVzjoXW35QZvfgawc9VmFgLFzXpTLqiQ7u/90gq5XbPeiVmjI
 sp7sehIYHI3hY3OtHYlhuaVoraY3psW4VxGAUsfBRiw50Nlo3x88Qlg6plxRgEc=
X-Gm-Gg: ASbGncur7g37cHMyG42Iz/bFhf0ASuM5/Mw1UBT4V+MrB1E1UIX9m8RTmh8Ntu/MCnT
 rBIRlAFmhqi2RwSgHKPv4k6RoqO5gyQ+hiZPoW6oIF+8w76a4YU5UvaHO2o7MVUgpvbOeZLV6fk
 DxHfAvj9Ga2X8o6Y4TN774wsLEOX884U63s4UY9SjAU6nZ8A1zF157by8nBSSFu3bmcfNavXTWP
 5aPJfnUZASGJPBd4oRyH3N/xFAtr29GfY03PRd+bFe1RLwOfddQW3LcfCmyvK91y6kY8atwIRQV
 iknwNmkRe+GVP/ma7N3NIFksFMy1
X-Google-Smtp-Source: AGHT+IF2MsEcHtfJsnbCdniHoa7VcAdQSTZcwAvqskX+aohsTDTPKNE8V6zPA5VQQH+cs1JPxEoQYw==
X-Received: by 2002:a05:6a00:17a1:b0:725:df1a:285 with SMTP id
 d2e1a72fcca58-729069ac008mr2002965b3a.12.1734031455842; 
 Thu, 12 Dec 2024 11:24:15 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72904a0b171sm773120b3a.172.2024.12.12.11.24.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 11:24:15 -0800 (PST)
Message-ID: <728eb888-20aa-4827-b2b6-c95811cf8ec9@linaro.org>
Date: Thu, 12 Dec 2024 11:24:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/18] accel/tcg: Use tb_page_addr_t type in
 page_unprotect()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20241212185341.2857-1-philmd@linaro.org>
 <20241212185341.2857-6-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241212185341.2857-6-philmd@linaro.org>
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

T24gMTIvMTIvMjQgMTA6NTMsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPiBN
YXRjaCB3aXRoIHRoZSBwYWdlX3Byb3RlY3QoKSBwcm90b3R5cGUsIHVzZSBhIHRiX3BhZ2Vf
YWRkcl90DQo+IGFyZ3VtZW50IGluc3RlYWQgb2YgdGFyZ2V0X3Vsb25nLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3Jn
Pg0KPiAtLS0NCj4gICBpbmNsdWRlL2V4ZWMvdHJhbnNsYXRlLWFsbC5oIHwgMiArLQ0KPiAg
IGFjY2VsL3RjZy91c2VyLWV4ZWMuYyAgICAgICAgfCAyICstDQo+ICAgMiBmaWxlcyBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9leGVjL3RyYW5zbGF0ZS1hbGwuaCBiL2luY2x1ZGUvZXhlYy90cmFuc2xh
dGUtYWxsLmgNCj4gaW5kZXggODVjOTQ2MGM3Y2EuLmM1MDY2MWEwNWQ1IDEwMDY0NA0KPiAt
LS0gYS9pbmNsdWRlL2V4ZWMvdHJhbnNsYXRlLWFsbC5oDQo+ICsrKyBiL2luY2x1ZGUvZXhl
Yy90cmFuc2xhdGUtYWxsLmgNCj4gQEAgLTI3LDcgKzI3LDcgQEAgdm9pZCB0Yl9jaGVja193
YXRjaHBvaW50KENQVVN0YXRlICpjcHUsIHVpbnRwdHJfdCByZXRhZGRyKTsNCj4gICANCj4g
ICAjaWZkZWYgQ09ORklHX1VTRVJfT05MWQ0KPiAgIHZvaWQgcGFnZV9wcm90ZWN0KHRiX3Bh
Z2VfYWRkcl90IHBhZ2VfYWRkcik7DQo+IC1pbnQgcGFnZV91bnByb3RlY3QodGFyZ2V0X3Vs
b25nIGFkZHJlc3MsIHVpbnRwdHJfdCBwYyk7DQo+ICtpbnQgcGFnZV91bnByb3RlY3QodGJf
cGFnZV9hZGRyX3QgYWRkcmVzcywgdWludHB0cl90IHBjKTsNCj4gICAjZW5kaWYNCj4gICAN
Cj4gICAjZW5kaWYgLyogVFJBTlNMQVRFX0FMTF9IICovDQo+IGRpZmYgLS1naXQgYS9hY2Nl
bC90Y2cvdXNlci1leGVjLmMgYi9hY2NlbC90Y2cvdXNlci1leGVjLmMNCj4gaW5kZXggMDYw
MTZlYjAzMDEuLjRlZDZkZDE5ZjMwIDEwMDY0NA0KPiAtLS0gYS9hY2NlbC90Y2cvdXNlci1l
eGVjLmMNCj4gKysrIGIvYWNjZWwvdGNnL3VzZXItZXhlYy5jDQo+IEBAIC02OTYsNyArNjk2
LDcgQEAgdm9pZCBwYWdlX3Byb3RlY3QodGJfcGFnZV9hZGRyX3QgYWRkcmVzcykNCj4gICAg
KiBpbW1lZGlhdGVseSBleGl0ZWQuIChXZSBjYW4gb25seSByZXR1cm4gMiBpZiB0aGUgJ3Bj
JyBhcmd1bWVudCBpcw0KPiAgICAqIG5vbi16ZXJvLikNCj4gICAgKi8NCj4gLWludCBwYWdl
X3VucHJvdGVjdCh0YXJnZXRfdWxvbmcgYWRkcmVzcywgdWludHB0cl90IHBjKQ0KPiAraW50
IHBhZ2VfdW5wcm90ZWN0KHRiX3BhZ2VfYWRkcl90IGFkZHJlc3MsIHVpbnRwdHJfdCBwYykN
Cj4gICB7DQo+ICAgICAgIFBhZ2VGbGFnc05vZGUgKnA7DQo+ICAgICAgIGJvb2wgY3VycmVu
dF90Yl9pbnZhbGlkYXRlZDsNCg0KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBp
ZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCg0K

