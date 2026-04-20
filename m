Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF5EF55803
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 09:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wElPH-0008HW-2R; Mon, 20 Apr 2026 05:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wElPA-0008Gx-V5
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 05:59:01 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wElP9-0007HD-BS
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 05:59:00 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-797ab169454so38039957b3.3
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 02:58:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776679138; cv=none;
 d=google.com; s=arc-20240605;
 b=PSDILNAZ7+gvNMEBjOkp548BFxm9hVf1iH+7jV43aLYZzptDFZ0a7VlbnQ8sOS/uD/
 6VqMu/0j3OJKfCm3NcjhbklCnigwGVzkUKETB5ee0eabTB/0Z1LIYsW3v/bNAmCdYwuy
 EIoRnzrybYW7csWawIEM89C5BXZKUyS4c213gzM/p99cOKEbCEIUVlkggbV9iz+XwB73
 0MUDOQbj8KaNUcQ57s60gykgbBgy6Aof5tWtXnfDRcO/HVCmo/FF2aabXTllvjrSGXD/
 gVbv6gdM4JcJCr0Qd8Th8S9CfBtSiz7CgZT1veRAN8QjYBAGqDJ6dJss4CzdCGyF01Rx
 +XyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=77v12DvZrsTA5CrcmzcwO4l++DfN0wrY47UPYcaP+bc=;
 fh=ua/6Ys84y5bjLTbUAUJBq9as/oxSI7ciXG0/MM6qXLM=;
 b=fdgxrIGLQe9VF/4O0M6fpC6gSVnbw4C/wP/P8c+sFfPEm0FZh2T88JoQKnCULllZ/n
 ORLy/irO+hdhKQ5SUILI2JsjIspi+1c++uTxy+JykJkXpOlAImHWCWbg8YLp52jc/3+R
 CYlgu5Iicb03Zb8EN2L7KmOOGp1YgGW1kUa6okCz3vrj0UKC6lk+neVHklHR6d2iX2DQ
 MR92P1awNnhwl9tIoBI8N2SHIsswCSzGUOTr4NBrdy+WI59a+hTdD84jSJHPNeucvO/E
 rftQwpEGx6O9zOkPz+zH3Q2hdyHT+r3iG7mk8wXsGvQlujZ30GpzcbvMBerty0+8+vpC
 3aUg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776679138; x=1777283938; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=77v12DvZrsTA5CrcmzcwO4l++DfN0wrY47UPYcaP+bc=;
 b=biGp/TC9krcvBk00nUEt1LUVOUPtkU7I+jWRIMhtEVZniej7YfB60aVKFYWH8GDPvg
 iNdp7QaDzPL55mj4ldfxhKnS4OklLWZLIa8xN4w5ztNJ1mnrNuXXDNrrSzTBM9Pe28I8
 9mV+OYRbJxzksAeul6oy6qYpF12k+WjDHbl+xRE/tIL4LVSMZ36MabjZKv4i6sGSPi5x
 bgRO+icnZvIuRRP12aLQYTievCwduHB4nIUDyLDf07HcRXCCkmJ2fe2S59Q8nMJhmAHz
 cgDqFND4Z8BCQjzlgBa7e8Vv0xWEk/exZ26SYywgwahQaIENFi2ufduDqPB64Jdyocaz
 I/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776679138; x=1777283938;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=77v12DvZrsTA5CrcmzcwO4l++DfN0wrY47UPYcaP+bc=;
 b=LgjhEZfSNa67oK1wXLNf/vODiPZAdhXZvqbuoT0jEFJ71Ns1eUsAn5S08hqGCCu8vt
 /YtsPRvNjaB4M09l3GzZuLeXRN8p/sDjTmle6KF9xt1Lj9+FumTAWhjSQiVToDC9RBRw
 PCQk4RjE+xvfTy+kBJYqQipvDWR0+V3NMmZkHjCxDZWQdTb/ux+1yFBlsHGirydnjulu
 zf39wcfkDOKBNWyvL2Q/z48L7Nxj5p1nBzhmnOkZMK771ZCRszCLEn3w3XZTYmyaJwOx
 3f3Cz5pPB/yG/UrTMzj3AWOsmtw+etB7pMqXWsCcq+l+NQwh7apV05a4gRPfN0L8tRnj
 Rs0A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9mKjttUUNU9BB7C+dGgKNyFMLANw1SK049nc4xnMGylK4q5zdGx3EZ10BHfbUYZqc5VM5i4IaPnbI9@nongnu.org
