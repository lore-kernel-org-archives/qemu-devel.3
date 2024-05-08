Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E673C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 13:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4hEc-0007ZC-Cj; Wed, 08 May 2024 09:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1s4hEO-0007XS-US
 for qemu-devel@nongnu.org; Wed, 08 May 2024 09:21:17 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1s4hEJ-0003Ad-5M
 for qemu-devel@nongnu.org; Wed, 08 May 2024 09:21:11 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 709CF3515A;
 Wed,  8 May 2024 13:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715174462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5lkXfstznkQT4X8aBuaeax1G9GwoBEzgkjYFB5gdCT4=;
 b=SxUNXoZVGWY9jaIrfCZWfam90IHqZsprUTvpbCgGrYU1xfCok2DcX5QQhbP5Z4xEo3hvjC
 16ks09CzBkaW85nufA6vjBbhlfGKSflAYPmMUdSBiYXE1TZcEVh3iG8ybJhE5fNL2EQmhx
 cvbX8j1Z43XAPfhgvwa27PqfW24MHvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715174462;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5lkXfstznkQT4X8aBuaeax1G9GwoBEzgkjYFB5gdCT4=;
 b=fKYNsB/uY9/4C+LC0adztDrOBMOyU6y4wi2vXCwFpb2QMH+s5/TU7q4xyrSSQL/ymJiodW
 ZVnHTYpeY68OyLDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715174461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5lkXfstznkQT4X8aBuaeax1G9GwoBEzgkjYFB5gdCT4=;
 b=tAm2rcJrOj/2XgRYV0jJMT2xrSF751plVbshXHpALNmuvfOFoXPXSBqshK6oCHeyWNmoDh
 HyCOkiDnnXY8WzS7BQxRnkxMNTSlVbCYnq6IJaX3bzR7STk4t7dVw0awp1dX+/IEjKMwX2
 IveriT/AoUrLEFZHzAf9iYqMzOwKGKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715174461;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5lkXfstznkQT4X8aBuaeax1G9GwoBEzgkjYFB5gdCT4=;
 b=D2zAZ6vPXyNEhPaIfzvwM8BD+2KjkSUjsoIuc/4YmRGEsGjMI66iUYwINKMX5gQ7wT3vOl
 RXu61mASGvcyZ5Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C95013A27;
 Wed,  8 May 2024 13:21:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6RqcBD18O2bzbAAAD6G6ig
 (envelope-from <cfontana@suse.de>); Wed, 08 May 2024 13:21:01 +0000
