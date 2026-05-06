Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDB3CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 13:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcOW-0006D3-En; Wed, 06 May 2026 09:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wKcOQ-0006BR-WF
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:34:27 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wKcOP-0001zr-IY
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:34:26 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-67c250805ccso2590481eaf.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778074464; x=1778679264; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MTBxwUdDAXq/27h3AIzTobRIIsRqrZ0As0hz6xY9Dsk=;
 b=P/hdhFWq1CefuOFM5YVDE9Px03Hx3V4e22r/BoYmrtc8RGPx4Nuf5FDe/ylhb59xXe
 qjmfVrmiuB7CPXbbo8HfsAw8ik+5fgT+20auQ86nlV4lD4lrvD87y1/hZg6aYc04BUDB
 R8yjnirI9p3eV3YHYivyDw76Yn7SB4IyxK1ZnWBJerc3Cc21RemuR671ZVwAe2Q4QBve
 8Bvtyagi/mQxJFQyjPw2Cefwv+PZG7Npu7I3d1KWCXzIVmo0Jzh1pMpJYjWY5I3SiuZX
 LxCwSzz3FVub8g0w9W29qJOY4ChkeQGcZuHG1vMQlD2o21usSIccPon6Jh8R5KKelPL9
 dpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778074464; x=1778679264;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MTBxwUdDAXq/27h3AIzTobRIIsRqrZ0As0hz6xY9Dsk=;
 b=X02JTGYsfZfFqz105ydlT0O+Wr3tsqA50jydn/H7BMDoEd4V6RtSpn3T5Ic66ZHt07
 tdI042qnWViIzRdWqeQi2OrryL686YCzSw9pgWzEsASO8p74kPLQjAXzRzzJ4geshmx2
 JVvXKYi3AEUZolz0WSiI1X1EXaZe6JvL4FGXGPQ6GzFDSJciX+iFjbzt8dKUQOQZpYwK
 urW6F677OTIxYyq4S7fRRK6jIrfr1q23aEzf8esjvsh6ExgVOayltWPtP8WoKLnxhpBV
 cz4zvCsnRD76YyC7+HuLYC2iGXD9uXk/t6D5rpAYzN6O5RW1FmSuTtRXXdV9p7w9s2ks
 Dvbg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+qOl6RK0JOtLnwHH7aDnwNl7TjjJdELndyjJVD9DczkLKpJXAUwNHsZunJT+fu7JzE7MMH1dbMYeqR@nongnu.org
X-Gm-Message-State: AOJu0YwozGVcwecVNB4UK4BK9IsPHDF5A5VvzJCFJnCACLhBb5XPDtqI
 j2BhdigjbLwVOxoXlFp0y3XmqxqsCxlZKwXlA+AVJbLcHwhnE/hwislEZc+ydktq3lI=
X-Gm-Gg: AeBDieuHMj3UOoJBRBc83uZSHSzGBPufZ4ZMIYLzk53BX/gSntenjfHSYJ6Mo486CF+
 sNwn7UnsT1xs09OxT6ZAAsunrJdIzi68MZcCGNHSeJSTKpBcYeXVOXCR9ZVoC1o3jSoAIRybKa5
 zECZNHrgO75b3pXRLvoTO6Ph2k1UZuZrCwMSSKkQjRMWpWMoSC88zK6uh5Uyc1wPqL8Es16QzB5
 tRXEQCOwOU0KOmw7exIz2825TFl0hbvmc/9SQRBj4d8A7Dy+3AKXumpBCUUNxKE4tlhUZ1Uz816
 zsugLGcMNX8+0G3cuzzq3rzL3di81drVtzadkU4iPnKY1jQfYAT0R+4vjxdZeqGaRhygPZrYKRu
 9jy+rKWybx+IVsYWjMBB6j7rHdcKvDpcpg7UoAnRibXIc9WbJxVYutwkZX7JIATzCysDGL0+5Dc
 LR4WSX/mqe42dBgdEJvmbNf9ar5Lr96Lv/M3eHZaOINOKqv3uYJw6uE7x6LG20bM+GnixYyS5S3
 jiNeNzOX/3dvKhCy5iTnrdL6fltr+c=
X-Received: by 2002:a05:6820:2015:b0:694:9cb9:ace9 with SMTP id
 006d021491bc7-69998d5b2a0mr1532022eaf.52.1778074464013; 
 Wed, 06 May 2026 06:34:24 -0700 (PDT)
Received: from ?IPV6:2600:381:c938:6375:5307:cd92:1ec8:e891?
 ([2600:381:c938:6375:5307:cd92:1ec8:e891])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6968947934esm9870521eaf.8.2026.05.06.06.34.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 06:34:23 -0700 (PDT)
Message-ID: <83afc091-2825-4a63-af3a-ae5697e02b8f@linaro.org>
Date: Wed, 6 May 2026 08:34:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/15] target/arm: implement MTE_PERM
To: Gabriel Brookman <brookmangabriel@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260504-feat-mte4-v5-0-232a648e63c6@gmail.com>
 <20260504-feat-mte4-v5-1-232a648e63c6@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260504-feat-mte4-v5-1-232a648e63c6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/4/26 10:50, Gabriel Brookman wrote:
> Introduces a new stage 2 memory attribute, NoTagAccess, that raises a
> stage 2 data abort on a tag check, tag read, or tag write.
> 
> Signed-off-by: Gabriel Brookman<brookmangabriel@gmail.com>
> ---
>   target/arm/cpu-features.h   |  5 +++++
>   target/arm/ptw.c            | 25 ++++++++++++++++++++++---
>   target/arm/tcg/mte_helper.c | 38 ++++++++++++++++++++++++++++++++++++--
>   3 files changed, 63 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

