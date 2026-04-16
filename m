Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB9FF428F5
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 06:10:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDFuv-0000lp-3i; Thu, 16 Apr 2026 02:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wDFuq-0000lO-J1
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 02:09:28 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wDFup-0007iS-0r
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 02:09:28 -0400
Received: by mail-qk1-x742.google.com with SMTP id
 af79cd13be357-8cfc5941028so1098321985a.1
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 23:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776319766; x=1776924566; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fTBRgxvyc6aW3/mzgCV1Qa+v73bqNPK/M3R0CLsC+wc=;
 b=NgsYmetqtV+/4cv/DGmatdl4W9qWwI7wuauKiGFCeY1lebXoNl8MAuZ7pf5nx+Urlf
 hNaXLJttJ2Px1pxRy+DLrLlS1Vt3upxH9lcX+1W4y+o78BAylVlBjbwRjR0dvLHe7fNK
 j7aEd6c80PFijsQFAtlUMUUWkB97gdcRvueg++K15bNk3jeAsviDpfI34JxthMR+PZlF
 TIFW94JFAQaxFspJ70FbWLHJ+HlgXeqt7R2hvEEfi0dBCsptPoCh7s70mi08YlPFIz9m
 /yz67cyDC60zg9sDhTe8dT29Z5tV1tuV22cuNdJG1hKmJrh3yCtosVMtmW8DQMR+0SGo
 3wXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776319766; x=1776924566;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fTBRgxvyc6aW3/mzgCV1Qa+v73bqNPK/M3R0CLsC+wc=;
 b=O1AqFR5kt/H3zqNZKtGJEZJnFfSz8Ha9aETxScg5aRAo0jruX3mu82GEwJgydAtUve
 pla1BA99WXucFzHqt5flTrP7dnBdnrvZOWo7lZ+MVYXSocAPB3Gs3k3hZnvtE6gUWwmt
 F+RFgCL9DRuIK0q+7H7L40VIUMyazZ6YiAlaw4bMNhwKw+oyNWZxgkl02MwXF7carCnw
 uddNYFn3T+GCCD19kBI5H6zHv86DbyEHPiOxbpNS7nBgS0t5XzOUimY20asDP4jpsBw3
 ch8BGrbaVm1ia0EuV/w3mSZ5QqGCZpwrRcH6hz3CkzIDdukVpiJhy6/3otS/8BI5Z/DJ
 m+MA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8P7dYT1OC2L4RhglAryNbO8OaeVZBTgRf+RzjF8bfw+Pb8BbdkoYonrRGhr3Z1fFskC3DrWoOq0dnz@nongnu.org
X-Gm-Message-State: AOJu0YyiGZGD4i11ey+Li2sIELtdgKYlVypeagwsphRJS4eX2GK8zO6p
 1wFefB50BaQtxHF4Tk9rKXDYF5j5QC85qcXojJSJg75bTZJhjB8PJXNc
X-Gm-Gg: AeBDiev0BkBR0MT0P6M+8fhRvT/bhT9xBtA9zHMPVg+mk1PBU7XPaA2w3GtV4S1QX9w
 IbdETf0QzWDIdk/f3Qnk31RTAzgRawv8yq6Tupb4b8XxGRAeGrR9b6v1OBvR0nGlDtwWoKjcY2E
 0/xjYgNOxHVfk6SUrOZSicalFSx0ZJKbktCqYHbfWyM9fdABafzL1yDzpXePAugIsMroKD8VjDg
 SBdzAsgryzHQoJEiWuIuZH5qJSp0KJ3CMb7q0iApEtRUGpk41hsV5s5mrJGU3jLk9MwkmkYohG0
 zCNIksu+Knt77hpoleGDabnCtCt32QJztbGb+Varrbn1Yz1M202FdKjG37xREjWZBFmTD84VzE9
 BfiiAff0O5TqoCuOsHaplFXBuhfHCbGoE7zpxyfBWNwR4hjd66MElJiu65QXvhEPTIk6qBOuT/W
 /uc05WLuwpn9xoln9jL2Mb6z4ugdkg6NU6E4L10gVkVHclZsLg/LZOBDppmaiByUMjOsaDMXBQ
X-Received: by 2002:a05:620a:4041:b0:8cd:bfd9:e2a2 with SMTP id
 af79cd13be357-8ddcfbad95amr3597552485a.43.1776319765843; 
 Wed, 15 Apr 2026 23:09:25 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e4eed6ed8asm300728285a.1.2026.04.15.23.09.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 23:09:25 -0700 (PDT)
Date: Thu, 16 Apr 2026 14:08:30 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: munkhuu0825@gmail.com, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 tangtao1634@phytium.com.cn, qemu-riscv@nongnu.org, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2] hw/char/riscv_htif: Fix format specifier for uint64_t
Message-ID: <aeB8vRtG0njYb3zt@ZEVORN-PC.localdomain>
References: <20260415134826.1742308-1-chao.liu.zevorn@gmail.com>
 <CAKmqyKPeqzjYDvG9GfmQ37psGEiqmx+tFGR=YES87YUd-FA7SA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKPeqzjYDvG9GfmQ37psGEiqmx+tFGR=YES87YUd-FA7SA@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::742;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-qk1-x742.google.com
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

On Thu, Apr 16, 2026 at 01:50:39PM +1000, Alistair Francis wrote:
> On Wed, Apr 15, 2026 at 11:51 PM Chao Liu <chao.liu.zevorn@gmail.com> wrote:
> >
> > Use PRIx64 instead of %llx for uint64_t arguments to avoid
> > -Werror=format warnings on platforms where uint64_t is not
> > long long.
> >
> > This fixes the cross-riscv64-system CI failure:
> >
> >   ../hw/char/riscv_htif.c: In function 'htif_handle_tohost_write':
> >   ../hw/char/riscv_htif.c:175:38: error: format '%llx' expects argument
> >   of type 'long long unsigned int', but argument 2 has type 'uint64_t'
> >   {aka 'long unsigned int'} [-Werror=format=]
> >
> > Fixes: d98f7a541c2c ("riscv_htif: reject invalid signature ranges (end <= begin)")
> > Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
> > Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
> 
> Again, is it ok if I squash this patch with "reject invalid signature
> ranges (end <= begin)" to maintain bisectability?
Agreed, this is a good idea.

Thanks,
Chao

> 
> Alistair

