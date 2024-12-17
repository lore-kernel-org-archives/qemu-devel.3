Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA13E77187
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 14:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNYKT-0008WS-Tk; Tue, 17 Dec 2024 09:13:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNYKQ-0008Vt-Uq
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 09:13:39 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNYKP-00025f-F6
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 09:13:38 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-725ee27e905so6826772b3a.2
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 06:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734444816; x=1735049616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WnrPo6CEMaC1ncbSc6+SgkbANPFnAxbQUbfs+Lkqs1E=;
 b=ORyjIXCq6keQBkRxXDyZSz0uv6zDj+E6MnJ/2k52Uq2gDx0khqUphqM95fgRtc98gU
 yNulhQ8+EgXqkvNpSF0Ruc47Z1Sf5toKONRcOC07Tke4TiYFsmlp1sd55snYXalljydS
 pCzaXBeLqb4y2uE82RH+xkJ9ugkkF5X9yqF0vLfzc+D8HXRbbhoIqvqLKciWrqQiT7D/
 G1CjjJxdbsC5lwXnQMew235rRzkn0beUXJ3V07eQHI589bInG2gGAc/8DoWXFh3vuZ1O
 PzP/x3VLbtxoDexvex3XBS2KWP3IvH7JcqYo+DTRELMeNKBKBYr/xkPSBFTQ6H/KKkv9
 tXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734444816; x=1735049616;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WnrPo6CEMaC1ncbSc6+SgkbANPFnAxbQUbfs+Lkqs1E=;
 b=NZd4Xr0yWiOC3DLpcX3W50k6N5AltwHxGhLPKr+cZTNrNZfhyMH8jWJ3M4QtLmkthS
 Sc+ENesa75uwjRXY63sBXHF+bgmzaFdUF5rskYEOTYwoo74HfpRBBX/qyjOj9CEilbfr
 uxsnZACdzh9v/UI2SYlKjiHX3z7zN6d9KU6ywUPH2+Mt5udS5Tgf9meHa1H5u8cI6zRW
 DoDT2B22itTB7Cb90c5dlGlZuEAUHJrHe1PD1hqXANR1SRXXQZIdaA0IsjW4ZnBOnD5P
 0dipp9GVwaj7tXQxxHj7atbrnNZu3VSg9P5f7ChsJd7KerPYJj8Ua6U3aX5vwDHy6JMe
 wOWg==
X-Gm-Message-State: AOJu0Yw54yhAu1fgby0Iu1ZiDHEhZXF8yRP9CrXpvQyPtOFap0tHP1lY
 jonGK577O55GB30o9sVGBReqGqdOnOr6YkWpsDibi+Y0KPhBr5wUoTPMY0sp0A/3hCpdpdajn3I
 8
X-Gm-Gg: ASbGnct81nyeZkTpS44563NRhd058pxAfD9KQC2TqpFAbN16FOYugGK45OYbHFDpa8V
 DjqF7D+AG7Sdk35VgXEDlGSiDqTtB2Y8YrhALPYeH0fmyMYb5m43O7A6Q4vJQE6gMsnb2CHrXH5
 vdaOMil3A7Qvg6W88ossMdOR/CK7bn4d18Jdz4FtzbUaiz5eQweoz7hG+d//+PWMqZSNtTA9KLZ
 IGIxO1p7rWWq5XezevrvY5A3D1z8i+UtZQAv8Uzn2kskfGrmd2VHWCCl/mi7CXhP5T+P9zKXzGo
 9nDl
X-Google-Smtp-Source: AGHT+IEJ7CnJNRfvMJwnd9iL3OqVe8L0PHONq2mDBjpwiDcDzi9HOFVI+QLx/dqB3rOHkXuc/+GBuA==
X-Received: by 2002:a05:6a00:8d5:b0:726:41e:b32e with SMTP id
 d2e1a72fcca58-7290c111609mr24558119b3a.4.1734444815723; 
 Tue, 17 Dec 2024 06:13:35 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918bcdf06sm6937397b3a.184.2024.12.17.06.13.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Dec 2024 06:13:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] include: Two cleanups around missing 'qemu/atomic.h'
Date: Tue, 17 Dec 2024 15:13:24 +0100
Message-ID: <20241217141326.98947-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x436.google.com
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

We have 2 headers using qatomic_read() without including
its declaration from "qemu/atomic.h". Include the missing
header. For my own convenience I plan to merge these 2 patches
via my tree.

Regards,

Phil.

Philippe Mathieu-Daudé (2):
  exec/translation-block: Include missing 'qemu/atomic.h' header
  qemu/coroutine: Include missing 'qemu/atomic.h' header

 include/exec/translation-block.h | 1 +
 include/qemu/coroutine.h         | 1 +
 2 files changed, 2 insertions(+)

-- 
2.45.2


