Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E1BE9A764
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 10:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4zJw-0006KT-Vr; Tue, 24 Mar 2026 06:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1w4zJv-0006Fz-8s
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 06:49:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1w4zJs-0000OY-SG
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 06:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774349347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cPYBG1S1s3K+YMoFMcK3kLRyXPMhOuHiZhO5uJic+MQ=;
 b=ixGvKFibP/KrwE+YfWIMLqCX+phKl/cyZvzKuz/yCKuMYCqHWj7Z53w8R7niKmY7r90VUu
 hs6/uf+N+unwUMnRkKRvvjz7v7n6jxQT6pmdhxYdZfxWqp9dWOQpmT2tgycBlX6NcRhyZy
 6fDzNprPeAKfcOMutZfXOZTbYlI1EG4=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-H3AFXul0O8iVkv8bJfWUdA-1; Tue, 24 Mar 2026 06:49:06 -0400
X-MC-Unique: H3AFXul0O8iVkv8bJfWUdA-1
X-Mimecast-MFC-AGG-ID: H3AFXul0O8iVkv8bJfWUdA_1774349346
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-799001d77fcso26876847b3.1
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 03:49:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774349345; cv=none;
 d=google.com; s=arc-20240605;
 b=Jf2wEHL+wDxC7m802mMIxveNL6ztFrQgzrcPUcaN6/E+rUhu4eGdbeH437/Z91K6QU
 zZhm81xbFnqCvKby3tMWqs86x+3gW3YXlXsRCz+hE8zMYC/lXjC5QZBIDKsG3pG4+6Gu
 b9fAPMSqZrA2xdlJoPVGBAcLt3wPIUFWknMemAm+7/ZJQf6sSfcmz8YrhO+kmTUDMgWV
 JJdXH6Ai1uF3xWX/oC0KIgUYjvcaKSM0OzgzhpeggqA2podPnXk6ZhnIrkrVg9h4QpTW
 ZoJjdt0f4k1iI/Kv+WsjhbzuKZ0U9KMZ+yNLFZodkuKKapBei8ZvZ+T6EEa/n5ENvibU
 iHCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cPYBG1S1s3K+YMoFMcK3kLRyXPMhOuHiZhO5uJic+MQ=;
 fh=/Q1walrJ1rQppfQIaR5kN+L7c1qEv+piY1FwYfW9K3g=;
 b=lJSFA+KRyM2gmPZaOnVuvexKO9OlkuXapsb284+ILh76GtOuzmFGpzC1rKs+pRxHjh
 ++KejeQQzBsRuqZk+Kydsjuan2tQRNWrjvAUT53WlBU64AUsUIVR6l1XtZHYFMh81Ifo
 acRUgoE9uTvii5+1+YhwcQ+QnakfqeMRokjlzEVXGOPAjSwJ5pSnBjOFlzEQ1SQLCUM3
 x2Qv+ooD/ilzdLb49Fcj2A+U2s4WFyrxvYIY6FNyhX4leCU794J/cG9SVxT0dlsgqw8i
 chXkIiLdWPJNrtSQuQquGg0VMdYxFjIX2MXbI9WB+R/V/iop6pZr96p2Zq+yn45NFM2G
 nFBg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774349345; x=1774954145; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cPYBG1S1s3K+YMoFMcK3kLRyXPMhOuHiZhO5uJic+MQ=;
 b=TSrg9ZMx8UsIPUbP+lDPUK1MAkf4eLngj55ha5d5kF0yxDwQyMMJVAL4knYWQK3tby
 D/48mkMmTRJHT+QtSH8egxC2D1sJgFcK6ESG5M3JkTeYHYaMpvSlNsxZQ/9kvNUDyEjj
 bwSTeYxab2sAxLDAcQEjONPNJQnn+gRNGOow4T1pnPwuTzkJQm2CH7JVmILfxqSt31mP
 C+lluA2fP49Hl/jWiiO9crf0Pk2X39ZZXyOfu1xCjPOX1hRNJJXHcM/gerLBAOUYgLUX
 8GFJNrt96Dn9Ysyb3akxUw5Fm2VV0bovuuPGbCkk8t3qY74ieDxL6JAwUjajFjUa5ltr
 mLEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774349345; x=1774954145;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cPYBG1S1s3K+YMoFMcK3kLRyXPMhOuHiZhO5uJic+MQ=;
 b=UK3djCiwi151LSH+YY1biT4U6t5Gxubxp1/p0yR+qq/5zMH08pJM1dqzw0vYE6YCAk
 OMJhWS011JW/FQjqo49BxtneV/Ry1OYqFeCf3N5soG40qxPONSaEJAfpM6AT001Jq0ap
 V8ufGilaKkk5KKe957rVg2C25R2b4hxRokR54wyVLFeAzjYCmk8rOEmdS8cVTHzCGyvK
 2dBeIQKcP/3cdyOw2plpJ3cNvO3H8aG6er/NXQv4RL2YaTHg3Ah2GKSVhWYjEeC7fkT5
 yObYEWbW0iQ9NrJb1HC7RFWTnOJTjTYrJxbb+ftSmi6LUIOyWbOf1NQDJR+ChUuWmoJF
 rjSQ==
