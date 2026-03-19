Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B0591090236
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 14:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3EiC-0000rF-Gn; Thu, 19 Mar 2026 10:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1w3EiA-0000qo-H2
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 10:50:58 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1w3Ei7-00082D-I0
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 10:50:58 -0400
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fc7sc2JvZzHnGkK;
 Thu, 19 Mar 2026 22:50:28 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 01B574056B;
 Thu, 19 Mar 2026 22:50:52 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 19 Mar
 2026 14:50:51 +0000
Date: Thu, 19 Mar 2026 14:50:50 +0000
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/2] hw/cxl: Respect Media Operation max ops discovery
 semantics
Message-ID: <20260319145050.00002acf@huawei.com>
In-Reply-To: <20260318185508.3683044-2-dave@stgolabs.net>
References: <20260318185508.3683044-1-dave@stgolabs.net>
 <20260318185508.3683044-2-dave@stgolabs.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 18 Mar 2026 11:55:07 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> The Discovery handler rejects requests where start_index + num_ops
> exceeds the total number of supported operations. Per CXL 4.0
> Table 8-332, num_ops is the "Maximum number of Media Operation to
> return" - a maximum, not an exact count. The device should return
> up to that many entries, not reject the request.
> 
> Cap num_ops to the available entries from start_index instead of
> erroring the command.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
One trivial thing inline.

> ---
>  hw/cxl/cxl-mailbox-utils.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index a3143f3faa23..71a012121c87 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -2593,6 +2593,7 @@ static CXLRetCode media_operations_discovery(uint8_t *payload_in,
>      } QEMU_PACKED *media_op_in_disc_pl = (void *)payload_in;
>      struct media_op_discovery_out_pl *media_out_pl =
>          (struct media_op_discovery_out_pl *)payload_out;
> +    int total = ARRAY_SIZE(media_op_matrix);
>      int num_ops, start_index, i;
>      int count = 0;
>  
> @@ -2609,24 +2610,20 @@ static CXLRetCode media_operations_discovery(uint8_t *payload_in,
>       * sub class command.
>       */
>      if (media_op_in_disc_pl->dpa_range_count ||
> -        start_index + num_ops > ARRAY_SIZE(media_op_matrix)) {
> +        start_index >= total) {
>          return CXL_MBOX_INVALID_INPUT;
>      }
>  
>      media_out_pl->dpa_range_granularity = CXL_CACHE_LINE_SIZE;
> -    media_out_pl->total_supported_operations =
> -                                     ARRAY_SIZE(media_op_matrix);
> -    if (num_ops > 0) {
> -        for (i = start_index; i < start_index + num_ops; i++) {
> -            media_out_pl->entry[count].media_op_class =
> -                    media_op_matrix[i].media_op_class;
> -            media_out_pl->entry[count].media_op_subclass =
> -                        media_op_matrix[i].media_op_subclass;
> -            count++;
> -            if (count == num_ops) {
> -                break;
> -            }
> -        }
> +    media_out_pl->total_supported_operations = total;
> +
> +    num_ops = MIN(num_ops, total - start_index);
> +    for (i = 0; i < num_ops; i++) {
> +        media_out_pl->entry[count].media_op_class =
> +                media_op_matrix[start_index + i].media_op_class;
> +        media_out_pl->entry[count].media_op_subclass =
> +                    media_op_matrix[start_index + i].media_op_subclass;
Patch in general looks good, but the indenting here is a bit too creative
/ inconsistent.
        media_out_pl->entry[count].media_op_class =
                media_op_matrix[start_index + i].media_op_class;
        media_out_pl->entry[count].media_op_subclass =
                media_op_matrix[start_index + i].media_op_subclass;

or something along those lines.

> +        count++;
>      }
>  
>      media_out_pl->num_of_supported_operations = count;


