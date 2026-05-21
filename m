Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D45F1CD343F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 05:50:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPwIN-00021h-CV; Thu, 21 May 2026 01:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPwIL-0001zZ-SB
 for qemu-devel@nongnu.org; Thu, 21 May 2026 01:50:09 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPwIK-000397-2f
 for qemu-devel@nongnu.org; Thu, 21 May 2026 01:50:09 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488a14c31eeso34672275e9.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 22:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779342605; x=1779947405; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gfrgYQOQkEtk+/MqMLPJPVSGHTgqZziOuqPi8na0zgI=;
 b=ciP7AW3sh9FBVxnLKJnP4NJUeeVo5ya+kFIVIutcVrdmSZQebKZoW9EIYEkHruTNMj
 rCFc4d/NwlkOhfXgsr2umMHxGS8yLWaf7StvhaGrBwdUKbhai27UNkiKYyWQtX53voiK
 T3odeUWnSTgUoU38BkyNHwJ6MGsDKiqSSZQ77Ep7iAOT0YWsIobkVEVnNBWFbgGbnDQl
 GAhXWX/fnofMCxylvc805TnP9Is+TAGmSv6z7kMkgcMAKRhFAwn6AzlQ7K6BhynGsNMP
 XZLhdvDEPXQ1j3hDjz0F60wUK9DSpU7LWa8O5L9rh47QxS+VU1Uh/wEs8VHOglIA0G9n
 ZBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779342605; x=1779947405;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gfrgYQOQkEtk+/MqMLPJPVSGHTgqZziOuqPi8na0zgI=;
 b=p4SRhIFH/s328pgQVb2RNM4b2aX5DmN+2NCfWfTEkkdaU39E9DpIpWUr5u9MNr3mbc
 a5vxeVErtFDOUI7kqotTKcGNhJG+zJrkRwxIFeQFVidYVDY59X7Z9pEPSE0/KHzQVNKb
 rK28hDAGQ9jFcmcAO6As29OT6aq4s8HB5QMEZ/KjsAnWmrAwYtrkK/0sHzA8YNZRCZs0
 rWoiGm2V9LgrXPBxMMAevE9x8V6EHkqs+1eZRsGEk8zqZB59EkFRUe1ei/GOPg7uYEH4
 jJtfbB/ZqhNBNNt0cBFiF4jm1Walb4B9bhWtXKBUY2LpKsNI5/9meT27QC7kjHYc4LWy
 vl6g==
X-Forwarded-Encrypted: i=1;
 AFNElJ91ct+Q8ptjj652x3s/A1lmR4fZzkRm/3zjpGQnez9owM9glZfDFTXiiDty+PnGM/il/Z2PHT0ZDZcX@nongnu.org
X-Gm-Message-State: AOJu0YxtkN1K6OjhYGsYhKtMA9iN7b3aCMv938H6oTf3uWfK1nU8LUgl
 s1sQDdv6ttorz+iuVWwgAcvy8t9VHLDeXvpk3lyJVV6F09p6IWtKxe0GR8f6FXHsf+c=
X-Gm-Gg: Acq92OFmZfhav7UMwmE/2od2gr7NuffwpOOylpyZ70nnBQgRUVamNCKmdKi+y3+nx2I
 0ZZ/muF89lLcITfJddmpd0IHWuMCva7/XcnV2W4+tIg29mZ2JS3TUTmLVFic52kNoEAdacM5nlP
 EzStYRZz1Ut/Wu7mpGsDHw6G3dl44AaBjSXAiVrxMg1nvl1KRdCshjz4Sqhgw5PzET9Dzk+5Dyz
 eG2/7VkRmA5JwWj4CkuHGhb5AZP5hlO9wg7piN6v8llCc5o+9o+QSNk3ZkTAwC41zLXWinQofCc
 Pc5S7hhYw5VWUDFXqppCsGJDAK98uoHqB+sRQrj02L1oJDuoz9B6yK1GXPUL1W4cdgtTznijldV
 txQittOxyMdnCTI2v1PJgNHse2/narLsl3VbBNawznXlBCvcf3GdDPua04tdHSdA8m4X3GEAcV4
 +IzL9hVyy3GyX3TQyeu5qA5XaKEGU5XZ75TvtN88Or8eZYD6gF0eBhpNWGZkxHzGAcwQ==
X-Received: by 2002:a05:600c:4241:b0:48e:62ec:f264 with SMTP id
 5b1f17b1804b1-4903607cfe5mr8397355e9.17.1779342604844; 
 Wed, 20 May 2026 22:50:04 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49035ee8a6fsm7893315e9.29.2026.05.20.22.50.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 22:50:03 -0700 (PDT)
Message-ID: <f4ed5c00-38bb-4553-9cdd-f88336e0abf1@linaro.org>
Date: Thu, 21 May 2026 07:50:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/40] system: move gpa2hva() to system memory unit
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
 <20260521-qemu-no-hmp-v1-5-d104f809e145@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260521-qemu-no-hmp-v1-5-d104f809e145@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 20/5/26 23:49, Marc-André Lureau wrote:
> The function is now used by SEV code path. Move it to physmem.c rather
> than hmp-cmds.c.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/monitor/monitor.h |  2 --
>   include/system/memory.h   |  2 ++
>   monitor/hmp-cmds.c        | 31 -------------------------------
>   system/physmem.c          | 31 +++++++++++++++++++++++++++++++
>   4 files changed, 33 insertions(+), 33 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

