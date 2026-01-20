Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A8FD2ED0F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 09:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi7q0-0005Cm-0r; Tue, 20 Jan 2026 04:15:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vi7px-0005Bn-VY
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 04:15:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vi7pw-00038t-As
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 04:15:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768900543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EcZZ11HWZ1UFZzG3th4x628mGWHBmKQFlgxNIk++NqY=;
 b=KBtF3EHOC6ZEc+o/uGCq1g1Men6lU3j2eJh110jf2lJIW8/m8A5w2wTowjx1w8BUD2CWRv
 tjUyvPhlUvZw+8rk/Uqilwu/nsMkmYQr2cDk6axc3bBUbut7NcPHIGpWmhmSme9ut1zAxH
 AdUiBPXI3ijaMcrxKxnKY+8J03Iqrec=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-0uRuwvQHNwy2Cukx8itaTw-1; Tue, 20 Jan 2026 04:15:41 -0500
X-MC-Unique: 0uRuwvQHNwy2Cukx8itaTw-1
X-Mimecast-MFC-AGG-ID: 0uRuwvQHNwy2Cukx8itaTw_1768900541
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47ee868f5adso38707155e9.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 01:15:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768900541; cv=none;
 d=google.com; s=arc-20240605;
 b=bh2FLIKoY78N0UpFvETI+qewFOLgs+4REXedpkhkqUQ0d9eHfcz8NyInG/Mf/VAKEj
 57c1XnCcObPG8h5oOixAcdPkaQ0De06TWmCrgy1fOl5ygfWM1hVdHVaMyQlMIMsTs7+N
 402rKeraviJfqPqHJbokSxSrPK12O6bvw8QDL82Xmc3CE0gamrXiVaeyS9Gi2KVMDt+8
 JT4TXPOjd78T+Cdmmq/E1dn+cl/NLdydYdOVvWpfhcRGdycjNxNfcqlJ1rC06HGeN7Cb
 c1jUMsejEzNy44av2J9/xW78IrQI68D49JDIvjxERSyHpm/Lec2Oke7dH55Gy6RzWgNB
 nn2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EcZZ11HWZ1UFZzG3th4x628mGWHBmKQFlgxNIk++NqY=;
 fh=SJ3HPovJyRUvRbjEYgfW8f8/HsJC2a+l/HOVRBs3/Wg=;
 b=W0Jlxd9aJNBYjNR5nYM+mmVKOVZQFHBQPBVr3h/thncbyIO02Lco95nrOD4zaM24hv
 b2QHq/d4ZAmHo2IPse/VluK3+MxUg52Y5/DcyK/3RbIzAbsD/NKznMNvxB6TvAh6wEG7
 Lqdpnlph+vI9BFZpR1C4ViAtbzi0WoQu052mWFY0ieHENvm4GQ+Un34ZUBweWe/D/FXm
 QjwMUgz/IqfxK+7sMByK39Eth62Z9aAlVfEeR4cyuqOC0Q2DnaTa3hhF3iF2zmuageCQ
 267siAevhjlKb+k+GzVyG1owsp7BQ/C1j7y5qLQKSJCWD+JYiBvXt63FkzPZYGYer1mB
 eYmg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768900541; x=1769505341; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EcZZ11HWZ1UFZzG3th4x628mGWHBmKQFlgxNIk++NqY=;
 b=tRzwPjt/2rx9HVk1KLcbB2vGWStQvbqLwOLIaVT2rJHTJMDNZODWdgVtXXsS6iniQK
 yG3D6s6jHv/y2HrffrAOsfv1otTt7JgUMgXOhLRXsedeXfcEhlVda5lcsz1kv4ldQ5gS
 PrpcUcVrgu8NxmxXHnGdtFL/H/vx1om09elypNSWNRImTlLZlDSfu3ZPVqT8dZpwXQk5
 G4cjb2HdO1wSa9zVRDpQddySxmyBmRj4PTlpRoFnbKTjBXSXrM9k8nMQ234wkR+Iyn6c
 YSt7MKo1aG/zxBTT2nA/qouVSXlgOAGDJRsJJEN7YPj9taVpYVNTCUJIQRowXb66Jxj8
 uGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768900541; x=1769505341;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EcZZ11HWZ1UFZzG3th4x628mGWHBmKQFlgxNIk++NqY=;
 b=kuR6am0EkOEZzMbMkXF+4oRzE4crV2TuKEXjoCC0mCaK1Fo4F7M4g/K3fmA99ZSsLe
 iVoIjkCMK3a7uG6T8jWyawBbfZWXal2nuki6DDq5lnuNncLSkqk6K7MYW/Y7WfTsBSPL
 pICZrASObYgQq27vV023OJxUCKGPaO0dSGf6SLUABJjBpHi5MAyKCfu/EGj0gre8Tf0m
 VvYRkATByoJ5ri82ouP4IIu/eJ6LPVcNuUvdhgCbgw9dJZ9kqSbaIqvPpMa4J+hE//yv
 M8IiTwD/AYNDTWdWvjL9+NIoDvUhCK4SJ3nH7Brky5MF5+C/DZcZdmvXMSpFSnbZrO5A
 0cAA==
