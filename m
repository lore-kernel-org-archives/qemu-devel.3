Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C382C5320E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 04:39:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sinyI-00028A-PZ; Tue, 27 Aug 2024 00:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sinyE-00027I-2r
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 00:38:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sinyC-0001ej-OD
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 00:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724733493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O9GXP6ZIrTW+mg9m1XoxzotibyWT2OTZBzzWlw/rHko=;
 b=dIMZx/eyI7jP+SD0cAXFFFnK9xcBBvopZk91BF7LChpl17E/mY8QVomv/Z9I/Nvg9PsAZ2
 px7zfovb+DqibbH6cdn5BVSWCRDe8oLKOPr/pDMwOnbGqWz1kRdgcMSTMX6QdrD1pqwp/K
 qkw6fyptdymfX86/MZC2Fm3AwUmMD68=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-i9WpUsRYNsS3UZjMoD5tGQ-1; Tue, 27 Aug 2024 00:38:11 -0400
X-MC-Unique: i9WpUsRYNsS3UZjMoD5tGQ-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-27026b76562so7760723fac.0
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 21:38:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724733490; x=1725338290;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O9GXP6ZIrTW+mg9m1XoxzotibyWT2OTZBzzWlw/rHko=;
 b=T36vzLm1bzmNAr+b1TzFk23LSXWSR/1Yl/9CXfoLxYJssUhltPfflUmoIVMa59pVBO
 Sxl0OPQZVMUV/sz/nZxLUhXDcndpYI9MH9hUZkogxNwSmIvy6ILZigh4qlc6oARsV1Sf
 gchddpg9xde07spdWI8KoLF6kd33OpmPHKEW7+KX8ZHt4wBmM1lqBexHIN3FXlrdKBjW
 cB6XXoLZbD9pBylLxbBMuH4Se83Iv29WDi2i8t8QevWDidakEbgfa+Vq5L2q0LsESsWE
 dAq6C75+lUAcMEyOq2M8s76vt3ukd+ybt9qaq9yeGj5G6kxXOGRxJqRLGaRXFtr4bkM3
 QAtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBC73nBvG/ZqmWyRDZD1TdMmO2rVKfVDYHgXO83hbD53pNzqJfSF53zwiCOY4SnPcTfA3XaY1ZEqm5@nongnu.org
X-Gm-Message-State: AOJu0Yy65C5XNuoHCycQhVpJ8DshxT5qL5ZtZa5WFL30B2CL1RUT58Vo
 amsnrH5Wg/MKyg7WoeRIwXYPMb1oxEMTXaQ/zcXMKkPknOeGFUwh/aPcHtqeTWkjfB+T4x63CBQ
 58yOxwyf594xzhvVa4IeDanOk+xjUP6m1jnuLDC0prdCrDdMLjf5d
X-Received: by 2002:a05:6870:470f:b0:270:5f17:b34 with SMTP id
 586e51a60fabf-273e64aa1e6mr14115125fac.11.1724733490534; 
 Mon, 26 Aug 2024 21:38:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/d2k4EXJJ9bRsj/6vvJtbIxqJIBnZxSSAKybHJLzNtPWJIFnoPaMkbPykNyYnoFTBxb2NhQ==
X-Received: by 2002:a05:6870:470f:b0:270:5f17:b34 with SMTP id
 586e51a60fabf-273e64aa1e6mr14115109fac.11.1724733490076; 
 Mon, 26 Aug 2024 21:38:10 -0700 (PDT)
Received: from [192.168.68.54] ([43.252.113.54])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-714400a5111sm6454436b3a.45.2024.08.26.21.38.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Aug 2024 21:38:09 -0700 (PDT)
Message-ID: <4e2a2553-9214-457e-9624-a5110217b38a@redhat.com>
Date: Tue, 27 Aug 2024 14:38:03 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2] hw/arm/sbsa-ref: Don't leak string in
 sbsa_fdt_add_gic_node()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Radoslaw Biernacki <rad@semihalf.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
References: <20240822162323.706382-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240822162323.706382-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 8/23/24 2:23 AM, Peter Maydell wrote:
> In sbsa_fdt_add_gic_node() we g_strdup_printf() two nodename
> strings, but only free one.
> 
> Since the string is actually entirely constant and we don't
> make any use of printf's format-string operations, we can
> drop the g_strdup_printf() use entirely.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> A small once-only leak, so this is 9.2 material. Spotted
> with clang leak-sanitizer.
> 
>   hw/arm/sbsa-ref.c | 15 ++++++---------
>   1 file changed, 6 insertions(+), 9 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


