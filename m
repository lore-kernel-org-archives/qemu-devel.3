Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F37C2C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 20:14:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsovy-0007sy-KC; Thu, 13 Mar 2025 16:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tsovo-0007qd-Ed
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 16:13:30 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tsovk-0008Op-Pd
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 16:13:26 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22438c356c8so28325235ad.1
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 13:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741896801; x=1742501601; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xP6aPmic4L50DBwBfpaW43vaTKEbxgExMrzJ3ZLBgSY=;
 b=nZl8FbA7cmhgj3hffsZWdurbeADmp9KkugXJk0aAYxso/ks2A9XX3dXW8dtvRofzK2
 Hgufh9n5ECAM0906Qs37JyRaW0Hsf/VEqUeCoFsrNa1JS0g1gavyRgOUzq/o6SpbJE9R
 LI3BnvWzjL33PJsCBmmxgRfQKiPe7scAGX0xFaDBaq+lacc0M+YziNkpofXgX7dqWr/x
 P/Frm1HHJdfpSlR3/R0TD88zsvWxUPOmIAuDABYsBJnXe4Ph4oad89o58XUY9BoXN/p4
 21AaEJKRuZrbLRyJDN4DAbhRulv5WI7hWJlwpiNH2yKRJ3yUXop7OkPiffMyWvG4gTJZ
 283g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741896801; x=1742501601;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xP6aPmic4L50DBwBfpaW43vaTKEbxgExMrzJ3ZLBgSY=;
 b=HDr9R71O8g0RkXCT8bk5ZJCwgjJ4KlFqqTvi5AlscIwl3Td8493YVKuDmnyCT2m78M
 skEi+0y6BhyYyLciBZ+GzWNc7wOU4XTXQY1QIHUKL97fV1g1DHiANb7LF4nCxvOPAUqX
 jt9xMeQw+oorJA91DwdzGDDQKOLb30x7jrGdB88CII5EXeroyadKaPYTVfmUEnvGQpmY
 wpHIGbewzrzyy/8ZzEAgWBAYSBrZjFxQrdRwVHovEwKKMr5GYxA37R5XdDoktMk9u1rE
 UWM60uirB9SrtdJ9fUTBymdgabFOZSx5CDAQ2hQvWhwj6yA3ViBytZSlLpzR1zRvdgLK
 w1zQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLzrN+rxlFtWgFj9PGymxUEbV5rvk6s+sDjcJIrbsspfbdri1ihhhW4S2r5OJkytjU5tveErAmuMWR@nongnu.org
X-Gm-Message-State: AOJu0YwOtFNU3nyKZWQPrwxuQle4RwS/ziz8AWibRZcE4+D9yAtXFL+P
 d0y7O2zoJKXoCk9Nqj5I86Kq+RObck5RjuWxuqozFIo/uqk7Ei1Z2/Nk9/7N5dg=
X-Gm-Gg: ASbGnctpDKVcO+C88otWV6Y7E443P9TtaERXqdsuS43kveA/en5MXWQxWZbOPbujcb8
 7fH/CXl3GprvEbbT4mZ48rJrt+Skq5MNaLFvb7n0fIpH7ylD6V2QtaXwqoxVU/AbaWq1YGYMfPR
 96osedJ2nQgHU2RIyv7WmEdj4WMqW8qjMc1PaOX5H744C8H13VPL2QFKzG/6DZg/RkSEtPiS/9V
 UHJ0Tbz0Oy0hQc6lERXoA4ivEBYran8qwq898xTo7aN02rJ6XM9dWT++tRhygzgS7U82195R9Qs
 aYC4a5/6B7dI/Y3g4JJE5X8wQRqLU1CsltvX3lXUZA1IljL3isROq7SPIA==
X-Google-Smtp-Source: AGHT+IHlYXL09cczNfleunp2v19bv6qljKuhMvZPcW9u+dhz5njgDmC1swO5woxCRmQUdINS4ezkJg==
X-Received: by 2002:a17:903:120b:b0:220:d257:cdbd with SMTP id
 d9443c01a7336-225dd905963mr10157425ad.48.1741896801082; 
 Thu, 13 Mar 2025 13:13:21 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c68883adsm17631225ad.47.2025.03.13.13.13.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 13:13:20 -0700 (PDT)
Message-ID: <e47682ae-cf3c-4352-bc1e-77f3cffd08cb@linaro.org>
Date: Thu, 13 Mar 2025 13:13:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/37] accel/tcg, codebase: Build once patches
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Peter Maydell <peter.maydell@linaro.org>
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <04c5bc51-ac5e-412e-b77c-a52c5a90be13@linaro.org>
 <5215233a-d2d1-4cc6-8958-2e7fb3b8e2a3@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <5215233a-d2d1-4cc6-8958-2e7fb3b8e2a3@linaro.org>
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

