Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94EEEC88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7FWD-0007Pc-U1; Thu, 17 Sep 2026 13:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7FVz-0007FX-0d
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 13:03:20 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7FVv-0001kj-Hx
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 13:03:14 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d3931so8517075e9.3
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 10:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789664587; x=1790269387; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IV0tF1sRRNpIOPotsbAY17LevOYRtBEbl2/JNz6ncs4=;
 b=LEt6ZndEbVdxR6jIsgzPir1Zx+nT6OZuQmKZBiXNtis6gJcHrZcsaog0SX0gE1ZhsS
 jTHWZsoY03arX27nNEsFnEUXIN9jVojg5TWJJpNU9Sdf2hgMhAR+JYPNAom42oxXGrdA
 I+wKoIYB/Ua53GHIYs/l1xOp5dmN426rd43gFxHSCBPfia1NwBsRIV+ewY/FGYeSMATv
 k8Rbsjttx80hhu3SmAoNmeR6rnJphI/UPmUzJ3fOJl/lSApW0evNsprHBtow8e470x/8
 xCLcC1L1+ieHnbqnAEkumGsxLHn6lXkliNSGXo/Zmv8K/QDedK7RBGWdCVqYZSD1H7gb
 SnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789664587; x=1790269387;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IV0tF1sRRNpIOPotsbAY17LevOYRtBEbl2/JNz6ncs4=;
 b=nHcukiWFlvTjOFXLD0N7ngp/v/SW0Jhty0olXoZDS0HSIVyPoZ6ng/+b1d3pAJU9i1
 hmK1p+MIgEvxFEh1MW0emkOQAl02ihS1dMby0Z7p5PuOEglG15e7Ntqm16FHZz5aYMTd
 +ZYyrg6W1mstdn6QUZOuBuEv8gnaHjbLTbg1EZaJdGaDmy2ocziqWT1oTJp0xg36XaMA
 YImAJeF2/j4NN4T2vYC22bS/PjHKbckcDZgZBzj8gQCYWo417wadYNS9MBoxRlZWhMpT
 MUO4nAGXY0dl6bc7Rqjc8jK2lBuFVLJOneVEXVvWPbqZvRSoUho5zGqKh9CTPal/e5jo
 F8+Q==
X-Gm-Message-State: AFuF++nOer/hH3IpejxS5W1pRSuixK2C335pe+su+EUe7M5znmyNYtvP
 a8VwrKa9qIg24dTV0FqZNKodOR94PbjLAs4hxvMXQzLIRs+gClrnCiR7Yg6m3Fd4Fpc=
X-Gm-Gg: AYBFou0kZtcGuUA2YN+5+fsdWtua1gpIWGGBVxpLbE4pCRuHGAaA1YrUHxhvC+AJ+js
 hmCoh+VSvFdXCIlseolMA+cruJV76nTRAAbkhj7b8IfIMDdmq8XmQmu2eJgqyhFl7gsZr1+M/L0
 AXmQoG0mCjYTVGDShPGQlglXZXzPbf6Z8Eo+xc24xG0kqcIMwcsN1BIszBDrD1QxaMyzOmxfk4q
 g5acRip1g5IpGLiH+s8UAAVd+dh2+G3wEICODiDCVnmDoPKXt3vms+ZT230GyO8+gwdzjPe3kUC
 TGIocZTjAciXiZsf+nunz/fG7hRHUg/z1O2duuYe5ZuiayhTalKS+VOC63KYJF7mL4z+0gogfZe
 689Hz/vkc08Z0gWvubkyX4c7wuyJuVtmUi3l7tDvH1Pqb1aAvuuG4nsr2L5tmkSRaTEBPcaCs8e
 UF7FzDCKRrbuyPEybKLkuhzv8orJkWAzZIPXUZXXnM1ET5/6Gsx9okVdPp//0QuuKCjKNEFic=
X-Received: by 2002:a05:600c:3ba4:b0:49d:17d4:d6ad with SMTP id
 5b1f17b1804b1-49eb7337325mr121275635e9.23.1789664587072; 
 Thu, 17 Sep 2026 10:03:07 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bef7678sm17418206f8f.2.2026.09.17.10.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 10:03:02 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8D0E35FCA7;
 Thu, 17 Sep 2026 17:56:03 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-arm@nongnu.org,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Song Gao <gaosong@loongson.cn>, Warner Losh <imp@bsdimp.com>,
 John Snow <jsnow@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>,
 Brad Smith <brad@comstyle.com>, Kyle Evans <kevans@freebsd.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v5 13/17] tests/docker: fix ccache directory variable expansion
Date: Thu, 17 Sep 2026 17:55:57 +0100
Message-ID: <20260917165602.3405537-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917165602.3405537-1-alex.bennee@linaro.org>
References: <20260917165602.3405537-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x10.google.com
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

From: Anders Roxell <anders.roxell@linaro.org>

DOCKER_QEMU_CCACHE_DIR is missing $() around DOCKER_QEMU_CACHE_DIR, so
$HOME/.cache/qemu is never created.  podman then fails to mount it:

  Error: statfs /home/user/.cache/qemu: no such file or directory

It only works if the directory already exists.  Add the missing $().

Fixes: 8a1975e4d44b ("tests/docker: expose $HOME/.cache/qemu as docker volume")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Message-ID: <20260915072403.347639-1-anders.roxell@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v5
  - dropped my fix in favour of Anders with a better commit (an he was
  first)
---
 tests/docker/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 74bf471f171..9237a0dbe7f 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -197,7 +197,7 @@ docker-help: docker
 # Where QEMU caches build artefacts
 DOCKER_QEMU_CACHE_DIR := $$HOME/.cache/qemu
 # Use a global constant ccache directory to speed up repetitive builds
-DOCKER_QEMU_CCACHE_DIR := DOCKER_QEMU_CACHE_DIR/docker-ccache
+DOCKER_QEMU_CCACHE_DIR := $(DOCKER_QEMU_CACHE_DIR)/docker-ccache
 
 # This rule if for directly running against an arbitrary docker target.
 # It is called by the expanded docker targets (e.g. make
-- 
2.47.3


