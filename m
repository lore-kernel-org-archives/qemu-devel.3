Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F41FC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 20:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjlvN-0006su-7B; Mon, 11 Mar 2024 16:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjlvK-0006rt-Ty
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 16:07:03 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjlvJ-0001dQ-CT
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 16:07:02 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33e99b62e01so876585f8f.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 13:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710187620; x=1710792420; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=liMc0zPQ94UU6ya4DkhKE7gayAi4xjluOnBYEjTL+As=;
 b=tOQIvSTh+fshBASPDmvIFFZOgr6fNkKHmgYo5bYvLxtBE3k4fxoN7iKC2Q1m5eOB8B
 dsAWxT6tqye0tvg9kgKyPvCkCu/H6527UZqnmIUmy+ypDkjpBR25XHT43+y6Bk6pGmI4
 0gphU9S6QAB6NS+DCLYDYDBfInKXgqdwWaVSA/FHFEpr9U9Gk4E/XC8UxBRTl60KY2cb
 PkSNbmEOM89B65u4kIqtEU3ViaMssL2KS8dsCQFown73vNxJMP6Ny8W8AjEvSxPzURp0
 q5sLxsB0la2VCOP7rOeBa6nBmS6GLnwGmpE6PqtsLfyuOfqiMehHTNNA/OAae7/T3ifM
 1zZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710187620; x=1710792420;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=liMc0zPQ94UU6ya4DkhKE7gayAi4xjluOnBYEjTL+As=;
 b=eXhVAZ9YArLKi9U2TK6bVk0pYoI7TUPX+b4Eynkp/EnUhnDVO7H165dveAhijL0eu/
 hQtC8MrX6Xjy6ECMhm0Gcdsy1rMvABZRhouEtEDHF1uwYytpgZhn34LnjdUKDruMXWPk
 Lqi7e8yXC1+RSPGUHryYDWvZ1evC5ESjIPbD0As0JmvuwG+CCLvqAYFl+K5Tvy4o8HA+
 Of/b42UOJ6kL+63pJnUrjNCnbiHp1FBbc5irO9gv0GMenJ7L/g4LA7G7ukGvH8mSiFIw
 MkNkDCBJjrpPO4LESZqO2cUlMQt5XiuQdDik0cePLg9BqxAmMUMfH/XuCP2zUs+hQxT8
 nhRA==
X-Gm-Message-State: AOJu0YxMiozK58pbChrOJbMwsuB1JZ5d8CIHfsPxtNRV5fBZ8h1G8CmW
 KaFztWLqU52CHK0hHLZBG11DNuFsFjXB8pSxJKdXwtiP3AkAzjGPmMOiLGmMmdw=
X-Google-Smtp-Source: AGHT+IF73egEHfRaHwUSCEziHM9hF4j5hDeOG2Ba2XMMUeo5CYrepg8WpD35qLP53hxRHrHja4yoHg==
X-Received: by 2002:adf:e0c6:0:b0:33d:4bc3:e786 with SMTP id
 m6-20020adfe0c6000000b0033d4bc3e786mr2550wri.23.1710187619915; 
 Mon, 11 Mar 2024 13:06:59 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.167.228])
 by smtp.gmail.com with ESMTPSA id
 cl2-20020a5d5f02000000b0033e456f6e7csm641136wrb.1.2024.03.11.13.06.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 13:06:59 -0700 (PDT)
Message-ID: <0a7df4f3-f4ca-484f-8af4-f4fd08c9e8d5@linaro.org>
Date: Mon, 11 Mar 2024 21:06:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] misc ppc patches
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20240311185200.2185753-1-npiggin@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240311185200.2185753-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 11/3/24 19:51, Nicholas Piggin wrote:
> Here's a bunch of patches that have been on the list in various
> forms, but haven't made it upstream yet. I would like to get
> them merged for 9.0 if possible. The checkstop and attn ones are
> bigger but they're not so important so I could defer them.

Yes please! Series LGTM but I don't have enough PPC knowledge
to give a proper R-b, so I'll let more familiar developers.

Regards,

Phil.

