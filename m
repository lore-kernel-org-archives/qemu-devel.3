Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42FFC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 18:04:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trhUR-0008Li-En; Mon, 10 Mar 2025 14:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trhUP-0008J8-6s
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 14:04:33 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trhUL-0000Jb-Gl
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 14:04:31 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2254e0b4b79so18152595ad.2
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 11:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741629868; x=1742234668; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=171ad/3m6TpRhj8AL5WvycUa8BOYOsUsJ0+Ae/voETc=;
 b=dI92KO7o0TKAZs1FSiNQaVxcERrKukpBN1xKCWD3iE2fv7ucs/ItNPtnSeEDGyftKt
 Wf7Q6KNQEmiXhiPC224yjA30bp6js4tSB4lerY9bC5FWcpGFh1zbChPS79WgoIRiY57n
 pTwrr102D2ZX4FJIvnBc2HRfd4MxLaIGMxHa+yAtBtuAROlxwJjyoKYwGDW3WzE4Nf3I
 Tp+dDQ3q8c93MscE2xyfCa9OrCN4uUUgRn18wGp2yxudpY5wmLKgZvIWw4oCXCZs4Cla
 uGBvBEpfp4o3mWS597dhlwrBN7ccSOWcRt+dU8qqg1LJ9612Dgl0ZGEEsC7oZqB0Sr1d
 SlGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741629868; x=1742234668;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=171ad/3m6TpRhj8AL5WvycUa8BOYOsUsJ0+Ae/voETc=;
 b=HQVipfZdvaWeY8223EVS2LZh/Q3sjcEwJQ3e9T1uyWpWjcyx5SBCGxAKCL9WPA7/XK
 NzrnwVe0Uwj4swR21yFZ/8Cljg3w26QFTlyEDpZDb6cQt4C9RE7qv8zM/D7iscLVcOgH
 kwDjSdPbec2LgRvtCY2uB90sjL+0Lqt8AhRoxg+rota2a5VhB2mJYBrQIyi5VaoPmTxn
 /lt+c97uJhGjR85KU7XnkbLnHHgImje7l0STqLH0ZRz9Arc8keFSJEvVv4XDxczZpoCO
 BxNeqPtWLr9RBZoHwNYRRYYexYhsxf5+MruW8downm8LXeJeiGGcZP5UT8KUBMH6ldn7
 YE0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8xic/71fBL08z+Zw1q2U66AVtwXYczMXkmR4TqzyTo2pqlnPbmOh7i8XL6payK5YyJRXJpHyWs+SJ@nongnu.org
X-Gm-Message-State: AOJu0Yzmo9fjxJVp2g6QkAGYD2CBVw/iPMGJTYhYe4xhb4It9siTBCG5
 LC5ZeohT785tBWE5cGGUXDZZIahL3acNR2GMo+guy0iPNvLwLGBB5QPryB0nQmw=
X-Gm-Gg: ASbGncsbtRmqnAmLRH+k0IDEqjqXSAwh2aVEfQF30oyjcRpgi8iGZNlvGWQl3c9zD56
 Ee0lhsJJ8GI+jrLjSTbAzQ9NEra2t40H0iuD8CPfzAaYTU+/ENCe/5u4lTbfdZckB5GSwAQMogH
 8EhuogkN92/JycOPyPYsh8KcO0EQ3e57ikypLgaU6eBeQEf3lrhUuhsCqicfrBZ12vFPeMkbIap
 ctxkRt86fvBxSQ8TaNX7DqCMXUYBT7CYSoDng4YXPQX/KB44RhNHpgtVVFUeHnQKuhIYKd8u2s5
 pqETqMBHp9nxHywS6te9jKYXzzEmAjTZbFErj6PZW6CY1ZBm9yEtrOGbFQ==
X-Google-Smtp-Source: AGHT+IEdDABoZ+WcuAcizsjTSWhdSSNrXe39PcAwNXY1AKSwOOstsTN186eoqVpvfGt0FCM8zrbQPA==
X-Received: by 2002:a05:6a00:ac5:b0:736:5dc6:a14f with SMTP id
 d2e1a72fcca58-736aab14d4emr22821071b3a.23.1741629867680; 
 Mon, 10 Mar 2025 11:04:27 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af281096763sm8063071a12.30.2025.03.10.11.04.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 11:04:27 -0700 (PDT)
Message-ID: <b411c27f-3f38-4d22-97ff-fa36ae77fb6e@linaro.org>
Date: Mon, 10 Mar 2025 11:04:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/16] system/memory: make compilation unit common
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
 <20250310045842.2650784-16-pierrick.bouvier@linaro.org>
 <76b4e445-0676-4982-a2c8-d273c49a9170@linaro.org>
 <2d631838-e8a5-48d9-8235-9a41ffc3381c@linaro.org>
 <76269a95-652a-4064-8f2f-6584b0677191@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <76269a95-652a-4064-8f2f-6584b0677191@linaro.org>
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

