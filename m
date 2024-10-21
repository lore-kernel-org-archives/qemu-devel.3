Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C605D15DB8
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 16:14:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2v1H-00044m-Si; Mon, 21 Oct 2024 12:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t2v19-00042b-Mm
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:12:27 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t2v16-0003D4-QA
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:12:26 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2e2c6bc4840so3389673a91.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 09:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729527143; x=1730131943; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4tyI9HMcw+oed3UoyTiS3Y+lP3POZ+ihsONfL3iJWRs=;
 b=cGI0ulPIG+zcPC7+0v14wF3dPNOg6TzZ7YS8vXlm4S7kxAlzzTeTrwqlf1VeSiMgdd
 tnlgQwBDKNtphzzn6qdVagEqxXXpWCNSIIDXdmmA7qMMnRWS8qDHtKDdvPDs5QUSqU7Y
 4jh2LtdHfzhpOz+PffZZLrpVhwYImqzpzQ9T107rQ/2YgqC87TGwK7mFM1MNID7H4BO0
 gqJRgenOh3zf0tMeiBC4/ta9KsGaVpUo64szUMJLttT1ApyR/O50ZzJekaDAqTnwfT1h
 BYfpBfzSmGxa2mX5kRuaRB53v27/11EzAa9qnqF0OpOIiPUaxYqRuTmYanisamOEjnB7
 35Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729527143; x=1730131943;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4tyI9HMcw+oed3UoyTiS3Y+lP3POZ+ihsONfL3iJWRs=;
 b=DNyqNvt78TpjOC4g03TEu5RwlC42icfFaENG79i9I0tE25zfOlsO42aLZ/0Ksuolh9
 0mtjogFZrrpoYzE+SbO1LFNoS/r+CBDLaYqVDPrjFQbSx/2LCrweEFS7oTavbGVAD7md
 wfNn6oLl/oDsQj+lpKk/p0KvI+3GLinWCHi/syJCQGRkxtn/eMxGPCGBqix9u5ZnHKvm
 +y6RMKIX369o+PjZHzZt6Zpr+x7X09Q4tjMgLDUJ+29adt9wkzP/wwQEOP4t1+RKksTj
 7sg3+MhokXiypGr2t3wq2UXrUthlk+ccZoJ4VJPz1M3y+ahIOOT5liH71KfjIod8Qx/+
 mTrg==
X-Gm-Message-State: AOJu0Yxob99a1coN1twsZUKLYfc8DKzyDlq25fE6AGtrdMdyAu2N4Oic
 4fVGO1SZFaAj/dyPQPHiDK7zjdh0dJZAt2uezeQIe5pSZjK+REh53m9VScplLQs=
X-Google-Smtp-Source: AGHT+IEJ79rcO7UvywEBODvgpNUBrZrniDJFce4wT3Aa2wPLvxVw7ShFnIcwMRwswCfdTaS4rxYemg==
X-Received: by 2002:a17:90a:f30f:b0:2e2:bfb0:c06 with SMTP id
 98e67ed59e1d1-2e5616e893fmr13956844a91.12.1729527143007; 
 Mon, 21 Oct 2024 09:12:23 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e5ad388effsm4015553a91.34.2024.10.21.09.12.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 09:12:22 -0700 (PDT)
Message-ID: <58f35342-76a1-4de2-901e-0e138232af57@linaro.org>
Date: Mon, 21 Oct 2024 09:12:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] build qemu with gcc and tsan
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Thomas Huth <thuth@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-s390x@nongnu.org, Beraldo Leal <bleal@redhat.com>
References: <20240910174013.1433331-1-pierrick.bouvier@linaro.org>
 <87wmj0ypwe.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87wmj0ypwe.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

T24gOS8yNS8yNCAwMzo0MywgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBBbGV4IEJlbm7DqWUg
PGFsZXguYmVubmVlQGxpbmFyby5vcmc+IHdyaXRlczoNCj4gDQo+IFF1ZXVlZCB0byB0ZXN0
aW5nL25leHQsIHRoYW5rcy4NCj4gDQoNCkdlbnRsZSBwaW5nLiBJIGNhbid0IHNlZSB0aGlz
IHNlcmllcyBvbiB0ZXN0aW5nL25leHQuIFdhcyBpdCBsb3N0IG9uIHRoZSANCndheT8NCg0K
VGhhbmtzLA0KUGllcnJpY2sNCg==

