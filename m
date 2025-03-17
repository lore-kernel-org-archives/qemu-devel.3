Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A655AC28B2F
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 00:28:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttyJt-0006lK-S6; Sun, 16 Mar 2025 20:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ttyJo-0006l5-Hv
 for qemu-devel@nongnu.org; Sun, 16 Mar 2025 20:27:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ttyJm-0007km-P9
 for qemu-devel@nongnu.org; Sun, 16 Mar 2025 20:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742171213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6kMikf6Qw9+uNhSE4MPw/RzZYgbF5zUx0NEjVtZJwfI=;
 b=Xy9SfC044JP5uz73Q4I+rathze+hGw9SlbSZvP/w2Y6fMs74XsvTfY6ebnTCOIIDBshCZR
 ZZukOv40aFZoftF74wdRVKN+CUsrx5EgpDpBxjomOU1u7AhDlXjN/5ZJTMWz9uK3Dqar+B
 4vR639Xa1yZ7TvO7w1Xsh8Lu+mEBjoo=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-bmSVLBybPeCg-Ik2C0-16w-1; Sun, 16 Mar 2025 20:26:52 -0400
X-MC-Unique: bmSVLBybPeCg-Ik2C0-16w-1
X-Mimecast-MFC-AGG-ID: bmSVLBybPeCg-Ik2C0-16w_1742171211
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2ff6aaa18e8so2080191a91.1
 for <qemu-devel@nongnu.org>; Sun, 16 Mar 2025 17:26:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742171211; x=1742776011;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6kMikf6Qw9+uNhSE4MPw/RzZYgbF5zUx0NEjVtZJwfI=;
 b=Fcd0o39Vj/ifFGCQF4j9Ti804jSXzyqQ4I58JAE9TOcKrZNpBjAuMpl0ma5n7GShSA
 52KXjE7wrIk1POC1QE/QAd2VcCex4v2cJ4GhcPIjaqSsxtpbeYYUgsXNfvzv45mS6wN8
 ozHuvauTfQzbfgcZqOryexefduXgT18CJrWbAL6ExHVqvCLjPgBC3k+Dyoqslha8x9af
 /piFGK/Qbz9TqeKdq62b1LWwNXUbXNsstvrsu7PmKA9CU/ynr+ddecGAmYUJeJJVkJG3
 hBiM+1TExd4dGgJh3TgWblLa0vw3xjKuE0gRZGM9XTTq3FqaKvJZn5s/7AOW8Et7+yAu
 9R3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVZQ7BSEht8t0bV3JP5BLg2/LpnD4iVramVJm9D1yKL0SmpTYeG2ohAL3iiF8def9HuX18mU313FAH@nongnu.org
X-Gm-Message-State: AOJu0YzGXoYfz2Jrb7i45LbIb0J/L1dU9xV0DiHPSs/jxIdngsTHqp5S
 Y8I+fheKJ3zgLc486X99Qo54hGekmLX1Lp0zs37TlL8n8zGdSALbswgph75KGMwga0/Dj8T2kGJ
 YUnVoEES3q1EPLjzROQsGzJ75qqEWJBe87GhjJwjZQD4JOyQK3OoUME6CwUmKl4mA+R4G24++HU
 V33snnPa7ZiJ6Utp+NadPVQUao3cQ=
X-Gm-Gg: ASbGncsFVA/AKfNs4Jp8+IAzFdJ7Gr8wJ8D00kfVeOTjSOQ5oTkFpYvM0bsRE80o4wX
 OyBQkC0xXwcrcrsWzZKNGeCn1QSeGHgTw6hmH76DQt0eh/mwbA0bK9SrLsrkx7tHs0QsXkMFHDQ
 ==
X-Received: by 2002:a17:90b:5608:b0:2ee:d824:b559 with SMTP id
 98e67ed59e1d1-30151d9d704mr12674054a91.28.1742171211364; 
 Sun, 16 Mar 2025 17:26:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2jHlYHJF2I2OnxJqGn2FdWNXuJXZt8dvMp1hbopi93IpO/1TKROwcsdntWA8WgHvOOCCJoDHk/Jfl2K3nQAw=
X-Received: by 2002:a17:90b:5608:b0:2ee:d824:b559 with SMTP id
 98e67ed59e1d1-30151d9d704mr12674032a91.28.1742171210913; Sun, 16 Mar 2025
 17:26:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250221190733.490308-1-kshk@linux.ibm.com>
 <CACGkMEtm5gapBTmM_cA=jxAEg4GMkyMf4Wa47kvkFvN05uJ__w@mail.gmail.com>
 <0ea107ce-82f1-4333-b766-fda8e0cef454@linux.ibm.com>
In-Reply-To: <0ea107ce-82f1-4333-b766-fda8e0cef454@linux.ibm.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Mar 2025 08:26:37 +0800
X-Gm-Features: AQ5f1Jo52S7cxzaRqB7LqMDS1riq4aOvG2pPsy72SVgJFOPAkH9yyiP1kWyG5QY
Message-ID: <CACGkMEsrFoQ9QXYPAGDE6p7FOK=a+vAUv4FePZOkTngn1izCuw@mail.gmail.com>
Subject: Re: [PATCH v2] vdpa: Allow vDPA to work on big-endian machine
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: mst@redhat.com, eperezma@redhat.com, sgarzare@redhat.com, 
 mjrosato@linux.ibm.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.333,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Thu, Mar 13, 2025 at 11:14=E2=80=AFPM Konstantin Shkolnyy <kshk@linux.ib=
m.com> wrote:
>
> On 2/23/2025 19:57, Jason Wang wrote:
> > On Sat, Feb 22, 2025 at 3:08=E2=80=AFAM Konstantin Shkolnyy <kshk@linux=
.ibm.com> wrote:
> >>
> >> Add .set_vnet_le() function that always returns success, assuming that
> >> vDPA h/w always implements LE data format. Otherwise, QEMU disables vD=
PA and
> >> outputs the message:
> >> "backend does not support LE vnet headers; falling back on userspace v=
irtio"
> >>
> >> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
> >> ---
> >> Changes in V2: Add code comment.
> >>
> >
> > Acked-by: Jason Wang <jasowang@redhat.com>
>
> Is this patch all set to be eventually integrated, or more review is need=
ed?
>

Michael, do you want to queue this or can I do that?

Thanks


