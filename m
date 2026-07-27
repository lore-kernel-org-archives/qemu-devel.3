Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D01D8C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 10:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woIw1-0000bH-OQ; Mon, 27 Jul 2026 06:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1woIvs-0000aK-48
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 06:51:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1woIvq-0003BY-01
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 06:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785149497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PALmNLZ34+QkRqPoenBk1x1GsUgAG1Wa+236evQz150=;
 b=ONV4ltXtHXzik1nm0aHPQSuWhbpThYo81MNsCS6KOdjtcaKO0vAKAcVXYuZ+6rKpGf6sZp
 RPgJCwpehRIx3tArc2GgnXZlIfVFbiUPbRalID0TQaYdMytG4UO7agXX4DVfGizowtb8xD
 fNBo2rH9JYPZgqvV/velfLoOamOZnyo=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-w9ZUlsO4PGa9TkjAu16sDw-1; Mon, 27 Jul 2026 06:51:35 -0400
X-MC-Unique: w9ZUlsO4PGa9TkjAu16sDw-1
X-Mimecast-MFC-AGG-ID: w9ZUlsO4PGa9TkjAu16sDw_1785149495
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-84a67b16217so4464310b3a.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 03:51:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785149493; cv=none;
 d=google.com; s=arc-20260327;
 b=Q7+aj22U+t5WaeRKrhj71cZhyUsBp/MsNfNUgeSo5LynaJd0DdzlohLt9v14HxayvU
 myKu181rwdHBROIzHO/2Mb5WxuYVMN2wFflFf99nhX+JBLq61u1CsnsQIaAOujRZ/nau
 Epl1G4+fjP3R74nBauINHjYt8kCKfpcz93OESf97sdRaZkc/TWtH3DXI4gD+e+DMVgtE
 cXWnt42HmAJJiUgOV955GSa0OZeSAYAOctnhMnf112VQ626fMpZfMSy97KTHFZn3fvAD
 juCvai5J4Pl+FK66nvOrgf2jnOcn00jRS2pUCl60w8MeUF3RCvh2VfiXDkxNaGyjyaZF
 fEeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PALmNLZ34+QkRqPoenBk1x1GsUgAG1Wa+236evQz150=;
 fh=fdVOT/7dFFaeK44Wq0gv9vI5EBoVvv8k0BvOZdqUCnk=;
 b=OwGdcLb1XSkRAs8miV5mUmBEJ8Z4r24EhJJ7llVPTGJd5QsaFNlN6v3CwQQvSn0XgQ
 1ohAHl87AXBdy0xW6wIhIE78tJ5RWOmNtZmYSqXG/R/jv0TFAWpPkyr1m95lziIMMGsy
 dLqDuNcg8s7JDDpQeLYudKSAaiCv0ueiU9QHTmBCtUeYsQL3733oqf6dnvo7oOop4cXN
 bSikxcqJcmw5rtcVzfrLkYsZTAX2HXCHb2pSdmeemYTVuKst+i3f3yMJO6TzWr6eZpUu
 RfUX7p6uudJt3jFlkASb9d4nWYJE998lZJWu0+s9EXIs1MuAblTNelneyRR3RUkh/MD5
 TExg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785149493; x=1785754293; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PALmNLZ34+QkRqPoenBk1x1GsUgAG1Wa+236evQz150=;
 b=qRSLyO7nx6HAzHJn3g/JgECyXXz/VX1wNfRpdilDDFGngYhCSxlave9fbg56JbXgUH
 wJ4MCc9xT4ZdD45LrlGQT9brHCR0abP371G/VDigkYQXRmKRB0jvCMw8MtxFXngBqUQU
 vKblvXxdhRqCsPjhRUcKa29EJQTPzbsZRLEWNeELk+BKWO0Bj9hVUgJcolX4di+5HnEz
 iYB9t0Dr7xUg+2UVRDFij2QbphTVu1bZxUPA9ezMSbdiaGDQmBHbHFwOP4XPOYKbCdEg
 /nLnpBSqlrgFeqMfDdMDnPL7o/xYEU6UOof6oLMf90Yb8jr44hzyABIh0+V/+WcqHJYf
 KgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785149493; x=1785754293;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PALmNLZ34+QkRqPoenBk1x1GsUgAG1Wa+236evQz150=;
 b=qghR1WQ78MzFVsStioxiVDwBUw4EmjSB0rV7FHHPMy/il3nVuP8y9BHSzafm2YnAg9
 iWjrDSySdyWyQi6EgxJNWmOp5+GRft8KaFILqHbkxgKq/HN/YO9wiiOZFM8cK5ZXi7xI
 Pz4wwKjfoBX1Wnm/2XpmiqZpZdP+Te1f7AT2eJksBvpUMQLEHoGOaCRNk37RWxK4f629
 NF4rV8kfpdWphudVs6aIjEByLeMO4xHSJMZa+VHJ/JceDjGgqeX1Trj6QXi+Ald8Ylq9
 EsCSGKnMmNxp+bb653Q4TeXJmiDUYDfgOmiftvGS9OqLmL/2GIFY0M0ZJsacPy2DM0VA
 /HDA==
