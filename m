Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F411DC36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 18:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0lmG-0004vd-Ck; Fri, 04 Apr 2025 14:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0lmE-0004vQ-4j
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 14:28:26 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0lmC-0000UR-0O
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 14:28:25 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-3035858c687so1819519a91.2
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 11:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743791300; x=1744396100; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Np1rrrGtmDUBc4AwZK//l8M2Vb0Jhhogj7kDQ41pqkM=;
 b=B33INrTFHoRV6JxTM2NHt1JWA7aSjiXsGtf89Lc6YG7Igb6tV/l+vaJprijxbcJQ6Z
 RGjIjn40/UQEaDT35rlcB9B+JIcBlE1O3DhN8Fpg2IhLtby7xwc2FzwCM7PjFPM1H0PP
 QfdRzqdI3OEQoLAAlTJBdMJVwdcsnWGBxho7ZN2tq3YIh+WEGzjOD8w+XdX3s5MaHrIU
 7+qIeUlRLEyXgi05yTeTsK/Eu1FBO0eObHaC1X2VD8A6lOrz/chjbDM93AOVjfn8QOLp
 G7p/zYgmxpJQ23G9+3qktZCLrvEGpFkm2FeePjYyvuyymhLaVecnFIFWt2ON5hZQlS0S
 1+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743791300; x=1744396100;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Np1rrrGtmDUBc4AwZK//l8M2Vb0Jhhogj7kDQ41pqkM=;
 b=mq75/lyjqdXB5eUPnNpwvi/xZYb84gCT0IcQJDlxfa5PvvZ2Ud/D/64+QAbb/JItUv
 w+Msi9VtNGkL6/uNf7XbK6thvyVzZgctVGQ35VNx5qe7xe1pV61rYg+h8YjjXvAkScPm
 4WeTyZD/cnE0N7tO90pme5qbc1faI0pmkFDc6RlmdCJn59bucoKAOMIMwCD4Fo91xIrX
 +InAHkBwe2PS7GjAYAzIDKSKrG/f5a1mGzb39N8FZnLE5YVsCGnbPsSqNxp0rpKZoCvT
 NS13kn1TH0CW2O4ZPlENvye0VgPLLG3oF8QrMwHd2DQ6HfrWB12FV7ZRmvuKSwGhKRpk
 LJXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNAuCo4pATrm3oNfDP7ClgWrwDKTOmb2OtHkXlsbObj457YbjqB1/qApXbM4yj9EnMI6niN5lAO4rZ@nongnu.org
X-Gm-Message-State: AOJu0YzoxX6lXkqpJ6mXKU2W7U349V9TuhLoZVYaQ35BZ5CjG3W3VTcv
 +V8Ag6HMznwVm+Yqp/8c64pDSnKcvtNhsaGHkt+OsWdbz0e+9CVLryukf0MRpuM=
X-Gm-Gg: ASbGncufEpVO8/32x0d137FMVSzTO1vWR/eQqXcgwpss4EYrQ22wE/Wu9Nw94a2sD9L
 d/ktJPIUNO05kqDcvtY0+4ofiarrSuW/2bzqnwiP/ymm/NSHaR4/a/2j6gQRJbccMMbluWDay+o
 XavAxaKn2r5850VWXGF+JiYdgl39LZwj2y3emORXsE+Af9ttPAodm/3/Z42TJEIjokQm4Dxq4cF
 jg5QrtOC5hbsp87bfMAI91ch1bNS2MLyIMuiseVMczYVPl6QVOGVMDll2VQbrZ/2fYhgUMjFZPg
 M80AdZlqbe0NzkWSOMLR/V8zwz6bHnFq09VaPLg1upGoB7iaALPBYvFdUA==
