Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A52BE9B258
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 11:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuqrt-0007zj-P9; Tue, 24 Feb 2026 06:46:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vuqrq-0007x0-4p
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:46:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vuqrn-0008TA-E3
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:46:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771933572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a2kYkAiOUHc3sI9/nfhIyHivm1euBlPQGAW9EpSGllc=;
 b=CS9QGeR92ScPUPnf4dadzYcBI6V/ihgKVEkiC+yK+zZleQVtGuP0Nrc8y6/uxA088AhBAn
 qK+r9M1xbOQpDEDxfFayqP4Jpm1vuhfLcwjmeL44F+H0T8vqs0TrJnMcXn54pxq245zLdR
 POg76cpsBBFeTe9rnIh68pbeSLDJx6E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-9ZX36n7FN3qDKdRpOVM-Cg-1; Tue, 24 Feb 2026 06:46:10 -0500
X-MC-Unique: 9ZX36n7FN3qDKdRpOVM-Cg-1
X-Mimecast-MFC-AGG-ID: 9ZX36n7FN3qDKdRpOVM-Cg_1771933570
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4836cc0b38eso8255525e9.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 03:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771933569; x=1772538369; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a2kYkAiOUHc3sI9/nfhIyHivm1euBlPQGAW9EpSGllc=;
 b=sERo79HdDBwjcE6+JAPKrdGMfkFH3g7tVQCtIMxun1GgBAsLvWnOaeFr+jpq03S+gQ
 pj1SicyEOdIRsQZ+JMxfP3cWQY+7OovP2rosTYEsgrM+i9VVxfBxoPx07kg34wUuuJa9
 rXejNZHROmX/R4R85JUILIZed19Yd77jsS6USDLVDD6iLuKgiljFPSp4BHzEBz8PXrbi
 oJs6pEcV/vEOMl5M/4Q6SFarOYEabisereyUbE+d6tAiHR3OxwL/cApYUlOmh8se93g3
 6AaZkhc6wLRDzmLGLTKgnqItetLfYgeJNqgtqXzFUq5S9TbOUUYbh259aJx5ugz9Plpo
 ihNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771933569; x=1772538369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a2kYkAiOUHc3sI9/nfhIyHivm1euBlPQGAW9EpSGllc=;
 b=Kq54sIOcNwoC8QvOwrMl+bpMjn+J8lH2TMZCbS4IODiivr/+AFS1Ad9FC0q41im9X6
 /D06RXiBqJNSQwGMDklNjpcon42s6OTVlaCCMUm/ktx3Mi7Y+UozaAQoUB7CBlFgzbOa
 zZvtxufAMkB1tfxkMvD68KbNV00A8ys7zmgQ6y67De+sp/7nJwC9tSkIOY60wbOiZgGd
 7ZNwqS391EdVHVqxsXl/Y7u+kjdTY58OXcDgHypJgSbuse/bpXaMvnhup5s5ApGdf3jF
 uFBZwVUh5EYwpz1r71SSHgzKF1IySnJVcWz1MXakf+KJdpp8aSErp3Nbgo0s1CGvMM7d
 PGGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKWyXIb77QSlAKsHI3QIow6dvrLrkAIdCp1UIJOx6DD5Mohh6frG6Z97PjwDM+SUZ2I+g5OOX3aeuV@nongnu.org
X-Gm-Message-State: AOJu0YwdDd2QgOy4E9CRl9rZcunVwGt3klEVq3KN3QmNW6Uv+r31RJhW
 QK9piXtQOpvssfLJR0eaS69TXYU84iFwGRJ1O9ePq2jN+3HB8V0Ff3dzeUxfisbmd+GXWldOFfS
 TNS7CXrFjWyCUG/7q4qCXvIlZCFB8jPOT47IRl8n6WIhYsC/uQ6tDMZ5Q
X-Gm-Gg: AZuq6aLFQMndyqKrHX31dFNZJpQKO3D9pzmEzEvZ0DMf+o4pKSRt5RNQ0vEmEbPD3/F
 /wTIJz7PwD5YKY7S734ac9MZ8UDfZbI57U9UrHVi63yrweHcCD404Q303+7g2j1IZynDUy4RvzP
 o/g4UwiVP0bO7aqAO0DmY4E5l2cLkglHDynS7Hn62vMaV/MHws7fYJQzJ7nQW6tU+b7JD+KhRmp
 mG0+l9RRMRRAlFTikoh2omWcBySR/Gbm32t1IKqbg1B575uqmvQ5vVWyPYjJu96VnZR9B1M+c/q
 FlNbiDeyR438TOGwRxfR3TBmPPcoB/Kh9NY+xKNu44+r0h8KdPkLt9AiiLWt70/thOa8IxgbZYN
 018EqIQ==
