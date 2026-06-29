Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03212C43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:42:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCFH-0000Vu-Er; Mon, 29 Jun 2026 09:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1weCED-0007lL-0V
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:40:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1weCEB-00052t-8U
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782740444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=f7gY6uiOvf9QPtbj2SFoTuWPHgnD0DrSj0sLFmTqn4A=;
 b=VQi8k9HoD2A/n9P3caC2ue7PD45V2Xmlq11/D2W0G37lde4+9GSEZdGV2czPBK9XEM4GbF
 F5sC10YJdzjojnqdCyO8tc12nnFzdg733ZNKb/ZIB/BV3yrKrvBM+GHO9pmUGZCztS3wQl
 0HU87/mL+A32KoWuMkEHSmc3jdQLyrQ=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-U8p-198sPXmTNt3D5WGslQ-1; Mon, 29 Jun 2026 09:40:43 -0400
X-MC-Unique: U8p-198sPXmTNt3D5WGslQ-1
X-Mimecast-MFC-AGG-ID: U8p-198sPXmTNt3D5WGslQ_1782740442
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2ca0331d0b1so12328685ad.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782740442; x=1783345242; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=f7gY6uiOvf9QPtbj2SFoTuWPHgnD0DrSj0sLFmTqn4A=;
 b=gB4DRvvQQTXSwW3UBhQpaxXr8E0OSBtZomMRGB6OJx1QT4yHGq3j0bFrZ3jdWRzFaR
 NhUhVpogO879q9odR3HHLUNBqNBsSIfzPiIZcEn0qLbUcTkj5rBHcM2QbewQ2nAdMfUp
 QQoZKUVc/TuhVQ3lM4vyiOyLJnAc8bTWNrD5xfs8MtXNe/rVvFo90+vC19aFBQXKmR5v
 vEocxEBOcLnWUD3MjLEFGirXUqLG3Be9lyPrkN6YTP9Zht6QnSt6xVrkgjWrTK4aP9Dq
 tWejmn38tE7W/mVxErx76iHqbqJYmNPpqLeJeuWC8CGnEFS9lpF4diTFkXsFkcRB7E5W
 jBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782740442; x=1783345242;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f7gY6uiOvf9QPtbj2SFoTuWPHgnD0DrSj0sLFmTqn4A=;
 b=n4kMLRHkKsUO1iWlOk31nHKoahXwaatx71iO1PudeyoZXacOfceMvqRtP0M+T36cLK
 vBjOCwI8y1vSlMImEMkL25dGR0mdPfqrOAyWOhw1sOkksUdREO27BvCWO/WqEeqxqIZS
 KQ9yTjxiqU38DLShQF+ReZ4fXe6mS9vv6WMVv4yaWebVBeMHCZ30E4ajrvmleYifPphf
 EPUv3OIMVLTz8uroYg2bvhSadfpLo7MiAJuViyWucjXWEow7MzLp4UOdVYo/lN35yreE
 cKdczC/DUF8KIlS4nWuawj0KSBJ5uAPcShzm4242+dNsLZDNteZA6zjyG6xHwU6pTa2Q
 VRQQ==
X-Gm-Message-State: AOJu0Yz9YDP2vF8nSpaI02RT0+EHgYUGU7ixNnU30EEENdqtqiH4lA1t
 NvGnQgIzcqP3JqphL+4ghGxON7yaKoo17pOhZoScck3gMWWvsmQ0L+xdpdanPM0Mf1NUNcq5ZEm
 n3D5a7EMIVlmVhgpeIpflekOyrJL3eSlNYDj5/wbVYRNfvEIYA07dQYCUMh23ExGdCm1isu34s9
 yqQl/DAS4MOLvwvoFDVZsaxhr36qZZQNowo0RFyu6t
X-Gm-Gg: AfdE7cnz7At+2dgvSlOltDtNDLdh8ZNlBUhWulCTr/sjgrUBbqQsnMgJqHB7eYDVJBY
 5unkR5bCzCyGPoi4hoDHWmNDOhjtaEbe7fdNI+Cq1CYuPn6uOKXtOsOYx7k0P2l3vq37nTTk+o8
 +gi1mP6XwF91SEAXPITWQBVF3U+u1UZJds8zULU8K8mEWLPZQIQqCr1vmJ4ySYzB1Oa5mgpLWAs
 8/yYLBRxbP3Xp/UxuHrLBNVxITJkUtd5sgrlRqR5/m4uMb1SByn5xTkH+DS0PteoKZOHfGQ9IUf
 feAUGlclBfygLm1S+CV+8un/6NiRaOi8gvuNWDcE76yHIlARgyC/UE3K4HOkb35wh8tOYo3Yzf4
 gB5eaVeCjIoadqQqRQUhoRw==
X-Received: by 2002:a17:903:32c4:b0:2c9:ff83:41e3 with SMTP id
 d9443c01a7336-2c9ff834537mr27831595ad.21.1782740441824; 
 Mon, 29 Jun 2026 06:40:41 -0700 (PDT)
X-Received: by 2002:a17:903:32c4:b0:2c9:ff83:41e3 with SMTP id
 d9443c01a7336-2c9ff834537mr27831345ad.21.1782740441095; 
 Mon, 29 Jun 2026 06:40:41 -0700 (PDT)
Received: from localhost.localdomain ([208.115.228.234])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c9a93d5ebdsm48626505ad.74.2026.06.29.06.40.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jun 2026 06:40:40 -0700 (PDT)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: jasowangio@gmail.com,
	Jason Wang <jasowang@redhat.com>
Subject: [PULL 0/1] Net patches
Date: Mon, 29 Jun 2026 21:40:31 +0800
Message-ID: <20260629134033.31893-1-jasowang@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 20553466cc47af6a8c95f665b601fce3c852e503:

  Merge tag 'pbouvier/pr/docs-20260626' of https://gitlab.com/p-b-o/qemu into staging (2026-06-27 23:28:35 -0400)

are available in the Git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to 08c450d312e73db0bc8b792e604e0f1c49d1bfa8:

  MAINTAINERS: update Jason Wang's email address (2026-06-29 09:52:49 +0800)

----------------------------------------------------------------
-----BEGIN PGP SIGNATURE-----

iQFJBAABCAAzFiEEIV1G9IJGaJ7HfzVi7wSWWzmNYhEFAmpCdSsVHGphc293YW5n
aW9AZ21haWwuY29tAAoJEO8Ells5jWIRb+sH/2PLAv0BpViEDy5lL0b+s5yCIdbw
8XRwVvLk/SXavj/zn+LaWe/DQCdd4MKALvCCuG6WfqfSdF7XWnG4DhSXvnx5MRiW
um+259bwwAsW2H++Unue6TdkCFvGQQo8TJFP3EV+gibzIaFEXwxHloMgp9y1uQah
HhAKFr3QJL5zX7YohzuzUSkXQO2yVnEcPCsTuvdnbe9QOrIyKFNOcTQJrtKwSBpm
YxGJfooOIpimtobecw18B9UJJ4iMN7Sgs80vAeA2PXkrie0KxTwO6FAwyIlaZlUy
6DSEdsozJoV6TG0dP2pj3Lt6RAbEesvxBI3zYDqgnrKZNL8Etb0gzMS6U4k=
=3c3b
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Jason Wang (1):
      MAINTAINERS: update Jason Wang's email address

 .mailmap    | 3 ++-
 MAINTAINERS | 8 ++++----
 2 files changed, 6 insertions(+), 5 deletions(-)



