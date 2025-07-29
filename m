Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10EDBC83F26
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 13:52:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugkk5-0001Bc-Jr; Tue, 29 Jul 2025 09:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugkk3-0000WE-MQ
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 09:51:43 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugkjz-0007Cw-M9
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 09:51:42 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4560add6cd2so6583045e9.0
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 06:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753797095; x=1754401895; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gfyV1GEz+/6fEXfYVjV9X6UXCYiwPPVPUeTTcCKvZD0=;
 b=cp4Zmq3rdDtlfbLMIQ7BVkQyJ6m2HyGqMGXF3V2aEZOwwR/yLsOEjuwfaaGf9vZoF5
 w9J2YPsgRH0yM1l9tbC8JwZZwcmtH113xDtE5w2/bTEdztAIAo0jgYc7Rz+ZyjrJ2Feo
 nHPu0rHu2+H/ShQMSX5JmrecU96gNID8Un61C3f+gcHKyeukeqkxpweWYGfz8eLbtJV8
 7wq1CfPFm2IaTgmShscgJmcusXcoTFYOlpn0UEG4t9i0nP8c+0FXjgygnYuiyMRDZHlA
 Ps/tC0wLD1vflruZul3NoyCzFY6jHtZjXLkcRiIS95QIJ2ECfaCh23otLvRa0I4g7wMh
 giiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753797095; x=1754401895;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gfyV1GEz+/6fEXfYVjV9X6UXCYiwPPVPUeTTcCKvZD0=;
 b=itAgofXf3JPG7HL/yegcDD1FxrUh9jTQfJViyZtTs94rAcE11KQiafa5LYgxl0lkUw
 GBhav9AytloWh4Nhciu/JMgu3fA5wQiW74d4HlljOYRWthQ2PIyAp43GOgL2kayItvo9
 tPs6Xda8M6pP+GLZZtYiiFZPQudTopQ/qFzNvhXkKmCoYa+hYFTs4rmwUYCoPdISrAaT
 XVChXyPo9JQc8dBsJQpsRE+CkjxJxuAQrfQx2u4rZNAQmmNKaXcphKKmP0SgPWiqCa5i
 Esfn41b7/t2Jz0pfwqsoyprj3iJM4480Rmd7294taWdRPCORWrFH42PdEBL7LpUXOINY
 wM0Q==
X-Gm-Message-State: AOJu0YzeLUYcYbGP+e6ew2Nn/mvO7uERp+QRNX671JhEVivz/Rdc32Jm
 FsM1QiJ1VnMRCx8cpfzPLylYs0L64flCY7ABHmxbPkmDkV62iOYB35Z7kqimLoTIDto=
X-Gm-Gg: ASbGnctaLZKyyZ3PVP/DgKJSjPVH/Kbb260cx7DepaKmNp/9ii3PipvJKols28dXiaF
 seuVF0C3S54zHlFnIkle9fp9ZC7clOFigKQfkmhi9Q/jicJRwX9TxM+aGQHZ2Lfw9mOeX7u6xi6
 QTjoShRZs/kkabKR16KnXbCFmmzxgHFVvwW3cTjGUOPfBFhizGvVElb6HAV+QpzhA4lHMK+3Rbj
 QLUT5c8mFhlebr1xE+Ortxe6GCp0vF0A9uaYI81H0uQfnrfPP/sQUgz9XEVpBohG7+q5Yxx9yY6
 A1NJdwXeyj4X6qwB+mrlAEPcuc3QaPEgP/fR9LHUq/ClpDOPHLLqO6cgtZ46ASbLIzLSf93qgoy
 BC4deFmeunHwun0l4n7b9F1qLAe3VjQrsSsGo5q3P9VnwVliNzSSk+R2XZNx5eVQZpuSCBwXd3W
 RMGhpsFg==
