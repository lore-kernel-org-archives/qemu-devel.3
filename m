Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B951E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 19:23:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLom3-0007qT-7r; Thu, 12 Dec 2024 14:22:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tLolu-0007p9-IT
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 14:22:51 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tLols-0004mm-0k
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 14:22:49 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21680814d42so9032125ad.2
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 11:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734031366; x=1734636166; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CKia1quOLZ/+YPQDtCOZGnVbJyyuMmvPGCBwRnO2KX8=;
 b=t4Y7p7KjxQeCuDOOLTpmK9sLlFOVATXboXB6jjgnCjNy4e0cY5wWPurOTYrBgNU9eA
 e4n9tVU2kDZwR5z12KbZKarLwGCcv30B8ZJc0qgDRAozThOQvwy34a5fpOZ+eWVikFa4
 LoZlde7ZxLnmPK0oppKQVGuelkZEJ8/Z73GscV+SVr9jadwj2OiMk+dK5q/hdqUmf7Ud
 mecykSfFJorfAeJtM3PdWlDETy7h4J1KGqeYuZtEdqrXg+8LGj5jdOwwcEVazNfA2gDj
 z4QrjNQgs9c6vD1RwWk28/wBHIj2FoblcQfWP7dz2GreC2dsrT5o1+/yHXq2nQ4T/Mec
 eXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734031366; x=1734636166;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CKia1quOLZ/+YPQDtCOZGnVbJyyuMmvPGCBwRnO2KX8=;
 b=lC1H8kXgoIMFYHUmzCl8JQsoAjQCK3Gq4iwlgChVBRiWHKY+zSqltzDskKTZKrhB7S
 5+FEZwfLPkvqxehKZa90u8XRaCUXObJtK02RHykfEywrZQQnMGqkVD8BnbKBHYou62O7
 /EV6PgMgNnxaE+yWecLWslnyQ8bJcbNbKoP7CJDntl0cL4v7h3gA6NhdsPmpLiVzL+Bv
 uvqxrGza3bb+Vs8yuZCWyMNbX/LzCA+rV4xoiRV8Y+vVn8rN03MXCEN2VoS8XVdC5lxY
 P/iTEVcBtkGQahyvtgSSHzk5aYT6YGRfewXVvz+Vwe1Xj1LwSKti3aMzwB37Fh/7R2cE
 QlpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtvi6nPA8B86qxXfyBZuDXg5HcskAow0Fk8DCPrcd62QozxTHoo9H9PmE5bSmgYS4rdV0jEwrHrQ84@nongnu.org
X-Gm-Message-State: AOJu0YxCbDYpA7qQOm49zSZ8wVXs5tXGXgo5Xz75zyU2G8Cz16Rd8+48
 0UpRsOnU3zdQzV5F3zqftLuHpprffoNtSTd+kwZ4ZCY5Yq96xS5B6VJcNM3NOJx2rykwAbds2Wx
 S4VA=
X-Gm-Gg: ASbGnctt+74Z+rrJqpAw1yeTSsbg+CfNAaHueRu/zxX/SZr3d81e/OMMoB6fi4roTs7
 mz1YTMekcfY/FAg7CHzH32rDU0JiGnu2KXL9QxzMmCgf2xGrSURugwRXVDgomQmrNxEZkwfaYCm
 sKkd2V8Hdz6i8X9N9vUGOUhXhmy78/H4vjYsXapNj8WJmvWcfuyAgmu9SvHQfCMmX8abyAxLme8
 bTjCaT9IMrW/QO46qX0nf1T8Jie4R+xzZAZZijpI1zJPVKywJo+oWS1TiMpfarMn6IzS772gYo1
 H+y4vCOQjh0pQM+Je/b0dgSRiKTE
X-Google-Smtp-Source: AGHT+IFGOMjuCxe3ZiEJ0d1LTeFSMo6ZP76j23G/kkRv2vTixqQs6vJKgF+lj+0pnmJK1qagZaDkuw==
X-Received: by 2002:a17:902:cf0a:b0:215:854c:a71a with SMTP id
 d9443c01a7336-21778532306mr128993915ad.34.1734031366321; 
 Thu, 12 Dec 2024 11:22:46 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fd4657a124sm7967593a12.2.2024.12.12.11.22.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 11:22:45 -0800 (PST)
