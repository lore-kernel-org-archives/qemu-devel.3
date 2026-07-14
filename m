Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 719B1C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 10:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjaVn-0002T4-Nb; Tue, 14 Jul 2026 06:37:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wjaVm-0002Sp-6l
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 06:37:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wjaVk-0000yz-97
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 06:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784025431;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=mtZ/3sZhemdQmSh9V8tpHM6qRx3N2T+uVSQKoKAts60=;
 b=aLU8iHcMmQnfGXj+ExCwvVMjbnwXpSY420BddpiVlhkG5PnrowI+mQ9MSX2Vi8ZAYHk4B5
 ca3YqD0rfqT3hrD//oIikPGW/lBj/x8wCZQRJOHjhnUJpG2A/bpJ05FA4uLu3isyn+dHer
 i3xy3TWEc9jy2LPMgbujrjV3DQ0PaM0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-7lKY2lnsOJmz5dF8njYeEg-1; Tue,
 14 Jul 2026 06:37:09 -0400
X-MC-Unique: 7lKY2lnsOJmz5dF8njYeEg-1
X-Mimecast-MFC-AGG-ID: 7lKY2lnsOJmz5dF8njYeEg_1784025428
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A1C61956062; Tue, 14 Jul 2026 10:37:08 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.163])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B9CC180049F; Tue, 14 Jul 2026 10:37:05 +0000 (UTC)
Date: Tue, 14 Jul 2026 11:37:02 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, Valentino Paulon <valentino.paulon88@gmail.com>,
 Yan Vugenfirer <yvugenfi@redhat.com>, Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH] qga: Do not follow symlink in guest-ssh-* commands
Message-ID: <alYRTj0_B-HA3t_Y@redhat.com>
References: <20260709105707.91209-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260709105707.91209-1-kkostiuk@redhat.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

