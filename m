Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B274CC5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 09:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxLvn-0004XT-9m; Fri, 21 Aug 2026 05:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wxLvj-0004Ws-I4
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 05:52:56 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wxLvh-00036G-2z
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 05:52:54 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-49557167508so6710355e9.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 02:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787305971; x=1787910771; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AwP/yWfGPx1h2d5TCJ6y+1qxsK3YP7lopFi3pzqk8ko=;
 b=G64q80TSLA5pHgr9/qpQ9B44R78Xom1RenqQP/rU1ACXrozkXmd8EA5nE3+33IjZ6s
 Au+Q82rA7wwt9jInC74/4Ws8KWcWMS4XXAE9mkN2lPllN2oe3bPN7hCOpVlSQ4Yb5ogp
 1bdLjS2YY4l+YVDmXmAsnPcCpsVOl2+FFTVuH1jv26X/3DKO6/k442P5kOUBCoTyknsE
 aTKjHQhRr9EDYpHVqXA4SoUEQh0pdyzWDM/ttLhImMpXP+akbkZcK20tDAVDYwr6b/pA
 edw4J49svW14mfdQHdyU1TAAFYopAcnFhwk1+7uuNkDCxeavCNdO3/vnP/pGwl3EJ6Ld
 rqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787305971; x=1787910771;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AwP/yWfGPx1h2d5TCJ6y+1qxsK3YP7lopFi3pzqk8ko=;
 b=mwY1fp+DtTo4NW3VAVUuV8b8RJKUdadPmtG0hzK/HowP6RbjcGk5cW/db+HVyL2YkP
 RU8eXsAh6LA++QVzKqkns7FU7yVAGw5SbVFQ7kz/PS17emLFEt3ETPqBrqz51YTdcPlQ
 AQWo23S83O5clSnR7bQXfBtsrmdXIuksOc6rNMizVPM6vANoB/z4GadK97pNJQZCNX0S
 dj6e8jpVTeUmZHnq/mG/dWu2G3leQdZLqBOxsGWyAM3cF7//xdgAub1mBH5klBcHvhUz
 MncU7e7wDjGnWZpOd/ifhZ/IC4+YbqNBaLzCCWukmUvmeODnhUE56pP6MqYBRkJx3ggn
 t24g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqJs1VRMCiVj4RDA6JEi6clhDT37bRfdr7hbNcR6FlwVEOfpfpXsMNcTTLtNW+ZhUwWfP4TpRtX+Yyl@nongnu.org
X-Gm-Message-State: AOJu0Yyjj11O6XyWC5nY+KUHH3AHhghNTYm9InPT+g/AOioPZXpNwQuh
 3O3cFPozS7VscznmnoW8wIY4O/KdP/76grxRYjyljLuqImdc+PVh48eGBG4rsClj1oY=
X-Gm-Gg: AR+sD11zmRtrsakkxcf69IvEzH7pJi+VbMfQun9WAcN68+TmRKNrvwJXeOGm62kWs+1
 S/spNHkVa1SPVCXF3cuPPhioFKaaoJoD17WHSswVx9HkZ8IDlaKfgrXMbPUX4MRDOda82mHJjLG
 tyuXvYYUU36HJ959jXX3cLDVUKxhEjqe56qCrhSCkQiwWDJLBIC3gZfv8fMCyJSM8YlA5kbVHSg
 uOQDpS6/OeWybNabPmKfWki21AvYXD/wL7doI9hybXItGP0Pud3RyPKv0xcCQS6eqF8vtJEONZB
 YCMF4TyPTSKs6wVw65f2M4DdDnYIzNAXC/Tz5YdaS2iD7xortw9n5iKIkLY6gYcjHGHTlsFNkCT
 /kuX7EZLZFM4vAZ/IXF+w8m5oVDg/KiV+112r3JIlCdPANm0GjBTOONWonHcg8YTNSih1I60YeV
 Tn9TRNybKdHkbQprnN8tzV+eOGJY5lLStV1/mD8KYBQRlVw+R93TV6qFtawPY1cQ==