Message-ID: <511c43ee-1424-47b2-858c-1f7f906d3657@linaro.org>
Date: Thu, 12 Dec 2024 11:22:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/18] accel/tcg: Declare mmap_[un]lock() in
 'exec/page-protection.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20241212185341.2857-1-philmd@linaro.org>
 <20241212185341.2857-5-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241212185341.2857-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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
b3ZlIG1tYXBfbG9jaygpLCBtbWFwX3VubG9jaygpIGRlY2xhcmF0aW9ucyBhbmQgdGhlDQo+
IFdJVEhfTU1BUF9MT0NLX0dVQVJEKCkgZGVmaW5pdGlvbiB0byAnZXhlYy9wYWdlLXByb3Rl
Y3Rpb24uaCcuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTD
qSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+IC0tLQ0KPiAgIGluY2x1ZGUvZXhlYy9leGVjLWFs
bC5oICAgICAgICB8IDE3IC0tLS0tLS0tLS0tLS0tLS0tDQo+ICAgaW5jbHVkZS9leGVjL3Bh
Z2UtcHJvdGVjdGlvbi5oIHwgMjQgKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAgYWNj
ZWwvdGNnL2NwdS1leGVjLmMgICAgICAgICAgIHwgIDEgKw0KPiAgIGFjY2VsL3RjZy90cmFu
c2xhdGUtYWxsLmMgICAgICB8ICAxICsNCj4gICBhY2NlbC90Y2cvd2F0Y2hwb2ludC5jICAg
ICAgICAgfCAgMSArDQo+ICAgbGludXgtdXNlci9mbGF0bG9hZC5jICAgICAgICAgIHwgIDEg
Kw0KPiAgIHRhcmdldC9hcm0vaGVscGVyLmMgICAgICAgICAgICB8ICAxICsNCj4gICA3IGZp
bGVzIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKyksIDE3IGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvZXhlYy9leGVjLWFsbC5oIGIvaW5jbHVkZS9leGVjL2V4
ZWMtYWxsLmgNCj4gaW5kZXggMmU0YzRjYzRiNDYuLmI1ZWE2MDdjZjQ1IDEwMDY0NA0KPiAt
LS0gYS9pbmNsdWRlL2V4ZWMvZXhlYy1hbGwuaA0KPiArKysgYi9pbmNsdWRlL2V4ZWMvZXhl
Yy1hbGwuaA0KPiBAQCAtMjcsNyArMjcsNiBAQA0KPiAgICNlbmRpZg0KPiAgICNpbmNsdWRl
ICJleGVjL21tdS1hY2Nlc3MtdHlwZS5oIg0KPiAgICNpbmNsdWRlICJleGVjL3RyYW5zbGF0
aW9uLWJsb2NrLmgiDQo+IC0jaW5jbHVkZSAicWVtdS9jbGFuZy10c2EuaCINCj4gICANCj4g
ICAvKioNCj4gICAgKiBjcHVfbG9vcF9leGl0X3JlcXVlc3RlZDoNCj4gQEAgLTUyMCwxOCAr
NTE5LDYgQEAgc3RhdGljIGlubGluZSB0Yl9wYWdlX2FkZHJfdCBnZXRfcGFnZV9hZGRyX2Nv
ZGUoQ1BVQXJjaFN0YXRlICplbnYsDQo+ICAgfQ0KPiAgIA0KPiAgICNpZiBkZWZpbmVkKENP
TkZJR19VU0VSX09OTFkpDQo+IC12b2lkIFRTQV9OT19UU0EgbW1hcF9sb2NrKHZvaWQpOw0K
PiAtdm9pZCBUU0FfTk9fVFNBIG1tYXBfdW5sb2NrKHZvaWQpOw0KPiAtYm9vbCBoYXZlX21t
YXBfbG9jayh2b2lkKTsNCj4gLQ0KPiAtc3RhdGljIGlubGluZSB2b2lkIG1tYXBfdW5sb2Nr
X2d1YXJkKHZvaWQgKnVudXNlZCkNCj4gLXsNCj4gLSAgICBtbWFwX3VubG9jaygpOw0KPiAt
fQ0KPiAtDQo+IC0jZGVmaW5lIFdJVEhfTU1BUF9MT0NLX0dVQVJEKCkgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4gLSAgICBmb3IgKGludCBfbW1h
cF9sb2NrX2l0ZXIgX19hdHRyaWJ1dGVfXygoY2xlYW51cChtbWFwX3VubG9ja19ndWFyZCkp
KSAgXA0KPiAtICAgICAgICAgPSAobW1hcF9sb2NrKCksIDApOyBfbW1hcF9sb2NrX2l0ZXIg
PT0gMDsgX21tYXBfbG9ja19pdGVyID0gMSkNCj4gICANCj4gICAvKioNCj4gICAgKiBhZGp1
c3Rfc2lnbmFsX3BjOg0KPiBAQCAtNTg1LDEwICs1NzIsNiBAQCBHX05PUkVUVVJOIHZvaWQg
Y3B1X2xvb3BfZXhpdF9zaWdidXMoQ1BVU3RhdGUgKmNwdSwgdGFyZ2V0X3Vsb25nIGFkZHIs
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnRwdHJfdCBy
YSk7DQo+ICAgDQo+ICAgI2Vsc2UNCj4gLXN0YXRpYyBpbmxpbmUgdm9pZCBtbWFwX2xvY2so
dm9pZCkge30NCj4gLXN0YXRpYyBpbmxpbmUgdm9pZCBtbWFwX3VubG9jayh2b2lkKSB7fQ0K
PiAtI2RlZmluZSBXSVRIX01NQVBfTE9DS19HVUFSRCgpDQo+IC0NCj4gICB2b2lkIHRsYl9y
ZXNldF9kaXJ0eShDUFVTdGF0ZSAqY3B1LCByYW1fYWRkcl90IHN0YXJ0MSwgcmFtX2FkZHJf
dCBsZW5ndGgpOw0KPiAgIHZvaWQgdGxiX3Jlc2V0X2RpcnR5X3JhbmdlX2FsbChyYW1fYWRk
cl90IHN0YXJ0LCByYW1fYWRkcl90IGxlbmd0aCk7DQo+ICAgDQo+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL2V4ZWMvcGFnZS1wcm90ZWN0aW9uLmggYi9pbmNsdWRlL2V4ZWMvcGFnZS1wcm90
ZWN0aW9uLmgNCj4gaW5kZXggYzQzMjMxYWY4YjUuLmJhZTMzNTVmNjJjIDEwMDY0NA0KPiAt
LS0gYS9pbmNsdWRlL2V4ZWMvcGFnZS1wcm90ZWN0aW9uLmgNCj4gKysrIGIvaW5jbHVkZS9l
eGVjL3BhZ2UtcHJvdGVjdGlvbi5oDQo+IEBAIC0zOCw0ICszOCwyOCBAQA0KPiAgICAqLw0K
PiAgICNkZWZpbmUgUEFHRV9QQVNTVEhST1VHSCAweDA4MDANCj4gICANCj4gKyNpZmRlZiBD
T05GSUdfVVNFUl9PTkxZDQo+ICsNCj4gKyNpbmNsdWRlICJxZW11L2NsYW5nLXRzYS5oIg0K
PiArDQo+ICt2b2lkIFRTQV9OT19UU0EgbW1hcF9sb2NrKHZvaWQpOw0KPiArdm9pZCBUU0Ff
Tk9fVFNBIG1tYXBfdW5sb2NrKHZvaWQpOw0KPiArYm9vbCBoYXZlX21tYXBfbG9jayh2b2lk
KTsNCj4gKw0KPiArc3RhdGljIGlubGluZSB2b2lkIG1tYXBfdW5sb2NrX2d1YXJkKHZvaWQg
KnVudXNlZCkNCj4gK3sNCj4gKyAgICBtbWFwX3VubG9jaygpOw0KPiArfQ0KPiArDQo+ICsj
ZGVmaW5lIFdJVEhfTU1BUF9MT0NLX0dVQVJEKCkgXA0KPiArICAgIGZvciAoaW50IF9tbWFw
X2xvY2tfaXRlciBfX2F0dHJpYnV0ZV9fKChjbGVhbnVwKG1tYXBfdW5sb2NrX2d1YXJkKSkp
IFwNCj4gKyAgICAgICAgID0gKG1tYXBfbG9jaygpLCAwKTsgX21tYXBfbG9ja19pdGVyID09
IDA7IF9tbWFwX2xvY2tfaXRlciA9IDEpDQo+ICsjZWxzZQ0KPiArDQo+ICtzdGF0aWMgaW5s
aW5lIHZvaWQgbW1hcF9sb2NrKHZvaWQpIHt9DQo+ICtzdGF0aWMgaW5saW5lIHZvaWQgbW1h
cF91bmxvY2sodm9pZCkge30NCj4gKyNkZWZpbmUgV0lUSF9NTUFQX0xPQ0tfR1VBUkQoKQ0K
PiArDQo+ICsjZW5kaWYgLyogIUNPTkZJR19VU0VSX09OTFkgKi8NCj4gKw0KPiAgICNlbmRp
Zg0KPiBkaWZmIC0tZ2l0IGEvYWNjZWwvdGNnL2NwdS1leGVjLmMgYi9hY2NlbC90Y2cvY3B1
LWV4ZWMuYw0KPiBpbmRleCBjMTNmNGE3Y2JiZi4uZjgyODcwYTFlMmEgMTAwNjQ0DQo+IC0t
LSBhL2FjY2VsL3RjZy9jcHUtZXhlYy5jDQo+ICsrKyBiL2FjY2VsL3RjZy9jcHUtZXhlYy5j
DQo+IEBAIC0yNSw2ICsyNSw3IEBADQo+ICAgI2luY2x1ZGUgInRyYWNlLmgiDQo+ICAgI2lu
Y2x1ZGUgImRpc2FzL2Rpc2FzLmgiDQo+ICAgI2luY2x1ZGUgImV4ZWMvZXhlYy1hbGwuaCIN
Cj4gKyNpbmNsdWRlICJleGVjL3BhZ2UtcHJvdGVjdGlvbi5oIg0KPiAgICNpbmNsdWRlICJ0
Y2cvdGNnLmgiDQo+ICAgI2luY2x1ZGUgInFlbXUvYXRvbWljLmgiDQo+ICAgI2luY2x1ZGUg
InFlbXUvcmN1LmgiDQo+IGRpZmYgLS1naXQgYS9hY2NlbC90Y2cvdHJhbnNsYXRlLWFsbC5j
IGIvYWNjZWwvdGNnL3RyYW5zbGF0ZS1hbGwuYw0KPiBpbmRleCBhOGIyNGJlMGI5Ni4uZDU4
NmFjOWJiMWQgMTAwNjQ0DQo+IC0tLSBhL2FjY2VsL3RjZy90cmFuc2xhdGUtYWxsLmMNCj4g
KysrIGIvYWNjZWwvdGNnL3RyYW5zbGF0ZS1hbGwuYw0KPiBAQCAtNDQsNiArNDQsNyBAQA0K
PiAgICNlbmRpZg0KPiAgIA0KPiAgICNpbmNsdWRlICJleGVjL2NwdXRsYi5oIg0KPiArI2lu
Y2x1ZGUgImV4ZWMvcGFnZS1wcm90ZWN0aW9uLmgiDQo+ICAgI2luY2x1ZGUgImV4ZWMvdHJh
bnNsYXRlLWFsbC5oIg0KPiAgICNpbmNsdWRlICJleGVjL3RyYW5zbGF0b3IuaCINCj4gICAj
aW5jbHVkZSAiZXhlYy90Yi1mbHVzaC5oIg0KPiBkaWZmIC0tZ2l0IGEvYWNjZWwvdGNnL3dh
dGNocG9pbnQuYyBiL2FjY2VsL3RjZy93YXRjaHBvaW50LmMNCj4gaW5kZXggY2E2NDFlYjk1
Y2YuLjg5MjMzMDFiOGI4IDEwMDY0NA0KPiAtLS0gYS9hY2NlbC90Y2cvd2F0Y2hwb2ludC5j
DQo+ICsrKyBiL2FjY2VsL3RjZy93YXRjaHBvaW50LmMNCj4gQEAgLTIyLDYgKzIyLDcgQEAN
Cj4gICAjaW5jbHVkZSAicWVtdS9lcnJvci1yZXBvcnQuaCINCj4gICAjaW5jbHVkZSAiZXhl
Yy9leGVjLWFsbC5oIg0KPiAgICNpbmNsdWRlICJleGVjL3RyYW5zbGF0ZS1hbGwuaCINCj4g
KyNpbmNsdWRlICJleGVjL3BhZ2UtcHJvdGVjdGlvbi5oIg0KPiAgICNpbmNsdWRlICJzeXN0
ZW0vdGNnLmgiDQo+ICAgI2luY2x1ZGUgInN5c3RlbS9yZXBsYXkuaCINCj4gICAjaW5jbHVk
ZSAiaHcvY29yZS90Y2ctY3B1LW9wcy5oIg0KPiBkaWZmIC0tZ2l0IGEvbGludXgtdXNlci9m
bGF0bG9hZC5jIGIvbGludXgtdXNlci9mbGF0bG9hZC5jDQo+IGluZGV4IDBlNGJlNWJmNDRh
Li5kNWNiMTgzMGRkZiAxMDA2NDQNCj4gLS0tIGEvbGludXgtdXNlci9mbGF0bG9hZC5jDQo+
ICsrKyBiL2xpbnV4LXVzZXIvZmxhdGxvYWQuYw0KPiBAQCAtMzQsNiArMzQsNyBAQA0KPiAg
ICNpbmNsdWRlICJxZW11L29zZGVwLmgiDQo+ICAgDQo+ICAgI2luY2x1ZGUgInFlbXUuaCIN
Cj4gKyNpbmNsdWRlICJleGVjL3BhZ2UtcHJvdGVjdGlvbi5oIg0KPiAgICNpbmNsdWRlICJ1
c2VyLWludGVybmFscy5oIg0KPiAgICNpbmNsdWRlICJsb2FkZXIuaCINCj4gICAjaW5jbHVk
ZSAidXNlci1tbWFwLmgiDQo+IGRpZmYgLS1naXQgYS90YXJnZXQvYXJtL2hlbHBlci5jIGIv
dGFyZ2V0L2FybS9oZWxwZXIuYw0KPiBpbmRleCA2M2ZlNGJhMzE4Yi4uYzM1Y2IwZjZhNTQg
MTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9hcm0vaGVscGVyLmMNCj4gKysrIGIvdGFyZ2V0L2Fy
bS9oZWxwZXIuYw0KPiBAQCAtMTMsNiArMTMsNyBAQA0KPiAgICNpbmNsdWRlICJpbnRlcm5h
bHMuaCINCj4gICAjaW5jbHVkZSAiY3B1LWZlYXR1cmVzLmgiDQo+ICAgI2luY2x1ZGUgImV4
ZWMvaGVscGVyLXByb3RvLmgiDQo+ICsjaW5jbHVkZSAiZXhlYy9wYWdlLXByb3RlY3Rpb24u
aCINCj4gICAjaW5jbHVkZSAicWVtdS9tYWluLWxvb3AuaCINCj4gICAjaW5jbHVkZSAicWVt
dS90aW1lci5oIg0KPiAgICNpbmNsdWRlICJxZW11L2JpdG9wcy5oIg0KDQpSZXZpZXdlZC1i
eTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0KDQo=


