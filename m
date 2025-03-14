Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 919FAC282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 20:35:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttBk6-0002fi-Ae; Fri, 14 Mar 2025 16:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ttBk2-0002dp-GE
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 16:34:52 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ttBk0-0005Gl-F6
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 16:34:49 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-224100e9a5cso51348475ad.2
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 13:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741984486; x=1742589286; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=39wW166Kou0vuRrfdqOehpfQFhfn1sJmUZY2NBjvXi8=;
 b=SqEm8v82Lsjwr9XGY7jdvpxy5te8IEIXd+oOePjbJnQawn90IIyCjgDm4W+U1b3ZPR
 UUXXJP/eNRxPVWPfz0ExhnLwDunKw4NWge/HjXwr4ftCvpN6Ab5j4XTQLeV5fJC+pLX4
 uTatg435bRMTSGmVdpHH3/bLfnzNTDdXMMU0QUMu33EkWis2oiI5rvYbyc7+Z6yi7+y9
 IUyu2NhPv9ezT6y+0zka893L2qrAKjEb19gILaCljGjZBAZlnDDF5yZQWy9CezjSO4p+
 eDudaba66oGRzfFYPGZA9GkDULB7cnuKeI48i8DwpsoFQ/cGRK6rH3Icw3o5nHQM+XWY
 b0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741984486; x=1742589286;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=39wW166Kou0vuRrfdqOehpfQFhfn1sJmUZY2NBjvXi8=;
 b=gjNiNr4pglj0hbgrmHv8vM4O/ImCBHlGcIQg/jUiBz9YnZ0+YguuorrmpetnGzescO
 cvXAskSGkNYc3cmL2r2bURKPhAE8skRX2iDt5sPRlW1sq0ogTJhJkTAf70WKFJwB0Op9
 n+3xiBkwVp7OaNHyMqxnGc9AF9mTiyNkDnzgI0FEvIIhIM1s55PFWMk84dMPr/HMDopJ
 s7AcqihN2CNtyBotIvwSTRxK0zh87wDJ/Aq3yIoHC1G6dHCF6SuGHeUZmNyFWHfmRjAn
 J7JH2ukwxY2o7mxgTywVcGjp7+MfCSyq7tx3pJW6/smqqcLYtHdVSGoJ2SljWI+UixNG
 mjww==
X-Forwarded-Encrypted: i=1;
 AJvYcCWR+yYS9OZIsmLGZtm6vWCcZsfS+6UT+eRdJu4s+RVV2+iOL0G76QnRzbIc25bQWtqdjEd8+NCypQLx@nongnu.org
X-Gm-Message-State: AOJu0YxTU7oks27XU/3UgXW5BugcR8EdXIpnpvG+HtVXeMmhw3usoXZk
 aIs2mPrthrcI0d21nxXnkQhFdS/mfFXpwv3Mpik0QXFt2sk6IvgeLOpmVGLluuo=
X-Gm-Gg: ASbGncuhohWRb9WaY4i4EP26get28r12wvCh2zyqrhNb+iwwIzNOb9JSMAcs0BElayi
 51x/DsyPOinWVeBDYOTwmXvWGyKEeeKdOGHoGuFn4l0gbOg6PC4r3vwx4VboyNnOfv3tQCGowJD
 /vVx+nCsd6SomHVB6N+7lvt6sdY6NtA4lw895ivE1vKZTBP10FhZS/oyuYmA6ehs+eGcmqjSUE5
 r+DjsSU1rYeSpEQhaeRbKnPxNGNVJxxVsbjrx3SbZeciLlXl+bhl6nExcBv+oyj/l04X9+SwNTx
 7fb7sSWOGro9qLO2Af8cuXfM/frLBu+LniOQDC81NBXzNYgzMXCjoYw/kw==
X-Google-Smtp-Source: AGHT+IFAtUxaS9Bebyq1yKkLFLSE69XVe/RWDCiHomfnxkuDbDMUPVpUzJ4oTDyjKjPlQ/n2bdJXbg==
X-Received: by 2002:a05:6a00:893:b0:736:50c4:3e0f with SMTP id
 d2e1a72fcca58-73722370260mr4379169b3a.10.1741984486346; 
 Fri, 14 Mar 2025 13:34:46 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711695ae4sm3401418b3a.145.2025.03.14.13.34.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Mar 2025 13:34:45 -0700 (PDT)
