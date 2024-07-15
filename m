Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BD5C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 09:55:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTIPx-00043f-3I; Mon, 15 Jul 2024 05:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTIPu-0003xD-Qh; Mon, 15 Jul 2024 05:54:46 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTIPs-00081A-UM; Mon, 15 Jul 2024 05:54:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721037285; x=1752573285;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=LapDANChhrEqCXMS7GYF4vmGDux79W3PxBHvfqK5iZo=;
 b=VKbR+Zed2b9XuzXdUGIzFQrG1v+Wdh1UE32jhg7QnMjs9GaHoA1WhsoX
 k4OINx7SvrgJDyp8aktILQOglDTHl4fzTucNrxGv8L07+7CsP35O6r7KF
 UFanIP2eeyYgTOi+XS7TuwWbvKARGFlACVKrq0/RwD+zW4ZVAca8JlEL+
 L2Vdehgsct9O3mOmIgeDppcp3BphqTwP0mTB6d6doIZHXw5pvqhdhgpoL
 wd1UXBnIAY8n19zRoi2FVCTt0LxOeRPJm50nl/cWAqIUcSu4efHBLo39J
 RL+qoPUI2utev73HnQ5kbA55Djn+REyBYmH2aztIERDvjXCQ8Ia7AE2EY A==;
X-CSE-ConnectionGUID: exmnF7G9TvKuvCM3LIrMBg==
X-CSE-MsgGUID: y3O1eufAQHq1ErL3gdqIpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="18219405"
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; d="scan'208";a="18219405"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2024 02:54:41 -0700
X-CSE-ConnectionGUID: /vG4t8zoS/2CedoHMhkKKg==
X-CSE-MsgGUID: 8nvzbuioRyGaHXmbpnUg0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; d="scan'208";a="54743486"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa004.jf.intel.com with ESMTP; 15 Jul 2024 02:54:38 -0700
Date: Mon, 15 Jul 2024 18:10:19 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Laurent Vivier <laurent@vivier.eu>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Amit Shah <amit@kernel.org>
Subject: Re: [PATCH 7/7] backends/rng-random: Get rid of qemu_open_old()
Message-ID: <ZpT1iy5NPqwjqaLB@intel.com>
References: <20240715082155.28771-1-zhao1.liu@intel.com>
 <20240715082155.28771-8-zhao1.liu@intel.com>
 <01245850-b5df-4bf6-9a22-775d12fc07a0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01245850-b5df-4bf6-9a22-775d12fc07a0@linaro.org>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jul 15, 2024 at 11:46:54AM +0200, Philippe Mathieu-Daudé wrote:
> Date: Mon, 15 Jul 2024 11:46:54 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: Re: [PATCH 7/7] backends/rng-random: Get rid of qemu_open_old()
> 
> On 15/7/24 10:21, Zhao Liu wrote:
> > For qemu_open_old(), osdep.h said:
> > 
> > > Don't introduce new usage of this function, prefer the following
> > > qemu_open/qemu_create that take an "Error **errp".
> > 
> > So replace qemu_open_old() with qemu_open(). And considering
> > rng_random_opened() will lose its obvious error handling case after
> > removing error_setg_file_open(), add comment to remind here.
> > 
> > Cc: Laurent Vivier <lvivier@redhat.com>
> > Cc: Amit Shah <amit@kernel.org>
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> >   backends/rng-random.c | 9 +++++----
> >   1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/backends/rng-random.c b/backends/rng-random.c
> > index 80eb5be138ce..3cdb982533b5 100644
> > --- a/backends/rng-random.c
> > +++ b/backends/rng-random.c
> > @@ -75,10 +75,11 @@ static void rng_random_opened(RngBackend *b, Error **errp)
> >           error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> >                      "filename", "a valid filename");
> >       } else {
> > -        s->fd = qemu_open_old(s->filename, O_RDONLY | O_NONBLOCK);
> > -        if (s->fd == -1) {
> > -            error_setg_file_open(errp, errno, s->filename);
> > -        }
> > +        /*
> > +         * Once the open fails, the error message is integrated into
> > +         * the *errp object by qemu_open().
> > +         */
> 
> IMHO this comment is superfluous, I'd drop it, otherwise:
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>

Thanks Philippe! I'll wait patch 1's comment, after that I can post a
new version with the change you mentioned.



