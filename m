Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4137E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 17:30:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPPlj-0007MR-Oz; Sun, 22 Dec 2024 12:29:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1tPPli-0007LP-AZ
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 12:29:30 -0500
Received: from toucan.tulip.relay.mailchannels.net ([23.83.218.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1tPPlf-00026Y-Ax
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 12:29:30 -0500
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 9A1D8781913;
 Sun, 22 Dec 2024 17:29:21 +0000 (UTC)
Received: from pdx1-sub0-mail-a313.dreamhost.com
 (trex-2.trex.outbound.svc.cluster.local [100.103.141.155])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 1DA707818A6;
 Sun, 22 Dec 2024 17:29:21 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1734888561; a=rsa-sha256;
 cv=none;
 b=zVvmf0zFW8pcJoOl+UL1vTi8NY4eBIztM/lO9A2LqSUIOw+BXNnquE22GXGCT+PF3O4hvY
 Rjdj+ByY6a/A5S1ujl06bDeDydxqBgfgHk3ovo7ZS4OsmuENmoRAF55G5W0StIfOTjhecx
 Kd1La0+Y/i2CTzxD3NC++j/S5R1I23n0qzDN6MRYrrIV15sm5J8NT9nE+wXm6sRZ4kzMbU
 HF3yIvwC/OtrHsobKtE1mg8V/2mnsFBVX0tRFeF5z2QOhuLxjPsIQu7xSzkDWveIGOJ8wt
 GN6omx7Hm0qZy105XNLGCUEzxI4MbN8awgvBn73WwdbPNj0Nn1p0Qkz3mjjCRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1734888561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=YbgWa4UMw5ktgyOFJVe/THfkUfRyxm495CfoYSajlE4=;
 b=UlolBv1s4sg4cs3nNyJn9EZ6OmmuenCGYt7LFbYvvP1Ufs3xmISdRBWkIizGNmI8SEuRfH
 ZxzG0X2echZ1i5minEWPsNdwgHrtOq4H4F9hWxhNnbnI87z9/wttqSj3WR2cqI7HKx8d9l
 ssGJCw4/+6wuIY4kw7o3ynrhxzBZNcXBLtxJYUH2GRjBLUWbQSYrRF2EvhExi3rCsVcjLR
 8zmL1Fe1KDd5HpJQHL1wfwJZAccOSKd+NmzjDmPO30hI03ClE8pWoBigmtO3HlRCHaF9Hy
 h24AtVThmbeh0yxDXSjCbxuiXXIVyRhooqCM4ay9qdZvHr3vuzOHKq1wxrrsVA==
ARC-Authentication-Results: i=1; rspamd-7d788bbf85-6cg98;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Industry-Oafish: 31b878767ea5240a_1734888561365_218295845
X-MC-Loop-Signature: 1734888561365:2659016520
X-MC-Ingress-Time: 1734888561365
Received: from pdx1-sub0-mail-a313.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.103.141.155 (trex/7.0.2); Sun, 22 Dec 2024 17:29:21 +0000
Received: from [172.22.7.54] (unknown [198.232.126.195])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: rob@landley.net)
 by pdx1-sub0-mail-a313.dreamhost.com (Postfix) with ESMTPSA id 4YGSnX4L5Vz5h; 
 Sun, 22 Dec 2024 09:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
 s=dreamhost; t=1734888561;
 bh=YbgWa4UMw5ktgyOFJVe/THfkUfRyxm495CfoYSajlE4=;
 h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
 b=AoetgOrtsZ3MHetHighQ2C4nP3i2biyzWMeOY/y1JpcscmZPOR3CKlInes2QMNKtl
 CXRRDqwegKagFJ9mtpYwamyd9UhLwX6YCMBaU/R/z1bHpUsHTASxeMIF0NA+VPzgCM
 BoutzyIEWKXkSw9Y0zmV0RyPnNY1PzYyJZPNMxkFAarZjlbKDsOppLOa1K3MMRgUL8
 m2ATvHnxjy/lqaaPllKA6viMjcqIn9JRx9g5O2mBwfNqRNv0GY4YPYA+vtXMqo+ccX
 ++MgiuVqGtD7D8vuu5xyUxj2T2Luui+m9MuZ0e18NjkyFc2cvVOfg2xQ6cb4B9h9+N
 zhceauqh2M9Ww==
Message-ID: <57c5207c-3aca-47cd-bfd3-3d7eb7be3c0f@landley.net>
Date: Sun, 22 Dec 2024 11:29:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: or1k -M virt -hda and net.
To: Stafford Horne <shorne@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <afac091f-08cb-0f6d-4c01-bfa4421e7a47@landley.net>
 <Zufcf4iAqosZ7VBf@antec> <9b2761aa-8ee0-4399-b237-31e70e3ed165@landley.net>
 <Z0Cyx3i3z7Zl7XPm@antec> <31fa6255-8e0c-4d05-bad9-dd843c676244@landley.net>
 <Z0GSETLeT5w8B2DX@antec> <87a6b910-5af6-47ad-ad8d-b79f11a7cbf2@landley.net>
 <Z0LMqEqcdjkAxnN-@antec>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <Z0LMqEqcdjkAxnN-@antec>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=23.83.218.254; envelope-from=rob@landley.net;
 helo=toucan.tulip.relay.mailchannels.net
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

On 11/24/24 00:50, Stafford Horne wrote:
>> Speaking of which, is there a way to get or1k to exit the emulator? I told
>> the kernel to reboot but it says "reboot failed, system halted" and hangs
>> instead of exiting qemu. (My testroot runs qemu under "timeout -i 10" to
>> kill it after 10 seconds of inactivity, I.E. nothing written to stdout, but
>> it still counts as a failure on one of the criteria.)
> 
> With the or1k-sim board it is not possible.  Traditionally on or1k we use
> special NOP instructions to reboot simulators i.e. 'l.nop 1'.  The QEMU team was
> not happy to support this mechanism.
> 
>    https://lore.kernel.org/openrisc/fb69c137317a365dcb549dfef1ecd2fbff48e92c.1492384862.git.shorne@gmail.com/T/#mef76d30d294aed84548b1e0d3e23aae499deaeec
> 
> As an alertnative we can use the 'virt' board which supports shutdown and
> restart via the generic syscon drivers.
> 
>      $ grep -C1 SYSCON arch/openrisc/configs/virt_defconfig
>      CONFIG_POWER_RESET=y
>      CONFIG_POWER_RESET_SYSCON=y
>      CONFIG_POWER_RESET_SYSCON_POWEROFF=y
>      CONFIG_SYSCON_REBOOT_MODE=y
>      # CONFIG_HWMON is not set

I built the 6.12 ARCH=openrisc virt_defconfig and got it to boot my 
initramfs, but while it does shut down, it hasn't got network or block 
device support.

The kernel config looks like it should have virt block device support, 
but nether -hda README nor "-drive file=README,format=raw,id=hd0 -device 
virtio-blk-device,drive=hd0" seem to be wiring it up in qemu where the 
kernel can find it?

Haven't tried to get fancy with the network yet. The buildroot config is 
still or1ksim...

Rob

