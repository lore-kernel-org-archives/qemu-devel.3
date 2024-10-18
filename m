Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DAC8D2FFE0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 09:45:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1jXS-0001FD-N4; Fri, 18 Oct 2024 05:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1jXQ-0001Ex-5q
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:44:53 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1jXN-0001r6-9T
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:44:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729244690; x=1760780690;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=t+ugeDC0dsgtzxXpHk3/PU5ZJYruZhJci/LktfE3T1I=;
 b=dcmHNfVHEAy8lN5GJg3t4UE0Qs0tKvP4WWsgFdNLDlcUE9kjSJzeNrK2
 Wf7nk6xR2YkyXpw+VtbKql91KRRvGEM+vRBmBFTYkx2a4XX5pimAzpxeo
 HY32wPb8mNo3idaov3uh2+bo+UxbYJjxqbpVdz1tk6SlAgLpbHd6vsMiH
 QFk4LkVoTl6Gy3sl7kpqGzk+8N9b3FOvqqoXCQyo6i8SSCbm9lGdZkkXQ
 RGGM+u5TWbv0ZEtCAsyah8hGDXfS4fZLymvEVSNeDEAhD1oA16gVCLZNK
 S60g7HBB2UeUUDWugK3TmYQIRZwGuhD7QIshatssmTXfPsRr7ksWhSAd+ g==;
X-CSE-ConnectionGUID: X4MMdzToQMew3m0o/5ledw==
X-CSE-MsgGUID: dro4Zh6AQnm6L6ujGsS0vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="39398361"
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; d="scan'208";a="39398361"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2024 02:44:47 -0700
X-CSE-ConnectionGUID: APsUcrwxSceQWp3vkKy7Qw==
X-CSE-MsgGUID: nHuXN+0gTmSVYHVXbehjrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; d="scan'208";a="83401673"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa005.fm.intel.com with ESMTP; 18 Oct 2024 02:44:46 -0700
Date: Fri, 18 Oct 2024 18:01:01 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 16/31] qobject: adapt to new import path for qobject
 data type headers
Message-ID: <ZxIx3SzjVXQGY/gK@intel.com>
References: <20241017113344.883424-1-berrange@redhat.com>
 <20241017113344.883424-17-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241017113344.883424-17-berrange@redhat.com>
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

On Thu, Oct 17, 2024 at 12:33:28PM +0100, Daniel P. Berrangé wrote:
> Date: Thu, 17 Oct 2024 12:33:28 +0100
> From: "Daniel P. Berrangé" <berrange@redhat.com>
> Subject: [PATCH v2 16/31] qobject: adapt to new import path for qobject
>  data type headers
> 
> The qobject data type headers have moved from qapi/qmp/ to
> qobject/.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  qobject/block-qdict.c      |  8 ++++----
>  qobject/json-parser-int.h  |  2 +-
>  qobject/json-parser.c      | 12 ++++++------
>  qobject/json-writer.c      |  2 +-
>  qobject/qbool.c            |  2 +-
>  qobject/qdict.c            | 10 +++++-----
>  qobject/qjson.c            | 16 ++++++++--------
>  qobject/qlist.c            | 10 +++++-----
>  qobject/qlit.c             | 14 +++++++-------
>  qobject/qnull.c            |  2 +-
>  qobject/qnum.c             |  2 +-
>  qobject/qobject-internal.h |  2 +-
>  qobject/qobject.c          | 12 ++++++------
>  qobject/qstring.c          |  2 +-
>  14 files changed, 48 insertions(+), 48 deletions(-)
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


