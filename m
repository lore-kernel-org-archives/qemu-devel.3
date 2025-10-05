Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637DFCAC5B8
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 16:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5S1M-00022D-Uz; Sun, 05 Oct 2025 12:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1v5S1G-0001wS-EN
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 12:55:34 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1v5S1B-0007rL-0D
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 12:55:31 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46e5980471eso19521485e9.2
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 09:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=livius-net.20230601.gappssmtp.com; s=20230601; t=1759683326; x=1760288126;
 darn=nongnu.org; 
 h=to:date:message-id:subject:mime-version:content-transfer-encoding
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=cb25B5eY+zXxsw9NK/ZgdrE5wA39gJzOi2flC+t/2Xg=;
 b=cdZV2yPA0l3PPYGDVwmXUjLDzY+b6ai25WPwBVZV3hazh2lQ5ePTrVOX72ofE1jhM2
 qUANFODBvMzNFLmIWP2nnJf1LgmXrry2HyQP+ixFc4Shcs61FmMWKr2C+TcZ4DYH78KX
 mmpQmCnqZRaUuaVybsetDL3r/aGHmyeoxPcVRTRaqhMtt3sw9WlzKC+aMDSwsNwk05r9
 6mQX4duEwdUsNLixG+FO5NILNtBaaCwp2qNQSNjmgeT8HXZ9yJYgj6UcfmBaQcxtRbtB
 fQC1t+rHA8jQnSfCjoukM2G5W67sVPt+hnZITVCfGn3VriOkDDTOoWhKTnbDuXoHOVMV
 OyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759683326; x=1760288126;
 h=to:date:message-id:subject:mime-version:content-transfer-encoding
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cb25B5eY+zXxsw9NK/ZgdrE5wA39gJzOi2flC+t/2Xg=;
 b=LdJzHyxRjcyOcwKrFACmwq0QCkyAC2YFGEOaakPnF5NwBysr58mysv2HEwM6jBVbSE
 pLEDk/lHBiEtJAXgSNun4Q/A3qBejiwO9+V4mvvHYRDBT42mahQwmVKhzfmB6o5DMVw0
 kgiLgPeD1nKvnAIzvYCLnGnKamOvBfGN2IonO/1GBhyAIYgpjWiGQqxG9Y0lnCEOg5EV
 UpL81ec9qIn1tOCtVyk1sSapaTnbCRnB0SSxOWLdP4Bf0esF+Xgy1/aA97IA9Cg0lqh1
 KCnPBJY6dR41thf8YaIUuOD+juF0zYeFHmw67WYsyVEmhmdf2m+zW8SamMBLNzDLoOcQ
 eU+Q==
X-Gm-Message-State: AOJu0Yzgvw7mRDRebVyjRrU2Oy93EDg/38qoTbQ5QWdxc3B894pXBYr5
 WBJ9PVFZDlfwBwRMrIO8B4Z+AnTRXyIahdCocRnPw+uDCS7VFa22JgCys59Xz9iYywjzHtGaUBa
 6k+D6P2w=
X-Gm-Gg: ASbGncvQnJoQ8cUCf1WqiS3s5gMklUIc0W+voFlcdEngFp0WXrE0ULEwp6807HsJMNN
 1AE2vUsI/WnOAS0/oLyx5H5k1wyyNWX0lfD0VhQArFB7bYXYAE44RfXps4VqAwhGj2AhKxm3eD8
 LUCPpDAMx1WSc3+P3nRZjeQxiQ3kUan35Cfjb0J3zurWl51IRIuELMYGaNlUUsxyRTwu46i1e6Q
 b4kMkahdV7JaRHWIaslhqav20dJKNCg/yaycts/8hIiuW3ARDxLfldA8q0CKCe1gJFnCwKdIJIk
 YVRo6644YUiN8ads1KPhTmK1Rjmvs7vaXz6hyyBar6IhFpX990/hC81V9ExySEJtgtzXA3LU9ne
 u/C+grDXZDsVAvKQTovFpRqFiNgjeXi4Xe3Ns3mqM1zoSZHt4yWuafcHq9Gw3sVS1fjT1WynyKU
 ivdg==
X-Google-Smtp-Source: AGHT+IGjXNOskYVnsyvBNP/ISSUaMV6Ohjzuh4HWOtJsQNFhSl9bhR3p5iqrt4OjB431+UDygDLAEw==
X-Received: by 2002:a05:600c:19d0:b0:46e:3709:d88a with SMTP id
 5b1f17b1804b1-46e7115b0bcmr62630795e9.33.1759683325454; 
 Sun, 05 Oct 2025 09:55:25 -0700 (PDT)
Received: from smtpclient.apple ([188.25.252.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8abe90sm16963967f8f.23.2025.10.05.09.55.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 05 Oct 2025 09:55:25 -0700 (PDT)
From: Liviu Ionescu <ilg@livius.net>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: qemu-system-aarch64 hangs in a cortex-a72 test
Message-Id: <9EF1806D-4C25-4980-B1CA-16616FA8E32F@livius.net>
Date: Sun, 5 Oct 2025 19:55:14 +0300
To: QEMU Developers <qemu-devel@nongnu.org>
X-Mailer: Apple Mail (2.3826.700.81)
Received-SPF: none client-ip=2a00:1450:4864:20::32f;
 envelope-from=ilg@livius.net; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Hi!

I have a small semihosted test that I use to test the xPack QEMU =
releases.

The test worked just fine up to 8.2.9, but hangs with 9.0.0 or later, =
including 10.0.0.

The test is invoked with:

```
$ qemu-system-aarch64 --machine virt --cpu cortex-a72 --kernel =
hello-world-cortex-a72.elf --nographic -smp 1 -d unimp,guest_errors =
--semihosting-config enable=3Don,target=3Dnative,arg=3Dhello-world,arg=3DA=
7
^C
$
```

The test binary is available from:

- =
https://github.com/xpack-dev-tools/qemu-arm-xpack/tree/xpack/build-assets/=
test-assets


I tested on macOS with 9.0.0, 9.0.4, 9.2.4 compiled from sources, and =
with 10.0.0 from the official Manjaro distribution. The 9.2.4 tests were =
also performed on Linux, with the same result.

The binary was compiled from sources; I don't have the sources at hand =
but I can reconstruct them. I do not have a physical board to validate =
that the test code is functional, I always ran it on QEMU. The test =
might very well have a problem that was not detected by pre-9.x QEMU, =
but I'm not familiar enough with A72 to diagnose it.=20

Any ideas what changed from 8.x to 9.0 to cause this?

Thank you,

Liviu



