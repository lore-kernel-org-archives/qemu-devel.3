Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 160BAC369C2
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Apr 2025 03:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6hlQ-0001Eh-86; Sun, 20 Apr 2025 23:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1u6hlM-0001Dy-Ol
 for qemu-devel@nongnu.org; Sun, 20 Apr 2025 23:24:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1u6hlK-0002Xv-PV
 for qemu-devel@nongnu.org; Sun, 20 Apr 2025 23:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745205841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v8YlgNOSiNEET7zj+xYP/iF3DeiPUGBJ7d+1nyGqkis=;
 b=C/5WwoLYgZ1gsO/6Ln6PoxL6t/hP6BdoKV0BC+Oa2r3xEvhMlePMMCUJEaAo1jEgRBYDcm
 wBd6lt22/aHYCQD3RV/XusYD6pzBspCpCsatse7cbWK66EaSIu+tW3raB09OvmrkoreHTZ
 UGSnweFvjYTsvYwuqBxCod1slH+dyB4=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-C9rnq5PpMpqU7y8XgVXTmA-1; Sun, 20 Apr 2025 23:22:43 -0400
X-MC-Unique: C9rnq5PpMpqU7y8XgVXTmA-1
X-Mimecast-MFC-AGG-ID: C9rnq5PpMpqU7y8XgVXTmA_1745205763
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b090c7c2c6aso2211381a12.0
 for <qemu-devel@nongnu.org>; Sun, 20 Apr 2025 20:22:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745205762; x=1745810562;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v8YlgNOSiNEET7zj+xYP/iF3DeiPUGBJ7d+1nyGqkis=;
 b=gz33TfYhb2iDUJyzrqsjbu2IqAhHEEKBerHcewYlyVZnvoUaAha/uPS0hb3vPsXu5A
 h8stm0rRodhuR/i44fiEET07Hx1MYSIEQcILIAxWnoLKgr9MntqEka6p1N8Lswj0EvKf
 w3A8GAV8tgxGTLT4dp7ud6SHMrTPWX9ipGzdLALppnXWqNZXa9k5HxXvgRqSZFIU9QSZ
 /S/tilYkCHBnh3skDJl3TdW0NupaSEiyrsxGg0BBi6Mo7bnuPwYFOzCnDO0f8h7LZIJX
 Mi012CqbJ47j2f5kkslenELzOMqGXSvBLvEUb9FUwEhUign/UTubEQP7bNKa28bkKmCZ
 4xDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQXmNqk38VpBGYV2j2kcFCMjPBLsZxaWh/h7y98NN4mneK+DenOWVO124XYfoL4ibEgmjVtOwZ68IY@nongnu.org
X-Gm-Message-State: AOJu0Ywqcd8g5Fwtx6moIQbdMB7n1b/ke5uEholBegYI7NriBrxsHXzL
 CdrxmCT7sh9Cjjyr/4n/6HsJ8IIVqCsWDwUn3GplIoLNfFyuZT8psbfXAETNEHEKqunJnOMW0bC
 EkYqYDSUBhhHgg/Vp7tkfkXK3wCHjNSa9vHcFDg+zEStB/CSwyvqTLBons7OhvOxNm2D0/xhiZL
 7l/fTZ5/+cIW7SNeWoW2Gzk18I1qU=
X-Gm-Gg: ASbGncvHE4Vl5X/P/xeQ7/F1kUsjAz8nIfPzyRnJ0xpKqmRBDFNE938syNdvA8oA/fd
 V8W8LZOf/xZIPmuTVljAFsH+wL/9C/trzrQVcLPsZupZQnxkzkWAepTQ+qYA2mIQl+iO9eg==
X-Received: by 2002:a17:90b:5444:b0:2f6:d266:f467 with SMTP id
 98e67ed59e1d1-3087bcc8b37mr12744859a91.34.1745205762615; 
 Sun, 20 Apr 2025 20:22:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVSbgubvhW4cAEXbs/rGFl6pD/pFeoVYfuFrV2XocyGXcTPjsCXZbSEa3HLFez7LvF0StXWX3PVXff3WtadKk=
X-Received: by 2002:a17:90b:5444:b0:2f6:d266:f467 with SMTP id
 98e67ed59e1d1-3087bcc8b37mr12744850a91.34.1745205762272; Sun, 20 Apr 2025
 20:22:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250417102522.4125379-1-lulu@redhat.com>
 <20250417102522.4125379-5-lulu@redhat.com>
In-Reply-To: <20250417102522.4125379-5-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 21 Apr 2025 11:22:29 +0800
X-Gm-Features: ATxdqUESeqHeInahpzuMNEatHz5MDwigBYXSFAOEWbIRrr9VKPp5b9PtagVaa_U
Message-ID: <CACGkMEsKmFZ_QaZZFohJvouQ9CWbPbOY56KJ27hBdfVFJiWORg@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] virtio_net: Add third acceptable configuration for
 MAC setup.
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.69,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Apr 17, 2025 at 6:26=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> For VDPA devices, Allow configurations where both the hardware MAC addres=
s
> and QEMU command line MAC address are zero.
> In this case, QEMU will automatically generate a random MAC address and
> assign it to the hardware, and the VM will use this random MAC address as
> its MAC address.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  hw/net/virtio-net.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 808a2fe4d4..2d4ac20ee0 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3772,7 +3772,18 @@ static bool virtio_net_check_vdpa_mac(VirtIONet *n=
, uint8_t *hwmac,
>              return true;
>          }
>      }
> +    /*
> +     * 3. The hardware MAC address is 0,
> +     *  and the MAC address in the QEMU command line is also 0.

Can this happen? I'd expect qemu should check for invalid mac addresses.

> +     *  In this situation, QEMU generates a random MAC address and
> +     *  uses CVQ/set_config to assign it to the device.
> +     */
> +    if ((memcmp(hwmac, &zero, sizeof(MACAddr)) =3D=3D 0) &&
> +        (memcmp(cmdline_mac, &zero, sizeof(MACAddr)) =3D=3D 0)) {
> +        memcpy(&n->mac[0], &n->nic_conf.macaddr, sizeof(n->mac));
>
> +        return true;
> +    }
>      return false;
>  }
>  static void virtio_net_device_realize(DeviceState *dev, Error **errp)
> --
> 2.45.0
>

Thanks


