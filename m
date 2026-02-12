Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F4DEE368C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:11:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXNm-0000fq-1D; Thu, 12 Feb 2026 09:09:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqXNj-0000el-2g
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:09:23 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqXNh-0006Pg-9G
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:09:22 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-480142406b3so64306515e9.1
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770905359; x=1771510159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JXMyUL241UOhw4GwSrwewH9IPtif3TF+OOYjh6p3bwU=;
 b=R9i6H+8ol/Jit58oYaX1ZVqTH8Qf2kK5iq7z4/R2z1VEEzAQgCIDleAlOqsMsxdE+G
 DvfH3wpRLeRgn9Bw67Z5MaYjkWhLWB97qcc843xuQyx7r4QEtZ/KSlNmnlSbUsRdvf9w
 z5cftLypaatS5O4b3zGCZlHHTFNBRvL/NBGkJ9TDyfdF4xRVpPKKTYphZi3n9EQF2ojZ
 AQC/sXLGNVYl+ItShNoigtAMigdc5Ji2o03oWO1Ed+fGLQaeXEwQn2EAVSesk+2Fkglh
 pTXSq7lbBgbyt63pH0cWgSj7i4krE7hjc7QCVuOsxYMSKLDShJFTPmjBXM44rK9O0lDL
 wEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770905359; x=1771510159;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JXMyUL241UOhw4GwSrwewH9IPtif3TF+OOYjh6p3bwU=;
 b=rQ8gizfBvppibgnpHK1aqBH5NEx3u1kHCPBA65Io4/AAVELD+O6sKOQkfbVe/7IlHD
 lygrTDij9U8mU4WWz+n/fbNUpKB1gQKHF+8o3tikSD1Xqej6b7SNilm2WWCMuV86b9y/
 FgKw2Le0UT6jEB5b7tvsDJaN3HiI8Etq/EE2zSQLoqmzyHKThsfsmGssgzbGIcm+fVDj
 wQ0xLIz7kAa4eBqO7cDjDmdQzLmRMTUzAXjAltR1EnMCxT63cK2I5ARpE5hOrQMnszmB
 8/1Xz37YUoeciUhcZLfEOgukGL1YroymtIfIED2c9JAwmi93jkw3sVUuVqmtX21kLuNr
 B50Q==
X-Gm-Message-State: AOJu0Yxo0CUAAbp1nyUuvkZaDbnVvYg+6TXXDJ3bL22CSkgHJ9SRxMC8
 NKg/aOPfDVk1UdGQq16VZFAP7vsnYp2emAXFOCtzigZF6aimERX7/lAWqVxgWCUj2VOAlcasF/u
 X00n2
X-Gm-Gg: AZuq6aKbLpqP/+A0oHOYrrboA4iS4qcR+FZsuVpQP+JWhz+o6Ia1Vdv5ZUbY5b6s6QF
 GnP3sDG9sudcY3tIiyCXpMhnAtArsW6VaMDYPYE9P86d3eJcvxdBNruxxbjRp5hOA3X/GW1GW9r
 DW1O4M6DqCtD7q0Kt1CqJCuYPMm7emW2bIh00Rc66ZESXjneNiD+0moaOdjZ9KdEkHUoq8EBSfT
 TyMTBLuuzg7vuzBoNKJ2CcfDrhfu1mkIhncGqwT9pCFx5bHY1Kj/YOD4O4eVjmDzJMZkyo+vCGF
 e4EJXyRJhtVNznfMMr3uLcC8ZehYqOB05WzUp3G5OLroXdSxc6Z1pCbXdC3Mw0hi9rxoKg3tWxV
 OG4WGKbU9kJCIQ7ZQIFIhg9em+DVLf7AhQux01yfAi4J9g9RsNk59bPU+gQuMJbnYm/ZhNkfpep
 cdeu2A1rZSn9itEFg19ijNcJTPDyfMGxw8Ivihtaa/Pv17AHh39Ogap8ypIMUNvMryLAFQUxBNX
 HYn/WFIsa+LmdJpPcaul3k6RFh0U0Y=
