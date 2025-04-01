Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B09BC36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 13:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzbfB-0007yU-Iw; Tue, 01 Apr 2025 09:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tzbf6-0007xV-Rq
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:28:17 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tzbf4-0004JN-EE
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:28:16 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-227914acd20so98008855ad.1
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 06:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743514093; x=1744118893; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/AhLmeGAi4YZkxbMKqI9apUwWgH0VLutA9ZY5rjyqmg=;
 b=QVVSVC+ytRl5bMYWiFLix7q56PbSiQsmP3pe8pyrlgUJJadsMf0A0EoWHY6CC1dMj/
 bvYTyHkDq1au9qgDFfPYXUhVUoAdRLTv4Ya2Sf1In3mb2Fp7JD+W+PJL+3Zn4ZlDPGs1
 9j4rIubDhOBGUhbnInPBANekUl6Xb2hpuXL9Zdg2vIaMwflKCbO6ymFDjBORX9/sQx/v
 PDaKE3JUrb1WSOzp5G+ePNJhqJD6sBMQ2e0j4EgT27kCtSyAMme38mk7k+9BlaGH5lWu
 ns1B2am1gCHiMcwsDbRucn+ptm6kFWtMa0VIiQ+ehi25N020DeWL0+JodQ1MCHwTRcmz
 a+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743514093; x=1744118893;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/AhLmeGAi4YZkxbMKqI9apUwWgH0VLutA9ZY5rjyqmg=;
 b=TbU656dAgGEEpfEvIr82srWYk4dhVb62HeUQBVYjHHW+cSeXLd51ycki8vbBo/XrpC
 X5Vefxt1GjZe9Fp5Yly2dY05vGNJXwlJgw7tIyzOx+ErDDFte0QRTu5wuf6uk7H/jRaD
 BJiY1YZmfZON/fN/lPin/ggHxFWR0DYjgDwyTIKsXxFMJay8hVDDSgjma/HefxVPto9D
 i1QcPmpM7A4K2KhAeXz2mcLNq/ZcSmwPRfyEyTtX560gl38nGQpNB10YkntDztOCp/kP
 fxbolFwHX2q61MLIWcZikLL5S+0YxMGRJHeh0EwYKtHA79JGOJLCZYlQIz12La6Bx2QK
 xFxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVd3fb9l/yQwyqKgaJR0IL1+JXeQpvV2T6sw31y5bm+CROHeP6Oj7zhPyDQ1QlWXaRXyeISCFYVMp7@nongnu.org
X-Gm-Message-State: AOJu0Yxh4z/r+WUw9dQMxUpEue9V9r5b2hvxtHySv5Thnfx0sFJc97sl
 509227HFQ3ivGQ09J4eue+IbKgj7RqXlMkqdPqxuE4HPNieHFokl
X-Gm-Gg: ASbGncvYVKplmdmwA3CHdrJ/2wOjTOmrsNirihf+7nVqBXuGNIDukX+mOBU7bsCWmiZ
 lgnVlxfqRciY4ubkGdoZ6hFd97hZ9cUb6JxZJKcACebt7H931pQTcJan2kapVy4xkI+uxcMQui7
 GTcszkY0qNnFCEyDtn+UDyc2HJYsgbKYV0uzVFSmoCqCoz29dT1eXLknhtqt2e5E0FRJZxMbx9c
 SwRy+3wSk2s9auJLYlogJTbVkKSjsegXT80OeiWiqGpPKTAJaUpeOj+VfvQbV3sHj5q+iSr1avl
 283K/QrixAOCI1EdVKN487mlSye85IjTeY+Em9urnCw60oZX+g==
X-Google-Smtp-Source: AGHT+IHvdxheGcUSUcVcY1MUX8V5omydVi/at9lavDdHwR25p16+fc+yV0mQBwQqi1kuCMDu5zFo3w==
X-Received: by 2002:a17:90a:d007:b0:2f1:2e10:8160 with SMTP id
 98e67ed59e1d1-305319e146fmr23636571a91.11.1743514092760; 
 Tue, 01 Apr 2025 06:28:12 -0700 (PDT)
Received: from localhost ([203.185.207.94]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3039dfd497csm12784655a91.5.2025.04.01.06.28.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 06:28:12 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Apr 2025 23:28:08 +1000
Message-Id: <D8VC5UV38OGF.2WYX1ZFTAS3RV@gmail.com>
To: <corey@minyard.net>
Cc: "Corey Minyard" <minyard@acm.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 4/5] ipmi/bmc-sim: implement watchdog dont log flag
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.19.0
References: <20250401114412.676636-1-npiggin@gmail.com>
 <20250401114412.676636-5-npiggin@gmail.com>
 <Z-vkh-c-TwvLQM0O@mail.minyard.net>
