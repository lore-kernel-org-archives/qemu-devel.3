Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D0BC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 23:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYvhg-0007nP-Rn; Fri, 17 Jan 2025 18:24:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tYvhf-0007nA-GT
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 18:24:39 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tYvhd-0003v2-TF
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 18:24:39 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2163dc5155fso51032225ad.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 15:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737156276; x=1737761076; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LCZe3MZM/FNHgUKn4zJKVqSHTqao4KOZNDDGg0Y2PUg=;
 b=KRyFo8QzM2uMmPWTwgkEsrhaw/KKy9sT2bA4A3Rt2BFkABljciXdTcIbmSdJdCOTpo
 NE7GGAzkwBRJzmxKX53zlT4oZvPB2ufcLPdbaunYzSNPlLShQBHhF/lDnP600XYYdLtU
 hdH+181WakvvH10IcSslWFNLzV/Ku/gUZTf4Qd8cZGzxlT7WUYW5Hu40ZLwuaxkp2tqS
 3IGVEREKVNsfO10U+7rG/O8AvHaGIuYTmVVK5H6WuCP7zZaxPQaxZujv0j6xPoDGqHbW
 sJrohRocopJiXaYN3HNepzv04kyW5dm4vwcHrXg+gneWMBBlPezBYNPRZ2pvdpaX4p59
 zS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737156276; x=1737761076;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LCZe3MZM/FNHgUKn4zJKVqSHTqao4KOZNDDGg0Y2PUg=;
 b=p3PJrTmbdn7Yaf8rzzZG6jWiXZ/mappEHlotCxYfWYk0DS+fSiLZnL2EGtXr5FXBYP
 JHPFSOqN0+G9IAP5uUQAwOXKXUx0WAoPbXdmpATA8gLFro7PIxJ4DLIf4QQ8TA1XvExB
 TGnzZg5PX1CZfPQ3UaGRaQwz/Ezo4VKTJnlxVzvABhjxk5hygnmEKTH1nG5YN/IB6Wb9
 w8ZwszJEotUyCpSozf2QqOrpYzOyKc2IjwL8eTh8PASgxg2QmaWCXFqsbZLVcDnURaBT
 XeIsJRw1wxEyTi0qV4a+qBsuc9KvATwCX6sslmmDIbZuQAGYb7TQjO/CjMBzW/NbqJTo
 b02A==
X-Gm-Message-State: AOJu0YymocFSZQtTwb2BTPTeBs1Jwut8IHZnbdgBOs7xjs6qV/SN+QG5
 ywcZZnS7H2rzlVvPFo1jE2BITwRx+jENdGPMWzGdJT/xPuN11UMGkF0uh48VAZk=
X-Gm-Gg: ASbGncuiiguz5FHz0np/F6pkHTQW6fcf7makp3ThoHn99J+F+D7PP3OLkTULH+Rqs7P
 pwXzZmsNRYSk5O9IiZlmwwXjVDGKutE2Gj15waDO95vA1Nq4tw/dES2m2DRtEdytA2Qm4e7DsHk
 WCG3VMDhf+e6r4+CxdxGljCK/xoCZlL6agWEc5gNIv1EFx+ZguIaHGafuY1qjdEWdbQr9vpTzBQ
 IFCiMSDPOnpcycEdl+kpHIZtbH4mrlhdFxgp4hSHYF/6DT7Uv2mKr7fSIojcB0H/ZY8f7Qle/Wt
 4aG7O34=
X-Google-Smtp-Source: AGHT+IGNLYkxuqWv8T+sgBAlYR9J7PNjADQTdq1FczMro4i0AwQKwwlRXvuxid/OP3gQCp5VmSqsvA==
X-Received: by 2002:a05:6a00:6088:b0:72a:a9b5:ed91 with SMTP id
 d2e1a72fcca58-72daf99ed03mr6692083b3a.13.1737156275957; 
 Fri, 17 Jan 2025 15:24:35 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72dab7f06b8sm2562261b3a.16.2025.01.17.15.24.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2025 15:24:35 -0800 (PST)
Message-ID: <14a5c74b-fa4a-41fc-bbf6-caad48b63c6f@linaro.org>
Date: Fri, 17 Jan 2025 15:24:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] plugins: fix -Werror=maybe-uninitialized false-positive
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20250114104820.2613099-1-marcandre.lureau@redhat.com>
 <33501d8b-0035-404a-88ee-c6ff64c237a4@linaro.org>
 <CAMxuvaxg_oTJyrWS7HU8F3MP==eVz_9dDogZ_ihHwCX_YX9Sfw@mail.gmail.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAMxuvaxg_oTJyrWS7HU8F3MP==eVz_9dDogZ_ihHwCX_YX9Sfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

