Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D106D58D69
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 16:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFcMn-00009I-8m; Mon, 25 Nov 2024 11:55:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tFcMl-00008W-QT
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 11:55:15 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tFcMj-00080d-O1
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 11:55:15 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21260cfc918so32898815ad.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 08:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732553712; x=1733158512; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zc82MiK/JkYljK345qg6O1Q+tMFI7BEg9vg2UdNytps=;
 b=SUFvdhnpHVYMCWDCOMr/UTKxJBMtouf7PMFeP38gg+RQXAHkcu0GyMlCV7G5RTsVMd
 zXVIwy+c6XBwA+AmjgpAXJZ10ONwIaq1lwi/aWT3dHWtgLZBiAzyVORzoT1CHD2SLwvT
 1gLrLVo5w0T27iUai+JtWKiAvor4k0cWb4gCuCij3e2XmsWxM7w0Fa4lfIT9fURqDpGd
 wYFcXD/6J3EqFYEXc2SknBbgTbwr2RxQb3tMMvrzv9AzxwkOPwY98hIc09ot2SJ20DPp
 kdaHaKebaGmWItcXBSYpJvZAumsAqTBUGTSOvxGpfJJPB5LecDyoY79Khw7VRHrC/HcJ
 PrqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732553712; x=1733158512;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zc82MiK/JkYljK345qg6O1Q+tMFI7BEg9vg2UdNytps=;
 b=VONJMDz7mGWaqq/4+q8ClwoLZqgPk5Diur4VPo6cg4IthI4cRqsNVWEe9BcEwcd+Us
 niIpZvPxrVTSGpNnE9HA/zU8KFKYSQYvnqA8yTeIA3k0qTWSCknaU6zoiW8nzQkRc+Cd
 LpUaMNCfqUBEke0tPkGzKwXPC8xGgl7bMEtfE4BsCFb+8ncL+CWo76rnm9Nc6DRjdyew
 bpWAWhpcaZEOrVA89nHZ1YxvR91JYnrFyLAkmKuKsVY+xmhgO+WY2MX0ZAVqENIdj5qH
 xgOlL2utLlZK9rm0mzw4r2XqZG6H2fyaQVE2i1aSC4fx8e7tmH2zs0tJzpU4RjUvODrC
 osMA==
X-Gm-Message-State: AOJu0YzatyMSGqgm+NjoibKczL5+MxYceGDK38oyJ99DGblQ684XTXPo
 lsk1uHjOA9p093Fl3nhEFdu72IuLcrIOGQrDLd4o8kJL26rZrFXU7rOvYHqbmM0=
X-Gm-Gg: ASbGnctDtrxMj767iFK8ARc3ZDIccHBcU/R0RmK7Ip2fQTRBg1r0EmvovvNJAYlmGmw
 P98BuZkmWJVdvq14Df1TJskqheU3OWwGcqhAcCJSaXwG2zITKmaCJlKflCaSyBrYu3rKlEbw3BV
 NeIY2I6ujHZXKqGbJzsF9bUNa+Nyt4zVgQzQAtTJPNTtDSnCpkDtEvSoJ3jKyULNi4+s/dopJeB
 3S1eKDXs/RO4/rYE8is+rd6X5M8xZF14JlS1nzYrid3rVGb9uV1/XoD5LvcU73zAPDJKjSpGfbD
 UUz/jPXii4+9TuaC6jGdeQ==
X-Google-Smtp-Source: AGHT+IH33AqXbjnaLMxMKpJDYdJMTr4JDSbYMoB9gVY6mL+tg6Q1TKUUg+NepGXoJJIrr/cztZgPuA==
X-Received: by 2002:a17:902:db03:b0:20c:8f98:5dbe with SMTP id
 d9443c01a7336-2129f7c3b81mr153897625ad.33.1732553711774; 
 Mon, 25 Nov 2024 08:55:11 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129dc2bd79sm65565035ad.281.2024.11.25.08.55.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Nov 2024 08:55:11 -0800 (PST)
Message-ID: <55e0ff78-765e-4db7-9406-e8a42679c1c6@linaro.org>
Date: Mon, 25 Nov 2024 08:55:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Supporting clang on windows
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <66c346de-7e20-4831-b3eb-1cda83240af9@linaro.org>
 <b045c676-4722-4fb9-a800-27c92d832347@redhat.com>
 <c8ec9243-f489-4b91-946e-2c6ff7e36f71@linaro.org>
 <CABgObfbpEEHbLYNNXoNUwD0VNPiNAYB-9REqgEFhRz3QQKTZYw@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CABgObfbpEEHbLYNNXoNUwD0VNPiNAYB-9REqgEFhRz3QQKTZYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

