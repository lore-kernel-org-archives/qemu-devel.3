Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41055C624CE
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 23:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1BpH-0007IL-6y; Mon, 31 Aug 2026 19:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roiklevansky@gmail.com>)
 id 1x19SQ-0000fh-Mt
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 17:22:22 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roiklevansky@gmail.com>)
 id 1x19SP-0004nE-1s
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 17:22:22 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4980fe6b3beso2645045e9.0
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 14:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788211337; x=1788816137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=80Y4SurtAQyLFH1WkBITnQUNVJhWLzqO4uAeKQP26D8=;
 b=ch7FuotbIJnt7Iy3u2LrcSzTulyAi5mVNR/EzcVq3sGnjQqXZ82wAX9r9DcO4eDJ2I
 7PqZvWmTZqDPNGPynVZwms4pn2xvOEzlnMuVrrrGfhrsz9/nEnCcg9O/JvLJGDPwZCoY
 y0YenuXKY07NgDb9hR5QHTqUhgJtSdBGQML7UEeJ1+TehWTGKUCx8sylcVuLncmRK9YO
 kkvfHdyU+j6pVOJLB4fT88LrfXagtK+hnNaUrknMQIGPAtHA39XdIh+oNH0PyKgG3sei
 rUzIf3coxEeY/7ZsG5rPao+vK9JyJSlqv8nQx60KxfSoHBu9j4s+GNy93iQcfuggmc9w
 Htyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788211337; x=1788816137;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=80Y4SurtAQyLFH1WkBITnQUNVJhWLzqO4uAeKQP26D8=;
 b=EXhXotAhmDDsZIJ7rOa8QxoZ5VVJP6w7gc1BN/9BpxBcz+PwuH37YzZYyZ6LW7GVTb
 DzPqUC4nO3IRcK2wfF2/f+WV1Ox2hr9ZqPdsk6izbZk4lUCjKsWs2rUBXFK0r9XNRSBt
 4KAkMDpACjqbJ4JbueoE6XhaZVmkWUgd2TJGR3wK2I+BMPpo6cyNhspj1NXSLDuO/ejQ
 C5Qa5vAyWDmmzrwIuWSu4VHx8cSXFgs8O7GuEVP9hUkHMfFax1wn1FAxFx7kR9LlkFKJ
 9xWYMb1QNcqQR862HTQ/xwUGRsLnFe4dh9W8M9lxEjh2mwhDogxQ8wW77r3zeKQ1xRgX
 1xyg==
X-Gm-Message-State: AFuF++lAVHTvJNrSZiFlPgu4HKj2m7xuY4SS+Lz7m+P3rEFJQQlgUoQ5
 6zQlrsC02qNhcMaVR+GKJ2DZmVji+Go8+z4C+qqVOCkZj80dCzoaBXvXI/3M/Zrl4Ck3Lg==
X-Gm-Gg: AR+sD103S7A5suAWV3325qsrmrrw5SzjWWeSaLakB30KRr5Na8AzkDsPTV0wAf1q4tI
 R45rpGYeZGFi052gQK//N7q5cm+ZhEN+4er5MpD5gbHF48z6srV7Nljhb+TqGoNTbJq+Un3ObsR
 ZYNkhahk5+I4sipUM3oBofjDu5j+h/b7hEBuctpZ3QZd+MSiWUGhVMwypeQYbUa3Xn+dtq4DF+N
 TZMdYuPIlvLDJB8pR6xtJ2a+zp1tsw9EWkTeV4FilZQx1/oDpr+96M8EhIRs14WPxnoAkBbakeD
 1OagfxlSm3/mHbDC8/LrdguykZpn+ZcRZiK24/apUrdWDn6HmU4hDngi0QzAaFwXMDWEGvYNVY7
 bIqVPfAkwFfz5+dQHFsSbpPuCdRSAn9MK2JtOIVhC+lN4axn9ZsZVfkYI8nxM9pdCx8jEPtwWBI
 +zQGsHHqyglV3zVoAP9jkKOVvbhuoldG5VNeyNwG+ZhkJrvbQJUQE8BIbqB2f8ELL82gdQ8NJ/M
 pfGZtewHCUIkcBP/HsZFrvwOG3N+KvO12jQMmIX3l3jv2BCQl0=
X-Received: by 2002:a05:600c:6819:b0:493:f783:c46a with SMTP id
 5b1f17b1804b1-49cdd41ca5amr16652515e9.6.1788211336947; 
 Mon, 31 Aug 2026 14:22:16 -0700 (PDT)
Received: from sima-pc.tail8094aa.ts.net
 (CBL217-132-71-241.bb.netvision.net.il. [217.132.71.241])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce10148sm18749815e9.5.2026.08.31.14.22.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 14:22:16 -0700 (PDT)
From: Roi Klevansky <roiklevansky@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Roi Klevansky <roiklevansky@gmail.com>
Subject: [PATCH 0/2] linux-user: return ENOMEM from madvise on unmapped ranges
Date: Tue,  1 Sep 2026 00:20:38 +0300
Message-ID: <20260831212040.1833650-1-roiklevansky@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=roiklevansky@gmail.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 31 Aug 2026 19:54:06 -0400
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

The kernel fails madvise() with ENOMEM when it is given a partially or a
fully unmapped address range. qemu-user differed from this and returned
0 instead.

Patch 1 makes target_madvise() check the range with page_check_range()
and potentially fail with ENOMEM while still giving precedence to
advice specific errors.

Patch 2 adds test cases, calling madvise() with partially and fully
unmapped address ranges.

Roi Klevansky (2):
  linux-user: return ENOMEM from madvise on unmapped ranges
  tests/tcg: add linux-user test for madvise returning ENOMEM

 linux-user/mmap.c                         |  7 +++-
 tests/tcg/multiarch/linux/linux-madvise.c | 43 +++++++++++++++++++++++
 2 files changed, 49 insertions(+), 1 deletion(-)

-- 
2.55.0


