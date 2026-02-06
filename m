Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E55D0EE6B44
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 17:48:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voPw6-0000Lu-B6; Fri, 06 Feb 2026 12:48:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1voPw3-0000LJ-8E
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 12:48:03 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1voPw1-0005Hw-SD
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 12:48:02 -0500
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7d19bfe1190so1897349a34.1
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 09:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard.net; s=google; t=1770400080; x=1771004880; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=brwL8bfA6SGZ4GoGxaBVeZCsxeBr0f6Ix8dXRgFbDMo=;
 b=IbJ0//cfmcdkvM6g6Qke2NGdoI4ZmJYwWyTbhJ7sQ9Cq/L2s1y6adwc3cjcsa9iQbn
 lzEQyN5acO8aRbA6M8s77KwLPlCAJcyMPZOXRseqLmBT7UrtcNRRoqapialXqSRWqOib
 x29/PirZpZbBkwIPlschV5dJTZOOHkHMMXBHwqZx2vHzQ6QPjfsrSdNat3YoEXixgLLa
 1vWmuv5HIgTQJtPri4PQ2Tc1dNzTUD3teJ0RdWmgcyiF2m8kG/NK+S36WY6NcVpL38lV
 AqUZq8XCk1WrNR1gHdcY+7gSIoeUoF7GdsHWnD3NKaIuI61VvpHJkqWvtfFshmtCPS2K
 eyUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770400080; x=1771004880;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=brwL8bfA6SGZ4GoGxaBVeZCsxeBr0f6Ix8dXRgFbDMo=;
 b=OYEx3NWt3JKKNU6xIiA7/uC3+mpW0MuYxewNXml3Xfr9rG1egQYTLtUgB3j5DLtQlM
 3ejMhD6wYVTysQCexq/tNpUv3cwpviIEU/l7lEZ4hyqqkxtGfhuvuDtBRpu/GKl/f6Gj
 4duMyfiEIPIlzW+aJkMDUz6/ClKrzwbrrsHRMNXxfVr0ATH7Y38DtRY8l6ywd+n+01/2
 CVg1nJceHXbbYlXNBRMakjgH2OgUWSq4u74dJA+bQ1P0kurB1dWWV5+gOiUnfAimVuFt
 sEDk7u0Vf4L9+VKosMGyP9DwNlUKQKwjzw3QCXie/ArtPNOJJsWKX4Dlk+DNeveB6eJ0
 +3Bw==
X-Gm-Message-State: AOJu0Yy3ke5JtWUHRNLQ8VNa2UURJ+TQ5tIowzbR5/YwGTAdaCEJ746d
 BfjkJixUzVWWrAijRM2yPpQdSRXeGdwrlw8M9An5gxmnmNgz/Gtd5l3gHIsD9pHG7G24SV+v8pR
 oUmoOois=
X-Gm-Gg: AZuq6aJIINXJJ8hSeMI23TEAwCPulnnvn0Ur8JWbinaoeweamodQp4K0kx1gVczQdIn
 P94ItpV++Ao1h4zsIa1+NJOc7hBWGVY3lgJqUNSgHsWHMXeIU71sY8vj+H9juC8eHgDe/EgVUfq
 skP4s4/qFWRLdpz3y/CjFbcsbmKv4eQQo25vtsdg0TwtoB3R1skklB/XRt40g+4NlYvWXZzNHUG
 l37mJryE2K1ev5sdCR4nRKPpE3CHj3uAzDkQDHA3LzA03QYnkHGtXeP85Z/0kg6F2DsgUElokTY
 pEG10xaja3v2aM2bKeqiKiXUzN9jX324+c18KOpp7YhqU9CjdhySmngqrOCnVALwEAEhty2jcCC
 uSo2fpSLyLbz6/KxVlG22d6O08kWGUVeNnU+zY0DgFjdxseIf2KsoagtrUyTFf5UV0MdCAGCm28
 gxImC+oxbXCck3JjDgQMKGoGlnkMVLlXFUTdX2n0qQtq/DwNWq9JFjbRnCBExUGmzlyw==
X-Received: by 2002:a05:6830:600b:b0:7cf:db30:bb62 with SMTP id
 46e09a7af769-7d46447729fmr2152256a34.17.1770400079817; 
 Fri, 06 Feb 2026 09:47:59 -0800 (PST)
Received: from localhost ([2001:470:b8f6:1b:aed7:ea82:7abb:dd28])
 by smtp.gmail.com with UTF8SMTPSA id
 46e09a7af769-7d464785b29sm1998153a34.14.2026.02.06.09.47.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Feb 2026 09:47:59 -0800 (PST)
From: Corey Minyard <corey@minyard.net>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Yunpeng Yang <yunpeng.yang@nutanix.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Jonathan Davies <jond@nutanix.com>
Subject: [PULL 0/2] Add a fake IPMI LAN channel
Date: Fri,  6 Feb 2026 11:45:27 -0600
Message-ID: <20260206174755.3190469-1-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=corey@minyard.net; helo=mail-ot1-x32b.google.com
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

LAN functionality that is not implemented in the device, but being able
to set the parameters can be handy for testing.


