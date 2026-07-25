Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8292BC531C9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 11:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnawF-0002a3-RB; Sat, 25 Jul 2026 07:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnawE-0002Zk-Nt
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 07:53:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnawD-0003c0-ES
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 07:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784980384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pooy1komK3HiWfIILm8XPYtq9kz4EhuEd9krvRuamg8=;
 b=dfQWV/9wc4KQOXSsFVdqBgEANMb0PckK4s35UBjJze3CQS1Q8N09cETWJi0+NAb3gFL4bs
 ZQ4L74xMAWpYOD4k8ZiBeULJUCjWDomprsyPg9iB3dOwrwgFTLtXUtTUO5dLKOZsAvkbqf
 al3d3/FG7VUrMef6RkhudKdZZbsYt0U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-E4edOzmXNlyFuUevz6uuKQ-1; Sat, 25 Jul 2026 07:53:03 -0400
X-MC-Unique: E4edOzmXNlyFuUevz6uuKQ-1
X-Mimecast-MFC-AGG-ID: E4edOzmXNlyFuUevz6uuKQ_1784980382
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4955843c6cdso13504505e9.1
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2026 04:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784980382; x=1785585182; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pooy1komK3HiWfIILm8XPYtq9kz4EhuEd9krvRuamg8=;
 b=m1JqUsC5Jm2gObRVhBdbjh2iXF4quCHA64Hh67tek0ZEFP3HY3E+S/17+utoMBIGWi
 Y/QElfzEH+eiZbrWVr6Yp2keKLC6PWL+VUlil/p/54do/iF0UEdtdlTJ4QHHo4qBIxDH
 eZh5nsaACjZ8yq+Mr+GUr5zo81SkLTIRVV8gtlnOtCl/rULHMAEpZ73tpsSkmhvMRrnD
 Z/TIW5lMdup1wNu2EM9Jao8ZwWqMbX0cZMGsOLdcxK3YxFqOMe9WgH+ANBMfUlhsE0KD
 U+yG4G2UGdI8KiLOao57AU39NkN3l1LexFFvg37qtybn94+s4DL+Ay2vso6bLpSzhzZt
 SErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784980382; x=1785585182;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pooy1komK3HiWfIILm8XPYtq9kz4EhuEd9krvRuamg8=;
 b=qjg0N7umt/3agNRynOPFS8qFXG9ZjFaVHeFNEoVWtlPkTWLd5qCnpd3pT9KypYLRem
 AtM1ArvNrKrpqrig8qHZP8UYeDPd192VKT5L4/SzMCe1GyyJFnNFiqcqNGs/POQBZaK0
 sHk/XBfM966J1pSP1PsiGYVqf87/SZOwBC0125fvNT+4FL2iNaoyOpG5PhZMOcTWeZZ9
 +AjFkYUp51Mjhi/d32LCmUGgHy3lBIiCu4SJ5SnlpjspxJh4wgWddIRZfIWiAM4ivRwg
 qI2nE0fP/O87Z6owBpeWzouRBA3sfUyavZwkCFx4ZLdwJpgpdxd+97AY9sIkK6qKbSM8
 b1xw==
X-Gm-Message-State: AOJu0YwRlh6sxbqqQ752DIxASQ6unuJsRyj53q0D4nUR2E0exnElJk6F
 rBB9BOxWwIFQ+QHzCV7pHNw6O5w13PaEP9/99EohdWeks1YoXqdzoJ5K19pueTviMOD3woPdT/m
 Mx7tYNutautK3pmDk9X0W7buACArjhQxeLxfPBeNLxl3INl62a+NrPhnG
X-Gm-Gg: AR+sD13rsG5hpOW9c7VX8AvxwFDGZHMl+0fbRjcMPruI7Tzab7fhKhjltc4j6mF0v5R
 X3qbQ2DlU+JU0aFoMJpy87ez0341UNFgBtg0cA8ei7Smm7uR2uF0lR1uO9t9TdQg7N1G4Olvv97
 I6T6evWIEN6kuuDJ8By9C4m+0FFe/uoFOalgXwMphg9BAF0Ja2DXSlEgSAZvzzonlNy8/OcuQOF
 ZOgObdvfu5qJ1p7ruExuC90KDt7R7dOSy+pcrYxtvio8czUJYBSHK6DpXIrVXuViJCEpMq0fqfm
 ao4y1Np3iENe8A0Rqx1XVagivfKYO60cpenszZ4AKVgLLIV++hQZnY4boFIRuB79gkEuKnUKxxt
 u6SBPzb5kHKPxDYNe4k0gF365rSb1Wjk=
X-Received: by 2002:a05:600c:530c:b0:495:62bc:a022 with SMTP id
 5b1f17b1804b1-496b56f99a7mr26330025e9.13.1784980382012; 
 Sat, 25 Jul 2026 04:53:02 -0700 (PDT)
X-Received: by 2002:a05:600c:530c:b0:495:62bc:a022 with SMTP id
 5b1f17b1804b1-496b56f99a7mr26329725e9.13.1784980381403; 
 Sat, 25 Jul 2026 04:53:01 -0700 (PDT)
Received: from redhat.com (bzq-79-177-145-168.red.bezeqint.net.
 [79.177.145.168]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bb57cfsm32454427f8f.11.2026.07.25.04.52.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2026 04:53:00 -0700 (PDT)
Date: Sat, 25 Jul 2026 07:52:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Isaku Yamahata <isaku.yamahata@linux.intel.com>,
 Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH 0/3] hw/pci-host/q35: Fix blank screen for VGA when SMM
 is disabled
Message-ID: <20260725075245-mutt-send-email-mst@kernel.org>
References: <20260708121011.1653365-1-peter.maydell@linaro.org>
 <CAFEAcA8WDKBMQhQELQrMzW2LatpQdmr0qJgak64B5S3rnsRk=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8WDKBMQhQELQrMzW2LatpQdmr0qJgak64B5S3rnsRk=Q@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
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

On Tue, Jul 21, 2026 at 09:55:23AM +0100, Peter Maydell wrote:
> On Wed, 8 Jul 2026 at 13:10, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > This patchset is another attempt at fixing a regression that's been
> > around since v9.0.0, where
> >  qemu-system-x86_64 -machine q35,accel=kvm,smm=off
> > stopped showing graphics output from the BIOS since commit b07bf7b7
> > ("q35: Introduce smm_ranges property for q35-pci-host"). This is
> > most obvious and bad for accelerators which have no SMM support
> > (e.g. NVMM, HVF, WHPX) because there smm=off is the default and
> > so you always see the bug.
> 
> Is somebody going to pick this patchset up? MST ?
> 
> thanks
> -- PMM

I took it, thanks!


