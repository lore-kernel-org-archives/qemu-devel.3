Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B868D2ECF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 11:18:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi9kA-0006ee-Vi; Tue, 20 Jan 2026 06:17:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vi9ju-0006b2-QD
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 06:17:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vi9jt-00055d-1Y
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 06:17:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768907855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KmrAIqg4tELo+1qtFE7zN5XxLpUk+rX/gPXGCkoBrOY=;
 b=dDh/l5dGbLXL/8gOllgJQKHv868OW9SHTxcq0Xrhgf3tUOdlF8pStVPvE8fgAersmYSGb0
 IX0nELdAob9P0UDbnBNFzO7lZE8QM9rievi71lnDLPsDULGqxMlbpYcAQoGLNLuMtF4BfY
 hXML4+Ey3ttJ1al+He+xv00ZehOlcYk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-ruJnaLaMPsS4amNf6z2aSw-1; Tue, 20 Jan 2026 06:17:34 -0500
X-MC-Unique: ruJnaLaMPsS4amNf6z2aSw-1
X-Mimecast-MFC-AGG-ID: ruJnaLaMPsS4amNf6z2aSw_1768907853
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47d62cc05daso36546965e9.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 03:17:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768907853; cv=none;
 d=google.com; s=arc-20240605;
 b=EanG9NedSF7fTP6oJq4mc2RgxYbmVtpUeDqKDnBtdZj0Y6S7O5kdTaU8/RwIdopBjr
 ba+f4wUjmm+yMsQ1U/Wzu7Plv4MRKBvrGSjYUMgFnKSCvu4sodIreh/Un7QFkZWIfWQE
 i5Zk+kYaWOQsdf0f+9BaLWLAhNFgcuC8YcNKqu1aVTVC67aBhnRFhosd7QRfyWAoFa6i
 qWVwitU67BhCcO/+4byqYaU0OLYx44THlbeMJ9NGegwICRCHsK6SpRa4INi35UsHHRPF
 a8a7/aZtseq4y0qpXqlRxe0Hq+6C5c6DfLGur9IbgZBjEE67yIZUQaFpCiHESqmiOfVc
 wv0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KmrAIqg4tELo+1qtFE7zN5XxLpUk+rX/gPXGCkoBrOY=;
 fh=jjq9sOgGRsbcm1AC8tD4S17WtZ06kUg+xzgdpLFYm5U=;
 b=fCJMDUzsW+h9IhAKmvraq9P1tx98A4uGhIFSFqPE8yMHvT7DfZRgwN7I/QEhDd4tfR
 ptJf52/S6RyoSewWaLMwohgq+g1UM04ViOiQDLYWbNodhtbVfr7ZazcABjbLsTphQQbs
 V3RHVswR8XJzeg/6PNjnI+ymwhKVjwvyZ5Leq8V4G9qIg6nMrU97QTjzHggGw51U0mEe
 TirfCu8DQy3Bm37TF2Zzv/SfaIlil57+rYHW7Eqsvg3Ctrgq1wMQoL/kk8x1vD+0+xlU
 jqxH8SFdijiYuxpQw2CxK8nHW32HV3qIIXOUSSc9haO1Urxlm9pqNtJS2zewSzakjvlB
 ITWA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768907853; x=1769512653; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KmrAIqg4tELo+1qtFE7zN5XxLpUk+rX/gPXGCkoBrOY=;
 b=nbROK7ir0KWPKtdr6c32+FhoBvP3wKp7j7P5ROkCGH4JhFhUUO9wZEzG8F0VOEyoKp
 tB6xYVPdwhnEn9jhaSEJiRThaS3MKJR3oxewY87vPVp8mfjVi+0LsOyBtEo8CBL1Vf6K
 lYqteBMKieBKlpsFraKJeXtSLPAvou3Ih1Szhct8jobIGiKaSHaYVe6lbpcZx4p0/2Xn
 87mbATqcBsjLJ5LZheQkCcxFJsOLQIEz4efCdaH227jybIy7gdxfVeP2OeIYlLlLI2ab
 6nAfNxT/KO0LTHyXvCWjoMSH5Peq/evpnCVMINg/triVDcOG9eh6IWEpUyHYbhy4Yovb
 Oa7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768907853; x=1769512653;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KmrAIqg4tELo+1qtFE7zN5XxLpUk+rX/gPXGCkoBrOY=;
 b=tE6LuAkhwpIMotPuqSmOyb0kwOP2xDFPT8sIailLwLDgwAwAVaUqRZOz+GjX9bei9g
 xwCCWDsXjAdLaWbOzNpM0jEopCEYbVPYs8NG2MNFJ0GCLNQ6SdfxZfDFuuIqYYrQAgWV
 yQQRmhKN4AnS6taX0SAwd2m7GPanjHjMyCWeuTJluetBNru5GCw+rRWLu1C3vmOSH8ic
 gUlkEZNiCqpNzuUBhu0MJtnGSWk1RMsnrVGTrStbnPwNtQCkdCyGmaEXCMQeNFpkwLPM
 fKEgYVwGvlXEY0YJG1bNMfheKRIgVqumzwVs1H6VRaqC/vNluV6dY/Q6XQ8gVaQpsSD5
 xD4Q==
