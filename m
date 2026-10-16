Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50ECDCC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 07:20:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHcF1-00014l-5f; Fri, 16 Oct 2026 03:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xHcEy-00012l-IK
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 03:20:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xHcEw-0001tj-BO
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 03:20:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792135228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nlY0zaNIRSAlCGiHt5dpIH2xNpiENPFHUjdwoSvE4Hs=;
 b=VHxdnAXkRdqeWDqhx0AUx+HKnzfHmP6EhtRQYf2foaSYcc+u9307sIGP7hcpbRQJSCfn1A
 as7wk3jqt92hugVKuBwKqr+vZb5ZZVwNOTrpaNZxSsz5wmHIB/cAoKdB7tuxnvwmJ0axaw
 yjmBPDa82PdQgKHTlMAyS/LIm+d/9Ig=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-ImaDmvH5Nrus0S6Q1tgbHA-1; Fri, 16 Oct 2026 07:20:26 +0000
X-MC-Unique: ImaDmvH5Nrus0S6Q1tgbHA-1
X-Mimecast-MFC-AGG-ID: ImaDmvH5Nrus0S6Q1tgbHA_1792135225
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ac575a9198so3559251a91.3
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 00:20:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792135225; cv=none;
 d=google.com; s=arc-20260327;
 b=NRoWRFrqYgGM029bKy1d0UL698IH5216H4GEk2b6rQ8mYFViqIRkpwU+BwCoqh6+4d
 TX8ca+45S373qdCJUo9RLXwCnLKadpRAQXKMbbG+U4M6/mR2GOP1suelC48oJWf6yWYs
 4vMCBYmyCL+X5N42188hulrpfHuJPH9KIgjbPENbvDeSjEFFx8Q6ofK0FDUjIgoR13dh
 qOJEDqRytlXYDuXulB7e7A//rsYl2J1ZJsB4j1cU7SAejeuMuVRcpnMYOJArGgpj7Ydc
 l9xpZbQBx+3nEd2zPlDpcibF+UOCeeMqorCyaaHb9LpHKydDeSNX2Rope64eiyEeRL8N
 YM3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nlY0zaNIRSAlCGiHt5dpIH2xNpiENPFHUjdwoSvE4Hs=;
 fh=lZLkOphK9EAX+1MVdeTF4LY6MVAmJaj+PuynQ7+aa/I=;
 b=OH7RAnZgXUAXcRpO62d7t/UU14CPRJTYxafRvy8bBOql8rKDKot+OF8mg/5DUWO14J
 0CkieNpKXiJ+HlmgoJcizaVnPXO40UMmrP1CMc1ARiWCCc7fTp9zMwzk+7G1ypc5IgaW
 zuccMgoZRXIYFCgQoKASrcArR/p0mUapy6410gFIW3clm1EC7ulOlC4gTK9t5srvv9Fu
 IvTbeL0sZBbfjtzv1MnkvIgULs6TiDKlQPWxV4FeGRa0/At2PMW2NUb1G0Bb3ibDn0zu
 wKZazXK8+LYgtVXYAKUroZoGPKBTVZ8lvvlApZVHuffhrk7+4mQX2JK2hHznC1f3iSsu
 tctw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792135225; x=1792740025; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nlY0zaNIRSAlCGiHt5dpIH2xNpiENPFHUjdwoSvE4Hs=;
 b=tq+DQZ49Belrm+P7QSw5dPO1EV1FGafpp3Pqd1kde2BGG+iofxLhu+ccub4tZkSUa0
 55rLu3Pagc7QC0iBZPJkE5pElL7b8va3qKSIK38YWBTW5gFfDOnUNP2tbbPFoI1TqtQJ
 XIDq35gYR9f2/qcyZE7Ap28b5FLiumXVRkpWM3TrOJkhLxOUh3FQjsDrI1/JQAT3RqqO
 /y/mAhvrSGL+JqV0fTIOZMDSYwco3NBS0Bs67Ams7RPCoi/pZLTRE6CIrBFBPhUgD3xi
 FhTSJe0gpPNG83vy9vBOjo4Xx4mXuySyvaplT8AB0ERULYT0dqbTq/sDq+fjQ+gl7qmZ
 Nfwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792135225; x=1792740025;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nlY0zaNIRSAlCGiHt5dpIH2xNpiENPFHUjdwoSvE4Hs=;
 b=KkOj/m2RLe38K6JVln5Wav+PDrauHoVE+Yrwcftwb3ylFRQXHmy96CjDdy15ApdmaL
 Gauh372gaS0bAL5Ioxs02L3M+Ue3DAyAUpbSIMhKIarsIhywFgrK8irkImznSlE5F5a7
 /TRMBYT63sfigOXN++0qZ3H7T98tt0oWDzmHXYj84sdAaPWYq12gYphFxYw12NY4o8PK
 41cKMFkFPrUpjjhh8eAqdH6o0L6NxrnOkLP1SPpJ/GW5lvmwYxkQnPWXTQPm8VBDuE1y
 OcASVHNq9qbo9Lyui75zXkX2ECAc6OnxbUiTICR3DNc6pmS7MycRYO2MFnk8p9lfaBAw
 z1oQ==
