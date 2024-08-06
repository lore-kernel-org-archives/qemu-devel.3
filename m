Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0172C3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 08:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbF86-0002Vn-Ci; Tue, 06 Aug 2024 04:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbF83-0002Te-1k
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 04:01:11 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbF7y-0007pH-5L
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 04:01:10 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-52ed741fe46so282758e87.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 01:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722931264; x=1723536064; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ddp8PHhm6obIoy1BIMRZil4RZ9+o1QidTk8KPlO31g4=;
 b=o/pzB9lHnXLIfo8oUQcg10/E+sI0Y7WI31dXnPxuCMqYjM7pAA+CsI5Nm3PASa1Iv7
 Y0r8ugIms5ANY//sBoDdfDxKSvvmtI8jqqtKAtAYaqIrM2wzFXAHDyth2BOw+ImH+PBO
 HY5jdQifHs00G86JEC3wu9wZWCL7VNcbgAqRWkNT6yHtRCdcr91osscclSl4cClqFTvk
 G4TKObSe8af7G8KbIYUQ9z+6Qt5WWOFhNPmwgG8I0sZuplJa31vinm4Vc/J67wmo+sV1
 7Hbi0KLIoeDJKpPRzisYkUedrx+aNE2Qv7WPlxQENIOPbypIj5MZ+68AuUcoB/a8lV3y
 7Xyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722931264; x=1723536064;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ddp8PHhm6obIoy1BIMRZil4RZ9+o1QidTk8KPlO31g4=;
 b=R1gB0sLK3Y4CTppe40yfKHQxoMOGc+N1nK5OXBC83TlXKuN1SYjBZiqXaQ6cKskwkX
 0ox/HZFhSJKr/Ec5of/FcTVgcQy4KsllawmYc0ZteB172d2gcSHgh6++BpfT1fXq+i3u
 k3qwngOx07gOtBJWI9/zYoj5TGe8ZpTP5qCH/jZJ5zxO1Gr/Cj6byfK/m3/eoVBcL67C
 UzPx03FXqLpe1vpomG0DO2/l0pMyCOa3qUeOZYVmueccyx+29WcfmbIFs1vkXLZRM2dQ
 Juy+d8uXAtAdGu+ZTueXkOmAWBmzJQwLjAAfH3F1QvO+qtKx75Bs3MAhqCRrXTaxQc4c
 zzyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSH/NH3ohLm4oaUaeyPT3T5iIFyt7rzG39guVgQbY1AkbrWpJ/34tfaVjrOihIs9y/ht/hs76PGX4hu+amcUGmdb6UdpM=
X-Gm-Message-State: AOJu0YyEKxtdzVOATp76ZPYIs+tQe12Pp+uhEyXembriudZeDUSlI/zb
 iUrAbHqVhoH9eM11L2ezJdXJuhBVKkGponrd+hh/BP+VIS+YyNpfmevbLoWSbrM=
X-Google-Smtp-Source: AGHT+IERJbS+qbO7r49XBuogRIuED7FMBd5cumPd/V0a9V5TEaY9csgATqCGBAXsQzcAtMIFLcVATw==
X-Received: by 2002:a05:6512:a90:b0:52e:9ba5:9853 with SMTP id
 2adb3069b0e04-530bb3b1a16mr8981979e87.24.1722931263215; 
 Tue, 06 Aug 2024 01:01:03 -0700 (PDT)
Received: from [192.168.69.100] (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282bb98040sm231495585e9.40.2024.08.06.01.01.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 01:01:02 -0700 (PDT)
Message-ID: <fa7cf9d5-b5df-4a4b-b3bc-9d619f9cbc77@linaro.org>
Date: Tue, 6 Aug 2024 10:01:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] docs/specs/pci-ids: Add missing devices
To: George Matsumura <gorg@gorgnet.net>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, mst@redhat.com, marcel.apfelbaum@gmail.com
References: <20240805031012.16547-2-gorg@gorgnet.net>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240805031012.16547-2-gorg@gorgnet.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x132.google.com
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

On 5/8/24 05:10, George Matsumura via wrote:
> Add the missing devices 1b36:000c (PCIe root port) and 1b36:000e
> (PCIe-to-PCI bridge).
> 
> Signed-off-by: George Matsumura <gorg@gorgnet.net>
> ---
>   docs/specs/pci-ids.rst | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


