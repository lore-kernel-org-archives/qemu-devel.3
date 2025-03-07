Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE732C28B24
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdP0-0000AU-Lb; Fri, 07 Mar 2025 14:30:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqdOu-00085b-Ps
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:30:29 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqdOt-0005Jr-4N
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:30:28 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22334203781so65110125ad.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741375825; x=1741980625; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xElhw45GbX7eLdoo8Przx/SbLWCDujOnVVlvjv4plD0=;
 b=uA/TM5/oH1xA81lkGpv6Zz4o5RSloY8Wv7h6EBx7OJcQZOvbgHyBJhu21/IyziSQxu
 EvEbnpl7tZ7jnok+W17tb3QYavj/QXuPwcWQl/zsE/WsTJ2/SRyWI77mDXU9Ti1m2ies
 z5WeZlEo5EEZ+lWyjbHqaKVRFDT/bJRdQWCpKTKmRmHOcmj8vB9Ad9LzMyi/rAleEW3R
 Z8q1GvmCW9bb8C/M7/JA5TLaSwOFj+ZDdwQ6Ckf1jLoH4ydFFFiKUV6KnTrpaQGHmxV/
 88+jeoI91FMqWT90PgkowCVwrzJSH/yATzIaik+WDdoyjqA9pCAtNpGQhEUBPfGthIBo
 7fGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741375825; x=1741980625;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xElhw45GbX7eLdoo8Przx/SbLWCDujOnVVlvjv4plD0=;
 b=JmFhCIQLZXY+DOHvA3pLXcU2qBGHlKJspqF1fchuRpe0VvHTW2jcgHqOjDvIAyfHWR
 faQGv1RYkKJnN6YZeZf+3UCTwksuOPDQY/uZEAvANxcs9oSeyuKjzl3ximsBR4Yb31VE
 vvMjhFAxzE0TZD/TuT/s+56VKz1UCKMGrEmKu1P0T7GJb0uX6DNQqbM9cxAr7QBZ0DOI
 Kdw7v2+/yi2rSubx+Z+RKSZxazDB0V27EREy56h6uDjPf0UFq2WF1n2cH6W+QKdO8jQM
 8kN8E3y9b/0re+Rwbsd/QoVqUXBznEPxCaNlE5zKGSyO4ooL7ChaOz3fDk1j2DpYoiJ2
 D2GQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoHpWx4sYVDQvHK0zur4/GLJUM+Aly7BGyzHApDCux4a21kjbgAg1tjIrF69FO+kkMvx876ij7aJRx@nongnu.org
X-Gm-Message-State: AOJu0Ywt86YAVNi+T0WAFHg2hI06flV4hvFI+jF7QeITKNiyHkBaZmHN
 hv5vUXh2bELA3Ch9Bk42YJdkjRBjH7Q+RsXCs1Rbru22cb/cQV6huBVlL9ajTjs=
X-Gm-Gg: ASbGnctU3vokXHGKzuLzpySJeG41lHbq9gEfl4gVEiCwc/xhW01OcLqzOon4QCU7MsU
 Hn61fG0Vy893o0PAsSRFJrDBu8tVrmIJDawuCpt5rlizN8rpgab2zfz9AAX0fLpm0z5eUm7pAkm
 K7+s4IZhxqqpGxLPBT8VmHIryJVmxMnfaYxf9RQU4gwhWVWu3ggUH73xn4uzUuUA637j14mupSH
 dRiPQ+DvLfXgWGUkqJltyiI14VCfJ2D6SIMWc90C0VNnXyfguHlMUU229eDp0zCw6POOqOXsI2w
 B+GJ/6WoYwDYSPxYXsF/UPxTbl83FzrChZh2u6oLiEUTuzwnM5ATwTM5TBAPEBJSVZPKd1O+EMn
 u9Vcnmj8h
X-Google-Smtp-Source: AGHT+IH34cHMri0ap2LTf0vgAy+xvbYhggfz1OEiGDcEZd4JnhR3v+7RXnGvt+W2M1TrCUezF6DPJw==
X-Received: by 2002:a05:6a00:6004:b0:732:706c:c4ff with SMTP id
 d2e1a72fcca58-736bc0a2082mr1060797b3a.7.1741375825618; 
 Fri, 07 Mar 2025 11:30:25 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7369853880dsm3642855b3a.180.2025.03.07.11.30.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 11:30:25 -0800 (PST)
Message-ID: <cf4d692e-d6d8-4ed1-bf06-58b9c8a3c1ed@linaro.org>
Date: Fri, 7 Mar 2025 11:30:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] hw/hyperv/hyperv-proto: move SYNDBG definition
 from target/i386
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 alex.bennee@linaro.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 manos.pitsidianakis@linaro.org
References: <20250307191003.248950-1-pierrick.bouvier@linaro.org>
 <20250307191003.248950-5-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250307191003.248950-5-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 3/7/25 11:10, Pierrick Bouvier wrote:
> Allows them to be available for common compilation units.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/hw/hyperv/hyperv-proto.h | 12 ++++++++++++
>   target/i386/kvm/hyperv-proto.h   | 12 ------------
>   2 files changed, 12 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