On Thu, Jul 09, 2026 at 01:57:07PM +0300, Kostiantyn Kostiuk wrote:
> Before this commit, when qmp_guest_ssh_add_authorized_keys adds an
> SSH key for an existing local user, the agent (running as root) decides
> whether to create the user's .ssh directory with a symlink-following
> directory test, and then writes and chowns the authorized_keys file.
> A local unprivileged user who owns their home directory can pre-stage
> their .ssh directory (or the authorized_keys file) as a symbolic link
> so that, when the host or operator triggers a key add for that user,
> the root agent follows the link and transfers ownership of an arbitrary
> root-owned file or directory to the unprivileged user, who can then rewrite
> it to obtain root
> 
> Fixes: CVE-2026-12080
> Fixes: https://gitlab.com/qemu-project/qemu/-/work_items/3929
> 
> Reported-by: Valentino Paulon <valentino.paulon88@gmail.com>
> Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> ---
>  qga/commands-posix-ssh.c | 53 ++++++++++++++++++++++++++++++++++------
>  1 file changed, 45 insertions(+), 8 deletions(-)
> 
> diff --git a/qga/commands-posix-ssh.c b/qga/commands-posix-ssh.c
> index 661972e34e..4e717d8ae8 100644
> --- a/qga/commands-posix-ssh.c
> +++ b/qga/commands-posix-ssh.c
> @@ -66,7 +66,7 @@ mkdir_for_user(const char *path, const struct passwd *p,
>          return false;
>      }
>  
> -    if (chown(path, p->pw_uid, p->pw_gid) == -1) {
> +    if (lchown(path, p->pw_uid, p->pw_gid) == -1) {
>          error_setg_errno(errp, errno,
>                           "failed to set ownership of directory '%s'",
>                           path);
> @@ -96,7 +96,7 @@ write_authkeys(const char *path, const GStrv keys,
>          return false;
>      }
>  
> -    if (chown(path, p->pw_uid, p->pw_gid) == -1) {
> +    if (lchown(path, p->pw_uid, p->pw_gid) == -1) {
>          error_setg_errno(errp, errno,
>                           "failed to set ownership of directory '%s'",
>                           path);
> @@ -123,6 +123,7 @@ qmp_guest_ssh_add_authorized_keys(const char *username, strList *keys,
>      g_auto(GStrv) authkeys = NULL;
>      strList *k;
>      size_t nkeys, nauthkeys;
> +    int fd;
>  
>      reset = has_reset && reset;
>  
> @@ -138,15 +139,25 @@ qmp_guest_ssh_add_authorized_keys(const char *username, strList *keys,
>      ssh_path = g_build_filename(p->pw_dir, ".ssh", NULL);
>      authkeys_path = g_build_filename(ssh_path, "authorized_keys", NULL);
>  
> +    fd = open(ssh_path, O_DIRECTORY | O_NOFOLLOW);
> +    if (fd == -1) {
> +        if (errno != ENOENT) {
> +            error_setg_errno(errp, errno, "failed to open directory '%s'", ssh_path);
> +            return;
> +        }
> +    }

IIUC, you're trying to protect against the possbility that /home/fred/.ssh is
a symlink to some other privileged directory.

>      if (!reset) {
>          authkeys = read_authkeys(authkeys_path, NULL);
>      }
>      if (authkeys == NULL) {
> -        if (!g_file_test(ssh_path, G_FILE_TEST_IS_DIR) &&
> -            !mkdir_for_user(ssh_path, p, 0700, errp)) {
> +        if (fd == -1 && !mkdir_for_user(ssh_path, p, 0700, errp)) {
>              return;
>          }
>      }
> +    if (fd >= 0) {
> +        close(fd);
> +    }

Does holding open an FD on a directory prevent that directory being
altered ?  Even if it prevents it being deleted, surely there's still
a race where the dir could be renamed, andd .ssh turned back into a
symlink ?

Rather than do these checks and switch chown->lchown, I wonder if we
are better off having the agent simply change its effective UID/GID
while it updates the SSH key files ? That way the agent would be
confined just like the user would be and we don't need to implement
special cases, nor would we have to think about race conditions.

>  
>      nauthkeys = authkeys ? g_strv_length(authkeys) : 0;
>      authkeys = g_realloc_n(authkeys, nauthkeys + nkeys + 1, sizeof(char *));
> @@ -167,11 +178,13 @@ qmp_guest_ssh_remove_authorized_keys(const char *username, strList *keys,
>                                       Error **errp)
>  {
>      g_autofree struct passwd *p = NULL;
> +    g_autofree char *ssh_path = NULL;
>      g_autofree char *authkeys_path = NULL;
>      g_autofree GStrv new_keys = NULL; /* do not own the strings */
>      g_auto(GStrv) authkeys = NULL;
>      GStrv a;
>      size_t nkeys = 0;
> +    int fd;
>  
>      if (!check_openssh_pub_keys(keys, NULL, errp)) {
>          return;
> @@ -182,8 +195,19 @@ qmp_guest_ssh_remove_authorized_keys(const char *username, strList *keys,
>          return;
>      }
>  
> -    authkeys_path = g_build_filename(p->pw_dir, ".ssh",
> -                                     "authorized_keys", NULL);
> +    ssh_path = g_build_filename(p->pw_dir, ".ssh", NULL);
> +    authkeys_path = g_build_filename(ssh_path, "authorized_keys", NULL);
> +
> +    fd = open(ssh_path, O_DIRECTORY | O_NOFOLLOW);
> +    if (fd == -1) {
> +        if (errno != ENOENT) {
> +            error_setg_errno(errp, errno, "failed to open directory '%s'", ssh_path);
> +            return;
> +        }
> +    } else {
> +        close(fd);
> +    }
> +
>      if (!g_file_test(authkeys_path, G_FILE_TEST_EXISTS)) {
>          return;
>      }
> @@ -215,18 +239,31 @@ GuestAuthorizedKeys *
>  qmp_guest_ssh_get_authorized_keys(const char *username, Error **errp)
>  {
>      g_autofree struct passwd *p = NULL;
> +    g_autofree char *ssh_path = NULL;
>      g_autofree char *authkeys_path = NULL;
>      g_auto(GStrv) authkeys = NULL;
>      g_autoptr(GuestAuthorizedKeys) ret = NULL;
>      int i;
> +    int fd;
>  
>      p = get_passwd_entry(username, errp);
>      if (p == NULL) {
>          return NULL;
>      }
>  
> -    authkeys_path = g_build_filename(p->pw_dir, ".ssh",
> -                                     "authorized_keys", NULL);
> +    ssh_path = g_build_filename(p->pw_dir, ".ssh", NULL);
> +    authkeys_path = g_build_filename(ssh_path, "authorized_keys", NULL);
> +
> +    fd = open(ssh_path, O_DIRECTORY | O_NOFOLLOW);
> +    if (fd == -1) {
> +        if (errno != ENOENT) {
> +            error_setg_errno(errp, errno, "failed to open directory '%s'", ssh_path);
> +            return NULL;
> +        }
> +    } else {
> +        close(fd);
> +    }
> +
>      authkeys = read_authkeys(authkeys_path, errp);
>      if (authkeys == NULL) {
>          return NULL;
> -- 
> 2.53.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


