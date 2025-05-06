Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53DC4C3ABBE
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 08:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCDSr-0001Cc-UD; Tue, 06 May 2025 04:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCDSo-0001BT-4z
 for qemu-devel@nongnu.org; Tue, 06 May 2025 04:15:42 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCDSm-0002s6-5a
 for qemu-devel@nongnu.org; Tue, 06 May 2025 04:15:41 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ac7bd86f637so1162905866b.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 01:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746519338; x=1747124138; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KjrRtqVJLdO+vqnT52t4cWcpgZq2EdNjcrmMdn2l6Is=;
 b=OgoajrZt96nRolGX+W5n8gLii4ydgLF5+FvkSNxQR4DRHMEokkdyZtGAK5VHZQh+U4
 w5qQgNLo0NG7dNW7IpTSJ+MWXhaHU86Fk/L1izH2hXVpXVb1u4gDPemdM06gYBsa0hQI
 ElNtKUltyKvZb/nHIutK6x20YA896+wiZAEiwIPp60Hp1Nv57FBXOGRWup/c6f1B6SUe
 pMMWjcGWB36MTiUWCJtI2jRgXjuO1SyfflkGEOwR8WZKZWG27WDerRVmICZKLSuEzDI2
 gTgMeW43CRrN3nZmtzGg/UyK4l/q573cDaHLWQiOOtSdvEPMKOtTEzgYiBfCqx/RfY2L
 p3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746519338; x=1747124138;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KjrRtqVJLdO+vqnT52t4cWcpgZq2EdNjcrmMdn2l6Is=;
 b=U8RuxBR7Q8vSUubrpFbJUjCb+rVYKUX6h9GZ3bvDYM/+hm7tBsclC8mQNI+tRFj3Em
 Y47JA+gq1hMbETOtyqW8pYjh+U8wuL7BjQeoXPOdgS2B/l+olixArcx9mEZhKpkUxli6
 PQvrn34522fnIj+2yl6pEEuwXOX2+qKKgZ6/7NVYmU02X2S65MRERltreTaTtXsL9ZsS
 b/OUwPz/AqRhWdF1bikDHWJkOGcCEEXkE6s1JnD690+hlhKc0MhgHSWoDrdvG07qK3NP
 c8VRVT77Q1qZ2XfEao4WBYvUXH6+rtRL0Bzh7IwswIcr7S0rBISE25wkLNhzj1b3HK8U
 K2+g==
X-Gm-Message-State: AOJu0YyBPoOfYwbF324qtmHqffRQXhF3nMeMwqxtwsExPpm1q3iyonuP
 0KndekoJw2f2S87MIKwCgMHUN6J8NmK1L1pKG5WNp7qzW+al9MWDsfxUvUI2XE0=
X-Gm-Gg: ASbGncsXO+XcdQvmISZegXzaU+5MOemgPeiaMM+6vHGgF722G0mJWB4/8tkSyImXdiY
 mleOzxcvMmHpXSLe2af0p9NEcq53cauZRg6Wl6eWsCqqi60ofmmcjdl1f6V4cEH1V+RKCG+p3sc
 /QnQe8wYw+iLwCc4kYmbfJWHQxArhM5obKnHewcmyrz5ecndRsC5HlVkk/iGwe8VSll7TY2V7zG
 qjqb0ORiNukKTlzGFmzr+iNXYuVflwpEaB9re1L8+43ROvRwIXKHrmIDIXwl7WMeaGu61wQhPR5
 QzkgvluigFfiOvst4PQeMGI0IM58kJ7vPLnnIVGMfduBKzGrRj9PUkdjZcx2RaJBQwt/vGnDMR/
 JN2g=
X-Google-Smtp-Source: AGHT+IG7lXwDYaAOwVwzYywWYNhhtL6WCgs5+DF4fyDxbcgjYw2P6bTy7yKMTU+MelcMq0no74CQOg==
X-Received: by 2002:a17:907:97d0:b0:ad1:8e6f:3ad8 with SMTP id
 a640c23a62f3a-ad1d2edafddmr241776466b.14.1746519337908; 
 Tue, 06 May 2025 01:15:37 -0700 (PDT)
Received: from [10.194.152.213] (238.21.205.77.rev.sfr.net. [77.205.21.238])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad18914736asm653456366b.7.2025.05.06.01.15.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 May 2025 01:15:37 -0700 (PDT)
Message-ID: <32d75ea4-0638-4e3c-9db3-fe37144837e4@linaro.org>
Date: Tue, 6 May 2025 10:15:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] hw/s390x/event-facility: Remove the obsolete
 "allow_all_mask_sizes" code
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20250506062148.306084-1-thuth@redhat.com>
 <20250506062148.306084-4-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250506062148.306084-4-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

On 6/5/25 08:21, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Now that the machine types 2.11 and older have been removed, we
> don't need the "allow_all_mask_sizes" compatibility handling code
> anymore and can remove it now.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/s390x/event-facility.c | 37 +------------------------------------
>   1 file changed, 1 insertion(+), 36 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


