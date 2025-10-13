Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31592CCD185
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 21:42:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8QIf-0006e5-CT; Mon, 13 Oct 2025 17:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v8QId-0006dk-Jf
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 17:41:47 -0400
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v8QIb-0001qe-O0
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 17:41:47 -0400
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-42f94689e73so38340395ab.0
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 14:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760391704; x=1760996504; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+NKcq9dIqY7g+jIbE6ZzJgWcuqu02bZ0oE5YXeKcEpk=;
 b=M/DApktZkoizZPbxb8+N58G8i9nGIBVOL1n+KeR9nxl5sx/t7vLNElm1lU1nGWtCQ7
 J5+RWDacaq81vEok1BsVc/Rw4+iDqOUSvbOVcB8VW3UE/28o3ejhcn9XfBkApSMpB1Eb
 N2iZbXaXRz+i2nBXtiUhnvRJpAGmOqeehn6wU+LOH+z0h147USisQhmTq+DyvJ5roJyl
 McQppulU3hqNQ/Kkv6Z6GLcMLr8LLy7viXyes9WW0zNidoozX+YUQRpjUtusQdBhkKCJ
 DlmfuQoeZMSZQiIvAMAdyic3vMlHWgOb17AvyyOGq+IdujTOFOHFsa+KwU149AjwKfia
 6WfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760391704; x=1760996504;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+NKcq9dIqY7g+jIbE6ZzJgWcuqu02bZ0oE5YXeKcEpk=;
 b=kwD8y2fzSLnzagHgpsbWSlDvZntKD1GbArSGtNq+/Cf616T1HJHNWup38O8EigSoUk
 hjTn4k++d7sDbHKYcUKMVKqPozdXWtq2Z5pA0Yt3U2FQsGA95YmzZe7uPTROONDMD7IU
 ubpaOm6LbYM7vuL5B/pLbid4SPhqQAGJfjCdW0uptokH1T+MqOxKu87Ea9ZhPIqP2vk/
 zDue7SV9GRIqASaY55a7COobkkB8r6A2LoI/Gaqcm3S80BuN1ayGGJb7/9o5FYMfFHgQ
 C2K3N57Yizn+NvU+Hy70H9n6qiFVz3frRx/TYyPFZ5ehhddpwXaQGLQIk467Hbopy+WE
 xfhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDIEqEjYYMBml1ntQN4sTAP6BsW4y4rz0D4XBQvlaJuiFRPSof1eAOFyEn+Q1jd9XTDiZgMcr3lIns@nongnu.org
X-Gm-Message-State: AOJu0YxvGuvFRYObOkbhTVd+72HGey6kqSALQx1N1m+v7etnQFdLQMXF
 QNyu4fwjyDgUn8tLhbJdVQ4UhZjw3CxMhz8lMMqZ6FJGVC3gV+0esHurEvyVWn7gtOFqiMXU+CJ
 ImV6IAd03D5SV9T2rf7AAub/V8I4vFvA=
X-Gm-Gg: ASbGncvhM2SInbcmsIZnmRDugWQhhwd2cVJZbA21JRZkNBJKGco+KvcfnMSWzsHkGex
 cQnjFVovA59WGJuxoNrn+isT8XYX3TyTVA4MWObm7menniQ+UJD0qTTHgnSCQyz5RqUnBxol+Nj
 +0crYxbyRgp/YLwLElsUV+pHgjwcr2izoXS9+BH5T0p2x63STUjzT/2GjjG8PPudurP71ekSSi1
 ZRIUxeyD6JlgkgD/gmvEk7T3qadl/3kms6L
X-Google-Smtp-Source: AGHT+IGmuYTorP3vbtdW83XCD01oi79WZawG+uRMsjG3nUGBNl5MqD86UpA3xDwYMzqY5rfmyT7G5CMcs7HHivBIU+8=
X-Received: by 2002:a05:6e02:441c:20b0:42f:a711:7458 with SMTP id
 e9e14a558f8ab-42fa71190a4mr122145605ab.32.1760391704347; Mon, 13 Oct 2025
 14:41:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <CAFubqFv8F8swA3EwZfgnVYpHNgs0yZSFgf6wm2DwXgPxSTjs5A@mail.gmail.com>
 <aabfa3db-e434-4dde-b01e-b0195eb4adee@yandex-team.ru>
 <CAFubqFsANpc_v8Dvd4P=Swmei2P_Nt33+0eXn4UdC8-dcJCPfA@mail.gmail.com>
 <e660bb4d-b682-4378-ad42-78046bf42b41@yandex-team.ru>
