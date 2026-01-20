Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E00D2ECF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 11:03:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi9WE-00065W-Gf; Tue, 20 Jan 2026 06:03:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vi9W6-0005zC-No
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 06:03:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vi9W3-0003NS-UQ
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 06:03:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768906997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kt/SExo3tbnxihmRkCgOUkwdte9w3iOPjprrz4Eo448=;
 b=bWGoeeBGM77QwrV11yAzN4eryfNCP8lYQqgMDptnQaRcszN6sgOJd750IJSmeJFbk3F3LD
 lePwxkflchsNgVJ0KZ9tCgDKX4hKThMQp1WRWz45k+aPu2xE5kBw2NmjNq5r6U6x6ZGS4K
 RFFA868R26dqE/1Y25Vr8tB7gW6jXnI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-UGfJkxrROrCiHSoL6qfs_A-1; Tue, 20 Jan 2026 06:03:14 -0500
X-MC-Unique: UGfJkxrROrCiHSoL6qfs_A-1
X-Mimecast-MFC-AGG-ID: UGfJkxrROrCiHSoL6qfs_A_1768906993
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4802bb29400so40344035e9.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 03:03:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768906993; cv=none;
 d=google.com; s=arc-20240605;
 b=igK9SqWL0CWwZRMJ2oKGb+cb9m/eT4fUW3Ydny6JEsb+1lKkYtBTaK6eZB6SNIR2/T
 ToPPV0BxE+XxKvt8jw+IxCXrnx1kuO5zhy8RYrLxD82+Ac8rAAcyR1BRk390v4gDbQ22
 Jr1GuNloCgfjjQuBIWUoCmZsBr+ZJMjKMKvNTc1GDTvxAWbysDL9UZGjndkuKiDHMoqc
 KzjS3QyE4i/WahLUtmykLmvPRhJAM97r1Fd6W34mHvTgLzJkpfRgyI56TArXcfa5pD8N
 K4zWLpeFA0mJPO1dAkCrwrQ52ujjUIQdksgv7yCo6Uw+d/KE8KuY5qsDCWcnmF3QwON7
 P2Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kt/SExo3tbnxihmRkCgOUkwdte9w3iOPjprrz4Eo448=;
 fh=SJ3HPovJyRUvRbjEYgfW8f8/HsJC2a+l/HOVRBs3/Wg=;
 b=Cg0wxmMUcKBCNBNwKDdUdhka1LPfpEHOTI2gHf49PylJFZ0soXYkUUN7XXmtUF9OKu
 rdQwxUr1wKPst+2FgbmK9gqnuZFw4SUzZnVBt7PYpMTaNTOarAeprJ99+OOPQI2qaAPw
 Ih2vUfo98IyqXtFyoVjUaCZpIG2KCljwLP+3oBNkvMQNZxd44hPrjio8rC8PA3pfwfL7
 eSxKCVrwArecRsTcrOBqGC36FvO5ZNiRWbtxrOhLQxExSubEGLnhmdo1RHcIeR7T2Jsn
 OrRe6MoJtvRoNm95lf2cXHvTAueZJhg/Tecu+YhTcjl83UlCiA1PK6zDDTeOuPZzGgrr
 QYPQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768906993; x=1769511793; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kt/SExo3tbnxihmRkCgOUkwdte9w3iOPjprrz4Eo448=;
 b=klC5Amvk7/WbQPePHAn/UrVNivdSNj2JSDsvdDOV8cnwGdj+lE+AyoToLI5ZBBfYls
 mCYVJzsWWpXr1Jn1KcmThlpQL1r5ubnbPwjab+SFS41RbdvET1KbJgwKw6wh+DIgjgoS
 DYFD67UfjZjtrF68Z30zu92Wks35rgUYSh5YYbUhG54v8gM70rQqKs1/cYAY/4qprkNZ
 n0lM/HSLLlPF44HdDZoD4e69gXDnGk9A/PCuC0LQTEFPMEDns4nOW5Hos3iV9QfN79ug
 mpVsUwYyBefN323orRs7E0g8xG92xFxa1iWQny/myzx2XjLoBllf8ao6IIqIXbhbbNxu
 sDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768906993; x=1769511793;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kt/SExo3tbnxihmRkCgOUkwdte9w3iOPjprrz4Eo448=;
 b=jTuSEsmXAzlz0eeSEAW+P+LfKhPT3LMga5oRGZ2opG2CZjO/rrWQZElb1JftmLMfb3
 WGhOiflntnUjcm75XVA60wv9gUutBDvWcs2X7FnhIRoW4mL2kIZWZXuEFoE+RVdmoIyD
 8x7cWy7lMMQj8UiF6DMHfySb+V8CB2+QyqEq3LrQ+xnAMQiBaQR+3TPo30C/q5bQeG+9
 GXiuNPWALXjp/jq6mZtN14vppYiOxunQbxvXOUNAiSoxQBCXyTL22w0UIhoczFCqCAEY
 S+0bSHMzuNbKE0jPF2k3Y0e5ETt432iLJ9gwMTAm4bQa86odS7paT8lbIOrwLu40JbEK
 VRqg==
