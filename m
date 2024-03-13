Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA703C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 10:19:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkLhu-0006qP-9x; Wed, 13 Mar 2024 06:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkLhp-0006q6-RI
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:19:29 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkLhn-0008PE-U2
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:19:29 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-512f892500cso5091015e87.3
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 03:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710325166; x=1710929966; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Em+u7y+YUDbR/ALAJ+dyUsxF1JndtA7TMUMVJDaF/tI=;
 b=N8NtYRshowUpFDGM1AGtMN7LiYZ8H1BoO8voWet+IKO79OEgWfQD3t8Cu7nAaOnEMP
 +lwG+bZH3qWRBgBlHooOO+cfZMniImn+nFV9+uGnRtWUMiInWsds6sSKuczNfvFqcCUR
 BIHGZnguQq7gjl2Kjr62ILZo91SnpZa7P3Nthrx3NCnrkQT9ZoElR5MNZ6lk/qS8ynJr
 bktvOr0TTE6A/j4RNpwC6zzjgP/3+qW8ohciU7uebQEUQsW8FNQGMk9/NT6qZtgBpqw7
 laJD5DE7pC2UfVOswUOPmp9AM7hB0vr1vXCdcyA3rYz0loQj/98lulaspXW3mJbQ3ISy
 u0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710325166; x=1710929966;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Em+u7y+YUDbR/ALAJ+dyUsxF1JndtA7TMUMVJDaF/tI=;
 b=ROcJX02pK40487cRe2TBjK8wfmqWGwycv6qH6euD7wEmIOM3lTPtbi4UWjCerWSeCn
 7cshfSVb1H1iYeLVMJVdwfo531zg9dgeQobIp9zBMPiQugi2Y87H9xnsr1SgEUFTgx5o
 oz1d48akERPqSCzB2WAefdxllVhqLguY788cQydmr1SoUa4UguKhVRhvXr4fDHaI5gdP
 9Ta7dvA8KQeqfXIT8HbJW2xDqYHZuqZonIIianjeWtml8fIxwj6TvYMNZc3jV7TfRP1h
 KL2ljHRWnDmn6VYinJrP/lYkmGpte/yIPCwUOkmxB9TbzphLIv7lbDS2KJ11xH/2i073
 4Kng==
X-Gm-Message-State: AOJu0YwOXPZFq8UXOHbSZcR73naAlkN6JKwePmQVe+xAMy2appZlufXc
 5fQX7faOzjBGYgH1qpYQXSg57zX+qj8ewRlVVZLXNNGRjs6nN35lmnhwhCvztqEb0TWe/ChyMEu
 hMCI=
X-Google-Smtp-Source: AGHT+IGSt8z2aBV810EXbmvQ/Amz14gKWM3NizP8aEWfqAtnsF52BdoZKbwJ6oSReRY/BMDVwK/fwA==
X-Received: by 2002:ac2:53ac:0:b0:513:c8d0:588e with SMTP id
 j12-20020ac253ac000000b00513c8d0588emr856442lfh.0.1710325165890; 
 Wed, 13 Mar 2024 03:19:25 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.182.179])
 by smtp.gmail.com with ESMTPSA id
 bv10-20020a0560001f0a00b0033e033898c5sm11406311wrb.20.2024.03.13.03.19.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 03:19:25 -0700 (PDT)
Message-ID: <99fb0647-ac76-4d33-8c59-35a57433292e@linaro.org>
Date: Wed, 13 Mar 2024 11:19:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 34/68] hw/display/macfb: Fix missing ERRP_GUARD() in
 macfb_nubus_realize()
Content-Language: en-US
To: Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Laurent Vivier <laurent@vivier.eu>
References: <cover.1710282274.git.mst@redhat.com>
 <5aa4a6417b0f7acbfd7f4c21dca26293bc3d9348.1710282274.git.mst@redhat.com>
 <ZfEOF36Y1JbveUPx@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZfEOF36Y1JbveUPx@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 13/3/24 03:23, Zhao Liu wrote:
> Hi Michael,
> 
> Thanks a lot and aslo this one, I forgot to update the status :/,
> this patch has been merged (commit d470fd6acd60, "hw/display/macfb:
> Fix missing ERRP_GUARD() in macfb_nubus_realize()").

Normally git should cope with this; if so, no need to repost :)

> 
> Best Regards,
> Zhao


