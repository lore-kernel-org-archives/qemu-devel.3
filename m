Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0420CD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 11:57:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSvph-0003YA-EY; Fri, 29 May 2026 07:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1wSvpe-0003XT-9C; Fri, 29 May 2026 07:56:55 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1wSvpc-0001lG-GY; Fri, 29 May 2026 07:56:54 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DD9B9600BB;
 Fri, 29 May 2026 11:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA93E1F00898;
 Fri, 29 May 2026 11:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780055810;
 bh=z1IBhTj2fC32OmbgClDlMH1jqzxWhx412T0SOUjDlJE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=jsoYkbtxvhcISpA3sbIqo/sT4nsRWj4Yj3SbJCswAZlNa1RUNSESBuFOcX0OMM5nw
 6bubrRbBo7OdroBWMq2h0ayIgDHF8fQdzh8ou0EFI5sEhKL+KsYgdKT+DfHqnONanG
 Do8XA8p4SHnV73Ia398MzUsHMWb4GWF6kKr27Tnr7gJwaImnAETTjQgW21yFeqna6G
 70Shd2o+C2113jZs1PG7MtInXeAoOlYlq0aq2nrSHvqb9hf/xNIq/hNnlzVpf2oBSA
 674tWWxMJ3tHvGcYM24Uwi5XLOpHf/+GeA7lLAfPqoS0CrBWJFxI3y9K1nqovonreI
 H6KL9Eu7uumOQ==
Date: Fri, 29 May 2026 12:56:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Aaron Esau <aaron1esau@gmail.com>
Cc: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, berrange@redhat.com,
 qemu-stable@nongnu.org, Jia Jia <physicalmtea@gmail.com>
Subject: Re: [PATCH 2/2] hw/cxl: add missing bounds checks in Set Feature
 for PPR and sparing
Message-ID: <20260529125642.6fd97f75@jic23-huawei>
In-Reply-To: <20260416200702.2374709-3-git@aaronesau.com>
References: <20260416200702.2374709-1-git@aaronesau.com>
 <20260416200702.2374709-3-git@aaronesau.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=jic23@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 16 Apr 2026 15:07:02 -0500
Aaron Esau <aaron1esau@gmail.com> wrote:

> From: Aaron Esau <aaron1esau@gmail.com>
> 
> cmd_features_set_feature() is missing bounds validation on the offset and
> data length for several feature UUIDs before their memcpy calls. The
> patrol_scrub and ecs cases correctly check:
> 
>     if ((uint32_t)hdr->offset + bytes_to_copy >
>         sizeof(ct3d->..._wr_attrs))
>         return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> 
> But the soft_ppr, hard_ppr, cacheline_sparing, row_sparing,
> bank_sparing, and rank_sparing cases are missing this check. Since
> bytes_to_copy is derived from the full mailbox payload length (up to
> 2048 bytes) and the write-attribute structs are only a few bytes each,
> a guest can overflow into adjacent CXLType3Dev fields.
> 
> Add the same bounds check pattern to all six affected feature handlers.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 5e5a86bab8 ("hw/cxl: Add support for Maintenance command and Post Package Repair (PPR)")
> Fixes: da5cafdc4d ("hw/cxl: Add emulation for memory sparing control feature")
> Reported-by: Aaron Esau <aaron1esau@gmail.com>
> Signed-off-by: Aaron Esau <aaron1esau@gmail.com>

There is an alternative patch that I think covers these same cases
from Jia Jia.  +CC
https://lore.kernel.org/qemu-devel/cover.1779946245.git.physicalmtea@gmail.com/

I prefer the use of a helper like Jia Jia has done. If you have
time to take a look at that patch it would be much appreciated.

Jonathan

> ---
>  hw/cxl/cxl-mailbox-utils.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 0adf1e72c8..5fabfcbbab 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -1814,6 +1814,11 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>              return CXL_MBOX_UNSUPPORTED;
>          }
>  
> +        if ((uint32_t)hdr->offset + bytes_to_copy >
> +            sizeof(ct3d->soft_ppr_wr_attrs)) {
> +            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +        }
> +
>          memcpy((uint8_t *)&ct3d->soft_ppr_wr_attrs + hdr->offset,
>                 sppr_write_attrs, bytes_to_copy);
>          set_feat_info->data_size += bytes_to_copy;
> @@ -1833,6 +1838,11 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>              return CXL_MBOX_UNSUPPORTED;
>          }
>  
> +        if ((uint32_t)hdr->offset + bytes_to_copy >
> +            sizeof(ct3d->hard_ppr_wr_attrs)) {
> +            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +        }
> +
>          memcpy((uint8_t *)&ct3d->hard_ppr_wr_attrs + hdr->offset,
>                 hppr_write_attrs, bytes_to_copy);
>          set_feat_info->data_size += bytes_to_copy;
> @@ -1852,6 +1862,11 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>              return CXL_MBOX_UNSUPPORTED;
>          }
>  
> +        if ((uint32_t)hdr->offset + bytes_to_copy >
> +            sizeof(ct3d->cacheline_sparing_wr_attrs)) {
> +            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +        }
> +
>          memcpy((uint8_t *)&ct3d->cacheline_sparing_wr_attrs + hdr->offset,
>                 mem_sparing_write_attrs, bytes_to_copy);
>          set_feat_info->data_size += bytes_to_copy;
> @@ -1870,6 +1885,11 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>              return CXL_MBOX_UNSUPPORTED;
>          }
>  
> +        if ((uint32_t)hdr->offset + bytes_to_copy >
> +            sizeof(ct3d->row_sparing_wr_attrs)) {
> +            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +        }
> +
>          memcpy((uint8_t *)&ct3d->row_sparing_wr_attrs + hdr->offset,
>                 mem_sparing_write_attrs, bytes_to_copy);
>          set_feat_info->data_size += bytes_to_copy;
> @@ -1888,6 +1908,11 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>              return CXL_MBOX_UNSUPPORTED;
>          }
>  
> +        if ((uint32_t)hdr->offset + bytes_to_copy >
> +            sizeof(ct3d->bank_sparing_wr_attrs)) {
> +            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +        }
> +
>          memcpy((uint8_t *)&ct3d->bank_sparing_wr_attrs + hdr->offset,
>                 mem_sparing_write_attrs, bytes_to_copy);
>          set_feat_info->data_size += bytes_to_copy;
> @@ -1906,6 +1931,11 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>              return CXL_MBOX_UNSUPPORTED;
>          }
>  
> +        if ((uint32_t)hdr->offset + bytes_to_copy >
> +            sizeof(ct3d->rank_sparing_wr_attrs)) {
> +            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +        }
> +
>          memcpy((uint8_t *)&ct3d->rank_sparing_wr_attrs + hdr->offset,
>                 mem_sparing_write_attrs, bytes_to_copy);
>          set_feat_info->data_size += bytes_to_copy;


