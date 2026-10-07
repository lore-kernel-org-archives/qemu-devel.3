Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D76CA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 12:53:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xER9J-0001tf-6F; Wed, 07 Oct 2026 08:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xER9F-0001t5-Hv
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 08:53:29 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xER9D-0006mX-W0
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 08:53:29 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-8b056d58f2aso12629837b3.2
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 05:53:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791377607; cv=none;
 d=google.com; s=arc-20260327;
 b=f7zfKFi2E+As3f8H4iATUbU+JEoSXDi7J4hi5u90ZwhE7F38wtwH4gLBdEbT1rjFO+
 Gb6EAjAT9CPzd7E16iYlfmsisg7T2UQUFhNTKuYEyXDr9XdkTJfYM9Z5UIzVGzA99F1n
 CyaEKhKouGS2wM0wsXXFct5AVXfe3gJL/rczczpkErq5hcQ6usLU2LQ+J3nluHukWE0X
 up4l6lRBeBXjQN22T30hA7euRq+NVKiFSVpLKz8AjeNZ6R09iQI0c8arf5PsOGdef07b
 lfhjP+YluGkjCz8P4D4lrGbfvjGOdiXginDqup70EZ6+Qv5zDgw7gnqmrtmTgeZVKp02
 ubdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=AofFlWPWOabpA9EhCWh1GV/m9w1x1lBYtBymb1woM/8=;
 fh=UbT5VgazgNcWem2EdZIJtW2gajCIFUMQcHP8tVH/4oc=;
 b=lut8tipHiDMLLt3sdleZIpfXHeEsKto/ctSGPOHUZVffExn2FDfWFGW0i2sT5m66/V
 VHtqLc93PYP4H/eG+9Z0Lt42oFDMWBvOwI0fP9+gPGqupVZqC1J5BJe++Wp3vibWMEXM
 pn18oJLJi8ESERzU/s/nmE5ijhxjlRT5e5HHlLgjURfxl/XfhLkms+qhVPFaN3R3hzaP
 2sZEebia3DWzbQZlqxapEHuOJOUwc0AEhg8LA25s/davG4uOhe0/r1XzGJU+rLMpM1Dv
 DIFZVeBJdkI1rkLNM1/cQZl8dO03n1IwBgPBErDMp+ZIk9XacZQ+fPuUUsLlK8eqwKGm
 VQHA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791377607; x=1791982407; darn=nongnu.org;
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AofFlWPWOabpA9EhCWh1GV/m9w1x1lBYtBymb1woM/8=;
 b=IOzQc411rcElURkq6S04qnC/urxrwUY0DFdEZ6/tisiZxvMiWgy2JjTJfc/zXDkZLN
 cRnjxpg1xzBfmz2XDNZTqZi9jwCwjCdvHLIbGePVN1DypQe43N7hxMwgALptfo10qaiq
 C6TZZWVHKqkgouDvRCm3W19bckuML6+BRQYPZfHbuRxFjV/PdSzwsGdspr6mtTz0kpCb
 /KJnqeDa8DPxXt70IkpiPXZzGLQG2ghlb09Fra05kTBHKH3Jb1XPlTLeAHlpkIoAPwQn
 6jWP5vmKWh0KO3N8oAr4PYE6EC6IvMVthFf8/G4ONo7u7pw8pAE8USDKXtipnlLX7t5C
 LPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791377607; x=1791982407;
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AofFlWPWOabpA9EhCWh1GV/m9w1x1lBYtBymb1woM/8=;
 b=ryEfVht4j/KLarjOjCMIrU277prI6GwMWoJUjBv1JznzXGAdDrDaQ/SA9+OMcc09lW
 tyXQMy8ZK2+O/rrQXG3swCRQq3ort/BfX3gW5Yvj4nh5Sa2F1zif0spV37xBoeXQQyAv
 D2GmxvPcTMAuPBUeWEEVmlfx9jMCpMCDFEH38AQnLP/hH1cShZufjGJrL8qZnCIYfOeh
 rQVm91VECeBapbWQPmM7VRmngV/PeFPuojZdXYVkb1k/oSNWASMTQFCbgG8ZUKzXuis+
 aK+nRyasdztJKnTTKB3G2m3TfKlNoh21uJ4GOk4kLzLpcw7eR0OIaIpgWZxkxbjleFQN
 3bEg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx/n6Tj0bmk32jtIkyX+GQuPXbGjw0TKiOyoEo1bjLa4cg6vwh1K6bAvmbwHrJ3CWNFEzhfyXvurQeZ@nongnu.org
X-Gm-Message-State: AFq9FYJ8pWzmUDEoCTz/741TYLdleuZDD03SLFP2csaMJKqNBXSk9NN9
 HnKfNHg64H2I1s/yWG+XH7BL/k0t4xa7o/Di9Ng8ZiiBji4Mou2VX2+35cAil+4hodj+9t7jWC5
 bnHhnXa9cInxf48Pot3E1MOjxLVB2OO6Kc0qEtbvuJexa5okJH3Oa+OI=
