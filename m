Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7803CD6E57
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 01:10:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUwb3-0006X8-GM; Wed, 03 Jun 2026 21:10:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wUwb1-0006To-6R
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 21:10:07 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wUwax-0005hI-Fw
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 21:10:06 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-7e86d46b02dso1974307b3.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 18:10:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780535400; cv=none;
 d=google.com; s=arc-20240605;
 b=AVlY0yDnZxkM8oZ+p8389pVoCvyOs3mHIRJaUzLZ/HvW4mXrGQ0eDA68viT777B4fw
 yir0iCuFQXCEuz3MeSguy2JBQmPTEjItvzaPwXb1NBTJZnZBrx8G0KoNS4EP3TL1kfOM
 WD+cAq6yPHpxU9andaX05rAj68lTiSSVN7ReG/fscQyFPF+Dbn//6IlK1wKaa+4Gb0nW
 YxsZMfpIWWqoTlYa2EwZG47sqYzpy4y7c3Qq2TWOG4hjFZBYQqJjKgHdOUh9AyLdOq8I
 ejs+Yd9vOc8KIKwrC7XYLx35eDl+dtF4KU46KdjcpwRFyxkRTuKtMLY4T1tz3rMZdTP/
 88Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fIed5qgpa5dwUJMxn35bujyif9xQg3tYkXlsm1gXA+U=;
 fh=OGWLbOmAOSP5dNFnMZ7C9DuFXSzk+iZ7T/QMFNwD7uY=;
 b=GWErYtS+3wVeC3Jbg6gQO+gCjXtbcRVKZc4KueYLt2TWSpuvbbp9XA6wLtZP8q2NLN
 ae8wlD2E/Pjw6GAskVim9RKlMJ0nbK//k/Nmyt9wGeonwpcy7nw9/RHi9Kj5V8RzPtpR
 oWxs14Qn3FlOyOdlzuD+gSgqgIZ5Cwt2m6uBF8Bz8Mr24Vbhv2QoS9Ku+pa1NdblRZXC
 iWXDdh/RV1x0lrDfqW/stVIg2GWbN1hUZSfy5yl1VCNmKJYwlZEtZ87RVhheLEBZDw9G
 flRAFUpQsZVqauy1fww/7oEblzvdLVjZruiq0CovgTjE7OYUA06rng9tVCo1AYQrO6Vc
 oFWQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1780535400; x=1781140200; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fIed5qgpa5dwUJMxn35bujyif9xQg3tYkXlsm1gXA+U=;
 b=mqQzAkN1nxocLHwIyNA+VGaAJG2nRAXWv8Yq8XP/A7XYVwlYiGvaykazN3la1CLxAC
 q54Gw4g4IQwJ3q8Pmv0ZOS2PhS2i0aZRG2pmG930H+UUHxQJs68f2O40mgSHMuypcuNh
 fXOjaVCYqAXzY/JmO30RZCvtl0tZReVLgOLyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780535400; x=1781140200;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fIed5qgpa5dwUJMxn35bujyif9xQg3tYkXlsm1gXA+U=;
 b=iLUSmcZzet54KKvKXuEdhbbQ9vx53R9NlHnuX6rKITGGmrhKxjwcdMkfBZvzIxRwQM
 Ne8GiOIO6dsUnRoTMhhrRRF/lZJ9LdHWogxleH5Pjfa7NIKO/wY00nwE7n0pOMfNNLpC
 YVMsc4hwppem8rGdZg6N/FIey76SvirzRHC3d2/Ls8gVTumMNZiLHbqgc3KCys2hMJix
 6nVgr5jSlx5f0Z4Rr001X3fE47k6LAhQOBVoJU4MdfKzbNDL53zX3rnrorAZg1W9GJeS
 0Kd0H1HQB9r5RmL28Lf5bVjG7e7DLwTXqRV/SCsFVCSL613wgiNL5KgFzpA/1uPw6va0
 ld9Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/zBzDnElWZgNNHXx/J36OEMUKNlGFPRXraBWLnC49Bq9+2VRpvBZ3L0CXhlJvVgbO/44Bz8QEnKDlc@nongnu.org
X-Gm-Message-State: AOJu0YyAjQ2LOTrzlFcVIPvZneYyCYXKU65wKY4Obhv6Iz6sQ0eb+s/J
 9zUUsWOWMRpyGvFxTz9rwXjLGsDfzk+hiKB3cpRgfvcX3DV+vjGr5cZL31GC1YaL4dwkDauRqZi
 wGmQ86ZGIItwwtB5R5nYttw3GkDlpyi0=
