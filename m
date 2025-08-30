Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F1B7CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usOE8-0007Mt-JV; Sat, 30 Aug 2025 12:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1usKFb-0002tt-8R; Sat, 30 Aug 2025 08:00:07 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1usKFY-0002Rk-Ho; Sat, 30 Aug 2025 08:00:06 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-74542b1b2f7so2478776a34.3; 
 Sat, 30 Aug 2025 05:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756555202; x=1757160002; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q1u7Y0LnB2OthysxlFNVi2xzVYI1K22e1j/zpM8FPJI=;
 b=Wk0ZWOckn/qgGwPJ2VmeAuOwY8JMf/+p0bF7lYMmd8dfrCm8SwLgtL9I6Y4dZtZIi/
 eQzfluOB+CAGqbnzJXEQ+5ifOxVdcQQ+oG8cdVPWbwwWFq2MiBSza9QOGDNDuCzs5TnV
 CozderznEllVKV1y7Z8hHFmxOP5aLfnoZlnFYZDGxgqo1RGEuSZ+y46t/71PTCcUw5fm
 PFXPgqrP+1fBgxex3/O+x6NB2p6xau6e71jqD+kToFj5HUaosSFBblIcwA1uJV8E1fM0
 2o4ySvkCmXJyOcPM1xR9xyGj7mVPKS9B65tiEh+Vfmz9/D7bEYUPM4Omx6b9D0qelmXc
 yJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756555202; x=1757160002;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q1u7Y0LnB2OthysxlFNVi2xzVYI1K22e1j/zpM8FPJI=;
 b=RV9cQcfdon2cDtsqysb3eu9PCd7bLhFhPKzgK0NhPgXxScnZ2vz0UE6NSHU+yO0Qyk
 IduRV75LM5UQ0SRMQwRMgQxgOgP+359IzwW9qWHLRwBKyDbRL8aCPlFk9ZDZiXVVpnUC
 8tWeozp/SutjwgcghxXqmF8uTcYcGe0JfkR5vNDzor7iA+ZvWi1tVAZfAfOyKzY2nMmy
 BYdmp8Y9zXSiBE840ckshU52V9YDlsQvGDh7l/Kwgr40Tl063JkxMr0R8VQ5oUCBz/iH
 MFr4O35gpKA594tJq11WFd8qNPFVj/tFgml8y1j4IKCH/Im6ZGEZpQBd5sasI1djO/b0
 RQtg==
X-Gm-Message-State: AOJu0YxPXYDJM9X1RyB6SBgwnQsZt1ty68T/42fcgEmfVs+jgwHzN3V2
 93FACFicqLLwRu1s5J3CtG9a55Huhiv02U2hAAYODL9HisCifolDS+M8isuO+Xbxad3b8aYS4Q6
 LDBRl92tdFnGL85fwFJRcIbFjxBVYwWE6uFTH
X-Gm-Gg: ASbGnctMUE3j6ZjLVKwingy4ZGDtagm6xIAp+Q8Q1RAV19blpsNUuD1DAyqPTYIS3RX
 TYOzwd1HJwI9d3dOHJEjbttsGl+T2KgxlIYSawdS7brpnu4IeED1qS5cO48orX2dTxvVF0MWdxm
 Osn/y2p6jxCn2jXJTZXlYHkig3fX7GLbLcjj/stm6w8cvPXJckduQqIPcolmuBFqUypvJ2gZMNt
 oiHVp7anyTgxOT99G5ljuAxPeJxcgjbgAjvruaM
X-Google-Smtp-Source: AGHT+IGTaorHFR43zcyJ0luBTjDLl0oq0gEcnfXNWqCMbFg5WEd+aWQLBf8TQKSPnNLbfgB9V76Bl82dBuUJ/J2ciW4=
X-Received: by 2002:a05:6808:17a3:b0:434:2d4:f1bf with SMTP id
 5614622812f47-437f7d0f017mr654451b6e.21.1756555201873; Sat, 30 Aug 2025
 05:00:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250830025025.3610-1-hibriansong@gmail.com>
In-Reply-To: <20250830025025.3610-1-hibriansong@gmail.com>
From: Brian Song <hibriansong@gmail.com>
Date: Sat, 30 Aug 2025 08:00:00 -0400
X-Gm-Features: Ac12FXxoGoZLt6wedR06mFyps0NfGAGKdIgOxBiSilazLxe_ykqAvglOOJpTbK4
Message-ID: <CAKWCU7VusNOUskuxc3RMTd+aLY6bSX+de-LiUhe9xpdmbzkn-Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] export/fuse: Add FUSE-over-io_uring for Storage
 Exports
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, bernd@bsbernd.com, 
 fam@euphon.net, hreitz@redhat.com, kwolf@redhat.com, stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=hibriansong@gmail.com; helo=mail-ot1-x332.google.com
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

We used fio to test a 1=E2=80=AFGB file under both traditional FUSE and
FUSE-over-io_uring modes. The experiments were conducted with the
following iodepth and numjobs configurations: 1-1, 64-1, 1-4, and 64-4,
with 70% read and 30% write, resulting in a total of eight test cases,
measuring both latency and throughput.

Test results:

https://gist.github.com/hibriansong/a4849903387b297516603e83b53bbde4




On 8/29/25 10:50 PM, Brian Song wrote:
> Hi all,
>
> This is a GSoC project. More details are available here:
> https://wiki.qemu.org/Google_Summer_of_Code_2025#FUSE-over-io_uring_expor=
ts
>
> This patch series includes:
> - Add a round-robin mechanism to distribute the kernel-required Ring
> Queues to FUSE Queues
> - Support multiple in-flight requests (multiple ring entries)
> - Add tests for FUSE-over-io_uring
>
> More detail in the v2 cover letter:
> https://lists.nongnu.org/archive/html/qemu-block/2025-08/msg00140.html
>
> And in the v1 cover letter:
> https://lists.nongnu.org/archive/html/qemu-block/2025-07/msg00280.html
>
>
> Brian Song (4):
>    export/fuse: add opt to enable FUSE-over-io_uring
>    export/fuse: process FUSE-over-io_uring requests
>    export/fuse: Safe termination for FUSE-uring
>    iotests: add tests for FUSE-over-io_uring
>
>   block/export/fuse.c                  | 838 +++++++++++++++++++++------
>   docs/tools/qemu-storage-daemon.rst   |  11 +-
>   qapi/block-export.json               |   5 +-
>   storage-daemon/qemu-storage-daemon.c |   1 +
>   tests/qemu-iotests/check             |   2 +
>   tests/qemu-iotests/common.rc         |  45 +-
>   util/fdmon-io_uring.c                |   5 +-
>   7 files changed, 717 insertions(+), 190 deletions(-)
>

