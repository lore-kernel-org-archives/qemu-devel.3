Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD0EFE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 09:38:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOCyg-0002Hm-OQ; Thu, 19 Dec 2024 04:37:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tOCyf-0002HZ-Mq
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 04:37:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tOCye-0002Y4-5P
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 04:37:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734601071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=exEmLkFBZ/EX8nDvgkhyf8SSU8q65KmXS2QQRy40M7A=;
 b=hx1JH6zROxXvETUVe5R2WVgjBJwwzLBSmza6+hIk4lmzQjW3rQA9iKU46mpAuYd9WxTkU8
 wntDPkEyG9bTWiyv+5FkzJceV+PObYHhMHUCtQOmtzD+b2eV7+OT0RC5UgeFWeNLS8Ux1x
 OyipgGB5TqCtNFOpqaSPCgUVIyqC89A=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-fLrS-7jEOkm5CnK7iUnUdA-1; Thu, 19 Dec 2024 04:37:49 -0500
X-MC-Unique: fLrS-7jEOkm5CnK7iUnUdA-1
X-Mimecast-MFC-AGG-ID: fLrS-7jEOkm5CnK7iUnUdA
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ef91d5c863so635422a91.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 01:37:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734601068; x=1735205868;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=exEmLkFBZ/EX8nDvgkhyf8SSU8q65KmXS2QQRy40M7A=;
 b=bfvYJ7pg8UKMBOjK/v/LTqaY2XkulEzKXIaVXQCj3vTfBODO9ZOTd39BrNqzBF67N6
 g/nN9tQYhduDseFK5RXhvcsr9MZ2qsx9psUq80a13Z4X5Tfg1+iqRP+UaWNzDhmxeN6m
 IElM8XU7Ko+7UhtnCf7Qj410vIlrVukBDL9TNYY5Dw7WDFamWCbT/M+WUEjUUujtuKLc
 Zi4TEhZPJK9Npq4Ct9Gj11VTxNavkdZwhIduXT90vZTpOE+3dtZ8wCSC0pIYJIMHEKxz
 9A4VhzmQAy163zDgl6Xxx6XDulhQv+VPxh/2sLqgpH/eb6uQ51UP6p954WbS1jr41iKk
 aPew==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCvvjkln7J4rGqlLkBEcwXLd0gNGj+p2jlbiJixah/A3BtWQ2xWPY6BGEL8hyPScnmQIGlmqhqiO3U@nongnu.org
X-Gm-Message-State: AOJu0YzFkdSG+dMr1c640PYfV1lfE7z3z6ccDo8Obb4GA2Et2lrWl6qy
 6/Q99VNs4ZRJgJjLi5YM4PVl4E+xPghz2uHTvx1J4XnK7Jgm1Y3PwD3KgeaE3P8x3A2WGSALXTB
 Osj23mXU+bl4brWlB55n4HxuuOwip8CmlHoHaLtIF3KGSX605EhjV
X-Gm-Gg: ASbGncuUtnW5ygAdR6y4WiNhDOSoKqBPks/ffuJTl49t5aYHCpV5wU5PmVDsQJXWuXs
 CB0yZfY+j8ITFlDa3StvXwkqU+vnIC0s8etFsX+hsbdYm/2EXvHl6rEGJvp79i9uUr5KhPpMct+
 MCt6sCX8PXWN5sAxiyIknB9+yGLPdOrsckvJsAjhhoxzYqMLvM6DrE9oXholwyT6fWZTVDNG9ZD
 sLyf5aQL+qG1ZjfWqt+Rvw4ROcfaMXdn93lkmICJO1ly8INZsanXMCd+uGC+jtL6JNAneBbWA==
X-Received: by 2002:a17:90b:50c3:b0:2ee:f19b:86e5 with SMTP id
 98e67ed59e1d1-2f443ce9ae5mr4138511a91.14.1734601068273; 
 Thu, 19 Dec 2024 01:37:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLxlUeCj71xhe+ynW7gsRYwjC0hExnBYVQr6TOhNxfLZ5M7If+Iphi2XTxMaK56p/W42XUzw==
X-Received: by 2002:a17:90b:50c3:b0:2ee:f19b:86e5 with SMTP id
 98e67ed59e1d1-2f443ce9ae5mr4138482a91.14.1734601067939; 
 Thu, 19 Dec 2024 01:37:47 -0800 (PST)
