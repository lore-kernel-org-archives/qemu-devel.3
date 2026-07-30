Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DFBC54FDF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 09:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpN0S-0000v2-FK; Thu, 30 Jul 2026 05:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpN0R-0000uU-2j
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 05:24:47 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpN0P-0003hq-HV
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 05:24:46 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-66804667af2so1372650d50.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 02:24:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785403484; cv=none;
 d=google.com; s=arc-20260327;
 b=ZlrojkExe/M9uHTYIzvcs83R6uXvQxyOa3b5i/RUMyFp4nyifyQmt20lYJ+wVeHNJZ
 +wAQ9h1RR3a5R7hwXeH6lC1MdG4A208zWmwOhBPkCt2jz5lI68B/24nTK1S7LdgzhssC
 9qh6fp8e60ytQp8IFPqcnegx0kzvTYD7IDaLK9h0sfcoi0592SsZ6K/FNjVFYhgWvVdZ
 C2v3C6P9EY4wpJcGmhMJ8TU+p2aaIf8fOnOr2cM8ZgiETBPhxw30ujHDNGaRmWXU10le
 GsE3PEdHL73Set/8QIO54t3XbkM8zDfSgcP/pSVfl3QgUDXIBuBiFTKZc+Q6uN9CX3zy
 Fwew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6DRPUvtZTmyt9EyX1NZslCd061ZF3H56Y2s2i0RY+cE=;
 fh=TLL7+sgVuFgzGNFRwLvREtumNEH4U/DomhiebgY++CU=;
 b=DplIq5riuLhwGuiWscFh4QFDGMxj0QUAHRbjtvCYU++1Rx8GUio0cOVTI3dJuHC7zI
 G83qAq1Zd/CAjveu+9abUDtd7cieXWGS4HE7i/J6BMCHrmz7GJSctB3poD4MK8nKUatk
 vqqCXnXX7wDeuoxg8uDW5S0K3bDvVASZUTdhZeBTQmD3zGAgZbHT2+W+nvWjgfAIxJP7
 1j+c+dKbpSjUqKR7Ds+eO+1wAh5kn5gDSK57HbVhI+/7Nuh14awQBtwPc+Pal//fuMg+
 VgLxPPIrwL4oRGKLj3Td5ZVGAgjbANp+8Dl/YjpZ1byy9cxAcG7m54DNRyu7yToiAkMM
 9Glw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785403484; x=1786008284; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6DRPUvtZTmyt9EyX1NZslCd061ZF3H56Y2s2i0RY+cE=;
 b=PvwboktIVJIJnEp8NGbOfyvGHi3zykoumVJaU1ADVi0k82U3Zn17BhAJR2hF7VLUgs
 bm27nA+yJrFLdVx6HbgXDwGRqSCInqBZk4GpZh2Buz+o6KgjbhFj1vxlzu5/CcsYa9Ha
 t8zrZQwPjodWxNzvmUOr68CsBl3N8NzIsIV/LvCPlvEQNBJueLGCLJAOXW9q7K8t97Ih
 DD8EKUckMrsQ+toKFixcKN8sF2MZJ6YXoveMic4KwsYwFf/mxr1kdrsfoU+31QnpYaCY
 x+E8TP5OUCqw4YFQwPoLIRFkoPAtnRc2NG1SFvJxTF1fSAigPbPwxm+1hWVrf4gJuJ7P
 f2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785403484; x=1786008284;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6DRPUvtZTmyt9EyX1NZslCd061ZF3H56Y2s2i0RY+cE=;
 b=GIkr4Tm7y5u7hWTGeCIusMYpPOALl13QmuDVJ++APNCOuzKUHGJiprorXqOgoEsWuz
 /t9DZUAAafAD7l3MUHQD0HzkuHjWVAZRlMZeKnC3FwFuW43PeZeT/pokrUaJH8hm6WLu
 B4nuFGU2o9dTlEzNZUQr8HmQkBGbn5Ld8OE0ol7gTCSqWFREMqqjrhggGd92FoRoPGWj
 tfAU0MKJKStOXqUBUgy0WkAeyGK1Lz2+YxISziIMuqvnVnvF8GqrFYOHLNWsiGLjm+vz
 ZLjczaUiIdIH2ex49MfdlP4TN9AY0fNk9Br0AtDkxVeCskrsCYlw5cozuXSAvpkxRbw9
 clvg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ros7traOjLCzkyrmQEVqAbtqXPvqh5ZrkAejpfQ3wxqjCyFQaeOfdrYTsfrG4r4Us0INxK03fkRjN7i@nongnu.org
