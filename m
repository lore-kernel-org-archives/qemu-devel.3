Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2275DC5DF8A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNUZ-0002PA-Mt; Tue, 18 Aug 2026 13:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwNUQ-0002Mp-Eu
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:20:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwNUA-0001iW-M5
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787073624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Bj2ViZ2FqvibrteJL9smaflTnuWVy/5WD/HZllCYWDs=;
 b=SZrS4pIKXv0CInIGBjPLlqr7+yIyGb3FOqzteHimuNq0B9gYbUcACJeVkT2YQGQvkK2rKQ
 DsYFFYGhuQTQrg+k/eNhz8Wkn60D5DkCstPxuN28WHA6E6CuCPhzWVrT6HVHibD+y6J284
 /0N5t/TDNO4v4vyRoUaEnrX8766ekVc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-cF-x8rcgOqK1biEkwA6FgA-1; Tue, 18 Aug 2026 13:20:23 -0400
X-MC-Unique: cF-x8rcgOqK1biEkwA6FgA-1
X-Mimecast-MFC-AGG-ID: cF-x8rcgOqK1biEkwA6FgA_1787073623
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8ef8249f871so2414226d6.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787073623; x=1787678423; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Bj2ViZ2FqvibrteJL9smaflTnuWVy/5WD/HZllCYWDs=;
 b=X5dm4o5kt5rtBnjnFG8IDiYER3pz7O6R3xnj6DVPkP0ZS8CFwoVNFSz/Ly2hwEIK+7
 +CJ2uhjKcYD1s4wjkpXaGEiQUfl2x0RYJ7KHWsMUwmwb8dP2Q1zZgVMDglKogT9fRlQB
 86L4dP6GSGjVkZ6DLwAq0iF412z0xxC3pxCe/Qy5ry8r6xrGIPHgUFX7YYGmAAY/Oi7P
 3BKtxQOrvFwpxtVR6bU2X/wn+uZyoekVVp1in/wrbhluLiAYS3HbQjV8dzWvwP+WUG39
 aYoHzPBCr43xYdhwjSHaisQv34XrvXM+gg163CCW6du7QtjQUDT4p7E9Ne0DX9I1MoZ3
 RZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787073623; x=1787678423;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Bj2ViZ2FqvibrteJL9smaflTnuWVy/5WD/HZllCYWDs=;
 b=d1n9g+b4M8W8v0ucRflUfr+DyZcdMRVQGYT9VU8n83L6oO+c5Eovhqo178wyAA/JtN
 KjsJGQoVtXJgvL/JIY5ucld22eqiZMQ6wosw1yiEWcphoA74/cj9mGzuC857W580Kis/
 H3BM9vYOAG146MmPXPPfOfWbUeupGktBKuAxqdDuK6/2SxW1+wKMSqGoj3FxcTA+uHwI
 d0Hzt6pL5CDU3yF00brhqRQz8tC7w5rTuRK8j2PdPq07cG/LTlul9ZT+JeWsoABZWjhl
 lzJ4LTZJkbaq1BoaM8sraU59nex1hjj99nJqxSJJ1UVLZSZmEAhNgPrQDkdQsnQ/c+pz
 sWnw==
X-Gm-Message-State: AOJu0YxmwvMTrQ71iYaJRlmYqJVRgqu+hkyprlErssSvnRB6fW7lNGb1
 cxhMLS7ZwfHixRH9xNvgv9cjBhaXW9JE53m5dFXvegNPcjoKHLPAaWl14Y4qctj528+kMZ2lV67
 wcLc8sEqs4Bn8LD0cmN1Ts6xvJK0g9lgJoW13Tq43Bkf8eqGyZcXXasevpBmw4wL6bnXxoAQnDe
 D1qQ9oVOdKL2J+eAOhVslbNewHN28BGASwK53ylQ==