X-Gm-Message-State: AOJu0Yxl4BaWy+ZWFA+aRThsVw7p3XPLq2m+GCzg2nh5mnvlNSVXSHKW
 WwnoSXKZFbh8BXgyhtKzx9lF25iK3rNCRYz8hKuXbcAcgaFXcYedbYTFdhhz5aqDuLBtEJ5lRS+
 rA0Rwy9EC/81ZvWttfYbXGzeTv5jx8g9GGIjndHGTRD+n8sGvJc/NZ45XuhVgSWKFa3wtEc8D7M
 XD3LT8x8mRlhLzuRnXlAbW4bnLW199FVg=
X-Gm-Gg: AY/fxX6Ie84s/qo1ALCiiRJR6zY/iVFKIPwjaAfDwvzb+tBU5oMpqahZKAY/4Vd8/qX
 R7Ew3gXlWlZy50Q1BeK1eJpWFui4WymSLIM/58OQFjFTR8MH7W8uDpLGX6EmV6T+grKGMLWQdZs
 s8uaQKk77Df35vgR47ulhpDMzzrj8ju6X8LPdZihFvFXPwmEW2uPylkiWSXDUXbPbJVJuuePcbB
 2WkXx9l/EfQxs1skvFWocbDCI5jBxel0qCP7u6CxKLHpuUA3GrR83Ej
X-Received: by 2002:a05:600c:5493:b0:480:3a71:92b2 with SMTP id
 5b1f17b1804b1-4803a71968bmr56949505e9.26.1768900540603; 
 Tue, 20 Jan 2026 01:15:40 -0800 (PST)
X-Received: by 2002:a05:600c:5493:b0:480:3a71:92b2 with SMTP id
 5b1f17b1804b1-4803a71968bmr56949285e9.26.1768900540245; Tue, 20 Jan 2026
 01:15:40 -0800 (PST)
MIME-Version: 1.0
References: <20260109124043.25019-1-farosas@suse.de>
 <20260109124043.25019-10-farosas@suse.de>
In-Reply-To: <20260109124043.25019-10-farosas@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 20 Jan 2026 14:45:23 +0530
X-Gm-Features: AZwV_QiFn3M8KnN8DH6uEnleusGzmWB6rYeE9H-GeMlJGuWrv0EQHyW17ss77gk
Message-ID: <CAE8KmOxW65J104Ta9NLHJDUGdo5hb5RVDbQSi9QMt8SphF-Y0w@mail.gmail.com>
Subject: Re: [PATCH v3 09/25] migration: Expand
 migration_connect_error_propagate to cover cancelling
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

On Fri, 9 Jan 2026 at 18:13, Fabiano Rosas <farosas@suse.de> wrote:
> (add some line breaks for legibility)

* This note could be expunged. It's only helpful for reviews.

> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/migration.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 7bef787f00..259b60af04 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1575,18 +1575,25 @@ static void migrate_error_free(MigrationState *s)
>  static void migration_connect_error_propagate(MigrationState *s, Error *error)
>  {
>      MigrationStatus current = s->state;
> -    MigrationStatus next;
> -
> -    assert(s->to_dst_file == NULL);
> +    MigrationStatus next = MIGRATION_STATUS_NONE;
>
>      switch (current) {
>      case MIGRATION_STATUS_SETUP:
>          next = MIGRATION_STATUS_FAILED;
>          break;
> +
>      case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
>          /* Never fail a postcopy migration; switch back to PAUSED instead */
>          next = MIGRATION_STATUS_POSTCOPY_PAUSED;
>          break;
> +
> +    case MIGRATION_STATUS_CANCELLING:
> +        /*
> +         * Don't move out of CANCELLING, the only valid transition is to
> +         * CANCELLED, at migration_cleanup().
> +         */
> +        break;
> +
>      default:
>          /*
>           * This really shouldn't happen. Just be careful to not crash a VM
> @@ -1597,7 +1604,10 @@ static void migration_connect_error_propagate(MigrationState *s, Error *error)
>          return;
>      }
>
> -    migrate_set_state(&s->state, current, next);
> +    if (next) {
> +        migrate_set_state(&s->state, current, next);
> +    }
> +
>      migrate_error_propagate(s, error);
>  }
>
> @@ -4106,10 +4116,7 @@ void migration_connect(MigrationState *s, Error *error_in)
>      return;
>
>  fail:
> -    migrate_error_propagate(s, error_copy(local_err));
> -    if (s->state != MIGRATION_STATUS_CANCELLING) {
> -        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
> -    }
> +    migration_connect_error_propagate(s, local_err);
>      migration_cleanup(s);
>      if (s->error) {
>          error_report_err(error_copy(s->error));
> --

* Looks okay.
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


