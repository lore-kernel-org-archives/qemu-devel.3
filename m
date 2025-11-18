Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 849ADCEBF92
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 08:46:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLHLK-0001zF-8d; Tue, 18 Nov 2025 03:45:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLHLH-0001y0-Ah
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 03:45:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLHLF-0001Vy-D8
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 03:45:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763455536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EeH7esf9DAprT3Wwab6GVJxBQKPkkelL/OieD6b8Pwo=;
 b=AHtRVgVMJXYYfsOymrpSlvzjET9v4zz9VUUA7EF5tG7LwX3sDNwJRLMRUCQsgWCelzMA/3
 5RXaRSkP208IoEVWhEnD4DGB6876QYDeNAuQNzKTrJSY6TSIYxjY+MnPKoWmxdhnpoFKRG
 bACIeZR054cuCemfOtXbgvBlAa51oi8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-Tf_E8UfoNt6l91kR9U_fFw-1; Tue, 18 Nov 2025 03:45:34 -0500
X-MC-Unique: Tf_E8UfoNt6l91kR9U_fFw-1
X-Mimecast-MFC-AGG-ID: Tf_E8UfoNt6l91kR9U_fFw_1763455533
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4775fcf67d8so35636465e9.0
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 00:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763455533; x=1764060333; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EeH7esf9DAprT3Wwab6GVJxBQKPkkelL/OieD6b8Pwo=;
 b=LLFg9TcdI8BDOKs/IAWhf81E+XlnKmsAbwJKsN5W9vCOWDDfr1LqTh3iecBGLg4xOZ
 OrwgwWoZnHsvFhLEAI8IJz18ToZla9K0ceWiM9L3pVN4kTTWqp9e1O7WM32mzXHXKOec
 hPm5wJreO9Jnho3eQZmY9dqOYLmgUSeaxilhZlzMR75Bu85ghTSlpT+R6YlAWnFNPFgD
 x/9th2Z6/7kS+gKFYT1xPOA70BGic02A1jHnfc4wY6vvNyoiZdMMOqB0dnOY4Ar5JRSn
 eRii0vlLmcKUccpieIoy+gbrmWnrqpvPe+kkckycOGobBw1ZwhCi4dGP3fkxe14w9LTE
 7CIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763455533; x=1764060333;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EeH7esf9DAprT3Wwab6GVJxBQKPkkelL/OieD6b8Pwo=;
 b=S2MOIyFX2YYBpYGdooEoyKulN88kU8ZhUW0fPIKeUGedc5eSx2YQQFMvMeU4sl1D66
 hVVhZRHWWJUyrOVEvKbpPODhdhgBhbO6Jthv81xAnXeuBqgM4NDY5jArZjZy8bL9aWeR
 9O7m43eCQHyDvrTS3fCEZVkpecIvvC011dBPI9hRFGbGiQsUWoL91HnbA3p7wE4uzA9n
 IRBSh7OWXxkRq16/iV4MHk7+eKdkj70uO0xm48ioEoMKnPgbcwheOFLUOcYy8qvDEi1X
 11VYrhA2bKqiuxayEeHzUHOtHi9RKKguvant20YkDFZLoMcGVEtFtPgko8GtzDPVZbs8
 Ewmw==
X-Gm-Message-State: AOJu0Yw2I7oY+MyLm7uGllsFHq2drHiRBdMJLH16jLXRR0NjTFae/2b1
 eaTmlbPy2nAJw0lU+o2QWQmvJtEIDUJnyyfu8+5BzvfIcqKQl6UqtPsE0nLLFTTd6T2jdwvzDK8
 DaGa+imL0c0ow8YHsEQLX4GNkELvY1ztr4AXpbLDiYtc/qSKsU1wXi0V0KRj5WrudWEy8sG27ap
 fFfLVKJ4UBMNL8EJavzpR7GXbbGkZzRZI=
X-Gm-Gg: ASbGnctpxfZo/cXKK6qWiqQu90cKeDV6e3i5ctWSqlZ3PjqrvgOB6BWzBOY42CaxCdh
 Pfc8WirPNxgmlXVEimKhbcWYITR5qtjXv2ZJEdbJgg6Fxb3eR+0qj9k9iTnf+NkMeasgicMOn7F
 kRnPt8gyqTEhL3qgAT4CNedvEBRBAfZLq6W8CL3z2NSu7vEkggUJb1mx3NbE+1svE8KFegWjRUd
 DNMfyO1aAg/+ETbXYHfErmWCTQmIEL1TY8Qr8BozJUT9GZTFfDGft4WxX3ksDiR1PTCg2k=
