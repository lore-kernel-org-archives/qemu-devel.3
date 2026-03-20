Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087C2109317B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 06:58:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3To1-0002Og-8O; Fri, 20 Mar 2026 02:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w3To0-0002OY-6b
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 02:58:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w3Tny-00068Q-Kl
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 02:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773989877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aWStPM7kBYwILbKrCpZRvLvv38EF2IgO2SjPyRoj51U=;
 b=A4H+l299YcwBRDNFAylnxyKzXAih87DYMtmZqJasCbxgzvK55cAMzSKFPHsUWPoKVXZyG2
 KHQ2kEXCrySvQNTn+xDOeOOTNEaCFjQCgwdKEpNcDv971k0YvrfODlmRX2G3jGdC/vhFYs
 H8LecvDvrG2bCPeFvQbJJCzRjQ6ZwRk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-UV0A4nU9NYSoAuJI9u09NQ-1; Fri,
 20 Mar 2026 02:57:55 -0400
X-MC-Unique: UV0A4nU9NYSoAuJI9u09NQ-1
X-Mimecast-MFC-AGG-ID: UV0A4nU9NYSoAuJI9u09NQ_1773989874
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD1B419560A7; Fri, 20 Mar 2026 06:57:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6A8A91955F25; Fri, 20 Mar 2026 06:57:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CAF5621E6937; Fri, 20 Mar 2026 07:57:51 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: yanlonglong <yanlonglong@kylinos.cn>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>
Subject: Re: [PATCH] hw/ide: resolve core crash caused by optical drive
 pop-up during virtual machine startup
In-Reply-To: <20260320020724.8714-1-yanlonglong@kylinos.cn>
 (yanlonglong@kylinos.cn's message of "Fri, 20 Mar 2026 10:07:24
 +0800")
References: <20260320020724.8714-1-yanlonglong@kylinos.cn>
Date: Fri, 20 Mar 2026 07:57:51 +0100
Message-ID: <87341vkmxc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

Reproducer?

Is this a regression?

yanlonglong <yanlonglong@kylinos.cn> writes:

> Signed-off-by: yanlonglong <yanlonglong@kylinos.cn>
> ---
>  hw/ide/atapi.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
> index a42b748521..d14feed45b 100644
> --- a/hw/ide/atapi.c
> +++ b/hw/ide/atapi.c
> @@ -153,6 +153,11 @@ static void cd_read_sector_cb(void *opaque, int ret)
>  static int cd_read_sector(IDEState *s)
>  {
>      void *buf;
> +    
> +    //resolve core crash caused by optical drive pop-up during virtual machine startup

docs/devel/style.rst:

    We use traditional C-style /``*`` ``*``/ comments and avoid // comments.

> +    if (!blk_is_available(s->blk)) {
> +        return -ENOMEDIUM;
> +    }
>  
>      if (s->cd_sector_size != 2048 && s->cd_sector_size != 2352) {
>          block_acct_invalid(blk_get_stats(s->blk), BLOCK_ACCT_READ);


