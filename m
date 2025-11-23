Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38300CFD316
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Nov 2025 23:28:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNJUN-0002Zh-Ul; Sun, 23 Nov 2025 18:27:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vNJUM-0002Z3-60
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 18:27:26 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vNJUK-0001N4-N4
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 18:27:25 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-29806bd47b5so22107455ad.3
 for <qemu-devel@nongnu.org>; Sun, 23 Nov 2025 15:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763940443; x=1764545243; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OIKs4SFbBMiKsgH9BmH9lXxKdwYWUPCDbsg2KAXJ+Bo=;
 b=V3+6jUZPP+R0PrvJxS/Lk0qMwww9pqztYtu5FFMKwNTQPHkKIekrcs4/a0ifS7Zx1a
 /PiGSx8J5vtm81hUF4V/lQBwlECGZPSTeAjNHScWbFRosgsvnmyiXA6IFr44zjNpMz4Q
 ujI/dsv9ykXxV4ZuYP4O/4VCZtbBkFC+DQjNNsxR5Gb/hOss79qdEHWF+7avIuoa6Q7y
 a89vRuTr8f+29n1Wm3XylsssfDkagjERzVC2mXKtX3J0ku1EOBKkhFY/6ttJoyQjYCSy
 yFujd3HCoAEGX9tXoHMuxPp1apOr8fxnhq7ILINKdPYB9JAjs7rA5u4aa2Dg6dQf1yA0
 5unA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763940443; x=1764545243;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OIKs4SFbBMiKsgH9BmH9lXxKdwYWUPCDbsg2KAXJ+Bo=;
 b=AK44MVgnn1LhmAj4X16mQhr7M9WE5AfAO78L0fPD/rjubdFE6vbZTviUiLFJu7eETv
 iwfjGFJiIwvSjj6hFrlHGZO9Q1IIklq1ru81SxX2XnQ0xqfwXgmQARJDVKsgb5WD1nTA
 2fvjsMhNbcYScWW/Sp1eqhW2QOaRcehYjLpfR051GPb8GkSF0hmN5uaZXmzStUtXi9Ho
 Y7ZKAp1v73m2q8cEp89p0g41mR7Yw+C7M1ripmMrLEoe/s+g4P3SAzFdJeD/N6HzNJcp
 rji/HRjQIr0rn+Q+FsRd6eFy4DgoMXzpWanDr8qAIewsO4GLbibXilmizEFubijnb96I
 Pxqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXH1QPv1bu6t+Y4DMi1CsZvQUlh0W7+uA76xYdvhTAA4lmM1HYX9sOXZwgd5JyxmJ+sOK2d6yRjXoGP@nongnu.org
X-Gm-Message-State: AOJu0Yyb5iHC7XWwqtIPrJ6g1zda7p6Maz1JoX3pMiFdWXlYw2AndaYO
 DFc4OLZANm4tal1HNEYMChgvD+rjmCPTC9u5wzRZFKXXsMJxy60zuAptJ3a2mD3BRT0=
X-Gm-Gg: ASbGnctp9mVyj4B1sqllhlY8rgCHFPKovebRP0WBUQpMpHChoZz93Bp5/3aTGWWJQ4g
 vIlgK8ricFwpyhxloOv/3gxBzmNPSJTAoeAVG/fTo6KRokRq4TBV9ZovBO9R1RHHTG5sDmcZvI4
 o7LNXxlGImPyrXzSoWNs/RFxbism8nYf2lDDUWmIhWcyPJ5NEvhYgU69CUnE+KlTkJdpfa2CzzW
 B69KMwfC+InaIKVeP7nS4TwtycdxyvLdoZH8GJPn9AYvGm0D/ZQIFzScoCT3h9Cfp/ZdL/e5T0T
 fkYCA1i8WnZi9CGrhIjae6hChMlfJemDNBX9Jfz5T76tSBPXPxPH1ZNnv4nqCXPrS6cejGV9zus
 M+BJf5DcfysoMtvUC5RoPO1ldawZByMYmPJ+MH/iLlkNDDSsWW4ZR83ky8MaOidd0ixyF03KSuh
 poN9HXZEPBj99VVzm2dknQobAbvtjt3xk+S4It5/llzoypNvTGspE+vnXVewD9pEIxhA==
X-Google-Smtp-Source: AGHT+IGNvsXnIoWTvH8DoD9bWlyfGdSdHSbMtlB7dJBqFYD3sDKP5zHmzIQQFE1Mo+rc3f7Pr7n0SA==
X-Received: by 2002:a17:903:1b43:b0:297:db6a:a82d with SMTP id
 d9443c01a7336-29b6c50ac1dmr105976265ad.26.1763940442765; 
 Sun, 23 Nov 2025 15:27:22 -0800 (PST)
Received: from [192.168.0.4] (174-21-128-133.tukw.qwest.net. [174.21.128.133])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29b5b111650sm112587725ad.8.2025.11.23.15.27.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Nov 2025 15:27:22 -0800 (PST)
Message-ID: <eb4b287b-58f3-4a99-9918-86936f5f458e@linaro.org>
Date: Sun, 23 Nov 2025 15:27:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/10] Fixes for QEMU v10.2rc2
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20251121093812.280911-1-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251121093812.280911-1-thuth@redhat.com>
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

On 11/21/25 01:38, Thomas Huth wrote:
>   Hi Richard!
> 
> The following changes since commit 5a5b06d2f6f71d7789719b97143fc5b543bec07a:
> 
>    Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2025-11-20 08:12:59 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/thuth/qemu.git tags/pull-request-2025-11-21
> 
> for you to fetch changes up to 88175cff49dedd709b7a01e0e5e1bdcad69e0c8d:
> 
>    MAINTAINERS: s390 maintainer updates (2025-11-21 08:34:53 +0100)
> 
> ----------------------------------------------------------------
> * Fix a crash that occurs when passing through virtio devices to nested guest
> * Update s390x MAINTAINERS
> * Fix various pylint warnings in functional tests

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~



