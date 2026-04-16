Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9DA8F8A145
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 09:19:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDIrn-00066j-3o; Thu, 16 Apr 2026 05:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqR-0005Af-BE
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:08 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqN-0007kH-P7
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:06 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so71619935e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 02:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776331022; x=1776935822; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gqaNbWDHvSpHi/VF5F2lpQOlJaRYccg5RJJEHGe8q6s=;
 b=doxSufCkAAycp2BgJzw5b+XT2BsbUZNNq+sFgtwR2M3uAE7213bMULLmc/ueFfAZsb
 /mfP5yhUYBQtT5fJqBNDVappBFX6i/PSb7rJBXgdO6k4doiaUap2I27jArEEiiNdPB71
 bn+hw8axaEkGUT/gNlteL4g6WEnf9zjEZteByGbW8lk06MdBeLMh9PTmuS8IZWY3B3Tu
 Kw3ixuvGM8DHwLDe3p2fXvOyXLp/40mhrC5zyxpGZf0Dh9xP1fvKBFk9SCrL3s1is3vU
 jucLxJruqB/eKZJyE6FIktVpWDxwCvy04ebSBYJCnavpGevmk2GBoQ7qpY4iqBISJsK6
 JXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776331022; x=1776935822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gqaNbWDHvSpHi/VF5F2lpQOlJaRYccg5RJJEHGe8q6s=;
 b=PlXxIpeykSYFuUtUq6bYVXdFPGdH8Ei7bpnLVG6042a6n8uy8iy4RgLlkZlUIUBugG
 PFfeYAuZVJEHO2NT68+zfAbh9LcH0IqaJqMgKBuuWLqGLI9U923p4hS6BwQkBC9I2+LV
 yoNyoa15Wbp2K+sSSwEpSCo1xBak95GvnmaF5B7r6jgiR3eNxjKpTew1Kzmvov/SFoc5
 VI3fttpyQfOOJH6tlGLK9qeEQxKfMalze/6DsEUgscJRZxMrZqSDrRkjWICvBDWFFacf
 WmOY4fOso9eqcTonPCS0ZWOx2Ovj63IiHf82MccEGNgAhpnnud1LL+3AZJAacffldrQy
 s+Ng==
X-Gm-Message-State: AOJu0Yx+4T9f1XUM4E2UEf670c2WHjzCraRAGbNaT5mtJRkC17fIPeNy
 J8HR6uTjJJp8CxkMyEAMpVTUmDs/JznA/ijt3jhc8riUroOQY94qGRjww+oJlBcyJ/mnhSjwaYf
 CN1xQwSs=
X-Gm-Gg: AeBDietTf57WzFSEkZtsT/d9S/o2BWJWPMwUoHeXUATdH1Jw24N1UNuR5pXc0sHGChX
 bDzJBDQZgwPF9EGnRLaIVqvLyxCp1yRwk3ssYa5CCGKbSALSiV7fSCv92g/iIa4w41rMLYS7eeY
 Fz0JCHxZZGL+GGHEKj+nBwE/EIfiWPfju2rZ/aa0xCnlFjZxGbeb1msqm3cHmdwrEF9qSKGQKsH
 T2Pmp8UjmrctciRIBTiwvcb61NxukVrZv5l4k1WW23O04xUYBKx1gtFJ8gRDARQc9/jUn9Wbr8u
 PzasPmpuh6H3bNGyJ2rSCLOiArRt8vEhxQ2GKYLQxt3Z/lbQLyggT6Apr8r6p9TAeGOUUGGvDmA
 tI1m6pH+MXxQcel5htrJdyDbmis+IsxG6dbKovdve5TcLG+ZQSzHoW6apWPh8GPD7StTiGXRGn0
 q5Vpovn7VZFa9BgA4p2V9GKjmORSsVyyEhfB1HmEEqu1xkqGU8GbsVfWM0y/Ypux9G4IHaO1avW
 0/0GhpQihIf8wGVDHO7N8bixY6YGT772pbzIXPQ2A==
X-Received: by 2002:a05:600c:c091:b0:488:a977:8d6 with SMTP id
 5b1f17b1804b1-488d683662cmr251377055e9.19.1776331022039; 
 Thu, 16 Apr 2026 02:17:02 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f5818da1sm37186565e9.6.2026.04.16.02.17.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 02:17:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/28] MAINTAINERS: Remove Damien Hedde
Date: Thu, 16 Apr 2026 10:16:32 +0100
Message-ID: <20260416091654.316158-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416091654.316158-1-peter.maydell@linaro.org>
References: <20260416091654.316158-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

Damien Hedde has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 341b86519b..885a11710a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4034,7 +4034,6 @@ F: .gitlab-ci.d/opensbi/
 
 Clock framework
 M: Luc Michel <luc@lmichel.fr>
-R: Damien Hedde <damien.hedde@dahe.fr>
 S: Maintained
 F: include/hw/core/clock.h
 F: include/hw/core/qdev-clock.h
-- 
2.43.0


