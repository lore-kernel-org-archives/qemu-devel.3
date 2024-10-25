Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090F5D149C0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 16:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Msp-0003EO-MD; Fri, 25 Oct 2024 12:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1t4MsQ-0002yp-Mu
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:09:26 -0400
Received: from iguana.tulip.relay.mailchannels.net ([23.83.218.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1t4MsO-0005PR-EW
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:09:26 -0400
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 40A2F1C27F3;
 Fri, 25 Oct 2024 16:09:22 +0000 (UTC)
Received: from pdx1-sub0-mail-a233.dreamhost.com
 (trex-0.trex.outbound.svc.cluster.local [100.99.209.54])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id AA1E01C303C;
 Fri, 25 Oct 2024 16:09:21 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1729872561; a=rsa-sha256;
 cv=none;
 b=ao3uzSJcrzGzcfs4hqpaT7nBfChvbj5E7FyV6QRJqGoDbu1hyV0M0oLwK4yyTHm4AtrlR+
 rn1wEtyy5NHvJBjNWg9wEZw++APztW9F0neCfEnNnZG6SCbC1JZENtdqY3WA5eZ1UGMnWc
 GwiDObi8s7PDs2U+D0gfzOQZu9NdsrjR4hjh6TIHV8/o/iUUQl15PCNb8cKqm/fXteYwMM
 Dlhq0Q5tjDboWZgZsEmxcFvRLAF7f9qDuFz/l/OLXcxawN4xS0gWfbVJtyEN9rtiE77bTw
 OzsPjFa1RfA2e17UHg6nYCd1kmlQaL400g89SpztcsBokP496BUHeDUUGFC6hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1729872561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=IdmirYyRblDuI+AZaBO+p4heqJBXcuAld70rKQqHWYo=;
 b=YWPSe0kZ4g9SpYFWCOXrN5RSWiSIQJ4nT8zKqupmoNlwYNVv7sYRTkLxBf4hbuqHL9qaDs
 lt3QLaqHALMingf0k0eVNZNj0QO4kJF0VUUr4RrY0fWQQz2MpF/OZU5AhXH6tSlAwIaarQ
 GehreLXok+ic0Yuho8h1Q9dQ2ZfLKkbv/+K6tKNTF/5qlo+bsTrWppqsQkRtSC/GhSuITA
 gdISC5j6cgijqcXtaWP5daBG7Un/sbdwEukVp1wCovzkW+CIsE2uPybzJz/JCzphvoRsQI
 lK4kCZhAriYaDukPZ/fx6TPb+E2SpUx11zB5oW3qmbOtB11+CtDbdlTLL/kDdQ==
ARC-Authentication-Results: i=1; rspamd-547c589df-6fk22;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Eight-Stretch: 71241ae648e0fd8a_1729872562090_1195396160
X-MC-Loop-Signature: 1729872562090:2375849557
X-MC-Ingress-Time: 1729872562090
Received: from pdx1-sub0-mail-a233.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.99.209.54 (trex/7.0.2); Fri, 25 Oct 2024 16:09:22 +0000
Received: from [172.22.7.54] (unknown [198.232.126.195])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 (Authenticated sender: rob@landley.net)
 by pdx1-sub0-mail-a233.dreamhost.com (Postfix) with ESMTPSA id 4XZnm101DTz4h; 
 Fri, 25 Oct 2024 09:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
 s=dreamhost; t=1729872561;
 bh=IdmirYyRblDuI+AZaBO+p4heqJBXcuAld70rKQqHWYo=;
 h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
 b=rIBm0akqPE/KxyZJtniobhWghvIiQJjfGY5KoS6VcbW2dGQpO6LnvqPZWEAlHoQLt
 TodWOG2hvG6OKIFRiVo8ZQcfSwQortgrLNHw7ou/Eoc87/Uwi8JjvzCgWxKVShhJsS
 WHAsSqdX0qfV2OxXWGqmz5qCzLEOEYv6XG8zT/iHBxZHDyl9Zmo7pGvP4jP2CNSfMB
 HDdCWYU7TadzlreSaw5g5DXstKasG9/Ew26+LPzBI2S/QdbozkbrMCK7bae5Cz04c2
 0Zh+7qIAezkbCIG+We8ooSQyYLEXQYwyknuaYn+BAQdLavK2lM17sul9MFD+S7lrOL
 p1reLfcbFgweg==
Message-ID: <b45ff481-bae0-413d-a3a6-bf5a308aae76@landley.net>
Date: Fri, 25 Oct 2024 11:09:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Revert "Remove the unused sh4eb target"
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>
References: <20241024082735.42324-1-thuth@redhat.com>
 <20241024082735.42324-2-thuth@redhat.com>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <20241024082735.42324-2-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=23.83.218.253; envelope-from=rob@landley.net;
 helo=iguana.tulip.relay.mailchannels.net
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

On 10/24/24 03:27, Thomas Huth wrote:
> This reverts commit 73ceb12960e686b763415f0880cc5171ccce01cf.
> 
> The "r2d" machine can work in big endian mode, see:
> 
>   https://lore.kernel.org/qemu-devel/d6755445-1060-48a8-82b6-2f392c21f9b9@landley.net/
> 
> So the reasoning for removing sh4eb was wrong.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Signed-off-by: Rob Landley <rob@landley.net>

Rob

