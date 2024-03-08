Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC8EC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 08:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riVRx-0007hF-ND; Fri, 08 Mar 2024 03:19:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1riVRu-0007a7-U8
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:19:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1riVRl-0007cX-W4
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:19:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709885957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c1/Me4NoGcTNWa4pk8Mp0wZ2ZYBg+jup03SvVrDUqkE=;
 b=OyRKYvJIEaUBq6Qfk8WyFsBedP0hoawDSxJhBB1qIFyO7XAF11up5fODv2TVXJwtcyUI1Z
 twe0Zvb9RsSDbYVA7UledI8+ZEqqYIqWRni3wC+i16lPtZannVqfbBnvkbkc6salUpecUd
 rGlVBHdDLwuYoaJldbF0beUKPE/C9b0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-QRAStQR5O7irGJZRL9tYfg-1; Fri, 08 Mar 2024 03:19:15 -0500
X-MC-Unique: QRAStQR5O7irGJZRL9tYfg-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-299783294a6so1485027a91.3
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 00:19:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709885654; x=1710490454;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c1/Me4NoGcTNWa4pk8Mp0wZ2ZYBg+jup03SvVrDUqkE=;
 b=XFRYSKcwF+fGhr6fyIe3CmfAV54U5XxgfR8klnq1XqngwQUh7/Lp9XHKUu6NOtmPz9
 Lxhzx2UjLxPSuzK4zD3KFaMWE0Z69UKSHOCKPFu8uksCS+Nc4vu4izl9qfoA9A5q6SZ8
 KalQio67IA04w8ZU6m2NPIr1HbordmEMvSndVmlM1tZyiMNMUjQkJzxvSaqK/Ytq39u7
 rRA9REkpbsYR6IX6eW+8Kl4tdUb189BaPFsYoQZctZVT+WSdcrz4eaO6d3KnUM5qJzxU
 T7Xkzt03ZvEm2DnujbQF/6BJKx9TeprPtv2pFf+cB70t+UUIgDzHo6yGnix9oURzFI8k
 +SsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCIjmwP4zfGAGf4vNEuYetWxScT0Yz5GrhxziKT0yjgHF9nLhA1CVyIELzG/dnRUEmZtUFD839YAmkjUtbyS9FZOxb+Zk=
X-Gm-Message-State: AOJu0YxPYm+zUUwX8Iz2gRv1JeWcK4oISxp/COSdma1o6jmeieF8lSI/
 FG7BgeU28Y+OW94TEexMJe7xd3JeJL9eXJyaGElcbPaZ4I9Cm8YjcElcKcpqSceoCiemT9oQwzU
 eAmWWNGEI0UXAYCmLzfznxyhYGYZhojLkjfE4CpVFmtlWg5GB/17yw6Icta7Pg/92l+Ge4YBCkF
 AUljdpztQswzYymR81tv6iWVK9JLM=
X-Received: by 2002:a17:90a:fb46:b0:29b:bb75:8d14 with SMTP id
 iq6-20020a17090afb4600b0029bbb758d14mr120545pjb.23.1709885654630; 
 Fri, 08 Mar 2024 00:14:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxT3q3TO20WPYT6SA66jcoFzj4FkDJmSvg09ERmGp00aTvxt9UjkUNut1iBaJOZyPzILZgMuuwmATjfu1mx/Y=
X-Received: by 2002:a17:90a:fb46:b0:29b:bb75:8d14 with SMTP id
 iq6-20020a17090afb4600b0029bbb758d14mr120536pjb.23.1709885654381; Fri, 08 Mar
 2024 00:14:14 -0800 (PST)
MIME-Version: 1.0
References: <20240205165437.1965981-1-andrew@daynix.com>
 <20240205165437.1965981-5-andrew@daynix.com>
In-Reply-To: <20240205165437.1965981-5-andrew@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 8 Mar 2024 16:14:03 +0800
Message-ID: <CACGkMEtdYosQAGYE47sMLDvC-OvFV7JM-mNvxirHwsZTDTtcOQ@mail.gmail.com>
Subject: Re: [PATCH v9 4/5] qmp: Added new command to retrieve eBPF blob.
To: Andrew Melnychenko <andrew@daynix.com>
Cc: mst@redhat.com, armbru@redhat.com, eblake@redhat.com, 
 qemu-devel@nongnu.org, berrange@redhat.com, yuri.benditovich@daynix.com, 
 yan@daynix.com, akihiko.odaki@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Feb 6, 2024 at 12:55=E2=80=AFAM Andrew Melnychenko <andrew@daynix.c=
om> wrote:
>
> Now, the binary objects may be retrieved by id.
> It would require for future qmp commands that may require specific
> eBPF blob.
>
> Added command "request-ebpf". This command returns
> eBPF program encoded base64. The program taken from the
> skeleton and essentially is an ELF object that can be
> loaded in the future with libbpf.
>
> The reason to use the command to provide the eBPF object
> instead of a separate artifact was to avoid issues related
> to finding the eBPF itself. eBPF object is an ELF binary
> that contains the eBPF program and eBPF map description(BTF).
> Overall, eBPF object should contain the program and enough
> metadata to create/load eBPF with libbpf. As the eBPF
> maps/program should correspond to QEMU, the eBPF can't
> be used from different QEMU build.
>
> The first solution was a helper that comes with QEMU
> and loads appropriate eBPF objects. And the issue is
> to find a proper helper if the system has several
> different QEMUs installed and/or built from the source,
> which helpers may not be compatible.
>
> Another issue is QEMU updating while there is a running
> QEMU instance. With an updated helper, it may not be
> possible to hotplug virtio-net device to the already
> running QEMU. Overall, requesting the eBPF object from
> QEMU itself solves possible failures with acceptable effort.
>
> Links:
> [PATCH 3/5] qmp: Added the helper stamp check.
> https://lore.kernel.org/all/20230219162100.174318-4-andrew@daynix.com/
>
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> ---
>  ebpf/ebpf.c           | 69 +++++++++++++++++++++++++++++++++++++++++++

Let's add ebpf.c to MAINTAINERS otherwise CI may warn like:

https://gitlab.com/jasowang/qemu/-/jobs/6349138969

Thanks


