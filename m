Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4F6C61DB6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 09:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wynQc-0001wz-IN; Tue, 25 Aug 2026 05:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wynQa-0001wX-Vp
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 05:26:44 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wynQY-0001P6-Us
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 05:26:44 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-66c711b7f2aso6584098d50.3
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 02:26:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787650001; cv=none;
 d=google.com; s=arc-20260327;
 b=iunZDpfW+rM9n90KoqKMtdxAgRBVmCCXQgG4iK1GYhmZCjsM1ijcIP9Q+AQinx2tW5
 6otMYnhiNGzidRjtHEmbuvTN2vrGXiusqOiyv19lYcdk4QlOUKBdHt2b4KjeQF+uNVNN
 7r6WK4iBAkfbElpMlrGRKh7mxM/sb8hwOkgqebIGCxzG8KkoN6HZ/9JsOwxlrRpQN1yv
 tEu9SCXwjwrEIsxzhXAwRPIVjxXIwMoag2iWRMsg7Txdoq61fl+N54aurQsC/n3wSJYF
 0/Beg+lJib2xs716RIet4eiJCTiXxmAwwOiHI1q2su8olLvRBPTPIb8NUYZCYSJbHXZV
 eI5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rv4C4op9b/+H/RxL4FDvYBB1nWUocf+3RodK5gCKWeI=;
 fh=M9obt2bsxV/Lz3otzTHt/WIM5ozQa/1MdEn4TugEAP4=;
 b=CCSaWx4K8JkdiZtIx/Rb18hbvlKUSyJI/O/Exkde6EqQzcxsKst21TkSAsdHBdQwIP
 txj7z9PAzvL/XT/y8Zp6aid/xUDn+n0WFKnjM3UwBvXxz1sbeK2pNG2w0Sv15E+huLzm
 tMCD0kpP0djp/uEA0SbMkFcYjiDlk18AXzF5YCeYRmpgqbcchAvSQbRsfBfntht5WzNG
 fX9hMaDO5D2/9h3HlFIJaxqxQduaq0hdtZlftY7D6nORe2MtKNvueIlaFSgQcHPhPpJr
 2C7Am2PZsLcK3MDqRieQXxPBovm7q4XSBW6HlrdeA18SDTogKlbXilNL+AlpANzUp4B4
 ukbA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787650001; x=1788254801; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rv4C4op9b/+H/RxL4FDvYBB1nWUocf+3RodK5gCKWeI=;
 b=nefJIlLy9M4bogJsH2xpyfIJvruhacYbUSCwIQI5KdL/BRnmCDFHnVgDx44GimM1Nv
 Ds3DoxUs+uOt375T5VTB/vP+7CmV93jLgCtbws8HN0o++PAEMRFQkaUmUxF27Eo++jmQ
 Nj9xb7I9EWSrPdmYiLW6kb8d7jctVqEY2I5catn30n/MAkKdZUiFfrGWRrMThy8pKKVJ
 blZKwXAXKEo9ddwcprWZGacGZ4W6kkLXDkoN1A8DTNf8JfvKwSi2yVvNu2vyaSarPzTc
 /33sld0u+dXY6IwX1EeU67jX9ACRKnS1jVMd3jm4AiuDX2Mop96QJ9+E0ccnDoLxRAYA
 BZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787650001; x=1788254801;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rv4C4op9b/+H/RxL4FDvYBB1nWUocf+3RodK5gCKWeI=;
 b=oTI/LDDxpcqeAxIdyETpbIxJRvmgUVJnMzFzJJ+9iqYEpWq9Rr0B+BpLyVTA0WD7+5
 GYyxIGBifKxTOJPoEWkuYPH3bgHdXPkC/XBE82n4OAs2p0bGqlV8XcCNZDWWPOxiLFg9
 lK1bQFEcBY9THDOKC88uGcpWuazRTwwOqDebj6RIVHC35k1mB379nDtC65uapxsD9Lav
 Q8XkBkXko+rqwVRsLw9zqMlqwdndmOYDb/xCXoEhvSd7BM+5IRBYpUetwx0CHd6ancEy
 OdDq42Auw8WvnNd0UgxKxQq6Sc1IebvLB01ZR6Ub/8GX3AYpL/uA9Ok22PO1YxIkBgLG
 z+6g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrEuewf9mBH1wy//KcIvkXX1bmC1WQt325URMYSBBb6pGeY+LoSA1jdJskc0Bk/8t5udp2rOI5kBb93@nongnu.org
