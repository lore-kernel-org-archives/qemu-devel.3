Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F04E0C3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 07:19:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCvXA-0000a7-CU; Thu, 08 May 2025 03:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCvX8-0000ZV-Mn
 for qemu-devel@nongnu.org; Thu, 08 May 2025 03:19:06 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCvX7-0007k0-0Y
 for qemu-devel@nongnu.org; Thu, 08 May 2025 03:19:06 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22e76850b80so5115415ad.1
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 00:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746688743; x=1747293543; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OcCCPVQ0vUA6v8j9ZsygKiUaBa77Ci9amVh32eMan6A=;
 b=nGCsBLihk0vYTgEFM57OWz3L8JXC+xpregDUdn8kGUXk1TGZUah4uzkWP/vo5RrBbC
 kWmNnlzv/WuDWuOyWFezl6OzdJkmB83JpKkdCj1OtfuNi5hAYE3IMd8yAFZaE5BQ0l5Z
 c2qEgLAV8LmdM/4c3kKDu/kvTtd39VP9wUgX6Te3CVCKsbU2Mn2wVG3ePNoObwZ/ADmc
 +XOH/FZ+IYJBPMB8Gr9kMny+VfGHxQIT9L7xY8ojO9v3nuFjd35xLtvcprRCqBT8FfPC
 SDK7x887mx6cY+LB/AsjprLDpMriKtis9KOJT5LoeIL/8T33gQXowFMLFKc4w4ioi8N+
 Swzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746688743; x=1747293543;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OcCCPVQ0vUA6v8j9ZsygKiUaBa77Ci9amVh32eMan6A=;
 b=jCzq8+ehvjkQeeYsTams7BCIc5OaFx7SjOzz75LADh5wqWX/6XXSCd0zcgB19BdtDS
 WdcdzL/zNaDC/JfW9pFom1cGH7oQTkMLRAwB5gfdF/gNBnnqCsd5CAs5kB3flNi2s+n8
 8XlBpJX7hzQfDE3JuQas8l4ThDVMneGLwV4hj53stp8X1jPWpzDh2KJ89u6HpdfCtRHN
 WOLdx4HD0kQtTtz6enODmM7r5wxBk91Pt7g3xEr4JMuz1iNk0UeXihE3qoz7piIcMbIA
 XMbWYtA5tBd9BvRlEg7+DdmHCrOdjRWWzKUVTZxbTVw8p7QkR7QDH8E45Rgw/XQMklX9
 mlow==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxRhxfhDPofz69RYIlswTK+D5J2/dyEtb9PsUcAE2wHgX38LJ6FWxET6bVGNEuGf/sJeFwjt0qopfu@nongnu.org
X-Gm-Message-State: AOJu0YxI9EOmakO7Czs6/xWXRlXwxt0xVmkTgDgARoaPQxflLesM4wTf
 2btFI+0xNkMPj+5cWYQZWh2rqWBQGW1jRtGYqHbIZXIw1QOsC3UWcSwu5XgAfLk=
X-Gm-Gg: ASbGncsdXCpeazQQk4lT2QAJQKxPUpVYXntx3Hz9gmduu1LBlTL4IzYvBPXOm2Ifuys
 ofIIaofudTZ+ZkXSKt/h3qpBjzLUGJ5LOTVhwlV6S27CaNskQ2Xe2s58gvWxh12WXa0ZXcozh1o
 m9Muhr1ycC4Nhd0/+jMWEdL0cdqUFO8LHu3EG6yUT686kEuyok2HJeSRgBxDh13tDigoWsacVfS
 V5+lxcUYnKHTfUwMeEhOo+dEDbhenb1p6kKr/j2CwpUCrGNn8TTUesfhNSnqabY5WcQlZMfCpU+
 iSUkCuIns/JRW6cbFynqTW+0vgP2t5e/fTpiTHSRjtQJajUmbaKb8BXqVJcLpN8NmhtVCll1QCk
 vhzGjhVb6R7hnxucNcH4=
X-Google-Smtp-Source: AGHT+IGl7oOlVPS9kmPkDO6fa/BpIb/oFg7my0ijyvXtDc2SLjxV8NbvmOyT0B5zU9vRUWw0C87jdg==
X-Received: by 2002:a17:902:cf0c:b0:223:6657:5003 with SMTP id
 d9443c01a7336-22e865f753amr35220445ad.32.1746688743341; 
 Thu, 08 May 2025 00:19:03 -0700 (PDT)
Received: from [192.168.69.243] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522fa21sm105593605ad.238.2025.05.08.00.18.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 00:19:02 -0700 (PDT)
Message-ID: <15908e2f-544d-4f14-ba9a-8058bfb7d46b@linaro.org>
Date: Thu, 8 May 2025 09:18:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ppc/spapr: remove deprecated machine pseries-3.0
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: npiggin@gmail.com, danielhb413@gmail.com, clg@kaod.org
References: <20250507052048.90559-1-harshpb@linux.ibm.com>
 <20250507052048.90559-2-harshpb@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250507052048.90559-2-harshpb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x62c.google.com
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

Hi Harsh,

On 7/5/25 07:20, Harsh Prateek Bora wrote:
> pseries-3.0 had been deprecated and due for removal now as per policy.
> Also remove legacy irq support which existed for pre pseries-3.1 machines.

"Also" suggests this patch could be split in 2 distinct changes,
easier to review / bisect / backport.

> 
> Suggested-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>   include/hw/ppc/spapr.h     |  1 -
>   include/hw/ppc/spapr_irq.h |  1 -
>   hw/ppc/spapr.c             | 27 +--------------------------
>   hw/ppc/spapr_events.c      |  8 --------
>   hw/ppc/spapr_irq.c         | 16 +---------------
>   hw/ppc/spapr_pci.c         | 32 ++++----------------------------
>   hw/ppc/spapr_vio.c         |  9 ---------
>   7 files changed, 6 insertions(+), 88 deletions(-)