X-Gm-Message-State: AOJu0YxYR2StcG7uXf3fqUQoLPyp492OptRsqz2vFcvGwehicViKaI1H
 LFNxD3jxhsOZyw62DQsGfJCQpOuhQRgtFmj46N9GVwRkEbKjr4KVyegtX43Cnf4rAt/fMldmy3P
 buWl3kxAC5FBhXyHXgFjNaIlD9G9sOB/d8nDq4TjFz4vMbTRLx/yah20xuawo2ANweeRXwRLCww
 wC0fDKP3MTwL0hlF/tc6+CM4NANabSD7Q=
X-Gm-Gg: AY/fxX51w6jGJFZOhSpSGVC53VzKkkHBN3tRHiccgGOKdARubn18osEPhgGtMGsIyC1
 vhQApGbAjnqsfJek0c7M2mlUTaGaPbjcM+cQOYLx1os6ayOEsjx/BfTwFJ/sGGHLr7eHnzweMPm
 2aLB/P4+PSAe/Ky/AqvLJjQQpODFHCScb/32+a6+luncjGnvpizj8mTM7kO1t5kCuUWzPqhE1gA
 2jPYLWnd9wQ8MaWcxkPIraD4b6RNy3aUF4wjiWa5H00KR3RXubbTTrs
X-Received: by 2002:a05:600c:4692:b0:480:3338:2939 with SMTP id
 5b1f17b1804b1-480349dfa7dmr80453695e9.26.1768906993059; 
 Tue, 20 Jan 2026 03:03:13 -0800 (PST)
X-Received: by 2002:a05:600c:4692:b0:480:3338:2939 with SMTP id
 5b1f17b1804b1-480349dfa7dmr80453085e9.26.1768906992490; Tue, 20 Jan 2026
 03:03:12 -0800 (PST)
MIME-Version: 1.0
References: <20260109124043.25019-1-farosas@suse.de>
 <20260109124043.25019-5-farosas@suse.de>
In-Reply-To: <20260109124043.25019-5-farosas@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 20 Jan 2026 16:32:55 +0530
X-Gm-Features: AZwV_QhLWHt71fCxkqG_6uwZMfEeVv4dLLktj1TlXI-ehQjglPBfZyxWxjYSFKI
Message-ID: <CAE8KmOw66B0Za=KA=TyxyWMPYSjFK=GBq7XhREevkCO4Vs+HYQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/25] migration: Cleanup TLS handshake hostname passing
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 9 Jan 2026 at 18:18, Fabiano Rosas <farosas@suse.de> wrote:
> The TLS hostname is doing a tour around the world just to be cached
> into s->hostname. We're already abusing MigrationState by doing that,
> so incorporate the s->hostname into migration_tls_hostname() and stop
> passing the string around.

