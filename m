Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0780E9539A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 13:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vncfV-0005Ge-SJ; Wed, 04 Feb 2026 08:11:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vncfS-0005FN-RJ
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 08:11:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vncfR-0000DF-Av
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 08:11:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770210695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8l45FkHHxlcA5g74ceNd2iNmwtU9cqPpHIpVeA+mecs=;
 b=R1JoY+DhEXvxVpuWb42EjxadvFrb/ZpEOGRSFV0jfu03iiNVsXW9XJn6qBK1JlykTZgMsX
 Z7It230imghxosbpvwPwnokJWt09HuhL4+xRsvFcxoAAd3nYcdexa9dd+7J2WOXnTBYX0C
 87ziBucLQYGRRLRxAT8ATYJ9lEUPYpY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-264-k39nSznfPZWcLl2uCIBMmA-1; Wed,
 04 Feb 2026 08:11:32 -0500
X-MC-Unique: k39nSznfPZWcLl2uCIBMmA-1
X-Mimecast-MFC-AGG-ID: k39nSznfPZWcLl2uCIBMmA_1770210691
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 34CEA1956094; Wed,  4 Feb 2026 13:11:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.22])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8EA7530001B9; Wed,  4 Feb 2026 13:11:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 210FE21E692D; Wed, 04 Feb 2026 14:11:28 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: marcandre.lureau@redhat.com,  pbonzini@redhat.com,  eblake@redhat.com,
 berrange@redhat.com,  yc-core@yandex-team.ru,  d-tatianin@yandex-team.ru,
 qemu-devel@nongnu.org,  philmd@linaro.org
Subject: Re: [PATCH v3 3/3] chardev: add logtimestamp option
In-Reply-To: <20260201173633.413934-4-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Sun, 1 Feb 2026 20:36:31 +0300")
References: <20260201173633.413934-1-vsementsov@yandex-team.ru>
 <20260201173633.413934-4-vsementsov@yandex-team.ru>
Date: Wed, 04 Feb 2026 14:11:28 +0100
Message-ID: <87pl6kwt4v.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> Add an option to inject timestamps into serial log file.
> That simplifies debugging a lot, when you can simply compare
> QEMU logs with guest console logs.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

[...]

> diff --git a/qapi/char.json b/qapi/char.json
> index 140614f82c..a4abafa680 100644
> --- a/qapi/char.json
> +++ b/qapi/char.json
> @@ -197,11 +197,15 @@
>  # @logappend: true to append instead of truncate (default to false to
>  #     truncate)
>  #
> +# @logtimestamp: true to insert timestamps into logfile
> +#     (default false) (since 11.0)
> +#
>  # Since: 2.6
>  ##
>  { 'struct': 'ChardevCommon',
>    'data': { '*logfile': 'str',
> -            '*logappend': 'bool' } }
> +            '*logappend': 'bool',
> +            '*logtimestamp': 'bool' } }

We prefer to separate words with hyphens in member names (see
docs/devel/qapi-code-gen.rst), but local consistency trumps that rule.

>  
>  ##
>  # @ChardevFile:

QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>


