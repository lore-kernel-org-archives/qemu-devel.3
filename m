Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931A6D2FFE0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 09:35:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1jOT-0002W3-Fv; Fri, 18 Oct 2024 05:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1jOR-0002Vn-1n
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:35:35 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1jOP-00018S-HS
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:35:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729244133; x=1760780133;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=GyQyKdl8DBqmOpeehn4D3NAth8+WLToQSgid+lb27u8=;
 b=C2OkIifsxAEjotqbL1nFC0H2P9OLvp2Ztd8g6gNDde4DctNiQ1Hta9bd
 QuYNyC2Oo90oPc1A7hqxZlxG3ZiKhP+eVut+AqLleY3Gq5IvywnhEjJA7
 o2lA9gSsJ++SJxTnekOs2d1cAK0TtGc9w2qG9wfNBZa3h+JsuA2CWqwZh
 ndDUp3nodwo+Od1IPFqSnm/cbS0RQqSZL9YEe1savP7byF52eZhW4WzNf
 UtCKj+VeNlaBBaMh2HbY4/3EDTNqbF35cKV2wB/Bgnow3wvBf89QiQ4KR
 Wxpp0zZmAxzHSftp47EHuCtXu8SGBGhlExt0lG4q7flEUFN/NAtiCnDTD A==;
X-CSE-ConnectionGUID: laVYzP04SH+5I9PFIp2pTA==
X-CSE-MsgGUID: 7HuG91FXTuOeZi3gZNWu3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="54180716"
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; d="scan'208";a="54180716"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2024 02:35:31 -0700
X-CSE-ConnectionGUID: /qmzKaNISfyiMyTUlLa0ng==
X-CSE-MsgGUID: z8u3eq2YTneQYh6sgsCJag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; d="scan'208";a="78832356"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 18 Oct 2024 02:35:31 -0700
Date: Fri, 18 Oct 2024 17:51:45 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 05/31] backends: adapt to new import path for qobject
 data type headers
Message-ID: <ZxIvsRSp7voYF58w@intel.com>
References: <20241017113344.883424-1-berrange@redhat.com>
 <20241017113344.883424-6-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241017113344.883424-6-berrange@redhat.com>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
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

On Thu, Oct 17, 2024 at 12:33:17PM +0100, Daniel P. Berrangé wrote:
> Date: Thu, 17 Oct 2024 12:33:17 +0100
> From: "Daniel P. Berrangé" <berrange@redhat.com>
> Subject: [PATCH v2 05/31] backends: adapt to new import path for qobject
>  data type headers
> 
> The qobject data type headers have moved from qapi/qmp/ to
> qobject/.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  backends/cryptodev-hmp-cmds.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


