Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A10C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 02:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkE78-0005Fo-2p; Tue, 12 Mar 2024 22:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rkE75-0005FC-2g; Tue, 12 Mar 2024 22:13:03 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rkE72-00005t-Kz; Tue, 12 Mar 2024 22:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710295981; x=1741831981;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=v38YNtJy/YG6uK8903FNNbXlOx4a9Ia/xHQiui7fk2Q=;
 b=BRPssKraj9vpkocw/J4nrVdNi40E0nZQi9p7nJuhiR1XJhRsW4tJkZDK
 uHWeBA6VNi3QroqOSBuQ7lSOpdolWBD2MhpC1Swaq7tb53HTGlWPLwiS4
 Ay7xzN6NaTt9kW3yc5zgmvvzt3ibqHIP6AqnYAgmSDMAkCZLhC50CU3oS
 VKnXR/k+K8ikEumZi9LoLj/hiOKUBvZ1rYwOHj/1BXbr5/ZEq+VxKk/LT
 MMQyvczRPZFRtXJut0lbFTjtZTlJ53XhjRJzQ8nwNmL04c0OTCcObus1Z
 2PV9PvysyG+qtvsQUeHo0QdwVsJeYzPOSQrrCV2CafMetGuLdx09SwiUK Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="4905912"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="4905912"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2024 19:12:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; d="scan'208";a="11644382"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 12 Mar 2024 19:12:54 -0700
Date: Wed, 13 Mar 2024 10:26:43 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org
Subject: Re: [PULL 36/68] hw/misc/xlnx-versal-trng: Check returned bool in
 trng_prop_fault_event_set()
Message-ID: <ZfEO4xhZwgyrWk8M@intel.com>
References: <cover.1710282274.git.mst@redhat.com>
 <305446015848f0b5d71b817b53e7e02b08c36ede.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <305446015848f0b5d71b817b53e7e02b08c36ede.1710282274.git.mst@redhat.com>
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Michael,

Thanks a lot and aslo this one, I forgot to update the status :/,
this patch has been merged (commit 1e0efa9735635,
"hw/misc/xlnx-versal-trng: Check returned bool in
trng_prop_fault_event_set()"). Sorry to make you
repeat the merge.

Best Regards,
Zhao


On Tue, Mar 12, 2024 at 06:27:22PM -0400, Michael S. Tsirkin wrote:
> Date: Tue, 12 Mar 2024 18:27:22 -0400
> From: "Michael S. Tsirkin" <mst@redhat.com>
> Subject: [PULL 36/68] hw/misc/xlnx-versal-trng: Check returned bool in
>  trng_prop_fault_event_set()
> X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
> 
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> As the comment in qapi/error, dereferencing @errp requires
> ERRP_GUARD():
> 
> * = Why, when and how to use ERRP_GUARD() =
> *
> * Without ERRP_GUARD(), use of the @errp parameter is restricted:
> * - It must not be dereferenced, because it may be null.
> ...
> * ERRP_GUARD() lifts these restrictions.
> *
> * To use ERRP_GUARD(), add it right at the beginning of the function.
> * @errp can then be used without worrying about the argument being
> * NULL or &error_fatal.
> *
> * Using it when it's not needed is safe, but please avoid cluttering
> * the source with useless code.
> 
> But in trng_prop_fault_event_set, @errp is dereferenced without
> ERRP_GUARD():
> 
> visit_type_uint32(v, name, events, errp);
> if (*errp) {
>     return;
> }
> 
> Currently, since trng_prop_fault_event_set() doesn't get the NULL @errp
> parameter as a "set" method of object property, it hasn't triggered the
> bug that dereferencing the NULL @errp.
> 
> And since visit_type_uint32() returns bool, check the returned bool
> directly instead of dereferencing @errp, then we needn't the add missing
> ERRP_GUARD().
> 
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> Message-Id: <20240223085653.1255438-5-zhao1.liu@linux.intel.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/misc/xlnx-versal-trng.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/hw/misc/xlnx-versal-trng.c b/hw/misc/xlnx-versal-trng.c
> index b8111b8b66..6495188dc7 100644
> --- a/hw/misc/xlnx-versal-trng.c
> +++ b/hw/misc/xlnx-versal-trng.c
> @@ -644,8 +644,7 @@ static void trng_prop_fault_event_set(Object *obj, Visitor *v,
>      Property *prop = opaque;
>      uint32_t *events = object_field_prop_ptr(obj, prop);
>  
> -    visit_type_uint32(v, name, events, errp);
> -    if (*errp) {
> +    if (!visit_type_uint32(v, name, events, errp)) {
>          return;
>      }
>  
> -- 
> MST
> 

