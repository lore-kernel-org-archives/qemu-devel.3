Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A63A1CAC595
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 07:15:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqota-0002pq-HY; Wed, 18 Sep 2024 03:14:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sqotY-0002pM-PP
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 03:14:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sqotW-0007Xt-93
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 03:14:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726643672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xZT6FveQrIkwAvvAFpd1siGw/C8+q8D+tHEyzEQZhFc=;
 b=AHv02h/4x5Hi9XEB5CYceSdoEpPOr6ILcxq0Qhlnw+3+B9O+zRyeeqqOdYTr99b3rh/weq
 bL+2vkzV4oOR4e5h0pLDB0DRzvxo7NN6Wd1uvLSx1pI7XJavsoC1c3ly4mkBXZgdFiOmoB
 +fk0NfLsORFfOqjqcqIsjrq0hCizRmI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639--8hEVdhRODqfC74XXxwOUw-1; Wed,
 18 Sep 2024 03:14:31 -0400
X-MC-Unique: -8hEVdhRODqfC74XXxwOUw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB2F71955D4C
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 07:14:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.47])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4EB9C30001A1
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 07:14:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 29D0E21E6A28; Wed, 18 Sep 2024 09:14:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Michal Privoznik <mprivozn@redhat.com>
Cc: qemu-devel@nongnu.org,  kraxel@redhat.com,  marcandre.lureau@redhat.com
Subject: Re: [PATCH] audio/pw: Report more accurate error when connecting to
 PipeWire fails
In-Reply-To: <3fd20aa6948acdff0d17ca56db81f88df51dc960.1726643187.git.mprivozn@redhat.com>
 (Michal Privoznik's message of "Wed, 18 Sep 2024 09:08:18 +0200")
References: <3fd20aa6948acdff0d17ca56db81f88df51dc960.1726643187.git.mprivozn@redhat.com>
Date: Wed, 18 Sep 2024 09:14:27 +0200
Message-ID: <87v7yt1lik.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Michal Privoznik <mprivozn@redhat.com> writes:

> According to its man page [1], pw_context_connect() sets errno on
> failure:
>
>   Returns a Core on success or NULL with errno set on error.
>
> It may be handy to see errno when figuring out why PipeWire
> failed to connect. That leaves us with just one possible path to
> reach 'fail_error' label which is then moved to that path and
> also its error message is adjusted slightly.
>
> 1: https://docs.pipewire.org/group__pw__core.html#ga5994e3a54e4ec718094ca02a1234815b
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
>
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>

Duplicate S-o-b.

> ---
>  audio/pwaudio.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/audio/pwaudio.c b/audio/pwaudio.c
> index 3b14e04fbb..988cd9108e 100644
> --- a/audio/pwaudio.c
> +++ b/audio/pwaudio.c
> @@ -769,13 +769,15 @@ qpw_audio_init(Audiodev *dev, Error **errp)
>      pw->core = pw_context_connect(pw->context, NULL, 0);
>      if (pw->core == NULL) {
>          pw_thread_loop_unlock(pw->thread_loop);
> -        goto fail_error;
> +        error_setg_errno(errp, errno, "Failed to connect to PipeWire instance");
> +        goto fail;
>      }
>  
>      if (pw_core_add_listener(pw->core, &pw->core_listener,
>                               &core_events, pw) < 0) {
>          pw_thread_loop_unlock(pw->thread_loop);
> -        goto fail_error;
> +        error_setg(errp, "Failed to add PipeWite listener");

Typo in PipeWire.

> +        goto fail;
>      }
>      if (wait_resync(pw) < 0) {
>          pw_thread_loop_unlock(pw->thread_loop);
> @@ -785,8 +787,6 @@ qpw_audio_init(Audiodev *dev, Error **errp)
>  
>      return g_steal_pointer(&pw);
>  
> -fail_error:
> -    error_setg(errp, "Failed to initialize PW context");
>  fail:
>      if (pw->thread_loop) {
>          pw_thread_loop_stop(pw->thread_loop);


