Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D426DD2ED0F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 10:17:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi8mb-000538-7G; Tue, 20 Jan 2026 05:16:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vi8mY-00051u-BY
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 05:16:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vi8mU-0004UJ-74
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 05:16:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768904171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yHi+AJBdIDQK4l972R4LZxcnS51eGST/FxiTej0nGfY=;
 b=OYEaAXNh/tPFld/pmxp9WSODoRwjM48sT1rjriCDbCr4sheaOhlBzqDck7sRPNQZsy++6I
 u1Xh22mICv89DAW7xY89YND9kTbPacdktccel5Fb16967+OORr2l/C2qYTxtgnFKCXmaY2
 OcQFW2n3T7UxowsJ3Jl5RMmv+tf8qAo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-o9adTfiONF2K93Vo6logiQ-1; Tue, 20 Jan 2026 05:16:10 -0500
X-MC-Unique: o9adTfiONF2K93Vo6logiQ-1
X-Mimecast-MFC-AGG-ID: o9adTfiONF2K93Vo6logiQ_1768904169
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4803b4e3b9eso7883865e9.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 02:16:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768904169; cv=none;
 d=google.com; s=arc-20240605;
 b=CqQgpOXX7CC4VCnRxUuLjPwYefbBq6ZXZilzY91Tc7SC6RWSyVJybtb/lZ53M0fVYz
 Z9TaULaUwHEDD70FNnhPhVhRG12e4ru6Wixj8phfzk7v7sZ3UbbLNzTefAi3oWwhBk3s
 L7s70CP8vKYHSsz70CgHTj3+Oluod346W1rPcVGAOQZbngAGPIt3Kva/7SzsCsgw9Ooo
 cRkXVOhXboFs+BuI6eQI9w+6nfdK8WClbCS0YwF85ItKJsRu6jI2uu4R0lFjQWW8HfhB
 fCjGpEdjvq9YyEEf4Z0XtCBKND9FmIDUJBpkpsVnJVfVUwooE9gX6FEpSxK9m+CEN1uZ
 q1tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yHi+AJBdIDQK4l972R4LZxcnS51eGST/FxiTej0nGfY=;
 fh=SJ3HPovJyRUvRbjEYgfW8f8/HsJC2a+l/HOVRBs3/Wg=;
 b=V64eCmgfdz0F1l2fkGY3pbc0rNkWyU4XewWujOyRoi0Td8EDajGLC8bz/8gJm6qK4S
 GMwrAlEjTwvMPffzonT02xCTRAyZV3+uddXSqueLuQpaNtEsfaqK8zzY9F2+XbBWkYjO
 tLeS1xxGEa/jYitjFQ6QgGExlhAoR8N5VnGTg53BZYlKPIONPHuJfeX1zTCuRNUqsLnp
 zu9GrOU3Ml9JxohfO25zi7VKKbQb5LnfacmcbMZ6PQehHpdtJN0vDrTfuhTsZB4XSfYa
 l5A3FWpkETcvegkxKvc72K8+t9kFKZOdLxoVuAWUQbARi18G1A22SOzP48aPyBo+lDSB
 fcuw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768904169; x=1769508969; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yHi+AJBdIDQK4l972R4LZxcnS51eGST/FxiTej0nGfY=;
 b=bNLbkfSKnarsxFaEGxQZGiX9upagROzS2e2SBHUwtnEm3ErLlXBu30r2WDwpBH5+sm
 9tIF6fNEiz4IjGkj7NjC5wcwxiCIKvmb5CiEDeMGpy1V9m2K2k9PJbqRG/7iH1Qluefh
 1bRHKiqSdX6eRdKi8uSlWH6p6NJw7R7jiTN4pAZbd/PDKrr/aNkmHb7Dv7/zZr0jIkIX
 YB9jLc02OlRNNjwSczL0xJhqYoiWHqkE3Z7etdbSORGZcPoyrIF044HsAbBt3CR6fU37
 YEG3dqD+CqYErjxWy2PoQYgQP7R/hL7pBEKMRE4JUm0Muso28+9/G3G+3H3Grmo1NaYo
 TN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768904169; x=1769508969;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yHi+AJBdIDQK4l972R4LZxcnS51eGST/FxiTej0nGfY=;
 b=I8gXCLgmrs8IqMqArwRDsnr7WveNdL5HPaU+fI6XbqLCHbv4jh4gKExwn2YiagLLR2
 CM8vlgLC8VLtzEAqDnywnGq0OMXLLxC1NwgbwXGOF+KOm7nmLVjSOwP05bTa43ItIB7x
 lNX1iQvuOxvJuecMdiuGOhXmSlIWx6psumpyTFRIpm7/aSZZAxRPw85E3AufpENTetOT
 5qG77WsFWU53fpq4lAkZAZzrcIyy4BBf1C89i6FhYaNR9zlAR1PayVKY/7KBtPqb2KBy
 C+6TuphV7AEJXiKoq/BR5bozbmlWk2fvkEAAy00IgcqY+X2fTxTcKBLl/RtQu68KKNEG
 VvZQ==
