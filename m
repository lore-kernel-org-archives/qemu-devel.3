Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6082210ED67F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 14:34:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w68G7-0002fg-Hd; Fri, 27 Mar 2026 10:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w68G6-0002fQ-M4
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 10:33:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w68G3-0001wq-N0
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 10:33:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774622033;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=aKoANEX0Fhr2tDbxO1ma58SQJ7Y/f+dl+DZEW8l35a0=;
 b=ezBnI909dU9KhRAURVcVkOHQKoyBJV96PhVG7yWOQbjq062qjG/c8lskBo0lI9bp4K4Uw/
 vtbT2KTO1OdVY+xy0BS45jo0ZH9EOE+7mwhtUitVsoz3KwEHPTKgtCgoH9O7WSaaTFFCY7
 vBB+IIPKitcgfngpT8U4A1tg8M8JbO8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-NtJgYXixPGW19kFwSIV6gQ-1; Fri,
 27 Mar 2026 10:33:49 -0400
X-MC-Unique: NtJgYXixPGW19kFwSIV6gQ-1
X-Mimecast-MFC-AGG-ID: NtJgYXixPGW19kFwSIV6gQ_1774622027
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 848B21956094; Fri, 27 Mar 2026 14:33:47 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.112])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A3A951800671; Fri, 27 Mar 2026 14:33:45 +0000 (UTC)
Date: Fri, 27 Mar 2026 14:33:42 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Cathy Hu <cathy.hu@suse.com>
Cc: qemu-devel@nongnu.org, Cathy Hu <cahu@suse.de>,
 Fabiano Rosas <fabiano.rosas@suse.com>, KVM Bugs <kvm-bugs@suse.de>
