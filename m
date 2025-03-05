Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACCADC19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 16:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tps0N-0008Vr-L1; Wed, 05 Mar 2025 11:53:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tps0L-0008VW-Sp
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:53:57 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tps0K-00069R-1C
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:53:57 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22185cddbffso19643205ad.1
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 08:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741193634; x=1741798434; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YHbN7rg6sN2QQGTNbhCL9h/LWgMhKOdSmjvu55+amPY=;
 b=WTruITo9xXCN9P7Dzx6queVFhZV5PP6YWTWi+uPPkwQ3kSrsdjwYg6AUJc2Q1K1zI1
 iRRPGaAd3iiNIseBgridDzGc9XDX5KUkExzCYnB5c55+/9xzcvKIUzq2/rTJatc72HIS
 8FQTIycTB6xO43BmczA4zseEo486v5f3N6OLT/zLvB/mms8HxuRdmLYotvWN51i1Ep6r
 DDxfNyjThUMNeJZNvQroTe/mSMHTg/LyR/7xlTB2DfbwDB+1Emn0tes3DP/+8Mw7SPZE
 sHAKOtsPHeKzXLAz6Y7vrSgNlCVosj3TKA4YPLfj+IlLKrXxLIAIg8eR9Douu5492hjS
 epnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741193634; x=1741798434;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YHbN7rg6sN2QQGTNbhCL9h/LWgMhKOdSmjvu55+amPY=;
 b=SGBu0pIC1v9eSJjo+wx15iC1+lP4WYOQqvxIPRDr9vkpV4gL8G3scN7UfOk80OGRs5
 Zi+BorW7IaB6S7J9U8/LRMaa5Lf+/CrB11bUF7qIBmYuFK4MWe0udMR/Z3qnKKMN3Uc8
 BTVc+LudYsv4tXZT0kai8gFUcFrWzm0x6pLWRlmNnT70kF/mP7CxIGwOWok12vZDffkI
 DiwGtb2NuwH3gOkW71LeMQjTQ3EmJcm0qOMquJ59FumAtMMXOHBrink0SXXfLqIPWH7z
 fKgKmKs2LQKFjqY7Ptvb4XCD+MhKPSC2/BxF9Gm3bMgAiySmtMmrpUfRpq2LK3Rbd50L
 QEtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwGvBs/xki46xA21mLz3Lk58y0EUPIHazEi6lC1a8rxSis+0IQTqMzKvBsYBMaoI1tvm2TOryE+08A@nongnu.org
X-Gm-Message-State: AOJu0YxoVXGJwn1oDpQyWbuxgfXaF0TrQBwfGNQbo4yYXcoaRud5AMUi
 5CRbNc6vc7wgpTzF233eyhTeuuY7dgm0XYptWz2RQ1Mh4pA/huhs6+Ucp4e/IQg=
X-Gm-Gg: ASbGncutWGBPYY34t7UgbAK6KkCCVdkhmqTIkUz3a+J5iKxgAa7JUu2ntsm/EYbWCg9
 0HjEtUxJGbKmmpAbvJjiYZ7XiHVkJ4WUVkyA7piBrc2pJxvTdaoqHo1pk8EWc+OQh8ZK3tobonH
 NWLaCIUKuPSLt4yTqOd5K57QDUyGN2lnnUDlXnM0aj8yF+nJK21ZhZQ99hs1vrfnofQGLeHZk4k
 11c3bXlt0Rl7jI0euaXz/xn5gXPjLF/svWL7PbQ0uQLrINs5HOOayqUqCnzvz25ZwOrUuNJBnTb
 Pdc1M3zUYVpep/C4iznqssyR9aN1/Oga/kVIgccZ9fhhLtHsM4zx3WuaNw==
X-Google-Smtp-Source: AGHT+IFPWry8pPoSYgrMD1WMAGmrWTEeYcyldKS58P2fmymvrXmqUX4DQBOnLYp4CGvwCelQmXEKIg==
X-Received: by 2002:a05:6a00:1893:b0:736:476b:fccc with SMTP id
 d2e1a72fcca58-73693eee618mr27963b3a.8.1741193634584; 
 Wed, 05 Mar 2025 08:53:54 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73663d88a1csm5496042b3a.108.2025.03.05.08.53.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 08:53:54 -0800 (PST)
Message-ID: <e2e22df0-4abc-4663-b60f-d79648b55706@linaro.org>
Date: Wed, 5 Mar 2025 08:53:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/18] hw/xen/hvm: Fix Aarch64 typo
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20250305153929.43687-1-philmd@linaro.org>
 <20250305153929.43687-2-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250305153929.43687-2-philmd@linaro.org>
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

T24gMy81LzI1IDA3OjM5LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gVGhl
cmUgaXMgbm8gVEFSR0VUX0FSTV82NCBkZWZpbml0aW9uLiBMdWNraWx5IGVub3VnaCwNCj4g
d2hlbiBUQVJHRVRfQUFSQ0g2NCBpcyBkZWZpbmVkLCBUQVJHRVRfQVJNIGFsc28gaXMuDQo+
IA0KPiBGaXhlczogNzMzNzY2Y2QzNzMgKCJody9hcm06IGludHJvZHVjZSB4ZW5wdmggbWFj
aGluZSIpDQo+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGls
bWRAbGluYXJvLm9yZz4NCj4gLS0tDQo+ICAgaW5jbHVkZS9ody94ZW4vYXJjaF9odm0uaCB8
IDIgKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24o
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3hlbi9hcmNoX2h2bS5oIGIvaW5j
bHVkZS9ody94ZW4vYXJjaF9odm0uaA0KPiBpbmRleCBjN2M1MTUyMjBkMi4uZGYzOWM4MTlj
OGYgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvaHcveGVuL2FyY2hfaHZtLmgNCj4gKysrIGIv
aW5jbHVkZS9ody94ZW4vYXJjaF9odm0uaA0KPiBAQCAtMSw1ICsxLDUgQEANCj4gICAjaWYg
ZGVmaW5lZChUQVJHRVRfSTM4NikgfHwgZGVmaW5lZChUQVJHRVRfWDg2XzY0KQ0KPiAgICNp
bmNsdWRlICJody9pMzg2L3hlbl9hcmNoX2h2bS5oIg0KPiAtI2VsaWYgZGVmaW5lZChUQVJH
RVRfQVJNKSB8fCBkZWZpbmVkKFRBUkdFVF9BUk1fNjQpDQo+ICsjZWxpZiBkZWZpbmVkKFRB
UkdFVF9BUk0pIHx8IGRlZmluZWQoVEFSR0VUX0FBUkNINjQpDQo+ICAgI2luY2x1ZGUgImh3
L2FybS94ZW5fYXJjaF9odm0uaCINCj4gICAjZW5kaWYNCg0KUmV2aWV3ZWQtYnk6IFBpZXJy
aWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCg0K

