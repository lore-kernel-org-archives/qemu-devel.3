Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB77FD2D0E4
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 12:40:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfdge-0002YK-On; Tue, 13 Jan 2026 07:39:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vfdgY-0002Vv-Dc
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 07:39:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vfdgW-000699-UL
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 07:39:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768307983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h7ouMIFI6HjHZBMbGXca7m5E0DyWxjt897rw7+G6hAY=;
 b=Xn3Cs6NcCgQ0EDpPd6KOYHyEfDu58dXtKPsuFr/6npseXVfRAcknqeC1UbozOqMBgJIqk5
 qlVR+XB4+/2xOSVmOqC00qHi9dxMAMc7UQIsqkD/Sleo17U++U1GP9YZKazhIkAC0O5Nsb
 6a9td9rz8Qq3mxjh0Keo1oYgPYIIbuw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-5uLbFobjOLeNAhAK_O2SyQ-1; Tue, 13 Jan 2026 07:39:42 -0500
X-MC-Unique: 5uLbFobjOLeNAhAK_O2SyQ-1
X-Mimecast-MFC-AGG-ID: 5uLbFobjOLeNAhAK_O2SyQ_1768307981
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47d4029340aso77304375e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 04:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768307981; x=1768912781; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h7ouMIFI6HjHZBMbGXca7m5E0DyWxjt897rw7+G6hAY=;
 b=fPOyQCry+3yUKxlodWd81BuzEIa48wM6yf7vifBjHdQ5q+ijHuxWATH+ZoZM6UpOvf
 ZvJyIc9feUVv1JAyCKKmHgoTYzku8vBxa6p9ld9Heq4pJ6Gqn9So3uDksA1QWPCJ9zoI
 ZO8BLE4Y5wFSmewkEyxMq44k5gs+r0bsaoOjQ/hIf9KEpLKJkx+HQHlrsonqUNbpi4XV
 UqrCCl2Tpkr+1fQXS5sRDafEEzOwWSlLuGVojsT+Rcwh2DJqDLhInw2xsJZMZQXI7KIr
 PAeLpP9b1+7yAHVhJOKat/AXcZQGPrCwgLamNZzX3jbMWuWBwJRnC9WpqqOdLrhoeOgs
 a7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768307981; x=1768912781;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h7ouMIFI6HjHZBMbGXca7m5E0DyWxjt897rw7+G6hAY=;
 b=tpx4EkgzlaLUtWApeSTIOzWW+PQTfhQc8Y3ihzliy8PVmyr2yNMClbgLPIG9pSHSXV
 0H4P51BhLhhnD5hpptKvxXJdhn1Dc1i1uzJ8EbpDJdhI3VXPitlgJd4QMSs1eKVkdJdc
 L3dQkMiV6cDdDycj1Iy03KxudeUr9tQbroKNIh+fWlI4Nxe1Jy6gCaBmJtcUoa4xEWoi
 OILYQD8OrYZKoDZsNetGQUMLF3+JdwVunPpVBT8gidtnip53YTdd5s6KHszymSMuzMMH
 kWiH6kdUL12MP9R0i14mZ0x2RWTwWlDTDquG49wDJQRJ57oodqxXxCslbEX+1o+uw1Dk
 uq8g==
X-Gm-Message-State: AOJu0YyTxRpveLAiwIzrlCvVlk4YApyCGQhadYTo2GC0oKQJsKy5Yh30
 V3/1ljWzaizPxp2iJSHWh/le0sDwOdxm+PYOL0xVqkC9uNOPgF1cODL/943pOLcfcTGDfF+pCHn
 A8mtyWV4yX0VOcIhhYYcqGyAaUOsIEF09fY+HMKysQrJQzXB82wvbiCX03yMlTPKx2ieVv7xVUh
 xOYQ4AiyG0IDl+s1FmY6N4aROkFr1XtfM=
X-Gm-Gg: AY/fxX4Lr22kbdG3VisggxMfq9GI4FKMrcjCOkB5E12gpDebmYzg/paTvZqSAnm02nJ
 3pnGwwnqB9UQfHSCgc2rVtU0rkQFbeyKYrnCF3L0H6YSFTi7xXAa6gmG6HRw/5Gr2fpwez36Gcv
 06o01OvpVAFvkWhHOVNU4OMWVXUQ3brkmOZFBY9HAvPJA1mMqimKYdZyIyLD21RJCR+SyIxGaT/
 QU0/a/b0xumFXLQK9CuwfXpTOaXX8tlDjE/L48WAgEbObbDgvMa4hDR
X-Received: by 2002:a05:600c:1f13:b0:477:98f7:2aec with SMTP id
 5b1f17b1804b1-47d84b086d7mr241104735e9.3.1768307981190; 
 Tue, 13 Jan 2026 04:39:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGiDI7YKMl0iyNWdziYPQuWC9P+wk1nssfXnTktKDRR++hwv7SubmOO8sNFEws4aVcVgd7sbnBE3vEBgGBrq2c=
X-Received: by 2002:a05:600c:1f13:b0:477:98f7:2aec with SMTP id
 5b1f17b1804b1-47d84b086d7mr241104405e9.3.1768307980830; Tue, 13 Jan 2026
 04:39:40 -0800 (PST)
MIME-Version: 1.0
References: <20260109124043.25019-1-farosas@suse.de>
 <20260109124043.25019-3-farosas@suse.de>
In-Reply-To: <20260109124043.25019-3-farosas@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 13 Jan 2026 18:09:23 +0530
X-Gm-Features: AZwV_QhKHLrZk7OqZcEP8woQQWYH-3WDMPoEq6N6980SHIoHvHgZ_DxryU2H9O8
Message-ID: <CAE8KmOwD5u8q_bDVXLQuiiC267qr22A6=F7_B4zuxePGauBpuw@mail.gmail.com>
Subject: Re: [PATCH v3 02/25] migration: Fix state change at
 migration_channel_process_incoming
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, 9 Jan 2026 at 18:11, Fabiano Rosas <farosas@suse.de> wrote:
> When the incoming migration fails during the channel connection phase,
> the state transition to FAILED is currently being done in the
> MigrationState->state, but the MigrationIncomingState->state is the
> one that should be used.
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/channel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/migration/channel.c b/migration/channel.c
> index 92435fa7f7..4768c71455 100644
> --- a/migration/channel.c
> +++ b/migration/channel.c
> @@ -48,7 +48,7 @@ void migration_channel_process_incoming(QIOChannel *ioc)
>
>      if (local_err) {
>          error_report_err(local_err);
> -        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
> +        migrate_set_state(&mis->state, mis->state, MIGRATION_STATUS_FAILED);
>          if (mis->exit_on_error) {
>              exit(EXIT_FAILURE);
>          }

* Change looks okay. (/me makes a note to see if we could combine
MigrationState and MigrationIncomingState, why couldn't we use the
same struct/object on both source and destination sides?).

Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


