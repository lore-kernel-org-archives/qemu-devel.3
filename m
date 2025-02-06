Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64427C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 10:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfyoI-0008E0-76; Thu, 06 Feb 2025 05:08:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tfyoA-0008CN-Pj; Thu, 06 Feb 2025 05:08:31 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tfyo7-0001lM-Ae; Thu, 06 Feb 2025 05:08:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738836507; x=1770372507;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=oP0y8I2b0k86JdcYw9jox2qnw26MXTvDoDpMb9y/Ax4=;
 b=AuJN5K6d4ga3UGvFjOeugAV4SfZo+3Ev3kD04Bc84eSSkE9hE+Gf7Iqk
 ytTjMyMI/8uI9rLV8Qn8/qBcPm47Ovcx2X8XRIRzC2oWp1vNnqn6uhTbs
 xoneDfBPDBjA90ACY9iKyuDimvuFTzVSiuPKqkhW2Y5rqzvQZUOkxOKQo
 QTKLS244Z7Mwqci1SrgK81XMgZbHikF4/40sxFcB+RgB6wmGlC5c/1kk+
 0W8WbuyRez7pZBVajnAl+M1atW/i5SwssAMHy7TMJTyyoDI6nYBvqt3ji
 gQ67+2aDYGzOoGEKOvXIjN4d5sQZie7Z5O7DwNW6vHmOlGJCM6BspqxEF w==;
X-CSE-ConnectionGUID: UxU7t8J2QDGOzamvirjPmw==
X-CSE-MsgGUID: xUVPm0e8Q+GjMXlM3rN5jg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43187318"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="43187318"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2025 02:08:23 -0800
X-CSE-ConnectionGUID: na8BE7FXTjK8oidnTjBbzw==
X-CSE-MsgGUID: twhacpdTQ+mS2Rq1hHFoAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="111744739"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 06 Feb 2025 02:08:19 -0800
Date: Thu, 6 Feb 2025 18:27:48 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5n77+9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Shaoqin Huang <shahuang@redhat.com>, Eric Auger <eauger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sebastian Ott <sebott@redhat.com>, Gavin Shan <gshan@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Yi Lai <yi1.lai@intel.com>
Subject: Re: [RFC v2 1/5] qapi/qom: Introduce kvm-pmu-filter object
Message-ID: <Z6SOpEcLjNW5NpFy@intel.com>
References: <20250122090517.294083-1-zhao1.liu@intel.com>
 <20250122090517.294083-2-zhao1.liu@intel.com>
 <871pwc3dyw.fsf@pond.sub.org> <Z6SMxlWhHgronott@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6SMxlWhHgronott@intel.com>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> > > @@ -1183,6 +1185,7 @@
> > >                                        'if': 'CONFIG_LINUX' },
> > >        'iommufd':                    'IOMMUFDProperties',
> > >        'iothread':                   'IothreadProperties',
> > > +      'kvm-pmu-filter':             'KVMPMUFilterPropertyVariant',
> > 
> > The others are like
> > 
> >          'mumble': 'MumbleProperties'
> > 
> > Let's stick to that, and also avoid running together multiple
> > capitalized acronyms: KvmPmuFilterProperties.
> 
> IIUC, then I should use the name "KvmPmuFilterProperties" (string version
> for QAPI), and the name "KvmPmuFilterPropertiesVariant" (numeric version
> in codes), do you agree?
>  

Thanks to Daniel's feedback, pmu filter doesn't need the string version
anymore. So there's only 1 "KvmPmuFilterProperties" structure in QAPI.


