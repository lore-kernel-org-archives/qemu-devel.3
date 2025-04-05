Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B953C36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 01:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0s3N-0004Yz-04; Fri, 04 Apr 2025 21:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0s3K-0004Yj-JD
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 21:10:30 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0s3H-0000wf-Ry
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 21:10:29 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7376e311086so3549871b3a.3
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 18:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743815426; x=1744420226; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rjLsoqK2dQC491Za2iV7tQhsDHDea4VLl9kjPp6bM+w=;
 b=lOk6jsZmPuPlak35hs8ob9DbsRmI7vlyISaMZI4gmMgINJxdGa/hQeKcebI5XDxbT2
 F7k6xxbw11v5s5zd1wHBRUnjCJxKFRFDzMaXiUDqxrt2hT93y6vqdkUa15sT/1lMVJIc
 lToOVt7yWgkid6H5xZvFJVNcrpp8XzlTY7ScgaPDfr8i0wqea+880nEPg1I9JlZFycjt
 N9Is4843pnUEcGVuosQJX9r1P0xQdZLPXOub08Ofnfog7S7Q7lDP/xkdj07SzxqwhbfZ
 2DaTMhkLC0kgFImAZGTHnE/8pWVWFhBvkkKVk0H4frZVTuR2x/FauGG527fnhWqxVPAT
 rOIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743815426; x=1744420226;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rjLsoqK2dQC491Za2iV7tQhsDHDea4VLl9kjPp6bM+w=;
 b=MSG5a7AWnMYpXC0/dp8h2Un8S8fTNpMHnU43M1AL+mbKPyYmOF04hQ2sKj7TqPYjAO
 Nyjo9VrbKJQugTEaru/KkTzvYHZ4xyG9Fn8jnhQ2IpPQOVnN5xc2CvfZcjnpZWDcc2d1
 i8l2NNQHa/1VzhLIhR/bQV4X9wOUg/ZKurBA2wdHTCuB+2QDxelnOH+i1swpvlHTIK4M
 0B2qDMYx1sYVAmIdLFIh7b2lLUIhvIdIKYbesb0BGJ+7dKOhsAmuFZXliSUdgteBjW+3
 UP7zaPq1DB9UYDM+UXYyt/3MelFSmtqzEOOtrNK/TMc6neM3rfE1nvqhIVb1qnm2H6GT
 l1Ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQ0WM9lbzYA4f0SWYtcGEI91EpxtvH1/0Sq5LfEsYJ7reHsoBeAS+QgU4fMKrYW2X6K8pHS8dH6ojf@nongnu.org
X-Gm-Message-State: AOJu0YzKA2UpEForrAaaO8R7Gq3pePM1EfpgrAOeV0exfaRcTxuO3461
 cGM0wUVJDgUDn37jmnOOh1ZzR6JfhDPvKF2YVNJdBljeSSJRUVP6UsA1ymxVwUk=
X-Gm-Gg: ASbGncuTjirhRo/zp/yctXPacc2BCrK2lErg43llavDB2yIu9hZAWjpqtjs1pRsRPAV
 GfBTMr1qdx8oU+GjNVXQRPMUFSYUGeiroMw0117mUOTiwUDhgIEQbyquLOx4cKZZrueOUzicjQ9
 TKZG+4Q+melvoPIKHtA9CLzjMpAlYkr/3qwC4TUXiCkOTlw9g2RLWuLXRROZb8v9spO5irJQr2U
 3V1hMvfE5HVH0/mr/yclJQkZEL7dYXyyvgLfCKp/aBVdlOpnPnj2iShUJ4deZQJ0vfiLm/aEnDR
 rrWpftbEHGCJWaDk0UcwYUD8Xjq/+HkgXAXsGwK70V+37cGRlaZa12EmTg==
X-Google-Smtp-Source: AGHT+IGPCy1YFBuABlu+OXmeRXl7gTxO95ixpG/MMPWNQLQ2WF7dRTePt0VB3WA8r59av3v1+2Wcew==
X-Received: by 2002:a05:6a00:230d:b0:736:35d4:f03f with SMTP id
 d2e1a72fcca58-739e6ff6b7fmr5810105b3a.6.1743815426138; 
 Fri, 04 Apr 2025 18:10:26 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97d1c97sm4254869b3a.19.2025.04.04.18.10.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 18:10:25 -0700 (PDT)
Message-ID: <c31a2445-ed34-45c3-8e0d-1c31f2c9ef78@linaro.org>
Date: Fri, 4 Apr 2025 18:10:25 -0700
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
 <bd789a1e-b72d-4a9d-8730-e35cd3b2ffd7@linaro.org>
 <9844deec-cd50-4ff4-9bd5-5356c5e72150@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <9844deec-cd50-4ff4-9bd5-5356c5e72150@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

