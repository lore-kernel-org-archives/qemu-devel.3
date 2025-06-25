Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42526C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 14:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uURXh-00076U-3P; Wed, 25 Jun 2025 10:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURXe-00074L-Nc
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:56:02 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURXZ-0006he-SW
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:56:02 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7426c44e014so1322921b3a.3
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 07:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750863356; x=1751468156; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=emKLBdlaTwJdwRUTH5IJYRDC6ldhyji/BzEEpU9WOXs=;
 b=iQJc7viEbaoH/n+IWHYHlPnGi9We5YM8/DGG9akJz6R/MssBnF4D2wrwj7KndbYlHk
 2//scP4jTFpVan6iJStyl09SMQsphvpC2ksxSdTGsSj45QztMb5SyiEVB4w59VQDIPOD
 hc1kuHY0u5wEi2dkcy7XvTDk9NS1+gsGvRnOZn1ECDdiKFOKBUqgRAN7KJA8BEbFJwgp
 wvPZWy2YSqXCe8hAlw2d+Cuy87QZH8AO/y7l7dpyzjvPFUAtlYA8/e4e9mIlp0rRCyZ1
 oBUuzeQfWcX+W0pXgOsdeWFJbqkglZee7rzJZUP/89cqG1C+VF6/nlds/35o5+EBoTRn
 tukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750863356; x=1751468156;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=emKLBdlaTwJdwRUTH5IJYRDC6ldhyji/BzEEpU9WOXs=;
 b=tN3v/Khw3yPxUdjl0QcNjcheaJR0O2JmNYLdk3aGWYPuOOb6k6tgNEcKg0MYqbh7st
 MwgWPb2TYGCykSRFNooGVWRt0+aLDvL5Ecfk/pJ+pXBlkIfa9LlAUP9cszfbIW9tW+9F
 VYEEkARiGUInla4Y9CPqrgJsoP5ta3Ago7D0WT8sf0uz23MEtWgZoiv4zBBSTyG1k1+6
 vQhZaZmesgltQKPcq6Il2mgulvdeSETJxQ/MZLgj4HdnRYzN4m5XIYgYlf5rD/9szfBC
 olWZ4WCMiDIdiUnUGDp9/Fn9Ywy/tzmtqZGndsuNxTBfHt65xCj29rRdXJjJHtQzRc7w
 fOpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeuipSD4uvprCN6eTm7IKZsjY1xXNWv3i3TRs0PeZGbsg53hLRw+nyRXj2ezd4FECvjuZRNTADzqP/@nongnu.org
X-Gm-Message-State: AOJu0YzmSgPJbIDSUMzwfGmz8WtJVneSZKk3kErVWg9XmYXoHrm/Ft7d
 ECA/XzRCXHhf5+/w9QjYQM5gLv6aIeWCNqx8PqsrCltutl9ryLmY9mpvuqMdj6NzumU=
X-Gm-Gg: ASbGncsFSyAu3mqbqVoaYt9Iel/jkHWpxLItpXUJJJQMW8tzDTBqi10Er76XoFIk0BC
 TJBHhsiNFnLy5FV+Flkvpo8xd+oUij7f/XfihaJir18O18z8wlclAerBdIj4vuQtll2rLinDkmL
 4r8e/OHYCp4phITsuVOVf0XrM5D/MkPZcPTTkQupLHrIJ1aXSuK40TdTxRiGUMjvJj4vwqY+y3D
 gSD4qA+NTfI9Kx21WK+NusBWopQ7zpMRBjehndqN6B7uF7qBJLdjHmpXLQ/jZKb/dJ66weIHnOO
 pkbpcd+HDf6YPWYJ1kVxbaljv0Ma4vY4UF/hiZdSj926YeL2n5RSsecPdlU/bOw1noEGq3llgEB
 YCiNdHkrLxQ==
X-Google-Smtp-Source: AGHT+IFqBFtHpHrolGyT1ddJXwRiOUp10/bHlgvgNxdXC4gP5/glt7rCb5sO2WdYnGjHTIay6NsCsg==
X-Received: by 2002:a05:6a21:174b:b0:1ee:b8bc:3d2e with SMTP id
 adf61e73a8af0-2208c08a54dmr232656637.8.1750863356168; 
 Wed, 25 Jun 2025 07:55:56 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f119d994sm10790904a12.22.2025.06.25.07.55.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 07:55:55 -0700 (PDT)
Message-ID: <1ff36588-5305-40ad-af0e-8ce025824236@linaro.org>
Date: Wed, 25 Jun 2025 07:55:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/27] tcg/optimize: Build and use o_bits in
 fold_sextract
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20250603080908.559594-1-richard.henderson@linaro.org>
 <20250603080908.559594-21-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250603080908.559594-21-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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

On 6/3/25 1:09 AM, Richard Henderson wrote:
> This was the last use of fold_affected_mask,
> now fully replaced by fold_masks_zosa.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 30 ++++++------------------------
>   1 file changed, 6 insertions(+), 24 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