X-Received: by 2002:a05:600c:3544:b0:493:f140:c3fb with SMTP id
 5b1f17b1804b1-499b8301874mr65796535e9.7.1787305971175; 
 Fri, 21 Aug 2026 02:52:51 -0700 (PDT)
Received: from linaro.org ([2a10:d582:31e:0:fa47:b339:78a1:d4c6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e3138sm22336665e9.4.2026.08.21.02.52.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 02:52:50 -0700 (PDT)
Date: Fri, 21 Aug 2026 10:52:48 +0100
From: Jim MacArthur <jim.macarthur@linaro.org>
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu@processmission.com>
Subject: Re: [RFC v5 02/28] hw/arm/smmuv3: Introduce banked registers for
 SMMUv3 state
Message-ID: <aogf8EmOJ_JEGKWl@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162410.2805113-2-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813162410.2805113-2-tangtao1634@phytium.com.cn>
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x32f.google.com
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

On Fri, Aug 14, 2026 at 12:24:07AM +0800, Tao Tang wrote:
> Rework the SMMUv3 state management by introducing a banked register
> structure. This is a purely mechanical refactoring with no functional
> changes.
> 
> To support multiple security states, a new enum, SMMUSecSID, is
> introduced to identify each state, sticking to the spec terminology.
> 
> A new structure, SMMUv3RegBank, is then defined to hold the state
> for a single security context. The main SMMUv3State now contains an
> array of these banks, indexed by SMMUSecSID. This avoids the need for
> separate fields for non-secure and future secure registers.
> 
> All existing code, which handles only the Non-secure state, is updated
> to access its state via s->bank[SMMU_SEC_SID_NS]. A local bank helper
> pointer is used where it improves readability.
> 
> Function signatures and logic remain untouched in this commit to
> isolate the structural changes and simplify review. This is the
> foundational step for building multi-security-state support.
> 
>  static void smmuv3_reset(SMMUv3State *s)
>  {
> -    s->cmdq.base = deposit64(s->cmdq.base, 0, 5, SMMU_CMDQS);
> -    s->cmdq.prod = 0;
> -    s->cmdq.cons = 0;
> -    s->cmdq.entry_size = sizeof(struct Cmd);
> -    s->eventq.base = deposit64(s->eventq.base, 0, 5, SMMU_EVENTQS);
> -    s->eventq.prod = 0;
> -    s->eventq.cons = 0;
> -    s->eventq.entry_size = sizeof(struct Evt);
> -
> -    s->features = 0;
> -    s->sid_split = 0;
> -    s->cr[0] = 0;
> -    s->cr0ack = 0;
> -    s->irq_ctrl = 0;
> -    s->gerror = 0;
> -    s->gerrorn = 0;
> +    SMMUv3RegBank *bank = smmuv3_bank(s, SMMU_SEC_SID_NS);
> +
> +    bank->cmdq.base = deposit64(bank->cmdq.base, 0, 5, SMMU_CMDQS);
> +    bank->cmdq.prod = 0;
> +    bank->cmdq.cons = 0;
> +    bank->cmdq.entry_size = sizeof(struct Cmd);
> +    bank->eventq.base = deposit64(bank->eventq.base, 0, 5, SMMU_EVENTQS);
> +    bank->eventq.prod = 0;
> +    bank->eventq.cons = 0;
> +    bank->eventq.entry_size = sizeof(struct Evt);
> +
> +    bank->features = 0;
> +    bank->sid_split = 0;
> +    bank->cr[0] = 0;
> +    bank->cr0ack = 0;
> +    bank->irq_ctrl = 0;
> +    bank->gerror = 0;
> +    bank->gerrorn = 0;
> +    bank->gbpa = SMMU_GBPA_RESET_VAL;
> +
> +    s->aidr = 0x1;
>      s->statusr = 0;
> -    s->gbpa = SMMU_GBPA_RESET_VAL;
>  }

Why reset s->aidr here? It should be read-only and set in smmuv3_init_id_regs. 

It won't do any harm and the reset of this patch looks correct, so:

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>


