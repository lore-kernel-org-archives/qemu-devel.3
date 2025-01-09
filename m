Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9894BE7719C
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 22:28:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tW10i-00067v-OC; Thu, 09 Jan 2025 17:28:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tW10d-0005yZ-Q5
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 17:28:12 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tW10b-000420-QV
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 17:28:11 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2efb17478adso2322640a91.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 14:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736461688; x=1737066488; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2Bu83VTr1T0r5x6e/pkIhmRX1PuARAHDwdR6skXj5a0=;
 b=JUZmSSi/w6HcR11mC+/8QpEPowVl8Ad9IUmF073mKRC0qC9v6SmUfR1mEfTEdgmvxm
 V7i3/V2hRNkWS6N93JMP2RZvNIE6WTJbB1v0M0iwETKmum+QHzkG/LLWplqyWvH9IzOz
 ivhd3JVi/phHL2GnrWxPNCsGuwpKTiQjfdPvN8xRy/LtKYjY7QEGZ+a9fzZldnvtazir
 G24nCZNaF3JX3ciCQQPtcv5cWPD7Jk42LTLIbp2vbFdjBZ/wE5sgqPfnkdxNCC2uYRfR
 xpdfOSZKqCRM9LxfK5DVlVq3JQC13zBViO+ui0A9kH1zktXC6dT6KqCnoc3W//a6Qgg9
 dLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736461688; x=1737066488;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2Bu83VTr1T0r5x6e/pkIhmRX1PuARAHDwdR6skXj5a0=;
 b=vSlgpQJMufvX77FWuREn2fRzJVmjkKkPbW74EtqAq4UfHG25oKtHRLWFOs9QICaVcU
 peXVJdCe8K/1FAuTGb0zPqYunHBwr/e9QXnlXR4a3ppYj22m/sfIWKIWBkVv16U0NMxr
 /5C1xiSEppetCIfvC4FbJe5RceVWvhqij96D3DomhOtMKVMwKjkQf9qZ2EauDSejoRMn
 YxtAXqYyyxWKYrq61IM6uW+vf8lx6RroXomER02DlKBYjAyD1ZoKBkTxS+cEqp1Ak1w5
 ZJUyNemUzNQ03iKUT2/7IMR5lGWWANRLzCUzeofPQNMQBvDHeUAfV4Zq6wryLqRvfUNd
 Y9VQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVe1tqxgG2TafX3zrB8aH4palVZtm2Ph1TLDRIRjaw549jOgMyzfaQpvJZBkRf+9n3mobYsbKPklMWZ@nongnu.org
X-Gm-Message-State: AOJu0YzQ9BcKf57hWK19rvVwVL4nqaoB5mlA4J3Fn5e7apRiCR/J7b2Q
 BlH5aPR6mtjC1dpDIc0AGY9eQEydtE8uirVTV1G+Q0Mn3P5MRp3/8cUplE6EkWw=
X-Gm-Gg: ASbGncs10NeMQndETtC4l25WRk/MpNqPhjw9/Hvl6xP/6LdPNUNmXT1F7EgbziNuqC9
 PTxfoO1HRshGWw8r2UtoHRzhz+oOu831IqQeSk8G+l228N37W9YDPRkeFppjWuzILo6BKF4CBcx
 YrHDlcMZ7zsVBIZ0lLk7G+8SxSuPOFle8DrrMxa8oeY1stcWMqfz5t6NRkx7ZCjGq1pD2HHs0IP
 GoXq9UA9wicmcgex/ZxkjZARzYLfAihhQnjs6qQZmDITazB/FzgHw/bVA9tyTI3y66c+w==
X-Google-Smtp-Source: AGHT+IE/tVueO/wHPFTVURHgWWbxDIYVKVjvuhNynF5dR4gMTiPe/Fp0/Aif0XLYK69HiM7uLHm0fQ==
X-Received: by 2002:a17:90b:3502:b0:2ee:59af:a432 with SMTP id
 98e67ed59e1d1-2f5490dbcf8mr11160801a91.31.1736461688442; 
 Thu, 09 Jan 2025 14:28:08 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f54a26ae2fsm4172190a91.9.2025.01.09.14.28.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 14:28:08 -0800 (PST)
