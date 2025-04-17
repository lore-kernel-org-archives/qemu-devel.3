Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E744C369BD
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 00:50:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5DRt-0005K7-NV; Wed, 16 Apr 2025 20:49:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5DRs-0005Jw-1Q
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 20:49:48 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5DRq-000603-11
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 20:49:47 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2260c91576aso1921755ad.3
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 17:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744850984; x=1745455784; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RuHA6pUMirqV1TOPFX6w25hNdUOAxYA25rk5tgTLC64=;
 b=k69bYWnZi6XAhvHdvDoebWRkZyB+8nPQ/PoeO2WqhUL9zAoTcMVD0f7s0KowFJi73M
 +ateAzu4hCsuR3eM8iGkJI111kcmc2k/TRvufPaskDSj11UAu0mervlD3ZdOpzwrdbs7
 /DtL5i9kYraV8AvnLR6eX0qk7APBxs8B0iiEPxfr34PHOKdTRfwGInXRkSAspZbpJsWR
 XaEreDapdq/xc+YWMixeD6xvvhYSw9ob/t46DQcw9xX7hLyHl2f05yR3k7D/iHUn8Hk4
 Be0fKFb0svOYLUBSX5QLdXbhVpXGYHT2Dzc2iA1xzFNp/A+0CF8B7Kt3csBnpbskxOsN
 cqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744850984; x=1745455784;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RuHA6pUMirqV1TOPFX6w25hNdUOAxYA25rk5tgTLC64=;
 b=U45DERmVNgwzyxAE/FKxcbjSQ7u/P2T3dWsvCXYsauRjwuP/xzM9rqAtUTuwh21jU+
 QpjAlkNN2J/hscOf2T7HebkPDyO9vDoF9IXrdAvhWyqgLCBkNkMLZv+yjwM4czAIxOWW
 d+lzo+zw+rBcmEe5iSbAGIV1Ay329RS/lj8cOgR4RtX+ukj1ihJuMzDOu4GZ8g3JP4ob
 6SQuBZ3o3KTauGjX60aMb2s1bdr2CEqRvFTb7rZ7JH2569FQeo7pJiDVvtnurScPRpwP
 7DXcpvNw+WmqSJSzRHlWqGMi5eUCcvmVoqiZNvGMd2b4dNQx1105SFaejCIsgC4MlyoM
 bnNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAXjlHahVOhZXg4FAjd0jcmcFwxpkNkuBdQFzHAh2j71Q5fnGZTwBP1XNfETLgfWVk+uy7HMTUz+Ju@nongnu.org
X-Gm-Message-State: AOJu0YyFG5xrj1nSzjzalW3sg00DDQ10gqClotJCKE5jScXp4fMloOza
 +NJydHHD260QALz09YoNvcBec7LV0sJWPk7VADGmp9RKr+rVgMUlYGWhXF9ZI98=
X-Gm-Gg: ASbGncsPvFYqShKovK6VlNgd3h6ZXs/ATVygFOXolZB8IKhpwsmUZUT+Q3rO5VUu3E0
 IJoZdyTQoZL16M/HarBygLN22tmRADwPsJh18KlQqzhKQBkIQmMAbxj/md0MZ8D4DpTu0PP8uz6
 4TrnxEDTrPC2JXTHkDvOZCyPoUPNy7Ae/yyWxXYbzc106PhyDj8p6dGmI/k3V9EdYTxIkVI+C3v
 Zr7RnFASITXVE90i/h/aFsCglS49ucPKxaktUP5EQJoAYyyPKVATV5jCxh22tx9fp2IcXz90IFl
 n3oZN3RwCg4agA0ql2c6UE6PFfJ9CjzJHGuoIEl31vtn6kyWLnv8/w==
X-Google-Smtp-Source: AGHT+IHHqHgTkKLvfEueDG67UYtM46xknrsuiXxZPifyDEbcpzZ4jbYdygLszmTfeSLmzbfMtqZ8vQ==
X-Received: by 2002:a17:903:2341:b0:223:4c09:20b8 with SMTP id
 d9443c01a7336-22c3596bbbbmr59711195ad.37.1744850984244; 
 Wed, 16 Apr 2025 17:49:44 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33fccafcsm20949715ad.205.2025.04.16.17.49.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 17:49:43 -0700 (PDT)