In-Reply-To: <Z-vkh-c-TwvLQM0O@mail.minyard.net>
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue Apr 1, 2025 at 11:05 PM AEST, Corey Minyard wrote:
> On Tue, Apr 01, 2025 at 09:44:11PM +1000, Nicholas Piggin wrote:
>> If the dont-log flag is set in the 'timer use' field for the
>> 'set watchdog' command, a watchdog timeout will not get logged as
>> a timer use expiration.
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>  hw/ipmi/ipmi_bmc_sim.c | 32 ++++++++++++++++++++++----------
>>  1 file changed, 22 insertions(+), 10 deletions(-)
>>=20
>> diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
>> index 216bf8ff7f0..3cefc69f8a8 100644
>> --- a/hw/ipmi/ipmi_bmc_sim.c
>> +++ b/hw/ipmi/ipmi_bmc_sim.c
>> @@ -514,7 +514,8 @@ static void gen_event(IPMIBmcSim *ibs, unsigned int =
sens_num, uint8_t deassert,
>> =20
>>  static void sensor_set_discrete_bit(IPMIBmcSim *ibs, unsigned int senso=
r,
>>                                      unsigned int bit, unsigned int val,
>> -                                    uint8_t evd1, uint8_t evd2, uint8_t=
 evd3)
>> +                                    uint8_t evd1, uint8_t evd2, uint8_t=
 evd3,
>> +                                    bool do_log)
>>  {
>>      IPMISensor *sens;
>>      uint16_t mask;
>> @@ -534,7 +535,7 @@ static void sensor_set_discrete_bit(IPMIBmcSim *ibs,=
 unsigned int sensor,
>>              return; /* Already asserted */
>>          }
>>          sens->assert_states |=3D mask & sens->assert_suppt;
>> -        if (sens->assert_enable & mask & sens->assert_states) {
>> +        if (do_log && (sens->assert_enable & mask & sens->assert_states=
)) {
>>              /* Send an event on assert */
>>              gen_event(ibs, sensor, 0, evd1, evd2, evd3);
>>          }
>> @@ -544,7 +545,7 @@ static void sensor_set_discrete_bit(IPMIBmcSim *ibs,=
 unsigned int sensor,
>>              return; /* Already deasserted */
>>          }
>>          sens->deassert_states |=3D mask & sens->deassert_suppt;
>> -        if (sens->deassert_enable & mask & sens->deassert_states) {
>> +        if (do_log && (sens->deassert_enable & mask & sens->deassert_st=
ates)) {
>>              /* Send an event on deassert */
>>              gen_event(ibs, sensor, 1, evd1, evd2, evd3);
>>          }
>> @@ -700,6 +701,7 @@ static void ipmi_sim_handle_timeout(IPMIBmcSim *ibs)
>>  {
>>      IPMIInterface *s =3D ibs->parent.intf;
>>      IPMIInterfaceClass *k =3D IPMI_INTERFACE_GET_CLASS(s);
>> +    bool do_log =3D !IPMI_BMC_WATCHDOG_GET_DONT_LOG(ibs);
>> =20
>>      if (!ibs->watchdog_running) {
>>          goto out;
>> @@ -711,14 +713,16 @@ static void ipmi_sim_handle_timeout(IPMIBmcSim *ib=
s)
>>              ibs->msg_flags |=3D IPMI_BMC_MSG_FLAG_WATCHDOG_TIMEOUT_MASK=
;
>>              k->do_hw_op(s, IPMI_SEND_NMI, 0);
>>              sensor_set_discrete_bit(ibs, IPMI_WATCHDOG_SENSOR, 8, 1,
>> -                                    0xc8, (2 << 4) | 0xf, 0xff);
>> +                                    0xc8, (2 << 4) | 0xf, 0xff,
>> +                                    do_log);
>>              break;
>> =20
>>          case IPMI_BMC_WATCHDOG_PRE_MSG_INT:
>>              ibs->msg_flags |=3D IPMI_BMC_MSG_FLAG_WATCHDOG_TIMEOUT_MASK=
;
>>              k->set_atn(s, 1, attn_irq_enabled(ibs));
>>              sensor_set_discrete_bit(ibs, IPMI_WATCHDOG_SENSOR, 8, 1,
>> -                                    0xc8, (3 << 4) | 0xf, 0xff);
>> +                                    0xc8, (3 << 4) | 0xf, 0xff,
>> +                                    do_log);
>>              break;
>> =20
>>          default:
>> @@ -734,28 +738,36 @@ static void ipmi_sim_handle_timeout(IPMIBmcSim *ib=
s)
>> =20
>>   do_full_expiry:
>>      ibs->watchdog_running =3D 0; /* Stop the watchdog on a timeout */
>> -    ibs->watchdog_expired |=3D (1 << IPMI_BMC_WATCHDOG_GET_USE(ibs));
>> +
>> +    if (do_log) {
>> +        ibs->watchdog_expired |=3D (1 << IPMI_BMC_WATCHDOG_GET_USE(ibs)=
);
>> +    }
>> +
>
> This change needs to be removed.  watchdog_expired has nothing to do
> with logs, it's a field reporting in another message.

Okay you're right, I read through the spec again and yes I was
mistaken on this field.

Thanks,
Nick

