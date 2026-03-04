Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FBCAEDEC12
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 06:30:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxfjb-0008T2-8Y; Wed, 04 Mar 2026 01:29:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vxfjN-0008Ff-8i; Wed, 04 Mar 2026 01:29:16 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vxfjE-000582-Je; Wed, 04 Mar 2026 01:29:12 -0500
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6246SbBQ071191
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 4 Mar 2026 15:28:44 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=FW1M35ADo1rOGTkjkUKBAtfBI7U6bavuPH5VmSHyiJw=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1772605725; v=1;
 b=mPgjr0ffes2Huq4KG+MqZOT2GSDkv+KFNnCS4uA1oSbxX5Z/85yPwsZ3N0vYnFKH
 OXjmI4iI9fOFk9UcVYxWjac3d2T2CWuMtsM+SzvXqldZHctRzcRigkTbOAPBF+5E
 iCxj8+0TLP6CqrF5/+jkyrbATh7gUPuAZjeLM2SV48NgNUrBK4qegc6vhoBrIImn
 A3y08yCIY69o+4QJmomTOMbHvWnrayt1+UmjSFbgerK+Ur+FwrJ5HYKJszpj3aaA
 mrSnOhLClevCePbWI2e9c5E/IVqmcZZxI0Hw213Ex31+GBAypE6+4cFY51udiQin
 htYrT/GGbV7wFw9G4RbbYQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 04 Mar 2026 15:28:36 +0900
Subject: [PATCH v3 4/4] meson: Add -Wformat-overflow=2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260304-nvme-v3-4-bbb1b7fd2d0b@rsg.ci.i.u-tokyo.ac.jp>
References: <20260304-nvme-v3-0-bbb1b7fd2d0b@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260304-nvme-v3-0-bbb1b7fd2d0b@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Alex Williamson <alex@shazbot.org>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-5ab4c
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

https://gcc.gnu.org/onlinedocs/gcc-15.2.0/gcc/Warning-Options.html
> Level 2 warns also about calls that might overflow the destination
> buffer given an argument of sufficient length or magnitude. At level
> 2, unknown numeric arguments are assumed to have the minimum
> representable value for signed types with a precision greater than 1,
> and the maximum representable value otherwise. Unknown string
> arguments whose length cannot be assumed to be bounded either by the
> directive’s precision, or by a finite set of string literals they may
> evaluate to, or the character array they may point to, are assumed to
> be 1 character long.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meson.build b/meson.build
index 414c8ea7e280..cf50bc492f9c 100644
--- a/meson.build
+++ b/meson.build
@@ -692,6 +692,7 @@ warn_flags = [
   '-Wempty-body',
   '-Wendif-labels',
   '-Wexpansion-to-defined',
+  '-Wformat-overflow=2',
   '-Wformat-security',
   '-Wformat-y2k',
   '-Wignored-qualifiers',

-- 
2.53.0


