Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 251B0D0BB46
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 00:12:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3lRw-0003Um-5k; Wed, 23 Oct 2024 20:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1t3lRu-0003TU-1C
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 20:11:34 -0400
Received: from fly.ash.relay.mailchannels.net ([23.83.222.61])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1t3lRr-0003C4-UR
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 20:11:33 -0400
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 537939426F4;
 Thu, 24 Oct 2024 00:11:28 +0000 (UTC)
Received: from pdx1-sub0-mail-a206.dreamhost.com
 (100-99-180-59.trex-nlb.outbound.svc.cluster.local [100.99.180.59])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id E4DD69426D0;
 Thu, 24 Oct 2024 00:11:27 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1729728687; a=rsa-sha256;
 cv=none;
 b=gO5JKzab1fdFjH8iM3P+gcjKfDsTdXo4kVlmIOfzIf6LemOMVxHvM1pSczqFDAW8F8BmrS
 YxHt3Xw4Y0g/8xaAJ5mQ11IjZlZXf7Je9VSd6HgAsdr/NFUf6E0Vsb6RKvMPskWAqVqjz8
 WLNfNETVEYgO04bkuS9WnIfvR7qQmtpbw8GR+sbQ9c1FCVw4bkpONxXMRT/8ENazr8rs1K
 MPIFYhcoqGsKT9FQFOKMmGka95mpQNso/9zfVlm6254N7xA0zI7KrK8e0P/5XRaLUOABZa
 84M7ec+JswQG0h75OBElC/2LpaMcY11HuePyiALWI7ok3X2peCizGwjly9kZBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1729728687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:dkim-signature;
 bh=iuAyWQcyESR1v3JuX3TByXvN6gsd0PEViL14GajQdB8=;
 b=6GOboNKzkyHQO6tuLcvp3wyDGfHI1WroWsi6DLFfHViqp26eHETfd+AGwkpXYI6Rw0K58N
 vu01Lnq6aopOrry53v9lZS9kbhnzRddfukGEgSUk4NnVx7nYdFL379eeE010MxVxL3zLb3
 KZ7M8TxrTd4wsOmqJQL8j9dUukFZRZhLYypETQ4mOESdWW/1FkcnJ/2jxBdFF+DajhmLuZ
 QXalAeoGXJtVnYNQGy3OTmpGbGQLNMBZ/9ZRu6C6uFgMwlvFKTPO9f+dFSNxl/hlwEjAGJ
 yWjBQ3sWeYQwvqzIPllFmztSuClWRbg/VcpJlKQFzsd6LOtXigAZzGAIT7z7CQ==
ARC-Authentication-Results: i=1; rspamd-7767f6b98-6r5k9;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Name-Spicy: 6e42a35210eb48c5_1729728688177_3008430000
X-MC-Loop-Signature: 1729728688176:2355695738
X-MC-Ingress-Time: 1729728688176
Received: from pdx1-sub0-mail-a206.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.99.180.59 (trex/7.0.2); Thu, 24 Oct 2024 00:11:28 +0000
Received: from [172.22.7.54] (unknown [198.232.126.195])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 (Authenticated sender: rob@landley.net)
 by pdx1-sub0-mail-a206.dreamhost.com (Postfix) with ESMTPSA id 4XYmYC2Q3LzDh; 
 Wed, 23 Oct 2024 17:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
 s=dreamhost; t=1729728687;
 bh=iuAyWQcyESR1v3JuX3TByXvN6gsd0PEViL14GajQdB8=;
 h=Date:To:From:Subject:Content-Type:Content-Transfer-Encoding;
 b=GtEXE511RaFuCduGEcK5v5tCK/Nc2mTcGOmg5aMRqXUKrzJ+1sshmoi+h3358M5Oq
 I/KRD4+FVGqbCf2peKHeYSUTdYbqWMAOiVw/a+y9CU0+PGHudfMyB6LcemWG6NfKv4
 QTfSU9/GRSUnAGbLiXjFVMyUvcQkhqqZ7gIojj8+UvxhpZqA+AjWvc7pwPlS8xuB7B
 r5AYgoT1W5Y9eEQTzSQrvDYO7QyixeEh4KRZQdB4jP80PZuGLYOHHlQf3scXbln7mC
 bjU+HcJ94YKqFxHAzCuwZ1nxLRNXp3B/IlxF6p7gsdew63na8VRXWWmZeTXmro3jIV
 /2jABSRWJei/Q==
Message-ID: <d6755445-1060-48a8-82b6-2f392c21f9b9@landley.net>
Date: Wed, 23 Oct 2024 19:11:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: qemu-devel@nongnu.org, thuth@redhat.com, jeff@coresemi.io,
 peter.maydell@linaro.org, glaubitz@physik.fu-berlin.de
From: Rob Landley <rob@landley.net>
Subject: Please put qemu-system-sh4eb back.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=23.83.222.61; envelope-from=rob@landley.net;
 helo=fly.ash.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

I use it, and ship system images for it:

   https://landley.net/bin/mkroot/latest/sh4eb.tgz

And here's me recentish-ly debugging an issue via it:

  https://landley.net/notes-2024.html#24-05-2024

(Compile/test cycles are WAY easier there than copying files onto an sd 
card to test on actual hardware.)

There was a big-endian issue breaking r2d last year, but it also broke 
big endian mips and some other targets too, and it got fixed. The binary 
I built a few months ago was working fine for me with vanilla qemu git 
source? (I don't _think_ I had local changes?) I can try to build the 
version removed to check that...

Yes I should be better about pushing local patches upstream. For 
example, here's the kernel patch I use to run fdpic binaries under qemu:

https://landley.net/bin/mkroot/latest/linux-patches/0002-sh4-fdpic.patch

Which lets you enable the FDPIC loader on an mmu kernel, which is useful 
for testing j-core userspace under qemu.

Rob

