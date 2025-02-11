Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95BCBC0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 09:01:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thm8J-0006A0-O2; Tue, 11 Feb 2025 04:00:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1thm8I-00069I-1G
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 04:00:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1thm8F-0002R9-27
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 04:00:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739264436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o5v9t+9/fcL9IGx6vUBnu+RzuqIZpc3aR2eLKlG7hyU=;
 b=CpveKlVXfiNYnx6HNzRmPbJq1zwHQAHaEwDUiUNIvCLuVgh7ZrgdlRKIulsWao9PHeX0jF
 H7RTud1YoaiSN9GjIxgm0Dbxsfxw5oeXapOgdpzb+RvD8wrQrhLMMHsP3jhb2zTYCLq3zE
 o2/xK0o/CKiKDhp5+k/aXxYGg9v7+lw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-SpKQTdPgM0qgzuwgh291lg-1; Tue, 11 Feb 2025 04:00:33 -0500
X-MC-Unique: SpKQTdPgM0qgzuwgh291lg-1
X-Mimecast-MFC-AGG-ID: SpKQTdPgM0qgzuwgh291lg
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4393e89e910so12232675e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 01:00:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739264432; x=1739869232;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o5v9t+9/fcL9IGx6vUBnu+RzuqIZpc3aR2eLKlG7hyU=;
 b=Ol4/oL8Ir2oz9Cr1GWHPQ+0uQvYYM2pe03gVW+TdHLWZV+MrC/fc3MZWS9G5KUcRgE
 CR3v8GxDR8f4oytyGVk568VtXWiNy0TBMqJqW6TMWtke6DAdg1WEMYes9cksDTleS0s0
 MWtdTJUTYijks5wG6vUzMdnnFFnv34G/zYLSutn6fCJ2rYgIwDUL8oSaj8kEdLXPamVN
 D5yC8TbKf3uJj3X8AzB/UTJrZj1OXjsgYRvWCzD5ziZXB2d2UUKpLtZZ1t69U8sa0PCq
 Dje27gAguBmy9BzNdSPcPYfvKH4pmrR6kaGfzx5XlDjx8nJBwXQ3AjCd2mvSOaunXcKk
 SuMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYFci8RXIYgtaC4ALgW38ZvtliSjgya16TjkOZGEuV808XcEeGU8ErM2pO8Mr7k+hs20D7p+ghdaXr@nongnu.org
X-Gm-Message-State: AOJu0YxKbshOjRPtk+D2apKEt7m9YrlHYVO2HdpJ101cdyI8GQ2cRBsw
 9cbXNibv0Fa7IF6fy0e6iN4RQFYlYQ4iUKrvTvbQKCUO5ooTLGa/9f6VhCLdC4iuHtVhGcT4rmw
 BTNV4Fm5AYNe8ZsoLao8TfDPGkNre+Bqi674lgdR3mJyStc7KV5Hoym3gj2dDhVNY6x8tT/CKFg
 Morou5NhoQ97fFiCaYHBGOY2vSDRk=
X-Gm-Gg: ASbGncuxDsRD3jY1DW5qqO3j+tp8mCzcl54XxG2FLJHDbg/CTUuS0SlLHScymGuqp1V
 ZmtAJCA/DQo36XnzhBLmwgrYRJMRZ4s9hQwIbRrGfu+czMBIKtxAE5iguJPCO
X-Received: by 2002:a5d:4286:0:b0:38b:da6a:8a02 with SMTP id
 ffacd0b85a97d-38dc94914bemr10012988f8f.47.1739264432076; 
 Tue, 11 Feb 2025 01:00:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9SnDFOxBawFtRMNNd7IMii8ZyjLGLlWvXhBKendc7FrUTAzok6ZPnfhngKrdbLAaEpbd+7PRuQt2m/d/CcIU=
X-Received: by 2002:a5d:4286:0:b0:38b:da6a:8a02 with SMTP id
 ffacd0b85a97d-38dc94914bemr10012956f8f.47.1739264431645; Tue, 11 Feb 2025
 01:00:31 -0800 (PST)
MIME-Version: 1.0
References: <20250206111514.2134895-1-pbonzini@redhat.com>
 <20250206111514.2134895-2-pbonzini@redhat.com>
 <Z6nOAftJsjQ7KAiS@intel.com> <c7685bff-96d1-4e89-ba19-08fbba399d37@redhat.com>
 <SY0P300MB1026B9C81F2EF236BB703F2B95FD2@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
In-Reply-To: <SY0P300MB1026B9C81F2EF236BB703F2B95FD2@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 11 Feb 2025 10:00:19 +0100
X-Gm-Features: AWEUYZlEd5ovXBUFtA1NaKqmdeWeYQgOpWyQOuDmrpvMZBV1dGFLpqyBnnqffpk
Message-ID: <CABgObfbTx9DNkkzw8EeMRU0+L6_+P64KHtAJTUwsW40mtwGSOg@mail.gmail.com>
Subject: Re: vtables and procedural macros (was Re: [PATCH] rust: pl011:
 convert pl011_create to safe Rust)
To: Junjie Mao <junjie.mao@hotmail.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Feb 11, 2025 at 7:47=E2=80=AFAM Junjie Mao <junjie.mao@hotmail.com>=
 wrote:
> I would suggest to keep the "sysbus" prefix in the method name, or in
> general, keep the class prefix in the method names in XXXClassMethods
> traits. Otherwise APIs from different parent classes may also
> conflict. As an example, in the following class hierarchy:
>
>   Object -> DeviceState -> PCIDevice -> PCIBridge -> ...
>
> For PCIDevice instances there is an API pci_device_reset(), and for
> PCIBridge ones pci_bridge_reset(). Without class prefixes both will be
> wrapped (as blanket impl in two traits) as reset() and a dev.reset()
> call will lead to a "multiple applicable items in scope" build error.

Yes, reset is definitely a problem.

I will wrap qdev_realize() in DeviceMethods to check if you get
"multiple applicable items" from that as well.

I can also go back and add "sysbus_" in front of init_mmio, init_irq,
etc.; but on the other hand we have Timer::{modify, delete} and
DeviceMethods::init_{clock,qdev}_{in,out}, should they be changed as
well? I'm not sure there is a single solution that always works.

> I agree that uses of proc macros should be carefully evaluated to see if
> they really help or hurt. In this specific case, I'm not sure if using
> attributes solves the root cause, though.

Yes, it doesn't help if you have multiple similarly-named methods
across the "superclasses".

Paolo


