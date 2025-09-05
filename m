Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 566B1CA1010
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 14:34:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuXUl-0004LZ-BW; Fri, 05 Sep 2025 10:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uuXUi-0004Jl-Vt
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 10:32:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uuXUb-0003I3-NR
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 10:32:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757082761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AJYsQ0k41dYEtEm+qEtpIcG16VDv3rXSXQjY6KH6CC8=;
 b=SbN27ZXSN7kWZgZQiH6Q3umAKvh6BoA+ctWFRc0qZh5DP6Pc0MXMvbGH1LMgH8EhFx4QhZ
 O7tDgeb7ZzuD8/yCL+/ZNj5GRgHgiBMVvQF2oHTzBA8ukCRZYRi+v5OsoFCQuNY5vTNAhW
 oJvHIgVItRUwgEOtHOdfh7jBSnvS37U=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-tQLGaMKJM-mmsi-iikyoPA-1; Fri, 05 Sep 2025 10:32:40 -0400
X-MC-Unique: tQLGaMKJM-mmsi-iikyoPA-1
X-Mimecast-MFC-AGG-ID: tQLGaMKJM-mmsi-iikyoPA_1757082760
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4b5e9b60ce6so23522121cf.2
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 07:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757082760; x=1757687560;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AJYsQ0k41dYEtEm+qEtpIcG16VDv3rXSXQjY6KH6CC8=;
 b=Tm/kYaqzM6hmn0qpPgMzNdluCt7LK4DdE/wmxiM0KTHDodSaKxfuy3O80LddMxdwnj
 YAKRPpp6erwmXj939aZXRRlPjz9dPgGk4+pZz/yGwixbZyZTofA07/2N3jvIpEYGdmof
 wxWepuN0UzU85u8A90XkwVOv89FS18yDAbj2zJGsTNkQqQNLOvEbrEG1sqVTzt5Kjhhj
 Q8V7HuuK7eT2oM54Rb3imUIPZ7e2mNwzGFRHj+KqAgh3wSxiDjG0oKr2pSGYTBjDVhrl
 6aGaMw6tsJh265fb2chEGRC2+w92XUnXsYfKsWLG9M41EkdWehSg7F2v0ug3RhQ10NFx
 PC0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8zjhoMMILi+YOSujvjDxdjoI8uTAifrov9kCJe3wnToTDf8JDhSikkUL5j2ZGmSITbKVU21LOhSBV@nongnu.org
X-Gm-Message-State: AOJu0YwlU/u2AEZkH7h7EKqTVOPXkJw12rPaPzSXEyPHlE/JSZunha6J
 lZqvyh/jzEhO9dL3pDrtlZ4qVxEDzYwhNgqbBtmhG1g4N/nZUPoZsQ6p39UuRfRpA6E0MGdKnQa
 7/Gck+p5QufxVj1NH6bKI7QyHctq0uiXFETqgR8A1vCgNOUOcJ75aKUC4
X-Gm-Gg: ASbGncviHyHUlNqWQ7ksJ1o/zphkqQ0jz7SzPeytS3yDP/fCSCuqAfhHlqQ1MoMx0oc
 sYE1aLKCF92TKIKFTWADFNgqlwJ2Id5AORDtNYTWgOdtUR43t5B36a5ARPkWZKxP5kC8QiE4Nmt
 k9rMkri3uZ5t8SalZ77d84K9nV6WUZJvOBFLmQQZtoZ6mwq1L8WWIMc0FF0kNNcGMQyHjwKV0GA
 niR9EPzqjYooGtB51h0AtcHpvCy2MFd1L0eur55jmLoPze0NIQvvYUeEMrR4iIgy0gbaLJ45ARd
 ktxFVW1CqRawMSq+AH+oe02jZ9q2FPbm
X-Received: by 2002:a05:622a:10c:b0:4b0:69d6:85a2 with SMTP id
 d75a77b69052e-4b31d86175amr301290701cf.31.1757082759510; 
 Fri, 05 Sep 2025 07:32:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGW45Sakcic0/au626zXwdL13HxP0OyaIYT2HgE/EM8+kHYAiCyErP6T4Qce2avfFhoAv8oA==
X-Received: by 2002:a05:622a:10c:b0:4b0:69d6:85a2 with SMTP id
 d75a77b69052e-4b31d86175amr301289721cf.31.1757082758538; 
 Fri, 05 Sep 2025 07:32:38 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b48f673fecsm45984731cf.21.2025.09.05.07.32.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 07:32:37 -0700 (PDT)
Date: Fri, 5 Sep 2025 10:32:25 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: chen CJ <cjchen@igel.co.jp>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Max Filippov <jcmvbkbc@gmail.com>, David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Tomoyuki Hirose <hrstmyk811m@gmail.com>
Subject: Re: [Withdrawn] [RFC PATCH v2 0/9] support unaligned access to xHCI
 Capability
Message-ID: <aLr0eTjUe8FXkQmV@x1.local>
References: <20250822092410.25833-1-cjchen@igel.co.jp>
 <CAAMq-Y86UY7LNe-p2P_d8mw7FgTqLm=HQdqbMvV8xxTdsZmx1A@mail.gmail.com>
 <CAFEAcA_EZxgnSHOEwdF5QayAxsncYnGGe4RDPP-vwYTqwU+dNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_EZxgnSHOEwdF5QayAxsncYnGGe4RDPP-vwYTqwU+dNA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 03, 2025 at 10:47:17AM +0100, Peter Maydell wrote:
> On Wed, 3 Sept 2025 at 06:03, chen CJ <cjchen@igel.co.jp> wrote:
> >
> > I would like to withdraw this patch series.
> >
> > Sorry for the inconvenience, and thank you for your understanding.
> 
> That's unfortunate; I think it's an issue we really do need to fix,
> but I entirely understand if you don't have the time to work
> on it further.
> 
> I might pick it up if I have the time to do so.

I worked on this problem a bit more in the past few days while almost
everyone will be at the forum.  It's almost because I saw similar issues
that I have commented before on old versions, but they still existed in the
core patch 5.  Then I found more issues.  Keep commenting on that might be
awkward because there will be quite a few dependency changes.  One example
is, I kept thinking we should not worry about MMIO out-of-bound over
mr->size when reaching as deep as access_with_adjusted_size().  There are
still quite a few places in patch 5 of this series that does the
calculation and it's not obvious what happens if mr->size violated.

Peter, if you want to pick it up, please consider reading the replies I
left in this series, alone with this version below as comparison reading
material.  The hope is the reworked patchset below _might_ be easier to
read (at least I did add rich comments, because the unaligned changes are
tricky and not easy to follow):

https://gitlab.com/peterx/qemu/-/commits/mem-unaligned-fix-v0.1?ref_type=tags

Especially this patch:

https://gitlab.com/peterx/qemu/-/commit/8a8f0f5728a7adc6ecb2cf4358366d2d663a5ed9

However that won't pass the test cases.  I still doubt the test case is
wrong but I didn't go further modifying the test cases yet (or any better
way to test this as you suggested in the other reply).  I think that can be
the 1st thing we figure out, not the best way to test, but the correctness
of the current test case, because IIUC it shouldn't be relevant to impl of
unaligned access.  To me, if we can reach a consensus on what is the
correct (test) behavior on all kinds of unaligned access emulations, fixing
the impl should be relatively easy.

Thanks,

-- 
Peter Xu


