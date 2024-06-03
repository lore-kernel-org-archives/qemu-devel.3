Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86CADC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 14:22:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE8a3-0003X2-M8; Mon, 03 Jun 2024 10:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sE8a1-0003Wu-Ll
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 10:22:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sE8Zz-00035W-WC
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 10:22:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717424550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=efLqh7H5R1H2MCstarX4MnmJFfDoGl/LnoB3y6f71Jo=;
 b=N4S3r5qJNltr6PlveBVYG5AjITPoQARpdIx7Va1mRS47EIHkVR8xKNnBIHqp1og47hOdY8
 cGP4QaWo2m+0pXtbgZ6Iz833fO5jT1zqjNKQTtV3/dEfA/lDxOD9dJb+7Z86jynLlwC8Pq
 z2i8Sv134f5mz4uL28IO6DkxX3WSO5Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-4PV8XSSIMZSB5cgSRxX3fA-1; Mon, 03 Jun 2024 10:22:25 -0400
X-MC-Unique: 4PV8XSSIMZSB5cgSRxX3fA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-35dbf83bb20so2566664f8f.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 07:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717424544; x=1718029344;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=efLqh7H5R1H2MCstarX4MnmJFfDoGl/LnoB3y6f71Jo=;
 b=ghzT9ECdU4vExqzu8GDX563zToNlukSvCAwH4UAYiev3mbV54R18Ff5fWh4kAmWAzo
 ySoS9cZhBaq7Tw5NT+ggt3IHTM/0ea5r5O2+7S+74h8w/jpqGkPnDNMi85eIqbLTRt8H
 8whWBI77fXZB9bkntatDtqq3Bbe4upZtMM0D2dg1P9pnBhGz0UsOAQNThmOAgg++Mk53
 J9jVHwMxyj9JagVyxAqbba5KZoq/6FfjAnhm0Y19QmHIhD7luh8cr7Xulxeq6xNQUD7P
 XS5wMMGSpvBdBnqUFpXmaNn8Ve4wxo9ciRXaeVBSEcvXxXYuIp22o9XhK/H4CXiK3PKk
 riqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXspksnjurxSnbMaRSXjL7wsT0Z60BwCZ3AZ/Gby4ZdaCLDTIUD+iVVV8wbip1Z20s+ILu2wrT8e4ecj+L5pWjSnbnJkJ4=
X-Gm-Message-State: AOJu0YzmTWhlgZUF+deHf5ikA4VfA6nVdVDBjCUGrV9HUiAHMQWRa3iU
 JndrhrRLdX30Mz8OamRPnBUxC0Pl/PTURLfu9DHULVbnlCmDtg+NOheIL7wc7mrmHbfnoy3VEDs
 B/vUO2wF3jPomibW0Xn65/OkHOlI7GOwpyfYDE5qDkWNCNLg4gfWlX7JKjXGeDq/HrnAZWEtgTR
 lAq5DKz6PalJd3AcswsBHpttrP0Bw=
X-Received: by 2002:adf:fecb:0:b0:357:ff92:aae7 with SMTP id
 ffacd0b85a97d-35e0f25c3e6mr6739800f8f.2.1717424544722; 
 Mon, 03 Jun 2024 07:22:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH67uOr9eOqicMCPNEhJhZpPzutpMuvtEFRvQ9siWY62a4sbnmkxWF/LwmjxcRZntnhm0yGRx+NDnbedJ/adBI=
X-Received: by 2002:adf:fecb:0:b0:357:ff92:aae7 with SMTP id
 ffacd0b85a97d-35e0f25c3e6mr6739776f8f.2.1717424544320; Mon, 03 Jun 2024
 07:22:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240530111643.1091816-1-pankaj.gupta@amd.com>
 <CABgObfYFryXwEtVkMH-F6kw8hrivpQD6USMQ9=7fVikn5-mAhQ@mail.gmail.com>
 <CABgObfbwr6CJK1XCmmVhp83AsC2YcQfSsfuPFWDuxzCB_R4GoQ@mail.gmail.com>
 <621a8792-5b19-0861-0356-fb2d05caffa1@amd.com>
 <CABgObfbrWNB4-UzHURF-iO9dTTS4CkJXODE0wNEKOA_fk790_w@mail.gmail.com>
 <05d89881-bdbd-8b85-3330-37eae03e6632@amd.com>
 <3j2llxlh3gzyn33n6uo7o5jdx4dmi4rzbax5buluof5ru2paii@2ze452jtocth>
In-Reply-To: <3j2llxlh3gzyn33n6uo7o5jdx4dmi4rzbax5buluof5ru2paii@2ze452jtocth>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 3 Jun 2024 16:22:10 +0200
Message-ID: <CABgObfa5Bnm2vNcHqyo+DbXET2aZrmH5C6h7HV=6Qio7bKVTsw@mail.gmail.com>
Subject: Re: [PATCH v4 00/31] Add AMD Secure Nested Paging (SEV-SNP) support
To: Michael Roth <michael.roth@amd.com>
Cc: "Gupta, Pankaj" <pankaj.gupta@amd.com>, qemu-devel@nongnu.org,
 brijesh.singh@amd.com, 
 dovmurik@linux.ibm.com, armbru@redhat.com, xiaoyao.li@intel.com, 
 thomas.lendacky@amd.com, isaku.yamahata@intel.com, berrange@redhat.com, 
 kvm@vger.kernel.org, anisinha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Jun 3, 2024 at 4:16=E2=80=AFPM Michael Roth <michael.roth@amd.com> =
wrote:
> Paolo mentioned he dropped the this hunk from:
>
>   hw/i386: Add support for loading BIOS using guest_memfd
>
>   diff --git a/hw/i386/x86.c b/hw/i386/x86.c
>   index de606369b0..d076b30ccb 100644
>   --- a/hw/i386/x86.c
>   +++ b/hw/i386/x86.c
>   @@ -1147,10 +1147,18 @@ void x86_bios_rom_init(MachineState *ms, const =
char *default_firmware,
>        }
>        if (bios_size <=3D 0 ||
>            (bios_size % 65536) !=3D 0) {
>   -        goto bios_error;
>   +        if (!machine_require_guest_memfd(ms)) {
>   +            g_warning("%s: Unaligned BIOS size %d", __func__, bios_siz=
e);
>   +            goto bios_error;
>   +        }
>
> without that, OVMF with split CODE/VARS won't work because the CODE
> portion is not 64KB aligned.
>
> If I add that back the split builds work for qemu-coco-queue as well.
>
> We need to understand why the 64KB alignment exists in the first place, w=
hy
> it's not necessary for SNP, and then resubmit the above change with prope=
r
> explanation.

I think it was only needed to make sure that people weren't using
"unpadded" BIOS (not OVMF) binaries. I think we can delete it
altogether, and it can be submitted separately from this series.

> However, if based on Daniel's comments we decide not to support split
> CODE/VARS for SNP, then the above change won't be needed. But if we do,
> then it goes make sense that the above change is grouped with (or
> submitted as a fix-up for):

Yes, I think we want to go for a variable store that is not "right
below BIOS". The advantage of something that isn't pflash-based is
that it can be used by any code-only firmware binary.

Paolo


