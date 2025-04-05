Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE434C36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 01:04:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0rwc-0001gI-H4; Fri, 04 Apr 2025 21:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0rwW-0001ft-2e
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 21:03:29 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0rwU-0008GI-A9
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 21:03:27 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2255003f4c6so24942435ad.0
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 18:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743815003; x=1744419803; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LWIcgOPan3l1oGAxJtplMws7fpZkKRmVobMScX00DTo=;
 b=dwkycueSNgSlQfCjHcefUj+oQmDZtfpKpJHIe0XZuNGWUsfV4FgQmqy47gq0OUbYzH
 zYLeqP7DtxyYK2IhGFI08zAMYIfT8nfKJwjg+ZasW3dISUreD5Ip0IWpTU9aR3fqlp8n
 yX45/atky3OBgrp1H0rWBiVM6LM5TPd+ms64T1GQFjRRTQz1g2keKkVbP7yRD5zkPhgC
 lFqZb9OpP7Jr4UjBMM4z3mv5tZiX/ovSq4YpP7oBmtnS8hNftYHSyQgSqGvCWNMHMCNF
 yGNFXOs3gRlPWsFEMeeWMZF7q5yxYAV7zk41Z5cpu9UkQFYuE5lYJ62C5L4ALVk192RN
 EcEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743815003; x=1744419803;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LWIcgOPan3l1oGAxJtplMws7fpZkKRmVobMScX00DTo=;
 b=lw7GPZN6jwDrD/smnW4Gx62hUMYAlq0yzDcJ0L7gA21GRZc3Lv8mUc0QzKKMdkGNC4
 QqqkjzXI/4vegQS7mmQrvdZVUNx5mCknAOtEnFEV0L3Of/lS1Efnf8ko6e3HlgkbTT5r
 pbKwe2zebmgtuSf4iNym6wZMsqmeLyuCqfXhrGt/X7y/llYO1l00rCCpWg/XcUjYvdbN
 E4pZ9uCxoqy3UOSEDUofijTS16TkOElraCszcFi82stEdn0ugfENYhJA/S3OTt572ami
 hqQ5lBB5Se2It+yqap/iXGJNn+fmiC9BgihMQC09ZJPRCiGVKYqbaIbOGKGKG4Qm/N/l
 Gr6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0kY/cXWmEf6Anb0bpWDC/ri6NJwgCAeRNfulrMyb22oC5ioIoc0HtomuUpVe/VU3G7B8+Zn4MXCII@nongnu.org
X-Gm-Message-State: AOJu0YzODssHy6kQkLABPMrqSUuDLYh/W83jHo0O7sSMhWVG/jWAdBDe
 6H9LV6dKx7VxJgvl/4cvtpxD8A+/wA4o3SNqLiDgFrPA+Xm9NXi1hxrRJnI2zn4=
X-Gm-Gg: ASbGnctNG6opHWi3Y3wn2y1bW97xlTjo6CxqawBnf2WDSaTIBPTEYhVEzyQoq2kCqB3
 uyIVdJ+cq9HuZHxfMnoXxoiecB8wGf2Pb0RTwDwCp047YlFx93CowGoXTr9JQkpNjHoO4S4AHVa
 AW3TcS70HWdcBhcYnqNPUpqWfcsXGn447SgxO+I1XNaH3D+63zAPpB484wgls2gYYrSCp7kiNqd
 hs3+49o78peQg1lpdkZD3VE0NfFiqwe6bkrHQwI1zOj72jV2STGD1sfaSQIpuX+46uRQTjrCVl9
 9K6W56GIdmeaCdOrEpsEKXZhcnSsxywBiAyoddlUnZTqsw5WzaNOp7+a1w==
X-Google-Smtp-Source: AGHT+IFXFWOhLVME3FhzMWeSFkXh304P/l8r5+HgzbjoqtVvWNdra6CQRhQbxesspne0ZIeE8Zd0Tw==
X-Received: by 2002:a17:902:cf07:b0:224:1935:fb91 with SMTP id
 d9443c01a7336-22a8a06cdd8mr66234045ad.27.1743815003006; 
 Fri, 04 Apr 2025 18:03:23 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229786600bcsm39214975ad.112.2025.04.04.18.03.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 18:03:22 -0700 (PDT)
Message-ID: <a61d8331-27ef-489f-8cd3-0374da0b4b1b@linaro.org>
Date: Fri, 4 Apr 2025 18:03:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 11/39] hw/arm: Use full "target/arm/cpu.h"
 path to include target's "cpu.h"
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20250403235821.9909-1-philmd@linaro.org>
 <20250403235821.9909-12-philmd@linaro.org>
 <83a57c49-93fd-4463-81bf-fc0014ff5f3d@linaro.org>
 <a3d5cd32-4a1f-4753-8536-43180229721f@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <a3d5cd32-4a1f-4753-8536-43180229721f@linaro.org>
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

