Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3A7C41513
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 16:22:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKh0p-0003l1-VS; Fri, 21 Jun 2024 12:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9ak7=NX=kaod.org=clg@ozlabs.org>)
 id 1sKh0f-0003OT-Lv; Fri, 21 Jun 2024 12:21:11 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9ak7=NX=kaod.org=clg@ozlabs.org>)
 id 1sKh0d-0003bq-Po; Fri, 21 Jun 2024 12:21:09 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W5MzY75c8z4wcJ;
 Sat, 22 Jun 2024 02:20:57 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W5MzW4zpfz4w2Q;
 Sat, 22 Jun 2024 02:20:55 +1000 (AEST)
Message-ID: <79d4accf-b7e8-4b65-9396-7e07cb3e1ed3@kaod.org>
Date: Fri, 21 Jun 2024 18:20:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/23] hw/sd/sdcard: Only call sd_req_get_rca() where RCA
 is used
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, qemu-block@nongnu.org
References: <20240621080554.18986-1-philmd@linaro.org>
 <20240621080554.18986-16-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240621080554.18986-16-philmd@linaro.org>
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
> It will be useful later to assert only AC commands
> (Addressed point-to-point Commands, defined as the
> 'sd_ac' enum) extract the RCA value from the command
> argument.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/sd/sd.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index bc47ae36bc..cb9d85bb11 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1102,7 +1102,7 @@ static sd_rsp_type_t sd_cmd_SET_BLOCK_COUNT(SDState *sd, SDRequest req)
>   
>   static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>   {
> -    uint16_t rca = sd_req_get_rca(sd, req);
> +    uint16_t rca;
>       uint64_t addr = (sd->ocr & (1 << 30)) ? (uint64_t) req.arg << 9 : req.arg;
>   
>       sd->last_cmd_name = sd_cmd_name(req.cmd);
> @@ -1160,6 +1160,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>           break;
>   
>       case 7:  /* CMD7:   SELECT/DESELECT_CARD */
> +        rca = sd_req_get_rca(sd, req);
>           switch (sd->state) {
>           case sd_standby_state:
>               if (sd->rca != rca)
> @@ -1214,6 +1215,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>           return sd_r7;
>   
>       case 9:  /* CMD9:   SEND_CSD */
> +        rca = sd_req_get_rca(sd, req);
>           switch (sd->state) {
>           case sd_standby_state:
>               if (sd->rca != rca)
> @@ -1237,6 +1239,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>           break;
>   
>       case 10:  /* CMD10:  SEND_CID */
> +        rca = sd_req_get_rca(sd, req);
>           switch (sd->state) {
>           case sd_standby_state:
>               if (sd->rca != rca)
> @@ -1277,6 +1280,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>           break;
>   
>       case 13:  /* CMD13:  SEND_STATUS */
> +        rca = sd_req_get_rca(sd, req);
>           switch (sd->mode) {
>           case sd_data_transfer_mode:
>               if (!sd_is_spi(sd) && sd->rca != rca) {
> @@ -1291,6 +1295,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>           break;
>   
>       case 15:  /* CMD15:  GO_INACTIVE_STATE */
> +        rca = sd_req_get_rca(sd, req);
>           switch (sd->mode) {
>           case sd_data_transfer_mode:
>               if (sd->rca != rca)
> @@ -1523,6 +1528,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>   
>       /* Application specific commands (Class 8) */
>       case 55:  /* CMD55:  APP_CMD */
> +        rca = sd_req_get_rca(sd, req);
>           switch (sd->state) {
>           case sd_ready_state:
>           case sd_identification_state:


