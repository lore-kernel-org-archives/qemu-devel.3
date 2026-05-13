Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE9DCD37B6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 08:41:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN58Z-0002Ry-PV; Wed, 13 May 2026 04:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1wN58S-0002PN-DZ
 for qemu-devel@nongnu.org; Wed, 13 May 2026 04:40:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1wN58Q-0000pY-7j
 for qemu-devel@nongnu.org; Wed, 13 May 2026 04:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778661603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wQsOYIwwQO5kUH3BI7RrEG5LiiLZSm4wpF7PK55dtgs=;
 b=JnvPAf87Bx/9mnmGIqLBcubgil9RMI2UcC/92T2HW6XMXDa2xtEH4BhDcKKX7YmHIrMhCl
 cBVnNoogSU62pvKtlhuGkhM4K8Xtp5bLgZmYyBtcRAMSwR3yNsKvj9vPsqgMQeuG8mBs7Z
 FLKF+YpS3C1bAIPPP+fIr3T8T02dSX0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-11ctcp3qNiqVAkZHr4dsPg-1; Wed, 13 May 2026 04:38:34 -0400
X-MC-Unique: 11ctcp3qNiqVAkZHr4dsPg-1
X-Mimecast-MFC-AGG-ID: 11ctcp3qNiqVAkZHr4dsPg_1778661513
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-365e70c39d0so8310792a91.0
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 01:38:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778661513; cv=none;
 d=google.com; s=arc-20240605;
 b=KArFLYcjuMUqgB43DVZ/g0p92X1c7TRFolhAaBqqdU75twtIFxptuXBhJ0NZuI2M4N
 qq2s5hQA+w1GRo/UAjgJ35sgKiG99wk/A67Uh+YiGfr5WADC1pXAiSLWK+PvHQaI+7IS
 ww0m458cBwwCTiREnmNip/9AwibJZvJhn+MOrIhaCuC9iugQ4AI1EBp/ufnXFoqOViZy
 gpxaAYVNinRG+j+O6LB2LEHJjJ5pDqG0ZASN5rtThN+28ZnKQNVrTuBDX7U7iJ1OE3VA
 7NRp5QyEBxcKvV2aNUPHnN35vMx7yspqt1MQsbiaKwd/sPpnAJZ896ajJLp4dV8NLZXt
 fV8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wQsOYIwwQO5kUH3BI7RrEG5LiiLZSm4wpF7PK55dtgs=;
 fh=jCYO653gQoDtsHy6wxlhoTgd7189PwsdWSDcxnyBY0o=;
 b=iIpJ/agrIpvuiH8disWKAFM5jr8a63q1uHvaS5mZIsTv2l8kDHMUOM/bgvWklAY3Cm
 k7PmNwa5cjs5vpokbF3IyQ+ymzi5jlUSp1kiVS710AW/vSa/FyPZNEdUK7R84ySxf/f/
 hrK7skYYm2nsf9+rssQR7uAFC8UYTsj6tPynMGNVvwD1d0Udzqct03qOTrO6KPHjUsQN
 vstHodCjYIr1OznfhO1Z0jT86L29B38ZbrM5LXnYReve+cd7OD8gZ4CBbK4jN7nSovjA
 37YYocOygeDjqP0IFImlnjyp42aLGW1pkQGK5QyZxEACsINrnF4XAHr8VWOfiwYuw1H0
 izoA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778661513; x=1779266313; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wQsOYIwwQO5kUH3BI7RrEG5LiiLZSm4wpF7PK55dtgs=;
 b=jvMXwPDFiFGlkHmDGZXyatjIUJDXxmG62kw73ap1b+jDlBWsx7f0YYRSj06dauGoWc
 WSijHNlZAkFRa/AhD3FEJ6m7oFLnWYUzw/oGAg3PDoq0V5uLzciyH9ZFRYtOApzu1sb4
 r7rslHL6S0uHYNYyavYpkoMMSNgcjgJqFeKezaKiJV7N7TtHddZPuCq8hjEJVrDM2QKV
 zPZ7LZzwFuYHUbGNDVJ8Grw/cfkysIkDcISphkeYGlln5SO0smLfczxO4k+gGPv2SEUq
 5UWloFUmp41hiafxRfSbd3kzAnxJ20Om2VZVKE+N3XmEyUxlAamjNVMSXcCXtN9ifbUH
 /O4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778661513; x=1779266313;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wQsOYIwwQO5kUH3BI7RrEG5LiiLZSm4wpF7PK55dtgs=;
 b=UcKYPtYpqY/KW8szAwVyWRE7lksQwKlTNAPTv8BWr/7PzIESyXSw0ZF7uxb+PZnqxs
 psmePX/G1178CZ7gj+MOyOxfNDHaVHP3lrUb/j5fvm3Odailxi1+iAHXrltM7GHW9dCX
 gQkubWysrJYy/IkxMLGQxYCjnpCw1m0Zgv32N0B2E6aUhm+gSogNZT/tSwaYJeOSNhx8
 8AzV0L/HZTu9dufx4aVFWwvEsi5wt0qUISQE/csj2mA5dn/f9YAlc3Jfg6JQtpNe3Pc2
 DEmEgiEQ9sl3lwC5IxgNlrW6HohNm1ewwif5wIX7pNChsGNCKv5G1Ev/IonUju9AqYNx
 Im9A==
