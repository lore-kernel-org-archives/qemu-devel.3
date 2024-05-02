Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E5DC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 16:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Yvi-0001f8-1H; Thu, 02 May 2024 12:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1s2YvW-0001TN-Tb
 for qemu-devel@nongnu.org; Thu, 02 May 2024 12:04:57 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1s2YvR-0004Pz-FD
 for qemu-devel@nongnu.org; Thu, 02 May 2024 12:04:52 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1ec76185c0fso188825ad.1
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 09:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1714665885; x=1715270685; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EDAXiO0gxua2B3ePNjjeSETOIpIhXW1c82rRYksCXxU=;
 b=PkeVAEq3C8kdHnFVu5aVO/CJENDq8t4lQh2IxfoEfU4IVzJJYKoScH2mwLTauA9CHx
 TbF8pKCxrHkYlK8tXnC2LOK7Ji56BDCeRn8mZV7MQfcb+2YJxW9u8hBB/1XKTCGO0nbH
 P9sudNqoYL3SEQrlWTuzNkTBJNW244bf9wHo9lKuXwL9nfMe3FYTpaQyD4e+52CjZXiv
 Doptxwh5ggDI+TOiv+6Bf4JDe/I/m0tzUV1mADwHXeivUZh1qA5DlUWvAOa7moZCXjRG
 Kbb4MZ3TY4E7g6+oeFdnJPdV7RnY1SXv+FWQYHc5gvkioQ+AM3rOpN8TdOqXEqWVCtRD
 W5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714665885; x=1715270685;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EDAXiO0gxua2B3ePNjjeSETOIpIhXW1c82rRYksCXxU=;
 b=RnDlxjl9k+JvXNVtthPTEtbUT9YN0/HFSmKHnVWgmWvn4wPq5Wwj42EJ9RFWl8qHqS
 +AodofsHaUdaYzeYcrSRLnnGBgzlYk07OV1tTPyzujKQAd+AoJ07rMCYagsSIvNDwKa1
 bbhnAHIJ3fEU+yYQFeDetjYZedAOdhuEEgJHYujDSB7GGaD870DrVBKfesMKF0cj8Va2
 Y/V771x05msh/gkcHbJKVND1ECJlTwKYi4C8ZqgKJ3b2TZHuU6OjVFgxO+UumNGHTtl9
 aaIahjHU3fc57z5k5k2fGh5ojreaAv/0zHkHXbAURWva4CeWK9E50pNMpRsSv82Zqv+I
 vO5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVfwWFQZ0ITLL1bk42nVxgwtL8ciBuVa30f9uCNuZ+QCajie83AhCsGiJiwABiQPvziyU+JA3i3bXrgMqrnalBbTh3zus=
X-Gm-Message-State: AOJu0YxDPJdRz/hefEvq+YsNgG9CEwo5jTqX5g7I/Rii4LGBcNDr8Rzc
 rc3WQOxOgHUeoSYxzwyDxMrs5B7QIa0XOscH+75ZyDLIScXsheiEkxlIAD7ZFt6L00lStteWXje
 p0tU8OhgN/GSK2XUcOlUpotc4i8Rr6Z/kCfmV
X-Google-Smtp-Source: AGHT+IEtxj39gWWnVDMO7pF+iuHgUKcJ+nROT50wWvpJRkKM11Z6Je37XMJdSW0d2mkAavvMuisr2MmVLGy5scf/QXo=
X-Received: by 2002:a17:903:2306:b0:1ea:2838:e599 with SMTP id
 d9443c01a7336-1ece5b48fcdmr2261255ad.17.1714665885215; Thu, 02 May 2024
 09:04:45 -0700 (PDT)
MIME-Version: 1.0
References: <4ead608e-7ab6-44b6-8712-fcf2e7ce6f51@redhat.com>
In-Reply-To: <4ead608e-7ab6-44b6-8712-fcf2e7ce6f51@redhat.com>
From: Roman Kiryanov <rkir@google.com>
Date: Thu, 2 May 2024 09:04:34 -0700
Message-ID: <CAOGAQeq5Mj5rpOeA5P+FiyPRN0LPE5EaU1u08s6=NjMWB-=0NQ@mail.gmail.com>
Subject: Re: QEMU headers in C++
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniel Berrange <berrange@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 JP Cottin <jpcottin@google.com>, Erwin Jansen <jansene@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=rkir@google.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Hi Paolo, thank you for looking.

On Thu, May 2, 2024 at 8:19=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> Anyway, just out of curiosity I tried to see what it would take to
> compile edu.c as C++ code, which I think lets us give a more informed
> answer.
>
> There were a bunch of conflicts with C++ keyword, especially "new",
> ...
>
> would not be a huge deal.

Yes, this is what I am talking about.

> So my answer is that we can't guarantee that QEMU is compilable as C++,
> but some of the changes are an improvement in general and some are a
> wash.  I think accepting the latter is a small price for Google working
> on upstreaming the changes and contributing the former.

Sure, we will send the patches.

Regards,
Roman.

