Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC7DC3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 15:26:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2tmm-0005ll-0Z; Thu, 10 Apr 2025 11:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u2tme-0005lO-T1
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 11:25:42 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u2tma-00069u-Sr
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 11:25:39 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3018e2d042bso680240a91.2
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 08:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744298734; x=1744903534; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qv2bPBi9xBWDzO7IKyXQxcD8pmVkuqtkafS4Fc1WRa0=;
 b=eek8glCjXBTnLbgntyNcc3+bNCCGyfp3RkfKdLoIM+oJpDTjyaLILtZhVHVfN56nVC
 DsYR7hL0vs7vOQU8warE9hZVlql6BdrXbonK7hsbI4ZayrSMXA+ysCt+/lU/nM8XP/aJ
 Wg6ocNKpzP/05jB0/rzJA7A21BA5Wdr7trw01pj6TwTnJLkI1dLr3f/kZdO5+CC8fKeK
 tgx/CGHAkbHwtqHUNbxZ54jlf2ifYjVB5Js0KSvbwmgenFBlKj8J1BZmL2qjhVMtKA8z
 7itJRptrQujT6P/qcZCCad3kiYBuorVAvXZ+YYUAHVejpCQqd6tItOnpbzGob6hGiMxb
 n9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744298734; x=1744903534;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qv2bPBi9xBWDzO7IKyXQxcD8pmVkuqtkafS4Fc1WRa0=;
 b=hqlmTl2Xsm7JqmkstoSJ2OkPPKyQknJC5mLrERkXMUM9ET500PqrnEbquJs3DebUOQ
 IQ052iBYf8LUrg+b89JJFwhZvvkPLZ6/d7Z24eOLW+7j1OU6ARLRC5+QvuGzxO+Yutjl
 laiaxCX5vGilIQFSprRM0BfjedSejRaOf0Sy93ZXAZDAiOBAKKYacFVzURSJxW+at+Tz
 Qm8wmsisQ2gmok6CLNABhrFN58+4RfCJ64g5TAl01S8qRLgIfNkbWqtRVLz2iayXElLU
 cEEsbcUZEJzOp8tkhhsEdGfaqgWHSnLHadGiiaohPUUL+GsTYtNXYmEgTMirYHzL0/sp
 2Idw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWojhTimpSmgjBGarjJPJAiatVaPqY560pzt0Qx7nCmlYKpwa+HVzu6AnTEAewshtHpyEjtJguD1AnM@nongnu.org
X-Gm-Message-State: AOJu0YwZWm+pxDT36VzOA3oXBGo+KXCMpR2yDIfol8PjmbHv3PGJ2h2Q
 F6z4faFrg3I87nIr8wXKYPy44nvUtekwMltxZmyRG/C8TB2yv167NgV2jDem4fM=
X-Gm-Gg: ASbGnctkB+kjsuiJWJWR8uD8B5DMYwsHTpi7VimhZ27+46VZcStEz3ar73GShrfmv3v
 anUDT4IMdthfmsQ9fxUXOi9pN7AGu9cTxTwLQfr0kI+/PhxDeNemY0ce1jYaTpWkuAfiA706Zf1
 E+kKNYR3T7W7nmNGbYeN+CSdRiPgFvl06cNkI6TTBVC8qyJBUXygo84d4HxsjACA/83sBSDP/u6
 ky24atDy+eETYvYJtowUP4dE1OuF4VAfwMpIYQnJ4n7rhSa8+n7h+7f6PhqunGeARZ+jZBw0n08
 TMEUfPcuLh9hvN3SFJOUTFxfNR0WS2gnVk47Eoo5bHV+0cVkM3w6iqZ2REAu31b+
X-Google-Smtp-Source: AGHT+IFfyAh1JVU7m7un12zx1T6MJaeKjljX99KvEdfk9g3foLmSAbIwptR4IddCtFGby4wy7UzxUA==
X-Received: by 2002:a17:90b:2d46:b0:2ee:6d08:7936 with SMTP id
 98e67ed59e1d1-30718b82e49mr4835990a91.20.1744298734220; 
 Thu, 10 Apr 2025 08:25:34 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306df0823aasm3660606a91.20.2025.04.10.08.25.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Apr 2025 08:25:33 -0700 (PDT)
Message-ID: <a8d9bc7f-2162-4198-ab6c-67e72c5e964e@linaro.org>
Date: Thu, 10 Apr 2025 08:25:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Issue with stoptrigger.c Plugin in QEMU Emulation
Content-Language: en-US
To: Saanjh Sengupta <saanjhsengupta@outlook.com>
Cc: "philmd@linaro.org" <philmd@linaro.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "amir.gonnen@neuroblade.ai" <amir.gonnen@neuroblade.ai>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "aabhashswain25@gmail.com" <aabhashswain25@gmail.com>,
 "aniantre@gmail.com" <aniantre@gmail.com>,
 "guptapriyanshi180@gmail.com" <guptapriyanshi180@gmail.com>,
 "harshitgupta5049@gmail.com" <harshitgupta5049@gmail.com>
References: <E57BEAE6-4DE5-4FF7-AADE-DB43678FE2E6@outlook.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <E57BEAE6-4DE5-4FF7-AADE-DB43678FE2E6@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102e.google.com
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

