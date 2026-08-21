Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F77DC5DF89
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:19:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxQ4r-0006xW-FD; Fri, 21 Aug 2026 10:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wxQ4q-0006xM-8H
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 10:18:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wxQ4o-0002YN-JN
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 10:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787321913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=84FGYflcgv58lo4fhVZUCd3ZOcqUuln6jNO6fS/A3cs=;
 b=BtYFnHp+a2+xVQNNX5l48aG/im1JTjaAfEOePs1m2qjujzDWB0PSGp1x76PM7dSlKQqFXv
 TLOAYPAnlEA+WNnX1++0Uz96qFxS/4W3c4LcueDMMq4A6U53ZZVgxvAlE/Rq84xbA3FbYu
 VScIT252q4dRmuNBas8eBN2xVvyB5ZU=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-1TIDF0LMPVOBnXxItLrw8Q-1; Fri, 21 Aug 2026 10:18:30 -0400
X-MC-Unique: 1TIDF0LMPVOBnXxItLrw8Q-1
X-Mimecast-MFC-AGG-ID: 1TIDF0LMPVOBnXxItLrw8Q_1787321910
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-48e5de5a23cso1491201b6e.0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 07:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787321910; x=1787926710; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=84FGYflcgv58lo4fhVZUCd3ZOcqUuln6jNO6fS/A3cs=;
 b=mcQC6fC9jz8gVMlBu7HRsTdN0bq+z8xvdnNWTlw5vf8oDH6EFyrVb3XvIRDtYXRGzC
 4oI7uKtyRe+OLDitLH7+c57dtKLx59AnVB1RRiReeB29QFTwq82FxhfaPXioA0W3TQCV
 mt5G9tzDk4T6Lb1P4G2ZMGiIWWRWQGxlnVJjKBcgk0zQlYCcUkD+dAxX3vJP3sGS3HTU
 5WWdu0cvzHqrAC9YWFd30hobmXTDoWTytBxBQhq1ewSJQVMOaOhp01uTktr2Q+GkVX9I
 k1U0pNogqvWwE8fRHr5EYhA7LD4jBngm0HcmP9xQTx7FePXysA5TbhJduK5CQ97IaBXc
 eT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787321910; x=1787926710;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=84FGYflcgv58lo4fhVZUCd3ZOcqUuln6jNO6fS/A3cs=;
 b=hLosuOlBgQaS5p6o+hlM2ancBSmIqzGOwIIBVXyAq+wiGBZiKUzkAHlRWoCA831IFt
 xpqeufIXf7C8dqpd1fzrsVAzBB73/ipVLX6jwOF/koR9ZQkwtQejd31E3HwuV7X87+Ak
 TTTuBMHmlLRKfdQGzCOWY8jhYkuQ3EvOvHExcfwiow46zcTa26LktlDIWhtYpCLn6Hoe
 FCjWzCeerJCdi90aSY2IIWrY49qrdDtAXG/BFJy9xBO86N4ZoNij822N8a7Q/Ymvhj1j
 Qy+GZBCpxEs464nn+XJAQqqFLbRvUXxsYG767+kCxvDEIXUP2nBzK4RY/9gHVgItfTkP
 PWqQ==
X-Gm-Message-State: AOJu0YzLStDP9q9jeykyRVgMJ01teZcMEDkXUWfhOeEt0Q+b/XbwY+RF
 VyWeV6ON5RobysmeQofh+4t+8ByeZypOj0ulJoGCbUBOz8LqWCXq0YR9TB3SsR87PIB5BzSl+Xz
 DHNDzduYwDDDn7ppxUSU91mr8WgEF6PcT9sV+bU9V4jiSLhwkcdaPMrak
X-Gm-Gg: AR+sD10CVBEOdawFc77K668s4OKQHCbpu0c+5W1lDyTzB5nu5U1BQ/opCXRkEqMxipg
 KcdrWUzgM1gBBIr+Y+IG1/KfqhXRlJiFwn5yAf5rNJs7VP0whqjyj/lztzBHwmvEqgTVx3LOmi/
 iUqrCvHaBEhYAQqponSZA1+Af7OMUEZff/aQhIytDwm8wd/TaJqfJ4uf6zWCUYq376zeRCc9Hu5
 hn836E2m7Ic0/csZ9slRqwpMA2uas0/dRYFxSwcb+y4Iyc7TUFWpDT+EMo7ebV4p6jNYPJgVQd0
 T8Bv9BxcDwiZr0xUFgSTixsKxYM5oPHaXk+zkdfp2j+4WvNS0g2IhLsKjjoveDwYwRJ25PO6
X-Received: by 2002:a05:6808:198f:b0:495:f79d:b08e with SMTP id
 5614622812f47-4b2ef584b2cmr6584776b6e.21.1787321909849; 
 Fri, 21 Aug 2026 07:18:29 -0700 (PDT)
X-Received: by 2002:a05:6808:198f:b0:495:f79d:b08e with SMTP id
 5614622812f47-4b2ef584b2cmr6584675b6e.21.1787321909351; 
 Fri, 21 Aug 2026 07:18:29 -0700 (PDT)
Received: from x1.local ([2605:8d80:6d68:fe45:30f9:c4fc:ce4b:4f74])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2d6711e15sm4921691b6e.1.2026.08.21.07.18.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 07:18:28 -0700 (PDT)
Date: Fri, 21 Aug 2026 10:18:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, jmarcin@redhat.com, david@kernel.org,
 pbonzini@redhat.com, chenyi.qiang@intel.com, farosas@suse.de,
 aik@amd.com, xiaoyao.li@intel.com,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: Re: [PATCH v4 00/12] KVM/hostmem: Support init-shared guest-memfd as
 VM backends
Message-ID: <aoheMqE-RnH8sQ82@x1.local>
References: <20260812201938.198915-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260812201938.198915-1-michael.roth@amd.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Aug 12, 2026 at 03:16:38PM -0500, Michael Roth wrote:
> v1: https://lore.kernel.org/r/20251023185913.2923322-1-peterx@redhat.com
> v2: https://lore.kernel.org/r/20251119172913.577392-1-peterx@redhat.com
> v3: https://lore.kernel.org/r/20251215205203.1185099-1-peterx@redhat.com/
> v4:
> - Picked up v3 series from Peter Xu and rebased on 11.1.0
> - Collected pending Reviewed-by's
> - Per-patch changes:
>   [01/12] Fix blank space (Xiaoyao)
>           Fix commit message typos
>   [02/12] Drop duplicated error-handling for capability checks
>   [05/12] Fix up commit message, disambigurate "in-place" terminology (Xiaoyao)
>   [07/12] Fix up commit message, disambigurate "in-place" terminology (Xiaoyao)
>   [08/12] Disallow 'seal' and 'hugetlb' options based on guest-memfd=on
>           Fix minor typo in comment
>   [11/12] Fix up typo in g_test_skip() reason
>           Pending: Move kvm_guest_memfd_init_shared_supported() to
>             migration-util.c (Fabiano)
> 
> This patchset is also available at:
> 
>   https://github.com/amdese/qemu/commits/gmem-shared-mem-v4
> 
> and is based on top of v11.1.0

Should I just pick this up?  I'll touch up the commit log that Phil
requested.  Objections welcomed before next week.

-- 
Peter Xu


