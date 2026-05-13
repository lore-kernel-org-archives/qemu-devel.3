Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE255CD343F
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 02:28:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMzKg-0004Vs-4t; Tue, 12 May 2026 22:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wMzKc-0004VR-5V
 for qemu-devel@nongnu.org; Tue, 12 May 2026 22:28:18 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wMzKU-0006Eg-Rd
 for qemu-devel@nongnu.org; Tue, 12 May 2026 22:28:16 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-bcd0111ea98so472891666b.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 19:28:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778639285; cv=none;
 d=google.com; s=arc-20240605;
 b=BpVb05bbH1M8SaoJqZJvccLuaMuKBS7ctVWKc8H2DUVv+b2R5cquDesi2RLIGXgypi
 zTBFaDweaDw1czuxWzuo5NHXwByApvVMDjsCX1sG9wACTaHOydLQqEuDwkDyHFqKaOXa
 PgMQ9uGmcAnLim7ank0lKUoEa7kRW0kTFEiQ5EUX+/Z+3DibLkwTWbqYnQxrM5TPBJZm
 1idJmYxw6OsyE9yQP9lW6s9/2aL3k3lKP0mGdTL5uTER0boXaBezNQOIxxCn2YAGD3zc
 BFxLRJtarXdyGrH7Shjyz+kdM///otTqn2aO4dhg0TC2b/forPe85GSntC+3py8I0Rio
 rT/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=l6k3TRobZX2UNd3jmH4Z1wx6gQ09ofuR09x1UsSCWRA=;
 fh=tyotjs3vSjNuogQmJNF94iI8vCDkfEphA5u7UrA5kwg=;
 b=lm2oZ7426zRjPsHjYG8+cGiEyQt9Kh+AyfYbCRZgn1lSGcm2G0c4vJApDyprPePUtL
 oX2kVXzBQRCk7WRVw32Rg1xYJB5/nk2S/wgIqHiPS890kwKUk+THRYbpmohI09eFXGTg
 AY3Iy6nmtdbTR0XFVHamy5+XM3X5ACpaLjV6n1uasjiE+xZv4mD05/1WwngjfWe9lkqi
 8+DK4Bv/l3JcZfH8faid7EeC9eJFIs/JKSishl9S9dBK6EQgFq01VB9Wvg9nzbWusHRL
 OdtmIxBUmA2uUUvcLGaNXbIjFQ6czetwDs3+0fphfsCcgjoW8J3dLEKrXpuuRNxC3rPd
 zkkQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778639285; x=1779244085; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l6k3TRobZX2UNd3jmH4Z1wx6gQ09ofuR09x1UsSCWRA=;
 b=cg+awrGE+skVJ3qMF7Q3iaAgZqUuShvoRwWyeRzW2UvAsKZOPKdx557ggVuqcojdjS
 YbpB/fAt1HyhtqIRIceuvDEPrR9sxWiZDEWclzISEPc/5hsbLqYds1CVvvqdCbKTv7ZC
 rZhq70eOzvEwknVwsVbSiuVFcLLFnA/cDcz7S00+xJ3B5csftFcvjlLgk6TAHTdl0EBQ
 juFlR1IbpS0eCM0p4K2SUROICXqbshjd6ROE8pDxHtC87HQdYyPuHBZ4vTGxKsRf43fC
 nsl9eFt8cjO4XdTHiQRZkjBOXPNiSx5im91T10kQA+FU64nSOnVmAPUBiErX4BUxGyLo
 EzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778639285; x=1779244085;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l6k3TRobZX2UNd3jmH4Z1wx6gQ09ofuR09x1UsSCWRA=;
 b=qBjpOAIRkH513hGVZglzFnpY+zDlHhXQAND66Jcv0JJNcxMqtiM72v8qOc06MpUmfr
 5qMZr85jr+tIUbpI3bcdLcZW10koVCxLckXecDwPF3HU7+5zgJb0IlqRj3BMqyNBezHD
 PbneFj0LtxpDixMlA6n1zTHIqYBdIqG7t7lR+zeh1nMacC2HkdRxMYmUlqyZd5j2TOsV
 cMIonwno/8fiwintwmsVvuYKPRZ+WWF2+t5S70Emcf8xfnZUEfFott1tRBc7fawor8oM
 puO8XDVauUAtIL+8NCp3nqQ7zwQxYLkgd4zxhf9Sh+q65UOyps3VcrzJHlqtYequreCa
 zWUQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+es7+usdhba1L60njoXi+EDth+e29Je/Fx/o4bwaII9FyAIsL78z8q6i61+htMzkm960FHT9d+ZGE5@nongnu.org
X-Gm-Message-State: AOJu0YwgIa5E7bAtsvAJe5hC9HLlZc5qUXDvxLmzq1n9SgoccOawULsY
 Tlnaq1TJH+Vd6ZdOJ8KvYBAuE199q63NS2JpKh7B0TW+nStrwtbrDwlaASNqtfSm9HkiKGHtxav
 0j1wabr8Ud3y9eWhuwLP8hCH34PWldwQ=
X-Gm-Gg: Acq92OHgTj+brOTNEMSDq9UHaZpc52rxHzQoz5KAlPukVXFTRhMgFkdCEy8Y4GrQtTm
 yTc5uOF6lidJ35YVe609tGzTcgHvY6EfeTfRxLML/gooQOQ8Iy79Cm0CzJytiGzZzGfkAvtP6DX
 MtVlSKLNm0SDnmda8ar35n4WONAOkvbA098hE5Jx3bilTTYsOg/eS8EVEicOi6HgVqnSLKImk3F
 VP4vAGICo2xWWr//3o2BP4yYJUXwmIeAiw/JwiL3MS6lpPLKEbJlQ/+T7iIHpxPfYA90w9wTIh8
 ylO9SxPSgPOw687y/IWqD9km4+XCbOi+RvajQA==
X-Received: by 2002:a17:907:3e21:b0:bd2:1995:3a91 with SMTP id
 a640c23a62f3a-bd3bfb97777mr67751066b.12.1778639284619; Tue, 12 May 2026
 19:28:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260512094614.3464388-1-visitorckw@gmail.com>
In-Reply-To: <20260512094614.3464388-1-visitorckw@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 13 May 2026 12:27:37 +1000
X-Gm-Features: AVHnY4LFrJ1rWssFbxTKc5JjeT4bQnfgD5H5DSAulz01US7vUDI3s05s_Jer144
Message-ID: <CAKmqyKMbF=BxeaDRiRPhJjSmwJFnUFLHiV5jTqZc3u2J3KKwbw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/5] hw/riscv: Add support for Milk-V Duo board
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, christoph.muellner@vrull.eu, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu.zevorn@gmail.com, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, May 12, 2026 at 7:47=E2=80=AFPM Kuan-Wei Chiu <visitorckw@gmail.com=
> wrote:
>
> Add initial support for the Milk-V Duo board.
>
> This is something I've been playing around with in my local branch, and
> I've reached a point where the implementation is enough to boot OpenSBI
> and reach a Linux shell using an SD card image.

Great job!

>
> I am sending this as an RFC to get early feedback to understand the gap
> between this minimal implementation and what is required for a upstream
> merge. I plan to continue implementing missing blocks (like gpio and
> clk/rst) in future.

Overall this looks good and is going in the right direction. Being
able to boot Linux is a great start and a good achievement.

This could be submitted now, there is no requirement to add extra
functionality to upstream it. It would be great if you could add some
unit tests as well, so then we can test this as part of the QEMU CI.

Alistair