X-Received: by 2002:a05:600c:138b:b0:477:7a95:b971 with SMTP id
 5b1f17b1804b1-4778fe882d9mr157498005e9.31.1763455533306; 
 Tue, 18 Nov 2025 00:45:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWrtB6FWUpiS02Ik6Y450zpyrbX5cajldKAKN3E1QGqYwiRM+8a4yPoFPG5LR7JaP0i8DbMeuNFrUI9/4JqOo=
X-Received: by 2002:a05:600c:138b:b0:477:7a95:b971 with SMTP id
 5b1f17b1804b1-4778fe882d9mr157497725e9.31.1763455532932; Tue, 18 Nov 2025
 00:45:32 -0800 (PST)
MIME-Version: 1.0
References: <20251118065817.835017-1-zhao1.liu@intel.com>
In-Reply-To: <20251118065817.835017-1-zhao1.liu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 18 Nov 2025 09:45:20 +0100
X-Gm-Features: AWmQ_bkgi0c0szQngSlsuQGAHJe64NW4a3ZmXTN_JYX47_A2Hyxk0ZyYVHFXbMw
Message-ID: <CABgObfZSBjNzhMrCVxXV1zRCsT47Hz31H-ER7Qv0S+Haw6Ds+A@mail.gmail.com>
Subject: Re: [PATCH 0/5] i386/cpu: Support APX for KVM
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, 
 "Chang S . Bae" <chang.seok.bae@intel.com>, Zide Chen <zide.chen@intel.com>, 
 Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Nov 18, 2025 at 7:36=E2=80=AFAM Zhao Liu <zhao1.liu@intel.com> wrot=
e:
>
> Hi,
>
> This series adds APX (Advanced Performance Extensions) support in QEMU
> to enable APX in Guest based on KVM.

Thanks for sending this out, I left some comments on the patch that
adds EGPRs but otherwise it's pretty simple---good.

Paolo

> This series is based on CET v4:
>
> https://lore.kernel.org/qemu-devel/20251118034231.704240-1-zhao1.liu@inte=
l.com/
>
> And you can also find the code here:
>
> https://gitlab.com/zhao.liu/qemu/-/commits/i386-all-for-dmr-v1.1-11-17-20=
25
>
> The patches for KVM side can be found at:
>
> https://lore.kernel.org/kvm/20251110180131.28264-1-chang.seok.bae@intel.c=
om/
>
>
> Thanks for your review!
>
>
> Overview
> =3D=3D=3D=3D=3D=3D=3D=3D
>
> Intel Advanced Performance Extensions (Intel APX) expands the Intel 64
> instruction set architecture with access to more registers (16
> additional general-purpose registers (GPRs) R16=E2=80=93R31) and adds var=
ious
> new features that improve general-purpose performance. The extensions
> are designed to provide efficient performance gains across a variety of
> workloads without significantly increasing silicon area or power
> consumption of the core.
>
> APX spec link (rev.07) is:
> https://cdrdv2.intel.com/v1/dl/getContent/861610
>
> At QEMU side, the enabling work mainly includes two parts:
>
> 1. save/restore/migrate the xstate of APX.
>    * APX xstate is a user xstate, but it reuses MPX xstate area in
>      un-compacted XSAVE buffer.
>    * To address this, QEMU will reject both APX and MPX if their CPUID
>      feature bits are set at the same (in Patch 1).
>
> 2. add related CPUIDs support in feature words.
>
> Thanks and Best Regards,
> Zhao
> ---
> Zhao Liu (2):
>   i386/cpu: Support APX CPUIDs
>   i386/cpu: Mark apx xstate as migratable
>
> Zide Chen (3):
>   i386/cpu: Add APX EGPRs into xsave area
>   i386/cpu: Cache EGPRs in CPUX86State
>   i386/cpu: Add APX migration support
>
>  target/i386/cpu.c          | 68 ++++++++++++++++++++++++++++++++++++--
>  target/i386/cpu.h          | 26 +++++++++++++--
>  target/i386/machine.c      | 24 ++++++++++++++
>  target/i386/xsave_helper.c | 14 ++++++++
>  4 files changed, 128 insertions(+), 4 deletions(-)
>
> --
> 2.34.1
>


