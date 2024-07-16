Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE141C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 17:08:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTlef-0003Ft-Us; Tue, 16 Jul 2024 13:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sTlee-0003Cf-H1; Tue, 16 Jul 2024 13:07:56 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sTlec-0006Dh-Py; Tue, 16 Jul 2024 13:07:56 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2eabd22d3f4so67091471fa.1; 
 Tue, 16 Jul 2024 10:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721149672; x=1721754472; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0sZXiP77/IQJ9B0rN8BeQyebchZs9/AdU41jvq1J+8M=;
 b=cCuYYwGc+Ty3AKLDH7Lbhie6o3yYsHECBm5tITcBNhJ5/xkAzCygjm2htvl7XodrWy
 ZRk/Vumbw03yp9/zk+OCzy7/DWDsR3kfnkyB49r06fBQhr2F1bVB9UKId1XFFY7frJi2
 uK72WEvvHhui0NnQ0x/QIoaaAXgEl7ie4GeyxOwQHnIqdykXpdj+augVuYOp62yuStSR
 ugVlCyJFfwR0n89I2D57I/O1apTkkjIbvkbVHPt5V3mdyGoMyOJ8ny++vm4Mo9CvnGQd
 FWqesYPio8gjmQ5N5lc84ySMD0dZPsErxeg4AYredVRUFQmfvlwO8cZpqGo2kmFcyk01
 84Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721149672; x=1721754472;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0sZXiP77/IQJ9B0rN8BeQyebchZs9/AdU41jvq1J+8M=;
 b=e+BkrRtwf/Ki+LjBxaolH9IPCfSjmc4dtHQ4A2DJbwOU2aZKorVTlx+CwKfn87Ppx9
 /ZvLlzugeN5rI7Sh0KhmtMJZTadY7nur8M/Tz3KgA7rnll09mz3CbOSXJKuoBgOcXP6t
 ndlucVIETanMdJHRNqO5nXN9znc8igVHSwQQ24iCmqJiSMyzOg3sYfMk5NJxlCDQ0uTd
 nluIMw140dBa0b0u+udvo87N5VpXqdlx6bMKTyFVtXO+1d+rRhc59Cz5KkKg6Le1a3+e
 RCkzkjo6H4NXmL1jeoH4PF/YuZeJDFnpknZv+lT82G5xaKO06Xg7zZTb5q+w7KrxjyBP
 fgTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU74P8ZmcRYY/dqoLjtcHlMKyC+fvuwdA0Hxdh7h+cRkldjQBRV6rpf5w2DEmn8fMfn1d61iDrfGE3KrTqe0YHH6PHG
X-Gm-Message-State: AOJu0Yxg1PQYEIVZ0htohst6QFmSroaAWx3BPMARMPl9fL3prRfPSQ5F
 1S8dg5Jh9pQjhc2qTvbZE0L63ncpyL+85ANVP5+7qpx+B6ya67Su
X-Google-Smtp-Source: AGHT+IHEw2hYWfj/lRdxVC7glYucRcB8RDHH4U2r49WTEYO1OfX0/GYkYftyLarwHs4WwktAAYtI5w==
X-Received: by 2002:a2e:9e99:0:b0:2ee:d8db:5bcc with SMTP id
 38308e7fff4ca-2eef41921e1mr20555541fa.29.1721149671473; 
 Tue, 16 Jul 2024 10:07:51 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2eee18bf03dsm11805421fa.65.2024.07.16.10.07.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 10:07:50 -0700 (PDT)
Date: Tue, 16 Jul 2024 19:07:50 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH 0/2] Consolidate embedded PPC initial mappung functions
Message-ID: <Zpao5gD727ww3Uji@zapote>
References: <cover.1721131193.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721131193.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x22f.google.com
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

On Tue, Jul 16, 2024 at 02:07:56PM +0200, BALATON Zoltan wrote:
> Embedded PPC has always enabled MMU so it needs initial mappings to
> start. This code is duplicated within machines which this small series
> aims to consolidate into helper functions to reduce duplicated code
> and make the board code simpler.
> 
> Regards,
> BALATON Zoltan

I tested this with my virtex-ml507 images:

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Tested-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

Cheers,
Edgar


> 
> BALATON Zoltan (2):
>   hw/ppc: Consolidate e500 initial mapping creation functions
>   hw/ppc: Consolidate ppc440 initial mapping creation functions
> 
>  hw/ppc/e500.c          | 41 ++++++++++++++++++--------------------
>  hw/ppc/e500.h          |  2 --
>  hw/ppc/ppc440_bamboo.c | 28 +++-----------------------
>  hw/ppc/ppc_booke.c     | 10 ++++++++++
>  hw/ppc/ppce500_spin.c  | 30 +++++++++-------------------
>  hw/ppc/sam460ex.c      | 45 ++++++++++--------------------------------
>  hw/ppc/virtex_ml507.c  | 28 +++-----------------------
>  include/hw/ppc/ppc.h   |  7 +++++++
>  8 files changed, 61 insertions(+), 130 deletions(-)
> 
> -- 
> 2.30.9
> 

