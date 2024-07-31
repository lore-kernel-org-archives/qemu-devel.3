Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE6B6C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 14:38:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZARN-0004kj-I9; Wed, 31 Jul 2024 10:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZARH-0004V3-Sl
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 10:36:29 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZARD-0002eN-OD
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 10:36:26 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4281f00e70cso26130155e9.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 07:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722436582; x=1723041382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MAd46eTldG2I+2ED6a/rVkcfbA6YevMDXfrDk/LBM/Q=;
 b=R8kL5rlZThLIGA8FZC7y/fcakAuzaOdaxHQoVW6yhlnmNmr5Kkg9TULROnItIo8tDs
 syiDj3S1+0/sGJdER4TCxKAv2e+wev+Kip9yEUroMk3667fZX6V3hcz91VZtLUZ2Js+V
 bPo5Pq4ynjGUmy6QrvNLXa3FXI/+XCXOgNgHkzAdFy6mENXFfLJLK09mmN9+qPWvNESE
 66ZfdaJFGWL18Z7KCpWOgCtuw4FQIHF5nweUzZ8jCX3BaCuzZ/SjIRcSF9Lp4hxkXOav
 P+9dGIXEXVbSLA+aCAiuZThn94P+9uNkoX7/+gjGRdwxNH9+mlOyMWmaHlAR296KSsHa
 LWew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722436582; x=1723041382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MAd46eTldG2I+2ED6a/rVkcfbA6YevMDXfrDk/LBM/Q=;
 b=h5oMUuVUJ6f6r0YZuZgeM9lLMAQGistYQLKzkdw3nB/qizRI3EUNUkb3dXNIfx9yg/
 Sct+ofZjfWQ0tvFPt+uiilOOApz/Nq/dp+s2bjiLe4fTpw5ppLHm3Ypw1oGwohMO5SZf
 Fkwg1CMRH6ZEqSafRIECHoO1irBHaHN5Fe+fudAiTTre4dlCao850QXmwz/a9ot0tGgb
 A/rXPgE7rtKQ3dP4X2rIluq9UCckiiItwL+oIBczhaVuLyJziX2SiwEWGE6oUOU4U/1O
 +2P78t7ChZlmVh6kfn78yCMegvAn6CSZDWofomJjNH6KwVYKu2ts50+Tuz1gyvPt4/as
 hF5Q==
X-Gm-Message-State: AOJu0Yx6Vpo9fabvl0ZXNE7KjuJ3yKsD3ZQWKKUOvyIn4jmS31UqfNbf
 27XIsJN0hj2VN0xI1s60Jv524aEfXxrg7WEi8eQ1osg90ZdiT4cf25w4iiQ2AzzwqEa7D48OBmH
 4
X-Google-Smtp-Source: AGHT+IEhSBErl0jyu9s+g96bkqrq1Co2veAAhfqZmHeUBJ5zqUxDD5cMmMuB++ZoSsF8uwkFEz3kow==
X-Received: by 2002:a05:600c:4c1a:b0:428:10e3:a000 with SMTP id
 5b1f17b1804b1-42811dfe3f3mr77300845e9.37.1722436581874; 
 Wed, 31 Jul 2024 07:36:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282b89a86dsm23976025e9.1.2024.07.31.07.36.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 07:36:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 "Richard W.M. Jones" <rjones@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH 5/7] hw/block/fdc-isa: Assert that isa_fdc_get_drive_max_chs()
 found something
Date: Wed, 31 Jul 2024 15:36:15 +0100
Message-Id: <20240731143617.3391947-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731143617.3391947-1-peter.maydell@linaro.org>
References: <20240731143617.3391947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

Coverity complains about an overflow in isa_fdc_get_drive_max_chs()
that can happen if the loop over fd_formats never finds a match,
because we initialize *maxc to 0 and then at the end of the
function decrement it.

This can't ever actually happen because fd_formats has at least
one entry for each FloppyDriveType, so we must at least once
find a match and update *maxc, *maxh and *maxs. Assert that we
did find a match, which should keep Coverity happy and will also
detect possible bugs in the data in fd_formats.

Resolves: Coverity CID 1547663
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/block/fdc-isa.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/block/fdc-isa.c b/hw/block/fdc-isa.c
index e43dc532af8..796835f57b3 100644
--- a/hw/block/fdc-isa.c
+++ b/hw/block/fdc-isa.c
@@ -147,6 +147,8 @@ static void isa_fdc_get_drive_max_chs(FloppyDriveType type, uint8_t *maxc,
             *maxs = fdf->last_sect;
         }
     }
+    /* fd_formats must contain at least one entry per FloppyDriveType */
+    assert(*maxc);
     (*maxc)--;
 }
 
-- 
2.34.1


