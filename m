Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB63EE88D9D
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2026 14:21:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w91sP-00053y-3S; Sat, 04 Apr 2026 10:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w91sL-00050P-D9
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 10:21:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w91sJ-00037i-5w
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 10:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775312482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HCzjenucMM0Vl8WKGvlq5jnMyvckcTLrQ8HdZBuKcvE=;
 b=EDy5Hg5E5GgQOxpr4zyKKg3bVx4lssTyXjtHWexlfD42Uf5vWRkOy3TgufQIxsObIcQHi8
 5NEuzyPyHhx6lnfSS5aAiqazZiOuCuoa4thEA0NuyQeV+2R5zfBblYxd6mb4j9G1pLlDyg
 Rdj8mmVD8btkbmWzIF2HZONFdMAg+bo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-60OYRrinMJ2jByH-WsnqPQ-1; Sat, 04 Apr 2026 10:21:20 -0400
X-MC-Unique: 60OYRrinMJ2jByH-WsnqPQ-1
X-Mimecast-MFC-AGG-ID: 60OYRrinMJ2jByH-WsnqPQ_1775312479
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43b96365ea8so3376990f8f.2
 for <qemu-devel@nongnu.org>; Sat, 04 Apr 2026 07:21:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775312479; cv=none;
 d=google.com; s=arc-20240605;
 b=gvctwypWInwT3c7pa6mYhLV9xURExQo0QLZ0W7SsuOF5Ztpt+H5wgnjHTktUM6x5dy
 5lbqbBqKChOhtStupA/pvRs3hh2Dl9vBkkmU5GKUZ2zQcWqGfXMYTrt+CsrHWYIlIdXK
 BjkKya7pcPh4DoJlVhB4Ovs6QQPoi3i5OuLYEiQy947HhOEhJFSUAqtgG2oouAcr+f12
 BkRSOwHDV/lc/LZuM9EFdqx1YqphDsUYFBSHCzUE5P2Hzi+8qZiggxW9rW8N4R6+ZVJU
 t3cTud0m7YoNW1nt15rzL5zHoAOw8QJbB0Isu40RixlrK9uUImblxaLxtHTFve+lG/VS
 lUmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HCzjenucMM0Vl8WKGvlq5jnMyvckcTLrQ8HdZBuKcvE=;
 fh=qxVSkX/SOxgioN8xRHGRSQe1t9On7ZcGHfjHBVgXh/w=;
 b=UH8n000AhkKv+gXW2tucRMmY5VvPGBsIL3kYsIRnKZj0gtyoZigMZyscRhwLc9w5Zt
 iO3pbeVQWhoGrk0ORihlbXW56SRQdSU94IgApMGfdX1OrAhor26uWXfUXYy+uJJtzMR1
 OtHIPGfaedBOs30h+2r0WSo9i1eFxt4rZ/8CyMi+j5v4P4/SBQzKH3Z//aDFAdP9z4+M
 Ek1el8tkEBrx/W1HpuRptCPchywBWcm2u+K7Q834FRIpzfZBS8uVoO4pKZj2hrddLvO6
 wi+JrXF7Ddnvf4a0hsPUg5rQlCuxAYWI6IsZpk1w7KwyXSdR//V0eINgQxB6cvOVaC1r
 WYzg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775312479; x=1775917279; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HCzjenucMM0Vl8WKGvlq5jnMyvckcTLrQ8HdZBuKcvE=;
 b=DUb0nOdkS6se2SN7VxuFKFafBbRouL1tppDojz3OaC3ZZ0p7PnGjuc/UoPgM7JtVn7
 hXPVmcUnF3RJaxu4/M+QfgkC/DAwSzRpUN9NjN8Yy/aaYnFna7EUhrX5DAAFY6Rcse+C
 eMyVINFkwZz+4m1pcVL7SpKWk3vIe2OYfsL4TbRDhrMAYaHXm4Iyago/vBRRhIeZQX9y
 9dBntB8zBFXQc23nZXZrsoEkfgGjVMYtGV60GFsG1j6mH7DaqwrSfTrXyxSyiLDBC4hC
 5PZofNxA4QMCzCYUtvRz+pF7cCgVNz5gM8iTlbWi9Wqc1TfqpI5Jqk9LoAIBWuoDa1ZS
 6JjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775312479; x=1775917279;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HCzjenucMM0Vl8WKGvlq5jnMyvckcTLrQ8HdZBuKcvE=;
 b=LYJI+vJUKuquppuEEyuA/QAN0khZ6Kky23iDvaXFv/K5zuFqcu+FfmG0xZKtFyCC5d
 RC5HAJzROIrup0B1kr/TYAniHZpTWUiNJFsBhqskAwH82oHkGYNMhF5ZNWyHcF9FiIQP
 ECfBIyi15YLS7WWDzkNNOxA0HinjIbRRpsR+CpQtrp5JzsWM2gqPZtzn5w+r9dCOwsjm
 4PicdTg3qf5dbGJq6hsQBUGl8HhQWnFG0TtUVTg/DYASxkCly286GVg9nnB0B29MHnkj
 g0ed8yfWe866xxq7AuH/eIJ2hDtPrc4xeZSK1kPcPYdypA5DzChVLORhN89ZdIyDCwAK
 KBfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUT5dY2gCeD1CMcSRKz+1bB3q9REFVAJptAyeCilqDNwSNlZdW1BTRQZBQPuTdCGhObeqF0YERM7w5@nongnu.org
