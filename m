Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 135E1C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 15:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rx7ON-0003be-TF; Wed, 17 Apr 2024 11:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rx7OH-0003bA-ML
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 11:40:10 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rx7OD-0004bf-Mv
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 11:40:04 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2a5215314a4so3566561a91.0
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 08:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713368398; x=1713973198; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UY3N20N4LYMkzmjW60Stplx7lNWuj7HeLzOMvh6/q8c=;
 b=qmY8AflMyX39LPPLoCAKIiM4vLbTgue6ChVX9dhn6JGQeRvb6kbdpBdlfdCIVev1fs
 X/oWK3f8+Azhl03gAQ/D8zVfDuQ0EAZQKkDg+fGE3giuzOj3vhGe3OyqC6XQSJi3iEmL
 7g/heqlif+1gn13a4Bnxwd0a5jA8PphWgWanAe6iz/nkIeRir03EBUZXp+tgdNAr5Equ
 CQQpoy7GxxjY3Krd3MLYxERYTnN4GEAJVDB7eVlhXrXi5VxjRUDamEuORdt9Nc1qjzrJ
 5DC78wUZqaucAPXl726Cj9oPRmqbder/4vlHaFxHkU+BeNM0u/Qgom1bD0eAjF4zwN73
 1JeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713368398; x=1713973198;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UY3N20N4LYMkzmjW60Stplx7lNWuj7HeLzOMvh6/q8c=;
 b=NLZO5F1fKsuk+pEi1NeBlqMe1kfHsJNiDZvvunv86zTCUej0TU1nDlg3Op912t6O1E
 4oy7zu4EeyQRlvM7s2rC3vRNJOaLQtYW/31OelOE5kad1Uji4vAlrf/4JhXgHSFre8yx
 lcUgaXEFxfm+EYS80xOJtkpQtP9pIJTTZI28RptqDmfdDkJRPBXSMe8CmV5CCvU0qEv4
 MecgASu4FeIQoBIu5fX02Z6RURBY3lSEjksXU4yNgEnS67KGKLRRTNS1ROLqCTNcc+93
 jFDUerv8TjI889K42zOWwE7lfy9eWZVVx4xkccEXOoLotE9CBuIAZUTen67+1W7jxx84
 Oggw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVb0+13PkSyikRGdKKEjwKauUBmiYyplIBKbhiAs38yUg/vYno5LcZDoREypoPN1BaqrWemS0Agneuzd+CGuYPhJBFEMfc=
X-Gm-Message-State: AOJu0YzF8eXHRpDKtcrTTnUS2t9JVaqEpCZL6BxFZREJ/3kMoVC7aGMx
 NQc/9pRf64hoM6OQf1dk/bPwjMIkNHBoREbfYY1DDq9/W0BFHG3CCsEwldvsBfg=
X-Google-Smtp-Source: AGHT+IFYD+IAK9O7yeYe/5Ix6tzkMg7TgpZZlv7zSlW5EoKEbIuJZpIwufR/bnq1JjM/IMUzdn2c6g==
X-Received: by 2002:a17:90b:3b89:b0:2ab:6c4e:de45 with SMTP id
 pc9-20020a17090b3b8900b002ab6c4ede45mr1289139pjb.40.1713368398485; 
 Wed, 17 Apr 2024 08:39:58 -0700 (PDT)
Received: from ?IPV6:2604:3d08:937d:c610::fc11? ([2604:3d08:937d:c610::fc11])
 by smtp.gmail.com with ESMTPSA id
 f21-20020a17090a4a9500b002a058af5e12sm1517832pjh.12.2024.04.17.08.39.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Apr 2024 08:39:58 -0700 (PDT)
Message-ID: <e3aabbd2-5743-46e0-bdb8-162e7a9ec674@linaro.org>
Date: Wed, 17 Apr 2024 08:39:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] plugins: Use unwind info for special gdb registers
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240416040609.1313605-1-richard.henderson@linaro.org>
 <c55a1d2c-bae0-44b5-9cd8-3df1b33c31ad@linaro.org>
 <91735cdb-0620-4fc6-a19d-08ca29acd9ff@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <91735cdb-0620-4fc6-a19d-08ca29acd9ff@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102a.google.com
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

