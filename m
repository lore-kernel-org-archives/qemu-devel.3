Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B46D6C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 20:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7KHm-0004Gs-El; Tue, 22 Apr 2025 16:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7KHj-0004Cb-HX
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 16:32:03 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7KHh-0004ry-ID
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 16:32:03 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2260c91576aso49237095ad.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 13:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745353920; x=1745958720; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V3QrtJKrNuWUOlIY6aVS4Af5l6Rw05lMs1vEb1nhXY8=;
 b=Qc6YCMgjLbiBvnKtt12CZllGikWZc609utdz9CKbRmbkArVHsPavhrB/2Z8yoS89g3
 OEKTcTXB+jRGAD8ZHRD0Y+bj1M9M4Nj3AXV84LPIHVwGAtLg4GhG7BOHrjSyPRd3WUJy
 oQcbqMwTCzCTfUjmX+795P5PnuC56e9qLzXxXCuUyUhPVG9erv71KJJ3Z0E4eDFBED7A
 rCtR4NWDMHA9pd7g+4FjPP9KIZsxljIFw3foHaH5mEEHYuDB/nLa9iZRYfDuHI3hskdR
 6KE+bEN1MjaVtEXllzen9m9RXUutVPf4+fltd3NwSYfxo5/FbG/saZJ7mLiVB0vFa2ZD
 2eAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745353920; x=1745958720;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V3QrtJKrNuWUOlIY6aVS4Af5l6Rw05lMs1vEb1nhXY8=;
 b=vzpqVFr78qady/zmzYxcNXkAxyT9N9/hfv1tdrIbHLZe8zSFe4Ra3eDOOBsVZIw5ab
 M+fhGWRF5lgQpmgkoIi/vAQyBZkGbU5AcnrOLiLOd6e2DBwu0ZKJq0Fpedy3OF3oL58Z
 2Ba77y1O772a5tlzyLglmIiRKeVMNnDXvtQffW6y5tJ10in+nYahop4ySnHl7ZQOIkuL
 +NizAWpIaE3tAZt5nOzlLpYthlQl5VUZZ6TeNsMN5JgXUFVRMaGA8QQOoE2Lk1HQQo9Z
 5fb8Y2Gx3DI2BaNhMYt1BU1TGmdzrlBLAMru6ITO3Q8epDeQN2apzEPfyFKS6Hughp9S
 mErg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWShZDx2fS5UC530MewJEU0qFjUygb2TRldeS/W/C6tPyU+UPebCoR14XtM0rr6i5+w/jq6FutReIwg@nongnu.org
X-Gm-Message-State: AOJu0Yz5biT6fccn7VycVhhRNwEm/W5KEBrgxlnRZah2b1PfdhwelSTM
 KQl4k/hUOoDWRFhqdb1IqZl8G0izazJeotAYQKm6tVqrD0n7+gbkfICVuG/Lauw=
X-Gm-Gg: ASbGncvbqxq8d5aY9xgYxTZr6jK1K9sS40rEeeRzNtZRs/9d4OoUP4+LCouy8pgsJMl
 2s3nFTNNnQ583jM1t+cWGlY8AlVrGAROLcNOi1p9sUoC6Vi71BMwX5ywOUYm15LOuwZBCptRvJb
 im2fC8gCeeJflQUrb0tbOghJD007z2fBJtlAoXphl/rtMfrqD0aIaoIH49XbXRWmgBXmDw0MrzN
 vvyEm1iHz8m5J3bDdwoQo60pII/lNwQKEMlgvQsRduICUXK5AZyN7HiUBwMOgLrQy8vHhAgktPu
 Hyi5xsa9XuceWLfIYYfACEgyki0FKMxkNyaGGvQrFPY2JzyF/z4o3A==
X-Google-Smtp-Source: AGHT+IFyXAldoBPHtb/bThb0DZHU1iG1QgbwUyPBUQEKHs8aZXU6PxGnsRCuzvOXQrxl1ogw6FTO7w==
X-Received: by 2002:a17:903:2304:b0:22c:3294:f038 with SMTP id
 d9443c01a7336-22c5359e53cmr231638245ad.18.1745353919800; 
 Tue, 22 Apr 2025 13:31:59 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb4613sm89808945ad.135.2025.04.22.13.31.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 13:31:59 -0700 (PDT)
