Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E6FD5A6E2
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 05:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFnzW-0006YD-OD; Tue, 26 Nov 2024 00:20:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFnzU-0006XI-E7
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 00:20:00 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFnzT-0003jf-0D
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 00:20:00 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-434a10588f3so11799535e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 21:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732598395; x=1733203195; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F7TwmWCfuDUOT9ESPywf7AnlYQkna+b+1fpB7ffNAVI=;
 b=cuhWNCcJglhEDPyITxduCN4EFbVCRbLBqzAhOgbsCIiIJ+Z8ZJH7Kb5qy8UM6aMFcA
 ieu89HOkZwu3pQHonwzW3YeEPNEBlChUhijEAn1lEa3lzogz7tb3GyP0HjUT64DP1kfA
 twGrg7xYGCXbsvhEQ5uo+Mr/BX3kuSovU4Rw5mZ1pGtOW+dOBxZbskeABSlYgt4sR1z/
 JOTambHUopd3A7ZxrlxDYcPxWeF4dzTYZy99yPLYpPXtjDfyHDL+k8HATAkRucuxTMt5
 HhFziN0Ro1A4QvLL8k41XzKs/fYbxEZL1B53oX+dD7903w5qXf2bVu7qJxr89gistSTq
 pPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732598395; x=1733203195;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F7TwmWCfuDUOT9ESPywf7AnlYQkna+b+1fpB7ffNAVI=;
 b=F2eFM2DZn68kMvvL3JV9hLYSF8w1+OCVWyjzK41tS+PZ8141bj51tTJxmB5tBLOaD4
 FfZIrxvarqVCgxegad5m/6AiKKF3n3QEpyR41N31iBN2/QMHTwo515aC1hoB8bkGDwn8
 QCtNg76ah475CGoQT3vf8UEfzEgXod2L+1WTtG9oOtMMsmu+hB0TpKrkN/KtRHFAhAiX
 9L1FA2UhdMQIoFypMYAr5hX3g7bnEvB1vVze2lvXqKDPchXv/Nxv+PSXRuA9c/J4to8e
 BQ+6J+Kkqz9f8GG6kzpbJWD3s8wswJMIeXOSeMXAu69YKOg+YEKN5EpuRE/0kA13BXZj
 m9Hg==
X-Gm-Message-State: AOJu0YziVrBLW1OuglXTXIMQURts5fez0jMA9mmtg9aRAEaxwMDjbkvF
 fgHNDI3FhWSu6fqQ5E1W7638pns88S4dkG8tzhvDPpaNMiLq+q4khnRZgnKq/pg=
X-Gm-Gg: ASbGnctfv495qK6nv+BJQMdf3/zEvE+lEIvN5mbawRZxWaAluJ8caN2xJn0vkmMRYkh
 Rm67mlmM1yvuntwD6KQ7wcDtUZ9qSD6acp+o2qX5F98BhYwwzQqoqyY8s8boryRIptKlzYv1b5R
 vDviLofoV48sSqrVnAUZT/tGnxR0CI6+Ig9Rz+oGSZnOgQQsGK/9qGzhZyUrUC90K22eI/2dXjU
 +jNrdv3K6eiWwRXQKaHvOLkCPBF0NRk0hP2xlK0h6ID/TGCB/Bj9Hz3C8CNcUzrxA==
X-Google-Smtp-Source: AGHT+IFfCPRPoKTkt7mxxdY/v8SDppG9yWLE0teVXtqzBNrHLGjuFYCBUlN1fr4pkCEnGi94M5Aobg==
X-Received: by 2002:a05:6000:2d01:b0:382:41ad:d8e2 with SMTP id
 ffacd0b85a97d-38260bcfc2bmr10065125f8f.39.1732598395332; 
 Mon, 25 Nov 2024 21:19:55 -0800 (PST)
Received: from [192.168.69.146] ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4349eeb375fsm66022715e9.3.2024.11.25.21.19.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Nov 2024 21:19:54 -0800 (PST)
Message-ID: <5c99da97-ddd1-4cc4-88c8-f11732be64b3@linaro.org>
Date: Tue, 26 Nov 2024 06:19:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] ppc/pnv: Add xscom- prefix to pervasive-control
 region name
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Chalapathi V <chalapathi.v@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>
References: <20241125132042.325734-1-npiggin@gmail.com>
 <20241125132042.325734-5-npiggin@gmail.com>
 <03d94b2b-4653-4401-a33d-8581ec022ced@linaro.org>
 <D5VT2APZ0C4M.2BNQ7AT62V693@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <D5VT2APZ0C4M.2BNQ7AT62V693@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 26/11/24 04:54, Nicholas Piggin wrote:
> On Tue Nov 26, 2024 at 5:28 AM AEST, Philippe Mathieu-Daudé wrote:
>> Hi,
>>
>> On 25/11/24 14:20, Nicholas Piggin wrote:
>>> By convention, xscom regions get a xscom- prefix.
>>>
>>> Fixes: 1adf24708bf7 ("hw/ppc: Add pnv nest pervasive common chiplet model")
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>> ---
>>>    hw/ppc/pnv_nest_pervasive.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/ppc/pnv_nest_pervasive.c b/hw/ppc/pnv_nest_pervasive.c
>>> index 77476753a4..780fa69dde 100644
>>> --- a/hw/ppc/pnv_nest_pervasive.c
>>> +++ b/hw/ppc/pnv_nest_pervasive.c
>>> @@ -177,7 +177,7 @@ static void pnv_nest_pervasive_realize(DeviceState *dev, Error **errp)
>>>        pnv_xscom_region_init(&nest_pervasive->xscom_ctrl_regs_mr,
>>>                              OBJECT(nest_pervasive),
>>>                              &pnv_nest_pervasive_control_xscom_ops,
>>> -                          nest_pervasive, "pervasive-control",
>>> +                          nest_pervasive, "xscom-pervasive-control",
>>
>> Could this break migration stream? Or only RAM regions need to
>> have a stable name? I don't remember, but try be be cautions with
>> such cosmetic change just before the release ;)
> 
> Hey Phil,
> 
> Thanks for always somehow being across everything :)

;)

Answering myself, I/O regions are migrated within the device state,
per field, via DeviceClass::vmsd structure.

IIRC RAM regions are the ones tied to their name, which is built
using the object owner, which is why we can't change migrated RAM
MR owners.

> For the powernv machine we are okay since we don't support migration
> at all. It's on the wishlist, but at the moment we have lots of
> hardware models that don't provide vmstate. So I think we are okay.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


