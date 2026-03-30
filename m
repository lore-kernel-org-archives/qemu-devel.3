Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34EB1061B1A
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 18:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7HpU-0002Dk-Qd; Mon, 30 Mar 2026 14:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1w7HpK-0002CE-Oz
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 14:59:07 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1w7HpJ-000470-57
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 14:59:06 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b79f8f7ea43so940532266b.2
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 11:59:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774897143; cv=none;
 d=google.com; s=arc-20240605;
 b=fgq1IFoqXvb+4rIgzaAh+mI5Er0TY+pDLhdeP5E/pIzMCAjV4Imm9kqa5HHsskk6LX
 smOr4opjZQciYyRPu1WrE57KbTBXFBHW1OBSPm+3VMUaS6Lv++CcbQghpJ5jAxblX4k4
 HUeWZjDaeE5XfjldhVpa5wK+TilkbNCARSCpr8Y63se8cLgRDwyCF4UC96fNj9NnT8L4
 Tjo/YQ6ABnCGVwvnL/wuxyMOyIayK7JCBuo1OCyVr8dq9i2/A9Vx4VQOQ12zbD20kck2
 x4evvMW3ZvbhE+gp1xRLL1vZmRksZ8Em1WXDUfbwRcM51r7DabfjNpCdc809eZzV2eFC
 YLfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=k4rAoAoPNN+VzZnBKbPKnqdI75IN2AVUh/oLxv4NemQ=;
 fh=xopoZxAxfwA5WIpxTaonJ6ni507NJjSH9E3qLXTQufM=;
 b=kduBMNhT7hyp6872+WFG4dbx76cD+6vCck8ASlwRuZ/nBd4l7xCh+syB/4QTU63GP4
 GjcW6642xhlHExK05ksItNYO834FCYUn/eZanLh5dwHGqERhW3HS11dsaSNK+eVo+rGi
 sKRCIoU2gb2ZhJhatf25n8naSC7auXfhtnUZap0LebwLd5sGCSjCTnXifkKZQzxw+CSV
 XukXZv4BicFRBeMplQPq27bWkAUur6OiWcKWot2vlmeU1AEMw3htZ08MUzMX72bwcJDK
 zOc73BDJxqtfRJKI1tOwSD1y8nISyDyidLdcgV52z4a4m8mfael4cv8Ow9Fig9IodUtH
 WfGw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774897143; x=1775501943; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k4rAoAoPNN+VzZnBKbPKnqdI75IN2AVUh/oLxv4NemQ=;
 b=ZnPVG9rdQLWKdgjrbnkep90iUCCEm33edeYiIOv6eNJCA/GJ7OFVmBSMNLoBt6ZrNF
 zbWIDjO6BWVwCw78Y7UPl+gn7P5jxNGu6vKX+CA3iD4Ap6PekPo9R5GRmJXZQ9sfLs5F
 YAwsy3hQzgos+ByNVlVjIska/WtIvNFNJlTGM9rq+xVOHnOpRyTfxOl47LV3P9OJBO3z
 265It7zNXiuw+v5taLdgnN2XMJb/54JX0+KCeUMqclefZAWu0/grKmPc31e7QW0vu0uT
 fl9VVyu9GRHl/ILRgPCm25cNiOMFLjjR89UExSZjILmOVG6+ezdrxO5F77DnNYQ83dSv
 /Vrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774897143; x=1775501943;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k4rAoAoPNN+VzZnBKbPKnqdI75IN2AVUh/oLxv4NemQ=;
 b=NPDC+dKr8+TrmR8m+dro9qNCjKj0icdCPSsb+CZeN13YLKst3veGkp8VqUDVVG67xY
 I0KlY+78OhRzMYPHy6OyqFP7LS/4tZFgGbgZz0ai/aeFzznNnqvxqLDCe+Fk7jZvcZEp
 CAr8vi/IX36aK2qYs705bzLfFfXNU+DuNOIU/23+eXsQwx2j9807MnHy6n0LBDlO6YsT
 A2pAO05LGO4Hqts7EFrfTmlQwSmnz6Ab24p/+Sji1fvaWU2JO2PgtIxW5qdPMahKESib
 tr4ZsxbYjB/WTWUVcBSbH18ZqX0Nrpy/AArW3kecp0/W3stsZPeSUceGBQB8StwkyZKQ
 xwNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAY9mp6OAkfWg9IRtLH65gXjzd0MEoKVoiVNAbpjhTFmdaf+/68q5xhj28MQO91ft7bP9iQ0TIqrWr@nongnu.org
