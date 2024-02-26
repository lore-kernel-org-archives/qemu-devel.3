Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA5AC54E41
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 14:29:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rebyX-00077E-VO; Mon, 26 Feb 2024 09:29:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rebyO-000764-G5
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 09:28:52 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rebyM-0005RB-SR
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 09:28:52 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5654f700705so4191578a12.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 06:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708957728; x=1709562528; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UaHnE8xFuk5fF0E94JeQzivSpvLKFREUCdWaCX88pEg=;
 b=TRd06k2Q7iG0RhknUoad8oQzxAyrEHiWuKJhsrFNb82mEK8pq6WbbSGtRujSZyb3gs
 qIBtZ48UkjfagV8BsFOJlTSyqn91Vd3k7mWS5vd57xxfXAqjqOG/LgReYFnwBt6pIhso
 ueTxZFhOOXtoEVp3EOIWEInj3eGaobji9nqi4R15A0xy4kYkpuM2lr13hu+ggIWLUzA6
 j2tvFDt0bGSXV6eaYdfcrOuCfqYLO3s9pyySEzHwiMrLtNLpAh/Pzs8bvBajotu+eq0c
 iCJzPpbsHuvs7Oj1jIU+xJnxXDtZKxbfrKULyWsEt54VIYOPkVEvRD3t7G9rU2c5+Sla
 THsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708957728; x=1709562528;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UaHnE8xFuk5fF0E94JeQzivSpvLKFREUCdWaCX88pEg=;
 b=sBTCPcXZzHptHCXBcZxnxaRb/L3DlS36bX5LWYRDbn6dFzeyp79DWtlO2x2EnGstdQ
 wF4Tl6Dl+MEMtZRG2BldchtZnaIfC2O6+Lf6RAEVwNN5GULWuI2e8ov9xRETzJQVAbn/
 8yDrE0fYx3zCIQPU0YdyMiHo7XzTacIW9TEo/Ix+tZSAvVimXyPA9OW4eGHXOJ9ih3Hf
 H2Kzxl3lUmV53DxnQSRytQi/5V7/os4OlXRTw3NQSl1nIF992a6a8VcTssUyrMhPNhYC
 rZGMmc58LvCLNmXnDbeCbCGq1dFmn0DbfphLjR/LYlWCtuAcqEbyLqzZqNQVaXmYagqM
 jOUg==
X-Gm-Message-State: AOJu0YyRoDYQ2SlkWtFFnL4Asi0uSAXppgz1DfeJHi1QhtNF5fSBkUvc
 YGb24Pmli+IMZjO45b62kOm8VGTS9vRm4nK8VS4Ul95heZm52LRQrfAt5C5Ljyw5lXwaAAYBBZc
 5JlAFDR92iWEftf1DDMn7uxFDRlxjJY1OsLEndg==
X-Google-Smtp-Source: AGHT+IEg5c6DFhQTd8s2Np8vblFmoNuz25GpAZWZ9UwimC9IXAzSuy9rIe3UNYccmKriKfgb9tXfWhpeO+l1QG/6Ks4=
X-Received: by 2002:a05:6402:393:b0:566:ca0:4a91 with SMTP id
 o19-20020a056402039300b005660ca04a91mr1249593edv.2.1708957728166; Mon, 26 Feb
 2024 06:28:48 -0800 (PST)
MIME-Version: 1.0
References: <20240220160622.114437-1-peter.maydell@linaro.org>
 <20240220160622.114437-6-peter.maydell@linaro.org>
 <Zdyfz8kc9/iumCAA@intel.com>
In-Reply-To: <Zdyfz8kc9/iumCAA@intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Feb 2024 14:28:37 +0000
Message-ID: <CAFEAcA_ZzSmgSbsgE92PNxnDxTxrprMAMOdWwT2Q6aZ-my8NbQ@mail.gmail.com>
Subject: Re: [PATCH 05/10] hw/core: Add documentation and license comments to
 reset.h
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Mon, 26 Feb 2024 at 14:13, Zhao Liu <zhao1.liu@intel.com> wrote:
>
> Hi Peter,
>
> On Tue, Feb 20, 2024 at 04:06:17PM +0000, Peter Maydell wrote:
> > Date: Tue, 20 Feb 2024 16:06:17 +0000
> > From: Peter Maydell <peter.maydell@linaro.org>
> > Subject: [PATCH 05/10] hw/core: Add documentation and license comments to
> >  reset.h
> > X-Mailer: git-send-email 2.34.1
> >
> > Add the usual boilerplate license/copyright comment to reset.h (using
> > the text from reset.c), and document the existing functions.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  include/sysemu/reset.h | 79 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 79 insertions(+)
> >
> > diff --git a/include/sysemu/reset.h b/include/sysemu/reset.h
> > index 609e4d50c26..6aa11846a69 100644
> > --- a/include/sysemu/reset.h
> > +++ b/include/sysemu/reset.h
> > @@ -1,3 +1,29 @@
> > +/*
> > + *  Reset handlers.
> > + *
> > + * Copyright (c) 2003-2008 Fabrice Bellard
> > + * Copyright (c) 2016 Red Hat, Inc.
> > + * Copyright (c) 2024 Linaro, Ltd.
>
> An additional question, when there is a new (notable) contribution to a
> file, then it's time to add the company's copyright. Right?

It's OK to do that; it's not obligatory. If you're contributing
on behalf of a company you should generally follow whatever
that company's policies are for copyright lines etc in open
source projects.

> > + * We assume that the caller holds the BQL.
>
> HMM, what does BQL stand for?

"Big QEMU Lock", the one you get via BQL_LOCK_GUARD().
BQL is the standard abbreviation -- we already use it
extensively both in comments in include/ and in docs/devel/.

-- PMM

