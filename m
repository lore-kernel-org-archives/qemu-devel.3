Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E6C2C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 15:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwLjv-0002qw-Eo; Tue, 18 Aug 2026 11:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwLjt-0002qQ-4x
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 11:28:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwLjr-00080a-Lw
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 11:28:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787066910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hc2ozsH4rcBASEMPINYYEWry0oGQh8OmzvWwba74o+U=;
 b=gtC4DjdoxUJgJ/nKt276pHtTBgCMvas/bLxUb8F72TTHLd3CF9QV9IZn2F0Ok3YMn177fh
 hLhh7MuphpkzbKdg5zx8iizUr/xY+S8IKxd4LE1ut6qhIjNxn+2Q8RjKggHmYvn2Ezzv2s
 t0mMxGdrsAa7gQgjTKV4xiqfD5sLems=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-KWJt3-uaNViJm2hMfQrmow-1; Tue, 18 Aug 2026 11:28:24 -0400
X-MC-Unique: KWJt3-uaNViJm2hMfQrmow-1
X-Mimecast-MFC-AGG-ID: KWJt3-uaNViJm2hMfQrmow_1787066903
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8485b7e18b4so82259b3a.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 08:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787066903; x=1787671703; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hc2ozsH4rcBASEMPINYYEWry0oGQh8OmzvWwba74o+U=;
 b=PcOjLXyApsY2D4FTCyzVK2fTkgPjlc7SSaT7a7ZdNecJuMCA03qev3xfNF5j2IBUv1
 VReAoaT+pbH/KmSVsMrrhIseWmvNVezqIScUps1CVZKDvTqu6ESEkfn9VE68L5ErzJ2x
 gG3G2M83/CEsKeIvZ9ynyrCxzeIFKe+GmCVeTr1WOLJN6iCHOq64wdMXzshznhVR0vIB
 nhST51IaLRKnPCYU+pq6pf+HNANdTFtJap/CKDMZwDGIjpgJRyjn0mgQh8elI918timg
 qEQtCVnaCUI1wH5+o6JrpZuqsmgytWHitNpZYkX0HM1E+e9Y5DZkB97ISVqagVkAy8xR
 QLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787066903; x=1787671703;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hc2ozsH4rcBASEMPINYYEWry0oGQh8OmzvWwba74o+U=;
 b=WAemjWhKFRllDup2hfZ6TgOGIGsvC6kXcyKKpTeBjv7qqvVoNoIBaHUuDsow5dQoTh
 8GMQGKt2gejW72FMC0b4NLM8QBRovv2l8GkO5wb601cP57Rmb39ujBkOVnFnM8TTuIbP
 9nYmWtldSDBBDfFTlff0pIrXjGzrTo5gbMTnc3ekvePxJ2uTnqTamPF0dmEILjjGrSzV
 4oT53MpyI3N1nuoO+MX7urcpKbUTQPbgtfC0zVLCW+xUupeVo3fH3Ny/STHCbIuruM96
 XpeF1SEMGIgKHKKlLDXUXV0XFw+nM7TOH+RbSABOMMxt1IEaDl7e7HdjVvz3PSDxU4Nk
 EPaw==
X-Gm-Message-State: AOJu0YznZkPxANaErdcbb1eN1EDq+UD3JUqo5aLxB2UK56AgTBErNb2r
 jZY3N514SXOOd91iuWfnv1fYMooy0AmNDKifhJ8UmimwqAJY4XY6zrJgFlx3NF8y5fiyJHYRqJ0
 Zo1D3htuCrCFdYva4WSoJ/Y9pfkVGtTs3QCQu7d55lvW79oOESuazoRyC
X-Gm-Gg: AR+sD12SMXN03CQ3MiiEux8s5/ZFmzGc1k+gpHr8Qds8JsZLIr3rdSqgFzidyFaPJWB
 CmVanp7S4Urwc9aDGRrG9U4oVXYwDDn+AFWRzV/dJTR93EsksH+3rRTAYtXlbxDro0WyGWu3d3C
 AWi25JKHGPplJ5Am3SItSw5TwQNhq6BM7hIyGTRH7srrOq/3MJmrkFSeSQWeQbPXako/mmwUCRR
 LiNX/EkrkWcNMAWcHwyWRFYQ8TAZ0+hwf8jfJKMonoa5zw7GhNX61oxOjTO77woBTZ2AMdgNrTP
 k9DLHdnnhwbcfjQt6tH9suFiGlQ55Y9smsRLBIz7zWfGEMHFlE/VNMQn7mUBzb3p1NEeRK9bl/n
 xJ9R4KO6/1zkNspECjWCmk/2ehoV5Lbk68VOdxgmJ12/atQeCXfE3V48mldQ=
X-Received: by 2002:a05:6a21:9981:b0:3c3:a140:9392 with SMTP id
 adf61e73a8af0-3cc7177a8e5mr32089125637.0.1787066898325; 
 Tue, 18 Aug 2026 08:28:18 -0700 (PDT)
X-Received: by 2002:a05:6a21:9981:b0:3c3:a140:9392 with SMTP id
 adf61e73a8af0-3cc7177a8e5mr32089054637.0.1787066897828; 
 Tue, 18 Aug 2026 08:28:17 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc13bf26ad5sm2318940a12.11.2026.08.18.08.28.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 08:28:16 -0700 (PDT)
Date: Tue, 18 Aug 2026 11:28:14 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH] system: Define ram_addr_t to be always uint64_t
Message-ID: <aoR6Dtwq3XrxC3Uu@x1.local>
References: <20260814134035.2733355-1-peterx@redhat.com>
 <CAFEAcA9xnJ1i541bLbKheVZkPvSFH1NTerUomWV4j4DyHhOPgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9xnJ1i541bLbKheVZkPvSFH1NTerUomWV4j4DyHhOPgg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Fri, Aug 14, 2026 at 03:48:32PM +0100, Peter Maydell wrote:
> On Fri, 14 Aug 2026 at 14:41, Peter Xu <peterx@redhat.com> wrote:
> >
> > QEMU's 32bit host support was deprecated since 10.0 and removed in 11.0, at
> > least the system emulation part.  Now it's safe to move ram_addr_t
> > completely over to uint64_t.
> >
> > It should be almost the same as uintptr_t as before for !Xen, except that
> > on some systems (like MacOS) uintptr_t and uint64_t can be typed slightly
> > differently, causing unnecessary compiler warnings when use them in a
> > mixture way.
> >
> > Hopefully, this change also makes it clear that ram_addr_t is never used as
> > a host pointer in any form, but only an internal QEMU integer based address
> > space for allocating ramblocks.
> 
> I've thought for a while that we ought to do this even if we
> hadn't dropped 32-bit host support. Having ram_addr_t be
> 64-bit should work fine even on 32-bit hosts (as evidenced
> by the fact that we forced it that way when Xen was compiled
> in), it was just a performance thing to use 32-bit values here.
> 
> Having it be 32-bit sometimes was always an irritating source
> of "whoops, doesn't compile on 32-bit hosts" bugs and other
> oddities. There are likely various places we can clean up now
> where we previously were working around this (e.g. in
> hw/arm/vexpress.c:a15_daughterboard_init()).
> 
> There are also a few ifdefs on HOST_LONG_BITS == 32, which
> (where they're not relevant to the tools or guest-agent)
> I guess we could drop.

Indeed.  Let me see whether I can touch those in one go.

> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Thanks,

-- 
Peter Xu


