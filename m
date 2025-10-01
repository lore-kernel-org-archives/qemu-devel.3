Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1221DCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3zB3-0000rr-25; Wed, 01 Oct 2025 11:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3zAs-0000j2-Lx
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:55:29 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3zAi-0001P8-R2
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:55:25 -0400
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-4db0b56f6e7so10980571cf.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 08:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759334105; x=1759938905; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OzVyIAQXdnJVnqSVT46kULVkxeryeNWBVK5cofXrOYM=;
 b=fngEDIL63bNvBhmSTsCNFiracHenzrGNMJ6vWsMIZreFvIjTMFod04pQ0Hz6zHTWzv
 dtshOQzOnz1xQbGbmEqf1lZ9j+nn5S8CVuhkUalMR3jG4HWyC0nJ7ygk9eGMPXp3SduQ
 YgiGM2Qf4irFbbG/06eTZ9jo5Kz6fIFrvk2P0ctD/cyFFy1Vh+yW0hbVAW+a3ieL8PBP
 SWJd/Zjzr7h/DclO4XnNpL1QnvoYHXLw/+xfXzG7nWl60tB8xps4GBDLThE4ikSjhQBs
 iueFcgX8Ki3+pfzyI8O/2l7b93IvrPAqExGZHNgIzHCdO0sIdTyQRoIvIBk8CZ1zyokC
 p0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759334105; x=1759938905;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OzVyIAQXdnJVnqSVT46kULVkxeryeNWBVK5cofXrOYM=;
 b=iSCtLbM6AAHnRBvPcH5BVw2YLmhXx/O+KI8x/l2Y0xzPst3WInu+/YouJEdvxVUpoj
 IlEddv8y2M7m3uA8q8RVc01CrIVKL9hqrnlITbN/Sme4zO1dOw8kAXQE95ur6mnBjhk+
 lpzrN6efKPpCpifwjXBHj26FqlJDNcYNGBocDW68ENuYDBdGWITEFM2QSkbqkiD1U1EU
 rKxTyMmCtdED+IFFPXkOSWLp3PY9UXg8IEAav7n3e/mwPey7GJtVv16I1Wcr8gXDZdyL
 nMdEdOIG4L/wOPoHeFiz3DGXZsK1/ZPGi46jy8j01PCUxSNxhNRdLnVaGYAcaa+Lmlnb
 dwpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpZ4LGQxOa859CgvjdO9XDqfdDT7MUOrdJt55Qo8IaPxrcDqdo3wOAtfxl7bx8vumGebUsrYQ9fmkE@nongnu.org
X-Gm-Message-State: AOJu0Yyqs4aOC3vaqN7cK36lwl3oio8opijPGASwEJ2RfWRFiJLLoq2R
 0StbkD0aRrq3qUbYlf0eOazzChoFjsFaq/4622rLUsqX9GJhDVPA9pRQu7/UHo+Nxbc=
X-Gm-Gg: ASbGncuk4YQcdJxbdm0qeZX18200ZoA6XbwQftkqkajjTmeEYI/B5z+Q4WJCYEN039P
 3YDgeM8KaQbSo3x43LxVjcIgiVN3cregrONpe/pUGkTxGKDEh0NYLiG7fK0ZdJ27A3hdK/l+4Us
 Vq0IGfEr8jCHvaZSzkEQ5fhosLQMOURpbOIajQvhBEZt65tvokJxNo8BMvKCJsszW4ov9kBmN9B
 cuu2HiWFfjCYRHDRhOVtmGKFdjg45utihFQBeJBh/TKiOLxpS9g0Dii8kGRu04nJ09dbUMgobIj
 gJ8+CwRRshGUt8wt3okHiBiS2mpdW7P/jxXWGnkn4amPc/wWxtDJkOP/rvOfdeFT73Rs0ctmehX
 zhD42Fp6GGKUzViy4XPChJgWGdtsmIpdx5a+9Hnlg1V6s6Wp52hUUFuakAGqH4AHVAL+2PK0/D6
 NDZpr2ugT8tupa6rInHA1Y26Gz8sgBv9g=
X-Google-Smtp-Source: AGHT+IHnMMdNy4MYzt2m0ymYO7nA7fm3jvALZw8rHP3Y1OX9v6an9L6WvAyYLOfYR42+X4IitIoQUg==
X-Received: by 2002:a05:622a:288:b0:4b2:8ac4:f097 with SMTP id
 d75a77b69052e-4e56385cc7fmr829341cf.33.1759334105139; 
 Wed, 01 Oct 2025 08:55:05 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345?
 ([2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bbb1d86csm319796d6.29.2025.10.01.08.55.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 08:55:04 -0700 (PDT)
Message-ID: <f0ef8fe7-5642-4c49-b796-2d7644612e22@linaro.org>
Date: Wed, 1 Oct 2025 08:55:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/25] system/physmem: Extract API out of
 'system/ram_addr.h' header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20251001082127.65741-1-philmd@linaro.org>
 <20251001082127.65741-26-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251001082127.65741-26-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/1/25 01:21, Philippe Mathieu-Daudé wrote:
> Very few files use the Physical Memory API. Declare its
> methods in their own header: "system/physmem.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   MAINTAINERS                 |  1 +
>   include/system/physmem.h    | 56 +++++++++++++++++++++++++++++++++++++
>   include/system/ram_addr.h   | 42 ----------------------------
>   accel/kvm/kvm-all.c         |  2 +-
>   accel/tcg/cputlb.c          |  1 +
>   hw/vfio/container-legacy.c  |  2 +-
>   hw/vfio/container.c         |  1 +
>   hw/vfio/listener.c          |  1 -
>   migration/ram.c             |  1 +
>   system/memory.c             |  1 +
>   system/physmem.c            |  1 +
>   target/arm/tcg/mte_helper.c |  2 +-
>   12 files changed, 65 insertions(+), 46 deletions(-)
>   create mode 100644 include/system/physmem.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

