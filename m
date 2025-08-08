Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED14AC87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 10:46:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukKau-0007bf-0O; Fri, 08 Aug 2025 06:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ukKar-0007Zy-Td
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 06:45:01 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ukKao-0003dB-61
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 06:45:01 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bz0sd1yXpz6GD6h;
 Fri,  8 Aug 2025 18:40:05 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id D76FD14038F;
 Fri,  8 Aug 2025 18:44:43 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 8 Aug
 2025 12:44:43 +0200
Date: Fri, 8 Aug 2025 11:44:42 +0100
To: Markus Armbruster <armbru@redhat.com>
CC: <qemu-devel@nongnu.org>, <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 03/12] hw/cxl: Convert cxl_fmws_link() to Error
Message-ID: <20250808114442.0000234d@huawei.com>
In-Reply-To: <20250808080823.2638861-4-armbru@redhat.com>
References: <20250808080823.2638861-1-armbru@redhat.com>
 <20250808080823.2638861-4-armbru@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri,  8 Aug 2025 10:08:14 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Functions that use an Error **errp parameter to return errors should
> not also report them to the user, because reporting is the caller's
> job.  When the caller does, the error is reported twice.  When it
> doesn't (because it recovered from the error), there is no error to
> report, i.e. the report is bogus.
> 
> cxl_fmws_link_targets() violates this principle: it calls
> error_setg(&error_fatal, ...) via cxl_fmws_link().  Goes back to
> commit 584f722eb3ab (hw/cxl: Make the CXL fixed memory windows
> devices.)  Currently harmless, because cxl_fmws_link_targets()'s
> callers always pass &error_fatal.  Clean this up by converting
> cxl_fmws_link() to Error.

Patch is definitely an improvement though I'm no sure how
it is really a violation of the above principle given
it has no effect on being called twice for example.

> 
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

The -1 return is perhaps unrelated to the main thing here,
but does make more sense than return 1 so fair enough.

None of the above comments I've raised are that important to me though.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


> ---
>  hw/cxl/cxl-host.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> index 5c2ce25a19..0d891c651d 100644
> --- a/hw/cxl/cxl-host.c
> +++ b/hw/cxl/cxl-host.c
> @@ -72,6 +72,7 @@ static void cxl_fixed_memory_window_config(CXLFixedMemoryWindowOptions *object,
>  
>  static int cxl_fmws_link(Object *obj, void *opaque)
>  {
> +    Error **errp = opaque;
>      struct CXLFixedWindow *fw;
>      int i;
>  
> @@ -87,9 +88,9 @@ static int cxl_fmws_link(Object *obj, void *opaque)
>          o = object_resolve_path_type(fw->targets[i], TYPE_PXB_CXL_DEV,
>                                       &ambig);
>          if (!o) {
> -            error_setg(&error_fatal, "Could not resolve CXLFM target %s",
> +            error_setg(errp, "Could not resolve CXLFM target %s",
>                         fw->targets[i]);
> -            return 1;
> +            return -1;
>          }
>          fw->target_hbs[i] = PXB_CXL_DEV(o);
>      }
> @@ -99,7 +100,7 @@ static int cxl_fmws_link(Object *obj, void *opaque)
>  void cxl_fmws_link_targets(Error **errp)
>  {
>      /* Order doesn't matter for this, so no need to build list */
> -    object_child_foreach_recursive(object_get_root(), cxl_fmws_link, NULL);
> +    object_child_foreach_recursive(object_get_root(), cxl_fmws_link, errp);
>  }
>  
>  static bool cxl_hdm_find_target(uint32_t *cache_mem, hwaddr addr,


