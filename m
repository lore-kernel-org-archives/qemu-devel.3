Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89EEEC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 17:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts3er-0007VB-ET; Tue, 11 Mar 2025 13:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ts3eo-0007Kn-86
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 13:44:46 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ts3ek-0008WM-2o
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 13:44:45 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2ff799d99dcso9808372a91.1
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 10:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741715079; x=1742319879; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5zlnRfPyjY/Sp7JIeHW6Kpn5XmFSsf1hUeY7YrVroyk=;
 b=RDp4fw4hLrFo4RSYNGrmaysrUuZqlq1Mfhm/4gGXctudBylIUjkAHLVlPXDM1k0saj
 u27A0SYKgOvVj18MhVg1/dI17QxrNuxX3h501cSNKmFl26z4uQq3nnFt7ZDvuA3xbRDV
 AwIgMkcDxy4nw3pMdzk5LqwLoBwcw8VQNT3JSK6wwu808btGfVoLzUGvprzLkm+eck5/
 7vtNRzKA6NV1ggCWxR/gwS2LwkRM5P2tmD0utOlFf/pu8IrK+Cz5kpbndLoS0INoGVv8
 qRyCcd7hmyHtxLP4D333yieBYgPSs0V5OZa4KchMyD9nqFKnPCIuiGM0T3HaGOEyQbAf
 BGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741715079; x=1742319879;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5zlnRfPyjY/Sp7JIeHW6Kpn5XmFSsf1hUeY7YrVroyk=;
 b=JBnsLr4NVQNaoFQXT4yL4b7YsJ0LnvhWNXtbkFWi2RZ93bgPGQlcYMa9kTFkuN4nWW
 4r+BNBzDsALaSD73wZBdR+InbcHN1FqqcEJfKluHRwuHct1cV7+9xVWIoVr8oHEEKBMh
 g+BQGI6x0ATm6M4iKBtdct+3nWvpg6ZyOYSrhMBLv/ioR9ZpErPdS1FJAwGjWR1Ll1NE
 Uj9Mc5ZXavd9fZSVSB982yDoqZzmvLkrav+bztNe7K19I+x+xdidp/5xJhtZsivFTJyD
 f/jtfVrDi11RLkth3gXPM9o0gW050/SXb3/CkRkFdKMdW2BiprBLXdgY0oJnKOjexZKt
 EMnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVY132CCuq285RcJ2yNoFvjiqM7nBGkCTvph05MeI61QvrWw2O3j4Vlz70ySd22TOolX48FOpO2w6fn@nongnu.org
X-Gm-Message-State: AOJu0YxqSSx2mxqD1IQNbYYDWVg7IJ5X8LyckhYbjVI7FFRKTnAV2shN
 13/yY5TJe2qPWSGASe8BDPIyLkEGMBmz6kSTk6paUU4PA/aZvqtOYUFlDhZyIQoqgLpVtFUjf5Z
 S
X-Gm-Gg: ASbGncuQGOdWJHFw2OYoKbrJz1gKv69uw+AT0ZYAa16xoBYc+I9BZkZqsvBavORkHW6
 MvC8GqFQCM6pLU7cF90Rw10E7KQ7bb0yDKOj3pik+vG6xsSjPl7VUm5PJs9+c/Tq4vCcyYEud4+
 7D2ODYWV4oiHkSvw2QzJt2XrHP4r4Vib/k9PuHjXX4afkpCPD23KSh4wJe9qNCKn7iGwb2REjf8
 BX1BTmRa/JUBPtf4dPXVKUfZ9O2YEoHCYiu4SKmRJPfQrSPscba7K78KdG47pAJrUNMw348nlJl
 qMl8Gl1soY3+eG39mJsHdPH+Q9is1AUSBdyti8THktr8HjQVYWI1ExwxsLN2p97gZX6lM5N0U5F
 KOBHfO9Mw
X-Google-Smtp-Source: AGHT+IHuyumoKZ3lwc8QpMIHSIMhORTTLvmOWoJ2Pfhj+chAGE776Zp3g0NKaygquk6g0EGZjKK4Fg==
X-Received: by 2002:a05:6a21:50c:b0:1f5:6d00:ba03 with SMTP id
 adf61e73a8af0-1f56d00bc0amr21931890637.36.1741715078936; 
 Tue, 11 Mar 2025 10:44:38 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af543238621sm2069231a12.48.2025.03.11.10.44.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 10:44:38 -0700 (PDT)
Message-ID: <7d24d6c3-f868-41aa-bcb5-c8138a094327@linaro.org>
Date: Tue, 11 Mar 2025 10:44:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/14] arm/cpu: Store aa64dfr0/1 into the idregs array
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20250311162824.199721-1-cohuck@redhat.com>
 <20250311162824.199721-8-cohuck@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250311162824.199721-8-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 3/11/25 09:28, Cornelia Huck wrote:
> From: Eric Auger<eric.auger@redhat.com>
> 
> Signed-off-by: Eric Auger<eric.auger@redhat.com>
> Signed-off-by: Cornelia Huck<cohuck@redhat.com>
> ---
>   target/arm/cpu-features.h | 16 ++++++++--------
>   target/arm/cpu.c          | 15 +++++----------
>   target/arm/cpu.h          |  2 --
>   target/arm/cpu64.c        |  4 ++--
>   target/arm/helper.c       |  4 ++--
>   target/arm/hvf/hvf.c      |  4 ++--
>   target/arm/internals.h    |  6 +++---
>   target/arm/kvm.c          | 12 +++++-------
>   target/arm/tcg/cpu64.c    | 33 +++++++++++++++++----------------
>   9 files changed, 44 insertions(+), 52 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

