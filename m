Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42B0606A32C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 15:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eIDV1cmW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUQYD-0007g8-CQ; Fri, 20 Nov 2026 10:29:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xUQYC-0007fz-KQ
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 10:29:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xUQXz-0002LU-Nz
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 10:29:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795188546;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z1w0cTh7kUatzc4tDKBg4Hnfy6uJLygZprT9oNWEp08=;
 b=eIDV1cmW92wgYb2rFhdpBUbyRilkHULFXrz9mzpu5G9MCvw28yxE1ydO3FrnVDt9lyuEhW
 MPJ2LVd+1VciUBiSUboodAcQok/eB1vfLRHECiR0zu6fSRiFe8fkNlQYG7lgn4BZ2ib+of
 aneG1mJSc2d9vlQwzdCbti9mC7EvLwI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-fg62HMWuMiCbE_Msr-Q1Cw-1; Fri,
 20 Nov 2026 15:29:00 +0000
X-MC-Unique: fg62HMWuMiCbE_Msr-Q1Cw-1
X-Mimecast-MFC-AGG-ID: fg62HMWuMiCbE_Msr-Q1Cw_1795188539
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 907681800617; Fri, 20 Nov 2026 15:28:58 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E91281956088; Fri, 20 Nov 2026 15:28:56 +0000 (UTC)
Date: Fri, 20 Nov 2026 15:28:54 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 04/10] oslib: report kernel stacks in qemu_thread_states()
Message-ID: <awBnNuLoE0MzJsLw@redhat.com>
References: <20260915203455.580999-1-den@openvz.org>
 <20260915203455.580999-5-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260915203455.580999-5-den@openvz.org>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Sep 15, 2026 at 10:34:48PM +0200, Denis V. Lunev wrote:
> From: Denis V. Lunev <den@openvz.org>
> 
> A wait channel names the primitive a thread is parked on but not the
> path that got it there, and for a thread wedged in a syscall that path
> is the answer.
> 
> Read /proc/tid/stack when the report is built, and keep the wait
> channel for when it cannot be. The file is restricted to CAP_SYS_ADMIN
> in the init namespace, so ask once rather than failing per thread, and
> say why the report came back thinner. Skip a running thread, which has
> no settled stack to unwind, and cap the frames, because the deep end of
> a stack is rarely the part that explains the hang.

I'm not convinced that this will be useful in practice. Running
QEMU with CAP_SYS_ADMIN is something that no one should ever do.

IOW, the only scenario in which it is likely is if a developer
is manually running QEMU as root for some debugging purpose,
at which point why not just run under GDB ? 

> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Cc: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>  include/qemu/osdep.h |  4 ++--
>  util/oslib-posix.c   | 52 +++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 51 insertions(+), 5 deletions(-)
> 
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 8039bf91b8..c15ffd7880 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -672,8 +672,8 @@ bool qemu_debugger_attached(void);
>   *
>   * Returns a newly allocated, newline terminated description of every thread
>   * in this process apart from the caller: its id, name, scheduler state and
> - * the wait channel it is parked on, or NULL on a host that cannot report any
> - * of that.
> + * kernel stack, or NULL on a host that cannot report any of that. Where the
> + * kernel stack is privileged the description falls back to a wait channel.
>   */
>  char *qemu_thread_states(void);
>  
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 79887d370c..6a683b849e 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -145,13 +145,39 @@ static char *read_task_file(const char *tid, const char *name)
>      return buf;
>  }
>  
> +#define THREAD_STACK_FRAMES 12
> +
> +/*
> + * /proc/tid/stack is restricted to CAP_SYS_ADMIN in the init namespace, so
> + * ask once instead of failing per thread, and say why the report is thinner.
> + */
> +static bool thread_stacks_readable(void)
> +{
> +    static int readable = -1;
> +    g_autofree char *path = NULL;
> +    g_autofree char *buf = NULL;
> +
> +    if (readable >= 0) {
> +        return readable;
> +    }
> +    path = g_strdup_printf("/proc/self/task/%d/stack", qemu_get_thread_id());
> +    readable = g_file_get_contents(path, &buf, NULL, NULL);
> +    if (!readable) {
> +        warn_report("kernel stacks need CAP_SYS_ADMIN, falling back to wchan");
> +    }
> +    return readable;
> +}
> +
>  static void append_thread_state(GString *out, const char *tid)
>  {
>      g_autofree char *comm = read_task_file(tid, "comm");
>      g_autofree char *stat = NULL;
> +    g_autofree char *stack = NULL;
>      g_autofree char *wchan = NULL;
> +    g_auto(GStrv) lines = NULL;
>      char state = '?';
>      char *rparen;
> +    int i;
>  
>      if (!comm) {
>          return;
> @@ -168,9 +194,26 @@ static void append_thread_state(GString *out, const char *tid)
>      }
>      g_string_append_printf(out, "  %-7s %-16s %c\n", tid, comm, state);
>  
> -    wchan = read_task_file(tid, "wchan");
> -    if (wchan && wchan[0]) {
> -        g_string_append_printf(out, "      wchan %s\n", wchan);
> +    /* A running thread has no settled kernel stack to unwind */
> +    if (state != 'R' && thread_stacks_readable()) {
> +        stack = read_task_file(tid, "stack");
> +    }
> +    if (!stack) {
> +        wchan = read_task_file(tid, "wchan");
> +        if (wchan && wchan[0]) {
> +            g_string_append_printf(out, "      wchan %s\n", wchan);
> +        }
> +        return;
> +    }
> +
> +    lines = g_strsplit(stack, "\n", 0);
> +    for (i = 0; i < THREAD_STACK_FRAMES && lines[i]; i++) {
> +        if (lines[i][0]) {
> +            g_string_append_printf(out, "      %s\n", lines[i]);
> +        }
> +    }
> +    if (lines[i]) {
> +        g_string_append(out, "      ...\n");
>      }
>  }
>  
> @@ -183,6 +226,9 @@ char *qemu_thread_states(void)
>      if (!dir) {
>          return NULL;
>      }
> +    /* Emit the permission notice ahead of the listing, not inside it */
> +    thread_stacks_readable();
> +
>      out = g_string_new(NULL);
>      while ((tid = g_dir_read_name(dir))) {
>          if (atoi(tid) != qemu_get_thread_id()) {
> -- 
> 2.53.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


