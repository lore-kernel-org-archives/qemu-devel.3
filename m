Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB126C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 16:00:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAWKi-0001Lu-JZ; Thu, 01 May 2025 12:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAWKT-000170-Ja
 for qemu-devel@nongnu.org; Thu, 01 May 2025 12:00:06 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAWKR-0003jQ-DJ
 for qemu-devel@nongnu.org; Thu, 01 May 2025 12:00:05 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22c33677183so12110185ad.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 09:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746115201; x=1746720001; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iq4wI2hvMWJFfJ5am2rVr1+dgfMUTQ1q66FDL0gy5/Q=;
 b=rXGnEsqx6yMbLfqxaGKh15gURYy3aglFYq1Cb0pzQMH2gmI+mPjfvVUb28YWRJNTaF
 +7tc0nt1BgZVNi+qvGcZVjKBfAGbzjDfWvTWr2zLAJH4q48H4wSLEryFOIH9eLSIti9g
 KskaIkNivGgNEM0QXmJqfsz0emsbsL3m8FitS9kz4hAlcBEt96BFKSY2hr+pvKuzazxt
 1yGpW74vH58O+PW7Ovd18BMkRU/o7ol/wOza3LfIYJeGiMwj6cDNsKY4eN6512GCvpwZ
 J1FWeldbHIqFHKf/3XDDdGt1KlKNRkt/L3c8T42E4BWBMVBMaqXR80He6MZHJ+oFOoLv
 QR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746115201; x=1746720001;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iq4wI2hvMWJFfJ5am2rVr1+dgfMUTQ1q66FDL0gy5/Q=;
 b=BiBMm7T8xjI592iOGhf0xv3oq0hYKFysp6Zu5EFoZI/dcnYAIYsKUDH1EKBfEsV2Om
 FKcLwRLwiep68+QHKMWGUnAeNAJfNrx/EeiqAuWEmJ3FKLn/damSsqx6IYxYepQlszQW
 c+MaVzQw3cz2qMUZpAq46yO/tficXY1Pm1yEZL5MRGE+WIwLlW7TZfo1H7yvPRwVpjYR
 htjC6m9ThWpHloXskjd7R9U9vKtLoFqXii4KIwqhPqzzip/1A6oypZRI0C2ZskmhjhRb
 GWe6sjhG8P0LdH2fGv3cJ0J16dp9PuD3O1hyonv1rcbTUAivu7cDY1+IyfNZuk2GXeUz
 9tUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWF6qhOmyDRC6wXwl+6+hmqXYiTbs+AmDXj+scurZWc3ANSIGR2OJslsKTVIukpI8fBnMgApCJZJvRc@nongnu.org
X-Gm-Message-State: AOJu0YyI9GJGIBnrzUTcPs+A6PyB/KbXfI7YiFQel0IbfHK2L1NI2A29
 uVmaVfelrsQ9BvHqV6ZEPtiW6o6rUNsxTNO+MG8JG0KmTXh84XzMolvce8+ru0Q=
X-Gm-Gg: ASbGncu1Z3HRYKywSM728KwhYkDMQnpSajkI0lwVmVZUwT7g5OgodKxuaDy1hz+Zcw5
 hw6H3xZKCVnyRIHBuWvqzx7pMDHmFm3ESkSZ8VztLwGnfcvl1/5VHaBzPm6MsTMOdCoRpfI4qMA
 yjE0W+SZuArq8ekpqsEJKXVOe/yMSs4qw2I8rVyIaMv0YEGejZ0hFhURjFJYP2f7fm9y/d9ASTy
 1TEleCM9YZ8o+SIV4lbt5oKaKrYXxKpGFMTo8p/qwhcDvR6M4QwFasjdNyx0veI9FR8plWRMNtM
 ZZ38a5djWtiD4PlsLSWMlKTSBzhaFSjhqsR9EOUpo8Sw10uj2lde5Q==
X-Google-Smtp-Source: AGHT+IHTAHKW3F4KLBH7qeH5g6utI2jbPYoX0CzF+ui3tG/DptgUmpnBokan6F03CNlNceZzmX/kxw==
X-Received: by 2002:a17:902:f68c:b0:227:e7c7:d451 with SMTP id
 d9443c01a7336-22e040e19demr52902385ad.29.1746115201457; 
 Thu, 01 May 2025 09:00:01 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e0bc7ae87sm8320665ad.163.2025.05.01.09.00.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 09:00:01 -0700 (PDT)
Message-ID: <f647de80-1075-4343-a157-22fd2f30ceae@linaro.org>
Date: Thu, 1 May 2025 09:00:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] accel/tcg: Move tlb_vaddr_to_host declaration to
 probe.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250501145520.2695073-1-richard.henderson@linaro.org>
 <20250501145520.2695073-3-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250501145520.2695073-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

On 5/1/25 7:55 AM, Richard Henderson wrote:
> This is a probing function, not a load/store function.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/accel/tcg/cpu-ldst.h | 16 ----------------
>   include/accel/tcg/probe.h    | 16 ++++++++++++++++
>   2 files changed, 16 insertions(+), 16 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


