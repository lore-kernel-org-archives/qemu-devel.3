Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A46EC982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 14:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x91rz-0006Zz-WD; Tue, 22 Sep 2026 10:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x91ru-0006ZS-OP
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 10:53:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x91rt-0007QX-6v
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 10:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790088791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GRgY7b85SMA2xtvaORMx+VgkTHClIbLwwCIZxZkir1c=;
 b=eItmFRO1UnXB6Txg2ES6AxLjhwZ2hhQGpIrrznnakfkvii/Ox6O55DI6c+o4x51gMEVMl8
 S/viR2bQ/BHHtN33M0h/pN4u83AYYBxH/MmvLJ38DVkTPwvQ/tAjjXdNJ1XrGCi36jyjhA
 JdWex/9A2QYvyjrlIVJBhNzFJykY9lQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-274--H4qSRQKMvGzCIYTkHhiCw-1; Tue,
 22 Sep 2026 10:53:09 -0400
X-MC-Unique: -H4qSRQKMvGzCIYTkHhiCw-1
X-Mimecast-MFC-AGG-ID: -H4qSRQKMvGzCIYTkHhiCw_1790088787
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6977B195C244; Tue, 22 Sep 2026 14:53:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82F79180034C; Tue, 22 Sep 2026 14:53:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3084E21E6A04; Tue, 22 Sep 2026 16:53:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Kashyap Chamarthy
 <kchamart@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,  Michael Tokarev <mjt@tls.msk.ru>,  Hanna
 Reitz <hreitz@redhat.com>,  Stefano Garzarella <sgarzare@redhat.com>,
 Jason Wang <jasowangio@gmail.com>,  Zhao Liu <zhao1.liu@intel.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Da?=
 =?utf-8?Q?ud=C3=A9?= <philmd@oss.qualcomm.com>,  qemu-block@nongnu.org,
 qemu-trivial@nongnu.org,  Laurent Vivier <laurent@vivier.eu>,  Eric Blake
 <eblake@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,  Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH 5/9] qapi: split intros at natural cutoff points for
 qga/qapi-schema.json
In-Reply-To: <20260921205147.1857168-6-jsnow@redhat.com> (John Snow's message
 of "Mon, 21 Sep 2026 16:51:43 -0400")
References: <20260921205147.1857168-1-jsnow@redhat.com>
 <20260921205147.1857168-6-jsnow@redhat.com>
Date: Tue, 22 Sep 2026 16:53:02 +0200
Message-ID: <87a4p949td.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

John Snow <jsnow@redhat.com> writes:

> Note that these intro conversions introduce a new intro/details split
> point. This new split point may or may not change the rendered output
> depending on if any documentation is generated for this definition.

Uh, we generate documentation for *all* definitions.

>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qga/qapi-schema.json | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index b592b14a011..19b0958b84e 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -401,8 +401,7 @@
>  
>  ##
>  # @guest-fsfreeze-status:
> -#
> -# Get guest fsfreeze state.
> +#     Get guest fsfreeze state.
>  #
>  # .. note:: This may fail to properly report the current state as a
>  #    result of some other guest processes having issued an fs

This one does affect rendered docs: the auto-generated Returns moves
from below the note to above, where it belongs.

> @@ -925,9 +924,8 @@
>  
>  ##
>  # @GuestNVMeSmart:
> -#
> -# NVMe smart information, based on NVMe specification, section
> -# <SMART / Health Information (Log Identifier 02h)>
> +#     NVMe smart information, based on NVMe specification, section
> +#     <SMART / Health Information (Log Identifier 02h)>
>  #
>  # TODO: document members briefly
>  #
> @@ -1816,8 +1814,7 @@
>  
>  ##
>  # @guest-get-load:
> -#
> -# Retrieve CPU process load information
> +#     Retrieve CPU process load information
>  #
>  # .. note:: Windows does not have load average API, so QGA emulates it
>  #    by calculating the average CPU usage in the last 1, 5, 15 minutes

These don't.

A possible commit message correction:

  Note that these intro conversions introduce a new intro/details split
  point. Only the first one affects the rendered output.


