Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 820CDC25B4F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 19:01:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s43a7-0006t1-Rv; Mon, 06 May 2024 15:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1s43Zd-0006bx-Sm
 for qemu-devel@nongnu.org; Mon, 06 May 2024 15:00:40 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1s43ZY-0005Pe-5p
 for qemu-devel@nongnu.org; Mon, 06 May 2024 15:00:27 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2ac9b225a91so1621673a91.2
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 12:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715022017; x=1715626817; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nx55YKW7SO1z394BS1S+XUqrjENESfE/9CViqjcHFPg=;
 b=YCXMewtiX1jS/ZJHkzlW2/JFNgXwOi6j3HjTvzLGSMJs4B9aD3mes+rSFSlkNeBnwY
 dSbATTvNSGtwxpAqSlH8E2kBSqiy4aVYA3JxoSuOIEQacjdBrDcyT+H3YWzmshciw9vw
 98b05zuCZ6kiekPgRc5W6poUdCrduqzXS0sbBPar+xvG7o6JdGga+hr21XEFv9lxp2s2
 4Ytc5eSNJuDZdsYwqyolsy6MH+1fFaozxlkEWZeINf8nJwHT2P8r6Z2FzAT+H5V8Cn3l
 MWQEG3bX8dQxDMTDPzYwVpvzIhxJo4/hoMdYhuzFBmsOVLa0bD5t0zHW8nW9Yby/3Mj+
 Gq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715022017; x=1715626817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nx55YKW7SO1z394BS1S+XUqrjENESfE/9CViqjcHFPg=;
 b=HOxHxADS4NXavouzMnxH0qye5l2HNkDMqxt7pNKw8HCsW/A3W+naOdr+k1Xh14lkNh
 Trch5VDLsQpubHkn12gYmVFhRr9ACJygGoe9FFAGkT2A2l/iuH9X6+HPsJoLdOJcFxSP
 i47aAi+S9fmO6gGKIhWsnKA+xk2eDI+4wcZMvrcc6UY7/GjV/WAhWHj2+DBSnYs2ar87
 aZOvHB6jgF7P7AavrQyKWv53YA3Tdl/ctSb3UKT72fffAiwWjdVzgdtxVTaFIUO4uGba
 lLZHbopPDr04Xh1P5MxHpPwX2VYgMre59HW7FtNpA1cedxsMtFq8zmZROaIg7qer4yOU
 t9kg==
X-Gm-Message-State: AOJu0YyWeArnBuyXExycAxg+CBOMK+vwS6uuAYVvrzPMbOk3iKFhh6id
 N0As9OnigTrmS7sTx0kBDfiit0dWZGtyS/zOFeGq7O67XId9cZgM
X-Google-Smtp-Source: AGHT+IH+jUTBZW6DlwgKWxxcMpFxSZLuAmEo3wSE7tnZk5YIEYGJL/y1hGujRESa/lUBLtPP/SFGQA==
X-Received: by 2002:a17:90b:230e:b0:2b1:a632:60f6 with SMTP id
 mt14-20020a17090b230e00b002b1a63260f6mr8736911pjb.44.1715022016346; 
 Mon, 06 May 2024 12:00:16 -0700 (PDT)
Received: from valdaarhun.localnet ([223.233.87.247])
 by smtp.gmail.com with ESMTPSA id
 sv12-20020a17090b538c00b002b1979d3af9sm7425460pjb.0.2024.05.06.12.00.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 12:00:15 -0700 (PDT)
From: Sahil <icegambit91@gmail.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-level <qemu-devel@nongnu.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: Intention to work on GSoC project
Date: Tue, 07 May 2024 00:30:12 +0530
Message-ID: <13514535.uLZWGnKmhe@valdaarhun>
In-Reply-To: <4912056.31r3eYUQgx@valdaarhun>
References: <13625712.uLZWGnKmhe@valdaarhun>
 <CAJaqyWdD7futYvUFt7=zV1xsoBdyAET6mvneOOjR2oob2U1-qg@mail.gmail.com>
 <4912056.31r3eYUQgx@valdaarhun>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=icegambit91@gmail.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

It's been a while since I last gave an update. Sorry about that. I am ready
to get my hands dirty and start with the implementation.

I have gone through the source of linux's drivers/virtio/virtio_ring.c [1], and
QEMU's hw/virtio/virtio.c [2] and hw/virtio/vhost-shadow-virtqueue.c [3].

Before actually starting I would like to make sure I am on the right track. In
vhost-shadow-virtqueue.c, there's a function "vhost_svq_add" which in turn
calls "vhost_svq_add_split".

Shall I start by implementing a mechanism to check if the feature bit
"VIRTIO_F_RING_PACKED" is set (using "virtio_vdev_has_feature")? And
if it's supported, "vhost_svq_add" should call "vhost_svq_add_packed".
Following this, I can then start implementing "vhost_svq_add_packed"
and progress from there.

What are your thoughts on this?

Thanks,
Sahil

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/virtio/virtio.c
[2] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/virtio.c
[3] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/vhost-shadow-virtqueue.c