In-Reply-To: <e660bb4d-b682-4378-ad42-78046bf42b41@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 13 Oct 2025 17:41:32 -0400
X-Gm-Features: AS18NWBFDz8lGBcXFfWh79qB2q9jbaNtrkNRuBQzUuM0_JgHEVpn3uVsP_M0za4
Message-ID: <CAFubqFsuYQxdGx-F-zHQvDsfYsEkPFdvF8z-JkTOjYPrUNX1HA@mail.gmail.com>
Subject: Re: [PATCH 00/33] vhost-user-blk: live-backend local migration
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net, 
 sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, den-plotnikov@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::130;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x130.google.com
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

Thanks for the extensive follow up here. I was hoping there would be
some way to move more of the logic into all vhost-user generic code
both to help other backends support local migration more easily and
have fewer "if backend is doing a local migration" checks in
vhost-user-blk code. As a straw man design, I would think there could
be some way of having the backend coordinate a handoff by signaling
the source Qemu and then the source Qemu could stop the device and ACK
with a message before the destination Qemu is allowed to start the
device.

Anyways, it seems like other maintainers have blessed this approach so
I'll leave it at that.

On Fri, Oct 10, 2025 at 4:47=E2=80=AFAM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> On 10.10.25 02:28, Raphael Norwitz wrote:
> > Thanks for the detailed response here, it does clear up the intent.
> >
> > I agree it's much better to keep the management layer from having to
> > make API calls back and forth to the backend so that the migration
> > looks like a reconnect from the backend's perspective. I'm not totally
> > clear on the fundamental reason why the management layer would have to
> > call out to the backend, as opposed to having the vhost-user code in
> > the backend figure out that it's a local migration when the new
> > destination QEMU tries to connect and respond accordingly.
> >
>
> Handling this in vhost-user-server without the management layer would
> actually mean handling two connections in parallel. This doesn't seem
> to fit well into the vhost-user protocol.
>
> However, we already have this support (as we have live update for VMs
> with vhost-user-blk) in the disk service by accepting a new connection
> on an additional Unix socket servicing the same disk but in readonly
> mode until the initial connection terminates. The problem isn't with
> the separate socket itself, but with safely switching the disk backend
> from one connection to another. We would have to perform this switch
> regardless, even if we managed both connections within the context of a
> single server or a single Unix socket. The only difference is that this
> way, we might avoid communication from the management layer to the disk
> service. Instead of saying, "Hey, disk service, we're going to migrate
> this QEMU - prepare for an endpoint switch," we'd just proceed with the
> migration, and the disk service would detect it when it sees a second
> connection to the Unix socket.
>
> But this extra communication isn't the real issue. The real challenge
> is that we still have to switch between connections on the backend
> side. And we have to account for the possible temporary unavailability
> of the disk service (the migration freeze time would just include this
> period of unavailability).
>
> With this series, we're saying: "Hold on. We already have everything
> working and set up=E2=80=94the backend is ready, the dataplane is out of =
QEMU,
> and the control plane isn't doing anything. And we're migrating to the
> same host. Why not just keep everything as is? Just pass the file
> descriptors to the new QEMU process and continue execution."
>
> This way, we make the QEMU live-update operation independent of the
> disk service's lifecycle, which improves reliability. And we maintain
> only one connection instead of two, making the model simpler.
>
> This doesn't even account for the extra time spent reconfiguring the
> connection. Setting up mappings isn't free and becomes more costly for
> large VMs (with significant RAM), when using hugetlbfs, or when the
> system is under memory pressure.
>
>
> > That said, I haven't followed the work here all that closely. If MST
> > or other maintainers have blessed this as the right way I'm ok with
> > it.
> >
>
>
>
> --
> Best regards,
> Vladimir