Subject: Re: [PATCH RFC] qga: Add selinux-helper for guest-exec subcommand
 (bsc#1237450)
Message-ID: <acaVRtE-NPUa5Ujy@redhat.com>
References: <20260327102515.502822-5-cathy.hu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260327102515.502822-5-cathy.hu@suse.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Mar 27, 2026 at 11:25:19AM +0100, Cathy Hu wrote:
> From: Cathy Hu <cahu@suse.de>
> 
> Problem:
> 
> ATM the QEMU Guest Agent and SELinux are not working together properly.
> The fedora (and therefor also the openSUSE) policy confine the qemu-guest-agent
> service in the domain `qemu_ga_t`. That means, qemu-guest-agent
> is only allowed to do what the policy says.
> 
> However, the `guest-exec` command allows arbitrary execution
> of code from a privileged service, which conflicts with the
> notion of SELinux confinement.
> 
> ATM, the policy allows only some accesses that are used
> by other qemu-guest-agent commands.
> That means, the qemu-guest-agent fails sporadically, depending
> on what is allowed for other commands.
> However, `guest-exec` would need to allow everything.
> 
> see https://bugzilla.suse.com/show_bug.cgi?id=1237450
> 
> Solution:
> 
> This is not an great solution, but it works like this:
> We add a "wrapper" which is executed instead of the program
> that is called via `guest-exec`. The "wrapper" just
> re-executes the command given by `guest-exec`.
> This way, on the SELinux policy side we can give that
> wrapper executable a label on the file system.
> With that label, we can transition into a more broader
> unconfined domain _and_ toggle that transition with a
> SELinux boolean. That would make `guest-exec`
> consistently allowed to execute or not by policy.
> 
> This needs a change on the SELinux policy side to
> accompany this with:
> https://github.com/fedora-selinux/selinux-policy/pull/3122
> 
> What other options have been tried unsuccessfully:
> 
> - Fixing via SELinux policy: It is not possible for
>   one domain to have different permissions depending on
>   code path. It is also not possible to toggle the permissive
>   state via a SELinux boolean, so users would need
>   to add it via semanage.
> - Setting the domain of the executed commands directly
>   to a broader domain with setcon/setexeccon.
>   The SELinux kernel does not allow to spawn a process
>   directly with those that has broader privileges than the parent.
> 
> What other options are there to solve this issue:
> 
> - Making the qemu-guest-agent unconfined by default
> - Document the workaround to use semanage to make the domain permissive
>   if `exec-guest` is needed as works as intended and ignore the problem

IMHO, the 'exec' command should never have been added to the
QEMU guest agent, for precisely this reason that it makes it
impractical to put any meaningful security controls around it.
Likewise the commands which allow arbitrary file read/write.

QEMU guest agent should focus on specific targetted tasks
with dedicated commands.

NB: in RHEL we disable all those unconfinable commands.


If users want to support an ability to have arbitrary command
execution, then that should be done with SSH over VSock, where
the guest owner can choose whether to require authentication
first or not, and use SSH authorized_keys if desired to limit
what commands can be run for a given recorded key.

These days systemd installs magic to allow SSH'ing directly
to a guest using VSOCK addresses, and libvirt further
enhances that to allow SSH'ing to a named VM.


We're repeatedly getting patches to add more functionality to
the "exec" command and they all reflect the fact that what
users need is a general purpose shell with vastly more
functionality than the 'exec' command - authentication,
and authorization being top of the list. IMHO this is not
something QEMU should be trying to address.

> 
> Signed-off-by: Cathy Hu <cahu@suse.de>
> ---
>  qga/commands.c               | 13 +++++++++++++
>  qga/meson.build              |  7 +++++++
>  qga/qemu-ga-selinux-helper.c | 17 +++++++++++++++++
>  3 files changed, 37 insertions(+)
>  create mode 100644 qga/qemu-ga-selinux-helper.c
> 
> diff --git a/qga/commands.c b/qga/commands.c
> index 5f20af25d3..29c092630b 100644
> --- a/qga/commands.c
> +++ b/qga/commands.c
> @@ -30,6 +30,10 @@
>   */
>  #define GUEST_FILE_READ_COUNT_MAX (48 * MiB)
>  
> +#ifdef CONFIG_SELINUX
> +#define GUEST_EXEC_SELINUX_HELPER CONFIG_QEMU_HELPERDIR "/qemu-ga-selinux-helper"
> +#endif
> +
>  /* Note: in some situations, like with the fsfreeze, logging may be
>   * temporarily disabled. if it is necessary that a command be able
>   * to log for accounting purposes, check ga_logging_enabled() beforehand.
> @@ -418,6 +422,9 @@ GuestExec *qmp_guest_exec(const char *path,
>      GuestExecInfo *gei;
>      char **argv, **envp;
>      strList arglist;
> +#ifdef CONFIG_SELINUX
> +    strList helper_arg;
> +#endif
>      gboolean ret;
>      GError *gerr = NULL;
>      gint in_fd, out_fd, err_fd;
> @@ -439,7 +446,13 @@ GuestExec *qmp_guest_exec(const char *path,
>          }
>      }
>  
> +#ifdef CONFIG_SELINUX
> +    helper_arg.value = get_relocated_path(GUEST_EXEC_SELINUX_HELPER);
> +    helper_arg.next = &arglist;
> +    argv = guest_exec_get_args(&helper_arg, true);
> +#else
>      argv = guest_exec_get_args(&arglist, true);
> +#endif
>      envp = has_env ? guest_exec_get_args(env, false) : NULL;
>  
>      flags = G_SPAWN_SEARCH_PATH | G_SPAWN_DO_NOT_REAP_CHILD |
> diff --git a/qga/meson.build b/qga/meson.build
> index 89a4a8f713..61f60fba26 100644
> --- a/qga/meson.build
> +++ b/qga/meson.build
> @@ -125,6 +125,13 @@ qga = executable('qemu-ga', qga_ss.sources() + qga_objs,
>                   install: true)
>  all_qga += qga
>  
> +if selinux.found()
> +  qga_selinux_helper = executable('qemu-ga-selinux-helper', files('qemu-ga-selinux-helper.c'),
> +             install: true,
> +             install_dir: get_option('libexecdir'))
> +  all_qga += qga_selinux_helper
> +endif
> +
>  if host_os == 'windows'
>    qemu_ga_msi_arch = {
>      'x86': ['-D', 'Arch=32'],
> diff --git a/qga/qemu-ga-selinux-helper.c b/qga/qemu-ga-selinux-helper.c
> new file mode 100644
> index 0000000000..a184e74ede
> --- /dev/null
> +++ b/qga/qemu-ga-selinux-helper.c
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#include <stdio.h>
> +#include <glib.h>
> +
> +int main(int argc, char **argv)
> +{
> +    if (argc < 2) {
> +        return EXIT_FAILURE;
> +    }
> +
> +    execvp(argv[1], argv + 1);
> +
> +    int err = errno;
> +    fprintf(stderr, "%s: %s\n", argv[1], strerror(err));
> +
> +    exit(EXIT_FAILURE);
> +}
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


