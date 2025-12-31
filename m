Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7BFCEE57D5
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Dec 2025 07:33:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaqhF-0006hl-0b; Wed, 31 Dec 2025 02:32:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1vaqhD-0006hL-KM
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 02:32:39 -0500
Received: from fly.ash.relay.mailchannels.net ([23.83.222.61])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1vaqhB-0000r4-UW
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 02:32:39 -0500
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id AD5A4560D5D;
 Wed, 31 Dec 2025 07:32:33 +0000 (UTC)
Received: from pdx1-sub0-mail-a256.dreamhost.com
 (trex-green-1.trex.outbound.svc.cluster.local [100.105.251.151])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id E7123560C56;
 Wed, 31 Dec 2025 07:32:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
 t=1767166351;
 b=GuvFTsz3q0JDjqJtzfTTA11t7QOUu82x84gDnFPDIkzYDP4LdHvZPK/+Vk/S8V/pQp7KOE
 HQJWeGyr2Sk6yT8VpCOgApRmYlJAeCkCf0SfTqpa7ZY9MO/BvAxbNWGmB/JFfC2qro2c4W
 Bbs51t2f4HqxAdQnsXFi0bpE48C8mq5US3yk1UHGsE3qmLU9HXZN89yob3SxbnRI9o3F2w
 ygApcWumt6IafZYz1Kqv6bf05bGtGz1SVK0WZstlFJxAvx8D3EDAmHD+kkHUjuveeyVBve
 yFSdgOk4Eh1dJEpeC0gb1f6T/2GXFAeUSLTVuI8tXz4TCoKnSPA8rlnhiqlK2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1767166351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=6zrZGd2BCW99SGJESQjUy40dHZAlsUkcw1EybcsdFvY=;
 b=MnuMkBOehvP+JhD9wG22DcCxQHQqrjSYPNo5VzlnUqZE6KCfporLeOg2W8KFy+qw9bab00
 +5LXjjFEDTmIu9/C98K4QJv1QwpzlbvbMscVWd+4be3mRFUF/KEOEnmax6lTglsTP+gnNz
 q5SSIROrdiIZ2yaUxPreernPEMeez+SskifFpDvG/eZ/VrEOlbzqIGdfJgaK0s2T6ADQrQ
 cJ04wD8twryogMDxq9izZR4vebihsuKiu6FuSQQZ+GOVqiGXCLikw4CV7KNCFxP+9SFeHk
 A3PNlRDtArDwt/SznkYLCHe7+/+tO5bPYczkIL3hFCrEkT7fsyDcuhxH7CjOow==
ARC-Authentication-Results: i=1; rspamd-69599c6f48-g57fg;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Plucky-Celery: 2c0abe962cd35c32_1767166353202_3002770154
X-MC-Loop-Signature: 1767166353202:1354852251
X-MC-Ingress-Time: 1767166353201
Received: from pdx1-sub0-mail-a256.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.105.251.151 (trex/7.1.3); Wed, 31 Dec 2025 07:32:33 +0000
Received: from [IPV6:2607:fb90:fa85:cea:c1aa:4813:f755:98f6] (unknown
 [172.56.10.2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: rob@landley.net)
 by pdx1-sub0-mail-a256.dreamhost.com (Postfix) with ESMTPSA id 4dh1rG1ZWsz105C;
 Tue, 30 Dec 2025 23:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
 s=dreamhost; t=1767166350;
 bh=6zrZGd2BCW99SGJESQjUy40dHZAlsUkcw1EybcsdFvY=;
 h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
 b=LDacERJwqn421g8uPoPIo1jYZtUVByC/LmMlPgjI9Bv8vAyKtFvI8aXMjpOJxmjWz
 OK1IdqqUy+D9ITinyei/5ez7x2nPYAipsz/b14fPMGOOxQyYXb3Z6qdUqn6asybAxQ
 1LuYWBJekhs7bpAFwP0PfsqDQ58dSWwvCz+PwnVEtIO82jVglOZ2Yml+jHVAQeucMT
 RXpFgRbmgFKfoFW5TewwkC5z7rjZoNgVJERxELMu2QPeZvkO8dJ5SGp5DIhXN8U3Wf
 KzWYd4puDAPfANr1EoXiFwuQgBeIh7Qk3EoN2QGBs2YkOttkGaYbrqz3Gr8yXyxjhC
 VU4BkK+fwruMg==
Message-ID: <a841c041-30c2-471c-81bc-f0f4576cb772@landley.net>
Date: Wed, 31 Dec 2025 01:32:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0 01/13] hw/sh4/r2d: Bail out early if user request
 invalid RAM size
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 qemu-devel@nongnu.org
Cc: Thorsten Glaser <tg@debian.org>, Yoshinori Sato
 <yoshinori.sato@nifty.com>, Magnus Damm <magnus.damm@gmail.com>
References: <20251124095109.66091-1-philmd@linaro.org>
 <20251124095109.66091-2-philmd@linaro.org>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <20251124095109.66091-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.222.61; envelope-from=rob@landley.net;
 helo=fly.ash.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 11/24/25 03:50, Philippe Mathieu-Daudé wrote:
> Do not give false expectations, as this machine only
> uses 64MB of RAM.

This broke my https://landley.net/bin/mkroot/0.8.13/sh4.tgz because 
every target in that directory does -m 256 as part of the template from 
https://github.com/landley/toybox/blob/0.8.13/mkroot/mkroot.sh#L333 
which worked until now.

I can special case qemu-system-sh4 but that won't fix compatibility with 
existing shipped instances. Could you maybe just turn this into a 
warning instead of -Werror in production?

I fixed it up by hand for testing in the meantime, and it loaded the 
kernel with -m 192 but then initramfs couldn't find init. Without the 
patch series the same git version (942b0d378a1d) booted to a shell 
prompt. I can try to track down what happened in the morning...

Sorry if I missed newer stuff I should be testing instead, I've been a 
bit distracted.

Thanks,

Rob

