Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E633FC87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 14:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufJb3-0002Oc-Aq; Fri, 25 Jul 2025 10:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1ufJaN-0000bD-Rm
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 10:39:49 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1ufJaL-0002Z6-NP
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 10:39:47 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-75bd436d970so1453700b3a.3
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 07:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753454382; x=1754059182; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=4wBC4D7PFJnUTB75FTM4xHFiZJYL3lpvMIyKjiSj5s4=;
 b=A2CGtAK/QRi9yEKMfDC/vr4BB+fPE/LbJtfkwk2ncsJ768Ocn/ut7qBKPDaGPmPgxD
 beBwQp/U9xGk1EqTVHvaROXA9knBzWxMrU3dcpqEBYUal3Op1SNcQD8J5By7CkiH7r+k
 E229je7WtBZG3bjF2GaQjxcR6TSCoCB3riHU9mcrZk9r9Ea869vCRwYcl446b/KZB7JZ
 ufhgQh5EM+6CuLdjrfuGnr5l1qISkdLXInrB+Ah1YRVwpERclXY2MMQbRADC3/JHCF0T
 ngGKg/K5kfP0btGpsoV1dFickE+HJ3JOKFh0I7g05oGS8ssRI1Z2jcwlddNS0y7+hZ54
 qCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753454382; x=1754059182;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4wBC4D7PFJnUTB75FTM4xHFiZJYL3lpvMIyKjiSj5s4=;
 b=RrXCooZHpYwyi9n84tZ1JJGhdbzTsMBQvx0+lWAVKt3khYVr6kNx+Pc2wHvYfagc0m
 tmjY0TxvzrTxyMOj2TBosBoH/rXCW42BZNXL6803SlRZKep/aP0qbIf4kdLO0CY//8fz
 ELrPw10r0Bour6xEf93pWqbMEI9bnfUH6hABGBEioO/Et7bMMc7XgOv8Q19umcMjby1O
 05rrxcngmaqVuo77sZU4DJ/XUURCFfkNhVp7R+buspBnZR0KVvDYx5fUrXVRQNh61fYh
 MfS3tXhlv0Z+6GXnlpEImNCVbhWHwm38oiB6aomA+77CUHdXeLnr/JO8Rzse/n8bdQhm
 nd3Q==
X-Gm-Message-State: AOJu0YzVKs/i8WEbsByaKv0UYYeSWDn8TUen480+rI2785Q3pQAfMJOS
 /CnbeqhNj0Qm6acRuxHVdvUQV9NVAqbQNU80bsfEUmzOLg2wEXlF1B1OwwT/Eg==
X-Gm-Gg: ASbGncsY5TgcQfbhtQpAEmOG0cY0sBtmDdbiLKsnhEmYkBd/ZCSqueOet8XKZsYXC0J
 PmLzvLihgGtOWckL4PeXCfYvjolzI6CeMuvqtKQpwoEiSu1W2jAIA3o4LGLDZWc8vmYzW2P1mDo
 pkKwYUoaWQUF3VsvPVQzwzNo4kdQELnBlBx9y4ly5qdFRLr6kcFEd6KwUWSDKPo0vc6GIeZ5nbB
 LkhBsOqJKCAgYIzkWngv6DGe8X2mAJn/PIdCFzmFRHKeE/HEqKNHBYuySmfxiGJQq8f9aSQCTJ7
 e3CFi6Sk0m5HESA0k4TZZ5/8eVL7jXHZlonnZAQZ15lGBU09qaOpRDXcWXsPoBnJ16TlJWgCqCZ
 Nqvk1HkL+6tLQo6DP5hUUuG+GgP9Q2Kd3m6s=
X-Google-Smtp-Source: AGHT+IGgkN1YSpzybq/Z4hbt7iXj02WG3Sb6Q1a0miUulmFms9dknAlMnsuU+P5RXAhjnTJTQ1AIVA==
X-Received: by 2002:a05:6a20:9147:b0:234:216b:cf98 with SMTP id
 adf61e73a8af0-23d7021bb59mr3825109637.35.1753454382290; 
 Fri, 25 Jul 2025 07:39:42 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-761b04b3517sm4066021b3a.84.2025.07.25.07.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 07:39:40 -0700 (PDT)
Date: Fri, 25 Jul 2025 07:39:38 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Biggers <ebiggers@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH] target/i386: fix width of third operand of VINSERTx128
Message-ID: <f8862cc4-d0ea-4295-a16b-1d96c56a021f@roeck-us.net>
References: <20250725061736.1096206-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725061736.1096206-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.159, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Jul 25, 2025 at 08:17:36AM +0200, Paolo Bonzini wrote:
> Table A-5 of the Intel manual incorrectly lists the third operand of
> VINSERTx128 as Wqq, but it is actually a 128-bit value.  This is
> visible when W is a memory operand close to the end of the page.
> 
> Fixes the recently-added poly1305_kunit test in linux-next.
> 
> (No testcase yet, but I plan to modify test-avx2 to use memory
> close to the end of the page.  This would work because the test
> vectors correctly have the memory operand as xmm2/m128).
> 
> Reported-by: Eric Biggers <ebiggers@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks a lot for the quick fix!

Guenter

