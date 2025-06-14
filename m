Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F616C71135
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Jun 2025 02:09:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQGK1-0002jR-52; Fri, 13 Jun 2025 22:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>) id 1uQGJx-0002ir-Tl
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 22:08:38 -0400
Received: from mail.sean.taipei ([128.199.207.102] helo=sean.taipei)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>) id 1uQGJv-0006ZB-QR
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 22:08:37 -0400
Authentication-Results: sean.taipei; dmarc=fail (p=quarantine dis=none)
 header.from=sean.taipei
ARC-Filter: OpenARC Filter v0.1.0 sean.taipei 0A7BB2806
ARC-Seal: i=1; a=rsa-sha256; d=sean.taipei; s=arc-2024Q2; t=1749866912;
 cv=none;
 b=WiTM4f2EcSh4g5LXma2jScVCOoK4y7YavMvYCyyqpHbJekhWCrlvtZh1IG6uZlB7l4tWcfOAr0P6CzIbFoOoD/F0N9V1woxSUqWRx1s8a/J2DB8snPJKWTLmxniNyG4Fy32a0rt/k4nWloawEOfjMQk6Kn3qt0hBqIgR8xYQjPyVX8j2Qtr6Vt6jX25g2Y+yuFac+fm47QewyYelBPlj0jteO7vwfmzf+coFeSh83gak+hnhQ944kFaIPlqlf/E14LbIKKG8D9y2/6jMNDDIEeHwYvCuxJGZg7fuaKJlDCN005leyJuHg0ZF+eUqQKu69QBSAfcOGn894dxNPTsU7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sean.taipei; s=arc-2024Q2;
 t=1749866912; c=relaxed/simple;
 bh=YJPB+UpF0TrK4otw7PnFdY2TZPEROUIzJoUx4Rnh/Ls=;
 h=DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=j8Ay4qC7+L9ZIhkTNFKMW0QYFTTcjJvpTIdbVuqd9RxJazblK7iW3w3qcZvdDPQYxL7qZVlD/mw/8yqFRcnRvf0aorZy35DfWT9Owz7uIrglZzi77RCrhwTi/KeS6jYikASfj+f8TeIxWnE6Q0pj0JZ1aENy8K3i0Eg7eGm4fcI8muLNlFjE8qgG8HyZTTaj2M3/AAmQSqwooUOOJAbABg51mRT6iN7ZLAM3CMKOK9TG8/zDMufZnwBR+YRNkrJBfcsd9U22PIC4TKCHQPOuOMmJr92VPhY90LmsvPvEvbcL0cJaBNSK3WQLgO5j6ge6iguiagXxxQB1THT0DqiRng==
ARC-Authentication-Results: i=1; sean.taipei;
 dmarc=fail (p=quarantine dis=none)
 header.from=sean.taipei
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sean.taipei;
 s=2021Q3; t=1749866911;
 bh=YJPB+UpF0TrK4otw7PnFdY2TZPEROUIzJoUx4Rnh/Ls=;
 h=From:To:Cc:Subject:Date:From;
 b=9xremK/SDi0PGVTj7N/T+MU6E+n6PB1jP8UyarkBduErtTU+m6nxSQPSUbuWnHyJA
 tpvUS+/UkSeWf8F7rZXqQRd4BGdWMLjdZAR7EurwDeN7ALYKouKOUbVY5vd4sfe5gd
 Dq9qzKJ+4+w8tXSpcgTz/KRSwF/rucH+vaqN+anCPSPRI7fVi+EoFHPUZpUj88Wemi
 A7vDCcpw/M9I8LySToVYUFZw6mLCLDhgrH0OZpFJbZNMgudnWq8Ohv0TSvBemt6mR/
 +S9zSAPzcjJx/0AA/QZO0wiez0RkTuy3JLSZNBMIcMw2kp8OS88unL0TTGvHwv9u3d
 894fz3UNPQkDg==
Received: from Mac.home.lla.com (unknown [207.191.242.16])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by sean.taipei (Postfix) with ESMTPSA id 0A7BB2806;
 Sat, 14 Jun 2025 10:08:28 +0800 (CST)
From: Sean Wei <me@sean.taipei>
To: qemu-devel@nongnu.org
Cc: Sean Wei <me@sean.taipei>, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Greg Kurz <groug@kaod.org>
Subject: [PATCH 0/2] virtio-9p: move G_GNUC_PRINTF to header
Date: Fri, 13 Jun 2025 22:07:40 -0400
Message-ID: <20250613.qemu.9p@sean.taipei>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Powered-By: Sean <postmaster@sean.taipei>
X-Scanned-By: MIMEDefang 3.3 on 104.21.5.93
Received-SPF: pass client-ip=128.199.207.102; envelope-from=me@sean.taipei;
 helo=sean.taipei
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

v9fs_string_sprintf() and v9fs_path_sprintf() already have
G_GNUC_PRINTF annotations in their own *.c files, but the
prototypes in the corresponding headers lack them.  When another
translation unit includes only the header, -Wformat can no longer
validate the argument list.

This series relocates the annotations to fsdev/9p-marshal.h and
hw/9pfs/9p.h, then drops the now-redundant annotations in
the *.c files.  There is no functional change.

I've checked all call sites for these two helper function, all
of them already passes the correct number of arguments.

A minimal PoC (sent as the next mail in the thread) demo how
G_GNUC_PRINTF behaves differently when the attribute is present
only in code.c or code.h file.

--

Sean Wei (3):
  fsdev/9p-marshal: move G_GNUC_PRINTF to header
  hw/9pfs: move G_GNUC_PRINTF to header

 fsdev/9p-marshal.c |  3 +--
 fsdev/9p-marshal.h |  2 +-
 hw/9pfs/9p.c       |  3 +--
 hw/9pfs/9p.h       |  2 +-
 4 files changed, 4 insertions(+), 6 deletions(-)

-- 
2.49.0

