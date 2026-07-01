Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E035FC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wettd-00067n-O3; Wed, 01 Jul 2026 08:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiri@resnulli.us>) id 1wettb-00067T-BQ
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 08:18:27 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jiri@resnulli.us>) id 1wettY-0005Dt-Ug
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 08:18:27 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-473ba028d46so567163f8f.1
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 05:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1782908302; x=1783513102;
 darn=nongnu.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VDQp6t8niIEysPmOVq236y+Fsxq9FvxfUesp7S7IOPc=;
 b=yCL1L8qOgdQwnd4aKuGVSjbu82Abm2taTuzty+IO74I44+Xe/Cr2tfo7sFFyB+cGsJ
 Pzfhi5Fn24XIhU88RHnN5Pm7L5VmoTrSDUZl7LIco9tfvBp8A2IiqkGX1ZANyJJEKZ3Y
 bqKD3lm5nJJTFyyTJWzfVhlaeyageN6M4ViH49N8+w2nfKrQpAEPFHZobXhGKZLMRQql
 n2uH3D2exZv8LTAal6hw8QnoKFlALek1YaILPCc9REMME70SJVClsglj+0XCkL020r9W
 AAODVhWGIjpLsMmmzGnwlxibblHdWcTkKOrBdjcgplAn9lQO4piRnAIpmHSI6N4/tC7r
 1wyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782908302; x=1783513102;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VDQp6t8niIEysPmOVq236y+Fsxq9FvxfUesp7S7IOPc=;
 b=TVD7eju8RXGQvSdSNIHTxpVPPn4Wu3Dhm/xBq0IIesAjB35PkIl3Qn0Vua9dYrifrJ
 VV/0IBi3H7iwC9OKrNVTeg1QdXdDEEoj+Crs5qg3qbJfBnE2o3s6EV4svxG6SQ9gYhQ6
 26J6gS5AFIsXacDe7DjaD+Y/38lG7lfsuPhXyFvQ35wZBW2NVZ6sMovhQ5YbRn9Og4uB
 eHheY8Mxrxih+CODo5DgyUWV1F2dAkpOMZoS9N4jsg2pnrSXEzCE2v2kjxR21Kko1xmx
 mLG6E8y1xdFKE8z/+wH/psF4hYxzlAgGCe3qap1zRUpGZ1ksT6ld0tN1yk3zz+n1wIZu
 VTbw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrJFPmxj5hQut7y7edVtyAgybhRh4WWoO0RmbENvvL6culeq6ZaGUAawx+ABDvJIzrkn9byl0tddq9o@nongnu.org
X-Gm-Message-State: AOJu0YyTsMcQbDMh4bXTTOhk5Bbj0Pa+DJZSTC/Za6o75vkDssLg5OaI
 RlIbA3QcJ1PPFxMPoJ01h7hlcP3qOTi8hco8LlEMTkzvJ6vguJlQs92WZiOyuEzUxWI=
X-Gm-Gg: AfdE7ck+zc+xIvPZFs7yfOd+uuQG3Z4EGirY3At5vRFQ4DzkOIf9vcANwsrQVe50gmN
 azLRjMVWdLXmhO3C7ARLaVClqqgHWglRk2rOqBxQ5kt9lGpFlWtnOT1AawgJDzZVXU67BYUgwPo
 LsO/0GGZ3Ye+8iBVagdALY9R3vn2Dr0IO841DNqFGYB3mDnbbS15HQkV26Xh1O3d7vR3UVYkM8d
 7Opb0EdThWqW0oW3eBB+sioK1VNqsqYf+u6E4GyretfV6km6hDV9769jgY3FwyXyaHd10L37JLZ
 0dsKXf6ylHKdyarqZtooZIXQa81FdsffDiHCR6u6U/NaHGzUWISUALUUixQ/HcofFH8Gu/Y9bsZ
 xwogqNVhhohpgrSTMArynRw93EpT6a1o+7uzcrjdxeAPRcvmeOcZEKHmOzdeJp3nOyJ1A5zE+ny
 Q3D4gZtOUJyUVgN47CKa3aUw==
X-Received: by 2002:a05:6000:2dc4:b0:46e:f162:64a8 with SMTP id
 ffacd0b85a97d-47758cbef97mr2379741f8f.23.1782908301567; 
 Wed, 01 Jul 2026 05:18:21 -0700 (PDT)
Received: from localhost ([140.209.217.212]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47563d19573sm15836638f8f.4.2026.07.01.05.18.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 05:18:21 -0700 (PDT)
Date: Wed, 1 Jul 2026 14:18:17 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Xiong Weimin <15927021679@163.com>
Cc: Serapheim Dimitropoulos <serapheimd@gmail.com>, stefanha@redhat.com, 
 qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com,
 sgarzarella@redhat.com, Xie <xieyongji@bytedance.com>
Subject: Re: [RFC DISCUSSION] virtio-rdma: RDMA device emulation for QEMU
Message-ID: <akUFOeFkqtRVyHuX@FV6GYCPJ69>
References: <20260316210600.62415-1-serapheimd@gmail.com>
 <CAJSP0QX3JtwhXDTnEgS-heLYYncjJtttg1KmFqG-+_VUXbH+Ww@mail.gmail.com>
 <20260320172345.4688-1-serapheimd@gmail.com>
 <1747673b.8c8c.19efe3cc66f.Coremail.15927021679@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1747673b.8c8c.19efe3cc66f.Coremail.15927021679@163.com>
Received-SPF: none client-ip=2a00:1450:4864:20::42a;
 envelope-from=jiri@resnulli.us; helo=mail-wr1-x42a.google.com
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

Thu, Jun 25, 2026 at 12:04:16PM +0200, 15927021679@163.com wrote:


[...]


>= What is working today =
>
>
>We now have an end-to-end stack:
>
>
>  guest: linux drivers/infiniband/hw/virtio/
>  userspace: rdma-core virtio provider
>  VMM: QEMU vhost-user-rdma device


Can you share links to public git repos for these? And what about
virtio spec?

