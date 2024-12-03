Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF56DE6C5FB
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 03:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIJwv-0005bk-5M; Mon, 02 Dec 2024 22:51:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIJwt-0005bc-2e
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 22:51:43 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIJwr-0007QH-Jr
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 22:51:42 -0500
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3ea47869282so2776908b6e.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 19:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733197899; x=1733802699; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hK38Y+1vp/1414Rt0PiYPOm/18hIL5dwxy3360OoQIM=;
 b=lgnixi9eRDVFxgrvWxSNatBNMv0At5RGKMTwdD54qfv7qQoOxdU6ifGNvgdIv1n+nq
 Cd746RfGTSTXxoUIRS+RuE9TnyuaLkHVkW33Tr6sEmFlWfD2gnhTxbCsMOcajuNhBidH
 ENeBRxWAE5y0127WA29zY81a/i4q9yUIGWYnYzOR/rMVpogKUroBndojvz7WfZFBIznl
 QWjTGFuo/nDiZ1ADO3ioUSwKGvxS/rEFYbjtq51/qHyeR5FScqp3d9nMKajko3LvrFwS
 I4sXyt0DUk2ZG461o+HL4ZREmwDfkAdCUQwvhTgZdk7YbWX7KqIihaWvB4Gx4qa6Etfp
 IK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733197899; x=1733802699;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hK38Y+1vp/1414Rt0PiYPOm/18hIL5dwxy3360OoQIM=;
 b=b7tB9Pb3A22w0x3A2bOHKyON43DNzO8poiKItIpsrvW8tXEKpkU9te/ujlV1Ub04kf
 /dO7XTYgizXdooDe2174g+Awmm2jpqxKPS+W++VlyUGWRCvENx6g9v0WTtp+dyU3kdvD
 YBu5wX9keVoPs7YCqFS11/ofZDaHVZaRUAofNPbrDqakm2BxGp0BwVXxvSFhms38jxPA
 /beJms0SUpT7hwG/ugGPi4wjCYjAmhBV6RSIeNO7b1PYTZsZQCsYZ+xtCv+sdyP869w6
 sYmpJiXsD1+iawAn8S6+xdOMLmgdV2+IrU7Wj9I+O7ieMun4mCzdQcLBy6cYurkeAV7a
 NX7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHlP2zfHvXN39YYzG4VUsytqTxr9vrT+gsJYGfIRY6houMuYPjTg9WhCtU4qJEy4morSbaTYykmCiR@nongnu.org
X-Gm-Message-State: AOJu0YxcktlmSe8/VGWogg+eBhJanCSwlwBezCpS0e7Y6OVaRD6PP1Py
 HV8UqZxxkOjPjAxN/OaVRgXsMxy+zBVZDbbIZ4PV8KfVXta/lpHRBPncUB3Kla4SWAcNMoN1A36
 Qcjc=
X-Gm-Gg: ASbGncswTfrUHWtWnz8KSWlqkBUkyY1p9nnlvuqdEgukUgMX+RVwo7+4cxmzYjHRHhq
 VueuhPMh/ItOTvPB9Gy8cIv3hZAvFy23wmJv2Y2GqhWJpaM95UzWs8zvp1p/JA7SYUz5GrLowgl
 FwEETj2uassIOL4lFxmex5AIZLFOplPq2DymtZFqNoMSwtKS7oKmvkE5olbAMwOoo171bMi9r4P
 C6eftw5/Am9hFToNwiiIOFpAeNzydV7+sFQYhcbVYnGQo1t2JcUWuam++wixb7uWnoCCuAHtDJl
 N5I/YEYNPTMy90DZomQPGci4IRmX
X-Google-Smtp-Source: AGHT+IFW0yYpaf0iR5aN7tmKSVohOIXBnTJq0hiGV6KEPxkVKa54BE6wHP3ffst3YFQufrYScht1Ug==
X-Received: by 2002:a05:6808:159e:b0:3e6:d7:9464 with SMTP id
 5614622812f47-3ea815c9815mr11962935b6e.14.1733197899591; 
 Mon, 02 Dec 2024 19:51:39 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d725d8580sm2629860a34.55.2024.12.02.19.51.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 19:51:39 -0800 (PST)
Message-ID: <7e380b2a-d002-454e-bbf6-471f33209c38@linaro.org>
Date: Mon, 2 Dec 2024 21:51:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-10.0 00/54] fpu: Remove pickNaNMulAdd, default-NaN
 ifdefs
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241202131347.498124-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
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

On 12/2/24 07:12, Peter Maydell wrote:
> (Apologies for this patchset being both big and having a wide CC list;
> the good news is that this is the last lot of fpu ifdef cleanup that
> needs to touch all the targets.)
> 
> This patchset does the same thing we already did for pickNaN() to
> pickNaNMulAdd() -- it replaces the compile-time ifdef ladder that
> selected target-specific NaN propagation behaviour with checking some
> runtime selectable settings in the float_status.  The motivation is:
>   * this will let us have multiple targets in one QEMU binary
>   * the Arm FEAT_AFP architectural feature includes letting
>     the guest select a NaN propagation rule at runtime
> This is patches 1-26 (which were in the v1 of this series).
> 
> It then does a similar thing for making targets select the default
> NaN value at runtime rather than relying on a compile-time ifdef.
> This is patches 34-54, which are new in v2.

Update needed for is_ebf in target/arm/tcg/vec_helper.c.

I think the best choice is to reverse the copy and test, e.g.

     *statusp = env->vfp.fp_status;
     set_default_nan_mode(true, statusp);

     if (ebf) {
         /* EBF=1 needs to do a step with round-to-odd semantics */
         *oddstatusp = *statusp;
         set_float_rounding_mode(float_round_to_odd, oddstatusp);
     } else {
         set_flush_to_zero(true, statusp);
         set_flush_inputs_to_zero(true, statusp);
         set_float_rounding_mode(float_round_to_odd_inf, statusp);
     }


r~