* I get the idea of not passing 's->hostname' around as a parameter,  but:
   - migrate_tls_hostname() already returns  '->tls_hostname->u.s',
why are we making it return 's->hostname' too?
   - How are 'tls_hostname->u.s' and 's->hostname' different?
   + virsh(1) migrate has:
       --tls-destination <string>  override the destination host name
used for TLS verification

* IIUC, when --tls-destination is supplied, s->hostname and
tls_hostname are different, otherwise they are the same? If that is
the case,  could we set tls_hostname = s->hostname when
params->tls_hostname is not defined below?
===
static void migrate_params_test_apply(MigrationParameters *params,
                                      MigrationParameters *dest)
         {
    if (params->tls_hostname) {
        dest->tls_hostname = QAPI_CLONE(StrOrNull, params->tls_hostname);
    } else {
        /* clear the reference, it's owned by s->parameters */
        dest->tls_hostname = NULL;
    }
...
static void migrate_params_apply(MigrationParameters *params)
{
    ...
    if (params->tls_hostname) {
        qapi_free_StrOrNull(s->parameters.tls_hostname);
        s->parameters.tls_hostname = QAPI_CLONE(StrOrNull,
                                                params->tls_hostname);
    }
    ...
}
===

> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/channel.c      |  6 ++----
>  migration/channel.h      |  1 -
>  migration/exec.c         |  2 +-
>  migration/fd.c           |  2 +-
>  migration/file.c         |  2 +-
>  migration/multifd.c      |  9 +++------
>  migration/options.c      |  5 +++++
>  migration/postcopy-ram.c |  2 +-
>  migration/socket.c       |  9 +++------
>  migration/tls.c          | 17 ++++-------------
>  migration/tls.h          |  2 --
>  migration/trace-events   | 10 +++++-----
>  12 files changed, 26 insertions(+), 41 deletions(-)
>
> diff --git a/migration/channel.c b/migration/channel.c
> index b4ab676048..ba14f66d85 100644
> --- a/migration/channel.c
> +++ b/migration/channel.c
> @@ -60,20 +60,18 @@ void migration_channel_process_incoming(QIOChannel *ioc)
>   *
>   * @s: Current migration state
>   * @ioc: Channel to which we are connecting
> - * @hostname: Where we want to connect
>   * @error: Error indicating failure to connect, free'd here
>   */
>  void migration_channel_connect(MigrationState *s,
>                                 QIOChannel *ioc,
> -                               const char *hostname,
>                                 Error *error)
>  {
>      trace_migration_set_outgoing_channel(
> -        ioc, object_get_typename(OBJECT(ioc)), hostname, error);
> +        ioc, object_get_typename(OBJECT(ioc)), error);
>
>      if (!error) {
>          if (migrate_channel_requires_tls_upgrade(ioc)) {
> -            migration_tls_channel_connect(s, ioc, hostname, &error);
> +            migration_tls_channel_connect(s, ioc, &error);
>
>              if (!error) {
>                  /* tls_channel_connect will call back to this
> diff --git a/migration/channel.h b/migration/channel.h
> index 5bdb8208a7..2215091323 100644
> --- a/migration/channel.h
> +++ b/migration/channel.h
> @@ -22,7 +22,6 @@ void migration_channel_process_incoming(QIOChannel *ioc);
>
>  void migration_channel_connect(MigrationState *s,
>                                 QIOChannel *ioc,
> -                               const char *hostname,
>                                 Error *error_in);
>
>  int migration_channel_read_peek(QIOChannel *ioc,
> diff --git a/migration/exec.c b/migration/exec.c
> index 20e6cccf8c..78fe0fff13 100644
> --- a/migration/exec.c
> +++ b/migration/exec.c
> @@ -55,7 +55,7 @@ void exec_start_outgoing_migration(MigrationState *s, strList *command,
>      }
>
>      qio_channel_set_name(ioc, "migration-exec-outgoing");
> -    migration_channel_connect(s, ioc, NULL, NULL);
> +    migration_channel_connect(s, ioc, NULL);
>      object_unref(OBJECT(ioc));
>  }
>
> diff --git a/migration/fd.c b/migration/fd.c
> index 9bf9be6acb..c956b260a4 100644
> --- a/migration/fd.c
> +++ b/migration/fd.c
> @@ -70,7 +70,7 @@ void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **
>      }
>
>      qio_channel_set_name(ioc, "migration-fd-outgoing");
> -    migration_channel_connect(s, ioc, NULL, NULL);
> +    migration_channel_connect(s, ioc, NULL);
>      object_unref(OBJECT(ioc));
>  }
>
> diff --git a/migration/file.c b/migration/file.c
> index bb8031e3c7..c490f2b219 100644
> --- a/migration/file.c
> +++ b/migration/file.c
> @@ -122,7 +122,7 @@ void file_start_outgoing_migration(MigrationState *s,
>          return;
>      }
>      qio_channel_set_name(ioc, "migration-file-outgoing");
> -    migration_channel_connect(s, ioc, NULL, NULL);
> +    migration_channel_connect(s, ioc, NULL);
>  }
>
>  static gboolean file_accept_incoming_migration(QIOChannel *ioc,
> diff --git a/migration/multifd.c b/migration/multifd.c
> index bf6da85af8..3fb1a07ba9 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -814,12 +814,10 @@ static bool multifd_tls_channel_connect(MultiFDSendParams *p,
>                                          QIOChannel *ioc,
>                                          Error **errp)
>  {
> -    MigrationState *s = migrate_get_current();
> -    const char *hostname = s->hostname;
>      MultiFDTLSThreadArgs *args;
>      QIOChannelTLS *tioc;
>
> -    tioc = migration_tls_client_create(ioc, hostname, errp);
> +    tioc = migration_tls_client_create(ioc, errp);
>      if (!tioc) {
>          return false;
>      }
> @@ -829,7 +827,7 @@ static bool multifd_tls_channel_connect(MultiFDSendParams *p,
>       * created TLS channel, which has already taken a reference.
>       */
>      object_unref(OBJECT(ioc));
> -    trace_multifd_tls_outgoing_handshake_start(ioc, tioc, hostname);
> +    trace_multifd_tls_outgoing_handshake_start(ioc, tioc);
>      qio_channel_set_name(QIO_CHANNEL(tioc), "multifd-tls-outgoing");
>
>      args = g_new0(MultiFDTLSThreadArgs, 1);
> @@ -876,8 +874,7 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
>          goto out;
>      }
>
> -    trace_multifd_set_outgoing_channel(ioc, object_get_typename(OBJECT(ioc)),
> -                                       migrate_get_current()->hostname);
> +    trace_multifd_set_outgoing_channel(ioc, object_get_typename(OBJECT(ioc)));
>
>      if (migrate_channel_requires_tls_upgrade(ioc)) {
>          ret = multifd_tls_channel_connect(p, ioc, &local_err);
> diff --git a/migration/options.c b/migration/options.c
> index 9a5a39c886..881034c289 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -956,6 +956,11 @@ const char *migrate_tls_hostname(void)
>          return s->parameters.tls_hostname->u.s;
>      }
>
> +    /* hostname saved from a previously connected channel */
> +    if (s->hostname) {
> +        return s->hostname;
> +    }
> +

* Maybe this return 's->hostname' can be avoided by setting
tls_hostname = s->hostname at the initialisation stage. If
'tls_hostname' and 's->hostname' are different, will the
migrate_tls_hostname() callers work correctly with s->hostname?

>      return NULL;
>  }
>
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 98a98138be..7afb42bd27 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -1966,7 +1966,7 @@ postcopy_preempt_send_channel_new(QIOTask *task, gpointer opaque)
>      }
>
>      if (migrate_channel_requires_tls_upgrade(ioc)) {
> -        tioc = migration_tls_client_create(ioc, s->hostname, &local_err);
> +        tioc = migration_tls_client_create(ioc, &local_err);
>          if (!tioc) {
>              goto out;
>          }
> diff --git a/migration/socket.c b/migration/socket.c
> index 9e379bf56f..426f363b99 100644
> --- a/migration/socket.c
> +++ b/migration/socket.c
> @@ -44,7 +44,6 @@ void socket_send_channel_create(QIOTaskFunc f, void *data)
>
>  struct SocketConnectData {
>      MigrationState *s;
> -    char *hostname;
>  };
>
>  static void socket_connect_data_free(void *opaque)
> @@ -53,7 +52,6 @@ static void socket_connect_data_free(void *opaque)
>      if (!data) {
>          return;
>      }
> -    g_free(data->hostname);
>      g_free(data);
>  }
>
> @@ -69,7 +67,7 @@ static void socket_outgoing_migration(QIOTask *task,
>             goto out;
>      }
>
> -    trace_migration_socket_outgoing_connected(data->hostname);
> +    trace_migration_socket_outgoing_connected();
>
>      if (migrate_zero_copy_send() &&
>          !qio_channel_has_feature(sioc, QIO_CHANNEL_FEATURE_WRITE_ZERO_COPY)) {
> @@ -77,7 +75,7 @@ static void socket_outgoing_migration(QIOTask *task,
>      }
>
>  out:
> -    migration_channel_connect(data->s, sioc, data->hostname, err);
> +    migration_channel_connect(data->s, sioc, err);
>      object_unref(OBJECT(sioc));
>  }
>
> @@ -96,7 +94,7 @@ void socket_start_outgoing_migration(MigrationState *s,
>      outgoing_args.saddr = addr;
>
>      if (saddr->type == SOCKET_ADDRESS_TYPE_INET) {
> -        data->hostname = g_strdup(saddr->u.inet.host);
> +        s->hostname = g_strdup(saddr->u.inet.host);
>      }
>
>      qio_channel_set_name(QIO_CHANNEL(sioc), "migration-socket-outgoing");
> @@ -180,4 +178,3 @@ void socket_start_incoming_migration(SocketAddress *saddr,
>          qapi_free_SocketAddress(address);
>      }
>  }
> -
> diff --git a/migration/tls.c b/migration/tls.c
> index 1df31bdcbb..82f58cbc78 100644
> --- a/migration/tls.c
> +++ b/migration/tls.c
> @@ -112,12 +112,11 @@ static void migration_tls_outgoing_handshake(QIOTask *task,
>      } else {
>          trace_migration_tls_outgoing_handshake_complete();
>      }
> -    migration_channel_connect(s, ioc, NULL, err);
> +    migration_channel_connect(s, ioc, err);
>      object_unref(OBJECT(ioc));
>  }
>
>  QIOChannelTLS *migration_tls_client_create(QIOChannel *ioc,
> -                                           const char *hostname,
>                                             Error **errp)
>  {
>      QCryptoTLSCreds *creds;
> @@ -127,29 +126,21 @@ QIOChannelTLS *migration_tls_client_create(QIOChannel *ioc,
>          return NULL;
>      }
>
> -    const char *tls_hostname = migrate_tls_hostname();
> -    if (tls_hostname) {
> -        hostname = tls_hostname;
> -    }
> -
> -    return qio_channel_tls_new_client(ioc, creds, hostname, errp);
> +    return qio_channel_tls_new_client(ioc, creds, migrate_tls_hostname(), errp);
>  }
>
>  void migration_tls_channel_connect(MigrationState *s,
>                                     QIOChannel *ioc,
> -                                   const char *hostname,
>                                     Error **errp)
>  {
>      QIOChannelTLS *tioc;
>
> -    tioc = migration_tls_client_create(ioc, hostname, errp);
> +    tioc = migration_tls_client_create(ioc, errp);
>      if (!tioc) {
>          return;
>      }
>
> -    /* Save hostname into MigrationState for handshake */
> -    s->hostname = g_strdup(hostname);
> -    trace_migration_tls_outgoing_handshake_start(hostname);
> +    trace_migration_tls_outgoing_handshake_start();
>      qio_channel_set_name(QIO_CHANNEL(tioc), "migration-tls-outgoing");
>
>      if (migrate_postcopy_ram() || migrate_return_path()) {
> diff --git a/migration/tls.h b/migration/tls.h
> index 7607cfe803..7cd9c76013 100644
> --- a/migration/tls.h
> +++ b/migration/tls.h
> @@ -27,12 +27,10 @@
>  void migration_tls_channel_process_incoming(QIOChannel *ioc, Error **errp);
>
>  QIOChannelTLS *migration_tls_client_create(QIOChannel *ioc,
> -                                           const char *hostname,
>                                             Error **errp);
>
>  void migration_tls_channel_connect(MigrationState *s,
>                                     QIOChannel *ioc,
> -                                   const char *hostname,
>                                     Error **errp);
>  void migration_tls_channel_end(QIOChannel *ioc, Error **errp);
>  /* Whether the QIO channel requires further TLS handshake? */
> diff --git a/migration/trace-events b/migration/trace-events
> index bf11b62b17..da8f909cac 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -149,10 +149,10 @@ multifd_send_sync_main_wait(uint8_t id) "channel %u"
>  multifd_send_terminate_threads(void) ""
>  multifd_send_thread_end(uint8_t id, uint64_t packets) "channel %u packets %" PRIu64
>  multifd_send_thread_start(uint8_t id) "%u"
> -multifd_tls_outgoing_handshake_start(void *ioc, void *tioc, const char *hostname) "ioc=%p tioc=%p hostname=%s"
> +multifd_tls_outgoing_handshake_start(void *ioc, void *tioc) "ioc=%p tioc=%p"
>  multifd_tls_outgoing_handshake_error(void *ioc, const char *err) "ioc=%p err=%s"
>  multifd_tls_outgoing_handshake_complete(void *ioc) "ioc=%p"
> -multifd_set_outgoing_channel(void *ioc, const char *ioctype, const char *hostname)  "ioc=%p ioctype=%s hostname=%s"
> +multifd_set_outgoing_channel(void *ioc, const char *ioctype)  "ioc=%p ioctype=%s"
>
>  # migration.c
>  migrate_set_state(const char *new_state) "new state %s"
> @@ -204,7 +204,7 @@ migration_transferred_bytes(uint64_t qemu_file, uint64_t multifd, uint64_t rdma)
>
>  # channel.c
>  migration_set_incoming_channel(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
> -migration_set_outgoing_channel(void *ioc, const char *ioctype, const char *hostname, void *err)  "ioc=%p ioctype=%s hostname=%s err=%p"
> +migration_set_outgoing_channel(void *ioc, const char *ioctype, void *err)  "ioc=%p ioctype=%s err=%p"
>
>  # global_state.c
>  migrate_state_too_big(void) ""
> @@ -328,11 +328,11 @@ migration_file_incoming(const char *filename) "filename=%s"
>
>  # socket.c
>  migration_socket_incoming_accepted(void) ""
> -migration_socket_outgoing_connected(const char *hostname) "hostname=%s"
> +migration_socket_outgoing_connected(void) ""
>  migration_socket_outgoing_error(const char *err) "error=%s"
>
>  # tls.c
> -migration_tls_outgoing_handshake_start(const char *hostname) "hostname=%s"
> +migration_tls_outgoing_handshake_start(void) ""
>  migration_tls_outgoing_handshake_error(const char *err) "err=%s"
>  migration_tls_outgoing_handshake_complete(void) ""
>  migration_tls_incoming_handshake_start(void) ""
> --

* Otherwise change looks okay.
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


