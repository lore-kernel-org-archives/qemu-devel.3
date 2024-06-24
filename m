Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3570C2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 08:37:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLfBc-0006bX-ID; Mon, 24 Jun 2024 04:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sLfBZ-0006bL-Vf
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 04:36:26 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sLfBW-0005fN-6n
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 04:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719218182; x=1750754182;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=y7E5P8y0OutV0LXtH5PDqcJH/gl2g2S4MTBuCD7Ew6w=;
 b=aD4DQI5Ghj1FQSlnpu8qQwus+rmP9UOMDXpDO5aMY2qPLe8DvDDVwizW
 NC8sOtxM1F/ousvZNbCyGE+0RRN1NvyZoecf/e9ueF8Egb2nJk5/Ni2tU
 RKeviW9oWhiXAiiIAYdYO4a815klVEVSOLLRqyyUR14VJjseUEtVv6Lcz
 tWtoe2W1EUKub9x/ijcHElBKYFj31G6KKNfCgMH2oZ2x6/NepWuwDYA17
 GPahVM+Z6tVxQqL26acHX38GqC2eV0rhCuYehwMwRcNhUZWyqvIUibdjw
 PIxMB3tjgVGS0oyzhg3e0K0K8JnDTYpTWOJ6sbyC90kb9qJZGZba1JQUJ w==;
X-CSE-ConnectionGUID: KTAuwimuSyelXILssseXZQ==
X-CSE-MsgGUID: 3RI+AlEeT5eJduIvs8/5fQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="16054795"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; d="scan'208";a="16054795"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2024 01:36:18 -0700
X-CSE-ConnectionGUID: /gC6NGrvQ1G+DnwO2D2I0A==
X-CSE-MsgGUID: ENkbAMvPRmqpV5Pr96QSSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; d="scan'208";a="66459776"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 24 Jun 2024 01:36:14 -0700
Date: Mon, 24 Jun 2024 16:51:48 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: Re: [RFC PATCH v3 1/5] build-sys: Add rust feature option
Message-ID: <ZnkzpBUQMMGTgQlL@intel.com>
References: <rust-pl011-rfc-v3.git.manos.pitsidianakis@linaro.org>
 <e74803e6b570ab36ebc538dd84dc7c4bc2fbe4e7.1718827153.git.manos.pitsidianakis@linaro.org>
 <ae1397b5-4154-4aeb-bf5f-3a62adcc05fd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae1397b5-4154-4aeb-bf5f-3a62adcc05fd@redhat.com>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
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

[snip]

> diff --git a/meson.build b/meson.build
> index c5360fbd299..ad7dbc0d641 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -290,6 +290,11 @@ foreach lang : all_languages
>    endif
>  endforeach
> +cargo = not_found
> +if 'RUST_TARGET_TRIPLE' in config_host
> +  cargo = find_program('cargo', required: true)
> +endif
> +

As with the original Manos version, it looks like there's no need to
check cargo here? Since patch 2 checks cargo and others in rust/meson.build.

Otherwise, cargo was checked twice.

>  # default flags for all hosts
>  # We use -fwrapv to tell the compiler that we require a C dialect where
>  # left shift of signed integers is well defined and has the expected
> @@ -4239,6 +4244,10 @@ if 'objc' in all_languages
>  else
>    summary_info += {'Objective-C compiler': false}
>  endif
> +summary_info += {'Rust support':      cargo.found()}
> +if cargo.found() and config_host['RUST_TARGET_TRIPLE']) != config_host['RUST_HOST_TRIPLE']
> +  summary_info += {'Rust target':     config_host['RUST_TARGET_TRIPLE']}
> +endif
>  option_cflags = (get_option('debug') ? ['-g'] : [])
>  if get_option('optimization') != 'plain'
>    option_cflags += ['-O' + get_option('optimization')]
> 
> 

