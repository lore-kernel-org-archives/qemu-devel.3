Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89053CA0EFA
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 09:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqTMU-0001Db-Nt; Mon, 25 Aug 2025 05:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uqTMR-0001D1-CE
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 05:19:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uqTMJ-0006ZQ-IQ
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 05:19:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756113555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KLkdp6CPGnf7GSk3NrPZWgfuK6t8oUSjJm1qJ9+YwnM=;
 b=FDSNo9Z++2peB0prwbOq1Uvc3eQ4QmvySS4GXhzUPHi/856OrZ0Y9qt3SHf8oQSLDxszh0
 8vuH4BJrtjwBt5PYZReFFVNFEaP6TI5K2Pa/b7AOEdJU3LDAOOQ2OGdB54+VnlZQj3VoRH
 cmyodTBWlVP0MhCbQBiv1YW1g7pqoF8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-vZ2ELM0TNwy-KwyUrDGuOQ-1; Mon, 25 Aug 2025 05:19:11 -0400
X-MC-Unique: vZ2ELM0TNwy-KwyUrDGuOQ-1
X-Mimecast-MFC-AGG-ID: vZ2ELM0TNwy-KwyUrDGuOQ_1756113550
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45a1b0060bfso27136935e9.0
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 02:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756113550; x=1756718350;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KLkdp6CPGnf7GSk3NrPZWgfuK6t8oUSjJm1qJ9+YwnM=;
 b=T4LbkW9fCZailiPm/03Tw9LD2hO3MTgLkPKeMs1fMYFzE3uTHtscNGSBiXwKSMq2vr
 rQSfVq8zHtYmqjaJH7OwGjLXW2yVIHiTuhcMAq/mCYOOqcKkVB2lCHs4jsXK2ZfiQSV2
 GwTXxPD6TyPJZZ04vYHrzAoexI4yBBH61/u9CE5Izj0W2U+DOLXq6uju9erpJ/+hffhR
 7tgGSbkeD77cdVRLZ7aKqond8iJVlAtZFyKo1Va4EXkjLmCLbNJRJPKj4ETpDYU3a4WL
 56mmyUDbqfCMl8H7A3F8e7EFVJ0n9Ltsf7kRx+ithRYb8NWKUuUM75WoJbR8VCYDAdmL
 DjNw==
X-Gm-Message-State: AOJu0Yz1LiFh2f02bzTWpnXjOSSvuXkPT0Ao+otWVmrEXLwWdOhlkX3V
 OybEUC+cwanu9kT/7y9vHyIc82OHTSN25IqcTCRKw8Oxju6Ke6ttQNSDa31682vYkZ9xlVXLjNL
 d0aCHZMH5lLTqM6f5AtSHi9w+bIu6lPW6NE5XdeH0ghe8WgXzcXpiET5kRHuHKanve4TSv4O74m
 Uk8xN7JAIHeGSMr8lf/eQbsjUU2Nicm38=
X-Gm-Gg: ASbGnct7UfhVV5VKT3c9yrIOWfnOQU4dn6h0w0R6FER0IepPUnC61wBguVrC3YbeFfy
 ry0Q35gtpvL+wzOvhD//D1IpSO/+j5ZDfcoeuljzAgI8+Io1O4gPdwUhm5hQvnzcxTHwC+kWSHf
 F6lblABLHWxQnl5/4bLMrTePfjHzvUWQ97wrZv7jQJqi1B31/TQORe/nmMA3PWpcOjHO41BHGGF
 EPrqKEKxb+kgQBmX/1yiQ/e5g==
X-Received: by 2002:a05:600c:3b95:b0:458:bda4:43df with SMTP id
 5b1f17b1804b1-45b517cba02mr103123115e9.17.1756113550179; 
 Mon, 25 Aug 2025 02:19:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELQH05dwUR16m6QT5xll79LwrCE44kH49u+FliRP9qSvjbgakDsB29rhWbMsE/W7lckgk8U8nZJq1Cx1xUNBU=
X-Received: by 2002:a05:600c:3b95:b0:458:bda4:43df with SMTP id
 5b1f17b1804b1-45b517cba02mr103122595e9.17.1756113549763; Mon, 25 Aug 2025
 02:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250822122655.1353197-1-pbonzini@redhat.com>
 <20250822122655.1353197-2-pbonzini@redhat.com>
 <CAAjaMXZbYXTiy5jQ-iNrWersX8Ggdd6M7FhrOUYvt6hjY4PbRA@mail.gmail.com>
In-Reply-To: <CAAjaMXZbYXTiy5jQ-iNrWersX8Ggdd6M7FhrOUYvt6hjY4PbRA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 25 Aug 2025 11:18:58 +0200
X-Gm-Features: Ac12FXx-2WlMGtF2yJOBGPi7-8FpRC7xLZ4oFcbjrkJg3U667kUZIaWvR1yVDG4
Message-ID: <CABgObfa4soFDJ8VYzsYJUo=jvhakA1zwmj6xozT49bsYNn1qaw@mail.gmail.com>
Subject: Re: [PATCH 01/14] treewide: write "unsigned long int" instead of
 "long unsigned int"
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, tanishdesai37@gmail.com, stefanha@redhat.com, 
 berrange@redhat.com, mads@ynddal.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Aug 25, 2025 at 8:40=E2=80=AFAM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
> Why can't tracetool support this? Can't we just add the permutations
> in the C_TO_RUST_TYPE_MAP dict in "[PATCH 06/14] tracetool: Add Rust
> format support"?
>
> +    "unsigned long long": "std::ffi::c_ulonglong",
> +    "long unsigned long": "std::ffi::c_ulonglong",
> +    "long long unsigned": "std::ffi::c_ulonglong",

Just laziness. I guess I can just sort the keywords.

Paolo


