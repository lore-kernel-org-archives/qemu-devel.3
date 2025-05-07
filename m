Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6EEFC3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:17:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCnyj-0000ip-P7; Wed, 07 May 2025 19:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCnyd-0000eR-Jk
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:14:59 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCnyb-0007A3-Vi
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:14:59 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2241053582dso7311445ad.1
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746659697; x=1747264497; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KhAM5TzWr84Jlzb5Lb6xETas9izeZHd6MMPISYifZW8=;
 b=i0zJrJ28vh+Gc9l4Xc5q17Xgc9jg6vJkUGB+HlgYlKIznO1e+7UxhZFmdqUcBGkmzC
 cURx90F4Mn8/hGGDFEjxGTFzN8D59nY7Xk3u3QrahDXRZj8aMEGd2gQnx8twRmZboxsI
 hrH7jWhy0QZkf528Rv4M9WS2mm0+ehNegYX/Qy24PbRGf3mDStNLahQgvJgwfu2o4035
 YPSaw6diV1BZdXz0tE3Mno76g99hava21FhrMhRCGfj7fAolyabJOROs/ofVvxX33GD2
 1P6Wfpts/+rlSO0ZrhgFjISUatw7ZjrxSOpXBv7BhR5mRlbl5H1ZXycxRHMHKXzgoFcC
 gzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746659697; x=1747264497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KhAM5TzWr84Jlzb5Lb6xETas9izeZHd6MMPISYifZW8=;
 b=GJWCrPd5M6Ok2Yc15uqdlleZWC9BoHSn9cQMW7xN4BG0O5ust2Ap51lAhjcGznts+x
 LTnQ0beycBZ/ULCoZVe1Z9e537fNpOs9fkhWML8tdRxluLVNW/fBVllq0OzTy6uRTotq
 Opadr5CrzWdhFrQ1RDvbV2iR69tVl6oeK3n6hpghmCQ5VSZO3ndOd5G0TpU8miT4UgBR
 aLO9UGVZPSXOJfMNlC6s8nmFaoRp5JURLT+QJ7tV6Da8d2VqYdTflqXBBkkW1/Aewjl5
 3Agm3N6QuDXrlDj3FQPhlOrdYYyL5m/xTuMg7Im+zU23L/T2+P1VQestw27RlPorV3X2
 UXhQ==
X-Gm-Message-State: AOJu0Yz7hxqQCPNfSu6f2NOHqzbed5n+EUDProGIHVvZnWohrqAcrknK
 nVzMlkuGn7DO09DjKyXztYU+dsrRwB1dP3j+qWB9jYCOOFNpKnMo0DwSlWhTfG4BGsJY1GPkRe7
 PevE+pg==
X-Gm-Gg: ASbGncsiSAZyDuDgt5woSoNpn/zK/IKhyAP1ThqqQXw56elPFGa3M0nJM+fwVYgnbC/
 UwD3BkrHFX7pa5poBPejno4h+8JT1wiF1aXAtIyukwDkZYYST8QubrhtxX55Yp0dWHu+fF6RV/G
 FsF/wibmaRywVShhupL2/7Nmp3FP5pa5E/SY71FZh3vW/H931Nb2cXPKDEpealDbbGfW/ptxzbE
 oIWVmYf3Zf+6oyGX7+FgQGkhJCEOsrs5mY3yKbESX+60n/Z8lX5MHtgV+7ZlDaKx15r382lA3Uj
 K5xdnGulBld+xCIVaeDwhtLcFcD17P1CGrguwcfX
X-Google-Smtp-Source: AGHT+IFbl3oXn+4IyyLr7TL1pI/3M1qe92Rlc4/DbiYJmIYf2f3XQwk6p4sL2kZIVUisrCqfX7mENQ==
X-Received: by 2002:a17:903:4410:b0:22e:56f4:e187 with SMTP id
 d9443c01a7336-22e5ec9d666mr74958625ad.22.1746659696800; 
 Wed, 07 May 2025 16:14:56 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e421a7dafsm40103205ad.69.2025.05.07.16.14.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:14:56 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, alex.bennee@linaro.org,
 stefanha@redhat.com, peter.maydell@linaro.org,
 Markus Armbruster <armbru@redhat.com>, richard.henderson@linaro.org,
 pbonzini@redhat.com, jsnow@redhat.com, philmd@linaro.org,
 berrange@redhat.com, thuth@redhat.com, Michael Roth <michael.roth@amd.com>
Subject: [PATCH 06/13] qapi/visit: hide fields in JSON marshalling
Date: Wed,  7 May 2025 16:14:36 -0700
Message-ID: <20250507231442.879619-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
References: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

We modify gen_visit_object_members to hide elements based on the
specified conditional.
This allows to hide those elements in input/output json, even though
they still exist in C code.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 scripts/qapi/visit.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 36e240967b6..82caf8c5f0b 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -90,6 +90,7 @@ def gen_visit_object_members(name: str,
 
     for memb in members:
         ret += memb.ifcond.gen_if()
+        ret += memb.ifcond.gen_runtime_if()
         if memb.optional:
             has = 'has_' + c_name(memb.name)
             if memb.need_has():
@@ -126,6 +127,7 @@ def gen_visit_object_members(name: str,
             ret += mcgen('''
     }
 ''')
+        ret += memb.ifcond.gen_runtime_endif()
         ret += memb.ifcond.gen_endif()
 
     if branches:
-- 
2.47.2