T24gMy8xMy8yNSAxMDo0OCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE9u
IDEzLzMvMjUgMTc6MzYsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBPbiAzLzEyLzI1
IDIwOjQ0LCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90ZToNCj4+PiBBbGwgdGhpcyBpcyB3b3Jr
aW5nIHRvd2FyZCBidWlsZGluZyBhY2NlbC90Y2cvdHJhbnNsYXRvci5jIG9uY2UsDQo+Pj4g
YnV0IGl0IGdvdCBsYXRlIGFuZCBJIGRlY2lkZWQgdG8gc3RvcCBhdCBhIGNvbnZlbmllbnQg
bWlsZXN0b25lLg0KPj4+DQo+Pj4gSW4gdGhlIHByb2Nlc3MsIEkgZGlzY292ZXJlZCB0aGF0
IHdlIGhhdmUgYWxyZWFkeSBhZGRlZCBmaWxlcyB0bw0KPj4+IGNvbW1vbl9zcyB3aGljaCBp
bmRpcmVjdGx5IGRlcGVuZCBvbiBDT05GSUdfVVNFUl9PTkxZLsKgIFNvbWV0aW1lcw0KPj4+
IHRoaXMgaXMgaGFybWxlc3MsIGFuZCBzb21ldGltZXMgaXQgcmVhbGx5IGlzIG5vdC7CoCBG
b3IgaW5zdGFuY2UsDQo+Pj4gcGx1Z2luL2FwaS5jIGlzIGFmZmVjdGVkIGJ5IGRpZmZlcmVu
dCB0cmFuc2xhdGlvbi1ibG9jay5oIGxheW91dC4NCj4+Pg0KPj4NCj4+IE1heWJlIGl0J3Mg
ZmluYWxseSBhIGdvb2QgcmVhc29uIHRvIHRhY2tsZSB1c2VyL3N5c3RlbSBhdCB0aGUgc2Ft
ZSB0aW1lDQo+PiB3ZSBtYWtlIHRoZSByZXN0IG9mIHRoZSBmaWxlcyBjb21tb24uDQo+Pg0K
Pj4+IFRoZSBvbmx5IHNvbHV0aW9uIEkgY2FuIHNlZSBpcyB0byBwb2lzb24gQ09ORklHX1VT
RVJfT05MWSBvdXRzaWRlDQo+Pj4gb2Ygc3BlY2lmaWMgY29udGV4dHMuwqAgSSBob2lzdGVk
IHNvbWUgZXhpc3RpbmcgbWFnaWMgaW4gdGNnLyBhbmQNCj4+PiBnZGJzdHViLyB0byBidWls
ZCBzZXBhcmF0ZSBzaGFyZWRfbGlicmFyaWVzIGZvciB1c2VyIGFuZCBzeXN0ZW0sDQo+Pj4g
YXMgdGhhdCdzIHRoZSBvbmx5IHdheSB0byBhZGQgZXh0cmEgY29tbWFuZC1saW5lIC1EZWZp
bmVzLg0KPj4+DQo+Pg0KPj4gSXQncyBhIGdvb2QgYXBwcm9hY2ggKG1ha2UgY29tbW9uICsg
cG9pc29uIGlzIHdoYXQgcHJldmVudCByZWdyZXNzaW9ucw0KPj4gYW5kIGVuc3VyZSB3ZSBw
cm9ncmVzcykuDQo+PiBXb3JraW5nIG9uIHRhcmdldCBjb2RlLCBJIGZvdW5kIHRoZSBuZWVk
IHRvIGhhdmUgYSBjb21tb24te2FyY2h9IGxpYiwNCj4+IGFsbG93aW5nIHRvIHNoYXJlIGNv
ZGUgYmV0d2VlbiB2YXJpYW50cyBvZiBhIGdpdmVuIGFyY2ggKGFybSB2cw0KPj4gYWFyY2g2
NCksIHdpdGggYSBzcGVjaWZpYyBkZWZpbmUgdG9vLg0KPiANCj4gQXJlIHJlYWxseSBBUk0g
JiBBYXJjaDY0IGRpZmZlcmVudCBhcmNoaXRlY3R1cmVzIChRRU1VIHdpc2UpPw0KPiANCg0K
Tm90IHJlYWxseSwgYnV0IGFzIGxvbmcgYXMgd2UgaGF2ZSAjaWZkZWYgVEFSR0VUX0FBUkNI
NjQsDQp0aGUgY3UgaXMgZHVwbGljYXRlZCwgYW5kIGl0IGJyaW5ncyBhIGxvdCBvZiBpc3N1
ZXMgKHN5bWJvbHMsIHR5cGUgDQpkaWZmZXJlbmNlLCBtdWx0aXBsZSBib2FyZCB0eXBlIGRl
ZmluaXRpb24sIGV0YykuDQo=