X-Gm-Message-State: AFuF++lNFgSvOosplof3gQFq7yH4D613WRSSRyjj5DsqzV1z+bcH4J9Z
 NZLU7Xtijt06J/ggwaBFFJfsk5I/gfepzBkVWsO6WNsH7yQqi916XlHqxH06Y9XBsCHAOv6Ec0Q
 uE2AnDX0dogW2YVjVlEUCPcWTgC5SqstXNPMiHXX/Sw==
X-Gm-Gg: AR+sD10fVixK6N1Fu1hbvx+nLTNr14uiqR3vlQjJ2gyJMwJa/dI0QEb+/VN3+TsewWI
 hluujBZ3YugwAvv48wVrzH9X+4Hsr/Cn/UsI685p6gb0dB+yRdl5izSlubV2x+F2cvSk2hyzUBW
 e8SL9CDYEHgA1JsL5KtRJDOsNqsoFG4kjMDn1hBTTCLQ+eTWOHwNI8fV5YQSaq1fybXAAoSPxgz
 +2StN1QEKAWCSZuMq2XszzjTi75WDGG+NhZJbGQVI0DqP5u5+VrJFqrJvOpvDQUTvrCYztOxDpp
 zSVWV/G5lpwcAWA/pp4rNIFAHbKYTjvJNK8xUiQmEmSGXmXEBgcQJKP5i+DENuFDkslEPvlmoq+
 N25dillTkxUYzahZaKA/Vx0n01lsu
X-Received: by 2002:a05:690e:1449:b0:66d:1131:b81d with SMTP id
 956f58d0204a3-66d1131bc41mr2756351d50.29.1787650001294; Tue, 25 Aug 2026
 02:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260627154225.863984-1-bin.meng@processmission.com>
 <20260627154225.863984-2-bin.meng@processmission.com>
 <4c1c01709d9e903fbe93fbce5b901ff959a5a01f.camel@alistair23.me>
In-Reply-To: <4c1c01709d9e903fbe93fbce5b901ff959a5a01f.camel@alistair23.me>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Aug 2026 10:26:29 +0100
X-Gm-Features: AcwNN1WMUESrB3U3h05wX1Kvwv9VRxetZ7MD9KvJUFZHGc8mH5meqMDiXNCiHEM
Message-ID: <CAFEAcA8VtORuoLj4p62vj2dGtsawWmaUWUw4dW6vtxn3g5aG8w@mail.gmail.com>
Subject: Re: [PATCH 1/1] hw/arm: xlnx-zcu102: Fix up DTB for direct Linux boot
To: Alistair <alistair@alistair23.me>
Cc: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Tue, 25 Aug 2026 at 05:20, Alistair <alistair@alistair23.me> wrote:
>
> On Sat, 2026-06-27 at 23:42 +0800, Bin Meng wrote:
> > Real-board ZCU102 DTBs describe the UART, SDHCI and GQSPI nodes
> > in terms of ZynqMP PM firmware providers for clocks, resets, power
> > domains and pin control. QEMU does not model those runtime firmware
> > providers, so using such a DTB with -kernel currently requires users
> > to edit the DTB before Linux can probe the boot-critical devices.

> > +    zcu102_fdt_fixup_clocks(fdt, "/axi/serial@ff000000",
> > pss_ref_clk);
> > +    zcu102_fdt_fixup_clocks(fdt, "/axi/serial@ff010000",
> > pss_ref_clk);
> > +    zcu102_fdt_fixup_clocks(fdt, "/axi/mmc@ff170000", pss_ref_clk);
> > +    zcu102_fdt_fixup_clocks(fdt, "/axi/spi@ff0f0000", pss_ref_clk);
>
> I don't think this is something QEMU should be doing. Modifying the DTB
> on the fly just seems very brittle and prone to breakage and confusion.

It is something we do already in some limited cases on other boards where
we don't model all the hardware, for example in imx8mm_evk_modify_dtb()
we nop out some nodes and make some other minor tweaks. I'm not a
huge fan of having to do that but it's a pragmatic thing where we
don't have models of the hardware the kernel is expecting.
This patch does seem to make slightly more extensive edits than that,
though.

thanks
-- PMM

