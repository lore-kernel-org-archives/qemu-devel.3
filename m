Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D0EC54756
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 07:36:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHHW7-0002TO-W9; Tue, 20 May 2025 03:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uHHVr-0002FL-UR
 for qemu-devel@nongnu.org; Tue, 20 May 2025 03:35:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uHHVp-0003tS-VZ
 for qemu-devel@nongnu.org; Tue, 20 May 2025 03:35:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747726543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WWkL3HJfU9ZtRmhYuV0nrux9JGr0IQVUGgkPTbgezEU=;
 b=jMRnlGAwIHzChn33llAYCS9mOzBrpQ5YnFbdcvB3OyTNvcFDuxb0DMmb/x7/zP0EoxOIzY
 7RQP7Or/AaERJzOVy2RoLu2dG8myWfvDXzBx9j9h9Xcoouk2EyfcL4ksTACV3tlLh0ulSG
 NMl55WjE6JPhh8IXPrtUM4r5BygfUr0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-kqojuQ7DMhSLIbiTvhYqDw-1; Tue,
 20 May 2025 03:35:40 -0400
X-MC-Unique: kqojuQ7DMhSLIbiTvhYqDw-1
X-Mimecast-MFC-AGG-ID: kqojuQ7DMhSLIbiTvhYqDw_1747726539
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 03F001956086; Tue, 20 May 2025 07:35:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 98FC418004A7; Tue, 20 May 2025 07:35:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1336521E6768; Tue, 20 May 2025 09:35:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mario Fleischmann <mario.fleischmann@lauterbach.com>
Cc: qemu-devel@nongnu.org,  alex.bennee@linaro.org,  philmd@linaro.org,
 christian.boenig@lauterbach.com
Subject: Re: [PATCH v2 00/20] Add Multi-Core Debug (MCD) API support
In-Reply-To: <20250430052741.21145-1-mario.fleischmann@lauterbach.com> (Mario
 Fleischmann's message of "Wed, 30 Apr 2025 07:27:21 +0200")
References: <20250430052741.21145-1-mario.fleischmann@lauterbach.com>
Date: Tue, 20 May 2025 09:35:36 +0200
Message-ID: <87iklvd99z.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Mario Fleischmann <mario.fleischmann@lauterbach.com> writes:

> This patch series introduces support for the Multi-Core Debug (MCD) API, a
> commonly used debug interface by emulators. The MCD API, defined through a
> header file, consists of 54 functions for implementing debug and trace.
> However, since it is a header-file-only interface, MCD does not specify a
> communication protocol.
>
> To keep the overhead of a communication protocol on top of MCD minimal,
> we follow a remote procedure call approach by using QAPI as an interface
> definition and transport infrastructure. This way, we can use qapi-gen to
> take care of generating the infrastructure to dispatch MCD functions and
> to (un)marshal their arguments and results. Furthermore, qapi-doc and qtest
> provide good integration into QEMU's documentation and test frameworks.
>
> In v1 of this patch series, the MCD protocol was directly integrated in QMP
> and the QMP monitor was responsible for dispatching MCD's server stub. This
> introduced a dependency between QEMU's machine protocol and the MCD debug
> protocol which is not to be expected. For this reason, v2 introduces a MCD
> monitor which uses as much of the QMP monitor's framework as possible but
> keeps the two protocols separate from each other.
> Similarly, MCD's test suite uses as much of the qtest framework as is useful
> for sending JSON commands to the QEMU under test but adds new code where
> required to prevent dependencies to QMP.
>
> To enable MCD, configure QEMU with `--enable-mcd`.
>
> To start the MCD monitor, run QEMU with the `-mcd` option:
> qemu-system-<arch> [options] -qmp tcp::1235,server=on,wait=off
>
> To run the MCD test suite independently, start `mcd-test`:
> V=1 QTEST_QEMU_BINARY="./qemu-system-<arch> [options]" tests/qtest/mcd-test
>
> To connect from a MCD client, a client stub corresponding to this
> patch series can be found at https://gitlab.com/lauterbach/mcdrefsrv

I'm okay with the general approach.

[...]

>  MAINTAINERS                   |    9 +
>  docs/interop/index.rst        |    1 +
>  docs/interop/mcd.rst          |   65 +
>  gdbstub/gdbstub.c             |   15 +-
>  include/exec/gdbstub.h        |   18 +-
>  include/exec/mcdstub.h        |   18 +
>  mcd/mcd_api.h                 | 3963 +++++++++++++++++++++++++++++++++
>  mcd/mcd_monitor.c             |   90 +
>  mcd/mcd_qapi.c                |  505 +++++
>  mcd/mcd_qapi.h                |   81 +
>  mcd/mcd_server.c              | 2274 +++++++++++++++++++
>  mcd/mcd_stub.c                |  988 ++++++++
>  mcd/meson.build               |   60 +
>  meson.build                   |    5 +
>  meson_options.txt             |    3 +
>  qapi/mcd.json                 | 2366 ++++++++++++++++++++

The schema is too big for me to review in detail.  I understand it's
designed to mirror mcd/mcd_api.h closely, so review would be limited to
checking the way you mirror is sane.  I doubt that would be a good use
of my time, but if you'd like advice on any non-trivial parts, just ask.

Some formatting nits caught my eye.  docs/devel/qapi-code-gen.rst
section "Documentation markup":

    For legibility, wrap text paragraphs so every line is at most 70
    characters long.

    Separate sentences with two spaces.

I recommend to read the entire section.

[...]


