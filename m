Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A4FCD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 04:58:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSpI9-0005fF-FS; Fri, 29 May 2026 00:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1wSpI6-0005eT-0j
 for qemu-devel@nongnu.org; Fri, 29 May 2026 00:57:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1wSpI3-00085K-As
 for qemu-devel@nongnu.org; Fri, 29 May 2026 00:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780030665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=V1fypGJVn2IFAyqeSiUc99YwP5V5gS7rRdMEcyTPB4c=;
 b=i4PeLGwyMHg4VTYuCIJl/DGkleeymXHfBnOS7S05eNIA5Sv/geY09NySCUwSl9raEuOXrM
 cICuCdP86c34f3lqc9QWmgoYt7ANoVWjYUGQXowB6s8Bh0eqrYE39K26BVwUx81zgBmwr0
 DUn5JvarUZREVGUNDXNluBlWyll7wtw=
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-k88EM_OmO16moc5OKppH8Q-1; Fri, 29 May 2026 00:57:42 -0400
X-MC-Unique: k88EM_OmO16moc5OKppH8Q-1
X-Mimecast-MFC-AGG-ID: k88EM_OmO16moc5OKppH8Q_1780030662
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304b8d0ee63so3939978eec.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 21:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780030661; x=1780635461; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=V1fypGJVn2IFAyqeSiUc99YwP5V5gS7rRdMEcyTPB4c=;
 b=FHFfsAwuC5/7plZKBss9BuVbd64ZDlaG61XmoaHv5eNhiNdF+lkMlES+KJ00Hbhs3e
 um+9RL/TLW2TJQ0hGUiFuY71ytaTWLYxp3opCoSKYYF2McK7u2ZAXSxJLgVxlrtD8IRr
 1Ov+ZAvzL2UJ+fSGYCKvcrRMd2EAeprzTdaAD2sa5wfNYmXZVs1r11EshC8MAwGK85A5
 4idwpZUxdpvs86Vqc7EDRXTp7s2Ss/sI2lKAuafmxAR3oMNHsl0K3+zDVjZOtInNK2fi
 6mxtGz6rcdQebvKv7f4gTPTmj3SKpLIfmNFffFVX9iVGdC4omhHokKiWhu0kYBukj/ln
 QHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780030661; x=1780635461;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V1fypGJVn2IFAyqeSiUc99YwP5V5gS7rRdMEcyTPB4c=;
 b=omwv3b9DeBvhl/OYmU4xEHOwab9zkRDyNJAPMR/GwaQCo9f4qXeD3xoGMmZXqX/he6
 FjVL6KiIzw0SACO3FDforzIpEqXy1OCFT7GbBQQ/M2vj9SR9jq8rMtiFQaNkPOqQpg2F
 8nNsglIDe+XRKH0jQ6hhc+EzFzkSeqCcwj7Z+WV7IxZle8DpqHEnwL+3itlO93Y69K1Z
 pLOAtk1DMaGFwT/s3wY406SNNoJZrtCmP3w1T06Erpa6EdGHQeRBxae8nYqPB9JzJeyO
 grLJUobG2+h8t8EbO+dI6mQ126BvtIsrqd4wXvD/ECHUKxKQLW8yyLPF4bPUIKySG7lD
 e3ig==
X-Gm-Message-State: AOJu0YxprSfpKgSDTmojS2cCBLTjMERImSVoLsEYQeIrkVsvus7gbe6T
 LSgiOf2eF2JJB9qISZxjoHm0LQr5YzWYtGP6ybaKYYqHg4ckYxDl8t2sPl1tNgHcmrFmKDj6Zhh
 /hBGqsL7KErr9or5XIL8yG85RfJ/MrdN/cwCJ5Wy9p/a3XlTlw5qrRcOgM6Ujgs4zNwO1zzUhpw
 i40/8uRS3+HhFOuOAGptCLPG3cDqpzVZk4auBYO8Q1h84=
