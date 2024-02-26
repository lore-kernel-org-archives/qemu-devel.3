Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A12CC54E4A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 10:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reY9C-0002s4-5S; Mon, 26 Feb 2024 05:23:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1reY9A-0002rr-MD
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 05:23:44 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1reY98-0007bz-C4
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 05:23:44 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-564372fb762so4157079a12.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 02:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708943020; x=1709547820;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ch7zLHaG+e2Do8DVRU2/oclSH4+zOZprmMOjSaKK30w=;
 b=D7pRgV9Z8K1iIopMh7jcjnB8v9KaT2v+2zOnZ6tRqxIqhjaHdxXFBHm6p8uqHftgtZ
 bgZWf+5ivLBr0lSpyxu01vsxtVc6/0QCw1fo0F3EEIUA4g5Oiq0UKTmquyH1J2x9pYQk
 LNLOJg7szFGQka61/OsQgZigJFdgJyOxwB7PaknepTmaBBSKUu1cFPxQuadBvlJNAZBd
 2RajwxazMnsaShxG6BOwIzUkRdeOWfknKviUgHRn5bvW3gUqwSTSy8mFeHdIoRdBTNqi
 2Ch6/aUOBsgRIelnmrU8bopI6V73mMdK9xoWeDFhH448hYTmAYwDU++zQ0yhHqdADu0O
 G6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708943020; x=1709547820;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ch7zLHaG+e2Do8DVRU2/oclSH4+zOZprmMOjSaKK30w=;
 b=jGYfGSXzdtZZ4akhqqn8hOBfqE5WkSZ4wVYl7ABoHHYFqP7pUzdaI5a1gvmJAC/rZN
 9uB+jy5NJu5oMZU9wdJmzoIBrWtNvr/S+VuVl5KIk/F9vWfeSCro9J6FrcRNHJ480PrO
 Th4h5EnZxDnoGU1JLnsj/7kj1jeHBauKjchzIRraZe6lROs2mGZx/ybtJW7vKp5dBS3f
 nEMnI3CaYQXKqR8w4t4gRdvr34cXxcQvEFJYbgDVrRTe9U1d5KifluLoEVWDSIhcfiiy
 9vQ6/gtj2cSi5LWN0hwh3N7DgT4ZPs3dd99ztoyaxTLc4x7zffwdL9MU/59pCZ03WVig
 VtjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVP1JoOH5Rj0GB9OIhNOqQz5Nvi9DoHWrKt51HZ/mKz/hFp3+62EIKIRgPgVvMk56OI0jJFoFEwPxTBB6IdsgdBCXOu1MA=
X-Gm-Message-State: AOJu0YyS4Rg3aCKyoOJJtBbY9Hp3Vo0EOP09RFp3TylzM1XF5aJ2I3IG
 KwGxOdI6y191PYtBHUw7pNhs494JVO4rT1g2wbR0XQvgt0Uhy2s+9HS0ioxPBe+QlbZxu5ilos2
 7d9BVUvQHxReiFktiE9SA80184sciU3eazPr9ag==
X-Google-Smtp-Source: AGHT+IGQSIQvRu5MtUgzHLQ1AMgyXWb+6U2E4nP/ulBhZz+qDOct20XGUQ9Uu6mhxxA9jRTN0oatKKd0wE0N/iyAgcw=
X-Received: by 2002:a17:907:765b:b0:a43:4a7b:1c7e with SMTP id
 kj27-20020a170907765b00b00a434a7b1c7emr1531652ejc.52.1708943020296; Mon, 26
 Feb 2024 02:23:40 -0800 (PST)
MIME-Version: 1.0
References: <20240205165437.1965981-1-andrew@daynix.com>
In-Reply-To: <20240205165437.1965981-1-andrew@daynix.com>
From: Andrew Melnichenko <andrew@daynix.com>
Date: Mon, 26 Feb 2024 12:23:29 +0200
Message-ID: <CABcq3pGy+Lp8YZnMZVC61wu6jDvE0BYj3kuuvuXCA+ewOtJVfg@mail.gmail.com>
Subject: Re: [PATCH v9 0/5] eBPF RSS through QMP support.
To: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, eblake@redhat.com, 
 qemu-devel@nongnu.org, berrange@redhat.com
Cc: yuri.benditovich@daynix.com, yan@daynix.com, akihiko.odaki@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::534;
 envelope-from=andrew@daynix.com; helo=mail-ed1-x534.google.com
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
Jason, can you please review the patch set, thank you.

On Mon, Feb 5, 2024 at 6:54=E2=80=AFPM Andrew Melnychenko <andrew@daynix.co=
m> wrote:
>
> This series of patches provides the ability to retrieve eBPF program
> through qmp, so management application may load bpf blob with proper capa=
bilities.
> Now, virtio-net devices can accept eBPF programs and maps through propert=
ies
> as external file descriptors. Access to the eBPF map is direct through mm=
ap()
> call, so it should not require additional capabilities to bpf* calls.
> eBPF file descriptors can be passed to QEMU from parent process or by uni=
x
> socket with sendfd() qmp command.
>
> Changes since v8:
>  * rebased and refactored QMP interface
>  * license SPDX id only for new files
>
> Changes since v7:
>  * rebased and refactored
>  * used SPDX license identifier
>  * used DEFINE_PROP_ARRAY() for virtio-net "ebpf-rss-fds" property
>
> Changes since v6:
>  * added comments to ebpf.json
>  * added libbpf version requirements to meson script with BPF_F_MMAPABLE =
check
>
> Changes since v5:
>  * refactored ebpf.json
>
> Changes since v4:
>  * refactored commit hunks
>  * added explicit BPF_F_MMAPABLE declaration
>
> Changes since v3:
>  * fixed issue with the build if bpf disabled
>  * rebased to the last master
>  * refactored according to review
>
> Changes since v2:
>  * moved/refactored QMP command
>  * refactored virtio-net
>
> Changes since v1:
>  * refactored virtio-net
>  * moved hunks for ebpf mmap()
>  * added qmp enum for eBPF id.
>
> Andrew Melnychenko (5):
>   ebpf: Added eBPF map update through mmap.
>   ebpf: Added eBPF initialization by fds.
>   virtio-net: Added property to load eBPF RSS with fds.
>   qmp: Added new command to retrieve eBPF blob.
>   ebpf: Updated eBPF program and skeleton.
>
>  ebpf/ebpf.c                    |   69 ++
>  ebpf/ebpf.h                    |   29 +
>  ebpf/ebpf_rss-stub.c           |    6 +
>  ebpf/ebpf_rss.c                |  150 +++-
>  ebpf/ebpf_rss.h                |   10 +
>  ebpf/meson.build               |    2 +-
>  ebpf/rss.bpf.skeleton.h        | 1343 ++++++++++++++++----------------
>  hw/net/virtio-net.c            |   54 +-
>  include/hw/virtio/virtio-net.h |    2 +
>  meson.build                    |   10 +-
>  qapi/ebpf.json                 |   66 ++
>  qapi/meson.build               |    1 +
>  qapi/qapi-schema.json          |    1 +
>  tools/ebpf/rss.bpf.c           |    7 +-
>  14 files changed, 1047 insertions(+), 703 deletions(-)
>  create mode 100644 ebpf/ebpf.c
>  create mode 100644 ebpf/ebpf.h
>  create mode 100644 qapi/ebpf.json
>
> --
> 2.43.0
>