X-Google-Smtp-Source: AGHT+IFXwb2nlFxZwaG9EfK96JCLWInVquvp5zsT07w5Txz5/4h93Esa48M5JtbLrBki41irBsQEGA==
X-Received: by 2002:a17:90b:258c:b0:2f9:c144:9d13 with SMTP id
 98e67ed59e1d1-306a61ee16fmr5377410a91.24.1743791299864; 
 Fri, 04 Apr 2025 11:28:19 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3058466dc0bsm3791925a91.15.2025.04.04.11.28.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 11:28:19 -0700 (PDT)
Message-ID: <bd789a1e-b72d-4a9d-8730-e35cd3b2ffd7@linaro.org>
Date: Fri, 4 Apr 2025 11:28:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 35/39] hw/arm/virt: Replace TARGET_AARCH64 ->
 target_long_bits()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20250403235821.9909-1-philmd@linaro.org>
 <20250403235821.9909-36-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250403235821.9909-36-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102b.google.com
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

T24gNC8zLzI1IDE2OjU4LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gUmVw
bGFjZSB0aGUgdGFyZ2V0LXNwZWNpZmljIFRBUkdFVF9BQVJDSDY0IGRlZmluaXRpb24NCj4g
YnkgYSBjYWxsIHRvIHRoZSBnZW5lcmljIHRhcmdldF9sb25nX2JpdHMoKSBoZWxwZXIuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxp
bmFyby5vcmc+DQo+IC0tLQ0KPiAgIGh3L2FybS92aXJ0LmMgfCAzMiArKysrKysrKysrKysr
KysrLS0tLS0tLS0tLS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25z
KCspLCAxNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ody9hcm0vdmlydC5j
IGIvaHcvYXJtL3ZpcnQuYw0KPiBpbmRleCBlMjQxZTcxZTFjMy4uYTAyMGYxYmQ1ODEgMTAw
NjQ0DQo+IC0tLSBhL2h3L2FybS92aXJ0LmMNCj4gKysrIGIvaHcvYXJtL3ZpcnQuYw0KPiBA
QCAtMzEzMywyNSArMzEzMywyNSBAQCBzdGF0aWMgdm9pZCB2aXJ0X21hY2hpbmVfY2xhc3Nf
aW5pdChPYmplY3RDbGFzcyAqb2MsIHZvaWQgKmRhdGEpDQo+ICAgI2lmZGVmIENPTkZJR19U
Q0cNCj4gICAgICAgbWFjaGluZV9jbGFzc19hZGRfdmFsaWRfY3B1X3R5cGUobWMsIEFSTV9D
UFVfVFlQRV9OQU1FKCJjb3J0ZXgtYTciKSk7DQo+ICAgICAgIG1hY2hpbmVfY2xhc3NfYWRk
X3ZhbGlkX2NwdV90eXBlKG1jLCBBUk1fQ1BVX1RZUEVfTkFNRSgiY29ydGV4LWExNSIpKTsN
Cj4gLSNpZmRlZiBUQVJHRVRfQUFSQ0g2NA0KPiAtICAgIG1hY2hpbmVfY2xhc3NfYWRkX3Zh
bGlkX2NwdV90eXBlKG1jLCBBUk1fQ1BVX1RZUEVfTkFNRSgiY29ydGV4LWEzNSIpKTsNCj4g
LSAgICBtYWNoaW5lX2NsYXNzX2FkZF92YWxpZF9jcHVfdHlwZShtYywgQVJNX0NQVV9UWVBF
X05BTUUoImNvcnRleC1hNTUiKSk7DQo+IC0gICAgbWFjaGluZV9jbGFzc19hZGRfdmFsaWRf
Y3B1X3R5cGUobWMsIEFSTV9DUFVfVFlQRV9OQU1FKCJjb3J0ZXgtYTcyIikpOw0KPiAtICAg
IG1hY2hpbmVfY2xhc3NfYWRkX3ZhbGlkX2NwdV90eXBlKG1jLCBBUk1fQ1BVX1RZUEVfTkFN
RSgiY29ydGV4LWE3NiIpKTsNCj4gLSAgICBtYWNoaW5lX2NsYXNzX2FkZF92YWxpZF9jcHVf
dHlwZShtYywgQVJNX0NQVV9UWVBFX05BTUUoImNvcnRleC1hNzEwIikpOw0KPiAtICAgIG1h
Y2hpbmVfY2xhc3NfYWRkX3ZhbGlkX2NwdV90eXBlKG1jLCBBUk1fQ1BVX1RZUEVfTkFNRSgi
YTY0ZngiKSk7DQo+IC0gICAgbWFjaGluZV9jbGFzc19hZGRfdmFsaWRfY3B1X3R5cGUobWMs
IEFSTV9DUFVfVFlQRV9OQU1FKCJuZW92ZXJzZS1uMSIpKTsNCj4gLSAgICBtYWNoaW5lX2Ns
YXNzX2FkZF92YWxpZF9jcHVfdHlwZShtYywgQVJNX0NQVV9UWVBFX05BTUUoIm5lb3ZlcnNl
LXYxIikpOw0KPiAtICAgIG1hY2hpbmVfY2xhc3NfYWRkX3ZhbGlkX2NwdV90eXBlKG1jLCBB
Uk1fQ1BVX1RZUEVfTkFNRSgibmVvdmVyc2UtbjIiKSk7DQo+IC0jZW5kaWYgLyogVEFSR0VU
X0FBUkNINjQgKi8NCj4gKyAgICBpZiAodGFyZ2V0X2xvbmdfYml0cygpID09IDY0KSB7DQoN
Ckkgd291bGQgcHJlZmVyIGlmIHdlIGludHJvZHVjZSBhIHRydWUgdGFyZ2V0X2FhcmNoNjQo
KSBmdW5jdGlvbiwgYW5kIA0KcHJvYmFibHkgdGhlIHNhbWUgZm9yIG90aGVyIGFyY2hpdGVj
dHVyZXMgd2hlbiBpdCB3aWxsIGJlIG5lZWRlZC4NCg0KSWYgd2Ugc3RhcnQgdXNpbmcgdGFy
Z2V0X2xvbmdfYml0cygpLCB3ZSBtaWdodCBlbmFibGUgc29tZXRoaW5nIGluIA0KY29tbW9u
IGNvZGUgdGhhdCB3ZSBhcmUgbm90IHN1cHBvc2VkIHRvIGRvLiBBbmQgaXQgd2lsbCBiZSBt
dWNoIGhhcmRlciANCnRvIGZpbmQgaXQgbGF0ZXIgd2hlbiB3ZSBkZWJ1ZyBoZXRlcm9nZW5l
bm91cyBlbXVsYXRpb24uDQoNCj4gKyAgICAgICAgbWFjaGluZV9jbGFzc19hZGRfdmFsaWRf
Y3B1X3R5cGUobWMsIEFSTV9DUFVfVFlQRV9OQU1FKCJjb3J0ZXgtYTM1IikpOw0KPiArICAg
ICAgICBtYWNoaW5lX2NsYXNzX2FkZF92YWxpZF9jcHVfdHlwZShtYywgQVJNX0NQVV9UWVBF
X05BTUUoImNvcnRleC1hNTUiKSk7DQo+ICsgICAgICAgIG1hY2hpbmVfY2xhc3NfYWRkX3Zh
bGlkX2NwdV90eXBlKG1jLCBBUk1fQ1BVX1RZUEVfTkFNRSgiY29ydGV4LWE3MiIpKTsNCj4g
KyAgICAgICAgbWFjaGluZV9jbGFzc19hZGRfdmFsaWRfY3B1X3R5cGUobWMsIEFSTV9DUFVf
VFlQRV9OQU1FKCJjb3J0ZXgtYTc2IikpOw0KPiArICAgICAgICBtYWNoaW5lX2NsYXNzX2Fk
ZF92YWxpZF9jcHVfdHlwZShtYywgQVJNX0NQVV9UWVBFX05BTUUoImNvcnRleC1hNzEwIikp
Ow0KPiArICAgICAgICBtYWNoaW5lX2NsYXNzX2FkZF92YWxpZF9jcHVfdHlwZShtYywgQVJN
X0NQVV9UWVBFX05BTUUoImE2NGZ4IikpOw0KPiArICAgICAgICBtYWNoaW5lX2NsYXNzX2Fk
ZF92YWxpZF9jcHVfdHlwZShtYywgQVJNX0NQVV9UWVBFX05BTUUoIm5lb3ZlcnNlLW4xIikp
Ow0KPiArICAgICAgICBtYWNoaW5lX2NsYXNzX2FkZF92YWxpZF9jcHVfdHlwZShtYywgQVJN
X0NQVV9UWVBFX05BTUUoIm5lb3ZlcnNlLXYxIikpOw0KPiArICAgICAgICBtYWNoaW5lX2Ns
YXNzX2FkZF92YWxpZF9jcHVfdHlwZShtYywgQVJNX0NQVV9UWVBFX05BTUUoIm5lb3ZlcnNl
LW4yIikpOw0KPiArICAgIH0NCj4gICAjZW5kaWYgLyogQ09ORklHX1RDRyAqLw0KPiAtI2lm
ZGVmIFRBUkdFVF9BQVJDSDY0DQo+IC0gICAgbWFjaGluZV9jbGFzc19hZGRfdmFsaWRfY3B1
X3R5cGUobWMsIEFSTV9DUFVfVFlQRV9OQU1FKCJjb3J0ZXgtYTUzIikpOw0KPiAtICAgIG1h
Y2hpbmVfY2xhc3NfYWRkX3ZhbGlkX2NwdV90eXBlKG1jLCBBUk1fQ1BVX1RZUEVfTkFNRSgi
Y29ydGV4LWE1NyIpKTsNCj4gKyAgICBpZiAodGFyZ2V0X2xvbmdfYml0cygpID09IDY0KSB7
DQo+ICsgICAgICAgIG1hY2hpbmVfY2xhc3NfYWRkX3ZhbGlkX2NwdV90eXBlKG1jLCBBUk1f
Q1BVX1RZUEVfTkFNRSgiY29ydGV4LWE1MyIpKTsNCj4gKyAgICAgICAgbWFjaGluZV9jbGFz
c19hZGRfdmFsaWRfY3B1X3R5cGUobWMsIEFSTV9DUFVfVFlQRV9OQU1FKCJjb3J0ZXgtYTU3
IikpOw0KPiAgICNpZiBkZWZpbmVkKENPTkZJR19LVk0pIHx8IGRlZmluZWQoQ09ORklHX0hW
RikNCj4gLSAgICBtYWNoaW5lX2NsYXNzX2FkZF92YWxpZF9jcHVfdHlwZShtYywgQVJNX0NQ
VV9UWVBFX05BTUUoImhvc3QiKSk7DQo+ICsgICAgICAgIG1hY2hpbmVfY2xhc3NfYWRkX3Zh
bGlkX2NwdV90eXBlKG1jLCBBUk1fQ1BVX1RZUEVfTkFNRSgiaG9zdCIpKTsNCj4gICAjZW5k
aWYgLyogQ09ORklHX0tWTSB8fCBDT05GSUdfSFZGICovDQo+IC0jZW5kaWYgLyogVEFSR0VU
X0FBUkNINjQgKi8NCj4gKyAgICB9DQo+ICAgICAgIG1hY2hpbmVfY2xhc3NfYWRkX3ZhbGlk
X2NwdV90eXBlKG1jLCBBUk1fQ1BVX1RZUEVfTkFNRSgibWF4IikpOw0KPiAgIA0KPiAgICAg
ICBtYy0+aW5pdCA9IG1hY2h2aXJ0X2luaXQ7DQoNCg==

