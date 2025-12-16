Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22518D5B87C
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 07:09:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVPB7-0002Vy-L8; Tue, 16 Dec 2025 02:09:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vVPB4-0002Vf-O3
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 02:08:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vVPB1-0000Rf-Sg
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 02:08:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765868933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fXyZKv/6BB1fiF5PdDXOfQyXARlnh8T6Plh13f0EWcA=;
 b=g1a4fX++0qLugdLeWwclimexXHm16vn313GsXIri+d8DcawTOhmCz6dul4rd2w58vHi3SS
 /Rw+VcRZ7yjYIuB2IV0iOFZ068w88Occ4066WyBDhBB3XTRmBVIJzjB9V2H0IFdpXV0h+w
 qkPbnKGZTHLTnpYwkbwAfB0+fYJzxOs=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-2JB-vBl6MQ6bUs6RR2IBDQ-1; Tue, 16 Dec 2025 02:08:51 -0500
X-MC-Unique: 2JB-vBl6MQ6bUs6RR2IBDQ-1
X-Mimecast-MFC-AGG-ID: 2JB-vBl6MQ6bUs6RR2IBDQ_1765868931
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-34c2f670a06so3574505a91.3
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 23:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765868930; x=1766473730; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fXyZKv/6BB1fiF5PdDXOfQyXARlnh8T6Plh13f0EWcA=;
 b=MYERIh4uuBrKr1ICBQalhMPwLI5Q9yRmJkA52tSZ/6vgHlT07ZVhC8/n75LfbmOFgL
 Fu2GcUb35Nn7362I/JR6cAAMneGNhvnMWHFEIVUczR8dglD9kh+vMpRINt47pjl30S2o
 XcmOZURSn3FQaw5UoG4+6lp90tIqUE2teEHGlA0/796XJP2+/9zNit6OdfXt2qKoxnCu
 T8sarSQxm/5LrAnqCdTKoWAMXLol/0LPoTEirWCqg/zlQv4oCZhd/dN3tPi2KbtrfnHr
 ufYZUErohQwT3iK0Q1YF5H6gesJci39PVQyIjUOBxjrp+D2cOdvAZv1MMRwEFb7/WTKq
 DFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765868930; x=1766473730;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fXyZKv/6BB1fiF5PdDXOfQyXARlnh8T6Plh13f0EWcA=;
 b=UzjL3dciS09I1+Rvfzc+wht2svPD0ORRorO4psAu6rDXItj1aqXyRJyEowd53mwfgQ
 Jn2dg9Men9h+kE18P/imGYyinO4yA/AYxi7u+06s++lTL2EflmwSuFmpDcBTvW8SCaZJ
 KpuBQXeg/fGFOUx2KldmHiVAtDWOjmWm1uMx52hPHFZ3euTEDzoreMDyV9f0ADt9+E4o
 OgPSGLhIfBYJ6QAa1xaAVFW56kdTg23i+Kim5f5f+5M71GAqa1uVaQKOlgit0+J4PdHf
 mGSs0aAZW7PO7pQqyu04lVuJKcUFBHjN83yYMH5v+EgO4Hgi+zkbAkeo/I+JozMjMdOQ
 TgtA==
X-Gm-Message-State: AOJu0Yy5Zv04blB32IKiX2tFkzl9+VCcnhYaHrDv/2vMEcgdu/VT863T
 B7T7G/JwsF+QzC3Lj/Ms4UsksGxFlVowrXWtiqtG9H3qHtpwqpQJACILqAmv6idjpasGxGI+AhZ
 DiZYDIri1v8zkeEa1sRW9dHiiSuP7HEflIfNwCwaDS1pgDuEi/e63eERzkSldEcoK7VnEHyLl+r
 wKWfIJ/AQ8tqPKcSXcci18VUPDKdvGkRs=
X-Gm-Gg: AY/fxX6hbltQGO0/BpgWcYLZWyXxF05Ryvpm5v12W5FoAH37IsY8zefY7tUgyoLU3ak
 8zgX9rbmi12W0B8UcMHKDdppg5A6RUGkSq5BNN02vQrLgTjxHA7ijyNd3j3Fo0yDCmEtTYyKyyi
 pTjqQ0PImn415hyC9YKLr0HFhIsJjmtyO7PPQFjeal1SsuMO4i+sZo2dg/NrvWj0koX6o=
X-Received: by 2002:a17:90b:54ce:b0:34c:ab9c:b59f with SMTP id
 98e67ed59e1d1-34cab9cb5cemr3303323a91.11.1765868930567; 
 Mon, 15 Dec 2025 23:08:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrZaUY+4/BVySv/5hiStenAPSTuBWnNTOx5C8CnNjrJHvPZOvNvSJ3GlaBimjO9HyQnYkGudwihD493Ewhogs=
X-Received: by 2002:a17:90b:54ce:b0:34c:ab9c:b59f with SMTP id
 98e67ed59e1d1-34cab9cb5cemr3303297a91.11.1765868930144; Mon, 15 Dec 2025
 23:08:50 -0800 (PST)
MIME-Version: 1.0
References: <20251208043518.3223721-1-hzuo@redhat.com>
In-Reply-To: <20251208043518.3223721-1-hzuo@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 16 Dec 2025 15:08:36 +0800
X-Gm-Features: AQt7F2pHkDd38zMJXfcZTMT2hO12dN6XgRDZKYqT9DDGx38oroIbOT2W2Md43MM
Message-ID: <CACGkMEuNstSoGihb4fp1VhBZOX3dLgCfu3NK59qQaT5saO8xCQ@mail.gmail.com>
Subject: Re: [PATCH v6] net/tap-linux.c: avoid abort when setting invalid fd
To: "Houqi (Nick) Zuo" <hzuo@redhat.com>
Cc: qemu-devel@nongnu.org, Cindy Lu <lulu@redhat.com>,
 Yanhui Ma <yama@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Dec 8, 2025 at 12:35=E2=80=AFPM Houqi (Nick) Zuo <hzuo@redhat.com> =
wrote:
>
> This patch removes abort() call in the tap_fd_set_vnet_hdr_len()
> function. If the fd is found to be in a bad state (e.g., EBADFD
>  or ENODEV), the function will print an error message.
>
> When QEMU creates a tap device automatically and the tap device is
> manually removed from the host while the guest is running, the tap
> device file descriptor becomes invalid. Later, when the guest executes
> shutdown, the tap_fd_set_vnet_hdr_len() function may be called and
> abort QEMU with a core dump when attempting to use the invalid fd.
> The expected behavior for this negative test case is that QEMU should
> report an error but continue running rather than aborting.
>
> Testing:
> - Start QEMU with automatically created tap device
> - Manually remove the tap device on the host
> - Execute shutdown in the guest
> - Verify QEMU reports an error but does not abort
>
> Fixes: 0caed25cd171 ("virtio: Call set_features during reset")
> Signed-off-by: Houqi (Nick) Zuo <hzuo@redhat.com>

Queued.

Thanks