X-Gm-Message-State: AOJu0YyItrwVZ3FG+s7ThZ64DUN+vc4wUAKn6XV+fWtHvgwFyefCxxCb
 bUP5S+a51dKIl/0shtn1Lfhjwn6i3/TJsyeym+ScSWoCEDd/R1etDdBI+g31obfrYr0qX1kMaax
 uE5l+fli+9MhTEWSkfjxSry5BiHzVYcWHwlMFyJXBfIZ9F60lqYt8fvaa98EaSLSv6ACxiHbS/I
 35YRnzCG7MQXsmn9PVp5vqFug2AuSCqqg=
X-Gm-Gg: AY/fxX4VEVCPDpl1+tlZk74GQWuJQSExOGyhoPmJS3G5BSvvcCue8f62tESd/YyMUky
 5DS0wcgleroJELkc/WiO1xd9rCrMnTKZTkNcxrv3U9ITovi3VG3dJaxE7XvRK0bGsqxBaDguhJJ
 BEHjqm3PTttQM8fZNb9n2jdkV4/VpoQMZios4mBCSI9AOB7nkKbl/xy89yHcfUzdfgaiSyzAsjt
 HqLLjdm+hacQu+cwmQDbbBfwlhHuEfpqEdLGy8xtNWLVOfED3TKMIpE
X-Received: by 2002:a05:600c:6085:b0:477:7ab8:aba with SMTP id
 5b1f17b1804b1-4803e79b854mr21062885e9.1.1768907852866; 
 Tue, 20 Jan 2026 03:17:32 -0800 (PST)
X-Received: by 2002:a05:600c:6085:b0:477:7ab8:aba with SMTP id
 5b1f17b1804b1-4803e79b854mr21062415e9.1.1768907852426; Tue, 20 Jan 2026
 03:17:32 -0800 (PST)
MIME-Version: 1.0
References: <20260109124043.25019-1-farosas@suse.de>
 <20260109124043.25019-23-farosas@suse.de>
In-Reply-To: <20260109124043.25019-23-farosas@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 20 Jan 2026 16:47:15 +0530
X-Gm-Features: AZwV_QjQRVoPj6I41cAUxH4CJHyLf9P39MfGhvr16gtSavDZrMLMxYGKOAyd2rI
Message-ID: <CAE8KmOwWENO6eaUw21BjGdRLxbVTpfHQSeBjph+n4pbTegJNnQ@mail.gmail.com>
Subject: Re: [PATCH v3 22/25] migration: Free cpr-transfer MigrationAddress
 along with gsource
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com, 
 Mark Kanda <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>
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

On Fri, 9 Jan 2026 at 18:19, Fabiano Rosas <farosas@suse.de> wrote:
> When setting a callback on a Glib source and giving it a data pointer,
> it's natural to also provide the destructor for the data in question.
>
> Since migrate_hup_add() already needs to clone the MigrationAddress
> when setting the qmp_migrate_finish_cb callback, also pass the
> qapi_free_MigrationAddress as the GDestroyNotify callback.
>
> With this the address doesn't need to be freed at the callback body,
> making the management of that memory slight simpler.

* slight -> slightly  OR  just skip it. ->  ... memory simpler.

> (also fix the indentation of migrate_hup_add)

* This note could be purged.

> Cc: Mark Kanda <mark.kanda@oracle.com>
> Cc: Ben Chaney <bchaney@akamai.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/migration.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 52c1bb5da2..5167233f76 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2007,9 +2007,11 @@ static void qmp_migrate_finish(MigrationAddress *addr, Error **errp);
>  static void migrate_hup_add(MigrationState *s, QIOChannel *ioc, GSourceFunc cb,
>                              void *opaque)
>  {
> -        s->hup_source = qio_channel_create_watch(ioc, G_IO_HUP);
> -        g_source_set_callback(s->hup_source, cb, opaque, NULL);
> -        g_source_attach(s->hup_source, NULL);
> +    s->hup_source = qio_channel_create_watch(ioc, G_IO_HUP);
> +    g_source_set_callback(s->hup_source, cb,
> +                          QAPI_CLONE(MigrationAddress, opaque),
> +                          (GDestroyNotify)qapi_free_MigrationAddress);
> +    g_source_attach(s->hup_source, NULL);
>  }
>
>  static void migrate_hup_delete(MigrationState *s)
> @@ -2028,7 +2030,6 @@ static gboolean qmp_migrate_finish_cb(QIOChannel *channel,
>      MigrationAddress *addr = opaque;
>
>      qmp_migrate_finish(addr, NULL);
> -    qapi_free_MigrationAddress(addr);
>      return G_SOURCE_REMOVE;
>  }
>
> @@ -2083,7 +2084,7 @@ void qmp_migrate(const char *uri, bool has_channels,
>       */
>      if (migrate_mode() == MIG_MODE_CPR_TRANSFER) {
>          migrate_hup_add(s, cpr_state_ioc(), (GSourceFunc)qmp_migrate_finish_cb,
> -                        QAPI_CLONE(MigrationAddress, main_ch->addr));
> +                        main_ch->addr);
>
>      } else {
>          qmp_migrate_finish(main_ch->addr, errp);
> --

* Looks okay.
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


