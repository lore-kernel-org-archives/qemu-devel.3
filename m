Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD8BC61DD6
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2026 20:01:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0PEh-0006ou-28; Sat, 29 Aug 2026 16:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x0PEf-0006oj-0P
 for qemu-devel@nongnu.org; Sat, 29 Aug 2026 16:01:05 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x0PEd-0005Ig-Gr
 for qemu-devel@nongnu.org; Sat, 29 Aug 2026 16:01:04 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-3a2b4743936so16329201fa.0
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2026 13:01:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788033659; cv=none;
 d=google.com; s=arc-20260327;
 b=bnWNEhIpVWI5Zy9CYUWb19yyCiCbXb7wZH/T0Yshi/cLQIx1T4eGOHjVw2X5EwxsiA
 fEtb8sNplumhD+tqEylZKlvuRV1yzNfCupf5gvj5lhTre3XOlHtruTKA2ZjWZ95uGUUV
 1BKevX7NiottSsqEJHm6OyuO5Mx8AANqZluXo2NYxAnp+xHDRhafnIX0z+B8III7va74
 4VUtjtk1D+hHC3ppKuCfektWKwfXC2CHKL+XuZI7U3qtRRusHdtDdKcmyqxPeKek450v
 abwzQA6hgWcyBc0919gRPfGxCFrzt7raSu6aZJBmMZPUpn1h1x5/QIjyqsJvL3ZN6IE3
 bgQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8i4iK0s4ro86T1XbI47eLSDdgjqHmD1Z2vTmNRslqT8=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=IMRPcaq9XHcwOUoqzjGLxlCKg49dMeq6TyKXCGy5hgnnWVOyH9z25hSKFFnwQKsG6W
 fiBBf/Xavgl4ikmm6GeoIDXxgVrBJpsWH/IPqEyn0Wi6so+65ejRPUUsbKhJFEu+DExa
 36ICicD8zPxCdo8wi2J9vyD+3LSL7k4LpF/HuCaOUllL7wiAD3s6Kgt+oe+gMe1PIPDZ
 5iO7wmNxlXSewg1x3URFo0OVMNom3tTwdvo0Et2w5r11QoZXkaDAihjKy+FogJak4AWR
 00GuTDC5LaRmiDs5Qm4QP5OS02AYvwQxhgkeJlzMuXSNmNapc11nuL15rU3ycavKZEtH
 cvuA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788033659; x=1788638459; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8i4iK0s4ro86T1XbI47eLSDdgjqHmD1Z2vTmNRslqT8=;
 b=J2lr5o56ciLQni6TDM+GEMRAsJdfnKep8BtwJHTtwXyWGIL+GWETZQl7/Td5rvB+n8
 dPW8AD9cb+cSfVrSDLSF3ai2bzr1I2oWhamsek2qlnb+qaHJlQz0BCYtTa2v1Yah2aXx
 9w0/q7y2D2E2oqQibvlfQh9PZQu4n9F1zcyZ6DhcKR3Qtn4iVaFgM9iRb4IHMQ6jxIJo
 GLfTB1IUViEUw/bdUiAwbTDAD+DJ4bmGIetonveVqBy0qS/6LN/DOdQTPrpC7etqW4et
 Fd4WhQPfkl7gB1Nmha1pD7xQ+VY5AzjXj1M1tdfnwQmfhNk6Qg2wnH55jYwLab/Gu5r7
 zlpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788033659; x=1788638459;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8i4iK0s4ro86T1XbI47eLSDdgjqHmD1Z2vTmNRslqT8=;
 b=Dwox/rAdT1kl+mVDT6mDOlLYeSR8LPwJcGr2P0If3T+Z/8ztWBcRlxT23cxxmwM7uK
 M7DHisMTa1E5FEv+MjGv6G07S+8F5hxcXR5GI/3JcpN1BMG7uCL0TL9eM3APEdl68M2M
 yE5DYk8lJY1n4vMIJp1q6JGhWjfPcVo0xYtOvPOkzW3VKlYDl57V6Ks9zyEN7hcYjn3+
 jcRGCyYBauGJRyHBp6+gU80T+wJ/ZT0h2F8znLyzllBB3EESH7JCUOpDeLd+J1A4hwV0
 dxJ/tAsCIjTuGn3glVEbF9HREXH75Hjj/Oz8iuV+aXyMTg51RA3tLtQAntZJFux+seQT
 frvw==
X-Gm-Message-State: AFuF++k5d6b3bvbWz7G52nV8AsRUlVj+vTFMspheYQCkfhsp+S/Ugmzx
 WAjA0T9yeWKCwje+V0ZbMzMY1JfgDBfnaSg/yotp2HGZBFI02Z9KcH3WfbZmXm8t5q6mggFTOMW
 mJ1tBB9nMaysNtZmrum0YvjngdFfsv70=
X-Gm-Gg: AYBFou0QAPSkz1cvyavpPb8WuX9wUkXztCI8JoI5qXa6gbJFx/HhsoH+Q+VhLCazwBC
 Q8vQsWO4FxsefQeE+IJrMHE5fLK/fdGbxCTkXYYqOk5UCJ0opl3YGuMo6nZsKwwb1GqPPY/MpDy
 iGYwVgQGNS5YiHzfWTfHf1ZALRDoujZkjTrCfeG6n97DfPmQ3ZTozmEAgNixdccmDZ7fQjeQbLt
 Y47qZDbjE/SO05ggtoXbDFie0T6fwctXK5yFugbnM3FpGHZgy90VpCz2TR6N4Y5tcODWtQRAkRd
 AfGQ7QbQr6Qjil/VYigR9hrm2aHzlsGmRuCsiyFIjwRxk0Q=
X-Received: by 2002:a05:6512:3c8f:b0:5b0:ceb3:1150 with SMTP id
 2adb3069b0e04-5b5e68c215emr4601720e87.8.1788033659147; Sat, 29 Aug 2026
 13:00:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260828224451.1564072-1-richard.henderson@linaro.org>
In-Reply-To: <20260828224451.1564072-1-richard.henderson@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Sat, 29 Aug 2026 16:00:46 -0400
X-Gm-Features: AcwNN1XHt5bt9-Vz5C7xT4JdAn4frp7QPnfiZqoXj1cFoeHlTGgAdeM3FmPLAaI
Message-ID: <CAEdQ38F-2N_fAj1d+Ja15MDoPehOJmd7vcRhrfHYBtdah2G-EQ@mail.gmail.com>
Subject: Re: [PATCH 00/16] tcg: Introduce INDEX_op_lea
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=mattst88@gmail.com; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Aug 28, 2026 at 6:44=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Add a complex addressing mode primitive, and some trivial use cases.
>
> This came up in conversation with Matt Turner re his inline jump cache
> expansion.  In particular,
>
> -    tcg_gen_shli_i64(h, h, 4);
> -    tcg_gen_add_i64(ent, jc, ent);
> +    tcg_gen_lea_i64(ent, jc, h, 4, 0);
>
> With the use case in target/i386/tcg, we get nearly full coverage of
> all the possible use cases.  The only thing I didn't immediately see
> is shifts > 3, which could be visible with loongarch64 guests.
>
> There are plenty of other places in target/ that could use this, but
> the shift/add/imm extraction/generation are inconveniently separated.
> E.g. m68k address generation, arm add-shifted, etc.
>
> It may not even be worth converting those, but instead adding some
> trivial peepholing along the lines of Matt's user-only guest displacement=
.

This looks great to me, for what that's worth.

Reviewed-by: Matt Turner <mattst88@gmail.com>

