Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9E0606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 12:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=pond.sub.org header.i=@pond.sub.org header.a=rsa-sha256 header.s=mail header.b=PfmKp+2Y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVTcG-0004Zt-W9; Mon, 23 Nov 2026 07:57:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xVTcE-0004XX-Fg; Mon, 23 Nov 2026 07:57:50 -0500
Received: from oxygen.pond.sub.org ([94.130.129.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xVTcC-0000jj-DP; Mon, 23 Nov 2026 07:57:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pond.sub.org; s=mail;
 t=1795438653; bh=hnuPeygjk6WxCPvkeDwMUh7WdvNPWpQeQcc411+i5cU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=PfmKp+2YtaePm8DMahZfAm6ddfYpnoKlzBv9Snd652afjNc4IVdr0ZgHlOhs/OpOe
 zDBO/K87Ko8DABKxjvI4tQ1/05Z9WazD6kKg//ofHo61tHjjnn7eWktoWpv+1EFoQJ
 lHghrPWc5NjTGq67QRb55J6hNwXWJNxCwFAZV3Lk=
Received: from blackfin.pond.sub.org (p4fd045cf.dip0.t-ipconnect.de
 [79.208.69.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id 2AC65205B5;
 Mon, 23 Nov 2026 13:57:31 +0100 (CET)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1C67D21E6A04; Mon, 23 Nov 2026 13:57:39 +0100 (CET)
From: Markus Armbruster <armbru@pond.sub.org>
To: Zhu Wei <zachwade.k@gmail.com>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  niming <niming@sangfor.com.cn>,  zhuwei
 <zhuwei@sangfor.com.cn>
Subject: Re: [PATCH v3 1/1 ] block/monitor: fix BlockJobInfoList leak in
 hmp_info_block_jobs()
In-Reply-To: <20261123100920.2966172-2-zhuwei@sangfor.com.cn> (Zhu Wei's
 message of "Mon, 23 Nov 2026 18:08:49 +0800")
References: <20261123100920.2966172-1-zhuwei@sangfor.com.cn>
 <20261123100920.2966172-2-zhuwei@sangfor.com.cn>
Date: Mon, 23 Nov 2026 13:57:39 +0100
Message-ID: <87eccbwvr0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
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
> Fixes: fb5458cd10a1 ("qmp: add query-block-jobs")

Still wrong: the line you fix doesn't exist there.  Please slow down some.

I believe it is

  Fixes: 93bb1315250d ("hmp: fix memory leak at hmp_info_block_jobs()")

> Signed-off-by: niming <niming@sangfor.com.cn>
> Signed-off-by: zhuwei <zhuwei@sangfor.com.cn>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

