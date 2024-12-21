Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C31A8E77184
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2024 03:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOq01-0002Rf-Os; Fri, 20 Dec 2024 22:17:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOq00-0002R9-98; Fri, 20 Dec 2024 22:17:52 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOpzy-0005Ep-RR; Fri, 20 Dec 2024 22:17:52 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2efd81c7ca4so1913163a91.2; 
 Fri, 20 Dec 2024 19:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734751068; x=1735355868; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ENLA9cVcPZw+PZva67xZP9D4/SCzS4OP2IvO6WzAedw=;
 b=SdqbHjDTsgg0OaWNd2xYAXfSSbiG8T+3xTZVFaDSVIILSOVjLaIueCvaNcIFiY2hju
 Bb07EpwMpB9vEPPspPA/rRq3NwlGjQYI3cov9M3YMEFCu/0KAuVNGQ8e2KmX9wZ9Z/bA
 9FbWwPSda//hm2kWm6H9ZPU5Om3O5YT+CNpraWqwCBmnXld84Ih2tBtGSQp1FPAGZtH+
 +WwsUAuW9V1ipHJt9UmVjqHLin1gotu+/GyYZQwTlpXHc+toSZJH69B2XWrWvj9FpooT
 QYTvZTs5uiBsRe2F7xVirBrJ3oGVraIc/v/t1icaT46Sv/d6+PFUxhscbZNFbExz4Mv1
 gBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734751068; x=1735355868;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ENLA9cVcPZw+PZva67xZP9D4/SCzS4OP2IvO6WzAedw=;
 b=oUejJjVJJGNi2CgmJkczYjukxLc2PnuKAL8t5+zMMCuAsWGZlQ0CgAh7uSz7to5WA/
 VjCCqaVsSxLcrDK2Ur2p8/OLJzi+M86TMG+l8QGXt102rKOk8RFybKNQfvvbshTH0qT/
 1qa7fqt8eFWScsH0ve8QKBZXX06G8gSOY7KfXpueaAdyC0zUuvAvwO2d8QIJxSqAMSmg
 jjtPnuNYLa4iDZ66L8d2UcfiBP18gcr/nN0FtRRl84iJKwQYLiqbMhPU1lY+4E0e+hb0
 JyMIR4Tk+QvbEYeZpGhCw+F0RU1zDsKfT9Eu2uEeOq9FcFnB98BFz8W4thrRgoz0wDSr
 1VYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQzkQe6UiCz9dKLTTlWhglvZ7Cnbz9AnUSupk2l0S/gPC4aX1Nn9/RfIGGeeSoyHvaivKwNXVDLPTT@nongnu.org
X-Gm-Message-State: AOJu0Yz0T+F6QnO0rVRBRejsehYv/ulAhfSvISnqqsc3GWuubWgFRoU3
 9B+OZ7wUF0U5m3K/wEffsG1kaqgHHvSXVXyGFE18bIAA7/2g/JLL
X-Gm-Gg: ASbGncuj9N9kr8EitdjPd3KHysq3lfb9BpV6iTkjPdfEjX1Ji7UFu8CvGGp83mIfBHZ
 uy9tu+YMU50YVP2cMb0bSFmwjC5giw0hhHzIJHAje3Vqt+e1QFkL5zuTEARh8Z3etpazEPNkraU
 NxYby4b9bJW6zN0nBxBH7h7Kmp3t07sUBAQ00EGJNjm7en8TWRILwEfTYrYH6Qnj7H1Js3BDK/a
 PIFVFsPV77/dAs4UB58bmzn3tDubP8fJ7OZgSa6hRfQYshtVgY9
X-Google-Smtp-Source: AGHT+IEHcd6BpkqvRiFbFLyzK2i+yyjgJb8oKrSQkg8tHk9tKVcHUFoJKumISt20KtIay8Kf1nqj8w==
X-Received: by 2002:a17:90a:d88d:b0:2ea:5e0c:2847 with SMTP id
 98e67ed59e1d1-2f452e4e81emr6725040a91.22.1734751068385; 
 Fri, 20 Dec 2024 19:17:48 -0800 (PST)
