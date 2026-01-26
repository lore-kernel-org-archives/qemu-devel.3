Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598F4D1951A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 21:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkUXC-0004xn-OX; Mon, 26 Jan 2026 16:54:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vkUX5-0004wu-Kv
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 16:54:04 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vkUX3-00073I-B9
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 16:54:03 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c62239decbeso1744514a12.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 13:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769464439; x=1770069239; darn=nongnu.org;
 h=content-transfer-encoding:subject:cc:to:content-language:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0kvaWFokiXHFG5TwNo8wBkyjCwHfHhk1JtyVsSNRUhI=;
 b=VS632oGBSCMGCIRMp1vwxHD5sehkOUdFulpheVPWlA+vFlBOoMvimplMrIBSecmkPv
 8yLXyWZwV++EHIwlZqNfyxNuDfSuX4w7dNssia/jdl7v37dxSLDK1QwoDkQ6jlgPBFzu
 0+wz/X4vAOcLtc3VcG72+888tOb3jPJdnSWQ4uXxFTai0EKnrpJvxUggIsrqfd/iyZXl
 TX9Ne9qkBxjeJi3YZ4FiWDgmZo7UAB5VNl7craZKuSGO8GlJ9Pj3d0FM+X0mwek0Ga/j
 feVxWz15omg5dAjbmjZG7Ya2gXBZBUU5fF1wuVNb13sHEBkTaH49NMFDahQYFjf9lJo3
 ZFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769464439; x=1770069239;
 h=content-transfer-encoding:subject:cc:to:content-language:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0kvaWFokiXHFG5TwNo8wBkyjCwHfHhk1JtyVsSNRUhI=;
 b=aBXDNful4qaLXUD28pvWJLMBNZq9aK4f5ku3a4p6e3dW1w6VeeXFomBeuXhigG2jTO
 twFc67NOTWw1YczmjJl94ZIEPDZXhULmzB1u6UIEA2LRBplTE9iIpufgA16uKL6f80hY
 0Rp7FsAK1kTnEPNJqry1aPYHtHRj2WIw8VzeNrrDzNlwV/D719Wz142rOPKx/iMHDPi+
 wliWzFH8X7xk6r5Sr8XsT5Bf3xj+NY8NUOmfxsnxEkyEeGvfkgOVzVh+y24mEIyjE7Z8
 1IyiL8MIFZJgtcZx24Asny3XcXkIVM1KU8YcitXhJvL94hK3O4o2zm4JyLDZTp3NDgbU
 sldA==
X-Gm-Message-State: AOJu0Yw8LdbiMa9pEQnD79jOwnqwmI0IQkZMnIjQo8+60UJPJjb2IaXy
 7Rc1bF2taTu8IWq5NyRCays1BC101Oi08dYE0UEdjcHwceFC40ZaX/WqVXPNLvGixGo=
X-Gm-Gg: AZuq6aL5WJooiOUT8hJp2CeMZnajojG/l8+gyHseVJVj6inuA3WliBKg+QcQQ3zTgIV
 OPaXZVO+HHQqM5iJlxxUveV+enp5DE+eUEltHdWvtm1ZIfHzvNeLIr/Mh5b/poFTCylG1HAlM3D
 YOf5MZVf8PZPB7lF9PlOK0K14bENCKpeUVoiblS2MsvdAvuRb+3dbHhWgFT5IVGaW3A6j0l4t4f
 Z2U2WefBKnCRQgyucj5DS4xuzJbcHPMI73viXTvybTGZQ0cTR9GmjvFxXl6hRxkpRmvbhgbeteg
 94sBuIoeP/sYSTgOLSUnaMMF50gWmFXvk4S6p3Xn8QotVSqJKXxJdJCcdeNLb3bShft77igMYwG
 R0Q9EgFjuHTIOiblAuDbEFJ190+XyhE28wTFVC+E90EAnlwl+EPz6eUTSIh3RsrmhxoatizBcV5
 IfqNnktNOhUhlRbH+2BZBJUpnY5l9aCLBZcyNxHklf
X-Received: by 2002:a17:90b:2c86:b0:34a:8c77:d37b with SMTP id
 98e67ed59e1d1-353c40c6914mr5217649a91.16.1769464438754; 
 Mon, 26 Jan 2026 13:53:58 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f6126220sm411264a91.7.2026.01.26.13.53.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jan 2026 13:53:58 -0800 (PST)
Message-ID: <da1443a0-5bf8-4ec0-9910-fd06beb42552@linaro.org>
Date: Tue, 27 Jan 2026 08:53:53 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
Subject: gitlab docker registries
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hiya,

I noticed this today, wondering why the daily scheduled builds are failing:

https://gitlab.com/qemu-project/qemu/-/jobs/12868286187

time="2026-01-26T17:34:06Z" level=fatal msg="Error parsing image name 
\"docker://registry.gitlab.com/qemu-project/qemu/qemu/emsdk-wasm-cross\": reading manifest 
latest in registry.gitlab.com/qemu-project/qemu/qemu/emsdk-wasm-cross: manifest unknown"
make: *** [tests/docker/Makefile.include:54: docker-verify-emsdk-wasm-cross] Error 2

I'm not really sure what the error message means. Do we need to push a built version of 
emsdk-wasm-cross to gitlab, so that a manifest is present? Which doesn't make much sense, 
since the job is all about a weekly rebuild of the containers.


r~

