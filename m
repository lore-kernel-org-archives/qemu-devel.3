Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9262AD625F9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 08:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viqVc-0006Rf-K9; Thu, 22 Jan 2026 03:57:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1viqV9-0005qc-AV
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:57:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1viqV6-0006Pr-Ih
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:57:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769072230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SgwzgL2wsXMbi1t2W6ZATQXuwGXVxpodou5g0+ffDl0=;
 b=iwgCUKaTlsDP1c2KLgOZQ7AeZJ7+jtgp7MfkXiHHeaWF912ljpdVDJDaKP1SJnqaXgVXNZ
 rylgG/aPm+dDCaF630ZsxvQm3tdl8rKdgHfmh9YMIT/2O4R7y1XEmefx3gs8WAGiZpRNeR
 rU6k1LJqUyXd6VUxqQBkRpt0zedmEP8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-UZFc5hRSMQ-lXTovUmbplQ-1; Thu,
 22 Jan 2026 03:57:05 -0500
X-MC-Unique: UZFc5hRSMQ-lXTovUmbplQ-1
X-Mimecast-MFC-AGG-ID: UZFc5hRSMQ-lXTovUmbplQ_1769072224
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 867C519775AC; Thu, 22 Jan 2026 08:57:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF4D930002DC; Thu, 22 Jan 2026 08:57:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 758A721E692D; Thu, 22 Jan 2026 09:57:01 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Wei Wang <wei.wang@smartx.com>
Cc: qemu-devel@nongnu.org,  kkostiuk@redhat.com,  michael.roth@amd.com
Subject: Re: [PATCH] qga: Fix crash due to redundant error setting in
 qmp_guest_file_open()
In-Reply-To: <20260122040430.51001-1-wei.wang@smartx.com> (Wei Wang's message
 of "Thu, 22 Jan 2026 12:04:30 +0800")
References: <20260122040430.51001-1-wei.wang@smartx.com>
Date: Thu, 22 Jan 2026 09:57:01 +0100
Message-ID: <87cy32gh42.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Wei Wang <wei.wang@smartx.com> writes:

> Avoid setting GError multiple times in qmp_guest_file_open() by checking
> if errp is already set.
> This prevents crash caused by repeated error handling calls.
>
> Signed-off-by: Wei Wang <wei.wang@smartx.com>
> ---
>  qga/commands-win32.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 0fd0c966e4..8c45ca5004 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -263,7 +263,9 @@ int64_t qmp_guest_file_open(const char *path, const char *mode, Error **errp)
>      fd = guest_file_handle_add(fh, errp);
>      if (fd < 0) {
>          CloseHandle(fh);
> -        error_setg(errp, "failed to add handle to qmp handle table");
> +        if (!*errp) {
> +            error_setg(errp, "failed to add handle to qmp handle table");
> +        }
>          goto done;
>      }

Can guest_file_handle_add() fail without setting an error?

If yes, that's the bug that needs fixing.

If no, the error_setg() here is wrong and needs to be deleted.


