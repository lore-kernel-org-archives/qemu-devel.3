Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8F5C28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 16:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u014I-0001fp-E9; Wed, 02 Apr 2025 12:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u014F-0001fU-Pn
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 12:35:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u014E-00083m-CC
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 12:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743611753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E5jbydTloO1zUHZ29JsbuP4L9HJC2tuxsQbwW6xGUrI=;
 b=jVwsRDkAefupFY9Y60pqHurEWGd/Gxz4grIcyT1KCF5AVTXRqM/lIT0RobBFSiz0f0iCGM
 0Ct5POiwEM5idxTpiBTO2qYT8BZ0wnCVM/roIuaDP7JBEfXGWmu2ngGOLx0IbpX5cdtBcR
 Myyai57e0SyyilLi/G50lksC1xRp+eQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-xApJak_zOSWARQW9bKJLbA-1; Wed, 02 Apr 2025 12:35:51 -0400
X-MC-Unique: xApJak_zOSWARQW9bKJLbA-1
X-Mimecast-MFC-AGG-ID: xApJak_zOSWARQW9bKJLbA_1743611750
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-391315098b2so4661f8f.2
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 09:35:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743611750; x=1744216550;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E5jbydTloO1zUHZ29JsbuP4L9HJC2tuxsQbwW6xGUrI=;
 b=cT1McPjxZkfVqk4u45I2krR1mxEwNX5yP0OpV5YDpGYYpoQWwvIgE3JQfOkqk64MTG
 TyfXpjeMOZExrep4Qa88rb9SgNf12Y6ldse1EFIvewYQibytKFT4hXmbgzL9eJTonk/E
 +/AXYWwSKid5fVaG46cmMdPGIYhdWBlKof/feISdl74OQpKNXqCMxsCduW3yu744WwFe
 t5mtAkQSneQrQQWUDy6YkVp32dNR9cX9ng0pofMn9LYW7Pt8e1FqHihKe0kyhhH9CZrm
 j/KiVeL8X4PKCom1EJsDdVFxKsWo+gjCs/kr/pU4VhQBL/xDUwOiMw19ekORhLz8ZDIQ
 yJmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQQkgzW5iHd3tzlVqQ3n31W8RZeQPcFACCm3C7qXCrhZwoS+qm+FndZE6bjfaBt91msXTg97/pHNca@nongnu.org
X-Gm-Message-State: AOJu0Yx7b66TxK2Eo7WRk35qVdhQzLZ62Tx7hh6BieF5H5r/Vj5GE1J3
 lIpSr0r/dFssIIN8YVRFejOPtIJILgVKi8iGwpwDFrRUVxray/Kx6XipK7RhW+iVkhLCwtYrkIL
 G8uKSnucQGHESS/7z8v9sfLL34kCz4u+6RXvlK9bw3UDbClLo+uHM
X-Gm-Gg: ASbGncs1XSAS+Ielk1o2Y/9LpfUUXWALm6lDsJDlCpsnLWCwmxO2HlZuUctlde6kYX2
 eDN99/CtSX03isA494ZVE0jmjwQbw0fLVCENeG5CE336t6XEzea9PlwukLocjDGeR8g3YKd1d6U
 NUjQ1lQAH0vtD5U8eRIVSzrmm4E2h6Sm6U6fwYitnPctMpFHlChLF/7Tch6OhBIzyZVNiXkcwFO
 u+HTqsGXJvY6ja3PqoqMSklpXsJqfMPlHt45fg65jErsJ6irYmYPda/VZ/X/3LIILmS/Ww24/IL
 BQGMgoqAzA==
X-Received: by 2002:a5d:64e7:0:b0:39c:11c0:eb95 with SMTP id
 ffacd0b85a97d-39c120de38bmr14064704f8f.17.1743611749968; 
 Wed, 02 Apr 2025 09:35:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9jx2lNhxzu4PoACAeTBBKCSHuYecOm2VIQi50Jc4CCbJqUYdCuJ23PbTkjZ/v3nl2jkhFLQ==
X-Received: by 2002:a5d:64e7:0:b0:39c:11c0:eb95 with SMTP id
 ffacd0b85a97d-39c120de38bmr14064683f8f.17.1743611749636; 
 Wed, 02 Apr 2025 09:35:49 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43eb61b843bsm27013045e9.40.2025.04.02.09.35.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 09:35:48 -0700 (PDT)
Date: Wed, 2 Apr 2025 12:35:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 3/4] virtio_net: Add second acceptable configuration
 for MAC setup
Message-ID: <20250402123447-mutt-send-email-mst@kernel.org>
References: <20250326132021.1215568-1-lulu@redhat.com>
 <20250326132021.1215568-4-lulu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326132021.1215568-4-lulu@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Mar 26, 2025 at 09:19:32PM +0800, Cindy Lu wrote:
> For VDPA devices, Allow configurations where the hardware MAC address
> is non-zero while the MAC address in the QEMU command line is zero.
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  hw/net/virtio-net.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index a3b431e000..1fd0403d5d 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3767,6 +3767,20 @@ static bool virtio_net_check_vdpa_mac(NetClientState *nc, VirtIONet *n,
>          if ((memcmp(&hwcfg.mac, cmdline_mac, sizeof(MACAddr)) == 0)) {
>              return true;
>          }
> +        /*
> +         * 2.The hardware MAC address is NOT 0,

space after .

> +         *  and the MAC address in the QEMU command line is 0.
> +         *  In this situation, Here we use the hardware MAC address overwrite
> +         *  the QEMU command line address(is 0) in VirtIONet->mac[0].

drop "here" and add punctiation. period before overwrite maybe?
what is (is 0)?

> +         *  in the follwoing process, QEMU will use this mac in VirtIONet and
> +         *  finish the bring up
> +         */
> +        if (memcmp(cmdline_mac, &zero, sizeof(MACAddr)) == 0) {
> +            /* overwrite the mac address with hardware address*/
> +            memcpy(&n->mac[0], &hwcfg.mac, sizeof(n->mac));
> +            memcpy(&n->nic_conf.macaddr, &hwcfg.mac, sizeof(n->mac));
> +            return true;
> +        }
>      }
>  
>      error_setg(errp,
> -- 
> 2.45.0