X-Gm-Gg: AR+sD10haiShHDgs6Dvf6ax2pPma75AWK0+R6Z1etKTcRRsW3OCFb9hmz2LLj0L3qXJ
 rF1FZZ2SsEjx5toe4C1rQBoxjl8U833d5o83isO3GPG0na4o1zePX68Lmiwn9l3+Bxec6qI744Q
 lk92fVDPpTJvUT4djhEwFugpNdtdUc7UxqmupYuvmd3eMkKeAgtjcvrSXeKIT6ksrALa0+OX9zO
 l0CDLCV/qQgbdPDJMuDUEX4crbx54ieHgnLhVnTGwx2GC0rJeXXFnxogClzIlBD/seONxQkpPxo
 WXqRN4S168Bx6CumF9CReNw0vXNW887C5ZegRvH0QQbxMLqP/8eN6tqxXdPALlO7EC7ysuxlIck
 iBlxdviN+i4Y1UCPkmLfen5JN4pEOqDHwFxO5BOj8MAwv1fl6XqmcsoPZ
X-Received: by 2002:a05:6214:1316:b0:907:888e:380c with SMTP id
 6a1803df08f44-90a91d92c3emr373426776d6.26.1787073622594; 
 Tue, 18 Aug 2026 10:20:22 -0700 (PDT)
X-Received: by 2002:a05:6214:1316:b0:907:888e:380c with SMTP id
 6a1803df08f44-90a91d92c3emr373425906d6.26.1787073621872; 
 Tue, 18 Aug 2026 10:20:21 -0700 (PDT)
Received: from x1.com
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c4584418bsm36560896d6.17.2026.08.18.10.20.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:20:21 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 0/9] Remove 32bit support on system/user emulations
Date: Tue, 18 Aug 2026 13:20:03 -0400
Message-ID: <20260818172012.3052821-1-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

v1: https://lore.kernel.org/r/20260814134035.2733355-1-peterx@redhat.com

In v2, I touched up the original patch per suggested.  Then I added some
more patches, almost quickly looking at references of HOST_LONG_BITS and
clean up those I feel confident about over 32bits.  I still left some there
(dev-properties, qht, etc.) which smells like tools may still use them.

Please have a look, thanks.

Peter Xu (9):
  system: Define ram_addr_t to be always uint64_t
  hw/vexpress.c: Remove forced cast to u64
  arm/mps: Remove 32bit define for MPS3_DDR_SIZE
  xen-mapcache: Remove 32bit support
  bsd-user: Remove 32bit host support in thunk_convert|print()
  linux-user: Remove 32bit host support in thunk_convert|print()
  arm/aspeed: Drop ASPEED_RAM_SIZE
  hw/arm/raspi4b: Drop board_rev for 32bit hosts
  machine: Remove 32bit limitation on ram size

 include/hw/arm/aspeed.h           |  7 -----
 include/system/ram_addr.h         | 16 +++++------
 bsd-user/thunk.c                  | 47 ++-----------------------------
 hw/arm/aspeed_ast2600_anacapa.c   |  2 +-
 hw/arm/aspeed_ast2600_bletchley.c |  2 +-
 hw/arm/aspeed_ast2600_catalina.c  |  2 +-
 hw/arm/aspeed_ast2600_fby35.c     |  2 +-
 hw/arm/aspeed_ast2600_fuji.c      |  2 +-
 hw/arm/aspeed_ast2600_gb200nvl.c  |  2 +-
 hw/arm/mps2-tz.c                  |  9 ------
 hw/arm/mps3r.c                    |  8 ------
 hw/arm/raspi4b.c                  |  4 ---
 hw/arm/vexpress.c                 | 13 ++-------
 hw/core/machine.c                 |  8 ------
 hw/xen/xen-mapcache.c             | 12 ++------
 linux-user/thunk.c                | 47 ++-----------------------------
 16 files changed, 24 insertions(+), 159 deletions(-)

-- 
2.54.0


