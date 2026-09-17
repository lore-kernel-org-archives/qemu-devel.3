Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A00C982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 09:02:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x77zw-0007wI-O5; Thu, 17 Sep 2026 05:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x77zv-0007w5-81
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 05:01:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x77zs-0006BK-IY
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 05:01:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789635695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BcdtQF5w7blEm1D42T5aJgM+qsLmhsvhsibx1JVRmbY=;
 b=dn3OkXAUC82u5gyNIFFfCoyWv1IGxq4ZTJxd+0HN14Vy+Ztlz9CSi4OvT9fFecsSPnOLTs
 LCEyHjdalkZDgo4VqnjPQTVZimm3JTF5v6U7arYkrYU+ROx6jGByKiy2q2onj9aVlHrVI4
 bKj6xHTIzTr2SLVO1YpsF3W5uabLZ4Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-xoVj1KiPNmmCBSoUEGUvtA-1; Thu, 17 Sep 2026 05:01:33 -0400
X-MC-Unique: xoVj1KiPNmmCBSoUEGUvtA-1
X-Mimecast-MFC-AGG-ID: xoVj1KiPNmmCBSoUEGUvtA_1789635692
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48589603501so365855f8f.3
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 02:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789635692; x=1790240492; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BcdtQF5w7blEm1D42T5aJgM+qsLmhsvhsibx1JVRmbY=;
 b=MiZFQJ5IU1jLtGAr3GfCPbSJlk/fge+jdavnSNOQk/BBM4Gt3zDWZuR1MFus6zdjoA
 KIwvVPlp1wvcAwRHweZ4UTMnke9xiL/q2MJb/VlCxARmi6rH86WCLT2BDMsERhxrV2Vi
 trfyIfZmTp1xVOK/gqYLSXdytA6klFzXSD5oRzvjHzjk7ErhMUPODjmpE0bAdCQVx+Bx
 YunZ+gKHztPqKGNg7Fv2ViiKVmOXEq6gL6glcgy42db71qMX6oiv+bCzMq4jF1DlKbUg
 8vVSCu6LDZjBx6wQkR3Bube8rBjlSNNnp74QDV984bhGDKtJLvJUsH+Xm/Tsm2zoyMx2
 p0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789635692; x=1790240492;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BcdtQF5w7blEm1D42T5aJgM+qsLmhsvhsibx1JVRmbY=;
 b=aVGS2vIOE/GZ401kSdL9A1EDFlC7mmMi9Sz/N4r0WiP3panwDRT1O1auAE8w56gOup
 Bi5mRsZ+SQT0ohtIUhjT4UKWmjeuhBgbc/q58gwB5JvbV+9lZi3kHpdYV7ErI/2KAXjl
 0W0+rHggjTjmogpCn4wq5fOLbgPGY0G2jTvmGWIxeHQrK65tjsNZY8IHSTo25bLDxe0O
 J+zQGKecQnm16yPOAXjbFKS9NQBvPRf1dGgLXKQfWd2/LWAhwqweyl2m7cTj2OjGxq3l
 wywX+S+uFKygrLmm54aRDdhCefMvbKrKF9u1E4pxbnbhlhLLt9srP4lLGOOi7rWsH60Q
 00uQ==
X-Gm-Message-State: AFuF++ns0fAEGF2Q5pZ9Lu0uEMhwDuLY3CI9Hm/C84mKpSU0JCz1y1hh
 RoWIvraRLQEO+rIgfCHF2OHzKR8qUKU1Az+D2XPhhzvNjp4Oyb/ERCHoyExmd+gkjH1QH1Fs5qL
 LzC/m+rMh3U4ceezWcTXfg/WwZJEFR1p4C9kHjkwk3xpqCy5gWokaJ0mi
