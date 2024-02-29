Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69812C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 08:33:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfbqO-0000xx-Og; Thu, 29 Feb 2024 03:32:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rfbqM-0000xi-It
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 03:32:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rfbqK-00033W-OZ
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 03:32:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709195559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sTjNzaS1HA+RGFL3kdQwPORlJBszUM9+fgGl5yYyEEM=;
 b=DbpawrsVmVfn+p+s2bxMMwidjhrwNOI+lW4rLGHAgViAfXl0l+0ltRIclzggdu3ZGAtVSh
 Tfkxtq7/nNG+4ZxGS9uIGv6c1dRtgK7DmoJ79I+Zzg9QTuGzUc/01fAeFTDpv35Q8vMPkx
 R6+f8f2PyG/Um3NeGfHvhxdFSGO4KNg=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-K119ODjEPv2m_MWdJkCInA-1; Thu, 29 Feb 2024 03:32:37 -0500
X-MC-Unique: K119ODjEPv2m_MWdJkCInA-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-dcc05887ee9so997468276.1
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 00:32:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709195557; x=1709800357;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sTjNzaS1HA+RGFL3kdQwPORlJBszUM9+fgGl5yYyEEM=;
 b=cEqoTk16XoczXH9tY0y4R5/WD4UbAhT+iYbxpehg2g485bwmKG/NXgElkgsV402Eex
 VdfsrMtTtfviD5vgitTx3C73OGCN/h/HcGRgnKV5YZrKLFlCAvMrT1NrPdjVfIPO8zwC
 +asHIho6Pb36WuyD5YwIAP9xnS/2Mlt+XYFGSglQq7dNbtHrTth9V9LI8ly7L6GzzNKf
 Vb6VuZrnobpn4/JhV0Z84Dk88GgxqYhKtQLaoMEkeqhNzOkiPyJO6WGUjCZpOD+NxCo7
 2ZaNMmpQiDCdRN4WmhyCKeWoUQsxQ2iqw7QubBf7pQNxiGIE0gCgpZyvXJqMyEi7K/U7
 66sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8mCBNcEk9wk2TTXA7IYMshIdths1RaUlgZ7Zg1YeH5duL3iS3DTqNwZbFeo8q8mFC2adc5/Em2oNRla5nASmEKs61c6Q=
X-Gm-Message-State: AOJu0YxLyVivXFi+06VCaLqFh9bF973FjHYOKE4Eth7rk58mJIf3VSjV
 N0WJUnkixIbEqHgA3+LGGB1M1Lgx3PB6WopoXpb+it9svJ1z3qJAqg4Is4J8rIizP8/9LY12EtN
 C5BQqVVMh9n2isbH+Dy7xecUTql8VxL9CTSvjrrMNS6Qjjy0bztYCusuItKSKaKpDtCtkNAhb40
 ZQgQAtChdx2MISl7fubS4ZPh0xm9I=
X-Received: by 2002:a5b:987:0:b0:dcd:9808:256c with SMTP id
 c7-20020a5b0987000000b00dcd9808256cmr1463597ybq.58.1709195557157; 
 Thu, 29 Feb 2024 00:32:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFI6ZE5etDt3cQLkbm0fXM1meuWsoLNjjD9oA7H/L9WOsQFq8xufdhheB/PiRRAX/BBkM7xGc14TjlEDwgNr+0=
X-Received: by 2002:a5b:987:0:b0:dcd:9808:256c with SMTP id
 c7-20020a5b0987000000b00dcd9808256cmr1463585ybq.58.1709195556803; Thu, 29 Feb
 2024 00:32:36 -0800 (PST)
MIME-Version: 1.0
References: <13625712.uLZWGnKmhe@valdaarhun>
In-Reply-To: <13625712.uLZWGnKmhe@valdaarhun>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 29 Feb 2024 09:32:25 +0100
Message-ID: <CAGxU2F4jx5m5_ijNoWZpVK_MepvtDBY8L70-dSZmRUPmTskCNw@mail.gmail.com>
Subject: Re: Intention to work on GSoC project
To: Sahil <icegambit91@gmail.com>
Cc: eperezma@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Sahil,

On Sun, Feb 25, 2024 at 10:38=E2=80=AFPM Sahil <icegambit91@gmail.com> wrot=
e:
>
> Hi,
>
> My name is Sahil and I go by the pseudonym 'valdaarhun' on Github. I have
> never contributed to QEMU before but I have used it a few times as an end
> user. I developed an interest in virtualization during my internship at
> VMware and would like to dive deeper in this subfield.
>
> My current full-time job does not allow me to take part in external progr=
ams
> that are paid. I would like to work on one of the proposed projects outsi=
de
> of GSoC.

Sure, not a problem at all, also because for this year QEMU was not
accepted in GSoC, so anybody can work on those projects if they have
time

> I have gone through QEMU's list of GSoC '24 projects [1] and am
> interested in two of them:
>
> 1. Add packed virtqueue to Shadow Virtqueue
> 2. vhost-user memory isolation
>
> Based on what I have understood, they are somewhat related and are part
> of the migration subsystem. I feel the learning curve of the first projec=
t
> will be less steep and will make me better prepared to tackle the second
> project as well.

The first project is for sure related with migration. While vhost-user
memory isolation is not really related to migration, but both are
related to virtio devices.
Anyway, your plan looks good to me!

>
> I have read the "Getting Started for Developers" [2] wiki page. I have al=
so
> built QEMU from source.

Great!

>
> I think my next step should be to read the documentation on the migration
> subsystem [3], the blog posts attached in the first project's description
> and virtqueue's implementation. Would you also recommend that I work on a
> QEMU issue that is open on Gitlab and related to virtqueues/virtio to
> familiarize
> myself with the codebase? I went through the issues tagged as "device:vir=
tio"
> [4]
> but can't really tell if any of them are good for beginners. One of them =
has
> the
> "bite-size" tag [5]. It also has a patch attached but hasn't been merged.
> Shall I
> work on getting that merged?

Yeah, "bite-size" issues should be better to understand how to
contribute to QEMU.
Feel free to work on any issue, doing the work or helping to complete
old patches.

>
> I have worked on a few smaller systems programming issues in other
> organizations (eg: strace [6], htop [7]) in the past.
>
> I look forward to hearing from you.

Feel free to reach us if you have more questions on the projects.

Thanks,
Stefano


