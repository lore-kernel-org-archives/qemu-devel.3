Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19557C5321E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 06:14:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siSzz-0001sY-CB; Mon, 26 Aug 2024 02:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1siSzx-0001r6-NJ
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 02:14:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1siSzw-0005sl-2b
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 02:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724652877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6H0SPr8vVIFVRa7Rw7vVIhnIZlr+17GMQA+h1/POUwI=;
 b=C7lrAS7u4Iq0djahffDDW2qB21iiIchumq1s4YkofojnKwv9Lvumx5DPS+ES4wdDGV1wYN
 4EfOXFfxrzLKjT+1KS7/8Vi0hvrZtHhVRyjQ6pn8PflMjuPNWiOCAAcO+kRcccuzwxsxYj
 YZjNXhjN37VB3d8zYsT7LFX5RRSDElg=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-1xGU0oncPfqnneQZ17xhDw-1; Mon, 26 Aug 2024 02:14:35 -0400
X-MC-Unique: 1xGU0oncPfqnneQZ17xhDw-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2d3c9a5c673so3645010a91.1
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2024 23:14:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724652874; x=1725257674;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6H0SPr8vVIFVRa7Rw7vVIhnIZlr+17GMQA+h1/POUwI=;
 b=MQ8gAyWwEinao8obp33PtfDBI04GG6kxgiFS1z7uyS6Wikq2x2gm0JK0EeQHwP3C43
 G/fFtfR8NT03wsaLYU3DOXOx3ljLTaVbvFPfoudkfyCqedHGrDRV7ECAOVOlUPWY1JGF
 qTCooYxcTA4/3YLpy4Yp58u7LTOeKxWNSNOzaUTEXmqm+xjSTTT10TD4FS1hH9YKIUPM
 wLnhXruQHbW/YayPMb+MB5TceS4FqRMRZTgdDRk3Zh/at3ncdHyhpWj8QnBgTGaTOl6y
 5Lz2eElkgVzNw0NXr+GL/j3fyEbTEUCTnen88xhZIybQUOD1WIKECIlc38Bd3bZ3r3q9
 vBdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5OaYfYGSwyU330zXemaKUojKlSZPX/FWnU5OWennHdZsjw8YxsT0EUYedtxJg15iDWZICyXAmNZo/@nongnu.org
X-Gm-Message-State: AOJu0YyiWaHKIEm6LeJBh4sFSpz9ndegsTlztH1OmvmZ9UCkvCpDj14U
 izjf8KaoW0hv/STAyQZaD42dvOAdHIH3k3+4J+WOdtDgQzSeiIBpZpcEG/vGhsUEo9Z/nhGyT0D
 lNYN0B11My8XotLXIibL0i3XsrE8gc1ScYMURhFeBbloPFC1wNmxWKZ34ABs26OHVXUIgXuL9pp
 aWGWzU3iBqI7DIS5+gLrAyPPQdwEE=
X-Received: by 2002:a17:90a:3484:b0:2d3:cd5c:15bb with SMTP id
 98e67ed59e1d1-2d646c04128mr8396618a91.25.1724652874585; 
 Sun, 25 Aug 2024 23:14:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCtZb4YaSypXxczl5NQRddCEcMVvrOORBx5qFdBvBWlA99jGqiHYft2aaiT/Z2aCBBWhBPH3If2Tp6tsmeCMM=
X-Received: by 2002:a17:90a:3484:b0:2d3:cd5c:15bb with SMTP id
 98e67ed59e1d1-2d646c04128mr8396598a91.25.1724652874056; Sun, 25 Aug 2024
 23:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240820095112.61510-1-clement.mathieu--drif@eviden.com>
 <68598e12-f2d6-40ee-8da4-fa906f9fd0a7@linaro.org>
In-Reply-To: <68598e12-f2d6-40ee-8da4-fa906f9fd0a7@linaro.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 26 Aug 2024 14:14:22 +0800
Message-ID: <CACGkMEt=swrrM+Akk3Weh9xjV+mgHjsyA9UO65ZzMJUk=Gn6SA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add myself as a reviewer of VT-d
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Aug 20, 2024 at 6:36=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 20/8/24 11:51, CLEMENT MATHIEU--DRIF wrote:
> > Signed-off-by: Cl=C3=A9ment Mathieu--Drif <clement.mathieu--drif@eviden=
.com>
> > ---
> >   MAINTAINERS | 1 +
> >   1 file changed, 1 insertion(+)
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>
>


