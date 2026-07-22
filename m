Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D956C44533
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 08:28:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmSIN-0004A7-00; Wed, 22 Jul 2026 04:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wmSIK-000450-SG
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 04:27:12 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wmSIJ-000693-2d
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 04:27:12 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-81eff3ddba4so48764007b3.3
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 01:27:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784708830; cv=none;
 d=google.com; s=arc-20260327;
 b=Naz6Ovefpszky9kIu5scyhA+LYUPhOu2Vr8GUU/n1DGZ8biWSe43UnwutnbOj6G+bO
 xAooHOEITS5YBpC9lVJWKT1yT+lOhxSsv0D5LG+mjOwd++XykUT2KL6Qbux2QjHq9ms8
 kFaJqMIszBM7rw09c9ZGPMyi5MF8EXVkqNr9uMrpkezmW7k001/+fPb/vGAnAKI81rKS
 U0LLyrS/dIoDPP2iyTmCZpofifHR/QoTY7/DTION/kojLnVia2tmR/uAVwBjNIetaktE
 eM6nmVjxIiXbJxctWrhaBCQQ0dMyOTfac/q4CWZk8dlYIT+ZunIgZjsiJdmRv4nmwCqy
 Nigw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tM7fJAJed/jW69c9wYglwSGLmt5mew2td6nHsMchr5M=;
 fh=hgKqMw/CgWXOGg+YwoWB5ePKGFnfDTsQ+kHc44UeZcE=;
 b=r0gzauC3anSODkzHwmpixlP847+Vhx8+P5I9JhzQ1hszYl/XFW21bkz0Hvyz9y8tRC
 wT1xgrCAvVnx/NNgAgZstm4fwyEW1G5jg/Z2cnUyvI69xsgwZH+J2/uiWCuM9ngwO0cR
 pieBfU4K7jGy2pIC+W7ul0zczV1pHPMuxyubefUuKbnfvgyrLpzCSSZk7F8k6J94ugNk
 L58T32YmwGZbMciI6V2/auoVCGlMU4AYcuK8dxDNLt4rbTinbHzyTuVxZf8onGcoDn9A
 dOWPB9E1pshw5x7jfydh5A79/yYyq2nwSU4Hdc5jsX2B5pZK/GHdtEg6P6qGSsDMbrIC
 KSWw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784708830; x=1785313630; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tM7fJAJed/jW69c9wYglwSGLmt5mew2td6nHsMchr5M=;
 b=BaJJXP9X7V6yEM+65od9dcrShsf/z8Ju8dAooR+009nkAWGHnj/8prulmtxlQMdpjM
 pRR/lZu+7gWaIbGeNolb8+TCED778ydSqbA9KvpVP0kQDZRZrZT7hRuTVlUHYOb6xO3X
 HxWvhIDiuhH8akR5vEfXJL7xDr1cRpDnsNcTV0YEfcXNFkD5UyFSpL8alr1H1Id6PsUo
 snIELOmAjZ4RJ3yIcNegbF01IIyELJ8x9PHkz7dw7G51sJ92DyCdm0Y5dzBOjNiDz4av
 AvPNmdOg0D81dyugsIqrsU4YjmiKwXZSJIQkANZbRjKul+WLGXaF7v6VZ0I6SCTxT/zd
 HKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784708830; x=1785313630;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tM7fJAJed/jW69c9wYglwSGLmt5mew2td6nHsMchr5M=;
 b=GrEdftKBeElvO1wx/nz8ZY150fa2BAGjFoYqM+j7bm4s7mzjXojtRMnfsspMX46rhS
 GOMRJkcCNeC7c+9OAy+RMqXbuFLvmTqfZLiHP17FcHWstX89phrdtZyRwy1EO7WiapWs
 JQZYz22Bvb02XfR5i5vCmYvIovHtBhhc2mURlGpg0IP5kZFfhlb5+GC6weNolwokkHtq
 KvQSrnr3qBrVFzDawSevAMWeMLWpgiKwZ0rWTKjWO6/nkEgzSPbxGiJrlPzBvJ84/J52
 x22GL3c9tyxpSBIqLs5TZNsv2j8FTFnwZHfj9GECFgz/slCUMjvrkolLjFzvxbXwCG0/
 QfRw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp6/fYOQRQxzeTFvKG68ObOn55gnyuDFIziyThD0r9CLeTmrQchLOHfqhwl7MXgyFnGS6b9e8Mz/Kpc@nongnu.org
X-Gm-Message-State: AOJu0Yy/oyBuKGDejigFFHcYNxRE3Ar7SmeukGO5NjO1nZQ4o/qEUb9K
 sW4Oy0PbdQkw6S2Wi9ZLx3hSNwPrhc3xde9IOgAo6liPS3y8ydKJ5eF2P/4MiVNW89Q0zlYObFV
 n3JZktkCJ5cCrMK+57RlGAuFarEdYSKU0cZlTwYIIZg==
