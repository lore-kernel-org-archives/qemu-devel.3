Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60FF0D6A25B
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 23:11:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBizG-0000gk-H9; Thu, 14 Nov 2024 18:10:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1tBizF-0000g7-Gd
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 18:10:53 -0500
Received: from dormouse.elm.relay.mailchannels.net ([23.83.212.50])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1tBizD-0006pk-SG
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 18:10:53 -0500
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 68A151A4959;
 Thu, 14 Nov 2024 23:10:47 +0000 (UTC)
Received: from pdx1-sub0-mail-a231.dreamhost.com
 (trex-7.trex.outbound.svc.cluster.local [100.111.111.109])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id F1CC11A43FF;
 Thu, 14 Nov 2024 23:10:46 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1731625847; a=rsa-sha256;
 cv=none;
 b=+VbI76W7hvvIwewryBvctvTTByiNGemPhe+UwEk4ey6KlKh4pOdlMxC0o/NjTI1XGUAw3L
 KRFLbE4/3qhgYoE1K+KQhM+SrEz/KMXcOCpTtBfTfmKzEabn3N1qb5IqQ1KtvOeLtnjkRx
 eabPbbUswMcS32l21U2KQ+fhhQa7Djc9+6DPrSIh0K9jrXtSP6DtCA2atc9Eh8UnoHXRb6
 ZnD6fS/aJ6LmOtP6hReYBZN8MqC0dCEo0D1BQP+9dKY1xspToJjM89SMAOwPbxZJoNut3Z
 wIXLJZJSd0p9QGhqVpKMm7Q1QMuiJB+fEeUEceNKtP41ULpoKMV73wtz6UCvjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1731625847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:dkim-signature;
 bh=v20ebj1ekECUvmjvyhu34jk+Llqt4A+KlSko9aHCEzw=;
 b=Z63wo8Wi3rJYUP28+fik7wf9BWS5WO6bANyj2baF0jRZwQyUBbbG3aoBYV7iiFnamENg47
 9XJJw1S3MIImYoYPdsHiuOnyJ9BPC++5dymE0yeSlfrvTZrwsQG9R2ICdgo7hzWQkd4wc5
 VaVZyhv07hl+KSCuOqUSqT2ldYRob3oIRJaSYC/izMZZSDKI0NIq/LyQmKRVb8IXN/ItAe
 HvgRnciyOGnLTLPv9QBlr1cP1wSr3K9Kdr2DXUc2HIyNcsauKE1CuMf+3krR3C/cCuH0xd
 Lb1QAMkUuSQM8QB02THXR4faL0+gE+T92skJNVAeEegjqPOMGRlsqs7Yq250KA==
ARC-Authentication-Results: i=1; rspamd-645676964-w689r;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Ski-Illegal: 0c366b7d6051d806_1731625847229_200874031
X-MC-Loop-Signature: 1731625847229:3360123726
X-MC-Ingress-Time: 1731625847228
Received: from pdx1-sub0-mail-a231.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.111.111.109 (trex/7.0.2); Thu, 14 Nov 2024 23:10:47 +0000
Received: from [172.22.7.54] (unknown [198.232.126.195])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: rob@landley.net)
 by pdx1-sub0-mail-a231.dreamhost.com (Postfix) with ESMTPSA id 4XqG923Ggqz3R; 
 Thu, 14 Nov 2024 15:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
 s=dreamhost; t=1731625846;
 bh=NO6cvgyy5FnJVhPlSrHIdMUL654kkw32kcfKhh6Agjk=;
 h=Date:To:From:Subject:Content-Type:Content-Transfer-Encoding;
 b=OD4eXTznLKcFkxuRM83gUd8Cd1eSUUJKlSTfE6tOrOfYAIzRwgHOVHcrk5JCrfMGg
 9tZxfYne5o/63zxnrYFTlEtaazPtMnTtBxdyWavHpnKQgfd5BVsMDth1399cTg0/wv
 M3p34KO3lwUqmG1Yvpy50HCReJQS+FKUlJFo6lqgZ25/zsFjQSD7LECSR2g5sQSG4l
 aLv1KztHS9HcF9gQB+glQsDM3yi5+HWd79DBzK+6+ejZyr1PXjHVOz0eGjoIi130td
 PhtF2KGlHTDO2OZx1bSaDaXCgveJ22P5SRvHz0xCBy0Pu9YseI9Kf4nsjCczjdXKN6
 p5xeLheigkkBA==
Message-ID: <86871f60-983e-4172-a6e6-1bd4b1e4e5c0@landley.net>
Date: Thu, 14 Nov 2024 17:10:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: qemu-devel@nongnu.org, pbonzini@redhat.com,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
From: Rob Landley <rob@landley.net>
Subject: "make clean" after "git pull" runs configure before cleaning.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=23.83.212.50; envelope-from=rob@landley.net;
 helo=dormouse.elm.relay.mailchannels.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.69,
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

Apparently because:

../meson.build:1:0: ERROR: Meson version is 0.59.3 but project requires 
 >=1.5.0
A full log can be found at 
/home/landley/qemu/qemu/build/meson-logs/meson-log.txt
/home/landley/qemu/qemu/build/pyvenv/bin/meson setup --reconfigure 
/home/landley/qemu/qemu
WARNING: Regenerating configuration from scratch.
Reason: Coredata file 
'/home/landley/qemu/qemu/build/meson-private/coredata.dat' references 
functions or classes that don't exist. This probably means that it was 
generated with an old version of meson.
DEPRECATION: "pkgconfig" entry is deprecated and should be replaced by 
"pkg-config"

(And then 30 screens more data...)

Seems a _bit_ awkward to do that (and potentially fail on a random new 
dependency) just to delete it all again?

And I dunno what it's saying about the meson version, "aptitude show 
meson" in my devuan daedalus ("debian bookworm" fork) says version 
1.0.1-5 which is nowhere near 0.59.3 or 1.5.0?  QEMU built fine with it 
last week, and after yet another ./configure it seems to be chugging 
along building the new -rc0 tag for the moment...

Rob

