Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE91ECD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 06:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPafq-00022p-06; Wed, 20 May 2026 02:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <j.neuschaefer@9elements.com>)
 id 1wPafb-000228-9m
 for qemu-devel@nongnu.org; Wed, 20 May 2026 02:44:43 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <j.neuschaefer@9elements.com>)
 id 1wPafX-0000Dp-TF
 for qemu-devel@nongnu.org; Wed, 20 May 2026 02:44:43 -0400
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-49021532ebdso13398205e9.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 23:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1779259476; x=1779864276; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=djIAhYJLRos7jbG4PFFpdw7Hxhmjn3IFqq7O4YAr7DQ=;
 b=Itxnwh+wi+ByN8rb7alWZ4ejXcsbEExWmSEzZ/Qc8XNU1TRjhLOZAbxbSZfbmJbrHH
 qqTo7qvFVvrUB/03FXsCs14+rZfFOW6azbk4lUe9KJ+hYzWSFDZFGoN1/Chwv/thARZY
 jYPe8PD8kNucHJKY0lhqq0jszK3k0EMa/WKm9OAkjaHsVNdzhnxT6detADB7a76mvR2y
 FSqGA4usjFQXRkgWdsSGIlxvl8MNcP3+Jnaq9mmYvlFi1DsWgMAc80XpDlbKLYv3vZgb
 zYEyI+Zv4mqZd607W1PRlLXJD5ephuAbOmQekR7oVR0R5ooVoAt4fq3cxaUu1g8sO5zJ
 ryyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779259476; x=1779864276;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=djIAhYJLRos7jbG4PFFpdw7Hxhmjn3IFqq7O4YAr7DQ=;
 b=k2skEbDGPCLTW+FBvy0vmkKXmyo0HfvDZn3CFUQ1N3KMztdRiGMX0FQY3oIuoaAMUW
 JsUK1REscqv9OvfTE08JjXeodmSTwnmicV8dBlmhLl0GpsAVXlBRwMU9VgVUkUolX3Ij
 b7vZ8xyIXtvR28qhdAlo+1W258DyUGV/ROLEzDxB8e2DOufP8/WFKjUgXHiDOZQ9CZw9
 W1cj01LXmSJjSuP2afR2Xy9YhCHNp0LzcmVq7GKmBNX/hvoU9ODT+NmNzc6q7/3F7jMj
 1w0ppWvhOleJPSOgvtAS7tkMU6kX7Z/USyCmcsdnCKJEzFUzrSUu5BGm7WftoB0u06CW
 6zWQ==
X-Gm-Message-State: AOJu0YwpUDgiF9/aU1BxRcdKlHtlN+n/yUelZWkwUiZeU2Zm+Wxjf5fU
 uLkS9tAmG70ANX3iWcQZw9+eAZl1HswbeXlwPK6Zm8H7azs+h6F2jIlAQSKQyvgfB6bR99w6KMT
 8w9rjoQ2b1Q==
X-Gm-Gg: Acq92OGRv1MfQKaEyQ6u+bNslAAqhXsIMMPDa/uZw1DzLwNzelDjEqIXTlYreG8Fajh
 kyEo0haIiZoa5+9Emrf5E2i+NaR/EPRxDCUe11mSg0csrFMDZ0OrnjNFl+Ssy/0Zj1G4cZpzpk+
 dJZrf3gzn00KKn4ZxuQZ1UVUd3P+pwCxU3m4alcLGUQrcL6IDVXb5MR6s774PeoIdf0p874Yr4z
 YSFcICb5aYXHuXGMks2RlxNr6JUwzoh4ge8vFGzCHmGHYNGof0EVM1bCZkyXysRoxvjhA1JAm5z
 l+xxMjJtQP2gnb3nu0HEN5vEChzKUfaGoDYxZyVJuHDSVmayvOGLd1x+6ztNaxxMw4bK+CC1XD4
 S4JlBztJ4DJjzqDgC6pEZWg0a76H7wuHpwt6EhjagE7Jkhnq7QGdByyKTwpvrYreODc5Tn92VcS
 RGVTcKo3ow8wjUl30OkbSM7DqJ91uR5WZzOFOdcJQKI5fhr9Gg3Y6fjuJBpOh5wnMHjhH7P11GB
 xCYoCrqJL0M8lEuEAbDZ/vgk9XgMZBfnQFH
X-Received: by 2002:a05:600c:858d:b0:48f:e230:80a3 with SMTP id
 5b1f17b1804b1-48fe6514c31mr274001725e9.33.1779259475887; 
 Tue, 19 May 2026 23:44:35 -0700 (PDT)
Received: from [127.0.1.1]
 (2a0a-a54a-ed40-0-9db4-bb9-3f9b-5d0a.ipv6dyn.netcologne.de.
 [2a0a:a54a:ed40:0:9db4:bb9:3f9b:5d0a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4dac000sm383575385e9.0.2026.05.19.23.44.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 23:44:35 -0700 (PDT)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@9elements.com>
Date: Wed, 20 May 2026 08:44:12 +0200
Subject: [PATCH] docs/devel: Fix typo (s/exist paths/exit paths/)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260520-exist-v1-1-535f929a87ae@9elements.com>
X-B4-Tracking: v=1; b=H4sIADtYDWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUyMD3dSKzOIS3SQj41RDE+NUy6S0VCWg2oKi1LTMCrA50bG1tQBl8/x
 +VwAAAA==
X-Change-ID: 20260520-exist-b23e143e9bfe
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@9elements.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779259474; l=1032;
 i=j.neuschaefer@9elements.com; s=20260513; h=from:subject:message-id;
 bh=3PYFmH5GbzAjjZHXID7SL3l/x1nFkNT0650hrIOQYfk=;
 b=LGObd4UPGbtO1bWQ/kNDdGd4oSzs9qeKTMBPXe3+Rd4gsJRTOKnjB0SrdWQDfKNWyjQkfQhGU
 uOUc/XqVjgOCJ+mSkK5ZCjts/Frfp2GGWsJoRNtbq/f/C5/E32UPfZ6
X-Developer-Key: i=j.neuschaefer@9elements.com; a=ed25519;
 pk=mytxDu9ALv0FsWdexvpDMisghxetVpsZ8NdmY/FGsgY=
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=j.neuschaefer@9elements.com; helo=mail-wm1-x344.google.com
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

In the discussion of control flow through a function, "exit paths" were meant.

Signed-off-by: J. Neuschäfer <j.neuschaefer@9elements.com>
---
 docs/devel/style.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/devel/style.rst b/docs/devel/style.rst
index b8edcf9316f059fe15415543098118b28fcaf99c..f4da16a0e83ca6fed205e2516fff4ac2cc941d04 100644
--- a/docs/devel/style.rst
+++ b/docs/devel/style.rst
@@ -469,7 +469,7 @@ for a time/space trade-off like ``tlb_mmu_resize_locked`` in the
 SoftMMU TLB code.
 
 If the lifetime of the allocation is within the function and there are
-multiple exist paths you can also improve the readability of the code
+multiple exit paths you can also improve the readability of the code
 by using ``g_autofree`` and related annotations. See :ref:`autofree-ref`
 for more details.
 

---
base-commit: 6d17fd91f6cf88df5cb2205e578640d72605cc43
change-id: 20260520-exist-b23e143e9bfe

Best regards,
-- 
J. Neuschäfer <j.neuschaefer@9elements.com>


