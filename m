Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB33C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 10:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Tn3-0001r2-Qx; Thu, 02 May 2024 06:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yu.zhang@ionos.com>)
 id 1s2Tn2-0001lE-Bp
 for qemu-devel@nongnu.org; Thu, 02 May 2024 06:35:48 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yu.zhang@ionos.com>)
 id 1s2Tn0-00082b-Gc
 for qemu-devel@nongnu.org; Thu, 02 May 2024 06:35:47 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-41b4ff362a8so72492985e9.0
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 03:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1714646144; x=1715250944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=k60kSKhKOu32QTj3W7nCKe69dYinBE5sEG/imqfx1iY=;
 b=hnteuhinF+oWxODGaBRe7SFKgKq9z1YZdcfhN/wSMgAIglTX0EO38MZRaj+DqM/tZ8
 R8nPThggpP+3wC7g/CKJ3V4saVOsrWSZfu8bUWnhxw/3CgAirtb+XyvRVSHkl5oI/qZF
 /SATJPVieOHhrLmnDptsPxQ9evc9Gpg+l1HAK5jIvodH6xsyxkRzzAqBixKWyR3MICed
 cqMBu8qOQmBmbb4/wQV5tmtImncYrQa9wxyZjmYtktEgjpJ+3RGfcWj+KBYtDOKsl5yX
 c7tMD0ZNF4PBfL37ciAMm0k0AHC1pBiQ0S20LfggYUNNE7Y+BwFtzEt34cU9fV0Fehu6
 UsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714646144; x=1715250944;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k60kSKhKOu32QTj3W7nCKe69dYinBE5sEG/imqfx1iY=;
 b=fJ5kL1RrYpGlS6K7MZJoS+k2ZDzzV5MrGWHdWxsQOUXn0nRoJy/iOei3DPgL/R3akO
 BEf1KxNlq1IIXEWZdzAt2LhLMfypRZ7UZg6k6i3Cn+YyyCn3EGneYa8vYZVctE283B9F
 q3ZiuFQCKftVHNfvpEze15z+BOzmJGPQAcGeyrf9K54GVLd+e47aCTJmPLv25ZGirwX6
 3Hcv/JH4T+Tm5FKESSg9dPoZgTq8Vh3ArPhMEIrfNDUVn4sGIvr0hFeWkCZ/UUFXgQcd
 rj90NL0t7o15op87sGKxfGHBavJxpKwJz2nT63dh7Gs3NbG+VuAEUgVbsdeaHo/egtY2
 GFMg==
X-Gm-Message-State: AOJu0YxUCNJ7nwpbQBx8zNkqMIMV6/2cwc6dNdP7oJ1NYnsFRK1+sjNq
 ZkeA3IKgpeEQ6YnyGJNnsCg8EIwJpw7tp9mE5jcKa3DOuca4GMglQiI7QJyOaDnleutWelOdJds
 Q
X-Google-Smtp-Source: AGHT+IGRkht5JXV/wLgcQh38HcrykHBDhr8+jlcy4Nhya6jr4BeiuaWxR+633GgSqvWO9FY6VrMgzQ==
X-Received: by 2002:a05:600c:19cd:b0:419:f911:680a with SMTP id
 u13-20020a05600c19cd00b00419f911680amr4978210wmq.1.1714646143745; 
 Thu, 02 May 2024 03:35:43 -0700 (PDT)
Received: from lb01805.fkb.profitbricks.net ([212.227.34.98])
 by smtp.gmail.com with ESMTPSA id
 fc20-20020a05600c525400b00418accde252sm1476136wmb.30.2024.05.02.03.35.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 03:35:43 -0700 (PDT)
From: Yu Zhang <yu.zhang@ionos.com>
To: qemu-devel@nongnu.org
Cc: mgalaxy@akamai.com, lizhijian@fujitsu.com, peterx@redhat.com,
 jinpu.wang@ionos.com, elmar.gerdes@ionos.com, armbru@redhat.com,
 berrange@redhat.com, Yu Zhang <yu.zhang@ionos.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] MAINTAINERS: Update the reviewers for RDMA migration
Date: Thu,  2 May 2024 12:35:38 +0200
Message-Id: <20240502103538.243789-1-yu.zhang@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=2a00:1450:4864:20::333;
 envelope-from=yu.zhang@ionos.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

As the links [1][2] below stated, QEMU development community is currently
having some difficulties in maintaining the RDMA migration subsystem due
to the lack of resources (maintainers, test cases, test environment etc.)
and considering to deprecate it.

According to our user experience in the recent two years, we observed that
RDMA is capable of providing higher migration speed and lower performance
impact to a running VM, which can significantly improve the end-user's
experience during the VM live migration. We believe that RDMA still plays
a key role for the QoS and can't yet be replaced by TCP/IP for VM migration
at the moment.

Jinpu Wang is the upstream maintainer of RNBD/RTRS. He is experienced in
RDMA programming, and Yu Zhang maintains the downstream QEMU for IONOS
cloud in production.

With the consent and supports from Michael Galaxy, who has developed this
feature for QEMU, we would like to take over the maintainer's role and
create the necessary resources to maintain it further for the community.

[1] https://mail.gnu.org/archive/html/qemu-devel/2024-04/msg00001.html
[2] https://mail.gnu.org/archive/html/qemu-devel/2024-04/msg00228.html

Signed-off-by: Yu Zhang <yu.zhang@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: Michael Galaxy <mgalaxy@akamai.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Li Zhijian <lizhijian@fujitsu.com>
Cc: Peter Xu <peterx@redhat.com>
---
v2:
- fixed an email address
- added "Tested-by: "
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f1f692202519..fa9c62aae3e1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3425,7 +3425,10 @@ F: util/userfaultfd.c
 X: migration/rdma*
 
 RDMA Migration
+R: Yu Zhang <yu.zhang@ionos.com>
+R: Jack Wang <jinpu.wang@ionos.com>
 R: Li Zhijian <lizhijian@fujitsu.com>
+R: Michael Galaxy <mgalaxy@akamai.com>
 R: Peter Xu <peterx@redhat.com>
 S: Odd Fixes
 F: migration/rdma*
-- 
2.34.1


