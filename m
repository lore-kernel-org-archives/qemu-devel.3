Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B059E65D2F
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 08:33:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEP5w-0002rz-Pz; Fri, 22 Nov 2024 03:32:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tEP5v-0002rj-Uy
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 03:32:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tEP5u-00019i-4Q
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 03:32:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732264367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vPgKYAovHm8G1oDfssARv2jTiR4Utk7GrWumL6zELeQ=;
 b=NAVZkon7XIW/PZfJAusFK/z+4GO/aIOlMUKU1r0SY+J5fUrSzLVv68iZoDQHACryxliM8W
 iIlzuTjAIlNaj0/V7lUGO2y6L9COOlhCnTbCfOiONAyNTu/8QjPxgYavnrF2uQvWHoXuwj
 pV9yNa/euMGXF0q8W0HGs2tvv9iPMmU=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-yytm3pr0Nr-baMAsCYKj5g-1; Fri, 22 Nov 2024 03:32:45 -0500
X-MC-Unique: yytm3pr0Nr-baMAsCYKj5g-1
X-Mimecast-MFC-AGG-ID: yytm3pr0Nr-baMAsCYKj5g
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-539e75025f9so1088020e87.3
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 00:32:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732264363; x=1732869163;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vPgKYAovHm8G1oDfssARv2jTiR4Utk7GrWumL6zELeQ=;
 b=bHsqyZq59bQbngw7JXppLXO/TRQBVKZLMy3rM+VSmJh2pePCkhBNrhFhLXq/aEiR5O
 1DwvT5yRAutxmgSxU1FnX0eN73OTtekapc2kz/tubFvKEx16LEpmE+Ko7dvcN/gVXxw2
 TP5WTDhw3wOW1ETH/hx7k7muhmMenyMPKN/G9GpfBEGQbFOfwJGRx3NHPPZ04jjBtTST
 WXyvUYPq4unH/CxpRnKhWN7MqMww2GIVdkchbOpEhEp2vfA5qN/AFPaa0NTefpVpdjwW
 YbtfytZ4VqwOzSk9c3RmgZ6bY3LWKeYpFKfsERUsa08sCBiqSlOLd3lVKU0BbVo0D6Kf
 Ba4Q==
X-Gm-Message-State: AOJu0YwZsG3nUTBQuo1QHcajKtRq77hSDb52kATcpPk3OFes4Vm3tuN3
 0nw7dUreKBa/bAowJq0lMbxo4XFpIRJAqd0755gabSp269W3F6os+eIB6j2xZxfIL/BWwIliboU
 UHDEj/PHbXnuRHnAmRDRpWRuPWjJYN1BfCebRAGYkHT/LKcDz2MgzVDy7g8IBfW7AXs3mksxa3+
 avtQJ7u2RTtkgrcxPYEMkAkGOIc0o=
X-Gm-Gg: ASbGncuAZoRXu/ugRrvjtl86LlB78g9w4QwidHNcaOjubjUm63Zr0imnhL1fT4e3tvw
 8QBR4mpX1bV50A8Xzwp2rg7sU/QthYGvE
X-Received: by 2002:a05:6512:32c9:b0:53d:c63e:beae with SMTP id
 2adb3069b0e04-53dd3aabef3mr849392e87.53.1732264363312; 
 Fri, 22 Nov 2024 00:32:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqqVf7csmeTnGDHbZ0CZ97gCX7Xxkmbyxuw3LsaUI+9Sx8Nrk+8uz4yz1wG8qTHr/V5TZRyBbXFyza1JhEE5A=
X-Received: by 2002:a05:6512:32c9:b0:53d:c63e:beae with SMTP id
 2adb3069b0e04-53dd3aabef3mr849383e87.53.1732264362976; Fri, 22 Nov 2024
 00:32:42 -0800 (PST)
MIME-Version: 1.0
References: <20241122074756.282142-1-pbonzini@redhat.com>
 <20241122074756.282142-3-pbonzini@redhat.com>
 <70f44731-6879-4adf-a71b-a781af48fe99@linaro.org>
In-Reply-To: <70f44731-6879-4adf-a71b-a781af48fe99@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 22 Nov 2024 09:32:30 +0100
Message-ID: <CABgObfbOj8FCvjXOM_AF8=jyFMi1bs-gfsRu+_GH3802hLhM1A@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: add bindings for interrupt sources
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, junjie.mao@hotmail.com, zhao1.liu@intel.com, 
 qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> > +/// Interrupt sources are used by devices to pass changes to a boolean value to
> > +/// other devices (typically interrupt or GPIO controllers).  QEMU interrupt
> > +/// sources are always active-high.
>
> So 'always active-high' = true below? (Wondering about pulsation, if the
> true -> false transition is always correct).

Yeah, I mean that raise uses true (or 1 :)) and lower uses false.
an example?

> Is this deliberate to restrict the Rust binding to boolean? (Maybe you
> envision a VectoredInterruptSource implementation for that).

No, I simply wasn't aware of that.  I'll adjust; do you have
an example?

> > +/// Interrupt sources can only be triggered under the Big QEMU Lock; they are
> > +/// neither `Send` nor `Sync`.

Oops, this is incorrect.  BqlCell *is* Send/Sync, but checks the
BQL state at run-time.

Paolo