X-Received: by 2002:a05:600c:458c:b0:47a:935f:618e with SMTP id
 5b1f17b1804b1-483656c6116mr41012855e9.15.1770905359454; 
 Thu, 12 Feb 2026 06:09:19 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dd0e327sm123266885e9.14.2026.02.12.06.09.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 06:09:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Patrick Venture <venture@google.com>
Subject: [PATCH 0/5] net: mark eth_header, udp_header,
 tcp_header as QEMU_PACKED
Date: Thu, 12 Feb 2026 14:09:12 +0000
Message-ID: <20260212140917.1443253-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

The packet header structs eth_header, udp_header and tcp_header
defined in eth.h are not actually guaranteed to be aligned --
typically the network device models will work with headers in a
byte-array packet data buffer. We attempt to deal with this in some
places such as net_checksum_calculate() by using lduw_be_p() and so on
to access the fields, but this is not sufficient to be correct,
because even accessing a byte member within a misaligned struct is
undefined behaviour.

Back in 2024 in commit f8b94b4c520 ("net: mark struct ip_header as
QEMU_PACKED") we fixed this for ip_header, but if you run a
check-functional on a sanitizers-enabled build you will run
into errors like this in the sifive_u_mmc functional test:

../../net/checksum.c:78:47: runtime error: member access within misaligned addre
ss 0x561f52f35011 for type 'struct eth_header', which requires 2 byte alignment
    0x561f52f35011: note: pointer points here
     00 00 00  00 33 33 00 00 00 16 52  54 00 12 34 56 86 dd 60  00 00 00 00 24 
00 01 00  00 00 00 00 00
                  ^
        #0 0x561f20608459 in net_checksum_calculate /home/pm215/qemu/build/clang/../../net/checksum.c:78:47
        #1 0x561f20117bfa in gem_transmit /home/pm215/qemu/build/clang/../../hw/net/cadence_gem.c:1386:21
        #2 0x561f20115c61 in gem_write /home/pm215/qemu/build/clang/../../hw/net/cadence_gem.c:1650:13

As with the previous ip_header fix, before we can mark the structs as
QEMU_PACKED we need to adjust some code which takes the address of a
packed-struct field, because gcc will refuse to compile that. The
rocker device does this with eth_header::h_proto.

I chose to keep the three "mark this struct as QEMU_PACKED" changes as
separate patches just in case they cause issues I didn't catch with my
compilation tests; that way it will be easier to diagnose/revert.

The problem with eth_header came up at the beginning of last year
in relation to the npcm7xx_emc device; none of this is particularly
specific to any one network device, it's just that we happen to only
be exercising the network in a way that triggers it with the sifive
test case.
https://lore.kernel.org/qemu-devel/CAFEAcA-gyMTz-KpmamyXcKX9QOL=yYHDMPRF2Xji_uJbG02WpA@mail.gmail.com/

It would not surprise me to find that some other structs in this
header also ought to be marked as packed, but I prefer only to
tackle them when we have a sanitizer repro case so we can
confirm the fixes.

thanks
-- PMM

Peter Maydell (5):
  hw/net/rocker: Don't keep pointer to h_proto as uint16_t* in
    OfDpaFlowPktFields
  hw/net/rocker: Don't assume h_proto is aligned in eth_strip_vlan_ex()
  net: mark struct eth_header as QEMU_PACKED
  net: mark struct udp_header as QEMU_PACKED
  net: mark struct tcp_header as QEMU_PACKED

 hw/net/rocker/rocker_of_dpa.c | 19 ++++++++++++-------
 include/net/eth.h             |  6 +++---
 net/eth.c                     |  6 +++---
 3 files changed, 18 insertions(+), 13 deletions(-)

-- 
2.43.0


