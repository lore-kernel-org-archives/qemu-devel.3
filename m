Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C21B6C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 20:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sONzG-0008Gs-HF; Mon, 01 Jul 2024 16:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ArqK=OB=kaod.org=clg@ozlabs.org>)
 id 1sONzC-0008GV-Ec
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 16:50:54 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ArqK=OB=kaod.org=clg@ozlabs.org>)
 id 1sONz6-0001X9-Kf
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 16:50:52 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WCdV94gDnz4xM5;
 Tue,  2 Jul 2024 06:50:41 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WCdV81Vggz4xM7;
 Tue,  2 Jul 2024 06:50:39 +1000 (AEST)
Message-ID: <885bee94-73e7-47d2-8ae2-185aaf00315c@kaod.org>
Date: Mon, 1 Jul 2024 22:50:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 18/98] hw/sd/sdcard: Introduce sd_cmd_to_sendingdata
 and sd_generic_read_byte
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Luc Michel <luc.michel@amd.com>
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-19-philmd@linaro.org>
 <1e5806db-d4e6-410f-b856-53c6a3f62999@kaod.org>
 <8d6d673e-2b89-42be-bfa7-aa3678fd697d@linaro.org>
 <6af8fd8d-9724-4c4f-9956-c19ff463d3c5@kaod.org>
 <4c9f7f51-83ee-421a-8690-9af2e80b134b@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <4c9f7f51-83ee-421a-8690-9af2e80b134b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=ArqK=OB=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

On 7/1/24 10:19 PM, Philippe Mathieu-Daudé wrote:
> On 1/7/24 18:54, Cédric Le Goater wrote:
>> On 7/1/24 6:40 PM, Philippe Mathieu-Daudé wrote:
>>> On 28/6/24 09:44, Cédric Le Goater wrote:
>>>> On 6/28/24 9:00 AM, Philippe Mathieu-Daudé wrote:
>>>>> All commands switching from TRANSFER state to (sending)DATA
>>>>> do the same: send stream of data on the DAT lines. Instead
>>>>> of duplicating the same code many times, introduce 2 helpers:
>>>>> - sd_cmd_to_sendingdata() on the I/O line setup the data to
>>>>>    be transferred,
>>>>> - sd_generic_read_byte() on the DAT lines to fetch the data.
>>>>>
>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>> ---
>>>>>   hw/sd/sd.c | 39 +++++++++++++++++++++++++++++++++++++++
>>>>>   1 file changed, 39 insertions(+)
> 
>>>> Shouldn't we check for buffer overrun ? sizeof(sd->data)
>>>
>>> OK if I squash this?
>>>
>>> -- >8 --
>>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>>> index d292e0adb5..f2d069c2da 100644
>>> --- a/hw/sd/sd.c
>>> +++ b/hw/sd/sd.c
>>> @@ -1123,7 +1123,7 @@ static sd_rsp_type_t sd_cmd_to_sendingdata(SDState *sd, SDRequest req,
>>>       sd->data_start = start;
>>>       sd->data_offset = 0;
>>>       if (data) {
>>> -        assert(size);
>>> +        assert(size > 0 && size <= sizeof(sd->data));
>>>           memcpy(sd->data, data, size);
>>>       }
>>> ---
>>
>> sure.
> 
> Great. Can I get your R-b tag? The final patch is:


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> 
> -- >8 --
> Author: Philippe Mathieu-Daudé <philmd@linaro.org>
> Date:   Thu Jun 13 16:21:12 2024 +0200
> 
>      hw/sd/sdcard: Introduce sd_cmd_to_sendingdata and sd_generic_read_byte
> 
>      All commands switching from TRANSFER state to (sending)DATA
>      do the same: send stream of data on the DAT lines. Instead
>      of duplicating the same code many times, introduce 2 helpers:
>      - sd_cmd_to_sendingdata() on the I/O line setup the data to
>        be transferred,
>      - sd_generic_read_byte() on the DAT lines to fetch the data.
> 
>      Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 18bb2f9fd8..60235d3898 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -143,4 +143,6 @@ struct SDState {
>       uint32_t blk_written;
> +
>       uint64_t data_start;
>       uint32_t data_offset;
> +    size_t data_size;
>       uint8_t data[512];
> @@ -1080,2 +1082,25 @@ static sd_rsp_type_t sd_cmd_unimplemented(SDState *sd, SDRequest req)
> 
> +/* Configure fields for following sd_generic_read_byte() calls */
> +__attribute__((unused))
> +static sd_rsp_type_t sd_cmd_to_sendingdata(SDState *sd, SDRequest req,
> +                                           uint64_t start,
> +                                           const void *data, size_t size)
> +{
> +    if (sd->state != sd_transfer_state) {
> +        sd_invalid_state_for_cmd(sd, req);
> +    }
> +
> +    sd->state = sd_sendingdata_state;
> +    sd->data_start = start;
> +    sd->data_offset = 0;
> +    if (data) {
> +        assert(size > 0 && size <= sizeof(sd->data));
> +        memcpy(sd->data, data, size);
> +    }
> +    if (size) {
> +        sd->data_size = size;
> +    }
> +    return sd_r1;
> +}
> +
>   /* CMD0 */
> @@ -1914,2 +1939,16 @@ send_response:
> 
> +/* Return true when buffer is consumed. Configured by sd_cmd_to_sendingdata() */
> +__attribute__((unused))
> +static bool sd_generic_read_byte(SDState *sd, uint8_t *value)
> +{
> +    *value = sd->data[sd->data_offset];
> +
> +    if (++sd->data_offset >= sd->data_size) {
> +        sd->state = sd_transfer_state;
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
>   void sd_write_byte(SDState *sd, uint8_t value)
> ---
> 


