Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A4EACD4F5B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 08:29:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sm7rE-0005sX-N6; Thu, 05 Sep 2024 04:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sm7rB-0005jl-7Z
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 04:28:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sm7r9-0003rB-1o
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 04:28:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725524921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=72tp/aHJd5yf3KJuEmi80Ko4ohiJJaa17zcLLnLLIpI=;
 b=MdLujygTbqwpg2uZ1kcrLMlISATzkQQP+CJ8EyAVdjDjyfI+uMEr7w2Gpye7ghwir/Cw7r
 L7kIIdVCfmZCbGDRH+jqjPhfQ6wPWuOIKmM/zP1FhVqUlFKdXKB5iYCoGYHiWR+COo4w5n
 R1ITm5aM+YoWDr2ekDVM6/pegwBNnxc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-1g5Mbn2nMFWKgWC_XSuF4Q-1; Thu, 05 Sep 2024 04:28:40 -0400
X-MC-Unique: 1g5Mbn2nMFWKgWC_XSuF4Q-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-374bb1e931cso828041f8f.0
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 01:28:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725524919; x=1726129719;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=72tp/aHJd5yf3KJuEmi80Ko4ohiJJaa17zcLLnLLIpI=;
 b=sYyedOmw2P75VkrolDww7IudrCiftcIA6SwS/IMMUjTCzLCO1L0k//o1AqJdfxasiy
 GNBbF4kU8YhM1/IhJayTyOMf4kXpnKDUbPyCb/cb6sr3rKWOhbS24skIMxLMQEdt2O41
 6yLtQwKqG7BiS/caGj8KJFOoqt/B9Pu1bkaJENML6SF8GdTrlBQwFrxV4vdcXZ0Vwdup
 f/H+5gMS8TyqOpnUyk9Biatm/d73g7kIl4N4KnHyLp+MlF3lhrkQILpCsosT/Kwc5/Ff
 OgRaKZHLvSQprEI1FDYMCMnxhH8MS60WpRyvjKegsaAZuFgpk7tzovOFcUKHjE5hGxea
 /6MQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW40IuSLs8H1dRxVHlLEAMNXbiS8/Wd8A3uHNrla7e7EZx0nqUZ09QOBMvsLo0/Qp6p9WXN9k1djzVl@nongnu.org
X-Gm-Message-State: AOJu0YzZO4qfPTuq472+VMNo4wDxjW5GSCwuxAd3SIcbqOA3KnZ/3vs6
 6LFFZk73IGhA6MuIATVUSY55+cOiisKOFVHocitj+YF2f8kWKc4BTfydl2CFul8Y3unFoP/EXSr
 ei4M+ahD+dOlemqlvajlhgoBchIeUesedNxC4TIJ8UMmuqd8jMckRsxk9n+cikPo=
X-Received: by 2002:a05:6000:d1:b0:374:c1ea:2d40 with SMTP id
 ffacd0b85a97d-377998aaeabmr3215520f8f.1.1725524918897; 
 Thu, 05 Sep 2024 01:28:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+6OKrdPLKQ8DI2SITgeKuWKdilpb5ADAOpSrSPM0TlRap2R+3UYZfCEWOmDoi/vCOCqh1LQ==
X-Received: by 2002:a05:6000:d1:b0:374:c1ea:2d40 with SMTP id
 ffacd0b85a97d-377998aaeabmr3215502f8f.1.1725524918388; 
 Thu, 05 Sep 2024 01:28:38 -0700 (PDT)
Received: from [192.168.10.28] ([151.95.101.29])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-42baa08d9f9sm251207865e9.32.2024.09.05.01.28.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Sep 2024 01:28:37 -0700 (PDT)
Message-ID: <37254a58-3f76-4c12-a2ae-0f2259e8bf9f@redhat.com>
Date: Thu, 5 Sep 2024 10:28:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest/meson.build: Add more CONFIG switches checks
 for the x86 tests
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Laurent Vivier <lvivier@redhat.com>
References: <20240904082116.209260-1-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240904082116.209260-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 9/4/24 10:21, Thomas Huth wrote:
> When configuring QEMU with "--without-default-devices", currently a lot
> of the x86 qtests are failing since they silently assume that a certain
> device or the i440fx pc machine is available. Add more checks for CONFIG
> switches here to not run those tests in case the corresponding device is
> not available.

Is this enough to fix this:

# Check our reduced build configurations
# requires libfdt: aarch64, arm, loongarch64, microblaze, microblazeel,
#   or1k, ppc64, riscv32, riscv64, rx
# fails qtest without boards: i386, x86_64
build-without-defaults:

and add i386-softmmu/x86_64-softmmu to build-without-defaults?

Thanks,

Paolo


