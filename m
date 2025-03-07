Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F5B6C282DE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 22:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqgKp-0004lI-Kz; Fri, 07 Mar 2025 17:38:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqgKm-0004k7-Cf
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:38:25 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqgKk-00030r-Nd
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:38:24 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2feae794508so3807515a91.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 14:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741387101; x=1741991901; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lpdyTQNoyvLDcPXfv7S+MFAA9YfJCY5NKT43UZABoS8=;
 b=Rji2jgjoI1vR37TnWbZdkp+CF+o/eHihNo2XX2DA/JDTmrV+xeH44ixgUutVr2LrzB
 rTeyTHD5X+/9bx4kTpvpD+mEEB1qUXzyBhV9SmjyKQvUEvLHyUnX0EIaezH0wd8KuBna
 2KzS/CAQBA/C5CpNepFtWPxfEpP8GK9hxYZ5Gdalazu6UbGIPBjdGVukLvLfO0rfICQL
 3Pjnk/IlF35xYN2D3inBwBtj/whmfNLqPKpM5iuD/rDPTrBybIUYfW06le/WkyyPHSg1
 brcfOfEhLzDBuXvjlDBg5i4c7rXSr3GdyzMmP05koZ9++Az/0kvxGb2BrJZYuxvCDjND
 BQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741387101; x=1741991901;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lpdyTQNoyvLDcPXfv7S+MFAA9YfJCY5NKT43UZABoS8=;
 b=CJNPV/IdCpcDFUd1vevYCTT/ftY/oM0n66s/sc4yf6PdvK5Xgicdra+Z6t6uq87gwb
 hMv6MMOOOVCpME5peiqajcUeHfbNRph7CFangjl2P5h9n7BZaam7ZgpuBi7ymKKMEvzR
 J8nvlHIs9sOGOJXYUL5I3oYqG4ICFtoAjgVFO8dBLN2ngRGEFP+f3F6b6JPQnPxvKUOc
 KuuyZFPXuIwfAL6H79ddl1BqbdK5zG5pc+9Sb6EBmTqcwjobrU62yDIjVKo0We2mkCFl
 tEGxpqMEJg1bo1iNdx9Y2BYumGv1wOyLWSSIbvTSlqNexvnuiJU/i+I+bcoujOyMDN6s
 1low==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHUtorkOHAp3tk0nzeBvrFnf95w7QolHdkmvPmi+9xdOF9MuJE0/LYsNEVzEa1PFbOu4Y2d50aeQ2O@nongnu.org
X-Gm-Message-State: AOJu0YxWA98x5TL1uH6HW0B0koVy0sQov9hAjNLtC4e+7grsP+19YeA1
 lSzizvkLeccuMP9T1e1tB8yGiRbb2om+EcZeBB5XXkZtLI2Qj+tRKQHUERX9lPs=
X-Gm-Gg: ASbGncuygtm//MJR01cCpFVkOusNijrrEzclQ98QGgO3hJEv+8h9EsS64cNPtic9OPX
 RrZfxIo0hCVpNCJbwkWpS8sKsZYXTj0wn+mVEKO7RTVBDgxZpuexUxinRPBxfbCh/MC9fOkbu1a
 VZ3btSD8jc5fcF+b2UHPRfKyyPPliBCfByGQZgHls1NeONDWjYuhfhOMEdTTau15XJ7mzuK3CMN
 nD5xyaKJVC1a0M0ua9PeZrL5/ncRspAQs3hM7nM2hdF3UaEQVkhXz4Rqkjy16lrtZkmGUGeuxL3
 sy/c4f/ZGvD6wGymnwYRS24uO5nrReLZI0QL9V5iPrPhXbpIcXNrxpA9ew==
