Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3232DC531D0
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 05:33:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnV0W-00008W-Uj; Sat, 25 Jul 2026 01:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnV0P-00007B-HL
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 01:33:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnV0N-0008VA-GG
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 01:33:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784957578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t650BNQ4TcDAv5114g+Y9Qf6j6gJ5cCULhZu4PXheWY=;
 b=CKrMt0H+zv4XDA7+kjaZqh3SnzKzXPIejA0oC2SxnZi+dgaNCzulajjO1+jqN9JUGfmhw5
 i0oBauSQBt9DbSEGPFMxUrfmTPlf+ZSZmU+9fK+Q4cZGcsH4G/+aJYa9KXLr71f2XVrUrd
 0gMGKQFQ37pTosEGpHsl2Za/iP+Fm+c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-2GUB0__fMtK3yXHp6XTczg-1; Sat, 25 Jul 2026 01:32:56 -0400
X-MC-Unique: 2GUB0__fMtK3yXHp6XTczg-1
X-Mimecast-MFC-AGG-ID: 2GUB0__fMtK3yXHp6XTczg_1784957575
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-495529a93f9so9718055e9.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 22:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784957575; x=1785562375; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=t650BNQ4TcDAv5114g+Y9Qf6j6gJ5cCULhZu4PXheWY=;
 b=AR5KOoxk9mEN6WcpC6g1W4VFOtr+yDDruJLzFW1JBKXCplFVkWyNKAsPlzvwzS+BnT
 P19DGfXqHLkYLFD0aeMz2iHC5BnsUY8h9Wl51H34tuurp5ghQmjXrfFgJfWttmz+s9r3
 qCK50N6XZOo0G8rRULvQnfEcyPJNAcbQ04tkSnlDb477xcKI5wiHmcSwBhWyP5J/4sYd
 fUnbgNyZ49L1Wmek8LBG6dlBAug0aB/Pe1ZxCYD/n/9Kdif62rTLmEr2gwAC6QEpARjj
 gC31F495sh3jx81XkpxYRG8he5bJ7uk4VBrA2MHB6rY247CK7Q9+1v0xnOaIbvSzMY+g
 uHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784957575; x=1785562375;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=t650BNQ4TcDAv5114g+Y9Qf6j6gJ5cCULhZu4PXheWY=;
 b=ce3Z5AoenRU1ZjNNXLHj9C0efCHwGnoDgCmPT9nGPOk+hkQA0cfiM/CL475EZ3MeAR
 SphaRFHeAodGnjMseOiRl3S45nNItVI4d9k3GDFwNtfJXH9wTraUi8m28ywn6Jiaxp9+
 6eP55pVdHTZh90VMce+vBDnVqdoN1o7M9q/+q3IFsGhOBBpn2GJYSyQ5WrD75bsnYtgP
 yK676G/Xwif/1RdCmDkbCGW3zISs3TW27q1kkubylOMqAefK8bQljHk38emiY9bIchj8
 tsxCyQRbXoI69tDwjT45FPsQDztdL0cCveRbzF4pX7Kg4ppeo3Rkzt6sZRrsO6+0u3Ez
 rLBA==
X-Gm-Message-State: AOJu0Yy6X+hrpxE3mOUOOx73nimy4h8RqifOHSUVP9lt8LCsOo5A9j1J
 rmwdDXNGs7SfzXeJXW6iUISHo4LQARjOYGvOZE/IQn6TKF8Zknig0rYbfh1kePaPSe3lwmB4Dnk
 smTA+/S+3KMRr7PvF/kExQkyEO3UnIXjb97y8Xck4de3h6oz+Xw0FzShF
X-Gm-Gg: AR+sD118B4cfYsNaokSqgafuPfDwJG4GlqoKjC33VGdPUhYcDzioCc/Sd8yzp41pXhe
 EN6UHTkEC5Y003D9hfTG2VhpxR8oRTixLLJo/GvTsE+lFxBc1jr1AiuYMHCXUI1tQVGgXwgC+cl
 VzVoI7P6EyMDe+w7Gn5yzxb0PMnJuQxHNcojpRL7axfWjg5UZQaEy3yA/ctkH2DfJAGoCl12w5d
 JY3YsNkO0g3lrfJyLXIMMzlwLSMv+JBXAdAq+LQNqYaI8O98e0ctphxnl3HkV2WwO8HqXYHWQSQ
 GkLFpvPf+kRy2w7pLaqCdm+z4xnkg3s5usTH+T85CUJeG9E7wipkpSLjQGNxXSqVz6X+rCzUtPF
 LNwvR2yH3/JfNeVn7ey9Zzo2fWBl5hkY=
X-Received: by 2002:a05:600c:1991:b0:495:4bf3:2150 with SMTP id
 5b1f17b1804b1-496b6a232d1mr6244055e9.8.1784957574702; 
 Fri, 24 Jul 2026 22:32:54 -0700 (PDT)
X-Received: by 2002:a05:600c:1991:b0:495:4bf3:2150 with SMTP id
 5b1f17b1804b1-496b6a232d1mr6243835e9.8.1784957574247; 
 Fri, 24 Jul 2026 22:32:54 -0700 (PDT)
Received: from redhat.com (bzq-79-177-145-168.red.bezeqint.net.
 [79.177.145.168]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b4f33b73sm38681325e9.14.2026.07.24.22.32.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 22:32:53 -0700 (PDT)
Date: Sat, 25 Jul 2026 01:32:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowangio@gmail.com>,
 Milan Zamazal <mzamazal@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 zhenwei pi <zhenwei.pi@linux.dev>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, virtio-fs@lists.linux.dev,
 Jason Wang <jasowang@redhat.com>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 qemu-block@nongnu.org, Raphael Norwitz <rnorwitz@nvidia.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH v4 0/6] vhost-user-blk: fix compatibility with older qemu
 versions
Message-ID: <20260725011415-mutt-send-email-mst@kernel.org>
References: <20260702091023.3306378-1-dtalexundeer@yandex-team.ru>
 <d95a174d-83ec-4bc0-ac5f-46628262bd0a@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d95a174d-83ec-4bc0-ac5f-46628262bd0a@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
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

On Thu, Jul 16, 2026 at 12:30:33PM +0500, Alexandr Moshkov wrote:
> Ping :)


I don't know what to do with this one. IIUC in flight migration is in 11.0
so I doubt we can just introduce new messages without a protocol flag.

It says fix compatibility but really it's a feature, right?

And this is somehow related to GET_BASE?

Half the commits here have no or a single line of comment, those that
do, repeat what the commit does instead of explaining why.

That's not how it should be.

Here's a good template to use:

Currently .... This is a problem because ... We can not do .... because
... To address .... And then ....

HTH

-- 
MST