Message-ID: <a37654f8-8d2e-4c4a-9029-fab383077849@linaro.org>
Date: Thu, 9 Jan 2025 14:28:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 01/11] plugins: add types for callbacks related to
 certain discontinuities
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
References: <cover.1733063076.git.neither@nut.email>
 <5e624b7244f1b0b294b28cd513aab04b6b294b1d.1733063076.git.neither@nut.email>
 <6f182c71-2600-4bbf-ab4c-985ed7e99f71@linaro.org>
 <87wmf46qmm.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87wmf46qmm.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1036.google.com
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

T24gMS85LzI1IDA1OjUyLCBBbGV4IEJlbm7DqWUgd3JvdGU6DQo+IFBpZXJyaWNrIEJvdXZp
ZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4gd3JpdGVzOg0KPiANCj4+IEhpIEp1
bGlhbiwNCj4+DQo+PiB0aGFua3MgZm9yIHRoZSB1cGRhdGUhDQo+PiBDb21tZW50cyBiZWxv
dy4NCj4+DQo+PiBPbiAxMi8yLzI0IDExOjI2LCBKdWxpYW4gR2FueiB3cm90ZToNCj4+PiBU
aGUgcGx1Z2luIEFQSSBhbGxvd3MgcmVnaXN0cmF0aW9uIG9mIGNhbGxiYWNrcyBmb3IgYSB2
YXJpZXR5IG9mIFZDUFUNCj4+PiByZWxhdGVkIGV2ZW50cywgc3VjaCBhcyBWQ1BVIHJlc2V0
LCBpZGxlIGFuZCByZXN1bWUuIEhvd2V2ZXIsIHRyYXBzIG9mDQo+Pj4gYW55IGtpbmQsIGku
ZS4gaW50ZXJydXB0cyBvciBleGNlcHRpb25zLCB3ZXJlIHByZXZpb3VzbHkgbm90IGNvdmVy
ZWQuDQo+Pj4gVGhlc2Uga2luZHMgb2YgZXZlbnRzIGFyZSBhcmd1YWJseSBxdWl0ZSBzaWdu
aWZpY2FudCBhbmQgdXN1YWxseSBnbyBoYW5kDQo+Pj4gaW4gaGFuZCB3aXRoIGEgUEMgZGlz
Y29udGludWl0eS4gT24gbW9zdCBwbGF0Zm9ybXMsIHRoZSBkaXNjb250aW51aXR5DQo+Pj4g
YWxzbyBpbmNsdWRlcyBhIHRyYW5zaXRpb24gZnJvbSBzb21lICJtb2RlIiB0byBhbm90aGVy
LiBUaHVzLCBwbHVnaW5zDQo+Pj4gZm9yIHRoZSBhbmFseXNpcyBvZiAodmlydHVhbGl6ZWQp
IGVtYmVkZGVkIHN5c3RlbXMgbWF5IGJlbmVmaXQgZnJvbSBvcg0KPj4+IGV2ZW4gcmVxdWly
ZSB0aGUgcG9zc2libGl0eSB0byBwZXJmb3JtIHdvcmsgb24gdGhlIG9jY3VyYW5jZSBvZiBh
bg0KPj4+IGludGVycnVwdCBvciBleGNlcHRpb24uDQo+Pj4gVGhpcyBjaGFuZ2UgaW50cm9k
dWNlcyB0aGUgY29uY2VwdCBvZiBzdWNoIGEgZGlzY29udGludWl0eSBldmVudCBpbg0KPj4+
IHRoZQ0KPj4+IGZvcm0gb2YgYW4gZW51bWVyYXRpb24uIEN1cnJlbnRseSBvbmx5IHRyYXBz
IGFyZSBjb3ZlcmVkLiBTcGVjaWZpY2FsbHkNCj4+PiB3ZSAobG9vc2VseSkgZGVmaW5lIGlu
dGVycnVwdHMsIGV4Y2VwdGlvbnMgYW5kIGhvc3QgY2FsbHMgYWNyb3NzIGFsbA0KPj4+IHBs
YXRmb3Jtcy4gSW4gYWRkaXRpb24sIHRoaXMgY2hhbmdlIGludHJvZHVjZXMgYSB0eXBlIHRv
IHVzZSBmb3INCj4+PiBjYWxsYmFjayBmdW5jdGlvbnMgcmVsYXRlZCB0byBzdWNoIGV2ZW50
cy4gU2luY2UgcG9zc2libGUgbW9kZXMgYW5kIHRoZQ0KPj4+IGVudW1lcmF0aW9uIG9mIGlu
dGVydXB0cyBhbmQgZXhjZXB0aW9ucyB2YXJ5IGdyZWF0bHkgYmV0d2VlbiBkaWZmZXJlbnQN
Cj4+PiBhcmNoaXRlY3R1cmVzLCB0aGUgY2FsbGJhY2sgdHlwZSBvbmx5IHJlY2VpdmVzIHRo
ZSBWQ1BVIGlkLCB0aGUgdHlwZSBvZg0KPj4+IGV2ZW50IGFzIHdlbGwgYXMgdGhlIG9sZCBh
bmQgbmV3IFBDLg0KPj4+IC0tLQ0KPj4+ICAgIGluY2x1ZGUvcWVtdS9wbHVnaW4uaCAgICAg
IHwgIDEgKw0KPj4+ICAgIGluY2x1ZGUvcWVtdS9xZW11LXBsdWdpbi5oIHwgNDMgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+PiAgICAyIGZpbGVzIGNoYW5n
ZWQsIDQ0IGluc2VydGlvbnMoKykNCj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9xZW11L3Bs
dWdpbi5oIGIvaW5jbHVkZS9xZW11L3BsdWdpbi5oDQo+Pj4gaW5kZXggOTcyNmE5ZWJmMy4u
MjdhMTc2YjYzMSAxMDA2NDQNCj4+PiAtLS0gYS9pbmNsdWRlL3FlbXUvcGx1Z2luLmgNCj4+
PiArKysgYi9pbmNsdWRlL3FlbXUvcGx1Z2luLmgNCj4+PiBAQCAtNTksNiArNTksNyBAQCB1
bmlvbiBxZW11X3BsdWdpbl9jYl9zaWcgew0KPj4+ICAgICAgICBxZW11X3BsdWdpbl91ZGF0
YV9jYl90ICAgICAgICAgICB1ZGF0YTsNCj4+PiAgICAgICAgcWVtdV9wbHVnaW5fdmNwdV9z
aW1wbGVfY2JfdCAgICAgdmNwdV9zaW1wbGU7DQo+Pj4gICAgICAgIHFlbXVfcGx1Z2luX3Zj
cHVfdWRhdGFfY2JfdCAgICAgIHZjcHVfdWRhdGE7DQo+Pj4gKyAgICBxZW11X3BsdWdpbl92
Y3B1X2Rpc2Nvbl9jYl90ICAgICB2Y3B1X2Rpc2NvbjsNCj4+PiAgICAgICAgcWVtdV9wbHVn
aW5fdmNwdV90Yl90cmFuc19jYl90ICAgdmNwdV90Yl90cmFuczsNCj4+PiAgICAgICAgcWVt
dV9wbHVnaW5fdmNwdV9tZW1fY2JfdCAgICAgICAgdmNwdV9tZW07DQo+Pj4gICAgICAgIHFl
bXVfcGx1Z2luX3ZjcHVfc3lzY2FsbF9jYl90ICAgIHZjcHVfc3lzY2FsbDsNCj4+PiBkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9xZW11L3FlbXUtcGx1Z2luLmggYi9pbmNsdWRlL3FlbXUvcWVt
dS1wbHVnaW4uaA0KPj4+IGluZGV4IDBmYmEzNmFlMDIuLjljNjczNzRiN2UgMTAwNjQ0DQo+
Pj4gLS0tIGEvaW5jbHVkZS9xZW11L3FlbXUtcGx1Z2luLmgNCj4+PiArKysgYi9pbmNsdWRl
L3FlbXUvcWVtdS1wbHVnaW4uaA0KPj4+IEBAIC0xNTQsNiArMTU0LDQ5IEBAIHR5cGVkZWYg
dm9pZCAoKnFlbXVfcGx1Z2luX3ZjcHVfc2ltcGxlX2NiX3QpKHFlbXVfcGx1Z2luX2lkX3Qg
aWQsDQo+Pj4gICAgdHlwZWRlZiB2b2lkICgqcWVtdV9wbHVnaW5fdmNwdV91ZGF0YV9jYl90
KSh1bnNpZ25lZCBpbnQgdmNwdV9pbmRleCwNCj4+PiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHZvaWQgKnVzZXJkYXRhKTsNCj4+PiAgICArDQo+
Pj4gKy8qKg0KPj4+ICsgKiBlbnVtIHFlbXVfcGx1Z2luX2Rpc2Nvbl90eXBlIC0gdHlwZSBv
ZiBhIChwb3RlbnRpYWwpIFBDIGRpc2NvbnRpbnVpdHkNCj4+PiArICoNCj4+PiArICogQFFF
TVVfUExVR0lOX0RJU0NPTl9JTlRFUlJVUFQ6IGFuIGludGVycnVwdCwgZGVmaW5lZCBhY3Jv
c3MgYWxsIGFyY2hpdGVjdHVyZXMNCj4+PiArICogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGFzIGFuIGFzeW5jaHJvbm91cyBldmVudCwgdXN1YWxseSBvcmlnaW5hdGluZw0K
Pj4+ICsgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZnJvbSBvdXRzaWRlIHRo
ZSBDUFUNCj4+PiArICogQFFFTVVfUExVR0lOX0RJU0NPTl9FWENFUFRJT046IGFuIGV4Y2Vw
dGlvbiwgZGVmaW5lZCBhY3Jvc3MgYWxsIGFyY2hpdGVjdHVyZXMNCj4+PiArICogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGFzIGEgc3luY2hyb25vdXMgZXZlbnQgaW4gcmVz
cG9uc2UgdG8gYQ0KPj4+ICsgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3Bl
Y2lmaWMgaW5zdHJ1Y3Rpb24gYmVpbmcgZXhlY3V0ZWQNCj4+PiArICogQFFFTVVfUExVR0lO
X0RJU0NPTl9IT1NUQ0FMTDogYSBob3N0IGNhbGwsIGZ1bmN0aW9uYWxseSBhIHNwZWNpYWwg
a2luZCBvZg0KPj4+ICsgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBleGNlcHRp
b24gdGhhdCBpcyBub3QgaGFuZGxlZCBieSBjb2RlIHJ1biBieQ0KPj4+ICsgKiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB0aGUgdkNQVSBidXQgbWFjaGluZXJ5IG91dHNpZGUg
dGhlIHZDUFUNCj4+PiArICogQFFFTVVfUExVR0lOX0RJU0NPTl9BTEw6IGFsbCB0eXBlcyBv
ZiBkaXNjb25pbnVpdHkgZXZlbnRzIGN1cnJlbnRseSBjb3ZlcmVkDQo+Pj4gKyAqLw0KPj4+
ICtlbnVtIHFlbXVfcGx1Z2luX2Rpc2Nvbl90eXBlIHsNCj4+PiArICAgIFFFTVVfUExVR0lO
X0RJU0NPTl9JTlRFUlJVUFQgPSAxLA0KPj4+ICsgICAgUUVNVV9QTFVHSU5fRElTQ09OX0VY
Q0VQVElPTiA9IDIsDQo+Pj4gKyAgICBRRU1VX1BMVUdJTl9ESVNDT05fSE9TVENBTEwgPSA0
LA0KPj4+ICsgICAgUUVNVV9QTFVHSU5fRElTQ09OX0FMTCA9IDcNCj4+PiArfTsNCj4+DQo+
PiBNYXR0ZXIgb2Ygc3R5bGUsIGJ1dCB3b3VsZCBiZSBiZXR0ZXIgdG8gdXNlOg0KPj4NCj4+
IGVudW0gcWVtdV9wbHVnaW5fZGlzY29uX3R5cGUgew0KPj4gICAgICAgUUVNVV9QTFVHSU5f
RElTQ09OX0lOVEVSUlVQVCA9IDEgPDwgMCwNCj4+ICAgICAgIFFFTVVfUExVR0lOX0RJU0NP
Tl9FWENFUFRJT04gPSAxIDw8IDEsDQo+PiAgICAgICBRRU1VX1BMVUdJTl9ESVNDT05fSE9T
VENBTEwgPSAxIDw8IDIsDQo+PiAgICAgICBRRU1VX1BMVUdJTl9ESVNDT05fQUxMID0gLTEN
Cj4+IH07DQo+Pg0KPiA8c25pcD4NCj4gDQo+IElzIHRoaXMgcmVhbGx5IGEgYml0IGZpZWxk
IHRob3VnaD8gSWYgeW91IHdpbGwgb25seSByZXBvcnQgdHlwZSBvZg0KPiBkaXNjb250aW51
aXR5IGF0IGEgdGltZSBhIHNpbXBsZSAwIGJhc2VkIGVudW0gd2l0aA0KPiBRRU1VX1BMVUdJ
Tl9ESVNDT05fTUFYIHdvdWxkIGJlIHNpbXBsZXIuDQo+IA0KDQpIZXJlIHdlIHdhbnQgdG8g
ZXhwcmVzcyBBTEwsIG5vdCBNQVguDQo=

