Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE0CCAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 14:54:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyX3l-0002bk-ED; Tue, 16 Sep 2025 10:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uyX3h-0002az-TZ
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:53:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uyX3d-0004XE-Sg
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758034400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iquDqYMJDVequs2yGGug36vnCjQzOwTxW6ZHlCaMBPw=;
 b=gvbKeWZ3LD1b3tQI5sBtnmqZpkQ+y01PXQTuvQujYce4J9tc9qXt8SGHedmxwpgpZngaEu
 YQkZt9D/F8ifk+nWf0lNv1Av4U6pMY0Asj6fDo+yGsqCtdL5K5AikFVTTgDa39CoOBbfT1
 EKNfKxz/4aV4ZegG8ppZOvP9okF2pvc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-l9nzPLKtOSuwOcq6o22AOQ-1; Tue, 16 Sep 2025 10:53:18 -0400
X-MC-Unique: l9nzPLKtOSuwOcq6o22AOQ-1
X-Mimecast-MFC-AGG-ID: l9nzPLKtOSuwOcq6o22AOQ_1758034397
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3e997eb7232so1370051f8f.3
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 07:53:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758034397; x=1758639197;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iquDqYMJDVequs2yGGug36vnCjQzOwTxW6ZHlCaMBPw=;
 b=Aza3zB8662chrmgBFoNEwLURdRQc/+fiPGExsJeBfRZ5hWTarG4PQPhVloSRB909f3
 1VnvyX94wyffYHYtFMoxbpzWlPpfQ/YS4/k+3q6MZeRXvkZXGqTNsp0P9HwiNBh1SzXZ
 8UacV/vTAZ3QRqqtw2c0SBYyxRPiFgH30C5G/mU6Xy8g5PxRMuzyrSPZ574g3sUqvRE4
 VPcDgksGPLGutDQsI+C/qSo0EmnF482fGEYWLWASVDhoFcpROh8tD8etL2OnjKSNzkVr
 630uDOoE9fn5JxqrpPWmsqXP9/6RscPqomk/zMCw6V0uKmZEHl2Q/nmrgGPj80cEJdkQ
 PIsA==
X-Gm-Message-State: AOJu0YyUKG2rkAoZKHKpn0PJLbPNLcfhGhiAoT+EU9IytHop48ar6BrL
 gMxCcY3tx5UnG5yTcQIuIoZKj5r5kpHXxB5Dpo8aKd3MbOO+CPXwcHIfRs5AL/CyBC3Td2lPiFw
 1d5Rlq3b+WYgltgnysZB1uinY1GUf8upl4Opo+2IHOzMBcicB/DC/s6BAOhfdG8M8F8dcbhBPal
 o9/jc7qmyPqXchfkVTUY2Zc466YwSOKwI=
X-Gm-Gg: ASbGnct6AHtogjPA022e0wVACqZYfSGYcA9n7pj5JsQqfDZsNhEdz3q4wygEYdhB+XU
 SBozDZv4Mh/tpHTkMtj/CaUYcuGRmxxUeNR269l7Jke2p3EdmQRl2OysTqlUCM5JWLgjp7sgqVR
 p4b35zdUqokatm+su9mS7aWyCj+lN6HwRJSnPXnGZqTTvTNqaFHOsrLDO31+SbprOWnG3/OT48m
 QXc6bZlGcj+KXwBmKeoIGJC
X-Received: by 2002:a05:6000:4014:b0:3eb:d906:e553 with SMTP id
 ffacd0b85a97d-3ebd906e5eamr4987504f8f.55.1758034396640; 
 Tue, 16 Sep 2025 07:53:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVBSJ7Onk8U6ksJej6NNxhfFuAedzN54HJvPfpAb+VMwv3x8AOZK6IDltl61c/lsbfNb4nIy4e3jdyxOAmXUQ=
X-Received: by 2002:a05:6000:4014:b0:3eb:d906:e553 with SMTP id
 ffacd0b85a97d-3ebd906e5eamr4987472f8f.55.1758034396112; Tue, 16 Sep 2025
 07:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250913080943.11710-1-pbonzini@redhat.com>
 <CAFEAcA8nFU1fRFMQ_jLcDzKPoPKeV789L5iTgq-kqoa0zULmaQ@mail.gmail.com>
 <CAFEAcA_+6hXCO3ruA+P_pYVGjtdCA-Li27D13McTf17GX4S94g@mail.gmail.com>
In-Reply-To: <CAFEAcA_+6hXCO3ruA+P_pYVGjtdCA-Li27D13McTf17GX4S94g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 16 Sep 2025 16:53:03 +0200
X-Gm-Features: AS18NWDtk54-71T0yfKnnU0_ZL7XWS23QnsrY03Vs8QA78qUoGc1bKIoAiXPIAA
Message-ID: <CABgObfbxTszgA3v2MUs_mLz-0nDENijFhWWuEWWFwTTXN8V9+g@mail.gmail.com>
Subject: Re: [PULL 00/61] CPU, Rust, x86 changes for 2025-09-13
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.009,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Sep 16, 2025 at 4:38=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
> So if I understood the outcome of today's call correctly,
> we should hold off on the 1.83.0 bump until that version
> has landed in the relevant ubuntu LTS distros (work in
> progress on their side), but after that it's available
> in all our target distro versions and we can take it as
> our minimum supported version ?

The missing pieces before Rust can be enabled are:
- tracing (posted, needs rebase)
- CI (needs Meson bugfixes)
- dtrace support (stap)
- lock-free MMIO and required support for Migratable<Mutex<...>>

Since Rust 1.83 is a requirement for most of the changes that are in
this pull request, holding off on it would basically mean that any
further Rust changes have to be developed out of tree. Since the above
list is not short, won't even be completed in 10.2 in all likelihood,
and doesn't include other things that people may like to work on, I'd
like this development to happen in tree.

We do have to hold off on enabling Rust until 1.83 has landed in
Ubuntu but, as I mentioned
https://lore.kernel.org/qemu-devel/0c35eccb-890a-47d1-8c54-9945519f6164@red=
hat.com/,
it's really unlikely that this update will end up on the critical
path. Work is already in progress at
https://bugs.launchpad.net/ubuntu/+source/rustc-1.83/+bug/2120318.

In the meantime, while Rust will be enabled progressively in more CI
jobs, Ubuntu can remain the one which tests the Rust-disabled case.

Paolo


