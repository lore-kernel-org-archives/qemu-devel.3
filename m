Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B91E4CA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:55:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBVTe-0001OB-Ei; Tue, 29 Sep 2026 06:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xBVTc-0001No-NR
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:54:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xBVTb-0006Nn-AF
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:54:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790679260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z9m+JmAKURpgcFBY4aCcQnzJ1ijy2IgSwFeivy6M4VA=;
 b=TlrRDpLoE1IM5vTMsnOzOQ7mefnk22W8byHXjmX3cFqICrOI7OUDrj7bgEmtbCCb/lpPzW
 DQtzg/v8n1VGoBgMwInXLNwYd19sGORDVsuQ31NDX4I5XWE7mSihSxY4ABcbB/909ufyDV
 C3dPyJGbmXQ1UsLUnA5EU/EZ16JF774=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-dPZCBjktOhGcQIHwuOXzvQ-1; Tue, 29 Sep 2026 06:54:19 -0400
X-MC-Unique: dPZCBjktOhGcQIHwuOXzvQ-1
X-Mimecast-MFC-AGG-ID: dPZCBjktOhGcQIHwuOXzvQ_1790679258
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4887f71b1baso3360920f8f.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 03:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790679258; x=1791284058; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z9m+JmAKURpgcFBY4aCcQnzJ1ijy2IgSwFeivy6M4VA=;
 b=LUD11tVOJYrEQhaM6MILr0Ohv2KlbqxZlXKEyk93M4PAKq83P+1Skm03IMVjHhT6WP
 yAIp8HItoIeM53zSXhBadEaUsJZaO+zGcVSgjvPX0KYZGLCLQwu3zKo09Js3eBQjRMHI
 tUxQbnMsHX5D8Vj+blu9zj/Pk9DhqN2fEpXFUXORd7k1OX7Pl2a6BzQ2FLV+hhjx6pad
 AZMcuMk1FPfkDBIdNy5N4weilrB6k/53sVtHzR4OshC+SU4OY7Hac2geSSPHr7AsnK/Z
 Oj+1L8UvRawk3iOD0eeyKGXiIyeFUHRjNdlE+J/RbXIud+oVCZchzXDiAKJEE74oL+z7
 q7wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790679258; x=1791284058;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Z9m+JmAKURpgcFBY4aCcQnzJ1ijy2IgSwFeivy6M4VA=;
 b=FOIoSKKWONs/gbQyNN1DvtyVzmdt6LHEdWnBK4xwxWJQGwWvDNOdoBb0AP+YJRHg7L
 zzpc6/+YiTFpphOLCupnDLAl7jCdMlBc/VG71mEcIX2TtvESRX3e+yAOpy/Qivbqi7Y/
 lq7qv3RoHBjNqRT4GdgqQC8ekSYme8Hn79uQChW2dkKkoF/uSFhs7plLpF7kSiM1qoLu
 8Rp6MOgtLRqR/nEpyJCMUds039hJCNwMNB/Tg7JoIVsWXml8SuxK0wL+Od6xW1cu1JPN
 OKYwY92qUmXb167/4wU6haet8+C2eT8Bwyo0p5DIBUKmlJTQ38ITzvq74Rgp8NUhm2kn
 uskA==
X-Gm-Message-State: AFq9FYLBPovyywgKdqH/g73zSPkzlOfYFvUpwN3EkeWOAiOGZPcxgo6z
 DXp9vVxesm0TQqmYuA2uxuYjtV0nvx3aa7elHWn5PpZWXedF4X6eoSKprDyOBhrL7DzNFW0Y94w
 QFoZiV3B7MzEjHqen0qOmWJeUsMj+r7TtiY826MdSEfXyRR5FbWXjrmOk
X-Gm-Gg: AYBFou25ZgZYfYDVPDQnX5Ls3mWNZ22YLwUmsE1xgy633LPqZuUPB4/qHuJIRUEQQS/
 xZbUMsepeOjj6S4ANPYwkvvItWV1UMhZtGJhkO39W83ynRBS+CCZEAk932oqREnkyJUA2dCB1yA
 8vDv+oXNmX5nzaUk4mJaKmQDQFmlXByT4Y0WKvCngcPZoWmU7IRb6Tm/KGHXEaDOA2MMAc556nX
 nWqcF5ac5sweTFFD37ysP/eCdBfCN4kSq4rPbA75w/fgBnOuLbPNmupUufedSDWZGl1314O/tdh
 yAJ5QjTyWUKgdgDdeNdq6gtxle6SsOnBoCginkQGmZtNnLwGuJ+2FGx1NgdzGAEHbY1kMyOcZus
 =
X-Received: by 2002:a05:6000:4201:b0:488:8411:1d08 with SMTP id
 ffacd0b85a97d-48884111e4bmr19916030f8f.48.1790679258011; 
 Tue, 29 Sep 2026 03:54:18 -0700 (PDT)
X-Received: by 2002:a05:6000:4201:b0:488:8411:1d08 with SMTP id
 ffacd0b85a97d-48884111e4bmr19916003f8f.48.1790679257590; 
 Tue, 29 Sep 2026 03:54:17 -0700 (PDT)
Received: from sgarzare-redhat ([94.32.54.7]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af50513c7sm3187760f8f.16.2026.09.29.03.54.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 03:54:16 -0700 (PDT)
Date: Tue, 29 Sep 2026 12:54:10 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?Q?Cl=C3=A9ment?= Chigot <chigot@adacore.com>,
 "yc-core @ yandex-team . ru" <yc-core@yandex-team.ru>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost-user: add missing stub for
 vhost_user_has_protocol_feature()
Message-ID: <aruTFz6mgOJpcQAi@sgarzare-redhat>
References: <20260929101623.1352299-1-dtalexundeer@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260929101623.1352299-1-dtalexundeer@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

On Tue, Sep 29, 2026 at 03:16:23PM +0500, Alexandr Moshkov wrote:
>Currently, building with --disable-vhost-user fails to link when other
>vhost backends are enabled: vhost.c calls vhost_user_has_protocol_feature(),
>but its implementation is not built.
>
>Add a stub returning false to fix the link error.
>

Should we add Clément's tag?

Reported-by: Clément Chigot <chigot@adacore.com>


Fixes tag?

Fixes: 5eb2347867 ("vhost-user: add skip_drain param to do_vhost_virtqueue_stop")


Is this one, right?

Looking better at that commit, can we avoid to call 
vhost_user_has_protocol_feature() at all in do_vhost_virtqueue_stop() 
and put an assert in vhost_user_get_vring_base_skip_drain() to check 
that the feature is negotiated?

That said, not sure if it should be an assert TBH.

Thanks,
Stefano


>Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
>---
> hw/virtio/vhost-user-stub.c | 5 +++++
> 1 file changed, 5 insertions(+)
>
>diff --git a/hw/virtio/vhost-user-stub.c b/hw/virtio/vhost-user-stub.c
>index 45559788dd..9d2e521788 100644
>--- a/hw/virtio/vhost-user-stub.c
>+++ b/hw/virtio/vhost-user-stub.c
>@@ -4,3 +4,8 @@
> void vhost_user_qmp_status(struct vhost_dev *dev, VirtioStatus *status)
> {
> }
>+
>+bool vhost_user_has_protocol_feature(struct vhost_dev *dev, uint64_t feature)
>+{
>+    return false;
>+}
>-- 
>2.34.1
>


