Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 147CBE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 20:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWLwq-0005PS-W5; Fri, 10 Jan 2025 15:49:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tWLwn-0005P3-QL
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 15:49:37 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tWLwm-0007EY-Ah
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 15:49:37 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2164b1f05caso43545945ad.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 12:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736542174; x=1737146974; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NCPOt+9fHY+BCUA9UBGjmfD80gBuMkE/kanEfZgzZJw=;
 b=bixvIjCcGRpqge5yh51pHvd3yARzJnCJYSUXonfUxJbgzysDg4GNk9EuF/Mw8ejfLH
 QOADUQyQoxh4o9RCHU63V038R22t6phriveOgmD8QVt/wzT8Pgvv3xJHc+vtm7BckM40
 MIBhI7Kyg+ATKksx6fxoRMLwxpMmNN52W2OoC0VqxmiEHTnRwgqeFLJeRTYfU7XRUfAr
 xnZURJc/3Pvft+nDZYCgw/Yzd+Aw9fm9vayT0adWUjuhHwT8CpytmRLgmJM1CKijsdEX
 NiF0406tJ+9J2ICmYBTzzT5GfrMN0afjW9eWP0Jrjpwv5ojnt/Si+pu10lNW9P/FU5IH
 vrdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736542174; x=1737146974;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NCPOt+9fHY+BCUA9UBGjmfD80gBuMkE/kanEfZgzZJw=;
 b=MKI1QO6dGkU2b8A+fkqYyqy5xPxJq+qiuT4be66tdh7pjHtNumCdDajlay+KrMwsx8
 tzOESvzH/96VxGFUmeTFhAC+51u0W2aRbZmGEsWc3KCB/cwZsDlL6/paDfqgQP1TL33r
 yj09k0ItiVpVd0lqFB1iF1ZdzAJUlbBtkiGqTO6bXoREIRWxogtCNEPAOKG7aJ7jlEZE
 Whrcb6DcHCaVW3bpoEKdDRjDC9bkPvGDAS/6vCDXeGCRO71j/XzeN6AG34tselfEmVMn
 GclctecVkEgYjQsONgodkITpW1PVkTRp4xovik+VTVQHbF0b5p/Rqt61r44R5RJ5VPdq
 0jsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJx85ddrAEZ+L+iGNDt6tPZNAv2Mh2ylouHNPURw3sBSXqE0tqPpTyWlv7z860wb/o+c/G+RWd0Rc5@nongnu.org
X-Gm-Message-State: AOJu0Yy2WWzgg4TeWx7FoMh2X5xxJXOInUErvY1mzV7+VF1fzFqPPvHE
 LUQojBGreCN34an8j8EEgBIm52LoSnamxYVNwsxhTmHb0JyUs7aE1XZTZKj1Q4w=
X-Gm-Gg: ASbGncsUT8MT5MIveFNcgZt8u6tStxsZLA3mvU4e0vsJuAghU/PSheNO5mdDwWi7UyI
 NwCHNPu8brkownp/+mQoBuKJxf3belZ1ETyR4qIMq0mXVDKL0DfzoLr7wMoX9Uo36+llYRr0CO9
 lcGchi8+ScRALD7znquDlpkP8OM0OdP6oxZmaHjSb6eywbB4PoKqfKWACmwKSH/mA45cHSJBMGx
 /dtt41C8G/CuwoyUqGSvvfMwWALg1gAo6H2hSo1fB8dxsjq6pTi7Ww8R2HvHWUvunHmiA==
X-Google-Smtp-Source: AGHT+IGWf2nD0VvViZAkOV1Q22E9QBFlUXxfaa13TYz0FNiqCyriUBIWkwh5XYlvlrsarfJtJwd6fA==
X-Received: by 2002:a05:6a00:4c18:b0:72a:8f07:2bf2 with SMTP id
 d2e1a72fcca58-72d21fb1cc8mr15300290b3a.9.1736542174577; 
 Fri, 10 Jan 2025 12:49:34 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72d406a935csm1963406b3a.179.2025.01.10.12.49.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 12:49:34 -0800 (PST)
