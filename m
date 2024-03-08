Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCB7C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 08:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riVFK-0004zN-NY; Fri, 08 Mar 2024 03:06:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1riVFI-0004z4-4P
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:06:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1riVFG-0004Rt-NM
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:06:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709885182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pdpfohmo8tS/IDjuDINcAQxkEpN9cXnmIvwbghdi63o=;
 b=bZaKw7rPnPvGWaTZXyfv1PBLP1jsymjTJGb+GeraVJuRvvFh8XBNmEbpT/qAs8KBlfEgvb
 KUTge+6mZ5Ckvf6h2AcYDNxmmByGW7NFLAXrYy+ljfVYa9il/7qvIxPDQ0uO0axhSCslUU
 BDWzIW0PpwIfB1WT6JG2k7ipHKWXqqw=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-2D-VD_JIMlq5j3sfaJCHXw-1; Fri, 08 Mar 2024 03:06:17 -0500
X-MC-Unique: 2D-VD_JIMlq5j3sfaJCHXw-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-29ba8f333easo879702a91.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 00:06:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709885177; x=1710489977;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pdpfohmo8tS/IDjuDINcAQxkEpN9cXnmIvwbghdi63o=;
 b=h22cYtwvRG1JK6hXVjw3pF+espM8f/oDREQ0hqdR3Y5Dwo9oJ4Euv/e5wkpLMt8x6+
 iliUG3sVNtxN+xks4lQ9fRWJxh/H0rS7O97e7pTQB+u+z6qZqfLj8KXbE30UZoMcxicx
 H5QqMaUbViIYF2XtwfgSxzz1chRhsvfAQ8ZocgsIt9H8ciZCXq4AYxgi9tlbWsJZeohe
 7OKnhIsAu3JrbsTOM8i3CSqvvN10d6RzUAFwKSyLnpuPjxm4INF7zvVQFcreLVj/W4sr
 V29kub9WtIPEatHeQH4LhfPbP8bPQbtzcQfmvlhJ+Hi+X1WQw9PGxgg8rWfkhY8Wj+XW
 mccQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeHtrenZREnkCkOFF2E5savFjFuWwV+9zrvD/YDuR8Ym0CZc92HMVKsn6n1OIo+lpYrHVQ6IpvCBwS/10c4i0sih1gAWw=
X-Gm-Message-State: AOJu0Yxd/MVtLCzh7y7qconGecx06IehDgJ2PTBKaIX8r54UzE2VmCL/
 HxXRIoQm2dlnfIJooInDXOjR3AKH9lyFuQ/vRwAk2qsSfhTYyWYSNzgBpkccx4Iifxm8Uit8FO7
 fEf+jnLnTHj1StYkO7zUYUpXMKxIS1YuJAflUQmUNzAPqRICpDrfi7KY0cevQZJK76mbnt9Sk3Y
 zGDbs9LvyN3QurQ1Qd+ANoNuyekWU=
X-Received: by 2002:a17:90a:ebd1:b0:29b:6e9d:5897 with SMTP id
 cf17-20020a17090aebd100b0029b6e9d5897mr9866494pjb.23.1709885176792; 
 Fri, 08 Mar 2024 00:06:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUEco3b4bk8XK2HX1Ju1UBcJr8vFf4EbdPvd6upOMc2zhp1ZDAlnH5n9ZDxC5GBnHnAwM3+NZrGD2/bbQM6DI=
X-Received: by 2002:a17:90a:ebd1:b0:29b:6e9d:5897 with SMTP id
 cf17-20020a17090aebd100b0029b6e9d5897mr9866463pjb.23.1709885176519; Fri, 08
 Mar 2024 00:06:16 -0800 (PST)
MIME-Version: 1.0
References: <20240205165437.1965981-1-andrew@daynix.com>
 <CABcq3pGy+Lp8YZnMZVC61wu6jDvE0BYj3kuuvuXCA+ewOtJVfg@mail.gmail.com>
 <CACGkMEs9B+7SEy1naQCQwXQDd7bzRZGjxv2h_QHx8g_az6E=Fg@mail.gmail.com>
In-Reply-To: <CACGkMEs9B+7SEy1naQCQwXQDd7bzRZGjxv2h_QHx8g_az6E=Fg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 8 Mar 2024 16:06:05 +0800
Message-ID: <CACGkMEvMoK+MZx7WkMzzVpyHw+agac38Td-aVq3Ygwb4jNhXmQ@mail.gmail.com>
Subject: Re: [PATCH v9 0/5] eBPF RSS through QMP support.
To: Andrew Melnichenko <andrew@daynix.com>
Cc: mst@redhat.com, armbru@redhat.com, eblake@redhat.com, 
 qemu-devel@nongnu.org, berrange@redhat.com, yuri.benditovich@daynix.com, 
 yan@daynix.com, akihiko.odaki@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Mar 8, 2024 at 2:30=E2=80=AFPM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Mon, Feb 26, 2024 at 6:23=E2=80=AFPM Andrew Melnichenko <andrew@daynix=
.com> wrote:
> >
> > Hi all,
> > Jason, can you please review the patch set, thank you.
>
> Queued.
>
> Thanks

This seems to fail CI at:

https://gitlab.com/jasowang/qemu/-/jobs/6348725269

Please fix this.

Thanks


