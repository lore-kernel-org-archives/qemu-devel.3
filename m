Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E0FD1CDD5
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 10:50:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3CT9-0007fD-Sy; Tue, 22 Oct 2024 06:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t3CT5-0007Za-Ry
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:50:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t3CT2-00015F-KH
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729594223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WAEooVzpinCEpYZwuQSn6oLzygBQbX4zyPUpINNF/vU=;
 b=IchXuLppEPm4zYObYO/mmI+5mhjhUdHTo/vFceVQM2CzlEq/clZHpRV/1xhFIGCsAVf04n
 /zONyWjOIE4bIqxVCUQHPFxNWTfXOi5tO7w56vRhB2DnaWGo8I1Jsde6Cr6Sk82sUjJSsf
 MvHhUCR+A/uXyvqh8IUWdh4CeZvvueo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-zhxuPwa_MayRKtS4rGi3WA-1; Tue,
 22 Oct 2024 06:50:19 -0400
X-MC-Unique: zhxuPwa_MayRKtS4rGi3WA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 095F7195608A; Tue, 22 Oct 2024 10:50:14 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.70])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 342EF30001A6; Tue, 22 Oct 2024 10:50:00 +0000 (UTC)
Date: Tue, 22 Oct 2024 12:49:57 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 Hanna Reitz <hreitz@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
Subject: Re: [PATCH v2 01/18] aspeed/smc: Fix write incorrect data into flash
 in user mode
Message-ID: <ZxeDVTBwLZsOEDvE@redhat.com>
References: <20241022094110.1574011-1-jamin_lin@aspeedtech.com>
 <20241022094110.1574011-2-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022094110.1574011-2-jamin_lin@aspeedtech.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 22.10.2024 um 11:40 hat Jamin Lin geschrieben:
> According to the design of ASPEED SPI controllers user mode, users write the
> data to flash, the SPI drivers set the Control Register(0x10) bit 0 and 1
> enter user mode. Then, SPI drivers send flash commands for writing data.
> Finally, SPI drivers set the Control Register (0x10) bit 2 to stop
> active control and restore bit 0 and 1.
> 
> According to the design of ASPEED SMC model, firmware writes the
> Control Register and the "aspeed_smc_flash_update_ctrl" function is called.
> Then, this function verify Control Register(0x10) bit 0 and 1. If it set user
> mode, the value of s->snoop_index is SNOOP_START else SNOOP_OFF.
> If s->snoop_index is SNOOP_START, the "aspeed_smc_do_snoop" function verify
> the first incomming data is a new flash command and writes the corresponding
> dummy bytes if need.
> 
> However, it did not check the current unselect status. If current unselect
> status is "false" and firmware set the IO MODE by Control Register bit 31:28,
> the value of s->snoop_index will be changed to SNOOP_START again and
> "aspeed_smc_do_snoop" misunderstand that the incomming data is the new flash
> command and it causes writing unexpected data into flash.
> 
> Example:
> 1. Firmware set user mode by Control Register bit 0 and 1(0x03)
> 2. SMC model set s->snoop SNOOP_START
> 3. Firmware set Quad Page Program with 4-Byte Address command (0x34)
> 4. SMC model verify this flash command and it needs 4 dummy bytes.
> 5. Firmware send 4 bytes address.
> 6. SMC model receives 4 bytes address
> 7. Firmware set QPI IO MODE by Control Register bit 31. (0x80000003)
> 8. SMC model verify new user mode by Control Register bit 0 and 1.
>    Then, set s->snoop SNOOP_START again. (It is the wrong behavior.)
> 9. Firmware send 0xebd8c134 data and it should be written into flash.
>    However, SMC model misunderstand that the first incoming data, 0x34,
>    is the new command because the value of s->snoop is changed to SNOOP_START.
>    Finally, SMC sned the incorrect data to flash model.
> 
> Introduce a new unselect attribute in AspeedSMCState to save the current
> unselect status for user mode and set it "true" by default.
> Update "aspeed_smc_flash_update_ctrl" function to check the previous unselect
> status. If both new unselect status and previous unselect status is different,
> update s->snoop_index value and call "aspeed_smc_flash_do_select".
> 
> Increase VMStateDescription version.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>

> @@ -1261,12 +1276,13 @@ static void aspeed_smc_realize(DeviceState *dev, Error **errp)
>  
>  static const VMStateDescription vmstate_aspeed_smc = {
>      .name = "aspeed.smc",
> -    .version_id = 2,
> +    .version_id = 3,
>      .minimum_version_id = 2,
>      .fields = (const VMStateField[]) {
>          VMSTATE_UINT32_ARRAY(regs, AspeedSMCState, ASPEED_SMC_R_MAX),
>          VMSTATE_UINT8(snoop_index, AspeedSMCState),
>          VMSTATE_UINT8(snoop_dummies, AspeedSMCState),
> +        VMSTATE_BOOL(unselect, AspeedSMCState),
>          VMSTATE_END_OF_LIST()
>      }
>  };

I think this will break migration compatibility. In order to enable
at least forward migration, it should be:

    VMSTATE_BOOL_V(unselect, AspeedSMCState, 3),

For allowing backwards migration, too, we should consider making it a
subsection instead that allows migration in the default case of an idle
device.

Kevin