Message-ID: <5a4072bb-1dee-4023-ad78-67f9f49632c1@linaro.org>
Date: Fri, 10 Jan 2025 12:49:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hw/char/serial: Convert to three-phase reset
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250110182759.84071-1-philmd@linaro.org>
 <20250110182759.84071-3-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250110182759.84071-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

T24gMS8xMC8yNSAxMDoyNywgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IENv
bnZlcnQgdGhlIFRZUEVfU0VSSUFMICgxNjU1MEEgVUFSVCkgdG8gdGhyZWUtcGhhc2UgcmVz
ZXQuDQo+IA0KPiBPbmx5IGxvY2FsIHN0YXRlcyBhcmUgcmVzZXQgc28gdXNlIHRoZSBSZXNl
dEhvbGQgaGFuZGxlciwNCj4gbGlrZSBvdGhlciBsZWdhY3kgZGV2aWNlcy4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9y
Zz4NCj4gLS0tDQo+ICAgaHcvY2hhci9zZXJpYWwuYyB8IDEwICsrKystLS0tLS0NCj4gICAx
IGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2h3L2NoYXIvc2VyaWFsLmMgYi9ody9jaGFyL3NlcmlhbC5jDQo+IGlu
ZGV4IDU2MjkzMTY4NWU3Li45Y2I2ZTMwYzljZSAxMDA2NDQNCj4gLS0tIGEvaHcvY2hhci9z
ZXJpYWwuYw0KPiArKysgYi9ody9jaGFyL3NlcmlhbC5jDQo+IEBAIC04NTEsOSArODUxLDkg
QEAgY29uc3QgVk1TdGF0ZURlc2NyaXB0aW9uIHZtc3RhdGVfc2VyaWFsID0gew0KPiAgICAg
ICB9DQo+ICAgfTsNCj4gICANCj4gLXN0YXRpYyB2b2lkIHNlcmlhbF9yZXNldCh2b2lkICpv
cGFxdWUpDQo+ICtzdGF0aWMgdm9pZCBzZXJpYWxfcmVzZXRfaG9sZChPYmplY3QgKm9iaiwg
UmVzZXRUeXBlIHR5cGUpDQo+ICAgew0KPiAtICAgIFNlcmlhbFN0YXRlICpzID0gb3BhcXVl
Ow0KPiArICAgIFNlcmlhbFN0YXRlICpzID0gKFNlcmlhbFN0YXRlICopb2JqOw0KPiAgIA0K
PiAgICAgICBpZiAocy0+d2F0Y2hfdGFnID4gMCkgew0KPiAgICAgICAgICAgZ19zb3VyY2Vf
cmVtb3ZlKHMtPndhdGNoX3RhZyk7DQo+IEBAIC05MjgsMTMgKzkyOCwxMSBAQCBzdGF0aWMg
dm9pZCBzZXJpYWxfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnApDQo+
ICAgICAgIHMtPm1vZGVtX3N0YXR1c19wb2xsID0gdGltZXJfbmV3X25zKFFFTVVfQ0xPQ0tf
VklSVFVBTCwgKFFFTVVUaW1lckNCICopIHNlcmlhbF91cGRhdGVfbXNsLCBzKTsNCj4gICAN
Cj4gICAgICAgcy0+Zmlmb190aW1lb3V0X3RpbWVyID0gdGltZXJfbmV3X25zKFFFTVVfQ0xP
Q0tfVklSVFVBTCwgKFFFTVVUaW1lckNCICopIGZpZm9fdGltZW91dF9pbnQsIHMpOw0KPiAt
ICAgIHFlbXVfcmVnaXN0ZXJfcmVzZXQoc2VyaWFsX3Jlc2V0LCBzKTsNCj4gICANCj4gICAg
ICAgcWVtdV9jaHJfZmVfc2V0X2hhbmRsZXJzKCZzLT5jaHIsIHNlcmlhbF9jYW5fcmVjZWl2
ZTEsIHNlcmlhbF9yZWNlaXZlMSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHNlcmlhbF9ldmVudCwgc2VyaWFsX2JlX2NoYW5nZSwgcywgTlVMTCwgdHJ1ZSk7DQo+ICAg
ICAgIGZpZm84X2NyZWF0ZSgmcy0+cmVjdl9maWZvLCBVQVJUX0ZJRk9fTEVOR1RIKTsNCj4g
ICAgICAgZmlmbzhfY3JlYXRlKCZzLT54bWl0X2ZpZm8sIFVBUlRfRklGT19MRU5HVEgpOw0K
PiAtICAgIHNlcmlhbF9yZXNldChzKTsNCj4gICB9DQo+ICAgDQo+ICAgc3RhdGljIHZvaWQg
c2VyaWFsX3VucmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2KQ0KPiBAQCAtOTQ5LDggKzk0Nyw2
IEBAIHN0YXRpYyB2b2lkIHNlcmlhbF91bnJlYWxpemUoRGV2aWNlU3RhdGUgKmRldikNCj4g
ICANCj4gICAgICAgZmlmbzhfZGVzdHJveSgmcy0+cmVjdl9maWZvKTsNCj4gICAgICAgZmlm
bzhfZGVzdHJveSgmcy0+eG1pdF9maWZvKTsNCj4gLQ0KPiAtICAgIHFlbXVfdW5yZWdpc3Rl
cl9yZXNldChzZXJpYWxfcmVzZXQsIHMpOw0KPiAgIH0NCj4gICANCj4gICBjb25zdCBNZW1v
cnlSZWdpb25PcHMgc2VyaWFsX2lvX29wcyA9IHsNCj4gQEAgLTk3NSwxMiArOTcxLDE0IEBA
IHN0YXRpYyBjb25zdCBQcm9wZXJ0eSBzZXJpYWxfcHJvcGVydGllc1tdID0gew0KPiAgIHN0
YXRpYyB2b2lkIHNlcmlhbF9jbGFzc19pbml0KE9iamVjdENsYXNzICprbGFzcywgdm9pZCog
ZGF0YSkNCj4gICB7DQo+ICAgICAgIERldmljZUNsYXNzICpkYyA9IERFVklDRV9DTEFTUyhr
bGFzcyk7DQo+ICsgICAgUmVzZXR0YWJsZUNsYXNzICpyYyA9IFJFU0VUVEFCTEVfQ0xBU1Mo
a2xhc3MpOw0KPiAgIA0KPiAgICAgICAvKiBpbnRlcm5hbCBkZXZpY2UgZm9yIHNlcmlhbGlv
L3NlcmlhbG1tLCBub3QgdXNlci1jcmVhdGFibGUgKi8NCj4gICAgICAgZGMtPnVzZXJfY3Jl
YXRhYmxlID0gZmFsc2U7DQo+ICAgICAgIGRjLT5yZWFsaXplID0gc2VyaWFsX3JlYWxpemU7
DQo+ICAgICAgIGRjLT51bnJlYWxpemUgPSBzZXJpYWxfdW5yZWFsaXplOw0KPiAgICAgICBk
ZXZpY2VfY2xhc3Nfc2V0X3Byb3BzKGRjLCBzZXJpYWxfcHJvcGVydGllcyk7DQo+ICsgICAg
cmMtPnBoYXNlcy5ob2xkID0gc2VyaWFsX3Jlc2V0X2hvbGQ7DQo+ICAgfQ0KPiAgIA0KPiAg
IHN0YXRpYyBjb25zdCBUeXBlSW5mbyBzZXJpYWxfaW5mbyA9IHsNCg0KUmV2aWV3ZWQtYnk6
IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCg0K

