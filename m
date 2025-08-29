Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E31CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:06:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNZW-0000Bi-VL; Sat, 30 Aug 2025 11:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1us3Mg-0004ti-03
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 13:58:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1us3Me-0003Ux-23
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 13:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756490294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dz3HxuCmcZlc0siOqaxukkCCyxcJiIXpMdpX3YwJQTo=;
 b=a6FOVi/8FLIrjUgs/WYi28Sj5QulhGd67tbLqWWcn2Wdv8eo/c6RvtHkUG/cZ3Hy8QG3YG
 y2ZbiBlevMEd7StZZah8V52pNp9tZ5Yg5vvXHbEuOnS2vFJZY1YtIPd/A/2JaPL5etXoSa
 jHBvdZhX7PPrPCDrQT61v2EXnZTrsw8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-A0L7BiJ3OaKUOwDxYvniWQ-1; Fri, 29 Aug 2025 13:56:45 -0400
X-MC-Unique: A0L7BiJ3OaKUOwDxYvniWQ-1
X-Mimecast-MFC-AGG-ID: A0L7BiJ3OaKUOwDxYvniWQ_1756490204
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-327b289e8easo2092895a91.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 10:56:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756490204; x=1757095004;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dz3HxuCmcZlc0siOqaxukkCCyxcJiIXpMdpX3YwJQTo=;
 b=gU2Dn/9bfxRh4pMHyGrA0Qii8zbm2nEZesoH7DWvJTulL823oOZQ77AGqK/y9tvXFO
 q+c9dSQpRzJiczdp+Nhhlo2PNiLAkqsHNalXG7JxZ7BORevwgqV8dGeuqiY9y0D8OI5C
 HsRw0NdsS/3TWadl5EOPxBaB4PYnz5gdJ3wrPpn8yHb9j5Fce6bsnHbAjx6dFxMehQoG
 enf8wNkQvE5muBKPxrejP+yeQRnoc+w2a37EgDMswCi/sACB23HRhsIlm9wKkxljx32D
 7Dtq6NpIf2xKnf9myrX8P+6GU9AkEkJUL615TM+IObgthnoa5j9u/W6BQPlPprvlet4q
 PJRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHGhzCOy6UsFsNfcri0hy37VYnWnrhVIvChU7fTLS2kE4r19FgehLgleE5dBqMoZEuROUuWvzrH6JV@nongnu.org
X-Gm-Message-State: AOJu0Yy/uBXxFA33dPZlGQqgiBqmhKknwlF83n7ZzASB1Eag7WZg12vx
 JB5zWOfE9OVgcAG7lwaBNHon7v4T9vwpWp+GoGpj1DSFnRrO8vKKwTevrPesod+EWgDlq8NhVxc
 7h6BSIAnRJi48r+pVWDjpGph7NjMsfgI65fziF0CV8rPBbmoYAV67BK1JS0sTZcZJuPu+8F3omP
 kuyexObkUdG1qQoY9X3Fhn/USzNKiqnnU=
X-Gm-Gg: ASbGncv/OhpBCg4nMEHCwwyMngCT/o9IqcSDGTmTmQN/CPvvbtwqoaFl/xbZHtNFp6x
 VqjTfBDBEcW9S1esrEm41MQUidc8Uz+fDROQMM5l4V19g2AFr7YBflQADM549FKvKqWVRJwCpjk
 IbPa7Afbe8rxIOlbelXw==
X-Received: by 2002:a17:90b:1d43:b0:327:e67d:658d with SMTP id
 98e67ed59e1d1-327e67d6768mr4708518a91.20.1756490203851; 
 Fri, 29 Aug 2025 10:56:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2ohRMZ2usxKdgz4UzVTIFqkI0545r4eUeqDTapLPt21aFQr49h6FWqP0Vj7qEQyJ1L2lXuZT7utA7jINHBV4=
X-Received: by 2002:a17:90b:1d43:b0:327:e67d:658d with SMTP id
 98e67ed59e1d1-327e67d6768mr4708499a91.20.1756490203376; Fri, 29 Aug 2025
 10:56:43 -0700 (PDT)
MIME-Version: 1.0
References: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
 <20250827150323.2694101-56-mjt@tls.msk.ru>
 <BN7PR01MB38281A0E41A6B3A681B2A2F8803AA@BN7PR01MB3828.prod.exchangelabs.com>
