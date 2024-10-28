Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA9DD1039A
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 12:42:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5P3i-0005oI-2P; Mon, 28 Oct 2024 08:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5P3g-0005nu-Gh
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 08:41:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5P3e-0005n4-FV
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 08:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730119275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RvoUd9HjVzVnP99Y5W50q/QSiTPoFzwVY25GnbJjb48=;
 b=Fn2sSpLr1kBlNJfT0VvbW/97IUjt7HFcr6wHfKrod2+KLpg/Lp5fgv/zrVCy2yPM7xKRX5
 avTctoGqCFYzRAKYF0we1/Hkz8NItW+tL9Qe5dwYRLOcJhRh8XIHl4m/p2kNLW8QEq2Fo/
 z1d23mttE2oApEJ4SB4z3bvgJkeX3IA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-6PBSexE-NTq03-2DvBK_Ng-1; Mon, 28 Oct 2024 08:41:14 -0400
X-MC-Unique: 6PBSexE-NTq03-2DvBK_Ng-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d56061a4cso2353530f8f.2
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 05:41:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730119273; x=1730724073;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RvoUd9HjVzVnP99Y5W50q/QSiTPoFzwVY25GnbJjb48=;
 b=R7uD5hf+i++FEAAHsssX1+MZOdV5zQPBS17FzBX1IZzl2OhkuerU59VITlt83qhC2P
 4ENjpznzFlSZhYBQki1O1VLYsVwjLlQfXT3a9QnYTvDL0hMioRk364Lg/hbKw+zfn86l
 OFCS6TTzSj1Ynrek9bsQY3OczhUuo5EMpFgb17cuL0l+rhUeEXR2ps5exowNYDKfX2+j
 BoMPpGPb5mf8oPvn+eE3OxUgSNW0rjLWZ9ozdAjecZ32f5YEz0MFVvyeTiDMYVEYCyGE
 gx+z2+ItH0ng6Um2d5r8Vnu1bdPwhIyHLYCYhftjKytzZ3C/uZjtozXQWgPX6ID/fhCq
 M33A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/t1hSVRm5mePD44ZYbSbz4tzMgX55n1Mr+lI3RsO6ZNLsxdlDEr1bxlc8etGGduBZQ96Da3oCiPgX@nongnu.org
X-Gm-Message-State: AOJu0Yx8gg5dw32V+ufDr2CRlK6ed1NSjAhxeTWhRq+a0P8w0X3GA7Wz
 jRngxM4Z7w21ibOXIl+NLfzgJRMSdIeyOY9So1HmGDbs9YDu9/u9r2wLbNNO4cGUOz9VTx1LiKo
 iESWb3SBZ+i60uDgzX3PIyrWHifzcTqaJ7rGM6mCNfw9kGLwUNoaU
X-Received: by 2002:adf:e851:0:b0:37d:45f0:b33 with SMTP id
 ffacd0b85a97d-380610e6444mr5738501f8f.9.1730119273075; 
 Mon, 28 Oct 2024 05:41:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWWXtoECBGbQXyAJILZtC/76KafNdV63mQ9dPgXpfkZsJLznhCMB3Cq+0M/gFRv9FFVDDYnQ==
X-Received: by 2002:adf:e851:0:b0:37d:45f0:b33 with SMTP id
 ffacd0b85a97d-380610e6444mr5738481f8f.9.1730119272722; 
 Mon, 28 Oct 2024 05:41:12 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38058b928cesm9422807f8f.102.2024.10.28.05.41.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Oct 2024 05:41:12 -0700 (PDT)
Message-ID: <1d6034ef-9e41-4ef4-9a95-d03885b09b2b@redhat.com>
Date: Mon, 28 Oct 2024 13:41:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/23] rust: fix CI + allow older versions of rustc and
 bindgen
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 manos.pitsidianakis@linaro.org, zhao1.liu@intel.com, junjie.mao@hotmail.com
References: <20241025160209.194307-1-pbonzini@redhat.com>
 <95b07b6b-0980-4a32-86fd-602985750104@tls.msk.ru>
 <Zx9XbxxA5iXmfVWC@redhat.com> <87h68w8lbp.fsf@draig.linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <87h68w8lbp.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/28/24 13:26, Alex Bennée wrote:
> At least rustup makes this reasonably easy for the rust bits. We do rely
> on the excellent Debian backports for getting QEMU quickly into testing
> images but I was assuming we would have trixie before --enable-rust
> became mandatory so I'm not too worried if bookworm is the outlier for
> old versions.

I agree that we can delay making Rust mandatory only after Bookworm has 
gone away.  However, if we can make --enable-rust default as soon as 
possible, even in 10.0, then it would be easier if the same code (which 
is the Rust one) runs on all supported platforms.

All in all, the point of this series is to show that the workarounds for 
old rustc and bindgen are self-contained and easy to revert later when 
we can.  If we agree about that, it seems worse to me if a couple 
releases single out Bookworm as the only non-Rust supported platform.

Paolo


