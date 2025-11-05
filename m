Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B2C4CCFA0D
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 13:47:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGdqZ-0006GK-JF; Wed, 05 Nov 2025 08:46:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vGdqW-0006Ah-8k
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 08:46:44 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vGdqU-0003N8-FK
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 08:46:44 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b70fb7b531cso543979266b.2
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 05:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762350400; x=1762955200; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rGsKN+q9CeP2ytSVjJhUPhfEzEadWHIXhtZJUJYtF+k=;
 b=t7wQn3O6dJXoSSaC6TBxjtsUxPRbAvpFQaOgbD/cpfbS7Fjej5Gj4jjVZRTYVHEN11
 dBXYydra73if124O0hd/87udmq+PuZGrtloKcFTkIozTf+t/r83UNhTFCDI0m1g1uN3/
 tu4u506DQo29OylVHSb79CQW3DBYYAppJYGLWfsU2UhMAhu09U4hEVFSlt6R2gvYRjEE
 jBNDldHZd2iVMEfyWzl/7Tdtf4Jgvzb/NxTUvZQeyOM8UBPo89fx9NwLd2eC6Gkd3Vyr
 ML0xmfXt19sC7wxNb4/dc34H2OMUZi8pX6ByYJG57nspHiG0Id+ZtXtGAc3CWvRWCSo9
 T6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762350400; x=1762955200;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rGsKN+q9CeP2ytSVjJhUPhfEzEadWHIXhtZJUJYtF+k=;
 b=Siq2eFrn3IblSuPkVyNg2muSXQ3VomJ4X03P4hmN+d5DvVtfvbtdXdeZ+/5up+vAiX
 uz73q6izeHs4Pnallxkxag7vM39Gp4ZG3L7DFDKQyRQOyctG8sNCsUyLIHk4PIVogW6Z
 m0gkytlU2c78mVfol4XAklmy9ndnJcO1jilJg/7BlF1cYH0yKPQyVhOH4GZMyuxtlO8I
 FBCiQUSh4kF2eWg6wDcIpN1eo4oCAjbjdtiQH3xU2ZNtQ2HEV8GH3iMhRKsBgR9DYqKd
 fEt8SYQYD4lWkTFmzKp5sFPO2DcbuNXrF3AOutsmFN4zm/9hXH+B4M4hAuF2wL7JAOqN
 2rWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTYl9sz+zsvimw9qP8moTtLqY8mu9LeJT3rdlK6lhBAlZrUSi+WNMCa5gkOTqpPxMR5b2Wm1gXwhh9@nongnu.org
X-Gm-Message-State: AOJu0Yxk9DP/XJAJZiR1ACCaLdL5IedNHzJfx/4IXZiAOuOPrQ7bUorI
 y295ZiTpEMv9N/eIw4nCadFAdGlqk1UgL4hKCDcvOcCB3ceKDamupp43BoDlmPl8Wb8=
X-Gm-Gg: ASbGncs4Dg4+6rhDAo5jqC1uFBWJNIMGv6U8/sYDOv8gZQn7X43jW0E3ET4U9jL1YZ6
 4nmOufpmdmUjuH+6gLS631UmcixoEGCuKx9V+aUnU2qo0rfRBOYieUB1QpZWV8Uet+MJkQSCD4U
 mJqvodBPoL8O+vdUXBa/+xXoseeXiG8itaFKp95GR9Bc4ipUNoW8c3VorGiYD7tdgYNO/szHDj/
 +lQ0Ba7YSwltrSaextBoAeanvgSp/6MY0BvGFVXNgM0QrYbSOLdB23CWuqjuNJYggE6DtoP/dto
 uSRba1Tuu1IH7H7GDDzPG31Ayw1sVX+l2Ye8ioi917l7fKE+ZFSaNWqRFA57FRsyep8fGHiuQS0
 0WqoZbjvUjNMGdx8SnzujjytIZ0oJ9SzwnI/fUHovuykRH/MqcYXe81w0QGNB4WnuJa99Jf4v5P
 zvNHPqd2jCvcEiQRMg+aACs7euiPc=
X-Google-Smtp-Source: AGHT+IGKgfj7DV/BgqOsqXI5eIJDrUl+wQ4S0TchzvtSiUj3BT0E7it7eurxCUcI7O7HoQWmSoN3bw==
X-Received: by 2002:a17:907:1c84:b0:b04:830f:822d with SMTP id
 a640c23a62f3a-b7265648907mr336318866b.63.1762350400273; 
 Wed, 05 Nov 2025 05:46:40 -0800 (PST)
Received: from [172.20.148.100] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b724064d25csm487978266b.72.2025.11.05.05.46.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Nov 2025 05:46:39 -0800 (PST)
Message-ID: <ee1bb8e2-135a-4166-892f-bc81fa54315f@linaro.org>
Date: Wed, 5 Nov 2025 14:46:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 0/3] I82596 fixes patches
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Jason Wang <jasowang@redhat.com>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
References: <20251104152204.6261-1-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251104152204.6261-1-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x631.google.com
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

On 11/4/25 16:22, deller@kernel.org wrote:
> From: Helge Deller<deller@gmx.de>
> 
> The following changes since commit a8e63c013016f9ff981689189c5b063551d04559:
> 
>    Merge tag 'igvm-20251103--pull-request' ofhttps://gitlab.com/kraxel/qemu into staging (2025-11-03 10:21:01 +0100)
> 
> are available in the Git repository at:
> 
>    https://github.com/hdeller/qemu-hppa.git tags/i82596-fixes-pull-request
> 
> for you to fetch changes up to fec69f17be25db71f9cd4001b920da21cc71b283:
> 
>    i82596: Implement enhanced TX/RX with packet queuing and filtering (2025-11-04 16:14:51 +0100)
> 
> ----------------------------------------------------------------
> LASI i82596 network driver fixes
> 
> As part of the Google Summer of Code 2025 program "Implementing LASI Network
> Card and NCR 710 SCSI Controller Device Models" Soumyajyotii Ssarkar fixed
> various bugs and enhanced the existing Qemu i82596 network card implementation.
> 
> Specifically he added or fixed the following functionality:
> - Monitor Mode
> - Promiscuous Mode
> - Support for linear mode, segmented mode, and flexible memory models
> - RX Timer
> - Bus Throttle Timers
> - Support for Little Endian mode
> - Accurate CU and RU transition State
> - HP-UX Specific Behavior Support
>      - Support for Loopback mode
>      - Self test
> - Statistical counters
> - VMstate descriptors
> - Polling mechanism
> - Transmit and Receive functions


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

