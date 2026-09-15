Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C90DC88E7D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6WK1-000770-FV; Tue, 15 Sep 2026 12:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x6WJz-00076q-P4
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:47:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x6WJy-0007TX-4H
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789490869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/C5RnETemO61ESTF719dmkJlPRhgyUaymvtOIyPJ3fA=;
 b=E7vdW45GCHTSqIblYO0KpfZduyvb6dlz8oQVOOFP7HcvwPnA6yx8XaHixinrmCUjj9ZVZi
 9MaLsoUzLM5oYbwjROP20x3yrj46/iwuG0tJhCT6ajiHsMZIuCRg/Uhq4BYW+x1D9AvwwH
 9ZTqB0ERjNYwdm1svia1pKHCPVEdHNg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-nRX6eyBvPYynACRaA57Q3w-1; Tue, 15 Sep 2026 12:47:47 -0400
X-MC-Unique: nRX6eyBvPYynACRaA57Q3w-1
X-Mimecast-MFC-AGG-ID: nRX6eyBvPYynACRaA57Q3w_1789490867
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49ccfbe060aso41216105e9.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 09:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789490867; x=1790095667; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/C5RnETemO61ESTF719dmkJlPRhgyUaymvtOIyPJ3fA=;
 b=iOAb6QB4gEF1nutzrmPlYn9LtcmaX9Ts546tpbQREPf/EIy5ruFXcFFWXouN2+vxUc
 Nid+FnEPPJnUfnH5EStgwuUrd58BYwulZTG0IxlAuWHJGY2/9IRhDHpwcWbL6asXK6W5
 yCAhaQMaqp2KPucA3NViJA9D7grPCMVUOoy+wTaNCHCMal3zViW2uUHzEbBZIdW368C1
 uXpRyGk727P8L6j6SOvJfFe9zCDFnIMeUZ6AflfY1ALOc5Fwf4i28LByoyUdb0eJ00Ut
 7pfEmor9e4s+FMil9LK/gdTXMw/LookGH3S3dJFgp7dIsJLth1wtF3yg11yNsd5YB6eZ
 bRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789490867; x=1790095667;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/C5RnETemO61ESTF719dmkJlPRhgyUaymvtOIyPJ3fA=;
 b=pL1o5xpQLGKJtS19hEtF1dHBsRS7hCNKi/l/j9TiFhr+YhcoXm4EPFbKEfQlks5kMH
 tkY/y+ILD8vCY5VhWktHXNO81xbWla+8gNsw1fte1P7ZhfJcVsGXfCa+mukeeO7AaDNY
 exAaCAeZNG8Na6QF6IZLwI8ODzOU/Kns3Ar9G2GUJr2EgQt9xcnBv6EYd6bWbElQN4bR
 cjaja744mg1MzUpEy18sjt+5E8q9ZncpqavU+7U+wQuJxtrFZ0riP40Pu4ar+dF3NZME
 iPJHuEAHEGjDzw83BEPuMqkTzkQK3HiI1eC1JoJ0LkTs66bUNKkwx1HEGaBJ+Jtt60YF
 3yjA==
X-Gm-Message-State: AFuF++mw5A4DQN4K2MBIY2gGYBK+sO7/L5Ok9utRSJQ+aJd/NKsUekXH
 7v2aEElELKndLqLhRVEKFLaaQM5DhhIcmsMd4wA6ldZwziya+KNDSX3GwZ5WAkKcbEx7DiPr3sv
 qecfLphxKoJvmvyI6L1J37WruztWtkfgrTeNn4GmEb+HmxztsLCm33cKu
X-Gm-Gg: AYBFou0p/sniIkf9xTlHFXyE418xBYk2njOnRcBsGBTKfD6bFGJRGZH4pu5Ew/5mSDm
 UPpuVmAIeIfhQtGk2d9XmPlpAOxsz19lnAV/ltD9SQ6OthZCIsI1RIKInZkiu1ogVkyWB9rLa3I
 DHg+vd2vEx5xqAkOZ4lMsCRnOtj32TPn3JQBsMDbXOp/iXnOa/M43tTNOmK0BrZ48kxnFxHDF5X
 N0A6jUvjEaAsP94L8MQiIxidcsauB/rigs49WjcQqU9PY/Fxz898x1Oiu4wd88daqKxR+r8lbVo
 Q0WKKoeKnWofGQW1EUuiL0+kULzfQLUwojzoNnyYPCLdb10wfFs/x0+UoPtkapaU62QMEGfFnNw
 Uvj8Z32nbCXHg7XkRoevc8c0=
X-Received: by 2002:a05:600c:4e89:b0:49d:7f5:4cdd with SMTP id
 5b1f17b1804b1-49e7a68d80emr88682445e9.27.1789490866634; 
 Tue, 15 Sep 2026 09:47:46 -0700 (PDT)
