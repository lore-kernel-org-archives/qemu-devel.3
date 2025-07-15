Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA24AC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubcDZ-00055k-9G; Tue, 15 Jul 2025 05:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubcDX-0004wz-8N
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:44:55 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubcDV-0001yY-7V
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:44:54 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-451d6ade159so37651905e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 02:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752572691; x=1753177491; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aot4+u9RJ7G5jt+NRvKicHl331+pWGgdDV/FQfND0wQ=;
 b=hZAq+XODzGVaQhYvOqP51pmaUQPnRqyGCCxGFVPlJMDsA57nnfGXBW97KDQC0FBDlf
 Q+opRDa47dsclwio8sSWFpQC/nR/2bJUhkOYw6byQSZ3fwAm9GKBi8IZP9WOlUaOkhCM
 mTeTLfdpTx+3bpuaFeTmYTrf0W5vbSn2OQR5bvc8BeZSQfnbEuID3+jN7yqezUZdO16U
 sXuI9mxvvYNZBtWoj1cTlDR6BDk0taKCT9AT64k5wxMj03BCDJZuqMukXjaM6upcl7kS
 BBPTX58oqNQ1V+Y72szK0MJHOx69l42qtudeeCSczbRTde7puoPYULUNONMoBMXsW4Zv
 5v/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752572691; x=1753177491;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aot4+u9RJ7G5jt+NRvKicHl331+pWGgdDV/FQfND0wQ=;
 b=vqXUktNH5X8D07VBaRQKxgfAbC61tqW1K2N9cDI6m5DEy+gLaX5CWJ5JxBEbkKoNpY
 2WrpsmKE7Lt3567g2QgB3C/3IO83yjhGjXHaOg8WhqeYUPBQxbm5M0E5TJkNzDwI7Qoq
 L09lmrGHhj51faFtMr4IdrmGficEW7fLeOB38YhwOBy1d+i7Dl54SSsy6t0RRKXk9uQO
 QyjnHTvhpjxnVe2yGL93iXNs+/9fuz3q9X6X5dncJo7Xoo8QtgeNhZpsFc6S6U4ZUyIv
 kpr5HnU1Z+99T0gkhB8PLZpdNARCGgwcvV+V5g/6j2mpqYAxRLini9pD+KT+zP0kmkaW
 B8Lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeTvVuWJRHLHetIawFjLJmb9asbc/a9k/DleUQKCLizADA2/JaO/RgtXV0voI0A1ws/fk3jx/cqmpm@nongnu.org
X-Gm-Message-State: AOJu0YzecJlFoj/eAqS8i1v3FT0eiynAbCrrqE6mra2moVXWAjfM7CnW
 FEv3rx5HNs0T4YjKy2Lxw3SvyZh5VZ6AI1klVZ7iYAtc6gmDsVaNcV7nbSfdVqOpNdM=
X-Gm-Gg: ASbGncuPWEE5f+YuX7BTz7JnblfjwuONiVyr8JYQP4G1KGJm4NTveVSnZhJPLIrVtLv
 Mmyl1Ay5CtLvsBHjSCvqs5nZgpAyeNN4ChWykA8Jo7WaYPSz9eblZP505DXfc49hvn5g9vdwm6H
 dJlsfrchD7Ki2SrY6t6lwXjKvW4mcBgiCbZPgEvOo840V8jztCUKfslBz1N7qD+cbNnC2p2Nmvn
 7esk/EqQzckFybBrWCDbHWBLEB6/c+f+v7OG4g0b5VRcB9Wp0jafF/32fNk3p+VxAtJXY7NIElW
 mgjB/kaltpLI9qzhv1fuhb049F05J4Jsq0P33DzZlWGWUzVkGnLngFxw4cC7WUlgXkgzUIXciKl
 s9OdnJGc1xvASu3ToK5BJtqKwu9boyC04bDvxQhiQuZHvBeNkvbxxWzuwOkA29d4ykZEldyp/WH
 IGeWAVxA==
X-Google-Smtp-Source: AGHT+IHGsDMEBCHWt8LGUJhyB7mipFuTgSO0zYQeBWntjtV59rjm6/7UW1LlIi3f0Ds8z4EM9IDURA==
X-Received: by 2002:a05:600c:6290:b0:456:1f89:2483 with SMTP id
 5b1f17b1804b1-4561f892ed3mr45179715e9.26.1752572691396; 
 Tue, 15 Jul 2025 02:44:51 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4560f22cd14sm86684675e9.30.2025.07.15.02.44.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 02:44:50 -0700 (PDT)
Message-ID: <fa255125-b989-4c52-9596-db22aaa3ebc8@linaro.org>
Date: Tue, 15 Jul 2025 11:44:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/22] vfio/pci.h: rename VFIOPCIDevice pdev field to
 parent_obj
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, npiggin@gmail.com,
 danielhb413@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, clg@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
 <20250715093110.107317-23-mark.caveayland@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250715093110.107317-23-mark.caveayland@nutanix.com>
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

On 15/7/25 11:26, Mark Cave-Ayland wrote:
> Now that nothing accesses the pdev field directly, rename pdev to
> parent_obj as per our current coding guidelines.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/vfio/cpr.c | 4 ++--
>   hw/vfio/pci.c | 4 ++--
>   hw/vfio/pci.h | 2 +-
>   3 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


