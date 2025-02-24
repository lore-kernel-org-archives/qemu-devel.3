Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BBB7C021B2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 01:58:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmNio-00072I-Fq; Sun, 23 Feb 2025 20:57:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tmNil-00071y-QH
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 20:57:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tmNij-0003y4-IV
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 20:57:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740362239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YWfCox4XMgYKO++x3TGe9BgKrjjJd8E47d59OaChgpc=;
 b=LZgFdDoRNw7cpk+Ft+BEKNh1HYQJ/ZR/c8Gas0P44YEjyM+/vSpoy/wDeg+2HjXISXcZ5D
 dLk77/iRX2w3mqxjHE9LIwIAWiN8SjEk+7gnBj5TZkdyCeIqF0I6GmG3OUER034LItMO/f
 sPaCT4OdQ+G1kxk4GpbJoxUODhxUCpw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-U_LWuT_IOOSbGwmNWgHxAA-1; Sun, 23 Feb 2025 20:57:16 -0500
X-MC-Unique: U_LWuT_IOOSbGwmNWgHxAA-1
X-Mimecast-MFC-AGG-ID: U_LWuT_IOOSbGwmNWgHxAA_1740362236
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2fc4fc93262so8386459a91.1
 for <qemu-devel@nongnu.org>; Sun, 23 Feb 2025 17:57:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740362235; x=1740967035;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YWfCox4XMgYKO++x3TGe9BgKrjjJd8E47d59OaChgpc=;
 b=Jit8EfU/kiEgz6J4GrWizYvqz16LaUM+j1/nzxE7SdGazlasZ3orvONs3TEkvyW11X
 vLEXeOvof90eWhA9X3AD/NdVbOThg6LoE6nbmrrjRWaZ0asiqTHJqVp1lsw26+EAxdKP
 3aIlPUA2y+N2ExOF9BCfjhfc8G1GDJbgtDjswrxQy/UF6HLsetJErD3+WTw3iK9fnFwe
 icXJoXctdVWbtPkEZlO/2Vrc4/nXSVH2UgKkWXcty6CEY3fpv2X6iWAbf5BHtDgFPKPb
 X8xOo2VkdBD4bU5IBTRVMJqbJ0pw7USCtDnlI1ms4urN1ufFZM/deIneVLreKLiYv7DH
 Hrjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhkofJQdAlZXlCRFUbp52pPBrksHycK8+kBysZIRWctT7HgFRuBzGKbiQDXgs+2UNEO3SSpvWk0a4u@nongnu.org
X-Gm-Message-State: AOJu0YynbikobZ0ahwj4Lk315A8CcH7j68ALuTNgQiVkV/ZTZUZpLjD+
 7+7wE/OGUjwV0wPg9W3kTYFshzPFKUEbFwNs1zjSavhpHfeST7T6jnwK4CMDMtTfhFv2BGnB702
 ArZ/2shq9ynjstINL2rpsHT24F2mj13jOgOCfJ4xoPdMtkuv2sRhb8unES7idR4lhsbkEi/c+1S
 R4g5l8B/0u92Krbfawn5AfF3AzioWdPrwuN4CxGA==
X-Gm-Gg: ASbGncumY5GbkEv3Q9GPlWkS5KzikDN85QXZS6MU2WJs0n9f9pCDq989kAbfDS7Y2lM
 N0qPEfMPqliKtHR2HyuQnffgiaj0DuMfHhu281t1rkpEbTsYhGTOwt0reXcXLo6dPtP3HdFESeg
 ==
X-Received: by 2002:a17:90b:1c90:b0:2fa:137f:5c5c with SMTP id
 98e67ed59e1d1-2fce769a8a3mr17871986a91.1.1740362235184; 
 Sun, 23 Feb 2025 17:57:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqaBqBgBYdkplFX+FL6kqL5kQwI1HV+HhpHEpUwgOecqViqfhIXWiUELhST+zArF/i8whqCcVkLSEim5AqREM=
X-Received: by 2002:a17:90b:1c90:b0:2fa:137f:5c5c with SMTP id
 98e67ed59e1d1-2fce769a8a3mr17871964a91.1.1740362234835; Sun, 23 Feb 2025
 17:57:14 -0800 (PST)
MIME-Version: 1.0
References: <20250221190733.490308-1-kshk@linux.ibm.com>
In-Reply-To: <20250221190733.490308-1-kshk@linux.ibm.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Feb 2025 09:57:03 +0800
X-Gm-Features: AWEUYZntHV2IHNDHf5WKd3ZXX5p9pedLd1uZJ7gl-UJyghewDOArIOMlUo581Jg
Message-ID: <CACGkMEtm5gapBTmM_cA=jxAEg4GMkyMf4Wa47kvkFvN05uJ__w@mail.gmail.com>
Subject: Re: [PATCH v2] vdpa: Allow vDPA to work on big-endian machine
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: mst@redhat.com, eperezma@redhat.com, sgarzare@redhat.com, 
 mjrosato@linux.ibm.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Sat, Feb 22, 2025 at 3:08=E2=80=AFAM Konstantin Shkolnyy <kshk@linux.ibm=
.com> wrote:
>
> Add .set_vnet_le() function that always returns success, assuming that
> vDPA h/w always implements LE data format. Otherwise, QEMU disables vDPA =
and
> outputs the message:
> "backend does not support LE vnet headers; falling back on userspace virt=
io"
>
> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
> ---
> Changes in V2: Add code comment.
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


