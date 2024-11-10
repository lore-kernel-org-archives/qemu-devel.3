Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0554FD5E399
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Nov 2024 03:41:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9yo8-0007c8-Kc; Sat, 09 Nov 2024 22:40:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1t9yo6-0007aN-VS
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 22:40:10 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1t9yo5-0000Ni-IV
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 22:40:10 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-720d5ada03cso3522457b3a.1
 for <qemu-devel@nongnu.org>; Sat, 09 Nov 2024 19:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731210007; x=1731814807; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=A7pEvf43qIJ2aRmyxx8UOLulspcDWFI0ipGvQq0BBgM=;
 b=mZVI4WReWpY2yMWQvsu/f1mc2XfZnXyidyvL4IR4kFHrPBfJAmZh6lO9v/491c2Yc/
 gJUqjJmE0IE6Y92qIOw1MKCS7X+aUYwvMURfNH+Yy9lQqPFd6Fw9qexnyRNTe9vHSYYR
 Ujv9fgBPw9Sq1pgRVNwMth+mtx5w7kFcIWXEf7XAPpA8RyqyajduRfBemNpbKClCKqHh
 E4uwfs0osizIsufB1/t6o1A1VRkvuU4JvV5jITRlkXb+oCL8yDzP7rdXIIPDKufYNp8G
 wqq8bhEjhKIZkJjGCSipZ3A21lVJ/1//w90ltrBJF45LfNLUTZFshUOonZQ3tN0NJtRn
 gbHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731210007; x=1731814807;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A7pEvf43qIJ2aRmyxx8UOLulspcDWFI0ipGvQq0BBgM=;
 b=VK2T4qN0mgy1WTKZhh7JdbMa1kygN/wwy3+6tPV0RQpSUgWj1o9gNONCu/wB5DLSuh
 yhxPluYi6EzSRBOi3ac383Zi9CfIKpsk2UjU00YWIb95czyA3Hz7F1krU54ZbrZ+KDHO
 tJB5+nQl9AsOwH67J9yLqaMcg9mRv1JwrqAgcHqo41oPDyNYsCZ4puTTp84dYbOswxX+
 EUrbLZ2cFES3i9j/KDl41Mxg08sjGbx9OVN3F8B7HfUGxU9I1Ne7a9Thn2OlMzur8ldJ
 jrSiek6dC2rFIG52qGQf6MF9rIZKelT5Y9DtqeHtGWsMPNL1EN5Kz1701h72nVBpQEpD
 kr0Q==
X-Gm-Message-State: AOJu0YzEKoPTbKM7VXK3kf3WlVTKiAmpRlkXFbN9jpP8AMYKS+hvE9hB
 +mlR+sU9xSXxwdVlbrXjJmy78qF3XTvJBDDznVrbJj9mc8WM8O4ZPHk8gQ==
X-Google-Smtp-Source: AGHT+IEhMcNvJomgsX/7LrXt1jHfxh4gyDPYFtASXBn1cn7UKRr1udkr0twadJqVswmXRIqqvQCgaQ==
X-Received: by 2002:a05:6a00:3d01:b0:71e:7c25:8217 with SMTP id
 d2e1a72fcca58-72413380e56mr9764620b3a.25.1731210007530; 
 Sat, 09 Nov 2024 19:40:07 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7240799bb78sm6345273b3a.95.2024.11.09.19.40.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Nov 2024 19:40:06 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Subject: [RFC PATCH 0/2] usb/msd: Permit relaxed ordering of IN packets
Date: Sun, 10 Nov 2024 13:39:58 +1000
Message-ID: <20241110034000.379463-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
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

Hi,

This allows MSD Data-In and CSW packets before the CBW packet.

This is just for RFC for now, but it does work. Patch 2 has the main
description of the problem and solution.

I've not found a good way to split this into smaller pieces yet, but I
will try, also migration is currently broken, I'm not sure the best way
to test that. I would like to add a MSD qtest and hopefully the XHCI
transfer ring qtest could help with that, but it's still quite a big job
I think.

Thanks,
Nick

Nicholas Piggin (2):
  usb/msd: Add status to usb_msd_packet_complete() function
  usb/msd: Permit relaxed ordering of IN packets

 include/hw/usb/msd.h |  20 +-
 hw/usb/dev-storage.c | 512 ++++++++++++++++++++++++++++---------------
 2 files changed, 352 insertions(+), 180 deletions(-)

-- 
2.45.2


