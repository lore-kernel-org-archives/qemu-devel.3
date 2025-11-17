Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4396FCEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 13:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKzXB-0007Av-Jr; Mon, 17 Nov 2025 08:44:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vKzX8-0007AV-D7
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 08:44:42 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vKzX6-0004Dw-Rb
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 08:44:42 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-297e264528aso43021475ad.2
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 05:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763387078; x=1763991878; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fytbvVTf0UQ7oYQnU1JSKf5Gx3i4Vweqjn7EuGQaOT4=;
 b=sm8BQmvZ56qeTEmJ/H/a0s7XzQ29eYPgVNpJbqPIasZdec57U3FbR4fDSq70d2ivFN
 xQTr6zo3M9xIIDaq5laOYuY6UhCMVz5d5L3Ow4JX84gCjD2LD/HhONp9+vz1OErnjFBY
 hP9PrQ8dJ8QTGU1jiUR2x9dY+FhSevonz1oqTVFqGrTJbZ5qbFH6Z8oWr1zlhHYz/9HR
 Mb2NSrNX9UdamdBHkAG/+ofU70D1OGaZbKMkSXandnyHlkNIw2ICKhz1IRupCO2DtNJI
 iU5EKt4CUGQreDg59TH4I3Lvqi10GVo8NlbFKcigc1avCOZ7w6W7BbzQe1zdnWsSc5CL
 jBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763387078; x=1763991878;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fytbvVTf0UQ7oYQnU1JSKf5Gx3i4Vweqjn7EuGQaOT4=;
 b=mKHnXQAGEC1rMQThZ/SoCx1vL87pVbeJM3GU1u9EtPUYqqf5E91u6JL7nAQx0AloKV
 87durc3cheD0SCRabNaMIBhlMnPT1+z+coP7gmyJ4OKO6X2zPV54ujDxGopkm3JdHzhb
 X/6jr6X6g9GRmevqNy3l0ysXev2sHmLM9X/GsW9jBbMdiPC3yahSvB5vgxaQ5wFwGdjW
 5rrmxGCiAPBlGVQjJk8M4PMkM2XvWinixb1zzLMAygTn+4abVSiGcUvz/qizIktXEHtZ
 VkHWpflFCSXB+pgxHlXhJ9Fk+5Q10nAp7jWFtoQXskxlN88LWTyGG0uoXBIXYlRH6VmA
 s+2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUcW/Tmq2CicZ+mIE/JkHuzuX6EZWd1oI9YkpaUhjaomsb63MiHZK+Zk2rFpAGS5SrUW0lm1xpP9iE@nongnu.org
X-Gm-Message-State: AOJu0YzQcDhbehn91P7DFjh08LA3Z+kBy6AnAm+gw8diN4DCYIqCE5RG
 MTiwxYyHnvfqhRIIVhjPQW/qW4kXF41rsV9PMSjIgq3rymKFfFe6jsjQw5q3voac7o/C9nI3IF0
 ZefBi
X-Gm-Gg: ASbGncvreJJ2DMzjnnhP5kn2EeB8JQ4q6/uXn9yTiCu/rArdcEm3SDxud47zLNxa9vW
 jI7/0D9Zf6b7KPkBzJlsuTw1TwqD2AbrALnFkyoPOhPIIYVwXFp2ahHGZVvl9Hte2SxPjGYerO9
 qiYb3cLJELJCIWfS/0yZ6MV2vYHVGrVOUPGdKvivedd4QpHhNmbOaP2EW8pNAbi1enve/OtKQ3S
 XJkxIGQ229WN4TZCLTRSfcJW81yv96fR9Yhp2iGZgtHiwXvke3aJ+3ILPRTMokSaE8PfifSL1UV
 Twbxe8fnXat0O7cMTL5US6sv6DjC+FstdZFHZ+HkynnXVZfvFQBC7dFNXP7vEkiALnFIxhouk1f
 7V7U2Da/fepkkTHXmPYzS4/2Z/7+zJAKehiXheOWgijl3uLCt9NdvMWpoyVvGIh0Sga+SH7LH3p
 IaHj48PcfepstQw6ylMESmxhz5cyfIlmaZ8ZW20GcdxlXoaUOVWvk5
X-Google-Smtp-Source: AGHT+IGj8kxdnAWUGcL4n9uNKEVTKSewe7g5h2PrIt6NxyV+okLPLv7o7h2Wc/R0hAFX6CdeFGWM/Q==
X-Received: by 2002:a17:903:380b:b0:296:3f23:b910 with SMTP id
 d9443c01a7336-2986a6b5587mr111782585ad.9.1763387078380; 
 Mon, 17 Nov 2025 05:44:38 -0800 (PST)
Received: from [192.168.0.102] (189-47-45-94.dsl.telesp.net.br. [189.47.45.94])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-343ea740980sm6612742a91.7.2025.11.17.05.44.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Nov 2025 05:44:37 -0800 (PST)
Message-ID: <84357dfb-8098-4d57-b144-c3019c7f6a70@linaro.org>
Date: Mon, 17 Nov 2025 10:44:28 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost-user: ancilliary -> ancillary
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Stefano Garzarella <sgarzare@redhat.com>
References: <44f5010964049b9988923ce1429652e0a9e8ebaf.1763380540.git.mst@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <44f5010964049b9988923ce1429652e0a9e8ebaf.1763380540.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62b.google.com
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

Hi Michael,

On 11/17/25 08:55, Michael S. Tsirkin wrote:
> My dictionary says the former spelling is incorrect.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   docs/interop/vhost-user.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index 93a9c8df2b..93f756d3f4 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -411,8 +411,8 @@ in the ancillary data:
>   * ``VHOST_USER_SET_INFLIGHT_FD`` (if ``VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD``)
>   * ``VHOST_USER_SET_DEVICE_STATE_FD``
>   
> -When sending file descriptors in ancilliary data, *front-end* should
> -associate the ancilliary data with a ``sendmsg`` operation (or
> +When sending file descriptors in ancillary data, *front-end* should
> +associate the ancillary data with a ``sendmsg`` operation (or
>   equivalent) that sends bytes starting with the first byte of the
>   message header.  *back-end* can therefore expect that file descriptors
>   will only be received in the first ``recvmsg`` operation for a message

Yeah, I'm not a native English speaker but in my mind the latter is the correct form :)

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>

