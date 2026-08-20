Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C7BC5DF86
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 20:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx8z7-0008Hb-Uz; Thu, 20 Aug 2026 16:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wx8z5-0008G6-Pg
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 16:03:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wx8z4-00051C-4z
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 16:03:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787256208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YDIhHsTOAS1WGPH1gHHRDCoovCMJME0O+VO1e5F4Eww=;
 b=Z7dBVUqUck6SePT0fHYFVOI0W1Cc5D1OgFKjMGlxnaDpyAJwtTs0BxAzUo3bGWF0eW+wcx
 JWWb935N/FndBa5tyVkgDiLo9t9e9j3PtG6p0H6VuGy3uZebFO7y12ps6pyFw59IEFySLC
 Vla3BKVZDrs203DU3qYUiqBAK8p+unc=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-AztGiMOROZyO9ks0t1Ibnw-1; Thu, 20 Aug 2026 16:03:26 -0400
X-MC-Unique: AztGiMOROZyO9ks0t1Ibnw-1
X-Mimecast-MFC-AGG-ID: AztGiMOROZyO9ks0t1Ibnw_1787256206
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-6b1000e2b5eso143621eaf.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 13:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787256206; x=1787861006; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YDIhHsTOAS1WGPH1gHHRDCoovCMJME0O+VO1e5F4Eww=;
 b=b9L4RJATG4+cRrYHcNhk5jQqKuklAHbhByeNRQv8kJkVrPsCVbUmcIqIQonxQyQveJ
 3cSsI7mkXRdSYy0S9QBcFPxk5ifQlSXgiaNtMCoMvX/w9lyi3S8t3WfYwi1EY/LrrH1X
 zo988ZSIfGpY2DDaO0/UesxuFR53vGQz/HcJY7GRQEQz4ti6G15H+Ipn1T7kzuJ3R12h
 fN0fvRWJX8RBdkT40hX18JPbV9O7HpkhlvgtKN/I+pvF10rraGFJ2RB0AH+qPKleZs+w
 f6c4jSBBTJDCG31BstGaWXwOqWFiTzaXLpR7JKNtJbRGQda+c+qH1PfYhuiDtQHG6S3u
 JKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787256206; x=1787861006;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YDIhHsTOAS1WGPH1gHHRDCoovCMJME0O+VO1e5F4Eww=;
 b=nHDwzazQZP4Gwpnehj8mNvsY1Bos8Xw6s7hZGiq1Er4V0VU6EtiO8L9imNnL1EU31o
 fvJiViLd0gZ/fzFAM+RDz8+gJGCz7viO5ulLph022Gap2LptX5x/6Ui+I4CA03Rg3Xzg
 C1ySswxq1kfxjg+pz5F7zVR8jGSts55wWvS0XckdrearKMr1rwG3ujmyLrWeCi0ZmfOF
 YV7wjTDtbuLLNDCw1EATvRojheuX5d4fJ9pjACRJkFJYFVqMDPeXA09+99Cn8wktoQYB
 yHfomSy7UdWFThWUvo753cq8vP9ekya3+0H/lVKWJyRNbPGeO9Ttv5DCXzBRNf17iv6l
 qGbQ==
X-Gm-Message-State: AOJu0Yy4veiRAZaUqcpovVWSwtx9Ttsu9SDscWocMeY91w/OoIOK0IpF
 89/O/dLetZPv6o6jgHRl9VB3Tt4c4fIPIrPxxg/YSs8q1rK9D0oyiIri1xB15uNsqtyrbTQVHCP
 wRuKCPk98Cn4E0ONHXV72v3aVHvbggf0bouUC1hkHrl9RyiPqWsFd2SAkKM+Syfe8iaSvhDlQuO
 HLAzENhTKZ/bc/hSkCufeMGcjD6Zvv7i/eUAi9Vw==
X-Gm-Gg: AR+sD13mjeR8SdxZZElRkx2vgiprpPXOP2gGMpfqt7TmcgcuiivgLNGofHTpQ+axhH9
 uEAYXbk5lSicew5rxNNAGvxwgNmoaZOINS3OK0O22K1CbtfZqMtjSR//fPGYyELfFQTKybXmty1
 FX6prL2Zmzj+pQRw31bZxCAT7nKRJ/jKSpxED+TeYijWoQQlKGikxV8XNWA0uUL9QCQBqT7r6Rk
 gcFPX9uAISR3VttgHr6HIenybSf4nMqSkx219sEt7EC2dCw1bmZhdhcM4oZ2yrTyPkd77cRnzka
 YrEvwGSwTybfSPu+3ikGshdcUSln8H8MdTw/ZodeiM8hNPoGh68Xpsw0kRvsYGlqaF0SKJasPFa
 Sxs2eqc9rJGlbXFuFZ4sb8HuwVZvEkSpDHmTMZ/FafDo3teufq2b6kh8hinc=
X-Received: by 2002:a05:6820:1c99:b0:6a1:8132:cb27 with SMTP id
 006d021491bc7-6b15ada3e0bmr398884eaf.9.1787256205821; 
 Thu, 20 Aug 2026 13:03:25 -0700 (PDT)
X-Received: by 2002:a05:6820:1c99:b0:6a1:8132:cb27 with SMTP id
 006d021491bc7-6b15ada3e0bmr398811eaf.9.1787256205265; 
 Thu, 20 Aug 2026 13:03:25 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b13cebeb2esm6181314eaf.10.2026.08.20.13.03.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 13:03:24 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jack Wang <jinpu.wang@ionos.com>, Peter Xu <peterx@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Samuel Zhang <guoqing.zhang@amd.com>,
 Yanfei Xu <yanfei.xu@bytedance.com>
Subject: [PATCH v2 00/10] migration/rdma: Fixes or drops
Date: Thu, 20 Aug 2026 16:03:12 -0400
Message-ID: <20260820200322.3321036-1-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
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

CI: https://gitlab.com/peterx/qemu/-/pipelines/2777122128

v2:
- Patch 2: remove two more unused trace points [Jinpu]
- Patch 4: drop unused RDMALocalBlocks.init [Jinpu]
- Patch 8: additional check for add overflow, fix off-by-one [Jinpu]

This series includes some RDMA changes, either to drop some dead code, or
to harden some checks for the incoming data stream, or both.

Please have a look, this should close all RDMA recent AI reports (none of
them are real security issues), thanks.

Peter Xu (10):
  migration/rdma: Introduce RDMA_CONTROL_NUM
  migration/rdma: Remove unregister code
  migration/rdma: Stick with rdma_ prefix for all tracepoints
  migration/rdma: Drop RDMALocalBlock.is_ram_block
  migration/rdma: Drop RDMALocalBlock.unregister_bitmap
  migration/rdma: Drop RDMARegister.key.chunk
  migration/rdma: Sanity check RDMA_CONTROL_REGISTER_REQUEST on buflen
  migration/rdma: Sanity check RDMA_CONTROL_REGISTER_REQUEST chunks
  migration/rdma: Sanity check upper bound of register MR address
  migration/rdma: Sanity check compress request ranges

 migration/rdma.c       | 349 +++++++++++++----------------------------
 migration/trace-events |  81 +++++-----
 2 files changed, 144 insertions(+), 286 deletions(-)

-- 
2.54.0


