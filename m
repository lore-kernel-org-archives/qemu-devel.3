Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC03D2ECF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 11:07:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi9a2-0000PD-IB; Tue, 20 Jan 2026 06:07:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vi9a1-0000Ow-9J
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 06:07:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vi9Zz-0003ob-6r
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 06:07:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768907241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J+D9rSUXqfsXN9SEQp7srK755p+CLrSem0MTmOU+OhI=;
 b=MlIPWSbZRfsiOyxqsVgOVUMtrjUN9Ij0TlEQ4PuotATxvTWCEE5afWDM+JFibTVq/LVmUh
 GAvRLkhyHY/NXJTwgzuSycao7j3NChDq88g47ElBbFmZ5gtIFli8hKH6H3V0FNvcdXsQoP
 u2LyLYCYTdKQU3cDDpW/b6R89esyvaE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-kb_S-pWiNlOXZQ2FGMafWg-1; Tue, 20 Jan 2026 06:07:20 -0500
X-MC-Unique: kb_S-pWiNlOXZQ2FGMafWg-1
X-Mimecast-MFC-AGG-ID: kb_S-pWiNlOXZQ2FGMafWg_1768907239
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43102ac1da8so4408551f8f.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 03:07:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768907238; cv=none;
 d=google.com; s=arc-20240605;
 b=HqjP/CMVY6NAjP3dOA8nHNEbOOF4fRR3gDs4ax+iACturw36UmoNijhFC7O4d5dj9x
 TgzgIXeIdytS2DMPFVE6+v2xRJxyu63CDew0v/zR9Pdm/8ikzQjJOA1Oii+LV1rHqyih
 ZJEVVYQGAFFXcmxzq4klBkgjmOxekW0qr3nQBK0WBoPi7Y8MRXClO1VAe8e/89pQ2LUZ
 BkiPFMsRpmW0udN2DWWa4UVZ9/C42cdmlObzgnh+CgDVFSzcKrmKNWEcIrPrcP2Xt9Lb
 Ycgl36V5g8d1TccSqlIIMee6aZOzimQc+ymGjh8ortELAkrd2aPWpDYv6V2o4f5hr70r
 4fIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=J+D9rSUXqfsXN9SEQp7srK755p+CLrSem0MTmOU+OhI=;
 fh=SJ3HPovJyRUvRbjEYgfW8f8/HsJC2a+l/HOVRBs3/Wg=;
 b=cNEqA2EkGm9H08lHCFyf8AhWkdgSPoiiKZsd/xLq5wm71KuxziPDuPbLbQAchG/b8p
 uadBInIlvxrgYJLZ8dFPojXS1HRZs7pdu+dg7PPResYv+SAV3IKyLAzskuKzhPgdpvsF
 ee0PEqfOVbvqGqAsa39h94UvhQiQBJvUQsyRGoKJPYZ6fwDL0u/cDlvdfx7Jaj+wLBcQ
 H260n0YnalI0rc7cYZ9clpEpR1AXyOXLDWJXTt7DLpGgn5e+XWnrw8jARa82KZr8WCEh
 H7HJ+Qct9x1a80/dqiUaA4OaVtfOswtwLbZFUqZr1CFfQKjN8wze8FSynAwktkZJoMhX
 uKUw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768907238; x=1769512038; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J+D9rSUXqfsXN9SEQp7srK755p+CLrSem0MTmOU+OhI=;
 b=gu59Xh6uRLcnKVBpXFOgDntJSiK8t8JpuI0Esv2GHPwzmdpYHAwEFIVfEqUerUYGOk
 hcDmqHYVzgFGQDXc3glhnBdfDdSjkdHZsqpwM2JAFGJn0Y1BmFq0urUjNeEfzowvsU2g
 OZN02soj9zHG8oT2VroEZiCG4VQ4bR1JfqEHo+VlRDmzZQF/U+JD17+EwycvzczKI0E7
 l1jiEtjKV81frwfMaeVTjMvnCW6ZvhDm5iaOkZwX2kwjaOMqe+2g5dMYjNA9er/g/+Kn
 Hot570AyHaAt1ETzhlmZN5DTLVc1YwZ4BiV1BnN/xj3VjtXTZ8BNqa1Ziw4D1JIO0XBB
 XTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768907238; x=1769512038;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J+D9rSUXqfsXN9SEQp7srK755p+CLrSem0MTmOU+OhI=;
 b=SGbpBZU88GIr7qkeTgmn7NuURevZ2oYKQAq//KY5RgEj/OKNEMbk87NwnyG+o2UwLF
 IKYRWjWlbs0riXaeH7avoqPR80wbVdyzh6OaAQGUoDVlHRhJpK/jl1aUjpexaIXHI5BD
 w6VrfQxKo1L+QDlBXQ1RQSHF+1IszSAc85Q4flOxpUbcXuuvcKVdANsSC3UjvzMgOf8u
 dD13u4qbWYA6WyRMUy6M6BbBc2MV3aKwMziM1fMUlVFv/T2Ng/6/p0X6/kbaa5ZTFCxa
 hj9fS0s9buGPbQ6jugBq5aOaioBSYW1AH0mduvjzWLItylWYqXokLKS6hacpZrFbOmf+
 r8Sg==
