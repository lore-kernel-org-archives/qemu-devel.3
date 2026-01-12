Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA298D2505E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 09:44:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfET0-00004z-QO; Mon, 12 Jan 2026 04:44:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vfESz-0008VZ-8P
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 04:44:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vfESx-00020d-Qp
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 04:44:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768211042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=flDfzf0/CQPBlAtFe2Zyw9+2STYvng3hxDlSiszF0ss=;
 b=iiyTEMyd03hJkH+z8D5mYo59Qg86BqF7krTNOqP83J9tblbgHBR/GpSL6ywqVRqAztNE4U
 s6WJa535WZQuoTJjjUQCrcRFY+fZDttfUh+3cmZ9Aq0eIUDcoywxgV3uc5UZfe5rSU06Lg
 HisnzRP75GzBHZbyFVArgxjN6tUIxBw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-w5zCYpl6Oeiyl0lXikt_jw-1; Mon,
 12 Jan 2026 04:44:00 -0500
X-MC-Unique: w5zCYpl6Oeiyl0lXikt_jw-1
X-Mimecast-MFC-AGG-ID: w5zCYpl6Oeiyl0lXikt_jw_1768211039
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B3DB21956094; Mon, 12 Jan 2026 09:43:58 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.56])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 982881956048; Mon, 12 Jan 2026 09:43:57 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 501E81800081; Mon, 12 Jan 2026 10:43:55 +0100 (CET)
Date: Mon, 12 Jan 2026 10:43:55 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Oliver Steffen <osteffen@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 Luigi Leonardi <leonardi@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Joerg Roedel <joerg.roedel@amd.com>, kvm@vger.kernel.org,
 Eduardo Habkost <eduardo@habkost.net>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v3 4/6] igvm: Add common function for finding parameter
 entries
Message-ID: <aWTB6UF-oh6kF14p@sirius.home.kraxel.org>
References: <20260109143413.293593-1-osteffen@redhat.com>
 <20260109143413.293593-5-osteffen@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109143413.293593-5-osteffen@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jan 09, 2026 at 03:34:11PM +0100, Oliver Steffen wrote:
> Move repeating code for finding the parameter entries in the IGVM
> backend out of the parameter handlers into a common function.
> ---
>  backends/igvm.c | 115 +++++++++++++++++++++++++-----------------------
>  1 file changed, 61 insertions(+), 54 deletions(-)
> 
> diff --git a/backends/igvm.c b/backends/igvm.c
> index dc1fd026cb..a797bd741c 100644
> --- a/backends/igvm.c
> +++ b/backends/igvm.c
> @@ -95,6 +95,18 @@ typedef struct QIgvm {
>      unsigned region_page_count;
>  } QIgvm;
>  
> +static QIgvmParameterData *qigvm_find_param_entry(QIgvm *igvm, const IGVM_VHS_PARAMETER *param) {
> +
> +    QIgvmParameterData *param_entry;
> +    QTAILQ_FOREACH(param_entry, &igvm->parameter_data, next)
> +    {
> +        if (param_entry->index == param->parameter_area_index) {
> +            return param_entry;
> +        }
> +    }
> +    return NULL;
> +}
> +
>  static int qigvm_directive_page_data(QIgvm *ctx, const uint8_t *header_data,
>                                       Error **errp);
>  static int qigvm_directive_vp_context(QIgvm *ctx, const uint8_t *header_data,
> @@ -576,57 +588,54 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
>      }
>  
>      /* Find the parameter area that should hold the memory map */
> -    QTAILQ_FOREACH(param_entry, &ctx->parameter_data, next)
> +    param_entry = qigvm_find_param_entry(ctx, param);
> +    if (param_entry != NULL)
>      {

if (param_entry == NULL) {
    // handle error if needed
    return;
}

take care,
  Gerd


