Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86FC2D2FFE1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 09:47:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1jZZ-0003pU-MO; Fri, 18 Oct 2024 05:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1jZW-0003nI-P3
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:47:02 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1jZR-0002Dv-K9
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729244817; x=1760780817;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=TdCRYriQGL2ze7PaTeD1CZVUfvmf8JwXiL7On7FzRHk=;
 b=EZgDR92klV0n+Jinx3ZapNIUa5L2kIgfpWCb2+bwOBwet+2/6m/bhOA4
 N51XkemH8N5/vbF5u+wxcDvvbMZWA/n8NgcJ0LLpek9FBFZ5FLvBXgn7B
 A/aIJnk+Xpy+eHC+7KtuSNob2tFyo57CSa6mMTv8dYCqGFA9kFNTv51e2
 gPAyLLjr2sXgZ+/S8gw/FAmtKglQUEqibhclS/WSFiC+0zgOy6/JGwMMe
 WiSofJ8uxcbLJW6UO8dwLBe2PyrOpj/unMSpqRIDm6/clP+GrfiRnDspr
 6pSlyacjUwG3ejRAADFfO/QiFPwqm7uh1WVatRQI5uBTcfHneG5HP4S1p A==;
X-CSE-ConnectionGUID: TOVC4ubtSmughLNvtgQMMw==
X-CSE-MsgGUID: ee1TkTtqRa2kGrn3YKKhLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="39398615"
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; d="scan'208";a="39398615"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2024 02:46:56 -0700
X-CSE-ConnectionGUID: yRdmgDnUQC+uMGM1d6L2eQ==
X-CSE-MsgGUID: q16Q4e6OSYiUf3Bm98KuSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; d="scan'208";a="83402126"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa005.fm.intel.com with ESMTP; 18 Oct 2024 02:46:55 -0700
Date: Fri, 18 Oct 2024 18:03:10 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 21/31] stats: adapt to new import path for qobject
 data type headers
Message-ID: <ZxIyXpxKMAUp9Qxh@intel.com>
References: <20241017113344.883424-1-berrange@redhat.com>
 <20241017113344.883424-22-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241017113344.883424-22-berrange@redhat.com>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
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

On Thu, Oct 17, 2024 at 12:33:33PM +0100, Daniel P. Berrangé wrote:
> Date: Thu, 17 Oct 2024 12:33:33 +0100
> From: "Daniel P. Berrangé" <berrange@redhat.com>
> Subject: [PATCH v2 21/31] stats: adapt to new import path for qobject data
>  type headers
> 
> The qobject data type headers have moved from qapi/qmp/ to
> qobject/.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  stats/stats-hmp-cmds.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


