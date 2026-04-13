Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E42E9380F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 02:55:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wC7Rq-00086G-KG; Sun, 12 Apr 2026 22:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wC7Rp-00085h-Fc
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 22:54:49 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wC7Ro-0006J7-1y
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 22:54:49 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c70fb6aa323so1374876a12.3
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 19:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776048886; x=1776653686; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4qQhs7WN5alTmwzimUY/uITGqs+KMD+QkfagNZ5IPKk=;
 b=sZIQD8/UGzBX2RauLRfaWcER8zR0WtK47D1xm9ppulyFq2PjJIbdvEAr+RWfvJtVuS
 FAioT/+PPM1YmxYv5CqF47w3yzDjgHYrdiFNjU2mTctyTUrbC6c6rzhtaypFzjKV4Tao
 K2XSXboPREEsPEjb4GDuxmWVlWv+4+VgCoBbOzp2OjFh4x36aA728Tw8UxEBXJeEm44p
 ZZJXLZyhw45MneYBopNR1A8bAxT1skKxXFaMqu/2B8UFVLuuIujJw3Ub7ONSaWBuiFaU
 0DOHDJttQ88xkEyy1mVMgeDbrzvCrpogYn5+KAGfuY1+SuPMyq/gOK+J3CZ/OZt04Mbj
 i3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776048886; x=1776653686;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4qQhs7WN5alTmwzimUY/uITGqs+KMD+QkfagNZ5IPKk=;
 b=V4AinQyv7T2qRPsmO4xro4QYPyo2T/4ezD5KTnAXWQ2lHVgkxMVfNVgJqAYhBGFz9D
 OlOxVNs/AXzGDbadbFEwtR6WSjTxavc77gfsWBQlIBo5juwbItx1AHr5BsQMfnRzbtsB
 XsuMx0oDih6Fe2EMV5K2vJ+fraCHSMP7Lg0FapPafUzH1N6imKkI2oq7XXXhD6TNrBzR
 hJBZvsYzWimy0bJAxNAspMmeXKfaVY3tuvzTqWkVQsI3pikWkGhcLV4nGk4pNGTakSQj
 vTOUCdwPY06vL+RwndOLFCcqX0u3eJsMZs3vBi7ItMehjidJpSLAeCTpwtvfr1N+UM/j
 MFmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnpo9wqy9uAfHT5ubpVoPmiODD+qjoC+MpcVbfMqUkhwUFhB2xqDmW/La160+Udsg+OElaCPQdvzYL@nongnu.org
X-Gm-Message-State: AOJu0YwOf0h0lav9HNO1kNlMIz3HG4KDKwkfD2nfFzIKhkL0okdbRCEf
 312yeblNi24/WVstZhn5Vw+Q/ebdRnvO2EJs7KmZf+5tDeljTvzs2uYXxKnj2vCbQyg=
X-Gm-Gg: AeBDietHaxZb8fvsQ6m+Y3Z3NBleVI7UzzuyLOmRpcgC5Ndv/SY6BZ9mf/C6ZYe7JSZ
 NH6GTK0imr4WQ2seGX+T4xh9rML0B8jbWWc3LnmdgRdQbsi1KQpyE3VIT0Lwred5C1gHh3a25ZC
 wFTKnvVdfCczlyy+QyWo5PSsMmORUgAbi7jH5xQRvjOyo+MNJB/tKpxV60/PkvDQ0P0WL2W3NRp
 oT0Mb4Bm6VTEb1rTP+ccumwl99wpil9lMdcR9xJ43UBrlgXATAxJPx4/SlzHPtxqdBY3OA+DZSa
 1gJzevBBzvgQ86Wchyft17rwCGFxgUhQ9K0q7o2rX1YEjab00scHxBdn8hd8n8/0XVMZZUHgXLQ
 ofAtayVr323AOwGF8kBBKS6YEERJVb6Lup8hLMgiuyOOC3oHWCh3rVujPFiYFEM3KksstcKNHHu
 0h9zQXdxFZnK03GLg6fnydr9OjZuDUj8Sx67ZXlOX3aAgorI52MKXkdWAIG8W4Ev4VMxlgKCJhF
 qfnakZmGykcWA==
X-Received: by 2002:a05:6a20:7f89:b0:398:7855:3e33 with SMTP id
 adf61e73a8af0-39fe409bbc8mr13028622637.56.1776048886144; 
 Sun, 12 Apr 2026 19:54:46 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f?
 ([2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7921a20100sm8215970a12.29.2026.04.12.19.54.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Apr 2026 19:54:45 -0700 (PDT)
Message-ID: <1fc32181-c4ad-48f5-80ff-d9195d6206c7@linaro.org>
Date: Mon, 13 Apr 2026 12:54:36 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/27] monitor: Reduce target-specific methods further
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org
References: <20260410195323.17937-1-philmd@linaro.org>
 <20260410195323.17937-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260410195323.17937-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/11/26 05:52, Philippe Mathieu-Daudé wrote:
> get_monitor_def() doesn't use any target-specific declaration
> anymore, move it to hmp.c to compile it once.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Dr. David Alan Gilbert<dave@treblig.org>
> ---
>   monitor/monitor-internal.h |  1 -
>   monitor/hmp-target.c       | 39 -------------------------------------
>   monitor/hmp.c              | 40 ++++++++++++++++++++++++++++++++++++++
>   3 files changed, 40 insertions(+), 40 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

