Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EBEACCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Cks-0004mv-6L; Fri, 10 Oct 2025 09:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.hoo.linux@gmail.com>)
 id 1v7Cjl-0004cG-N5
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:00:46 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.hoo.linux@gmail.com>)
 id 1v7Cjb-0001tM-5e
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:00:45 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b609a32a9b6so1271670a12.2
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760101225; x=1760706025; darn=nongnu.org;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vOOXZGCs8bQ+qHQrZlVXdYoF24tKQxHP/cXnUs7wLho=;
 b=Kp4EPMGWJ3PYbWF3De5UMRobOJ3XHpz63CpCJ/T9HngB6MojcxqZ5LSU/PCyKq3CwS
 Nlh4kT6hYScTtd97fWrPRA1oihnNIKfeavF6Yy06JpVm5N2zTzNr1TVEBBE2odDp0f+N
 UCJ2K5iPmw1/EY2sAYPEVd2sGYDKtgRjDXDr2PVLDT1FYT/QEE7Zl2aiKjNx/w/nA5Kq
 BdRuAwvGVG7yZSlVtPR5Im3F5rpnwZCIdvsCq8BMQ/Ws5F94TCvaLOBAZK0qN8Gvor2U
 Tf1tqSZYNyzKfqvm8gj1oLcihnwymKPfhTWSaRdctUzB0H4BXAXect+T0d066HtRMyuf
 7jqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101225; x=1760706025;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vOOXZGCs8bQ+qHQrZlVXdYoF24tKQxHP/cXnUs7wLho=;
 b=gXawXYaa2gjS1iTXqWcRerT8Vb7k9Im83OsMr6A+DjlQHt8y900zqzXDnuO6vMjN20
 f6oywL7Fg3cTVpA3JqWADqeGZWSxLK0nxr1IjHZio7ajZIrEdKwbV7D1AZ898uYppqd3
 TABGUw9fOsgI/bNmjHO2CywgHNvdr6TnhWAL1cBANU5jzqf8SFHyYueJXKvbMRsY7Ice
 c270jOKvJjDfcFmhfMIvJ8rBLcpqWwAJ4guawgrzPV0hD89RySUmvjkYkDxIFMRHTqVG
 0auKwW5OFdtQUkTYs7eUUyFCKgPRqayyyhuKXedmRJeIGXKDehEG3onMsTRJ6chGTjpT
 qevA==
X-Gm-Message-State: AOJu0Ywxm74cSrE2yF41Q5ThFANAEBS8yvafQKtTm7nwAsUUzwV5NXkH
 apdLk+eBGijvWAyzowlbi8usVZ31HZj7ghAD8j1RTzfmfIbOhZ4VnO5xF/BwbZCB
X-Gm-Gg: ASbGnctU8guasUs2ASXNtdCckaDCN24I69IJOPNwcDnAbx7fRDqRuQUexDliKdm4BZR
 mVBxOuYgXzFSWFg+Ilp55PXjlKNgZDZXwOHk7NIB4Eh/UN6z4HyIlSfuFqy4CBWA6fhHRsoDIP9
 qF9EKlAoJK9XIiSMKhp5x83mE/UNJyCqRsuEkqlJSAgWACgFkAOH4vfvkoOTFWzfmaslajsV8f8
 dzzWD2CmiIdzJqp2PxO/QaRBCtNhZp2BPBXQTKVAmVsHwk10S5gD9cBOGtZZAympNkWY08cZ5eg
 LxYl/s7YKvOMjvNujJbO8U3iPPpWe4VOW3zE56lCdnKe9y8k7gEQha0JCu1ZESfV1ySzJX09vUm
 pD6paV+LYqCvtgWkkI1viPlvvqFCYJBhXMkjPoZRdElH2Ai2SUqDXWAT3RXgRQnxLNnbcvqbBQ7
 QIX344b3ScaC5SGX0gTOBp8gRUnCp8KDAYp9Q5iVDcJXQnAv0Xe6UQplhqqJkRIkQY
X-Google-Smtp-Source: AGHT+IEYuNdt8adqxLdE30t6Z6WFdRp/jd/MialuY+uI4QVuv21WKO0OSuuGmIgtwvNpmNOpRPUddw==
X-Received: by 2002:a17:902:ef09:b0:27f:1c1a:ee43 with SMTP id
 d9443c01a7336-290272c2564mr138425485ad.29.1760101225347; 
 Fri, 10 Oct 2025 06:00:25 -0700 (PDT)
Received: from [172.27.236.23]
 (ec2-13-250-3-147.ap-southeast-1.compute.amazonaws.com. [13.250.3.147])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034e45568sm56691545ad.55.2025.10.10.06.00.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 06:00:24 -0700 (PDT)
Message-ID: <1943ea16-c3cb-4442-be72-5719026ee13a@gmail.com>
Date: Fri, 10 Oct 2025 21:00:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: qemu-devel@nongnu.org
From: Robert Hoo <robert.hoo.linux@gmail.com>
Subject: vsock support for communication between guests
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=robert.hoo.linux@gmail.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi,

Does vsock support communication between guests?
 From man page, and my experiment, seems it doesn't.
But why not?