X-Gm-Message-State: AOJu0Yz8OUQnCfh8hzDx6d5zNTFyQ1RhwxmnnK7RXeyN8SwtU31b7v8u
 9ZikAIB9h0HtuQY2rmH5n7aVxRAg7+24yokze4I77qKqIG4ER3AfcJfCJOFKMBi8ugiDbMkkM3K
 C4iS1ZfTpUihfhdQ3f+nKdIsWpFujvWXJr41yLq4OiQ==
X-Gm-Gg: AR+sD10u3dnUYKUauGDxwDWkxLLdT2GXVpjNZdARFRE8SEsXDE9xCO8Ekv8AQmbpu6s
 gVqulu4gc9RLggSfGVd6Mtyg8VBP4uH5i7491EYNwME/jI/TpSXVCTF1Kf1E7yf603wBBP94gyH
 2F+5Z22Ws2zRKqc75EPwSxxHdnlr2sfgMmtQzm1OGb3Q2slmwfp1m8XEM4g6IltEJGgzDaUNGgs
 fyqLGZoEsMUOQ0ruUXxCl48mX3+TsA7BWb2yO6U3Nyrsx4PUfyylLX0S9X0gK98Huv3U8WhoDOY
 lN2Ar127PwLj23JdK46Uh73oGpw/IvlIm+2V3zKpOkYeqgjuA8BbPELSm6JGTI+p0N5x0mOFm4v
 /wSOKnHJ1t0L45eYN4C1SlEfyZDf1OtrwMviKGnY=
X-Received: by 2002:a05:690e:23d8:b0:668:9e51:5239 with SMTP id
 956f58d0204a3-6692f635433mr875554d50.44.1785403483884; Thu, 30 Jul 2026
 02:24:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260728031731.286666-1-gshan@redhat.com>
 <20260728031731.286666-3-gshan@redhat.com>
 <20260729182316-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260729182316-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Jul 2026 10:24:32 +0100
X-Gm-Features: AUfX_mxT43uM4P_x5i7ErKMK1RbVsZJEwZ-hb_VUMJvYXOLsfxF40TT3khzneWg
Message-ID: <CAFEAcA8nxsXNPuqOoc4DGnHbCKQ-pBJib4JhXnYkzMg79GMfAA@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] system/memory: Use qemu_ram_move() for directly
 accessible regions
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 peterx@redhat.com, philmd@oss.qualcomm.com, richard.henderson@linaro.org, 
 alex@shazbot.org, berrange@redhat.com, philmd@mailo.com, david@kernel.org, 
 clg@redhat.com, pbonzini@redhat.com, phrdina@redhat.com,
 jugraham@redhat.com, 
 liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn, shan.gavin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Wed, 29 Jul 2026 at 23:35, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Jul 28, 2026 at 01:17:30PM +1000, Gavin Shan wrote:
> > +void qemu_ram_move(void *dst, const void *src, size_t n)
> > +{
> > +    uintptr_t test, len;
> > +
> > +    if (src == dst || n == 0) {
> > +        return;
> > +    }
> > +
> > +    /*
> > +     * Maximal length of aligned access that are determined by @src,
> > +     * @dst and @n
> > +     */
> > +    test = (uintptr_t)src | (uintptr_t)dst | n;
> > +    len = test & -test;
> > +
> > +    /* Overlapping buffers, unaligned or oversized access */
> > +    if (n > 8 || len != n) {
> > +        memmove(dst, src, n);
> > +        return;
> > +    }
>
>
> This part I don't get exactly. It's fine on most arches I think.
> x86, power...
>
> But here is aarch64 for example:
> https://codebrowser.dev/glibc/glibc/sysdeps/aarch64/memcpy.S.html
>
> it says
>    It uses unaligned accesses and branchless sequences to keep the code small,
>    simple and improve performance.
>
> so if the point is to get rid of unaligned accesses to BARs, are you sure
> it achieves this?

The idea is rather just to ignore the unaligned-access-to-not-RAM
case as "only a theoretical issue" and default it to memmove().
If anybody reports an actual problem we can think about it then :-)

-- PMM

