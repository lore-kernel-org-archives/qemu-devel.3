Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72BDC56208
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 16:33:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws11Z-0004WL-OM; Thu, 06 Aug 2026 12:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ws11Y-0004Vz-Bo
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 12:32:52 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ws11W-0007Pr-K7
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 12:32:52 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-84e0688b859so833466b3a.0
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 09:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786033969; x=1786638769; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PCXH8C52W7ZK0seF8WFhcvqgDynyVjh/s4U9YgqVZlY=;
 b=yU3IFzYtoV9XQSMmLxzUDQlqjpSXydR1DneEu26wZtFyR3Wdf0/NaXlo8gCCUn961Z
 C4Y5aG12BVtEl3wN0GnRs2fmxXjCNm/nrGs+nhUrxuxT3gvtQACuNcVFsLZrDebrOucT
 fXb6Pn4DbMYiA07b8XxBai14yDVDpzKzucYTXOUZh5BFbL33GygS7WGIzi+IWgDRKFXH
 wZAzwMuBreFqRwgnqYwDm6sVX21fwmoPHuUv10C73hhoQ1hJCjE1T/b41rkbXqwInorp
 FStdgo4gZ6ZoBTUljb1jpZl8jTJVgmqQacZWN3Y+RpUVRT9T/j1m2DOKonwshLLNUsmt
 igKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786033969; x=1786638769;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PCXH8C52W7ZK0seF8WFhcvqgDynyVjh/s4U9YgqVZlY=;
 b=tSGQmRqVzYHGzSklou20Uy5ZanTn8mYrA2F9QmxcCC8jpz3lrUN82n4D1LBRPGRtb0
 XEXI5/xqvJoIw+ljXvhFGNab8QAmiMoruhWVam/TPtuTPzHCzXNzGUv7Pibv/ESMtyiA
 Psfye29p5Nps4+LhLSwPV38dW5N0k/7dk9IQm9tVWH3Idyn3n9m0eRSZVVjFD9z+9gSn
 ddbDnh6EnQtCNMqht3Jtop30GthevEjyfljaYhoeZ/tItwuafxY18ZJUPKCoOt2mXEA0
 9/Za0goygKE7y1hOiPUyfM4ZU8si0kokWiD6tnJdWiBe9fIkl9G8xpqrETZXNjGg0yQo
 830w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpYbmruUR6rlpoWgFoVCoVwiwwM2WOdeSJSpCoNImT+AQQPMr/EjmmZM8ufA4ULiki2iAwulrBdCBWn@nongnu.org
X-Gm-Message-State: AOJu0YxxqUCZM2C5pbCaQFENfCx/kI/G3HV+Jgu9WQhgZeyw8wZgkAS2
 M2od2o0jqfL237WO1PRDldjQrGlAzOYzKdl3cR8KYdXeShrUVe1grAwa1ql9GPW0xaE=
X-Gm-Gg: AR+sD13HynQ+D6PK7WlUeRvMHIl0SNx24ykchcBuZnZsOkpjuS4/zgb2aOJfmuQne3D
 zE2r3ZAfU+igJ3Zy2IqsVmrQ/Spn6yXFKkhky0O+16rU5evppn07t4soy7rnU9UjyP6j3re+bNj
 MYEEbudOpNFQC/9w61RyAsKdaX5DtEzPFoBcfTEmyFLDQbPrc+LV39fw2NOKv+eY76d1kelJUZ2
 bBAkvNWVvtV/H2+IcMbBwDYSDhQ2owduk8SyYX4ZxhYrE1dyi+FZL9EU01/4TnT+aRzyzD/pHBJ
 I0JRAZj17G0ldLNApsA3KtVXfzaBW+vLt540vNuENdwb4M+e7+WdH2JHS9lqF9StI9ZJ/rkwyOl
 TLbr1nO8cTTWiOgHGPS3t/1pbPy6Z7LAclLnEzPRNeUUT6Y29x5yhaKLRkwr31Vgdq6iWnPkvIn
 lMKtOn9mG/9F6WSjfE2qGdN+dk0xDqYRIDFat2ScRi7hM3mm6FHp8bD8oQpSypLaunMGMq+RNPf
 isSd17ZrV//B9k1X+k1XiZn/OJv
X-Received: by 2002:a05:6a00:8d81:b0:845:e9ff:5d97 with SMTP id
 d2e1a72fcca58-84f2e025254mr20640793b3a.12.1786033969100; 
 Thu, 06 Aug 2026 09:32:49 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84f45389e68sm1723037b3a.4.2026.08.06.09.32.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2026 09:32:48 -0700 (PDT)
Message-ID: <4add9dd6-85e0-4149-8670-705225e18f8a@linaro.org>
Date: Thu, 6 Aug 2026 09:32:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: fix incorrect decoding of EXTRQ_i
To: Simon Scherer <scherer.simon89@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20260625155613.192643-1-scherer.simon89@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260625155613.192643-1-scherer.simon89@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 6/25/26 08:56, Simon Scherer wrote:
> The decoding of the extrq instruction with an immediate operand (EXTRQ_i) is
> incorrect. Per the AMD manual the instruction encoding looks as follows:
> 
> EXTRQ xmm1, imm8, imm8   66 0F 78 /0 ib ib
> 
> The /0 indicates that the "Reg" field of the ModR/M byte must be equal
> to 0 and the XMM register operand is specified by the "R/M" field.
> However, qemu incorrectly uses the "Reg" field to extract the register operand.
> 
> This patch instead extracts the XMM register operand from the "R/M"
> field.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3611
> Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
> ---
>   target/i386/tcg/decode-new.c.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

