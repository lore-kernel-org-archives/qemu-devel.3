Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24FB7C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 14:55:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uURWW-0004kQ-Lh; Wed, 25 Jun 2025 10:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURWU-0004j8-9j
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:54:50 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURWS-0006OC-PW
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:54:50 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-23636167b30so66596325ad.1
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 07:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750863287; x=1751468087; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ao8oplomwiu38rd6Pk9qufQ4srfg4UhUHzgpgTkoH7Q=;
 b=hyWWhY/mwxhzZqYZtJUwhc7Px8t9Ilc+NLgOaOfS+6VuphIyIRaZoxFeVmZXUDPZLj
 mimbMQ79ZxQkf9O18/eE7lJwpdNvslNyrfeDwp+EewXuq3+9P8FkRi7cZkvBSpxZ6dWH
 afb5xY7LvTkf6exw5F0gNvNG1efqD2we0MicqhZy8lqzJBpWurMWkgW1p8gZGfRvNcb/
 lMbZ/ADw2pHqKLEQCW8Jarp67lDJWOpgQcVid4GZVtUI2nZW9otsQk2zpMkJSFOA5z0X
 RqxOioAehPB7lsG8qd56KO9vCuPkd2rbNscqI5ys6BWH9aAkITodS1jaQEpMvUBAaaUU
 590w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750863287; x=1751468087;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ao8oplomwiu38rd6Pk9qufQ4srfg4UhUHzgpgTkoH7Q=;
 b=nKQPbV93YXj0pYp3gTF8qbWDb7Y81JJEKqaW8535N9GpaGnHyq+qW0C6DNWN5GVjj2
 anFjnVkTByM1DnEwMBNbYnUfLMC8mdDFIMta8Z+6cGv211x9++RcwwkF21ZRlXUhLR36
 wwC6e3gIOnBUr+LlyjN1kGD+k/ub1j9MxIuXlUPBnr9xEMtXi/Di1DAE2/HSghQNp4nj
 +CUZ5ETOXQPv5oyCWonFdBJPnHaeGxEiOqX3DV0UtO1jyEjrlYN9QQ33Y7MlAwaSUKqR
 QqXozewbcadR80MiPSMiE553P1aQ+Ft/YO2s1I2lHpLUmLSnXDTk3uLQGk2Uzc/nFT5U
 poxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAswEAwIxbblGeaQWof2S0UMoXJu5ohxpAKYOLfa6m+EF63Ny7qsUmBd1A7G1TJlD2pwbpVZQd8apU@nongnu.org
X-Gm-Message-State: AOJu0YzgBF+9nhPx6BWSjvDII1xW27MI7WOyXn8JDR+cxkY6RRX7gLiR
 7GLj+ht4Lap+VOj49vPldJfmqeci0JRczuAUEycJuagrwX2Hn1XVkzEVgPB/89ib/7E=
X-Gm-Gg: ASbGncuVy/hHXztBRGsvG7ZfKqs2iJMUSZ7n0nGViUKUET02ArhaIwvvocv1D6i5kfA
 QGdZ17y/IUUdSKdWA6KiIUIq/DKVVkdv4UMnU2ZKePslNcpHhZHNWNJEtOIIksSTZJVErupjw6t
 6FPDLIq/0unSQlqGU80hm6Ec2rsiY0bVUd4qzePBMwC3ynhPcv6CjH+zgYww/r6nQT1in0YIFJ6
 3sRuLoUALgRl030FjzZ3GYR+CyI02yN922S0n7dKDo3uLoQRR6KWOIZN3pkmh49ulky/T5mHD3Q
 cEfPTCXvBSQtAFJOnIAbmeUFtjZR1JxCTtFcl8hkD2g82QWlEUcFKMURuex8qgWe6+cP7Qd3ZgU
 =
X-Google-Smtp-Source: AGHT+IF41mK3h4GQ0Lq+NvMD/ECbwm9bmcw67V3GiHmBDXi12xyB2/bgHOmxPPtkdkJdM4GeVD+/nA==
X-Received: by 2002:a17:903:2283:b0:234:c549:da0e with SMTP id
 d9443c01a7336-23824072d85mr53009565ad.47.1750863287133; 
 Wed, 25 Jun 2025 07:54:47 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d86518b2sm135054305ad.152.2025.06.25.07.54.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 07:54:46 -0700 (PDT)
Message-ID: <a437c3a9-2554-482c-b52a-625ae290805d@linaro.org>
Date: Wed, 25 Jun 2025 07:54:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/27] tcg/optimize: Build and use o_bits in fold_exts
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20250603080908.559594-1-richard.henderson@linaro.org>
 <20250603080908.559594-18-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250603080908.559594-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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
>   tcg/optimize.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


