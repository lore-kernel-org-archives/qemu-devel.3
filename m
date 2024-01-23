Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780E3C47DDB
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 16:37:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSJmU-00075B-W7; Tue, 23 Jan 2024 11:37:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rSJmE-0006yN-GJ
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 11:37:32 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rSJmB-0002a3-4m
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 11:37:28 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-559f92bf7b6so8158047a12.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 08:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706027845; x=1706632645; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=usY41eUzvkiHlTGvN4HbTI5QCF83cM1nTnbncS+87js=;
 b=T4xtt1V8EpiNWYebGIJ6zb/6gQtf2n2Le8QmDIX48y85r9XDb9f6f0AjjLwMXMjvWu
 IBOU8gkXFEJzAW+N/PBtquR40oBjSRCsAv7U7UqplM93imvjTifVoy0SL76UgntY+URd
 2MgUTAxSjdoVwBkPQ30pionCiXZfNGByoeSCpq03U48eUre4HaIdvIz5/GFLZqUzO0Zk
 vRYn4iawQa33Gr2LHItIAHCffQf7ua6M7T/bEPu/wPaIKAr9IuME6iq074/Y2RMn2xyd
 UG5LwTbXC5w7HFs/dCySlzWirq1+NPJRaLSCK6lTb8wWyNuOhuGe7QduSWI5GEVFcHd5
 Bx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706027845; x=1706632645;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=usY41eUzvkiHlTGvN4HbTI5QCF83cM1nTnbncS+87js=;
 b=MMDagJrvQOMxzS9vZ63r15rdZSrRVO9BzmI/zDFR3fb/qLGOI5xnS9FEfzc8SZzT5O
 BNCiQcHDXoNccaqWsJ5wc4JhSFE4YaOyTCYTx2WFV6dcSB9VAUz5kL/j8kUqe9QDP/jJ
 KuIlBcSZTl4x/ngQ6lFD0y3/SG15IHDgOEWY+KKlJZYdajCW29wqfjYUKa2DkIRIf15o
 nmZlzsB4OASRQENm/12TjZ2vAcQhTtwDmQQPxFWWXbmSkPaPCN6DRlnBaD0AcUMFHBmm
 zNSDMy7UXyg85Iru/X4PkzZJABw7IK0Mire2spbEgf6zEYBobwvlvT2xazdXiSoaDCsR
 vk/g==
X-Gm-Message-State: AOJu0YzrPgwg1V4ekv3i/PvKNU5i8CxGSAy+WSEZsVdcketZwNJmU+OP
 JSuHNyjUuWKEk+T1rdZ9Cu2REICZOPh8LF70sI/SyUisCYs74/ODjMx0qq1e5z/upXs2IPqxTw3
 Dh4DoTexQCnW9HMm3w22FAlNkRZh0hCWB80+3kA==
X-Google-Smtp-Source: AGHT+IHENleDekqy37Cb71Bw/jLXERZ0hSghGMZnJiaWaGfwKnjjfzgfnQu/Lx6C7Gz8P1p4TUbDMvX2WjE9hUZ7UxM=
X-Received: by 2002:aa7:de0c:0:b0:55c:8d17:1bea with SMTP id
 h12-20020aa7de0c000000b0055c8d171beamr1140754edv.17.1706027845209; Tue, 23
 Jan 2024 08:37:25 -0800 (PST)
MIME-Version: 1.0
References: <20240122063501.782041-1-bcain@quicinc.com>
In-Reply-To: <20240122063501.782041-1-bcain@quicinc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Jan 2024 16:37:14 +0000
Message-ID: <CAFEAcA8zUMvRjKZqUKNYTG7OKzRBi-yb60f3=JEY=Gep0KeYWA@mail.gmail.com>
Subject: Re: [PULL 00/15] target-hexagon queue, hexagon docker
To: Brian Cain <bcain@quicinc.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, richard.henderson@linaro.org, 
 philmd@linaro.org, quic_mathbern@quicinc.com, stefanha@redhat.com, ale@rev.ng, 
 anjo@rev.ng, quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 22 Jan 2024 at 06:35, Brian Cain <bcain@quicinc.com> wrote:
>
> The following changes since commit 3f2a357b95845ea0bf7463eff6661e43b97d1afc:
>
>   Merge tag 'hw-cpus-20240119' of https://github.com/philmd/qemu into staging (2024-01-19 11:39:38 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/quic/qemu tags/pull-hex-20240121
>
> for you to fetch changes up to bbe4209c8b4300d722f47791f9151e1a69cb0135:
>
>   target/hexagon: reduce scope of def_regnum, remove dead assignment (2024-01-21 22:02:48 -0800)
>
> ----------------------------------------------------------------
> Coverity fix, cross toolchain update, switch to decodetree
>
> ----------------------------------------------------------------
> Brian Cain (2):
>       tests/docker: Hexagon toolchain update
>       target/hexagon: reduce scope of def_regnum, remove dead assignment
>
> Taylor Simpson (13):
>       Hexagon (target/hexagon) Fix shadow variable when idef-parser is off
>       Hexagon (target/hexagon) Clean up handling of modifier registers
>       Hexagon (target/hexagon) Make generators object oriented - gen_tcg_funcs
>       Hexagon (target/hexagon) Make generators object oriented - gen_helper_protos
>       Hexagon (target/hexagon) Make generators object oriented - gen_helper_funcs
>       Hexagon (target/hexagon) Make generators object oriented - gen_idef_parser_funcs
>       Hexagon (target/hexagon) Make generators object oriented - gen_op_regs
>       Hexagon (target/hexagon) Make generators object oriented - gen_analyze_funcs
>       Hexagon (target/hexagon) Remove unused WRITES_PRED_REG attribute
>       Hexagon (target/hexagon) Remove dead functions from hex_common.py
>       Hexagon (target/hexagon) Use QEMU decodetree (32-bit instructions)
>       Hexagon (target/hexagon) Use QEMU decodetree (16-bit instructions)
>       Hexagon (target/hexagon) Remove old dectree.py


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

