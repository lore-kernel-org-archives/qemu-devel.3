Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65545CD5BD1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 08:19:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSVxB-000896-6w; Thu, 28 May 2026 04:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wSVxA-00087f-8t
 for qemu-devel@nongnu.org; Thu, 28 May 2026 04:18:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wSVx8-0004sW-6k
 for qemu-devel@nongnu.org; Thu, 28 May 2026 04:18:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779956333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Td0WQj49h+BXEIi/ReFE3ky7vmQbqD0m3BLndkWvo5k=;
 b=NOGPN0TU56jbX6/B4e0BwDsSRs10Hr4zW0FbmLnn7CTWXiI/YPOOJ+FgHUwEKjW13mSyMv
 pYcWQo82/3tBTVRpLJ9bk4Q/27xWp3Uh6a8iOvSxiqXTjTYdzs7IA9aWRXFImzv27h0Fpi
 wV5oKQzS8aCsloHODFFeD38H82w8DgQ=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-zqrLAXS2Mp6cV5d7kYRXoA-1; Thu, 28 May 2026 04:18:51 -0400
X-MC-Unique: zqrLAXS2Mp6cV5d7kYRXoA-1
X-Mimecast-MFC-AGG-ID: zqrLAXS2Mp6cV5d7kYRXoA_1779956330
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c829366cf25so16212243a12.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 01:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779956330; x=1780561130; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Td0WQj49h+BXEIi/ReFE3ky7vmQbqD0m3BLndkWvo5k=;
 b=ZeoYpvQXHDPJqyV76FaSfjxtS/9cajKdp0dHrslSA6IENDjbYz/sh4OjZ+yEVG0g23
 7yDLdUEpkhdA1wXWUwAc6BA8CdOn0zcE7qM7ukPFPpH8rZBD8VYHQsGjQyE3D+WGPltN
 VtLYtOAC+kppI/QSveEREUSYLew/j7wsuTW56ur8eodkEjXvpUg89plJGq0Z0u0LdF3e
 eMNE5mWpbaFY2V2u7qlOcAgedCG3SkeYWNq8fTjQi9uq1X6Rhcst3HV/Ho0XYd+tWTNS
 PHzVv2PIrvx5XZFw7SyYemzW2Kxz1MDaMGbYC6m0tU3e3spBZBZZn4WGFtNZD2ALV3cl
 kJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779956330; x=1780561130;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Td0WQj49h+BXEIi/ReFE3ky7vmQbqD0m3BLndkWvo5k=;
 b=axUlc4GInTQsUrAZusKZG1RHG1fMiN7ZyD45rXzYC6wd5nabkB0Yz3Z5+lgTlBunzW
 4DY4YFWrr2nnfLpi2TNeQHR6Jd44ji2+dkX0bJNfe9OX30RKvxveicsnJhHtydtWvAnH
 Ik7mog9na4FEINorwu4fDR2yx5iTg5FHMIvaKHssSFL9kMbpGVnhmXwx5DXPg8qF/tiv
 il0WWKAJDKVJPDmTEx3Z8dk697OCN8pBc0sQ0llkoa9uEHHrm4+3M8kSM+0af6EL5iKB
 J8rIVlnmyIqPyDsn3kXPCV9C9x3s5zc09tGnvk2NmO7qz5Ppe48cWU1rqKSKUocEdKqj
 DkgA==
X-Gm-Message-State: AOJu0YydUJxdsUNdI8uQejc3lxR+iN1BwnDMwRyojz0s9hWx9i/VIZo0
 TxH9Io42dizHE+KGbyKY1dgVZ82OaOLcdVRdQU7waUvRSblfHztTr4Nx2mO7R4YaZ7RJYw+TIaE
 V5u4XH4ryz+0zhqWEqPt303N9sN+NKB3PoOOnEhiXjCpY9WGpMVslkgvU
X-Gm-Gg: Acq92OGN/1d1pDVvoAtSQgl5VV1Jn8/ujQ7dZvx3p/6NFO3NYRFArOb/31ZaNcnBkk2
 R0wEQncQPRbZ+S2iXwt4RIB6sstJxtrRTFE+WVnTFRg14rYD82MKtqmJWb96u7GYr8beed4Fmkh
 cWqC25ELCJWPHeSmLO8atIFkPBiLNlwO/MiEICc+yl5v+80UbXgy5bI1GWTm3vjEEsffEUfQVYu
 gGAbfsQDAkSRKVwGaACP1RfCX1hGvQUX4GC2xjEVEO88eBvRqt+Pq3R3h7iUvMIiBfQXmNrkmPp
 RHzuu4CeBCtsdqM19cO9M4BufLWDk/1MhiHLNASdN4LqrdPSD/pG7b/2crdZQZMORIDa8vxomQO
 jPU0Js96DExIke5dUISr6
X-Received: by 2002:a05:6a00:1822:b0:835:4776:7d69 with SMTP id
 d2e1a72fcca58-8415f38fd64mr26329358b3a.41.1779956329381; 
 Thu, 28 May 2026 01:18:49 -0700 (PDT)
X-Received: by 2002:a05:6a00:1822:b0:835:4776:7d69 with SMTP id
 d2e1a72fcca58-8415f38fd64mr26329245b3a.41.1779956327877; 
 Thu, 28 May 2026 01:18:47 -0700 (PDT)
Received: from redhat.com ([5.28.174.83]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-841f3cbce53sm1132916b3a.3.2026.05.28.01.18.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 01:18:47 -0700 (PDT)
Date: Thu, 28 May 2026 04:18:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] docs/devel: relax policy on AI-generated contributions
Message-ID: <20260528041241-mutt-send-email-mst@kernel.org>
References: <20260528073412.551117-1-pbonzini@redhat.com>
 <20260528034301-mutt-send-email-mst@kernel.org>
 <CABgObfZwaiu4A2b2EFuFRA4dbWfHrDYEfiq5_-mf+zQpsYfTLQ@mail.gmail.com>
 <20260528035815-mutt-send-email-mst@kernel.org>
 <CABgObfbq9rFNHLYnhbr=5Gn9iJW1-BDsxTMLOjAoeM3h5Ct6wA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfbq9rFNHLYnhbr=5Gn9iJW1-BDsxTMLOjAoeM3h5Ct6wA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, May 28, 2026 at 10:04:40AM +0200, Paolo Bonzini wrote:
> On Thu, May 28, 2026 at 9:59 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > +     AI-used-for: tests, docs
> > > > > +     AI-used-for: code
> > > > > +     AI-used-for: code (refactoring)
> > > > > +     AI-used-for: code (prototype)
> > > > > +     AI-used-for: research
> >
> > BTW: commit log ?
> 
> I don't think I want to encourage it to the point that it requires
> highlighting, quite the opposite in fact. Using AI for minor edits is
> irrelevant, while writing the bulk of the commit message should be a
> conscious act of the submitter.
> 
> This was also mentioned in the other thread.
> 
> > > I suppose it can still be useful for traceability. I copied it from
> > > Kevin's proposal but I can remove it.
> > >
> > > "Research" may also include using a script written by the LLM, which
> > > is encouraged in the first section.
> >
> > but again, if the script is not merged, then the boundaries do not
> > apply?
> 
> See the first sentence above re. traceability and copying from Kevin's
> proposal. :)
> 
> Paolo

OK. It's all nitpicking on my side, anyway.

-- 
MST


