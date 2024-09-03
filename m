Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31626CD343D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 14:52:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slU1m-0007QP-Ct; Tue, 03 Sep 2024 09:57:06 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slU0m-0007NQ-Ik
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 09:56:01 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slU0D-0006YI-Ed
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 09:55:52 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42bbd16fcf2so36966155e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 06:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725371634; x=1725976434; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AbJKNCwW/XpaAMYQoJPQUSxctQzqjFRdpARUfLirEpY=;
 b=UBuFfS3AwZ1I0P4SMl2x3cVG0IcezWAfC0E0+armLEJwHbcwMMRbxD8kJX+RcYwt9e
 8lx2Lx96NGLmvWQnxzzQQFUe5hj5sFSK3yYSdJJybXzqkfL0L6+QQUQeri9gQ+5CkdGy
 aqJgx1EQo4Lz7Y/lYABHdTaABe+p8iNDESbOU3d1plQvf5R6ydTggGq2vNREhNIlNmRO
 rORHA6oQpOxCH7fesoA0E6G7XnhWV1qtC1qZazv4aq3LWc0gOVyVsDlHlUf6b0dqBS/1
 yHrz5/pnAogcA9GSgPc3zfV7rncytl8jL7fsMkS32/pvwmSzgFcVrOXyXBqFNTcQJjgX
 +lmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725371634; x=1725976434;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AbJKNCwW/XpaAMYQoJPQUSxctQzqjFRdpARUfLirEpY=;
 b=hatTeefPvqbTwcs+0+Nw62Q0qk5bW8snxZVKzyKyl6wjGzEIkrK2lsL+mp2DHh2xSS
 qNQRZ3vW3sDgp+uhjxa3iZ+0JWQZro4gykwrzeFhkxbibDrqjJn5at3GOHUv4vb2D3Hf
 yBHpzqk3A22TXNEsHxiMn4XVFyGiHLJ6xHhInUK3V7dBV7PW3a527zsqtZsmwVINTiNV
 me9Kq8GSDzbTiXbbFOqltS0dncHRmgkKmL/rjx6iRv7RcXVZ+bIfePTNWghn/pvfsyTh
 MihlEVOe/YgEHzlnFisLC48GWJugZ70TrFQwHR3ZNToQxihXfu1kQGeXbjZsbjzbyplq
 fqMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhzYx8Gnz7/9QCOI4nnXENvM2qKc66zL+Jg5aqUwiAAXNp78W/HikaktdpZBMWhZG6OIlQT6P5rg2E@nongnu.org
X-Gm-Message-State: AOJu0Yzxa579CLEUjUgbKDlKWh2hyaAuC/wEqZ70XupE+BVAKCM3oW8/
 MIkKNO4/T+4Ny7LtwQBBy/QygPNHE5OPB3+n8sd6aYoPS6FTLhyeDnut1V95Vy3Rk9lOqIjZZPK
 e
X-Google-Smtp-Source: AGHT+IEUYoaZvJnfZeEq74yOlruRr1tUBL9ks7J5HN7w7+TgPUK1V2KlMyFoulnkYZpepftzW7ipow==
X-Received: by 2002:a05:600c:a4c:b0:426:5dc8:6a63 with SMTP id
 5b1f17b1804b1-42bb01e6ca3mr102390735e9.30.1725371634275; 
 Tue, 03 Sep 2024 06:53:54 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42b9e7b7f87sm179620455e9.1.2024.09.03.06.53.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2024 06:53:53 -0700 (PDT)
Message-ID: <7a061449-3bbf-4cc5-a9db-ecc1f01af784@linaro.org>
Date: Tue, 3 Sep 2024 15:53:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kvm/i386: make kvm_filter_msr() and related
 definitions private to kvm module
To: Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org
References: <20240903134441.40549-1-anisinha@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240903134441.40549-1-anisinha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, T_SCC_BODY_TEXT_LINE=-0.01, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 3/9/24 15:44, Ani Sinha wrote:
> kvm_filer_msr() is only used from i386 kvm module. Make it static so that its
> easy for developers to understand that its not used anywhere else.
> Same for QEMURDMSRHandler, QEMUWRMSRHandler and KVMMSRHandlers defintions.

"definitions".

> 
> CC: philmd@linaro.org
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>   target/i386/kvm/kvm.c      | 12 +++++++++++-
>   target/i386/kvm/kvm_i386.h | 11 -----------
>   2 files changed, 11 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


