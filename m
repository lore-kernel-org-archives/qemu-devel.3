Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A17EDE997
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 03:33:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soE6b-0007Dd-QL; Tue, 10 Sep 2024 23:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soE6S-0006xP-9r
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:33:13 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soE6Q-0001Sk-Or
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:33:12 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-718816be6cbso4445307b3a.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 20:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726025589; x=1726630389; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VhB4YrBLxEZ9VfEvPG8Soly4uSXEA33CYZgsAi5nLCU=;
 b=Gfk+ZRVCkxsz5K+CeWQxU034Eb9p4KU2a5qCeu4NxQCtW0uB2KGQ8u6amc1V+dlKQq
 fw4G+BGwQnXV3O2cOaKCjVtYaQ485XxbflFIsqX4REmEr7Bp5TU6oCE4LaggspHW9mym
 5u4mShjZd3eW72QN8XMjT90sEEo0NA4d4Frdx8j+DJq0uihq3rfy+u3vKzQZJG09xq50
 nGx8tNSqMNnKW+tPv5u9kMAyUIBLGFdWWV4kk3dGMUJxBDEgKc4s8d4JDja0B0/0FfQZ
 DK13xbGEolF0m2D7sznHXcsS/QDZTZTvCW/3kRHrP+BA9H+ByF8oI3CyOOR3PLh+A5Yd
 VDNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726025589; x=1726630389;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VhB4YrBLxEZ9VfEvPG8Soly4uSXEA33CYZgsAi5nLCU=;
 b=MrXR/IBNZKLYYZ/rOsMXdB5uFmoJhOklL8dtmJhuiQ4UWL/BqGw5GedUceGgVuQc0I
 oDt+LrcWI2AKqXETmYQRz9j59xA6MObFGSXF9tg5PQ8GnkyOZOwYACixLropQAvFi3BO
 SX7tDWy6M58wMIPE4AL97dJ4dE8ZjYnhl5psRY2FCp5e9rs3jKGpPR2DJNBF+KkmWq6Q
 1PXpiwd9WYvBxo452ULe8etZpIcRVxW1GEiQHrov2RYnhjamt6GS0bWs8b2uRmVfzS0R
 VZgfrcVk+atp/IoY5E3VaoZ67JjYTn1UDd4Uz1sU1Bt1kTuEPl4pmQ9gaK9C1bYcbbcI
 NFAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2uckhexRBqjex7BgWwCLQdUlwyIBuDXhrGm8nccyZkGk/WHzXbriCNoV0JNNLWmAdbNFOxIzaLKlE@nongnu.org
X-Gm-Message-State: AOJu0YxQWC4O6QudyDXwFyYN3dujKAy/1M6/5+yHJjbWUNrli56+dpJB
 SsbHjfe6rmQydTs1XGH3BUEwnkYtjj95ab0qa6vrO3wT7G+FPyVODipZFIK1sK8=
X-Google-Smtp-Source: AGHT+IGjo3/CB9s33oQWnSbxxGiJdwcmydVJZIkkfQHgyR6UjeBWg1FT0PZrQB/4qsd/W8A6yTS8fw==
X-Received: by 2002:a05:6a21:1796:b0:1c8:b255:486a with SMTP id
 adf61e73a8af0-1cf5e17b67dmr4446649637.35.1726025589388; 
 Tue, 10 Sep 2024 20:33:09 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7d823736324sm5321568a12.18.2024.09.10.20.33.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 20:33:09 -0700 (PDT)
Message-ID: <83b36d61-fa0e-46e7-8aa1-87f6bdb42030@linaro.org>
Date: Tue, 10 Sep 2024 20:33:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 31/39] hw/scsi: remove break after g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-32-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240910221606.1817478-32-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 9/10/24 15:15, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/scsi/virtio-scsi.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index 9f02ceea099..6637cfeaf51 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -357,7 +357,6 @@ static void virtio_scsi_do_one_tmf_bh(VirtIOSCSIReq *req)
>   
>       default:
>           g_assert_not_reached();
> -        break;
>       }
>   
>   out:

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

