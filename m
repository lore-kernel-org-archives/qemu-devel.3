Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF27C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 19:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhv6Z-0003jm-Lz; Fri, 01 Aug 2025 15:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtZN-00005j-F0
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:29:25 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtZL-0003oe-UA
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:29:25 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-710e344bbf9so12286247b3.2
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 10:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754069362; x=1754674162; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5BAPjLWU16TkjCq2WfRmcVN80javjTC1goDdwwNbjOM=;
 b=yu9beCsIcOQ9CfVU3WXgTejN2m3P8SroG0Paqy8ttoVwgTfHLEVMG9yu99lSIgdk+s
 WWevqxOTgS0LwKaGWmfEQNnL4PFKdFSDME0eqHqhLsKNHYmMN1O+2CfR6V7IBfeslhpm
 Wt9QZO94vOpAEwl/IxcHe4mFnH1FQSvUPZWTkjv3JPX6/+OklvaTspPJxt3Mf2Dcd5H0
 Cn2fmuXLWQ4zfcTr9T7kt9GrRXU0BQpxemjcwto6t37H0p7qqifN/a+YmLpruFDpmUWo
 N4uU+GZSsJWMqx9hzMKIKAfFrZ9uIKnX/+Iz03sM5X8s1/BRD8goBQbe1h9/EdvHmyil
 n2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754069362; x=1754674162;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5BAPjLWU16TkjCq2WfRmcVN80javjTC1goDdwwNbjOM=;
 b=IzKydQXpY8D2G+wsH0IQjFFS1I0CyDVj6JGhhBis+V1036KcZf+83JJz98QcJtmTjs
 jCAcvD3SM5bjMSo/iE7ouukLyPCrutzTcFyeFko8AeIZ/bbMGDPnUGKpHA0hblykZ4cO
 zInWqlPVuMutni5bjt9tbL/KiMj2RnDcautu/xNTBj1xs08E35shgJdY36XPNNrE5TBJ
 H/J+uWJe8V2ytXhjDasrtFAkpZX5c88NHmXdBubpjFSJyVjDIwEIddVRgzhuU6l56Yxy
 FVXq7h8KDG8VeOpygiBfA+skADRrZwAcn1/gWlMyRG/EY2iImDJxM//gZ0pORmTqiDSB
 Slrg==
X-Gm-Message-State: AOJu0Yx/fjVUzD/k4BD8FWtuhHmo/tHym+Wfmi6amkpmDiECd1yZylqZ
 5o2B1Rc41L6k15UGhZGhNCkhjETx6emx0oJVjNPAr42HGdsff+fZZ5y1+WlzrGgzP1DWOrBB6kU
 6K3+mcKhT8Hzj3mYHrK9Gf7fQh1F9pudMsdRp8qo6GQ==
X-Gm-Gg: ASbGnctSvXnZY18C9Nhpheppt4uU8ya2lhyE43Mt29e2fTIS3zHbxA5rv/cw3htidbI
 PhP3wbUNw8TBaRuzrdUvUEqhrn8TI0Q6Wipa7jc78hhabKbY8wLhZ6ufPCIjY97UYft8jjpfTiO
 F337nCQ4+xg1+qe4syVag1RzbQA8hB8KaXDe8BWoqyh7dOlX/OFeZV/mAC7shSJ3P9P4hjhOwB6
 YMfiuR7
X-Google-Smtp-Source: AGHT+IEcaUHsKODTPLW4TWKhz4vZOr6NiLNxwhKrvB4dCBl/kCkpUwe05QsaEMbW94ejvPyfuDm8AD12eUFAhvOPhF8=
X-Received: by 2002:a05:690c:4481:b0:71a:2cb:db1c with SMTP id
 00721157ae682-71b7ef6619fmr6911147b3.25.1754069362168; Fri, 01 Aug 2025
 10:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-32-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-32-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 18:29:10 +0100
X-Gm-Features: Ac12FXzYKPSfViTMajOwyhQw5ct3lLf1wvoy0HGP_N3TA19WeMV9JFNSFUUqoV0
Message-ID: <CAFEAcA_kzAUpCnyj=RV4Fm65zg8dX5HBjeJYLJ3mfKtTiJbh=w@mail.gmail.com>
Subject: Re: [PATCH 31/89] linux-user/openrisc: Create init_main_thread
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Wed, 30 Jul 2025 at 01:25, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Merge init_thread and target_cpu_copy_regs.
> There's no point going through a target_pt_regs intermediate.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c           |  7 +------
>  linux-user/openrisc/cpu_loop.c | 11 ++++-------
>  2 files changed, 5 insertions(+), 13 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

