Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D66E4E7716A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2024 06:10:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMLMF-0000Cw-FI; Sat, 14 Dec 2024 01:10:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tMLMD-0000Ce-Rz
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 01:10:29 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tMLM8-0000a2-CH
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 01:10:29 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2166022c5caso20367915ad.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 22:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734156623; x=1734761423; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OchTz7mVI7jz4AmIIhNXbDm/ZFziZTynF2lbi5lG6B8=;
 b=AcvkpE77pInu1JLYPq6V3m1fhiR9ghCApqqZkEjteh1v7BRDQEiq8jcj8qCBPaAnF+
 eolLEr1gyYtrep6wpvCa9Rt6SFZqCabIaNJJXcN0VfTr9G/zoNRBWa/vUtBNNsa8uPej
 U3DsXA2C3BF8P0dQX3lBpMkuYqR+xRrTjkOksAxC+8mHoBJzJ+zWvRTS8h6zLbu0My76
 0bqRBFwq57kamumTZskUUl8vi5Ig3/DSluwEIsumdu2+Y5yLak9E4y0MYNEI2q1xlW/l
 +FaybXnZ+pRA4LwmX5pHgDznWW/uqGZEMjKCwtrTHCKGEKyyk2itE+ba2Ja5pjG7BZxR
 xUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734156623; x=1734761423;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OchTz7mVI7jz4AmIIhNXbDm/ZFziZTynF2lbi5lG6B8=;
 b=ht3oK+QErrQ+hS2oqe3RyQUhavFETRDwnooVJUcSYpl6QEL5rbhrhr5vFa6Lr3ubv2
 IgScJILrHRFhBHxtu4PpzvNnz/3gUNLCaKjGvZCfJpzsI9RyuH1C4LhT4NnXCv+iUfae
 8H4au97ss3rvIHQ4rQeeMJWzvEbdbgTmof4GytwCWPzvqkuCvevB2MDsnVaUcD78uQWR
 I9O1OhRMBLCnV6PkNZC4oXPdd+udIUVU+6gtPUkmHD9KQDU8C0azzsMdneo1ie6w9G0c
 g59OAYm8spnT6dm3GgNNYR6JcUK5Icd4GnqM/F1qVNo8sgj5Te5094ZZHlXe/33iYCE3
 6TxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMjUJkDpnfGRYsgWbkdlL7C9Br39hpAQVvKHG+td49HOC9wA+DYKNYI7vlJFz8akxGajPfIhO1k4kE@nongnu.org
X-Gm-Message-State: AOJu0YzNZmCCtDJjw8PFrg/r19DlennTkRfv1mT8BFcrsTNHLYSxGWr7
 dxO0V28QUDcfenEMeALTUxvfigEMzSOZkoXk6wGI7snExp64Q30DrnIg2dmxkcV+ZD+5Nqk0RFh
 44RCwWQ==
X-Gm-Gg: ASbGncsmO+0eHT7fvEIKOLs7zrNt+s/3pfHW5LOM3GJ6dz4WG+c+yiCG1u28asVlmfY
 2q3qXlL5YQok534myJmFLslnktExsO9QS3etq0wmoSPLh5npyc0JFcZkHoCsb9JYTn06RFIIKvR
 Gr2TTKypK6TXUNpdB+Cj3F3h6bYWfxYRT+8+AZhY4UuJmiPHFdsA1BVl8/veeyebMazOA38/tco
 xA3NZwn/a/GkD6wVwjVAzS0/nea9WkDv7bTGp71wy75UmTy1wz1HJIt7696/Un8jm8xeeHJf40H
 ICa5tYkscy03slFwTO5+0xEEUGQD
X-Google-Smtp-Source: AGHT+IGkb5wX7LYa05QI6JlIefIoOOV8UHhyFaB6iIYZwpelM4gdfP4/xJGRKPk7AYL5Atyih6y10w==
X-Received: by 2002:a17:902:d2cd:b0:218:a43c:571e with SMTP id
 d9443c01a7336-218a43c5806mr19019915ad.28.1734156622693; 
 Fri, 13 Dec 2024 22:10:22 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1db74ccsm6724245ad.34.2024.12.13.22.10.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 22:10:22 -0800 (PST)
Message-ID: <03143045-f2f0-4fa6-95a8-b9b96a46416d@linaro.org>
Date: Fri, 13 Dec 2024 22:10:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: contrib/plugins does not build on 32-bit host
To: Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <dbb6dbf1-1ceb-48c0-8174-ee5dea7533dc@linaro.org>
 <718f3f80-eb3b-4d9b-b2a0-24946a8c5b79@linaro.org>
 <03bf8242-8dd7-43ae-a0a5-3f304aa546bd@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <03bf8242-8dd7-43ae-a0a5-3f304aa546bd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

