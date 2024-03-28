Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC20C54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 09:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpm0F-0001Dl-95; Thu, 28 Mar 2024 05:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rpm0D-0001D7-Rj
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 05:24:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rpm0B-0004xe-Sh
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 05:24:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711617890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A/M1Q/tNX7SA6NOz8Cj4KMwen9KBkjX7STaFPxtYC4Y=;
 b=hZqCBexMQTqik+8+dk8BmM9JH7jAFvRcdV2nYDx7QB31xTkDFuRGQaetK1BYZP74AHQl/Q
 NUNxpS/sKkmO0y41fNJXM31IkY+JpOqVK5dv1rPFVeK7xZtm9I+jIb2FuyhZTuKH0AcBF/
 5vSoHppi1kCP7vu5iSpCSE7DpkiePLs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-cphmLjaPPI6M6LlnO38lzA-1; Thu, 28 Mar 2024 05:24:46 -0400
X-MC-Unique: cphmLjaPPI6M6LlnO38lzA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CAB47101A523;
 Thu, 28 Mar 2024 09:24:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A9B321C060D0;
 Thu, 28 Mar 2024 09:24:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AAA1C21E680D; Thu, 28 Mar 2024 10:24:40 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org,  qemu-devel@nongnu.org,  jsnow@redhat.com,
 kwolf@redhat.com,  hreitz@redhat.com,  devel@lists.libvirt.org,
 eblake@redhat.com,  michael.roth@amd.com,  pbonzini@redhat.com,
 pkrempa@redhat.com,  f.ebner@proxmox.com
Subject: Re: [RFC 04/15] qapi: block-job-change: make copy-mode parameter
 optional
In-Reply-To: <20240313150907.623462-5-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 13 Mar 2024 18:08:56 +0300")
References: <20240313150907.623462-1-vsementsov@yandex-team.ru>
 <20240313150907.623462-5-vsementsov@yandex-team.ru>
Date: Thu, 28 Mar 2024 10:24:40 +0100
Message-ID: <878r22emjr.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> We are going to add more parameters to change. We want to make possible
> to change only one or any subset of available options. So all the
> options should be optional.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  block/mirror.c       | 5 +++++
>  qapi/block-core.json | 2 +-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/block/mirror.c b/block/mirror.c
> index a177502e4f..2d0cd22c06 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -1265,6 +1265,11 @@ static void mirror_change(BlockJob *job, JobChangeOptions *opts,
>  
>      GLOBAL_STATE_CODE();
>  
> +    if (!change_opts->has_copy_mode) {
> +        /* Nothing to do */

I doubt the comment is useful.

> +        return;
> +    }
> +
>      if (qatomic_read(&s->copy_mode) == change_opts->copy_mode) {
>          return;
>      }

       if (change_opts->copy_mode != MIRROR_COPY_MODE_WRITE_BLOCKING) {
           error_setg(errp, "Change to copy mode '%s' is not implemented",
                      MirrorCopyMode_str(change_opts->copy_mode));
           return;
       }

       current = qatomic_cmpxchg(&s->copy_mode, MIRROR_COPY_MODE_BACKGROUND,
                                 change_opts->copy_mode);
       if (current != MIRROR_COPY_MODE_BACKGROUND) {
           error_setg(errp, "Expected current copy mode '%s', got '%s'",
                      MirrorCopyMode_str(MIRROR_COPY_MODE_BACKGROUND),
                      MirrorCopyMode_str(current));
       }

Now I'm curious: what could be changing @copy_mode behind our backs
here?

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 67dd0ef038..6041e7bd8f 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3071,7 +3071,7 @@
   ##
   # @BlockJobChangeOptionsMirror:
   #
   # @copy-mode: Switch to this copy mode.  Currently, only the switch
   #     from 'background' to 'write-blocking' is implemented.
   #
>  # Since: 8.2
>  ##
>  { 'struct': 'JobChangeOptionsMirror',
> -  'data': { 'copy-mode' : 'MirrorCopyMode' } }
> +  'data': { '*copy-mode' : 'MirrorCopyMode' } }
>  
>  ##
>  # @JobChangeOptions:

A member becoming optional is backward compatible.  Okay.

We may want to document "(optional since 9.1)".  We haven't done so in
the past.

The doc comment needs to spell out how absent members are handled.


