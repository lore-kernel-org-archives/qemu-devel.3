Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4790AD6B09D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:40:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlV3W-0007kE-Ts; Thu, 29 Jan 2026 11:39:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlV3U-0007jp-Ax
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:39:40 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlV3R-0004qz-J9
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:39:40 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47edd9024b1so10019795e9.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769704775; x=1770309575; darn=nongnu.org;
 h=content-transfer-encoding:subject:cc:to:content-language:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8MgDEWesNwCg97fIINd3vRrwZUg3uvI0BpbBEfWyJrU=;
 b=PZhlIe8rOP+gIwxI8JJJ0YpC7Cwe37s/d9kPpHyxmDQquT9hbfpgdRVRCjJ5VC+4yz
 sC2fv7aQRBk02EMHhzXnMGMqQU4O6LwaQo4NSF92jKETGxShBZ7gkTtX9sNH01IPHY79
 xcs0T+m93y3O4AMRkYaZf0Sj0uEA7epnzzs9zXVmmHCwJ7E0WN4Yadt1sxsdZAj+mCom
 gNPrYk1U1wu1Dsfz/GsPj1794dOumic5LhMpw/B9C5mL6lj6AVF0CqnmyooBuIeE6fiK
 gUlQTngNXNdnO1mxw2Bzr5Cf4M8mhK4Bex6aLkrDcY9vif7YSD0mTqTD+ECI4ZRw0fWy
 ZQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769704775; x=1770309575;
 h=content-transfer-encoding:subject:cc:to:content-language:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8MgDEWesNwCg97fIINd3vRrwZUg3uvI0BpbBEfWyJrU=;
 b=Zv3zIo9IO++36cPxfjBwHcblKuTBW5TcRSXoB0Nsu6E8U0BxZ0vO/U25gWjMwx3sMe
 Qc9Yu7C08YPmqg2bpUXaKhm7WBD+5QO4NXvQBvd+qLmk7aFfm+PNyiCxXEvf1JVF1wt3
 b/8EHyg6oYxN4hjjvcZcBM7Vfl6noDel16FR70/ZAJXFkPzc5IK9P4hfIug/a19d0foR
 sS0U83X6+wD5Qy3+M/YmxmBKyMYdy99CVzeMsVKnC3i3X4FRipI6WPMpRiorbL8rncBP
 v02tHjiKnqwZ4GeTGgp8QiyD6MRU3UXPl/K5uuud4G4cPyg5vhAvtZOhr4vyEZHKOsDC
 qZrQ==
X-Gm-Message-State: AOJu0Yz7MUAYcwRAyespyU1ktbKQQZFnSlIrilhQIkcziDok65k7g2Yy
 FJNc4vUz2TNUYdynyKFJuHM+3EVb823J0HU+xDAlev5euzoPw0Lrg98UqM0TPt3zQ7iap9tcNcY
 YNqskSXo=
X-Gm-Gg: AZuq6aJErwV+H5sleRs6eSdT9uKNifv3EsQGtFkCXHRTulve7m3dfUEk5eKfNO7cBRV
 QHUgNsBNjFDfm4l7Giwmf3qpM8YMqLoKcT6XJj155tL3gweIsNT3dHWBoo0UajN+s2M9ymPe208
 +GKz5qJxLnQHHzXKe99XDL8+Uy75dFGz1GKPtdtyFX1AnkVS4pM0ZiFQ7LHB56fMbhqWTk7B9Lz
 4QH9jY56V1soHlUmVktoN5TMZ173LaaIuIZKzBf82ZMSgmI2KWvuYeygXPyIpqrXj0Sx/R8pete
 WLnH0JWHJh8Zthdh4eKNAM0LEgveA9/C3NpTishMhAZJTraHV4ZRbBQjYshtYHUk+hIDf8UtXRn
 yuZz3SUlMnTDc1iEXE+Kc4ATgfdHI5RFpQ8OJNtyLuaAIHdWQTBAHH01quIlG9gI7e1ukWd9koS
 KWOiHse2Rlt/E/CS/XMqOKYMtud7cymfi4PfmKiqvwn/dtsjM6C5TLDg==
X-Received: by 2002:a05:600c:3b96:b0:475:dcbb:7903 with SMTP id
 5b1f17b1804b1-48069c37e2dmr131314265e9.9.1769704775400; 
 Thu, 29 Jan 2026 08:39:35 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e4824sm16543535f8f.1.2026.01.29.08.39.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jan 2026 08:39:34 -0800 (PST)
Message-ID: <5100b77e-eb58-4651-bb43-13ccc6b531ce@linaro.org>
Date: Thu, 29 Jan 2026 17:39:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: qemu-ppc <qemu-ppc@nongnu.org>, Thomas Huth <thuth@redhat.com>
Subject: tests/functional: PPC test failures
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

PPC AmigaOne and 40P tests are failing:

  40/306 qemu:func-thorough+func-ppc-thorough+thorough / func-ppc-40p 
                       ERROR             6.02s   exit status 1
qemu_test.asset.AssetError: 
https://archive.netbsd.org/pub/NetBSD-archive/NetBSD-7.1.2/iso/NetBSD-7.1.2-prep.iso: 
Download retries exceeded

274/306 qemu:func-thorough+func-ppc-thorough+thorough / func-ppc-amiga 
                      ERROR             0.36s   exit status 1
-----------------------------------------------------
tests/functional/ppc/test_amiga.AmigaOneMachine.test_ppc_amigaone/base.log
2026-01-29 14:34:05,923 - DEBUG: qemu-test.archive_extract Extract 
/root/.cache/qemu/download/8ff39330ba47d4f64de4ee8fd6809e9c010a9ef17fe51e95c3c1d53437cb481f 
format=zipsub_dir=None member=None
2026-01-29 14:34:05,924 - INFO: qemu-test.fetch Downloading 
https://www.hyperion-entertainment.com/index.php/downloads?view=download&format=raw&file=25 
to 
/root/.cache/qemu/download/8ff39330ba47d4f64de4ee8fd6809e9c010a9ef17fe51e95c3c1d53437cb481f...
2026-01-29 14:34:05,978 - ERROR: qemu-test.fetch Unable to download 
https://www.hyperion-entertainment.com/index.php/downloads?view=download&format=raw&file=25: 
HTTP error 403
2026-01-29 14:34:05,996 - ERROR: qemu-test.fetch Unable to download 
https://www.hyperion-entertainment.com/index.php/downloads?view=download&format=raw&file=25: 
HTTP error 403
2026-01-29 14:34:06,010 - ERROR: qemu-test.fetch Unable to download 
https://www.hyperion-entertainment.com/index.php/downloads?view=download&format=raw&file=25: 
HTTP error 403
-----------------------------------------------------

