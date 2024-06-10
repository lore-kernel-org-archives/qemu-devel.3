Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC1E5C27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 09:15:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGb7b-0001HN-2q; Mon, 10 Jun 2024 05:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sGb7a-0001HF-9W
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 05:15:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sGb7Y-00026d-Jr
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 05:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718010919;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=+Cubc5XGJsqY/wZAaaEif/ckFjT2ThNTOMSN8dszWss=;
 b=UNW/pe9TbNG+1E73WIxQ0K54Tlds1vDvTNwpA82E2ZrtnIyQUEmhqi392b0DrHpAmn0U8Z
 gUduECfizP5mr6hvCRJFK22SBRm5bz4e7w5Nee+3RmTjGm+cyZyZ7v/X2eBmj5Cia3FZVR
 6m6LyA5qPq0Dgmzu3Et+uZoAEm+XZDc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-490-dOErEOf_OyCP4MrFsoXUMw-1; Mon,
 10 Jun 2024 05:15:15 -0400
X-MC-Unique: dOErEOf_OyCP4MrFsoXUMw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E4A4195608E; Mon, 10 Jun 2024 09:15:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.32])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA0611956048; Mon, 10 Jun 2024 09:15:10 +0000 (UTC)
Date: Mon, 10 Jun 2024 10:15:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Don Porter <porter@cs.unc.edu>
Cc: qemu-devel@nongnu.org, dave@treblig.org, peter.maydell@linaro.org,
 nadav.amit@gmail.com, richard.henderson@linaro.org, philmd@linaro.org
Subject: Re: [PATCH v3 3/6] Convert 'info mem' to use generic iterator
Message-ID: <ZmbEG5ThGSmhWGXm@redhat.com>
References: <20240606140253.2277760-1-porter@cs.unc.edu>
 <20240606140253.2277760-4-porter@cs.unc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240606140253.2277760-4-porter@cs.unc.edu>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jun 06, 2024 at 10:02:50AM -0400, Don Porter wrote:
> Signed-off-by: Don Porter <porter@cs.unc.edu>
> ---
>  include/hw/core/sysemu-cpu-ops.h |   6 +
>  include/monitor/monitor.h        |   4 +
>  monitor/hmp-cmds-target.c        |   5 +-
>  target/i386/cpu.c                |   1 +
>  target/i386/cpu.h                |   1 +
>  target/i386/monitor.c            | 354 ++++---------------------------
>  6 files changed, 60 insertions(+), 311 deletions(-)
> 
> diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
> index bf3de3e004..3bef129460 100644
> --- a/include/hw/core/sysemu-cpu-ops.h
> +++ b/include/hw/core/sysemu-cpu-ops.h
> @@ -250,6 +250,12 @@ typedef struct SysemuCPUOps {
>      void (*mon_print_pte) (Monitor *mon, CPUArchState *env, hwaddr addr,
>                             hwaddr pte);
>  
> +    /**
> +     * @mon_print_mem: Hook called by the monitor to print a range
> +     * of memory mappings in 'info mem'
> +     */
> +    bool (*mon_print_mem)(CPUState *cs, struct mem_print_state *state);
> +
Similar to the suggestion on the previus patch. I'd suggest this method
gains a 'GString *str' parameter, which it will print into. Then add
a QMP command that returns HumandReadableText, and call that from the
HMP command. This completely separates the architecture code from the
monitor APIs.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


