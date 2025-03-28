Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 754C1C28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 17:36:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyDbo-00041t-Sd; Fri, 28 Mar 2025 13:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tyDbb-0003wh-Mi
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 13:35:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tyDbY-0000rz-Fo
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 13:34:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743183290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pmTBEpXxdB868KsVPa0XELCnCWsZb70LJgfed75aEq0=;
 b=G28vZT0QMOS02D4sUNvqPxWHoYVBBUAusiC73D8xeY477vsWRMmgx+ixyTGQ8Oontz8cM5
 LATa8PuoBbY0yC13K3n4Xzsror1iFqsUJWumXLDa4TIACNd03EQYigwor7oeU47X9dYFQ4
 hGkGSc0zPtZujbGmOdtYtslTuY3mIVc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-W8v7VQdpPwW7tq5x3sM6TQ-1; Fri, 28 Mar 2025 13:34:45 -0400
X-MC-Unique: W8v7VQdpPwW7tq5x3sM6TQ-1
X-Mimecast-MFC-AGG-ID: W8v7VQdpPwW7tq5x3sM6TQ_1743183284
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d01024089so25593715e9.1
 for <qemu-devel@nongnu.org>; Fri, 28 Mar 2025 10:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743183284; x=1743788084;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pmTBEpXxdB868KsVPa0XELCnCWsZb70LJgfed75aEq0=;
 b=Fe3qnz0FV5SonL3Yqe5ceT3PIh9EU5XTrRCKrcSksNU0NEWeF1Gyrt5Wduc4dh1kgl
 gflQmmOSQPUXGKjpuLvcQeTb+jV7sHADw52InsSef7jV7OyKrDEX3nhvUcI3AlSLtEEW
 7uCgS+MBCJ8vq66WKslaruqjMJBZR1fDH5YxK66cvbCNm1K90PK11m3UtDNUA/YhJbsm
 v0gP0DLx3v0Mvfn3UTNEIs5rBbMZSUfom3CgSVWCpKcAgNfxnJlolDgtInhni8+bPvWF
 QVDSa15liFPYUnw2y7dCWpV+d3YH4hU5AOuot3TTPEiyN52Gmn2Xdw/4/UiwYbSGZi2H
 o2DA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRiAiLkRWZoWBSms9Fl8Zk8TBOKmwTOHvGuxSsc+6PrA/dE/VsOGoGuom8Gj6/ISXZiXeEXfx0t4zG@nongnu.org
X-Gm-Message-State: AOJu0YwS+QLUYJYLnahe/SDXj/twPTvlUyqEdwJbgj5JqfGTTcgnpToh
 qDnCG/LXm51nS8Lrf3X0QxQ4TK9ELQYcreD4fP8Amy6Zi9OYdalfp2K1RNtN6Q2ckNZiV0Sw7Ub
 Z7nLSFE/UTF+MGYjJUX5396dEN/Fr29+GXIfJbGM4EutwRVCJcxpPuFFNOlqdaz54vJQC8qu4GX
 paHQz8+XIGOOBxBRPVg/vZm5Gt8+8=
X-Gm-Gg: ASbGncuxIlLnKLcbDqfjhL7QbZFtc4AQJlvc9werWSLUE5+SrkUBO+uhY9255/Gj7YJ
 3fz2vLzWz12Zt1rhsbYnSSd7xcsNWPluiZygJPOkvdwpJ75WYCb0QRw9A9PBgq6p/HtejNPMaHw
 ==
X-Received: by 2002:a05:600c:4754:b0:43c:fbe2:df3c with SMTP id
 5b1f17b1804b1-43db8516e66mr2197885e9.26.1743183284272; 
 Fri, 28 Mar 2025 10:34:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDV7ZT6Bx+qhN+5cyOyemuCfn2JGh4X6+yrJ8UoAMAE4FiRRZC8POXkjgOyn0V6NiUVWzMQV0VjB9gjpiOf78=
X-Received: by 2002:a05:600c:4754:b0:43c:fbe2:df3c with SMTP id
 5b1f17b1804b1-43db8516e66mr2197715e9.26.1743183283856; Fri, 28 Mar 2025
 10:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250327153627.307040-1-rakeshjb010@gmail.com>
 <364c91ef-b086-9aea-4073-e0be49b77d76@eik.bme.hu>
 <ca76bcb1-7cea-4153-ae74-02718a6a1cfb@redhat.com>
 <971ac7f1-618d-c94a-93db-9ba887bdc997@eik.bme.hu>
In-Reply-To: <971ac7f1-618d-c94a-93db-9ba887bdc997@eik.bme.hu>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 28 Mar 2025 18:34:32 +0100
X-Gm-Features: AQ5f1Jp1hjJOk6yvOff3obB31736u3EWstPGLS5TsA8PtFEkDSdZkdlhVqPwG2U
Message-ID: <CABgObfbL0b7G-Okq=0xnbDMJ4viu0Uk8gduuTUeCS0C4Xtn6aw@mail.gmail.com>
Subject: Re: [PATCH] hw/pci-host/gt64120.c: Fix PCI host bridge endianness
 handling
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: rakeshj <rakeshjb010@gmail.com>, qemu-devel@nongnu.org, 
 marcandre.lureau@redhat.com, philmd@linaro.org, thuth@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, Mar 28, 2025 at 3:16=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:
> > It should be fine.  You should take into account:
> >
> > - the endianness produced by pci_data_read/pci_data_write (always littl=
e
> > endian)
> >
> > - the endianness expected by the guest (big endian under the conditions=
 in
> > the patch)
> >
> > - the endianness expected by memory.c (always little endian, as specifi=
ed in
> > gt64120_pci_data_ops)
> >
> > Because there is either zero or one mismatch, bswap32 is fine.
>
> This may worth a comment but I'm still not convinced this works on big
> endian host because I think pci_data_read returns val in host endianness
> and if you want big endian then you only need to bswap on LE host not on
> BE host. Was this tested on BE host and confirmed it works?

Looking again at the code, there is definitely one problem: since you have

+        .min_access_size =3D 1,
+        .max_access_size =3D 4,

the bswap can also be bswap16 if size =3D=3D 2 (and bswap32 only if size =
=3D=3D 4).

Also WRT to what Zoltan is saying, I think it's safe to just add an
extra swap, as long as it's of the correct size. The swap changes the
combined action of ops->read and adjust_endianness() to have 1 or 2
swaps instead of 0 and 1, and that is the same as inverting the result
of devend_memop().

The loops in access_with_adjusted_size() could be a problem but they
do not matter here, because split accesses are never needed
(impl.*_access_size are the same as valid.*_access_size).

Thanks,

Paolo


Paolo