X-Google-Smtp-Source: AGHT+IEVkJet9kB5gafppx4L2K50y/6jm1C51AUkG3sJ79QOTpVTTju/b9cGHufPmr9egx704qVrAg==
X-Received: by 2002:a05:600c:3f18:b0:456:21f4:a0a3 with SMTP id
 5b1f17b1804b1-4589031cfa0mr16688465e9.5.1753797095317; 
 Tue, 29 Jul 2025 06:51:35 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4588e5c2232sm29561065e9.13.2025.07.29.06.51.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jul 2025 06:51:34 -0700 (PDT)
Message-ID: <893a7943-e5ac-4c42-b30f-1dfa262b923e@linaro.org>
Date: Tue, 29 Jul 2025 15:51:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sd/sdcard: fix spi_cmd_SEND_CSD/CID state check
To: Ben Dooks <ben.dooks@codethink.co.uk>, qemu-block@nongnu.org,
 bmeng.cn@gmail.com
Cc: qemu-devel@nongnu.org, Guenter Roeck <linux@roeck-us.net>
References: <20250724105807.697915-1-ben.dooks@codethink.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250724105807.697915-1-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Ben,

On 24/7/25 12:58, Ben Dooks wrote:
> The addition of specific handlers for mmc-spi for SEND_CSD and
> SEND_CID has broken at least Linux and possibly also u-boot's
> mmc-spi code.
> 
> It looks like when adding the code, it is checking for these
> commands to not be in sd_standby_state but the check looks to
> have been accidentally reversed (see below)
> 
>       if (sd->state != sd_standby_state) {
>           return sd_invalid_state_for_cmd(sd, req);
>       }
> 
> Linux shows the following:
> 
> [    0.293983] Waiting for root device /dev/mmcblk0...
> [    1.363071] mmc0: error -38 whilst initialising SD card
> [    2.418566] mmc0: error -38 whilst initialising SD card
> 
> Fixes: da954d0e32444f122a4 ("hw/sd/sdcard: Add spi_cmd_SEND_CSD/CID handlers (CMD9 & CMD10)")
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>   hw/sd/sd.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 49fc79cf8a..e6c1ba7c5d 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1317,7 +1317,7 @@ static sd_rsp_type_t sd_cmd_SEND_IF_COND(SDState *sd, SDRequest req)
>   /* CMD9 */
>   static sd_rsp_type_t spi_cmd_SEND_CSD(SDState *sd, SDRequest req)
>   {
> -    if (sd->state != sd_standby_state) {
> +    if (sd->state == sd_standby_state) {

This happens to work in your case by luck.

Since we switch to sd_sendingdata_state in sd_cmd_to_sendingdata(),
we need to check for sd_transfer_state -- the spec is wrong here! --.

Btw sd_cmd_to_sendingdata() already checks for that.


>           return sd_invalid_state_for_cmd(sd, req);
>       }
>       return sd_cmd_to_sendingdata(sd, req, sd_req_get_address(sd, req),
> @@ -1336,7 +1336,7 @@ static sd_rsp_type_t sd_cmd_SEND_CSD(SDState *sd, SDRequest req)
>   /* CMD10 */
>   static sd_rsp_type_t spi_cmd_SEND_CID(SDState *sd, SDRequest req)
>   {
> -    if (sd->state != sd_standby_state) {
> +    if (sd->state == sd_standby_state) {

Ditto.

>           return sd_invalid_state_for_cmd(sd, req);
>       }
>       return sd_cmd_to_sendingdata(sd, req, sd_req_get_address(sd, req),
> @@ -1345,7 +1345,7 @@ static sd_rsp_type_t spi_cmd_SEND_CID(SDState *sd, SDRequest req)
>   
>   static sd_rsp_type_t sd_cmd_SEND_CID(SDState *sd, SDRequest req)
>   {
> -    if (sd->state != sd_standby_state) {
> +    if (sd->state == sd_standby_state) {

Nack, you just broke SD card implementation. Have a look at
the "4.8 Card State Transition Table" in the spec.

>           return sd_invalid_state_for_cmd(sd, req);
>       }
>   
Regards,
Phil.