X-Received: by 2002:a05:600c:4e89:b0:49d:7f5:4cdd with SMTP id
 5b1f17b1804b1-49e7a68d80emr88681985e9.27.1789490866139; 
 Tue, 15 Sep 2026 09:47:46 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e83b031c3sm7590255e9.11.2026.09.15.09.47.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:47:45 -0700 (PDT)
Date: Tue, 15 Sep 2026 12:47:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?utf-8?B?0J3QuNC60L7Qu9Cw0Lkg0JfQvtGA0LjQvQ==?= <zorin@swemel.ru>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, armbru@redhat.com
Subject: Re: [PATCH] util/error, hw/net/virtio-net: fix NULL pointer
 dereference in error_vprepend
Message-ID: <20260915124114-mutt-send-email-mst@kernel.org>
References: <500d4850-f7d7-45fb-91e5-74d32d35fde2@swemel.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <500d4850-f7d7-45fb-91e5-74d32d35fde2@swemel.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Thanks for the patch! Some questions:

On Tue, Sep 15, 2026 at 07:24:39PM +0300, Николай Зорин wrote:
> SWSA#b0709cee-9722-4603-a30c-dc857dc87961

what is this?

> The `error_vprepend()` function modifies the error message inside an
> existing Error object. However, it only validated if the `errp` pointer
> itself was non-NULL, missing a check for whether the underlying Error
> object `*errp` is `NULL`.
> 
> Calling `error_reportf_err(local_error, ...)` when `local_error` is `NULL`
> invokes `error_vprepend(&local_error, ...)`, which subsequently crashes
> via a `NULL` pointer dereference during `(*errp)->msg` access.

but you then go on to remove such calls? then why do we need to change this?

> 
> Fix `util/error.c` by adding a defensive `!*errp` check inside
> `error_vprepend()`.
> 
> Additionally, fix the invalid error reporting patterns in
> `hw/net/virtio-net.c`:
> - In `vhost_user_net_save_state()` and `vhost_user_net_load_state()`, when
>   `vhdev == NULL`,

and when is that?

> calling `error_reportf_err()` with an unallocated/NULL
>   `local_error` is incorrect and unsafe. Replace it with a straightforward
>   `error_report()` call.
> - Fix a cosmetic double-space typo in "Error loading  back-end state".
> 
> 

why two empty lines here?

Fixes tag please?

> Signed-off-by: Nikolay N Zorin <zorin@swemel.ru>
> ---
>  hw/net/virtio-net.c | 14 +++++++-------
>  util/error.c        |  2 +-
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 4362e866..d505fb86 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3406,9 +3406,9 @@ static int vhost_user_net_save_state(QEMUFile *f, void
> *pv, size_t size,
> 
>      vhdev = virtio_net_get_vhost(vdev);
>      if (vhdev == NULL) {
> -        error_reportf_err(local_error,
> -                          "Error getting vhost back-end of %s device %s: ",
> -                          vdev->name, vdev->parent_obj.canonical_path);
> +        error_report("Error getting vhost back-end of %s device %s: "
> +                     "device is not using vhost\n",
> +                     vdev->name, vdev->parent_obj.canonical_path);
>          return -1;
>      }
> 
> @@ -3434,16 +3434,16 @@ static int vhost_user_net_load_state(QEMUFile *f,
> void *pv, size_t size,
> 
>      vhdev = virtio_net_get_vhost(vdev);
>      if (vhdev == NULL) {
> -        error_reportf_err(local_error,
> -                          "Error getting vhost back-end of %s device %s: ",
> -                          vdev->name, vdev->parent_obj.canonical_path);
> +        error_report("Error getting vhost back-end of %s device %s: "
> +                     "device is not using vhost\n",
> +                     vdev->name, vdev->parent_obj.canonical_path);
>          return -1;
>      }
> 
>      ret = vhost_load_backend_state(vhdev, f, &local_error);
>      if (ret < 0) {
>          error_reportf_err(local_error,
> -                          "Error loading  back-end state of %s device %s: ",
> +                          "Error loading back-end state of %s device %s: ",
>                            vdev->name, vdev->parent_obj.canonical_path);
>          return ret;
>      }
> diff --git a/util/error.c b/util/error.c
> index 673011b8..db8b5e43 100644
> --- a/util/error.c
> +++ b/util/error.c
> @@ -133,7 +133,7 @@ void error_vprepend(Error *const *errp, const char *fmt,
> va_list ap)
>  {
>      GString *newmsg;
> 
> -    if (!errp) {
> +    if (!errp || !*errp) {
>          return;
>      }
> 
> -- 
> 2.43.0


