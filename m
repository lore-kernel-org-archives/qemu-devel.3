Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F30CD5BD2
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 09:58:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRoXa-00089q-G2; Tue, 26 May 2026 05:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRoXZ-00089a-LF
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:57:37 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRoXX-0000St-VV
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:57:37 -0400
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-4906238c62eso18128735e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 02:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779789454; x=1780394254; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=C6/NkZnvl6sK5ZtDxnkw+QmRTro7QskNIYwoIfNtqIE=;
 b=NfGUdwFmTtr451DVWCGpfXP3uQ8TKXEuhdaCNgXTE8ZHJf9nlbexhI6OJAuo6UZfBd
 iq4rtWrmTX02+dhhoXEfdRCl3pSIMLNgHszCZ8AgMtmjUi2EG4sQ6fX8Ev7be6/+p+L/
 PMg5rqhhtfRuBrRSViTda/nsINFNltsLu+fDgVgG46Z7tpm0DuzzUahMLim5RaKwIZ+t
 BVil5V40rl5uXqm79UV9qCt27WwIpK1GrfCLXXQX1Dc/CspsMqOs0Mdnx+uZhk8Dmc2g
 5jDwi1VHE4B1THbpNvZxP/IFMhnVO+krOP3KHYCS0ClWuxXsP9ojkSQWV+7Yn8aEow7l
 hQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779789454; x=1780394254;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C6/NkZnvl6sK5ZtDxnkw+QmRTro7QskNIYwoIfNtqIE=;
 b=KHmw1Zo3Qw9TdeC3ys8hAiQtCPS9i0o+94BzKHGGdko9Fde34ucbeJjnQXOpXpRCU6
 diTzv2vAUcNo3yA8xxA7FBNao3gMIFUTmwxzT74oP2RLkn/mWqu8zoDjIjEIuZUzVRAp
 XjXU5dGpkipEGUCpd+YEpSwDOVxfc8nCN8pm0S0KcRJwbUAIE/nKKYG/IReNA2SwMuJJ
 DeqRBr9j0HQAHHDQ8ZvpduMUIDS6h9qdje/Q9EBOiKlE+Njhwd9u2+8fOlr3DyNSjA2q
 2v9VBE/BH0E9FwCzMUO25c7z5JbxK9lyCWEvuh1o7Y2Q733DkPbPA4ZJ668ijnuT/zj4
 JYUg==
X-Gm-Message-State: AOJu0Yy5MvwJ/8pQ9Ln4qKqmYqXdl1thu4Ck8DRvm2lGCvNkXy1emFeo
 lhJYnd3ma6eGX54w0zKEBFGMyGAZ//p/rtaCIdRXO8L9lENVGp7FcG9Uxcogow9zZh4moirAlXA
 iNr/ZJyZYaziG
X-Gm-Gg: Acq92OETOwqOSGr7i06pK0bCWURYvlLBNvhpWqBkido6y06VHXvXs98m/SuZ1q69206
 KLhH76UQ31gltqx65GrkAk5UZToeF97FETApWB2t9XIY9K1xV3tLx4PnmWIzf0RQvRTe/0zD0bF
 kuVnHFdkCeuTF59v+bg9c/ejuRKMdKQGFopkQw1F7aE2D4BnJLnmvwYLLSnhvnUdKwDPdP2tzYg
 qSw9BQayx/qOOlN0xX7PpJe3oKilJQoSn5244wWhhMDxZGH47IIH9m3w29boHFyaqqMytlrt2hO
 VHNLORMXyabsok+rczOPo74uSRQrcJhgyswJ1ASF5DO+0WSqP7SN9tfo3ApWKy5zDyezsJUjOov
 FLJOzvMx0QwDVwp1IsCgR0PPk5Ki0ag1AJ4RA8wC5K7AjpeegDgi1yKR2aztNkFegkidRaYAXbL
 VOwRn2lF7s+TUtOXGjMYuJV+Fw0AYeqtyjMFeMS9o9d8Ou0O4dDMKTOAw=
X-Received: by 2002:a05:600c:46cb:b0:490:40f1:5330 with SMTP id
 5b1f17b1804b1-49042482485mr303837435e9.6.1779789454023; 
 Tue, 26 May 2026 02:57:34 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49048c6acf8sm94508405e9.10.2026.05.26.02.57.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 May 2026 02:57:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 0/4] hw/riscv: Inline TYPE_RISCV_CPU_BASE definition
Date: Tue, 26 May 2026 11:57:27 +0200
Message-ID: <20260526095731.63525-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x342.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Inline TYPE_RISCV_CPU_BASE in preparation of "single-binary:
Compile hw/riscv once":
https://lore.kernel.org/qemu-devel/20260520-hw-riscv-cpu-int-v3-0-d1123ea63d9c@rev.ng/

Anton Johansson (1):
  target-info: Add target_riscv64()

Philippe Mathieu-Daudé (3):
  hw/riscv/spike: Use 'max' CPU type by default
  hw/riscv/microblaze-v: Use RV32I / RV64I CPU type by default
  hw/riscv/virt: Inline TYPE_RISCV_CPU_BASE definition

 include/qemu/target-info.h      | 7 +++++++
 target/riscv/cpu.h              | 6 ------
 hw/riscv/microblaze-v-generic.c | 4 +++-
 hw/riscv/spike.c                | 2 +-
 hw/riscv/virt.c                 | 4 +++-
 target-info.c                   | 5 +++++
 6 files changed, 19 insertions(+), 9 deletions(-)

-- 
2.53.0


