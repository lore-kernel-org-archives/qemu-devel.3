Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A790BCD6E64
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 09:04:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUhVg-0001UI-8s; Wed, 03 Jun 2026 05:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wUhVe-0001U4-PT
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 05:03:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wUhVd-0005QA-8l
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 05:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780477411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cSie2qWTr6EJsqNxweSQ9tti5cQY+Q8+DjGHW5Y8U+o=;
 b=bZE64ZwjyQsSHmxY6XefpsHfvQNjh5MWJLfZ/rb5v6TI+Fb2hr0/hpYxvFH4rn1Bpl/Fku
 BNDoDFgla4HQH13RgFz+wU1Gol/p/MwDFEQzXHo6cs5jhaJQWHaJq9gOxoWemWw511rAWb
 jyTH6lmfGvJh2Zm8m45UQCXazSyyT/s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-Nq7f-FqDNLqOnn3F1IyN_Q-1; Wed, 03 Jun 2026 05:03:30 -0400
X-MC-Unique: Nq7f-FqDNLqOnn3F1IyN_Q-1
X-Mimecast-MFC-AGG-ID: Nq7f-FqDNLqOnn3F1IyN_Q_1780477409
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490b37e1f47so12817355e9.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 02:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780477409; x=1781082209; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cSie2qWTr6EJsqNxweSQ9tti5cQY+Q8+DjGHW5Y8U+o=;
 b=nrt+WRAkEYBMm6KQzCM9z6FrxltptP5QJMKvSRw+04VJ2ipbZPlvRnds02A3NZJRmB
 Imgp+94r0aBvX4/RAA3kT49WCTIpGMYMCPpd7yWv1FeEQxNMFqhPT31uMlMdl7PnwNXY
 O8ksbSvJZ4DKE/1j6Ivkk9TOO1b9QbMDsBMH5Z0CE57NZzFWsDbNT4fUlx3OpQINct8E
 vZE5kiUiCTGjjdv/6oBVAKTZdtcMVUmRaBve8bOWC5fLSSJ552Y80zjn22ExLpx9Tzb/
 ac+pHP5DDK1mYs3L6laSBiI1d1AlZtXNscI4x3WrPS7gf24vHPBpaSkHnO9nR7MJeHTN
 oFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780477409; x=1781082209;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cSie2qWTr6EJsqNxweSQ9tti5cQY+Q8+DjGHW5Y8U+o=;
 b=B7lCgISq5TUvtKzicjt+fykze/DqyiTAsgrXyf/GV7Z2m0VfE2btSMYTTPs9jrf31p
 A+jaOTse1xlmFC2LQ7KmQqSo9BKUWw1ip2C0SFLEyWS2mNIydymeBLcqQ07aw291iEtP
 PUdgDHMrGWKtpkjTOMVIjDRU3IRIFsRkMI+xqnd1JD2s/wPf0iFK/MvE/RGUX7iEq2gc
 PD/zx8EJKb/12Y5CXZnvSk2Xd+uj6Zw96MNNiLftn66pcdtPRjjk31guKdIimeCRyTjC
 hZug0P8OdQ0yaUFav0PQRLy+wkk2PkkJ1uLUMlB8s4qJOnN7EU/IlcXd3SB5gGyT3Nez
 S3kg==
X-Gm-Message-State: AOJu0YzPqBnj4U19k7S55P9qEbph2J5PtHognQu6OKaEZYBqs63FGCAJ
 fueYgXw1Jr2hMq2YGZsW4s+c9anPN13uRoTkpAhFhvavD2rugu1XZqO98dhVXv4+yQLBrZ1f9OW
 7Nq+OmOuKTyRkSvM/nPG9kO0q8C1mhtnQssmHSJ67Dg61mKaTNmgOPk5M
X-Gm-Gg: Acq92OFMp2KkS0VRui+zZ8UeIb9ypK/ip16VxGArT+rpdbyYsjJ0tmKAiACr9w/USjr
 OlykGhc8nf0/AQMrCp4ZiYqPbAxtdZCmatgjrGJOmoE987ip8fRXzrfeHhA8G5qLRdmbEP1PG+Q
 fj8FwITlFxB92YRLt2pFKrBOETBtNuZriR1QljtDwDp4Gfebms/GUvxwQPJUbtAPYV31WikE+UH
 EI7YlAVSNpLGL4QHKdPwpmLUWna0dEHNzoKzGoD9wdv7wixQOu+yNTxldOgdPvIXJKDHUh/eCVK
 10AtD1+D09xTywcGFq04oN6Jj4yMhq63CMQ085GTIQFvMRhvC+q+AwqcDJcs8KzvH6gVtfj1snr
 6nPMfPLP/6uRl+Abzey8dVn+D1g4zKnC+ht27Ww==
X-Received: by 2002:a05:600c:4fcc:b0:48a:8b02:ae91 with SMTP id
 5b1f17b1804b1-490b5eaab2dmr41268395e9.11.1780477408849; 
 Wed, 03 Jun 2026 02:03:28 -0700 (PDT)
X-Received: by 2002:a05:600c:4fcc:b0:48a:8b02:ae91 with SMTP id
 5b1f17b1804b1-490b5eaab2dmr41267455e9.11.1780477408293; 
 Wed, 03 Jun 2026 02:03:28 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.118.98])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490b615fb2bsm45834035e9.5.2026.06.03.02.03.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 02:03:27 -0700 (PDT)
Date: Wed, 3 Jun 2026 11:03:18 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 hreitz@redhat.com, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 gmaglione@redhat.com
Subject: Re: [PATCH v2 2/3] libvhost-user: look for available vq buffers upon
 SET_VRING_KICK
Message-ID: <ah_rtghBvzQgN8fy@sgarzare-redhat>
References: <20260519191548.335082-1-stefanha@redhat.com>
 <20260519191548.335082-3-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260519191548.335082-3-stefanha@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, May 19, 2026 at 03:15:47PM -0400, Stefan Hajnoczi wrote:
>When a vring is started the back-end must look for available vq buffers
>and process them. This scenario can happen if the back-end is stopped
>with unprocessed available buffers and then started again.
>
>The inflight I/O tracking code already did this, but it should also be
>done when inflight I/O tracking is not enabled. Move the code.
>
>Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>---
> subprojects/libvhost-user/libvhost-user.c | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)
>
>diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
>index 9c630c2170..2e286ea6d9 100644
>--- a/subprojects/libvhost-user/libvhost-user.c
>+++ b/subprojects/libvhost-user/libvhost-user.c
>@@ -1390,11 +1390,6 @@ vu_check_queue_inflights(VuDev *dev, VuVirtq *vq)
>         vq->counter = vq->resubmit_list[0].counter + 1;
>     }
>
>-    /* in case of I/O hang after reconnecting */
>-    if (eventfd_write(vq->kick_fd, 1)) {
>-        return -1;
>-    }
>-
>     return 0;
> }
>
>@@ -1436,6 +1431,11 @@ vu_set_vring_kick_exec(VuDev *dev, VhostUserMsg *vmsg)
>         vu_panic(dev, "Failed to check inflights for vq: %d\n", index);
>     }
>
>+    /* Inject a kick to look for available vq buffers */
>+    if (eventfd_write(dev->vq[index].kick_fd, 1)) {

Should we check if kick_fd is not -1 like we already do in other places 
in this function? (mainly when `nofd` is true)

>+        return -1;

This function returns boolean, -1 is `true` and IIUC means that we ask 
for a reply which is not the case here. We should fix it.

Thanks,
Stefano

>+    }
>+

>     return false;
> }
>
>-- 
>2.54.0
>


