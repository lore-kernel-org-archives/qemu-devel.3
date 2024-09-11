Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08779EE020B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 05:28:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soFu2-00080y-Dm; Wed, 11 Sep 2024 01:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1soFu0-0007f0-2T
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 01:28:28 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1soFtu-0004Vm-64
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 01:28:27 -0400
Received: by mail-pj1-x1042.google.com with SMTP id
 98e67ed59e1d1-2d885019558so4336363a91.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 22:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=landley-net.20230601.gappssmtp.com; s=20230601; t=1726032500; x=1726637300;
 darn=nongnu.org; 
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TVZXPeyDcnWx+SHARuhHxWV+WYt38GB6ybIdyGpCIwk=;
 b=qVdYb8apeICymr/FlgRrCCPZMiBeZJ7ZEEtEqwwCMeTpo2sMQ3KG4ztg/s8l41QIDJ
 vso89Ib2nAyC/LFk6jLlVR438PdZHXsAczhYq8wyLs9VnOCGsIR1a3qQiG5SSIVXRfuA
 bQYEAPTTcNwYWaqiqg4J8z8/UGTesjuXZcB+z3y8xo6/8c5IQVFjMS++ZAjYabOmi57T
 cSabjZh0rVwSEZA75nPVbRlmKjncMvhdru1UjsavyHH0so4wBxusya3gPXI+Qn/YmnYe
 xDD1CMagfUE/2dagHUS8qb4uIP+QLglh/KyOy6P+d4Fv5dLv1jtdZ4sIqNExnP5AwqO1
 iaIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726032500; x=1726637300;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TVZXPeyDcnWx+SHARuhHxWV+WYt38GB6ybIdyGpCIwk=;
 b=X6ig+q0f36EafqjqDeQMe9kPgSbQB6en5n9n/dw2poJCWTRIw9ffbN+F3mpwgihJ6k
 7IEMAdGctUNaMXYlp5hKMWc7yADQluSN1DGGagAeRqFS20d1VSaVr4ucoQFVPKq55tua
 vRJpKRknZqVVGMCQYAa0k8f3ouOvFvASdhC/UCuZFUvigB6FfAjLV4kXxz1Um+T3Z/Pp
 MYVQsNvMnoekvUR4smbseke8D+Murfs8cKsVhhLaR9cVaWnuWD4DvlZU4vz92EBUvGF6
 1Jdf1QdSkyJaZ8zj0taTNY4GG6XnExie9a81fTo94lhs/kuU3PLN5eBgZELbnWBxvRIV
 oVUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8RM+V/ajqnrgPqwbWXUWjH8YFy/fAKPMk0wUexnTRKAUhUO0dSDMhLOcotR/zZPWvCu0LgbkQZLWG@nongnu.org
X-Gm-Message-State: AOJu0Yxqwx/DppUPm0MDiulvb5CLqFJArL7Je7RaCMcvzHPVlxD3FB9I
 OrceVWt6rlto8w16AiZS7muN8DXmOMtpbZNuY6Gd1EvxfdL36h//6nOM2I2DAQ0=
X-Google-Smtp-Source: AGHT+IHkm5z0A6kkfgNf+l+iEAl/x8DxVjVJZwLluha7Q6v5c53pje/kugQcimwNGULl0gnIYDZmqA==
X-Received: by 2002:a17:90b:3015:b0:2d6:1981:bbf7 with SMTP id
 98e67ed59e1d1-2dad5181bfemr16907817a91.32.1726032500135; 
 Tue, 10 Sep 2024 22:28:20 -0700 (PDT)
Received: from [192.168.11.7] (softbank126112255110.biz.bbtec.net.
 [126.112.255.110]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dadc0213a7sm9611523a91.18.2024.09.10.22.28.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 22:28:19 -0700 (PDT)
Message-ID: <afac091f-08cb-0f6d-4c01-bfa4421e7a47@landley.net>
Date: Wed, 11 Sep 2024 00:42:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Stafford Horne <shorne@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 QEMU Developers <qemu-devel@nongnu.org>
From: Rob Landley <rob@landley.net>
Subject: QEMU commit 0a923be2f642 broke my or1k image.
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=rob@landley.net; helo=mail-pj1-x1042.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Grab this tarball, extract it, and ./run-qemu.sh. It's a simple
linux+initramfs image that boots to a shell prompt.

  https://landley.net/bin/mkroot/latest/or1k.tgz

QEMU 7.0.0 ran that linux-or1k image, but newer qemu does not. I besected the
issue to qemu commit 0a923be2f642, and it's still broken in current tip of tree.

Rebuilding the image with current linux-git doesn't seem to make a difference?
Either way I get serial output with old qemu and don't with current qemu.

Rob

P.S. Reproduction sequence for the tarball available upon request, kernel config
is in the docs/ directory, userspace is just a toybox mkroot build but "not
getting kernel boot messages" happens way before userspace gets a vote.


