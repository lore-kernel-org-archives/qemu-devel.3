Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 653F2CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 12:15:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBuAw-0001vl-Op; Thu, 23 Oct 2025 08:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vBu8v-0008RP-QJ
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:10:12 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vBu8p-0005Ga-3d
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:10:08 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b4539dddd99so145659966b.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 05:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761221401; x=1761826201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dPRpRXWNkgzTelJ9LaP0XDvrgpGKDnKCNCyXswtjrG8=;
 b=tP+MFI44W4gYJq2TSQFaOFWBNERAVZgHXXeM4gOksB5M9cWLcgxDQ4tuGnfHNy7sLx
 ClXBU5XpguMfr6A0SAzAorP6Tl9HBIkDiWwLOV+acm2Ey6HT3IYdLuwJ2EFc8cOW98XT
 qjrKrdOJAI27oMhFYgjTjHvYWIOp/Io9rDKCsIi2TRces6Ilhjr3Q5q61BH9GbmcINPN
 9ea6r+OL1/5M2uQxGD+ddYrQ+zXh8kZg38fI9j1flqy+ZveFh9swfj38rgn5NnbwOXH9
 0kOLPj98yP041S1HX73ClMRUhTgX2CeKKrwtdk5zU/ALbTV3iBd3OAV3eS7uqVXplDil
 5c4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761221401; x=1761826201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dPRpRXWNkgzTelJ9LaP0XDvrgpGKDnKCNCyXswtjrG8=;
 b=pbzCTtRuKHZAc/d3U8RzgF2V0wplpv8T5Ac8S7oSpj2rc2v9W+e7iosnDJuQmwLF7h
 KY29rpmo9rQHGjI8ANi8Glrjj/4SxDZHpkwmeYECxB5qx4Ydmv5vG1r9IIUqMM1g1yFS
 1/FYgf6fpWuQBrBcv+fNd8Df06OKLghozFgi9YL5PP+fwlxWf2aiiENWss0cxuRo9+7T
 V7FO+aJGgmohUPItb4eYXdPHTuFdFG0z5GydS2QlzT5K7gXyMFxinEOcyxKvrnt8xeed
 qhB/YbjCS9xLppoW8R2gHt1yilFtxgiFpe88RJLr8baGpBJLe+r54L10aE6nxrOVL0KM
 JmYw==
X-Gm-Message-State: AOJu0YwahZ2rt+kT7cE5J7WkOePHyMmtcuiuTyB6cLQypzweVX8uKrxC
 lNhJR+I/y9OyUmeTkS5WsACu/pOfB0BIXXtEUkQlEkpmr611PRNQZSbtj/CJWWKnSHQ=
X-Gm-Gg: ASbGncvX5ST4N/vU3eV72CNxBZ9s8poZtrjt7WetHPMT+6cyF9nMHFIdYHlWDX8YEwp
 XS2RQERZsiKAfSDWCU6pCarwCnjFueQ7MJSNmUmRDVnSKnSbhDmWDTzrlNNAuW7rxr3i96nE2fG
 99tvnmIsdPXWThdm8yMknB4NR2qdk0y/jz1QEmsYpW4BV5GkS44+gkyq7n0jDBuQnUgsdyh4UYB
 HgbIVW3ebJwl3RlQrniP7QzJy84f0ct0T3LtmjRJSGL/gZ4Q+/kJV1jEnJA4Cf4AqS8MT4sjmLB
 cNAeMfPFdZVa8YMANOs/TwPcoUPExoUBkZtVIIDjhJEtwj6LgunjTS3si9Teu46U/7xbI+stidB
 6UzIYqAN90uuwXt3dIHvCNdqlRCse9dmQy6f+8pkN4YT34PfNuQPZgSoYCwGsCk4jx+YD3TYnPQ
 QhPZsOltDlmRZ2egNZhIE04Q==
X-Google-Smtp-Source: AGHT+IE8f0LTnD+EXw8E4mqYXJEjGDQZPhvgg8E0/D5LpzHUgxn7MqWSEXvMdQ9WoemiAIznYZkDoA==
X-Received: by 2002:a17:907:9415:b0:b6d:2d0b:1ec2 with SMTP id
 a640c23a62f3a-b6d51c3132amr276095366b.54.1761221401021; 
 Thu, 23 Oct 2025 05:10:01 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d511f7b1dsm201744866b.19.2025.10.23.05.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 05:09:58 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5B47D60F63;
 Thu, 23 Oct 2025 13:09:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Gustavo Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 6/7] scripts/ci: modify gitlab runner deb setup
Date: Thu, 23 Oct 2025 13:09:52 +0100
Message-ID: <20251023120953.2905297-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251023120953.2905297-1-alex.bennee@linaro.org>
References: <20251023120953.2905297-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
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

Both Debian and Ubuntu are setup the same way.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/ci/setup/gitlab-runner.yml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/ci/setup/gitlab-runner.yml b/scripts/ci/setup/gitlab-runner.yml
index 7025935487a..76aeaf4ee95 100644
--- a/scripts/ci/setup/gitlab-runner.yml
+++ b/scripts/ci/setup/gitlab-runner.yml
@@ -56,12 +56,12 @@
         url: "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh"
         mode: 0755
       when:
-        - ansible_facts['distribution'] == 'Ubuntu'
+        - ansible_facts['distribution'] in ['Ubuntu', 'Debian']
 
     - name: Run gitlab-runner repo setup script (DEB)
       shell: "/root/script.deb.sh"
       when:
-        - ansible_facts['distribution'] == 'Ubuntu'
+        - ansible_facts['distribution'] in ['Ubuntu', 'Debian']
 
     - name: Install gitlab-runner (DEB)
       ansible.builtin.apt:
@@ -69,7 +69,7 @@
           update_cache: yes
           state: present
       when:
-        - ansible_facts['distribution'] == 'Ubuntu'
+        - ansible_facts['distribution'] in ['Ubuntu', 'Debian']
 
     # RPM setup
     - name: Get gitlab-runner repo setup script (RPM)
-- 
2.47.3