X-Gm-Message-State: AOJu0YzBo7raXERPXFcZRG+iOVilO3HzWodsuzfALfzClvjHbyWeQIcb
 vbp6my9veeV5jRUfmDRsbWOH79E4xd5xhC2+PFi5f9pc7rSD0fzvKq5BNVPkFQPQvx/iLxo887/
 JrQMGggyeXB5JVpnIsoCSYOW9m/BaGb9+ILjzqRakYlwXMTUQUZxrQGCtMTRrpKSCVtwgKwiekj
 5wdtQcqdPl8btDcnrzPqMRRbEgupwDKVMxxomER9rFsw==
X-Gm-Gg: AY/fxX4PDVfHcFFQvpqRwjT45ecaCY3EQwjGHJuNASDB9f6CQCS42b8GSBU/M06cto8
 +75UPhvWau5BZN0bDSVkH9SYYnPZiGTTiTlaAqrXKuu8MjVtoX7y/d2iucblu/rc9+3YK1X33PI
 Ze7JW2/A4T7hOUjwCWovLilqTObmZADsEi1U0H5caYfjECB4zJjYFsewUzADty1lgvZXIR42J60
 KKbXOEP76MN5RHooPmBn0ViGrbgynSNp7jEXCByKPZ4kpeQtW1XEftx
X-Received: by 2002:a05:600c:1d14:b0:47d:4fbe:e6cc with SMTP id
 5b1f17b1804b1-4803e7a39damr20169855e9.13.1768907238018; 
 Tue, 20 Jan 2026 03:07:18 -0800 (PST)
X-Received: by 2002:a05:600c:1d14:b0:47d:4fbe:e6cc with SMTP id
 5b1f17b1804b1-4803e7a39damr20169475e9.13.1768907237503; Tue, 20 Jan 2026
 03:07:17 -0800 (PST)
MIME-Version: 1.0
References: <20260109124043.25019-1-farosas@suse.de>
 <20260109124043.25019-25-farosas@suse.de>
In-Reply-To: <20260109124043.25019-25-farosas@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 20 Jan 2026 16:37:00 +0530
X-Gm-Features: AZwV_Qg6vAR_Dap2uM5MhN9c6ZtLllRh_qGvw2OmK1LcXmtSNW-cApHL4tAA70k
Message-ID: <CAE8KmOyns_hmR-uU-qUmUCLD0uj9uhbBbn3mu-LEZPjXnroK2A@mail.gmail.com>
Subject: Re: [PATCH v3 24/25] migration: Remove qmp_migrate_finish
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> After cleanups, the qmp_migrate_finish function is now just a call to
> migration_connect_outgoing(). Remove qmp_migrate_finish() and rename
> the qmp_migrate_finish_cb callback.
>
> This also allows the function's error handling to be removed as it now
> receives &local_err like the rest of the callees of qmp_migrate().
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/migration.c | 35 +++++++++++++----------------------
>  1 file changed, 13 insertions(+), 22 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 6be2849326..086bbb03de 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2001,15 +2001,18 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
>      return true;
>  }
>
> -static void qmp_migrate_finish(MigrationAddress *addr, Error **errp);
> -
> -static gboolean qmp_migrate_finish_cb(QIOChannel *channel,
> -                                      GIOCondition cond,
> -                                      void *opaque)
> +static gboolean migration_connect_outgoing_cb(QIOChannel *channel,
> +                                              GIOCondition cond, void *opaque)
>  {
> -    MigrationAddress *addr = opaque;
> +    MigrationState *s = migrate_get_current();
> +    Error *local_err = NULL;
> +
> +    migration_connect_outgoing(s, opaque, &local_err);
> +
> +    if (local_err) {
> +        migration_connect_error_propagate(s, local_err);
> +    }
>
> -    qmp_migrate_finish(addr, NULL);
>      return G_SOURCE_REMOVE;
>  }
>
> @@ -2063,10 +2066,11 @@ void qmp_migrate(const char *uri, bool has_channels,
>       * connection, so qmp_migrate_finish will fail to connect, and then recover.
>       */
>      if (migrate_mode() == MIG_MODE_CPR_TRANSFER) {
> -        cpr_transfer_add_hup_watch(s, qmp_migrate_finish_cb, main_ch->addr);
> +        cpr_transfer_add_hup_watch(s, migration_connect_outgoing_cb,
> +                                   main_ch->addr);
>
>      } else {
> -        qmp_migrate_finish(main_ch->addr, errp);
> +        migration_connect_outgoing(s, main_ch->addr, &local_err);
>      }
>
>  out:
> @@ -2076,19 +2080,6 @@ out:
>      }
>  }
>
> -static void qmp_migrate_finish(MigrationAddress *addr, Error **errp)
> -{
> -    MigrationState *s = migrate_get_current();
> -    Error *local_err = NULL;
> -
> -    migration_connect_outgoing(s, addr, &local_err);
> -
> -    if (local_err) {
> -        migration_connect_error_propagate(s, error_copy(local_err));
> -        error_propagate(errp, local_err);
> -    }
> -}
> -
>  void qmp_migrate_cancel(Error **errp)
>  {
>      /*
> --

* Nice. Looks good.
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