T24gNC80LzI1IDE0OjUzLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gT24g
NC80LzI1IDIwOjIwLCBQaWVycmljayBCb3V2aWVyIHdyb3RlOg0KPj4gT24gNC8zLzI1IDE2
OjU3LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4+PiBXZSB3b3VsZCBsaWtl
IHRvIGdldCByaWQgb2YgJy1JIHRhcmdldC8kQVJDSC8nIGluIHRoZSBDUFBGTEFHUy4NCj4+
DQo+PiBXaGlsZSB0aGlzIGNoYW5nZSBpcyBjb3JyZWN0LCB0aGlzIGlzIG5vdCBzdHJpY3Rs
eSBuZWVkZWQuDQo+PiBXaXRoIHRoZSBjdXJyZW50IGFwcHJvYWNoLCB1c2luZyBhIHNldCBv
ZiBjb21tb24gZmlsZXMgcGVyIGFyY2hpdGVjdHVyZSwNCj4+IHdlIGNhbiByZWx5IG9uIHRo
aXMgaW5jbHVkZSB0byBiZSBwcmVzZW50LCBhbmQgaXQgZG9lcyBub3QgYmxvY2sgZnJvbQ0K
Pj4gaGF2aW5nIGNvbW1vbiBmaWxlcy4NCj4gDQo+IEluZGVlZCwgSSByZWJhc2VkIHRoaXMg
Y29tbWl0IGZyb20gbXkgaGV0ZXJvZ2VuZW91cyBicmFuY2guDQo+IA0KPiBJJ2xsIGtlZXBp
bmcgY2FycnlpbmcgLyByZWJhc2luZyBpdCBmb3IgdmFyaW91cyBtb250aHMsIHRyeWluZyB0
bw0KPiByZW1lbWJlciB0byBub3Qga2VlcGluZyBwb3N0aW5nIGl0Lg0KPiANCj4gT3IgYWx0
ZXJuYXRpdmVseSBJJ2xsIHBvc3QgaXQgaW4gYSBzZXBhcmF0ZSAiY2xlYW51cCBzZXJpZXMi
LCBub3QNCj4gbWVudGlvbmluZyBzaW5nbGUtYmluYXJ5IG9yIGhldGVyb2dlbmVvdXMgZW11
bGF0aW9uLg0KPiANCg0KTXkgcG9pbnQgd2FzIG5vdCAicGxlYXNlIHBvc3QgdGhhdCBsYXRl
ciIsIGJ1dCBzaW1wbHkgdG8gc2F5IHRob3NlIA0KY2hhbmdlcyBhcmUgbm90IG5lZWRlZCwg
bm93IG9yIGluIHRoZSBmdXR1cmUuDQpXZSBjYW4gaGF2ZSBhIHNwZWNpZmljIGluY2x1ZGUg
cGF0aCBmb3IgdmFyaW91cyBmaWxlcyB3aXRob3V0IA0KY29tcHJvbWlzaW5nIHRoZSBzaW5n
bGUgYmluYXJ5L2hldGVyb2dlbmVub3VzLCBhcyBsb25nIGFzIHdlIGNvbXBpbGUgaXQgDQpv
bmx5IG9uY2UuDQoNClNvIHdlIGRvbid0IG5lZWQgdG8gcmVtb3ZlIGNwdS5oIGluY2x1c2lv
biBpbiB0YXJnZXQgcmVsYXRlZCBjb2RlLg0KDQo+Pj4gVXNlIHRoZSBmdWxsIHBhdGggdG8g
ImNwdS5oIjogInRhcmdldC9hcm0vY3B1LmgiLg0KPj4+DQo+Pj4gUmV2aWV3ZWQtYnk6IFJp
Y2hhcmQgSGVuZGVyc29uIDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPg0KPj4+IFNp
Z25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9y
Zz4NCj4+PiAtLS0NCj4+PiAgwqAgaW5jbHVkZS9ody9hcm0vZGlnaWMuaMKgwqDCoMKgwqAg
fCAyICstDQo+Pj4gIMKgIGluY2x1ZGUvaHcvYXJtL2ZzbC1pbXg2LmjCoMKgIHwgMiArLQ0K
Pj4+ICDCoCBpbmNsdWRlL2h3L2FybS9mc2wtaW14NnVsLmggfCAyICstDQo+Pj4gIMKgIGlu
Y2x1ZGUvaHcvYXJtL2ZzbC1pbXg3LmjCoMKgIHwgMiArLQ0KPj4+ICDCoCBpbmNsdWRlL2h3
L2FybS9mc2wtaW14OG1wLmggfCAyICstDQo+Pj4gIMKgIDUgZmlsZXMgY2hhbmdlZCwgNSBp
bnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCg0K