X-Gm-Gg: AYBFou0CnrhtvUKZszRmaTf/UCycaqiIJ2+7nWoit3aWGUJxPP/6dF5vBWFM5RKlFOr
 GCUeeBUPqjvoL4c+ft86wUTr7lPLwR5K7tgpwhisiETenwLhUMplacL/mh0caFcHzM+uc8p62h1
 00kcUSNbYWCniULzKR9ifkuTSXm+IVFazvH98kNDWN28k8oySoAniXkc3YqTCQMiexgHRSzErVa
 qzP13MbYONIBms5o+TSKFGnf4LbtkHKZEpcTDbzz11/4ezVRWHE0FmkjI8FHmTESdU6TBAdOmS4
 sAwXn0wTIuScXWBo/36BTXvzW2oiqqi1a7UtPbnuocXG22KQHnSdZuip1vO/pMZH+qWrkSHADWl
 IEFCOG5uTpSknpE2EL02KOuXbumNtULYmNTgxSmQ=
X-Received: by 2002:a05:690c:e1d7:20b0:8a8:31af:381 with SMTP id
 00721157ae682-8b05b16abb0mr11024357b3.83.1791377606335; Wed, 07 Oct 2026
 05:53:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260914160020.327787-1-peter.maydell@linaro.org>
In-Reply-To: <20260914160020.327787-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Oct 2026 13:53:14 +0100
X-Gm-Features: AclHuK_bDTVMLk95Gy2HReWHRreUgHG3wWfY7M2VVSikSFCOYrFjuchpQM5v_tM
Message-ID: <CAFEAcA_30Oq5e7U2+GKeE1YGF2F5hp8avDo6tJaAs3aLeD+_iA@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] hw/intc/arm_gicv5: Minor fixes and cleanups
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

Ping for patch review on this series?

thanks
-- PMM

On Mon, 14 Sept 2026 at 17:00, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This patchset is a compilation of minor fixes and cleanups to the
> GICv5 code that I found in the course of implementing virtualization
> support:
>
>  * Various in-memory data structures are defined to be aligned to
>    their size, even if the guest provides a base address that is less
>    aligned
>  * We had some extra blank lines that didn't match the style in the
>    rest of the file
>  * We were unnecessarily extracting a bit from a raw register value
>    when we already had it cached as a boolean in a struct
>  * We weren't tidying up our allocated memory on finalize
>  * We can re-use arm_cpu_set_irq() rather than implementing the
>    set/clear IRQ/FIQ/NMI locally. (This doesn't matter much for these,
>    but VIRQ/VFIQ/VINMI have more complex logic in arm_cpu_set_irq()
>    that we don't want to have to duplicate.)
>  * Now we have a 'max-v9' we can clean up how we deal with the GICv5
>    needing a v9 CPU
>  * having the cpuif identify itself by IAFFID and the IRS do an
>    IAFFID->cpu index lookup is unnecessarily clunky
>
> Changes v1->v2:
>  * fixed the lack of ~ in masking calcs in patches 1 and 2
>  * patches 7-10 are new
>
> Only patch 3 here has been reviewed.
>
> thanks
> -- PMM
>
> Peter Maydell (9):
>   hw/intc/arm_gicv5: Ignore low bits in IRS_IST_BASER.ADDR
>   hw/intc/arm_gicv5: Ignore low bits in L1_ISTE.L2_ADDR
>   hw/intc/arm_gicv5: Regularize spacing in config_readl() switch
>   hw/intc/arm_gicv5: Use cached IRS_IST_BASER.VALID state
>   hw/intc/arm_gicv5: Free memory in finalize
>   target/arm: GICv5 cpuif: Use arm_cpu_set_irq() to set IRQ/FIQ status
>   target/arm: Only allow GICv5 on CPUs without AArch32 at EL1..3
>   hw/intc/arm_gicv5: Pass CPU index to CPU interface
>   hw/intc/arm_gicv5: Pass cpuidx rather than iaffid in gicv5_get_hppi()
>
>  hw/intc/arm_gicv5.c                | 72 +++++++++++++++++++++---------
>  hw/intc/arm_gicv5_common.c         |  5 ++-
>  include/hw/intc/arm_gicv5.h        |  1 +
>  include/hw/intc/arm_gicv5_stream.h | 10 +++--
>  target/arm/cpu-features.h          |  8 ++++
>  target/arm/cpu.c                   | 61 ++++++++++---------------
>  target/arm/cpu.h                   | 10 +++--
>  target/arm/internals.h             | 14 ++++++
>  target/arm/tcg/gicv5-cpuif.c       | 41 +++--------------
>  9 files changed, 120 insertions(+), 102 deletions(-)
>
> --

