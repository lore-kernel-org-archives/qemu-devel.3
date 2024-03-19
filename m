Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 858B8C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 14:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmaGW-0002Qk-Pu; Tue, 19 Mar 2024 10:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmaGM-0002Py-ML
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:16:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmaGL-0003Zb-0d
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710857780;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=BB6KXKeRy6uwGzGwxzxZd3SldYiDoDwzvLmFdjU0g7I=;
 b=SjEnA6j9LF6Zv+2AXbwG6tlkr7+S996cRaeXowLXh8WOCA6eiVGJSvIbwbtQ1QPUBdJ6ro
 ZN6pvwYuUi4Ta1HV9ybnzH035T6+W4d9OpNFJ2hG0abKQvnlYwVcegf3zgqxssA/Z9lrZD
 U/519ry+2YmvXihbbVq/wWGbOZ+0hsQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-CQOfO2K-Ow-kVPP8AYasOw-1; Tue, 19 Mar 2024 10:16:18 -0400
X-MC-Unique: CQOfO2K-Ow-kVPP8AYasOw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ABDFD88FC85;
 Tue, 19 Mar 2024 14:16:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ED247492C2D;
 Tue, 19 Mar 2024 14:16:12 +0000 (UTC)
Date: Tue, 19 Mar 2024 14:16:07 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, xiaoyao.li@intel.com, michael.roth@amd.com
Subject: Re: [PATCH 2/7] runstate: skip initial CPU reset if reset is not
 actually possible
Message-ID: <ZfmeJ9c_TMSb12Z1@redhat.com>
References: <20240319140000.1014247-1-pbonzini@redhat.com>
 <20240319140000.1014247-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240319140000.1014247-3-pbonzini@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
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

On Tue, Mar 19, 2024 at 02:59:55PM +0100, Paolo Bonzini wrote:
> Right now, the system reset is concluded by a call to
> cpu_synchronize_all_post_reset() in order to sync any changes
> that the machine reset callback applied to the CPU state.
> 
> However, for VMs with encrypted state such as SEV-ES guests (currently
> the only case of guests with non-resettable CPUs) this cannot be done,
> because guest state has already been finalized by machine-init-done notifiers.
> cpu_synchronize_all_post_reset() does nothing on these guests, and actually
> we would like to make it fail if called once guest has been encrypted.
> So, assume that boards that support non-resettable CPUs do not touch
> CPU state and that all such setup is done before, at the time of
> cpu_synchronize_all_post_init().
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  system/runstate.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/system/runstate.c b/system/runstate.c
> index d6ab860ecaa..843e2b9853d 100644
> --- a/system/runstate.c
> +++ b/system/runstate.c
> @@ -501,7 +501,20 @@ void qemu_system_reset(ShutdownCause reason)
>      default:
>          qapi_event_send_reset(shutdown_caused_by_guest(reason), reason);
>      }
> -    cpu_synchronize_all_post_reset();
> +
> +    /*
> +     * Some boards us the machine reset callback to point CPUs to the firmware

ITYM s/us/use/

> +     * entry point.  Assume that this is not the case for boards that support
> +     * non-resettable CPUs (currently used only for confidential guests), in
> +     * which case cpu_synchronize_all_post_init() is enough because
> +     * it does _more_  than cpu_synchronize_all_post_reset().
> +     */
> +    if (cpus_are_resettable()) {
> +        cpu_synchronize_all_post_reset();
> +    } else {
> +        assert(runstate_check(RUN_STATE_PRELAUNCH));
> +    }
> +
>      vm_set_suspended(false);
>  }
>  
> -- 
> 2.44.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


