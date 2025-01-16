Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0784BC02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 16:14:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYSUs-00060D-R3; Thu, 16 Jan 2025 11:13:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSTk-0003ZY-AX
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:12:20 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSTe-0004SV-DT
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:12:19 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3863c36a731so972763f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 08:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737043932; x=1737648732; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j93GecBEOMwiOkIFmK122dF8ntsByPuKMq5HKst7wb4=;
 b=fOjePmQ2omcNwNPJd9tvjGYERgtraNoZ1boYDNzQ9+gd9Cyg/aIlF+EF7mcK6p/DLh
 HHsL4B6gNiXC1cChUwzMG0ZeWskZTWi0Qso9IDvKRX4aGhSVY0ZZO1Ssus/o2gLE8m2J
 kipKfShPrJsOJ82BB+g2N5VeWiGaSyJH5ULVPlA0o/wzsS+1moeCnMI8Bzz1FovnAJVQ
 vVFEksP1OIv3mGwTCYIbw+UrlwgmWnIRLVlIkG7zAfrKPnewA/fzyh3CHkrEIp1ni2MS
 3zg2axS4fa6jtCXXYRixT4ir33U+jICpwXrXQO1xOkp1zHEzmSiyIw+nV68DFrVGfAzB
 9cgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737043932; x=1737648732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j93GecBEOMwiOkIFmK122dF8ntsByPuKMq5HKst7wb4=;
 b=eKgqcOO0GztcLLqS9ytbXzxzzscwfrk4PT6DVC9qAvGJBZvYKncVlpzfJ8tCgVqxRx
 bGgjstVCl0/ufrL4LgbYKT6ufGaMrSdwyM0gL64x80iwpRMRcBFENPE+i/qh/qdPOr1X
 kGona9PM+ZAGlG2ygjV6mdg0QEfOiLd/IDa8ZKSdJJjKNSZPPVyNlyi3KBvpkF/2gi70
 EpyU55lDkDyp6PvAWa1l0x4HJUSA5BFHUHs2VCUGnrZwBm71FSr38Lc7zw21UD+9RZR0
 cGma1tlYpFF42J4jGSZ6TnNJLgpqigL0rXE1EZqBKKEkO33k2FZFWIA2r9GTGaOr/Gp+
 Kncg==
X-Gm-Message-State: AOJu0YyfHbRbuZrHSWZg4EeFB5mf6cQOGraWhUq37caNVluNtYIjUL/I
 rf3zTiToychtWIZPNaBMkTKf86uAA7DYREirDx6JCKudlH/1oR4HQrt8n8GEEzE=
X-Gm-Gg: ASbGncuJWnPiLyLCq1jlU7heMNuGSLiqa3XBjvkjQrkgZB6n0Tz7hJvi5amo0W9QrgP
 CTXB0gk3G05+icu61ZwRk7wsiBgDwVyWHzNu6TFmScx66uVWE/5XIRa10T6zOHkZxTy45zsDfJn
 uFh/Xn/Nuagl4r+qKU91Mxt58BTleYcIHukncynGQeDFxUGsEs3g8fMEwUZXZBRNk5kH+HSaJU8
 CHSCzHS5gl1eEs5kLdBzV0dOLFlnqFNwJs2I/eGAQvgATKR88V7esg=
X-Google-Smtp-Source: AGHT+IFTmn4zofStPlXd6PO7otF7CYyh/kZloPTmNaL2Si+R+1chWih4sA8hP62BjSjw1NN7bdbc+g==
X-Received: by 2002:a5d:64a4:0:b0:38a:8d32:2741 with SMTP id
 ffacd0b85a97d-38a8d322aaemr23798721f8f.19.1737043932285; 
 Thu, 16 Jan 2025 08:12:12 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c753c60csm62650135e9.36.2025.01.16.08.12.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 08:12:11 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 81E01608E2;
 Thu, 16 Jan 2025 16:03:09 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Stefano Garzarella <sgarzare@redhat.com>,
 qemu-arm@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, David Hildenbrand <david@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Alexandre Iooss <erdnaxe@crans.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 31/37] docs/sphinx: include kernel-doc script as a
 dependency
Date: Thu, 16 Jan 2025 16:03:00 +0000
Message-Id: <20250116160306.1709518-32-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250116160306.1709518-1-alex.bennee@linaro.org>
References: <20250116160306.1709518-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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

When we update the script we should rebuild the docs. Otherwise
breaking changes made to the kdoc script don't become apparent until
later.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/sphinx/depfile.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/docs/sphinx/depfile.py b/docs/sphinx/depfile.py
index e74be6af98..d3c774d28b 100644
--- a/docs/sphinx/depfile.py
+++ b/docs/sphinx/depfile.py
@@ -31,6 +31,9 @@ def get_infiles(env):
         for path in Path(static_path).rglob('*'):
             yield str(path)
 
+    # also include kdoc script
+    yield str(env.config.kerneldoc_bin[1])
+
 
 def write_depfile(app, exception):
     if exception:
-- 
2.39.5


