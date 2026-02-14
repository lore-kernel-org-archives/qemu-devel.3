Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 952F2EF48C4
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 13:18:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrFWy-0005fH-IU; Sat, 14 Feb 2026 08:17:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vrFWV-0005Tg-LO
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 08:17:26 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vrFWS-0007uc-TD
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 08:17:23 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4836f363ad2so19516545e9.1
 for <qemu-devel@nongnu.org>; Sat, 14 Feb 2026 05:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771075039; x=1771679839; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fNoZb4bp9DmDOYZJ/ogzsqn+KnRGtybuYeAcnSj4TvA=;
 b=QTQMRFV25fwdy2wlplrB5rWLdUO+s26wywb6ApTiDlPkgqs8yORGKf5csHCViza5tC
 vqmFHbhFP6Tp+yL+9a+oNHkLwcDqVpXIkGBQgQ4LI5Js6GhPp4/7YIQpe0ZRlGhkTsn8
 +ZEjRhsKsHEc1IHNFUfg1+Xmj2psleiH1mSbXMMVnHJkC7O0besWz081ILKwpfqqlqAJ
 8SqJgsl4PCAMI8FBtYr8gFaHdAUSmBvB3tfcECH8GORQqMN9awdHh64gaY+UKWfWkeIx
 +n699rkWgGBdM1usqQiQkuVQzk/EI9/rMnJzEs5g535P3et7kbFvoz5BYUaDplUpOL8l
 o5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771075039; x=1771679839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fNoZb4bp9DmDOYZJ/ogzsqn+KnRGtybuYeAcnSj4TvA=;
 b=CwdvbaY9Yd3IMxY6bhmDtbBvVxdhkp11d2pbr0AsnmPfN/wAgOl4VaJpvNg/miusbw
 IK56A1/wcBdaUa4EVBpYbK8a69N3gGfuPO2GF8MXGXX+ly5lI9SYLSmwBQ/mxYPL6Nz0
 slxUTEFWpV7cbwb2NReWqb8obYK2NxTA8KHAHYn49h8o4qsJDEOdMpMknxtBlQ9hBC8O
 1cUbU9HGfy02eQNgkgQ8jH7EzuqS2JubAFuBAqwNzYFHMChLAnPubttkrOp8ZOy34XwD
 GuhDlm4WJfPQri0utrstUiJW4DBulT9lYRx+8Vp+uKMEUQumFxv+Ha4+YmvSyP2L3WWE
 swnw==
X-Gm-Message-State: AOJu0Yy0y2ytOrYxq6V5X8d6barVfI3VzzXTUegiG0008yADFJBFE087
 Zghl622L0WAPJUs14005d0KJxiBs8LWp6dAcHXc4tmJE6rFYaVpBON2zSOGcLw==
X-Gm-Gg: AZuq6aKIM9kvKTOA7cKR9cERpZYUnMwpUx8IquOcnsAfPK9SFzYic9EoFhS4IL6fXdv
 7pohsCYfQmlhazAu+YyEyeIxEveuynq6VDUdmIq+YRBld895rkbazAsWmGzxXpgzNDfjhqaJVqs
 RS0A+AS6tTUw/M/f/nnyZVl6n1p759n0YFdtL2KtdQFaBv3eyxxw97bJDCLjhB3Cz/KD7hia1U7
 POqof/eb9vu8HE7fsNKq9UT+PK0maeNTykIROoceACK33U5U2H29BQ8p8U0u/5qFzDHgUxO7gPA
 0JOM4ZeSSH2tfM3Rxdz39oll7HBeBN2ii2cIDRuoQWQUhz3JSdY9wJrEUqbvu73jc2AB1Zm7+Ji
 C47lo0wxh/id8pcxtWCDTLhrUkJqEzbyHBhXpyhZlYtF9diCMmAEjd9Lx6Ye7P8LNawyhr7xFXy
 xqfN5csnPE9cwpti1Zb83qUBXdViru6WBrehOw1JUcOXjya2QaftyAXXxXYxLJjSL1OsVHIicSK
 ZRnbBTR1vxUyaVo
X-Received: by 2002:a05:600c:190c:b0:477:5af7:6fa with SMTP id
 5b1f17b1804b1-48373a59a74mr70610875e9.32.1771075038598; 
 Sat, 14 Feb 2026 05:17:18 -0800 (PST)
Received: from archlinux (dynamic-092-224-176-164.92.224.pool.telefonica.de.
 [92.224.176.164]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac800esm13340471f8f.27.2026.02.14.05.17.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Feb 2026 05:17:18 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 1/3] target/i386/emulate/x86_decode: Fix compiler warning
Date: Sat, 14 Feb 2026 14:16:57 +0100
Message-ID: <20260214131659.31378-2-shentey@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260214131659.31378-1-shentey@gmail.com>
References: <20260214131659.31378-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

When compiling for i386-softmmu under MSYS2, GCC emits the following warning:

  In function 'get_reg_val',
      inlined from 'calc_modrm_operand64' at ../src/target/i386/emulate/x86_decode.c:1796:15:
  ../src/target/i386/emulate/x86_decode.c:1703:5: error: 'memcpy' forming offset [4, 7] is out of the bounds [0, 4] of object 'val' with type 'target_ulong' {aka 'unsigned int'} [-Werror=array-bounds=]
   1703 |     memcpy(&val,
        |     ^~~~~~~~~~~~
   1704 |            get_reg_ref(env, reg, rex_present, is_extended, size),
        |            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1705 |            size);
        |            ~~~~~
  ../src/target/i386/emulate/x86_decode.c: In function 'calc_modrm_operand64':
  ../src/target/i386/emulate/x86_decode.c:1702:18: note: 'val' declared here
   1702 |     target_ulong val = 0;
        |                  ^~~

In the calc_modrm_operand64() case the compiler sees size == 8 to be mem-copied
to a target_ulong variable which is only 4 bytes wide in case of i386-softmmu.
Note that when size != 1, get_reg_ref() always returns a pointer to an 8 byte
register, regardless of the target_ulong size. Fix the compiler warning by
always providing 8 bytes of storage by means of uint64_t.

Fixes: 77a2dba45cc9 ("target/i386/emulate: stop overloading decode->op[N].ptr")
cc: qemu-stable
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 target/i386/emulate/x86_decode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/emulate/x86_decode.c b/target/i386/emulate/x86_decode.c
index d037ed1142..6ad03b71b0 100644
--- a/target/i386/emulate/x86_decode.c
+++ b/target/i386/emulate/x86_decode.c
@@ -1699,7 +1699,7 @@ void *get_reg_ref(CPUX86State *env, int reg, int rex_present,
 target_ulong get_reg_val(CPUX86State *env, int reg, int rex_present,
                          int is_extended, int size)
 {
-    target_ulong val = 0;
+    uint64_t val = 0;
     memcpy(&val,
            get_reg_ref(env, reg, rex_present, is_extended, size),
            size);
-- 
2.53.0