X-Gm-Message-State: AOJu0YwMHBCmAQIjCJ0ZE/mA47DhNUgUHytGEN2Ld9ycDQdHZHK1EKti
 oNZ/W4XmqHmlVotn8PSDxyc8yABPBdNqWd8Fln7mmZF3Z8YPnbL7eUQE1TV0/yDUnR8T7PXslDJ
 BEgsKzsM819ZXnVnDtcx3IJeJb/Yz8x9A57g9dv4LHA==
X-Gm-Gg: AeBDieuPwoOPKiDQQCGoql0d4zgjzs1kphJhwKxewv8pCTgB6BHhxXa0wYpQxOQDpaK
 kQfrig3hTO2wtLHKLTHGRVtELja/qC75Uxr0o+ufhkDx6Ehu1fIICHZOEpQ/PeDcEzheRRxjqcJ
 i6kbm1qutw51OpB1UXAvRKX6B3x86ZwN3nbtmoK12FC0i7m5WiZVTXYWfYIBaexsHK2j4PYHhwC
 RXHxdDcYP9zMq/msvt2mOsMv4Vmy9sHFdbU2c2lcwYGlPYQPXBSH6fPObLtgXGBmPYSqxb0tmgN
 7fTKPrbokisTaTUBQqCMsvc4bXSczywTgER8VMozv+eExBgdWYOL/sVO4Z7qzl3Zrhhqy+LiPgT
 Y+A==
X-Received: by 2002:a05:690e:1281:b0:653:11d9:b0c5 with SMTP id
 956f58d0204a3-65311d9b991mr11525569d50.46.1776679138236; Mon, 20 Apr 2026
 02:58:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260417152236.1305333-1-farman@linux.ibm.com>
 <20260417152236.1305333-2-farman@linux.ibm.com> <87a4uyt0ww.fsf@redhat.com>
In-Reply-To: <87a4uyt0ww.fsf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Apr 2026 10:58:46 +0100
X-Gm-Features: AQROBzBWCBRo6FQnsPhdGe5RXAoyejx-2hE-baSSD0JYD9XirUUzN7W4AD51IcM
Message-ID: <CAFEAcA9xCN6XMUFmZ_QAn617W14FAzi4D_H1mgSER10otTtQMQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: Update s390 trees
To: Cornelia Huck <cohuck@redhat.com>
Cc: Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Mon, 20 Apr 2026 at 10:52, Cornelia Huck <cohuck@redhat.com> wrote:
> I also have the s390-fixes branch, which I've used during freeze, not
> sure if it is worth mentioning here as well. (Assuming that I'll
> continue using the same setup as in the past, but it had been working
> well back then.)
>
> In general, do humans tend to consult the T: lines? Are there tools that
> do anyting interesting with them?

I never look at the T: lines. My impression is that this is a
part of the MAINTAINERS format that we've carried over from
Linux, where the development workflow is much more that
subsystems have their own git trees and patches for those
subsystems should be based on those git trees, because the
mainline git is only updated during a merge window. For QEMU
our workflow is that patches for anywhere in the tree should
be based on the head of upstream git, because that continually
updates except during release freezes. So there's much less
need to care about what a subsystem's git tree is, and many
subsystems don't have a public git tree at all.

-- PMM

