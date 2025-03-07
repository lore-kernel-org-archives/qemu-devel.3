Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1513C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 10:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqV8n-0002oh-9Y; Fri, 07 Mar 2025 05:41:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqV8k-0002mp-AI
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 05:41:14 -0500
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqV8h-0008Lm-A0
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 05:41:14 -0500
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e46ebe19489so1284291276.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 02:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741344070; x=1741948870; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Or8nid5ZiXi3yxl/7VmAKOyJyaMIwbEgpuB/hf5xtIQ=;
 b=gRaBxdCJTNv69zk5nxw5GahTLC83/ZndfQUslkyCzi61Og5YHfn00103j5ZAaqrvgz
 Ad64/g2J/N3bqQs9wIo3dkRvDMXD9UJKW7/3NhwSS25j03bGrHLY/urad+EDcyqEgYpa
 wwHzdkWSwHMZoP2F2Y9ZHHPM88CVM7CrQNUrKbky8iuklcntl3UorbsjFnxe8T6fRhJW
 maPdlm7ebQ8/ndZFmq1LCi7So2QmOO6eDQ/sir9yVh9DRP/2Rei/0RmL8anlBZthk3Gc
 FPS1WzBsHBWCA7Pm96j1DONMeVJrfds7mGwHbfwUwjTkGsSQuLG1Xjc50d0+IfUbt1fp
 3W2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741344070; x=1741948870;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Or8nid5ZiXi3yxl/7VmAKOyJyaMIwbEgpuB/hf5xtIQ=;
 b=hJjpEywQbtJOeIKVwHnPdsYSPSp10lEq5vl5m2cMjEI48snqzhWyl02RYvS/BDaFqZ
 hBopsXI85UoIFdSG4DQwNWhFYKGWSZxlf+dDORCG/L2/xAywWRVKdW4LE4bKl7L2AV+V
 DwtMETRJC9qLEaDeRRoBNnD+nVGtNEL/z86bLjzLOwDT6UT/mFjwQdx6GqYdNwS9Saeg
 q2UAOgnaNGwbcSndAK4S+7wxT49nbl+T/4CSxOx5k+jA2k2HXVkQRL7mTv15V6xXEmNL
 x4aOknqlYPleh+PUzuejExHlM8cHnORTKRVvu46OMnJodscoMK87HYWd0nG01zuZHc3h
 qyYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKTDBmj3n0EykawEY6xvo+sgecBn2AShOddawYS/3yfxIhdipXcbXsSFY1iIq83BZpiB3+f9KdGrpA@nongnu.org
X-Gm-Message-State: AOJu0YwMmMkbl/a66PF2BPwiHtZ7tjV2+O15Kc+TuX2TuLpZtsoEmdyO
 koiL2L7nUZvzaJL4UHUYIsUFsX5DFKGeJByvMcUMKF9dR/QsB+hVHrhJJ+k+Jbz9o0ZgJEFljWW
 Oyy83tePOsnEC/Xa0erdvsb/nIfKx3MPYMQHLig==
X-Gm-Gg: ASbGncvTJbTRDgGM8UX65tiJy0nPF190PrEBhLSel1xF7qOvdecuiK+U25RB1p98aXI
 DsRkLYY4vBm7iQNwgPSxPVWVac2vHPK5GcLqrvM0DMWR+Iw08cHiioy7XqdW+1cCFhlCAUese8v
 EXUbInImUn9ZF1TibkYhHcIbSEXcE=
X-Google-Smtp-Source: AGHT+IFzrYzPZFAlAn+/swqFCr9qte1Ec2VPxUIhV4b+ZpfQUohk6+l07F/6+QStoqcr0ni6LKa23EsdVmzJTvG+pd0=
X-Received: by 2002:a05:6902:1b8e:b0:e60:a16c:d01f with SMTP id
 3f1490d57ef6-e635c1f4d28mr3524529276.47.1741344070188; Fri, 07 Mar 2025
 02:41:10 -0800 (PST)
MIME-Version: 1.0
References: <20250228174802.1945417-1-peter.maydell@linaro.org>
 <CAFEAcA9RPnZdf5zqFwu255-LdJ5inFbjtCA8SJ4o89aiUuabpA@mail.gmail.com>
In-Reply-To: <CAFEAcA9RPnZdf5zqFwu255-LdJ5inFbjtCA8SJ4o89aiUuabpA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Mar 2025 10:40:58 +0000
X-Gm-Features: AQ5f1JoIK5vHYIdC4x-PFgjp35sYufdDTGe4cFGEW41goOLjFhItfVdX-p0j9_M
Message-ID: <CAFEAcA8+oA6jJPrN_o3VDbSETyZugsFrRZH7uUSP9i6KdQE3vQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] hw/net/smc91c111: Fix potential array overflows
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb35.google.com
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

Ping for review of this series (and the other smc91c111
patch I link below), please?

thanks
-- PMM


On Fri, 28 Feb 2025 at 19:22, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 28 Feb 2025 at 17:48, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > This patchset fixes some potential array overflows in the
> > smc91c111 ethernet device model, including the one found in
> > https://gitlab.com/qemu-project/qemu/-/issues/2742
> >
> > There are two classes of bugs:
> >  * we accept packet numbers from the guest, but we were not
> >    validating that they were in range before using them as an
> >    index into the data[][] array
> >  * we didn't sanitize the length field read from the data
> >    frame on tx before using it as an index to find the
> >    control byte at the end of the frame, so we could read off
> >    the end of the buffer
> >
> > This patchset fixes both of these. The datasheet is sadly
> > silent on the h/w behaviour for these errors, so I opted to
> > LOG_GUEST_ERROR and silently ignore the invalid operations.
> >
> > Patch 3 tidies up the existing code to use a constant defined
> > in patch 2; I put it last so we can cc the first two patches
> > to stable without having to also backport that patch.
>
> See also the other smc91c111 fuzzer fix patch:
> https://patchew.org/QEMU/20250228191652.1957208-1-peter.maydell@linaro.org/
>
> (if I need to do a v2 of this series I'll put that one in too)

