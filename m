Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DADB1FF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:07:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wINLa-000875-VS; Thu, 30 Apr 2026 05:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wINLO-00080Q-Nt
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:06:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wINLM-00039J-Uq
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777539960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6z81I2Y73DiITnhPZaOx+GVYfzkf1mAhZbm2YUOmmF0=;
 b=CTtE9iMm1Q0SoIx+vbR9jMrwJnwc8H8zIqBfWBYbJMFK0VjJqBqRcQX5h/ge1U9thozIrZ
 LGMMegA1efcixRusg8Vql0GPN7KEgmYiv9pajjV4R3cAMoCOYL3sBjjsBk6ncLx6cJSigB
 zZ8xwQ/T+bTKbWQHBVhFzpJLoN/RzTs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-7f0re4-bO6-qhK2_zep41g-1; Thu, 30 Apr 2026 05:05:58 -0400
X-MC-Unique: 7f0re4-bO6-qhK2_zep41g-1
X-Mimecast-MFC-AGG-ID: 7f0re4-bO6-qhK2_zep41g_1777539957
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-488dcaf2f2fso5319765e9.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 02:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777539957; x=1778144757; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6z81I2Y73DiITnhPZaOx+GVYfzkf1mAhZbm2YUOmmF0=;
 b=bJJvaGxeO7VmL0mGGPkmVWvOrB3BD3GzThMFs/+UXWJq1QjuCQbVy24I75pI/KLnwI
 DGtcJgYdfRH1O6gMoSONxg3gDxR9Vg6wQVPEnZRt4z6WLlUpPRzpT92ZsNOUuemOw4V5
 uG0Uy2G3GEvcSy+VgCkuYuuW0KHJC+IIOBmqh1BwqyKS6W+TVTbuapNE83qo7n9K1Q+D
 MEIZ6SJoMh/0VnquPryRr695LCQi1rmKEVy3D4LxQGmp7CNeagDgwHRO2bAn0O/m2/D1
 /1ZBPF9SLfrv//DLryRjBttnF3fWdPzm32p4bLWqhAuJsCKg1momnl7/CTziVaIKg15y
 AP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777539957; x=1778144757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6z81I2Y73DiITnhPZaOx+GVYfzkf1mAhZbm2YUOmmF0=;
 b=aM9JIBWBxtpvvyvtiQoCn5zu7qZM+gWAALXX0dKlD1LWBcJa5/AcpMKw5IIbJboLIt
 +dSE/ZRGIxO31jqdlFzrIRjXlGQdDY6BHazhhI/X1kxPbQp7bHYkOAVB1lI5Fnu+ceYP
 Lu91UCWUo2AqesDzlUNCZwR7Xiogg/8l2tWwKB4YQp4KLyU6Ey4eQ72IaR3ipHy9gfWE
 8qtDGLXz6o1JGGwNUeAH0gpdVanP+v7IRz7HmdTvuwFd+kdpdCcyrKisTORho7HRD+lF
 +vo2dkv/eP9UCejFqD1cQ/dka6PF8jWZgzJ3RUfp4oyNwcHVlbQ/K776SOEYH2jlgL5L
 KY9w==
X-Gm-Message-State: AOJu0YxU6cin8EQONb2lz7Ogt1mRfGi4eOVx72zLOsaSkf6v18XrUSYn
 XYNHm2WsPnTKFVuVSV1SDyIkPXAxvqAU2Wa7DjP9VljuutFK2m6p/LkBIAqeR9ThpG9OsaLoxsQ
 YQxppqtW3pZE0uEm0wSSxVBJSg/Mmu8OCnIDNC6cUmwyVT4EmeO7/Qlsuy91ivepUVlvvl7mlhg
 Jd2mDrcjgupqEUdKXuKDdTY9S0vaQdowY1VBriHsjw
X-Gm-Gg: AeBDiesm8OAyfxmz5gOenCLHLuOQv82sjhViTiY1M4kILE2hbLvcpPq9ASix04eoj4O
 Qg0ss55Ovksw8ZhIr9x30MNanbc6nR1465w07If2G4qgQmZz+zeq/EB2fn+ZP4ogPLZOUaYZ8Hm
 aA0QyeiWAU53EsrWT2RABi4DCaVVI57FwXoMK8B3sGS/0lNdfI+xuaiNlysxAuC5YreKyB8aPiu
 LeGcm431zgMs3OmDYeyFK86+F/r1ZZBplmOCMH72nUfFyPQajh/uRMzo2QJEHzwC36cn5Fryk+a
 H+T+yQZ+qIXU/NBMkvDGaKK2MgHguObUoILuKAWgxbX0tjPn6uOhHuHl931PebXdFxsdM4C7OZ5
 2VuL8cb9GnE49tyrJxIh0n0l7dU2TLyikZ5nqdJDs1d1SfxJXLvvxP9NhpZ4DA8sgbnSgkLtUEm
 f+Ie99OfQTL6t0tKljXyCWtOI/7/ZmaM6JnJg=
