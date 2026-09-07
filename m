Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297C5C79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 23:46:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3j1o-0000jO-5P; Mon, 07 Sep 2026 19:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x3j1i-0000ih-2z
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 19:45:27 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x3j1g-0006M2-Jr
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 19:45:25 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-66e64e6e3fbso3308605d50.2
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 16:45:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788824723; cv=none;
 d=google.com; s=arc-20260327;
 b=gNmIt+CQcj3aMN247imlJ/6Lutgqg6J6l0FVrBQYA3NKw4MzmUWnWnaH93HwDYv13A
 AggBjGWssENvMCZNMJCpSp/pqb3cDaJrK4YNQM/YOQB5DCjwGvZa8O43bSmmNjPigdiE
 Oky8SNpx9z5Figzk9/jUeqj29+XraxuqSGT80AXzo4DXEoz/QpBL9kfo+a+jR5BUp5aA
 l8sA3rTIQ1NQ/EttGsPUw3dZlDLPpnb1Evigu6uAZL39E6la5Z+z3/HoWNhBOWLqJ8ER
 Lik34itI8YijO4FTawKO3PSTAYlnkMFY/D7J5I0DlWR4gVXLEM6hkofWfr36IpZqIBW+
 BxdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=pZGxf1XYLGfpDHnmJT4XCJ6rkrjJ3E2fMgnK/QvciZY=;
 fh=nGOzflEC3gPvybHDFYEtQ4W8SBqP08hmOZ/2EdVuEM0=;
 b=RQN8lXmxc7xkC5KUKQWmeu1jZfBvsa/cr1HOp/vDrR2QArusO6boKKnPQOXQdFmDfR
 amPAdNRzPqFKbMHrgYzXR9bbGENf0wkFOgpWUBvIs+YRfNl7Q2iC97pG8Ldgadm8y68b
 cYRAvwMLmAShE78KIlzNaNFmv4GtJUI3svYEbp+JJ/kKra7FuRscDUDf2wNpywP+YoGf
 wAnzVAnrMn54uAmB5ZvZ4Vyssg0v4GkvZGkQZ4HRUNlURM6vwWjRTPm0S5LfVhr33H8l
 bDIkQSOReKzCWdnWtGch3lzUu9a94j0MjJk8qd2D5B3BGtcLV19IhpF3pcqbS+4DwaXV
 pm5g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1788824723; x=1789429523; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pZGxf1XYLGfpDHnmJT4XCJ6rkrjJ3E2fMgnK/QvciZY=;
 b=gYUDsWeVuCmgSSOBiodY70HLra6/uAp7jF2G8fRo0t49uRDWoQLpwpZj3Whmy4EGnH
 rBsVdkKb7Qq/m/V+y2xMxdY5uyL/2pMcu0EOMknE26ngnHcfMyiJllCRk5oqhpWihvXt
 bjiScN0e91j6Pq9WNarG061iOybizwW+z5K3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788824723; x=1789429523;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pZGxf1XYLGfpDHnmJT4XCJ6rkrjJ3E2fMgnK/QvciZY=;
 b=Ym5RUpWQn+2irFjFaEJW0DnFwinBI1SA3ACaef3slQMd3EEzRQKQVX5zEwZ2L1dOVD
 frZFdbSIkz/P954h9agDYfmGp1sA58s/EfXb842K210eqXetlvsLi4npneh4AUjx/uzd
 zL9+mbRcwP5rBGgZYEzMrg73r4XF77pSu3knYYtBfipG3D1DKCf7gGD55jCnKVFfejH5
 7+5iyMAlx4lRy9Nc12sDXG4ToI625gEc8o43tTXinEK3LKwSomtqtCnYc52iLlj1q0nb
 8dfDdPNJ0NlgFtClz+0sWxCri9QPPkjksk3jQ06aH3EQupyGy0Z44NEhT1T0qW3SkUHp
 BZqg==
X-Gm-Message-State: AFuF++nqcbyOxblkh84jPv9uJ9eS7iFQU/Bs97z8SXmgRH0D/1Diwuyy
 1bssO5G/6QxoztbtgXTN7hd8af97MHdPAniMr8iwyuxsvAMcL/RZj4CK0bjNYNedvfuu1ts+su1
 XcPM6upKyYpLBo3LL6XSiFaN/t1GYKtg=
X-Gm-Gg: AYBFou2kNAXlF1oB/RamKDy/bWdXxNTiagK9YZI0y+H+Ee/xk0MI4oW7KDhIwZfPrMJ
 5Mht7MDo+RLCeX9RT5nBVolAXVKG4j6nx9Id2z0Yv/7JSjo1Tda87YLf6a8D+ouqs2+2+zzX/tm
 hJ31IpB5ZtHrphwn35lkWgidGHhwB1BujzV8rDelHm9Xg0j4lLU6fMh5xv/4g7iuk9a5f4N6BHn
 fGVdpn51jmtagpHrDYGs3d0XV/8dLAxslDDC1qOUmTcsyTiGnNUChuwk+JOkZwPo9WwJRDivvx5
 5dXxfHP8A/n40CC1sXiok4x0qu13MA8zMtH32VuJ1U7hshNLoqke7zljP4e0Hxuv+JpTuni4noX
 nTgddszkeNuBwiNhuiFfEmmIM7H7ARaFo14cQYGFsmMoR577WWN9e1B4fC49JjwpDXazxhK/C+z
 0QC5uZlQvmyNFBfeus
X-Received: by 2002:a05:690e:b44:b0:66e:5748:e04f with SMTP id
 956f58d0204a3-66fc1b2721emr6231389d50.20.1788824720326; Mon, 07 Sep 2026
 16:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260903170011.3627720-1-max.chou@sifive.com>
In-Reply-To: <20260903170011.3627720-1-max.chou@sifive.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 8 Sep 2026 09:15:08 +0930
X-Gm-Features: AcwNN1X84fgBGT4YekBqrmYqvYXsNf34hVWm93A8cHkyMZha-z-AAkrunsVxuSQ
Message-ID: <CACPK8Xfc8o5kKbgZRnp+4nmSjUqZv9T6HbAJYZLFWx7=_9A0zw@mail.gmail.com>
Subject: Re: [PATCH] tcg/riscv64: Set vtype before whole-register vector moves
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=joel.stan@gmail.com; helo=mail-yx1-xb132.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, 4 Sept 2026 at 02:30, Max Chou <max.chou@sifive.com> wrote:
>
> According to the RISC-V unpriviledge spec,
>   "vset{i}vl{i} and whole register loads and stores do not depend upon
>    vtype."
> The whole-register vector move instructions reuqire legal vtype that
> trap when VILL is set.
>
> The tcg_out_mov in tcg/riscv64 missed the vtype setup before emitting the
> OPC_VMVNR_V.
>
> Fixes: d4be6ee1111 ("tcg/riscv: Implement vector mov/dup{m/i}")
> Signed-off-by: Max Chou <max.chou@sifive.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

Thanks! I had the same patch in my tree.

I hit a crash running qemu-x86_64 on top of qemu-system-riscv64 -cpu
rva23u64. Notably the spacemit K3 doesn't crash, but other (stricter)
implementations will.

Cheers,

Joel

