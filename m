Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D28CC5AC82
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 11:35:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtOHm-0005z6-W6; Mon, 10 Aug 2026 07:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wtOHf-0005yN-As
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 07:35:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wtOHd-0001Fw-8v
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 07:35:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786361708;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=dnSjSdlhDJ3ON58Ty/ICfBPj/qFOPh6zuMBHfbHRTp4=;
 b=LrJlYsMroF4rPvo21Gczja+9PpJc6CObGvNIxv93sMwaKcFeYXAfzlZjlI6hejP9Or3iWP
 NQ8bu5Lm/C3Vt2bOXCtz+wvgbtY0lG5oLmH8SJBTKPeDmG/oM6p+Qe7+9W9lXMuAbQm9vV
 s2qQJbk7dUJQe0Z9JA4tRWg0lwSsYrU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318-tLWNqAAnNWy9jGVho2RMGQ-1; Mon,
 10 Aug 2026 07:35:04 -0400
X-MC-Unique: tLWNqAAnNWy9jGVho2RMGQ-1
X-Mimecast-MFC-AGG-ID: tLWNqAAnNWy9jGVho2RMGQ_1786361703
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BDD5C195608F; Mon, 10 Aug 2026 11:35:03 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48D2C1800348; Mon, 10 Aug 2026 11:35:02 +0000 (UTC)
Date: Mon, 10 Aug 2026 12:34:59 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, Valentino Paulon <valentino.paulon88@gmail.com>,
 Yan Vugenfirer <yvugenfi@redhat.com>, Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v2] qga: Change effective user/group ID in guest-ssh-*
 commands