Message-ID: <64d0d267-aa1f-4f61-b902-dcbbd89420d6@linaro.org>
Date: Tue, 22 Apr 2025 13:31:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] buildsys: Disable 'unguarded-availability-new'
 warnings
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20250422171955.11791-1-philmd@linaro.org>
 <7de6ad37-d62f-4e66-b660-034b69fb5938@linaro.org>
 <94dabfd0-e104-432d-9793-2f44d361ddc9@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <94dabfd0-e104-432d-9793-2f44d361ddc9@linaro.org>
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

T24gNC8yMi8yNSAxMjo0NSwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE9u
IDIyLzQvMjUgMjA6MzYsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBPbiA0LzIyLzI1
IDEwOjE5LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4+PiBXaGVuIHVzaW5n
IFZpc3VhbCBTdHVkaW8gQ29kZSAodjEuOTkuMykgYW5kIEFwcGxlIGNsYW5nZCB2MTcuMC4w
DQo+Pj4gSSBnZXQ6DQo+Pj4NCj4+PiAgwqDCoCBJbiBmaWxlIGluY2x1ZGVkIGZyb20gLi4v
Li4vcWFwaS9zdHJpbmctb3V0cHV0LXZpc2l0b3IuYzoxNDoNCj4+PiAgwqDCoCBxZW11L2lu
Y2x1ZGUvcWVtdS9jdXRpbHMuaDoxNDQ6MTI6IGVycm9yOiAnc3RyY2hybnVsJyBpcyBvbmx5
DQo+Pj4gYXZhaWxhYmxlIG9uIG1hY09TIDE1LjQgb3IgbmV3ZXIgWy1XZXJyb3IsLVd1bmd1
YXJkZWQtYXZhaWxhYmlsaXR5LW5ld10NCj4+PiAgwqDCoMKgwqAgMTQ0IHzCoMKgwqDCoCBy
ZXR1cm4gc3RyY2hybnVsKHMsIGMpOw0KPj4+ICDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIF5+fn5+fn5+fg0KPj4+ICDCoMKgIC9MaWJyYXJ5L0RldmVsb3Bl
ci9Db21tYW5kTGluZVRvb2xzL1NES3MvTWFjT1NYLnNkay91c3IvaW5jbHVkZS8NCj4+PiBf
c3RyaW5nLmg6MTk4Ojk6IG5vdGU6ICdzdHJjaHJudWwnIGhhcyBiZWVuIG1hcmtlZCBhcyBi
ZWluZyBpbnRyb2R1Y2VkDQo+Pj4gaW4gbWFjT1MgMTUuNCBoZXJlLCBidXQgdGhlIGRlcGxv
eW1lbnQgdGFyZ2V0IGlzIG1hY09TIDE1LjAuMA0KPj4+ICDCoMKgwqDCoCAxOTggfMKgwqDC
oMKgwqDCoMKgwqAgc3RyY2hybnVsKGNvbnN0IGNoYXIgKl9fcywgaW50IF9fYyk7DQo+Pj4g
IMKgwqDCoMKgwqDCoMKgwqAgfMKgwqDCoMKgwqDCoMKgwqAgXg0KPj4+ICDCoMKgIHFlbXUv
aW5jbHVkZS9xZW11L2N1dGlscy5oOjE0NDoxMjogbm90ZTogZW5jbG9zZSAnc3RyY2hybnVs
JyBpbiBhDQo+Pj4gX19idWlsdGluX2F2YWlsYWJsZSBjaGVjayB0byBzaWxlbmNlIHRoaXMg
d2FybmluZw0KPj4+ICDCoMKgwqDCoCAxNDQgfMKgwqDCoMKgIHJldHVybiBzdHJjaHJudWwo
cywgYyk7DQo+Pj4gIMKgwqDCoMKgwqDCoMKgwqAgfMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Xn5+fn5+fn5+DQo+Pj4gIMKgwqAgMSBlcnJvciBnZW5lcmF0ZWQuDQo+Pj4NCj4+PiBEaXNh
YmxlIHRoaXMgLVd1bmd1YXJkZWQtYXZhaWxhYmlsaXR5LW5ldyB3YXJuaW5nIGFzIGENCj4+
PiBzaG9ydCB0ZXJtIGJhbmQtYWlkIGZpeC4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IFBo
aWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj4+PiAtLS0NCj4+
PiAgwqAgbWVzb24uYnVpbGQgfCAyICsrDQo+Pj4gIMKgIDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKykNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9tZXNvbi5idWlsZCBiL21lc29u
LmJ1aWxkDQo+Pj4gaW5kZXggNDFmNjhkMzgwNjkuLjUzOTM2OGY4MmIxIDEwMDY0NA0KPj4+
IC0tLSBhL21lc29uLmJ1aWxkDQo+Pj4gKysrIGIvbWVzb24uYnVpbGQNCj4+PiBAQCAtNzM1
LDYgKzczNSw3IEBAIHdhcm5fZmxhZ3MgPSBbDQo+Pj4gIMKgwqDCoCAnLVdzdHJpY3QtcHJv
dG90eXBlcycsDQo+Pj4gIMKgwqDCoCAnLVd0eXBlLWxpbWl0cycsDQo+Pj4gIMKgwqDCoCAn
LVd1bmRlZicsDQo+Pj4gK8KgICctV3VuZ3VhcmRlZC1hdmFpbGFiaWxpdHknLA0KPj4+ICDC
oMKgwqAgJy1XdmxhJywNCj4+PiAgwqDCoMKgICctV3dyaXRlLXN0cmluZ3MnLA0KPj4+IEBA
IC03NDcsNiArNzQ4LDcgQEAgd2Fybl9mbGFncyA9IFsNCj4+PiAgwqDCoMKgICctV25vLXN0
cmluZy1wbHVzLWludCcsDQo+Pj4gIMKgwqDCoCAnLVduby10YXV0b2xvZ2ljYWwtdHlwZS1s
aW1pdC1jb21wYXJlJywNCj4+PiAgwqDCoMKgICctV25vLXR5cGVkZWYtcmVkZWZpbml0aW9u
JywNCj4+PiArwqAgJy1Xbm8tdW5ndWFyZGVkLWF2YWlsYWJpbGl0eS1uZXcnLA0KPj4+ICDC
oCBdDQo+Pj4gIMKgIGlmIGhvc3Rfb3MgIT0gJ2RhcndpbicNCj4+DQo+PiBJIHNvbHZlZCBp
dCB0aGUgc2FtZSB3YXkgbG9jYWxseSwgYnV0IGRpZG4ndCBzZW5kIGEgcGF0Y2ggYmVjYXVz
ZSBJJ20NCj4+IG5vdCBzdXJlIHdoYXQgaGFwcGVucyBpZiB0aGUgY29kZSBydW5zIG9uIE1h
Y09TIDwgMTUuNCwNCj4gDQo+IEknZCBleHBlY3QgbWVzb24gdG8gRG8gVGhlIFJpZ2h0IFRo
aW5nIGFuZCBub3QgZGVmaW5lIEhBVkVfU1RSQ0hSTlVMLg0KPiANCg0KVGhlIHRyaWNrIGlz
IHRoYXQgaXQgY29tcGlsZXMgd2l0aCBhIHdhcm5pbmcsIGJ1dCBtZXNvbiB0ZXN0cyBhcmUg
bm90IA0KZG9uZSB3aXRoIC1XZXJyb3IgZW5hYmxlZC4NClRoaXMgbWlnaHQgYmUgdGhlIHBy
b3BlciBmaXggYXQgdGhlIG1vbWVudCwgaWYgd2UgaWRlbnRpZnkgdGhhdCBhIGNyYXNoIA0K
aGFwcGVuIG9uIE1hY09TIDwgMTUuNC4gRWxzZSwgdGhlIHdhcm5pbmcgY2FuIHNhZmVseSBi
ZSBzaWxlbmNlZCBhcyB5b3UgZGlkLg0KDQo+PiBhbmQgSSBkb24ndCBoYXZlDQo+PiBzdWNo
IGEgbWFjaGluZSBhdmFpbGFibGUuDQo+Pg0KPj4gSXMgdGhlIHN5bWJvbCBhbHJlYWR5IHRo
ZXJlPw0KPj4gRG9lcyBpdCBjcmFzaD8NCj4+IEkgZ3Vlc3MgdGhlIHdhcm5pbmcgaXMgaGVy
ZSBmb3IgYSBnb29kIHJlYXNvbi4NCj4+DQo+PiBZb3UgY2FuIGZpbmQgYSBsb3Qgb2YgaXNz
dWVzIG9wZW4gaW4gdmFyaW91cyBvcGVuIHNvdXJjZSBwcm9qZWN0cyB3aXRoDQo+PiB0aGlz
IHdhcm5pbmcgKHdpdGggdmFyaW91cyBmaXhlcykgc2luY2UgdGhpcyB1cGRhdGUgd2FzIHJl
bGVhc2VkLg0KPiANCg0K

