Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71E9606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pond.sub.org header.i=@pond.sub.org header.a=rsa-sha256 header.s=mail header.b=V5Y1ApzW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTNal-00014G-KD; Tue, 17 Nov 2026 13:07:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xTNac-0000pP-O5; Tue, 17 Nov 2026 13:07:31 -0500
Received: from oxygen.pond.sub.org ([94.130.129.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xTNaZ-0005x2-NB; Tue, 17 Nov 2026 13:07:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pond.sub.org; s=mail;
 t=1794938837; bh=3GukzQFRiBfm2OCdDGDn/Z+ydRHkB0R8csTLQwyw6gQ=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=V5Y1ApzWX48csilmnk0F0ZFE2Dp25BU0UqdPlH9sEXO2KYeP3tdBYTqcytwCc9THB
 slyLm6OkgNB6JyJVDAfgdfiaoNPWOt6ygNb8kd85+Mko+VQ7+tY7EhBchsHZFVlpvC
 KsE2DR8J81hcq7XfT0Ylx9NxW628DhuGItpDBttA=
Received: from blackfin.pond.sub.org (p4fd045cf.dip0.t-ipconnect.de
 [79.208.69.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id 362832017D;
 Tue, 17 Nov 2026 19:07:16 +0100 (CET)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0181521E6A04; Tue, 17 Nov 2026 19:07:21 +0100 (CET)
From: Markus Armbruster <armbru@pond.sub.org>
To: Zhu Wei <zachwade.k@gmail.com>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  Kevin Wolf
 <kwolf@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,  niming
 <niming@sangfor.com.cn>,  zhuwei <zhuwei@sangfor.com.cn>
Subject: Re: [PATCH 1/1] block/monitor: fix BlockJobInfoList leak in
 hmp_info_block_jobs()
In-Reply-To: <20261117144548.3252867-2-zhuwei@sangfor.com.cn> (Zhu Wei's
 message of "Tue, 17 Nov 2026 22:45:48 +0800")
References: <20261117144548.3252867-1-zhuwei@sangfor.com.cn>
 <20261117144548.3252867-2-zhuwei@sangfor.com.cn>
Date: Tue, 17 Nov 2026 19:07:21 +0100
Message-ID: <8733szjpra.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=94.130.129.15; envelope-from=armbru@pond.sub.org;
 helo=oxygen.pond.sub.org
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
> Fixes: 2bcad73c4b9b ("monitor/hmp: move hmp_info_block* to block-hmp-cmds.c")

Pure code motion.  Please try again :)

> Signed-off-by: niming <niming@sangfor.com.cn>
> Signed-off-by: zhuwei <zhuwei@sangfor.com.cn>
> ---
>  block/monitor/block-hmp-cmds.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
> index 7bae4d425c..d3f404146a 100644
> --- a/block/monitor/block-hmp-cmds.c
> +++ b/block/monitor/block-hmp-cmds.c
> @@ -760,7 +760,7 @@ void hmp_info_blockstats(MonitorHMP *hmp, const QDict *qdict)
>  
>  void hmp_info_block_jobs(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    BlockJobInfoList *list;
> +    BlockJobInfoList *list, *head;
>  
>      list = qmp_query_block_jobs(&error_abort);
>  
> @@ -769,6 +769,9 @@ void hmp_info_block_jobs(MonitorHMP *hmp, const QDict *qdict)
>          return;
>      }
>  
> +    /* Keep the head: list is NULL once the loop below is done */
> +    head = list;
> +
>      while (list) {
>          if (list->value->type == JOB_TYPE_STREAM) {
>              monitor_hmp_printf(hmp, "Streaming device %s: Completed %" PRId64
> @@ -791,7 +794,7 @@ void hmp_info_block_jobs(MonitorHMP *hmp, const QDict *qdict)
>          list = list->next;
>      }
>  
> -    qapi_free_BlockJobInfoList(list);
> +    qapi_free_BlockJobInfoList(head);
>  }
>  
>  void hmp_info_snapshots(MonitorHMP *hmp, const QDict *qdict)

Patch looks good to me, but I'd drop the comment.