X-Gm-Gg: AYBFou3rr0Bd5EL21KImuz7hvjJhTnXZaIRc2RuisGmpL4eLUGMfoHZFwTMYn8xsB5i
 CYVJgWzjbjYov3NZjLD24ITTgH0m7m4BaFOKBgKIYayNQV5Z61pJvut90kqyblL56c0yZoDVLM9
 6edeLi5ZyPtDycr8wjsmn1VPaRWB6a9+vq2kwWzCkrNd/gdkcRNa0Wjsb/eT0X/+SwS3yOuHDbI
 K/0UhKXhz/D5gobMbfndPRlkYjfu3ZEPLv6qNWhUyfJ4WgpeDs/EicWypl6GbTjMVqMyAuR5yT6
 JYkx208SZDTyayfI9WzeZkTTn7NoaUTYdPIXBya+JPUBY1AkjYowRR2W7SXIli8cN/Fw3yTv6iG
 ul39Y3kHd4dmGd07QOzWIb9JiNwtLo1eqkiKCJOAgB51+rQ==
X-Received: by 2002:a05:6000:2588:b0:486:e81b:842a with SMTP id
 ffacd0b85a97d-4870d27e321mr6743874f8f.48.1789635692006; 
 Thu, 17 Sep 2026 02:01:32 -0700 (PDT)
X-Received: by 2002:a05:6000:2588:b0:486:e81b:842a with SMTP id
 ffacd0b85a97d-4870d27e321mr6743809f8f.48.1789635691480; 
 Thu, 17 Sep 2026 02:01:31 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it.
 [79.53.30.11]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf27df9sm14010475f8f.19.2026.09.17.02.01.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 02:01:30 -0700 (PDT)
Date: Thu, 17 Sep 2026 11:01:24 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Omer Can Vural <can.omer.5306@outlook.com>
Subject: Re: [PATCH v2] libvhost-user: protect against OOB memory table access
Message-ID: <aquqUSJpZqu4UiLz@sgarzare-redhat>
References: <8adc88f2f535ab0566a5df1c66db728112dd6f74.1789469161.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <8adc88f2f535ab0566a5df1c66db728112dd6f74.1789469161.git.mst@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Sep 15, 2026 at 06:46:17AM -0400, Michael S. Tsirkin wrote:
>SET_MEM_TABLE handler uses nregions from the message as a loop
>bound without checking that it is below VHOST_MEMORY_BASELINE_NREGIONS,
>so a malformed message causes an out-of-bounds access to the
>regions[] and fds[] arrays.
>
>Frontend is trusted so not a security problem, but
>an OOB access is not a nice way to handle errors.
>Check, and panic.
>
>Fixes: 7b2e5c65f4 ("contrib: add libvhost-user")
>Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4403
>Cc: Stefano Garzarella <sgarzare@redhat.com>
>Reported-by: Omer Can Vural <can.omer.5306@outlook.com>
>Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>---
> subprojects/libvhost-user/libvhost-user.c | 7 +++++++
> 1 file changed, 7 insertions(+)
>
>diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
>index 2fed792e85..52817cc733 100644
>--- a/subprojects/libvhost-user/libvhost-user.c
>+++ b/subprojects/libvhost-user/libvhost-user.c
>@@ -1105,6 +1105,13 @@ vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg)
>     vu_remove_all_mem_regs(dev);
>
>     DPRINT("Nregions: %u\n", memory->nregions);
>+
>+    if (memory->nregions > VHOST_MEMORY_BASELINE_NREGIONS) {

Should we also check that it's equal to the number of file descriptors?

Maybe `memory->nregions != (uint32_t)vmsg->fd_num` is
enough for both checks, since IIUC we already assert that
vmsg->fd_numvmsg->fd_num <= VHOST_MEMORY_BASELINE_NREGIONS

Thanks,
Stefano

>+        vu_panic(dev, "Invalid set_mem_table nregions: %u > %u",
>+                 memory->nregions, VHOST_MEMORY_BASELINE_NREGIONS);
>+        return false;
>+    }
>+
>     for (i = 0; i < memory->nregions; i++) {
>         _vu_add_mem_reg(dev, &memory->regions[i], vmsg->fds[i]);
>         close(vmsg->fds[i]);
>-- 
>MST
>


