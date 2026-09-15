Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B891EC88E77
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 17:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6WWy-00031J-21; Tue, 15 Sep 2026 13:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x6WWf-0002zE-EB
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:01:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x6WWd-0001iV-5X
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:00:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789491652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HcuIX0wwkBjz/hIwGTl0BPzRG7b+jWO3jhlPii25rdk=;
 b=QY4M98OPScmBsbhkBQf/esjRnYw+xjHSPD3WzhL+oiSe5b0tJl/GpjMRp4AQaKI0eiWYp+
 uYgag5vXEd96/0OKcpDyikVuAp+ik3bFW00gA0kx/MiDdBFDHk6isl+7IAZA2/D0OQPeF9
 yTg22kxVm7ZUg9w5h5XJIm5WNX7kZ5s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-iZhnf4EnOzuiJZ8hN-SBcQ-1; Tue, 15 Sep 2026 13:00:51 -0400
X-MC-Unique: iZhnf4EnOzuiJZ8hN-SBcQ-1
X-Mimecast-MFC-AGG-ID: iZhnf4EnOzuiJZ8hN-SBcQ_1789491650
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490a767c7dcso38261945e9.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 10:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789491650; x=1790096450; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HcuIX0wwkBjz/hIwGTl0BPzRG7b+jWO3jhlPii25rdk=;
 b=TAOvfR/fAihWjZxcAtuJrB7tI75Eem8lN8Pojx0ar3UKJd7AJc909iwTloYd23ncFF
 B+hquM+u+qJzs/lrmZyHWq/wUGonXZPaBG8IX9TcY1acGjxnWvvFCHxhI8qPcUhLl9mi
 YnZUqSuZep3ZEgRwQtA24oHiDCwML+4KgV5xjOwdbyg42LbEoyi9OK6bgev/SwfVENZ7
 jqgbhJiTs31kmufORuanq939gkEJd96Kvoz3s7lOf2PjAlYwiZgj1PjTodXnMbensWgM
 sBHeDtkYf6QAujIIGmE+uk3p9IDAaHT7P4UOC56VlW1adsNJ4jNWNumHRMO1M+I9ZqvN
 aR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789491650; x=1790096450;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HcuIX0wwkBjz/hIwGTl0BPzRG7b+jWO3jhlPii25rdk=;
 b=wi/HFeF6Sm/SA7HHPxO7PajyVPPUTgd8+wwIii8ofUeqQ3Xp0O6FsIIf117mg2l6us
 nWL9B5B1qtqnd2oPn/meoc9MLccKROWsxCXmK/KATpym7AAQgWuiSY+Z+OEU79+xBP2X
 HNSPceCdMBCOY0fgVj6j9Fu05RG8W9R50ggtp4HOQpSXVmGvWD+7y3BPGCITvmPifDS9
 JmTr6tstfi4xdoHMRv/0aWtCmbeUAHIBYRaXWTbmtWZhDn9GF7bOz4vhd7hgRvg+d5Uf
 ymMxyyFyk/QStvIeWDpcCktZ4eCRB5qYANNlZxekMvJLGJRl/inCTijQykIlKPNYgVv/
 eF9w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwxlG1U8RINrFcnfvabI5+Hvxacw0EWJRf0G+Et/zlukNSOxgfMVw/q80+NxA5b+UgQGOpmgcmkklXT@nongnu.org
X-Gm-Message-State: AFuF++n8i42FXkOoTkyf1LvE7KMS7E5rXUBk5Fa/zKsAF2BC6XgphVKj
 WElTmas+kCIjLXwNkquDTuOEFRJ6LUTVp0EiZIMUVP7D+S8kELNXYlbXoiWgn9uauDsFCV1jacL
 vUQ8wo8C238QZZD9BR53uzxfVP1c8V+HSQjZuRv7CZ6YzPvOL9sw6A4Pt
X-Gm-Gg: AYBFou35d+AwXf+nulaMF2shGB6oifYSkoWQt/DC3pbqFJzgHd//8NXMQbBjgCg4pZT
 NA7kQDOnaqsYJtWaMp5Wbfk4Jo5+UKFWO8arSwOu2ApaaTpfznd0I9ERNjdg+rQbptEXE4y7Ydp
 PXRKT/SBODJYGL+OoMiJ3EKvtpExZEebQwOfCXcskYveRM3QTN2FxxUmAmy1v7oQUr9NO2zE5Jp
 cYS7jctZstgMVAArbCNXncXvb+42MAtO8BKbrYGaapQoKe9smYKRGLnDy+v3SJWg8JWLS2GJGaH
 kBMzwervT8tyKKNjiJP0c7aoHRO1nR5oDf2VfXdWP6rIUlf1NuhwNRRD1u2PEpvjg6GIHMQtI/G
 14JvzYHKnzkT1ywHk6JHj2W8=
X-Received: by 2002:a05:600c:1991:b0:49c:fc6c:be00 with SMTP id
 5b1f17b1804b1-49e7a676bcamr95371385e9.23.1789491649933; 
 Tue, 15 Sep 2026 10:00:49 -0700 (PDT)
X-Received: by 2002:a05:600c:1991:b0:49c:fc6c:be00 with SMTP id
 5b1f17b1804b1-49e7a676bcamr95370845e9.23.1789491649458; 
 Tue, 15 Sep 2026 10:00:49 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e83fca34asm1031365e9.1.2026.09.15.10.00.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 10:00:49 -0700 (PDT)
Date: Tue, 15 Sep 2026 13:00:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?utf-8?B?0J3QuNC60L7Qu9Cw0Lkg0JfQvtGA0LjQvQ==?= <zorin@swemel.ru>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, stefanha@redhat.com,
 kwolf@redhat.com, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>
Subject: Re: PATCH] hw/s390x/s390-hypercall: fix potential NULL dereference
 in handle_virtio_ccw_notify
Message-ID: <20260915125413-mutt-send-email-mst@kernel.org>
References: <13ad0871-44dd-40eb-aad1-d08cc2d7dfe5@swemel.ru>
 <597e1a7a-8720-4356-91ed-a7c9fa416312@redhat.com>
 <1749cad8-1651-4543-8a2b-aad3c1168328@swemel.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1749cad8-1651-4543-8a2b-aad3c1168328@swemel.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Sep 15, 2026 at 07:42:31PM +0300, Николай Зорин wrote:
> This is the reaction of the (dynamic) static analyzer. We conducted research
> (at the request of the quality department) and found out that it could work. So
> we created a patch. If you're sure it will never happen, then, of course, skip
> it (and I'll have to work hard, because the quality department is digging into
> everything).

It's contributor's job to test the code before and after the fix and
explain, in the commit log, what the issue is, how to reproduce it, and
what is the behaviour after the fix.

Without this information, the maintainers can't make an informed opinion
e.g. on whether the backport the patches.
-- 
MST


