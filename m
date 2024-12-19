Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E14E7718D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:33:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJJo-0004W3-OZ; Thu, 19 Dec 2024 11:24:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOIcL-0004WR-T1
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:39:13 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOIcJ-0004Pd-Eq
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:39:13 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-435f8f29f8aso7160385e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 07:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734622741; x=1735227541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Yx3FKFzrL9hqrpdKmx3rGNSt2oazi/Rwi7wXg9/BJ2w=;
 b=h+zqYizOyaHl0y/2jvF7cDucVqB51xz/xflVF23oJv1pFZ2si0Du55xRg+0B0hqQxn
 rPpFu1NpOMlMkXwOKruCCwexiZMwJvdx3HR82fhoJPcCxPbkMwPHEUcAN4H3NvrPcEmQ
 gZx0RGUxHrRmjKz7L8Ec0pt4kgUknZ90d/V3H6KvchHYan5RWrApJXpG0bwxqt7IqI/k
 qSZcMieoYkrS+3VoRBSevj5jeAkB6A2zG+unOtEXSZicnx84rSU1513mqigflmuwLpFi
 NrwEG2innAyThvFZ/UigGJH6iEwPm3ZKEM6pt7s+LLaU2uYSkr5SWfTHWb4g/0bYjFJc
 h8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734622741; x=1735227541;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yx3FKFzrL9hqrpdKmx3rGNSt2oazi/Rwi7wXg9/BJ2w=;
 b=dtt+oQQk9iCue9ANgBo4LnX5bqQN095d8XrubDIbujjIq7ogXztYG1A9ZOeSafgJEz
 6THuAzTOXz9qYvQKztoH6nVPj8b4oWaR3jvbE0n0c06y4/pibAGGIQno2FMOzqINlu9L
 pAsiTLA3rebqE8WE8Y2MPdyx5lF4NlbfjLhOOWFHPvc+9Ejy+cj8jieoj1+5iKo5Rayz
 B2GHXyI9IeBgYFLy4u8cqPnaExQJ9CQQCFw/d0fayrpIfmMiImmIgEGXNqPIM++oR9lA
 ZgfT57xaBAIGf6mgP046K0Sa0bSrfoEfbMzwzZV9+oi4TrN0ilFjJGVO2mSXq1ZNURxM
 GgvQ==
X-Gm-Message-State: AOJu0YylfgUGqjaykS9JAOKHRNZAw26+ucfCXKCf33k5GCi7WpItbRWC
 KsdwO6MImFZZP4TqWhvJuS/8fTvKkwv26YSFT+WqyGp1E/ZcpN21Vfi5TYra8aXXkN8pEQn91S7
 K
X-Gm-Gg: ASbGnctZF2+0PjZOQBtSZXLTjNZrtyl9kD7VMlKUo9sPPXsCRLdkbwCorqYZAXaxqC7
 wyjxqWBKpw+MDy0HUeC5C4lrK+lH15GHnBFazSIBzImoOwBx7eNhUpxlKDTQoPGmfExCYhvJN6m
 mlG9aLCmvbf62iyKqJCnXVU9UeVC5wJC5r/NPdeyt1pJEL8MYIRx2Ui6pE26RYfEMxO/hGwr17I
 PEU6MspXha/W4mHIcx15vQfUNo/8Hr5Z0BXTFFXMpNuc9qWpCkYzsFt80572hor8MIKF8JUGZKM
 8Qli
X-Google-Smtp-Source: AGHT+IF4yOVsethpcYTQks5GA7W2NFl7iW21Pb2OJm0n0i2wFlblJMGIfsdoo6RRUegqYj7VhnewrQ==
X-Received: by 2002:a05:600c:4509:b0:434:f623:9ff3 with SMTP id
 5b1f17b1804b1-4365536ef4cmr80982205e9.15.1734622740956; 
 Thu, 19 Dec 2024 07:39:00 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656af6c66sm56826725e9.5.2024.12.19.07.38.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Dec 2024 07:38:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 00/10] hw/misc/vmcoreinfo: Convert from QDev to plain
 Object
Date: Thu, 19 Dec 2024 16:38:47 +0100
Message-ID: <20241219153857.57450-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

No reason for vmcoreinfo to be based on QDev, since it
doesn't use any QDev API. Demote to plain Object.

Since we can only register one type, introduce a new
one for object: 'vmcore-info' (dash separator), keeping
'vmcoreinfo' device during the deprecation period.

Philippe Mathieu-Daudé (10):
  hw/misc/vmcoreinfo: Declare QOM type using DEFINE_TYPES macro
  hw/misc/vmcoreinfo: Rename opaque pointer as 'opaque'
  hw/misc/vmcoreinfo: Un-inline vmcoreinfo_find()
  hw/misc/vmcoreinfo: Rename VMCOREINFO_DEVICE -> TYPE_VMCOREINFO_DEVICE
  hw/misc/vmcoreinfo: Convert to three-phase reset interface
  hw/misc/vmcoreinfo: Move vmstate_vmcoreinfo[] around
  hw/misc/vmcoreinfo: Factor vmcoreinfo_device_realize() out
  hw/misc/vmcoreinfo: Implement 'vmcore-info' object
  hw/misc/vmcoreinfo: Deprecate '-device vmcoreinfo'
  hw/misc/vmcoreinfo: Remove legacy '-device vmcoreinfo'

 docs/about/removed-features.rst |   5 +
 include/hw/misc/vmcoreinfo.h    |  26 ++---
 hw/misc/vmcoreinfo.c            | 167 +++++++++++++++++++-------------
 3 files changed, 116 insertions(+), 82 deletions(-)

-- 
2.47.1