X-Gm-Message-State: AOJu0YwQKxPOFUQ0k/0H2+oZDpkXeJ91E/fmz1TIsjDHrYPaTONAbE+y
 GtfwLqke3jbFf5Y0iaCP/+9NKP+yiU02zt/F2olvRa2nIBHmc7WQIq9e3F8wfRw/G6GOwFvZyHM
 XYgD4Q/PrqqqnlK5pdlIwi5BIu48wAKdncIJ4qzj/KSNWwG1aN0l8gJPF/TKeGv9/ORlCd/9eNH
 PYsUzDqk/x4CnYmP8CFrnjfRUke/ebkzk=
X-Gm-Gg: ATEYQzzzoLDhi4nIlH3EFX1ppsm3ibeWHXEZvOja/oEO8loaMfw3jBPwtkx0gZ0tNiD
 HnNCPwHxrPVQnsJMDFurKpd3RYwODlV5ifR12WDPtYCg7NP3ojKjIJjnm556nRcP0CZ+qjLr9SI
 UDBuwxfEyjjT72wmYm93uyBHbwBvPwLQ9ZHinE5gDoOHLHQxN52FD2iSkH/vI6U6zzPmeISX7yC
 Hp6fw==
X-Received: by 2002:a05:690c:10c:b0:79a:7157:892 with SMTP id
 00721157ae682-79a90b7ebedmr162341797b3.34.1774349345637; 
 Tue, 24 Mar 2026 03:49:05 -0700 (PDT)
X-Received: by 2002:a05:690c:10c:b0:79a:7157:892 with SMTP id
 00721157ae682-79a90b7ebedmr162341597b3.34.1774349345238; Tue, 24 Mar 2026
 03:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260320142015.3856652-1-jonah.palmer@oracle.com>
 <20260320142015.3856652-6-jonah.palmer@oracle.com>
In-Reply-To: <20260320142015.3856652-6-jonah.palmer@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 24 Mar 2026 11:48:28 +0100
X-Gm-Features: AaiRm51xxHtwaBfvyxcaxq_JdkhZlHiSfGRLqPYK6Oe_Exjxa0D5tmqvt9ph8hs
Message-ID: <CAJaqyWfNABTMcg8UUS5GaSs9C3uUMWC17auV76dAYeK8fEWxcA@mail.gmail.com>
Subject: Re: [RFC v2 05/14] virtio-net: detect VirtIODevice config buffer
 mid-migration change
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com, 
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com, 
 mst@redhat.com, sgarzare@redhat.com, jasowang@redhat.com, leiyang@redhat.com, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com, armbru@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
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

On Fri, Mar 20, 2026 at 3:21=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
om> wrote:
>
> This patch saves the config buffer and its length of a virtio-net
> device's VirtIODevice to compare with later during the stop-and-copy
> phase.
>
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---
>  hw/net/virtio-net.c        | 21 +++++++++++++++++++++
>  include/hw/virtio/virtio.h |  4 ++++
>  2 files changed, 25 insertions(+)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 2733e0130c..ca4385df1a 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3871,6 +3871,15 @@ static int virtio_net_early_pre_save(void *opaque)
>      VirtIODevMigration *vdev_mig =3D vdev->migration;
>
>      vdev_mig->status_early =3D vdev->status;
> +
> +    /* VirtIODevice config buffer snapshot */
> +    g_free(vdev_mig->config_early);
> +    vdev_mig->config_len_early =3D vdev->config_len;
> +    if (vdev->config_len) {
> +        vdev_mig->config_early =3D g_memdup2(vdev->config, vdev->config_=
len);
> +    } else {
> +        vdev_mig->config_early =3D NULL;
> +    }
>      return 0;
>  }
>
> @@ -4150,6 +4159,9 @@ static void virtio_net_device_unrealize(DeviceState=
 *dev)
>      virtio_cleanup(vdev);
>
>      if (n->early_mig) {
> +        g_free(vdev->migration->config_early);
> +        vdev->migration->config_early =3D NULL;
> +
>          g_free(vdev->migration);
>          vdev->migration =3D NULL;
>
> @@ -4251,6 +4263,15 @@ static bool virtio_net_has_delta(VirtIONet *n, Vir=
tIODevice *vdev)
>          return true;
>      }
>
> +    /* Has the VirtIODevice's config buffer changed? */
> +    if (vdev->config_len !=3D vdev_mig->config_len_early) {
> +        return true;
> +    }
> +    if (vdev->config_len && memcmp(vdev->config, vdev_mig->config_early,
> +                                   vdev->config_len) !=3D 0) {

I'm happy with this but maybe a comparison to the config generation is enou=
gh?

> +        return true;
> +    }
> +
>      /*
>       * Always return true for now until we're able to detect all possibl=
e
>       * changes to a VirtIONet device.
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 752c46ce53..9949b94b64 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -103,10 +103,14 @@ enum virtio_device_endian {
>   * struct VirtIODevMigration - Common VirtIODevice migration structure
>   * @early_load: Flag to indicate an early virtio_load for the device.
>   * @status_early: Device status at the time it was sent early.
> + * @config_len_early: Length of the config buffer at the time it was sen=
t early.
> + * @config_early: Config buffer at the time it was sent early.
>   */
>  typedef struct VirtIODevMigration {
>      bool early_load;
>      uint8_t status_early;
> +    size_t config_len_early;
> +    uint8_t *config_early;
>  } VirtIODevMigration;
>
>  /**
> --
> 2.51.0
>


