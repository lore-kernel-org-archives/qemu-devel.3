Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C4BC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 07:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxiIS-0000bb-6f; Fri, 19 Apr 2024 03:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rxiIO-0000bG-MD; Fri, 19 Apr 2024 03:04:29 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rxiIL-0004hI-C5; Fri, 19 Apr 2024 03:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713510266; x=1745046266;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=1o5StPG0H7u78CJDbdVWPonhMnUZscV0l0Iu/eFYpKQ=;
 b=mftt9wN5pAFTKpn3H0SbH0ZFAGajnR5awbrZvw23ihjubpa7VaimjmKY
 XA8MjWn1DIBNkrD8/vmIV6v3W/GdLjjL7NT8QwfpJrPTfNjDoeeqU/m40
 XE8l92kIjpVnZpPS2bVUlVWv6axtLWDEdqj1ngPIzI36ZBBZ6aKS/RwGe
 fiXX7OpKnofAB+ZZw32dNCz1UUzYf35Gy+89cNdHVXURl+8KT3npAenBc
 Tv2vXP5ONASxL9xdNV5ZtRfRnqusS0/qlumvvl9p3rjqYdCKnzSmSsWK8
 jA0yc2u4r223v1HGBJJdBpIvv5cdvxC2r4xWaHlVOaP0Ik2s/OVEJSwAw w==;
X-CSE-ConnectionGUID: E/wsrY5zTpGdVS3ueLhe/Q==
X-CSE-MsgGUID: j2aDNSCIQTCFsXsXjZQC8g==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="8958346"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="8958346"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Apr 2024 00:04:21 -0700
X-CSE-ConnectionGUID: AFVrgFvmQyepcNnhhljJ5w==
X-CSE-MsgGUID: QxyfoaOqQ0qTgMQPp0eYyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; d="scan'208";a="28027095"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa005.jf.intel.com with ESMTP; 19 Apr 2024 00:04:17 -0700
Date: Fri, 19 Apr 2024 15:18:22 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 3/6] target/s390x/cpu_models: Make
 kvm_s390_get_host_cpu_model() return boolean
Message-ID: <ZiIavtfC1X/ul18B@intel.com>
References: <20240419065712.1225038-1-zhao1.liu@linux.intel.com>
 <20240419065712.1225038-4-zhao1.liu@linux.intel.com>
 <61dca21b-576f-40d0-a155-e52111acb45a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61dca21b-576f-40d0-a155-e52111acb45a@linaro.org>
Received-SPF: none client-ip=192.198.163.18;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.067,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

> > diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> > index 052540a866ac..a0e4acb707d7 100644
> > --- a/target/s390x/cpu_models.c
> > +++ b/target/s390x/cpu_models.c
> > @@ -560,16 +560,15 @@ S390CPUModel *get_max_cpu_model(Error **errp)
> >       }
> >       if (kvm_enabled()) {
> 
> Nitpicking, we could move @err declaration here:
> 
>           Error *err = NULL;

Yeah! Next patch removes this variable completely, so I think it's OK
not to move. ;-)

Thanks,
Zhao

> > -        kvm_s390_get_host_cpu_model(&max_model, &err);
> > +        if (!kvm_s390_get_host_cpu_model(&max_model, &err)) {
> > +            error_propagate(errp, err);
> > +            return NULL;
> > +        }
> >       } else {
> >           max_model.def = s390_find_cpu_def(QEMU_MAX_CPU_TYPE, QEMU_MAX_CPU_GEN,
> >                                             QEMU_MAX_CPU_EC_GA, NULL);
> >           bitmap_copy(max_model.features, qemu_max_cpu_feat, S390_FEAT_MAX);
> >       }
> > -    if (err) {
> > -        error_propagate(errp, err);
> > -        return NULL;
> > -    }
> >       cached = true;
> >       return &max_model;
> >   }
> 

