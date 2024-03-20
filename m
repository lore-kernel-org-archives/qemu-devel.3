Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2228C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 06:03:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmp2R-00078e-MR; Wed, 20 Mar 2024 02:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rmp2Q-00078V-8O
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 02:02:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rmp2O-0004sm-MH
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 02:02:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710914575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=28pBd+RMF6K0pUYfLahAeinJQgMP9VwJN/XQC/rFAjM=;
 b=GV9msLAdYOpEWtfBUnCn/iy0E55p/BupGhob9/xQ51EKxL35AVmZqWvYzzgM0XC27wD5is
 9ksQjcPoNpEuScgJMTWVrUq5RTs12JZKIfw5+UNWeErM+aq4F5/WJGjVFBZ0AY6qUvkO1k
 ZU/8EXAS8LPIhJhc9m06/Hdjmy+v70U=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-eY1aS5qAMfexX5uqDymBTw-1; Wed,
 20 Mar 2024 02:02:52 -0400
X-MC-Unique: eY1aS5qAMfexX5uqDymBTw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F31703C0245B;
 Wed, 20 Mar 2024 06:02:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ABAEEC04220;
 Wed, 20 Mar 2024 06:02:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AC4A721E6A28; Wed, 20 Mar 2024 07:02:46 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Tao Su <tao1.su@linux.intel.com>
Cc: qemu-devel@nongnu.org,  pbonzini@redhat.com,  xiaoyao.li@intel.com,
 alex.bennee@linaro.org
Subject: Re: [PATCH] target/i386: Check NULL monitor pointer when injecting MCE
In-Reply-To: <20240320052118.520378-1-tao1.su@linux.intel.com> (Tao Su's
 message of "Wed, 20 Mar 2024 13:21:18 +0800")
References: <20240320052118.520378-1-tao1.su@linux.intel.com>
Date: Wed, 20 Mar 2024 07:02:46 +0100
Message-ID: <87le6dwid5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Tao Su <tao1.su@linux.intel.com> writes:

> monitor_puts() doesn't check the monitor pointer, but do_inject_x86_mce()
> may have a parameter with NULL monitor pointer. Check the monitor pointer
> before calling monitor_puts().
>
> Fixes: bf0c50d4aa85 (monitor: expose monitor_puts to rest of code)
> Reviwed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Tao Su <tao1.su@linux.intel.com>
> ---
>  target/i386/helper.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/target/i386/helper.c b/target/i386/helper.c
> index 2070dd0dda..a9ff830a17 100644
> --- a/target/i386/helper.c
> +++ b/target/i386/helper.c
> @@ -430,7 +430,8 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
>          if (need_reset) {
>              emit_guest_memory_failure(MEMORY_FAILURE_ACTION_RESET, ar,
>                                        recursive);
> -            monitor_puts(params->mon, msg);
> +            if (params->mon)
> +                monitor_puts(params->mon, msg);
>              qemu_log_mask(CPU_LOG_RESET, "%s\n", msg);
>              qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
>              return;

Could instead revert the broken part of commit bf0c50d4aa85:

  -            monitor_puts(params->mon, msg);
  +            monitor_printf(params->mon, "%s", msg);
               qemu_log_mask(CPU_LOG_RESET, "%s\n", msg);

Then the fact that we send the same message to monitor and log is again
more obvious.

Either way:
Reviewed-by: Markus Armbruster <armbru@redhat.com>


