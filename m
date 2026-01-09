Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B715AD277C1
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 23:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veLs9-0005QK-83; Fri, 09 Jan 2026 18:26:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veLs7-0005Q4-Gg
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 18:26:23 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veLs6-00033v-1m
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 18:26:23 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-81db1530173so783843b3a.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 15:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768001180; x=1768605980; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h0GYBa3tahrIREApSfgw11G9eRbQHF6bUEUG9KknTy8=;
 b=Xlk/TWfasUQ30E3TBFW53rti5gyDxgixUVzZ5GtU15qSNPEl4ZylCqHMNchF7FaLT+
 26WSZHJVXL0BVuYMzSbBZ/+KAJhHeBM5OTcaAnBv/udbLaNZuqRAffgGsGZb56Mljpzq
 vVAB960gVrbAlk2rMQIlJdNs8HxGc7aOnx1dmTqmAtfkacue8isk2Ss9+haTLn9X6/RI
 R+JufsOJB/e6twa//kDPrisz/KendLF7d3DyOtbMCJ6qbjnpVYEQTMnzsoAdX13au12j
 OXG4Kxf35ywugvjzB6OKJlHNVfcCsQRGQBS12Q0l6uvG8OG5D2RcCchwoJ2xrynZiRbA
 /n4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768001180; x=1768605980;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h0GYBa3tahrIREApSfgw11G9eRbQHF6bUEUG9KknTy8=;
 b=mX2OMHHTe18ganY32o5uXZMipOeIwEofDWdRObUV3j+CsNiYZdzSuhL9Vr3Lu5WiET
 30HRVw+Hk6c0qNzPQ9dsRltDoFvvc/7572dx/60rBrLHw7liq7Rzuo7UbNxAbIV/2Dnj
 Em//HPwe3o4j1zXGC+E8XbvYqUEThHt9ppsbDR+zxtTjMHFnwAbh8M9FI3LgN3gSDXu3
 srV+/XogjqcEMIzTOlyCZ0kr4zDdHTyr3heoPN2Kp4spBXYWhdJPFReTUkTLGtQyv1cu
 xSpruF3fYQ7FMWnslQ3uoV3D+kYIJFxq6e94JvrRl84q4IPto6M/Ht4o/iV+s0SRb90q
 G4TA==
X-Gm-Message-State: AOJu0YyONtSNuAiBwbxdXtp1h7fzvkk98f2zqAPcIHT2eL2kipeiWbfs
 GoBjDPp1ue3LbjQTlx4IoLwMyWENMREdBBvUYE7jzNbI2Jk+nvDiyYDhBabAeabw9i0=
X-Gm-Gg: AY/fxX6I5a6QuxlRmYZ6RSowk54+Lddwft8bLB/L5g64cSSWWSTWeG6K/cAwJ7K2qpn
 Db1jgpnwPNLlumwDw1VT3RVha2xgC0AXNrv4y9B1A8VUQUinsCx4S3rE/RYAfyKa+UHnVR1W2pN
 Gy4209EWRZ/dLLuSCBKsF4zlObhOYs2WWhFW9+zkPEHX9bSdzJ8ZPQYNUDY8oW9zeYhAS+ipvCY
 QuKhru/tHhCMBCqEmuctLZsICnRbISUgG2OF+zxmQPGC+sWo5l8mY2kmzWDfZqvX+EnaE9smrMh
 7+9paPhwDV68Bx0kjaugSZhdHJXX5lx9wnV1VazQQl8fDs08vzLQ7K5tu1zCr/NSUktqGk2IQbS
 ujz/RT8Wn0KtquwzAp/POwKQRjtA9q6Pj4cAOGxkvZ0CrxqabvBom/nKQlc99/cNb0GvXXrrrp1
 DMREt3YKYXCAdhBzRfmDqCmMzZpBhaebju7L61
X-Google-Smtp-Source: AGHT+IGU/1RlPKTF4572H5CJ7wXJeV2GJM/kv3oz7/kx4y7+xXD44nY1E/m2yqZcEenpQ5c2vYh5ZA==
X-Received: by 2002:a05:6a00:e88:b0:7f6:2e6e:5289 with SMTP id
 d2e1a72fcca58-81b7fbcbd1bmr7992775b3a.49.1768001180406; 
 Fri, 09 Jan 2026 15:26:20 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81f3cae7e7esm161048b3a.44.2026.01.09.15.26.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 15:26:20 -0800 (PST)
Message-ID: <60994c46-d04f-461b-819b-31597a8405ab@linaro.org>
Date: Sat, 10 Jan 2026 10:26:12 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/22] util: Introduce ldm_p() and stm_p() load/store
 helpers
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Peter Xu
 <peterx@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260109165058.59144-1-philmd@linaro.org>
 <20260109165058.59144-3-philmd@linaro.org>
 <CABgObfYYx4-BcN7gbpNNiZi8nQhqYh-fgJ4j=6udogBnpz_7UQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CABgObfYYx4-BcN7gbpNNiZi8nQhqYh-fgJ4j=6udogBnpz_7UQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 1/10/26 04:23, Paolo Bonzini wrote:
> 
> 
> Il ven 9 gen 2026, 17:51 Philippe Mathieu-Daudé <philmd@linaro.org 
> <mailto:philmd@linaro.org>> ha scritto:
> 
>     Introduce load/store helpers which take a MemOp argument.
> 
>     Inspired-by: Paolo Bonzini <pbonzini@redhat.com <mailto:pbonzini@redhat.com>>
> 
> 
> That's a new one. :)
> 
> I think they should be inline and so should be address_space_{ld,st}m_internal (maybe even 
> always_inline). The amount of optimization enabled by constant MemOp is huge.

When are we going to have constant MemOp?


r~