X-Gm-Gg: AR+sD10nvSCpAZEoeoHz+FpB3cmPnPnBWWUTNNjxbHWFkBpw0A9j6rCqck/2ND2/vUw
 8gm6mgvMZ/+vtvwx6gvbsOx29xrHOeuyFtG12u1PuMpYR4wj2Lmx4wwBl30beaGk/fVrcXRdajj
 /faFknsUeE05PCVJprRoWH4XgqIZovuv3MMBUrAb/JlJ8qOpQcYDxfp+CJWqXQEE9V3HiYGbPn9
 bUT8e0M8xMDkgU6tzFVYu44hzfpK2tK9bGCcm/yPA8pNXn6kGHsIVzKrO+/VzMD5jGtEWtb9b71
 DkW6MVfeCyYx1q2PJTkoZC2Mh8QHD2MOEiuJG1upZkx7uQ==
X-Received: by 2002:a05:690c:6988:b0:81e:2b86:d75f with SMTP id
 00721157ae682-81ef2704c4dmr65442217b3.68.1784708829654; Wed, 22 Jul 2026
 01:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260715131819.14827-1-dingtao0430@163.com>
 <20260715131819.14827-2-dingtao0430@163.com>
 <63046247-5e3a-4943-852a-985ffdc1f087@tls.msk.ru>
In-Reply-To: <63046247-5e3a-4943-852a-985ffdc1f087@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 22 Jul 2026 09:26:58 +0100
X-Gm-Features: AUfX_mzzNm8zY6cS5eh0E3xtWBb_G8hwMppOvWwKTLpkXUE-jQ3hxrRDjbQaUWA
Message-ID: <CAFEAcA-k5U_AnQXTOEeshYSpZcQyOMrFEJgnqOqpO4EMQBGNZg@mail.gmail.com>
Subject: Re: [PATCH 1/1] hw/char: imx_serial: add missing migration state
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Tao Ding <dingtao0430@163.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 QEMU Stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Tue, 21 Jul 2026 at 20:01, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> On 7/15/26 16:18, Tao Ding wrote:
> > Add ucr2 from imx_serial to vmstate, and increment the version_id.
> >
> > Migrating on sabrelite can reproduce this issue:
> > 1. Prepare the U-Boot required for sabrelite. (according to sabrelite.rst)
> > 2. Compile qemu
> >      $ mkdir build && cd build && ../configure --target-list="arm-softmmu" && make -j4
> > 3. Start sabrelite and prepare for migration
> >      $ ./build/qemu-system-arm -M sabrelite \
> >      -smp 1 -m 1G -display none -serial null -serial mon:stdio \
> >      -kernel ~/u-boot
> > 4. Enter qemu monitor after uboot. (ctrl + a + c)
> >      (qemu) stop
> >      (qemu) xp /4wx 0x021e8084
> >      021e8084: 0x00004027 0x00000784 0x00008000 0x00000a01
> >      (qemu) migrate -d file:vmstate
> >      (qemu) q
> >
> > Load the migrated vmstate, before repairing:
> >
> > $ ./build/qemu-system-arm -M sabrelite \
> >      -smp 1 -m 1G -display none -serial null -serial mon:stdio \
> >      -kernel ~/u-boot -incoming file:vmstate
> >
> > (ctrl + a + c)
> >      QEMU 11.0.50 monitor - type 'help' for more information
> >      (qemu) xp /4wx 0x021e8084
> >      021e8084: 0x00000004 0x00000784 0x00008000 0x00000a01
> >      (qemu) q
> >
> > It can be found that the data for address 0x021e8084 (register of usr2 in imx_serial of sabrelite)
> > is not the data before the migration.
> >
> > After being repaired:
> > $ ./build/qemu-system-arm -M sabrelite \
> >      -smp 1 -m 1G -display none -serial null -serial mon:stdio \
> >      -kernel ~/u-boot -incoming file:vmstate
> > (ctrl + a + c)
> >      QEMU 11.0.50 monitor - type 'help' for more information
> >      (qemu) xp /4wx 0x021e8084
> >      021e8084: 0x00004027 0x00000784 0x00008000 0x00000a01
> >
> > Signed-off-by: Tao Ding <dingtao0430@163.com>
>
>
> Somehow, this grow Cc: qemu-stable@ in the final version which was
> applied as v11.1.0-rc0-68-g8833ff95eaf.  I don't think this is a
> good candidate for the stable series, since this fix changes the
> migration stream format, which is very difficult to do in the stable
> series.

On the other hand it goes from "migration doesn't work" to
"migration works" for a typical guest :-)  But I agree it's
probably better to avoid migration breaks in stable branches
unless they're fixing something really critical.

-- PMM

