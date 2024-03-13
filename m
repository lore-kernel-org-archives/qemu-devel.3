Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE6FC54E66
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 18:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkTGv-000647-U0; Wed, 13 Mar 2024 14:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1rkTGu-00063z-IQ
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 14:24:12 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1rkTGs-0008FK-Qd
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 14:24:12 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9F15755BA9;
 Wed, 13 Mar 2024 21:25:11 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9FC3E9895E;
 Wed, 13 Mar 2024 21:24:06 +0300 (MSK)
Message-ID: <24d738c6-27d6-4ff3-8b52-d0639deae855@tls.msk.ru>
Date: Wed, 13 Mar 2024 21:24:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hmat acpi: Fix out of bounds access due to missing
 use of indirection
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Liu Jingqi <jingqi.liu@intel.com>, qemu-devel@nongnu.org, ankita@nvidia.com,
 "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Cc: linuxarm@huawei.com, Markus Armbruster <armbru@redhat.com>,
 Daniel Black <daniel@linux.ibm.com>
References: <20240307160326.31570-1-Jonathan.Cameron@huawei.com>
 <20240307160326.31570-3-Jonathan.Cameron@huawei.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 xsBLBETIiwkBCADh3cFB56BQYPjtMZCfK6PSLR8lw8EB20rsrPeJtd91IoNZlnCjSoxd9Th1
 bLUR8YlpRJ2rjc6O1Bc04VghqUOHgS/tYt8vLjcGWixzdhSLJgPDK3QQZPAvBjMbCt1B6euC
 WuD87Pv5Udlpnzf4aMwxkgfTusx+ynae/o+T5r7tXD+isccbC3SiGhmAPxFyY3zGcFk4+Rxc
 0tP8YY2FWE/baHu+lBDTUN79efWAkHhex1XzVZsV7ZD16rzDbXFK5m6ApvGJWlr5YDEEydTF
 WwmvwBfr4OINVxzEG/ujNiG4fpMf2NsnFGyB9aSbFjXZevB4qWkduYYW+xpK1EryszHtAAYp
 zSBNaWNoYWVsIFRva2FyZXYgPG1qdEB0bHMubXNrLnJ1PsLAlgQTAQoAQAIbAwYLCQgHAwIE
 FQIIAwQWAgMBAh4BAheAAhkBFiEEbuGV0Yhuj/uBDUMkRXzgoIBEZcUFAmBbcjwFCS5e6jMA
 CgkQRXzgoIBEZcUTIQgA1hPsOF82pXxbcJXBMc4zB9OQu4AlnZvERoGyw7I2222QzaN3RFuj
 Fia//mapXzpIQNF08l/AA6cx+CKPeGnXwyZfF9fLa4RfifmdNKME8C00XlqnoJDZBGzq8yMy
 LAKDxl9OQWFcDwDxV+irg5U3fbtNVhvV0kLbS2TyQ0aU5w60ERS2NcyDWplOo7AOzZWChcA4
 UFf78oVdZdCW8YDtU0uQFhA9moNnrePy1HSFqduxnlFHEI+fDj/TiOm2ci48b8SBBJOIJFjl
 SBgH8+SfT9ZqkzhN9vh3YJ49831NwASVm0x1rDHcIwWD32VFZViZ3NjehogRNH9br0PSUYOC
 3s7ATQRX2BjLAQgAnak3m0imYOkv2tO/olULFa686tlwuvl5kL0NWCdGQeXv2uMxy36szcrh
 K1uYhpiQv4r2qNd8BJtYlnYIK16N8GBdkplaDIHcBMbU4t+6bQzEIJIaWoq1hzakmHHngE2a
 pNMnUf/01GFvCRPlv3imkujE/5ILbagjtdyJaHF0wGOSlTnNT4W8j+zPJ/XK0I5EVQwtbmoc
 GY62LKxxz2pID6sPZV4zQVY4JdUQaFvOz1emnBxakkt0cq3Qnnqso1tjiy7vyH9CAwPR/48W
 fpK6dew4Fk+STYtBeixOTfSUS8qRS/wfpUeNa5RnEdTtFQ9IcjpQ/nPrvJJsu9FqwlpjMwAR
 AQABwsBlBBgBCAAPBQJX2BjLAhsMBQkSzAMAAAoJEEV84KCARGXFUKcH/jqKETECkbyPktdP
 cWVqw2ZIsmGxMkIdnZTbPwhORseGXMHadQODayhU9GWfCDdSPkWDWzMamD+qStfl9MhlVT60
 HTbo6wu1W/ogUS70qQPTY9IfsvAj6f8TlSlK0eLMa3s2UxL2oe5FkNs2CnVeRlr4Yqvp/ZQV
 6LXtew4GPRrmplUT/Cre9QIUqR4pxYCQaMoOXQQw3Y0csBwoDYUQujn3slbDJRIweHoppBzT
 rM6ZG5ldWQN3n3d71pVuv80guylX8+TSB8Mvkqwb5I36/NAFKl0CbGbTuQli7SmNiTAKilXc
 Y5Uh9PIrmixt0JrmGVRzke6+11mTjVlio/J5dCM=
In-Reply-To: <20240307160326.31570-3-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

07.03.2024 19:03, Jonathan Cameron via wrote:
> With a numa set up such as
> 
> -numa nodeid=0,cpus=0 \
> -numa nodeid=1,memdev=mem \
> -numa nodeid=2,cpus=1
> 
> and appropriate hmat_lb entries the initiator list is correctly
> computed and writen to HMAT as 0,2 but then the LB data is accessed
> using the node id (here 2), landing outside the entry_list array.
> 
> Stash the reverse lookup when writing the initiator list and use
> it to get the correct array index index.
> 
> Fixes: 4586a2cb83 ("hmat acpi: Build System Locality Latency and Bandwidth Information Structure(s)")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This seems like a -stable material, is it not?

Thanks,

/mjt

> ---
>   hw/acpi/hmat.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
> index 723ae28d32..b933ae3c06 100644
> --- a/hw/acpi/hmat.c
> +++ b/hw/acpi/hmat.c
> @@ -78,6 +78,7 @@ static void build_hmat_lb(GArray *table_data, HMAT_LB_Info *hmat_lb,
>                             uint32_t *initiator_list)
>   {
>       int i, index;
> +    uint32_t initiator_to_index[MAX_NODES] = {};
>       HMAT_LB_Data *lb_data;
>       uint16_t *entry_list;
>       uint32_t base;
> @@ -121,6 +122,8 @@ static void build_hmat_lb(GArray *table_data, HMAT_LB_Info *hmat_lb,
>       /* Initiator Proximity Domain List */
>       for (i = 0; i < num_initiator; i++) {
>           build_append_int_noprefix(table_data, initiator_list[i], 4);
> +        /* Reverse mapping for array possitions */
> +        initiator_to_index[initiator_list[i]] = i;
>       }
>   
>       /* Target Proximity Domain List */
> @@ -132,7 +135,8 @@ static void build_hmat_lb(GArray *table_data, HMAT_LB_Info *hmat_lb,
>       entry_list = g_new0(uint16_t, num_initiator * num_target);
>       for (i = 0; i < hmat_lb->list->len; i++) {
>           lb_data = &g_array_index(hmat_lb->list, HMAT_LB_Data, i);
> -        index = lb_data->initiator * num_target + lb_data->target;
> +        index = initiator_to_index[lb_data->initiator] * num_target +
> +            lb_data->target;
>   
>           entry_list[index] = (uint16_t)(lb_data->data / hmat_lb->base);
>       }


