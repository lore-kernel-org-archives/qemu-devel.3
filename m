Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B2FFEEA84E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 21:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqeg0-0003zk-TQ; Thu, 12 Feb 2026 16:56:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqefY-0003wF-1j
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 16:56:16 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqefW-0004G1-Ag
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 16:56:15 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4801c2fae63so2321075e9.2
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 13:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770933371; x=1771538171; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t8WBGiN4/DVAiL0Eh6Dae5nCGHyAaujcJb6LH0LxG+U=;
 b=bvz9giTXLLncdpoz5adxJfTW+jZigeh75E2LqdYo8V3YW21h1sMzbxTa9E5F5eJXUk
 /9yGdbM2WudziGqbad8Q38JlI0XzSwET7MYUSJ3FEgiWV4pou3oCBRqD2YXGcYQOJE26
 u4Fl713JdK4VOLLv7RDto2ydFqtssbUczzQM9bTV7Fsy3e1PnKP2+7LfVm2ie35Hb9bj
 4zHYxppyPZxlRwhdz5kPKpwyPFkkQsEKVmFZs4GsxOfx/yNIDCLG5rH46iKPsbwbO8Mk
 ZIMviomEBpmdNYA2pKMGJ1WYSeUWO7DDL2TghlQ1yEL5C6BLvvA4y3I1uuxbUi6yKnhZ
 vYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770933371; x=1771538171;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t8WBGiN4/DVAiL0Eh6Dae5nCGHyAaujcJb6LH0LxG+U=;
 b=EwylGJUO58zf7Mi8yAeDAEhS4sTgWkwDP3E0qzc5EYtIwjhQjGn3ELveQ04k+xOCgU
 YX+CxRtgPKKt5x5jxBraH/dBTFS2c1jcgKfJDyOFhvfOnyiTLFZ9I7BiCPpdMUiCcL8V
 fY6g3hcfWRtn7MZzYv7gBptOeN6Nzprpsk6tMKwSPMb76Ib1qigbYU9zd2x0VPsQR1+i
 Clgs6UDPVHid+M5/Uf5Q0CDctx4hLJZF5QqL6TxxSQCcRQ2TEtMneZMH3DwESaFy5nnw
 HCJbIEriJr2GhsZeRwUW0qDUbs/i/rFUqDmS6xwSGxfuD1UcUSdI2FNZEl8uZdX8fx+f
 +J+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVV3lWJKHyUNZBoSWH/24bemh8dnHP4jM+bGf4HrnMhfZkBsSU9TmxoLAbZv7t05U616cU7EJnjMkyu@nongnu.org
X-Gm-Message-State: AOJu0YySf+8hVtnW+NuWaRKarRKd1thvkUv+wghvF4RjYFRaorpFBoX5
 BoBu4UK8sveeb+yB9GOfcKM5y04havwN1qmfdC09Wi1EIIWVdPX3lZX/RmH54OqCnaQ=
X-Gm-Gg: AZuq6aJNHtd6RrMkaDmHAThy0z639Do5WgrNGf4T1PfHoFS/OK+EIbLi1csMw0y0OGK
 15jQsPT5v2lPv1+aKHuCtku1jzYIZTQdU49RPzHeZrUMmrKwNB9nsk3fjb/VCH6I2Ydp4+h+6po
 iSdaE7kYd2acPxfvIgOWukdt940MMpTVZu/hLOuWtwktAjuC6uqAGmKvMSU1wqkzL3OEsJ5wPEX
 89Rlotfr86JC6V3fiGK9q68PldVbrspxFRuPENd4YwGyE2b/v2kD4Sc+328zpn30EwY1zMaScI5
 o+2LcU9Ug0QMy3KpZteQTO/TRGpMw+Nmtd7gFiItycEItwgoBM6mFKN1l/RDhOQJ02rTfMAV9d/
 KHUSAKXd591L9LXaAcIcRd5FZtBSoE2Pp4Zn9RFu4HYf9Z/BZ1U2qqvNfITBHuKu2BQPj4cZnt9
 PtYqYDWfsVhXOvsf9E7ggTVmBpx0OmC0BDqslxwbam2C95/EimQn6uj3rRPTZ8XVQ31Ulha2HaI
 RNx
X-Received: by 2002:a05:600c:468d:b0:47e:e20e:bbb4 with SMTP id
 5b1f17b1804b1-4837108fcf1mr9628085e9.26.1770933371468; 
 Thu, 12 Feb 2026 13:56:11 -0800 (PST)
Received: from [192.168.69.225] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd1bsm246005785e9.6.2026.02.12.13.56.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Feb 2026 13:56:10 -0800 (PST)
Message-ID: <320f3ce8-5df0-4f70-b9a2-9823ce0545bf@linaro.org>
Date: Thu, 12 Feb 2026 22:56:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] hw/net/rocker: Don't keep pointer to h_proto as
 uint16_t* in OfDpaFlowPktFields
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Patrick Venture <venture@google.com>
References: <20260212140917.1443253-1-peter.maydell@linaro.org>
 <20260212140917.1443253-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260212140917.1443253-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 12/2/26 15:09, Peter Maydell wrote:
> In rocker_of_dpa.c we assume that the h_proto field in an eth_header
> struct is aligned, and we copy its address into a uint16_t* in the
> OfDpaFlowPktFields struct which we then dereference later.  This
> isn't a safe assumption; it will also result in compilation failures
> with gcc if we mark the eth_header struct as QEMU_PACKED because gcc
> will not let you take the address of an unaligned struct field.
> 
> Make the h_proto field in OfDpaFlowPktFields a void*, and make all
> the places where we previously read through that pointer instead use
> a new accessor function which allows for the possible lack of
> alignment.
> 
> (Compare commit 5814c084679
> "hw/net/virtio-net.c: Don't assume IP length field is aligned"
> which fixed a similar problem elsewhere for an ip_header field.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/net/rocker/rocker_of_dpa.c | 19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

