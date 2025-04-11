Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7772EC369A2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 08:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u39NS-0001om-UP; Fri, 11 Apr 2025 04:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u39NR-0001oa-Bi
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 04:04:41 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u39NP-0004fw-Dj
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 04:04:40 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-224341bbc1dso16193925ad.3
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 01:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744358678; x=1744963478; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ylz2iIYZOSyw/z6UARhneBq0/g623n67mpLl1GiIy2c=;
 b=VfSYtxylWJnBJgebc+3fE8ivv4VRDZw8kL4CqOktYha5yTG3yoj2jVy0pRXVniWZFk
 q+iaKb3PiemxSpje47nFhhecc0CM/xKhRPJes97Qmhe4JVdxBni3VyBLLlEEDzctn91T
 cr67BGDWXV/EzrhENzme7ODydpppGbDtXUjq40jeIP8rieuqF+CigK3nMd+AcwwscbDi
 3D4ivNL8f+jJ/SHZd+hP9caJTbjrNg1vF+Bf6KSXmlwEfArqrbsnqAMCiSrESYlsn+VL
 4LYLzIztAZMyPGZ/bBnumkukgVSq4cOo/e50XgQEnijfXbnOAvDTggCLFLqDO2617SxK
 k3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744358678; x=1744963478;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ylz2iIYZOSyw/z6UARhneBq0/g623n67mpLl1GiIy2c=;
 b=r1QH63tcIfIg67ocsBFwZP9h6oG6xW3xq70aWsbmX/I12pcCM9QaoXkOG6hxu5fJor
 0wyrpQNWkzXgTiiCZR1tKPymrtYC9T73coVqhQ9Mh5lFqk9NPPCnIm6HCPd6tJRwIcKB
 eKyLU+KIZn6FZKRo//xk6y3CEsom4xDeCwXmFkqAiAzwbFMZ3VWh8FfcafO6WKhUKgqk
 xPq7WZB0IabqrsbUJ09t4lZlE1Xl67uvhzjNoDALlljIXqN78J1+ahE/9SL+6fMF3v7Y
 VG0noSOulHOiOf6dADCiTYHAUoqzNSlqTrPEAx9Z7DkvPcNPFQC7C6J+WrfFiKw3TXOb
 /2EQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsJ2xuLJDtugXD8ZM7GGq72Edccuzf8DqGEKTdrvcrr2nwPk+QDTdCtqkEtVBbga4huM8dE1ke7xXM@nongnu.org
X-Gm-Message-State: AOJu0YyBOHjz+gDBn8pkFcFYtmMCBTbhP3l9spc6NaroKJMy6Gh7rB2F
 EPpu7kehVSXstsncmvgTWDki52vVnQBHUWqrtcoJu/0XaUyGkoJ9
X-Gm-Gg: ASbGncumkKE1fj5C9+/J3NZ219hJQNWPs1MkV/LmrYVCoijpX4zSP/PT8cK3cXWs6pG
 MJUYTlj2WeBNn0axVb9HEq1ipjvsNR6itIbaXR7z62XNoZ+L0ymfQTSBwLwdq4CsDxG9XCnoV5k
 0KiHuePqvjYOyfyiinzvYy2/jeClAPl6zRItx/LmsdsC2Q+Yd/NAh30Vs5mVO5TyD5S4NQ9uhwd
 pkbvKDRgVkVo67vnA4d2vDynT870s+NO3K93SnUgIgsakyYKIlEYnjlcUs9JMHWV79hsGyF5FFg
 JpPY01Egkdgzh1GWTnwOcHDTUQ1+yhc+25+n3fHDgDa1b8Y0h7QLJQo=
X-Google-Smtp-Source: AGHT+IFJeLk5z1Nse/h09ksg13I7P36OL6D5+6KYwOSRD85992lsyUM5xYya7VADQXojUOGMIq+ZBw==
X-Received: by 2002:a17:902:d542:b0:223:3396:15e8 with SMTP id
 d9443c01a7336-22bea4afa98mr30143025ad.22.1744358677867; 
 Fri, 11 Apr 2025 01:04:37 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7c95c83sm43048065ad.147.2025.04.11.01.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 01:04:37 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v2 00/10] usb/msd: Permit relaxed ordering of IN packets
Date: Fri, 11 Apr 2025 18:04:21 +1000
Message-ID: <20250411080431.207579-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
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

This series ultimately permits relaxed ordering of USB mass-storage
packets from the host, as allowed by the usbmassbulk 1.0 spec, but
not usually seen in drivers. AIX drivers do require this ordering.

Since v1:

https://lore.kernel.org/qemu-devel/20241212091323.1442995-1-npiggin@gmail.com/

- Rebased on upstream with one patch from the series merged.
- Fixed a few build warnings on 32-bit hosts.

Thanks,
Nick


Nicholas Piggin (10):
  usb/msd: Split in and out packet handling
  usb/msd: Ensure packet structure layout is correct
  usb/msd: Improved handling of mass storage reset
  usb/msd: Improve packet validation error logging
  usb/msd: Allow CBW packet size greater than 31
  usb/msd: Split async packet tracking into data and csw
  usb/msd: Add some additional assertions
  usb/msd: Rename mode to cbw_state, and tweak names
  usb/msd: Permit a DATA-IN or CSW packet before CBW packet
  usb/msd: Add more tracing

 include/hw/usb/msd.h |  18 +-
 hw/usb/dev-storage.c | 510 ++++++++++++++++++++++++++++---------------
 hw/usb/trace-events  |   9 +-
 3 files changed, 357 insertions(+), 180 deletions(-)

-- 
2.47.1


