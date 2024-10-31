Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14740D767C8
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 14:07:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6Vp2-0002eV-90; Thu, 31 Oct 2024 10:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1t6Vp0-0002eA-IV
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 10:06:46 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1t6Voy-0002k4-HO
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 10:06:46 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-37d49a7207cso703716f8f.0
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 07:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1730383602; x=1730988402; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NfnBAMHxRdHwHD3vUVludur5p2ItyJIfYaCHMSZoWbI=;
 b=FPscv8Q0nJ+Gn5KLWnTdfgjh5aiLrJ+fsd3CweNQ0zbZfmpbThTGj8LRPNK6OrGZ6M
 5Kxqa49bc80Df85n2IcfVpkwP5TpRaaXrlqG7OSxYii2iU3mcxePZsnQfdOtrIEwbolB
 bjI5NYeewTBbBDl/fQg54tfZvf56MOlhTj621XnSUeYU+FnNTyAnEfZTUyanmCFzgA5o
 GZhAvWApUnIogj3AJT9y7ILP5FN2rvfXg6+6M+WQEpySF791J/5balQvkMVBm2bnudH9
 1Agb7aprC1ZhWkT5fn4jZzXhiRwKD8cmEpSkgOKGWguPYq6P0rG5HiBOgosAfRdCPWQ+
 nE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730383602; x=1730988402;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NfnBAMHxRdHwHD3vUVludur5p2ItyJIfYaCHMSZoWbI=;
 b=wvVu8/7sU4OWkTRMLNlXz9jjxI4ozORHZMMkaQsc3moljpLyBidBANnO3gfUtYRl9u
 AfdOmKtswkbNrAyco3ZGBkd2t0tuOKEZ8dHWxwmueWE3Jpq1DOc0WFsfbLtTrhIugXSS
 pMG2Foue1BzxyzD8/vtCBd1hHKbgTSJodz4j3BqGFE1fDPOulUvQLuiZB9LSc1rCPYTz
 KLsA/NppqCE1iH2exdodZLg6pIgdRaI5lznQ7mih+96xDpY0tIeGCqJ2wGk8vCMyNPeo
 HNBSr1FakvBFuKOu5ALVQ5u28KbzKEljD7614nA+eXM9BFdYr7exenHZ6VoluvjoeYmh
 JpAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwUSQjGhc4zg0L0QnSxSB2/qmZM9hxmGvd5qzzwTRMxIB4yvZTEBC9TUFKVdCPVM5xXOlHFGhgrbqE@nongnu.org
X-Gm-Message-State: AOJu0YxAND8rNrmRtAuA7q9btc1VbzjiEjRATIdguU2nPrHlaBEF/aqb
 pe0PcQh9EjoAPI+9wjd8fsSBMTl8as83Zb9gDqe988hLrOBnXSQ6sw7WkCM4zRU=
X-Google-Smtp-Source: AGHT+IHlh0UtuPOE+u+4bJo+XiEIyLMxvvpTC8hDH/OTBiQOifFGNPAqJ52SDFhskNDwLdMykJ0Inw==
X-Received: by 2002:a05:6000:400d:b0:37c:fdc9:fc17 with SMTP id
 ffacd0b85a97d-381c7a4cea7mr73338f8f.23.1730383602016; 
 Thu, 31 Oct 2024 07:06:42 -0700 (PDT)
Received: from localhost (cst2-173-13.cust.vodafone.cz. [31.30.173.13])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c113dd95sm2206171f8f.83.2024.10.31.07.06.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 07:06:41 -0700 (PDT)
Date: Thu, 31 Oct 2024 15:06:40 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH 0/4] target/riscv/kvm: add riscv-aia bool props
Message-ID: <20241031-20473647edbfb74109eb3b95@orel>
References: <20240924124407.766495-1-dbarboza@ventanamicro.com>
 <f6d26471-9137-498f-b295-2bd6fad7241f@ventanamicro.com>
 <CAKmqyKPLdt3KQqzGSMVov2557MOsEmzP=+g9iR-irw_4YK8-mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKPLdt3KQqzGSMVov2557MOsEmzP=+g9iR-irw_4YK8-mQ@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x433.google.com
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

On Wed, Oct 30, 2024 at 11:44:19AM +1000, Alistair Francis wrote:
> On Tue, Oct 29, 2024 at 4:01 AM Daniel Henrique Barboza
> <dbarboza@ventanamicro.com> wrote:
> >
> > Hi,
> >
> > I had a change of heart w.r.t this work. I still believe that the boolean properties
> > are better to deal with since we don't have to deal with string parsing, and that we
> > should avoid creating new string props in the future.
> >
> > But as far as the user API goes it doesn't matter that much. Having to do
> >
> > -accel kvm,riscv-aia=emul
> >
> > or
> >
> > -accel kvm,riscv-aia-emul=on
> >
> > is basically the same thing. Deprecate properties always creates some form of hassle
> > for existing scripts and whatnot and we should avoid it.
> >
> > String properties aren't that great to report to APIs though, so what we can do is to
> > create internal bools to track the string value and then use it for QMP.
> >
> >
> > Long story short, I'll re-send this series with only patches 1 and 2. Thanks,
> 
> Ah, I should have read this before responding to your other patch.
> 
> Sounds good to me. Although I don't have the same dislike of string
> properties as you, but I guess I'm also not using APIs :)

libvirt and other upper layers which use qmp would need to learn about
each property's possible values, possibly requiring QEMU to provide
different APIs for each different property type. With only boolean
properties, all an object's properties can be queried and modified in the
same way, which also allows immediately knowing how to enable and disable
new properties which QEMU adds without the need to update the upper layers
at all.

Thanks,
drew

