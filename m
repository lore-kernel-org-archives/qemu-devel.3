Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7EF8C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 14:54:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uURWG-0004Re-7q; Wed, 25 Jun 2025 10:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURWE-0004NA-6I
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:54:34 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURWC-0006Mv-Jn
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:54:33 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b26f7d2c1f1so7194133a12.0
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 07:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750863271; x=1751468071; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V3KL4xA0U7LN4S20l+epU0nutDG6aU3YflzRHrP6ZU0=;
 b=Kg95y89IMiUQtpwY64vmbqm26JfjER9+t4VA+KM2SiWgVCoMxmGV7QS+aclXqzRpvo
 RqCiG9v4jlW4avtqdjkrLVr2DTtfS1jKWWOYYlQO3jUFu7llzSWAvLXaeQ9b3E1GHTD5
 IS7DmwUb8m66vBrWG7e1hX2ALEbkpZGRQ2by2Af2K/adR+3bIwoq6tlxmRusZYKFQhSF
 CMe3Sgfvgerh0Nsgjo9Z+5VVyTKzbIqFuH7Wp3V13NXiiW9HBk5bly9NlYD0tDm/mcKV
 /nJimqjnlSdIfKVddccahSbtpiC2pEddPgqoVI6oksocYcmo++ZBxV5Xv//euVSrptMn
 keCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750863271; x=1751468071;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V3KL4xA0U7LN4S20l+epU0nutDG6aU3YflzRHrP6ZU0=;
 b=DOXojsxXJLuT0TqbgZWSHHEKd6djeYBTCRbCwFQ9Zt6oOQvGm06ak3Ssx2d1frtAYY
 uxipzcf1yuqystovfUEHOamFdHkzEySWXzonhKGVkZk+KJSQy8A5Sd/rlYU2fpJImzri
 VddPqYORrn8GfGS87ScWc8OSaCUtuVuCY4Mm9HiAvYz8xBi5SNdmS2QG78fE46BLtHUQ
 yTXsMGP5GEbX6QlOlf9FplIjzau4DGyGrssaVRLW1mWOWptcK3c27No2TAgZ7FSPe9Is
 PiiERsXdnHyebV8soegRNE8sGbW/q2yeJIUaI5Zi+cryeLgCPoY0+4PjUdTl9tH7enXt
 Z5ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYWeQcJ4OpGyjS0MDJAuC8LwThU+kcpdZrA3mt/M4J92boSdUYomqPy9kyRx4/X376nmcoXoxfmn0v@nongnu.org
X-Gm-Message-State: AOJu0YwH3lBKRkUvR1kBvlxbe8yBPNg9l2ETneK73+ZLlBN/87xfA0/S
 ZoVeueNyubuj3fcr4PGNcIK9IqY9NHRCzFlbPHy5EXabIemBHqDluspB1HyFYUAF7b8=
X-Gm-Gg: ASbGnctSV7LJVTMr6iXO73tu4OcAU1g2/YOHqZ6R4dPi3eNNW2iVlvZL4PGtl59jPkH
 yz7H7qAlF6+s1ulfoh8OcUeca35zBO4j096NQa5q7eMY+ZoHgeDBaz9f1eM4XekIL9IzPNGBHN4
 Y7sOiF7nJzevJwEnUgMRMbx92gniVBMkLbtmwh0JccFw56qLmL6bxNMqNWnm4qm/NhQcuu+9T4G
 rW57FtYybJlYyD3cvB8wjERwePi0ZqBdb2AdAQ4lFSgib2Z0bApSbt40l5BYlEEu/zfV+3tIrN/
 Gc4Da8KhcnErNehat9fmBKTACreNe86T/7KaUYcS5Hquxrnrs0sXSYWpOADJUxx64zTTtSDE5mo
 =
X-Google-Smtp-Source: AGHT+IHwN2CKBenH9DxnZonuUZ9lis0LG3R+5HH5IxFJy71B14cAnSjziPuUmmHiYaKTK7T8rF8PLg==
X-Received: by 2002:a17:903:1988:b0:237:7802:da30 with SMTP id
 d9443c01a7336-2382403b72fmr59239025ad.31.1750863270945; 
 Wed, 25 Jun 2025 07:54:30 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d8610ac2sm139888285ad.135.2025.06.25.07.54.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 07:54:30 -0700 (PDT)
Message-ID: <f63a515d-3f10-45b5-abf2-9c93b5cba854@linaro.org>
Date: Wed, 25 Jun 2025 07:54:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/27] tcg/optimize: Build and use z_bits and o_bits in
 fold_extract2
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20250603080908.559594-1-richard.henderson@linaro.org>
 <20250603080908.559594-17-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250603080908.559594-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52a.google.com
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

On 6/3/25 1:08 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 38 +++++++++++++++++++++++++-------------
>   1 file changed, 25 insertions(+), 13 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


