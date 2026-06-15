Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C0F8CD98C5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 13:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ7HJ-0004pH-De; Mon, 15 Jun 2026 09:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wZ7HH-0004hg-PC
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 09:22:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wZ7HG-00055V-DT
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 09:22:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781529777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5HCUq7G6Zv1bfGrgHwsKLi6f2azWG7jYOkJTxh2yLVw=;
 b=JmSLKttot4ClU0da+1xQrA8OhTXxLHHFWFJFxFCIpZ1m/1sFfeFMYQPuqwmuKGyDvV7phy
 iYN8LkwRGo/gawaF4K3GwClfx81xDcEOrV4Wwwb0QW8SF134fHJMPM6uSNM6XOQbGWMAkw
 V0ah7vKJKp8CLYP33B18vrHY+hlw8oU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-711-zRTM64KsOqq8fu-la1F-Kg-1; Mon, 15 Jun 2026 09:22:56 -0400
X-MC-Unique: zRTM64KsOqq8fu-la1F-Kg-1
X-Mimecast-MFC-AGG-ID: zRTM64KsOqq8fu-la1F-Kg_1781529775
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-460153ce644so2424778f8f.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 06:22:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781529775; cv=none;
 d=google.com; s=arc-20240605;
 b=K0Lw4dxKtFvhqAchbjk/9HnLZY869xZwagZ8BzbLD1hFamArLHh3fB20aYkwImDS/G
 dTJO1hFr/lErsIXIhzb6xlBIt4bonimjvlGcIusJ9Ru48LMRk7m9ZzbJAeu+9XsY53E7
 JelUBMQ019NULqlrKut+gDU8EDPnyYIMotikD6cHSihATagwCR0tB2IMW/yrUUuHFHPz
 FJ3cehEYKco+mAWwJlBEm+iIsa4tuwvuLKlPzk2rtrckhr0nB9McuuRIgX60NBNG0i00
 S2+aPLvUMizpadH9uVFB0RcNZ+j36SQpEKWWKCs0iYdWd5wBLjproh/0tzYH+O9opRUP
 hUuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5HCUq7G6Zv1bfGrgHwsKLi6f2azWG7jYOkJTxh2yLVw=;
 fh=8aBEJY+feA7d7ThUvpzyIH9FOGeOtT6IdrliqPJEqPM=;
 b=fWYzUo391nmXTICQ7u0Al3d3evJzIy/OeMglmJaBZZq7J3saIYuvVZZTBwZ0GNjX5d
 WWJxe8cr+OpYIGj5vBsw05IpnI46Mv3bzSZ/HnTjJHK/N56gB82fATGkEvug/GCBmAyO
 dxxQ4BRGzFzx0wa5qNOsmiUiDvV+5TQ3clpXRvLsmPLB9q7rVrtX/KycYZUFpblRFJsV
 2qaTNdnJSxBP3HAihE51kBGpRj9lLkzfEYOP87JHA98IOejbtIKADX3b1scbeJ9V/dY9
 1ayIl7oxS7hw9iJuk95tP8EBIwWqx7JvR3XcPSnZY/P1IJKOz8/u7+J3BVPUhYWYsnao
 xkoQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781529775; x=1782134575; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5HCUq7G6Zv1bfGrgHwsKLi6f2azWG7jYOkJTxh2yLVw=;
 b=CknrlLRns0rRVjch5G5k5pWFxINjZK25TXexiJPKAXv2dD9Bry6uUVTabam/S6owER
 Ysbiueq0aWlnapHVz9rrqB+7wN2bkgUkSIUjjf9H/VDNNqs7qmU9Fr5zmLrH6x2Nf128
 RXZt+Yt4juAnJNRQ1+eVTBzGYVcTxW5IeiCEBmAky5zkmTF7HJlda1D9Q5G3MhV4Lbb2
 DHpDZwLgs98rCW3gt8Bl6QAUpj+6iKtxNO7wjuht6PAa3nn246u3X9dFHo75HJvNS3xk
 nLPs7x5m71T5m77Umx202w/HL1HzzSNCVnh3BSDdV6tZdxCyx6wocdmHeGZj31R3fPWI
 KdFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781529775; x=1782134575;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5HCUq7G6Zv1bfGrgHwsKLi6f2azWG7jYOkJTxh2yLVw=;
 b=UeqfzPzutGSN8Zi6zjUydHLbw2TLKwYdDB7hJe91wW8VQGoAMsE/CEofGfiCmOs3Jc
 VYxPf6QXTc3ietpYB1038hb39d0pOboYU7K0J/tbEF7vNptFdyHm6XsTi2jXAba7YxhQ
 OzpS015d+pQbBd35JaYBzLW4TAg8mne/4Ca/HyAj9Xm+/+3eOoizBGBQseWe6Rl6ThhX
 qsywz6hpQeZf+lSzFHCUSVKXAP3VBC+EJhtuugOxHz5iZNAF0yVlSikTWj9ajlHWyQ7e
 ebgILjXgjAOy8ImmMWksiYBLls8REcf7xZzMx0gvTr24nDrl+SVFgfrm9TTHVbtFCTNH
 8FFA==
