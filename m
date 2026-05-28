Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D15CD5BD1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 05:57:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSTix-0006Jy-0T; Thu, 28 May 2026 01:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <physicalmtea@gmail.com>)
 id 1wSTiu-0006JD-ND
 for qemu-devel@nongnu.org; Thu, 28 May 2026 01:56:04 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <physicalmtea@gmail.com>)
 id 1wSTio-0004dt-S6
 for qemu-devel@nongnu.org; Thu, 28 May 2026 01:56:03 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-835c98b659eso9964784b3a.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 22:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779947755; x=1780552555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6+/x1y/Lh0bso6UxK1vW2WZa03KFzqlFGYCtQYm4XYY=;
 b=SLLqOb+sTsi8rAbaHkZu9Z194mzP6JMXfr1AyFwIALBHnZAZ0LXBbEclQfY2aCAtNu
 XMTo+IOf5bygV6xiC7gbMa8cWDqw/65jGo//1LvGeUPN2RJUt+1Ik1aw1esEUL1ubOsE
 US/h4toHYEY9hGiBpZbofX+SvtfdrQFhwUq8/b/LlUQf73Uram3yhhnfmvw2Sy6uXRWr
 Nsfn8bBvk7i85amqxtdeCvepRz+8sMe2uPSk9f+tJv2Jum90Gt4g7rYFNMOnAz3vAirx
 4GdTQ8zIsvbaccHfABwKvQZKBWJ3wfY8v89L1vh93jzAoyta/RVUroOQDnumWTQ6OxKJ
 D4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779947755; x=1780552555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6+/x1y/Lh0bso6UxK1vW2WZa03KFzqlFGYCtQYm4XYY=;
 b=RDeUwbFpQyGfwlXeavU0WSSbpcMvDf1Vsj8IPlfIFCsSkyuarwPIHZ7uGUfUXTWEUt
 xwXzihcHSQpczRVbkx3GVnhFTou8KAOQnSZQLEDu56o55KqAJJxTe4LHlwbjTGxDiRtz
 Vb3ZuELO61asyyp0PISeCi8wPUlZkw7IE6kjwMLgXUl3gdtHF5IBXqwFp+ofIGaEnGOM
 xDCAdBpxaxQkcS1HLgyU/rS7puuul90yIbko+CWvNMzWzpgjA903UP2uysMGR8+1F6C6
 8T/W4UPmnahwjs4AnJa6ip349z46DVx4KF3NjTBcs65xqed34+lItOUw8TiIqscgKFop
 Iumg==
X-Gm-Message-State: AOJu0Ywb7+jLLVHvy/f3hX+AbEo568VzSXCP6Fux3XiSHuDEbA2RQUFG
 z2JGpWmNh5/ENUJaaPK8DKi552dGV/yQeIu2t08rBppw+7oZnJKLYB4iTRYLL2ZdKzw=
X-Gm-Gg: Acq92OH+uYpHl9rbDorqqJMat45yiySbKG09/prRcVNETRvsaXfmOXdtOrXXeiwhrgx
 U7HjyEZmc+WxnL3QHSOwR2pgbA78mJIj4w6QzSCECQ0bB0VVc/mnUeOJoQr/oLN5qZGAnnFKZWA
 s7w53JdhGU6oUA77iJDg/tyndMHvk90Z2zvDbijxvlVcvtKk2fEUACCMFyR7GYaCayVq8qAuw0i
 GakVZUdzF8DZ/OW5K7/9U2RzNKFoROSi7zB4Y7wN5GAMx9bSFBP1REyOBM8AKFM1mCUnmZt3tfv
 2jMVbOwQOEr40L8Amme/UMD9noqCstxHx85TJ7sNsrEkVnYHsufCW6Cxxr/0XbbMHONjeDdAOma
 NGXS/GPludl0HjmPGk/qJJZV3/zuIYbUogW1RTedTtTM6GYb/e9RbfYVc8Y16ioABzkRXnYsoLj
 XSdlmbXHs6/xCjmJqZoUJ3xrbmDhjm582aaBk=
X-Received: by 2002:a05:6a00:1944:b0:82f:5125:a327 with SMTP id
 d2e1a72fcca58-8415f33006amr23596647b3a.27.1779947755078; 
 Wed, 27 May 2026 22:55:55 -0700 (PDT)
Received: from gmail.com ([114.249.134.218]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-841f3cbce48sm758068b3a.10.2026.05.27.22.55.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 22:55:54 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jonathan Cameron <jic23@kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 linux-cxl@vger.kernel.org
Subject: [PATCH v3 0/2] hw/cxl: bound Set Feature writes
Date: Thu, 28 May 2026 13:55:23 +0800
Message-Id: <cover.1779946245.git.physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260429152750.2409174-1-physicalmtea@gmail.com>
References: <20260429152750.2409174-1-physicalmtea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=physicalmtea@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Jonathan,

Thanks for the review.

This v3 splits the helper extraction from the actual bug fix. Patch 1
is a refactor only: it folds the existing patrol scrub and ECS bounds
checks into a helper, with no intended functional change.

Patch 2 uses that helper for the remaining Set Feature branches that
still copy into fixed-size write-attribute buffers without bounds
validation. That patch carries the Fixes tags.

I have left the qtest out of this backportable bugfix series for now.
I can send it separately after addressing the x86-only and magic-value
comments.

Changes since v2:

- split helper extraction from the bug fix
- add Fixes tags to the bug-fixing patch
- leave the qtest for a separate follow-up

Jia Jia (2):
  hw/cxl: factor Set Feature write bounds helper
  hw/cxl: validate PPR and sparing Set Feature writes

 hw/cxl/cxl-mailbox-utils.c | 94 ++++++++++++++++++++++++++++----------
 1 file changed, 70 insertions(+), 24 deletions(-)

-- 
2.34.1