X-Gm-Message-State: AOJu0YzZIjL6YlN+DymzK+pk1OOZ+nmkkPT8bKt0wU1MoBqTmmVAKEb3
 Hkpy4cnu/u7Fb24am5GlqWCUml6Xw1aa1pZYiOTuqVirOWR+LwRjXfcciZIOADmRGDFXGKJ5NHd
 Keu0zV/UIYPG+ivEXCKAUYcc/SUC2BhuPfhfktm61ky316w/r8Y232NfscwE8sbYmShYZMb7bGs
 yZatj33RzNoxPY/OshE/es4ySZn/sr6kc=
X-Gm-Gg: AY/fxX54HeIuqAKMRNKo581SmU5jkzaRGBL8Pu53HdrjdNsNWBA4hsMJSIRqgn//av8
 OTUQ7TrKJoKjaqShtyZuV1YndGp16NV5vIuNRPNLd+A/cP+K4/hgOnCpGCpV4pHtyX3joQIxzzV
 pTdYp79mLHotE1haVVrLP7wjciIZwg1MbXDEoMMBqIeRRpVmyntAYWaPeALf9XTc/LTkksWzpAk
 5UxYIW4PXipiI8YPXwZIP+5YmOy7y9f0BpsdA5NlTis5fGxEUe4ZCEM
X-Received: by 2002:a05:600c:1d28:b0:477:b734:8c41 with SMTP id
 5b1f17b1804b1-4801eab51d5mr167826615e9.1.1768904168999; 
 Tue, 20 Jan 2026 02:16:08 -0800 (PST)
X-Received: by 2002:a05:600c:1d28:b0:477:b734:8c41 with SMTP id
 5b1f17b1804b1-4801eab51d5mr167826295e9.1.1768904168579; Tue, 20 Jan 2026
 02:16:08 -0800 (PST)
MIME-Version: 1.0
References: <20260109124043.25019-1-farosas@suse.de>
 <20260109124043.25019-21-farosas@suse.de>
In-Reply-To: <20260109124043.25019-21-farosas@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 20 Jan 2026 15:45:51 +0530
X-Gm-Features: AZwV_Qj1nVIU5X_H3K0p8jnOpRw0MIPqz0KdqxtuXnrWILVXQ4T1mdVlycBx6zk
Message-ID: <CAE8KmOzKkF2M0c4yresB+Y87XTXssbmvGp77C640tt33dbj37g@mail.gmail.com>
Subject: Re: [PATCH v3 20/25] migration: Move channel parsing to channel.c
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

