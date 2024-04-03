Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFCFCD128A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 11:12:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rryWj-0007Rz-VU; Wed, 03 Apr 2024 07:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rryWY-0007RG-48
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 07:11:22 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rryWW-0007GL-Ni
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 07:11:21 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6e6bee809b8so5862883b3a.1
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 04:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1712142679; x=1712747479;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lzZZwAvDlZW0POG/57kWL/3/6EoUmB+Yu+cgaQmA+uE=;
 b=YqKF4LiuRG8ml/QyBqE1naJUD0+MJgn5e+q8Ltrmsavfl6w+ZyGSLcShxg7QnLVCBr
 QPq9ZrMr9FJ4EN05azthNoVEzcqonRVwHGNm97PWcAHoNkDal2wn27B7F7MRGWqPte/O
 3I/AZ1sO0MT2WeohqEBE/HtByXdV+mlTzttEJbNT1SxzPRLaRxuo+TqzwYSV0APTzwH4
 VOA544z0zjRB5AMAg+m/W6tByXy1zugklv6RsVdKzAcvX0Kl8hEVNxE/3af3g4Vyiek4
 wlzKx7FFk2jdAEfkaG4GsE8OZ3HUEjhpa5i+DwZDuKZAio5LtX8Wl3j5kwjnpa0/M7mY
 Reqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712142679; x=1712747479;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lzZZwAvDlZW0POG/57kWL/3/6EoUmB+Yu+cgaQmA+uE=;
 b=YI8xZUsbROSWFkMbcxAZEM+r3BKes8THneB4UZ2zaL5iSnPNN8QTB3ySRPqyhRp7ik
 ekERTmIrNKaM4uce3e+rjdb/gou/zbeMoPD0uaz8EJ8lHJ7mGQ4VYEOOb0kdpr5UBOZr
 BAELSjX8M9qrj44eDouKblCKcyM0/x0dnhcGD1dANQK3GP0T9dtRsIDS9Y83VQK28OgF
 VC5RzbdX4536S/Ei+63XWLZC4TQ+MmW2RMgZJUyDRhPqjERj4+y4VuErrwQpsaP+KtQa
 Nez+faJNq6RpsHHCwmwCcFA4kyR9n6kLXZP2S9koC1FyPsQVO/9kVDyOyIjG2DBffrvd
 e2RQ==
X-Gm-Message-State: AOJu0YzdofVe7wwTqEJEAb9CT7FH+0SNRkggXFdmFrqPzKD+08B0gPfG
 FN5Khn/w3GcATc2XHI/0RzLLH0+BL1wqG0QA4GekdM8/Bnhcc6F4Tho5tr5p4Do=
X-Google-Smtp-Source: AGHT+IGpBDjT/jpFbgnIrhkjgd8SEYDxES/T6HZEpsfpgs5ffuoEq1jZ0KN+VCiKZylCvp0tntLDoQ==
X-Received: by 2002:a05:6a20:1589:b0:1a3:15e8:7e93 with SMTP id
 h9-20020a056a20158900b001a315e87e93mr18807122pzj.56.1712142679486; 
 Wed, 03 Apr 2024 04:11:19 -0700 (PDT)
Received: from localhost ([157.82.200.213])
 by smtp.gmail.com with UTF8SMTPSA id
 k7-20020aa792c7000000b006eab9ef5d4esm11430442pfa.50.2024.04.03.04.11.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Apr 2024 04:11:19 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 03 Apr 2024 20:10:54 +0900
Subject: [PATCH v9 06/20] tap: Shrink zeroed virtio-net header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-rss-v9-6-c6d87e69d38b@daynix.com>
References: <20240403-rss-v9-0-c6d87e69d38b@daynix.com>
In-Reply-To: <20240403-rss-v9-0-c6d87e69d38b@daynix.com>
To: Jason Wang <jasowang@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev
Received-SPF: none client-ip=2607:f8b0:4864:20::42f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

tap prepends a zeroed virtio-net header when writing a packet to a
tap with virtio-net header enabled but not in use. This only happens
when s->host_vnet_hdr_len == sizeof(struct virtio_net_hdr).

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 net/tap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tap.c b/net/tap.c
index 9825518ff1f3..51f7aec39d9e 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -119,7 +119,7 @@ static ssize_t tap_receive_iov(NetClientState *nc, const struct iovec *iov,
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
     const struct iovec *iovp = iov;
     g_autofree struct iovec *iov_copy = NULL;
-    struct virtio_net_hdr_mrg_rxbuf hdr = { };
+    struct virtio_net_hdr hdr = { };
 
     if (s->host_vnet_hdr_len && !s->using_vnet_hdr) {
         iov_copy = g_new(struct iovec, iovcnt + 1);

-- 
2.44.0