T24gMTIvMTMvMjQgMjE6MjksIFJpY2hhcmQgSGVuZGVyc29uIHdyb3RlOg0KPiBPbiAxMi8x
My8yNCAyMTo0NCwgUGllcnJpY2sgQm91dmllciB3cm90ZToNCj4+IEhpIFJpY2hhcmQsDQo+
Pg0KPj4gT24gMTIvMTMvMjQgMTM6NDcsIFJpY2hhcmQgSGVuZGVyc29uIHdyb3RlOg0KPj4+
IEhpLA0KPj4+DQo+Pj4gU2V2ZXJhbCBvZiB0aGUgcmVjZW50IGNvbnRyaWIvcGx1Z2lucy8g
cGF0Y2hlcyBkbyBub3QgYnVpbGQgb24gZS5nLiBhcm0zMi4NCj4+PiBBbGwgb2YgdGhlIGlz
c3VlcyBhcmUgcmVsYXRlZCB0byBjYXN0aW5nIGJldHdlZW4gcG9pbnRlcnMgYW5kIHVpbnQ2
NF90OyB0aGVyZSBpcyBhIFdlcnJvcg0KPj4+IGdlbmVyYXRlZCBmb3IgY2FzdGluZyBiZXR3
ZWVuIHBvaW50ZXJzIGFuZCBpbnRlZ2VycyBvZiBkaWZmZXJlbnQgc2l6ZXMuDQo+Pj4NCj4+
PiBJIHN1c3BlY3QgYWxsIG9mIHRoZSBpbnN0YW5jZXMgd2lsbCBuZWVkIHRvIHVzZSBzZXBh
cmF0ZSBzdHJ1Y3R1cmVzIHRvIHN0b3JlIHVpbnQ2NF90DQo+Pj4gd2l0aGluIHRoZSBoYXNo
IHRhYmxlcy7CoCBUaGUgaGFzaCB2YWx1ZXMgdGhlbXNlbHZlcyBjYW4gdXNlIHVpbnRwdHJf
dCwgYXMgImhhc2giIGJ5DQo+Pj4gZGVmaW5pdGlvbiBsb3NlcyBkYXRhLg0KPj4+DQo+Pj4g
VGhlIGZvbGxvd2luZyBpcyAqbm90KiBhIHN1Z2dlc3RlZCBwYXRjaCwganVzdCB0b3VjaGVz
IGV2ZXJ5IHBsYWNlIHdpdGggYW4gZXJyb3IgdG8NCj4+PiBoaWdobGlnaHQgYWxsIG9mIHRo
ZSBwbGFjZXMuDQo+Pj4NCj4+DQo+PiBUaGlzIGlzIHNvbWV0aGluZyBJIGFscmVhZHkgdHJp
ZWQgdG8gZml4IHRoaXMgd2F5LCBidXQgYWxhcywgY2FzdGluZyB2YWx1ZXMgaXMgbm90IGVu
b3VnaCwNCj4+IHdlIG1pZ2h0IGxvc2UgaW5mb3JtYXRpb24gKGluIHRoZSBjYXNlIHdoZXJl
IGd1ZXN0IGlzIDY0IGJpdHMpLiBTb21lIHBsdWdpbnMgbmVlZCBhDQo+PiByZWZhY3Rvcmlu
ZyB0byBhbGxvY2F0ZSBkYXRhIGR5bmFtaWNhbGx5LCBpbnN0ZWFkIG9mIGhpZGluZyBpdCB1
bmRlciBhIHBvaW50ZXIuDQo+Pg0KPj4gU2VlIHRoaXMgcHJldmlvdXMgc2VyaWVzOg0KPj4g
aHR0cHM6Ly9wYXRjaGV3Lm9yZy9RRU1VLzIwMjQwODE0MjMzNjQ1Ljk0NDMyNy0xLXBpZXJy
aWNrLmJvdXZpZXJAbGluYXJvLm9yZy8NCj4+DQo+PiBGaW5hbGx5LCB3ZSBkaXNjdXNzZWQg
aXQgd2FzIG5vdCB3b3J0aCB0aGUgZWZmb3J0LCBhbmQgQWxleCBzaW1wbHkgZGVhY3RpdmF0
ZWQgcGx1Z2lucyBieQ0KPj4gZGVmYXVsdCBmb3IgMzIgYml0cyBwbGF0Zm9ybSwgc28gaXQg
c2hvdWxkIG5vdCBiZSBidWlsdCBmb3IgYXJtIDMyIGJpdHMuIElmIHdlIHJlYWxseSBoYXZl
DQo+PiBzb21lb25lIHRoYXQgbmVlZHMgdGhpcyB1c2VjYXNlLCB3ZSBtaWdodCBtYWtlIHRo
ZSBlZmZvcnQsIGJ1dCBmb3Igbm93LCBpdCBkb2VzIG5vdCBzZWVtDQo+PiB3b3J0aCB0aGUg
aGFzc2xlLg0KPiANCj4gSG1tLiAgSSBkaWRuJ3QgZGVsZXRlIG15IDMyLWJpdCBidWlsZCB0
cmVlLCBidXQgaXQgY2VydGFpbmx5IHJlLWNvbmZpZ3VyZWQuICBJZiBwbHVnaW5zDQo+IGFy
ZSBzdXBwb3NlZCB0byBiZSBkaXNhYmxlZCwgc29tZXRoaW5nIG1heSBiZSB3cm9uZyB0aGVy
ZS4uLg0KPg0KDQpUaGUgMzIgYml0cyBjaGVjayBpcyBkb25lIGluIHRoZSBjb25maWd1cmUg
c2NyaXB0LCBub3QgaW4gbWVzb24gcGFydC4NCiBGcm9tIGEgY2xlYW4gc291cmNlIHRyZWUs
IG9uIGEgYXJtaGYgbWFjaGluZSwgaXQgaXMgZGVhY3RpdmF0ZWQgYXMgDQpleHBlY3RlZC4N
Cg0KPiANCj4gcn4NCg0K