Message-ID: <b39ca716-65eb-463e-bf30-6a07413d5d91@suse.de>
Date: Wed, 8 May 2024 15:20:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] qemu-options: Deprecate "-runas" and introduce
 "-run-with user=..." instead
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: devel@lists.libvirt.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Claudio Imbrenda <imbrenda@linux.ibm.com>
References: <20240506112058.51446-1-thuth@redhat.com>
Content-Language: en-US
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <20240506112058.51446-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.29 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=cfontana@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/6/24 13:20, Thomas Huth wrote:
> The old "-runas" option has the disadvantage that it is not visible
> in the QAPI schema, so it is not available via the normal introspection
> mechanisms. We've recently introduced the "-run-with" option for exactly
> this purpose, which is meant to handle the options that affect the
> runtime behavior. Thus let's introduce a "user=..." parameter here now
> and deprecate the old "-runas" option.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Add missing part in qemu-options.hx as suggested by Philippe
> 
>  docs/about/deprecated.rst |  6 ++++++
>  system/vl.c               | 15 +++++++++++++++
>  qemu-options.hx           | 15 +++++++++++----
>  3 files changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 3310df3274..fe69e2d44c 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -61,6 +61,12 @@ configurations (e.g. -smp drawers=1,books=1,clusters=1 for x86 PC machine) is
>  marked deprecated since 9.0, users have to ensure that all the topology members
>  described with -smp are supported by the target machine.
>  
> +``-runas`` (since 9.1)
> +----------------------
> +
> +Use ``-run-with user=..`` instead.
> +
> +
>  User-mode emulator command line arguments
>  -----------------------------------------
>  
> diff --git a/system/vl.c b/system/vl.c
> index 7756eac81e..b031427440 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -773,6 +773,10 @@ static QemuOptsList qemu_run_with_opts = {
>              .name = "chroot",
>              .type = QEMU_OPT_STRING,
>          },
> +        {
> +            .name = "user",
> +            .type = QEMU_OPT_STRING,
> +        },
>          { /* end of list */ }
>      },
>  };
> @@ -3586,6 +3590,7 @@ void qemu_init(int argc, char **argv)
>                  break;
>  #if defined(CONFIG_POSIX)
>              case QEMU_OPTION_runas:
> +                warn_report("-runas is deprecated, use '-run-with user=...' instead");
>                  if (!os_set_runas(optarg)) {
>                      error_report("User \"%s\" doesn't exist"
>                                   " (and is not <uid>:<gid>)",
> @@ -3612,6 +3617,16 @@ void qemu_init(int argc, char **argv)
>                  if (str) {
>                      os_set_chroot(str);
>                  }
> +                str = qemu_opt_get(opts, "user");
> +                if (str) {
> +                    if (!os_set_runas(str)) {
> +                        error_report("User \"%s\" doesn't exist"
> +                                     " (and is not <uid>:<gid>)",
> +                                     optarg);
> +                        exit(1);
> +                    }
> +                }
> +
>                  break;
>              }
>  #endif /* CONFIG_POSIX */
> diff --git a/qemu-options.hx b/qemu-options.hx
> index cf61f6b863..3031479a15 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4824,7 +4824,8 @@ DEF("runas", HAS_ARG, QEMU_OPTION_runas, \
>  SRST
>  ``-runas user``
>      Immediately before starting guest execution, drop root privileges,
> -    switching to the specified user.
> +    switching to the specified user. This option is deprecated, use
> +    ``-run-with user=...`` instead.
>  ERST
>  
>  DEF("prom-env", HAS_ARG, QEMU_OPTION_prom_env,
> @@ -4990,13 +4991,15 @@ DEF("qtest-log", HAS_ARG, QEMU_OPTION_qtest_log, "", QEMU_ARCH_ALL)
>  
>  #ifdef CONFIG_POSIX
>  DEF("run-with", HAS_ARG, QEMU_OPTION_run_with,
> -    "-run-with [async-teardown=on|off][,chroot=dir]\n"
> +    "-run-with [async-teardown=on|off][,chroot=dir][user=username|uid:gid]\n"
>      "                Set miscellaneous QEMU process lifecycle options:\n"
>      "                async-teardown=on enables asynchronous teardown (Linux only)\n"
> -    "                chroot=dir chroot to dir just before starting the VM\n",
> +    "                chroot=dir chroot to dir just before starting the VM\n"
> +    "                user=username switch to the specified user before starting the VM\n"
> +    "                user=uid:gid dito, but use specified user-ID and group-ID instead\n",

nit: ditto?

Ciao,

C

>      QEMU_ARCH_ALL)
>  SRST
> -``-run-with [async-teardown=on|off][,chroot=dir]``
> +``-run-with [async-teardown=on|off][,chroot=dir][user=username|uid:gid]``
>      Set QEMU process lifecycle options.
>  
>      ``async-teardown=on`` enables asynchronous teardown. A new process called
> @@ -5013,6 +5016,10 @@ SRST
>      ``chroot=dir`` can be used for doing a chroot to the specified directory
>      immediately before starting the guest execution. This is especially useful
>      in combination with -runas.
> +
> +    ``user=username`` or ``user=uid:gid`` can be used to drop root privileges
> +    by switching to the specified user (via username) or user and group
> +    (via uid:gid) immediately before starting guest execution.
>  ERST
>  #endif
>  


