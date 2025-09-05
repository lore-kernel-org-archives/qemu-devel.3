Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 476C4CA1015
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 11:52:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuUyt-0001YS-Ov; Fri, 05 Sep 2025 07:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuUyr-0001X9-BL
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 07:51:49 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuUye-0003YH-To
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 07:51:45 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-45dcff2f313so12764605e9.0
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 04:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757073090; x=1757677890; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EapCZB/FCGF/ZPuTeVtlzDN9C3/Ya/lmVh3FD9dhVQc=;
 b=fEyZE21Xr4t3wwh/FoA269pnJ26v/m7JxVIFIdJhoi5e5Wd8EqjD3AP8+eIyn7AApf
 3iM0x4qqUc4PQraUFArRqoROtaMIx68VFNUpqZD24tmDJP8lC00n7QMiW994MC26VeQm
 N2EzluDxr/j8jw6IVhyQI1kxhJJrzJotF8JwdyGezc8PeYOUMlns7VPtH3RhbfHmEvDD
 18SLw4BeBLdycsp7wiDcaqr73RMA4Ff/ozo/wPy51LBUIZ+MO0fC85JWC7K2hU69YPFP
 g7zWp9sEGdHVt0KNa3BzcIk4xxuR79mtl/jXr/k8Y5VH3vwPjLxyWhrglbw7fMXH6ft/
 T6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757073090; x=1757677890;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EapCZB/FCGF/ZPuTeVtlzDN9C3/Ya/lmVh3FD9dhVQc=;
 b=uTG6Iw7EHbdYq+Hk12coAhXogk6OrzxbDSPdH0BXIgR6wF+KOHn1X4Czwi4E6U/qy7
 Y+Cc8+6BSOQk1AfFdauHyscZh3//tJFiHKXBW7sZY5TKdmQdIOFYNNE4pKvYeVxrPbiI
 mVIj/LTOsET3Nltgvk/FQ4920PzhjrIioL2RGKdFVXCRPuwMfAekMZSnqFyEVV0Pp3FT
 6hh47SVbM0m+F155/WJ6myagbADmpIsLnVtsAIS9qHXX+icW+Rve/rWrrF84emVKMd+x
 +z6UdjVRC314nGp75Z16qmWgJc7GUiiPC/QGXvJmQlLGGixi/Oq2DbHs6MB26I65fD+E
 WwoA==
X-Gm-Message-State: AOJu0Yz+UPLY2vfRfz7EHGVczu/CmpzI0s/glpSuW9TQnh8VKrukW1pQ
 QY/W6UUwV0K/ltkuPpZmw52aMY3tsaz3wI8zzFKifWQggXWBDFOPr7reGA9QBqFtucwGA4ocND4
 +6iyYjes=
X-Gm-Gg: ASbGncsq0r0r2Bq3xGCrMrX8ZGDE3Vmf2jMDev9QAzl6fXawVMuNs4YudMv3amiHVxr
 KfXvIAoVgwD6Vv94tync5bSKT8z6kQS9xuAwgyi/paTWniV62IBKFrT1UiO5tsnczs3iNxdJZ7n
 ftq6rFwl5UdMXBFuN89vwoZ4UYysNtP2v/MqcS850PM9Rt1g4+UQCw6j2ANVF22qsIp3jUBhbtv
 qnvldCSz3hQPkS1Ym4ndjqy5ljWdwIm9BEkyg5sl0Xrd8Ykvj2krMz16Kkb5ftwrgJ/o0ZcQn6X
 VRYnNCBoeE1c4byBA/SaPAhtrudz/p3bhhX+kEM5hbajU/hqdh/gkJLh+laGnqJZhfiu1hn8y0o
 mNTtzaxufbJJodQ4AKwnn2A7kZTJIOzUnZZ29WZ3QIQvML+XcjG1KzteR
X-Google-Smtp-Source: AGHT+IGkqx8Dx4joD1aHa+bdn4LnNdhvRbJ3j+6RuDGFqkdr+hy4h5FP6vtP2izTODNG++ulDVGWBg==
X-Received: by 2002:a05:600c:1396:b0:45b:868e:7f7f with SMTP id
 5b1f17b1804b1-45b9615d7fbmr145339285e9.17.1757073089640; 
 Fri, 05 Sep 2025 04:51:29 -0700 (PDT)
Received: from stoup.dot1x.polimi.it ([131.175.126.3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b8f2d3c88sm194285115e9.19.2025.09.05.04.51.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 04:51:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH v2 0/7] target/sparc: Relax some decode for v7/v8
Date: Fri,  5 Sep 2025 13:51:21 +0200
Message-ID: <20250905115128.376295-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x334.google.com
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

Hi Mark,

I noticed a few other places where we probably want to
allow unused bits to be set and ignored for pre-v9.

Changes for v2:
  - Use TRANS() in the STBAR and RDY patches.
  - Apply the same relaxation for RDPSR, RDWIM, RDTBR.
  - Do not report illegal_instruction when unused bits
    are set in the rs2_or_imm field.

r~


Supercedes: 20250905051936.92815-1-richard.henderson@linaro.org

Richard Henderson (7):
  target/sparc: Allow TRANS macro with no extra arguments
  target/sparc: Loosen decode of STBAR for v8
  target/sparc: Loosen decode of RDY for v7
  target/sparc: Loosen decode of RDPSR for v7
  target/sparc: Loosen decode of RDWIM for v7
  target/sparc: Loosen decode of RDTBR for v7
  target/sparc: Relax decode of rs2_or_imm for v7

 target/sparc/translate.c  | 77 ++++++++++++++++++++----------------
 target/sparc/insns.decode | 83 +++++++++++++++++++++++++--------------
 2 files changed, 97 insertions(+), 63 deletions(-)

-- 
2.43.0


