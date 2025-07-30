Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D596C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 21:11:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhE43-0004P2-E0; Wed, 30 Jul 2025 17:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhE3z-00049C-25
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 17:10:15 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhE3w-0006Z6-85
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 17:10:14 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-769a9c3bbc4so246140b3a.3
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 14:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753909810; x=1754514610; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UGppI92iHV8vjys/mQ6Zs0MlEcFqJGFo85JuuOCHjL0=;
 b=sMx67uuRLP0sdmHSFldvAoIyK4epax/t2TpfACIBGM9cvbJd5fl4DmIGPXiTiEUC94
 RDE1H8WDEHWzcF5Hm8aBxA1JID5YeH7eK4fbMd+qDFIV2LzK3d/U1cEk44QszGDc66Tc
 dpWQmuGToCkja+ySMZMi5jHSPks8axj/LLj1/GyTt9fsAVOk9NyPGJtrPBjoGu5cIkjk
 ictNmy23vSrnpipYzB+Gys5aupxS5gZPRot88OSil6zwLOKzsPvtPxdlYsfqURA6wLRS
 rMWQV21o+HZNAyaALskxpLRjcLQuyAuxjE6XqnIZdHvHMqWfBXUznR5++J6XJAUACv/4
 qTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753909810; x=1754514610;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UGppI92iHV8vjys/mQ6Zs0MlEcFqJGFo85JuuOCHjL0=;
 b=JFUEi6pYN+fqjXW0/S2Hn0ABDIcnxdQGz6UfM5C1RZQ1OfSxuadYmyhOW3bE32ptii
 XPtp+3GvAj4qLHsd4KKQZZQ7snoAPCu+mnyKX3AwfUsb7kfxNLoqtNaYB4Oh9157fQbX
 U8boJPlQaauUW4AJUCBcpqoc0ruXbSYUIpsAuDAzQu2NiX8MfifcQrjOA1XQs+rxWc4s
 pUm5qqlYVORVCrAQsg+u5e+bXh0wSBK8t8bcJuPF/m7GZTOXEgegeBSufgo/7KKngOC6
 dpZSWsVR7wmPeZM+KO0Odm9rT3HvScvlzV8AyRbfeykPReGeRPEnYTbLZjgJhnDrtSV1
 hJQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3+DDAYsRjhqpQJ8b537XmrkJ8lT0tYs6s/sMls4mjjsywdOiA46zblafoh+D+IhOzzWk0op6mNIWz@nongnu.org
X-Gm-Message-State: AOJu0YxDXmAjdooVncHNESMS4/9Jamf/QgQqrmteTLn2GD4XNuto1riq
 Oh0NvBljXrwUwFMCEYPpaG74pXoPjUiGcRlPKEmpYgfGWs6x11LRSaQOJ5Cd0FPNtnk=
X-Gm-Gg: ASbGncuhkD7mIMq0oxBPda7W5N1XXmFGow5c9sNiIBbERpM6d0Chw/LVitoowYPMUwj
 Obmuj6NaBR7j9q7AhlJTPlSjYlovpMJsAMtHSqRmpj8cJ3IVXVfEVav/MyumRrdAXiwXcBX58uX
 +N5ek7iOoLcKYiBUgPgsw0ILxMx2Esz90qtAPCHgsD9UnkFTY3At9UiOqCPHrfhOKGPeJaD6+3V
 eEOZSUJPOzILlboVzriNKdH6DU1XevugZovaqwDOTU10Oa2LnBKIMGgr1NRrHLSA5hP/IdeM+hH
 +vMqcJS4CYpblqofVWHJh7RcyK4/EloVOLgrMVDPTv6bjpwbQbz0DAgzPY07SIEl5gJDwjiH3lC
 rmSgQIm+AuAsysP+IA+M2yeBAKWXU/83t5W0=
X-Google-Smtp-Source: AGHT+IHq+oZLzGG/nNvzINB/nFM4w7y3skDNpUoPg81fOq+MRB/e4qcsVyOBp25byx49SEITrLH/RA==
X-Received: by 2002:a17:903:1b43:b0:23f:8d03:c4ac with SMTP id
 d9443c01a7336-24096a68567mr59562265ad.2.1753909810428; 
 Wed, 30 Jul 2025 14:10:10 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1ef67a3sm502015ad.15.2025.07.30.14.10.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 14:10:10 -0700 (PDT)
Message-ID: <6963c11f-ed15-42f5-9110-9516ceb64662@linaro.org>
Date: Wed, 30 Jul 2025 14:10:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 30/82] target/arm: Convert arm_mmu_idx_to_el from switch
 to table
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-31-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-31-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

On 7/27/25 1:02 AM, Richard Henderson wrote:
> In an effort to keep all ARMMMUIdx data in one place, begin construction
> of an info table describing all of the properties of the mmu_idx.  Begin
> with the access EL.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/internals.h       |  3 +--
>   target/arm/mmuidx-internal.h | 27 ++++++++++++++++++++++++
>   target/arm/helper.c          | 27 ------------------------
>   target/arm/mmuidx.c          | 41 ++++++++++++++++++++++++++++++++++++
>   target/arm/meson.build       |  7 +++++-
>   5 files changed, 75 insertions(+), 30 deletions(-)
>   create mode 100644 target/arm/mmuidx-internal.h
>   create mode 100644 target/arm/mmuidx.c

What's the benefit to explicitely size arm_mmuidx_table on declaration 
and definition?

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


