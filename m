Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D172CCA100B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 05:38:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utgCG-0001KA-0t; Wed, 03 Sep 2025 01:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1utgCE-0001Jp-VH
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 01:38:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1utgCD-0008Uc-38
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 01:38:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756877892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k+XRZztv0qffqFKfYgy3bFLc1xA4eE+XfIRoGbF2nPg=;
 b=GAMbjQct1hV7us+3p3iazLtWNfNMJlCE9EW9EDf8OpndycoOHEXKs4NBpAf8PR7ipyxWRE
 0Rdx5hLGlQj6FxAQFUA2cB3WXzkUCfn9eR3ilw2NMdDDgT6tFXKb3mkgNjHFeF3113Dk5/
 uLanJ947qUACB0T5ve1sESeUI5JO4Bw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-7YNhRWA4Op2nUdflnlipng-1; Wed, 03 Sep 2025 01:38:10 -0400
X-MC-Unique: 7YNhRWA4Op2nUdflnlipng-1
X-Mimecast-MFC-AGG-ID: 7YNhRWA4Op2nUdflnlipng_1756877889
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-324e41e946eso10987869a91.0
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 22:38:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756877889; x=1757482689;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k+XRZztv0qffqFKfYgy3bFLc1xA4eE+XfIRoGbF2nPg=;
 b=TFCtQ18TF3HEQISElTq2L2Y9SPDLmNwdMklQAMZudOuDyzjPRPAnBkrz5knqIMKtPh
 NhtzeWsICzKz34N4T0kfpfznrWzafm2PNjWGMEIjbNK1/7COy2wQs/ag6LiMwDxQcv/B
 6bunPO2GyZeGowZybT9NDoWibedXKpk7muT4OA0/d2NEzsoQx47iLr95BK4XfhKjHqB5
 CBImIwi6aZVa6FsvcqM4VfDzDn0AfeGcOmmsM7GCJN3F1MkEYQWu6ryEnOU5s9WV7E33
 GoazhprIxRg09monp+lW7GxXVeCDESd1F2NZUJawhU4m3dKtQkKKD4vKovnKBDWI1GYc
 T+8w==
X-Gm-Message-State: AOJu0Yzbca2K/fJFbAq6+ETpgLNyO/yYH5PPLMfZ5hueVDEL42MEx4OB
 S/iiBs2hniJorN+QAW1tWRPo9YEvMdYYLJUh+EuYZbeVhwBq1sacSHOA3xKlRqzLPHuCmJ02nyL
 KUui+L7LVRmm3YzBq+IPSR1TIqdolre9FzpLKDApxI4MFzgolJxnt5oyychQFIWkhhnVRxUfbx1
 FI9risioksG0Pav0TJ44qJvZY8Ppwup3w=
X-Gm-Gg: ASbGncuiQPpn1HvKvD3G3oJNx+AumqaSPYnBH7T2H5LI3F227lpRvWvi4Un8msLjVix
 ji1CNlYfJSHMIX8QCU55WoMTJYb3kyI+vjqc0jAzCPApahP2whqorQ46jnK/ryJAgnxg4dN0FYw
 HDku9g3LDnMOM65l9Aulso5Q==
X-Received: by 2002:a17:90b:5865:b0:328:a89:3dc8 with SMTP id
 98e67ed59e1d1-3281543cc5emr18210859a91.14.1756877889224; 
 Tue, 02 Sep 2025 22:38:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJzdG1m3IQCjKaUR+4j30qCXdzENwOdKK3nXriBeymPe51xGaovYBjzDewIbFtYjupJyYbSjo423eIRrrt4io=
X-Received: by 2002:a17:90b:5865:b0:328:a89:3dc8 with SMTP id
 98e67ed59e1d1-3281543cc5emr18210828a91.14.1756877888683; Tue, 02 Sep 2025
 22:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250823160323.20811-1-vsementsov@yandex-team.ru>
 <20250823160323.20811-17-vsementsov@yandex-team.ru>
In-Reply-To: <20250823160323.20811-17-vsementsov@yandex-team.ru>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 3 Sep 2025 13:37:57 +0800
X-Gm-Features: Ac12FXwyQEZ-oxJV-sJeEmC0wyqFu-gOtaQqXtzxIEir_-HeIlp-mN6kYfpYxTM
Message-ID: <CACGkMEsy9_nZYSrKf+uhbZfC3XPaVCE1iLUFfpiavNpi+sNi6A@mail.gmail.com>
Subject: Re: [PATCH v2 16/20] net/tap: introduce net_tap_fd_init_external()
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, leiyang@redhat.com, steven.sistare@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, Aug 24, 2025 at 12:03=E2=80=AFAM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Add helper that covers logic for initializing fds, given from monitor
> or helper.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  net/tap.c | 90 ++++++++++++++++++++++---------------------------------
>  1 file changed, 36 insertions(+), 54 deletions(-)
>
> diff --git a/net/tap.c b/net/tap.c
> index 27642c45a9..8cea6ed87b 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -627,13 +627,40 @@ static bool set_fd_nonblocking(int fd, const char *=
note, Error **errp)
>      return ok;
>  }
>
> +static int net_tap_fd_init_external(const Netdev *netdev, NetClientState=
 *peer,
> +                                    const char *model, const char *name,
> +                                    const char *vhostfdname,
> +                                    int *pvnet_hdr, int fd, Error **errp=
)

Is net_tap_fd_init_mon() better?

Thanks


