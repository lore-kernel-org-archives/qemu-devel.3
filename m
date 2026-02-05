Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB968ECD9A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 20:42:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo6AH-0005t0-3v; Thu, 05 Feb 2026 15:41:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vo6AF-0005rR-TX
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 15:41:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vo6AD-0002G6-Dx
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 15:41:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770324080;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=PVtfVexxdlmo6K6+2WybMfSVFCDQt0lkrZ/XAneZnDs=;
 b=aELsI9Y/lEcNQZhJb0MU0dz25ULng82gnfy48hODEcZtgtNRArXbmF9JxyRVMqvVpyyTNR
 w6NN/sv46IsZX7yukQn5X1shjhHgIg7FSSWeCrCAy2tgivqaQZiuYWYao0GE4SFt46BIHv
 kqbVHGBVV0h1sevr2U/JyfEq8lHBFT4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-SH6ZuUtwMje7qOrqi1xGkg-1; Thu,
 05 Feb 2026 15:41:15 -0500
X-MC-Unique: SH6ZuUtwMje7qOrqi1xGkg-1
X-Mimecast-MFC-AGG-ID: SH6ZuUtwMje7qOrqi1xGkg_1770324067
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D4231955DC1; Thu,  5 Feb 2026 20:41:07 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.12])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 27AB518003F5; Thu,  5 Feb 2026 20:41:02 +0000 (UTC)
Date: Thu, 5 Feb 2026 20:40:59 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 francisco.iglesias@amd.com, Ruslan_Ruslichenko@epam.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: Re: [PATCH 23/29] system: Introduce -sync-quantum command line option
Message-ID: <aYUAWw9Rfuu7KWjA@redhat.com>
References: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
 <20260205195824.2610192-24-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260205195824.2610192-24-ruslichenko.r@gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Feb 05, 2026 at 08:58:18PM +0100, Ruslan Ruslichenko wrote:
> From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
> 
> Add a new global option '-sync-quantum' to specify the maximum time
> interval, in nanoseconds, between synchronizations with remote peers.

Again, we don't really want to introduced new top level command
line options, so try to find an existing place that's suitable
to fit this in, perhaps a prop -machine.

> 
> In co-simulation environments (such as QEMU coupled with a SystemC
> simulator), time must be synchronized periodically to ensure functional
> accuracy. The 'sync-quantum' defines the maximum amount of time QEMU
> can simulate ahead of its remote peers before a mandatory synchronization
> event (sync packet) occurs.
> 
> This value is stored in the global 'global_sync_quantum' variable and
> serves as a default hint for device models and Remote Port instances
> to manage their simulation time.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> Signed-off-by: Takahiro Nakata <takahiro.nakata.wr@renesas.com>
> Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
> ---
>  include/system/system.h |  2 ++
>  qemu-options.hx         | 11 +++++++++++
>  system/vl.c             |  8 ++++++++
>  3 files changed, 21 insertions(+)
> 
> diff --git a/include/system/system.h b/include/system/system.h
> index 0cd012004d..f187544147 100644
> --- a/include/system/system.h
> +++ b/include/system/system.h
> @@ -59,6 +59,8 @@ extern MlockState mlock_state;
>  
>  extern const char *machine_path;
>  
> +extern uint64_t global_sync_quantum;
> +
>  #define MAX_OPTION_ROMS 16
>  typedef struct QEMUOptionRom {
>      const char *name;
> diff --git a/qemu-options.hx b/qemu-options.hx
> index b7dd2a64f0..8ef0c57507 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -765,6 +765,17 @@ SRST
>      Preallocate memory when using -mem-path.
>  ERST
>  
> +DEF("sync-quantum", HAS_ARG, QEMU_OPTION_sync_quantum,
> +    "-sync-quantum Max time between synchroniation, nanoseconds.\n",
> +    QEMU_ARCH_ALL)
> +SRST
> +``-sync-quantum val``
> +    Maximum time between synchronization <val>.
> +    This value is used to drive periodic synchronization with remote port peers.
> +    It is also used to set device models sync-quantum properties controlling
> +    the maximum amount of ahead of time simulation that is prefered (only a hint).
> +ERST
> +
>  DEF("machine-path", HAS_ARG, QEMU_OPTION_machine_path,
>      "-machine-path DIR A directory in which to create machine nodes\n",
>      QEMU_ARCH_ALL)
> diff --git a/system/vl.c b/system/vl.c
> index 4750b1cf69..467646c3ff 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -182,6 +182,7 @@ static QemuPluginList plugin_list = QTAILQ_HEAD_INITIALIZER(plugin_list);
>  static BlockdevOptionsQueue bdo_queue = QSIMPLEQ_HEAD_INITIALIZER(bdo_queue);
>  static bool nographic = false;
>  static int mem_prealloc; /* force preallocation of physical target memory */
> +uint64_t global_sync_quantum;
>  const char *machine_path;
>  static const char *vga_model = NULL;
>  static DisplayOptions dpy;
> @@ -3129,6 +3130,13 @@ void qemu_init(int argc, char **argv)
>              case QEMU_OPTION_mem_prealloc:
>                  mem_prealloc = 1;
>                  break;
> +            case QEMU_OPTION_sync_quantum:
> +                if (qemu_strtou64(optarg, &optarg, 10,
> +                                  &global_sync_quantum)) {
> +                    error_report("failed to parse sync_quantum");
> +                    exit(1);
> +                }
> +                break;
>              case QEMU_OPTION_machine_path:
>                  machine_path = optarg;
>                  break;
> -- 
> 2.43.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