X-Received: by 2002:a05:600c:3b96:b0:47e:e076:c7a5 with SMTP id
 5b1f17b1804b1-483a95b7aedmr241112655e9.11.1771933569503; 
 Tue, 24 Feb 2026 03:46:09 -0800 (PST)
X-Received: by 2002:a05:600c:3b96:b0:47e:e076:c7a5 with SMTP id
 5b1f17b1804b1-483a95b7aedmr241111985e9.11.1771933568915; 
 Tue, 24 Feb 2026 03:46:08 -0800 (PST)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d4c626sm29159485f8f.28.2026.02.24.03.46.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 03:46:08 -0800 (PST)
Date: Tue, 24 Feb 2026 12:46:07 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: David Hoppenbrouwers <david@demindiro.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Sairaj Kodilkar <sarunkod@amd.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] hw/i386/amd_iommu.c: fix amdvi_unhandled_command
 logging cmd ID
Message-ID: <20260224124607.4202980d@imammedo>
In-Reply-To: <ef9b046b-3f57-4b09-8d99-91c61ee41bd0@oracle.com>
References: <20260220181437.19338-1-qemu@demindiro.com>
 <20260223083257.423660c4@imammedo>
 <e483bb5d-d8c2-480e-92a4-6234d87a8522@demindiro.com>
 <ef9b046b-3f57-4b09-8d99-91c61ee41bd0@oracle.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, 23 Feb 2026 13:49:45 -0500
Alejandro Jimenez <alejandro.j.jimenez@oracle.com> wrote:

> Hi David
>=20
> On 2/23/26 8:06 AM, David Hoppenbrouwers wrote:
> > On 2/23/26 8:32 AM, Igor Mammedov wrote: =20
> >> On Fri, 20 Feb 2026 19:14:37 +0100
> >> David Hoppenbrouwers <qemu@demindiro.com> wrote:
> >> =20
> >>> The command ID is in cmd[0], not cmd[1]. =20
> >> pls add a reference to the spec,
> >> and if any what impact it does have on a guest/how it manifests. =20
> >=20
> > Figure 43 "Generic Command Buffer Entry Format" in
> > https://docs.amd.com/v/u/en-US/48882_3.10_PUB =20
>=20
> Unfortunately, the documentation links tend to be broken very often, so it
> is not a good idea to include them in commit messages. That is why I would
> opt for the longer, more verbose (but hopefully easier to find after a
> quick search) choice of listing the name of the spec with the revision,
> chapter and relevant keywords. See my proposed commit message at the end.
>=20
> > But the switch() above also uses cmd[0]:
> >=20
> > =C2=A0=C2=A0=C2=A0 switch (extract64(cmd[0], 60, 4)) {
> > =C2=A0=C2=A0=C2=A0 case AMDVI_CMD_COMPLETION_WAIT:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 amdvi_completion_wait(s, cmd=
);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> >=20
> > It has no effect on the guest, only on the -trace option. It may be
> > confusing to developers if the actual command ID doesn't match what is
> > shown by -trace.
> >  =20
> I think it could have an effect on (some) guest too, although this is
> unlikely given the number of things that need to go wrong, but perhaps a
> test flow in a guest driver like:
> - Guest triggers an IOMMU command with an invalid opcode.
> - Guest reads the event log (incorrectly filled by the vIOMMU) and reports
> an error on mismatched opcode.
>=20
> Using cmd[1] seems clearly a typo from the original code. To honor Igor's
> request to add details, I'd propose we change the commit message to:
>=20
> amd_iommu: Fix opcode reported in invalid command handling
>=20
> According to the AMD I/O Virtualization Technology (IOMMU) Specification
> (Rev 3.10), Section 2.4 Commands, the Generic Command Buffer Entry Format
> encodes the opcode in bits [63:60] of the command buffer.
>=20
> When handling illegal opcodes, the traces for unhandled commands and event
> log info extract the opcode from an incorrect offset in the command buffe=
r.
> Fix this issue to avoid potential confusion with mismatched opcodes in
> traces and unlikely errors in guest event processing.
>=20
> Fixes: d29a09ca68428 ("hw/i386: Introduce AMD IOMMU")
> Signed-off-by: David Hoppenbrouwers <qemu@demindiro.com>
> Reviewed-by: Sairaj Kodilkar <sarunkod@amd.com>

with this
Acked-by: Igor Mammedov <imammedo@redhat.com>

>=20
> If that works for everyone, I can add apply it; no need to send a new rev=
ision.
>=20
> Thank you,
> Alejandro
>=20
> > David =20
>=20