Message-ID: <ad7cd476-1830-4806-b4d2-20d8456af849@linaro.org>
Date: Fri, 14 Mar 2025 13:34:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 32/37] include/hw/intc: Remove ifndef CONFIG_USER_ONLY
 from armv7m_nvic.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-33-richard.henderson@linaro.org>
 <7f665a47-2bba-4c3a-980c-a252ec44723c@linaro.org>
 <807dbc0d-db15-4bd3-95f3-b3e87951bd7f@linaro.org>
 <42b1f9f3-2ed4-461b-9460-0318011097ee@linaro.org>
 <e3d39823-734e-4186-95b6-07717663bdf2@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <e3d39823-734e-4186-95b6-07717663bdf2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

T24gMy8xNC8yNSAxMzowMywgUmljaGFyZCBIZW5kZXJzb24gd3JvdGU6DQo+IE9uIDMvMTQv
MjUgMTE6MzYsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBPbiAzLzE0LzI1IDExOjEz
LCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90ZToNCj4+PiBPbiAzLzEzLzI1IDE0OjAwLCBQaWVy
cmljayBCb3V2aWVyIHdyb3RlOg0KPj4+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvaW50
Yy9hcm12N21fbnZpYy5oIGIvaW5jbHVkZS9ody9pbnRjL2FybXY3bV9udmljLmgNCj4+Pj4+
IGluZGV4IDg5ZmU4YWVkYWEuLjdiOTk2NGZlN2UgMTAwNjQ0DQo+Pj4+PiAtLS0gYS9pbmNs
dWRlL2h3L2ludGMvYXJtdjdtX252aWMuaA0KPj4+Pj4gKysrIGIvaW5jbHVkZS9ody9pbnRj
L2FybXY3bV9udmljLmgNCj4+Pj4+IEBAIC0xODksMjEgKzE4OSw3IEBAIGludCBhcm12N21f
bnZpY19yYXdfZXhlY3V0aW9uX3ByaW9yaXR5KE5WSUNTdGF0ZSAqcyk7DQo+Pj4+PiAgwqDC
oMKgICogQHNlY3VyZTogdGhlIHNlY3VyaXR5IHN0YXRlIHRvIHRlc3QNCj4+Pj4+ICDCoMKg
wqAgKiBUaGlzIGNvcnJlc3BvbmRzIHRvIHRoZSBwc2V1ZG9jb2RlIElzUmVxRXhlY1ByaU5l
ZygpLg0KPj4+Pj4gIMKgwqDCoCAqLw0KPj4+Pj4gLSNpZm5kZWYgQ09ORklHX1VTRVJfT05M
WQ0KPj4+Pj4gIMKgwqAgYm9vbCBhcm12N21fbnZpY19uZWdfcHJpb19yZXF1ZXN0ZWQoTlZJ
Q1N0YXRlICpzLCBib29sIHNlY3VyZSk7DQo+Pj4+PiAtI2Vsc2UNCj4+Pj4+IC1zdGF0aWMg
aW5saW5lIGJvb2wgYXJtdjdtX252aWNfbmVnX3ByaW9fcmVxdWVzdGVkKE5WSUNTdGF0ZSAq
cywgYm9vbCBzZWN1cmUpDQo+Pj4+PiAtew0KPj4+Pj4gLcKgwqDCoCByZXR1cm4gZmFsc2U7
DQo+Pj4+PiAtfQ0KPj4+Pj4gLSNlbmRpZg0KPj4+Pj4gLSNpZm5kZWYgQ09ORklHX1VTRVJf
T05MWQ0KPj4+Pj4gIMKgwqAgYm9vbCBhcm12N21fbnZpY19jYW5fdGFrZV9wZW5kaW5nX2V4
Y2VwdGlvbihOVklDU3RhdGUgKnMpOw0KPj4+Pj4gLSNlbHNlDQo+Pj4+PiAtc3RhdGljIGlu
bGluZSBib29sIGFybXY3bV9udmljX2Nhbl90YWtlX3BlbmRpbmdfZXhjZXB0aW9uKE5WSUNT
dGF0ZSAqcykNCj4+Pj4+IC17DQo+Pj4+PiAtwqDCoMKgIHJldHVybiB0cnVlOw0KPj4+Pj4g
LX0NCj4+Pj4+IC0jZW5kaWYNCj4+Pj4+ICDCoMKgICNlbmRpZg0KPj4+Pg0KPj4+PiBJJ20g
YSBiaXQgd29ycmllZCB3ZSBtaWdodCBoYXZlIHJlZ3Jlc3Npb24gd2hlbiBkb2luZyB0aGlu
Z3MgdGhpcyB3YXkuDQo+Pj4NCj4+PiBJIGV4cGVjdCBsaW5rIGVycm9ycyB0byBkaWFnbm9z
ZSBlcnJvcnMuDQo+Pj4NCj4+DQo+PiBJbiB0aGlzIGNhc2UsIHllcy4NCj4+DQo+PiBNb3Jl
IGdlbmVyYWxseSwgZm9yIHN5c3RlbSB2cyB1c2VyLCBpdCBtaWdodCBiZSBzdWZmaWNpZW50
IChldmVuIHRob3VnaCBJIHdvdWxkIHByZWZlciB0bw0KPj4gYmUgYmxpbmRseSBwcnVkZW50
IG9uIHRoaXMpLCBidXQgaXQgbWlnaHQgbm90IHByb3RlY3QgYWxsIGNhc2VzLCB3aXRoIHN1
YnRsZSBjb25maWdzIG9yDQo+PiBmZWF0dXJlcyBlbmFibGVkL2Rpc2FibGVkLg0KPj4NCj4+
IFdpdGggYSBydW50aW1lIGNoZWNrLCB3ZSBjb3VsZCBpZGVudGlmeSB0aGUgbWlzc2luZyBj
YWxscyAiZmVhdHVyZV9lbmFibGVkKCkiLiBJbiB0aGlzDQo+PiBjYXNlLCB3ZSB3b3VsZCBs
aW5rLCBidXQgY291bGQgZW5kIHVwIGNhbGxfZmVhdHVyZSBpbiBzb21lIGNhc2VzLCB3aGVu
IGl0IHNob3VsZCBiZSBoaWRkZW4NCj4+IGJlaGluZCBhICJfZW5hYmxlZCgpIiBjaGVjay4N
Cj4+DQo+PiBpZiAoZmVhdHVyZV9lbmFibGVkKCkpIHsNCj4+ICAgwqAgY2FsbF9mZWF0dXJl
KCk7DQo+PiB9DQo+IA0KPiBJJ20gbm90IHF1aXRlIHN1cmUgd2hhdCB5b3UncmUgYXJndWlu
ZyBmb3IgaGVyZS4NCj4gQSBidWlsZC10aW1lIGVycm9yIGlzIHZhc3RseSBwcmVmZXJhYmxl
IHRvIGEgcnVuLXRpbWUgZXJyb3IuDQo+IA0KDQpFdmVuIHRob3VnaCB0aGlzIHNwZWNpZmlj
IHBhdGNoIGlzIHNhZmUgKGNvZGUgY2FsbGluZyB0aG9zZSBmdW5jdGlvbnMgDQpzaG91bGQg
YmUgdW5kZXIgc3lzdGVtIGFueXdheSwgc28gaXQgc2hvdWxkIG5vdCBiZSBsaW5rZWQgaW4g
YSB1c2VyIA0KYmluYXJ5KSwgSSBqdXN0IHdvbmRlciBpZiB3ZSBzaG91bGQgbm90IGFkZCBl
eHBsaWNpdCBjaGVja3MgZm9yIHRoaXMsIA0KZm9yIG90aGVyIGtpbmQgb2YgcmVwbGFjZW1l
bnQgd2UnbGwgaGF2ZSB0byBkby4NCg0KPiBJZiBpdCdzIGEgbGVzc2VyIHVzZWQgY29uZmln
dXJhdGlvbiBvciBmZWF0dXJlLCBhIHJ1bi10aW1lIGVycm9yIGNvdWxkIGxheSBkb3JtYW50
IGZvcg0KPiB5ZWFycyBiZWZvcmUgYSB1c2VyIGVuY291bnRlcnMgaXQuDQo+IA0KDQpTdXJl
LCBidXQgd291bGRuJ3QgaXQgYmV0dGVyIHRvIGhhdmUgYW4gZXhwbGljaXQgYXNzZXJ0LCBp
bnN0ZWFkIG9mIA0Kb2JzZXJ2aW5nIGEgcmFuZG9tIGJlaGF2aW91cj8NCg0KSSdtIGp1c3Qg
d29ycmllZCB3ZSBlbmQgdXAgY2FsbGluZyBzb21ldGhpbmcgd2Ugc2hvdWxkIG5vdCAodXNl
ciB2cyANCnN5c3RlbSwgb3IgYW55IG90aGVyIGlmZGVmIENPTkZJRy9UQVJHRVQgdGhhdCBt
aWdodCBiZSBoaWRkZW4gDQpzb21ld2hlcmUpLCBhbmQgc2lsZW50bHkgcmV0dXJuIGEgd3Jv
bmcgdmFsdWUsIHdoaWNoIHdvdWxkIG5vdCBiZSANCmNvdmVyZWQgYnkgb3VyIHRlc3Qgc3Vp
dGUuDQoNCj4gDQo+IHJ+DQoNCg==

