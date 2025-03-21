Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B088C36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 20:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tviiW-00046O-Rw; Fri, 21 Mar 2025 16:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tviiT-00045s-ON
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 16:11:41 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tviiS-0004YU-1q
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 16:11:41 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2240b4de12bso19068515ad.2
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 13:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742587898; x=1743192698; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6T+1x5xOuQ2yJ3mt19MuTaHImZYpr22igEe7u5TyWMg=;
 b=s6QtFW6+/YduemTq5HF7kMFuylfjY9iZWB0l3h16MPvBoXVTgjwC3wKi1OisvRrjZ9
 H2YbSoCnG6K21tLpAcrpo06xO4cwk09LgNlA3d+s/xPPlIH2VGf9vfcyX2ReDyGCLKJR
 B9lUpez+R6edGNY7nNybHKhknv4lUAmvEBTpHEn8t4MZ4NA3Q5+5FlPXCXN6uxQeEmdT
 +hhGuWi8eQYf8g9XZUTYU3U93c0AblJUxeagninxMdV1YbuTE98adchM1XmzC2feRpva
 9BVd63HUViH4ieCwoBLlJkrMAAYdv3u3p34HsxP2+XWSrUUolJU1eBp/ItQNNc58boxi
 pPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742587898; x=1743192698;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6T+1x5xOuQ2yJ3mt19MuTaHImZYpr22igEe7u5TyWMg=;
 b=etSkygSSXywhsbV2jKzu3LjbcDO6JDdB4tCqooKsdfyjchliaO4s5uEOMkiEez0eGr
 WeYJ1l1wprQw3oLK4NSlJ74q7jyWe+Sv5qqEGs5EjMmNzMag2hm88iXrsiD13U/Dca8R
 IxplKD1ZiXZQj9W812Y+NvX2gnqRF3Zo1dp+xu4SwPJJn4P2jgds30xBv0l9FMsoFIPK
 RGqZbdNJ1r5cVBIQIoo5nPBaDMuQYyoUaqxvctL26KZiyu6r41uS7z1uJ19tS84Hxy8L
 Be1Avj2FstgK/eQLBDFFCAXSgGaQ/mCOhsI71VB831tEOJ1q3WssPdG2Ev0j0R6UZUDO
 juQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXou0S1H0CF/w1RSLhgA+ebaHxfdmBRds94EZrAZoNEnwvnJCkOcacYSa6OCf2+uEw0CB5SgCieGy1Y@nongnu.org
X-Gm-Message-State: AOJu0YxK/vL+1YrzDzMeKmd8EYDM9VqrlowwocQisW09DZOyjhiL0Cg6
 VxdFnsTB5/Q/D1dN167BB7orcl3O84FfDQSvjtIrUKii/DuyGCxoreDkzjPfRPE=
X-Gm-Gg: ASbGncvtiVRFPhX2O+VjnhIHIN/L9DxEX6UNG7+YKVn39z8mo2+U1sG513ANZyGunAq
 1JJ1UXhgLMKQNeE8FENYItubYth5KXq3OrX8KdqvXeGAh7K1xGM4F/iKM5QKVub3W/xKb6jnRS5
 ayNU6GEqM20TAN3hDt3p24H8LOOh3OOBPGLcFn24TLXNcQ8iA7U6GcJpEVy3keLgFpYo1DOdV3j
 kb3LQX9MBneMdxIPYkDfm1XYFoOC6TA8FGiSN/I9+zd1AKbHckLpTlwXbFFTDgFcTZTzRfLJ/dJ
 282Wg5UqmdSFfY0j0kzhrhb+NbNjP7OYOVS4Ltsyn5ALFJDzhAvQb4grPVXfxf918v5u0g==
X-Google-Smtp-Source: AGHT+IETv1gtDe0Tn14WdsrX20MpKLXdC8E2l3VUaPRnXb98rd0gWl5A1Eo5BTcwdnWAcDxnvNIVCQ==
X-Received: by 2002:a17:903:32c8:b0:224:1609:a74a with SMTP id
 d9443c01a7336-22780e14a50mr77491965ad.34.1742587898418; 
 Fri, 21 Mar 2025 13:11:38 -0700 (PDT)
Received: from [172.16.224.217] ([209.53.90.26])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811da89csm21677065ad.193.2025.03.21.13.11.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 13:11:37 -0700 (PDT)
Message-ID: <216a39c6-384d-4f9e-b615-05af18c6ef59@linaro.org>
Date: Fri, 21 Mar 2025 13:11:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/30] exec/target_page: runtime defintion for
 TARGET_PAGE_BITS_MIN
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
 <20250320223002.2915728-18-pierrick.bouvier@linaro.org>
 <2e667bb0-7357-4caf-ab60-4e57aabdceeb@linaro.org>
 <e738b8b8-e06f-48d0-845e-f263adb3dee5@linaro.org>
 <a67d17bb-e0dc-4767-8a43-8f057db70c71@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <a67d17bb-e0dc-4767-8a43-8f057db70c71@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

T24gMy8yMS8yNSAxMjoyNywgUmljaGFyZCBIZW5kZXJzb24gd3JvdGU6DQo+IE9uIDMvMjEv
MjUgMTE6MDksIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+Pj4gTW1tLCBvayBJIGd1ZXNz
LsKgIFllc3RlcmRheSBJIHdvdWxkIGhhdmUgc3VnZ2VzdGVkIG1lcmdpbmcgdGhpcyB3aXRo
IHBhZ2UtdmFyeS5oLCBidXQNCj4+PiB0b2RheSBJJ20gYWN0aXZlbHkgd29ya2luZyBvbiBt
YWtpbmcgVEFSR0VUX1BBR0VfQklUU19NSU4gYSBnbG9iYWwgY29uc3RhbnQuDQo+Pj4NCj4+
DQo+PiBXaGVuIHlvdSBtZW50aW9uIHRoaXMsIGRvIHlvdSBtZWFuICJjb25zdGFudCBhY2Ny
b3NzIGFsbCBhcmNoaXRlY3R1cmVzIiwgb3IgYSBnbG9iYWwNCj4+IChjb25zdCkgdmFyaWFi
bGUgdnMgaGF2aW5nIGEgZnVuY3Rpb24gY2FsbD8NCj4gVGhlIGZpcnN0IC0tIGNvbnN0YW50
IGFjcm9zcyBhbGwgYXJjaGl0ZWN0dXJlcy4NCj4NCg0KVGhhdCdzIGdyZWF0Lg0KRG9lcyBj
aG9vc2luZyB0aGUgbWluKHNldF9vZihUQVJHRVRfUEFHRV9CSVRTX01JTikpIGlzIHdoYXQg
d2Ugd2FudCANCnRoZXJlLCBvciBpcyB0aGUgYW5zd2VyIG1vcmUgc3VidGxlIHRoYW4gdGhh
dD8NCg0KSSB3ZW50IHRocm91Z2ggdGhhdCBxdWVzdGlvbiwgYW5kIHdhcyBub3Qgc3VyZSB3
aGF0IHNob3VsZCBiZSB0aGUgYW5zd2VyLg0KDQo+IA0KPiByfg0KDQo=

