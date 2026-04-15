Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E58B3F419B6
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 13:40:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD0T2-0005Dg-GC; Wed, 15 Apr 2026 09:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wD0T1-0005DN-3i
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 09:39:43 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wD0Sw-0007NO-0D
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 09:39:40 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-651bf695701so1853785d50.2
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 06:39:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776260377; cv=none;
 d=google.com; s=arc-20240605;
 b=DzYD4+JgWmb96jkkLL5MkIe1uQ41H9dX5V1Ps0hCbV9pg/5op1n7U3bR9uvJe9moJ/
 RJ2ftRiyBXTdzPvLKBp0HTBi4OT45Gwba4Mkg3b257ccHKTQ7V1kxqFQDTDW8UGZSPlb
 xv++lhOu/zHdOtbiyF9xyEGg0eMubH6oD60tNqGytIP813dQ8f2sqMT/2vGcOMgChHnu
 2UEjEKCpwkGOda2kFXSQKECzxLZGkUrZqbcsMJrCkZnQz3CAhpFoKDF59+iehhqH46G9
 r0fbHmgn8wLZS935x0T+/Y9r3T5+cpVT9GCuWkXFQTKxSZKJclbnFy7sc+SFAXH5LTI/
 ZnGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rpP+7Fu4pzw+MKsOG8lqQFGEgCtoctLLSSvR6dXTRyw=;
 fh=dYw5aCcXqLPd9s2S+adU6r/y+bA6SHXCRZUhbq5C4Wg=;
 b=Jb/muxb9SGBeaXg9e97zbTzZu17AKVdzDgxS6Fc4nRCePk7kJQwNJdJhiLN/Q8ReLr
 3g5LWnjnkxXsg1ZDuQKUQYDoN2hkH2Hfilcb43vzlm3vq+TOWVTPErH6tKfIg9HVMSl/
 oLpJyS4cCeydHKE54QcYGUNDWpbmibb8MTSjzKBEexSBmrlTN3Ar9IU/fJ727uBWAKvs
 9v7Z7btUKNGcJeCpa2vJvT2QSwCNXJOypIeappOrnKLwYd7nNqsml6Tl+AVQtbFkhS3N
 5PwUqjVaqV9y+z3H8pEG4ekJWfm+Z5LRP/TBv5tfa4sSNN36RO9FKyjbjjQe/xDJEFpg
 SjiQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776260377; x=1776865177; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rpP+7Fu4pzw+MKsOG8lqQFGEgCtoctLLSSvR6dXTRyw=;
 b=lNC5YdN1JJ5MARqdFO1wvO62qu4kkBItzrhB5Ui2Z9u1psJUHPAACkmXQOc8M9p1Ye
 ZhLGWTAAfDQphLtZM3RWEtWirbrwi63PeLjU/iCkWnrRRmVpa42hSTTjtMMOLAC2Y20T
 aIV/DecZwHAN8R/15XslJu9Mfm/vreoODnQDcV2tyBa5VpuFED/8XpI/ZDEMOwcytpiK
 YqPpQrtpL8u23Aa8QNX02MNm9TFIIAYUauC/5fNN7nKtuX63V3eOx27oQ/5GSM+82B1w
 g8X84o5a+J51jKh19d2XdPEkNnfTflUdh+Lpdu0Sg5fxHdObKMI8h6PgSIRAS/69WYfi
 w3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776260377; x=1776865177;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rpP+7Fu4pzw+MKsOG8lqQFGEgCtoctLLSSvR6dXTRyw=;
 b=f349ZvowRGjFO4aWUi5IJccNbyrNCYuq/rQuilrlNOTUhTQjUudI2aqgdsTU+vmYO3
 u5D0MUzSmocCuRqzzTSQvKqMtPgRrgvi1WEuAuO+zSS8Q6tQDRsRT6MHRIG82h8irZYm
 /gGUN9LsG/I43fsZimp9hqK3nD356HNsyHK07eU3kFEfPyGkn5DZ9sNJraf52o+dyvEC
 a7Hgb5Yqx+PTAPGksAzOOmkQhUG/Iwrt/pWD5TiauNa3gKFP41941FaNIETTw/cxVIZl
 CCmYGsOgBHqfRQ30EacjAaMxIJsr9andVwr2pCRlVjbDOOOCPUOPrRtrf41Dd3NiOKal
 149w==
X-Gm-Message-State: AOJu0Yxn499rNVw2aewOLst7wiY1lJDj/+fsQ2lFBhujgQus/G7XQNd4
 gVUSmeFpAi4NdhFfjFx9goAA6mhD2NP+Xq3aM2LRbkXyZZzFzK5VkYREx5Gc+ENeU0mGsFJSnbV
 d5auXCMyUYqRU6HJwRh6YVqReXns3KxFHEYAsZdQYOw==
X-Gm-Gg: AeBDiesZ3WdULbbp2Bm8PEWfnsoMvplxNy9LaZtwacECt6IV3QXEPwY0oG6P8AAuiYP
 Es3F3BKMeqJuKmNgBwGa9eFIBssdQByeqPqcIIpuPK1UdR4UKf1bQ9MI1NpNxpSa6Sv/u0Ws26y
 t8t2fUCoeWY5g396ef+1+1OWhyLgxW6+coKSkY63w7eX6+gbLaccqu5qRQmrh7LsNWnLv1hs1WI
 a+Qdn41RXMmtlpRy2SGqB6j829RSXa7+pzyszJUpxcf8gXvq4bD90NSVhzGwC40GoQettc9ZqFB
 Q96QQICg/ohLawnWFaUC2wbQeX9NfWi73/DzobZZhYo6Aj+UM6J1xMcHpuRNG85YV3EST9zlFjV
 2fg==
X-Received: by 2002:a53:d007:0:b0:651:c047:f094 with SMTP id
 956f58d0204a3-651c047f43amr11519226d50.31.1776260376710; Wed, 15 Apr 2026
 06:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260410194227.16357-1-philmd@linaro.org>
In-Reply-To: <20260410194227.16357-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Apr 2026 14:39:25 +0100
X-Gm-Features: AQROBzDWyyWZlWUcLBju42JqJHFmLU1ZA4SfWFt0RryHZdkDjzW5TpAZKwFWyuk
Message-ID: <CAFEAcA97Tx2OYu=6fW_TbsR44hJ96Q7uhsq0wndSr-NA3yuT-g@mail.gmail.com>
Subject: Re: [PATCH-for-11.1 v5] target/arm: Remove target_ulong use in
 hvf_handle_psci_call()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Alexander Graf <agraf@csgraf.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 10 Apr 2026 at 20:42, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Similarly to commit 3580aa03547 ("target/arm/tcg/psci.c: make
> compilation unit common") which replaced the target_ulong use in
> arm_handle_psci_call(), replace the one in hvf_handle_psci_call.
>
> This could be vaddr, because entry is the start pc for the on-lining
> cpu, but we prefer uint64_t because this is what we get in param[]
> and pass to arm_set_cpu_on().
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>




Applied to target-arm.next for 11.1, thanks.

-- PMM