Message-ID: <0af3284c-9a5a-471c-ae7f-41e0ea18a766@linaro.org>
Date: Wed, 16 Apr 2025 17:49:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 000/163] tcg: Convert to TCGOutOp structures
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <a093de11-8901-4e1b-83eb-fd3b6a557249@linaro.org>
 <baa52414-03a5-4c86-9719-d6d5419cd798@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <baa52414-03a5-4c86-9719-d6d5419cd798@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

T24gNC8xNi8yNSAxNzoxOCwgUmljaGFyZCBIZW5kZXJzb24gd3JvdGU6DQo+IE9uIDQvMTYv
MjUgMTY6MzgsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBUaGUgb25seSBjb25jZXJu
IEkgaGF2ZSBpcyB0aGF0IHdlIGNvdWxkIGNyZWF0ZSBzaWxlbnQgInBlcmZvcm1hbmNlIiBy
ZWxhdGVkIGJ1Z3MsIHdoZXJlIGENCj4+IHNwZWNpZmljIGZlYXR1cmUgaXMgZGVhY3RpdmF0
ZWQgYmVjYXVzZSBvZiBhIGJhZCBjb21iaW5hdGlvbiwgYnV0IGl0J3MgaW5oZXJlbnQgdG8g
dGhpcw0KPj4gYXBwcm9hY2ggYW5kIG5vdCBhIGJsb2NrZXIuDQo+IA0KPiBJIHRoaW5rIEkg
a25vdyB3aGF0IHlvdSBtZWFuLCBhbmQgdGhlIHdheSBJIHNlZSB0aGluZ3MgaXQgdGhhdCB0
aGUgc2lsZW50IHBlcmZvcm1hbmNlIGJ1Zw0KPiB3YXMgcHJldmlvdXNseSBzY2F0dGVyZWQg
YWNyb3NzIGRpZmZlcmVudCBzZWN0aW9ucyBvZiB0aGUgY29kZSwgd2hlcmVhcyBub3cgaXQg
aXMgb24gdGhlDQo+IHNhbWUgcGFnZS4gIEJ1dCB1bmRlcm5lYXRoIHRoZXJlIGlzIG5vIHJl
YWwgY2hhbmdlLg0KPiANCj4gVW5sZXNzIHlvdSBtZWFuIHNvbWV0aGluZyBkaWZmZXJlbnQ/
DQo+IA0KDQpJdCBzaG91bGQgYmUgZnVuY3Rpb25uYWxseSBlcXVpdmFsZW50IGluZGVlZCwg
YnV0IGluIGNhc2Ugb25lIG9mIGNzZXRfKiANCmZ1bmN0aW9uIGNvbnRhaW5zIGJ1ZywgaXQg
bWlnaHQgc2lsZW50bHkgZmFsbGJhY2sgdG8gYSBzbG93ZXIgDQppbXBsZW1lbnRhdGlvbi4g
VGhlIFRDR19UQVJHRVRfSEFTXyogd2VyZSBsZXNzIGVycm9yIHByb25lIEkgZ3Vlc3MsIGFz
IA0KaXQncyBqdXN0IGEgZGVjbGFyYXRpb24uDQoNCkJ1dCBvdmVyYWxsLCB0aGUgbmV3IGFw
cHJvYWNoIGlzIHJlYWxseSBiZXR0ZXIsIHNvIGl0J3Mgd29ydGggdGhlIHJpc2suDQoNCj4+
IEFzIGEgbW9yZSBnZW5lcmFsIHF1ZXN0aW9uLCBob3cgZG8geW91IGFwcHJvYWNoIHRlc3Rp
bmcgZm9yIGEgc2VyaWVzIGxpa2UgdGhpcyBvbmU/IEkgc2VlDQo+PiB0d28gZGlmZmVyZW50
IGNoYWxsZW5nZXMsIGFzIGl0IHRvdWNoZXMgdGhlIElSIGl0c2VsZiwgYW5kIHRoZSB2YXJp
b3VzIGJhY2tlbmRzLg0KPj4gLSBGb3IgdGhlIElSLCBJIGRvbid0IGtub3cgaG93IGV4dGVu
c2l2ZSBvdXIgY29tcGxldGUgdGVzdCBzdWl0ZSBpcyAocmVnYXJkaW5nIGNvdmVyYWdlIG9m
DQo+PiBhbGwgZXhpc3RpbmcgVENHIG9wcyksIGJ1dCBJIGd1ZXNzIHRoZXJlIGFyZSBzb21l
IGhvbGVzIHRoZXJlLiBJdCB3b3VsZCBiZSBpbnRlcmVzdGluZyB0bw0KPj4gZ2VuZXJhdGUg
Y292ZXJhZ2UgZGF0YSBvbmNlIHdlIGNhbiBnZXQgYSBzaW5nbGUgYmluYXJ5IGluIHRoZSBm
dXR1cmUuDQo+IA0KPiBJIGRvbid0IHVzZSBhbnl0aGluZyBtb3JlIHRoYW4gb3VyIHRlc3Rz
dWl0ZS4NCj4gQ292ZXJhZ2UgZGF0YSB3b3VsZCBpbmRlZWQgYmUgaW50ZXJlc3Rpbmc7IEkn
dmUgbm90IGF0dGVtcHRlZCB0aGF0Lg0KPiANCg0KSSB0cmllZCBwcmV2aW91c2x5LCBidXQg
c2luY2Ugd2UgaGF2ZSBkdXBsaWNhdGVkIGNvbXBpbGF0aW9uIHVuaXRzIHBlciANCnRhcmdl
dCwgdGhpcyBpcyBjb25mdXNpbmcgZm9yIGFueSBjb3ZlcmFnZSB0b29sLCBhcyBzb29uIGFz
IHlvdSB0cnkgdG8gDQphZ2dyZWdhdGUgZGF0YSBmcm9tIHNldmVyYWwgdGFyZ2V0cy4NCg0K
Pj4gLSBGb3IgdGhlIHZhcmlvdXMgYmFja2VuZHM6DQo+PiAgIMKgICogQXJlIHlvdSBhYmxl
IHRvIGNvbXBpbGUgUUVNVSBvbiBhbGwgY29uY2VybmVkIGhvc3RzIGFuZCBydW4gdGVzdGlu
ZyB0aGVyZT8NCj4gDQo+IEkgaGF2ZSBhYXJjaDY0LCBhcm0sIHMzOTB4IHZpYSAqLmNpLnFl
bXUub3JnOw0KPiBsb29uZ2FyY2g2NCwgcmlzY3Y2NCwgcHBjNjRsZSB2aWEgdGhlIGdjYyBj
b21waWxlIGZhcm0uDQo+IA0KPj4gICDCoCAqIE9yIGRvIHlvdSBjcm9zcyBjb21waWxlIGFu
ZCBydW4gYmluYXJpZXMgZW11bGF0ZWQ/DQo+IA0KPiBUaGlzIGlzIG15IG9ubHkgb3B0aW9u
IGZvciBtaXBzZWwsIG1pcHM2NGVsLg0KPiANCj4gSSBkbyBub3QgZXZlbiBoYXZlIGEgY3Jv
c3MtY29tcGlsZSBzb2x1dGlvbiBmb3IgcHBjMzIsIGFzIHRoZXJlIGlzIG5vIGxvbmdlciBh
bnkgZGlzdHJvDQo+IHN1cHBvcnQuIEkgaGF2ZSBiZWVuIGlnbm9yaW5nIHRoYXQsIHdhaXRp
bmcgdG8gcmVtb3ZlIGl0IHdoZW4gYWxsIDMyLWJpdCBob3N0cyBnZXQga2lja2VkLg0KPiAN
Cj4gDQo+IHJ+DQoNCg==

