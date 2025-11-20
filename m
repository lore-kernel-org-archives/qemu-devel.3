Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB6E8CF64A0
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 00:17:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLsMQ-0003Bk-Uo; Wed, 19 Nov 2025 19:17:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLsMP-0003BK-EF
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 19:17:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLsMO-0007SE-18
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 19:17:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763597835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U+ZM1ZqiMdfgA1oCQRd2zAK+9NPqIfMNQvMcX6iBu/E=;
 b=SPDnitet6Iz3fM0EwVLhP6DfsITYpd2qGNr5ZFIvSrllgYoRmJLe9BJoW+l/P226hhWhqa
 qsw90D3lnQnGTNAbg8F5d8G99Guw1uqFZOpVD1K/WuFzn+LVuYk0sTdjxxa93PlKKnT2us
 bf7XFyHTXKiQDYfT2lNHuK4hqRvYr3I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-KwwgDqFROXygL7vEul1uEQ-1; Wed, 19 Nov 2025 19:17:14 -0500
X-MC-Unique: KwwgDqFROXygL7vEul1uEQ-1
X-Mimecast-MFC-AGG-ID: KwwgDqFROXygL7vEul1uEQ_1763597833
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47496b3c1dcso2841885e9.3
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 16:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763597832; x=1764202632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U+ZM1ZqiMdfgA1oCQRd2zAK+9NPqIfMNQvMcX6iBu/E=;
 b=jPsZWa1fIRizEVYpIxncotY+VKlLnQhLf/NpWF03UrpTSqDxeEYuwgR7jYvttR7tEC
 UDVfSK7wyEEziVGa3HpUN6cTLDGeKxp+ceVswghi8Y8Zi6LSn7DsWzi3HDqDMi1N9T1J
 zfog42tbZ9dIkGZQwJ7uHNSHbKPPor6OktpbtyPyd99rTTnTFwa8QNwR3PqDoshduQqC
 uVxF0njpfcB3M8k4fVZ+cRiPHNprhMPREhm2xuEUM8vjW+0bNHcUt+y8UcgdBWDEskRZ
 IIFIlbvSuNXCqL+wqs687zRcpi+LWNDVYrkyWaU0bRw2JGU1PikJBWmB8CZ4dlTO71fZ
 75Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763597832; x=1764202632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U+ZM1ZqiMdfgA1oCQRd2zAK+9NPqIfMNQvMcX6iBu/E=;
 b=Vax0vLwelAF0NrxbS79IsCox4fag09BpY6nVw7L5LHfl8KX6f3kKyX+0aXHfcgKHzB
 F7cDtU9cFLt7cP6cweWPbVI/mcmmQZAU8j/ipUSAcKbVRIp49GgESKHPX1AbqBCjJW4U
 krbczUxBDeVXi3eXG9t1RkhuhkfJkJ38T/Pg29Gz4Emh65pBuwTm8ydAh14feFylO+ux
 UHjQM+vX1gY10UOi9rpNVkm9t5YWxG7IMPzukb2VOnNIGAOuF+4FwYI9nC2gsyr+uIKl
 ZXeewxLRnABDlmCgIrmuUj1IdBC6UrzHCgw6Vtmj3f6r8LTCpIX8q7+hM1rxsZBHkhno
 fepg==
X-Gm-Message-State: AOJu0YyYKKr9NxKIO5yUiU4cHhAgw1eIHtnv4U45gUdYbGeccNy85GXW
 WUIkw34FoGmBDKPSwrfYX5Dc2ECaV9eBeCWuUDG72R4Fvbc+kZLb9UF/r4mxtY9zL5HWtUVFWX5
 low93UJOzKK30W7ydPo3+t2w7AVKRWeKMDMbrfx5/LzaUaQy5xR9tI/T1Q/k0Bic5ne97yQTZGh
 M9WaMZG+eCn58gTautTcL+anQkxX1RzDUg9aebak0C
X-Gm-Gg: ASbGncvNzzVy8E0sFLSqPZua6zupFzdqDBBkE6NM5DEKb8YVkUtyMPORSTutrMHFGx7
 Q7V9/Nkg0YSIm0dr98yq0tlaOq48wfAIJDFe/DvZL9WLRTSUcNTPbYIqHieAynKMrAIZFFCxcSo
 ONh0F+GW8VDU2DZZ8jcQX0z/2LsAizLsC3BEWf/k7bp4AyefcNKC8KoYC9df+06x5Xq4t8UNT14
 EMQa5SlBmQEy6PtnMiKASR3kDIo/YLLwzRneLbawjFojijEQ0mDfMIEpzZk9u8HSs7A5um3qiSz
 GIa0HLb40Wku7SeLTerV4G7Dx4v9RHDuub5dR0m6pw9VQXfWqtBTxKxtHC8r4EqjiLu530W+kDx
 p3b85Z04uvFemEVSgdoBF0pVBq1MIK45S0JLkea/AXN1BczsUm5bS6CdqJ09GWnHfaYKqq9u9Vk
 M2waiE0xOLoTB5UKw=
X-Received: by 2002:a05:600c:3146:b0:477:79cf:89d4 with SMTP id
 5b1f17b1804b1-477b9e34890mr3921745e9.31.1763597832325; 
 Wed, 19 Nov 2025 16:17:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWpZtOpnMr/YZU3MnOtMC1GMl/WX/5tMEzhayD6CvgLGyPI2lySHH8XdbYBIBys1rm9N491g==
X-Received: by 2002:a05:600c:3146:b0:477:79cf:89d4 with SMTP id
 5b1f17b1804b1-477b9e34890mr3921535e9.31.1763597831834; 
 Wed, 19 Nov 2025 16:17:11 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477b8314279sm16575225e9.11.2025.11.19.16.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 16:17:10 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 09/10] mtest2make: do not repeat the same speed over and over
Date: Thu, 20 Nov 2025 01:16:48 +0100
Message-ID: <20251120001649.1085913-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251120001649.1085913-1-pbonzini@redhat.com>
References: <20251120001649.1085913-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

There are just two of them (slow and thorough; quick is simply the
default).  Avoid repeating them for as many times as there are tests.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/mtest2make.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
index 38512046d97..4b252defc3f 100644
--- a/scripts/mtest2make.py
+++ b/scripts/mtest2make.py
@@ -13,7 +13,7 @@
 class Suite(object):
     def __init__(self):
         self.deps = set()
-        self.speeds = []
+        self.speeds = set()
 
     def names(self, base):
         return [f'{base}-{speed}' for speed in self.speeds]
@@ -61,10 +61,10 @@ def process_tests(test, targets, suites):
         suites[s].deps.update(deps)
         if s.endswith('-slow'):
             s = s[:-5]
-            suites[s].speeds.append('slow')
+            suites[s].speeds.add('slow')
         if s.endswith('-thorough'):
             s = s[:-9]
-            suites[s].speeds.append('thorough')
+            suites[s].speeds.add('thorough')
 
 def emit_prolog(suites, prefix):
     all_targets = ' '.join((f'{prefix}-{k}' for k in suites.keys()))
-- 
2.51.1


