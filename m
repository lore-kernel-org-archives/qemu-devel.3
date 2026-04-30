Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6582BCD13DE
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:29:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV6P-0004lW-Fm; Thu, 30 Apr 2026 13:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV6M-0004ko-Az
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:23:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV6K-0004O9-Po
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2gL+Jmgyypi9znqL1SXXp9HI1CPL5iE/cIgPpzzIEds=;
 b=igNpZQBhJHEFw8xM9tc2WuNFDrXz5JGS6Rlv+ZyUt9+p74N4U6ViDmc2dxFeO1P4Q8lZBa
 7Uoah6S24RZ9n2azotznMhED+Mn4OTzr/oV0UoyPwTz6xdWJBAObaVv6noh2NMhcOEpph5
 tsvXS9G1C01VtYFycSqlWrPmpWwQzpA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-Edf5n2wcNtOpf9brsrWbiw-1; Thu, 30 Apr 2026 13:22:58 -0400
X-MC-Unique: Edf5n2wcNtOpf9brsrWbiw-1
X-Mimecast-MFC-AGG-ID: Edf5n2wcNtOpf9brsrWbiw_1777569778
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8aca29dcd69so31028546d6.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569777; x=1778174577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2gL+Jmgyypi9znqL1SXXp9HI1CPL5iE/cIgPpzzIEds=;
 b=RnI4Ypn5rjPre0lcHND7C2to0OWuwV8A+SLA0orneL+e1Wq1shGZLumtYMTVDD3rnR
 3p/2LCO/vhUytqndvPhWoxXNor7TUYZxdX0CIU6ThVyNJGHdJggenN8fZ+tlV9HmEGJp
 o8/ifyIA/OeutkKLkKCXL1fLadnDUO0L3AHvDkio40nbHsjLE/cnsnwTcn20qFaEauhA
 Hd2nNPna2tYbU9Iqv23RSMznuzDpadRXTP31REC2UyeCPts+KBk3UZho06qy/TznDW0l
 n1cp1pSvyn064B0Ajqz0x2wTBDZPCsi5Ee3C7RL+WRpIxtbAAcb3L+URh+1vM08QUHdc
 5rJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569777; x=1778174577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2gL+Jmgyypi9znqL1SXXp9HI1CPL5iE/cIgPpzzIEds=;
 b=EZzlhLfYP1S8J1aT7R40dDQwHB3NsNm4TeD58J2VOV18j4/P+4Rm4o8dhC3uB2ciPC
 fzsBci5j5scL/Nn+pmivKfNUm2rJmA1epHoGtirP92/nfGxqG1v5yUhF4qGJXGKUIf6r
 ECQEvFn2eO2ANrV4ljvmiaLGaqyI/5QdYNe38impyqI3Ljr8spwf398hkFkSGJIsyi1S
 3mTZwHhvByuDqxN2TtYlnr3Jtgly8usoJ/sg5Ptu0Vqa2pSCalVbAd6y12K1pzoqaNO3
 jcvH/B3CB0hBuQzuiBW8W4AyqkMgSg/+y7btRaVFmKFbM/7i5Yb0BzsaBfFUN9gg4Bb/
 Xerg==
X-Gm-Message-State: AOJu0Yww161DsyQymOZ5NaP5cWmkRU3aZXFCmvvXwrA2XLyf5QXtOoLj
 bhtzI6Hk1zk5g1wTONCcdeg8PjeTf0WCWrTXpUMuHlNlShKKfSWA8qLs7tBsmDuUSdROABQcuIZ
 gBSGhupJM3vvrv0n3vlwYwYgLLUk4pdRB11fmh9blDZEOCwmSdLQxfDA5ue7U06e/9ozKYfygOq
 PZEH7RILTcY4aSU/Gds5gTA3pXlKtm5xuT0/bwg4hx
X-Gm-Gg: AeBDietWHY8eRfjXdMzQBdXXwrDGSzmlwNScx89FiXQbCCp2xmyjuF4+kIC7KrISjLJ
 0pi7Kn20nuDaYK4CB4wfVOVocjn7CmDBOoocN4qqIXG4TbkWk3F3QnlozcHYHHHKuozb4gafNdR
 2XeQD+nGvzopsEqCphanZwjOXU+GMy9dd1652XRXdAjaztQv6878uiXv137o1wIAIz1obUNJ3FL
 TL9rmEr/EbAdU7j9P20WV+KjIT/Xw1YYuOTBEj84+tjAHByT3EN18WneIUtq6UkdpZG9ybthRAF
 oVondS23FZdV8O3n9ktT2Nnh76EY3urShekyKNdW8mxiz+VymR3eIx4d0UEcplH3grUnpMgMm/q
 Msbey4sSHfIsVLm7zavvIkKTEAoAu7/UxnOcBCgViuIw8cSMfMiML5mdCre/4nw0gBMST8CPPlv
 yPxsKJvC9m2ma6sx3Lv9NqyRyo2A5t+psDkyw=
X-Received: by 2002:a05:6214:3d12:b0:8ac:b6d7:e61c with SMTP id
 6a1803df08f44-8b3fe7cdf42mr56798886d6.32.1777569777126; 
 Thu, 30 Apr 2026 10:22:57 -0700 (PDT)
X-Received: by 2002:a05:6214:3d12:b0:8ac:b6d7:e61c with SMTP id
 6a1803df08f44-8b3fe7cdf42mr56798196d6.32.1777569776534; 
 Thu, 30 Apr 2026 10:22:56 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3ff301dd3sm23206776d6.7.2026.04.30.10.22.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:22:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 15/58] minikconf: remove unnecessary semicolons
Date: Thu, 30 Apr 2026 19:21:21 +0200
Message-ID: <20260430172204.1006673-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430172204.1006673-1-pbonzini@redhat.com>
References: <20260430172204.1006673-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/minikconf.py | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/scripts/minikconf.py b/scripts/minikconf.py
index d728fd867f3..685e559bb87 100644
--- a/scripts/minikconf.py
+++ b/scripts/minikconf.py
@@ -327,25 +327,25 @@ def do_imply(self, var, symbol, cond=None):
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


