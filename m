Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE242D2FFE0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 09:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1jZF-0003bY-Ck; Fri, 18 Oct 2024 05:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1jZD-0003WC-7i
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:46:43 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1jZB-0002CS-2B
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729244801; x=1760780801;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=kJMgfm6qzdm6/+u8juIOnObNNCxgtFq1Q44oN98iZMM=;
 b=RfBde+wCAiWq3CCg/FsrXiw/IDBrH8E+yD70MuCBnuV7sauLv2sNjqjE
 PAME2NSBHvmss+n5giycavojAiMh1gyYWg7ut4yfR7IzITqQUOdkRlK05
 wI7pN+Vcx9UpJ9HFRBIvMCmAPOaUM+qZIMxdoFmd7Ue1LJPlXxQswpNwN
 piVClfQcm3pCqeqgm0ceX+h7wFTemAmh7d1NUixzq95Wbcmw+emVAcxPx
 ozeQLCyfoAd+FN5KPcVAUjRNrI/0aUrRsxHgdEZBuGwX4SOSN/xDrai++
 Uk9yZMqg0S9IZuct+rrJZvjYxDTowvlCBDrPRHnArZsw6MpdV8gcVxVnw g==;
X-CSE-ConnectionGUID: r+Hc2HlDSTCeqtLSh6YYDg==
X-CSE-MsgGUID: POElDJR0QR27X5bc0mhkvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28862114"
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; d="scan'208";a="28862114"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2024 02:46:40 -0700
X-CSE-ConnectionGUID: 363BtQecTtOt7464O9kySg==
X-CSE-MsgGUID: pw8eNM7TTQycWj87hinCqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; d="scan'208";a="79629356"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa008.jf.intel.com with ESMTP; 18 Oct 2024 02:46:38 -0700
Date: Fri, 18 Oct 2024 18:02:53 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 20/31] scsi: adapt to new import path for qobject data
 type headers
Message-ID: <ZxIyTa6pk06ReiLU@intel.com>
References: <20241017113344.883424-1-berrange@redhat.com>
 <20241017113344.883424-21-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241017113344.883424-21-berrange@redhat.com>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
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

On Thu, Oct 17, 2024 at 12:33:32PM +0100, Daniel P. Berrangé wrote:
> Date: Thu, 17 Oct 2024 12:33:32 +0100
> From: "Daniel P. Berrangé" <berrange@redhat.com>
> Subject: [PATCH v2 20/31] scsi: adapt to new import path for qobject data
>  type headers
> 
> The qobject data type headers have moved from qapi/qmp/ to
> qobject/.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  scsi/qemu-pr-helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


