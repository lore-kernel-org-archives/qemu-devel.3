Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C1DF3C24C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 13:10:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzaLT-000726-Kd; Mon, 09 Mar 2026 09:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzaLM-0006uD-4v
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:08:20 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzaLK-0008Aw-CW
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:08:19 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-64ae222d87dso10496366d50.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 06:08:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773061696; cv=none;
 d=google.com; s=arc-20240605;
 b=SlvjGiDjvwm6WOZSBj/N73byDciIFI8Qlc66OV5ZsjttrOKW/kb8K2Aie2F5TdnLev
 w//4MMvOLcPinCbuDr/CKOdW4/Rla7wmdijzJqqeMlEPEvDbhh3SU3VhqEWKFD6GeVvM
 vRAFWCs6lajcLCOK+N9oC1iIwv+tOrmizo1C+Ct0kZzly/DRuKDXswJTcMmgkS+Srx/7
 aTd5EQOLAIQyUbDUqQzkMa7kkAVoIMi604NQGbn+CT0ESvu7b2mwTCEYSDfr2aFtRg20
 2SQfn5y4UeCUDY+R5KC7Ihje3Jq/KW986nLAx7fBAzv8rxfqMKZWiygMjVme4WgJmTm2
 Z+kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GduVTXdiZ1S23u3Lrbb8oIM41C4r9WXmvvMVN/hRaVo=;
 fh=KIPl86UKwYdKsAWkYeHBwwla3dnQZBVl4urYHK8biVk=;
 b=JT83V7Afx68uiGz5xpRlz58Y+5y89oB58U9qFLWOGzAiuQcnVri5lgisiwhM42Pr+1
 +xoGR4Zm+2Ch6LQiqEzflS+Osbj7bLLAVq+SjavmRQ5gpjIt9114KJUANwvYcL8+bFhK
 D6LRMA9DJb3NkdDWPzdVRPFi00XmCa749JYIU+ShZpNx0fUAIHHJNF4DFl5Muo6L8vyR
 xoWwxYfYxq7Rli6nFXxqBfaf/TP+Ykai8FruekIkytTgiViL6rvWSf9XCdycxcvzyUBn
 hiU3JUz4vJnzeyb5x8kv+ZnS0wMIU8HgAxYIHaJQOxSyN1hq55mRDbyJcVrWXkfpikng
 HvUg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773061696; x=1773666496; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GduVTXdiZ1S23u3Lrbb8oIM41C4r9WXmvvMVN/hRaVo=;
 b=psdDMzKQHKuvb56OXJ+1WUh09jh8y51KH63F6helOwuxVoZ7hBnx4dFdlfx0tsne5s
 2fKxC2Q3EaFJNkYmTdePdES4YxWlg6BnXA262PBV4ukvprknyViD5yYAZuWvhc7u+HrE
 DWxSyPEBI1tsYNyBFrcIOCXfBUJxqFccYnHDo6bgfCGDhtLsdUc232iKRyiuyicLq/xT
 M3RRsHrB6Gwb0q0s+R2e+USakbMNW0IOKcXCiP02OtjSXYswR6qubwfq1ZfrSXWgyF9i
 1ZJkrdALuq+2Pepk3lHIMpZ6L7bdwx3jfbB/O2SOtesbg9gRXYqFHwyB4FbENjgIw8Z6
 sxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773061696; x=1773666496;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GduVTXdiZ1S23u3Lrbb8oIM41C4r9WXmvvMVN/hRaVo=;
 b=eT3dtKAIcBxPy8Av8y1TFPv29zaDWbiXEUug/Pm/8BG09E72pU1KAYUuAdGKXfa/oR
 +2AD46ESN6xXTmWxGoP4vNHOKZBuqInWLh5vlxGa+/oS+zF/hrT9H0nFQu6lKYRre+J2
 WrqBELpxKKdPdGdSU7ND8q5RydrMldv8w9xMW12whIrDMfVTTiYt2i2eB2FMftImOZr3
 J+ZA02ljEltdLcIAw1JP6+nhV1/qUgsrR56f5cNRjhqv6XStryRI3oHTXy3TjmyeP4qP
 3E2Y5YWObZym5S+0ExiE6HQT7SYRR8HvqPeGJD/zMUciafDtHhaKm3zx/dtuvBxEvUJv
 03cw==
X-Gm-Message-State: AOJu0YxheT1rf8td6+ylVqvxtr0F1GnFMvJHV+ZoIxR41rgFcevND7+K
 F0pciOV+xfjIMOONQeDDDA4SIOlZfIIT83aRJEtKHoZM2RnrOflH8vbRO3csjAHf7R1ZQKQl/Tb
 sNAhGjWmYCOauPP1pvwDQoAXBdnmS6Qs8/KZuWcMbew==
X-Gm-Gg: ATEYQzzLYPQxaQC4KXXsyMhkr1fpu9h1slAHREj/i7fOPiKxWZItnaTWveBBXBXoqHP
 VW1QXy+qG4ZiXOfHwKTGWTyJXgfNYHq/UFEp6K8rF9DG43oM1P2dLvFfeCpMM3n3UPR6CmKtWIB
 d6Q3NK+PpB19jbF/9kayD6P5QcfUWFMnNzO1vbE3H5FL9cK5zztLNDFudkx5MBxQ29CkMH7pvd1
 0fW04GkPr7m9W+qQPnJTU33ksNwcFwaZqDhxh7uGsYxcSvnrNGgKBZ3zeH8GSTi1XJKmjPKwRhY
 DNbuhmrMhxX5iAhhEaedvdFrohwSL9WLIP9EJEd9f7tSAGt+Qml2jiB27fQWRfmDRe4=
X-Received: by 2002:a05:690e:444d:b0:64a:dc4e:780a with SMTP id
 956f58d0204a3-64d1429b2d3mr7732636d50.44.1773061696259; Mon, 09 Mar 2026
 06:08:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA8FhiJZy6NqRUVnWQ+L6=fE8Ssqs9FEW2eO2eAVTrL=_w@mail.gmail.com>
 <aa6_x250FtIdy1iw@redhat.com>
In-Reply-To: <aa6_x250FtIdy1iw@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Mar 2026 13:08:04 +0000
X-Gm-Features: AaiRm53zKdP2UdKymyj0HrF10w6snPkiaRHgpuZSTIYTqEmV3X3Mm_3yZDGncDs
Message-ID: <CAFEAcA_odsUhgQiucTRiAmTp9y1rnEwBK97JQ=2p_UORb9e4vQ@mail.gmail.com>
Subject: Re: running a single functional test: where do the logs go?
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Mon, 9 Mar 2026 at 12:40, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> On Mon, Mar 09, 2026 at 11:55:58AM +0000, Peter Maydell wrote:
> > The functional test documentation suggests running a single test
> > with the build/run script. But if you do this where do the logfiles go?

> Meanwhile your logs are likely in build/tests/functional/... instead
> of build/san/tests/functional.

Thanks, yes, that's exactly where they ended up.

-- PMM