Message-ID: <anm3Y3b3EgB8aKKE@redhat.com>
References: <20260810104659.82320-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260810104659.82320-1-kkostiuk@redhat.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.746,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Aug 10, 2026 at 01:46:59PM +0300, Kostiantyn Kostiuk wrote:
> Before this commit, when qmp_guest_ssh_add_authorized_keys adds an
> SSH key for an existing local user, the agent (running as root) decides
> whether to create the user's .ssh directory with a symlink-following
> directory test, and then writes and chowns the authorized_keys file.
> A local unprivileged user who owns their home directory can pre-stage
> their .ssh directory (or the authorized_keys file) as a symbolic link
> so that, when the host or operator triggers a key add for that user,
> the root agent follows the link and transfers ownership of an arbitrary
> root-owned file or directory to the unprivileged user, who can then rewrite
> it to obtain root.
> 
> Fixes: CVE-2026-12080
> Fixes: https://gitlab.com/qemu-project/qemu/-/work_items/3929
> 
> v1: https://patchew.org/QEMU/20260709105707.91209-1-kkostiuk@redhat.com/
> v2 -> v1:
> Change effective user/group ID instead of checking for symlinks and
> changing ownership of the file.
> 
> Reported-by: Valentino Paulon <valentino.paulon88@gmail.com>
> Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> ---
>  qga/commands-posix-ssh.c | 94 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
> 
> diff --git a/qga/commands-posix-ssh.c b/qga/commands-posix-ssh.c
> index 661972e34e..9a3507fda4 100644
> --- a/qga/commands-posix-ssh.c
> +++ b/qga/commands-posix-ssh.c
> @@ -8,6 +8,7 @@
>  #include <glib/gstdio.h>
>  #include <locale.h>
>  #include <pwd.h>
> +#include <grp.h>
> 
>  #include "commands-common-ssh.h"
>  #include "qapi/error.h"
> @@ -123,6 +124,9 @@ qmp_guest_ssh_add_authorized_keys(const char *username, strList *keys,
>      g_auto(GStrv) authkeys = NULL;
>      strList *k;
>      size_t nkeys, nauthkeys;
> +    uid_t euid, egid;
> +    __attribute__((unused)) uid_t unused_euid;
> +    __attribute__((unused)) uid_t unused_egid;
> 
>      reset = has_reset && reset;
> 
> @@ -135,6 +139,29 @@ qmp_guest_ssh_add_authorized_keys(const char *username, strList *keys,
>          return;
>      }
> 
> +    euid = geteuid();
> +    egid = getegid();
> +#ifndef QGA_BUILD_UNIT_TEST
> +    /* The initgroups requires CAP_SETGID. During build time unit tests, we can't do this. */
> +    if (initgroups(p->pw_name, p->pw_gid) == -1) {
> +        error_setg_errno(errp, errno, "failed to set group for user '%s'",
> +                         p->pw_name);
> +        return;
> +    }
> +#endif
> +    if (setegid(p->pw_gid) == -1) {
> +        error_setg_errno(errp, errno, "failed to set effective group ID for user '%s'",
> +                         p->pw_name);
> +        return;
> +    }
> +    if (seteuid(p->pw_uid) == -1) {
> +        error_setg_errno(errp, errno, "failed to set effective user ID for user '%s'",
> +                         p->pw_name);
> +        /* Ignore errors, we can't do anything in this case */
> +        unused_egid = setegid(egid);
> +        return;
> +    }
> +
>      ssh_path = g_build_filename(p->pw_dir, ".ssh", NULL);
>      authkeys_path = g_build_filename(ssh_path, "authorized_keys", NULL);
> 
> @@ -144,6 +171,9 @@ qmp_guest_ssh_add_authorized_keys(const char *username, strList *keys,
>      if (authkeys == NULL) {
>          if (!g_file_test(ssh_path, G_FILE_TEST_IS_DIR) &&
>              !mkdir_for_user(ssh_path, p, 0700, errp)) {
> +            /* Ignore errors, we can't do anything in this case */
> +            unused_euid = seteuid(euid);
> +            unused_egid = setegid(egid);

IMHO we should

      assert(seteuid(euid) == 0)

given the code flow, there is no way in which this should ever fail in
normal operation. So if it fails, aborting the daemon feels right, as
this is a sign of a major disaster. Systemd would auto-restart it to
recover

With that, you don't need the "unused" annotations

If we really strongly don't want to abort though, we could just
fork but not exec, just to run the privileged operation, and thus
the temporary throwaway process would exit and not need to change
UID back to the orignial.

>              return;
>          }
>      }
> @@ -160,6 +190,9 @@ qmp_guest_ssh_add_authorized_keys(const char *username, strList *keys,
>      }
> 
>      write_authkeys(authkeys_path, authkeys, p, errp);
> +    /* Ignore errors, we can't do anything in this case */
> +    unused_euid = seteuid(euid);
> +    unused_egid = setegid(egid);
>  }
> 
>  void
> @@ -172,6 +205,9 @@ qmp_guest_ssh_remove_authorized_keys(const char *username, strList *keys,
>      g_auto(GStrv) authkeys = NULL;
>      GStrv a;
>      size_t nkeys = 0;
> +    uid_t euid, egid;
> +    __attribute__((unused)) uid_t unused_euid;
> +    __attribute__((unused)) uid_t unused_egid;
> 
>      if (!check_openssh_pub_keys(keys, NULL, errp)) {
>          return;
> @@ -182,6 +218,29 @@ qmp_guest_ssh_remove_authorized_keys(const char *username, strList *keys,
>          return;
>      }
> 
> +    euid = geteuid();
> +    egid = getegid();
> +#ifndef QGA_BUILD_UNIT_TEST
> +    /* The initgroups requires CAP_SETGID. During build time unit tests, we can't do this. */
> +    if (initgroups(p->pw_name, p->pw_gid) == -1) {
> +        error_setg_errno(errp, errno, "failed to set group for user '%s'",
> +                         p->pw_name);
> +        return;
> +    }
> +#endif
> +    if (setegid(p->pw_gid) == -1) {
> +        error_setg_errno(errp, errno, "failed to set effective group ID for user '%s'",
> +                         p->pw_name);
> +        return;
> +    }
> +    if (seteuid(p->pw_uid) == -1) {
> +        error_setg_errno(errp, errno, "failed to set effective user ID for user '%s'",
> +                         p->pw_name);
> +        /* Ignore errors, we can't do anything in this case */
> +        unused_egid = setegid(egid);
> +        return;
> +    }
> +
>      authkeys_path = g_build_filename(p->pw_dir, ".ssh",
>                                       "authorized_keys", NULL);
>      if (!g_file_test(authkeys_path, G_FILE_TEST_EXISTS)) {
> @@ -209,6 +268,9 @@ qmp_guest_ssh_remove_authorized_keys(const char *username, strList *keys,
>      }
> 
>      write_authkeys(authkeys_path, new_keys, p, errp);
> +    /* Ignore errors, we can't do anything in this case */
> +    unused_euid = seteuid(euid);
> +    unused_egid = setegid(egid);
>  }
> 
>  GuestAuthorizedKeys *
> @@ -219,16 +281,45 @@ qmp_guest_ssh_get_authorized_keys(const char *username, Error **errp)
>      g_auto(GStrv) authkeys = NULL;
>      g_autoptr(GuestAuthorizedKeys) ret = NULL;
>      int i;
> +    uid_t euid, egid;
> +    __attribute__((unused)) uid_t unused_euid;
> +    __attribute__((unused)) uid_t unused_egid;
> 
>      p = get_passwd_entry(username, errp);
>      if (p == NULL) {
>          return NULL;
>      }
> 
> +    euid = geteuid();
> +    egid = getegid();
> +#ifndef QGA_BUILD_UNIT_TEST
> +    /* The initgroups requires CAP_SETGID. During build time unit tests, we can't do this. */
> +    if (initgroups(p->pw_name, p->pw_gid) == -1) {
> +        error_setg_errno(errp, errno, "failed to set group for user '%s'",
> +                         p->pw_name);
> +        return NULL;
> +    }
> +#endif
> +    if (setegid(p->pw_gid) == -1) {
> +        error_setg_errno(errp, errno, "failed to set effective group ID for user '%s'",
> +                         p->pw_name);
> +        return NULL;
> +    }
> +    if (seteuid(p->pw_uid) == -1) {
> +        error_setg_errno(errp, errno, "failed to set effective user ID for user '%s'",
> +                         p->pw_name);
> +        /* Ignore errors, we can't do anything in this case */
> +        unused_egid = setegid(egid);
> +        return NULL;
> +    }
> +
>      authkeys_path = g_build_filename(p->pw_dir, ".ssh",
>                                       "authorized_keys", NULL);
>      authkeys = read_authkeys(authkeys_path, errp);
>      if (authkeys == NULL) {
> +        /* Ignore errors, we can't do anything in this case */
> +        unused_euid = seteuid(euid);
> +        unused_egid = setegid(egid);
>          return NULL;
>      }
> 
> @@ -242,6 +333,9 @@ qmp_guest_ssh_get_authorized_keys(const char *username, Error **errp)
>          QAPI_LIST_PREPEND(ret->keys, g_strdup(authkeys[i]));
>      }
> 
> +    /* Ignore errors, we can't do anything in this case */
> +    unused_euid = seteuid(euid);
> +    unused_egid = setegid(egid);
>      return g_steal_pointer(&ret);
>  }
> 
> --
> 2.55.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