X-Gm-Gg: Acq92OG3m7Mb0lls8iEje71uPUkmmD9zc/t/qosqnh6DD7Gz6u9FOb7PAAcS4BjzmvN
 vcu0ECeevKVseWZddgGTdNVpVUahLTfMGi6h2gQFuTXI5aEp52LDsPIaYTyAkX9qpeNONvbFMah
 I2Sf82UWzGfrw42DbguzpFe41BJjlG8podS09MtUg3GYCohYr32Lh7kOy+admq63nAPT68A7V26
 9sdB1SvQEpWs3sG5R7eCld4uOQtH/ZZGVoPM+rJF+Vo6fAE2fdmdOdHClJUcJ4WTg3+F9En0fiq
 e9gkiTRez/ewO+da0AAxu6Fl2Bmaupu218KFVlU+BDPd+e6MDufCmi4HA5kGybTwp4XnWZ62Uda
 o2hNixdtlfSHNlOd4V9L3VY/YoKZfKJfPiD8=
X-Received: by 2002:a05:690c:3682:b0:7bd:577d:7828 with SMTP id
 00721157ae682-7ea4987b42cmr53589307b3.31.1780535399639; Wed, 03 Jun 2026
 18:09:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260528131214.2251075-1-daniel.barboza@oss.qualcomm.com>
 <20260528131214.2251075-2-daniel.barboza@oss.qualcomm.com>
 <ahz7-1OomsZTMIz2@ChaodeMacBook-Pro.local>
 <b063eb61-a246-4f10-bac2-ee9272afcd2f@oss.qualcomm.com>
In-Reply-To: <b063eb61-a246-4f10-bac2-ee9272afcd2f@oss.qualcomm.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 4 Jun 2026 10:39:48 +0930
X-Gm-Features: AVHnY4LcozYN8wqknDYQoC6wRDK9EI5pMFa79rlcsdEesr8BW8hKWj7h18o_yrU
Message-ID: <CACPK8XcjabfXiDLNm5WoaypfHKbGRggqLL3gob2FWz2TZf0ZZw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] target/riscv: deprecate 'debug' CPU property and
 Debug 0.13
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 alistair.francis@wdc.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 Tao Tang <tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=joel.stan@gmail.com; helo=mail-yw1-x1135.google.com
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

On Thu, 4 Jun 2026 at 06:27, Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
>
>
> On 6/1/2026 1:04 AM, Chao Liu wrote:
> > Hi Daniel,
> >
> > On Thu, May 28, 2026 at 10:12:14AM +0800, Daniel Henrique Barboza wrote:
> >> Starting on commit f31ba686a9 ("target/riscv/cpu.c: add 'sdtrig' in
> >> riscv,isa') the 'debug' flag has been used as an alias for 'sdtrig' that
> >> is, for now, compliant with Debug 0.13 that was ratified 8 years go.
> >>
> >> We're going to add more debug trigger extensions, e.g. 'sdext' [1].
> >> Thing is that 'sdext' and all other extensions that will follow are now
> >> adherent to Debug 1.0, ratified Dec 2022.  And so it happens that Debug
> >> 1.0 and 0.13 are not compatible with each other.  This makes support new
> >> Debug 1.0 extensions like 'sdext' harder because we would need two
> >> independent code bases for each.
> >>
> >> We consider that most of the RVI ecosystem already moved on to Debug
> >> 1.0 and is now going towards the extended Debug 1.0 extensions, and we
> >> should follow suit.  And the best way to do that is to leave Debug 0.13
> >> behind, by deprecating its 'debug' flag and making it an alias for
> >> 'sdtrig' that will eventually move on to Debug 1.0.
> >>
> >> The following changes are made:
> >>
> >> - 'ext_sdtrig' flag was added in cpu->cfg. 'debug' flag was removed from
> >>    cpu->cfg;
> >> - All occurrences of cpu->cfg.debug were replaced to 'ext_sdtrig';
> >> - Two explicit getters and setters for the 'debug' property were added.
> >>    The property will simply get/set ext_sdtrig;
> >> - vmstate_debug was renamed to vmstate_sdtrig. We're aware that this
> >>    will impact migration between QEMU 10.2 to newer versions, but we're
> >>    still in a point where the migration break cost isn't big enough to
> >>    justify adding migration compatibility scaffolding.
> >>
> >> Finally, deprecated.rst was updated to deprecate 'debug' and inform that
> >> it will be now interpreted as an alias of 'sdtrig', which is now going
> >> to be compliant with Debug 1.0.
> >>
> >
> > This patch conflicts with Alistair's riscv-to-apply.next branch.
> >
> > f71708fedf target/riscv/tcg: disable svnapot if satp_mode < sv39
>
> Based on recent discussions with Alistair (check the "QEMU RISC-V Call" thread)
> seems like we're postponing this change because there seems to be interest
> in keeping the 'debug' flag around, together with the 'sdtrig' extension that
> we need for your 'sdext' extension (and for the riscv-server-ref board).  Seems
> like someone is going to send patches making it possible.

I think this was a reference to Nick's work (I got credit for a bunch
of things Nick said on the call, so swap out "Joel" for "Nick" in some
places):

 [RFC PATCH 00/25] target/riscv/debug: Sdtrig fixes and TT Ascalon support
 https://lore.kernel.org/qemu-devel/20260114044701.1173347-1-npiggin@gmail.com/

I encouraged Nick to get it out on the list early, to make others
aware of the work that had been done.
He mentioned there's some further improvements to make, I'll let him
fill you in.

Cheers,

Joel

