Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D66CD6E79
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 03:48:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWnRl-00078p-Pi; Mon, 08 Jun 2026 23:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wWnRl-00077k-0R
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 23:48:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wWnRj-0000MG-GN
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 23:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780976889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qs5nGOKy6Cl45eEzyOq2a3dgg7ojdHXEG5J2g5ghe+I=;
 b=jNfD5iPr0VraSmsK3HvlNAXlO8R+jInVybNFiV/XF4aFKWr24b4NOGOUNDehBGd03TcLaZ
 Xa5C7X16zjJilGhxDjwiwJaN5+xSbUMTUAdmc5fsgR7CmbLp+g2YlNmyRsScXi+jKj8/24
 W85gqAnXPd4PKGeqvzeyXgmQtaE8T7s=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-T8Hduh2lN6alzluKBRWwvQ-1; Mon, 08 Jun 2026 23:47:54 -0400
X-MC-Unique: T8Hduh2lN6alzluKBRWwvQ-1
X-Mimecast-MFC-AGG-ID: T8Hduh2lN6alzluKBRWwvQ_1780976873
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8ccdcd8dd3dso123559806d6.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 20:47:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780976873; cv=none;
 d=google.com; s=arc-20240605;
 b=ff+MJMoGU9nGDdO7U5UpHgQzSyi1VLN9FrdIT1qRZktrcIgvVEnWYXbGlwrrNBAfie
 0RmVV/VBbkghIUSjAq9Z9AM0pmC2NwTMXkLtpGAleakDoKduuudpsApcOV8odr1273fo
 M1Z3nnN2XMwm8xrk5OjbF5qEf6sPjV8YbDwcBCfUgr7aBRt3d1rgLrTFyogYtzzG/JUS
 2nB9uXUavDdWExZC29OvghpeTKhWgm+Njg9GF4KSV3uAC7bpMVRG3C9SwnR5XZAEsI3H
 1YZpGeni45Lnyh65/2teG5TN9gv2aWvnVTikMJFXU7PKYKs40YBZd3v+/I/zPpsFdXdl
 vKsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Qs5nGOKy6Cl45eEzyOq2a3dgg7ojdHXEG5J2g5ghe+I=;
 fh=MLuei9TA3F1FMjFWE2GNpY1LHjP0MtNrq7n1WxKtb8Q=;
 b=W93TbwXxq6zEtB302MHU3pHCX+Ed3ZkXEN6kRiLP3IL5MXOHaCTMwc3njplO5V8zNQ
 QeJNfCdy4edOamPAYEpV/c7BY4eTA3FnNnc8F6atWGRn2Dso0uFeY/qVsON44YjeKMxc
 KLcf+n/Zvhb0XovF/CisV+Lt6FwPQZV0F+LibyfiqswPCVeuwwU9aO/Sf0X0J6BEaodK
 jQFVs0reE8lLN3Db2h9BV4C+LTQALRKhMDW1YarVhABVVK57AOpjUul7b7gqGARHfLGH
 /eoQprRKvxSlOa1FqLgqZPOCxQMr0OyRN1HIw+42FMifFPggPtYgvvzG3PWVOtKKJalW
 KkgQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780976873; x=1781581673; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qs5nGOKy6Cl45eEzyOq2a3dgg7ojdHXEG5J2g5ghe+I=;
 b=ROF1g7ovZvbBf6fmxDoyrxZO8jjHomwmP0IpYnGnrm+3lPM5TL5dlUFuPOzqDyEZ/D
 tiqQ6frjDQpN4POJVBMb88lsSNmnmF34VoVitR288COw0yNaL4Xag1rWuHXe4qrfuauv
 HAfR1VkacBUuIS4WZE6Ya/tQG/hwHLmXJw5l4linKg4Kh19kpSdRYhQPZvZt6IN+XsbK
 U0uIyaRAN/Um8+B0KCETX+Gk8J7WRrisV0pmvwTeTyulvY+wUMDrafuwQZSG18bgWIhT
 XNK4cIeTgP9w7KBOvdGNxBCRb4azdeEYIgK6JJd7lJ43h1pVYQqIbn7pKdfBgyeEybFd
 V65A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780976873; x=1781581673;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Qs5nGOKy6Cl45eEzyOq2a3dgg7ojdHXEG5J2g5ghe+I=;
 b=asdldw5SQvvrqaUtxr/jX00u4IJ4gLeEIKhfMcYh035PLQp+mtpZX5LAwUOFCxic/1
 41ZMpnvRe6SiAzzVqEotV6EMEsxWEspmZTIbxZKCBF/UK7oZb6l6fJOYQ5bgBonFMAKn
 PNLjQjLxT2Ril+/3srvrXxFqSrZKNQ5/9LVMaNgMYAGmm2hAk60NqqMaXeEEvhD1BMqF
 LN6c1PYl1ew65FfS7td9O5uk3wb5N5KFV2nQIJDyAqXzC489X+kwRlH2MicV4sTf8z5o
 97gU4EB1NBiCp2msTqECO9RkUSsC7H6PP9fC53nN3zhjh46kduVIkNnXE4ZHLi9zMZr1
 Etdg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9S7raBy1T7JOnbhkwIOIQFT9/TZ6q5B7XK2NE3TkH7UrQtBPpJDCPUhgb7eRYN685DjerYybYnhQEQ@nongnu.org
