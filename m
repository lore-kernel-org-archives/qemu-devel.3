Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B60C3CD1297
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 05:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruQoz-0007AN-LH; Wed, 10 Apr 2024 01:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ruQox-00074e-HY
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 01:48:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ruQow-0002Dv-2W
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 01:48:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712728109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Aqm8BRHEYAMlTASdrlz3TRv/0AL45a291pR1V6IyaxE=;
 b=Ylyg4l5xkNa1I8Cqjnp2lgRv2ClJzs6Kb88kaFEBH2PaHdxR+evIhYlv8lJqNCg9qYOCK5
 IkRw2EPc6szvQqw0D145FmLb+UPGAlFBA8+Q3mQb+HDtUmFdMXWxQ5XDmbK06xuNCusnbv
 e4SnsfdWRosnhBWcBiho7j/yA2j/ElE=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-_iuUDXA0N8qm6ry8aqFBXg-1; Wed, 10 Apr 2024 01:48:25 -0400
X-MC-Unique: _iuUDXA0N8qm6ry8aqFBXg-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5d5a080baf1so4675668a12.1
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 22:48:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712728105; x=1713332905;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Aqm8BRHEYAMlTASdrlz3TRv/0AL45a291pR1V6IyaxE=;
 b=kozfcZSwgiRQ96it+sFMzeGIornm9E15G5E0yYwZXs4fbxBouIy0pe3AKniNx+shWU
 Z4tUJ/4XoSKziPoZtHJD2t+aeZBLxCXQuqcNkpao6NnG6XdcQZXzBw/27BUgMp9ZT0vq
 ZYEkPNsSfUXxhzZVzeThQcA18wNT9XdgkOdrYtBcBzvkKjy1dANrwBR68f3yvT1ZlyGu
 oP1DxGoJ9wWUxeZ4gOYrSJIIkaFTIIhhlk+kUzI4rUudwdp+vEDS/8Zb39mzDu1Fwu9C
 pfpjlmMQ1KUzDG5YF02BbkzrpLiCxHSmgw7YauhgfVAqdCqq0EX2xY2YaERpN3jFKB3Z
 6nLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwn2GbnbsV29WlRbzOHzNLzP3BKjlXEQ7XsYOMpn6cMFfqzoStS51nVt6pvLcq0foVA/0pOPesyr37AnJlRCKKiiIxyro=
X-Gm-Message-State: AOJu0Yxw1rWCKWotXDtBNC7d9H5xJA9cFoPb9byQDcFe0zZGlUl82Q+Q
 pEGnws3FOSZZcU8xrSXFV5zytBzeiQzwvAXHRlqO2a2XNnlkshwo66r5QC9XPelxRQmdIRUd4sT
 tJ7R2z0Lsil0KK1NgsdxNFg3IMtwiD4INAbjO719ew5doqsSEXO3y66Zn8PH4h5pigJ1m3o+9G2
 zD6nlc2lLBhiVLjGe6/IVhucRcmw4=
X-Received: by 2002:a05:6a21:880d:b0:1a3:e2ed:62af with SMTP id
 ta13-20020a056a21880d00b001a3e2ed62afmr2109645pzc.34.1712728104509; 
 Tue, 09 Apr 2024 22:48:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEBlix2qcjpgcyMu2GmAHmxEBecDuYWClnuQ1oSts6LQAsQP9jUJ3VdmRV4L7pOk/OOnO6UyNsKaM0t43aH3M=
X-Received: by 2002:a05:6a21:880d:b0:1a3:e2ed:62af with SMTP id
 ta13-20020a056a21880d00b001a3e2ed62afmr2109632pzc.34.1712728104211; Tue, 09
 Apr 2024 22:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240410052926.417674-1-lulu@redhat.com>
 <20240410052926.417674-2-lulu@redhat.com>
In-Reply-To: <20240410052926.417674-2-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 10 Apr 2024 13:48:13 +0800
Message-ID: <CACGkMEunM_JPGg82kN+SvFVeNO4jtf-PRfkEjoNkCYwxy204Mg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] virtio-pci: Fix the crash that the vector was used
 after released.
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.701,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Apr 10, 2024 at 1:29=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> When the guest triggers vhost_stop and then virtio_reset, the vector will=
 the
> IRQFD for this vector will be released and change to VIRTIO_NO_VECTOR.
> After that, the guest called vhost_net_start,  (at this time, the configu=
re
> vector is still VIRTIO_NO_VECTOR),  vector 0 still was not "init".
> The guest system continued to boot, set the vector back to 0, and then me=
t the crash.

Btw, the description of the cover letter seems to be better, how about
just using that (so there won't be a cover letter since this series
just have 1 patch)?

Thanks


