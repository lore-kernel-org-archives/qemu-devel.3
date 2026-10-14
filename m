Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2651BCC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 12:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGxkW-0007av-Sd; Wed, 14 Oct 2026 08:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGxkT-0007ag-ND
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 08:06:21 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGxkQ-0003oe-DM
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 08:06:20 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-8ac8a2ac52bso41828207b3.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 05:06:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791979577; cv=none;
 d=google.com; s=arc-20260327;
 b=IguUXM/+iQfzcrVqIkOkHoowlmYg2acW4zForbRtRdDuhRZii9Vc9aa6tay2MeqofG
 p7ChRVOiCpPqelMkJleLe6DeL6R/M04z6IkAUPREadEM/rlQ0UZedkB4+xkxUM2W4Oy2
 Cs4zcnFvkqL8JnBA3SJOo/aNUJanMxOU37Wm/0OV7wApzhCyXIYmgVtjSmGTjAYJW7LF
 Pw2jlbgsAFzbFWZbRPRHuXWwHYGfAmIKqGL3xtJQpEHpq2M7nTKQGIz8ODP8x0nQys/3
 FwAaJYXJMuq/LsXKPWkUCRKvQ/1teij9Je+MULdVyFx8D+z5J06W75iTK7H/YoQ8G0qM
 C8AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=d/3zqLfYuRm+7YCJo4+EtPoysMl01w41Nwru3cxg2z0=;
 fh=YHoQpvTWCe2sf9yaDxE7bMloNaE7q4NVBTFaJj17TiI=;
 b=qVb/cYiiGHS/Xa/S3G+H3q4K2iwPmWwb3p9j2Cjms0pnb6FGM+E+oeChSLhTepQyY7
 +43+Wv1KQLSmHMRDR6338c47t9Ky3eWDpHtLZc+Gzb3lQfrcjQqEG50FrmxMIZ48MnCj
 cGfPypGmmOX7tMlKwFSEMDNE8Zhc4lmPsnGsrJRcOgkgmGi8+t908PGOXtATVTImwcIy
 f9BwscDLRm34nqIQBxvswK4Yy+lZlFyqiRgNP8DcG68EDBQU+WiQkOCKStRoQn2gTDc+
 EvN95/5fTZOVHuyyQZAcuNV6KMpzDlSLaJ4A0XBOxDTH1nUc4r99T/f9PcALU1ujfKiA
 kNNA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791979577; x=1792584377; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=d/3zqLfYuRm+7YCJo4+EtPoysMl01w41Nwru3cxg2z0=;
 b=L/jFHOnDhozMDKzW2RhXm8eu2hfQrL5q6xlb2rG1Z79YZASq0c+tXAr8J/nHGpb/xT
 6zhrtfbD73kxgmvR5Zzs+H0AXjwy2AI2ClW+tJArjE8YgerJl/AimI8iCnvjdhW/MAIX
 1aD6Mt4qgmXZomjpJnG55mGOvcLwffPjLy0k1xAqWbqpzDjPPs6qGM35yAuMtjpdykj5
 LpBHUYHz3NuRaqaE5fccsw3Mmd7LTelQ3kG6UvapSJlEXpgDgkRQbVUhtaSAkPu7U4CY
 w2d9smR2gcnH+7Lx5JBg06Mp0JX16P89dZF47SB144dYf+0lCFDwYUd6j3dXV9g8NGoc
 REIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791979577; x=1792584377;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=d/3zqLfYuRm+7YCJo4+EtPoysMl01w41Nwru3cxg2z0=;
 b=wKNGoQsFNCbowsJLKGjTAZlwFBH2eSNmIumgl9JoYBQxcFBpeEoGdwvcZGeAbQnqMs
 v8O3AhgnT5EAopraoLPpFMCEDtZIL2NecldeuuRZ70dmaQnYdugush/CPSPD14UpBPHm
 fYsCt/jhG0mzBIgY6khaybilLdECycbOcT2t8EUrpN5rpqeBBxWn9hxh1BWqCqK8eGcg
 ZTxsTodmhW1Oy3Xpl7qdYdUUJ+BvKBNHn/DV2+Bw6yxYlu+w+8DzJYSnHYlPh7mnVVL6
 HiMtp0QDdDt/likE6ue7QEe3YkQUtcgP6Bwlc9E84QSq4I9VSKj9XR9hvPqmXqi7LFNf
 /aWg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxOfL8MEYQD9lbiSU9Xqh3LenfoKVEaXehTru9gR0XZRF7/5dy4oscacN5t9Dft04Hcd4qFI80IwQIU@nongnu.org
