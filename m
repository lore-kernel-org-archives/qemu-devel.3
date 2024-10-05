Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB6C7CF8869
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 06:14:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swy3G-000125-Iy; Sat, 05 Oct 2024 02:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1swy3E-00010B-Fb
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 02:14:00 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1swy3C-000189-Sd
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 02:14:00 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2e075ceebdaso2117320a91.2
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 23:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728108837; x=1728713637;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ml/Y5ZbDQDb5nr8Y5unr89/ApO1UKPdv9ntCYuNI/hg=;
 b=bWyy95NYHJNI49E1ENdW0iohqYTdpv1Eim1Zl29KDjPnh1YdKzfGRY4YuEB1c7pPuS
 CSA6O9wPu4tIuE8EsVZTHi25Jp4WnynFHGnlKgBwHByV8zGa/NiK/Q8GmM5hFftBNAtN
 huU/IheRt+gmVBVgIoOaWDJgqqFq3n4yjmY+eWTuOrN8ybXSYYNPj+oWQxP1+Rd5DlhY
 rvSzNJvW/30cCDWHl2Aw9WzfEqBv8RmcPRN1C9UNEEWQd/y/U1LBfIme4xOjpsagfCY3
 nWmvqR7YNw8dLSX1vd4FszSfw5h0ZobzE+4v1oM07r8R8Fdur8mVst/RCqvnrCV2hGL2
 KDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728108837; x=1728713637;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ml/Y5ZbDQDb5nr8Y5unr89/ApO1UKPdv9ntCYuNI/hg=;
 b=QN3dxnuA2ES46NSXQeKQ8rg9YBsZjiKA3vFQ0FcnCTaiaZiFR77WMibGMoqsWu/5CR
 +ZXBvgsWlzIK40Ko5MSRPcTQl6uz19WfV2EKc+SosKWoJNTTZXltYzDmzO3/pZNUa5no
 xF6aNAPeF+1o0kf/6mArd4FPPRE/MVas/2H5l7qvviATSSLMHvvXHTgaLWlwxETjgcsO
 CsdLx40qLjndROV+oUJtNEmEC0tHrLLv2zQ2kX3g+/2i0HZbjRho3LAIA1qpu6A96b1N
 ew9A4bhq7skjrys3gf/ZKykM3gMyuTApkk1UXBi3kwg7DLPVoXG0WC9dNnbiOp+ShQ7G
 WEOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfHFlofQy8pRu9mkGsbMp8wvRbki4NdPG3S0GdZQ39A9EoYfLgatC/ZHkLuhRy3WU+51CWDk9883J7@nongnu.org
X-Gm-Message-State: AOJu0YzyAp8OFvMTBXX2j1q1v2Yc0Xjf3FwYaHQIJbwEEdzMCt1XVJhP
 pK5utCqq+ihf7oybCtrn0fm9MHSXz32Nhg8AzVcrIYQt81rynT4Rtgp8Xldp4uM=
X-Google-Smtp-Source: AGHT+IEDruv77bILIaPD0GPoqkKIs7whNghi37lJkXODs6OkFU1dsPEaU5odLiWkO74R1qjk5S0h+g==
X-Received: by 2002:a17:90b:4a45:b0:2e0:921a:3383 with SMTP id
 98e67ed59e1d1-2e1e620f326mr6090398a91.1.1728108836957; 
 Fri, 04 Oct 2024 23:13:56 -0700 (PDT)
Received: from [157.82.202.230] ([157.82.202.230])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c138d0b2fsm7461475ad.112.2024.10.04.23.13.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2024 23:13:56 -0700 (PDT)
Message-ID: <5db6c12a-0a39-4869-9ba5-8b9a37080c62@daynix.com>
Date: Sat, 5 Oct 2024 15:13:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/14] hw/misc/pvpanic: Add MMIO interface
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: agraf@csgraf.de, peter.maydell@linaro.org, pbonzini@redhat.com,
 rad@semihalf.com, quic_llindhol@quicinc.com, marcin.juszkiewicz@linaro.org,
 stefanha@redhat.com, mst@redhat.com, slp@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 Alexander Graf <graf@amazon.com>
References: <20240928085727.56883-1-phil@philjordan.eu>
 <20240928085727.56883-8-phil@philjordan.eu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240928085727.56883-8-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1030;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

On 2024/09/28 17:57, Phil Dennis-Jordan wrote:
> From: Alexander Graf <graf@amazon.com>
> 
> In addition to the ISA and PCI variants of pvpanic, let's add an MMIO
> platform device that we can use in embedded arm environments.
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

