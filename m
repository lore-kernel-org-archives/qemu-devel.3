Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B26E9C61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 11:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzYWC-0001UJ-DF; Thu, 27 Aug 2026 07:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzYWB-0001U3-Fs
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 07:43:39 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzYWA-00028J-0A
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 07:43:39 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-66ceaade3f1so1974120d50.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 04:43:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787831017; cv=none;
 d=google.com; s=arc-20260327;
 b=OhlRx0qpnu8HomcVLxrsbrcWRWv7PfZewg54McTxrgi/eQSt6HPOV4nqNbmy5So88k
 XV/yYPlgaYISurBSY3wRqKgfmMle3fexV0yc9Gd4gACczV02+7PWiY/6NySX4NALP+x+
 UyjIZHUI5hq7nxpp6cmThR35LbH2qXddNRfhyhFbSMT8CAyRSnYPTi3XTyAEUmzaXQVe
 i2F2eM55N+ul5kTooCKbrqHY56NySt8loxhoN2WU0atWXzYCfeZGHoN47PXyor6k+e3n
 KsRIOxY/cd534s6IMex250qX5KslF9RA+1+yFGnR4TPD5czrrfA9F2duk3uu+dkktC1v
 XAtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=U/QiQGqrVY6L6I6dyaHA0RjlF/f6uTPAhgIInOpAcag=;
 fh=m5HWyJD7/CbHnS18T70hWpFuILsk0gqQH/wE8LADv1o=;
 b=Q/MElwEQQZhBgagqWU/4PEYIEKL5obsj9vM0c0svVEY41K0dM+E39ko1I2DV7XTDw/
 /zs/9a7VeviTuZUbVMpYhF2YKg+wo8pL2bPtM8RY2y9ASM0+0dbYQ9dEA5c4L9ghZ2ew
 djbEXGy9Fv5mAb2onS5RTrZKkWyQxrcpzzBQMbqPxo57P/Q8gNDSudq4PwyHV9FGtCzj
 8hdWZsKTucsRoSFASaWUCwkGvzJNu9uES6DqREqyWquGUZQP+MFBbrKyiAmPXkyJ3iPI
 2n6SWJL3iiTaF5lEwjYl04OkosJEWCJJi6zWeckwYPa5P/k2UW4XNdLzVfJDkzw/2a7s
 rMyQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1787831017; x=1788435817; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=U/QiQGqrVY6L6I6dyaHA0RjlF/f6uTPAhgIInOpAcag=;
 b=G8hd0za/qAvMfvZQOfjAouxeOH4I/1Nl+/KtfH/uDODQEO9cZqvu14p7wXyVrFo09U
 fntN/aLuS4h7M6WHwGIm99WId8faEhJyDKk3z01fAwm0IcaLn9c+eh3DER1acxE8tJFT
 feGnQG9TlrifHonMMpZXL60lTGaJp9fYj6oOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787831017; x=1788435817;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=U/QiQGqrVY6L6I6dyaHA0RjlF/f6uTPAhgIInOpAcag=;
 b=neg7EnRauiMkZPHixE206N+2fdsUaZDLWwvYOcPmY7Q0BlQRF0oTLxtf+ZQJoNDVS/
 GAloQtM5Qxj+SGK8usnT7leXx0Sg2uyhyrpbY2/16XKxWiEir9eGAtknGAFf9xRP/Mp1
 lnifYDo58ube8C/+zNNvPImMM+TqkIfsGY45+LeFty7jUglUGmnePorRbYcopnwYK2HE
 OTsYUBmEdm5Cm+OmzENj3yp5/vMzl7fpJSkfaMMRY6ymiCX27uOP/CUpNuWPuNcUG7P2
 Z3xMpBx2aNbwubqdA/JSLWj8fmJA3s9yigH82NUjc1yRPxoM9sG1wcodtHmY0LLkSjK/
 /mcw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp3qodvPye/uCbswUrK9BR29wJ0FxfMjKPqAZspZO3pBpf3SK6lSMFX4SKbfksGF29XgT898tNSq731@nongnu.org
X-Gm-Message-State: AFuF++lRKmNVR0PwrsdW8UcuyXjUDxlPjKhWXFrofzCL98EPshrA1IpU
 nozjcbxgz2JoOpZcbqjGMkNYfRr5xxzyhbNLUNB/eS7ue1kyHcJCbZCdKq6eWuGPcD2LVRYUAzV
 b6WH9z9/q8Msfvj1GafekkDHU5ZEGEg4=
X-Gm-Gg: AR+sD11VIBRkRf8tKa5KhXL3Ok0hxDE9gvPh6tSFYZ+cMkdUzkY15762z7cJObkW2+o
 2nlAWWvsMD6dZDjbkqXbmwKXogI4tpGLIyANPNPLSdAwV24TlaugkSbJyiEO3tFBJAB9qdME4Xl
 o6ASA5zg7cKLrQH6Ln07N3USOxWpfkKIHtPWSvJv9nglRDZFM2HzWKbKl7CbDWqI0tHXlyB6DV4
 d8jtdvJu7qQljU5vK3kfeRNlJWNgVOk5eDvdjXd8IZwqIUa0gYvOV2Mu6tmuMoVRG3JcGpe+B7y
 EIjRUp0qFHc+TFoM9oNKnDyX8+UrSJSnq840PZkPYp/tRkozjImy2AJWlW78YENTtR83mufmWff
 d9CRsRiQewFJNEw2kWQKVB2T1zBq+B8EABifHFsNPR68fhXy5CE8GQHxaGrap6UnqrZ0QiR7gR5
 OejQ8iixfmU0Af5/so
X-Received: by 2002:a05:690e:12cb:b0:66d:113a:3928 with SMTP id
 956f58d0204a3-66d256827e9mr4966075d50.12.1787831016635; Thu, 27 Aug 2026
 04:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260826220528.54516-1-joel@jms.id.au>
 <20260826220528.54516-9-joel@jms.id.au>
 <0da0b312-106c-418b-9827-f340a736f502@oss.qualcomm.com>
In-Reply-To: <0da0b312-106c-418b-9827-f340a736f502@oss.qualcomm.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 27 Aug 2026 21:13:25 +0930
X-Gm-Features: AcwNN1WzIeegeDA_EL8pclbrCytZlGwakQZ2kFExJzi4uwRLFK72xjEYfbE4QM4
Message-ID: <CACPK8Xe+2ObYr2dFFcuPfMkigLEb5bTHX2t06Xr_ZzaDvJaAtQ@mail.gmail.com>
Subject: Re: [PATCH 08/16] hw/riscv/atlantis: Remove unused fdt_size
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, 
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-riscv@nongnu.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=joel.stan@gmail.com; helo=mail-yx1-xb12b.google.com
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

On Thu, 27 Aug 2026 at 20:45, Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
>
>
> On 8/26/2026 7:05 PM, Joel Stanley wrote:
> > The machine state carries around the FDT size which isn't used by
> > anything.
>
> AFAIK no RISC-V boards are doing anything with the fdt_size return value
> from create_fdt() at this moment.  Maybe they were doing it in the past and
> we just kept it around.
>
> Probably something we could clean up in other boards too.

I noticed the same. It's dead code with the variable not checked, and
in some code paths the size is not even modified by libfdt.

It was at this point in development that I found myself making
tree-wide changes and writing coccinelle scripts. I backed down for
the moment, but watch this space.

