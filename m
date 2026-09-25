Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA542C98318
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 00:06:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9tRA-0004VG-UR; Thu, 24 Sep 2026 20:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1x9tR8-0004Ra-6S
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 20:05:10 -0400
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1x9tR6-0004br-O2
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 20:05:09 -0400
Received: by mail-yx2-x10.google.com with SMTP id
 956f58d0204a3-670fee39d73so529311d50.3
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 17:05:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790294707; cv=none;
 d=google.com; s=arc-20260327;
 b=La4BJZ2zjeVLO/J256Ce/qafqzVsfLKumNvOvmWmdu7shiqmfo+HbFRfzZI/5urReU
 V9m0roNxweghBW0FRaWBrQBXqWD+MEOD8NH2+TiNss+e2aNsKuDKsqCG319eKQ8z+y7b
 6+EVIpquaQJENMkTGHteaDVt5XNSg4HAYQgoqUMRh2qp/CwHYXO0PtwF+5NCtUDfaDmZ
 cse8WyNrXEbXFi+2qBktIQl99QfFuLkD/Tm5NAF+/gMYiHYtfHFZ1bce6lXD1XkNovoC
 wIpeCAa9OXMSSBf3rPIDHd1QqU2edOVsuhHzWk4891PqJUkCk9gzZTxt6hB5F1DG1OCj
 00vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=THFKGI5+Bokdkdl0jWd/+1qSxdO1Cl6vplCduDfW+EA=;
 fh=ZF7jCY669HysMP18HcFkfmHdyUOvKtASQdJ99ECflHs=;
 b=HxPzILE/d8qd7sfuf1OTxZcaVrsoDekIrjhP7AeC7/V1ug2pRRGQdAl1LcwfXoj449
 8dJvXhRC3lrJI1N74vWfNPIiwAA6XWn5HDt/xSIs8cwj/BhjmDTKOtdxEzD/b9nztTu0
 XuB/zYGR1Kw6fASJ0ZQ9qJcndI7RENZ+AI4agu1Ixq2uztnn6JkJHbt2bPJmvIr/et9J
 YOmwXINSbcRZWYN5iemaiV1Hwxj7QHIzdXJJfnk86HvU7Ma/Qjqf67ybGzBuyB4ta7K7
 HPGmpvx7NXKwvjh8zmF1d8bNoGuBPECLCFPEUiTnVYucL9/dI+F35LxOZZZhOhfztgh1
 vDrw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790294707; x=1790899507; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=THFKGI5+Bokdkdl0jWd/+1qSxdO1Cl6vplCduDfW+EA=;
 b=RpJ78D3LMxJrF3KjoxX8YtgU65WnyJ8CeLbk+ivyP0SZejVOlSPEWO+UPxOJ/Zi53L
 KxRZ7oDozDMtkXCfd8kDRzjp/fQfB5ZGa5Fu1CJm2zly5ImUkYMdXsxNO84f1BVlNuPD
 EF0z6TXSPJP6Y5cBWkdkfuIcK84y0exv7p5M055TNzSausIxgtWUxXv3949aKE0gjXTu
 8EPBuH2WOuBA75lkjLFWtx31x7GGJinEG8coOR47E/M/4XPURXvzSKbiil8eTubCAddk
 50j+yHwu/KZIb7O8nGkhvw8xZAxp3/QiMP65RqKy+TH1Xygg5a9OSdUFBGNnyUNULqBH
 uFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790294707; x=1790899507;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=THFKGI5+Bokdkdl0jWd/+1qSxdO1Cl6vplCduDfW+EA=;
 b=a5WxUDeXj9y36SS5XfSAtdqQ4suGaEfKE7wKUYzmqwX3YskomPNMkxptU90eqxSN4P
 AxFmnj0j2nEXxhx2jdPqTLHZth/ndY+lLxr/CDKjXplZizohKscp6ULnHMCQggYrHSuE
 iFwbE1OaiY709THVhesxwPyR03p+a/KDpPQbYXkmt1ZdMOSSon0Gc3BXXRev4P0yYDeP
 rWwDPR5rOH6iVCkeF7FRSFou7LwXgzOixGny6AJXYnolqgLACV5+rlJO4W5vAeG0F7eC
 qIylyOZZIi6iGtPT6dehCy4+pXZPjr2K1MhBY1H6ZyyyM0ZXomu/bQRaQMuY7zLmyrQ1
 qDoA==
