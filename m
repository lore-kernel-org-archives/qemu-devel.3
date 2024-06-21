Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0DDFC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 16:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKh1Z-0004Zw-3o; Fri, 21 Jun 2024 12:22:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9ak7=NX=kaod.org=clg@ozlabs.org>)
 id 1sKh16-00049p-8X; Fri, 21 Jun 2024 12:21:39 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9ak7=NX=kaod.org=clg@ozlabs.org>)
 id 1sKh12-0003fz-2F; Fri, 21 Jun 2024 12:21:33 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W5N094b54z4wc5;
 Sat, 22 Jun 2024 02:21:29 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W5N072Dgtz4w2Q;
 Sat, 22 Jun 2024 02:21:26 +1000 (AEST)
Message-ID: <0e9201b7-cf13-4647-a6d9-c1dfff9f600d@kaod.org>
Date: Fri, 21 Jun 2024 18:21:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/23] hw/sd/sdcard: Only call sd_req_get_address() where
 address is used
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, qemu-block@nongnu.org
References: <20240621080554.18986-1-philmd@linaro.org>
 <20240621080554.18986-18-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240621080554.18986-18-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=9ak7=NX=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/21/24 10:05 AM, Philippe Mathieu-Daudé wrote:
> It will be useful later to assert only ADTC commands
> (Addressed point-to-point Data Transfer Commands, defined
> as the 'sd_adtc' enum) extract the address value from the
> command argument.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/sd/sd.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index a0193a46ea..1df16ce6a2 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1111,7 +1111,7 @@ static sd_rsp_type_t sd_cmd_SET_BLOCK_COUNT(SDState *sd, SDRequest req)
>   static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>   {
>       uint16_t rca;
> -    uint64_t addr = sd_req_get_address(sd, req);
> +    uint64_t addr;
>   
>       sd->last_cmd_name = sd_cmd_name(req.cmd);
>       /* CMD55 precedes an ACMD, so we are not interested in tracing it.
> @@ -1237,7 +1237,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>               }
>               sd->state = sd_sendingdata_state;
>               memcpy(sd->data, sd->csd, 16);
> -            sd->data_start = addr;
> +            sd->data_start = sd_req_get_address(sd, req);
>               sd->data_offset = 0;
>               return sd_r1;
>   
> @@ -1261,7 +1261,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>               }
>               sd->state = sd_sendingdata_state;
>               memcpy(sd->data, sd->cid, 16);
> -            sd->data_start = addr;
> +            sd->data_start = sd_req_get_address(sd, req);
>               sd->data_offset = 0;
>               return sd_r1;
>   
> @@ -1337,6 +1337,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>   
>       case 17:  /* CMD17:  READ_SINGLE_BLOCK */
>       case 18:  /* CMD18:  READ_MULTIPLE_BLOCK */
> +        addr = sd_req_get_address(sd, req);
>           switch (sd->state) {
>           case sd_transfer_state:
>   
> @@ -1357,6 +1358,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>       /* Block write commands (Class 4) */
>       case 24:  /* CMD24:  WRITE_SINGLE_BLOCK */
>       case 25:  /* CMD25:  WRITE_MULTIPLE_BLOCK */
> +        addr = sd_req_get_address(sd, req);
>           switch (sd->state) {
>           case sd_transfer_state:
>   
> @@ -1415,7 +1417,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>           if (sd->size > SDSC_MAX_CAPACITY) {
>               return sd_illegal;
>           }
> -
> +        addr = sd_req_get_address(sd, req);
>           switch (sd->state) {
>           case sd_transfer_state:
>               if (!address_in_range(sd, "SET_WRITE_PROT", addr, 1)) {
> @@ -1437,7 +1439,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>           if (sd->size > SDSC_MAX_CAPACITY) {
>               return sd_illegal;
>           }
> -
> +        addr = sd_req_get_address(sd, req);
>           switch (sd->state) {
>           case sd_transfer_state:
>               if (!address_in_range(sd, "CLR_WRITE_PROT", addr, 1)) {
> @@ -1459,7 +1461,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>           if (sd->size > SDSC_MAX_CAPACITY) {
>               return sd_illegal;
>           }
> -
> +        addr = sd_req_get_address(sd, req);
>           switch (sd->state) {
>           case sd_transfer_state:
>               if (!address_in_range(sd, "SEND_WRITE_PROT",


