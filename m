Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA57C44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 12:34:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlnCI-0002L6-Vy; Mon, 20 Jul 2026 08:34:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wlnCH-0002Kl-Cr
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 08:34:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wlnCF-0001zX-H7
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 08:34:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784550850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CXa8P+UUFs0PByxiYGtGNrGEQP8hiqCznin53lWm6r0=;
 b=VCbWVpUDmTVggoEDXZvoRFuc84WFoj8eaHMr1CdsIuzX/rtzQux76njGChJoEdtEgUoVSo
 HSK5f2l7W0McUQra/VQ29AfdWNMf4ZUhE7OQls/QBlMj+BlnixQtr4Dkx5rdbYMtcCp/QZ
 +hVurJAvODwe1AXrBBoVFB1U0GREAh0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-R918he7BM2GPpnMqC6aPAA-1; Mon,
 20 Jul 2026 08:34:06 -0400
X-MC-Unique: R918he7BM2GPpnMqC6aPAA-1
X-Mimecast-MFC-AGG-ID: R918he7BM2GPpnMqC6aPAA_1784550844
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BD621801BD0; Mon, 20 Jul 2026 12:34:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B43AF18001E2; Mon, 20 Jul 2026 12:34:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7262921E6920; Mon, 20 Jul 2026 14:34:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  John Snow
 <jsnow@redhat.com>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  Kevin Wolf <kwolf@redhat.com>,  Hanna Reitz
 <hreitz@redhat.com>,  qemu-block@nongnu.org,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Fam Zheng <fam@euphon.net>,  "Denis V. Lunev"
 <den@openvz.org>,  Christian Schoenebeck <qemu_oss@crudebyte.com>,  Greg
 Kurz <groug@kaod.org>,  "Michael S. Tsirkin" <mst@redhat.com>,  Stefano
 Stabellini <sstabellini@kernel.org>,  Anthony PERARD
 <anthony@xenproject.org>,  "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org,  Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH 1/8] monitor: annotate monitor_qmp_dispatcher_pop_any()
 as coroutine
In-Reply-To: <20260720-co-v1-1-fabb4db3c204@redhat.com> (=?utf-8?Q?=22Marc?=
 =?utf-8?Q?-Andr=C3=A9?= Lureau"'s
 message of "Mon, 20 Jul 2026 11:55:30 +0400")
References: <20260720-co-v1-0-fabb4db3c204@redhat.com>
 <20260720-co-v1-1-fabb4db3c204@redhat.com>
Date: Mon, 20 Jul 2026 14:34:00 +0200
Message-ID: <87ecgxvo07.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=armbru@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> The function calls qemu_coroutine_yield(), and is called from
> monitor_qmp_dispatcher_co().
>
> Fixes: 60f4f62efeb ("monitor: extract request dequeuing to a new function=
")
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  monitor/qmp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/monitor/qmp.c b/monitor/qmp.c
> index 223e0643c2a..338d37cb7e5 100644
> --- a/monitor/qmp.c
> +++ b/monitor/qmp.c
> @@ -342,7 +342,8 @@ static QMPRequest *monitor_qmp_requests_pop_any_with_=
lock(void)
>      return req_obj;
>  }
>=20=20
> -static QMPRequest *monitor_qmp_dispatcher_pop_any(void)
> +static QMPRequest * coroutine_fn
> +monitor_qmp_dispatcher_pop_any(void)
>  {
>      while (true) {
>          /*

Reviewed-by: Markus Armbruster <armbru@redhat.com>


