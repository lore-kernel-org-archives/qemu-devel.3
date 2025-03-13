Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEFCCC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 11:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsgns-0005Iy-Bn; Thu, 13 Mar 2025 07:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1tsgnh-0005Hn-NR
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 07:32:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1tsgnZ-0003o7-Vv
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 07:32:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741865536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LN8cSgwH85nFXJ9upMoUeBi7cWBH3mB+8CHjsCJYtwk=;
 b=BT7w9Ck8lyFIaG3nAkGSN4q+kxA/1MlTxfOXSUMH794D3BJZ2K/qas+x3vH2vkveE0X+en
 BCd9t4fo8wutdxlC+rUSZyzxPGfbEvl/Z+Ex+GXWh26OPuIcDoWZvbybagcwZgeHbUdRiY
 JCOZOfBydAQsXx2ajcbc0iPCFttTtDw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-TuFYrXUdOHSVy73BS7wAwg-1; Thu,
 13 Mar 2025 07:32:15 -0400
X-MC-Unique: TuFYrXUdOHSVy73BS7wAwg-1
X-Mimecast-MFC-AGG-ID: TuFYrXUdOHSVy73BS7wAwg_1741865534
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F36819560AE
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 11:32:14 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.45.242.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C77D1955BCB; Thu, 13 Mar 2025 11:32:11 +0000 (UTC)
Date: Thu, 13 Mar 2025 12:32:08 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/uefi: flush variable store to disk in post load
Message-ID: <Z9LCOFcHU53a0rJA@angien.pipo.sk>
References: <20250313104119.2084313-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313104119.2084313-1-kraxel@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

On Thu, Mar 13, 2025 at 11:41:19 +0100, Gerd Hoffmann wrote:
> Makes live migration more robust.  Commit 4c0cfc72b31a ("pflash_cfi01:
> write flash contents to bdrv on incoming migration") elaborates in
> detail on the motivation.
> 
> Cc: Peter Krempa <pkrempa@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---

Thanks!

>  hw/uefi/var-service-core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/uefi/var-service-core.c b/hw/uefi/var-service-core.c
> index 8ed8378ab991..4836a0cb8116 100644
> --- a/hw/uefi/var-service-core.c
> +++ b/hw/uefi/var-service-core.c
> @@ -29,6 +29,7 @@ static int uefi_vars_post_load(void *opaque, int version_id)
>      uefi_vars_state *uv = opaque;
>  
>      uefi_vars_update_storage(uv);
> +    uefi_vars_json_save(uv);
>      uv->buffer = g_malloc(uv->buf_size);
>      return 0;
>  }
> -- 
> 2.48.1
> 

Reviewed-by: Peter Krempa <pkrempa@redhat.com>


