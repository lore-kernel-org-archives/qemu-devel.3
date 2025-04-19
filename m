Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 950B9C369AB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Apr 2025 01:17:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5wpF-0005kd-DU; Fri, 18 Apr 2025 21:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5wp8-0005jo-Gv
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 21:16:51 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5wp5-0003Xw-99
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 21:16:48 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-73bb647eb23so2024613b3a.0
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 18:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745025405; x=1745630205; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=evSCFhSpHW4Q4bdQ+uJG3WBQKCL31CAkZ+sVi+QjVe8=;
 b=LCjYA21cEJZuRK4EQZf9/A1HVWmT+EU0zALeW8eFsV13YAwNkC+hiSkHV82EbGszTS
 iyaBRVPXQCwONG6g6fjA0cMrU+sgEONmxDwqAdci/Rahl4LelqPE2aPZzW1XKICkqROE
 HEioyjoRCieJ7aLcPA6Zi83m9cJ8PKTLdVP/vo0th6c38jVQWvZwLpLGx3j5BglahliC
 8G3WCnP6xm9hF/y2D2RTwKV2dI5F4/VIJWFQTOYJzqheqggT+F0Pp3FSoJT/FdRu448t
 UMMADOLF4UDD7SH7Y9BgR7F7EcBzt8aP7T/1cpdEQrNqok14aelhYaCdrFuI3ThGSckd
 9G0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745025405; x=1745630205;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=evSCFhSpHW4Q4bdQ+uJG3WBQKCL31CAkZ+sVi+QjVe8=;
 b=CigVRly5IXjZmAkFrVYldsahWOPu5rnWWjihyP70P1+yUZ4XIjiVkrqH1agcLTrsH/
 aXwPxuHzTaySPDZeXJb0KmnpMx7kMjIsVuTRgZWfTp+0kuaqHdTzUT3Ss3p8MWly0ADJ
 L7d7a/Q6kGOibYLV7Vthgit/wdf2CiL6SG1zgTTSMDOCAtpfeprkfEP+hxkTVh7lAHr3
 FY/ugrBG89iGasnMjuF3r3TVmOmrQOmvVRWVzU4McuIbzRZFUe8IHKv+jyJS4TY0KAyG
 7qU7YyC8rB84ZaoOOVWfiqa2AjFntEEnVnboK0J4K/HFSFho7hOre+iI/3Ht3aYOXkxF
 y/MQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWMU0twhp2UGx6FDibW2SCkurU4GNhWLitDuNuW9+qUHcJ8xpu801ehUNwSaVRn6OiyODAIUSmTTlB@nongnu.org
X-Gm-Message-State: AOJu0YxnOsos8EZI6IENX6Spq2K22ABBxjphEuhITZicBxTBwKOtv9e0
 s7YaQEArpDC4L9tORp3rn7vbHBXAFy25EE7xuThMR7zuJZ3wdWN6M4pYg9hEsPw=
X-Gm-Gg: ASbGnctgF0YGxem2sXiy3VjIPSSD60W1NmB0Td65Bm0Ucc1t4F6mjdFejona8ZmeeIO
 /pPvuWyZ7LyckaC3EAyJ0QftZtba+54Az7+TmbkzP72Kj/xMbT28Hs6g6jbAWw7yBxZrZS0V7gy
 2XTgBLXZAP5OF6bNbSTgJ9bRdcCpEPABkRD+gR2dGIxux0RRYVLPa/zyVOCGmObNciMoTyc8zo4
 mgE2Mb5cw+q3kSKMfKG2/dBZ8dFkRV2LxRlM1PyO+fmFGmJZRkYpcDsWONYPevL2U6FDzE+QGke
 E7DYSJw0IBC57ckw3IGdhF2JcrcpxrM8ycYc6ww/AUhpel3CLkPYuA==
X-Google-Smtp-Source: AGHT+IGcRSBXOxtCRHvA49egIHw/QsA6o5+nfy1YIwrjqoL/lVq2rr/ThtSAP78UilnjXyma9pvewA==
X-Received: by 2002:a05:6a21:7887:b0:1f5:8f65:a6e6 with SMTP id
 adf61e73a8af0-203cbd20447mr6609039637.27.1745025404849; 
 Fri, 18 Apr 2025 18:16:44 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b0db13a41a2sm1944743a12.21.2025.04.18.18.16.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 18:16:44 -0700 (PDT)
