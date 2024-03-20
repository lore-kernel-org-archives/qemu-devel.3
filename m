Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A03A5C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 13:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmvat-0001eO-0E; Wed, 20 Mar 2024 09:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmvaq-0001dk-Lj
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 09:02:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmvao-000568-NA
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 09:02:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710939773;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=7H00VayKjXaxeNawqzhjlTJZAUY7CQZcUm2+gmbe7rk=;
 b=RtezqyAcacfhi4C5omomgnKt2f4gyhBaisK4k+T18zFziILZO/4OD3OGXzBR3FcJMcdxXJ
 EWQh6zd/AAdQRBE7NvTYRi8DaR+G+T78YC1f6szRioXqsfxhtcDcswiB68jTpUzCnCbLNw
 HfquATcqBBcczojQWFxmctuLsQuXdZg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300--6tq72-LOeqUgEawiD3v1w-1; Wed, 20 Mar 2024 09:02:47 -0400
X-MC-Unique: -6tq72-LOeqUgEawiD3v1w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 044A8800268;
 Wed, 20 Mar 2024 13:02:47 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.205])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E8560112132A;
 Wed, 20 Mar 2024 13:02:45 +0000 (UTC)
Date: Wed, 20 Mar 2024 13:02:39 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Tao Su <tao1.su@linux.intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, xiaoyao.li@intel.com,
 alex.bennee@linaro.org, armbru@redhat.com, philmd@linaro.org
Subject: Re: [PATCH v2] target/i386: Revert monitor_puts() in
 do_inject_x86_mce()
Message-ID: <Zfreb8-swnvSOMhx@redhat.com>
References: <20240320083640.523287-1-tao1.su@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240320083640.523287-1-tao1.su@linux.intel.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Mar 20, 2024 at 04:36:40PM +0800, Tao Su wrote:
> monitor_puts() doesn't check the monitor pointer, but do_inject_x86_mce()
> may have a parameter with NULL monitor pointer. Revert monitor_puts() in
> do_inject_x86_mce() to fix, then the fact that we send the same message to
> monitor and log is again more obvious.

Yikes, why do we have such a horrible trap-door in our
monitor output APIs.

Isn't the right fix here to make 'monitor_puts' check for
NULL & be a no-op, in the same way 'monitor_printf' does,
so the APIs have consistent behaviour.

> 
> Fixes: bf0c50d4aa85 (monitor: expose monitor_puts to rest of code)
> Reviwed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Tao Su <tao1.su@linux.intel.com>
> ---
> v1 -> v2:
> - Instead revert the broken part of commit bf0c50d4aa85
> - Add Markus's Reviewed-by
> 
> v1:
> - https://lore.kernel.org/all/20240320052118.520378-1-tao1.su@linux.intel.com/
> ---
>  target/i386/helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/helper.c b/target/i386/helper.c
> index 2070dd0dda..23ccb23a5b 100644
> --- a/target/i386/helper.c
> +++ b/target/i386/helper.c
> @@ -430,7 +430,7 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
>          if (need_reset) {
>              emit_guest_memory_failure(MEMORY_FAILURE_ACTION_RESET, ar,
>                                        recursive);
> -            monitor_puts(params->mon, msg);
> +            monitor_printf(params->mon, "%s", msg);
>              qemu_log_mask(CPU_LOG_RESET, "%s\n", msg);
>              qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
>              return;
> 
> base-commit: c62d54d0a8067ffb3d5b909276f7296d7df33fa7
> -- 
> 2.34.1
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


