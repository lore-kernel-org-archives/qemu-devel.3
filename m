Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82ABCC369DC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 01:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBl1W-0005lj-6J; Sun, 04 May 2025 21:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0z-00043z-39
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:53:05 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0v-0002eZ-7E
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:53:03 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-736b0c68092so3402825b3a.0
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 18:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746409980; x=1747014780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vzXXutq4wGalZELe39I44dxOL/4dV/vBf09UEOe1qt8=;
 b=cLyvWSJXicrOASpE9lDi+FUuxukyRFmFIB99UJhc1DENd8pPgNi6MNKcaHsa5nv/pd
 9edg9ZI6Ch23k2RzOIQteAMa5d2BWdbMmU4t7doOulqWZpDWTDlIsv7A8qG4sfBNpApZ
 Tp6Fsp3XV6Xit78AerRUHyvAsDnqLcnuV44uuZlsyPBMj07YJ6YY7TjrBzgZY+vULJjq
 5tNyiIHjO3tm7Xo1w97WgX6cveQPcml3NfNowlILkoiUOCuQXys/2i/s6CVkjT1CF4ox
 J2kV0zVX+wU4gnExf10lutE/u6FRmRuqjV0SJkqXtjAyUQh4V98Obpg/40JdCmyF2C4p
 iF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746409980; x=1747014780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vzXXutq4wGalZELe39I44dxOL/4dV/vBf09UEOe1qt8=;
 b=GEss1H4g+H+YhCfZHpACLvugDVdBnhkL5bvd0rViCbCj6RB3tudJ9J5vnscMYN40L8
 1MX1pL9A9l8NvUVfK8DRb6XyMX1rjtBzY1X9XsFeio2wgDaCzY8kkfgR4orNKWzXVgAk
 83he9YOMHjouGFplAgaMZXA49lMjCrRPasMpu563HJdmYFLLHoqKLhUZ8eCQzSw4N3NT
 npxI8D34Zl7SI721URDM5Pk2IawI/mTNaNlrfouiY6uwH8ROilo6bb316ickFr3/au2C
 q2wQXzUmb5x/OQWWeEEWnlPPqfAkcEIAFiH6Zx41sOKetg7Qq46SURIk7vgoci9QFDRz
 2EzQ==
X-Gm-Message-State: AOJu0Yy7QOf638cST3IdDqnpU1kzoIwzsmWyppjaLPGkk1LEmqTNmu/8
 mQlPINKVlod7LVLGUyZSYSevNjac1WWbF3zQr/435hznkObEFEeDDh4rBYiF9myC4XuAF9GdFyg
 0YZM=
X-Gm-Gg: ASbGnctBHvbYHDLfEKrQTYqOdv9QgVHre+JkpH0NjgucbRCyfycsp10s04pGiOqXhIe
 IVcfobLjtgDsJQi1n5XbDO4LtV2lVArTUecl/qnTm2Ls1ZapSefhM1AqVXwOUvES4rCaiq1T8O6
 DDUAJIOhr+JxEtNS740X0qyUxoojV6Tq61DMQCL/vPc2Bn24lQWbwfnrXoadEfl3uMYE6i/X6W3
 GDMJVxB/uOiATugV510mPLgof6d4CQilZHe0NpJGnfkmNHNl56ARGvQQlbOiWDI5bMZiwZgt6G0
 /jTPa7OCyYz5/KwbKSIGXtFai29bjGQ2BZNloAWLLDIWETUpz+4=
X-Google-Smtp-Source: AGHT+IFgLeVwvQpFcZ2xjxjTrl7k3WOiNHp3SqAmhA94n1nQpI7p9dI1Ond7jrjd4FwoecItT43iAQ==
X-Received: by 2002:a05:6a21:6711:b0:203:9660:9e4a with SMTP id
 adf61e73a8af0-20ce04e6871mr18561298637.41.1746409980047; 
 Sun, 04 May 2025 18:53:00 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3920074sm4462101a12.11.2025.05.04.18.52.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 18:52:59 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 34/48] target/arm/meson: accelerator files are not needed
 in user mode
Date: Sun,  4 May 2025 18:52:09 -0700
Message-ID: <20250505015223.3895275-35-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 151184da71c..29a36fb3c5e 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -5,9 +5,6 @@ arm_ss.add(files(
 ))
 arm_ss.add(zlib)
 
-arm_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'), if_false: files('kvm-stub.c'))
-arm_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
-
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
   'cpu64.c',
   'gdbstub64.c'))
@@ -18,6 +15,8 @@ arm_system_ss.add(files(
   'arm-qmp-cmds.c',
   'machine.c',
 ))
+arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'), if_false: files('kvm-stub.c'))
+arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
 
 arm_user_ss = ss.source_set()
 arm_user_ss.add(files('cpu.c'))
-- 
2.47.2