X-Gm-Message-State: AOJu0Yzu5s1TXezgTY4huXFfZ99QO1HOUJhUiDHMh4rHJWN5amUP7/kc
 lBqiHkQyFpSvfQaa+YmNXZRD0mKFVaTB+70RSC8vxE/JoXnA1C7UPos2opT0QJ6L4BfC62Yf6GD
 EiD/bOhctC6Ey3nudltB9ging7RP+XRKAVGTOYpeixNEqfvfw+6nYKJfaEBF6Lo6U8KHZ1YZDvS
 qw/NsnT6rj5qWCQclUC3hUvg0Z4KQGM+vmfwW7KdTeHA==
X-Gm-Gg: AR+sD11O6Ntph95Y3pN+AlM6AFQDR+n0K1c9HRs6OiglLgiEsWpp0OGpLwpHaS+GiDw
 SVxydIvpu9S759tt1qwjiyFKDiLuQI0Z3hECIjuRA2D/e922qdcSCnAGVTBQoVLeAUUiHr5xJui
 /ZkyJ4iReLstWBfIRGGb+ps1GBH2NAhPZkmcodCnNdQZQSnuRqaJScUWrsYV3Zdhx9sdgKuKD1V
 b8lvVCvOc9X2GrzN26JM89h2PFffT+RHrAKhkuBAeoAaXxX+Cyoa8yRnCou3eHyJufBvlxST5sf
 uQ==
X-Received: by 2002:a05:6a00:4648:b0:84e:244a:98e8 with SMTP id
 d2e1a72fcca58-84e59491059mr6368403b3a.30.1785149493111; 
 Mon, 27 Jul 2026 03:51:33 -0700 (PDT)
X-Received: by 2002:a05:6a00:4648:b0:84e:244a:98e8 with SMTP id
 d2e1a72fcca58-84e59491059mr6368359b3a.30.1785149492674; Mon, 27 Jul 2026
 03:51:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260725-co-v2-0-d3552ddb3931@redhat.com>
In-Reply-To: <20260725-co-v2-0-d3552ddb3931@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 14:51:20 +0400
X-Gm-Features: AUfX_myf2_jNttAq9V_d7I6y5h_jwqjOgLK2HB5Guezr7Cr4sf4D7xx8j8_zEIA
Message-ID: <CAMxuvazemnngM4-J1QFPwEBaazVnTavxSEbZEe9HGSrri9CjqA@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] coroutine: add missing annotations
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Denis V. Lunev" <den@openvz.org>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 xen-devel@lists.xenproject.org, Li Zhijian <lizhijian@fujitsu.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

On Sat, Jul 25, 2026 at 1:48=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi
>
> Add missing coroutine_fn, coroutine_mixed_fn annotations and fix
> a few related issues across monitor, migration, io, block, and
> 9pfs subsystems.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

I am queuing all except "block: add missing coroutine_fn annotations"
awaiting review

> ---
> Changes in v2:
> - fix some annotations in patch "block: add missing coroutine annotation"
> - collect trailer tags
> - Link to v1: https://lore.kernel.org/qemu-devel/20260720-co-v1-0-fabb4db=
3c204@redhat.com
>
> To: qemu-devel@nongnu.org
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Fabiano Rosas <farosas@suse.de>
> Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> Cc: John Snow <jsnow@redhat.com>
> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Hanna Reitz <hreitz@redhat.com>
> Cc: qemu-block@nongnu.org
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Fam Zheng <fam@euphon.net>
> Cc: "Denis V. Lunev" <den@openvz.org>
> Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>
> Cc: Greg Kurz <groug@kaod.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony PERARD <anthony@xenproject.org>
> Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
> Cc: xen-devel@lists.xenproject.org
> Cc: Li Zhijian <lizhijian@fujitsu.com>
>
> ---
> Marc-Andr=C3=A9 Lureau (8):
>       monitor: annotate monitor_qmp_dispatcher_pop_any() as coroutine
>       migration: fix qemu_get_counted_string annotation
>       io: add missing coroutine annotation
>       block: add missing coroutine annotation
>       qcow2: remove invalid qcow2_check_refcounts calls
>       block: add missing coroutine_fn annotations
>       hw/9pfs: annotate V9fsTransport callbacks as coroutine_fn
>       migration/rdma: annotate and simplify wait_comp_channel()
>
>  hw/9pfs/9p.h                 | 26 +++++++++++++++-----------
>  include/block/blockjob_int.h |  2 +-
>  include/io/channel.h         |  4 ++--
>  block/commit.c               |  5 +++--
>  block/crypto.c               | 13 +++++++------
>  block/io.c                   |  8 +++++---
>  block/parallels.c            |  5 +++--
>  block/qcow2-snapshot.c       | 18 ------------------
>  block/qcow2.c                | 12 ++++++++----
>  blockjob.c                   |  3 ++-
>  hw/9pfs/9p.c                 | 31 +++++++++++++++++++------------
>  hw/9pfs/virtio-9p-device.c   | 24 +++++++++++++-----------
>  hw/9pfs/xen-9p-backend.c     | 34 +++++++++++++++++-----------------
>  io/channel.c                 |  5 +++--
>  migration/qemu-file.c        |  2 +-
>  migration/rdma.c             | 12 ++++--------
>  monitor/qmp.c                |  3 ++-
>  17 files changed, 105 insertions(+), 102 deletions(-)
> ---
> base-commit: 300438ffbb8d9430cac2fcc15cba6f482b2c0587
> change-id: 20260720-co-625d98c7dc5e
>
> Best regards,
> --
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>


