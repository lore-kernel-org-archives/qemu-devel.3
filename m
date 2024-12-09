Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 353B1E77173
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 01:47:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKSrJ-0000gV-Ge; Sun, 08 Dec 2024 20:46:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wannacu2049@gmail.com>)
 id 1tKSrI-0000gE-0b
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 20:46:48 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wannacu2049@gmail.com>)
 id 1tKSrG-00012r-It
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 20:46:47 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-215b13e9ccbso35437105ad.0
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2024 17:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733708804; x=1734313604; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PS/SyKa5qII7S4zjcdsqTedeO7HFW43UKQe9mFIi7+4=;
 b=YnpHoVWzkdRrQRYlm+FM/qPwywLfg7xvYfQpuYS6Nya1/tjLJfRTeAHdRKnSO9hNQm
 Vf/EcxdOjK1pPrUcuxc2E+q3Eq3p2LGZg9yCqMYHdzzFNTa+2lCw0bmmZocmJWGy/ffj
 /iAK98pHAHzObTP9F35b1/EP/Tq625YlGvkB+Ccl/klJCot0A6m4k+J8Ub0n5Trwa7wL
 2wNMX4ksxhfkcKa7Wi5GvFuHIBepAGHlVAClJlQYizGNBf2O7p3k0MSIFOSevwEQwQN9
 Z9GhLSzM+BpcdvJExMfLHEgaOgGa7k2mYxpL8cJ1PtmNg37RicGikrCd64L9OzNWSmPF
 p8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733708804; x=1734313604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PS/SyKa5qII7S4zjcdsqTedeO7HFW43UKQe9mFIi7+4=;
 b=LTn9YB6ljkDL2RYXlo4C8S7cZnSjFmKp0GB8wbiXY6rLH5InqAh+9Yb2YKww69chO4
 UuO+qRyQaILQJ+yAln6+H2XuGAFrqdmRWDUBD77Mus/Sz+QmwobYwlsa1wVT6WfVWEPk
 6xdGk6zc9BY4jXjKDjrh6gz3yr3/XvrP3ymJDnXiaiFk4XkSfCrSMG5M3ndE70Lp8cjp
 OKl/yHhUt+CBWSU/DiffezVt3wqkjsCVhOjmEHvPb2s+BusIG+3sl9z9nYLpZzdOWUNG
 CBvg9+eH0kkoFI6SoaxKt7vPqnqdC6DoPqC7ImHF2/cp9QCiWPtSidldownC7Fuo0+uZ
 qyUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAy6iJvjqQtqSluTDN8qyJftf5r7iEzuo2+1ovPmNxXIo5KTwMyO3ccwfinKFSvfGN9T7N0PlLiYLL@nongnu.org
X-Gm-Message-State: AOJu0YwTzTN7prTilqe7QPYLH3VxFK6vk9bWLw6hiTBFFBn6dTvqsL1p
 rpXCyl3wY0RdugaTQR4/ZlpO9aDuDGstue9YcZ+9w5rGQKwRwJIM
X-Gm-Gg: ASbGnctTY5kGJ5olXygFx4Xtctv57zsfUQ6Z4D2UiEbpTO1DiqcVbczsnsq3h1uNYqQ
 xIjPgCYQ3s9bCGLOXsw636A0WJSBPhuCrEL8K8BGwcctW9/LjyWAq94y1ZHjEgjoNRmKAdZ948U
 2OHdv7K7sX6757fSwJKomTIWJHRp/zW/uneJtTauggKBQChCskLlVZz7Y22jSdVRNytmHaSkgcd
 EylBf0v4kAi5gpDk6euqeDR5LI0QX5d5vfpJ8kxk4hoRJx3QPXpGJ4TTTUXJpo=
X-Google-Smtp-Source: AGHT+IF1gODURwYzSYIKXSwknOM3nIMVLU6dGYQXK6KktGx60tJAWCKKGj6Sd7VZOkPlRqEguhlldA==
X-Received: by 2002:a17:902:d4c3:b0:215:8c36:9ce with SMTP id
 d9443c01a7336-21614d7be2bmr137433915ad.30.1733708804134; 
 Sun, 08 Dec 2024 17:46:44 -0800 (PST)
Received: from localhost.localdomain ([61.183.83.60])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-216325f51ecsm25876335ad.216.2024.12.08.17.46.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2024 17:46:43 -0800 (PST)
From: wannacu <wannacu2049@gmail.com>
To: richard.henderson@linaro.org
Cc: eduardo@habkost.net, pbonzini@redhat.com, qemu-devel@nongnu.org,
 wannacu2049@gmail.com
Subject: Re: [PATCH] tcg/optimize: Fix constant folding of setcond
Date: Mon,  9 Dec 2024 09:46:38 +0800
Message-ID: <20241209014638.18972-1-wannacu2049@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <7f8d7f1b-8c5d-42de-8d5c-137b2d281719@linaro.org>
References: <7f8d7f1b-8c5d-42de-8d5c-137b2d281719@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=wannacu2049@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

> I was curious as to why this helped, when arg_new_temp was supposed to be doing exactly 
> this.  It turns out we were incorrectly reusing an old temp, not allocating a new one.

I appreciate your explanation of the issue. I had attempted to update the z_mask in 
init_ts_info when the temp arg was reused, but it didn't seem to have the desired effect.
Since I'm not deeply familiar with the codebase, I didn't dive into all the details.
I'm glad to see that your new patch resolves the issue so effectively. Great work!

Thanks,
w

