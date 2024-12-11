Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54DC4E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 21:53:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLUdR-0006UC-0G; Wed, 11 Dec 2024 16:52:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLUdP-0006U3-M4
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 16:52:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLUdN-000842-DU
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 16:52:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733953957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8SiWBW9s3Ny/vPz46WsUkjPV+U8HPBe9k0tYULakYOQ=;
 b=PBZ1+I7it7UkfRR9ydVtzJ6IywG9nkyFv0Xx6blHywMJowAdxTsdGxkxZOEO8k8HhXKpy4
 xAv20VaxWLGoWLjirhjNwHmJUVRtohiARaPlRrGxXatDB8dwLw7C3uCqq4cL0FVpgTZwRG
 hYzhIvBweHJgfm6226RaMmg6YgTYy5I=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-QB980wKRNQWCFrRvUv-kTQ-1; Wed, 11 Dec 2024 16:52:36 -0500
X-MC-Unique: QB980wKRNQWCFrRvUv-kTQ-1
X-Mimecast-MFC-AGG-ID: QB980wKRNQWCFrRvUv-kTQ
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6d8edb40083so22450486d6.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 13:52:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733953956; x=1734558756;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8SiWBW9s3Ny/vPz46WsUkjPV+U8HPBe9k0tYULakYOQ=;
 b=vSabPOWzTXw4EkGFY60FAIK1NQN8Ie3IIFF0JxZa6Tm9yW8jxP8VkNOXuGmmt3HUR4
 h1lwQV711yIOftpxWy+fYHTg8T5eRRjAEw+esixpCcCy9GXgrzJO4dmmruoOmfor1CoY
 CRInKh5T8/CZkgeV2Hn1EmCfMjlPBYjfg8k70WTmcRbAeTEW2H5qqnJLBv1C9R+NxcIM
 L10lCIunpLffK21NLgRknHBarT61QwyvwRf5YKwz/ynR+TS5Yr7Lllz/ACLxYoeWPIqo
 XoSDxN74CXNWx+xO/8WYH4Q6cgYvCef+1xGloQTTuZZ8MltDKGevS1tObVbtte0ez9jl
 0euQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpDMnna3BD990VIdDVJkAdmU+C50fhJdFpZWr/rAf0mfvLeIWhF1PTimbeRYIOQ7OM6Cbxbz+S2tTY@nongnu.org
X-Gm-Message-State: AOJu0YxiEYvPW29BZHQY3WTsQuFcfsV+kdU2ZB+C/QTPVV5oM1NxTaLv
 0yS02rC35BA3wr3MnVEB2os47BlWgF7iCFyxK2QJ0HjDn2Gq172EtoPKetq622ZQHHJnwFEJJpr
 R9FW2Hq19K5VzcItociJ+EdrPd1PRGFE/hLdWBjYeD+qFjDfpdyAZ
X-Gm-Gg: ASbGncsWLTDmN/zMuzpGNmsoMN2plwoJhrqkuurYDNchdi9ahvJX6VyTX7fJKtLeQbK
 kqYNlFX2ckQT1EH6LBPEddzlp6jyX6vqJYZEYtvV796Sb5URfLcnzNmj9/SITYXnM1cAPzXy1gx
 Z4LHGOVhNvB8UICrvZ1F/VVVer2w4nGzpPlGLpz/2tuDKeeZrZxuOoWYLEBtBCstuy51ltEKP5O
 lG/AL7ULZUREx67n60yc+QIzLwffQld3j5sTT64ztUVJ/WlLMgv0r8kZ0F+mnNl7maJcMvxBizl
 K9MhKZFSiEd7MUA=
X-Received: by 2002:ad4:5aee:0:b0:6d8:88c2:af5f with SMTP id
 6a1803df08f44-6dae3b0a5demr17593806d6.1.1733953955951; 
 Wed, 11 Dec 2024 13:52:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtzbkjHKgCCFS8ZdYUM+9QF3w57aAoVtRoya7w2S/b0q+vF7ni51+DDiwZNe0f1X0zbK4v1w==
