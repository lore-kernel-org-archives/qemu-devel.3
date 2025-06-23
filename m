Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A68CC7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 22:38:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTpnK-00087M-T7; Mon, 23 Jun 2025 18:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTpnG-00086t-9m
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 18:37:39 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTpnE-0003Qw-I8
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 18:37:38 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-73c17c770a7so5335012b3a.2
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 15:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750718253; x=1751323053; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ie/Jbtqrmn2Uur88ykWORcPz57J0/Ee1pl9bf2eBIq8=;
 b=C4xb4DghCB8Yfctu9nkH5lpyvpDuog3LMBtlw85vQqKa2/iX4fMjxANwsCPNj4HWft
 BJDcIRlncUqUDmdpUh7HTZG4QUp+tCDQWMEB4sVll/XpvDGrkSVRJWSFP/CIaHExoR9s
 iqPTOQwTrR1njnvrtzeDe/lEVHc+qeGPC1TqDi9HDurd/GwU0VbSkJm0NwcvaAehAWsU
 PNAtNH4/FbsBlUThEYRlLd7FGf9ZpeRTp0X9c0covpOUkWsnceK1nr5g9auQZb/12u8L
 YbfYZwjokl7DS29V3H5s6ByAwWAf+/sMTuepWpiD8TA4u4NOf552g5CJsDvhr6eBIHkU
 zNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750718253; x=1751323053;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ie/Jbtqrmn2Uur88ykWORcPz57J0/Ee1pl9bf2eBIq8=;
 b=KOXKfBDJTkHzEKAjvxB3qnl9i2+Ixuod8aeCtJRbpC68bbkwYRN1gVdKvVV4vFAnoc
 MPOlTAEQBGhzSWW13D5ARBi4dZe4OFd0rTnxmqmVCi3NJt+cJC/9MvhotiA5z/nImRuU
 K/Gzm9DXvwEyb+n4zof614EuzVT+xmMvRPcFdExARbDUnGrDLyNtKMt6LlVrCYJc0xmt
 OV0xqQsu6tTST3VC05t+4MS9D5UPxTF0uhtLo2WjOhx+jGz+u7nbXhVXdi3LfKyhnk3o
 AxQqSvbhmGM3TaFVD38ovpUpFzy+z4ZGhqHP/pS+1QWsqWXCEICVP7+ogPEAyWhycq88
 siDQ==
X-Gm-Message-State: AOJu0YwpPb/15+JULbdBN1Vm7Ka73cF1z5iCjYK0OWJjraKTbSA0iApa
 JNF7v3n8kHVkRMASFaAARGjZSqI+WDXd9qDo7SEJLO0Y6fqcB7YjkcKJxljy73f+PBSzdByqLDw
 P0HfAL94=
X-Gm-Gg: ASbGnctWFzm0o8bmn9Lu9qGYW1lwEM+1E/PtvUmzZbBHXQEAw4lGdwD77FKTQWdSpTL
 dGYUMUVpoc6ZEnKgRkESkeWsu2e8HQeA7r57Kf6OpjFJ9XLv1qEDUaT9FhWObUr7EtI7jUDbXAF
 17zXOmksK0Z3l/lHZd74VvzxVK0DQ80+tVjoXPoCDvmeEWrkISWrzxh+UJD4CCjsF5VhC1IJwKB
 d2jxep6D01dnOsAlFRpobLQfRJdXtdboiGx/Rcym6YF56sh3jkbOk9zJfXP674VhF4DzxOmG9Xd
 E4C6+05Z0e5ck6zrxGoAlZdJrP2dCZknU3pNryXTvw2LoUQM+ka8lfdU30hMAxe3ISHQgbE+ie0
 nhVjj0Qp7k4K8g5sIoB9qgcjBIcE5
X-Google-Smtp-Source: AGHT+IGDEGs3E+/QsaHcUWWckXf/cCVsgTaEPs+sc3Sd+gzOB8MxEKbro70k4FM54jdq8GmcNrau9Q==
X-Received: by 2002:a05:6a00:2789:b0:730:95a6:3761 with SMTP id
 d2e1a72fcca58-7490d4f533amr26003608b3a.3.1750718253507; 
 Mon, 23 Jun 2025 15:37:33 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-749b5e42a8esm196623b3a.69.2025.06.23.15.37.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 15:37:33 -0700 (PDT)
Message-ID: <ed51d1e6-8e81-412f-9ad0-03726aa27fb4@linaro.org>
Date: Mon, 23 Jun 2025 15:37:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] hw/s390x: Use preferred API call for IPLB chain write
To: qemu-devel@nongnu.org
References: <20250623201216.721130-1-jrossi@linux.ibm.com>
 <20250623201216.721130-2-jrossi@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250623201216.721130-2-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 6/23/25 13:12, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Replace a recently introduced legacy API call with the preferred API call.
> 
> fixes: 0927875 (hw/s390x: Build an IPLB for each boot device)
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>   hw/s390x/ipl.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 2f082396c7..f2606303e6 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -399,8 +399,16 @@ static uint64_t s390_ipl_map_iplb_chain(IplParameterBlock *iplb_chain)
>       uint16_t count = be16_to_cpu(ipl->qipl.chain_len);
>       uint64_t len = sizeof(IplParameterBlock) * count;
>       uint64_t chain_addr = find_iplb_chain_addr(ipl->bios_start_addr, count);
> +    MemTxResult ret;
> +
> +    ret = address_space_write(&address_space_memory, chain_addr,
> +            MEMTXATTRS_UNSPECIFIED, iplb_chain, len);
> +
> +    if (ret != MEMTX_OK) {
> +        error_report("Failed to map IPLB chain.");
> +        exit(1);
> +    }

I'm certain you should not exit for a guest error.


r~

>   
> -    cpu_physical_memory_write(chain_addr, iplb_chain, len);
>       return chain_addr;
>   }
>   


