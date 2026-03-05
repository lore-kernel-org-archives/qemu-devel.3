Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC90F3D332
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 17:15:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyCIV-00011t-5I; Thu, 05 Mar 2026 12:15:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vyCII-0000zD-7b
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:15:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vyCIG-0005fL-Qg
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:15:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772730924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uL6mXpjXurniYA5EoOlsGIbqMSMn4cPbCbbTVPdQmx4=;
 b=VdC0WSljfCDk/ThSTC6Go6QZx+Kg3vuzq8bD8Sr92wi+JtMErbHmxvlEE1Ob5Hd9o9CFfw
 ct0VptyjDeys0ii4NSNZDjmzG5NLdZH88mavrh7BKKpR95doAZBUeQpvg6cgesDcwG91RT
 ObY76yLUM9xBZTOjURsicQXqL3BGCRc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-1xhGTv7vMOKY6JxPeYngQg-1; Thu, 05 Mar 2026 12:15:22 -0500
X-MC-Unique: 1xhGTv7vMOKY6JxPeYngQg-1
X-Mimecast-MFC-AGG-ID: 1xhGTv7vMOKY6JxPeYngQg_1772730922
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5033b4d599eso633251601cf.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 09:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772730922; x=1773335722; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uL6mXpjXurniYA5EoOlsGIbqMSMn4cPbCbbTVPdQmx4=;
 b=q+kYeYTfeqSQu7vpG6y9ta/qvfINVhZCmPGK2xeMftUzAsJ7kLthwcooEOh2sAT9cc
 jlvMix8H1Ns+lOKdno7GPKzJhn4CYtlcpkXV6ZzM8DGhMxjPf4qeHwXEl5ZPYE+fOd5R
 7CpggDS2mAR3r5BoqlXwpgjym5yxAauEIPIUrx/ivoXX8zYHpLlpGoYrvYzPGMDE6rpk
 cQbvY8FagOQJRDYAxLBfGGi3yf2Cfq9A62FtxibYiFGlz+XAFeIM2b+1OHhuqPzkM7gY
 xRpHt4bB3CSUPXJ14dBnfRtvH2XvJ1N5iJzsFYP1kUW8lzG55ix5tr4LVD/Q9NFsB+Vv
 IyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772730922; x=1773335722;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uL6mXpjXurniYA5EoOlsGIbqMSMn4cPbCbbTVPdQmx4=;
 b=UdjcZuqDNerm/oy0NxrhwMIHx4vSIGedKMkCCVX75nDi4ajcf8/10f2qMLm5xleu97
 7h8SWw+I5fPQqsZoojB9JHSTDXIT2U9pByzyK4iNOZXM1zPdQ3CVdAOuO4MwV+BQ2HYC
 LTjekE/cDVyBPTm7XnIQGYYUnrNaFcBwYRkscs5a35TPxc/XTMr53e4tGR/c9ajfWe5M
 /T5GCgmMANxd4uFM9F6Uss9UXzPqwNEutopd1dGWnldDR2xueiLj4d2yh5/ZfFK2LFwI
 dMU9hj9NqAe206zXOz38tebuKSRfPiUKmOjdbO5rLwuyTAfWk0PPD9nD0a4QzAFYO2n9
 vp2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV21u4KXY5p4YR08LhGCYAntKFGS9Ooju9uzH4N1RwgqfBXe+2X0S0kxmmb5ZJ0IBv47c8gWiRL6GnI@nongnu.org
X-Gm-Message-State: AOJu0YxAybeGimP0khQMpz8tp6uYj09f+EWfyWS9/9N3COLn5lOMkYFn
 aJ7ryrn5cE/vvgATdMz8Z2CKTAB4tTSJbMxmILkgZm+/VYO2YwY4SYJIqbjWb0xNv2/FcDllpFb
 Vr89jYXA09orS1M1qQPx9RiVH2ftKbckjN6WU/d+0YZGyYOitNrEfWhNVXTUD4SxU
X-Gm-Gg: ATEYQzxNDZprGTX2abvjti/68fvnRiWoiHCWKVX+eBXRQFVo+3BMjftkZTGNv59smyE
 7IV/cpFGBGrZ43PK70cl48SWszlRJWbClBLkFwwCz1fs6+renffEVd4UDGtICpfSZaQ3Uljjw7j
 5aVnhuWT/Qq10WqNd/+dGVHK5Ksj2xPP2W2+jkQEcvlGaLQijXT14YwRWYsk5d1vqb1Ns5QuAsU
 7Spz8H/8+vyPZ20WZVZx2vuND9qekthOmZURRNbD3o617mIDMPpKzU103pmDPzORmKUgljEvAmm
 pHv+mK6E9Jd/dUiIScTmHZYsv/pG+1QzbbUoNY7jEvjwCUQeGX7qM/zWWQL1uxNRFheHBMtf8yj
 jdVBTgKycBpbLag==
X-Received: by 2002:a05:622a:15c9:b0:505:e7b8:5523 with SMTP id
 d75a77b69052e-508db24ab8cmr84173861cf.8.1772730921823; 
 Thu, 05 Mar 2026 09:15:21 -0800 (PST)
X-Received: by 2002:a05:622a:15c9:b0:505:e7b8:5523 with SMTP id
 d75a77b69052e-508db24ab8cmr84172511cf.8.1772730920832; 
 Thu, 05 Mar 2026 09:15:20 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50744af0731sm208969191cf.31.2026.03.05.09.15.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 09:15:20 -0800 (PST)
Date: Thu, 5 Mar 2026 12:15:09 -0500
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: farosas@suse.de, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 18/18] migration/vmstate-types: move to new migration
 APIs
Message-ID: <aam6HfC_4-MD9dBY@x1.local>
References: <20260304212303.667141-1-vsementsov@yandex-team.ru>
 <20260304212303.667141-19-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260304212303.667141-19-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Mar 05, 2026 at 12:23:02AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


