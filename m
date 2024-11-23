Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B677E6ADD3
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2024 00:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEeQ4-00037p-SX; Fri, 22 Nov 2024 19:54:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1tEePw-00037X-QH
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 19:54:34 -0500
Received: from shrimp.cherry.relay.mailchannels.net ([23.83.223.164])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1tEePt-0001vS-JM
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 19:54:31 -0500
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id D0B5E1645DF;
 Sat, 23 Nov 2024 00:54:22 +0000 (UTC)
Received: from pdx1-sub0-mail-a293.dreamhost.com
 (100-122-114-63.trex-nlb.outbound.svc.cluster.local [100.122.114.63])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 758031648B0;
 Sat, 23 Nov 2024 00:54:22 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1732323262; a=rsa-sha256;
 cv=none;
 b=yRrX3aKakcIo/Rx7LcTUVQ030MTwrAWIAIB3DWzrJelaS0hOZd9mSU9WyF3cFbNFsARoQl
 FgBkKEBezizwpXRqeOKwhPmNTxyBb4S4DHDy9eDhgKtJnhTJqcSHu8BuAFyh0QGSu4Eltt
 H3kFHg2mVSgmyr9J4Cl9PYUNFZkwZSckmKCFzckeaRLhvga5PXNsaW4ccJ+15SB1gkzGsL
 TmfpjXX4FA2lfIINYXOuAZAvx0AXbTNmEEpPJtPmGxjphGF6mgxy1alijdJYwmpK8QjA4F
 e8VXKw70s/NJsqHR8mW3cK6U1GgKGxhHwSPbl9Wh+vXVTdq/nMU82Xq3nSyPTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1732323262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=V0CqhsWxOD7dto3rWjqVqr+/q/9ea292RF/M+Dcl0aY=;
 b=xU97YshMkV3zBT/JNaLcM4Fa15Zt7fLFjRc2OPGvNq65BbA0KQfActKbxRHxGg8Fq3EzxB
 fau5dDHfXuj/UA9I/pGOzf5E4EJ3F8Sr4oipmzxfiZlZ3Tr6iMD2kRhZ7NoEEVNCymzSc5
 3ZbVA6z9fLzXvI+nbarJAJdp4tx4dH6XcCnoTjqLBV7P8ni1KxZoq6SHhGrNGM5gmmL582
 /jcIgXxbnwdP6HG0DAEpGE5eLl7KTk0Hpx2ukpqSYcD64L8fLddB166YT+fRQNmakJ9rg+
 opsPC2bNn4T+rzllPbvkhky9lZeNAaM1msQdmpJVGUUqv0jp8j4iq+cxMpDbLQ==
ARC-Authentication-Results: i=1; rspamd-868968d99d-mkkh4;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Whimsical-Army: 0c06c1672e0b6094_1732323262710_1228245726
X-MC-Loop-Signature: 1732323262710:3948981509
X-MC-Ingress-Time: 1732323262710
Received: from pdx1-sub0-mail-a293.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.122.114.63 (trex/7.0.2); Sat, 23 Nov 2024 00:54:22 +0000
Received: from [172.22.7.54] (unknown [198.232.126.195])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: rob@landley.net)
 by pdx1-sub0-mail-a293.dreamhost.com (Postfix) with ESMTPSA id 4XwD4s6wm4z2M; 
 Fri, 22 Nov 2024 16:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
 s=dreamhost; t=1732323262;
 bh=V0CqhsWxOD7dto3rWjqVqr+/q/9ea292RF/M+Dcl0aY=;
 h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
 b=YaQcuwz3yM+sT6ml0QW5y+irWN2V5xi1/SZ9K1b/LcZ5VGkdCTOhT+fQWHTQlHZk/
 txFArup9FvyCLvzV9GG6gQSP76EdN5I6AUXv6u9YI7+mW70QYDya519usTYwp0qzxU
 rBqlRWo6ev12qRLMOIb7uWt3stfc/om6brE7ZaEhc2ratpXs4skQ+42AzqWk6Z/NE+
 798TWvYKoVTtMpG9kSh+rnmTZ/9/AkIQxlFhTIxBJyorVlFtcZz8q3ECAd2rqcqlCD
 H1TzPzebIoW+GaJTApxZ+jzl6XxA74/qGlV7V8SJbHM0wHp3CZYE49rnO+YkeBo9sW
 ZRS7Px5SKaNCQ==
Message-ID: <31fa6255-8e0c-4d05-bad9-dd843c676244@landley.net>
Date: Fri, 22 Nov 2024 18:54:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QEMU commit 0a923be2f642 broke my or1k image.
To: Stafford Horne <shorne@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <afac091f-08cb-0f6d-4c01-bfa4421e7a47@landley.net>
 <Zufcf4iAqosZ7VBf@antec> <9b2761aa-8ee0-4399-b237-31e70e3ed165@landley.net>
 <Z0Cyx3i3z7Zl7XPm@antec>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <Z0Cyx3i3z7Zl7XPm@antec>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=23.83.223.164; envelope-from=rob@landley.net;
 helo=shrimp.cherry.relay.mailchannels.net
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=no autolearn_force=no
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