Received: from localhost ([203.221.215.169]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f4477c8518sm4455366a91.19.2024.12.20.19.17.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2024 19:17:47 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 21 Dec 2024 13:17:39 +1000
Message-Id: <D6H1XERTFTU7.J2FG4GD2TP8W@gmail.com>
Cc: "qemu-devel" <qemu-devel@nongnu.org>, "open list:Block layer core"
 <qemu-block@nongnu.org>, =?utf-8?q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Kevin Wolf" <kwolf@redhat.com>, "Hanna Reitz"
 <hreitz@redhat.com>, "Pavel Dovgalyuk" <pavel.dovgaluk@ispras.ru>, "Stefan
 Hajnoczi" <stefanha@redhat.com>, "Fam Zheng" <fam@euphon.net>, "Ronnie
 Sahlberg" <ronniesahlberg@gmail.com>, "John Snow" <jsnow@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, "Jason Wang" <jasowang@redhat.com>,
 "Vladimir Sementsov-Ogievskiy" <vsementsov@yandex-team.ru>, "Peter Xu"
 <peterx@redhat.com>, "Fabiano Rosas" <farosas@suse.de>, "Dr. David Alan
 Gilbert" <dave@treblig.org>, "Markus Armbruster" <armbru@redhat.com>,
 "Michael Roth" <michael.roth@amd.com>, "Wainer dos Santos Moschetta"
 <wainersm@redhat.com>
Subject: Re: [PATCH 13/17] hw/scsi: Convert to new bh API
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Paolo Bonzini" <pbonzini@redhat.com>
X-Mailer: aerc 0.18.2
References: <20241220104220.2007786-1-npiggin@gmail.com>
 <20241220104220.2007786-14-npiggin@gmail.com>
 <CABgObfbZsfCCQotUXpRAM_-T5nM_w3tW_DOc6E5bc6XDz7niXA@mail.gmail.com>
In-Reply-To: <CABgObfbZsfCCQotUXpRAM_-T5nM_w3tW_DOc6E5bc6XDz7niXA@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat Dec 21, 2024 at 9:54 AM AEST, Paolo Bonzini wrote:
> Il ven 20 dic 2024, 11:44 Nicholas Piggin <npiggin@gmail.com> ha scritto:
>
> > Convert aio_bh_schedule_oneshot() to aio_bh_schedule_oneshot_event(),
> > which can specify the clock type, making it compatible with
> > record-replay.
> >
> > Operations on SCSI reqs do affect target machine state, so it should
> > use QEMU_CLOCK_VIRTUAL to recorded and replay the bh.
> >
>
> This does not seem to match the patch below?

Ah, good catch, I missed fixing the changelog.

I think scsi_device_purge_requests() does not affect target because
it is called on machine reset so the state is all going away anyway.

But initially I thought scsi_dma_restart_cb did, like the ide
restart (which was a real bug). But that caused record-replay hangs
because it is a vm_change_state handler, so I took another looks and
it seems like it perhaps just kicks the host DMA running again and
perhaps it is okay to be outside record-replay. I'm completely
confident of this though.

And now you make me look again, the IDE restart is also a vm change
state handler. So my patch for that does not solve all problems
either (it's better than nothing, but still has this bug).

AFAIK, vm state change (stop, continue) should ideally not affect
machine or emulated devices right? Is it possible to split out
the architectural SCSI/IDE restart from the DMA restart that is
reqiured by vm state change?

At least I will redo the patches and leave a comment and a qemu log
message if we hit the case of IDE vmstate change with record
replay active...

Thanks,
Nick

>
> Paolo
>
> +    aio_bh_schedule_oneshot_event(blk_get_aio_context(s->conf.blk),
> > +                                  scsi_device_for_each_req_async_bh,
> > +                                  data, QEMU_CLOCK_REALTIME);
> >  }
> >
> >  static void scsi_device_realize(SCSIDevice *s, Error **errp)
> > --
> > 2.45.2
> >
> >


