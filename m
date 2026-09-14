Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44817C88E6F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 19:23:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6CHI-0000kl-Ua; Mon, 14 Sep 2026 15:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6CHB-0000gE-B1
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 15:23:37 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6CH9-0002Lj-OP
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 15:23:37 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-398b3b189e0so1860238a91.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 12:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789413814; x=1790018614; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kiqN/SNECHaFLGJUJJesup1atSVTnWLr1p2ytdyKDyg=;
 b=BS5AIj9urAKVuAAFcu70CUwOLEK6XbaNe96runcbqcW3Gye125L4XOdwkCYLqrwRCq
 zA3jPaYuqft7CqovWlq4j8t6NGjirA1r4ql/SWfAqZHpLbQ97uFGlSgxrsrPt+qL2t+7
 rPomS+xQUhafW6P9FQ/yzSTh+GwGB50tec8u71H7FwrP5nNgmsa1ZCOehUcI4TwBUcy8
 AUZcQmPjs0Wn4uNp+OtC5ls71eX0aeN5fxgV9/c56P2TwUbxM3R9d/7qK2VtSFjuPlMu
 zRPZR1ACqtpvooV4JaJl2GWdxE37ZHGfIHz7IXaKosuvBLqM/bj69nAnggxqpouDa8PG
 cG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789413814; x=1790018614;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kiqN/SNECHaFLGJUJJesup1atSVTnWLr1p2ytdyKDyg=;
 b=oFxZtm5a1hRsI0rMPy6NsV5M18eFsCFjiEhCSMUC5RQuMqSAdWQgQEUMtKBXWY+waD
 vl+kfkYQa+QEF2Dsb1ETCXpM76ieFM0iZSL6NQrwnv8oG7PQri7pYek+0e/X0eFVRTQj
 Vodb9SzZAw18QguI5r/MK7PapmBYaTUDfaAbFchyGyUI/uxU/kbJv/MPdXD3ECi98Ts4
 z2RXQv3dXIg8zaUokYxp8jDr2JQuYDsecjbLYDBMb34ubv22HozgI87x0Y7+V75s8Lq8
 nEEEI13knJN9c0/r35Y4SvzHe0VnMfJeu5M/ly6ZVauVw/YcpIU6z9aNTOuwbUg9THHz
 cemw==
X-Gm-Message-State: AFuF++nIbGL+Q9OpZe6heBZtxepAXXxo3SQkZ5IJ7NjqiWTC3/q/D7sp
 9FWtYfj+6SycUdF1U8qGSNlqY17ZX3/Wg8rBa0k3BxS97UgNr0ApxQV0ZZkR07RaUo6fN3IrBEp
 2SWyHj4M=
X-Gm-Gg: AYBFou1k23T/OhN9a0G6/b4jbCSvW5mD4XzDqTW6UBTusib2siKSYS1EdB31LGVB0cD
 TBc9HXrfo2AL1rZTRuyGZ9pF4SF1h/L70N+FtoqU6FVJaK0ndOY5b8iaN/WCOJ5FmS0Fu+14IOx
 mRZuxSIzYld9ew8q6Ou04x6TwD0Oxo7hrzYLacbVhwJiJpJw3z2N/ilSByDp8i1SpCnp+jfbRRZ
 ujaebQQkPbQWYXgp+oLXCvTRJg3Thl8FCNvzZ2vFaXgtR36qTunYkss4yqC9Kxa5YnHZJLXi1C8
 MllprHXp0UvJW9HVr6Yx26LYyU+dI7oBNYG7huzgMjXqAuxGYJ8eb4/KBMa0v25kpeDEXlskQ7W
 uuRg1H+irluICx9L3cB63H+RpGVtGE78skjKKsJLINRbc50PbDJoWSxtTUfoEnPCSTXLKpZ0FbG
 evvISzVmsfz+ER2SIr8zS8OvPeVB5KGnrIN8tuNzf/thExrh22qBWpa+PvBQFX8+ek6joWPtYQj
 75VedHXTFvW8rSzkzCGDiOt45D41eY3EYNCzqUNhaL06KeelOlnJSxojmt2rw==
X-Received: by 2002:a17:90b:2809:b0:39d:f2b0:5afd with SMTP id
 98e67ed59e1d1-39df2b05b4emr5634398a91.2.1789413814312; 
 Mon, 14 Sep 2026 12:23:34 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:7164:7976:4c53:31bc?
 ([2603:800c:7900:ed00:7164:7976:4c53:31bc])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365ba729dsm42216419c88.14.2026.09.14.12.23.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 12:23:33 -0700 (PDT)
Message-ID: <83ba5d71-d430-48a9-9c86-338290d0136f@linaro.org>
Date: Mon, 14 Sep 2026 09:23:31 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/14] hw/core: report security status in query-machines
To: qemu-devel@nongnu.org
References: <20260910103628.2326622-1-berrange@redhat.com>
 <20260910103628.2326622-11-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260910103628.2326622-11-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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

On 9/10/26 00:36, Daniel P. Berrangé wrote:
> Reviewed-by: Marc-André Lureau<marcandre.lureau@redhat.com>
> Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>
> ---
>   hw/core/machine-qmp-cmds.c | 1 +
>   qapi/machine.json          | 8 +++++++-
>   2 files changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

