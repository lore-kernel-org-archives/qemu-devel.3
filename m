Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 503E8C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 10:29:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkhJv-00075J-FT; Wed, 19 Feb 2025 05:28:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tkhJt-000754-LS
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 05:28:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tkhJr-00016J-OY
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 05:28:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739960922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=byBTgz/OpLLyKnRfgfVjKGNyfqCtbzluS8k2nabvk2o=;
 b=KaDwoccqFF8mvhhFvtoeSQZbgGvAma4jPUKVWiv6M4U2xtbs/VcBMlaJ/T4QHEcx7Ck8g9
 dx30Af5rryFOFT/DYWLaU8YP78wA9ZqXaqG6MJbnAQgMYLzlB0P7wq+9PdsBCt4Q/1bPrX
 slUJji33HHkVZMoiaXxPzMftk3dcVxI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-87eyXX6fPt-N3C_wb_Yz8A-1; Wed, 19 Feb 2025 05:28:39 -0500
X-MC-Unique: 87eyXX6fPt-N3C_wb_Yz8A-1
X-Mimecast-MFC-AGG-ID: 87eyXX6fPt-N3C_wb_Yz8A_1739960919
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38f34b3f9f1so3140287f8f.0
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 02:28:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739960918; x=1740565718;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=byBTgz/OpLLyKnRfgfVjKGNyfqCtbzluS8k2nabvk2o=;
 b=KVvXmqTlQQemJSWErgYpMBCdUu6gWdKO3fUQGhskAeGqHRs/xCNYjmfesSiaYXpXyX
 zhA7H9iTn1sdHd39N+9WAvKvaeFcxGfsaJt9gxXNf6yfvnFp/KJhVGRCwKmd9REFOWXt
 ySMP3XIg7alIN9Xv7JHAxC81EfO5ziQX9utsc4/g+NvDspdnCr4P4fCWeezIUiubtpmK
 aX4/OhM0X0+cX0y2ybT/DCMRrWkuWi94oBxmPsReO+MKPO+/wdrCQu1CYhTcUodH1+hc
 6a3/HZp6RPXP/YE+JtA9EOyPsr9mtLUBDG7dYVXR6PmpZbCRxoRfOwma0L4u8Xdch/Kj
 QH3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOAuxZqyufEmBlIwSfZeOwOj8d1oDoCvjxX0M5U6sMovGd3HTofm1RMh4phzb1r440ol2PTmnM0FEL@nongnu.org
X-Gm-Message-State: AOJu0YyNVZkuH0/+3s4wpl7bJpj6HgYkE9VoO9THTPlBNq8ncemuufQF
 nd3iTgrj2t579k27EHYYsgSWne2JCpmloGjQy+OnxKJJiLP8UZZduRZfFv0Nif/d5aptf2+yb74
 sNh+HhNx2czaP8bGh5KEERG/M88CvlG82qRjJFN4nCX8ibhmQ0RSTt/G7AqdckoCaU9jH8r8PMv
 soFn0OLCxbjV1WB5z/dMDad6GnKOq9AuG6ZsLVZg==
X-Gm-Gg: ASbGncvm+RrDcy6MraPxJvw3qyt4pKZiaiYwq1loSoS9DguSwvB413gKsNpEHQq1Dgb
 noROCnUzSu2K9i4seh5cGCwGoTe3Ww1tZotq7TvoMynizPbVfzTr25g+vsrawH+I9
X-Received: by 2002:a05:6000:400c:b0:38f:2a32:abbb with SMTP id
 ffacd0b85a97d-38f58781d2bmr1987335f8f.4.1739960918120; 
 Wed, 19 Feb 2025 02:28:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE009v+efCzfDWU+xFgZNRG9KdIPSle8vbmwuREFTReLqOAaA2+f9CCCF7AJ3EK30fzOAAQaeKpQPF3VxFchPs=
X-Received: by 2002:a05:6000:400c:b0:38f:2a32:abbb with SMTP id
 ffacd0b85a97d-38f58781d2bmr1987323f8f.4.1739960917798; Wed, 19 Feb 2025
 02:28:37 -0800 (PST)
MIME-Version: 1.0
References: <20250212112958.38023-1-philmd@linaro.org>
 <c33817a1-74d4-47b0-93d3-000cfd6200be@redhat.com>
 <CAAibmn2Ohd_-k5LGqo5m1xzLrrs2UYxCT6U_XEKsJYScfCpx6g@mail.gmail.com>
In-Reply-To: <CAAibmn2Ohd_-k5LGqo5m1xzLrrs2UYxCT6U_XEKsJYScfCpx6g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 19 Feb 2025 11:28:26 +0100
X-Gm-Features: AWEUYZnkD8YrsRi1WFbCZukB1z5-tIaFzP7ijIzXemG8zth9fxqS24KZnpo0u88
Message-ID: <CABgObfaq2m42tBUAmskSXm-fR6zKDtApAsR4rYYqg8dnMq+Bog@mail.gmail.com>
Subject: Re: [PATCH] meson: Display summary of Darwin libraries detected
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Tue, Feb 18, 2025 at 3:55=E2=80=AFPM Phil Dennis-Jordan <phil@philjordan=
.eu> wrote:
> It is not cross-architecture. So, the PVG guest drivers with x86-64 macOS=
 don't
> give useful results with the aarch64 macOS host PVG framework. (I suspect=
 a
> mismatch in texture memory layout and perhaps some other data format issu=
es
> Apple's GPUs use a "swizzled" memory layout, whereas Intel/AMD/NVIDIA's d=
o not.)

Thanks, that helps.

> In summary, hw/display/apple-gfx-mmio.m has a hard dependency on aarch64 =
*host*
> systems, and both apple-gfx device variants only make sense when host arc=
h matches
> guest arch. (Unless you're a developer attempting to find a workaround to=
 the
> incompatibility.)  I'm very much not a Meson expert, so this was my best =
attempt at
> encoding these facts in the build system. (And nobody suggested anything =
better during
> review.)

I'll find a way to do that, thanks. I also would prefer to add
--enable/--disable-pvg; I
can take care of that, but I just need to know...

>> Either way, the Kconfig file does not need "depends on AARCH64" and it
>> should have just
>>
>>      depends on MAC_PVG
>>
>> with an "imply" somewhere in hw/arm/Kconfig.

... which boards should enable MAC_PVG_MMIO? Is it only VIRT, or something
else?

Paolo