X-Gm-Message-State: AFq9FYJRVUQ36vTONiJPYTwexKC8Ix5y1q7mw6AvlrQ/N6HSTJCXEsDV
 jFgazVWid2/08ehcRr//IC6rnZ/SLgbmFfdQc4twTIQLTwWXOBNIyNkL8W5bDmwnwFS++qDZnNN
 0ke5T3iMDA/dzXo1EEt2OAQBDYuG/kpa9tv0bkbMB1jLyf9yD4OmWOmSFfzUaHj88aQlNN9KPJx
 df9TBH+DaOn2mclLBb5xjnx5/Yzjgkaj8=
X-Gm-Gg: AYBFou16FkXJJiWXdyCaojHvX9O1Nb0e1MjXwmWmzhu0nvMhqa0nkZHe6BIg5uEna0J
 yJXaCFyQ8S35Ys+Yi8SWqfPw6dg7X0bKcbXXUT/73L44oVZWhGFCUJo0nv1pW2nbmVdDRXDZn2b
 wvaTG/EG5dJPTNav84G42br1LcpoTWqMOZRd0ubGUhz2kLXzuIAr7A4IRiVil6JZmAdOkTaHmdZ
 fnMCv/gw9JkeXqMfDbjxX2B6c9fCFe4cFf4uw90hnMuO6jCd7HxIAmxe6ThZkD6MWvSioOL7QVP
 lw==
X-Received: by 2002:a17:90b:5345:b0:3ac:9df3:6b07 with SMTP id
 98e67ed59e1d1-3ac9df36ea5mr4420080a91.24.1792135224995; 
 Fri, 16 Oct 2026 00:20:24 -0700 (PDT)
X-Received: by 2002:a17:90b:5345:b0:3ac:9df3:6b07 with SMTP id
 98e67ed59e1d1-3ac9df36ea5mr4420052a91.24.1792135224333; Fri, 16 Oct 2026
 00:20:24 -0700 (PDT)
MIME-Version: 1.0
References: <20261015112044.1999748-1-berrange@redhat.com>
 <179206655287.744241.865023521920859070.b4-review@b4>
 <atDHwThz_5XPY9Yx@redhat.com>
In-Reply-To: <atDHwThz_5XPY9Yx@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 16 Oct 2026 11:20:11 +0400
X-Gm-Features: AclHuK9gT0-L_WXpd5-5ndoRYRtFKbI3Wnnv8XAiPnZxo0ZhZnof3hH7XFhFH30
Message-ID: <CAMxuvayG8mPvVSagb6EyEH-hhA094qw3LPUWdeL_PJ5qeEk3=g@mail.gmail.com>
Subject: Re: [PATCH 00/21] system: introduce a live data recorder facility
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi

On Thu, Oct 15, 2026 at 4:32=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Thu, Oct 15, 2026 at 04:15:52PM +0400, marcandre.lureau@redhat.com wro=
te:
> > > This series introduces a new facility called 'tldr' which is a
> > > live data recorder. This is intended to aid support of production
> > > QEMU deployments, by providing a data collection facility that
> > > can be left "always on", such that in the event of a QEMU crash
> > > or guest OS crash, certain important information will be recorded.
> > >
> > > The data recorder has to be enabled by adding a "tldr-config"
> > > object instance with -object / object_add.
> > >
> > > With this series, the data recorder collects
> > >
> > >  * error_report/warn_report/error_printf messages
> > >  * QMP events
> >
> > It should probably be recorded at emission, not per monitor
>
> Opps.
>
> > >  * QMP errors
> > >  * QMP commands, which are not query-XXX/qom-list,
> > >    or any command associated with a QMP error.
> > >  * qemu_log output
> > >
> > > The last item is intended primarily to be used in combination
> > > with tracing and its 'log' backend, to have continuous
> > > recording of certain interesting probes.
> > >
> > > Each type of data is collected in a distinct circular
> > > buffer, such that high volumes of one type of data, does
> > > not result in overwriting other types of low volume data.
> > >
> > > The data recorder is set to trigger on SIGBUS, SIGSEGV,
> > > SIGILL, SIGFPE and SIGABRT, or manually via QMP 'tldr-dump'.
> >
> > Instead of allocating and dumping by a signal handler, why not use a fi=
le-backed
> > mmap or a memfd? We would need to define a small fixed header for the f=
ile
> > layout/buckets.  This would avoid all the issues with signal handlers.
>
> That would impose a continuous I/O workload on data recording, which
> is something I wanted to explicitly avoid, until the time the data is

Yes, a file-backed mapping shouldn't be the default, but memfd/tmpfs
should have the same performance.

> needed to be preserved. This only persists the final data, not any
> intermediate data that is overwritten as the circular buffer wraps.

Same design, the reader would handle the ring data

> Coupling the in-memory layout to the on-disk layout also means that
> dumps would always be the max size, since we would not have grow-on
> demand buffers.

The dump output would not be the raw data, a reader would emit the
same text format, skipping the unused parts.

mapping reserves address space only, pages are allocated on first write.

The benefits:
- no signal handler, no conflict with MCE, ASAN etc
- data survives SIGKILL, OOM, or a crash in the dump path itself
- data can be read from a hung QEMU

Someone needs to hold the memfd to outlive QEMU, otherwise QEMU could
create a file under a runtime dir on tmpfs

>
> File backed would be even worse for the follow up goal of including
> statistics, since it'd be putting disk I/O into the stats gathering
> path.
>
> > There would be a small window for consistency on crash, but that's prob=
ably
> > acceptable.
> >
> > Plain ASCII section markers would probably be easier to deal with than =
emojis
>
>
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>


