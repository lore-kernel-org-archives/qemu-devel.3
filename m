Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B6FCC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 08:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGuiI-0003ZV-4x; Wed, 14 Oct 2026 04:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xGuiE-0003ZB-E9
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:51:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xGuiC-0004yi-Tc
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791967907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UH1Ys0m0wlD3Q6XP55oYK9XVv60ktbLpC82FevmOX8M=;
 b=AyYt0/zexo+MS7RWFQE3SwdhRJpeXFT7uoJSRNjUp81phNJ6PREiUUC7J14/G8p3J9siwf
 aJS6QaliPuYc+m4egxsPWGLXB8i1pTSkLwL0yQEUei6m+9n+Fi82MAuuJMrUS+LDYyHIPq
 h2V481DjNY2Bs3btawZDTuiw3nrssko=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-r7SqFr3PND2oGMDu8w4IBQ-1; Wed, 14 Oct 2026 08:51:44 +0000
X-MC-Unique: r7SqFr3PND2oGMDu8w4IBQ-1
X-Mimecast-MFC-AGG-ID: r7SqFr3PND2oGMDu8w4IBQ_1791967903
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a170fa0879so30663565e9.3
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 01:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791967903; x=1792572703; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UH1Ys0m0wlD3Q6XP55oYK9XVv60ktbLpC82FevmOX8M=;
 b=dqJcIRNuE78gHVv/N9CiZSO1AkvxrIYaAU9/nHvO9i9Oal4p9u7429JoNP0Jsx+vGU
 nEb4kpz1wP5AyROmjs5amVilTETFsgz+XSj7YUcHl0ddA95G26yb8FF0hURh+kbasTVj
 vag5hv3i0dthoXKWQQf4m+HprIgDDzc52CQZ/yE1YZDsAmvFJDRT5bdO9k1T4mLcrvgf
 7O3OoH96SlYQB5IyY0hx7xXeisXyYSHocruiytoSVGf9lk5djY5Z7qBGghIUBiUBwanp
 EpVciVQqz9Lj8H7pkaQdWqU+mzH9jv+BBiIOY7/VKnzSAzQroKga/GBVs/vi2XzkKnM4
 sEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791967903; x=1792572703;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UH1Ys0m0wlD3Q6XP55oYK9XVv60ktbLpC82FevmOX8M=;
 b=lI49lJcJs1gWt+CsSsQz8txubUmAHkcVyTxsomGLgE4izAlkejF8w4DULZYKy/XXsx
 xkJuCZZBjMdDqxnqDUoxjo+E/JKuI6zNtndcxhpvYhr0FVxpDlBJ4XQH0jb+2iWhX3R0
 0bNry2oENJERYUoqe2p1xZwXH8stJW48xvY9qJ6E0xOnxzwIPxBFyXnSu4LGs9Qkmebh
 Qjqrcz/4YoNQS3gInRkLBup2Vnme8UE5A7yAfJ8I5ZxbaHhC7PVWic3zO+wC+3VgnSLX
 xE0Uu7F1TK4Isoi5xGf68NpcXY9mLlnP3ntadvAHd0u5B4Q2rDP2LjKSFxJHiqIY7xu+
 zM4Q==
X-Gm-Message-State: AFq9FYKZeMxNc696OyAgigTwhRm/4J4k4TIMl6qAkiGfIW/LH4Fv0oxi
 gdBTKUAyVVh385w1K/LJZRSIzdCEIYzKVnb6yjOjA9bs9JgrDYjIYbXk04zDABHUr1EoYAjfs4f
 C3hGLApSlYgIvMD/I1BiR2nDdTOWkYGU1Wq8nPPeKSGmP35G2Q283zie3
X-Gm-Gg: AYBFou2jQP225twp2GldWsAbooUDDI71F9x9mi0Wt2sqFy5hr9PQk0r7P5Yr1z1yGkG
 vd+Is60N9VwZWo29EzssSvoLJf6rEOyFvB17ET9ClkCf4eT9qA0AchDBM4xfq9moCHbNaCuC8HS
 GAp/R9ewVzw8wethr0K8aB860AoFbvl3cp3BToIgv+r0ADHfM5ffjx+ds/HVaX2ZRsHORiXv2Nx
 KS4LY0Bxon1J771qEbh9j6elSLp9FHMKCN+edQYlSZnHGXsuyxVt6ulC9x40CT1JrZGz36m0D2N
 Dd9XQqDWCdL4wBHeyGm8qjCrGcLr8VDd11/Tz6jQjosKONZXUKdUoUNqDATu8QqLTiESX4UyYFh
 EXX5grw==
X-Received: by 2002:a05:600c:3ba2:b0:4a1:acab:234c with SMTP id
 5b1f17b1804b1-4a1acab23acmr116446365e9.10.1791967903158; 
 Wed, 14 Oct 2026 01:51:43 -0700 (PDT)
X-Received: by 2002:a05:600c:3ba2:b0:4a1:acab:234c with SMTP id
 5b1f17b1804b1-4a1acab23acmr116445895e9.10.1791967902672; 
 Wed, 14 Oct 2026 01:51:42 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.168.237])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18beabbd0sm491252285e9.12.2026.10.14.01.51.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 01:51:41 -0700 (PDT)
Date: Wed, 14 Oct 2026 10:51:39 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 bchaney@akamai.com, mst@redhat.com, maciej.szmigiero@oracle.com, 
 mark.kanda@oracle.com, vsementsov@yandex-team.ru, clg@redhat.com,
 den@openvz.org, 
 dongli.zhang@oracle.com, farosas@suse.de, peterx@redhat.com,
 dwmw2@infradead.org, philmd@oss.qualcomm.com
Subject: Re: [PATCH v16 17/22] vhost: release ownership when the incoming
 migration fails
Message-ID: <as9CjWs5PbWddXgv@sgarzare-redhat>
References: <20261012-up-vsock-vhost-v5-v16-0-36c38bd15ffc@virtuozzo.com>
 <20261012-up-vsock-vhost-v5-v16-17-36c38bd15ffc@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261012-up-vsock-vhost-v5-v16-17-36c38bd15ffc@virtuozzo.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

On Mon, Oct 12, 2026 at 01:28:25PM +0300, Andrey Drobyshev wrote:
>A CPR target that has taken the device ownership in post_load() doesn't
>always reach vhost_dev_cleanup(): a subsequent load error, e.g. a
>truncated migration stream footer, makes QEMU exit() right away, and the
>ownership stays with the dead process.  The source still holds the FD,
>so the kernel never releases the device, and the source can't take it
>back after being resumed -> SET_OWNER fails with EBUSY.
>
>Releasing the ownership at exit isn't enough either: with the
>return-path capability the target reports the failure to the source
>before exiting, and the source resumes right away, racing with the
>target's exit for the ownership.  And with exit-on-error=false the
>target doesn't exit at all.
>
>Add a migration notifier to each vhost_dev, registered for its lifetime
>for the CPR modes, that releases the ownership if still held on
>MIG_EVENT_INCOMING_FAILED.  It runs before the failure is published in
>any way.
>
>Reported-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
> hw/virtio/vhost.c         | 23 +++++++++++++++++++++++
> include/hw/virtio/vhost.h |  6 ++++++
> 2 files changed, 29 insertions(+)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>


