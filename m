Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1172ACD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:59:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRtF3-00046G-4D; Tue, 26 May 2026 10:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wRtEy-00042V-H1
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:58:44 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wRtEv-0006wp-Al
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:58:43 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-393d6025f99so105640141fa.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:58:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779807518; cv=none;
 d=google.com; s=arc-20240605;
 b=LttcqgT/9/n1oIZ/AruAo8jWMOpXidwpPPjm0XPvbN/TI01JeOTC0dJWfeF2N7gBWE
 /4GUQdsH5kZS9UyuA5J6iWqHi1PTIl+I/kq3fY3j49ju91Uvo9ZW9EbGiMJnhBZupVwI
 La9mdj46Y/ctQQ9Szk5Tk68vI7sUey9O8NmoarqZfBynmYa04Fyv56OpaETUiTBSJ0h6
 uaImlhoKEc2PYCv5/FJafIYEDNxNz4A/dyC7gZf1PWG+KdiThpnevy8OP0E5DL9fwcWY
 dld6t6sDldGn91OS1+o40b7yagc2Nbrc9I5yDcQej63x7Li9sqW06lEXAvG4JtH3LAOc
 EVHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=you26xEPJm20hYM6wktq3KtIZeiuThYaFjic904hbzw=;
 fh=MMcR8mKPphBjKxaqKocB+pPofRLf22dPcQILiUF8Xd8=;
 b=N8+snv2vg4q3PygAwEVVM4DKk1297z1r6gz/mAt5q0yJn+sGOS6WT1ra57BPdacrXF
 KaIMOwzLtN6ZAnAWlhxKleJmH0fi+0Ro0A30gDqPRuQjQU62XDdPJzn7NadRLm3Rxj2g
 0n5MPHHVwjzIdqgRW523BkMuCYILtOswkRHcfYoa3NI3mmRbyhW+C3r+2YDlFaIkCnr0
 5GLIthsHCD0QNv7LFhy6UCsi6WGHogDcalxFj4f/8YiqJK2eXgzJ5A5F4M+ucAaMgm8x
 1tjs6Qn9Mww5PLjBVK1h959jIAjJtuAJkKhmP5SGyIY2MMBpGi6prfzHngYijudNEsFk
 2hCA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779807518; x=1780412318; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=you26xEPJm20hYM6wktq3KtIZeiuThYaFjic904hbzw=;
 b=IZUXkLW9t8ISYGs/TXthepFBUpwIVo2jcQyDjBPkGPqbS2n2bVV59jRVCb8Znp+F5p
 y2H51iEPCx9Wab+iScx2djEnVb/Y0nYNAIBkmYx4bHnjlpHp2nUERr3SSZwSC3zWIlzd
 pTNObtF5pcl0fVd9ipYHD3n0fxSTkwH+ZMKT7HxbdIU1hWykF96pk35xxpWQnimS+LHt
 HlUmO7pwWcqnRYCTE2nP7q/cI9Cm1MGT2Zc4+gRawNPvlZi2WkLjEeNo82r2u3f2Hosa
 zx6SqKbTgOtiEA2UR3LOghsByLRgvM9n6LMif/XK6HvYi4lNf8UgoPXRL6a+jMrRoBKS
 y6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779807518; x=1780412318;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=you26xEPJm20hYM6wktq3KtIZeiuThYaFjic904hbzw=;
 b=hl8AgqDHTVcWZfHMBGilEkqVrY5CpirWHhG2pjKZduwKn5vQ+C6XWFfMhq5soaI0Pj
 5pAx+UubLNMSV5bggjr0tcz8XxOImrBmMyN9Lj7LJE4ZGY5ZR3Vk9ReitRcnmAkAswCC
 ubZFXxbB8OcBmTXaV4jQdQjfO3zLD9+L08b3WJy0zzEydhVOhMCGJkJJdpIb/snNnbiA
 /Ns3dD9kbkz1ViLbOoFU2b0YhqcT0FweFSJY8mU0FD1x++mKU+3uTHGK2Bw8DfKuxHfV
 fz3oChNXsJCgUmJI0w3Y9XYVhTBjuHqcvKdlpAiwLu1iiyTBH80eGL2o/UcHiVzMW/Wb
 i8IA==