T24gNC80LzI1IDE1OjA1LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gT24g
NC80LzI1IDIwOjI4LCBQaWVycmljayBCb3V2aWVyIHdyb3RlOg0KPj4gT24gNC8zLzI1IDE2
OjU4LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4+PiBSZXBsYWNlIHRoZSB0
YXJnZXQtc3BlY2lmaWMgVEFSR0VUX0FBUkNINjQgZGVmaW5pdGlvbg0KPj4+IGJ5IGEgY2Fs
bCB0byB0aGUgZ2VuZXJpYyB0YXJnZXRfbG9uZ19iaXRzKCkgaGVscGVyLg0KPj4+DQo+Pj4g
U2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8u
b3JnPg0KPj4+IC0tLQ0KPj4+ICDCoCBody9hcm0vdmlydC5jIHwgMzIgKysrKysrKysrKysr
KysrKy0tLS0tLS0tLS0tLS0tLS0NCj4+PiAgwqAgMSBmaWxlIGNoYW5nZWQsIDE2IGluc2Vy
dGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2h3L2Fy
bS92aXJ0LmMgYi9ody9hcm0vdmlydC5jDQo+Pj4gaW5kZXggZTI0MWU3MWUxYzMuLmEwMjBm
MWJkNTgxIDEwMDY0NA0KPj4+IC0tLSBhL2h3L2FybS92aXJ0LmMNCj4+PiArKysgYi9ody9h
cm0vdmlydC5jDQo+Pj4gQEAgLTMxMzMsMjUgKzMxMzMsMjUgQEAgc3RhdGljIHZvaWQNCj4+
PiB2aXJ0X21hY2hpbmVfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqb2MsIHZvaWQgKmRhdGEp
DQo+Pj4gIMKgICNpZmRlZiBDT05GSUdfVENHDQo+Pj4gIMKgwqDCoMKgwqAgbWFjaGluZV9j
bGFzc19hZGRfdmFsaWRfY3B1X3R5cGUobWMsIEFSTV9DUFVfVFlQRV9OQU1FKCJjb3J0ZXgt
DQo+Pj4gYTciKSk7DQo+Pj4gIMKgwqDCoMKgwqAgbWFjaGluZV9jbGFzc19hZGRfdmFsaWRf
Y3B1X3R5cGUobWMsIEFSTV9DUFVfVFlQRV9OQU1FKCJjb3J0ZXgtDQo+Pj4gYTE1IikpOw0K
Pj4+IC0jaWZkZWYgVEFSR0VUX0FBUkNINjQNCj4+PiAtwqDCoMKgIG1hY2hpbmVfY2xhc3Nf
YWRkX3ZhbGlkX2NwdV90eXBlKG1jLCBBUk1fQ1BVX1RZUEVfTkFNRSgiY29ydGV4LQ0KPj4+
IGEzNSIpKTsNCj4+PiAtwqDCoMKgIG1hY2hpbmVfY2xhc3NfYWRkX3ZhbGlkX2NwdV90eXBl
KG1jLCBBUk1fQ1BVX1RZUEVfTkFNRSgiY29ydGV4LQ0KPj4+IGE1NSIpKTsNCj4+PiAtwqDC
oMKgIG1hY2hpbmVfY2xhc3NfYWRkX3ZhbGlkX2NwdV90eXBlKG1jLCBBUk1fQ1BVX1RZUEVf
TkFNRSgiY29ydGV4LQ0KPj4+IGE3MiIpKTsNCj4+PiAtwqDCoMKgIG1hY2hpbmVfY2xhc3Nf
YWRkX3ZhbGlkX2NwdV90eXBlKG1jLCBBUk1fQ1BVX1RZUEVfTkFNRSgiY29ydGV4LQ0KPj4+
IGE3NiIpKTsNCj4+PiAtwqDCoMKgIG1hY2hpbmVfY2xhc3NfYWRkX3ZhbGlkX2NwdV90eXBl
KG1jLCBBUk1fQ1BVX1RZUEVfTkFNRSgiY29ydGV4LQ0KPj4+IGE3MTAiKSk7DQo+Pj4gLcKg
wqDCoCBtYWNoaW5lX2NsYXNzX2FkZF92YWxpZF9jcHVfdHlwZShtYywgQVJNX0NQVV9UWVBF
X05BTUUoImE2NGZ4IikpOw0KPj4+IC3CoMKgwqAgbWFjaGluZV9jbGFzc19hZGRfdmFsaWRf
Y3B1X3R5cGUobWMsIEFSTV9DUFVfVFlQRV9OQU1FKCJuZW92ZXJzZS0NCj4+PiBuMSIpKTsN
Cj4+PiAtwqDCoMKgIG1hY2hpbmVfY2xhc3NfYWRkX3ZhbGlkX2NwdV90eXBlKG1jLCBBUk1f
Q1BVX1RZUEVfTkFNRSgibmVvdmVyc2UtDQo+Pj4gdjEiKSk7DQo+Pj4gLcKgwqDCoCBtYWNo
aW5lX2NsYXNzX2FkZF92YWxpZF9jcHVfdHlwZShtYywgQVJNX0NQVV9UWVBFX05BTUUoIm5l
b3ZlcnNlLQ0KPj4+IG4yIikpOw0KPj4+IC0jZW5kaWYgLyogVEFSR0VUX0FBUkNINjQgKi8N
Cj4+PiArwqDCoMKgIGlmICh0YXJnZXRfbG9uZ19iaXRzKCkgPT0gNjQpIHsNCj4+DQo+PiBJ
IHdvdWxkIHByZWZlciBpZiB3ZSBpbnRyb2R1Y2UgYSB0cnVlIHRhcmdldF9hYXJjaDY0KCkg
ZnVuY3Rpb24sIGFuZA0KPj4gcHJvYmFibHkgdGhlIHNhbWUgZm9yIG90aGVyIGFyY2hpdGVj
dHVyZXMgd2hlbiBpdCB3aWxsIGJlIG5lZWRlZC4NCj4+DQo+PiBJZiB3ZSBzdGFydCB1c2lu
ZyB0YXJnZXRfbG9uZ19iaXRzKCksIHdlIG1pZ2h0IGVuYWJsZSBzb21ldGhpbmcgaW4NCj4+
IGNvbW1vbiBjb2RlIHRoYXQgd2UgYXJlIG5vdCBzdXBwb3NlZCB0byBkby4gQW5kIGl0IHdp
bGwgYmUgbXVjaCBoYXJkZXINCj4+IHRvIGZpbmQgaXQgbGF0ZXIgd2hlbiB3ZSBkZWJ1ZyBo
ZXRlcm9nZW5lbm91cyBlbXVsYXRpb24uDQo+IA0KPiBJIGdldCB5b3VyIHBvaW50LiBNYXli
ZSB3ZSBjYW4gcmVnaXN0ZXIgdmFsaWQgYWE2NCBDUFVzIHJlZ2FyZGxlc3MsDQo+IGFuZCBm
aWx0ZXIgZm9yIHJlZ2lzdGVyZWQgUU9NIENQVXM/IE9UT0ggeW91ciBzdWdnZXN0aW9uIG9m
DQo+IFRBUkdFVF9BQVJDSDY0IC0+IHRhcmdldF9hYXJjaDY0KCkgY291bGQgYmUgZWFzaWVy
IHRvIHJldmlldy4NCj4gSScnbGwgZ2l2ZSBpdCBhIHRyeS4NCj4gDQoNCkkgdGhpbmsgaXQn
cyBiZXR0ZXIgdG8gY3VzdG9taXplIHRoZSBsaXN0IGNyZWF0aW9uIGRpcmVjdGx5LCBpbnN0
ZWFkIG9mIA0KYWRkaW5nIGFub3RoZXIgaG9vayB0byBmaWx0ZXIgdGhpbmdzIGFmdGVyd2Fy
ZC4NCkFzIHdlbGwsIGl0J3Mgb2J2aW91cyB3aGVuIHJlYWRpbmcgdGhlIGNvZGUsIHRoZSBz
YW1lIHdheSBjdXJyZW50IGlmZGVmIA0KYXJlIG9idmlvdXMgd2hlbiByZWFkaW5nIHRoZW0u
DQoNCj4+DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIG1hY2hpbmVfY2xhc3NfYWRkX3ZhbGlkX2Nw
dV90eXBlKG1jLA0KPj4+IEFSTV9DUFVfVFlQRV9OQU1FKCJjb3J0ZXgtYTM1IikpOw0KPj4+
ICvCoMKgwqDCoMKgwqDCoCBtYWNoaW5lX2NsYXNzX2FkZF92YWxpZF9jcHVfdHlwZShtYywN
Cj4+PiBBUk1fQ1BVX1RZUEVfTkFNRSgiY29ydGV4LWE1NSIpKTsNCj4+PiArwqDCoMKgwqDC
oMKgwqAgbWFjaGluZV9jbGFzc19hZGRfdmFsaWRfY3B1X3R5cGUobWMsDQo+Pj4gQVJNX0NQ
VV9UWVBFX05BTUUoImNvcnRleC1hNzIiKSk7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIG1hY2hp
bmVfY2xhc3NfYWRkX3ZhbGlkX2NwdV90eXBlKG1jLA0KPj4+IEFSTV9DUFVfVFlQRV9OQU1F
KCJjb3J0ZXgtYTc2IikpOw0KPj4+ICvCoMKgwqDCoMKgwqDCoCBtYWNoaW5lX2NsYXNzX2Fk
ZF92YWxpZF9jcHVfdHlwZShtYywNCj4+PiBBUk1fQ1BVX1RZUEVfTkFNRSgiY29ydGV4LWE3
MTAiKSk7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIG1hY2hpbmVfY2xhc3NfYWRkX3ZhbGlkX2Nw
dV90eXBlKG1jLA0KPj4+IEFSTV9DUFVfVFlQRV9OQU1FKCJhNjRmeCIpKTsNCj4+PiArwqDC
oMKgwqDCoMKgwqAgbWFjaGluZV9jbGFzc19hZGRfdmFsaWRfY3B1X3R5cGUobWMsDQo+Pj4g
QVJNX0NQVV9UWVBFX05BTUUoIm5lb3ZlcnNlLW4xIikpOw0KPj4+ICvCoMKgwqDCoMKgwqDC
oCBtYWNoaW5lX2NsYXNzX2FkZF92YWxpZF9jcHVfdHlwZShtYywNCj4+PiBBUk1fQ1BVX1RZ
UEVfTkFNRSgibmVvdmVyc2UtdjEiKSk7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIG1hY2hpbmVf
Y2xhc3NfYWRkX3ZhbGlkX2NwdV90eXBlKG1jLA0KPj4+IEFSTV9DUFVfVFlQRV9OQU1FKCJu
ZW92ZXJzZS1uMiIpKTsNCj4+PiArwqDCoMKgIH0NCj4+PiAgwqAgI2VuZGlmIC8qIENPTkZJ
R19UQ0cgKi8NCj4+PiAtI2lmZGVmIFRBUkdFVF9BQVJDSDY0DQo+Pj4gLcKgwqDCoCBtYWNo
aW5lX2NsYXNzX2FkZF92YWxpZF9jcHVfdHlwZShtYywgQVJNX0NQVV9UWVBFX05BTUUoImNv
cnRleC0NCj4+PiBhNTMiKSk7DQo+Pj4gLcKgwqDCoCBtYWNoaW5lX2NsYXNzX2FkZF92YWxp
ZF9jcHVfdHlwZShtYywgQVJNX0NQVV9UWVBFX05BTUUoImNvcnRleC0NCj4+PiBhNTciKSk7
DQo+Pj4gK8KgwqDCoCBpZiAodGFyZ2V0X2xvbmdfYml0cygpID09IDY0KSB7DQo+Pj4gK8Kg
wqDCoMKgwqDCoMKgIG1hY2hpbmVfY2xhc3NfYWRkX3ZhbGlkX2NwdV90eXBlKG1jLA0KPj4+
IEFSTV9DUFVfVFlQRV9OQU1FKCJjb3J0ZXgtYTUzIikpOw0KPj4+ICvCoMKgwqDCoMKgwqDC
oCBtYWNoaW5lX2NsYXNzX2FkZF92YWxpZF9jcHVfdHlwZShtYywNCj4+PiBBUk1fQ1BVX1RZ
UEVfTkFNRSgiY29ydGV4LWE1NyIpKTsNCj4+PiAgwqAgI2lmIGRlZmluZWQoQ09ORklHX0tW
TSkgfHwgZGVmaW5lZChDT05GSUdfSFZGKQ0KPj4+IC3CoMKgwqAgbWFjaGluZV9jbGFzc19h
ZGRfdmFsaWRfY3B1X3R5cGUobWMsIEFSTV9DUFVfVFlQRV9OQU1FKCJob3N0IikpOw0KPj4+
ICvCoMKgwqDCoMKgwqDCoCBtYWNoaW5lX2NsYXNzX2FkZF92YWxpZF9jcHVfdHlwZShtYywg
QVJNX0NQVV9UWVBFX05BTUUoImhvc3QiKSk7DQo+Pj4gIMKgICNlbmRpZiAvKiBDT05GSUdf
S1ZNIHx8IENPTkZJR19IVkYgKi8NCj4+PiAtI2VuZGlmIC8qIFRBUkdFVF9BQVJDSDY0ICov
DQo+Pj4gK8KgwqDCoCB9DQo+Pj4gIMKgwqDCoMKgwqAgbWFjaGluZV9jbGFzc19hZGRfdmFs
aWRfY3B1X3R5cGUobWMsIEFSTV9DUFVfVFlQRV9OQU1FKCJtYXgiKSk7DQo+Pj4gIMKgwqDC
oMKgwqAgbWMtPmluaXQgPSBtYWNodmlydF9pbml0Ow0KPj4NCj4gDQoNCg==

