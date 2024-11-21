Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CAECD75BDC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 09:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE3Mb-0007z2-M4; Thu, 21 Nov 2024 04:20:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tE3MZ-0007mS-1B
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 04:20:35 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tE3MW-0006n5-2v
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 04:20:34 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-382442b7d9aso565195f8f.1
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 01:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732180830; x=1732785630; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NmHsWm9SOe/1O/0yZC1JhpX3Qt4NwD71m8LNeqKOBDU=;
 b=pWqJA/E4jibwfuhylC0d4RUBahW9dt4qs7rTfGw8hsmHoJql8I5cNBa6SCjQQDGxcv
 Bl+venqzalG+NvOhjKfgKq/YUHoIXgbA3CC/zn9t35FL7kFKuACAuNccn4IaFyzrwYX1
 peRWlfRqX/XLOwQOTxT1o9HG0MJmVOQlCAVrTqFo3rhmeuMAzhJGEbmPoCnrEyEiPuLC
 apalfcdPVTNMLXSawJmeNUYv514dAmPfZKB6BbIs9Av0GHsO9rBgeTiStqryW55cMSBx
 zALNJQ/6pSLXwcAavspXjlsUaU7DhVmG9xkbDXVtTMut3MOv32bUKe3HQvQb2I1b2M8X
 JeYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732180830; x=1732785630;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NmHsWm9SOe/1O/0yZC1JhpX3Qt4NwD71m8LNeqKOBDU=;
 b=ue7HY6dYfCrbw6looLm8IdmFjvvQwA8jzYjkpw8VMxRa0Eq39M8h3zw++HDdFTfeq6
 bzyZOPbu6ih263LWQxVwDlZ7hc3mwydwEhqz3GsjottIz+hWXe3ir0md7kLx5xpQ5tdB
 zKEIcxSz4Og8KDqflnekbQsnNd4kpGQW/PyeCdEX6+PLVONTrGLplNTDcghurzH5sWO7
 pYRpwnaY5Jo4vpKTw2ZtYYYU9ltDP5EEEKvX6OP2E3X0odCWkjD1CVlya5j52tDVBXBV
 cAwEgC3sNoraLo0m46a0cgr1+98zWBpjVHJ5Cq66CF2+a8QPY5fiX33iVZyXRFEtSmb1
 sHqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6bkdkG/9MSg8Ppv+xfdViyauhOyLe+ZT7D68sFuxFb8iAycdThwoTrM1pv8zu9YDxHicKJKoULqjB@nongnu.org
X-Gm-Message-State: AOJu0YzqV+k1GAcRqwOnJeok6kurn1Dlh7u8nDtsfFVeVn9Z5ddQ9/Em
 vI0A5gHKY//ccEknodlJGqbo4p0iVG386Jpa8QbanYbodaJ8avCHdn5mQgXOSrU=
X-Gm-Gg: ASbGncsYbAwis+cAEJ5MxiHV0T1KBtZnmJ1iG1RByLHZS3MvNz8pu3M4r/71uitI+iV
 OQjvbGS2YBSnYH+3RkLqCHfx7t318RcIKx6/lbZsvS1Lnzfhd0dD1xy6cRci+XiG5roU5xH/DVA
 jSwfBmTCIhoTijmacWrcy0xkT49hqJTDd/l9ivL3bRVDbvcRgqQNWNEiDviH+vbVxSp9XX3wILQ
 zk8Dj+aiGmqpxZ6kBtEInizYVaZtBlKvyc1RC7+8BWpAQeNCU6SdktgV2CeJpFzA8Upmg==
X-Google-Smtp-Source: AGHT+IEpPIaN6vQJvl7E9jePpekFpNVOSwFrtk23cL0e+fysA16E6Twp4SmMdC81IJYXBfO/bCTjNg==
X-Received: by 2002:a5d:64eb:0:b0:382:356a:c927 with SMTP id
 ffacd0b85a97d-38254addfc3mr4315503f8f.9.1732180830563; 
 Thu, 21 Nov 2024 01:20:30 -0800 (PST)
Received: from [192.168.69.146] ([176.187.204.90])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38254910e77sm4308506f8f.59.2024.11.21.01.20.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 01:20:30 -0800 (PST)
Message-ID: <5eaea573-bcf1-4825-b165-cd72eddd32df@linaro.org>
Date: Thu, 21 Nov 2024 10:20:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] qom: Add TYPE_CONTAINER macro
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20241120215703.3918445-1-peterx@redhat.com>
 <20241120215703.3918445-2-peterx@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241120215703.3918445-2-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 20/11/24 22:56, Peter Xu wrote:
> Provide a macro for the container type across QEMU source tree, rather than
> hard code it every time.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   include/qom/object.h | 1 +
>   hw/arm/stellaris.c   | 2 +-
>   qom/container.c      | 4 ++--
>   qom/object.c         | 4 ++--
>   4 files changed, 6 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