X-Google-Smtp-Source: AGHT+IFRvX91pdjWbDKnSP+k+ImsF7U6gTpnKvt8Vx6MdsWqPIPr62rb0Sr9WIH7YOso2WdWOgisgw==
X-Received: by 2002:a17:90b:48ce:b0:2ff:64c3:3bd9 with SMTP id
 98e67ed59e1d1-2ff7ceee4bdmr6532714a91.23.1741387099805; 
 Fri, 07 Mar 2025 14:38:19 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff693e72basm3591779a91.39.2025.03.07.14.38.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 14:38:19 -0800 (PST)
Message-ID: <41e7da17-5f8b-4cae-8cab-36055f2b4794@linaro.org>
Date: Fri, 7 Mar 2025 14:38:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] hw/hyperv: remove duplication compilation units
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 alex.bennee@linaro.org, Marcelo Tosatti <mtosatti@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 richard.henderson@linaro.org, manos.pitsidianakis@linaro.org
References: <20250307215623.524987-1-pierrick.bouvier@linaro.org>
 <fb8f0700-2676-4e7a-8857-ca10f5060b37@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <fb8f0700-2676-4e7a-8857-ca10f5060b37@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1030.google.com
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

T24gMy83LzI1IDE0OjA2LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gT24g
Ny8zLzI1IDIyOjU2LCBQaWVycmljayBCb3V2aWVyIHdyb3RlOg0KPj4gV29yayB0b3dhcmRz
IGhhdmluZyBhIHNpbmdsZSBiaW5hcnksIGJ5IHJlbW92aW5nIGR1cGxpY2F0ZWQgb2JqZWN0
IGZpbGVzLg0KPj4NCj4+IGh3L2h5cGVydi9oeXBlcnYuYyB3YXMgZXhjbHVkZWQgYXQgdGhp
cyB0aW1lLCBiZWNhdXNlIGl0IGRlcGVuZHMgb24gdGFyZ2V0DQo+PiBkZXBlbmRlbnQgc3lt
Ym9sczoNCj4+IC0gZnJvbSBzeXN0ZW0va3ZtLmgNCj4+ICAgICAgIC0ga3ZtX2NoZWNrX2V4
dGVuc2lvbg0KPj4gICAgICAgLSBrdm1fdm1faW9jdGwNCj4gDQo+IEJ1ZywgdGhlc2Ugc2hv
dWxkIGJlIGRlY2xhcmVkIG91dHNpZGUgb2YgQ09NUElMSU5HX1BFUl9UQVJHRVQuDQo+DQoN
ClllcywgSSBub3RpY2VkIHlvdSBzb2x2ZWQgaXQgdGhpcyB3YXkgb24gb25lIG9mIHlvdXIg
c2VyaWVzLg0KSW4gdGhlIGVuZCwgc2luY2UgUUVNVSBkb2VzIG5vdCBoYXZlIGFueSBzcGVj
aWZpYyBib3VuZGFyaWVzIGJldHdlZW4gDQpzdWJzeXN0ZW1zIChpLmUuIG5vIHByb3BlciBs
aWJyYXJpZXMgd2l0aCBwcml2YXRlL3B1YmxpYyBzeW1ib2xzKSwgd2UgDQphcmUgbW9zdGx5
IGZyZWUgdG8gaW5jbHVkZSBhbnkgc3ltYm9sIHdlIHNlZSBpbiBhbiBoZWFkZXIgYXMgbG9u
ZyBhcyBpdCANCmRvZXMgbm90IHVzZSBhIHRhcmdldCBkZXBlbmRlbnQgdHlwZSB3aGljaCBj
aGFuZ2VzIHRoZSBzaWduYXR1cmUuDQoNCj4+IC0gZnJvbSBleGVjL2NwdS1hbGwuaCB8IG1l
bW9yeV9sZHN0X3BoeXMuaC5pbmMNCj4+ICAgICAgIC0gbGRxX3BoeXMNCj4gDQo+IFllYWgs
IG5vdCBhbiBlYXN5IG9uZS4NCj4gDQoNCg==