In-Reply-To: <BN7PR01MB38281A0E41A6B3A681B2A2F8803AA@BN7PR01MB3828.prod.exchangelabs.com>
From: Mauro Matteo Cascella <mcascell@redhat.com>
Date: Fri, 29 Aug 2025 19:56:32 +0200
X-Gm-Features: Ac12FXx-3g2ETvVl31tKognWEu1QBMRdhuJLsO8Ewe2sgvnzDnzLnQFQGBVTBS8
Message-ID: <CAA8xKjXAcib=RKEY=bmb9QjL7czFHaKzYU4dBmQnh1_Le13aCw@mail.gmail.com>
Subject: Re: [Stable-10.0.4 56/59] hw/uefi: clear uefi-vars buffer in
 uefi_vars_write callback
To: "zdi-disclosures@trendmicro.com" <zdi-disclosures@trendmicro.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mcascell@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Aug 29, 2025 at 7:41=E2=80=AFPM zdi-disclosures@trendmicro.com
<zdi-disclosures@trendmicro.com> wrote:
>
> Hello Team,
>
> May we know the ZDI-CAN mapped to CVE-2025-8860?

This was reported (by you) to the qemu-security ML as ZDI-CAN-27261.

> Regards,
> The ZDI
>
> -----Original Message-----
> From: Michael Tokarev <mjt@tls.msk.ru>
> Sent: Wednesday, August 27, 2025 8:03 AM
> To: qemu-devel@nongnu.org
> Cc: qemu-stable@nongnu.org; Mauro Matteo Cascella <mcascell@redhat.com>; =
ZDI Disclosures Mailbox <zdi-disclosures@trendmicro.com>; Gerd Hoffmann <kr=
axel@redhat.com>; Michael Tokarev <mjt@tls.msk.ru>
> Subject: [Stable-10.0.4 56/59] hw/uefi: clear uefi-vars buffer in uefi_va=
rs_write callback
>
> From: Mauro Matteo Cascella <mcascell@redhat.com>
>
> When the guest writes to register UEFI_VARS_REG_BUFFER_SIZE, the .write
> callback `uefi_vars_write` is invoked. The function allocates a
> heap buffer without zeroing the memory, leaving the buffer filled with
> residual data from prior allocations. When the guest later reads from
> register UEFI_VARS_REG_PIO_BUFFER_TRANSFER, the .read callback
> `uefi_vars_read` returns leftover metadata or other sensitive process
> memory from the previously allocated buffer, leading to an information
> disclosure vulnerability.
>
> Fixes: CVE-2025-8860
> Fixes: 90ca4e03c27d ("hw/uefi: add var-service-core.c")
> Reported-by: ZDI <zdi-disclosures@trendmicro.com>
> Suggested-by: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Mauro Matteo Cascella <mcascell@redhat.com>
> Message-ID: <20250811101128.17661-1-mcascell@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> (cherry picked from commit f757d9d90d19b914d4023663bfc4da73bbbf007e)
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
>
> diff --git a/hw/uefi/var-service-core.c b/hw/uefi/var-service-core.c
> index 4836a0cb81..92fc121fe7 100644
> --- a/hw/uefi/var-service-core.c
> +++ b/hw/uefi/var-service-core.c
> @@ -259,8 +259,8 @@ static void uefi_vars_write(void *opaque, hwaddr addr=
, uint64_t val, unsigned si
>          uv->buf_size =3D val;
>          g_free(uv->buffer);
>          g_free(uv->pio_xfer_buffer);
> -        uv->buffer =3D g_malloc(uv->buf_size);
> -        uv->pio_xfer_buffer =3D g_malloc(uv->buf_size);
> +        uv->buffer =3D g_malloc0(uv->buf_size);
> +        uv->pio_xfer_buffer =3D g_malloc0(uv->buf_size);
>          break;
>      case UEFI_VARS_REG_DMA_BUFFER_ADDR_LO:
>          uv->buf_addr_lo =3D val;
> --
> 2.47.2
>
> TREND MICRO EMAIL NOTICE
>
> The information contained in this email and any attachments is confidenti=
al and may be subject to copyright or other intellectual property protectio=
n. If you are not the intended recipient, you are not authorized to use or =
disclose this information, and we request that you notify us by reply mail =
or telephone and delete the original message from your mail system.
>
> For details about what personal information we collect and why, please se=
e our Privacy Notice on our website at: Read privacy policy<http://www.tren=
dmicro.com/privacy>
>


--=20
Mauro Matteo Cascella
Red Hat Product Security
PGP-Key ID: BB3410B0


