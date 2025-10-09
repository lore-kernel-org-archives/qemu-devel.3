Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1C2CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 15:43:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6smm-0003Rj-Q6; Thu, 09 Oct 2025 11:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6smk-0003RN-WB
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 11:42:31 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6smh-0004dY-C0
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 11:42:29 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-78115430134so774126b3a.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 08:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760024544; x=1760629344; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XrxNSZHqH6NhkKvBSuPc3F/eFKYRVCgsoHAnmdwfMmM=;
 b=XknyjerUcIW7thBciHA+6dsM6SqJV0tOIF6Ra7OYypFVCtr5srUGjqkXqt3/b9FTlx
 PgSYrQ0pzdLMd08uzd/Ogq17VYHprvvsLcDPs3Qx3DjjuQ/H19zcAoSip2L5ouRMNu2S
 v1AK/AIjwmyoFOVomZnDMSxzqxh5RoHczUvyh/QOqPSX0IELExRbLkr8STfMMyp4AiDG
 5NI7KCcuJZt4+ukA25M9/4duwt7wZDrlwTu/WN9HFfKTe/o+buK8Ym/IW+0naSwZtYdy
 iW8K6YVsmMkIkNwAz3MVvcEHUR+j5w1XA57i5wblnk2rUcR3mbsYRw7MgDar2hc6D4uM
 xBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760024544; x=1760629344;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XrxNSZHqH6NhkKvBSuPc3F/eFKYRVCgsoHAnmdwfMmM=;
 b=nlo2Yp4wdG2grCT8ZM8ZMGNGFMP9cn37ZCJsi/3zhYod+DEzHUVE/AM/LMQnR2P3IB
 md7MKL4e0oWvib2mmQhXhYFwq4asu4svmeniaTStdnyIb8yJlnEcjJD60K+afzRWsRre
 bYgEjUQLQZ40JK1T4UmnLJ4E/MSocdiFq7pmu9NX6kdo8piBFPE63eFTxkHkuO9bQY7+
 pCgpTgJTzv/OYcIn7cwT/q+nLmErwTo++HnguTmjgWAY9WpBiaK8IuslHis+DyrMxjd+
 lhrumimvBBUZpeCPxgkjh8p+PS0dpFAT5zXh6yYR7Fu3sx/YhvTFfg1JEdShewSBpCPP
 hcyQ==
X-Gm-Message-State: AOJu0YwCKKyOSJGH2rHxZpQJK2VEGmQq3AIoT3acKMwcrUOrsrzf5c4n
 eNBGdtEh8Wb4+24sMKZNUrl2yOsb9lkKujglY1vuE+dnd6qjTTbvYtStRV9oL3bcGoCNTXHE6q7
 YKFRKWRs=
X-Gm-Gg: ASbGnctemNLfyNsE/69pWd+oXJvFp1JnDJfm2SlgofV0EOu2qWo62tvJt+6vomiIGW9
 Ga9yXdvSeSCbQWAEBEpzErmjbkTqrjKl7LOkDlM7Fwtv3+88+spKwsBZk0cVPsyuiFFP6jKKNbv
 xr5x/C9WDL1CSZOtrv3aiNFgcMppjKc1TsEYUlqB573LF4A1hJ0A+NTeNSW5gF42Ljuz5HH2Ueq
 bdXKCakTll8Qu48ZVugvhcGJV0/4uFS+iJeOzAhPopKzTnjRkxHW+eR+uxby7ApmKgMm9/bqnHV
 RvO94E8S84dS3fg924CZPrCuyFv+KeoaOHWtwR8byDnXMa3ivs9UDLfpLuCw20FrEKh+lE4M6va
 lt+EuMWh0yQby6hG/sKgZoAgJhPDjZsnOx698U5LHt+2pVcaUTjIbXl9PICljm5aa
X-Google-Smtp-Source: AGHT+IEWBLlawTmlOLIn4x3PNYM43nyiVQdoDxeKlR3VcS204MT7SVKpgqEqlBrbsxLUXxMT3uJYgw==
X-Received: by 2002:a05:6a20:729c:b0:2ca:1b5:9d45 with SMTP id
 adf61e73a8af0-32da839d2a0mr10624272637.32.1760024544113; 
 Thu, 09 Oct 2025 08:42:24 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33b61d88857sm131771a91.13.2025.10.09.08.42.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 08:42:23 -0700 (PDT)
Message-ID: <9c3b5ce7-8106-48af-9d6c-0d8e26e934fd@linaro.org>
Date: Thu, 9 Oct 2025 08:42:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: fix layout of struct target_msq_id_ds
To: qemu-devel@nongnu.org
References: <mvma520fd3i.fsf@suse.de>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <mvma520fd3i.fsf@suse.de>
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

On 10/9/25 05:56, Andreas Schwab wrote:
> The msg_lspid and msg_lrpid members are of type pid_t, which is a 32-bit
> integer.
> 
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
>   linux-user/syscall.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 0956a7b310..3dcdb3ef42 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -4185,8 +4185,8 @@ struct target_msqid_ds
>       abi_ulong __msg_cbytes;
>       abi_ulong msg_qnum;
>       abi_ulong msg_qbytes;
> -    abi_ulong msg_lspid;
> -    abi_ulong msg_lrpid;
> +    unsigned int msg_lspid;
> +    unsigned int msg_lrpid;

This should be target_pid_t.


r~

