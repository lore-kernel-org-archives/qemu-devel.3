Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A6A1C83F26
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 15:07:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uglum-0007oe-Q7; Tue, 29 Jul 2025 11:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ben.dooks@codethink.co.uk>)
 id 1ugluc-0007nC-Vq; Tue, 29 Jul 2025 11:06:43 -0400
Received: from imap5.colo.codethink.co.uk ([78.40.148.171])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ben.dooks@codethink.co.uk>)
 id 1uglua-0000k0-NT; Tue, 29 Jul 2025 11:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
 Content-Type:Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:
 MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iWs4yYSMMMSjOcqiAh/EJMF/ND0cKCbGGyrpjRIiv/I=; b=GvKkBnNzaD3HjVPfjhNfxogzxI
 TyQo29l9+0bWGbTaCgAH6AVHwTZSgDpxH+b+z6qZyNJr46r/eyzvW+wAq3++SX+YXhBRQSdfgxXuf
 LRBPaXOwwA4UGiW3LyaMyJBiT6TpRXsQkeF5mcrybV/20CAuxTJGGaVbGaOm6fUfOvHffsgR7yWup
 DWzQ7gJLqMuozr3qRw8iqE3eUflUfOoa8SVVsQ98sjJHaWSIPiVnkGfvZmSOr4ciRkRf61OomHo4u
 8xvA89ugqvnCDtiw7N4u9azCizT/MvBDgm9mDo7xH0ch6JGRJXozNzkeGXfObRX5JG+Vj6ft0Y8Gq
 Haeq93cg==;
Received: from ipa12.colo.codethink.co.uk ([78.40.148.178]
 helo=webmail.codethink.co.uk)
 by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1ugluU-00Acdc-7D; Tue, 29 Jul 2025 16:06:34 +0100
MIME-Version: 1.0
Date: Tue, 29 Jul 2025 16:06:33 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-block@nongnu.org, bmeng.cn@gmail.com, qemu-devel@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] hw/sd/sdcard: fix spi_cmd_SEND_CSD/CID state check
In-Reply-To: <893a7943-e5ac-4c42-b30f-1dfa262b923e@linaro.org>
References: <20250724105807.697915-1-ben.dooks@codethink.co.uk>
 <893a7943-e5ac-4c42-b30f-1dfa262b923e@linaro.org>
Message-ID: <7731f31b606442cab7a3f7b1c2cf6d6e@codethink.co.uk>
X-Sender: ben.dooks@codethink.co.uk
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=78.40.148.171;
 envelope-from=ben.dooks@codethink.co.uk; helo=imap5.colo.codethink.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 2025-07-29 14:51, Philippe Mathieu-Daudé wrote:
> Hi Ben,
> 
> On 24/7/25 12:58, Ben Dooks wrote:
>> The addition of specific handlers for mmc-spi for SEND_CSD and
>> SEND_CID has broken at least Linux and possibly also u-boot's
>> mmc-spi code.
>> 
>> It looks like when adding the code, it is checking for these
>> commands to not be in sd_standby_state but the check looks to
>> have been accidentally reversed (see below)
>> 
>>       if (sd->state != sd_standby_state) {
>>           return sd_invalid_state_for_cmd(sd, req);
>>       }
>> 
>> Linux shows the following:
>> 
>> [    0.293983] Waiting for root device /dev/mmcblk0...
>> [    1.363071] mmc0: error -38 whilst initialising SD card
>> [    2.418566] mmc0: error -38 whilst initialising SD card
>> 
>> Fixes: da954d0e32444f122a4 ("hw/sd/sdcard: Add spi_cmd_SEND_CSD/CID 
>> handlers (CMD9 & CMD10)")
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> ---
>>   hw/sd/sd.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>> 
>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>> index 49fc79cf8a..e6c1ba7c5d 100644
>> --- a/hw/sd/sd.c
>> +++ b/hw/sd/sd.c
>> @@ -1317,7 +1317,7 @@ static sd_rsp_type_t sd_cmd_SEND_IF_COND(SDState 
>> *sd, SDRequest req)
>>   /* CMD9 */
>>   static sd_rsp_type_t spi_cmd_SEND_CSD(SDState *sd, SDRequest req)
>>   {
>> -    if (sd->state != sd_standby_state) {
>> +    if (sd->state == sd_standby_state) {
> 
> This happens to work in your case by luck.
> 
> Since we switch to sd_sendingdata_state in sd_cmd_to_sendingdata(),
> we need to check for sd_transfer_state -- the spec is wrong here! --.
> 
> Btw sd_cmd_to_sendingdata() already checks for that.
> 
> 
>>           return sd_invalid_state_for_cmd(sd, req);
>>       }
>>       return sd_cmd_to_sendingdata(sd, req, sd_req_get_address(sd, 
>> req),
>> @@ -1336,7 +1336,7 @@ static sd_rsp_type_t sd_cmd_SEND_CSD(SDState 
>> *sd, SDRequest req)
>>   /* CMD10 */
>>   static sd_rsp_type_t spi_cmd_SEND_CID(SDState *sd, SDRequest req)
>>   {
>> -    if (sd->state != sd_standby_state) {
>> +    if (sd->state == sd_standby_state) {
> 
> Ditto.
> 
>>           return sd_invalid_state_for_cmd(sd, req);
>>       }
>>       return sd_cmd_to_sendingdata(sd, req, sd_req_get_address(sd, 
>> req),
>> @@ -1345,7 +1345,7 @@ static sd_rsp_type_t spi_cmd_SEND_CID(SDState 
>> *sd, SDRequest req)
>>     static sd_rsp_type_t sd_cmd_SEND_CID(SDState *sd, SDRequest req)
>>   {
>> -    if (sd->state != sd_standby_state) {
>> +    if (sd->state == sd_standby_state) {
> 
> Nack, you just broke SD card implementation. Have a look at
> the "4.8 Card State Transition Table" in the spec.
> 
>>           return sd_invalid_state_for_cmd(sd, req);
>>       }
>> 
> Regards,
> Phil.

ok, so what is the correct fix? the sd-spi has been broken for some 
time.

out of office at the moment so may not be able to test anything until 
5th August


