Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 228E5C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 15:21:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwi6o-0004aj-Er; Wed, 19 Aug 2026 11:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwi6m-0004Uw-Q0
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 11:21:40 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwi6l-00058U-41
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 11:21:40 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2ce98cb8165so9682425ad.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 08:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787152897; x=1787757697; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PsR5Jfbn7veF9hYWqsRQXx1+eJkdxQ+p4Co4mZneZVo=;
 b=j1nJ0FuIkY3DU9OnpaI3sLF12dkgudyJd1lRFJa1dmv7bOQRIGdI8fevGiw6QCDtjp
 7k9QdNpZVfdPvMHdA561wM1BX4o00StpynuD8mJ84q9pBesuAKEuM5uHE0Z+TExUDOi7
 pl6pIWas09ZxTpPQP0AHRoYBKezGhwVmpoWZzPEktlNJ/c7kVHE3PyMfqW/qynUcmig5
 w2DtPx7vwb/N2Wt1R2Lg4TuQt1T0m/VV9YLIEKKhBGNe3FeYHsw97GDFOzdQL9UG9l5/
 JWfnFGastIpyhMW8VJXwP/YwguPizCTGMlf0ljGXjsOjr0kvHJmruag9vwUfryoeTI9P
 Xzxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787152897; x=1787757697;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PsR5Jfbn7veF9hYWqsRQXx1+eJkdxQ+p4Co4mZneZVo=;
 b=jWGruN6waid+7QRpq/QHYMYiJnp5a8ndZFNaM77zE3lYz4uwXXaQUJI+q/4VJnKIOx
 m0mOntddRnwY4CZDBaZsCd1QOcyu5j8NMCYrlyQ4/Ol5KPWlu0+AymW/yALnKEIbZKVs
 /hjeXSs2dsh21sOJsV+2PH5qtucmlWt048aznEOD1pfJx2G1VoAOp7pn+uHnfN7GcVI8
 DZKQs3D51F3oOA6j7LoicsK16qluh1cjpSXqolvtKeZh6YheCg713oyj8vVB21JZNTJQ
 YkD5MibR90TPTSvVDFP3UPKR/fZwgF0o/Cu94YkHzoaegu/ikl1MTpzJg1lLK6RNts6q
 N7QQ==
X-Gm-Message-State: AFuF++lTIrTJA16DM9H/95fFRonyaOXzAA92eioT/PKMxglMxKW1Q36Q
 TM9xMnmOG0bzRZaLUcZyiSlo/I4hZZiwXCIwNBiiDT3oaNxiHjkkFgnHfjF0FXAWg1DlHkKyxTA
 9v26HWiw=
X-Gm-Gg: AR+sD10jkTuq4ExpLCUNNse+YeBA9xH8IIe51igyaLzPhyjq2fOvF7GWGGdCVH/F66V
 eibYd9LXvyHAKu5evtBNH8PaBvU+qtrzyiOjMkWVzXY6rVaZ08UHXzFI4t9YuxN87niTpuXOYTU
 DxS5idM0gQvtYet9rSXQrPqXjnoI9b9M3VS2VzRcVd+7581D+AaLvCQCNua/ZunxCh6og/85kn7
 2mzTGIgGmn/kKqtJ1o0v3+FlZcDH+QXmITtSvgnXtIa88xLmekHrqr0g8A2Hg7IpvZKAhx16a5O
 alIGl91NF5jdS6QJBzoLK7iwGjiZA/6sSnGiusIxQ3VJ7yXR5mcYDnDkIlQqumWqiv2HaomxRZo
 WI+R+QUpUv5q88H+xmLu3yOMCyaglqhOiyGwOMKn7bwitiZX4XdCX+U4iF1+RDNwBfRAoJU7yJX
 29Baft5whOpPSDaeW1uuj58C5pgSZ27xgVD3YdsFeC+lCmf+ZAsGSjdmDoW8USNffgFmTRUtIh8
 MFEDnn+
X-Received: by 2002:a17:903:350c:b0:2cf:af20:4254 with SMTP id
 d9443c01a7336-2d5fc9bf1c7mr70484055ad.10.1787152897285; 
 Wed, 19 Aug 2026 08:21:37 -0700 (PDT)
Received: from [192.168.122.51] ([173.164.107.233])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d5c1efd10fsm26008955ad.81.2026.08.19.08.21.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 08:21:36 -0700 (PDT)
Message-ID: <a4200d8d-b74a-47f8-a974-9cdaf9177b88@linaro.org>
Date: Wed, 19 Aug 2026 08:21:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/38] tcg patch queue
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20260818170155.1907006-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260818170155.1907006-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 8/18/26 10:01, Richard Henderson wrote:
> ----------------------------------------------------------------
> accel/tcg: Allow overlapping reads in record_save
> tcg/optimize: INDEX_op_mul is commutative
> tcg/optimize: Fix s_mask computation for shifts
> tcg: Defer tb_flush when initial thread region alloc fails
> tcg: Add revbit{8,32,64} opcodes
> tcg: Add integer min/max opcodes
> disas: Updates for capstone v6


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.2 as appropriate.

r~

