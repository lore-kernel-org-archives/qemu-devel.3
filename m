Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03D9606A690
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 13:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pond.sub.org header.i=@pond.sub.org header.a=rsa-sha256 header.s=mail header.b=XON5XWO2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVUYL-0000m0-A5; Mon, 23 Nov 2026 08:57:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xVUYJ-0000lj-P0; Mon, 23 Nov 2026 08:57:51 -0500
Received: from oxygen.pond.sub.org ([2a01:4f8:13b:3ad0:1::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xVUYH-000675-4b; Mon, 23 Nov 2026 08:57:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pond.sub.org; s=mail;
 t=1795442256; bh=vKUs6t0SQWFzbQSq/X9PcIj6LgVmSXRVThmUQPV8tk0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=XON5XWO2YxaRfaDdDTL4kMt3J1J2B8DDM5Cetx9PQYZm25sNqq8BUFKybBrabc8s9
 2gADf1Va3Tmlt4IEwE+L8/kq+fdmiwbzi4sqhO6dp6/RGuLsD5pBJCj3r9x4Y2cTGp
 kFozXdQEX7ABGdnsOYUUGLqG5fX+wGjpKWvONaRA=
Received: from blackfin.pond.sub.org (p4fd045cf.dip0.t-ipconnect.de
 [79.208.69.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id D5FB82007A;
 Mon, 23 Nov 2026 14:57:35 +0100 (CET)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5CBD421E6A04; Mon, 23 Nov 2026 14:57:43 +0100 (CET)
From: Markus Armbruster <armbru@pond.sub.org>
To: Zhu Wei <zachwade.k@gmail.com>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  niming <niming@sangfor.com.cn>,  zhuwei
 <zhuwei@sangfor.com.cn>
Subject: Re: [PATCH v4 1/1 ] block/monitor: fix BlockJobInfoList leak in
 hmp_info_block_jobs()
In-Reply-To: <20261123132344.3154080-2-zhuwei@sangfor.com.cn> (Zhu Wei's
 message of "Mon, 23 Nov 2026 21:23:42 +0800")
References: <20261123132344.3154080-1-zhuwei@sangfor.com.cn>
 <20261123132344.3154080-2-zhuwei@sangfor.com.cn>
Date: Mon, 23 Nov 2026 14:57:43 +0100
Message-ID: <87a4mzveeg.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a01:4f8:13b:3ad0:1::3;
 envelope-from=armbru@pond.sub.org; helo=oxygen.pond.sub.org
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Zhu Wei <zachwade.k@gmail.com> writes:

> From: zhuwei <zhuwei@sangfor.com.cn>
>
> hmp_info_block_jobs() uses 'list' both as the head of the BlockJobInfoList
> returned by qmp_query_block_jobs() and as the iterator of the while loop.
> Once the loop finishes, 'list' is NULL, so the call to
> qapi_free_BlockJobInfoList(list) at the end of the function frees nothing
> and the whole list returned by qmp_query_block_jobs() is leaked.
>
> Keep the head of the list in a separate variable and free that one after
> the loop, so the entire list is released as intended.
>
> Fixes: 93bb1315250d ("hmp: fix memory leak at hmp_info_block_jobs()")
> Signed-off-by: niming <niming@sangfor.com.cn>
> Signed-off-by: zhuwei <zhuwei@sangfor.com.cn>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  block/monitor/block-hmp-cmds.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmd=
s.c
> index 7bae4d425c..d3f404146a 100644
> --- a/block/monitor/block-hmp-cmds.c
> +++ b/block/monitor/block-hmp-cmds.c
> @@ -760,7 +760,7 @@ void hmp_info_blockstats(MonitorHMP *hmp, const QDict=
 *qdict)
>=20=20
>  void hmp_info_block_jobs(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    BlockJobInfoList *list;
> +    BlockJobInfoList *list, *head;
>=20=20
>      list =3D qmp_query_block_jobs(&error_abort);
>=20=20
> @@ -769,6 +769,9 @@ void hmp_info_block_jobs(MonitorHMP *hmp, const QDict=
 *qdict)
>          return;
>      }
>=20=20
> +    head =3D list;
> +
>      while (list) {
>          if (list->value->type =3D=3D JOB_TYPE_STREAM) {
>              monitor_hmp_printf(hmp, "Streaming device %s: Completed %" P=
RId64
> @@ -791,7 +794,7 @@ void hmp_info_block_jobs(MonitorHMP *hmp, const QDict=
 *qdict)
>          list =3D list->next;
>      }
>=20=20
> -    qapi_free_BlockJobInfoList(list);
> +    qapi_free_BlockJobInfoList(head);
>  }
>=20=20
>  void hmp_info_snapshots(MonitorHMP *hmp, const QDict *qdict)

Reviewed-by: Markus Armbruster <armbru@redhat.com>

The function right above this one does a similar loop more nicely:

    stats_list =3D qmp_query_blockstats(false, false, NULL);

    for (stats =3D stats_list; stats; stats =3D stats->next) {
        ...
    }

    qapi_free_BlockStatsList(stats_list);

Observation, not a demand.

