Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA9D1D2FFE0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 09:42:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1jVN-0008RW-VT; Fri, 18 Oct 2024 05:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1jVM-0008RK-Vq
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:42:44 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1jVK-0001lL-R0
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:42:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729244563; x=1760780563;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=ylrd1HDv0B5fVLz9yUYPW+bGRcGvNzIWBsTiTEr+AhU=;
 b=lL3rDJxVcA04HxYasMA4slDFAFcpLTfezDlOBOa8co3TGnV4GXygEu1W
 2tPLlEF7/hTt4jMDdZhs4uJmLaXw3nng16O5xOBcRrAgaqHa03g+4MFJZ
 v++/12nDH4L2H1ksSfXboGQeDYwUKwrahLsFpMsmbJlfW12a2PfEY1u0O
 kztMi8UdgKy7BviXlW+tDavw1+Vfep6iaSujAgbXtxZvVaJgELDGKGRqH
 4wjnKWhHk+qmM82ud70U8H87tqEHEHHn/oHZuWy8UoIlnt9VUyKW5vOQs
 8X1MZ0ruLbiEaWAp8T4ReOJ8bowYYOB64jB3imCommcILfWkTenEW06+z A==;
X-CSE-ConnectionGUID: AIckcyxhS228iEX17IWqDw==
X-CSE-MsgGUID: XnfCIV3TTHegsbCIxGVDwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28558628"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="28558628"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2024 02:42:41 -0700
X-CSE-ConnectionGUID: rtIo6a0LSce2M9u0FmWNGg==
X-CSE-MsgGUID: H0xKZcxWT9+ARWNIilLuZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; d="scan'208";a="79237251"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa007.jf.intel.com with ESMTP; 18 Oct 2024 02:42:40 -0700
Date: Fri, 18 Oct 2024 17:58:55 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 14/31] qapi: adapt to new import path for qobject data
 type headers
Message-ID: <ZxIxX0Yllx4RJ+JM@intel.com>
References: <20241017113344.883424-1-berrange@redhat.com>
 <20241017113344.883424-15-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241017113344.883424-15-berrange@redhat.com>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
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

On Thu, Oct 17, 2024 at 12:33:26PM +0100, Daniel P. Berrangé wrote:
> Date: Thu, 17 Oct 2024 12:33:26 +0100
> From: "Daniel P. Berrangé" <berrange@redhat.com>
> Subject: [PATCH v2 14/31] qapi: adapt to new import path for qobject data
>  type headers
> 
> The qobject data type headers have moved from qapi/qmp/ to
> qobject/.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  qapi/qapi-clone-visitor.c     |  2 +-
>  qapi/qapi-dealloc-visitor.c   |  2 +-
>  qapi/qapi-forward-visitor.c   | 14 +++++++-------
>  qapi/qmp-dispatch.c           |  8 ++++----
>  qapi/qmp-event.c              |  6 +++---
>  qapi/qmp-registry.c           |  2 +-
>  qapi/qobject-input-visitor.c  | 14 +++++++-------
>  qapi/qobject-output-visitor.c | 12 ++++++------
>  qapi/string-input-visitor.c   |  2 +-
>  9 files changed, 31 insertions(+), 31 deletions(-)
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


