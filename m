Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A16FC28B2F
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 02:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttzu8-0000Ns-Uy; Sun, 16 Mar 2025 22:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1ttzu6-0000Nc-MC
 for qemu-devel@nongnu.org; Sun, 16 Mar 2025 22:08:34 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1ttzu5-00011j-3J
 for qemu-devel@nongnu.org; Sun, 16 Mar 2025 22:08:34 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-6f6ae4846c7so38088727b3.1
 for <qemu-devel@nongnu.org>; Sun, 16 Mar 2025 19:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1742177311; x=1742782111; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sEvWfgrA1xQt7Pck2ReN71OGZAzJWFV9g5EFB1cLTK8=;
 b=BCAd+kwzGJHq4EfotGtu28IGelRGDrgaQsHnLN3SRT6C+OUAXb6VxBMhuyDYZ6Uosd
 mN/lwIA263uL5V2dJ1/6AT8yr6zDzz2WzS0o1LozPejDEVQPglKexdZjG5M+cnSA675N
 WO3HPXrafU6kBRIuAHUuuXOu7dJA4dgPvWy46j+cpq0YWsGE2XGz+UY62AocofxarWEB
 NVD6LCa5iAm84zJyoXL0DSSN6SUNhyx8TaM1ManTm6LuiBnQZR8/I5JFYHEvi3FdZd2a
 wzCJzIydPFN+TvjqRY//HdAjhgQT6/xV5zN6DfKHqlFEO7D+wCUuFfUpA/T5I7FoyCH2
 UhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742177311; x=1742782111;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sEvWfgrA1xQt7Pck2ReN71OGZAzJWFV9g5EFB1cLTK8=;
 b=HcV+ZHAjKfEfenwZQuMukCfS+IB4xB7aFykpSlXGM3TQeW5DZpmI1Cvx9WC08b+yyO
 CjKozySsyjmVT5GeoUaCSwTXMRa51VkNyABRF9oD/9PrrPaWzBs6Xbu64MQ4p3aoqZ+5
 lQZPpt/JhzVkEUMoWOlpSXOdjv3uwhLXD++pGUz8S2mdv5ONTolx3msIkw2Y8uRrWybw
 KVmsF68MzGkrHEcMe+0UbnQ3cJscZ2CJ4hkj0rRLEMvZGxabDfl/Ec1EHQLfzhs+MROM
 JH7ENbFIoEMe0/wtCjplYLvdFKhPhWtLUt/vtYSvW/wcKWDaqB1AofFY75V9OXoqpkrA
 zeVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9kwpKYMrBRjPx6rdEeiYSCLH+rY+1Kz4meKC3i467PF2WhFEawXE+P7zNRjvcDXAU98GK2DyvC+L+@nongnu.org
X-Gm-Message-State: AOJu0Yz5iR1TYt/WSBN5RZkykbB2H7Y4ZkpBu84xXYCNAyZeVVCLJcOO
 J8sX5fdTf7sbTrv2eoIlw+rrXE/8y+fUa7gbXbAjTONNv/tf+mFO1YTGk0DeIU1HCzbUqH3S7zD
 jpnW2we2DWSJQkhnNNeqb1XAWZ8uw+yOXIru/Pg==
X-Gm-Gg: ASbGncuzziyNx/c29M4+aHd4Ne9rwg5AL14NpS/YG9srdEkiXSLQodcPgrmDgqiD3eI
 JVcW5NvZZ/jT6De7SedKF+mCIY9VA69mIp1KyKN5YBLMRJS9lwV/dMAOjl0DMMaZ4hOjFq4rXXu
 5wdVGPdmNw/qfXabG3IzVlz4juviIVLMA4loEt5BOdg+ckJt1v8yDAAQw=
X-Google-Smtp-Source: AGHT+IFQraTHV0NnExhL+b0DQnySWKsDCjDtgjmrW0U8OfzB/WB9ZYdqhHb6HtBZL97EFuayyrDvSCsb/CWIHhDHUY4=
X-Received: by 2002:a05:690c:3813:b0:6fe:aa66:5d84 with SMTP id
 00721157ae682-6ff460d0e48mr141434407b3.37.1742177310841; Sun, 16 Mar 2025
 19:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250126072056.4004912-1-antonb@tenstorrent.com>
 <53591e3f-78d2-463e-b857-0b7d170b84e5@sifive.com>
In-Reply-To: <53591e3f-78d2-463e-b857-0b7d170b84e5@sifive.com>
From: Anton Blanchard <antonb@tenstorrent.com>
Date: Mon, 17 Mar 2025 13:08:20 +1100
X-Gm-Features: AQ5f1JqX_p3knzu0ZP0C9Gy5qROtmUfYKwhxccBIQey5w4oacUgQEpVUloR49v0
Message-ID: <CAN7m+mAtsMtafZzWVhUJzVCHyrAyhPN8a3zAdGzFk7=evJWHRg@mail.gmail.com>
Subject: Re: [CAUTION - External Sender] Re: [PATCH 00/12] target/riscv: Fix
 some RISC-V instruction corner cases
To: Max Chou <max.chou@sifive.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=antonb@tenstorrent.com; helo=mail-yw1-x1131.google.com
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

Hi Max,

On Fri, Feb 28, 2025 at 1:47=E2=80=AFAM Max Chou <max.chou@sifive.com> wrot=
e:
> While reviewing this patchset, I noticed a few missing parts related to
> the mismatched input EEWs encoding constraint.
> I also found a few other rvv encoding issues and planned to submit an
> upstream patchset to address them.
> However, I think it would be better to merge these fixes into this
> patchset to maintain the series=E2=80=99 cohesion and keep up to date.
>
> If you agree with this approach, I can integrate the fixes and submit a
> v2 of the patchset.
> Please let me know your thoughts, and we can discuss the details further.

Sorry for not getting back to you earlier but that would be great.

Thanks,
Anton

