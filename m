Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164C8C61DBE
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2026 19:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0OlS-0002Kq-HI; Sat, 29 Aug 2026 15:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x0OlQ-0002JL-Jv
 for qemu-devel@nongnu.org; Sat, 29 Aug 2026 15:30:53 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x0OlH-0002XF-4Y
 for qemu-devel@nongnu.org; Sat, 29 Aug 2026 15:30:50 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-cc1c3d79b9bso1887724a12.3
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2026 12:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788031841; x=1788636641; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gre0IyABsuJv972/9wX6XUu1eOxBjMvFLdEpEU2LlV4=;
 b=yaNnCVJepcOilkx5bdPnGW++KZ/fjjJMbLTNHRFa6JVoPgvBKeofuRPjkuet9Lu40/
 LpIiO763BjUK1PkyJpnWiF9R5X11k2a486ZBe0bnLyJeMr42jSKwJ4Kf/MKgTcIoRti2
 MBh+qX8Ig/cjRvptghwJv6gPuhbWZ+8xrGry6dua/2unAU4pqKWJIlQsIu/C10HQoqtm
 521Pluw7IlXDmn++4k85eBeVEtMap9q8Fpcdl9syShUqliJCJxcxf215QJaV36KOiSpH
 tGEJphJww6HlqsyOajNJ70Fn0fuxihArmP9hl/6UR8tkZE/5HR0RjN/xZvs0QgL1sKOq
 luhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788031841; x=1788636641;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gre0IyABsuJv972/9wX6XUu1eOxBjMvFLdEpEU2LlV4=;
 b=ESaoL/Xftgp3rYy5E7F6xZKKQs7Mv1y6tt9+7RdLaMzF+tdBNhZBDEcEgwVVPSQ6Q9
 9PM4NB2WK1yy2fD42aGLIpOdV3H69RcttlzMOysKmJb5GKorXhX/awwg3SDB7NqOxFVp
 u9mNRhNnEQXvlJff8SaqhAON3C6a+nQBr5/IeRDKrpHkpP7ng+GAxSeZDewkluV73iO1
 uF6Kbm8l+Hu3XznpGKVoNWOu/eZ42qTJsbIdNm5KR3Yqe9xmxhm9Nx63goFe4l9gk08s
 S5trLYoVQN+8K+FKNsEoJIbGwtp7mkFOntAnN8T3Dtd2iktLVoJEcHvHP6N3P/ZXi/k1
 q0OQ==
X-Gm-Message-State: AFuF++nn9QMGxKjJIQ9MK/30ZIfLAgIC1U1rEICd96c/nG2Dfon2Wk+b
 ZHM9qNyHfLc8kPkfaQWQGrfUfS2xEmARSyvMdDZolwPXZuOXaZjB4GRT5sV0LyeCrQ09bSaY4h2
 m/V+fRKE=
X-Gm-Gg: AR+sD11Dr1kAVuIWsqYfZQ8KBZRBGDAfs3shLsksif7i/3NotYobnjiY8FDc9BfZ+yi
 l/hBpyd68qD7f/i+Cp++C+fGQNZFPNaN3AdF02FQfcltRnIafNVa3rCl4+MioJd6ECgfCoUvbfx
 RFIQMmaDPnmSrD1xKsxfyVvf+X81yNN9tm/ZeWrW1ivRp3BM95m9Tuaz/s25vn+hS9Eo0uJcGia
 FND2W56jrOeDw3x9/XvRXl1SFjiaE9MJqSCu2C+d+yAyvbB3AyOeOh3vY0deRhDN4xhj4rdq/ih
 GLr7zkI93htfnnRUg7bRnkJlN+CtLelrRwn514TQZbUIVPhYqhQT0/LQ9FosUxKgTHLefnrBALm
 fg1dP5A+Q3F277O6B/EhwElUGMYnf4WXyyUPqsc1OY2PaGPGarwAqQlP+Jr9LBCAxHZJdlZtqVU
 pb/j1sWYbuHMoifUu/bvyrDQ9O9cmysJP4BTykUdg2Nuq50jEdWN9gd9F+2Tkd7JmUyt+ZpxBx2
 CeejcFJc29RmSabwi7WxbcbM5IHnPs=
X-Received: by 2002:a05:6a20:1582:b0:3cd:2e96:5929 with SMTP id
 adf61e73a8af0-3d2681a9fcemr25323023637.14.1788031841437; 
 Sat, 29 Aug 2026 12:30:41 -0700 (PDT)
Received: from [192.168.0.4] (71-212-39-143.tukw.qwest.net. [71.212.39.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc1f36efd8fsm1995313a12.30.2026.08.29.12.30.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Aug 2026 12:30:41 -0700 (PDT)
Message-ID: <dbe611fb-39f8-4844-919f-1b44fb9817fe@linaro.org>
Date: Sat, 29 Aug 2026 12:30:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/or1k: Implement l.extws and l.extwz
To: Ali Ahmet Memis <ali@iusegentoo.com>, shorne@gmail.com
Cc: qemu-devel@nongnu.org
References: <20260829083010.2424941-1-ali@iusegentoo.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260829083010.2424941-1-ali@iusegentoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

On 8/29/26 01:29, Ali Ahmet Memis wrote:
> From: Ali Ahmet Memiş<ali@iusegentoo.com>
> 
> l.extws and l.extwz belong to the ORBIS32 instruction set, but the
> decoder has no entries for them, so they raise an illegal instruction
> exception on every CPU model.
> 
> On a 32-bit implementation both are register moves: there is nothing
> above bit 31 to extend into. Implement them as such.
> 
> Found while writing an OpenRISC port of Valgrind.
> 
> Signed-off-by: Ali Ahmet Memiş<ali@iusegentoo.com>
> ---
>   target/or1k/disas.c      |  2 ++
>   target/or1k/insns.decode |  2 ++
>   target/or1k/translate.c  | 14 ++++++++++++++
>   3 files changed, 18 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

