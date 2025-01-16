Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFDFC02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 16:10:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYSNM-00075o-MP; Thu, 16 Jan 2025 11:05:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSLG-0003dV-5I
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:03:34 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSL4-0001Kx-Qs
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:03:33 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3863c36a731so964771f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 08:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737043401; x=1737648201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+2KBORBltMfs4JjAXKxZruuaRZjbGhUmZm0A1SXI8IE=;
 b=lHEi6K202B+QlIZJrcClU4pBIP4qPYJdmDdZdP5gexYL3mlMeL5xpYsLAkRk2jchaA
 W6OjiP0KlUiy+YlM2OZLgiTPn0LeO0o5tkKXWyw+rOOrkLJYiIJoP69m+vdspVnIU/eH
 H7gXNL+iEeTVkPyfvcuqLT2VihHDZrUID5vXuL0YMD+5I+T/qXrdRRkdXS9XuZhY8cir
 AkM/VujGioc1rboKn99a64lQQBHZzYj0QA6nrAiLklPZzGyUfP7UsMT89T1Lq6Q9djkP
 dl0DHgiVY5B+9SKjDMkxWGOq4ZB4yzwr7VF7J089/WUBdk3zE1XheFAcsm3hW9msYML0
 z0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737043401; x=1737648201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+2KBORBltMfs4JjAXKxZruuaRZjbGhUmZm0A1SXI8IE=;
 b=oXmPQhRIHkfIPXmm49Xdt9fTOiR0gREivCwq83v5Xt3BtKAoGdJ95xC3GmVBUl2Nxf
 er/t6hYjPBtcYzA+F0iH5ZdFJj4E0yTcZHjRp2QH8bEADq/06KbRg7+JcNkQzVyXYQFP
 GWbKJVBtp3y5yNrLNg/uxze3pX3NQ6N/j8T3t794jes/WPfJyyvQjfLZP+p3EwG1VC2M
 3CtJbvxM2qPjTpMFRaRQqhjKMdl1pnBo2TdtrqL3eFTet/1/dbn2AljCgr4yJy/sjztc
 97xWYJ6ik24z0PfL53VHlkSs3fSGu8A9BxzsFkGCdNfHubm3pCjU72VmCms7+mEqiB11
 OgUg==
X-Gm-Message-State: AOJu0Yw9DFslocW00nM03y3V2N0Owlh+HNRZUpLg4RCv2+bd4Ch+YCaN
 VhC/67CDX303zr8Ssu73NrdjmqXBkUHDEEDtdHrgP38iDqFhe3XhogrAg83lcDo=
X-Gm-Gg: ASbGncs/D4T+276AYh8aWXz16JJh3uLUKaBflniwvqUIdaY43ja9i0qlyVgDz+PRz97
 amPGU7dgB2SvIiBgNZxRzZrX7RAQbEOH/8pffKbC3uHTps3J0IAvORnDzCXBz4mx3VDD8PHPSyL
 K4CMKnFkg3VByEpRkRQDgNlQuKW5+Tv53MaWiUHAJmJQy6L8FBH9PsKDqTUo211MnuctpAivaip
 v76mLTG9mQOVIKGufapwMn68RIlFna0BfEmmXkuXOqdMuf4hlMiENE=
X-Google-Smtp-Source: AGHT+IHPNIbV244ZWm/YR40z/Rg7aCAZgP3TuQv2sQxFXTd06VTvSNCRIRyHuNz8ikWQow+pQ1IL1w==
X-Received: by 2002:a5d:6485:0:b0:38b:eb7b:316 with SMTP id
 ffacd0b85a97d-38beb7b043fmr3484175f8f.47.1737043400466; 
 Thu, 16 Jan 2025 08:03:20 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf3275562sm205273f8f.66.2025.01.16.08.03.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 08:03:18 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3F10C608F5;
 Thu, 16 Jan 2025 16:03:10 +0000 (GMT)
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
Subject: [PATCH v3 37/37] scripts/nsis.py: Run dependency check for each DLL
 file only once
Date: Thu, 16 Jan 2025 16:03:06 +0000
Message-Id: <20250116160306.1709518-38-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250116160306.1709518-1-alex.bennee@linaro.org>
References: <20250116160306.1709518-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Stefan Weil <sw@weilnetz.de>

Each DLL should only be checked once for dependencies, but
several hundred (781 in my test) unneeded checks were done.

Now the script is significantly faster (16 s in my build).

Signed-off-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250111215244.1680931-1-sw@weilnetz.de>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/nsis.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/scripts/nsis.py b/scripts/nsis.py
index 03ed7608a2..af4e064819 100644
--- a/scripts/nsis.py
+++ b/scripts/nsis.py
@@ -37,10 +37,10 @@ def find_deps(exe_or_dll, search_path, analyzed_deps):
 
         analyzed_deps.add(dep)
         # locate the dll dependencies recursively
-        rdeps = find_deps(dll, search_path, analyzed_deps)
+        analyzed_deps, rdeps = find_deps(dll, search_path, analyzed_deps)
         deps.extend(rdeps)
 
-    return deps
+    return analyzed_deps, deps
 
 def main():
     parser = argparse.ArgumentParser(description="QEMU NSIS build helper.")
@@ -92,18 +92,18 @@ def main():
         dlldir = os.path.join(destdir + prefix, "dll")
         os.mkdir(dlldir)
 
+        analyzed_deps = set()
         for exe in glob.glob(os.path.join(destdir + prefix, "*.exe")):
             signcode(exe)
 
             # find all dll dependencies
-            deps = set(find_deps(exe, search_path, set()))
+            analyzed_deps, deps = find_deps(exe, search_path, analyzed_deps)
+            deps = set(deps)
             deps.remove(exe)
 
             # copy all dlls to the DLLDIR
             for dep in deps:
                 dllfile = os.path.join(dlldir, os.path.basename(dep))
-                if (os.path.exists(dllfile)):
-                    continue
                 print("Copying '%s' to '%s'" % (dep, dllfile))
                 shutil.copy(dep, dllfile)
 
-- 
2.39.5