X-Gm-Gg: Acq92OEWjFT2NL4Muy/UXOkWSEFL/X+KVtAS8mPn6jkb76c/li/oSe7WTU5PnxI8mbn
 Yaex0r1kaH4Ill9VtAebxPcIZJYTOZP1xOgYZAplm9lFbfx4m5zvre7hHQprX+HWi/0Eb5QDXco
 K0coyEraFDAH0nAX3fYy69B8rG9RtgI11RA5Hx/Km37Jisbl9MKgrTwDLeWz6JyKKz8kT4gEE1p
 5Dx+gs4M3lLEY2jB6Bq/eqmh424nQvLgiHE0LfgpLinFcolD8p7zYbwU26yYNiQvW0ngKx1FBob
 LxZsyBh4/Pp+ySIwGqiDUqNc47PYtVVV0285m30gknz0JNEx+qjQi9dbEqTsMGomIM6YHroPVbV
 Iy+uPZc0TdhH9ESbr4OdV7SKmBK2t3qnmM5BZmukeRskcZX5Vy6PvZaW9hAL43It9JsLiS+Jr
X-Received: by 2002:a05:7300:a483:b0:304:2cc9:2ba8 with SMTP id
 5a478bee46e88-304eb21755dmr637762eec.30.1780030661498; 
 Thu, 28 May 2026 21:57:41 -0700 (PDT)
X-Received: by 2002:a05:7300:a483:b0:304:2cc9:2ba8 with SMTP id
 5a478bee46e88-304eb21755dmr637741eec.30.1780030660649; 
 Thu, 28 May 2026 21:57:40 -0700 (PDT)
Received: from localhost.localdomain ([107.172.97.67])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed3358b1sm562865eec.13.2026.05.28.21.57.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 May 2026 21:57:40 -0700 (PDT)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>
Subject: [PULL 00/15] Net patches
Date: Fri, 29 May 2026 12:57:15 +0800
Message-ID: <20260529045730.90322-1-jasowang@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit cbf877d67a812be17a9ce404a589e1bdf722c1f6:

  Merge tag 'pbouvier/pr/docs-20260522' of https://gitlab.com/p-b-o/qemu into staging (2026-05-24 07:45:19 -0400)

are available in the Git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to 71d027cfee8553e2ec28efa1ddd7fd0ecbadcc86:

  hw/net/rocker_of_dpa: Avoid unaligned accesses in _of_dpa_flow_match() (2026-05-29 11:54:06 +0800)

----------------------------------------------------------------
-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEIV1G9IJGaJ7HfzVi7wSWWzmNYhEFAmoZHBQACgkQ7wSWWzmN
YhH7ywf/WZdieTiWCoi1XI2rZ6XCjdJRqTSmp+WENDDQt4tBnXXJ6PxyitFqZh7g
oZnN1+WXgIAO0SZRPbzjspe9mFsXrFkE/7y9XijOF4F/bhbWPA/AL8SICxnjoyaC
nOs1QU2hE7yhOqgnUHweUjNbgpUO8mIgLdSIbKYDgZq1vRFsXy2kkKbeiJkbPCfe
0ILqltFjS5MeCl2fV0WwUquWr7VXEXb0vGPQKAzRbygmbDC+qYRF100cTrSCxnOe
LSW8c1nf2AHZkQJmj2HWc2DUwxynAr8N8jSRPgp4JSC6B2caSQygKHGtKe19Y/Be
u4hm+k5+HB25xkA4czheMcNvefnzoQ==
=JjfR
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Peter Maydell (2):
      hw/net/rocker_of_dpa: Check group ID pointers are not NULL
      hw/net/rocker_of_dpa: Avoid unaligned accesses in _of_dpa_flow_match()

Vladimir Sementsov-Ogievskiy (13):
      net/af-xdp: fix type overflow
      net/tap: net_init_tap_one(): add return value
      net/tap: net_init_tap(): drop extra vhostfdname variable
      net/tap: net_init_tap(): refactor parameter checking
      net/tap: net_init_tap(): common fail label
      net/tap: net_init_tap_one() refactor to get vhostfd param
      net/tap: net_init_tap_one(): drop model parameter
      net: introduce net_parse_fds()
      net/tap: move fds parameters handling to separate functions
      net/tap: fix vhostfds/vhostfd parameters API
      net/tap: net_init_tap(): merge fd=, fds= and helper= cases into one
      net/tap: net_init_tap(): relax QEMU hubs check
      net/tap: check that user tries to define zero queues

 hw/net/rocker/rocker_of_dpa.c |  16 ++-
 net/af-xdp.c                  |  44 ++----
 net/tap.c                     | 324 +++++++++++++++++-------------------------
 net/util.c                    |  55 +++++++
 net/util.h                    |  14 ++
 5 files changed, 221 insertions(+), 232 deletions(-)