X-Gm-Message-State: AOJu0Yy7GlcOSwb3PXNHmMRZP6gIpW6euKBkaW2G5OxvfzTySL9ihoXy
 uie+zjHgvxzyZ1tp9ioycBzJ7jlg1S0hHd6OFgzu/ipcgUrhDxMHCR4wkUugwaWAJe2aj6mt+Iw
 W7t8ZBzFAbcLcmRVeGEQt0YNt77Tdx3gTg9CSFM9aS+/7Sd/ylxsc/HaCYNlDK2lEgJLwn7KrdZ
 N1s8tAJO2MKTSS7YmPIk7zBVJp/JAACek=
X-Gm-Gg: AeBDiet4wnHIdVLxgTbmK9jvMaHH34AS3+KK/gzHRFL4f3b2tShZN0AMJFlAz180WDC
 cgYmUpto2cdzd86pYAmwTvXWA9+vtf2C42nQ8kbIXbGk3mn8J2l4NQebNN3mP0lHH2czxyxw+A6
 GVwCvtniBrIP1V/91O8/uCRG2Tic1h6g5ryMSmJrs+wttGQEf5+M228c8n62668iKmrN4T+rx4v
 XW1eZTaIXo4lb5k+VrizyJKmSZcj2pwH9ZdomDQZS1cSnFtHTSnsNKgAyXjS18E/1MGqEO7N6yq
 ZqJL
X-Received: by 2002:a05:6000:2512:b0:43c:fd18:a30b with SMTP id
 ffacd0b85a97d-43d292f4ffamr9365914f8f.42.1775312478960; 
 Sat, 04 Apr 2026 07:21:18 -0700 (PDT)
X-Received: by 2002:a05:6000:2512:b0:43c:fd18:a30b with SMTP id
 ffacd0b85a97d-43d292f4ffamr9365896f8f.42.1775312478542; Sat, 04 Apr 2026
 07:21:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260403104327.1163942-1-mjt@tls.msk.ru>
 <20260403104327.1163942-7-mjt@tls.msk.ru>
 <eb9b80b4-78a9-4a0e-be63-aecfa8b426c5@linaro.org>
 <64e92c21-86b1-4828-b9b1-a7372986288e@redhat.com>
 <0b5eb7b7-7b99-4170-9553-fa92c187b9a3@tls.msk.ru>
 <CABgObfYPjpQxHXOf-fQ6ESGP3+G8giEUrn2kTC+DNh5gFz1dbQ@mail.gmail.com>
 <5ab94e34-1f76-4fe9-8942-2b24823d7eba@gmx.de>
In-Reply-To: <5ab94e34-1f76-4fe9-8942-2b24823d7eba@gmx.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 4 Apr 2026 16:21:06 +0200
X-Gm-Features: AQROBzDMsBrToUG6oJFZ8mLV99DQBqV2RMUrvMgD1aD5gRtCI0VXrokU-gFyk9I
Message-ID: <CABgObfYrPb-rrr8V0FD1w=_Q0dgTwHfy9bvHDMZvkEx2pUyEBg@mail.gmail.com>
Subject: Re: [PATCH for-11.0 6/6] RFC: Allow building qemu tools on 32-bit
 hosts
