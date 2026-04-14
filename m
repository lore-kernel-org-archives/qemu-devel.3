Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A64F9D0D3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 15:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCfhE-0006pA-1T; Tue, 14 Apr 2026 11:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wCfhB-0006oh-6e
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 11:28:57 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wCfh9-0000ja-8Q
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 11:28:56 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5a2beddab48so5509271e87.1
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 08:28:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776180533; cv=none;
 d=google.com; s=arc-20240605;
 b=CXLSX5XKi9H+w682CoQhY0hpOPSYiPQde3V+HFVGz4vyQMGK9tpBmCjWQ1lHRQ6unl
 bGg1ae29GECYlfalwrmuA4MOHoRh6qjm2CwnUV+xTobrgkZ/xjMXJRMrgqmkr7Xjg/I8
 oDRQv1zxvNvi+YmTwtSxkS6tj8Bpg4S660NeuC/fGnqa5HYBBsJeeu+mX/7ag3hHsdfU
 SUZzihp9J4zQ/95XHOlNlOeNNUau14KalTWdjZ57q5w+K799c2bzIbvSzv4iSq6i/jJB
 040OCrOboEd272dWbAPEs3ATvWGeKYxkTs1qLkfTSp7/9448LanMsEQ/vRgA8qtdCSgJ
 PKbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=r4fRx9uMLiAF9kvQv2xyM9tR/zWxCvqPzXkqpbQJD6c=;
 fh=zMqNfbU/2zNkKF+Cag57LKHm2/PU2HxigWdxjzl/lRQ=;
 b=c2XXxmGuLdnqdDeX8nEnSaiBy8+0T3ayN5/X+9MrReXqNoiIwPmmdUKiQ26XCD1Dod
 Vjt96zvYHshJmvXbhmvmEefMvuSdXz6w8K9q+pVw3ONpRaQBns/YisjIPTRm/xYAs3EZ
 3CHDkQxKWW/5Smvismv7kcApQz/J0uS0PebDxFj0VMAtsk7gcABW8PqnCkk9a1wGYdvy
 yyDOLzrvKzdIrEn7GyWkZiw0L084Uj8QZ17M+U90hIrdnW7rAb9Dthj5AIKv/Hcto80r
 JQWWboVUIFg7MuH/EHyH3QbD5fdJ4/Ld32+tPoDTFiB3imMljjOzVMwmbIVOXgpk8xLu
 66rg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1776180533; x=1776785333; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r4fRx9uMLiAF9kvQv2xyM9tR/zWxCvqPzXkqpbQJD6c=;
 b=PYALa9s0LrLfri+eykHVrsXYhGn9jUY3fUB6QQR2jz1U1pGSA/5WfevJAe6y/CtfZk
 XS++gf94sSyH2EbPnAkOMN61TulzcAc9iJpZ8JpqoeojjiB7yfggg86ac+LxTKJcks3Y
 bHLbbzvTcvfvo6fX6pLgudQUzosZl8u5b6krU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776180533; x=1776785333;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r4fRx9uMLiAF9kvQv2xyM9tR/zWxCvqPzXkqpbQJD6c=;
 b=Fs8qi4QF6nt+usJ8DGbN/GUS9oquRDyvz+OeZYM/A2QhBXKSM0dzf2ZBYtkhd3HJ+l
 /yqgA2MIAfSHLmTBZ5x/+T54/y+NrrupuxSC7zkNTyOo1yiVg3ore6/o9P5pvJG1hSzs
 bI1C2pNNKMv6RDufNAQOUFJIRiPV8LqkYkK3GHhgjSXyG60UvXLIN+yX+8xcOjNMxNEr
 BRv7T64c9OPcWPSLh97hLRY02+2Lg6OVaXyoavH75CkVDYrdnaWXL30c53WhxZ/i8Bc3
 Ireo3XCloZeJlAnvxY2bgskgHVYrvzsOzNwaEnCOnH0hD4zyaB41nWZhtGsHJTrOf34y
 ydKw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Td4k6kahUjzvd1inV0VJwShi0iNBCtnZjYeiNJiiaBcl333zCSz2uMbWtQ3o43l36DvMlYfXZk1hy@nongnu.org
X-Gm-Message-State: AOJu0YxQlqyURKsZ+MPS1csvJPgATOx+htWhDFGUHTIEsKXq5hmrVEw1
 uEeVALVzpX0ZqgTAu4ovINrKcAp5A6CDab12bHsSeE9cP+n1HQZVIFzsjoy4k9hWBVs5E8a5gC0
 XtIYuBOPemKUKvUERdN1vCvDP1obO66Wpajq6uBzPNA==
X-Gm-Gg: AeBDieuahQc/MQJExAJI4qTmqq0vRIEWIFs7vRxmYMUCR89WLlMNrwNb6XmOWw04qtU
 tYlMjHAc1Gk/RNLomJ2dCHD226b6FXJml5lqoi/HCRBo1c9j9Q8h4nOwP1GH40aoirMoPJyrB1z
 6P+jFn+um0n/aVphoVLt8vS3zAq/D0/pXW2CawL28qVCovVSDG73o8XD+eiMv9WnlNKii5RUNxR
 E1IRMu7LAIf+5uDgRzrGEqmktabHofKuzGx3EnZa7HE+LUmnwzXYI7w/amZeDsmyrmmJzYAoDsV
 5B9oudIbVsURKLZEVq117NHs6QCfs6d+wo3DLv8=
X-Received: by 2002:a05:6512:3d0f:b0:5a2:b889:3b79 with SMTP id
 2adb3069b0e04-5a3efb43c15mr5419550e87.2.1776180532191; Tue, 14 Apr 2026
 08:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260401202844.673494-1-peterx@redhat.com>
 <CAJqdLrr9yyxr29U53NpFhghn7Nycd5LkA8U7eLSb9tjz3Huppw@mail.gmail.com>
 <87jyu9zhtq.fsf@suse.de>
In-Reply-To: <87jyu9zhtq.fsf@suse.de>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Tue, 14 Apr 2026 17:28:40 +0200
X-Gm-Features: AQROBzA9W3bzAkIFHnv7p6pTjCC8733e1WvgveEaF-O0MVpLx-ZQaC4477zR0WI
Message-ID: <CAJqdLrpS-Ha5M8EqjzD7L1SiuaZwgO_x_onUULNuwo1QApWwGg@mail.gmail.com>
Subject: Re: [PATCH 00/11] vmstate: Implement VMS_ARRAY_OF_POINTER_AUTO_ALLOC
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, 
 Juraj Marcin <jmarcin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=alexander@mihalicyn.com; helo=mail-lf1-x12e.google.com
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

Am Di., 14. Apr. 2026 um 17:23 Uhr schrieb Fabiano Rosas <farosas@suse.de>:
>
> Alexander Mikhalitsyn <alexander@mihalicyn.com> writes:
>
> > Dear friends,
> >
> > when I can expect this to be landed in master? I would like to prepare
> > and send next version of my
> > NVMe live migration patchset, that's why I'm asking.
> >
>
> I intend to send a pull request as soon as the release happens and the
> next development cycle opens.  Probably by the end of this week, unless
> we need to have another -rc.
>

Thank you, Fabiano! And sorry for bothering with this question ;-)

Kind regards,
Alex