X-Gm-Message-State: AOJu0YySHthE2iAkbLxxC4OIfdyKM15qLOil64Vd6G2YfilgDhz54YhE
 EzcXOo345A5AbgAKXeDhPUI26+Rz9+SQMGn9vRPhNwPjq057A+g4jeamqtBwJmIOTf5BWxJuE7Q
 VEvgMynwak5eCHvTe9w1xhacYNf63+ok=
X-Gm-Gg: ATEYQzyQ5Ndr8bh9U6f82VNvPISCp+cxpet429DKC+XtiMBI4RNKk1qGDKsX6fSLCB2
 FmdwMRUeMKC11Hc9N5yzQVvYADdAwR6lUoW48CiTXKpe1yjr6lj6L/3LqbbHTeh2l++FVFsjDG3
 h4GuW4tNydY3kkkgrutZukYkxVZCK4ljQYBcJMEMViTADHN4HYJQG8MLczfG9ZaUYhKupQLxd8Q
 jylzFypspTXN1Zf6xRIlX4IggLzNgRr+TsIvgsmyR5aDSc2l/wLGEr0OLNz4gbx5As39220Vp/B
 8Fsy8pZS
X-Received: by 2002:a17:907:94c2:b0:b95:6687:4d15 with SMTP id
 a640c23a62f3a-b9b50937e83mr873615566b.42.1774897143252; Mon, 30 Mar 2026
 11:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260305142459.52559-5-zhangckid@gmail.com>
 <20260309081502.GC39949@fedora>
 <CAK3tnv+HfV9JCR7whLRDcXpfp6ZAdbw1AhWzT1RSdTVevtyvBg@mail.gmail.com>
 <20260312052422.GA116604@fedora> <87bjgtxv9b.fsf@pond.sub.org>
 <CAK3tnvJc2U+c=sx=RASKHCAjcTQMx9dg0iOpe5eEui9U0-Ft_g@mail.gmail.com>
 <87jyv9fyn5.fsf@pond.sub.org>
 <CAJSP0QWnRRRATvgRtWss_hw4ygqB_bHgBuWQd3mqUcbb1q48KA@mail.gmail.com>
 <CAK3tnv+9pdVG_FzEYbux3JDHv8T1ywbwLBvA6j4xJ=ATdNtxAQ@mail.gmail.com>
 <875x6dzo50.fsf@pond.sub.org> <20260330133155.GA154632@fedora>
 <CAK3tnvJJKUgmJQ0oV4kOX7Lppo4=90EHUUzyGiTOMZjX44fevQ@mail.gmail.com>
 <CAJSP0QXTEHphbgR_xxqBSvcvqNo=aGe6S1M7wksC=3BHEgKRAA@mail.gmail.com>
In-Reply-To: <CAJSP0QXTEHphbgR_xxqBSvcvqNo=aGe6S1M7wksC=3BHEgKRAA@mail.gmail.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Tue, 31 Mar 2026 02:58:26 +0800
X-Gm-Features: AQROBzBniL2odKJZf73za_PjubpCIhtAYA7MACyOkOT21wkTHjEdPS_sbFZdvdw
Message-ID: <CAK3tnvLJWkgqnsA0D3iUdgptfE-GfxdtHGDcnmMQf1xu1Xy8DA@mail.gmail.com>
Subject: Re: [PATCH V5 04/13] blockdev: Update tracking iothread users with
 holder name
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Czenczek <hreitz@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, 
 "Dr . David Alan Gilbert" <dave@treblig.org>, Eric Blake <eblake@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Mar 31, 2026 at 1:53=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.com=
> wrote:
>
> Hi Chen,
> It seems to be an email delivery issue. You can check the mailing list
> archives if you are worried about missing emails:
> https://lore.kernel.org/qemu-devel/20260305142459.52559-1-zhangckid@gmail=
.com/T/#t
>

OK, but the lore can't catch the mail too....

2026-03-30  3:13                 ` Zhang Chen
     [not found]                   ` <875x6dzo50.fsf@pond.sub.org>
2026-03-30 13:31                     ` Stefan Hajnoczi

And like this:
https://mail.gnu.org/archive/html/qemu-devel/2026-03/msg08030.html

That's irrelevant to what we're discussing, I'm just curious, thank you.

Thanks
Chen

> Markus' reply arrived in my @redhat.com inbox but seems not to have
> reached the mailing list yet. It could be due to slow mailing list
> servers or temporary email delivery problems.
>
> Stefan

