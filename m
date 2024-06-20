Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2455CC27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 15:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKJcK-0005lv-Gr; Thu, 20 Jun 2024 11:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sKJcJ-0005kw-Jf
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:22:27 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sKJcH-0007uU-RX
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:22:27 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-57cf8880f95so1162321a12.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 08:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718896944; x=1719501744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2yimdE3nPFUILo7awwhHRy/OflE23PtwusH0HEIKw8g=;
 b=y8kGqvgmunhoK6+Qx6ouVwHXfJobJfIzSioXKnjErGdhu6UH6m8nHOu5JvnIorlU+Y
 yVdug8rmWHpMqqKF2RQ9CY+HB+VYs1EKQH1q4TwLNKm87IEGurQRuOcHDHL2a5zYZCEn
 QPujWboLvLqe2KCp9UFhkWi9F+KEpwG6gFaz8shEzbcJWcsrsl4j/FU/69MPMZVXEeF9
 JXA6KGtze5YMVk6MYmdheGqXiiAYEjXzto6oNhdcXXdvojCFEB1afJRTv0HmlfxT6v4e
 hTbfhNnitErRXaYd6VnUSAMgsdwNqT4inE/sDOEwKx0k7VdSX6U0y2YuMRMe97zmEIH8
 zjAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718896944; x=1719501744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2yimdE3nPFUILo7awwhHRy/OflE23PtwusH0HEIKw8g=;
 b=tdevPXixjhbXFEjB2H/c0pTIjw7DqLFUCErbV6/TDQ4oFghtVXNN6uSIzN08KFZbMc
 j5Q0MKBGSomwN6a1xxE/DgPPNI8aWSYDNC5qtRMGdti9XXcUEBnt6LaALNdvYoA4bHbD
 uXYyVLvrQoNeUjf54j47kNgSToJGBbfqAcK5SMfoeruzPfp2c76Vqsx/LOe15l2mgVAh
 sEB3zypWMuTymnde6a08wqn6WTzonelvzJ7C2mdAMxnOWwtGKT2DqcncoiPQJjE4hYBK
 HrDQkIyXZ6T+jxAvCgfvnqbe/Hoib7EM2+u/IFCFx9FuxrmnvmMvwIlJRe7FrAjFMJNh
 k2FA==
X-Gm-Message-State: AOJu0YwGF2HddK2R7S08wQLKkyy+q5Fg+cRXUDacO6NpOwxD6Tt+f/fw
 VmgHSJm4lPjNnLD6nWsPkFy5fh3m4GOU1kPDvhhOgKxeigcxsRSJTfXYadEgDtA=
X-Google-Smtp-Source: AGHT+IF0pT64lOwvmgjrnZz5oRbIp3FmEbDr7uORUII+TZgPVQWBUAxVEabv+gd2aImTVoquazQfRQ==
X-Received: by 2002:a50:8704:0:b0:57d:3ea:3862 with SMTP id
 4fb4d7f45d1cf-57d07ed410dmr4532022a12.27.1718896943048; 
 Thu, 20 Jun 2024 08:22:23 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57d21df986esm1006464a12.72.2024.06.20.08.22.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 08:22:22 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 137115F892;
 Thu, 20 Jun 2024 16:22:21 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jamie Iles <quic_jiles@quicinc.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mark Burton <mburton@qti.qualcomm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-arm@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marco Liebel <mliebel@qti.qualcomm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Cameron Esfahani <dirty@apple.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Nicholas Piggin <npiggin@gmail.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 01/12] include/exec: add missing include guard comment
Date: Thu, 20 Jun 2024 16:22:09 +0100
Message-Id: <20240620152220.2192768-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240620152220.2192768-1-alex.bennee@linaro.org>
References: <20240620152220.2192768-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Message-Id: <20240612153508.1532940-2-alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/exec/gdbstub.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index eb14b91139..008a92198a 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -144,4 +144,4 @@ void gdb_set_stop_cpu(CPUState *cpu);
 /* in gdbstub-xml.c, generated by scripts/feature_to_c.py */
 extern const GDBFeature gdb_static_features[];
 
-#endif
+#endif /* GDBSTUB_H */
-- 
2.39.2


