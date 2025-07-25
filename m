Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3DDC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 13:32:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufIWM-0004Or-C1; Fri, 25 Jul 2025 09:31:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ufIWJ-0004G4-KU
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 09:31:31 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ufIWH-0000Be-FA
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 09:31:31 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bpTHp5BNcz6L59B;
 Fri, 25 Jul 2025 21:29:42 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 54C8A140133;
 Fri, 25 Jul 2025 21:31:22 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 25 Jul
 2025 15:31:21 +0200
Date: Fri, 25 Jul 2025 14:31:20 +0100
To: <shiju.jose@huawei.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 <fan.ni@samsung.com>, <dave@stgolabs.net>, <linuxarm@huawei.com>
Subject: Re: [PATCH qemu v4 7/7] hw/cxl: Add emulation for memory sparing
 control feature
Message-ID: <20250725143120.00000eef@huawei.com>
In-Reply-To: <20250721172228.2118-8-shiju.jose@huawei.com>
References: <20250721172228.2118-1-shiju.jose@huawei.com>
 <20250721172228.2118-8-shiju.jose@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, 21 Jul 2025 18:22:28 +0100
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Memory sparing is defined as a repair function that replaces a portion of
> memory with a portion of functional memory at that same DPA. The
> subclasses for this operation vary in terms of the scope of the sparing
> being performed. The Cacheline sparing subclass refers to a sparing
> action that can replace a full cacheline. Row sparing is provided as an
> alternative to PPR sparing functions and its scope is that of a single
> DDR row. Bank sparing allows an entire bank to be replaced. Rank sparing
> is defined as an operation in which an entire DDR rank is replaced.
> 
> Memory sparing maintenance operations may be supported by CXL devices
> that implement CXL.mem protocol. A sparing maintenance operation requests
> the CXL device to perform a repair operation on its media.
> For example, a CXL device with DRAM components that support memory sparing
> features may implement sparing Maintenance operations.
> 
> The host may issue a query command by setting Query Resources flag in the
> Input Payload (CXL Spec 3.2 Table 8-120) to determine availability of
> sparing resources for a given address. In response to a query request,
> the device shall report the resource availability by producing the Memory
> Sparing Event Record (CXL Spec 3.2 Table 8-60) in which the Channel, Rank,
> Nibble Mask, Bank Group, Bank, Row, Column, Sub-Channel fields are a copy
> of the values specified in the request.
> 
> During the execution of a sparing maintenance operation, a CXL memory
> device:
> - May or may not retain data
> - May or may not be able to process CXL.mem requests correctly.
> These CXL memory device capabilities are specified by restriction flags
> in the memory sparing feature readable attributes.
> 
> When a CXL device identifies error on a memory component, the device
> may inform the host about the need for a memory sparing maintenance
> operation by using DRAM event record, where the 'maintenance needed' flag
> may set. The event record contains some of the DPA, Channel, Rank,
> Nibble Mask, Bank Group, Bank, Row, Column, Sub-Channel fields that
> should be repaired. The userspace tool requests for maintenance operation
> if the 'maintenance needed' flag set in the CXL DRAM error record.
> 
> CXL spec 3.2 section 8.2.10.7.2.3 describes the memory sparing feature
> discovery and configuration.
> 
> CXL spec 3.2 section 8.2.10.7.1.4 describes the device's memory sparing
> maintenance operation feature.
> 
> Add emulation for CXL memory device memory sparing control feature
> and memory sparing maintenance operation command.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>


> +    } else if (qemu_uuid_is_equal(&hdr->uuid, &rank_sparing_uuid)) {
> +        CXLMemSparingSetFeature *mem_sparing_set_feature = (void *)payload_in;
> +        CXLMemSparingWriteAttrs *mem_sparing_write_attrs =
> +                            &mem_sparing_set_feature->feat_data;
> +
> +        if (hdr->version != CXL_MEMDEV_SPARING_SET_FEATURE_VERSION) {
> +            return CXL_MBOX_UNSUPPORTED;
> +        }
> +
> +        memcpy((uint8_t *)&ct3d->rank_sparing_wr_attrs + hdr->offset,
> +               mem_sparing_write_attrs,
> +               bytes_to_copy);

Trivial but no need for the wrap.  There were some of these in previous patch as
well.

> +        set_feat_info->data_size += bytes_to_copy;
> +
> +        if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
> +            data_transfer_flag == CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER) {
> +            ct3d->rank_sparing_attrs.op_mode =
> +                             ct3d->rank_sparing_wr_attrs.op_mode;
> +        }