Received: from smtpclient.apple ([116.73.135.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f4477c8537sm919487a91.21.2024.12.19.01.37.45
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 19 Dec 2024 01:37:47 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH v2] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <rnhi7vmax2vicc56xpaltjbfnffto3k7awaum4eblqlts4uhd2@ivqgxapmdnj2>
Date: Thu, 19 Dec 2024 15:07:33 +0530
Cc: Alexander Graf <graf@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A29831BB-032B-4F8B-9935-69439BD1DD1B@redhat.com>
References: <20241216114841.1025070-1-anisinha@redhat.com>
 <rnhi7vmax2vicc56xpaltjbfnffto3k7awaum4eblqlts4uhd2@ivqgxapmdnj2>
To: Gerd Hoffmann <kraxel@redhat.com>
X-Mailer: Apple Mail (2.3776.700.51.11.1)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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



> On 17 Dec 2024, at 8:51=E2=80=AFPM, Gerd Hoffman <kraxel@redhat.com> =
wrote:
>=20
>  Hi,
>=20
>> +Fw-cfg Files
>> +************
>> +
>> +Guests drive vmfwupdate through special ``fw-cfg`` files that =
control its flow
>> +followed by a standard system reset operation. When vmfwupdate is =
available,
>> +it provides the following ``fw-cfg`` files:
>> +
>> +* ``vmfwupdate/cap`` (``u64``) - Read-only Little Endian encoded =
bitmap of additional
>> +  capabilities the interface supports. List of available =
capabilities:
>> +
>> +     ``VMFWUPDATE_CAP_BIOS_RESIZE        0x0000000000000001``
>> +
>> +* ``vmfwupdate/bios-size`` (``u32``) - Little Endian encoded size of =
the BIOS region.
>> +  Read-only by default. Optionally Read-write if ``vmfwupdate/cap`` =
contains
>> +  ``VMFWUPDATE_CAP_BIOS_RESIZE``. On write, the BIOS region may =
resize. Guests are
>> +  required to read the value after writing and compare it with the =
requested size
>> +  to determine whether the resize was successful. Note, x86 BIOS =
regions always
>> +  start at 4GiB - bios-size.
>> +
>> +* ``vmfwupdate/opaque`` (``1024 bytes``) - A 1KiB buffer that =
survives the BIOS replacement
>> +  flow. Can be used by the guest to propagate guest physical =
addresses of payloads
>> +  to its BIOS stage. It=E2=80=99s recommended to make the new BIOS =
clear this file on boot
>> +  if it exists. Contents of this file are under control by the =
hypervisor. In an
>> +  environment that considers the hypervisor outside of its trust =
boundary, guests
>> +  are advised to validate its contents before consumption.
>> +
>> +* ``vmfwupdate/disable`` (``u8``) - Indicates whether the interface =
is disabled.
>> +  Returns 0 for enabled, 1 for disabled. Writing any value disables =
it. Writing is
>> +  only allowed if the value is 0. When the interface is disabled, =
the replace file
>> +  is ignored on reset. This value resets to 0 on system reset.
>> +
>> +* ``vmfwupdate/bios-addr`` (``u64``) - A 64bit Little Endian encoded =
guest physical address
>> +  at the beginning of the replacement BIOS region. The provided =
payload must reside
>> +  in shared memory. 0 on system reset.
>=20
> I'd suggest to make all integers u64 (little endian).
>=20
> Any specific reason why vmfwupdate/opaque is 1024 bytes?
> How about using 4096 (aka PAGE_SIZE) bytes?
>=20
>> +On reset, the hypervisor evaluates whether ``vmfwupdate/disable`` is =
``1``. If it is, it ignores
>> +any other vmfwupdate values and performs a standard system reset.
>> +
>> +If ``vmfwupdate/disable`` is ``0``, the hypervisor checks if =
bios-addr is ``0``. If it is, it
>> +performs a standard system reset.
>=20
> What is 'standard system reset' in SEV-SNP mode?  I think qemu does =
not
> support it right now and will simply poweroff the guest instead.  Will
> that continue to be the case? =20

No. Work is in progress to support VM resets even in SEV-SNP.

> Or should qemu re-create the VM context
> in that case, simliar to the firmware update case,
> except that qemu
> would have to use the default firmware image then?

Fw update works both in coco and non-coco cases. Will update the doc in =
v3.

>=20
> Will the vmfwupdate be supported without SEV-SNP too?  Might be useful
> for development + testing.  If so the spec should clarify what happens
> in that case, because the concept of "shared memory" does not exist
> then.

Will update the doc in v3.