X-Gm-Message-State: AOJu0YxbdjXvdyZK1z5v8ol3EAyudEsXHKz8JT04hvYEx7V1FMdjtyhE
 T4dLcCnw4W0bqByBIID7CNRFO9iigNKEE+z0KO5meLBdh16L5TUcVfrvo9sg2qiecT7QPCJrTxi
 1d0luPqaHv/HrMulwwAIivB2NCi+8mBuZfguK6XYQbQlR/n2TZWfyBM3O6Vz1u9DvxfCeKtiwvv
 MnPI3lYUl/TaEd0OGmPLTA4jJ8J68d/Uo=
X-Gm-Gg: Acq92OFZP9PMk+UVGOuPfUuTRAf2Dzu3BGe72YvGyOfWWBmr7SL4B3ZST1yC6m7PKjf
 Jft+y5nreU0YmEzNS27o58jU3LrRpJdgKGRS7jw0/qJBJY0/S0JJ9p3wr4sbR83/WA2vZ+7Fs9I
 V1zQtFpVlFUfDFWtHA9NTJmTwTIc1ziOs0Q267cQko1sXsR0dmKMpBOV7Jw0ClVquOElesfKEnL
 hnUemeUuVIe2P0FJ/okirIf91WkUDJHf9MnvSuFyHi6SjN2Zw==
X-Received: by 2002:a05:622a:40cb:b0:516:e152:7a59 with SMTP id
 d75a77b69052e-517ca5faa20mr15734371cf.42.1780976873430; 
 Mon, 08 Jun 2026 20:47:53 -0700 (PDT)
X-Received: by 2002:a05:622a:40cb:b0:516:e152:7a59 with SMTP id
 d75a77b69052e-517ca5faa20mr15734181cf.42.1780976872991; Mon, 08 Jun 2026
 20:47:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAK3XEhMNqHbkL2P6Xg3_hJ8WAxhPQgurjvuZg-vXUDZ5=x-RRA@mail.gmail.com>
 <f2516211-6fbc-4714-b674-4276464f94ff@redhat.com>
 <CAK3XEhPdaVqi9nECrJrcRaCKK0bVcRXw=t6hXM=EVwbxpu5wLA@mail.gmail.com>
In-Reply-To: <CAK3XEhPdaVqi9nECrJrcRaCKK0bVcRXw=t6hXM=EVwbxpu5wLA@mail.gmail.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Tue, 9 Jun 2026 09:16:39 +0530
X-Gm-Features: AVVi8CcXweN4JLbWesEs1bpo1VjKUiopjGVsOq33ZB3rxS5BXf5n5ZcZxHuMty0
Message-ID: <CAK3XEhM3K1r3Q7zpqvQkLtuMEeXkb+nwDwN-j_+B0fwZpHhgkg@mail.gmail.com>
Subject: Re: artifact download for qtest
To: Thomas Huth <thuth@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel <qemu-devel@nongnu.org>, 
 "Daniel P. Berrange" <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jun 9, 2026 at 7:54=E2=80=AFAM Ani Sinha <anisinha@redhat.com> wrot=
e:
>
> On Mon, Jun 8, 2026 at 10:43=E2=80=AFPM Thomas Huth <thuth@redhat.com> wr=
ote:
> >
> > On 30/05/2026 16.56, Ani Sinha wrote:
> > > Hi,
> > >
> > > I am trying to write a qtest for which I need an IGVM file. I have th=
e
> > > file, about 54 MiB in size.
> >
> > 54 MiB is quite big,
>
> I was able to reduce the combined size of 2 files to about 400K
> https://gitlab.com/anisinha/qemu/-/commit/6aef476b59443dd1bc570c29e8e5ca4=
3140cfed4

Compressed size is about 100K but I don't want to introduce dependency
on libarchive preferrably if 400K size is ok.


