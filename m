Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF8A8C79F99
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 13:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3vTX-0005qR-7F; Tue, 08 Sep 2026 09:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3vTP-0005pu-7o
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 09:02:51 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3vTN-0006mG-CG
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 09:02:50 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-861a2ae9c51so52388607b3.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 06:02:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788872568; cv=none;
 d=google.com; s=arc-20260327;
 b=ETSjI680dPCbSWiKE5/Ix7cpn5dga1NxLUOzOjlzKQ8CaGTHl5FteQMkPul42kguHV
 oMT8EFhJSJaNULTiB3v2nC4f7H6lnSp9cgm2dqT4vMZH8JsPMXINzxv+Pg+Bm8yzu24R
 BvVZQF+uxQBZCQPDkMbwV1EnPhm475+2HzlwIwRW9NlcuKqs5sbIFY16ysCfwd11wwha
 PH2QKOD1qTb0/b6kNSU727K0opTV5INe0n6HEgx8TwxzLyh0E3alsyC0uAVztSBMXFdq
 cojCzdds2kwZfNxXuV5iO5/N61usG4lIGxPuy5n2hwfDoNxtycSngFxc2Dx/HpgFWjUN
 VRzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gxoejITaV8EJZ0L3fA2zu8GDWjWmHZv0urCXtCaJMGU=;
 fh=mnxap6nv1rtlHfh/EtIVsAO3KoZ39x1WWRQkDxrLyVs=;
 b=YeD34ByK2O2WC1IUiIq1NGLk0hxE5Euvgr4y4ttBAgG/RroMH91ASIHcVdbAgZf6mS
 TvStizCGVcEtIvH7e99mfj7XALRxRUiCGt0GrMOMUgTEEDP2lRYkLS8K6a/4zeQsccxj
 PZFEATHYveQCh6ik7kDQ9NbjiV1JjoGEx2O370UwRUgsj7jT9iImO5qFZ1XXkF/4vFOv
 E7u0u623WGRKTVlleVGnzUPHyeipxs2WUw5xnPztCRbR5wpWV2iNvyzYMfMme9m8A+xZ
 GLnxJM3/ctj7MzoVblr9fXJSoXBHGLS1HN03fY3X//K3UdV0IzcKYYOtOb8Jfi0i3iGC
 t2UQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788872568; x=1789477368; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gxoejITaV8EJZ0L3fA2zu8GDWjWmHZv0urCXtCaJMGU=;
 b=SMLY204vWYFv941oG7dqcnMZRacYO0GaNC7YtM2QaOQaugR4/rgxf/H93ijauoLEEU
 2l3El8xbDRiSSGNkmZOCAQwQapSxDRNnJ/G6VVz/2Vm6rqTJ2ON/BRNIMRszcNDkt8H9
 9skUNVnzvxZTan3/ece+YOajRmoY6ZZLZHFKN9MeHA6/HBJDUdHKGIxMoy+NPVtKSif1
 KRWcsx+gpI3g8XSpRX+ROdJV0I3e032XsQ/jwggXyNHiewC/NIjY1W5AFyG2DLbPWHyH
 Loholsej193a1cS8MIhItMtNf5PbfzmFoikNzKXI7mOuc2A2LTbVARgMPE3JaOFnwXZ3
 EkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788872568; x=1789477368;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gxoejITaV8EJZ0L3fA2zu8GDWjWmHZv0urCXtCaJMGU=;
 b=VSxD1a/St/mSTH5ruh2OtzfieGFaORj/pgGSHCYzjySVvEup8O9CyQA7QR8JtVXQRE
 5N6IUaIAGcgfpTYE899vndOLHrvqijhLJlPEwxY6j0Uo3PC6o0vuBepTzc3nQ/GSUJ07
 mf1UvCZhRYd8nPY/CFw38FgZdAZocEPns/lhmNRkY2ELZ4CET5lsK26J8MG3fo9OghXD
 22okrL/dzi2e2aYM/qvGuj48iIKsaWeZG+YzKshN3/EkibpsfkCAxGdFoNmCltsgDuUY
 HOUMWk88xPJW1JHriNfLDMl3GIbk9vE6EQao1EJUaqj9vjA8By6IIJOg9YJe76B1piU+
 2+eQ==
X-Gm-Message-State: AFuF++lTttcc6t6/px/053SEZxhAX96u1Qa7Pbf9sc95xfixSaPMfV11
 H99JZ3L2SCnZiPOC8MCZIM1NVrdNb2NjPIfQBopsjs1LRzEV5RNvMf7EIymzFDrkw75IHx2XQkq
 8qP7X1U1cuXBh0aQCE5vozMdsw7G4p1fYGF4BM3JBbg==
X-Gm-Gg: AYBFou0EL0DmSRIVOB1NNYKsNQCx7vbdobemEwcoKLRRuz0x6uRw9fsS7hzwNB3TOMM
 fj1KAPLVh8e+Brsb75rrv9xfq7w6J+E/bDmnr+y6oVrwxEL1+wVHQHTp9ZRQ7b3icqLseED2WfN
 zqFaHhe9Vm52Qw4Q1caWbOGvAbasmvnMql45EIEqLHLfrkprku2Zwcw3Sf6KBvy1NYY7quls/N4
 EGupBVOZbdy5z4qMuK69z1ABGX5wyjqYmcZUWi+9wiPBfPbf32sJL0Zm1mTOhYpP4q2cxKUEUh2
 Qokz7HGumjsPgKlOQK8dYli+jnfbN38saNxCGNuyA5yBpTiFVHrIUu0sTBxwL2xsMQrWayEqH4c
 WRZ/5+PFaWc7EN3pliWB+c0rIQ+dh
X-Received: by 2002:a05:690c:c3b8:b0:867:ae30:4ea8 with SMTP id
 00721157ae682-8712c90b967mr73111827b3.34.1788872547449; Tue, 08 Sep 2026
 06:02:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+F1CLTUd1HxdZQ=Ot2eMKcHTiP52f2V-=mehfOcFzN0UtXsg@mail.gmail.com>
In-Reply-To: <CAJ+F1CLTUd1HxdZQ=Ot2eMKcHTiP52f2V-=mehfOcFzN0UtXsg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Sep 2026 14:02:14 +0100
X-Gm-Features: AcwNN1VWvtSPvP_BrKZpwoyZuL75EWlrjVXWroaon2kAkpqtoHMxdTII7He50dc
Message-ID: <CAFEAcA-Z1_=NSi2xvpYcac6t1vP8aHWxaebrHD5CdnRt0p2gMg@mail.gmail.com>
Subject: Re: Proposed QEMU 11.2 release schedule
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Tue, 8 Sept 2026 at 12:16, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi Stefan & all,
>
> Would that be a suitable release schedule? It's a bit earlier than
> last year (https://wiki.qemu.org/Planning/10.2 release date 12-23)
>
> 2026-08-12 Beginning of development phase
> 2026-11-09 Soft feature freeze. Only bug fixes after this point. All
> feature changes must be already in a sub maintainer tree and all pull
> requests from submaintainers must have been sent to the list by this
> date.
> 2026-11-16 Hard feature freeze. Tag rc0
> 2026-11-23 Tag rc1
> 2026-11-30 Tag rc2
> 2026-12-07 Tag rc3
> 2026-12-14 Release, or tag rc4 if needed
> 2026-12-21 Release, if we needed an rc4

Richard is running the release this cycle, so up to him, but
I would suggest that this is too close to Christmas and would
move it a week earlier.

-- PMM

