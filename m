Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49AB7CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 07:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6kiS-0001QJ-Q7; Thu, 09 Oct 2025 03:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6kiQ-0001Q8-B4
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:05:30 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6kiL-00079O-Pe
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:05:29 -0400
Received: by mail-wr1-x443.google.com with SMTP id
 ffacd0b85a97d-3f0134ccc0cso402327f8f.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 00:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759993519; x=1760598319; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IZWnxm4AQ/3pjqxwIJhJQxVEFNuYxuMQFsIPc5iZzIM=;
 b=z3o05xTh2CvAcnbF44IoZg4sALfHW7dTOUZ8GqlfRVjcqh5uM4oH5FQNreGe09EBjm
 SFGLHNUqpMFMvmeJ0CTJ7moX1z+NKXQPzux5oKyN/WwTV2wnr7M3zBifqeizDpnKGaBv
 r/jbUwkc083nm/VCAk68uhoOw1pH80EtpJm7/eAWuCiTmrpvkfvINgebyp0Prb7kaaJ5
 1+eMvKlbLO0O6FWpJlbcfL6PXof0BCEjGG0ZZIv12us3axIvc3TAnaUvr65tAS5XLeb/
 Wfe9WGJoqvKZnwn6bvXOlTrxbHaoe8LgiBv7dY21wjFs8QB0kXxY58birt9xnC2B7xmj
 bBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759993519; x=1760598319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IZWnxm4AQ/3pjqxwIJhJQxVEFNuYxuMQFsIPc5iZzIM=;
 b=viit8HcWX6iQnmsqbuVt3io8qz2CvMPdXWl2FM1TUhGi7aja4EtXTLgV/sENlwf1lC
 J6iV1L5Qj9Bt9+Ri3U+n74+TLF5Zg7Z2rIivcjycJp8HCQejXRS0MxV0BknCyjG6t11z
 K6B4wF9yI+caE/3zD471ibO1ZOIspiG6LssMOZHNG6c5y8p+1X3G2yPZi4+RVFzEIsHq
 M+jTcMiE//MJXzkXLdBAQKe6s348JoDM6fP8ZJkl6nCXnI9Fok/oSsLn/KR+BBFzl6td
 IV2nC/vbOFIMw0feKpuGAcZf30dNaSwKXj0uebPAipdGrcblhlIIeoi8ha1knv1yg3KC
 u4cw==
X-Gm-Message-State: AOJu0YwPkjGkMWMh2u8sX0ayoqCN8ZKGFKyObuzsa6XIjsKxPJW+KGEr
 lcwswcwgqHQorEUYuWsF7/ME894eI+jJoorehVb6n7SgTmJbLGBQ0zdkJG8nHTvNl23nHsx76Km
 xD/hS6ZXLbpkF
X-Gm-Gg: ASbGncvjCF5W5+koLViVdgR1gnaBRM8XtpE+GDBTbWB+cVyZZtVJFTYmVqfMQVzPTHZ
 N2vbVYxrGu7I0RtUZ3M1vokUNMH00LFiYIAknKUjZI9CWedcQLEBPAOo62Hv9StwXWn7F7AbyT1
 bd5Zzq+uuxmuP2NYH+oiddoSdOLFAz9NobKLiYnn5pt5wqO4qALpI/HDKRScIBiENDKiiOaJoII
 7+NWGKc4LnH1FnU4qX8j945KDbDUdLF5Crse+16s0CaHvGASt+t+eH7Q98C60+unIXihBa7u1f/
 8JUgu+UcYp70hsE8/N3kBGph1k5zfS/foI316v9pvpGyeiWEJj4KmsFfxtJE5Q3a1vugRxY9S+6
 TVF36I9Yu/aAk7RJz4dV4+hwSSpsO2Z1O05/uW7qnE3TN40DT4/N8d+aZxT+21M30jtVjZcRxU7
 h7J8SePpxwEo/hQsGFw5Efdfta0/74yetsvU0=
X-Google-Smtp-Source: AGHT+IH/jsop23dTnnTcPzA2aPTSU36104tZwOPrP1GQF3K5T+1q6WZu6xj0MT+mPOBTbNalFEiEPQ==
X-Received: by 2002:a05:6000:603:b0:3ea:4e8b:c96a with SMTP id
 ffacd0b85a97d-4266e8e64e4mr3896744f8f.57.1759993519160; 
 Thu, 09 Oct 2025 00:05:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f02a8sm33615328f8f.39.2025.10.09.00.05.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 00:05:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH 1/3] mailmap: Fix Denis V. Lunev authorship
Date: Thu,  9 Oct 2025 09:05:10 +0200
Message-ID: <20251009070512.8736-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009070512.8736-1-philmd@linaro.org>
References: <20251009070512.8736-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x443.google.com
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

Mailing list mangled Denis address in commit b67e353863d
("block: drop force_dup parameter of raw_reconfigure_getfd").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Cc: Denis V. Lunev <den@openvz.org>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index e7271852dc6..f2f83e8061f 100644
--- a/.mailmap
+++ b/.mailmap
@@ -57,6 +57,7 @@ Stefan Weil <sw@weilnetz.de> Stefan Weil <stefan@kiwi.(none)>
 # precedence over any munged From: in the mail's headers.
 # See https://lists.openembedded.org/g/openembedded-core/message/166515
 # and https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg06784.html
+Denis V. Lunev <den@openvz.org> Denis V. Lunev via <qemu-block@nongnu.org>
 Ed Swierk <eswierk@skyportsystems.com> Ed Swierk via Qemu-devel <qemu-devel@nongnu.org>
 Ian McKellar <ianloic@google.com> Ian McKellar via Qemu-devel <qemu-devel@nongnu.org>
 Julia Suvorova <jusual@mail.ru> Julia Suvorova via Qemu-devel <qemu-devel@nongnu.org>
-- 
2.51.0


