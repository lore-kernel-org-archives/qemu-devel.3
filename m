Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05283C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 09:00:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXzFw-00021Q-6n; Wed, 15 Jan 2025 04:00:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXzFk-0001zi-Pd
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 03:59:57 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXzFj-00014F-BO
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 03:59:56 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-385e0e224cbso3291636f8f.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 00:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736931593; x=1737536393; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jFDPWfTCQ1p5T8t5XmrdYui1nUYwl0mTr00Jt3GPdC4=;
 b=tDbfcPOU16hXg2SnsqYsLsmhotbjc84o4mvlfCiA+YFLOQ8WM8rbw/SPjRG4gfqJ4l
 efr/IVOA+olCUGvnrBAjh1zYloXPFC6Z6sYXWuhuMEHav8mm0k5wxJVBSDH4MtheLnt3
 dDCWcLS2+NgsMSZI8aXrtju++tQVfCn6UGbCGPzhqkf/sjkn5fUqmzWG1VkfgA0fZZyp
 yFGtCcgJWcaOte9ZVQzaZMY3bxLwAwqSDF9QLkUfVyBnxx+9UhI+BsHuGApBLmpruXD5
 PyjRwU1/VjDu7Ynn/DYj4brl1kWJUIwoZFrjC3oLqaauqOjA2o8lVczNmUZF/m+ClyzI
 6+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736931593; x=1737536393;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jFDPWfTCQ1p5T8t5XmrdYui1nUYwl0mTr00Jt3GPdC4=;
 b=Y+e49wcCQ/A5AJV23LnmDUha9m2Uk31aVMo2mau2ilqpY1XUjilP5FMJiNNaseVI0R
 8ilNFB/lMCrNl9eGZkK19kjH3Vmq1xpzoO0FHHMlnbTu3nfl2vnrp18UW+AB0i+dp+JB
 slV73h5wr8P13ilBtR795JyUmGmATmhVXri6HVKzndo5nGps8/qeYD6aVQu0ZufBcAnv
 /GVmAYPXtuEp0aH4VIqpNpR7fZyS7YCsRxnwRMWnnFU2YGArVNfzkIZtSQvWY7rb1moz
 br1rytTJzYehVtqysTMS0jj4TjbLDty0HtXGRgFF6iu2cx8Ch/gt+6O/7y6x9NHHNQWe
 jvxA==
X-Gm-Message-State: AOJu0YwS0nDXfOg17dfzUKnFx64jwjc1WWIodI+PCTBn/2TH0HDJEJk3
 kJrKdjgDwk5jsrozFcAfPlyidT4lls2CWocwI9p7Dd+NeSduLuqIFPKxAwnLek8=
X-Gm-Gg: ASbGnctoDA6/MX/y7XaTzVUAA5dbIZR3mA6FfYVbX8MEQ3REJqGHHwDVqFaGxNWO4ar
 ouacgf58aPutxR5V22o9AMD9FvSP1Nz2NuEug/oGWAABGXdmSr13dCQgFPz0GB5/2OxIvX0UpA+
 XuaiCK4mWrt6g3sAAi7vAY0v8XPnv/To9kpsMI0iIkY4g+8BXotHMZUXQeTo6ahRTfuQJCtHJXR
 Gf+AIT1JExKyGrUljT6N/HCIl4fW056RgEVOqGCyFXY4M1yo3XpvVOrnmL/DCgSEiMu0F1O/cEd
 vm3XxSZxLkZmuo6zFQFnb1Fb
X-Google-Smtp-Source: AGHT+IE3e+kcoFyiPSMzO4c0+MN+ua7w+ChrzqVliD41xTqI3shl1uV/PONpJTIMRgmrXJgzIwZ/1Q==
X-Received: by 2002:a05:6000:470f:b0:385:f092:e1a with SMTP id
 ffacd0b85a97d-38a872cb24fmr20175267f8f.11.1736931593441; 
 Wed, 15 Jan 2025 00:59:53 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c749935fsm16078985e9.3.2025.01.15.00.59.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 00:59:52 -0800 (PST)
Message-ID: <e604495a-a6cc-4477-a9e9-3be1474a84c1@linaro.org>
Date: Wed, 15 Jan 2025 09:59:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] hw/s390x/s390-stattrib: Remove the old
 migration_enabled flag
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20250115073819.15452-1-thuth@redhat.com>
 <20250115073819.15452-4-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250115073819.15452-4-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 15/1/25 08:38, Thomas Huth wrote:
> Now that the machine types that set the migration_enabled flag to
> false are gone, we can remove it and the related code.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   include/hw/s390x/storage-attributes.h | 1 -
>   hw/s390x/s390-stattrib-kvm.c          | 2 +-
>   hw/s390x/s390-stattrib.c              | 7 +------
>   3 files changed, 2 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