T24gMTEvMjQvMjQgMjM6MDAsIFBhb2xvIEJvbnppbmkgd3JvdGU6DQo+IE9uIFN1biwgTm92
IDI0LCAyMDI0IGF0IDk6MjPigK9QTSBQaWVycmljayBCb3V2aWVyDQo+IDxwaWVycmljay5i
b3V2aWVyQGxpbmFyby5vcmc+IHdyb3RlOg0KPiAqIHRoZXJlIGlzIG5vIHB1c2hiYWNrIGFn
YWluc3QgY2xhbmcgc3VwcG9ydCwgdGhlcmUgaXMgcHVzaGJhY2sNCj4gYWdhaW5zdCBhc2tp
bmcgZm9yIGEgY2hhbmdlIHdpdGhvdXQgdW5kZXJzdGFuZGluZyB0aGUgcHJvYmxlbQ0KPg0K
DQpUaGFua3MgZm9yIHRha2luZyB0aW1lIHRvIHNoYXJlIG1vcmUgaW5zaWdodHMgYWJvdXQg
aXQuDQoNCj4gQXMgYW4gYXNpZGUsIGF0IGh0dHBzOi8vZ2l0aHViLmNvbS9tc3lzMi9NSU5H
Vy1wYWNrYWdlcy9wdWxsLzIxNTQwIHlvdQ0KPiBzYWlkICJJIHRoaW5rIHRvbyBpdCdzIG1v
cmUgYSBGVUQgYXJndW1lbnQgdGhhbiBhIHJlYWwgcHJvYmxlbSIsIHdoaWNoDQo+IGlzIGEg
Yml0IHRvbyBkaXNtaXNzaXZlLiBJZiBhbnl0aGluZyBpdCdzIGEgY2FzZSBvZiAib25jZSBi
aXR0ZW4sDQo+IHR3aWNlIHNoeSIuDQo+DQoNClRoZXJlIHdhcyBubyBpbnRlbnRpb24gdG8g
aGF2ZSBhIHBlcnNvbmFsIGp1Z2RtZW50LCBub3QgYmxhbWUgYW55b25lLCANCmFuZCBJIGhv
cGUgeW91IGRpZG4ndCB0YWtlIGl0IHRoaXMgd2F5LiBJZiB0aGF0J3MgdGhlIGNhc2UsIHNv
cnJ5IGFib3V0IA0KdGhhdC4NCg0KRlVEIGFwcGxpZXMgd2hlbiBGZWFyIGFuZCBVbmNlcnRh
aW50eSBhcHBsaWVzLCBhbmQgaXQncyBkZWZpbml0ZWx5IHdoZXJlIA0Kd2UgYXJlIG9uIHRo
aXMgLSB3ZSBmZWFyIHNvbWV0aGluZyBmcm9tIGEgcGFzdCBleHBlcmllbmNlLCBhbmQgd2Ug
YXJlIA0KdW5jZXJ0YWluIGFib3V0IHRoZSBjdXJyZW50IHN0YXR1cy4gSSB0b3RhbGx5IHVu
ZGVyc3RhbmQgdGhhdCdzIGEgdmVyeSANCmhhcmQgaXNzdWUgdG8gZGlhZ25vc2Ugd2hlbiB5
b3UgbWVldCB0aG9zZSBraW5kIG9mIG1lbW9yeSBsYXlvdXQgYnVncy4NCg0KPiBJIHVuZGVy
c3RhbmQgdGhhdCwgYW5kIEknbSBhc2tpbmcgeW91IHRvIGRvIGFub3RoZXIgZXhwZXJpbWVu
dC4gRG8gbm90DQo+IGNoYW5nZSB0aGUgY29tcGlsZS10aW1lIG9wdGlvbnMuIEluc3RlYWQs
IGNoYW5nZSBRRU1VX1BBQ0tFRCB0byBqdXN0DQo+IA0KPiAjZGVmaW5lIFFFTVVfUEFDS0VE
IF9fYXR0cmlidXRlX18oKHBhY2tlZCkpDQo+IA0KPiBhbmQgc2VlIGlmIGFueSBzdHJ1Y3Qg
ZGVmaW5pdGlvbnMgKHdoaWNoIHdpbGwgYWxsIGZvbGxvdyB0aGUgbXNfc3RydWN0DQo+IHJ1
bGVzKSBjaGFuZ2UuIElmIHRoZXJlIGFyZSBjaGFuZ2VzLCBsZXQncyBleGFtaW5lIHdoYXQg
dGhleSBhcmUgYW5kDQo+IHdoeSBteSBhbmFseXNpcyBhYm92ZSB3YXMgaW5jb3JyZWN0LiBG
aXggdGhvc2UgY2FzZXMsIGFkZA0KPiBRRU1VX0JVSUxEX0JVR19PTiBjaGVja3Mgb25seSB0
byB0aGUgYWZmZWN0ZWQgc3RydWN0cywgYW5kIG9uY2UgeW91J3ZlDQo+IGFkZHJlc3NlZCBh
bnkgZGlmZmVyZW5jZXMgKGlmIHRoZXkgZXhpc3QpLCB5b3UgY2FuIHByb2NlZWQgd2l0aA0K
PiBkcm9wcGluZyBnY2Nfc3RydWN0IHNpbmNlIHRoZXJlIHdpbGwgYmUgY29uY3JldGUgZXZp
ZGVuY2UgcHJvdmluZyBpdCdzDQo+IHNhZmUuDQo+DQoNCkkgZGlkbid0IGV4cGVjdCB0aGUg
aXNzdWUgb2Ygb3VyIGNvbnZlcnNhdGlvbiB3b3VsZCBiZSB0byBnZXQgcmlkIG9mIA0KZ2Nj
X3N0cnVjdCBlbnRpcmVseS4gVGhhbmtzIGZvciBwdXNoaW5nIGluIHRoZSByaWdodCBkaXJl
Y3Rpb24uDQoNCkkgYW5zd2VyZWQgbGF0ZXIgb24gdGhpcyB0aHJlYWQgZm9yIHRoaXMsIGFu
ZCBpdCdzIGEgdmVyeSBwb3NpdGl2ZSANCmNvbmNsdXNpb246IG5vIGRpZmZlcmVuY2Ugd2Fz
IGZvdW5kIHdpdGgvd2l0aG91dCBnY2Nfc3RydWN0IGF0dHJpYnV0ZS4NCg0KPiBQYW9sbw0K
PiANCg0KVGhhbmtzLA0KUGllcnJpY2sNCg==

