Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2ADEEE2086
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 10:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voJ3I-0001Q2-Ab; Fri, 06 Feb 2026 05:27:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voJ3G-0001PZ-7a
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 05:27:02 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voJ3E-0007Rb-JC
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 05:27:01 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c075ec1a58aso693922a12.0
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 02:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770373619; x=1770978419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=yXYMlG5aH3vUYMJ29Ny0BmERw9jc2mXgZB3mj6BPDAiCqPaoiDBg5auX2xAt+kAk4i
 6HXiyXRyZ1wx+inj5gTDvOmo86JaU4kciaTU1farR6TvMpPXBDsl2Qxk2a+D53MUzZIM
 Y4PV0PwbcWfw7QlELCLrwrTXrAdgJ8LX7r/2M+mvqnccyXMRuS+MIG7Y/iMAm5Ay2MZh
 TUMSwc+leHNogkQzIvairEcWdoiiYTf6an4DIyKMViRaS2M+W/FuPFfZapPXN2NFQjek
 8/5GJRMk0QcaHzA5u63N05GL5XUMSAd/aReDCtGxWB1ZElSLw9l3SAlAnrW/P+2HxTkf
 lB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770373619; x=1770978419;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=UCcuKNgcGovq8bPwJK1aNst75K7Xjtpn5dgLs3HUWJxOtwx/e87gI1RVAUgqLhJjqO
 i2qeon7y02nKaEca2P7hfOlyXp+ZLh5h65KoUz3S7ML1dUedA0NtboeYMBeR8wl0Ib1F
 PzLKyjRhkBp0kGSDIsHhBfRpk8Q1GZBHLTc9OyAOTXQ3yMV1vBwpYwqs90icr6pNdDnX
 vSjNIVSzwczY16Hu0u2y1uc7qmaJbilqDiOsToDHlhqkLAYSdekfZCIfKeRQucu/x7fh
 idZRMkkrAvbwRSbnM0o3yx6eamnuuWEq0wovRtero9hekGwoCSxXH/gIbevQeZtBfts/
 fRnw==
X-Gm-Message-State: AOJu0YzHU+ACUMxAzxzrm013nHnKywh2wGsHG3hTuAyQKYLT9rpNEyqc
 cjgV8fybbKrGKe2D79lgEVUHzW0TcjIJCeCesTbQHe2s1GFaoBWnaALlw75UbB6A8rGcQKKPNqz
 Qxfok/i+uyg==
X-Gm-Gg: AZuq6aKYirQOinIvNNHiYwexXYEzVapbt98c93AaBDV/QmPR7Fc/pvBjLovHqW/iMSO
 1WBsk8ZZkMT0dUGZsfTvOYTNVz4pGoz1S7gUa6vmTGqa71baK/AHOZIlZlmnO7GjU+SPnm6tE4E
 CPKgC4LwnAFmRTeB5I867QKy1UzaQwtruROV7NEaPxWlq9vfyjIujNu7pryk4j/eJU9c5wCDF3w
 ehmn3iSrF3sQhB8o2K2DDpruaB4qmS8Ayur+Xqf2AC6HnxLaNOn9ZfMQcRjYVHCNcUuM/0nfpd6
 Kr2Pf94Ff28BiFH7pItegwC88uKCKEq45yMeqEJhFxfOKFazt7zYuRQ0/zrgxniV6YUQlegmYWH
 Y3HRgOPpbtN/7YaShvPZi6NBI9Zlrkt3vAYvV/7aT9mRQSnoKOnjmRmEyGRwLu6n3a9J/uh3SMB
 JzOMNYgOBJbdLtXgyIBIvJ9XaGwKD/wBSBxGlbD4cX9HUFbF8QzPLqJnRiciJmpkhiu/+eEpEdR
 oM=
X-Received: by 2002:a17:90a:dfc7:b0:354:a57c:65db with SMTP id
 98e67ed59e1d1-354b3e2ea73mr1892620a91.20.1770373618863; 
 Fri, 06 Feb 2026 02:26:58 -0800 (PST)
Received: from stoup.. (bg30dhzpdc341w7g29yn.ip6.superloop.au.
 [2401:d002:dc0f:2100:1ced:e57b:71bf:567a])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-354b1f49191sm2113723a91.7.2026.02.06.02.26.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 02:26:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] tcg + linux patch queue
Date: Fri,  6 Feb 2026 20:26:47 +1000
Message-ID: <20260206102652.164018-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
X-Spam_score_int: 16
X-Spam_score: 1.6
X-Spam_bar: +
X-Spam_report: (1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, EMPTY_MESSAGE=2.32, PYZOR_CHECK=1.392,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


