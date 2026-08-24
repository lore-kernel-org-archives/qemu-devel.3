Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA4EC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 14:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyVOS-0004jq-5r; Mon, 24 Aug 2026 10:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wyVOQ-0004jW-9f
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 10:11:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wyVOO-0005Cl-6K
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 10:11:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787580675;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7+29W/EbgAFyoJ1/UIG4RJKBj3qpFCY1W8KixD+XNhw=;
 b=bJiLFmlMEBk5ldVh1nWV83HSHqRC/Y5oWROZreV0g8SZv5OftZeBWYiiFeZAWamsJ0tgeG
 +NNK9dnAOmvcSBdrTK9O4zuB673YOvH+ysgfKpFCahnBEfuRGjhkMtbXP3/M062rpY3v9C
 hoRcwzpnQSsp8N6GIlaHZzXc3awNGu4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-9P8P1CEZMmuhy3wswUzFiw-1; Mon,
 24 Aug 2026 10:11:13 -0400
X-MC-Unique: 9P8P1CEZMmuhy3wswUzFiw-1
X-Mimecast-MFC-AGG-ID: 9P8P1CEZMmuhy3wswUzFiw_1787580672
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E35B818600D3; Mon, 24 Aug 2026 14:11:11 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 408C030002EA; Mon, 24 Aug 2026 14:11:10 +0000 (UTC)
Date: Mon, 24 Aug 2026 15:11:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v3 34/49] qemu-print: switch to use monitor_cur_hmp()
Message-ID: <aoxQ--22A82pLhIf@redhat.com>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
 <20260816-qemu-no-hmp-v3-34-e53fc35bc550@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260816-qemu-no-hmp-v3-34-e53fc35bc550@redhat.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, Aug 16, 2026 at 11:13:01PM +0400, Marc-André Lureau wrote:
> Note that this fixes qemu_vprintf() (and thus qemu_printf) to do as said
> in the code comment: print to current HMP if we have one, else to
> stdout, instead of trying to print to the current monitor (which may not
> actually have hmp-only print capability/callback and fail silently).

The question is whether that commented behaviour is actually
what we want ? AFAICT, the comment has been wrong since day
one - it always printed to HMP, and /dev/nulled for QMP,
and stdout thus only in non-monitor context.

I'm not convinced that qemu_printf family should do anything
in QMP context - /dev/null feels like the right behaviour.

We have warn_report/error_report which go to stderr in QMP
context which is right.  I don't see a use case for
qemu_printf to stderr in QMP context.

> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  util/qemu-print.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/util/qemu-print.c b/util/qemu-print.c
> index a2d1f0244168..0eecc05b0330 100644
> --- a/util/qemu-print.c
> +++ b/util/qemu-print.c
> @@ -21,9 +21,9 @@
>   */
>  int qemu_vprintf(const char *fmt, va_list ap)
>  {
> -    Monitor *cur_mon = monitor_cur();
> -    if (cur_mon) {
> -        return monitor_vprintf(cur_mon, fmt, ap);
> +    MonitorHMP *hmp = monitor_cur_hmp();
> +    if (hmp) {
> +        return monitor_vprintf(MONITOR(hmp), fmt, ap);
>      }
>      return vprintf(fmt, ap);
>  }
> @@ -53,7 +53,8 @@ int qemu_printf(const char *fmt, ...)
>  int qemu_vfprintf(FILE *stream, const char *fmt, va_list ap)
>  {
>      if (!stream) {
> -        return monitor_vprintf(monitor_cur(), fmt, ap);
> +        MonitorHMP *hmp = monitor_cur_hmp();
> +        return hmp ? monitor_vprintf(MONITOR(hmp), fmt, ap) : -1;
>      }
>      return vfprintf(stream, fmt, ap);
>  }
> 
> -- 
> 2.55.0.543.g5ebe2ebe4ea8
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


