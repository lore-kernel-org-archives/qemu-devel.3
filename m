Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB794F8E49C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 01:31:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDY2W-00075c-B3; Thu, 16 Apr 2026 21:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wDY2T-00075E-7M
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 21:30:33 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wDY2R-0000I1-KP
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 21:30:32 -0400
Received: by mail-qt1-x844.google.com with SMTP id
 d75a77b69052e-50d75bfb259so1388051cf.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 18:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776389430; x=1776994230; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gY5LfQJVjXb12M6EoWSACsq9veQbVH4z3SuU8JTk5qc=;
 b=nESppAswoYfDIjYBQeGUj/JKTaAplqa8cNSpymoXjMWFUXnPp+XL9xWeirwEZryBvL
 QeTxQ7FrfDDZWpM8fEK68F6ag6u0sHw16vA3dq9PGXMSrkTxC0wuwpMkmPPqe1hkhSrg
 +li3fVPHrFuuujee4inMmrAuB51khm7gwIPfesnz9OOe9iKXL2iOx7kgyJtBESLYl5Un
 ciC7W4/U7OWMUxzKFc2OtJrMfuQ4mo5sL7vxGsDLAQ7uwHly56uEc7go+W/d/R8cV2wY
 1EQPEZE3OK0l3G0D52DgWf87dQW9rA0O/xkOK3kEwpOzquoVknH9tGWDEPQADrblBSAf
 4chA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776389430; x=1776994230;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gY5LfQJVjXb12M6EoWSACsq9veQbVH4z3SuU8JTk5qc=;
 b=jXVO9t7iHp7uu1gkYgjPb06H9Zs1TO7niE/QR1xNx14QSeUZrv13yewPFPuFbvKLzf
 IGA3eNbXAgVjY15lCc0JMqrgJNTSCXiHrOQxcWNJfEUsgB4gUlW0N7lWy7dNEV57Srag
 CEvgSKokhl1OvFnBIdvveMli1ZyVKr71ejd92UthbvDR9gGvqE5rUQqWJ6b22SrXnMyM
 0eWWupPe5eClaDMEhrEFeYlZScei6XoLFi9AtyIAxcC6M90OfrhzVfjpUn2skwsOIOV1
 WtLgBYGHKxMklFlzxokGdx40o0Cv1PUQhWAcKy87CAPXVHBbsXrumI6T8fSRhMoCgrG2
 Bq8A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9yknSrqOJ0hmqNki89leflTu5GUCkrRFofY1dXPSWLOBtL+ee31+YgU5DI22Xv+Z/Qrt2+Xg7/oU35@nongnu.org
X-Gm-Message-State: AOJu0YwJGyesmmoF4KJdApX42wJtrlIBh91mZj1hEvuRvlxVyDpbJv6r
 A3eNp038oJQxGQ1kv4dfZ4Vj+ylQ6XFMLjoeWWUe189z46eaI0C89MhD
X-Gm-Gg: AeBDiet/VqkBsQ7oQ6EXet8dO09eADoNtd7NCgSZ/72SGaXPwFYCggGf3x581serZP8
 6c9/6xsDJT3s8wg8COF7mHQam9DSxBbQ+ZggCz/1mqFtB6F4bRbj7M3HRbtOk8GS0p7XMdimIMR
 nM3VI0PvShbIp3C351TTkRE0klUS+ZkTbJVyEwvKtkd2Qy+uYDSYHA6m/q2l3BhxuOYHjI0/LDE
 +pCYtcwdNnOzzXINsMB0f3TtUmop80eW+iMX/+5WfFEpLcNrGePrHwjhixYX/jjLZX30jjC2U1A
 DbvifFbSJY4nMJMDDCRr9aRG1yv22TLXctHb5OmK4pXDngEQlmezPi2jMpVBbI8qCIA/qkZmHhX
 p+62aFMkiPyG+7sM4VpQ/zqP1mbGcEDWzEkdrmCohWFDvDxCN2kydK7udxhAoK+R6kDMqbFYYce
 CdC2b05bRRfgndMbsHuV8DjADdM6G8lIvdojr2w53gZKpPqR3ze3QQdFVcRvmrQ40lGYJh8HBli
 25t1h/Z+KY=
X-Received: by 2002:ac8:7d43:0:b0:50d:74f9:894b with SMTP id
 d75a77b69052e-50e36b36677mr12832461cf.23.1776389429972; 
 Thu, 16 Apr 2026 18:30:29 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e39305285sm576161cf.13.2026.04.16.18.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 18:30:29 -0700 (PDT)
Date: Fri, 17 Apr 2026 09:30:17 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, tangtao1634@phytium.com.cn
Subject: Re: [PATCH v1] tests/data/acpi: Update SPCR golden-ref for RISC-V virt
Message-ID: <aeGNBch02JmQuBCE@ZEVORN-PC.localdomain>
References: <20260412012501.1808602-1-chao.liu.zevorn@gmail.com>
 <CAKmqyKP9k5ku8hfNbq=4XxPrukAn0Php_QyZuero=MEHVtd0BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKP9k5ku8hfNbq=4XxPrukAn0Php_QyZuero=MEHVtd0BA@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::844;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-qt1-x844.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, Apr 16, 2026 at 12:35:59PM +1000, Alistair Francis wrote:
> On Sun, Apr 12, 2026 at 11:25 AM Chao Liu <chao.liu.zevorn@gmail.com> wrote:
> >
> > Update the expected SPCR binary to match the corrected field
> > sequence after the Terminal Type and Language fields were swapped
> > back to their proper order.
> >
> > This fixes the qtest-riscv64/bios-tables-test CI failure:
> >   https://gitlab.com/TaoTang/qemu/-/jobs/13879552268
> >
> > Fixes: 977c6fefcd04 ("hw/acpi: correct field sequence in SPCR table")
> > Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
> > Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
> 
> Thanks for the fix!
> 
> Do you guys (Heinrich and Chao) mind if I squash this with "hw/acpi:
> correct field sequence in SPCR table"? They are both in my tree and if
> I can squash them then it keeps the tree bisectable
> 
Sounds good to me.

Thanks,
Chao

> Alistair
> 
> > ---
> >  tests/data/acpi/riscv64/virt/SPCR | Bin 90 -> 90 bytes
> >  1 file changed, 0 insertions(+), 0 deletions(-)
> >
> > diff --git a/tests/data/acpi/riscv64/virt/SPCR b/tests/data/acpi/riscv64/virt/SPCR
> > index 09617f8793a6f7b1f08172f735b58aa748671540..59d2c8f7f215a604612cbd0294c18bc6301e208a 100644
> > GIT binary patch
> > delta 10
> > Rcma!wnqbGo%rMbG3IGpM0&@TW
> >
> > delta 10
> > Rcma!wnqbGoz&z1G3IGpJ0&@TW
> >
> > --
> > 2.53.0
> >
> >