X-Gm-Message-State: AFq9FYKvlpP+NsVc1ER85y297mbeA2yTYRVgoL/PP5nglO08L+pgZ0X1
 DSaID0Nq5C4loI5UD5OBg3CPn2BOkjalWoWtNVZVvtK7keacK4jh3FUrezst5Ugx3u4MCTIgVlf
 /Gyd3p6MI2S7OOj13i0L/y3WIHwPxv9+2dLFaA26YWA==
X-Gm-Gg: AYBFou30oyM0GuKBJ/CWkYlWH1SZi191uMkX7FohKJ8ULRKjDTrBRlfgcURbMysW4zn
 +Orptg7DnWvoxxwv647rcwGUZyTsHeM63lmUDNcTIRRhPcM6vF4og/cuO39axXxPc4HQTPBfvpn
 VqYI0JtLEmWR6Tah6kWsXD2+6ZvXF0dUY/QLFgMduOMMSci+SXTg1hmkPP9hOV509xigXrtjFZJ
 L7wDXXEA54752csHnjuGRAgTZA+1Km/vraBdEEWb+Z4ba8m2MnkRuk39HRdbyUmZxl1hoHsGdrw
 GWWPSenFsYaen+NdBC5sFad2Oy2Gug+PH9gf30TZfimwbLr8bPWfnMZMyRqjIV6UsnLE1Z9LzGL
 GmKq7duGCpC8aXbGiR/gPJkIQ+GS85w1t/7k4kKs=
X-Received: by 2002:a05:690c:47c4:b0:8a7:ef2a:ff9c with SMTP id
 00721157ae682-8b07ebfde3amr43167667b3.2.1791979577149; Wed, 14 Oct 2026
 05:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
 <20260916104435.600211-15-mark.caveayland@nutanix.com>
 <CAFEAcA_fv66MxW4QKHjUypSwTZL=LK6YVLgNvoMH83ivn=EMbQ@mail.gmail.com>
 <0148737f-834a-4e7a-8e7f-7fff2ffaa90b@nutanix.com>
In-Reply-To: <0148737f-834a-4e7a-8e7f-7fff2ffaa90b@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 14 Oct 2026 13:06:05 +0100
X-Gm-Features: AclHuK8r8W29TXukvU3-Y7mDsa8VmOnEakDfcbLqZ_5sU32lHwrsaLd93jsyRyA
Message-ID: <CAFEAcA_uWm4kq=NRDcUHrU_gDBEiVRc7_FQz+k6omAre0+p7gA@mail.gmail.com>
Subject: Re: [PATCH 14/22] i8259.c: properly cascade secondary i8259 from
 primary i8259
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com, 
 sstabellini@kernel.org, anthony@xenproject.org, edgar.iglesias@gmail.com, 
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Wed, 14 Oct 2026 at 12:20, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> On 13/10/2026 17:18, Peter Maydell wrote:
>
> > On Wed, 16 Sept 2026 at 11:49, Mark Cave-Ayland
> > <mark.caveayland@nutanix.com> wrote:
> >>
> >> Currently the cascaded output from the secondary i8259 is returned directly in
> >> the pass_irqs[] array, instead of being connected to the relevant input of the
> >> primary i8259.
> >>
> >> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> >> ---
> >>   hw/intc/i8259.c | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
> >> index fcc94e12f8..964ceb04b2 100644
> >> --- a/hw/intc/i8259.c
> >> +++ b/hw/intc/i8259.c
> >> @@ -501,7 +501,8 @@ static void i8259_pic_realize(DeviceState *dev, Error **errp)
> >>       }
> >>
> >>       /* Wire up secondary cascade */
> >> -    qdev_connect_gpio_out(sec_dev, 0, s->pass_irqs[2]);
> >> +    qdev_connect_gpio_out(sec_dev, 0,
> >> +                          qdev_get_gpio_in(pri_dev, 2));
> >
> > We just added this line in the previous patch, so we might as well
> > squash this change into the previous one I think.
> The reason for having this in a separate commit is because it is
> technically a behaviour change. Before this commit, an interrupt from
> the secondary PIC would *always* raise the passed interrupt, whereas on
> real hardware it is possible to disable interrupts from the secondary
> PIC by masking the relevant input on the primary PIC [1].

OK, if it's a behaviour change that's fine. The commit message
is written as if it's just a refactoring, though -- it would
be helpful to spell out what the behaviour change there and
that it's fixing a corner case bug.

-- PMM

