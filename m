Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B472C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:45:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN6HG-0007JW-7z; Fri, 28 Jun 2024 03:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6HE-0007J4-Bo
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:44:12 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6HC-0004MA-Ff
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:44:12 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9S9y4015z4w2Q;
 Fri, 28 Jun 2024 17:44:06 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9S9x3MGHz4w2N;
 Fri, 28 Jun 2024 17:44:05 +1000 (AEST)
Message-ID: <1e5806db-d4e6-410f-b856-53c6a3f62999@kaod.org>
Date: Fri, 28 Jun 2024 09:44:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 18/98] hw/sd/sdcard: Introduce sd_cmd_to_sendingdata
 and sd_generic_read_byte
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-19-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-19-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=GU6n=N6=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
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

On 6/28/24 9:00 AM, Philippe Mathieu-Daudé wrote:
> All commands switching from TRANSFER state to (sending)DATA
> do the same: send stream of data on the DAT lines. Instead
> of duplicating the same code many times, introduce 2 helpers:
> - sd_cmd_to_sendingdata() on the I/O line setup the data to
>    be transferred,
> - sd_generic_read_byte() on the DAT lines to fetch the data.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/sd/sd.c | 39 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 39 insertions(+)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index d85b2906f4..1a8d06804d 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -142,8 +142,10 @@ struct SDState {
>        */
>       bool expecting_acmd;
>       uint32_t blk_written;
> +
>       uint64_t data_start;
>       uint32_t data_offset;
> +    size_t data_size;
>       uint8_t data[512];
>       uint8_t vendor_data[512];
>   
> @@ -1083,6 +1085,29 @@ static sd_rsp_type_t sd_cmd_unimplemented(SDState *sd, SDRequest req)
>       return sd_illegal;
>   }
>   
> +/* Configure fields for following sd_generic_read_byte() calls */
> +__attribute__((unused))
> +static sd_rsp_type_t sd_cmd_to_sendingdata(SDState *sd, SDRequest req,
> +                                           uint64_t start,
> +                                           const void *data, size_t size)
> +{
> +    if (sd->state != sd_transfer_state) {
> +        sd_invalid_state_for_cmd(sd, req);
> +    }
> +
> +    sd->state = sd_sendingdata_state;
> +    sd->data_start = start;
> +    sd->data_offset = 0;
> +    if (data) {
> +        assert(size);

Shouldn't we check for buffer overrun ? sizeof(sd->data)

Thanks,

C.



> +        memcpy(sd->data, data, size);
> +    }
> +    if (size) {
> +        sd->data_size = size;
> +    }
> +    return sd_r1;
> +}
> +
>   /* CMD0 */
>   static sd_rsp_type_t sd_cmd_GO_IDLE_STATE(SDState *sd, SDRequest req)
>   {
> @@ -1920,6 +1945,20 @@ send_response:
>       return rsplen;
>   }
>   
> +/* Return true when buffer is consumed. Configured by sd_cmd_to_sendingdata() */
> +__attribute__((unused))
> +static bool sd_generic_read_byte(SDState *sd, uint8_t *value)
> +{
> +    *value = sd->data[sd->data_offset];
> +
> +    if (++sd->data_offset >= sd->data_size) {
> +        sd->state = sd_transfer_state;
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
>   void sd_write_byte(SDState *sd, uint8_t value)
>   {
>       int i;


