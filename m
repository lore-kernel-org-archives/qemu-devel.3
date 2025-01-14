Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6601C02185
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 16:01:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXjLO-00055R-Ms; Tue, 14 Jan 2025 11:00:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tXjLD-00052n-2B
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 11:00:31 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tXjL9-0000t0-T6
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 11:00:30 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-219f8263ae0so93926125ad.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 08:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736870423; x=1737475223; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MYkdOYTFxmOiHWh6guosbnEUmxlN45TzyNLZXo2vGd8=;
 b=IZM3kcCkBOuhkXPKYC8BGk4tnqGzPsYBy8Eh34S5haXKyoXdraAfLfdQyrSN/aAbkZ
 udEuMFBGad2ynMgums25THffj/jsynRsI+x1l6aC+IPoWuoA8QW5oUxsOJwxdTdRKZPZ
 xWEsEdgDG4Lhrj5Ba1EDFY5HiVcN2k25rqqpQ08lnbQ+nR/qKFYleQ8WUNhNBz8cjYUz
 gDLTkkrOlaZSpWBWlMyb+nCSVCfLnPRASLN4D6gZWCIlCefHEd8G/BJk2O4r6f1PCF6F
 2qZK5gjWz/xWXYKhbPMgLQMktCZbzLIZYnzw9EE0eou7GKDQvYw5U4yrBeATdskTXBDi
 v6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736870423; x=1737475223;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MYkdOYTFxmOiHWh6guosbnEUmxlN45TzyNLZXo2vGd8=;
 b=ra+fJ75+JbX12fBP6WhD6zQDrbw3+C4J1wpG221qkLDulOSYeN/0f9n6ySq6XuTBFu
 GDMPJEVcLIvQfV05of+zDNkuFQtUzyK12dlCQJYMbUk3oszPgk+Xx+NSAeiv1uqfh8Pk
 SUFQmi4834nY2yedZVKDlke7ST3aV6jVDP26ZPu7Bd1Be9K1ACp0vg1W2mwmupk0hmJI
 /r/h0G57bL/BaUS5ps8SIgYSoiGvoilknfzIYgFrKKIp3ika0qI5OZKQq2DqWcO92hCH
 4vfOecqJ0lDurD29xVgQ8nIO+uDCHGRia03R1oLSzOeGneHN9QqVIlAwhGj5r0txW3oo
 2x0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/KJznxi6hkENfAYqAetvbsJoqorQe+FAwDQtkyKjOv9gC7vEYYh2RiRD3lGAhQNBfvaEsdCYDCuDc@nongnu.org
X-Gm-Message-State: AOJu0YxVeck5+2LUjbWyF86E5BcaL92F4zQMDbuYhpXoKijfAcAWpgmm
 mxp1ShDZQ6IrUjJoEDt9yD+wPNGobE7q7AFI5CW3XcnSrQde80dxdYfatqimafQ=
X-Gm-Gg: ASbGncsVzuumHpoFYQRyu/KKdD1421ut3Cy3AZF4Dtyj4EnXmEKThqcSafgstxNDSHH
 uMEmTmWc9AO9l4EZ90PYCAbegVNPqfMb/9IadDPJwO2lwpQRqm0mlfSVGiWdm3fUy15q50JZYff
 KEVdht5i+9IF6b4iEzVxEouvP/pq6LPfA8i7+Eo71oEPpFz8KZec4GWGFW5XYn1lY8rawN0Qcep
 Q5JFAsazj+7JnOKWEfZ7d3+CiQwT0aGdqt6PLB7+4BVL5gvrty1XcJz/kvKftfUK0u/iQ==
X-Google-Smtp-Source: AGHT+IGyf8DOKryLeGeCqEYeKtC5Xus780Ragaouos+Wq3PL7sptmeUnVOViSLCJVoXxWHn0d5o20A==
X-Received: by 2002:a17:902:e5ce:b0:216:386e:dd8 with SMTP id
 d9443c01a7336-21a83f54a51mr311768755ad.17.1736870423166; 
 Tue, 14 Jan 2025 08:00:23 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f219302sm69093835ad.149.2025.01.14.08.00.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 08:00:22 -0800 (PST)
Message-ID: <33501d8b-0035-404a-88ee-c6ff64c237a4@linaro.org>
Date: Tue, 14 Jan 2025 08:00:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] plugins: fix -Werror=maybe-uninitialized false-positive
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20250114104820.2613099-1-marcandre.lureau@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250114104820.2613099-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

T24gMS8xNC8yNSAwMjo0OCwgbWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tIHdyb3RlOg0K
PiBGcm9tOiBNYXJjLUFuZHLDqSBMdXJlYXUgPG1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNv
bT4NCj4gDQo+IC4uL2NvbnRyaWIvcGx1Z2lucy9jYWNoZS5jOjYzODo5OiBlcnJvcjog4oCY
bDJfY2FjaGXigJkgbWF5IGJlIHVzZWQgdW5pbml0aWFsaXplZCBbLVdlcnJvcj1tYXliZS11
bmluaXRpYWxpemVkXQ0KPiAgICA2MzggfCAgICAgICAgIGFwcGVuZF9zdGF0c19saW5lKHJl
cCwgbDFfZG1lbV9hY2Nlc3NlcywgbDFfZG1pc3NlcywNCj4gICAgICAgIHwgICAgICAgICBe
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+
IA0KPiBJcyBhIGZhbHNlLXBvc2l0aXZlLCBzaW5jZSBjb3JlcyA+IDEsIHNvIHRoZSB2YXJp
YWJsZSBpcyBzZXQgaW4gdGhlDQo+IGFib3ZlIGxvb3AuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBNYXJjLUFuZHLDqSBMdXJlYXUgPG1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbT4NCj4g
LS0tDQo+ICAgY29udHJpYi9wbHVnaW5zL2NhY2hlLmMgfCAyICstDQo+ICAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvY29udHJpYi9wbHVnaW5zL2NhY2hlLmMgYi9jb250cmliL3BsdWdpbnMvY2FjaGUuYw0K
PiBpbmRleCA1MTJlZjY3NzZiLi5jMmMyNzRjZmNkIDEwMDY0NA0KPiAtLS0gYS9jb250cmli
L3BsdWdpbnMvY2FjaGUuYw0KPiArKysgYi9jb250cmliL3BsdWdpbnMvY2FjaGUuYw0KPiBA
QCAtNjA5LDcgKzYwOSw3IEBAIHN0YXRpYyBpbnQgbDJfY21wKGdjb25zdHBvaW50ZXIgYSwg
Z2NvbnN0cG9pbnRlciBiKQ0KPiAgIHN0YXRpYyB2b2lkIGxvZ19zdGF0cyh2b2lkKQ0KPiAg
IHsNCj4gICAgICAgaW50IGk7DQo+IC0gICAgQ2FjaGUgKmljYWNoZSwgKmRjYWNoZSwgKmwy
X2NhY2hlOw0KPiArICAgIENhY2hlICppY2FjaGUsICpkY2FjaGUsICpsMl9jYWNoZSA9IE5V
TEw7DQo+ICAgDQo+ICAgICAgIGdfYXV0b3B0cihHU3RyaW5nKSByZXAgPSBnX3N0cmluZ19u
ZXcoImNvcmUgIywgZGF0YSBhY2Nlc3NlcywgZGF0YSBtaXNzZXMsIg0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICIgZG1pc3MgcmF0ZSwgaW5zbiBh
Y2Nlc3NlcywiDQoNCkJ5IHRoZSB3YXksDQoNCndoaWNoIGNvbXBpbGVyICh2ZXJzaW9uPykg
YXJlIHlvdSB1c2luZz8NCkp1c3QgY3VyaW91cyB0byBjaGVjayBpZiB3ZSBkb24ndCBoYXZl
IGFueSBvdGhlciBmYWxzZSBwb3NpdGl2ZXMgaW4gdGhlIA0KY29kZSBiYXNlIHdpdGggaXQg
aWYgaXQncyBhIG5ld2VyIHZlcnNpb24uDQo=