On Fri, 9 Jan 2026 at 18:14, Fabiano Rosas <farosas@suse.de> wrote:
> Encapsulate the MigrationChannelList parsing in a new
> migrate_channels_parse() located at channel.c.
>
> This also makes the memory management of the MigrationAddress more
> uniform. Previously, half the parsing code (uri parsing) would
> allocate memory for the address while the other half (channel parsing)
> would instead pass the original QAPI object along. After this patch,
> the MigrationAddress is always QAPI_CLONEd, so the callers can use
> g_autoptr(MigrationAddress) in all cases.
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/channel.c   | 45 ++++++++++++++++++++++++++++++++++++++
>  migration/channel.h   |  5 +++++
>  migration/migration.c | 50 ++++++++++++-------------------------------
>  3 files changed, 64 insertions(+), 36 deletions(-)
>
> diff --git a/migration/channel.c b/migration/channel.c
> index 56c80b5cdf..8b71b3f430 100644
> --- a/migration/channel.c
> +++ b/migration/channel.c
> @@ -11,6 +11,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qemu/cutils.h"
>  #include "channel.h"
>  #include "exec.h"
>  #include "fd.h"
> @@ -20,7 +21,9 @@
>  #include "migration.h"
>  #include "multifd.h"
>  #include "options.h"
> +#include "qapi/clone-visitor.h"
>  #include "qapi/qapi-types-migration.h"
> +#include "qapi/qapi-visit-migration.h"
>  #include "qapi/error.h"
>  #include "qemu-file.h"
>  #include "qemu/yank.h"
> @@ -280,3 +283,45 @@ int migration_channel_read_peek(QIOChannel *ioc,
>
>      return 0;
>  }
> +
> +bool migrate_channels_parse(MigrationChannelList *channels,
> +                            MigrationChannel **main_channelp,
> +                            MigrationChannel **cpr_channelp,
> +                            Error **errp)
> +{
> +    MigrationChannel *channelv[MIGRATION_CHANNEL_TYPE__MAX] = { NULL };
> +    bool single_channel = cpr_channelp ? false : true;
> +
> +    if (single_channel && channels->next) {
> +        error_setg(errp, "Channel list must have only one entry, "
> +                   "for type 'main'");
> +        return false;
> +    }

* Instead of the single_channel variable above, we could say
(!cpr_channelp && channels->next)? and avoid the single_channel
variable.

> +    for ( ; channels; channels = channels->next) {
> +        MigrationChannelType type;
> +
> +        type = channels->value->channel_type;
> +        if (channelv[type]) {
> +            error_setg(errp, "Channel list has more than one %s entry",
> +                       MigrationChannelType_str(type));
> +            return false;
> +        }
> +        channelv[type] = channels->value;
> +    }
> +
> +    if (cpr_channelp) {
> +        *cpr_channelp = QAPI_CLONE(MigrationChannel,
> +                                   channelv[MIGRATION_CHANNEL_TYPE_CPR]);
> +    }
> +
> +    *main_channelp = QAPI_CLONE(MigrationChannel,
> +                                channelv[MIGRATION_CHANNEL_TYPE_MAIN]);
> +
> +    if (!(*main_channelp)->addr) {
> +        error_setg(errp, "Channel list has no main entry");
> +        return false;
> +    }
> +
> +    return true;
> +}
> diff --git a/migration/channel.h b/migration/channel.h
> index 8264fe327d..5110fb45a4 100644
> --- a/migration/channel.h
> +++ b/migration/channel.h
> @@ -42,4 +42,9 @@ bool migration_has_all_channels(void);
>  void migration_connect_outgoing(MigrationState *s, MigrationAddress *addr,
>                                  Error **errp);
>  void migration_connect_incoming(MigrationAddress *addr, Error **errp);
> +
> +bool migrate_channels_parse(MigrationChannelList *channels,
> +                            MigrationChannel **main_channelp,
> +                            MigrationChannel **cpr_channelp,
> +                            Error **errp);
>  #endif
> diff --git a/migration/migration.c b/migration/migration.c
> index 3c93fb23cc..98c1f38e8e 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -741,8 +741,7 @@ static void qemu_setup_incoming_migration(const char *uri, bool has_channels,
>                                            MigrationChannelList *channels,
>                                            Error **errp)
>  {
> -    g_autoptr(MigrationChannel) channel = NULL;
> -    MigrationAddress *addr = NULL;
> +    g_autoptr(MigrationChannel) main_ch = NULL;
>      MigrationIncomingState *mis = migration_incoming_get_current();
>
>      /*
> @@ -754,25 +753,20 @@ static void qemu_setup_incoming_migration(const char *uri, bool has_channels,
>      }
>
>      if (channels) {
> -        /* To verify that Migrate channel list has only item */
> -        if (channels->next) {
> -            error_setg(errp, "Channel list must have only one entry, "
> -                             "for type 'main'");
> +        if (!migrate_channels_parse(channels, &main_ch, NULL, errp)) {
>              return;
>          }
> -        addr = channels->value->addr;
>      }
>
>      if (uri) {
>          /* caller uses the old URI syntax */
> -        if (!migrate_uri_parse(uri, &channel, errp)) {
> +        if (!migrate_uri_parse(uri, &main_ch, errp)) {
>              return;
>          }
> -        addr = channel->addr;
>      }
>
>      /* transport mechanism not suitable for migration? */
> -    if (!migration_transport_compatible(addr, errp)) {
> +    if (!migration_transport_compatible(main_ch->addr, errp)) {
>          return;
>      }
>
> @@ -780,7 +774,7 @@ static void qemu_setup_incoming_migration(const char *uri, bool has_channels,
>          return;
>      }
>
> -    migration_connect_incoming(addr, errp);
> +    migration_connect_incoming(main_ch->addr, errp);
>
>      /* Close cpr socket to tell source that we are listening */
>      cpr_state_close();
> @@ -2116,10 +2110,8 @@ void qmp_migrate(const char *uri, bool has_channels,
>                   bool has_resume, bool resume, Error **errp)
>  {
>      MigrationState *s = migrate_get_current();
> -    g_autoptr(MigrationChannel) channel = NULL;
> -    MigrationAddress *addr = NULL;
> -    MigrationChannel *channelv[MIGRATION_CHANNEL_TYPE__MAX] = { NULL };
> -    MigrationChannel *cpr_channel = NULL;
> +    g_autoptr(MigrationChannel) main_ch = NULL;
> +    g_autoptr(MigrationChannel) cpr_ch = NULL;
>
>      /*
>       * Having preliminary checks for uri and channel
> @@ -2130,38 +2122,24 @@ void qmp_migrate(const char *uri, bool has_channels,
>      }
>
>      if (channels) {
> -        for ( ; channels; channels = channels->next) {
> -            MigrationChannelType type = channels->value->channel_type;
> -
> -            if (channelv[type]) {
> -                error_setg(errp, "Channel list has more than one %s entry",
> -                           MigrationChannelType_str(type));
> -                return;
> -            }
> -            channelv[type] = channels->value;
> -        }
> -        cpr_channel = channelv[MIGRATION_CHANNEL_TYPE_CPR];
> -        addr = channelv[MIGRATION_CHANNEL_TYPE_MAIN]->addr;
> -        if (!addr) {
> -            error_setg(errp, "Channel list has no main entry");
> +        if (!migrate_channels_parse(channels, &main_ch, &cpr_ch, errp)) {
>              return;
>          }
>      }
>
>      if (uri) {
>          /* caller uses the old URI syntax */
> -        if (!migrate_uri_parse(uri, &channel, errp)) {
> +        if (!migrate_uri_parse(uri, &main_ch, errp)) {
>              return;
>          }
> -        addr = channel->addr;
>      }
>
>      /* transport mechanism not suitable for migration? */
> -    if (!migration_transport_compatible(addr, errp)) {
> +    if (!migration_transport_compatible(main_ch->addr, errp)) {
>          return;
>      }
>
> -    if (migrate_mode() == MIG_MODE_CPR_TRANSFER && !cpr_channel) {
> +    if (migrate_mode() == MIG_MODE_CPR_TRANSFER && !cpr_ch) {
>          error_setg(errp, "missing 'cpr' migration channel");
>          return;
>      }

* This check for (_CPR_TRANSFER && !cpr_ch) and error could be moved
to migrate_channels_parse() as is done for the main_ch.

> @@ -2178,7 +2156,7 @@ void qmp_migrate(const char *uri, bool has_channels,
>       */
>      Error *local_err = NULL;
>
> -    if (!cpr_state_save(cpr_channel, &local_err)) {
> +    if (!cpr_state_save(cpr_ch, &local_err)) {
>          goto out;
>      }
>
> @@ -2194,10 +2172,10 @@ void qmp_migrate(const char *uri, bool has_channels,
>       */
>      if (migrate_mode() == MIG_MODE_CPR_TRANSFER) {
>          migrate_hup_add(s, cpr_state_ioc(), (GSourceFunc)qmp_migrate_finish_cb,
> -                        QAPI_CLONE(MigrationAddress, addr));
> +                        QAPI_CLONE(MigrationAddress, main_ch->addr));
>
>      } else {
> -        qmp_migrate_finish(addr, errp);
> +        qmp_migrate_finish(main_ch->addr, errp);
>      }
>
>  out:
> --

* Otherwise it looks okay.
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