SGkgTWFyYy1BbmRyw6ksDQoNCkkgY291bGQgc3VjY2Vzc2Z1bGx5IGJ1aWxkIGFsbCB0YXJn
ZXRzIHdpdGggZ2NjIDE0LjIuMCAodXNpbmcgYSBkZWJpYW4gDQpzaWQgY29udGFpbmVyKSB3
aXRoIHVic2FuIGFuZCBhc2FuIGVuYWJsZWQsIGFuZCB3aXRoIC1PMi4NCg0KUGllcnJpY2sN
Cg0KT24gMS8xNC8yNSAyMjo0MCwgTWFyYy1BbmRyw6kgTHVyZWF1IHdyb3RlOg0KPiBIaQ0K
PiANCj4gT24gVHVlLCBKYW4gMTQsIDIwMjUgYXQgODowMOKAr1BNIFBpZXJyaWNrIEJvdXZp
ZXINCj4gPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4gd3JvdGU6DQo+Pg0KPj4gT24g
MS8xNC8yNSAwMjo0OCwgbWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tIHdyb3RlOg0KPj4+
IEZyb206IE1hcmMtQW5kcsOpIEx1cmVhdSA8bWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29t
Pg0KPj4+DQo+Pj4gLi4vY29udHJpYi9wbHVnaW5zL2NhY2hlLmM6NjM4Ojk6IGVycm9yOiDi
gJhsMl9jYWNoZeKAmSBtYXkgYmUgdXNlZCB1bmluaXRpYWxpemVkIFstV2Vycm9yPW1heWJl
LXVuaW5pdGlhbGl6ZWRdDQo+Pj4gICAgIDYzOCB8ICAgICAgICAgYXBwZW5kX3N0YXRzX2xp
bmUocmVwLCBsMV9kbWVtX2FjY2Vzc2VzLCBsMV9kbWlzc2VzLA0KPj4+ICAgICAgICAgfCAg
ICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn4NCj4+Pg0KPj4+IElzIGEgZmFsc2UtcG9zaXRpdmUsIHNpbmNlIGNvcmVzID4gMSwg
c28gdGhlIHZhcmlhYmxlIGlzIHNldCBpbiB0aGUNCj4+PiBhYm92ZSBsb29wLg0KPj4+DQo+
Pj4gU2lnbmVkLW9mZi1ieTogTWFyYy1BbmRyw6kgTHVyZWF1IDxtYXJjYW5kcmUubHVyZWF1
QHJlZGhhdC5jb20+DQo+Pj4gLS0tDQo+Pj4gICAgY29udHJpYi9wbHVnaW5zL2NhY2hlLmMg
fCAyICstDQo+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvY29udHJpYi9wbHVnaW5zL2NhY2hlLmMg
Yi9jb250cmliL3BsdWdpbnMvY2FjaGUuYw0KPj4+IGluZGV4IDUxMmVmNjc3NmIuLmMyYzI3
NGNmY2QgMTAwNjQ0DQo+Pj4gLS0tIGEvY29udHJpYi9wbHVnaW5zL2NhY2hlLmMNCj4+PiAr
KysgYi9jb250cmliL3BsdWdpbnMvY2FjaGUuYw0KPj4+IEBAIC02MDksNyArNjA5LDcgQEAg
c3RhdGljIGludCBsMl9jbXAoZ2NvbnN0cG9pbnRlciBhLCBnY29uc3Rwb2ludGVyIGIpDQo+
Pj4gICAgc3RhdGljIHZvaWQgbG9nX3N0YXRzKHZvaWQpDQo+Pj4gICAgew0KPj4+ICAgICAg
ICBpbnQgaTsNCj4+PiAtICAgIENhY2hlICppY2FjaGUsICpkY2FjaGUsICpsMl9jYWNoZTsN
Cj4+PiArICAgIENhY2hlICppY2FjaGUsICpkY2FjaGUsICpsMl9jYWNoZSA9IE5VTEw7DQo+
Pj4NCj4+PiAgICAgICAgZ19hdXRvcHRyKEdTdHJpbmcpIHJlcCA9IGdfc3RyaW5nX25ldygi
Y29yZSAjLCBkYXRhIGFjY2Vzc2VzLCBkYXRhIG1pc3NlcywiDQo+Pj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIiBkbWlzcyByYXRlLCBpbnNuIGFj
Y2Vzc2VzLCINCj4+DQo+PiBCeSB0aGUgd2F5LA0KPj4NCj4+IHdoaWNoIGNvbXBpbGVyICh2
ZXJzaW9uPykgYXJlIHlvdSB1c2luZz8NCj4+IEp1c3QgY3VyaW91cyB0byBjaGVjayBpZiB3
ZSBkb24ndCBoYXZlIGFueSBvdGhlciBmYWxzZSBwb3NpdGl2ZXMgaW4gdGhlDQo+PiBjb2Rl
IGJhc2Ugd2l0aCBpdCBpZiBpdCdzIGEgbmV3ZXIgdmVyc2lvbi4NCj4gDQo+IA0KPiBHQ0Mg
djE0LjIuMSBmcm9tIGZjNDEuDQo+IEkgdXNlICctLWVuYWJsZS1kZWJ1ZycgJy0tZW5hYmxl
LWFzYW4nICctRG9wdGltaXphdGlvbj1nJw0KPiAnLURkZWJ1Zz10cnVlJyBpbiBteSBjb25m
aWd1cmUgZmxhZ3MuDQo+IEFsbCB0YXJnZXRzIGRvIG5vdCBjb21waWxlIHdpdGggdGhvc2Ug
ZmxhZ3MuDQo+IEFTQU4gcmVwb3J0cyB2YXJpb3VzIGVycm9ycyBkdXJpbmcgbWFrZSB0ZXN0
Lg0KPiANCj4gSGVscCB3ZWxjb21lIQ0KPiANCg0K

