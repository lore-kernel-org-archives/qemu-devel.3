Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B939C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 04:30:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wemaH-0005J3-Ja; Wed, 01 Jul 2026 00:30:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wemaF-0005I7-85
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 00:29:59 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wemaD-0005Pz-EG
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 00:29:59 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-664d530fcfdso215079d50.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 21:29:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782880196; cv=none;
 d=google.com; s=arc-20260327;
 b=OkTX9F7ZKP0RRl2XET3vqIV5WqiQi/dzHm+LN76/qABzrKkhMWz7hTu0Xcod64YrPc
 m9hlxAjqJaNIdgV+9BzejS3cE6lf8halh3l3TguiOy9Ex+rL6lj/qUkXy+wepXfugVOT
 PEH/JnjoiLvZZ/7eAf2ta69TFXMU0GRdfZY/R53TK24fMAU86C0rGnWO0tJWgn2TMfAb
 wHEbiAz6V/z+ON1Q4OXicSCMDwv5apfbd/fHicRZgwy9u1w90pbPJ4om0amUpnm7OZYr
 4iCscKF1YnJoztERCLUJz6cv8TB/aCYVMDOi5dTb9Ikr78q+qkbFCM59MxBB/EhWI4/y
 qa6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NkA89hQKgBW8RKe455wjGc4VzEyzFdTmOegKbWYXtQ4=;
 fh=QMl3m49tuLtOusuuXCnCOZCsoZiLfsjUwXG2nLBmcSY=;
 b=rsWuewaYxzLdpq6n817C4O/U5C07qwgE3NvKUpDFxf0JJQR2qPK2N+fCjaBue2JOBC
 LDTqXKfKYnNDj1P8oEyzxgqQPybnTbPeAgm8ceSTsJokHIAn4W/thefACdNo+edRGGS+
 4ROxGgtK1qxKfLnT1UBXm47x8C+70Ecp9xbrgd53j8AyxaTx2rCBZWK45CyKryD+dSvN
 dwTKLi+yqpOVMxZNTTRRgJSQc8CPNqes1t7WHuT9Y3I6z5YDL2uhmniq9bZFdrxOPWUp
 AdecmGfHEPOOOBH/mRIB0h3EoGV7tGg0hFdf5Cw8BhWLrPqtned7sPGWJU4ihflZYXbu
 NVmw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1782880196; x=1783484996; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NkA89hQKgBW8RKe455wjGc4VzEyzFdTmOegKbWYXtQ4=;
 b=kZL5O0viJauqH0YQy0w58p9YEaPr4x2ChiU2zMNQzyQLi2PfYJ8sfnSr5gbUDNt6qf
 SGkvur7BJth1xKPXUWCw0VltLK1PnxJgSvgdsnZ7siSTC/8DDxO+O48r8PybHeW4IXTm
 WJWwOk5r0IspN/ElpveZpSRGc4XsUxqGJ3J94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782880196; x=1783484996;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NkA89hQKgBW8RKe455wjGc4VzEyzFdTmOegKbWYXtQ4=;
 b=L/TbvelSZP5UTWi817+aL9mE8tLgRQ5x7y9dyxzhRSEpwV2nY5He2QRa++6U5cCYsv
 ZPMOxIc5hiv8c9zrByCmzx4sw3j/wpoD35sq09XLpBSMkNEFW1mB4fj5c5I2P9kFrFHR
 zrClKCOb4fD+ZNtGytVL+pDJ5hwU30/QKAaAeej8dDfM98XKc86yyzl1zSXkw5xMj5cA
 2pQL5kLdkiqk4Lj0vj2qs5ibjvK9nCcC/ElZuv8ATerrDv3IFMvP436yxGvodZq82w8O
 JROOwky+3cfWelm012IfzkWZt+LwnWxGPSGUYg9cnxlzOF1q5B7FefZ7AbKFqHYxbPq+
 VX4Q==
X-Gm-Message-State: AOJu0Yy/fctzangvIEEgYtyoRXGlMbjmI1NCcHt51RZhvLlGjY+/+qd+
 dM9ORN5/NtdvpX8sTWDJmCpzM6SCf4Dv7wz4U6kyEHvHVRY8sgEQC36TlXsIpQ3Tlu0zQZTV0WS
 MZkRBwPLefaO+36oPsVKl1Wn7PBb8DNM=
X-Gm-Gg: AfdE7cmo1GmnGWMaqWfhOKSNnyT79Dp1IoQ+iDWeHHjMJ4cpiVq7mn4R61eBobVVDQq
 xuj/kokGyW4YNdLg65Z0lX9uOgqwai1DA/tKtmAeEDvS714bstzn1rUBWYdABlE3OhWtBzG+o9e
 SM0BiYW86XtDpKCpT5zW2UvtRX8btLP3V69pcHm4V1VvQ8/T1BUIV5kYiIps9B2+KLPXTP9/IDk
 puIC6zcIKWRpj8qn0YsI28bqU4b8AeIIAc6A5zH/ZvZfsbgOSAX9AOMuG/+SNucx54VFQiJtHa9
 MIWNtBHn1D1WGoVuen2dW3giMy3RAURla2p1unHsLCHMjcadF6MI6dltNOV1xWb37jyYqeWReN3
 wxqmGL9AIen7PGCULp9P8N5Wv
X-Received: by 2002:a05:690e:484f:b0:662:551d:b987 with SMTP id
 956f58d0204a3-6652196979cmr31110d50.12.1782880196316; Tue, 30 Jun 2026
 21:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260610214133.1882563-1-daniel.barboza@oss.qualcomm.com>
 <20260610214133.1882563-2-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260610214133.1882563-2-daniel.barboza@oss.qualcomm.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 1 Jul 2026 13:59:45 +0930
X-Gm-Features: AVVi8CdJsOpeHLO2sqRcWf7JZmfLsV6KCqBXcRTkerrIhb-5qjq35Keb_txflJs
Message-ID: <CACPK8Xf9sT_Pyc20zpLnpo+32RNRjS29VP86RhmF0ufoNd8kxQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/7] target/riscv/cpu.c: remove 'bare' condition for
 .profile
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 andrew.jones@oss.qualcomm.com, leif.lindholm@oss.qualcomm.com, uwu@icenowy.me, 
 Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=joel.stan@gmail.com; helo=mail-yx1-xb12d.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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

On Thu, 11 Jun 2026 at 07:11, Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> We want to configure other CPU types to use profiles as an alternative
> to adding every profile extension explicitly, i.e. a profile is nothing
> more than an extension bundle.
>
> This means that a vendor CPU can set .profile=rva23s64 while having the
> same handling as any other vendor CPU. Same thing with all other CPU
> types.

+1000

>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

