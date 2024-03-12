Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 501CFC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 23:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkBIz-0002lD-Cj; Tue, 12 Mar 2024 19:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1rkBIt-0002jz-H3
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 19:13:06 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1rkBIr-0003l7-JC
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 19:13:03 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a4627a7233aso56844566b.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 16:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1710285180; x=1710889980;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=72K5TEDCSTaAnZCwZRGbEfY47LiMWx5ImxrGs18pxLY=;
 b=3NHWPPVrAQxplAydQv1JpCOF5wfyBxod3l+kjzNw106FGuLB+6g7wtOrOh+Zslu2bz
 BUSwILQ2CPlqsAg6op6DRKg2hLxoRjEbsGsx0/uSHnyaDfm4mkR6UXpD+vJDZS0AS9MR
 hIe8H6eZ9+D9pMkTS87CBKPX7lPItdvoknF6hRPOHT0dHHEm/jALmr5lrcG7CPMgyBih
 0xU0ellue2g73GcIFLR2ltzMnKwSFoIijPZMiJSNz4/o7EwtogemXw+hlmWQljidyTJ2
 EdUbz/DM0GkKUc+Dif58tHmWCDv5Kox+JflcOsCeCjvcsSliqKPjSt+cNaGNGs4UBJ3z
 floQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710285180; x=1710889980;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=72K5TEDCSTaAnZCwZRGbEfY47LiMWx5ImxrGs18pxLY=;
 b=JZIUOpFFuNdi/cU5sBy7MOHv2gPRsY8W0F6ue41PHfEMOWildMINnMd6xjPQ0B/vBJ
 lspV8iPIa5AUpoWIhblShFkeriokoSu7mdqfpT3nkDbaRdEnaQUovZSfUf+TlQFzjJTy
 uUIK5N12h4iZKS38tlGfjlxM/OOkOUFx97ZwRJb8JqBra25UAw1ZSIkB6KW4U4yZvBU8
 6mpMm38uCtzkTuJWdqnvouPbHtbXYVyzkDWO6H5hnmlE3WO7wezNuSPPJRO4S3stDKen
 BUiCUG16d6D6TEvUDPibcMPLPpWDUgeydU0dvju4poThJ6CDBJEfZtK59OKVs54Sru2Y
 SXNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeRVDG8SpySJeiDJmMcz1JxRUHGcVwFU++/D7RBsVLH+pyoYLVaBhXib3Ebr6DCxM3fcoCkx3Ad8cOuBt09f67gan+n80=
X-Gm-Message-State: AOJu0YxmCbfN3CnriZ9oL/jY8OHv0ho9G159rL6PLG76mT7G78uPOWAt
 hfvjkKIlEZqipdyU8+m24UnB8sayetw4POibLOfaK+T39xyn7SWRZyN07RaJrI8UfjnUgnQwIDb
 7qOgtTCfwbUV7bhYWVkU1eSrSYlVxUBYUKnh2YQ==
X-Google-Smtp-Source: AGHT+IHndEPHFAAUg2gs2IipJ4gp1s97Z483Nj2dUChiXFwGph1bujqCbt8338J6qqLZuPJXcf2lbhdVuVqWldrfsg4=
X-Received: by 2002:a17:906:b182:b0:a46:4beb:d06 with SMTP id
 w2-20020a170906b18200b00a464beb0d06mr750016ejy.31.1710285179593; Tue, 12 Mar
 2024 16:12:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240205165437.1965981-1-andrew@daynix.com>
 <20240205165437.1965981-5-andrew@daynix.com>
 <CACGkMEtdYosQAGYE47sMLDvC-OvFV7JM-mNvxirHwsZTDTtcOQ@mail.gmail.com>
In-Reply-To: <CACGkMEtdYosQAGYE47sMLDvC-OvFV7JM-mNvxirHwsZTDTtcOQ@mail.gmail.com>
From: Andrew Melnichenko <andrew@daynix.com>
Date: Wed, 13 Mar 2024 00:47:31 +0200
Message-ID: <CABcq3pEQ9-RW5w+4gOaQJZbcPuYnFjoVk6axoj4g53OArbso+w@mail.gmail.com>
Subject: Re: [PATCH v9 4/5] qmp: Added new command to retrieve eBPF blob.
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, armbru@redhat.com, eblake@redhat.com, 
 qemu-devel@nongnu.org, berrange@redhat.com, yuri.benditovich@daynix.com, 
 yan@daynix.com, akihiko.odaki@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::62b;
 envelope-from=andrew@daynix.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi all,
I've checked - apparently, qapi/ebpf.json should be added to
MAINTAINERS - I'll fix it.

On Fri, Mar 8, 2024 at 10:14=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Tue, Feb 6, 2024 at 12:55=E2=80=AFAM Andrew Melnychenko <andrew@daynix=
.com> wrote:
> >
> > Now, the binary objects may be retrieved by id.
> > It would require for future qmp commands that may require specific
> > eBPF blob.
> >
> > Added command "request-ebpf". This command returns
> > eBPF program encoded base64. The program taken from the
> > skeleton and essentially is an ELF object that can be
> > loaded in the future with libbpf.
> >
> > The reason to use the command to provide the eBPF object
> > instead of a separate artifact was to avoid issues related
> > to finding the eBPF itself. eBPF object is an ELF binary
> > that contains the eBPF program and eBPF map description(BTF).
> > Overall, eBPF object should contain the program and enough
> > metadata to create/load eBPF with libbpf. As the eBPF
> > maps/program should correspond to QEMU, the eBPF can't
> > be used from different QEMU build.
> >
> > The first solution was a helper that comes with QEMU
> > and loads appropriate eBPF objects. And the issue is
> > to find a proper helper if the system has several
> > different QEMUs installed and/or built from the source,
> > which helpers may not be compatible.
> >
> > Another issue is QEMU updating while there is a running
> > QEMU instance. With an updated helper, it may not be
> > possible to hotplug virtio-net device to the already
> > running QEMU. Overall, requesting the eBPF object from
> > QEMU itself solves possible failures with acceptable effort.
> >
> > Links:
> > [PATCH 3/5] qmp: Added the helper stamp check.
> > https://lore.kernel.org/all/20230219162100.174318-4-andrew@daynix.com/
> >
> > Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> > ---
> >  ebpf/ebpf.c           | 69 +++++++++++++++++++++++++++++++++++++++++++
>
> Let's add ebpf.c to MAINTAINERS otherwise CI may warn like:
>
> https://gitlab.com/jasowang/qemu/-/jobs/6349138969
>
> Thanks
>

