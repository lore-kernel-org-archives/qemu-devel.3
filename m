Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF75EC47BC2
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 07:36:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd1bG-0007mR-47; Tue, 06 Jan 2026 02:35:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vd1bB-0007lk-MP
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 02:35:26 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vd1b9-0002AB-Gc
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 02:35:25 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-78f99901ed5so7811407b3.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 23:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1767684922; x=1768289722; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HrpAM8PPAYXD3CaG+xN7uoTPiVzRPR4/77s+xJAdYlc=;
 b=MtGrL7HM/bMJTyGGatIwoOqRA70WBMkRn77MlHmI8mUOyiggcsuPJos7j/cAMy5Km0
 I77vB/xgsHuYqJsSdSctlsuqRgw9XcVJ7G8auzXywJges2ZzkWue7luqOqXwiP75Kqlg
 1l5U8OamyvbSWHEuGlAH6NZY23H9YbXXg5744=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767684922; x=1768289722;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HrpAM8PPAYXD3CaG+xN7uoTPiVzRPR4/77s+xJAdYlc=;
 b=YWde2pwJPXU1DLQsxAGzAAkSD8MT+HKTNs/zfADZuzbIv6/yeG4tGJRRYXFezC2B2n
 lkvytbx7lVhqSQxdZQTjz4yBsCuBEoPxqhwXLLBt2Nqir3g5Oz2wQEucMz8tIOgQLITS
 gbnFC4ITN6IfOlyoIZHj+zfuphJtjb+9R7GdvUgWh9WDahAYHRVksLDQTEgExsO95mCc
 xjwxGRqVNz28nrXTuPdR7/Yiuey1/e9nDGr2fQQ4ubwZzjrYH2JYKCI1NsFyjIi1JkYw
 vVFbk5tjmhxWGCkCNnnQbdvnoCrnHM2iVuRqHthFM/cx0i216LI/pMaudK7SWBtJjtcx
 +u8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUI+Y4+Zq5JwVkIztO5Y0FiAc3XZxjwiQwgSyrDcDXnT4saav/FSKMq/wy8Lcrh/g5VtYmmzqNtLS8@nongnu.org
X-Gm-Message-State: AOJu0YzZpjv4ZiOa4I98u2QWnX2fLOCvajEP4P+G4NP1Z4B9OsClYdaL
 CzYUr6Ve3GIhFll9l9UflQaOhMwAXWSV6uGHtQpHPczPr9PumF7FA726Ldi2fduUSqgt/Kcc3EY
 TpYwuqgXhvXUahdawpEbYtllpdWb3pnA=
X-Gm-Gg: AY/fxX7K9xfISX/mzE4+pNj9zVSRCO7Yv3QsEMfpurVM/u4PI5pgXzyG059sEsi3nNf
 rHSVjsNEBjHmER4gzhXoL3zFgnhNRQg/V1+SrehfDyaAPH/pW1I65Se5oq24RaKZIeeXNtLbQPa
 +8Ut04efoBCRPG3miZkhUNbY7YtCf0Ba/+d6jrY42YMCuYMGAq4Mj+yL/nrjt+ah4M+epWu74+F
 voRDLB3Zx1ahKkgutX9wvQ1qjHV444fdLDEgfAoTctzTZRKyKEDKFWntmwUwJfmNDRvUCs=
X-Google-Smtp-Source: AGHT+IFGKZ8TQn+HvvvVcZ0l+iGaaWXmSCfskRQR1W38NUTaH4+hIChH5MlQkupEQgo0l3f8W5JtCKMfQej4oTCZDV4=
X-Received: by 2002:a05:690e:1501:b0:645:55a2:be64 with SMTP id
 956f58d0204a3-6470c86ae80mr1817769d50.30.1767684922311; Mon, 05 Jan 2026
 23:35:22 -0800 (PST)
MIME-Version: 1.0
References: <20260106055658.209029-1-joel@jms.id.au>
In-Reply-To: <20260106055658.209029-1-joel@jms.id.au>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 6 Jan 2026 18:05:09 +1030
X-Gm-Features: AQt7F2oOcSR5FpX9BvHd7BXSeOwOkPt_9vCeeWSk18DtcRyfw8K2aM5R7stP4MU
Message-ID: <CACPK8XdxvLLsQxPqSyakxh2GeK2AcGeukcerswB2eyTfeghOGQ@mail.gmail.com>
Subject: Re: [PATCH 00/16] hw/riscv: Add the Tenstorrent Atlantis machine
To: Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Chris Rauer <crauer@google.com>, Vijai Kumar K <vijai@behindbytes.com>, 
 Sunil V L <sunilvl@ventanamicro.com>, Ran Wang <wangran@bosc.ac.cn>, 
 Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>, 
 Nick Piggin <npiggin@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=joel.stan@gmail.com; helo=mail-yw1-x112b.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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

On Tue, 6 Jan 2026 at 16:27, Joel Stanley <joel@jms.id.au> wrote:
>
> Introducing Tenstorrent Atlantis!

Note that this was based on v10.2.0 and passed CI before I sent it:

  https://gitlab.com/shenki/qemu/-/pipelines/2246526243

However master has moved along and there are now some merge conflicts.
I'll hold off sending a v2 for now, but in case anyone is trying to
test, a rebased tree is here:

  https://gitlab.com/shenki/qemu/-/tree/tt-atlantis

Cheers,

Joel