X-Gm-Message-State: AOJu0YwCpAhW5kMtd0J/lKUvceg3bs7K7YCO4zDyLfS+tZRNNL/oCzxp
 +fmj1SPlWBsbSmJQ7tZsew4xo1mWA8c1CF7zYOkST17Eg+rABbn20PV5qFqejcHDERN5Nith/gj
 3A2aiM1lBFhtbDakVo6XQERHb/Md4dD4=
X-Gm-Gg: Acq92OH3eEW3fCAvm0t3g7/QNhQFcVR1CikP1oQEmRRpO5Yt5OM1v2pfhCSXE7WY/EP
 6bsk0q48olq7GiXFvhZAAmPepnQgWYZtJtoHtHhBm2Scy0Knfilg6M7EK5Bz0YnbAEDOHCvvBZQ
 sbfSG2o5AXoLFjuDdvLYTJTEM9Z31MPxPbS9YIgBTv4MUSuqGDpOYIWbAtpfYHn1ZbBIWoT9Jpk
 wZzrXN6f/R2w27+t+DmGUof9bO7wLcpKzvVXvntqhiqOByPPtST8041f045Ncw6C8kKa8XwY8lI
 sPm6EGlsFw==
X-Received: by 2002:a2e:958c:0:b0:393:9cf1:78a with SMTP id
 38308e7fff4ca-395ca56fbebmr53226261fa.22.1779807518131; Tue, 26 May 2026
 07:58:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260525152210.4119543-1-mattst88@gmail.com>
 <f4f5a3a3-f042-4d97-92ec-ca37e9991b43@linux.ibm.com>
In-Reply-To: <f4f5a3a3-f042-4d97-92ec-ca37e9991b43@linux.ibm.com>
From: Matt Turner <mattst88@gmail.com>
Date: Tue, 26 May 2026 10:58:25 -0400
X-Gm-Features: AVHnY4KjPTWFhOqYoLH48K8u2ch4vZg1f4jX850hWHZefOV1koTP3AR2rDZY3EQ
Message-ID: <CAEdQ38GPkcRvBZnjoK1XTE_TrKVvyBBNAhs=7DqHOEmrwtY=XQ@mail.gmail.com>
Subject: Re: [PATCH] linux-user/s390x: restore fpu_status rounding mode from
 FPC on sigreturn
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>, 
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=mattst88@gmail.com; helo=mail-lj1-x236.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, May 26, 2026 at 7:20=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> On 5/25/26 17:22, Matt Turner wrote:
> > QEMU keeps the s390x floating-point control register (FPC) in env->fpc.
> > The rounding mode bits [2:0] of FPC are reflected into the derived
> > env->fpu_status via set_float_rounding_mode(); every architectural
> > write to FPC goes through HELPER(sfpc) which keeps the two in sync.
> >
> > restore_sigregs() restored FPC with a direct assignment:
> >
> >      __get_user(env->fpc, &sc->fpregs.fpc);
> >
> > This wrote env->fpc correctly but never updated env->fpu_status, so on
> > sigreturn the interrupted code resumed with whatever rounding mode the
> > signal handler last installed in fpu_status.
> >
> > Factor the two-step "write fpc + sync fpu_status" logic out of
> > HELPER(sfpc) into cpu_s390x_load_fpc(), declare it in cpu.h, and call
> > it from restore_sigregs() in place of the direct assignment.
> > cpu_s390x_load_fpc() omits the specification-exception check that
> > HELPER(sfpc) performs; raw signal frame restoration does not validate
> > the saved state.
> >
> > Fixes: 2941e0fa05 ("linux-user/s390x: Save/restore fpc when handling a =
signal")
> > Cc: qemu-stable@nongnu.org
> > ---
> >   linux-user/s390x/signal.c     | 6 +++++-
> >   target/s390x/cpu.h            | 1 +
> >   target/s390x/tcg/fpu_helper.c | 6 ++++++
> >   3 files changed, 12 insertions(+), 1 deletion(-)
>
> Just curious, how did you stumble upon this?
> It looks like a source of nasty intermittent bugs.

Indeed.

I spent a lot of time this weekend debugging the `signals` test on
sh4, which resulted in this patch:

https://lists.gnu.org/archive/html/qemu-devel/2026-05/msg06646.html

It was hard to debug from scratch, but the solution was so simple and
the problem so obvious (if you know to look for it) that I figured I
would do an audit of other architectures. I found this, as well as an
issue on MIPS and another on PPC.

Hopefully my ten minutes of effort on s390/mips/ppc will save someone
a couple of days in the future. :)

