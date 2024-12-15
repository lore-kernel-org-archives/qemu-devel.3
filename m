Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E49E7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMtw7-0001Dj-Ah; Sun, 15 Dec 2024 14:05:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtw4-0001CO-M6
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:05:49 -0500
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtw2-0000x6-Fd
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:05:48 -0500
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-29fb5257e05so1052286fac.0
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289543; x=1734894343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QLPgagf/0DIVBUOtqLaT1jsxc0wpGovV01TxsboZpYI=;
 b=fdP2sgVOR1HSzC/8pHIO0vRYJt4p0amDiWzNtix4sXXotvLShME+sVeRKxdfe/aobn
 PBxqZPazWFZwNLoj+rNOjeXsTqHoK7bb/zthntI8lCBZMAbyxOjzcQqjNwq4rZ9wXg8f
 zN0hJHNfN5pOT6SatJjvc36QjYIVUa6+WEGZmBDyKqVVgxOUDWnAvqxNupzPo09+OdHR
 IoY9mr5LsA4f51YQBIsqkz/o1mBnThkuIEXAf4mwZqSlxi4vi6TzhMvj+3wmUd+WTNpX
 Bxj7TEgwg+k7YhtEX7v2f32GHU7v7KqqiGCJ+kDnRMj0jP5AlBX99ia2SE0mXMLE1mI/
 ymPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289543; x=1734894343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QLPgagf/0DIVBUOtqLaT1jsxc0wpGovV01TxsboZpYI=;
 b=YrfHyPSTnQ2Rf0NTbeaz3BJTDrVB7OKeMmQA+DgWNwTfUIob7U2EjGasMox0qUnPWy
 Z0q0+0kdbGOVI5dSdy0CuNKd7hvF++vfF+AHA98Tp2zSpi0d/AGGkPtz0CV6CSDzza2b
 mBw5stp1Wc09Crv7kEo7aPzqCnTyIviW32oeP2/6ltvKJZ/xu+Ml89HNmB1kfpEoJqWF
 v4SZjzssBXNthIR1SpLA5PCwmE3CREYjf7GZLOTblc4BPLtjGSXgTCwKfo9y0ihzknMJ
 uYT0/u0sOTDp8Hf/4icrwVu+qXwG4sweWbGnQnZz6UCYJAlTeII9MldZrNuiWt17Wnj6
 IsYg==
X-Gm-Message-State: AOJu0YyGfBCjwIOxS3lu6MWqp0xZZsUvCJVNAhpxpIQbHDC1AmJnft3C
 XedTk45WBMz8DRbT4WweNXCzDkdMQhJk+n4b14H6cXpihg7N3lXSeuD4FMsZ6sesOfFJdFrpmvo
 UB+OFWLet
X-Gm-Gg: ASbGnctqtmzddbdApwBcTnsXCr5mtLsUptwaBaucGduZxRr+k7RDncnRbSgJEmS+pOs
 VRE/aey9fe80AdIi88516483LyoP5/0H1nokajy8tfKU2rbOV+5nlubPRzqnRVcRdm/xtLK6t+i
 VBvg2jdp73lhSx36GwFeRh0eEz0uyOlPlp0LuZgGG8jSz4O+7+DjZSqq0UrAObQkwk/kl489vWr
 WT2XeOLlNZ9YiA1LZZRal/snC40DwG0qQKGXQ+qCzsoBxqmlWLqCpStRb2AAnPEAcFSGAZoyFmQ
 Qzw4Hrr0c0xn0FfvwBpUv3zZuEkqk2+t4rDubU15Sv0=
X-Google-Smtp-Source: AGHT+IEhK1pHZYMsw6bimbSbZ7CchTBsXofTXwLlg9tM/X2pn4BtWfRz5Vzwjzkp/SWjbQdfdddECA==
X-Received: by 2002:a05:6870:9a0b:b0:29e:14ff:2f9c with SMTP id
 586e51a60fabf-2a3ac6caedcmr5621551fac.18.1734289543712; 
 Sun, 15 Dec 2024 11:05:43 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2a3d2914ac6sm1423214fac.39.2024.12.15.11.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:05:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/67] target/avr: Constify all Property
Date: Sun, 15 Dec 2024 13:04:28 -0600
Message-ID: <20241215190533.3222854-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2b.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