On 11/22/24 10:35, Stafford Horne wrote:
>> I just regression tested linux-6.12 against qemu-9.2.0-rc1 and I'm still
>> getting no output from or1k, with the current image or the old or1k release
>> image that worked under old qemu versions.
>>
>> I tried applying your serial patch to current qemu, and it made no
>> difference: still no output booting the image.
> 
> OK, I am trying to get that patch pushed upstream.  I will be sure we fix your
> issues before we do that.

Thanks. Let me know how/if I can help.

>> Alas I can no longer test that reverting the commit I identified (git show
>> $HASH | patch -p1 -r) makes it work again in current qemu (although it did
>> at one point, that's a standard sanity check at the end of bisect for me),
>> and I can't fix it up by hand either because hw/openrisc/openrisc_sim.c no
>> longer contains the string "load_sim", looks like it got collated with
>> common code for other architectures.
>>
>> I'm happy to tweak the kernel config if qemu changed in a way that broke
>> compatibility with old images (I assume _you_ have a kernel that boots), but
>> I was hoping "this week's kernel release" would have any necessary patches
>> to work with QEMU's changed ABI.
> 
> The patch I have put in 6.12 only helps with earlycon.  Regular output has
> always been working for me.  I will work on testing your image again to see what
> is special about it.

Just a guess, but given the alignment change, I suspect it's barfing on 
the statically linked initramfs? That seems the most likely step to go 
off the rails given the failing patch is a symbol alignment change in 
the flattened device tree plumbing, and I think the initramfs extractor 
parses device trees very early on to find stuff (I forget why). Moving 
"where the data lives" without a corresponding change to the "where to 
look for the data" code seems a bit strange, but it's not my area...

Here's the miniconfig I built 6.12 with (90% of which is generic to all 
the architectures I'm testing, the sections are labeled. The 
console="FIXME" bit is because I can't get qemu-system-or1k -append 
"blah" to go through to linux, so I stuck FIXME in that field for the 
or1k target and it wound up in the output):

# make ARCH=openrisc allnoconfig KCONFIG_ALLCONFIG=linux-miniconfig
# make ARCH=openrisc -j $(nproc)
# boot vmlinux console=FIXME

# architecture independent
CONFIG_PANIC_TIMEOUT=1
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_RD_GZIP=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_UTF8=y
CONFIG_MISC_FILESYSTEMS=y
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_SQUASHFS=y
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_NET=y
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
CONFIG_NETCONSOLE=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IPV6=y
CONFIG_ETHERNET=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_EARLY_PRINTK=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y

# architecture specific
CONFIG_ETHOC=y
CONFIG_SERIO=y
CONFIG_SERIAL_OF_PLATFORM=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_OPENRISC_BUILTIN_DTB="or1ksim"

# architecture extra
CONFIG_INITRAMFS_SOURCE="../../root/or1k/fs"

And then run-qemu.sh is just:

DIR="$(dirname $0)"; qemu-system-or1k -M or1k-sim -m 256 "$@" -nographic 
-no-reboot -kernel "$DIR"/linux-kernel -append "HOST=or1k console=FIXME 
$KARGS"
echo -e '\e[?7h'

(The echo is because some qemu bioses disable wordwrap in the terminal 
and leave it broken, driving bash cursor-up history nuts. My plumbing 
just sticks a reset in all the architectures' scripts...)

The or1k support in mkroot is the 4 lines at:

   https://github.com/landley/toybox/blob/master/mkroot/mkroot.sh#L256

(I'd cut and paste them here but thunderbird wordwraps everything.)

Also, looking at that, I'm using a builtin DTB and you might be passing 
one in via -dtb? Another thing the alignment change might break...

> Note, I did find some issues with the kernel nor properly handling stdout-path.
> It seems that if there are multiple uarts the first one will always be used as
> the default uart.  Only the console= command line argument can be used to
> override that.

I've never managed to get console= to go through to linux in 
qemu-system-or1k. The above tries but is ignored.

It's also doing a statically linked initramfs because -initrd didn't 
work on this target. Happy to update if it's been fixed, the other 
targets are almost all using -initrd to feed in an external cpio.gz

> So as long as the kernel selects the first uart as the stdout path (it should
> have always been the case)  AND qemu picks the first uart as the uart connected
> to the console (it should be with my latest patch) we should get serial output.

The commit in question is not changing UART configuration. It's changing 
the alignment of a symbol. Your patch to the UART plumbing did not fix 
it. I don't see how the UART configuration could have changed between 
the "working" and "not working" states.

> Another thing that may get me delayed is that I need to rebuild my or1k-elf-gdb
> as it's python version is no longer compatible with the kernel's python.

Yeah, Python 3's forced upgrade treadmill is deeply silly. I'm not a 
fan: https://landley.net/notes-2024.html#09-04-2024

(I know they're doing it to make sure they never have another "our 
userbase refuses to move off 2.0 for a full decade" moment by holding 
tightly to the control they wrested away from their users and never 
giving an inch back now they've forced the issue, by making sure their 
code spoils like milk and the installed base is regularly slashed and 
burned, but for me that just means "use lua" or something. Yes your dev 
team had trauma. So did the perl guys, who eventually gave UP forcing 
their transition down an unwilling userbase's throat... But again, not 
my area.)

> -Stafford

Rob