X-Gm-Message-State: AFuF++n5TU2uviHM0AfcB4r+v7zosMiqOoboJMqV+Sfy+1I2kB9jO+0l
 fT7KQ9LghQOxBY6XFrgv2hFGkdY8+w22e92ogpQ5Di05KzuaKV7BbW/dIhzJ3160rggiNwihrIr
 NypUEoWd5i6LfWjqoNxlECtH6z3sLxOk=
X-Gm-Gg: AYBFou2G53H6LqZ37TrezjEn+8d49WCZ12PzyHRxoZ39OBNbRl7cQHP+uAXewYJErN1
 D0bYnKN8/Kbfq61YeAylIZW+J8xbrHlHIQlG1+zlbiRfNbvRFeJLc9lKFLg0zRZeL785AhQZq0v
 ErxRNi5bN46A3Wd6UEEZjvxjdx2HQX2fdhxXgFYDyZ/rnw3bPQD0D2azb5FYu4suGFxkCPDcj20
 aIppEoSn3MS2sOQ9j+4rith57qojxZyv4leOyIfAigEyKGHXBhFeOhWLKycUtZbuakQ0diksA6b
 GONl+9B9e65OiDXbLkvK6ZQD8zL1lWOtyiBdJNDrNe6pCiINxBnffaigDImc
X-Received: by 2002:a05:690e:118e:b0:672:d609:6bfe with SMTP id
 956f58d0204a3-672ed32167bmr2613560d50.39.1790294707282; Thu, 24 Sep 2026
 17:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260825084224.1827672-1-bin.meng@processmission.com>
 <CAEUhbmU+BQ=MErMdF1t8BHp-Xzwc2PbFY6pN3wtAgYKbO7jdaQ@mail.gmail.com>
In-Reply-To: <CAEUhbmU+BQ=MErMdF1t8BHp-Xzwc2PbFY6pN3wtAgYKbO7jdaQ@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 25 Sep 2026 08:04:54 +0800
X-Gm-Features: AclHuK_MXEl-ur_paSEuduhOrrrD2iPyXDlk9VNgzE7kU1gjnLHP4KYGeXbJ8z0
Message-ID: <CAEUhbmVoMnHDiNGG7KoGYECewu-JdiuCuB+aXeyq4ohVHo-H6w@mail.gmail.com>
Subject: Re: [PATCH] hw/net: cadence: Honor subword lanes in the GEM registers
To: Bin Meng <bin.meng@processmission.com>
Cc: QEMU <qemu-devel@nongnu.org>, Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jason Wang <jasowangio@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:41::10;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri, Sep 4, 2026 at 4:16=E2=80=AFPM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> On Tue, Aug 25, 2026 at 4:43=E2=80=AFPM Bin Meng <bin.meng@processmission=
.com> wrote:
> >
> > The GEM MMIO callbacks ignored the low address bits and access size.
> > Byte reads therefore always returned lane zero, causing guest driver
> > that reads the station address byte by byte to turn four unique MAC
> > addresses into the same value. Partial writes had the corresponding
> > lane-selection problem.
> >
> > Extract the requested little-endian read lane and merge partial writes
> > with the current register value. Preserve the existing read-clear,
> > write-clear, and command side effects, including dynamic queue
> > pointers.
> >
> > Fixes: e9f186e514a7 ("cadence_gem: initial version of device model")
> > Signed-off-by: Bin Meng <bin.meng@processmission.com>
> >
> > ---
> >
> >  hw/net/cadence_gem.c | 94 ++++++++++++++++++++++++++++----------------
> >  1 file changed, 60 insertions(+), 34 deletions(-)
> >
>
> Ping for review?

Ping?