SGkgU2FhbmpoLA0KDQpJIGhhdmUgbm90IGJlZW4gYWJsZSB0byByZXByb2R1Y2UgdGhlIGlz
c3VlIHdpdGggY3VycmVudCBtYXN0ZXIgYnJhbmNoLg0KSXMgaXQgYW4gZXJyb3IgeW91IHNl
ZSBmb3IgZXZlcnkgcnVuPw0KDQpSZWdhcmRzLA0KUGllcnJpY2sNCg0KT24gNC8xMC8yNSAw
NDoxMCwgU2FhbmpoIFNlbmd1cHRhIHdyb3RlOg0KPiBIaSwNCj4gDQo+IEkgYW0gd3JpdGlu
ZyB0byBzZWVrIGFzc2lzdGFuY2Ugd2l0aCBhbiBpc3N1ZSBJIGFtIGV4cGVyaWVuY2luZyB3
aGlsZSANCj4gdXNpbmcgdGhlIHN0b3B0cmlnZ2VyLmMgcGx1Z2luIGluIFFFTVUgZW11bGF0
aW9uLiBJIGFtIGN1cnJlbnRseSANCj4gdXRpbGlzaW5nIHRoZSBsYXRlc3QgUUVNVSB2ZXJz
aW9uLCA5LjIuOTIsIGFuZCBhdHRlbXB0aW5nIHRvIGVtdWxhdGUgdGhlIA0KPiBEZWJpYW4g
MTEgYXMgdGhlIG9wZXJhdGluZyBzeXN0ZW0uDQo+IA0KPiBUaGUgY29tbWFuZCBJIGFtIHVz
aW5nIHRvIGVtdWxhdGUgUUVNVSBpcyBhcyBmb2xsb3dzOg0KPiAqLi9idWlsZC9xZW11LXN5
c3RlbS14ODZfNjQgLW0gMjA0OE0gLXNtcCAyIC1ib290IGMgLW5vZ3JhcGhpYyAtc2VyaWFs
IA0KPiBtb246c3RkaW8gLW5pYyB0YXAsaWZuYW1lPXRhcDAsc2NyaXB0PW5vLGRvd25zY3Jp
cHQ9bm/CoCAtaGRhIA0KPiBkZWJpYW4xMS5xY293MiAtaWNvdW50IHNoaWZ0PTAgLXBsdWdp
biAuL2J1aWxkL2NvbnRyaWIvcGx1Z2lucy8gDQo+IGxpYnN0b3B0cmlnZ2VyLnNvLGljb3Vu
dD05MDAwMDAwMDAwIC1kIHBsdWdpbiAtcW1wIA0KPiB0Y3A6bG9jYWxob3N0OjQ0NDQsc2Vy
dmVyLHdhaXQ9b2ZmKg0KPiANCj4gSG93ZXZlciwgd2hlbiBJIGF0dGVtcHQgdG8gdXNlIHRo
ZSAtaWNvdW50IHNoaWZ0PTAgb3B0aW9uLCB0aGUgcGx1Z2luIA0KPiBmYWlscyB3aXRoIHRo
ZSBlcnJvciAiKkJhc2ljIGljb3VudCByZWFkKiIuIEkgaGF2ZSBhdHRhY2hlZCBhIHNjcmVl
bnNob3QgDQo+IG9mIHRoZSBlcnJvciBmb3IgeW91ciByZWZlcmVuY2UuDQo+IA0KPiBlcnJv
ci5wbmcNCj4gDQo+IFdoZW4gSSByZW1vdmUgdGhlIC1wbHVnaW4gYXJndW1lbnQgZnJvbSB0
aGUgY29tbWFuZCB0aGUgT1MgYm9vdHMgdXAgDQo+IHBlcmZlY3RseSwgYXMgZXhwZWN0ZWQu
IENvbW1hbmQgdXRpbGlzZWQgaW4gdGhhdCBjb250ZXh0IHdhcyBzb21ld2hhdCANCj4gbGlr
ZSAqLi9idWlsZC9xZW11LXN5c3RlbS14ODZfNjQgLW0gMjA0OE0gLXNtcCAyIC1ib290IGMg
LW5vZ3JhcGhpYyAtIA0KPiBzZXJpYWwgbW9uOnN0ZGlvIC1uaWMgdGFwLGlmbmFtZT10YXAw
LHNjcmlwdD1ubyxkb3duc2NyaXB0PW5vwqAgLWhkYSANCj4gZGViaWFuMTEucWNvdzIgLWlj
b3VudCBzaGlmdD0wIC1xbXAgdGNwOmxvY2FsaG9zdDo0NDQ0LHNlcnZlcix3YWl0PW9mZioN
Cj4gDQo+IA0KPiBJIHdvdWxkIGdyZWF0bHkgYXBwcmVjaWF0ZSBpdCBpZiB5b3UgY291bGQg
cHJvdmlkZSBndWlkYW5jZSBvbiByZXNvbHZpbmcgDQo+IHRoaXMgaXNzdWUuIFNwZWNpZmlj
YWxseSwgSSB3b3VsZCBsaWtlIHRvIGtub3cgdGhlIGNhdXNlIG9mIHRoZSBlcnJvciANCj4g
YW5kIGFueSBwb3RlbnRpYWwgc29sdXRpb25zIG9yIHdvcmthcm91bmRzIHRoYXQgY291bGQg
YmUgaW1wbGVtZW50ZWQgdG8gDQo+IHN1Y2Nlc3NmdWxseSB1c2UgdGhlIHN0b3B0cmlnZ2Vy
LmMgcGx1Z2luIHdpdGggdGhlIC1pY291bnQgc2hpZnQ9MCBvcHRpb24uDQo+IA0KPiANCj4g
UmVnYXJkcw0KPiANCj4gU2FhbmpoIFNlbmd1cHRhDQo+IA0KDQo=

