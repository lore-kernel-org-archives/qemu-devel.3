Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD51C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 17:42:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts3bo-0003ws-4j; Tue, 11 Mar 2025 13:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ts3bf-0003lI-VA
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 13:41:33 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ts3bc-0007z9-UZ
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 13:41:30 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-224019ad9edso131364675ad.1
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 10:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741714887; x=1742319687; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zKFfFJ2OhjE17PCC4T+chtXa6+M6mRhSrk5T/UA5sAQ=;
 b=EZgp2/5Kr804LsjZTRrVfEoMSeCsbIPoGpK6mHWYGUZ+BOixAcopLrnQLOcjTn7AEH
 LuFBxhlZ/Gbg9cFz2Y13j0I0uhNvX3rziqUBP4L+ygG8utGuFsY/6F8QobA3AJENEpgP
 /6b7gpTogOot0m4Xr0xy1mzvg50oxopvc6eyQiIX3C2zSMuC52aGr6uIoXN/YFXYwp6K
 jc2JieFIZ5Z7zNOTJFdMiJcHNDYKVfiVg7WUZ2lM2JtazbbZcacDZSm95383mBbVfvFq
 uQpDgnkSbG9xuUNHH+vewXu79ZJ398A2q2KQ/Pn68hgAyGYgO+hW6PppMZ4pDKFFGK2j
 JgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741714887; x=1742319687;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zKFfFJ2OhjE17PCC4T+chtXa6+M6mRhSrk5T/UA5sAQ=;
 b=CDb4IKF1Mu89VJP/KH0H6Cd1TZO3g9gdl+8I+QFF2YYmq9wqFxq94H/e0wUd77ft5z
 OCVVfbGf0eQsqJe+H1N/MRGnmqHZit2rhipdTypFBAU678RMq+TUKw1kqjBBO8EyX1b5
 6OBpaKlwdzCJO9tcELdAXNix4M3KCZrdlpd/uYj3CdaULUz9viXlXahZQDbqfsgn3x/o
 PL1IlYr0bAQGmSThbuk5TXqI9y0und2kwOZQXVKFLHQH0euZvuqxIaBXXVitWOsXjM+4
 sCmyqJOJBijFse7pc60545ZZTB6FFeDrHT3rUUdPrdeA1fK85PudOhFXcJ7X7L26QRwn
 +5aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwMjHJ6I3g7V2jDOgEO6N+6Qz+VzSQxpy0/uVUu77YqH88p15IHlRYpdLViErR35zOh55Q9WcDiQ+b@nongnu.org
X-Gm-Message-State: AOJu0YxAKUFkKFS3o41md2bU0Ixu/Gs5Rc/doZaUNI9HRliIlCmf0T4T
 Dd73FhctvrQcyO87pXUDRUApchcPstLmqfYdqXQlIqsg2JTT4Qy2mSJKdC2JJso=
X-Gm-Gg: ASbGncvT0eqbv6eeq7r9HqQmOkmLhEy3s7RQtJWoSL8twVv2IF3yRBN0xUrqUrzIvj7
 eIobAFnP/IkBMbTVJY39pFJnSCdjZqWwUA5JWPpz33NqnvxbT0dPPwKAlFWXu4i/nPtE++q3ThG
 dXZn4f2iI98/c8zcyeYdPScSqzPV7pt1IH90ipqmZO7m5OCWIQDGPpv6pGrFrZU/u87qM6UHtih
 Ogy7qDbzhqQPGpEa9toue336DstnBKrUnP5Ux0EJDPvhQeI+5ktCqI3zCZIfyj6ZOUCaUL+NV6P
 Ei0mQcM6rsJPN94p7/SjCFM2cmuo6AU0Y8laTPhxlgQwiYsUYLXIF1GplEZXDOYDQcmjS/SRwBx
 FUgd0tmhJExVjgo7l/as=
X-Google-Smtp-Source: AGHT+IEqZzPQjUwHRsx6AMr2DPIC7ek3UukWs4ouOskXck22kSx+nZ/9UPpbegt0xtaC2PLnE5z6RQ==
X-Received: by 2002:a05:6a00:3c87:b0:730:97a6:f04 with SMTP id
 d2e1a72fcca58-736aa9d3a5emr25810743b3a.7.1741714886904; 
 Tue, 11 Mar 2025 10:41:26 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736b2da32c6sm8716044b3a.149.2025.03.11.10.41.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 10:41:26 -0700 (PDT)
Message-ID: <3d8edf26-506f-4ccd-be93-eb90d9338a08@linaro.org>
Date: Tue, 11 Mar 2025 10:41:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/14] arm/cpu: Store aa64isar0/aa64zfr0 into the
 idregs arrays
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20250311162824.199721-1-cohuck@redhat.com>
 <20250311162824.199721-4-cohuck@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250311162824.199721-4-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 3/11/25 09:28, Cornelia Huck wrote:
> From: Eric Auger<eric.auger@redhat.com>
> 
> Signed-off-by: Eric Auger<eric.auger@redhat.com>
> Signed-off-by: Cornelia Huck<cohuck@redhat.com>
> ---
>   target/arm/cpu-features.h | 57 ++++++++++++++++++++-------------------
>   target/arm/cpu.c          | 10 +++----
>   target/arm/cpu.h          |  2 --
>   target/arm/cpu64.c        |  8 +++---
>   target/arm/helper.c       |  6 +++--
>   target/arm/hvf/hvf.c      |  3 ++-
>   target/arm/kvm.c          |  8 +++---
>   target/arm/tcg/cpu64.c    | 44 ++++++++++++++++++------------
>   8 files changed, 75 insertions(+), 63 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

