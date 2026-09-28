Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2720CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 15:41:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBDT3-0005Gh-Gb; Mon, 28 Sep 2026 11:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBDSy-0005Fw-4Z
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 11:40:32 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBDSv-0004Ya-Nd
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 11:40:30 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-674784a9f64so1314869d50.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 08:40:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790610028; cv=none;
 d=google.com; s=arc-20260327;
 b=eOYpkKIS4WU3UsoKQ48WArQjgDF+4NWTLGyalh81dwaXhT9cBbINpRQr6rVpL3PnJh
 nrDkQsR2pj/34IjpotZjfsZfC29HJpVtc7qu0EVhMxBtaH2xw1E4YlrVhpeSiw/f0UTB
 hr51TjqB/6e9rq3ZTej7L0of8HBfzVcvmDOMhMOzlNYMTQ5Rhv8S9jH4Jf0eytF4RHWf
 UG2UOFV3MQgfB+w6M6NyziwvpY7w28WJz8A2uOHALDv/1fNPffgBB7FUoVSibbQmICn3
 kSbR6vd0W1IFYRnZYZjWqoMdvoOypOC+g2UNe7SVK5WqTQqqo5UVX8xAZU/+YkT8T/PD
 yfvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qM/B9Ymm+HU7jsilmrZJu7DV8Ea3+MiIvk8w5TS6NXA=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=DVywJ9w7WyS/w2IYATyXXS+U/CAJJVGzEaP0pzyXB1+cT0C74J5LBtRDnkqqLteFF6
 gZmkTl6U8uBJGgFJ/GeVLCYSf5ec1/POfrmesyE23lpHIu7ahMwjtzywRUDUj/jflg2q
 3qcmKubdko0zbNiFziqwDv/bjLg1cYR83JgnX4Pa4PSE8LoJPFaFxRUZtW0IvCBx6/CH
 rcLU0WRJ51+sRsWgnvuzGBknD+y5dwaIZS5BAjyj6TYKqIohs91Gfbj+4EMaJrRKUJYx
 E8YbPOigcy/3A4bogB4NqOQFl2hR65vhlnm62dfKPJiZk8iH6qa8RBI7O5DhvMg50fPJ
 bzMA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790610028; x=1791214828; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qM/B9Ymm+HU7jsilmrZJu7DV8Ea3+MiIvk8w5TS6NXA=;
 b=CtAJSTmC9QjmmkeClvO4dsSMF9IpwfPBNHbTVer9AeBZ5gyqQU3oqsZkuaWmaACC16
 9q6BUcD5u6lmhZt5tNvaNxJVIrg+65DyGP6iwM5SKYSeIqKxBgBvBRvkzrR3T5+n75rq
 6CZcwCW5Xdno4qJhNZYPTUlBBQQrw0/Eghe99/FHcucdM8t6RNmDxuL/C1MoWt/NUyte
 sqt/Le7WcvE+zUAlJCie/8KTFzJSSWNNUyGgqfrsg50X5b1y0gFB9xPn/MfUQv9r5zKQ
 bgyhrv9AiloVvJLWozwxBcg47rETI2SH9iEokU5ZmubvDiezUhXhwSaTlYJn8jjKJB+J
 7Umg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790610028; x=1791214828;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qM/B9Ymm+HU7jsilmrZJu7DV8Ea3+MiIvk8w5TS6NXA=;
 b=fygcjcLc3RZHzU5g68RdmTqYVX2uiIYll4EdKVbREzB3bO9DM20Fwp/1hHqoHkJa7G
 1O8JCQfKOTCx2CospKyCNAVSx5dYFznNg3+Ci41pQatjVDDequYyKujoc5DkNkkdpEM7
 wVbJtZnjqr4awj3oqKkjX/KSc5Bb5DVNv1Ezlc5yXpjbl/pf0zq5ZMtvztgmqrGaZVrV
 zjh3zlS0L9GK/9wepAof7wSmBEGTpkdGgIeS7GMoYYJbKMbDiTPhhFj6B8WF3hAt6rm9
 lOFpAwAWnDrS5SJOzYVHvKtO0R/Zd14LeC/uL42L8b4XKOwCJlUNPCIidPC7Ru28IY3r
 q1Tg==
X-Gm-Message-State: AFq9FYKlKgT95n/lIzTJtQwG7GfTLWIGqVJlLzvlKaPjKDptwhTsajro
 JqlyaotYCgihYOed1glrY3bJiMGJu/KwmFptnN+s43tDOSsjG3Z1ixPwYt/v6oer57ETzi2Sg12
 6QBSQ87uPCQ8Kr+DYivfpSlVT+929XoVB8lXszpAh9bnB0Ltjb8+3w2Q=
X-Gm-Gg: AYBFou1ukSeB3ijUcahya4wEcQAogZA8IcZE7oAA+7R1GGpw/GOl6iiVqsOYVyxjuQ1
 tLy0UL+SUqCZog4i2zsbLDJVVqGZEsrVirK4rSxv7dsj91sno80lscrLV8Ko4mPqOVC1wJRTgsK
 HpPOQ47htYSZ+iO8lTN/9AHHbVx6etUMUR4O+jHczZAddGpGcp2B/iLCprCm2cNh4XpyTUV9OOm
 O4+bLXKXWco43aLK7unmmPxbiuuchZhxxOfhLhwEpRJTdA3enVVOR7nmwl+CUu0vwN88sLLKwWe
 XW0OQj+FnFoLHJjofpkn2TycaDMl5fbDZMZn94lhI+2GvPQMa3QOmQURoHX/PtC71iRM9K5vAKY
 W4vC4S7KBjqEVxxqUMgeWZOGl0OvoaQ8onb1MZH8=
X-Received: by 2002:a05:690e:150c:b0:673:ae96:361e with SMTP id
 956f58d0204a3-673ae96378fmr4465386d50.55.1790610028322; Mon, 28 Sep 2026
 08:40:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260925215004.456336-1-richard.henderson@linaro.org>
 <20260925215004.456336-4-richard.henderson@linaro.org>
In-Reply-To: <20260925215004.456336-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Sep 2026 16:40:17 +0100
X-Gm-Features: AclHuK8DTkPA4pO_5khNZ4Gh2tPJ16Yz5JxWstZ29xndF0dvODjAjfpjmxPlzJg
Message-ID: <CAFEAcA_8MyATnQiAsT1d2Ay4b1C375vPJKY80aXvi+8A6EoJTg@mail.gmail.com>
Subject: Re: [PATCH v2 03/14] target/arm: Split out
 rebuild_hflags_common_aprofile
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Fri, 25 Sept 2026 at 22:51, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Alignment, FGT, and IL are common to a32 and a64, though the
> latter comes from different places.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

This doesn't break the set-read ordering for FGT_ACTIVE in
rebuild_hflags_a64(), because it moves the set earlier than
it was, so that's OK.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