X-Received: by 2002:a05:600c:8599:b0:488:d6eb:e63c with SMTP id
 5b1f17b1804b1-48a84444078mr24120325e9.15.1777539956879; 
 Thu, 30 Apr 2026 02:05:56 -0700 (PDT)
X-Received: by 2002:a05:600c:8599:b0:488:d6eb:e63c with SMTP id
 5b1f17b1804b1-48a84444078mr24119795e9.15.1777539956324; 
 Thu, 30 Apr 2026 02:05:56 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7b912ee3sm65330185e9.2.2026.04.30.02.05.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 02:05:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/13] minikconf: remove unnecessary semicolons
Date: Thu, 30 Apr 2026 11:05:32 +0200
Message-ID: <20260430090534.841894-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430090534.841894-1-pbonzini@redhat.com>
References: <20260430090534.841894-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/minikconf.py | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/scripts/minikconf.py b/scripts/minikconf.py
index e14b80e3ae7..5fb42c8f760 100644
--- a/scripts/minikconf.py
+++ b/scripts/minikconf.py
@@ -325,25 +325,25 @@ def do_imply(self, var, symbol, cond=None):
 # tokens table
 TOKENS = {}
 TOK_NONE = -1
-TOK_LPAREN = 0;   TOKENS[TOK_LPAREN] = '"("';
-TOK_RPAREN = 1;   TOKENS[TOK_RPAREN] = '")"';
-TOK_EQUAL = 2;    TOKENS[TOK_EQUAL] = '"="';
-TOK_AND = 3;      TOKENS[TOK_AND] = '"&&"';
-TOK_OR = 4;       TOKENS[TOK_OR] = '"||"';
-TOK_NOT = 5;      TOKENS[TOK_NOT] = '"!"';
-TOK_DEPENDS = 6;  TOKENS[TOK_DEPENDS] = '"depends"';
-TOK_ON = 7;       TOKENS[TOK_ON] = '"on"';
-TOK_SELECT = 8;   TOKENS[TOK_SELECT] = '"select"';
-TOK_IMPLY = 9;    TOKENS[TOK_IMPLY] = '"imply"';
-TOK_CONFIG = 10;  TOKENS[TOK_CONFIG] = '"config"';
-TOK_DEFAULT = 11; TOKENS[TOK_DEFAULT] = '"default"';
-TOK_Y = 12;       TOKENS[TOK_Y] = '"y"';
-TOK_N = 13;       TOKENS[TOK_N] = '"n"';
-TOK_SOURCE = 14;  TOKENS[TOK_SOURCE] = '"source"';
-TOK_BOOL = 15;    TOKENS[TOK_BOOL] = '"bool"';
-TOK_IF = 16;      TOKENS[TOK_IF] = '"if"';
-TOK_ID = 17;      TOKENS[TOK_ID] = 'identifier';
-TOK_EOF = 18;     TOKENS[TOK_EOF] = 'end of file';
+TOK_LPAREN = 0;   TOKENS[TOK_LPAREN] = '"("'
+TOK_RPAREN = 1;   TOKENS[TOK_RPAREN] = '")"'
+TOK_EQUAL = 2;    TOKENS[TOK_EQUAL] = '"="'
+TOK_AND = 3;      TOKENS[TOK_AND] = '"&&"'
+TOK_OR = 4;       TOKENS[TOK_OR] = '"||"'
+TOK_NOT = 5;      TOKENS[TOK_NOT] = '"!"'
+TOK_DEPENDS = 6;  TOKENS[TOK_DEPENDS] = '"depends"'
+TOK_ON = 7;       TOKENS[TOK_ON] = '"on"'
+TOK_SELECT = 8;   TOKENS[TOK_SELECT] = '"select"'
+TOK_IMPLY = 9;    TOKENS[TOK_IMPLY] = '"imply"'
+TOK_CONFIG = 10;  TOKENS[TOK_CONFIG] = '"config"'
+TOK_DEFAULT = 11; TOKENS[TOK_DEFAULT] = '"default"'
+TOK_Y = 12;       TOKENS[TOK_Y] = '"y"'
+TOK_N = 13;       TOKENS[TOK_N] = '"n"'
+TOK_SOURCE = 14;  TOKENS[TOK_SOURCE] = '"source"'
+TOK_BOOL = 15;    TOKENS[TOK_BOOL] = '"bool"'
+TOK_IF = 16;      TOKENS[TOK_IF] = '"if"'
+TOK_ID = 17;      TOKENS[TOK_ID] = 'identifier'
+TOK_EOF = 18;     TOKENS[TOK_EOF] = 'end of file'
 
 class KconfigParserError(Exception):
     def __init__(self, parser, msg, tok=None):
-- 
2.54.0