To: Helge Deller <deller@gmx.de>
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000a62e9e064ea32586"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

--000000000000a62e9e064ea32586
Content-Type: text/plain; charset="UTF-8"

Il sab 4 apr 2026, 13:50 Helge Deller <deller@gmx.de> ha scritto:

> > They do, and in fact Stat64 was removed as part of dropping 32-bit
> support.
>
> Please note that debian (and probably other distributions still supporting
> 32-bit)
> enabled 64-bit file offsets, 64-bit time stamps and many other 64-bit
> flags by default,
> so there are actually no 32-bit limits/issues left on all 32-bit platforms
> beside i386/i686.


It's not about limits, the problem is testing. Even if we don't provide
official support we're still on the hook for fixing stuff, and for data
losses caused by bugs. The maintenance can cost was the makn issue for TCG
backends (but on the other hand something like x32, if it was still a
thing, could be supported because the word length is 64 bits); but for the
tools preventing from being able to build and run and lose data on 32-bit
hosts is exactly the point.

(By the way, for qemu-ga in 11.1 we'll probably support building it
directly with meson+ninja, i.e. without passing through configure. This
should be the main supported way to build qemu-ga only. Konstantin is doing
it for MSVC support but we can make it the accepted way to build also on
32-bit hosts).

Paolo


> > Tools share all the storage code with system emulation, which is way
> > more complex than qga and would be mostly untested for 32-bit hosts.
>
> I think nobody expects that the qemu team should officially test and
> support 32-bit hosts. Limiting official support to 64-bit is OK.
>
> The ask is simply to not actively *prevent* from being able to build and
> run
> on 32-bit hosts (or other unsupported architectures like m68k, powerpc,
> alpha, ...).
>
> Helge
>
>

--000000000000a62e9e064ea32586
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il sab 4 apr 2026, 13:50 Helge D=
eller &lt;<a href=3D"mailto:deller@gmx.de">deller@gmx.de</a>&gt; ha scritto=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&gt; They do, =
and in fact Stat64 was removed as part of dropping 32-bit support.<br>
<br>
Please note that debian (and probably other distributions still supporting =
32-bit)<br>
enabled 64-bit file offsets, 64-bit time stamps and many other 64-bit flags=
 by default,<br>
so there are actually no 32-bit limits/issues left on all 32-bit platforms<=
br>
beside i386/i686.</blockquote></div></div><div dir=3D"auto"><br></div><div =
dir=3D"auto">It&#39;s not about limits, the problem is testing. Even if we =
don&#39;t provide official support we&#39;re still on the hook for fixing s=
tuff, and for data losses caused by bugs. The maintenance can cost was the =
makn issue for TCG backends (but on the other hand something like x32, if i=
t was still a thing, could be supported because the word length is 64 bits)=
; but for the tools preventing from being able to build and run and lose da=
ta on 32-bit hosts is exactly the point.</div><div dir=3D"auto"><br></div><=
div dir=3D"auto">(By the way, for qemu-ga in 11.1 we&#39;ll probably suppor=
t building it directly with meson+ninja, i.e. without passing through confi=
gure. This should be the main supported way to build qemu-ga only. Konstant=
in is doing it for MSVC support but we can make it the accepted way to buil=
d also on 32-bit hosts).</div><div dir=3D"auto"><br></div><div dir=3D"auto"=
>Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"></div><div dir=3D=
"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
&gt; Tools share all the storage code with system emulation, which is way<b=
r>
&gt; more complex than qga and would be mostly untested for 32-bit hosts.<b=
r>
<br>
I think nobody expects that the qemu team should officially test and<br>
support 32-bit hosts. Limiting official support to 64-bit is OK.<br>
<br>
The ask is simply to not actively *prevent* from being able to build and ru=
n<br>
on 32-bit hosts (or other unsupported architectures like m68k, powerpc, alp=
ha, ...).<br>
<br>
Helge<br>
<br>
</blockquote></div></div></div>

--000000000000a62e9e064ea32586--


