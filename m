Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B9E9E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB1G-0002Rz-3R; Fri, 13 Dec 2024 14:08:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB1D-0002RV-Pb
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:08:07 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB18-0006Rq-Nj
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:08:07 -0500
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-71e19fee3b3so1669553a34.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734116880; x=1734721680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DLUzbfuqaQK1ED8d++hVx9+Fv9mlyMdyo3cb7lVSrZY=;
 b=v/ZulzyKCFlFTwQvtMJ+y76ZSkgZbMXVzoLX8tIG296y/9mhoVX+1e2TBQAEF+3YSW
 WAlW1gJ3HlEu/Hem1jGbQmcTJuLxn0IcSkZjTotuEVe9ygilssZSJH7Jt1VZmRa9kxXV
 fju7RZGpTWKqytNEsqEKUbL4f5lPGZyX0IbNCVS8f4LBLEZIeY+FeMwIcHz79TO4KlH+
 VFUF6H1JeFKxTgTOE7Z3BERcIxZTkJA7lOBwQPFfW5uoSEzbfiiQ/K/De7HwqOK0+fug
 fxyULk6SEn+rWInVzZ/C4QcxDfw6u4YRttbEMS2z95B48Cfyyq4qfwDeHhcuIszGs0n7
 mGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734116880; x=1734721680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DLUzbfuqaQK1ED8d++hVx9+Fv9mlyMdyo3cb7lVSrZY=;
 b=hl4l6/UgsHo9mQ/baOlxYfBYhzRqew/L0tvGVbFcObu/deFk+LEYmqFmvAlyCcE67A
 2mPaSAduVqePbrpR5sUM85Sr77sBPlVWZsVsbBKCqv/Y+5oFO342Zv/fMpsNgc/bsi75
 amP6XQ7WmCbWQVqQzb1ce3E+3ycgcr3/a67EtXKhIM/53cRoxpBjcpDaKC3V+ZWt0AoV
 wWoHUyLB80WAgLRoOwN8v3BGQUkiugY579tNR/b3aKf2rW87MLiCeBcelPoi9isU/XAm
 NFQQ2r7KXylEZaL63dnwtxAyqY3qIYzBzLtPptnbp7GqJ4LWiY/US3JZXeDeP5nSsNBA
 O05g==
X-Gm-Message-State: AOJu0YwV8UwX2FmXrnBRh9JIsGu9b/WWIlnpGeMQTocXjObRhigIMwQb
 mRhMJJHGI6Y2QshQw62V1XzMETxtkD+HtpPzwVch7GImdnlx9R+Xftw/noqibvSm7/eZF+ND+fH
 AVGDpHahe
X-Gm-Gg: ASbGncsRYt+RSFumazPfH8djUGVG7LAubjiVeRLkLQk9VJTrmjV5YkOQnc79yDBfgz1
 L2oJc/yqOBnODaCXdGTQEIHJN94gbRk07+ag/ot24NxZsV3zSqkG5vqldhJ7o2jHZB9cFcen8Wt
 G7B6i7f23p17uHrafv7+5+53OIL5RIC4YY3uA6PeglSVy0nNQ5HepoWiuJeJs1tpme3Rlnxmnhc
 9sd39xdmWZM8mwNwHmGdt3l2PzULyAhXphQCws97htG7EOIGtM+p3d+oAHY/+6q
X-Google-Smtp-Source: AGHT+IE7ee7P2jPsSBnVkjmgySOrSS4DGP4ItowfUVWBcq99cgiebxMwVDx+57KFSooRXm/Q5JVO5w==
X-Received: by 2002:a05:6830:350e:b0:718:9160:a3e6 with SMTP id
 46e09a7af769-71e36ab9d99mr2800232a34.0.1734116879933; 
 Fri, 13 Dec 2024 11:07:59 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4834da91sm29697a34.18.2024.12.13.11.07.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:07:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Michael Rolnik <mrolnik@gmail.com>
Subject: [PATCH 02/71] target/avr: Constify all Property
Date: Fri, 13 Dec 2024 13:06:33 -0600
Message-ID: <20241213190750.2513964-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/avr/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 3132842d56..a7529a1b3d 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -149,7 +149,7 @@ static void avr_cpu_initfn(Object *obj)
                       sizeof(cpu->env.intsrc) * 8);
 }
 
-static Property avr_cpu_properties[] = {
+static const Property avr_cpu_properties[] = {
     DEFINE_PROP_UINT32("init-sp", AVRCPU, init_sp, 0),
     DEFINE_PROP_END_OF_LIST()
 };
-- 
2.43.0


