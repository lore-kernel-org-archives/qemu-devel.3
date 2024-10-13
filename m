Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD43BCF2579
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 17:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t021i-0003u3-1N; Sun, 13 Oct 2024 13:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t021f-0003tj-62
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 13:05:03 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t021d-0000hJ-K7
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 13:05:02 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-208cf673b8dso36954315ad.3
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 10:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728839100; x=1729443900; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eMPR8XFDaREuizFpqyXhMG4at6FcQdNYioA1oliHzzk=;
 b=GGiaOIDo1HjthVNOcSAO2U7ODmsBoJTVkX2/NvnxrjIdI9VvTOxVC3VQWFEQT5xOGh
 2m4HROu55CG1jkgDNPQ3YvzozKWAQTnoH1jN9TNza7Ed3MkZEI9mehQSaazuGcYgrrUB
 U/YSzBkTakKUSQ2GKQrk3R7c4BPRrXoflaoYQY5f6f98/D2m2d996a5Oy2v3oP20nxfo
 LZ17LNGUE/l3hn0c0icS/zwoJ0Q2FzqGvEGQjFB+FaPKs7pSbUJ33SCCFA4dAT3tIP8w
 RUK5ln+bCVEzquDmn8j1a3pGhSHzwY/eEynxF6fo9BVoWuNUuESQYAFM226IRz/TGbjk
 0fKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728839100; x=1729443900;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eMPR8XFDaREuizFpqyXhMG4at6FcQdNYioA1oliHzzk=;
 b=ggBmPCPVLFckC2b2YJqow4epdE6KytAr3SPo8qRFXDgWICY4ubQCKFUP4caA71Ffaj
 08ddAPC0wos++A2SGewWs+hgdhkqUF6bQdApkLVxIv415DiD5IE+oDnitUqo/VTB5TTk
 HHxCxczHYs1UW7eGSAc7OGBARZoXiAqBKLOUn6mqkbQDK2rZlbFmvQ5qn9QpWYMT76Vl
 MfL0mXq5Wf4SShrkyoGkw4gzVJPgX2T8Rz60kbozHBpu+V7F7C4w7ojjRE9xCI/EYo+n
 45EHjJ99oFKAjmCNGuo1vcsf5nbtPInjI+C661wKYtxXliAF67BIiODDVehBWAaxBfHu
 rzgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHESUmFIbDb7EkxQVJOvYv+SXodqX1vMnq5IO7x6GW4bj1l4RPWN2K6AzsPxhnYHdrXq7WpNVXq/6b@nongnu.org
X-Gm-Message-State: AOJu0YwXkaV1+6YLDHNQh4Z24NU/NUYlYwq3vmR0v4a5n1R+gIOf7c6x
 IvRqcRb7euuHwxujkWpk9tURXFXR0yzMgutp+37bN8KOZbCcO+GndPwOgNtsZ4U=
X-Google-Smtp-Source: AGHT+IFi7Eqey1biUT4EqwOCahxQtTBM0aNckwRRgXBqdD1LblqUjDjXCAKgAUBA4T+7heNiKnNW2Q==
X-Received: by 2002:a17:902:c40d:b0:20c:5a64:9bc6 with SMTP id
 d9443c01a7336-20ca16e9c53mr116142195ad.50.1728839099716; 
 Sun, 13 Oct 2024 10:04:59 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8c351060sm51867935ad.292.2024.10.13.10.04.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Oct 2024 10:04:59 -0700 (PDT)
Message-ID: <ce85edae-0f6d-474e-9101-c98f2d32ab06@linaro.org>
Date: Sun, 13 Oct 2024 10:04:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg: remove singlestep_enabled from DisasContextBase
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20241010083641.1785069-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241010083641.1785069-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 10/10/24 01:36, Paolo Bonzini wrote:
> It is used in a couple of places only, both within the same target.  Those can
> use the cflags just as well, so remove the separate field.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   include/exec/translator.h   | 2 --
>   accel/tcg/translator.c      | 1 -
>   target/mips/tcg/translate.c | 5 +++--
>   3 files changed, 3 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
And queued.


r~

