Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92FA9F531DE
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 23:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCQkF-0006uo-TU; Mon, 13 Apr 2026 19:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCQkD-0006u6-Jg
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 19:31:05 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCQkB-0006RH-Mm
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 19:31:05 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-82f41fce3e6so678450b3a.1
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 16:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776123061; x=1776727861; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A8BJNN/kVo8S9axiz6QuMHZKzhALQuyNX6Zbc5UdI8U=;
 b=z2sUKNN6Bi9/sPzFvVU6e/nbwDVkiq1WRC2FPg+gGIJHf1/908tIYIpdCGsIOajCv1
 XinvlhAJwQB49hyA2viyX9ANHJglGFs0NLJEDdgH13I/WgO/5fso15ghx6GADzwyyfje
 CiqtncnqcDWGOdq5yX/NVqwl41iahJGTxVMca0n+giGB4W/7DRxbx0h9x/1ZyGrUO9Mj
 K9Vxg0awuSbMrdf47aecoVjc56TtB+WiqBFB0KWIjCbp3vV17n9tm75cUUTGejhfJ/MN
 gPA3v2JlI8ycrBbDLdni0XQhPLa83pncvTvjQ+pWDTptTx/xZk59v0hMeWmyK2oWFxLD
 nTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776123061; x=1776727861;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A8BJNN/kVo8S9axiz6QuMHZKzhALQuyNX6Zbc5UdI8U=;
 b=DP2Oba2f2EQ9V8/wwzC4Q+WzHQwCW7X+HwIZMQ/Q+Bptzhviw67nLEi/rsAu7Uo024
 /ylrorcOCHLtACPSGLuW3gBORe5Q4MWD8Nsw4UjwX027Whi0L04UOiK3J633SGvv0b6v
 utThx5g4ctf/0MdH/EzxIgOQwawomIXDY9OfuweJuczR7p7xLuyh/yUl0uPLIC8uz/5H
 CUUsJt9I4gAwRuY7AcFiV2Qhh2hH9cQ6NvQ3JRMX1WpkIj2Ip3t9nxVYaOWz+SYSQDB7
 htuWetGtAYTFhGBj41sM1r35Rjefuue1BunG9kp+3rCw03ZaJQxwMlDxapFOJUvAu+Aj
 hx4Q==
X-Gm-Message-State: AOJu0YyP7VxP6CgPk5njuw7ayZaEncfuZhvzzefllXAPJDSMhe7nN8Ob
 2Tee8jghcSs/udrFjTFSWI0FX0gwHP6nOGi5jZ25Fha5Hb2AbMIJ/RUM49s5FucaqLmhUAx18E5
 YH9GWtc8=
X-Gm-Gg: AeBDietjDuOMEZOwiX0hqz/o+E3C1whmgb+A+eC4Pvb2ITSOD9X0U/uFEgZLSeskyWB
 pEET8gwati5PmH9Zwx9cksiEOkHx1yvIFdd8XiT3nxEDBJ223VRTw8C4VcVvcuZOPlFU+3BA6Jb
 +YwKmOfwDyrWnntdvLGI6XtXCWnOphXQM7qcV35WsfimaezvZ4kgDRaomP8WIyb6FpCDBs4VU06
 Kl2CHh5bRwW2QjmdzlPA9freE+UKpIwyTc8xbSqReVVx5/WLAbrSLIY15fVdZrDThodJoQZ4y2x
 hjDozhCMET4GRLs3KQXWLG0+FIZIYZ8PnakOv0AANmKXgeuKrM7emNjTGRt+UnY6KwlWSTr6zRt
 18AWl+qYLmuXJLfMF7drGmdTZOTBZ1I/wXjZosAXwJMRLgqZeopyZ/EeWHVNatHPChvC+FwiHzK
 5gz6x47YZaZXeJjlE3w9jZD+EYkCo4P4mRmyBr5Dw0rLBZ10YFblGgye98oDWQdmtDrXBavG26L
 o2P36NSwnZ69A==
X-Received: by 2002:a05:6a00:114f:b0:82c:e0d7:2681 with SMTP id
 d2e1a72fcca58-82f0c276ff3mr15666449b3a.16.1776123061216; 
 Mon, 13 Apr 2026 16:31:01 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:377f:61ec:6edd:e205?
 ([2401:d002:dc0f:2100:377f:61ec:6edd:e205])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f0c34f7d0sm13138348b3a.14.2026.04.13.16.30.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 16:31:00 -0700 (PDT)
Message-ID: <d64d3576-9188-4e74-afdc-3492c9feb8e0@linaro.org>
Date: Tue, 14 Apr 2026 09:30:54 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] target/arm: Replace MO_TE -> MO_LE for Aarch64
To: qemu-devel@nongnu.org
References: <20260410200628.19378-1-philmd@linaro.org>
 <20260410200628.19378-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260410200628.19378-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 4/11/26 06:06, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/tcg/helper-a64.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
> index 2dec587d386..dc3c8a036d9 100644
> --- a/target/arm/tcg/helper-a64.c
> +++ b/target/arm/tcg/helper-a64.c
> @@ -1019,7 +1019,7 @@ static uint64_t set_step_tags(CPUARMState *env, uint64_t toaddr,
>            * the page dirty and will use the fast path.
>            */
>           uint64_t repldata = data * 0x0101010101010101ULL;
> -        MemOpIdx oi16 = make_memop_idx(MO_TE | MO_128, memidx);
> +        MemOpIdx oi16 = make_memop_idx(MO_LE | MO_128, memidx);
>           cpu_st16_mmu(env, toaddr, int128_make128(repldata, repldata), oi16, ra);
>           mte_mops_set_tags(env, toaddr, 16, *mtedesc);
>           return 16;

Here's an amusing fact: we don't actually need any specific endianness here, because every 
byte has the same value.  So we could simply drop MO_TE.  That would produce a store in 
host-endianness, which will be fractionally more efficient on some hosts.

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

