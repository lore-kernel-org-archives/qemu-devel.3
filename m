Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 751A3C44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 19:03:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgoaS-00012f-Kt; Mon, 06 Jul 2026 15:02:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wgoaR-00012L-4D
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 15:02:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wgoaP-0001XU-GA
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 15:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783364551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fq/eK+EDfOxTxN50j17rJA55hX/iXHJqIXvcAwxAp30=;
 b=B7PjPxzqecV4ulHnhT4ghWfKQljJyXC/PEN2ebKaLDd4g4q4B/Gf5B/NG9aAJQbt6tBbWl
 SdAOIajobYTLc3LL/YTIyugyUlrR+cfYMsk9NzTjsFx3OVnif8JfsP9/vzTgurdVuNgUzd
 stddy0XRf9fwvYv3ke/moh7iWMefE4k=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-emZH3Rb6Pymc5qxblofESA-1; Mon, 06 Jul 2026 15:02:30 -0400
X-MC-Unique: emZH3Rb6Pymc5qxblofESA-1
X-Mimecast-MFC-AGG-ID: emZH3Rb6Pymc5qxblofESA_1783364550
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-664e15b53d3so1477011d50.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 12:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783364550; x=1783969350; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Fq/eK+EDfOxTxN50j17rJA55hX/iXHJqIXvcAwxAp30=;
 b=lvYOeUFDB7nOMmvIffPyuUsOJR6p5CTXKOHkKRIvl0PZGLxSboAWuMy0esieXbF5tz
 MmpUKtNIwj0z71IOtStryyXTmWKw+ao2vULR09SZ08adUq1Y3GdcZ2utEOCewWgaByYV
 SEFCM/0dxPa8IRxwDkiK00pCq/my29WzLXHJUxohWF7ioFHHX+ltBe6ZO8n4ghxnqbou
 2YFfIT+Go/dXT+u16n0dwNZg6Kc5RmC10rFRbo/Bu0/K7afq0D0ZkjtMohY9n74sYX0v
 rowT8G/edZ345GrqEvghNGi1lTYhQavaW6ZPImCeP36WwmVFTB+nhOAPLjVp0+GF0hvl
 HnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783364550; x=1783969350;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fq/eK+EDfOxTxN50j17rJA55hX/iXHJqIXvcAwxAp30=;
 b=G9P/h/ZgY0OHNWCvKgdD+6kV8kL506x/iir/5yD+/B2ZX7XdKuNtCvae03wZIvsZpd
 SYINd7QuOVskmfOgIxtSnCtfaKAwzcqG1OdIELxvSqC8lwFdjsHHmhr9RvzPCwR+MvV8
 ugz5LclaMvGM6gBF8CUaifD758ui4GwSxIIHxtl4NgUZQlTWfZg20zPWwm0Y5L73f5hn
 bjoQz/A7ffjDeZa3fUEyIPyiM1gZCFgc4s37GwxBXskTOhdJL5GWT9DDmpuNegEAs1Mo
 LySJNh019j54fjtEqMIVMzTTrZnNSJ8TzD/CJd61qmXXSCRj/YToJ9A7asUlo0jwbwku
 1Pbw==
X-Gm-Message-State: AOJu0YxwsqGeKcGOcPqpYJ6XMNSiI8TXoe5+sMtvpUdDYbzL6RfIXmhH
 JZsBP6WzM8m87YAkItC0+f4twQOEtydIr+lvsn38CwwTj4t4KQ9Wqm8cJiUVlBn3KWAQJVU/pRt
 +9Zlyl+Wr2T1ATkvvAy+0XffnzR3Xs+7zmmCv7TLmBJ/smnIswmJBByrZ
X-Gm-Gg: AfdE7cnoeaRmhOG8NvEWitoE8GcFE959jVW1dMf4LDnH96tVf2xe3edle8e6WWR9tnP
 knYQIr31hACHmo6pohE/wJhShxW5I4CZwr+v7T8fKImuCmG0DYKvgQLOiqECI4B0jr+vdo944by
 k44pkB0pgYV/W/CBb+YF/3GE2oCqaiTsKX3nFDyXUz8pSRsF4JrjnQXVR79kIJbgROtmGQCnNT7
 mKHFTD7nRR/GcXW3x6hrK2ygTuDP9p6b71H5WSJ52AH7GIzoFFBTuv/t4hX7XKzq7PjkOZX00Ci
 skQ0EbFtGIembqvEUPOOOstQ2cZBjBcTCB5a6X21we9Nl3LPjKk2uu2bZcRFH136EHKkZjEVCPL
 QbOQqAC+cFhAePeRIxn9sSzoR7Zi2vrHKZHg2fN34mzGewNc/vrrc1JfJpJPwxnnoP27i6A==
X-Received: by 2002:a05:690e:1183:b0:667:72da:e793 with SMTP id
 956f58d0204a3-6677fc7b9a4mr1518179d50.53.1783364549802; 
 Mon, 06 Jul 2026 12:02:29 -0700 (PDT)
X-Received: by 2002:a05:690e:1183:b0:667:72da:e793 with SMTP id
 956f58d0204a3-6677fc7b9a4mr1518142d50.53.1783364549282; 
 Mon, 06 Jul 2026 12:02:29 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f46f30c04fsm153407756d6.22.2026.07.06.12.02.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 12:02:28 -0700 (PDT)
Date: Mon, 6 Jul 2026 15:02:27 -0400
From: Peter Xu <peterx@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com,
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com
Subject: Re: [RFC PATCH v2 1/7] migration/tests: remove capability conflict
 test postcopy-ram+mapped-ram
Message-ID: <akv7w9vIRHtt77RJ@x1.local>
References: <20260630081940.611092-1-aadeshveer07@gmail.com>
 <20260630081940.611092-2-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260630081940.611092-2-aadeshveer07@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Jun 30, 2026 at 01:49:34PM +0530, Aadeshveer Singh wrote:
> Remove the test test_validate_caps_pair, which asserted postcopy-ram
> and mapped-ram capabilities cannot be active together. The new fast
> snapshot load feature is exactly this pair of capabilities active
> together, with the following patches in this series, this combination
> will now supported and be functional.
> 
> Remove the capability check that rejected mapped-ram and postcopy-ram
> being set simultaneously, as this combination now corresponds to fast
> snapshot load.
> 
> No replacement test for fast snapshot load is included in this RFC. A
> test exercising the full save/load flow will be added in a follow-up.

Don't forget to drop this paragraph when reposting.

> 
> Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>

Let's move this patch to the end, because it enables everything.  The patch
itself is all fine, thanks.

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