Message-ID: <24588f0b-9661-409c-9883-b12266c95597@linaro.org>
Date: Fri, 18 Apr 2025 18:16:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 11/14] hw/core/machine: Allow dynamic registration
 of valid CPU types
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20250418172908.25147-1-philmd@linaro.org>
 <20250418172908.25147-12-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250418172908.25147-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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

T24gNC8xOC8yNSAxMDoyOSwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IEFk
ZCBNYWNoaW5lQ2xhc3M6OnZhbGlkX2NwdV90eXBlc19saXN0LCBhIGR5bmFtaWMgbGlzdCBv
ZiBzdHJpbmdzLg0KPiANCj4gQ1BVIHR5cGVzIGNhbiBiZSByZWdpc3RlcmVkIHdpdGggbWFj
aGluZV9jbGFzc19hZGRfdmFsaWRfY3B1X3R5cGUoKS4NCj4gDQo+IFN1Z2dlc3RlZC1ieTog
UGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+
DQo+IC0tLQ0KPiAgIGluY2x1ZGUvaHcvYm9hcmRzLmggfCAgOCArKysrKysrKw0KPiAgIGh3
L2NvcmUvbWFjaGluZS5jICAgfCAzMCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysN
Cj4gICAyIGZpbGVzIGNoYW5nZWQsIDM4IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL2h3L2JvYXJkcy5oIGIvaW5jbHVkZS9ody9ib2FyZHMuaA0KPiBpbmRl
eCAwMmY0M2FjNWQ0ZC4uNjQ3YTI5ZmYwNGQgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvaHcv
Ym9hcmRzLmgNCj4gKysrIGIvaW5jbHVkZS9ody9ib2FyZHMuaA0KPiBAQCAtNTYsNiArNTYs
MTMgQEAgdm9pZCBtYWNoaW5lX3NldF9jYWNoZV90b3BvX2xldmVsKE1hY2hpbmVTdGF0ZSAq
bXMsIENhY2hlTGV2ZWxBbmRUeXBlIGNhY2hlLA0KPiAgIGJvb2wgbWFjaGluZV9jaGVja19z
bXBfY2FjaGUoY29uc3QgTWFjaGluZVN0YXRlICptcywgRXJyb3IgKiplcnJwKTsNCj4gICB2
b2lkIG1hY2hpbmVfbWVtb3J5X2RldmljZXNfaW5pdChNYWNoaW5lU3RhdGUgKm1zLCBod2Fk
ZHIgYmFzZSwgdWludDY0X3Qgc2l6ZSk7DQo+ICAgDQo+ICsvKioNCj4gKyAqIG1hY2hpbmVf
Y2xhc3NfYWRkX3ZhbGlkX2NwdV90eXBlOiBBZGQgdHlwZSB0byBsaXN0IG9mIHZhbGlkIENQ
VXMNCj4gKyAqIEBtYzogTWFjaGluZSBjbGFzcw0KPiArICogQHR5cGU6IENQVSB0eXBlIHRv
IGFsbG93IChzaG91bGQgYmUgYSBzdWJ0eXBlIG9mIFRZUEVfQ1BVKQ0KPiArICovDQo+ICt2
b2lkIG1hY2hpbmVfY2xhc3NfYWRkX3ZhbGlkX2NwdV90eXBlKE1hY2hpbmVDbGFzcyAqbWMs
IGNvbnN0IGNoYXIgKnR5cGUpOw0KPiArDQo+ICAgLyoqDQo+ICAgICogbWFjaGluZV9jbGFz
c19hbGxvd19keW5hbWljX3N5c2J1c19kZXY6IEFkZCB0eXBlIHRvIGxpc3Qgb2YgdmFsaWQg
ZGV2aWNlcw0KPiAgICAqIEBtYzogTWFjaGluZSBjbGFzcw0KPiBAQCAtMzA2LDYgKzMxMyw3
IEBAIHN0cnVjdCBNYWNoaW5lQ2xhc3Mgew0KPiAgICAgICBib29sIGlnbm9yZV9tZW1vcnlf
dHJhbnNhY3Rpb25fZmFpbHVyZXM7DQo+ICAgICAgIGludCBudW1hX21lbV9hbGlnbl9zaGlm
dDsNCj4gICAgICAgY29uc3QgY2hhciAqIGNvbnN0ICp2YWxpZF9jcHVfdHlwZXM7DQo+ICsg
ICAgR0xpc3QgKnZhbGlkX2NwdV90eXBlc19saXN0Ow0KPiAgICAgICBzdHJMaXN0ICphbGxv
d2VkX2R5bmFtaWNfc3lzYnVzX2RldmljZXM7DQo+ICAgICAgIGJvb2wgYXV0b19lbmFibGVf
bnVtYV93aXRoX21lbWhwOw0KPiAgICAgICBib29sIGF1dG9fZW5hYmxlX251bWFfd2l0aF9t
ZW1kZXY7DQo+IGRpZmYgLS1naXQgYS9ody9jb3JlL21hY2hpbmUuYyBiL2h3L2NvcmUvbWFj
aGluZS5jDQo+IGluZGV4IGY1MmE0ZjIyNzNiLi5mZjI3ZDUzM2I1YyAxMDA2NDQNCj4gLS0t
IGEvaHcvY29yZS9tYWNoaW5lLmMNCj4gKysrIGIvaHcvY29yZS9tYWNoaW5lLmMNCj4gQEAg
LTE1MzgsNiArMTUzOCwxMiBAQCBjb25zdCBjaGFyICptYWNoaW5lX2NsYXNzX2RlZmF1bHRf
Y3B1X3R5cGUoTWFjaGluZUNsYXNzICptYykNCj4gICAgICAgcmV0dXJuIG1jLT5kZWZhdWx0
X2NwdV90eXBlOw0KPiAgIH0NCj4gICANCj4gK3ZvaWQgbWFjaGluZV9jbGFzc19hZGRfdmFs
aWRfY3B1X3R5cGUoTWFjaGluZUNsYXNzICptYywgY29uc3QgY2hhciAqdHlwZSkNCj4gK3sN
Cj4gKyAgICBtYy0+dmFsaWRfY3B1X3R5cGVzX2xpc3QgPSBnX2xpc3RfcHJlcGVuZChtYy0+
dmFsaWRfY3B1X3R5cGVzX2xpc3QsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgZ19zdHJkdXAodHlwZSkpOw0KPiArfQ0KPiArDQo+ICAgc3Rh
dGljIGJvb2wgaXNfY3B1X3R5cGVfc3VwcG9ydGVkKGNvbnN0IE1hY2hpbmVTdGF0ZSAqbWFj
aGluZSwgRXJyb3IgKiplcnJwKQ0KPiAgIHsNCj4gICAgICAgTWFjaGluZUNsYXNzICptYyA9
IE1BQ0hJTkVfR0VUX0NMQVNTKG1hY2hpbmUpOw0KPiBAQCAtMTU4MSw2ICsxNTg3LDMwIEBA
IHN0YXRpYyBib29sIGlzX2NwdV90eXBlX3N1cHBvcnRlZChjb25zdCBNYWNoaW5lU3RhdGUg
Km1hY2hpbmUsIEVycm9yICoqZXJycCkNCj4gICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7
DQo+ICAgICAgICAgICB9DQo+ICAgICAgIH0NCj4gKyAgICBpZiAobWMtPnZhbGlkX2NwdV90
eXBlc19saXN0KSB7DQo+ICsgICAgICAgIGJvb2wgdmFsaWQgPSBmYWxzZTsNCj4gKyAgICAg
ICAgdW5zaWduZWQgY291bnQgPSAwOw0KPiArICAgICAgICBHTGlzdCAqbDsNCj4gKw0KPiAr
ICAgICAgICBmb3IgKGwgPSBtYy0+dmFsaWRfY3B1X3R5cGVzX2xpc3Q7ICF2YWxpZCAmJiBs
ICE9IE5VTEw7IGwgPSBsLT5uZXh0KSB7DQo+ICsgICAgICAgICAgICB2YWxpZCB8PSAhIW9i
amVjdF9jbGFzc19keW5hbWljX2Nhc3Qob2MsIGwtPmRhdGEpOw0KPiArICAgICAgICAgICAg
Y291bnQrKzsNCj4gKyAgICAgICAgfQ0KPiArDQo+ICsgICAgICAgIGlmICghdmFsaWQpIHsN
Cj4gKyAgICAgICAgICAgIGdfYXV0b2ZyZWUgY2hhciAqcmVxdWVzdGVkID0gY3B1X21vZGVs
X2Zyb21fdHlwZShtYWNoaW5lLT5jcHVfdHlwZSk7DQo+ICsgICAgICAgICAgICBtYy0+dmFs
aWRfY3B1X3R5cGVzX2xpc3QgPSBnX2xpc3RfcmV2ZXJzZShtYy0+dmFsaWRfY3B1X3R5cGVz
X2xpc3QpOw0KPiArICAgICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiSW52YWxpZCBDUFUg
bW9kZWw6ICVzIiwgcmVxdWVzdGVkKTsNCj4gKyAgICAgICAgICAgIGVycm9yX2FwcGVuZF9o
aW50KGVycnAsICJUaGUgdmFsaWQgbW9kZWxzIGFyZTogIik7DQo+ICsgICAgICAgICAgICBm
b3IgKGwgPSBtYy0+dmFsaWRfY3B1X3R5cGVzX2xpc3Q7IGwgIT0gTlVMTDsgbCA9IGwtPm5l
eHQpIHsNCj4gKyAgICAgICAgICAgICAgICBnX2F1dG9mcmVlIGNoYXIgKm1vZGVsID0gY3B1
X21vZGVsX2Zyb21fdHlwZShsLT5kYXRhKTsNCj4gKyAgICAgICAgICAgICAgICBlcnJvcl9h
cHBlbmRfaGludChlcnJwLCAiJXMlcyIsIG1vZGVsLCAtLWNvdW50ID8gIiwgIiA6ICIiKTsN
Cj4gKyAgICAgICAgICAgIH0NCj4gKyAgICAgICAgICAgIGVycm9yX2FwcGVuZF9oaW50KGVy
cnAsICJcbiIpOw0KPiArDQo+ICsgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+ICsgICAg
ICAgIH0NCj4gKyAgICB9DQo+ICAgDQo+ICAgICAgIC8qIENoZWNrIGlmIENQVSB0eXBlIGlz
IGRlcHJlY2F0ZWQgYW5kIHdhcm4gaWYgc28gKi8NCj4gICAgICAgY2MgPSBDUFVfQ0xBU1Mo
b2MpOw0KDQpIb3cgYWJvdXQgc2ltcGx5IGNoYW5naW5nIHZhbGlkX2NwdV90eXBlcyB0byBi
ZWNvbWUgYSBmdW5jdGlvbiBpbnN0ZWFkIA0Kb2YgYSBzdGF0aWMgbGlzdD8NCg0KVGhpcyB3
YXksIGl0J3Mgc2ltcGxlIHRvIGdldCBsaXN0IG9mIGNwdXMsIGFuZCB0aGlzIGNoYW5nZSBp
cyBub3QgDQpuZWVkZWQuIFRoZSBhY3R1YWwgbGlzdCB3aWxsIGJlIGRlY2lkZWQgYXQgcnVu
dGltZSwgaW5zdGVhZCBvZiANCnN0YXRpY2FsbHksIHdoaWNoIHNvbHZlcyB0aGUgb3JpZ2lu
YWwgcHJvYmxlbS4NCkFzIHdlbGwsIHdlJ2xsIG5lZWQgaXQgdG8gYmUgYWJsZSB0byBoYW5k
bGUgYWNjZWxlcmF0b3Igc3BlY2lmaWMgY3B1cywgDQpzbyBpdCB3aWxsIGJlIGNoYW5nZWQg
ZXZlbnR1YWxseS4NCg==

