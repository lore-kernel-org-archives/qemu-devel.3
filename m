Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760C1CA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 11:01:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEPOE-0000gN-1c; Wed, 07 Oct 2026 07:00:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xEPOA-0000dH-Bf
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 07:00:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xEPO7-0001gj-NF
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 07:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791370841;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ne9+pahuFHq5YTDYEIRYP/+u9UQG+XNxluMpTQ3NQh4=;
 b=VgBw5ah4xcGEgsj81Kjqe1k3jLJ6agzlFtgyRts1mlaEdhdmNBZR613Qx4b24XHuo+lSN8
 mYparSmFShDnrAoPb+FATUnBgMztqCSUPnIewtkqALGPn8zx4Kc7T7jIjAhR33657rhsQS
 5ZZJb7E24gpCDRcV5oNBq3JUD4PCBYk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-AUyowbpkNNOS7pQm8it-Lg-1; Wed,
 07 Oct 2026 07:00:40 -0400
X-MC-Unique: AUyowbpkNNOS7pQm8it-Lg-1
X-Mimecast-MFC-AGG-ID: AUyowbpkNNOS7pQm8it-Lg_1791370839
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 355DB191320E; Wed,  7 Oct 2026 11:00:39 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D2C3630002D6; Wed,  7 Oct 2026 11:00:37 +0000 (UTC)
Date: Wed, 7 Oct 2026 12:00:35 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 01/27] cpus: Add helper to log raised exceptions with '-d
 int'
Message-ID: <asYmU2H_J225oU2s@redhat.com>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
 <20261007094516.75732-2-philmd@oss.qualcomm.com>
 <7437c9ee-d1f5-452a-a456-d1dd7e1d268d@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7437c9ee-d1f5-452a-a456-d1dd7e1d268d@oss.qualcomm.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Oct 07, 2026 at 12:47:24PM +0200, Philippe Mathieu-Daudé wrote:
> On 7/10/26 11:44, Philippe Mathieu-DaudÃ© wrote:
> > Add log_raise_exception(), a common helper cpu_loop_*() can
> > call to log a raised exception when '-d int' is used, and
> > qemu_excp_name() to resolve QEMU-internal exceptions to names.
> > 
> > Use it in cpu_loop_exit_atomic() to log the EXCP_ATOMIC reason.
> > 
> > Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> > ---
> >   accel/tcg/cpu-exec-common.c | 32 ++++++++++++++++++++++++++++++++
> >   1 file changed, 32 insertions(+)
> > 
> > diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
> > index 68077c8fd9d..2ac8380d0bb 100644
> > --- a/accel/tcg/cpu-exec-common.c
> > +++ b/accel/tcg/cpu-exec-common.c
> > @@ -89,6 +89,37 @@ void tcg_update_all_cflags(void)
> >       }
> >   }
> > +#define EXCP_QEMU_INTERNAL 0x10000
> > +
> > +static const char *qemu_excp_name(int excp)
> > +{
> > +    static const char *excp_name[] = {
> > +        [EXCP_INTERRUPT - EXCP_QEMU_INTERNAL] = "async interruption",
> > +        [EXCP_HLT       - EXCP_QEMU_INTERNAL] = "hlt instruction",
> > +        [EXCP_DEBUG     - EXCP_QEMU_INTERNAL] = "debug",
> > +        [EXCP_HALTED    - EXCP_QEMU_INTERNAL] = "halted",
> > +        [EXCP_YIELD     - EXCP_QEMU_INTERNAL] = "yield",
> > +        [EXCP_ATOMIC    - EXCP_QEMU_INTERNAL] = "emulate atomic",
> > +    };
> > +    assert(excp >= EXCP_QEMU_INTERNAL);
> > +    excp -= EXCP_QEMU_INTERNAL;
> > +    if ((excp < ARRAY_SIZE(excp_name)) && excp_name[excp]) {
> > +        return excp_name[excp];
> > +    }
> > +    return "undocumented";
> > +}
> > +
> > +static void log_raise_exception(const CPUState *cpu, int excp)
> > +{
> > +    if (!qemu_loglevel_mask(CPU_LOG_INT)) {
> > +        return;
> > +    }
> > +    if (excp >= EXCP_QEMU_INTERNAL) {
> > +        qemu_log_mask(CPU_LOG_INT, "raise exception: 0x%x (internal: %s)\n",
> > +                                   excp, qemu_excp_name(excp));
> 
> Daniel suggested on IRC we can use target_name() here to distinguish
> between different kinds of vCPUs. Alternatively we can add a
> CPUClass::log_friendly_format_name() defaulting to current "%p index:%d"
> but overwritable i.e. as "accel:%s target:%s cluster:%d index:%u", so
> each time we log something on a vCPU context we have an unified prefix
> format to parse.

That would be problematic. Those two different format strings have
different args. Also since it is not a static string, it can't be
concatenated with the format strnig being passed to qemu_log_mask().
So that would imply sprintf'ing the CPU format string prefix first
with whatever args it needs, before passing the result into the
qemu_log_mask() call.

     g_autofree char *prefix = g_strdup_printf(
         "accel:%s target:%s cluster:%d index:%u",
	 accel, targe,t cluster, index);
     cpu_log_mask(CPU_LOG_INT,
                  "%s raise exception: 0x%x (internal: %s)\n",
                  prefix, excp, qemu_excp_name(excp));

the double layers of printf makes logging quite unpleasant,
and while it could be hidden in a macro, the runtime overhead
still exists.

On IRC, I suggested an approach that would work at the preprocessor
level to concatenate the arch target name at compile time on to the
front of all log messages, so there is no runtime impact at all,
nor any code impact beyond s/qemu_log_mask/qemu_log_mask_target/.

#define  qemu_log_mask_target(MASK, FMT, ...)           \
    do {                                                \
        if (unlikely(qemu_loglevel_mask(MASK))) {       \
          qemu_log(TARGET_NAME # FMT, ## __VA_ARGS__);\
         }                                               \
    } while (0)

Note, TARGE_NAME is poisoned, so we can't add this to to main
include/qemu/log.h file. It would need to live in a header file
that is built per-target, and thus only used from target specific
code like the TCG impls. 

As a slight variation, *if* we can assume each target arch's VCPUs
are in a separate thread, we could avoid using TARGET_NAME directly
and instead use a thread local

  __thread const char *target_name;

...which would be initialized to TARGET_NAME when the vcpu's thread
starts.

Then  we would change the macro to be 

#define  qemu_log_mask_target(MASK, FMT, ...)           \
    do {                                                \
        if (unlikely(qemu_loglevel_mask(MASK))) {       \
          qemu_log("%s" # FMT, target_name, ## __VA_ARGS__);\
         }                                               \
    } while (0)

That would make it possible to include more dynamic information
by adding more thread-locals and hiding more fmt args in the
macro.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


