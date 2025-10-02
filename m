Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 877C9CCA471
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 10:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4GNG-0001VN-O0; Thu, 02 Oct 2025 06:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v4GND-0001UD-0C
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 06:17:21 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v4GMx-0003hc-5s
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 06:17:13 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46b303f7469so5055125e9.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 03:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759400211; x=1760005011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HGAmfelpv8M7kB4vi3vZ/7QGZHXLaCaXOVFbGk4GFqI=;
 b=U3C9wPXUTGXdKb6fWqZvrRkqWc4OSpwzH6kfXoOk++NWTII98ea0GArTWQ7UAO8TyP
 FiYSylGoTGQunf2ec2ciZgh3tqWfhan31kZ3L8YYV92V+xQ+Bd1wA/DcEQCrYic1tt//
 61YDFG3AcXXTnIJ3ODevY9LJlDQugj8HOobk968oavzdlTNxMQDZ8glp+OUsm7qIfkd9
 HVpYEks8pJ8Ulr2GGAKZV/7bml1gUsj55mIDghmqlH9nq8Y/16xsIcpg4ALCFF01LKG9
 NKHdabWt8w20QtU68tfQvZ2jMtBRzr1RARMxk9P5EV/iyP8QVME3GUDtrHSolz1bJvms
 tC1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759400211; x=1760005011;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HGAmfelpv8M7kB4vi3vZ/7QGZHXLaCaXOVFbGk4GFqI=;
 b=RU8xDSQ2XjCqaKzKmuc3/EvN/Gbpv9reaP+xx4kU5PuCd1SkqSQ7G+GFvuj/UGtl+b
 fFhK7Q8/LzgiELolz9nm8enA3yxabZcCqfgFrry2GcOLmHj2la0TRPg4lfMrbOd33RLe
 9Mnq1m7tj9DWoM6TNqKGqyTP3vAzVguiSa45G8c4rZbU4nQ0hxB7YHWH97bgQNy3Nvoc
 ycuKZPetReL2ZD/bJx2lJATBGDKsm24Kv070bay0TI1jaaTh3ornkGHHXpeKf/VjZNnt
 xuxrpxWcAvnjDg3IuaqH4pG1HW9TUuCpE3xpVSKyFj493ibn+CCYESK5B8BmiMTqJZ3A
 jLKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXj7AS+h+5hOmIwxrAbs/ILXbq5xsB69rtcbn+0RzoRPvosQcGJ6zGCOfVAAP4tYoUvwLxWzyWX5c0K@nongnu.org
X-Gm-Message-State: AOJu0YzUjLZmiDvjVmr6zy9Ool11HYpMLTMDkiQ3l7Ns4/baLQxbCqrj
 COxRlJuUTcOohwuOKK8FoxyTChYmmUVQJ0/STepItO+5H/RJvBh5qO1b9IZP+LLCCqeyxVdnTSf
 HiM3n
X-Gm-Gg: ASbGncvyeU9/sVSVDg86r5rtqIcE5cYs1hGz65ubxnbRl3/igPixU4U5MIWer6EGxvn
 sR0+ccT/D8q1GAcqhEX7/sj6xc1aMAEF2l3krnj9cEOyCu4jgPwolh6PVY+hJf1FuNodpatvLS0
 w9lTG7CaWjqJsdhsDQ2SsXzaz+rmwTwSMK0IhEL9Qs/BqF8IYx0BJTd0hGs4HtYSujg8BhRnFsg
 I2WpGWUB7Dfnny1ANeuw7hN50AGQQQpDSjAS/VhqU62hVXLhJDzZBU8eKbssOVfhOMeUmRQxkp+
 JgxL1w0qxtLuYbf8pqHHKsqf+dVD6lTNFe8lNc1zNwj3fGGEZoCLh8efPJdZ7kfGbl+2IWhtL8U
 ISU3z+mNG9klbd3IXgDyy6zWzNJ3XBAtv1OdMi+1xf9Wox1bIE8W7176w
X-Google-Smtp-Source: AGHT+IGYX7Zli88xnjD0pAkVUWiw1lHPyP4HTQMofby2ytke7p/FqjDO/GQo3GN0MdWchWcmGGtXPQ==
X-Received: by 2002:a05:600c:1c95:b0:46e:6c40:7377 with SMTP id
 5b1f17b1804b1-46e6c409098mr11977915e9.35.1759400210776; 
 Thu, 02 Oct 2025 03:16:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e9780sm2978809f8f.29.2025.10.02.03.16.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 03:16:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [RFC PATCH 0/2] target/arm: Allow aarch64=off for TCG
Date: Thu,  2 Oct 2025 11:16:46 +0100
Message-ID: <20251002101648.2455374-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

This patchset relaxes our current constraint that we only permit
-cpu foo,aarch64=off on KVM CPUs, so that you can also use this
to run a TCG CPU with aarch64 disabled. This is useful because
currently if you want a 32-bit TCG CPU you're limited to either
'max' in qemu-system-arm or else the old v7-only CPUs like a15.

I had a look at this last year, but never actually got the changes
into a completed state before I moved onto other things. Clément
asked about this the other day, so I figured I'd send out the
patches I had.

The series is RFC because:
 * I haven't tested it enough; in particular I don't think
   I checked that the "clear the AArch64 ID register values"
   patch doesn't break KVM aarch64=off (including not breaking
   migration). If it does we might have to make the "clear regs"
   only be done for TCG, but that seems a bit hacky...
 * I haven't checked that we forbid weird property combos like
   '-cpu max,aarch64=off,sve=on'

But I did do the work of looking through the codebase at where
we test ARM_FEATURE_AARCH64 to confirm that it really is the
right thing to test and we weren't using it any places where we
should instead have been checking ARM_FEATURE_V8 or something
else instead.

thanks
-- PMM

Peter Maydell (2):
  target/arm: Clear AArch64 ID regs from ARMISARegisters if AArch64
    disabled
  target/arm: Allow 'aarch64=off' to be set for TCG CPUs

 docs/system/arm/cpu-features.rst |  7 ++--
 target/arm/cpu-features.h        |  5 +++
 target/arm/cpu.h                 |  3 +-
 target/arm/cpu.c                 | 61 +++++++++++++++++++++++++++++---
 tests/qtest/arm-cpu-features.c   |  8 ++---
 5 files changed, 70 insertions(+), 14 deletions(-)

-- 
2.43.0


