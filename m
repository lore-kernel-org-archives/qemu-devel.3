Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27234C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvzBa-0000IK-6v; Mon, 17 Aug 2026 11:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvzBY-0000BF-Ag
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 11:23:36 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvzBW-0004AD-Me
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 11:23:36 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-81e6f0b4610so36052717b3.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 08:23:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786980213; cv=none;
 d=google.com; s=arc-20260327;
 b=XR/Fw/RxAEEUKxttm9fToquoHgUHgP5CxDvelHT0Tp2d9MT8vj/9iIUBzCBjS7w680
 7INxZi+P7c2QOi+7W2x6ppbYInrTnS5wAblGX4j4Ur3X2d2XB9HQBlaPOkIKRg/Aln70
 dac8y/3mPoiqPLjMDQf0dskqZr5S8z6Jcf15f6uUQ3N9tV9VD/GzNudvdM06JGe02KSw
 XZBdA6cIoASSror/YHdvE7O7mXlDjisycWSGA5wbFhOSlSHKr9RCoblu4HIlQ0cLJ6cr
 ypi9BxeTM7kp/Vgp0bDrwFuIX/DVZp8j1kJ8VqeflrOxieKaAt7c7VuMs6TCLGvIG7qf
 mRDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fDUUXlrS94PSLkYqonthioUjC+HhEl2gGJd/qSapbD8=;
 fh=xChv7ieWS1sj6jE9IHpGYXOFSuW+3i48YUpPGYmP/DA=;
 b=mso9BJmEgnqHp0oc7O+un28RbTm984uR/XyZ0J97bn5Qum4w66gekBNaFuSSLFIIhl
 jWDrhZbYw1DFmASzM25m2oCPDWJxeZf7oYRJx6f85Az/xMQTGEfzwOTcJn3m7bMgbf9D
 Ah48vG3Gh2sMToMo5/h04SKqHUdpcvmXY3d7CLL3vtelemHHvI5J19rrYiM5Zhgd6+4Y
 6yT73rMM9H79UQF4BWCpMywHCaDbsUBLrg3GDcW+cldDfrn3pCEkCnMcRheTIAI3wAcJ
 84xnRYO1M/uSq/S2HBGT1FUZAH8AJYu+YgrECzmMbh1e/7Wpylpm0fJTdwOgB4XwRh4U
 6WrQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786980213; x=1787585013; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fDUUXlrS94PSLkYqonthioUjC+HhEl2gGJd/qSapbD8=;
 b=gH6gGYtyWj1IBFxYJw6XUMNe8boASEd3CI4DF73EfZQjWZNG30NZt995mi+Ttde/WM
 aeR8ZGcinEfSKQgotr2G5f1apIHy7dURob0Bsnl3+3IYE8XMGGmutV9zs9fyAEQQKx4d
 +HgFSPvDMyUqt9GkV2nOjychWRBITzIMrXIGP/U0h2FemQdA0FRE1db43qaU9W1kKeTz
 joMYw+UpPtF1XXcZn/m6cYqdbQD5iOv+qctnteEV0GUcqWvq7CzkSNVo+o9xrFjk3/BZ
 gGt3ZVI5xVof+OVTMDl9hmCiu3BSYkMr6EINV1EQgtRPeBw0EobcjrAPQGj2hId1/hy1
 Jh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786980213; x=1787585013;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fDUUXlrS94PSLkYqonthioUjC+HhEl2gGJd/qSapbD8=;
 b=btbcFriHg1CZGFwFzKyMYcnXKOQ0+hqN2H5cQ6GULjwjglrtudQQH88Ms6zAmCBStd
 NuMWKNV86kDAbZzS5w3HYXFuO+3P//eRwxJA/+41DpvQAnmZLe1y8eKJK6/YkykZ7pl5
 5AiW5VyCYfE7j4CzL4qUHXzm6mTmsBuP4BbtoGGawpV2tDboTgIEPQp3SWEMA9yhA50I
 pUmtog4KohChQIpiXn60ERugL65gA3u+TAVw5a88mt4wxI7NW7uV0Hw52q1L6Wc0SE/T
 3QcE0pYtJl/EZvH63Lnj/F5L6r1f7tcOgLiZ7wcVNa3eVyuhw8S9hfUnVk7f7fXxEPo6
 dL9A==
X-Gm-Message-State: AOJu0YxoteDyY4uSH2KSUJO1ATdSfGkjLrOQTrcD/liksjWNi2/VJ9W1
 gsjPRE7a72SSFvu1NVqpSOMHyj3OrI/hM4qL3w6Te33Sj8XbasO0V7BsJywuN+cAv4oSz/vOwrh
 e0rnNArzUSIjMc/1ZKpHN1Ga7UbGYThRIrRQZTyA2JA==
X-Gm-Gg: AR+sD11nIXNGMDywCPN5HHEJPsDwix/kndpyjX2oHO5v30V+0VMoalfFtsZWyAbTOnB
 0apmtrj5/65SiGCND3xKgIKjBrelwEPrASdRiysW2iyIn0R9R4h7acswCRBtE5g6563w4GMAuM+
 Q/6IaudXtIfyBQV+u8b9RQbi1GB5RJglKcCVBfMtUaxhAIKOZAbw1JupJawjMwZhW+dAC2l+CiK
 wJAPhxfBL6so/VhGqsA3YsmXnODbfh/Rlp77Irt0f4IcRPwwnIeHjsZ4zocjthEDAT/UZSQvV+n
 F3FpQMvga6ZPrZ8CXAHjunC4mkxi2y4tQb6f3eqeBlmcTw2uVL8ohqYkv8Kgoi9UsEhan0VdMjk
 9CVP8T+lNEfpxwc7sHO/WX4mI8HfD
X-Received: by 2002:a05:690c:e0c5:20b0:80b:bfee:c427 with SMTP id
 00721157ae682-8412e0cc751mr5377617b3.13.1786980213165; Mon, 17 Aug 2026
 08:23:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260805153005.9989-1-simonxhy0404@gmail.com>
 <20260805153005.9989-3-simonxhy0404@gmail.com>
In-Reply-To: <20260805153005.9989-3-simonxhy0404@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Aug 2026 16:23:21 +0100
X-Gm-Features: AcwNN1W1y2f7Yk56Rwnh1OFm4MUWsAs_WaBVUBI5wYi0aEQS_S0MYd32W85WnA8
Message-ID: <CAFEAcA-1pdwBn4cEVwb3xy1P+arWeqG6g3NmkeN+s+NeQKOygg@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] hw/arm/armsse: add Arm Corstone SSE-310
To: Simon Xu <simonxhy0404@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Owen Giles <owen.giles@hpe.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Robert Elliott <elliott@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Wed, 5 Aug 2026 at 16:30, Simon Xu <simonxhy0404@gmail.com> wrote:
>
> Add baseline Arm Corstone SSE-310 model.
>
> Device list changes between SSE-310 and SSE-300:
> New NPU0 Power Policy Unit and Configuration interface.
> All other devices are the same.
>
> Update comments in include/hw/arm/armsse.h to include SSE-300 and
> SSE-310 and their respective documentations. New SSE-310 IRQ mapping.
> sys_version and iidr values from the "SSE-310 with M85 and U55 FPGA"
> documentation for the mps3-an555. Refractor comments and code
> pertaining to both the SSE-300 and SSE-310.
>
> Arm Corstone SSE-310 TRM:
> https://developer.arm.com/documentation/102778/0000/
>
> Reviewed-by: Owen Giles <owen.giles@hpe.com>
> Reviewed-by: Robert Elliott <elliott@hpe.com>
> Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

