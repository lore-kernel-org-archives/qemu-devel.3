Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC9FC83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 06:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXDok-0005ze-Uf; Thu, 03 Jul 2025 02:53:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXDof-0005zI-RZ
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 02:53:06 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXDoe-0005ev-1T
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 02:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751525584; x=1783061584;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=Jnf1h1p21hN+dzV5ohwpjGa2cjqFe8yrNqCDkV6dgX8=;
 b=gWrjg87bnB3IyPvmnANmwshFCaEkFiLhfehdIeXfEWL8ZAJiNGzSgAqK
 99lv4XVgp9LiwL+a2Uua/jW0qhpSDe6uzIeXWWh1X3e/1BqzIwaWqor5o
 cS3JS/VlM7qAGNN1Xumckb9KOv1gR7q8Bbnog6hueUPWg5ZFo537rHF0X
 go3OJXEfajxUHHCoEUDNUxeFUAdE5p7ZrRRakf2wOFBYRAOvBDk3h8Gcb
 iptl5DFDfeIe/mDi48v9vNHjuL13OH6/YcRz7uo5m2AIAjwsUUJc+maOU
 Sq5ATlvOgXkR5LGz+JCVQ7WIOwyIVnMUNz0ONMWQZK+OTZ2q4ItDkeubi w==;
X-CSE-ConnectionGUID: UqjeNZ35Q9eiXcadVmd1cw==
X-CSE-MsgGUID: iXp7I6LeR8OdD06a3Zkw5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="52957467"
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="52957467"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 23:53:00 -0700
X-CSE-ConnectionGUID: 1phJ5Fj5SiCMo1lSEIhpaw==
X-CSE-MsgGUID: ydQRnj77QMG60r+3x9N48Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="158563616"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 02 Jul 2025 23:52:58 -0700
Date: Thu, 3 Jul 2025 15:14:24 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3 26/68] accel/tcg: Implement get_[vcpu]_stats()
Message-ID: <aGYt0DyMsPapzGQh@intel.com>
References: <20250701144017.43487-1-philmd@linaro.org>
 <20250701144017.43487-27-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250701144017.43487-27-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi Philippe,

On Tue, Jul 01, 2025 at 04:39:34PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Tue,  1 Jul 2025 16:39:34 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v3 26/68] accel/tcg: Implement get_[vcpu]_stats()
> X-Mailer: git-send-email 2.49.0
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/tcg/tcg-all.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
> index ae83ca0bd10..d49d2b3b0fa 100644
> --- a/accel/tcg/tcg-all.c
> +++ b/accel/tcg/tcg-all.c
> @@ -239,11 +239,17 @@ static int tcg_gdbstub_supported_sstep_flags(AccelState *as)
>      }
>  }
>  
> +static void tcg_get_stats(AccelState *as, GString *buf)
> +{
> +    tcg_dump_flush_info(buf);
> +}

With:

./configure
make -j

I met this error:

/usr/bin/ld: libuser.a.p/accel_tcg_tcg-all.c.o: in function `tcg_get_stats':
/qemu/build/../accel/tcg/tcg-all.c:244: undefined reference to `tcg_dump_flush_info'

It seems tcg_dump_flush_info() needs a stub?

Thanks,
Zhao

>  static void tcg_accel_class_init(ObjectClass *oc, const void *data)
>  {
>      AccelClass *ac = ACCEL_CLASS(oc);
>      ac->name = "tcg";
>      ac->init_machine = tcg_init_machine;
> +    ac->get_stats = tcg_get_stats;
>      ac->allowed = &tcg_allowed;
>      ac->supports_guest_debug = tcg_supports_guest_debug;
>      ac->gdbstub_supported_sstep_flags = tcg_gdbstub_supported_sstep_flags;
> -- 
> 2.49.0
> 
> 