X-Gm-Message-State: AOJu0YwH+GYj5zoLjlitaZTgj11g0OUCCQnFuW7bb7gTXP/RSnez7wu+
 AM6KHvH0goag4ugyv8kg+wlPukHagUvSlTSla9xjW3FrHJ/oUeG3QIXIdPI0DyerZ8mr/HqjaNe
 ru9iEZvjc/aKJPrf2gT9tacC+WpX/AclTzCds1rKPZxfBeIWUDEkoUu41Vk6Ps8bFqdeAoc0Gk9
 sispEwxHS0Dib2XvPol+Mcud2q3fyrP/bst8KA/5k=
X-Gm-Gg: Acq92OGFgTMA+PhFDVGLUL7tPSjvxdtjL8pgA+qHhRQWEdWGMb0dahRLDvfCvqIHmhk
 4o2Lf2d1em47gHpe8LfCWPw7M0cAoNzZZlWeuzToKpkeq+mdJ/w9rTCWmiPgivpm/k1UA+/UTUo
 CwxpPIBF2UgD1HUASKSL1qju6ZTCjPW85n25/MOzXcIBmZvJ0Rk9AqpTHnuaOGkyzI1BLV09JAH
 oY5ViAR+EYeFdMGwCPIkggTVzGOAjs3AOa1G8wCJ5qEtBxW7T4AvC1zYZMOtUiPRPn1ZuZ5K0Ek
 rgBfKzA=
X-Received: by 2002:a05:6000:2601:b0:45e:fb69:f02b with SMTP id
 ffacd0b85a97d-4606da5a6edmr20458660f8f.1.1781529775144; 
 Mon, 15 Jun 2026 06:22:55 -0700 (PDT)
X-Received: by 2002:a05:6000:2601:b0:45e:fb69:f02b with SMTP id
 ffacd0b85a97d-4606da5a6edmr20458536f8f.1.1781529774118; Mon, 15 Jun 2026
 06:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260525150503.393743-1-pbonzini@redhat.com>
 <20260525150503.393743-6-pbonzini@redhat.com>
 <87qzm8oule.fsf@pond.sub.org>
In-Reply-To: <87qzm8oule.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 15 Jun 2026 15:22:42 +0200
X-Gm-Features: AVVi8CcdxaidWppamZsyPDT0ucQ-50j1-mzDnOOhsVw9DEewu-2je6xQWd3rccU
Message-ID: <CABgObfaEm0GW5cXyDW5++bwb0N05cFUvGVaq8zExyrLqz9ixHQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] json-streamer: remove token queue
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jun 15, 2026 at 2:30=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Lexical errors change from
>
>     JSON parse error, stray '@'
>
> to
>
>     JSON parse error, JSON parse error, stray '@'

Oops...

Paolo


