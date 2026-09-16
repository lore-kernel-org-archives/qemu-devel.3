Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD8DC88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 12:49:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6p4Y-0006sY-28; Wed, 16 Sep 2026 08:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x6p4M-0006sJ-UU
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 08:49:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x6p4F-0005nj-9F
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 08:48:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789562929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1iQbEGOQOJKyDZNx1ADOmTA7O595vtIv8iY7COsqD9Q=;
 b=g/VDa/64c1q88xfg2LNLTpPSEjVll8GQYgvOZOyPfiFqoi7VUL6+yDFYXDxoEVaKr5iYb1
 re0vKIVinQSxJPVYlUFAHMGInYV12xWL7J9Iuatzdj151kOxzLW9RqMnbXMTvIcpo0UbdP
 IrZkysZF3nRXMu9NyDnszds0BNZcxMo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-aLPCUsxeMfSlN2OcCjd5Xw-1; Wed,
 16 Sep 2026 08:48:47 -0400
X-MC-Unique: aLPCUsxeMfSlN2OcCjd5Xw-1
X-Mimecast-MFC-AGG-ID: aLPCUsxeMfSlN2OcCjd5Xw_1789562927
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E3999195608D; Wed, 16 Sep 2026 12:48:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B0EA30001BB; Wed, 16 Sep 2026 12:48:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9386F21E6A04; Wed, 16 Sep 2026 14:48:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?B?0J3QuNC60L7Qu9Cw0Lkg0JfQvtGA0LjQvQ==?= <zorin@swemel.ru>
Cc: qemu-devel@nongnu.org,  jasowang@redhat.com,  mst@redhat.com
Subject: Re: [PATCH] util/error, hw/net/virtio-net: fix NULL pointer
 dereference in error_vprepend
In-Reply-To: <500d4850-f7d7-45fb-91e5-74d32d35fde2@swemel.ru>
 (=?utf-8?B?ItCd0LjQutC+0LvQsNC5CdCX0L7RgNC40L0iJ3M=?= message of "Tue, 15
 Sep 2026 19:24:39 +0300")
References: <500d4850-f7d7-45fb-91e5-74d32d35fde2@swemel.ru>
Date: Wed, 16 Sep 2026 14:48:43 +0200
Message-ID: <87h5jp8iqc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

First, please read docs/devel/code-provenance.rst section "Use of
AI-generated content".

I'm not looking at the patches, only the commit message.

=D0=9D=D0=B8=D0=BA=D0=BE=D0=BB=D0=B0=D0=B9 =D0=97=D0=BE=D1=80=D0=B8=D0=BD <=
zorin@swemel.ru> writes:

> SWSA#b0709cee-9722-4603-a30c-dc857dc87961
>
> The `error_vprepend()` function modifies the error message inside an
> existing Error object. However, it only validated if the `errp` pointer
> itself was non-NULL, missing a check for whether the underlying Error
> object `*errp` is `NULL`.

This is nonsense.  error_vprepend() and error_prepend() modify an error.
They must not be called when there is none.  The check isn't missing.
Adding it makes the functions "work" papers over bugs.

> Calling `error_reportf_err(local_error, ...)` when `local_error` is `NULL`
> invokes `error_vprepend(&local_error, ...)`, which subsequently crashes
> via a `NULL` pointer dereference during `(*errp)->msg` access.
>
> Fix `util/error.c` by adding a defensive `!*errp` check inside=20
> `error_vprepend()`.
>
> Additionally, fix the invalid error reporting patterns in=20
> `hw/net/virtio-net.c`:
> - In `vhost_user_net_save_state()` and `vhost_user_net_load_state()`, when
>  =C2=A0 `vhdev =3D=3D NULL`, calling `error_reportf_err()` with an unallo=
cated/NULL
>  =C2=A0 `local_error` is incorrect and unsafe. Replace it with a straight=
forward
>  =C2=A0 `error_report()` call.

Both uses of error_reportf_err() are indeed wrong.

> - Fix a cosmetic double-space typo in "Error loading=C2=A0 back-end state=
".

Worth cleaning up.

> Signed-off-by: Nikolay N Zorin <zorin@swemel.ru>