T24gMy8xMC8yNSAxMDo1OCwgUmljaGFyZCBIZW5kZXJzb24gd3JvdGU6DQo+IE9uIDMvMTAv
MjUgMTA6NDcsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+Pj4gTWF5YmUgYmV0dGVyIGFz
DQo+Pj4NCj4+PiAgwqDCoMKgwqDCoCBNZW1PcCBtb3AgPSAodGFyZ2V0X3dvcmRzX2JpZ2Vu
ZGlhbigpID8gTU9fQkUgOiBNT19MRSkgfCBzaXplX21lbW9wKHNpemUpOw0KPj4+ICDCoMKg
wqDCoMKgIGFkanVzdF9lbmRpYW5uZXNzKG1yLCAmbXJmZC5kYXRhLCBzaXplX21lbW9wKHNp
emUpLCBtb3ApOw0KPj4+DQo+Pg0KPj4gRG8geW91IHRoaW5rIGRlZmluaW5nIE1PX1RFIGFz
IHRoaXMgZXhwcmVzc2lvbiBpcyBhIGdvb2QgaWRlYT8NCj4gDQo+IFRoZXJlIGFyZSBub3Qg
c28gbWFueSByZWZlcmVuY2VzIHRvIE1PX1RFIG91dHNpZGUgdGFyZ2V0LyBvciBhY2NlbC90
Y2cvLg0KPiANCj4gSW5kZWVkLCBhZnRlciB0aGlzIGNoYW5nZSwgdGhlIG9ubHkgb25lcyBs
ZWZ0IGFyZSBpbiBody9hcm0vYXJtdjdtLmMsDQo+IHdoaWNoIChiZWNhdXNlIGl0J3MgQXJt
KSBjYW4gYmUgY2hhbmdlZCB0byBNT19MRS4NCj4gDQoNCkkgc2VlIGEgYml0IG1vcmUgdGhh
biB0aGF0ICgxNyBmaWxlcyk6DQpody9hcm0vYXJtdjdtLmMNCmluY2x1ZGUvZXhlYy9tZW1v
cC5oDQp0YXJnZXQvYXJtL3RjZy9oZWxwZXItYTY0LmMNCnRhcmdldC9hcm0vdGNnL3RyYW5z
bGF0ZS5jDQp0YXJnZXQvaGV4YWdvbi9pZGVmLXBhcnNlci9wYXJzZXItaGVscGVycy5jDQp0
YXJnZXQvaHBwYS90cmFuc2xhdGUuYw0KdGFyZ2V0L2kzODYvdGNnL2VtaXQuYy5pbmMNCnRh
cmdldC9sb29uZ2FyY2gvdGNnL2luc25fdHJhbnMvdHJhbnNfdmVjLmMuaW5jDQp0YXJnZXQv
bTY4ay90cmFuc2xhdGUuYw0KdGFyZ2V0L21pcHMvdGNnL21pcHMxNmVfdHJhbnNsYXRlLmMu
aW5jDQp0YXJnZXQvcmlzY3YvdHJhbnNsYXRlLmMNCnRhcmdldC9yeC90cmFuc2xhdGUuYw0K
dGFyZ2V0L3MzOTB4L3RjZy9tZW1faGVscGVyLmMNCnRhcmdldC9zMzkweC90Y2cvdHJhbnNs
YXRlLmMNCnRhcmdldC9zMzkweC90Y2cvdHJhbnNsYXRlX3Z4LmMuaW5jDQp0YXJnZXQvc3Bh
cmMvbGRzdF9oZWxwZXIuYw0KdGFyZ2V0L3NwYXJjL3RyYW5zbGF0ZS5jDQoNClBsdXMgbW9y
ZSAoMjIgZmlsZXMpIHdobyByZWxpZXMgb246DQpNT19URSogdmFyaWFudHMgKHdoaWNoIHJl
bGllcyBvbiBNT19URSB0cmFuc2l0aXZlbHkpDQoNClRodXMgbXkgcHJvcG9zYWwgdG8gaGF2
ZSBhIGZpcnN0IGNoYW5nZSB0byBNT19URSBkZWZpbml0aW9uLCBhbmQgDQpldmVudHVhbGx5
IGRvIHRoZSBjaGFuZ2UgbGF0ZXIuDQoNCldoYXQgZG8geW91IHRoaW5rPw0KDQo+IA0KPiBy
fg0KDQo=

