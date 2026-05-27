Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA08CD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 14:12:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSEzG-0005dE-CC; Wed, 27 May 2026 10:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wSEzE-0005d2-6s
 for qemu-devel@nongnu.org; Wed, 27 May 2026 10:11:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wSEzB-0003cY-JV
 for qemu-devel@nongnu.org; Wed, 27 May 2026 10:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779891112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cFO4zekA8e3odwUEuSB6CsmkBnoCuNLFnxtv9lFUwfk=;
 b=CNoHciEp2NF0P+fH2+zpe6avjMA8Fdxrku/crKQ+FpAQwdfZP55g/s+rvUc1VhY8tzGDEo
 05ci70N5F8xGceZxYkxLNpYXmQS0Rzn/08jAhLzjgjrwrjBHBi1dHFXCuTINjl8n+uIN9l
 OW+e8aMK6mXs6lZ3FMYpaazDpi64wpk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-GvHf8croO7GwQ6RixBaNfQ-1; Wed, 27 May 2026 10:11:48 -0400
X-MC-Unique: GvHf8croO7GwQ6RixBaNfQ-1
X-Mimecast-MFC-AGG-ID: GvHf8croO7GwQ6RixBaNfQ_1779891107
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49043386b3fso51731025e9.3
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 07:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779891107; x=1780495907; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cFO4zekA8e3odwUEuSB6CsmkBnoCuNLFnxtv9lFUwfk=;
 b=iACJE1CsTP4XGQsk++BN5v1qw4SHn6vuayOn1yycjxyNTj7+y7vKGseG5kQmx506Ms
 3ejkB29Zdn/cF53woA5aYEfkyxpCYldBCRIIT6nG6j2qQmtGx15v7CNqBVZJraD0Qj/T
 07o1AJB4iF+qUkcj6heWvGKdlt75IRWe2r7/c4i1GOTHL61sXZg117g+T6zrD5cXOMNT
 zymTKTZ5RBIur5zMc9QM1UHN+HyzOdZTeyR+ivUhLKwb1FymYyvB1Io6c2ZSkwz1Wgx3
 FryRo8hIT8ih/8tO1bb3mtUKB34WTFHMkE7MWUaOd7KQkh+0B+Pot+hyNpIOOINtbW57
 93Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779891107; x=1780495907;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cFO4zekA8e3odwUEuSB6CsmkBnoCuNLFnxtv9lFUwfk=;
 b=kVTuwTbHx6+bxbtli8Pr0pUYLHCO8avMaEnBqK6xUePjKUy796/4eXwcACEMX+cycf
 xnBsqot4YcbxpLRewzPD2aiZJdj3qVjthYhwpiMkgCcqFh5md3NdNYiBwyu2a4VpslLW
 yGzYPvdPxatXk21PSQgvQ2t6yrFnR1pt29dOtiAHWmElX/EO35ZpGg0ey3ZqVzb0RieQ
 JUnr5D4byzufEhPhgqxXbJyNDw1Pgpe+YVmZI14ET56BCpkweTrqQBM3wo0VBkKkEXmo
 JfMapavmFRqO6exBxE05XPd8iKUi51A2Gts4wCNPmzN0vPRGRLVCU2ojvLIbF6nH7qoE
 nkPg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8FfpNgeE8tGgvHZczvP0QUjTYvWGlS+0QRKPeQ9RzHLAeBHciJXCv4ZhoqzcbxR2vJIgfSn3qlOpSf@nongnu.org
X-Gm-Message-State: AOJu0YzHaP8NAN1l4K6cCF/vvaxqypcnhW7mV/CQhsErgCdonZxVK/6S
 bICwtc/bCktLMEv1IBz7EtJV1FZ73xJuuIdO1iZJgYvv0GU3weYWWOuWIgnnQ5c0YAazdjdaXBZ
 cqkfCin8JsRFkPfPqeiF8Yicyn5HALztYXZwn13qOZJ6nxd7kFyfDoGl5
X-Gm-Gg: Acq92OG7LV6OWjNBkin621eXUBUhGqlvQaoeuYZ26TVGw5XnIS6QTeiBI7cc5HXxmmH
 3gMulfROFXMYDd2BegeqaBoSrgELhRGQP4oKtNH/cV5P/pLK87uin1Dsct91ufGoA2JsUoWIBfB
 vZOIidVyEJCcnNE5vfJ2eQbR+qL+ZUxK9XnzOdyyyDfQB/fyJJqydgIxqYHK/nCzhDpKb3VpFFT
 wzxYg+vV3yUMzRjrSkSwi2Va8nnkkmQSQxQKdNJAJ6fQElC9TxsgDHBPlAbk1iOFX+yDapEuAFL
 3mW8qEHpFGSoTmKA2+hTpANHgxa/EK+W1D0imRhJITgoZlEKd8qKcNk/CFLo7XSVeR807ZZopJJ
 eDrYb1rTtSmAU
X-Received: by 2002:a05:600c:6207:b0:490:5e2a:f924 with SMTP id
 5b1f17b1804b1-4907dae3d6amr82363805e9.7.1779891106728; 
 Wed, 27 May 2026 07:11:46 -0700 (PDT)
X-Received: by 2002:a05:600c:6207:b0:490:5e2a:f924 with SMTP id
 5b1f17b1804b1-4907dae3d6amr82362845e9.7.1779891106116; 
 Wed, 27 May 2026 07:11:46 -0700 (PDT)
Received: from redhat.com ([31.187.78.155]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454c600esm390805935e9.3.2026.05.27.07.11.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 07:11:45 -0700 (PDT)
Date: Wed, 27 May 2026 10:11:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Warner Losh <imp@bsdimp.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: on ai generated and code provenance
Message-ID: <20260527095525-mutt-send-email-mst@kernel.org>
References: <20260524083329-mutt-send-email-mst@kernel.org>
 <ahXbxzB4C_lr6b0N@redhat.com>
 <20260526140231-mutt-send-email-mst@kernel.org>
 <ahXtqyuIa4XqkMHb@redhat.com>
 <20260526152526-mutt-send-email-mst@kernel.org>
 <CANCZdfonroZmdRRpPdHzTKR_m8qyVdSG14gXB-K3BTuv=Qgw9g@mail.gmail.com>
 <ahauQKLOU1tzDtbb@redhat.com>
 <f8791a2d-257b-4233-aafb-ccd45e695542@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8791a2d-257b-4233-aafb-ccd45e695542@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, May 27, 2026 at 12:01:10PM +0200, Paolo Bonzini wrote:
> > > 3. Limited, small changes to fix bugs or add a small new feature whose
> > >     scope is less than about 100 lines and the originator can explain
> > >     them all or the meta issues about the patch.
> > 
> > Not sure if mentioning a number of lines is wise. 100 lines can be
> > mostly boilerplate and simple sequential code or they can be a deeply
> > nested complex algorithm.
> 
> I'd put the threshold at 20-50 at most.

At most 50 lines added, right? OK.

-- 
MST


