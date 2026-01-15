Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B260D41144
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 09:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgJaO-0008RG-E0; Thu, 15 Jan 2026 04:24:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vgJaK-0008FL-JS
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 04:24:09 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vgJaI-0007bc-5Z
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 04:24:08 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-81f3b4ae67bso387104b3a.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 01:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1768469044; x=1769073844; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LONq2OglDDn5dZlPJt93ojBxeihqgxeaGq1z/y+xiyU=;
 b=GJHuL6SzWrcd2mhtPra1HsjdKCZZ0Cm7FdnVDetX+6tNnxSrvUsfI1IsS1Pt3VeoBc
 Ru5X951AeFqAPKBbRKe2/A5D1o8t1f7Taj+etA+vm5e0osMvkcZDBhVp5iGKkMq8IbvU
 530pRzIEhewQi1ZLXkJt93jJbiKgRoxWatRhHApEPXq9ET20pJAxT3vOqDhjRZVRmH6m
 a+LVRkXdqsseTuFOX129KeI5lYbknooIh146/el1iPrR5yjiziZBQWinc7JcAiXzIdV8
 uRSlAAvBzSEloSwcnmtyXzXyuug2O31FW55WpFZyBkWQ3CrosLEIFWkaMtEVVnGPtuln
 Rnbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768469044; x=1769073844;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LONq2OglDDn5dZlPJt93ojBxeihqgxeaGq1z/y+xiyU=;
 b=aaFawAYSCHIvpId/J6cn6sN2FQFlcOaj3TvEIRJ1eMTdeCYFg7Wi0wIhfowSjARhKy
 KpFf2klUyl/3J/3MibOZdqIRUFDJS2lfdyWyRY1nmqRjHjJ8fnRbDqLVb8GZz6GvUb7q
 KbgNt7SKcXRNnNhAXktsKjuJcKLxTPjRPeVXp9dz/q9CbYiUcWz/7TIZqx3jc+bRp1HZ
 7H0IVFlKWKug5/tRKUU/7SPVw0hCPxohLlfn1eKqsw13a77oEDiBR70Kcn5YQ/xOgAas
 jNqgiXm+9EmYrjYzZqqIIZbxVq3LWNmPZgFG4Tpz7z7wDxxWIJCTujyjjZ/jjVR8aCNn
 zpdw==
X-Gm-Message-State: AOJu0YxfgEhcuj3GYAIR5Xf6uivlDSTfsmZhRT/593wkunvmIhVbAk4l
 8LhiHLDKk+ifNigluIS8tgl0CehTBIq0Yg+56HJwHR8YPKjX/n1zbfldm7U2TwrADho=
X-Gm-Gg: AY/fxX6hR05KqPFXVJjFFixTBniIqU4VumdFUxCHcoc/3ihC1+JiZl7f+Q5ASX85Zdh
 3niADKWlNCMBRP7+8VEOASJnkMp7kuHIZk0Uk/SFpQkbd+gTGZ1G7RWQmmm38Uec6bweBp4FNfe
 nmSM04641SVXNTqKpKc8hmG5Wav5xsWhsQd0M6Ig5NYuIcG0GmZXQZHJCcqFZF2CgI5oSrTfNNs
 gILDEqocBiuNRoI7Bg5STii+0nqJH6mF2QxPRDqbeuLh2ECEYE6DBhUowYSUZMLvQTtFbBX/qSw
 XAMaC8R6RsR2ZUGU4XrW8Zb/UvylobMvIyCwXkL/WGpaX9n7lliZk+2Un2VsZKl0EtmcmFnnG7V
 JIzF0xPaInViDzaWkLlp4+HXrQZSRg5eOFsiGkolTtyVLGc6sDM2CCSmy+R5zcEqkpFUdIFLeU1
 YT7TyW0PoHRAhTr8mmexB74vw8nBhqm0AywvgP
X-Received: by 2002:a05:6a00:338b:b0:81f:4943:b853 with SMTP id
 d2e1a72fcca58-81f81d5a54amr5350962b3a.38.1768469043732; 
 Thu, 15 Jan 2026 01:24:03 -0800 (PST)
Received: from sifive.com ([136.226.240.171]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81f8e4b7a6csm1909971b3a.1.2026.01.15.01.24.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 01:24:03 -0800 (PST)
Date: Thu, 15 Jan 2026 17:24:00 +0800
From: Max Chou <max.chou@sifive.com>
To: Chao Liu <chao.liu.zevorn@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH 11/18] target/riscv: rvv: Add vfncvt.f.f.q and
 vfncvt.sat.f.f.q instructions for Zvfofp8min extension
Message-ID: <aWix_6RWXhuXOVEs@sifive.com>
References: <20260108151650.16329-1-max.chou@sifive.com>
 <20260108151650.16329-12-max.chou@sifive.com>
 <CAGL8uCVTFrcW=b+Du4inUtjzND=P-UNPYvfhhSWBfYR22sdq+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGL8uCVTFrcW=b+Du4inUtjzND=P-UNPYvfhhSWBfYR22sdq+A@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2026-01-09 14:37, Chao Liu wrote:
> > +    return false;
> > +}
> Missing the trailing blank line.
>

Will fix it at v2.

Thanks,
rnax

> Thanks,
> Chao

