Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4072FC54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 05:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkGo3-0001Vr-NK; Wed, 13 Mar 2024 01:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rkGo1-0001Vi-RR
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 01:05:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rkGo0-000646-2q
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 01:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710306330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T10gB/MhJAUovYtZmYoIOakNAuS+et11MT2zR11xuxE=;
 b=KPwcMbJrDMGoqexPriwZ11HN2mssFz7a02WXlzkptmO+tqF1L19nftKen41M3N4IIOvhHX
 obR3iZAgXpqOng8N1ohfwz6cgqRl7+1MsZKCza096rWY/AtjlcDYgMSZuL1qgvSSiZXSdo
 qp5kVgHQU2tzTnKn9Q7S+SYzz/MQOfQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-ux5vD0EfNKiygZ9AzLMBDQ-1; Wed, 13 Mar 2024 01:05:28 -0400
X-MC-Unique: ux5vD0EfNKiygZ9AzLMBDQ-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-29b8f702cbfso5069880a91.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 22:05:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710306327; x=1710911127;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T10gB/MhJAUovYtZmYoIOakNAuS+et11MT2zR11xuxE=;
 b=k9BcZ/oXvwmSGbcHy0FBaJk4hzNQQPFfRlhjWLF5gULxUxiCPAvo14V10tQZFUA19V
 SP4POVNwA41s3+WozodIep7PBFw4Y1tbZyPlK+ToG1b4EMDC79fyfOn+BAYNwiHk176r
 czIN09XiUTit0zT4RTj2de3uck/M6lpklw6Nq+gTpCvPJphPSVqppJJwhUS3tk7EeTab
 eAEIFWB4hAGkWkUwwHUpa0qDWovxISBpm24OeAtkYMMD/fmaimiWWIzq3EN6FimXHg6D
 KgxHW26fY8Zh4xBPb8QPg0tBIZF+IuOWS5eiz3/5vTSrT+Jr6zv30EDPl957toDoF+8n
 ErYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsApvOryAPjHSf4N3tThrrDTc83d+9iWNivA1VLoFtUWn+OIrb0UEfqeIyK6NKcoVfY/veaRKQjBqy7qG0egUp0fI/tms=
X-Gm-Message-State: AOJu0Yy3UfFc1XvxnnI/HSCS1/1+Peibmwo9FwfTdWO1khMO3Zq1UQ0F
 vmhbrfwyYVdHV/BvBZ6+sabVgABj0KyBN+FwerGManaoM+4CnfsU2wGQ2x8u5XTtN/fM6+3LXx2
 Z6/jFn71M/MHsrG5w25P7Hz0fVSFwhpYUIIKUqg1przBSOXPWPJjnfa2pK1z987wSuSIGo+mtLm
 G2pc5g4MYaPr4cMVe0Fln4o86tbhM=
X-Received: by 2002:a17:90a:7896:b0:29c:3908:8473 with SMTP id
 x22-20020a17090a789600b0029c39088473mr3014432pjk.46.1710306327206; 
 Tue, 12 Mar 2024 22:05:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrxZ/XFI2PMVah6AfTrrSo9DO6MFPsogHM8eQR/6yx0Xr4Wj9cJx5F2hcukmg4INP41cr7VbUMFD8Ft2AlPHg=
X-Received: by 2002:a17:90a:7896:b0:29c:3908:8473 with SMTP id
 x22-20020a17090a789600b0029c39088473mr3014421pjk.46.1710306326848; Tue, 12
 Mar 2024 22:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240205165437.1965981-1-andrew@daynix.com>
 <20240205165437.1965981-5-andrew@daynix.com>
 <CACGkMEtdYosQAGYE47sMLDvC-OvFV7JM-mNvxirHwsZTDTtcOQ@mail.gmail.com>
 <CABcq3pEQ9-RW5w+4gOaQJZbcPuYnFjoVk6axoj4g53OArbso+w@mail.gmail.com>
In-Reply-To: <CABcq3pEQ9-RW5w+4gOaQJZbcPuYnFjoVk6axoj4g53OArbso+w@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 13 Mar 2024 13:05:14 +0800
Message-ID: <CACGkMEseH32rxhpWkBshe+d8YArbmTL60d8C9Rd0sXV5PYziVQ@mail.gmail.com>
Subject: Re: [PATCH v9 4/5] qmp: Added new command to retrieve eBPF blob.
To: Andrew Melnichenko <andrew@daynix.com>
Cc: mst@redhat.com, armbru@redhat.com, eblake@redhat.com, 
 qemu-devel@nongnu.org, berrange@redhat.com, yuri.benditovich@daynix.com, 
 yan@daynix.com, akihiko.odaki@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Mar 13, 2024 at 7:13=E2=80=AFAM Andrew Melnichenko <andrew@daynix.c=
om> wrote:
>
> Hi all,
> I've checked - apparently, qapi/ebpf.json should be added to
> MAINTAINERS - I'll fix it.

I've fixed this by myself and the pull request has been merged.

Thanks

>
> On Fri, Mar 8, 2024 at 10:14=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Tue, Feb 6, 2024 at 12:55=E2=80=AFAM Andrew Melnychenko <andrew@dayn=
ix.com> wrote:
> > >
> > > Now, the binary objects may be retrieved by id.
> > > It would require for future qmp commands that may require specific
> > > eBPF blob.
> > >
> > > Added command "request-ebpf". This command returns
> > > eBPF program encoded base64. The program taken from the
> > > skeleton and essentially is an ELF object that can be
> > > loaded in the future with libbpf.
> > >
> > > The reason to use the command to provide the eBPF object
> > > instead of a separate artifact was to avoid issues related
> > > to finding the eBPF itself. eBPF object is an ELF binary
> > > that contains the eBPF program and eBPF map description(BTF).
> > > Overall, eBPF object should contain the program and enough
> > > metadata to create/load eBPF with libbpf. As the eBPF
> > > maps/program should correspond to QEMU, the eBPF can't
> > > be used from different QEMU build.
> > >
> > > The first solution was a helper that comes with QEMU
> > > and loads appropriate eBPF objects. And the issue is
> > > to find a proper helper if the system has several
> > > different QEMUs installed and/or built from the source,
> > > which helpers may not be compatible.
> > >
> > > Another issue is QEMU updating while there is a running
> > > QEMU instance. With an updated helper, it may not be
> > > possible to hotplug virtio-net device to the already
> > > running QEMU. Overall, requesting the eBPF object from
> > > QEMU itself solves possible failures with acceptable effort.
> > >
> > > Links:
> > > [PATCH 3/5] qmp: Added the helper stamp check.
> > > https://lore.kernel.org/all/20230219162100.174318-4-andrew@daynix.com=
/
> > >
> > > Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> > > ---
> > >  ebpf/ebpf.c           | 69 +++++++++++++++++++++++++++++++++++++++++=
++
> >
> > Let's add ebpf.c to MAINTAINERS otherwise CI may warn like:
> >
> > https://gitlab.com/jasowang/qemu/-/jobs/6349138969
> >
> > Thanks
> >
>


