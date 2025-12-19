Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3B4D7879F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 18:28:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWfC5-0006vG-4t; Fri, 19 Dec 2025 13:27:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWfC2-0006uu-5A
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:27:10 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWfC0-0005Ub-KS
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:27:09 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47a95efd2ceso17768005e9.2
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 10:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766168827; x=1766773627; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=L9GiWOmfyMyj5ciUSgqFfyjuX4l2YQUMTA4v3u2DnUw=;
 b=Dd60tmh+hK1WEIO9X0jzGa9zb0kNRaJA4hCq6ti3PdGLuDX1485+6ozMAeWFS1gEpS
 H+Bc36+GF7c2/1jMUUErMLDVkrdGwrQO+HxfSLAQHdqTipDNbStJ9+s5C1zwJahcJnA8
 EBOQPVxu4CpJig+5CGOwUasaDe2Y3s67SGWsd9zdbdhxREhnxKMkdIJSAk9Xe6S3lfsg
 GYPej6hyAvxiTMih1EC+hqao3OVnvS7N1r6bDEuteU+Wtilr2TmBUrMqic0cvaa3hudh
 iKF/1skPKUcOe2Hu2htqZ17iEzcMrP5JQpldwJ+aeaD9C1euM+HgqogxJJVR5YPeo/y+
 6rcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766168827; x=1766773627;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L9GiWOmfyMyj5ciUSgqFfyjuX4l2YQUMTA4v3u2DnUw=;
 b=f50ssQoz2w2pP8Jlf9NT/QwW0MwMxGWgbLq+vgiBOF4Qj0+AXzIg+GBwBWAVV0qkL8
 /AubfIZFVvgvwdV6x2vg/tVbmwngcMblZcaPrQB5+r9m+n9hFTsvOhdix+oQB24B7GAj
 m6UwQuevLOGprAdWGO3VTIpCk/RbWis+WGwwbLzhmEGhkc1eEvcADzEbZCCKQmdyDU09
 LHfjAU7nbE3zuqCV6fK4oYceb5XjRsUokYuxPVECNuiAOX/UyUgfrndPaWgDFBgdzPSa
 WujoQyMjE/8z1i3+hVUW+463T0HtVwTvZ9BSLhJB4Z7BhHctuDfFggh+dp76sPT6EIls
 Kz3Q==
X-Gm-Message-State: AOJu0YxbfVk7VXnQAxtBuRPRbbwg1ZBaahbyJ4M9bd/D6Lb2M3AkhDAt
 0pzoE5n8YKV1mDNr21FWU2IeK3bMNE+Uo5U84GCUhkpQBAxjUwlPcmo9WT+Wpf9VyDNMMbhIbAh
 QA/RZLa0=
X-Gm-Gg: AY/fxX7gfVfVfrzpt4dL202i1xZtHiYUb+w7GT+cp1v9VqFHCqsUqOPTRMU/cPvr6oY
 +x2hs6xgwxeuxzzl5GcfgqcSSZsKlWdpZBL0a37FXssAcS8rQUfFT8HXorV4hkUBPFKMq60rpp7
 w8ZpaGvlE5dPDw7mLl1rS4T03HVVPs90dmeFbITHVzydUSSUHg1961FrF9pSGKJe3tk552liJcH
 ADW2j9mLUxRdqZF9yGJNdlm0iB2moYYCGaZ8aqPd+b+YUSF5iPLyNUmf1GKTGjgQT7JdUtHR2jD
 2L8DxhtXD0gpjqaTmNIi5VfRPfID2u82t+h5vuNAjXoi/Z19vunp/MAnLn05ALnxts9rKdae7SN
 jE8oIf8bbFpS4z2kGkbzAetj3w6H4oh8dXjY8H6aFsZ/9juhVgpvsc1rG75xYpVeg526bN9ed0g
 agPCHsG+TFZVgF6AxdAp8NbTdFtl9RqKDpNE9rtl3iSMKD3LWkIK1nR37MFYYK+nV1hGZzUis=
X-Google-Smtp-Source: AGHT+IEqzlF4651WH8TDQ+UI2HzmBKNYlU2FMDPhzcD8SeijsOe1YEQEdo0l5tAs8khViogG4udQlA==
X-Received: by 2002:a05:600c:1d1d:b0:477:9c73:267f with SMTP id
 5b1f17b1804b1-47d195aa4bfmr42191985e9.33.1766168826443; 
 Fri, 19 Dec 2025 10:27:06 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3a0fb9asm42124425e9.2.2025.12.19.10.27.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Dec 2025 10:27:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/3] target/openrisc: Stop using the legacy native-endian APIs
Date: Fri, 19 Dec 2025 19:27:01 +0100
Message-ID: <20251219182704.95564-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

OpenRISC is always big-endian, making the conversion easy.

Besides a lot of preliminary cleanup are already merged:

. 5b67dbf1dc3 target/openrisc: Replace target_ulong -> uint32_t
. 500708331e3 target/openrisc: Inline tcg_gen_trunc_i64_tl()
. 4f6c60683f2 target/openrisc: Replace MO_TE -> MO_BE
. 73cd283e58d target/openrisc: Introduce mo_endian() helper
. 2f737e19a4d target/openrisc: Conceal MO_TE within do_store()
. 22c36c0a20c target/openrisc: Conceal MO_TE within do_load()
. ef797ac0025 target/openrisc: Explode MO_TExx -> MO_TE | MO_xx
. 81e2fb236b7 target/openrisc: Remove 'TARGET_LONG_BITS != 32' dead code
. 9dc4862dc4a target/openrisc: Use vaddr type for $pc jumps
. 2367c94cbb1 target/openrisc: Remove target_ulong use in raise_mmu_exception()
. 1843e89bec5 target/openrisc: Remove unused cpu_openrisc_map_address_*() handlers
. a3c4facd395 target/openrisc: Do not use target_ulong for @mr in MTSPR helper
. 2795bc52af4 target/openrisc: Replace VMSTATE_UINTTL() -> VMSTATE_UINT32()

Philippe Mathieu-Daudé (3):
  target/openrisc: Use explicit big-endian LD/ST API
  target/openrisc: Inline translator_ldl()
  configs/targets: Forbid OpenRISC to use legacy native endianness APIs

 configs/targets/or1k-linux-user.mak | 1 -
 configs/targets/or1k-softmmu.mak    | 1 -
 target/openrisc/gdbstub.c           | 2 +-
 target/openrisc/translate.c         | 3 ++-
 4 files changed, 3 insertions(+), 4 deletions(-)

-- 
2.52.0


