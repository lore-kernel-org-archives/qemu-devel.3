Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88CE5C982CC
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 00:01:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6zYl-000882-Aa; Wed, 16 Sep 2026 20:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6zYj-00087o-LT
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 20:01:01 -0400
Received: from mail-oi2-x11.google.com ([2607:f8b0:4864:32::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6zYh-0008LR-Tm
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 20:01:01 -0400
Received: by mail-oi2-x11.google.com with SMTP id
 5614622812f47-4bb359e6878so118500b6e.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 17:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789603258; x=1790208058; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=S/LZN/RuuecEKH3kmSnhGupQHSeYWr5nJ+tTzsAnbfQ=;
 b=k09hy5Gf1XJ22hwPhxo16uBw/HFLCaw2Gf83ukwk+dMe218bAtH0+bL5rumERewM6d
 3AINyP+g+dOi7rtpyJyD64x1RTuXy6QT9TYlhy7AyRYS4wh335E8v7wIoWEctVaxiP3b
 i8ciG0BkkyUhOFPGmuiR+mc0AaK4DQVkQqOIjA1MfRslpaLLw6RWK9fRs3VHqWvPUTlV
 bSR4+MtitJB6APyqnRyQBNE4oaGE6DZfuxZ0c3BQH68nuAlAtblT0ClptJ6BDBnf286r
 mmoe/9bYwa2HJ+wdhkhQBZSvG8q66AoNGyBzhqd+cvWzCA9EX4HgfcV4TLUnogEObF8d
 q+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789603258; x=1790208058;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=S/LZN/RuuecEKH3kmSnhGupQHSeYWr5nJ+tTzsAnbfQ=;
 b=FNi0ew4VT2t3D7O+eXxUA+1ontp08RtLE6ZHn/kfzOXwmS99sjj/vnwV/5KLQHIGXj
 pEd+cUEQZ6qcn+jsvhIA/sw1NqIdbz0RkVSqS9JU7CNajjvgIDsSDd9p29lRrrTXCBFn
 +EXrhqZgVPLSStzPfNM+gtydUopPIW0sWp+BzkBM2qIl0ktfdL6EV7zSVFP/KIDQGgyt
 xA5U1SSTnNPV2nanMCq4vFD7hJbEgqaMlRh41K1w+VNN6MZmm5R7Ct7Y2G7tYH6/Wwlh
 ENiSY6fbrWx+ClHGJl++YSp4dGAFJsoRSv1LTvxB6ORwC/AG+brANJJyGpoAGKkaWROW
 JCBA==
X-Forwarded-Encrypted: i=1;
 AKwUvByjs/9mrAGjOQ8pemxdyjOo45hzkmaPXhwXQ5rZ+6NmIfqNtE9KxEJKY4F1LtatSTv/G0s3FBdyidzq@nongnu.org
X-Gm-Message-State: AFuF++l6zV6c+6IPcE3OxjkMnZn6fJJEFF37h8z1B88wLzrA1o58eO2A
 tWThfNhmgRXy6pkwObCUqY3dmxIXw99Oy/MTXOx6YmKL9L2gKlm0/MS2EoBfaFv9euM=
X-Gm-Gg: AYBFou31TH6NTiu76xjUFz8O0NXEkCwjqCPwJuLP1L9asPyw8Ih7+ROCHktfSeq2sDR
 b8BuHG9850y9XUTfCt/oA14OY7v7KLrMvXBaHiV+l6YMsW7vXDlAI1krhKGuP+o6dSGrlA8H3vW
 qotsaN26ZXQHEnVXOPY+DPR5EAq8niOQEuWSlzHpDderZuPfwQiJBAm5z02HO7A5RvhyrVz1idR
 yzrBbdC/Vz2j3Bd23g0Ee6f6fbq/gpEqr69iQqprJY6d5LqeGt/n1wN6l2y5dDjUtj1c2G8Yb6E
 bQgmIuIyWIKyHWpBrwdYx5xpx+bM/AltVmbUE8FSzWQ4rutwtGwudRbEmyZCwwTz7IcqfOgs17j
 NBDNsbko2wgg9RvIZaILntyZvkq+bkJRms69sVqkIApRPDyVapjulCB00VeBKUTdvsZVWF/9zhc
 Wyt4ZvNr3gy4tdNxaX41t3XGbZiexE+POf6Gc3VmI9ou6lR0+Z8w3Z4s6hM0jrarnXqHmZCq88M
 gYqRDiD1YPlpsx0FsVyj0Fm3oVY70ITnPpsDEmUgjVgSaqStbn9+kTfOTaQz1mCfP3iipXS
X-Received: by 2002:a05:6808:1386:b0:4c3:bc5a:def with SMTP id
 5614622812f47-4ca49dd6c6cmr5543139b6e.6.1789603258408; 
 Wed, 16 Sep 2026 17:00:58 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:325f:1938:d075:8c13?
 ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5b1d335sm11589529eec.28.2026.09.16.17.00.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 17:00:57 -0700 (PDT)
Message-ID: <1af97e15-d08f-45e4-a4bf-879667a43c0f@linaro.org>
Date: Wed, 16 Sep 2026 14:00:55 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/19] tests/tcg: don't define tests when missing
 compilers
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
References: <20260916153013.2134555-1-alex.bennee@linaro.org>
 <20260916153013.2134555-10-alex.bennee@linaro.org>
 <863e1541-31bd-4b2f-ba78-0f963138c0be@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <863e1541-31bd-4b2f-ba78-0f963138c0be@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:32::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/16/26 06:41, Pierrick Bouvier wrote:
> The alternative is to not declare the final test (test() call at the
> end), in case cc is not present. Reuse skip_test variable, and check if
> cc is present at this step instead.
> 
> This way, we keep benefit of checking meson.build, and the benefit of
> this patch.

Good idea.


r~