T24gNC8xNi8yNCAxOTo0MCwgUmljaGFyZCBIZW5kZXJzb24gd3JvdGU6DQo+IE9uIDQvMTYv
MjQgMTc6MzUsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBPbiA0LzE1LzI0IDIxOjA2
LCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90ZToNCj4+PiBCYXNlZC1vbjogMjAyNDA0MDQyMzA2
MTEuMjEyMzEtMS1yaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnDQo+Pj4gKCJbUEFUQ0gg
djIgMDAvMjFdIFJld3JpdGUgcGx1Z2luIGNvZGUgZ2VuZXJhdGlvbiIpDQo+Pj4NCj4+PiBU
aGlzIGlzIGFuIGF0dGVtcHQgdG8gZml4DQo+Pj4gaHR0cHM6Ly9naXRsYWIuY29tL3FlbXUt
cHJvamVjdC9xZW11Ly0vaXNzdWVzLzIyMDgNCj4+PiAoIlBDIGlzIG5vdCB1cGRhdGVkIGZv
ciBlYWNoIGluc3RydWN0aW9uIGluIFRDRyBwbHVnaW5zIikNCj4+Pg0KPj4+IEkgaGF2ZSBv
bmx5IHVwZGF0ZWQgdGFyZ2V0L2kzODYgc28gZmFyLCBidXQgYmFzaWNhbGx5IGFsbCB0YXJn
ZXRzDQo+Pj4gbmVlZCB1cGRhdGluZyBmb3IgdGhlIG5ldyBjYWxsYmFja3MuwqAgRXh0cmEg
cG9pbnRzIHRvIGFueW9uZSB3aG8NCj4+PiBzZWVzIGhvdyB0byBhdm9pZCB0aGUgZXh0cmEg
Y29kZSBkdXBsaWNhdGlvbi7CoCA6LSkNCj4+Pg0KPj4NCj4+IFRoYW5rcyBmb3IgdGhlIHNl
cmllcyBSaWNoYXJkLiBJdCBsb29rcyBnb29kIHRvIG1lLg0KPj4NCj4+IEJlc2lkZXMgcmV2
aWV3aW5nIGluZGl2aWR1YWwgY29tbWl0cywgSSBoYXZlIGEgbW9yZSBnZW5lcmFsIHF1ZXN0
aW9uLg0KPj4gICBGcm9tIHNvbWUgZGlzY3Vzc2lvbnMgd2UgaGFkLCBpdCBzZWVtcyBsaWtl
IHRoYXQgcHJldmlvdXNseSBnZGIgc3R1YiB3YXMgY29ycmVjdGx5DQo+PiB1cGRhdGluZyBh
bGwgcmVnaXN0ZXIgdmFsdWVzLCBhbmQgdGhhdCBpdCBoYXMgYmVlbiBkcm9wcGVkIGF0IHNv
bWUgcG9pbnQuDQo+IA0KPiBOb3JtYWxseSBnZGJzdHViIGRvZXMgbm90IHJ1biBpbiB0aGUg
bWlkZGxlIG9mIGEgVEIgLS0gd2UgZW5kIG5vcm1hbGx5IChzaW5nbGUtc3RlcCwNCj4gYnJl
YWtwb2ludCkgb3IgcmFpc2UgYW4gZXhjZXB0aW9uICh3YXRjaHBvaW50KS4gIE9ubHkgdGhl
biwgYWZ0ZXIgVENHIHN0YXRlIGhhcyBiZWVuIG1hZGUNCj4gY29uc2lzdGVudCwgZG9lcyBn
ZGJzdHViIGhhdmUgYWNjZXNzIHRvIHRoZSBDUFVTdGF0ZS4NCj4NCg0KVGhhdCBtYWtlcyBz
ZW5zZS4NCiAgPg0KPj4gV2FzIGl0IGZvciBwZXJmb3JtYW5jZSByZWFzb25zLCBvciBhbiBh
cmNoaXRlY3R1cmFsIGNoYW5nZSBpbiBRRU1VPw0KPj4gSXMgZ2RiIHN0dWIgdGhlIHJpZ2h0
IHdheSB0byBwb2tlIHJlZ2lzdGVyIHZhbHVlcyBmb3IgcGx1Z2lucz8NCj4+DQo+PiBJIGRv
bid0IGtub3cgZXhhY3RseSB3aHkgc29tZSByZWdpc3RlcnMgYXJlIG5vdCB1cGRhdGVkIGNv
cnJlY3RseSBpbiB0aGlzIGNvbnRleHQsIGJ1dCBpdA0KPj4gc2VlbXMgbGlrZSB3ZSBhcmUg
dHJ5aW5nIHRvIGZpeCB0aGlzIGFmdGVyd2FyZCwgaW5zdGVhZCBvZiBpZGVudGlmeWluZyBy
b290IGNhdXNlLg0KPiANCj4gVGhlIG9uZSBvciB0d28gcmVnaXN0ZXJzIGFyZSBub3QgdXBk
YXRlZCBjb250aW51b3VzbHkgZm9yIHBlcmZvcm1hbmNlIHJlYXNvbnMuICBBbmQNCj4gYmVj
YXVzZSB0aGV5IGFyZSBub3QgdXBkYXRlZCBkdXJpbmcgaW5pdGlhbCBjb2RlIGdlbmVyYXRp
b24sIGl0J3Mgbm90IGVhc3kgdG8gZG8gc28gbGF0ZXINCj4gd2l0aCBwbHVnaW4gaW5qZWN0
aW9uLiAgQnV0IHJlY292ZXJpbmcgdGhhdCBkYXRhIGlzIHdoYXQgdGhlIHVud2luZCBpbmZv
IGlzIGZvciAtLSBhIGJpdA0KPiBleHBlbnNpdmUgdG8gYWNjZXNzIHRoYXQgd2F5LCBidXQg
b3ZlcmFsbCBsZXNzLCB3aXRoIHRoZSBleHBlY3RhdGlvbiB0aGF0IGl0IGlzIHJhcmUuDQo+
IA0KDQpUaGFua3MgZm9yIHRoZSBkZXNjcmlwdGlvbiwgSSB1bmRlcnN0YW5kIGJldHRlciB0
aGUgYXBwcm9hY2ggeW91IHBpY2tlZCANCmZvciB0aGF0IGlzc3VlLg0KDQo+IA0KPiByfg0K