X-Received: by 2002:ad4:5aee:0:b0:6d8:88c2:af5f with SMTP id
 6a1803df08f44-6dae3b0a5demr17593486d6.1.1733953955623; 
 Wed, 11 Dec 2024 13:52:35 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da696b8csm74823546d6.28.2024.12.11.13.52.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 13:52:34 -0800 (PST)
Date: Wed, 11 Dec 2024 16:52:32 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 2/2] overcommit: introduce mem-lock=on-fault
Message-ID: <Z1oJoIa_JGc6WgC9@x1n>
References: <20241211000447.1310181-1-d-tatianin@yandex-team.ru>
 <20241211000447.1310181-3-d-tatianin@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241211000447.1310181-3-d-tatianin@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Dec 11, 2024 at 03:04:47AM +0300, Daniil Tatianin wrote:
> Locking the memory without MCL_ONFAULT instantly prefaults any mmaped
> anonymous memory with a write-fault, which introduces a lot of extra
> overhead in terms of memory usage when all you want to do is to prevent
> kcompactd from migrating and compacting QEMU pages. Add an option to
> only lock pages lazily as they're faulted by the process by using
> MCL_ONFAULT if asked.

Looks good but some nitpicks below..

> 
> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> ---
>  include/sysemu/sysemu.h  |  1 +
>  migration/postcopy-ram.c |  4 ++--
>  qemu-options.hx          | 14 +++++++-----
>  system/globals.c         |  1 +
>  system/vl.c              | 46 ++++++++++++++++++++++++++++++++--------
>  5 files changed, 50 insertions(+), 16 deletions(-)
> 
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 7ec419ce13..b6519c3c1e 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -44,6 +44,7 @@ extern const char *keyboard_layout;
>  extern int old_param;
>  extern uint8_t *boot_splash_filedata;
>  extern bool enable_mlock;
> +extern bool enable_mlock_onfault;
>  extern bool enable_cpu_pm;
>  extern QEMUClockType rtc_clock;
>  
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 36ec6a3d75..8ff8c73a27 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -651,8 +651,8 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
>          mis->have_fault_thread = false;
>      }
>  
> -    if (enable_mlock) {
> -        if (os_mlock(false) < 0) {
> +    if (enable_mlock || enable_mlock_onfault) {
> +        if (os_mlock(enable_mlock_onfault) < 0) {
>              error_report("mlock: %s", strerror(errno));
>              /*
>               * It doesn't feel right to fail at this point, we have a valid
> diff --git a/qemu-options.hx b/qemu-options.hx
> index dacc9790a4..6c8360e62e 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4566,21 +4566,25 @@ SRST
>  ERST
>  
>  DEF("overcommit", HAS_ARG, QEMU_OPTION_overcommit,
> -    "-overcommit [mem-lock=on|off][cpu-pm=on|off]\n"
> +    "-overcommit [mem-lock=on|off|on-fault][cpu-pm=on|off]\n"
>      "                run qemu with overcommit hints\n"
> -    "                mem-lock=on|off controls memory lock support (default: off)\n"
> +    "                mem-lock=on|off|on-fault controls memory lock support (default: off)\n"
>      "                cpu-pm=on|off controls cpu power management (default: off)\n",
>      QEMU_ARCH_ALL)
>  SRST
> -``-overcommit mem-lock=on|off``
> +``-overcommit mem-lock=on|off|on-fault``
>    \ 
>  ``-overcommit cpu-pm=on|off``
>      Run qemu with hints about host resource overcommit. The default is
>      to assume that host overcommits all resources.
>  
>      Locking qemu and guest memory can be enabled via ``mem-lock=on``
> -    (disabled by default). This works when host memory is not
> -    overcommitted and reduces the worst-case latency for guest.
> +    or ``mem-lock=on-fault`` (disabled by default). This works when
> +    host memory is not overcommitted and reduces the worst-case latency for
> +    guest. The on-fault option is better for reducing the memory footprint
> +    since it makes allocations lazy, but the pages still get locked in place
> +    once faulted by the guest or QEMU. Note that the two options are mutually
> +    exclusive.
>  
>      Guest ability to manage power state of host cpus (increasing latency
>      for other processes on the same host cpu, but decreasing latency for
> diff --git a/system/globals.c b/system/globals.c
> index 84ce943ac9..43501fe690 100644
> --- a/system/globals.c
> +++ b/system/globals.c
> @@ -35,6 +35,7 @@ enum vga_retrace_method vga_retrace_method = VGA_RETRACE_DUMB;
>  int display_opengl;
>  const char* keyboard_layout;
>  bool enable_mlock;
> +bool enable_mlock_onfault;
>  bool enable_cpu_pm;
>  int autostart = 1;
>  int vga_interface_type = VGA_NONE;
> diff --git a/system/vl.c b/system/vl.c
> index 03819a80ef..4e2efd3ad4 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -347,7 +347,7 @@ static QemuOptsList qemu_overcommit_opts = {
>      .desc = {
>          {
>              .name = "mem-lock",
> -            .type = QEMU_OPT_BOOL,
> +            .type = QEMU_OPT_STRING,
>          },
>          {
>              .name = "cpu-pm",
> @@ -792,8 +792,8 @@ static QemuOptsList qemu_run_with_opts = {
>  
>  static void realtime_init(void)
>  {
> -    if (enable_mlock) {
> -        if (os_mlock(false) < 0) {
> +    if (enable_mlock || enable_mlock_onfault) {

IIUC it's still cleaner to make enable_mlock into an enum to be a
tri-state.  IOW, we could have two flags set now with the current patch
when with things like:

  -overcommit mem-lock=on -overcommit mem-lock=on-fault

> +        if (os_mlock(enable_mlock_onfault) < 0) {
>              error_report("locking memory failed");
>              exit(1);
>          }
> @@ -3532,14 +3532,42 @@ void qemu_init(int argc, char **argv)
>                  object_option_parse(optarg);
>                  break;
>              case QEMU_OPTION_overcommit:
> -                opts = qemu_opts_parse_noisily(qemu_find_opts("overcommit"),
> -                                               optarg, false);
> -                if (!opts) {
> +                {
> +                    const char *mem_lock_opt;
> +
> +                    opts = qemu_opts_parse_noisily(qemu_find_opts("overcommit"),
> +                                                   optarg, false);
> +                    if (!opts) {
> +                        exit(1);
> +                    }
> +
> +                    enable_cpu_pm = qemu_opt_get_bool(opts, "cpu-pm", enable_cpu_pm);
> +
> +                    mem_lock_opt = qemu_opt_get(opts, "mem-lock");
> +                    if (!mem_lock_opt) {
> +                        break;
> +                    }
> +
> +                    if (strcmp(mem_lock_opt, "on") == 0) {
> +                        enable_mlock = true;
> +                        break;
> +                    }
> +
> +                    if (strcmp(mem_lock_opt, "off") == 0) {
> +                        enable_mlock = false;
> +                        enable_mlock_onfault = false;
> +                        break;
> +                    }
> +
> +                    if (strcmp(mem_lock_opt, "on-fault") == 0) {
> +                        enable_mlock_onfault = true;
> +                        break;
> +                    }
> +
> +                    error_report("parameter 'mem-lock' expects one of "
> +                                 "'on', 'off', 'on-fault'");

Not the only one that open code this.. but still there're better references
like net_client_parse() or monitor_parse() that we could follow.  So would
be good to put it into a function.

Thanks,

>                      exit(1);
>                  }
> -                enable_mlock = qemu_opt_get_bool(opts, "mem-lock", enable_mlock);
> -                enable_cpu_pm = qemu_opt_get_bool(opts, "cpu-pm", enable_cpu_pm);
> -                break;
>              case QEMU_OPTION_compat:
>                  {
>                      CompatPolicy *opts_policy;
> -- 
> 2.34.1
> 

-- 
Peter Xu