X-Forwarded-Encrypted: i=1;
 AFNElJ++d0DP/7fhkXhYgx8iH7hYlnIlZWdn4ylSxCKv3DoyGeY46iEmF8YDDfU9ebq3RDL5H7B00SznUurE@nongnu.org
X-Gm-Message-State: AOJu0YwO3Lr2/9CYdQ7lNcmIgM2paOlGWnpVu2lcixK77J2Rq77xG1Hs
 nEWmINmaPKBZsFgVX5ntALGsZ9mC/ALz2C+hGQ4v24XIAIYxJHhL41OJYGB4XqTUuEflXRZWeZO
 Y9iAk12dttqEYF2g/FgR8xqzSHPsLo9azOqh7IwpW1NtkytkpprMQBqf1cYDY1R8duhF9pFHkBP
 DRsxogkLdM2vTQ/D41Ig8aRJD3ZmqulhA=
X-Gm-Gg: Acq92OF0mQoJJ3byTNPTBV4N4zYOXDM0F66UDe1sJ0GD/ROVlosHPvPJIlMlsi2tmuC
 7+qdtHHzd0aUjKbWveB01WRggAxZvoHeVgQixNxwFjuPGPjqiNUWBxbp3J25gR2nxyYjSX46f46
 f417N7oEnRwfQyyi6d6AGyrsRbt54yTW6iA9GOPHPurBuDrzsZ08BjjaTYGKSnC04tFI4LawBis
 wId9dE=
X-Received: by 2002:a05:6a20:430a:b0:3a3:21db:8ece with SMTP id
 adf61e73a8af0-3afb2c5b04fmr2124141637.54.1778661512969; 
 Wed, 13 May 2026 01:38:32 -0700 (PDT)
X-Received: by 2002:a05:6a20:430a:b0:3a3:21db:8ece with SMTP id
 adf61e73a8af0-3afb2c5b04fmr2124079637.54.1778661512450; Wed, 13 May 2026
 01:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <87y0hwbvbp.fsf@pond.sub.org>
 <253ecaac-ac2e-43a8-97e8-9251f114df3f@linaro.org>
In-Reply-To: <253ecaac-ac2e-43a8-97e8-9251f114df3f@linaro.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 13 May 2026 16:38:19 +0800
X-Gm-Features: AVHnY4ImxURX7goCfVnmf-s1jsEyFNkfWnNJ4HV--1kNVErYP2S_ltB-ZlPggEw
Message-ID: <CACGkMEsvtHiyNviz+vKL3SPZSU7xjWEK75y8js_bf+w6-WKdPA@mail.gmail.com>
Subject: Re: MAINTAINERS entries that aren't S: Orphan but maybe should be
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 qemu-ppc@nongnu.org, qemu-block@nongnu.org, integration@gluster.org, 
 Zhao Liu <zhao1.liu@intel.com>, Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Milan Zamazal <mzamazal@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Mark Kanda <mark.kanda@oracle.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 Glenn Miles <milesg@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>, 
 Fabiano Rosas <farosas@suse.de>, Ben Chaney <bchaney@akamai.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, May 13, 2026 at 3:11=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 6/5/26 14:01, Markus Armbruster wrote:
> > I'm cc'ing reviewers and lists mentioned below, and frequent
> > contributors to MAINTAINERS.
> >
> > There are a number of MAINTAINERS entries with S: other than "Orphan"
> > without M:
>
> ...
>
> > Unless somebody steps up to server as M: or at least R:, we should
> > downgrade to S: Orphan.  Volunteers?
>
> 'Network device backends' (net/), 'eBPF' (ebpf/) and 'Network devices'
> (hw/net/) patches are left unattented on the list since 6 weeks, all
> maintained by Jason (first 2 listed as 'Maintained', last one as 'Odd
> Fixes'). These sections don't have co-maintainers. Shoud we be worried?

It should not be. I will wrap things up soon and will continue the
role as maintainer.

Apologies for the late reply.

Thanks

>


