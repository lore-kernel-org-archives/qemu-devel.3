Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18FC5C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 20:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHrVu-00030v-Tc; Thu, 13 Jun 2024 16:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sHrVu-0002zj-1H
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 16:57:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sHrVs-0000jQ-Cn
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 16:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718312258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QC78PEmRFiOowdsFUB0N5gB2tedbbpskq6Ilu/rAR5E=;
 b=TOeoa6YylvYySPcB+W8hgIxfx78F3M8whsf+JVPvy2FXNPdfdscG8s/T4wQucqKfM5P1cb
 UDN4NBAtYD8fVjbmOAxVXE/J3n1a8XmG26uLQERULPOyZTDieYuJeL0Z3RvhOIWU4jNyCU
 1ncdINOAjrlgp1Mk43ed+vHcB3mByNg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-sxiersT_MVywMrc6ON_KAA-1; Thu, 13 Jun 2024 16:57:36 -0400
X-MC-Unique: sxiersT_MVywMrc6ON_KAA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-35f0d66bed9so876138f8f.3
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 13:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718312255; x=1718917055;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QC78PEmRFiOowdsFUB0N5gB2tedbbpskq6Ilu/rAR5E=;
 b=YD3U4O3w3npoopbQejwJg2gDQnj7eVKVlbm+YhbrKJw/nvv9PxM+lXxnW/GfTiI36L
 dJiBe55TSRy0HjuThfy2HJ0CBz3yDkpABBsEMhOv2uidheuwmwAvGHsm8IPXW/79me0t
 dykcOkY3c/3LqOBp83XI8x1zr36grqYtcn4fk+mnGAx6L4nYZ91VrL75bWQ46LPKlvZB
 CJDeWK8irdBsnFenQ+J3AFdtSV050H+W7NuH99WKoNCwXTtHnOPg+w2KBkieL9+BbQC4
 tJtqen7WbddxUhTHoqJe8DxpHNcLidUc/bIk5DBUrYzL4ELC3Cg4odBvrwB502TF9HRt
 qrqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4Kdim5Krs7Z0euod9qIVHqrhSX4QcevIQkF73HMcnlZ3/0gIKlCvCKoKzUL/+ILf8918PonBDLZZPT8UAMxEBYkRfElA=
X-Gm-Message-State: AOJu0Yyx1BUoNXOL0uKIpHoiFsz2kErVNAcyt17QcYpYREph9t07ggfM
 DtXbZCLp5hRJfNohzawzk+SByRxC3yANhZhzceIS1oOK5FieuShXL9MccVxS9ecCIW31lSoWYsG
 OkXqyjWBADAfu5d05QS5vxl2LwUzMnM3V9Ru+mIQNAQE0un+4j+/P19Lo42M+t1PjJpvld7S531
 clj+weBBBJTAvKxpPQ/RJRQqT9rSA=
X-Received: by 2002:a5d:6341:0:b0:360:7279:858e with SMTP id
 ffacd0b85a97d-3607a7d96e2mr390890f8f.50.1718312255411; 
 Thu, 13 Jun 2024 13:57:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3yNt/ZMRnZe7jtdqrm/DnGX85d/Ql35xrxqYMVMeAsUb12wCbmlmoiIrnI/1gSLb7e+5+zp1iepe2umjMY7U=
X-Received: by 2002:a5d:6341:0:b0:360:7279:858e with SMTP id
 ffacd0b85a97d-3607a7d96e2mr390878f8f.50.1718312255066; Thu, 13 Jun 2024
 13:57:35 -0700 (PDT)
MIME-Version: 1.0
References: <rust-pl011-rfc-v2.git.manos.pitsidianakis@linaro.org>
 <0fde311846394e9f7633be5d72cc30b25587d7a1.1718101832.git.manos.pitsidianakis@linaro.org>
 <CABgObfY8BS0yCw2CxgDQTBA4np9BZgGJF3N=t6eoBcdACAE=NA@mail.gmail.com>
 <ez270.x96k6aeu0rpw@linaro.org> <ZmnHoajecti472mi@redhat.com>
 <ezjl0.qx0tmsp6d6t@linaro.org>
 <CABgObfbGwKc0RYBcDPzNkE8HOSouFj4D15Oh7TuiKOC+D7raaA@mail.gmail.com>
 <ZmqcFf0xB9m4WkA3@redhat.com>
 <CABgObfb4+FSsadFTVg6Dc1zehQV2Vei2_kSRd5CfxsGBLPN6Eg@mail.gmail.com>
 <Zmq47yQV-sQ0hGMy@redhat.com>
In-Reply-To: <Zmq47yQV-sQ0hGMy@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 13 Jun 2024 22:57:22 +0200
Message-ID: <CABgObfYaxBxc8GS3=YU=EwNLEihEoD4ikZ595P4m_KTZCAAaBw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/5] rust: add PL011 device model
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9_e?= <alex.bennee@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

On Thu, Jun 13, 2024 at 11:16=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
> I guess there's a balance to be had somewhere on the spectrum between doi=
ng
> everything against the raw C binding, vs everything against a perfectly
> idiomatic Rust API wrapping the C bniding. The latter might be the ideal,
> but from a pragmmatic POV I doubt we want the barrier to entry to be that
> high.

Yes, I agree. I guess we could make things work step by step, even
committing something that only focuses on the build system like
Manos's work (I'll review it).

I can try to look at the basic QOM interface.

Manos, can you create a page on the wiki? Something like
https://wiki.qemu.org/Features/Meson.

Paolo

> Is this not something we can figure out organically as part of the code
> design and review processes ?
>
> e.g. if during review we see a device impl doing something where a higher
> level API would have unambiguous benefits, and creatino of such a higher
> level API is a practically achieveable task, then ask for it. If a higher
> level API is desirable, but possibly not practical, then raise it as an
> potential idea, but be willing to accept the technical debt.
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>


