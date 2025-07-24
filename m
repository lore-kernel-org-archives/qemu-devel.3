Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14871C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 10:33:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uetFY-00035r-OV; Thu, 24 Jul 2025 06:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ben.dooks@codethink.co.uk>)
 id 1uetFV-00031r-Se; Thu, 24 Jul 2025 06:32:30 -0400
Received: from imap4.hz.codethink.co.uk ([188.40.203.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ben.dooks@codethink.co.uk>)
 id 1uetFT-0006tv-AL; Thu, 24 Jul 2025 06:32:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sQe45rhbeZfbWgfx6m8i6TjHB9DeZPBvIRqj7Oyu/G0=; b=qvL53ulntLUuyStWnPfEXJNjI5
 2FJRL1qRYAvJt9xvL/yT+WxSWThPv1hz9GGiyy4G6gLQ0zCtaJlbcoR6+eivy4wgl3Ah5K4vaeIbt
 DuAjFI7UFgkMx8UpE/UKfdQTo6RASL0AgOoGWodVJEAYYUUre2iFoVDTE9PI1MD7TBsjydiK7pmzE
 TBfg1Xk57Sx0cUZ4jobUBdaBIc/2pF7nb6eKEDQF3A6micMkhPyd/arPvW4dDBRltUdyOyemIk7jU
 bYfHcZ9Bq+3jrAy1LYgJAMRWXc61Su73j2fzSgJMtoIuhn4b4x+nF0Exp10KAh/uL5vfniw09VSXb
 F+jnncrA==;
Received: from [167.98.27.226] (helo=[10.35.6.194])
 by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1uetFN-001YLX-4a; Thu, 24 Jul 2025 11:32:21 +0100
Message-ID: <840016d0-0d49-4ef4-8372-b62b3bcd0ac6@codethink.co.uk>
Date: Thu, 24 Jul 2025 11:32:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sd: print bad s->arglen in unexpected response
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Bin Meng <bmeng.cn@gmail.com>
References: <20250722090547.109117-1-ben.dooks@codethink.co.uk>
 <87seinulb7.fsf@draig.linaro.org>
 <CAFEAcA8c0GRxvXUANBbNvMdTqBwBgCjTZkqc2RNjE8bRQo772w@mail.gmail.com>
 <197dd05a-eda5-44e0-9592-b886e953086f@codethink.co.uk>
 <f20200a3-1391-45d9-961d-df2fc5996341@linaro.org>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <f20200a3-1391-45d9-961d-df2fc5996341@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=188.40.203.114;
 envelope-from=ben.dooks@codethink.co.uk; helo=imap4.hz.codethink.co.uk
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

On 23/07/2025 17:30, Philippe Mathieu-Daudé wrote:
> Hi Ben,
> 
> On 23/7/25 16:55, Ben Dooks wrote:
> 
>> I am currently trying to track down two errors with mmc-spi.
>>
>> The first looks like u-boot is sending a couple of CMDs (9, 10)
>> in the wrong state (currently this works however with a real SD
>> card) so I have a tmp-fix in to just ignore the two checks in
>> these and u-boot is now working.
>>
>> I'm also getting multiple versions of linux failing with QEMU10
>> on Debian/testing and my own close to the current git tree with
>> Linux and CMD13...
>>
>> [    0.579845] EXT4-fs (mmcblk0): INFO: recovery required on readonly 
>> filesystem
>> [    0.580222] EXT4-fs (mmcblk0): write access will be enabled during 
>> recovery
>> ssi_sd: error: Unexpected response to cmd 13, arglen=16
>> ssi_sd: error: Unexpected response to cmd 13, arglen=16
>> ssi_sd: error: Unexpected response to cmd 13, arglen=16
>> ssi_sd: error: Unexpected response to cmd 13, arglen=16
> 
> CMD13's arg len should be 2 in SSI mode.
> 
>> Then the system stops working.
>>
>> Systems are riscv sifive_u and my own cva6 machine
> Do you mind sharing a reproducer?
> 
> Even better if contributed as a functional test :)
> (see tests/functional/test_arm_sx1.py for example).
> 
> Regards,


So looks like running a kernel directly on sifive_u is stopping
because of this commit:

commit da954d0e32444f122a41c24948d4d1c718bf66d4
Author: Philippe Mathieu-Daudé <philmd@linaro.org>
Date:   Wed Jun 12 23:16:40 2024 +0200

     hw/sd/sdcard: Add spi_cmd_SEND_CSD/CID handlers (CMD9 & CMD10)

     Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
     Tested-by: Cédric Le Goater <clg@redhat.com>
     Reviewed-by: Cédric Le Goater <clg@redhat.com>
     Message-Id: <20240628070216.92609-52-philmd@linaro.org>

  hw/sd/sd.c | 50 ++++++++++++++++++++------------------------------
  1 file changed, 20 insertions(+), 30 deletions(-)

I think the CMD13 might be something else so going to look into that
now.

FYI, qemu command line is

$qemu -M sifive_u -m 1G -s \
	  -kernel ./linux-kernel-mmc/arch/riscv/boot/Image \
	  -append "root=/dev/mmcblk0 rootwait earlycon=sbi conole=ttyS0,115200" \
	  -drive file=./rootfs-le.tmp.ext2,if=sd \
	  -netdev user,id=usernet,hostfwd=tcp::5556-:22 \
	  -nographic 2>&1


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

