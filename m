Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27100C88E75
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 15:19:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x68SB-0004En-7J; Mon, 14 Sep 2026 11:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x68S0-00043Z-Gh
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 11:18:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x68Ry-0002Dz-PG
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 11:18:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789399110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jrbR86qvPSM1UT+pt+N2KElBfjNWyq9Pp++QoqytyGM=;
 b=E72lRUggv274+V+7jUvJQ6lzR8ndMDaniBki6VgJ36qcwHT5VzNgrkm4UMruCTk+IRr/ej
 s85MOtU/8b5vtAuOEMdW6Wvv9SqQSlhonoxalqKW9FSgRG9Oabu4xfdNmcOfAGiL/17YaA
 xy5FEY8amDo3i11nmX06YlTCl6SfBjM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-eRlxPTHfNd6FoibkAZMNxg-1; Mon, 14 Sep 2026 11:18:28 -0400
X-MC-Unique: eRlxPTHfNd6FoibkAZMNxg-1
X-Mimecast-MFC-AGG-ID: eRlxPTHfNd6FoibkAZMNxg_1789399108
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48597bbd963so2821314f8f.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 08:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789399107; x=1790003907; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jrbR86qvPSM1UT+pt+N2KElBfjNWyq9Pp++QoqytyGM=;
 b=EVMuolU6lVWzIK4uydUuynWXCPYlBC8rhmH+jkrQ9h/JxGvu+yQM6ZbKvv7bqnJI8r
 hbtRG2FOWtOU7myvG+R+sj7eQFSd0axEsAMb/Fv0l1PhCBZzlV2JtdNr/Vp835h47NrH
 3KI8hbIgcYkqYcEmBz2Jg8HXlCvB8gzVgO/kVNtLXNmZK4EHKrGi9g3zdCOq8qCSju17
 /jLpXepdiLOkRhm7Y1WWBk75PzOzJIW8K7pTQeLHLyJQOFWLAMjsY6LALZ/t8ZIdoW4F
 nqvvxK38HuxUZfn7pAKehGVhOtupE0MLypKeecMxPzVy5GZKXZvHBUE0NE0etY/cjiUh
 97tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789399107; x=1790003907;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jrbR86qvPSM1UT+pt+N2KElBfjNWyq9Pp++QoqytyGM=;
 b=TE8dkcrZ7V063QS0BCHoXEQ1KnLXYr5yKUb8lfv+pBluQ/OU+YRlL3knt/+Mp7ryT0
 qBoJQAnB9t7qy+FLA0fDV2H8kKmAxkgMUBqN5m4sZCj7Qam3GzZ2dFf6StgcXF80KVYP
 Se5uFlNMm3TaJeggRN4Y6BD+/6U195SWCpOKrmYr038facBgKI5894oErOYBmEpv1A9M
 bvCvmtcZ41fRd4UC2ug/TrDcK1PPibf8k7xTtR9ElroJJ/emH2uBPqcIJhvO2hI50rLr
 hiuL7vYQaBRl1LiB8OVB8wkTZ6ZCJ8EWQ6OUO68c+8A3MJFem/RkxCrb/dJVdlKOVYIs
 77mA==
X-Gm-Message-State: AFuF++nEvow1Th0k1O//ABvV05VFiN9eAg/0yjjQ49OG+PR2gpviASlR
 yzgAXxKbzCqlq1vPm5AsAH9eUzhQsfI+1Ep/6zi3RFjyPviaqtZoP2nEZ1vcGnTwmvUI+WVnUu6
 sXztArtsrZMPw/eb2eRv7SLs4dvYJGaWw54wv+n+xLKSnYOChqnV+rDmX
X-Gm-Gg: AYBFou1RkuzVJDZ3eFH//vxeXJp3hkeHFf+8R6jUesDcHypgIosOCRnVDdTXsrCSrp2
 /tcag5+RKqQnNSHrfKRekDx4Bddk3RHMI0H0cyTZwzDjdKS1kjWCtlCMvPGKahESld/yLigEmk0
 FSG+6D6c16QGrezmNJZFZKPCk9V65CnKo6VV2j9/cTU3Pdyx8ZwG3iEPTUK2uiDTHc00GF9I9wk
 S5aq2DBG1gG06lc3e5GTuWZbzGGd3Y9/yCmTbJjcjgn+cM+ekPkAjgKKT6iCStGb/KI/6xa5lzO
 uf6Uc1GSsy4S5kiTQ1L6HHEQ29PPUlxuKCbfJFU5JkzjjyOmYOqgMPYQKq9KpK5NeZ809JQqjgg
 A2+BV96/r34ncptDyzH+W5dP/rDZGNdnIFXcis6PsLa6LBA==
X-Received: by 2002:a05:6000:2685:b0:485:ac96:7251 with SMTP id
 ffacd0b85a97d-48702b1d3f6mr9176584f8f.21.1789399107504; 
 Mon, 14 Sep 2026 08:18:27 -0700 (PDT)
X-Received: by 2002:a05:6000:2685:b0:485:ac96:7251 with SMTP id
 ffacd0b85a97d-48702b1d3f6mr9176436f8f.21.1789399107038; 
 Mon, 14 Sep 2026 08:18:27 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it.
 [79.53.30.11]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb357288sm28121334f8f.29.2026.09.14.08.18.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 08:18:26 -0700 (PDT)
Date: Mon, 14 Sep 2026 17:18:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, philmd@oss.qualcomm.com, 
 maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com,
 den@openvz.org, 
 farosas@suse.de, peterx@redhat.com, clg@redhat.com, dongli.zhang@oracle.com
Subject: Re: [PATCH v5 12/14] vhost: add vhost_dev_set_owner() /
 vhost_dev_reset_owner() helpers
Message-ID: <aqgQObEfJ8zu4pjF@sgarzare-redhat>
References: <20260914-up-vsock-vhost-v5-v5-0-d17423589f48@virtuozzo.com>
 <20260914-up-vsock-vhost-v5-v5-12-d17423589f48@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260914-up-vsock-vhost-v5-v5-12-d17423589f48@virtuozzo.com>
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

On Mon, Sep 14, 2026 at 11:37:43AM +0300, Andrey Drobyshev wrote:
>Wrap the set_owner/reset_owner backend ops in dev-level helpers, matching
>other vhost_dev_* wrappers, so device code can take or release ownership
>without reaching into vhost_ops directly.  vhost_dev_init() now uses
>vhost_dev_set_owner(). Both return -ENOSYS if the backend has no such op.
>
>No functional change.  These are used by the following vhost-vsock patch to
>hand a device between owners during CPR.
>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
> hw/virtio/vhost.c         | 20 +++++++++++++++++++-
> include/hw/virtio/vhost.h | 25 +++++++++++++++++++++++++
> 2 files changed, 44 insertions(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>index 2bb9a23fee4..ea17bf01080 100644
>--- a/hw/virtio/vhost.c
>+++ b/hw/virtio/vhost.c
>@@ -1690,6 +1690,24 @@ int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
>     return 0;
> }
>
>+int vhost_dev_set_owner(struct vhost_dev *hdev)
>+{
>+    assert(hdev->vhost_ops);
>+    if (!hdev->vhost_ops->vhost_set_owner) {
>+        return -ENOSYS;
>+    }
>+    return hdev->vhost_ops->vhost_set_owner(hdev);
>+}
>+
>+int vhost_dev_reset_owner(struct vhost_dev *hdev)
>+{
>+    assert(hdev->vhost_ops);
>+    if (!hdev->vhost_ops->vhost_reset_owner) {
>+        return -ENOSYS;
>+    }
>+    return hdev->vhost_ops->vhost_reset_owner(hdev);
>+}
>+
> int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>                    VhostBackendType backend_type, uint32_t busyloop_timeout,
>                    Error **errp)
>@@ -1707,7 +1725,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>         goto fail;
>     }
>
>-    r = hdev->vhost_ops->vhost_set_owner(hdev);
>+    r = vhost_dev_set_owner(hdev);
>     if (r < 0) {
>         error_setg_errno(errp, -r, "vhost_set_owner failed");
>         goto fail;
>diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
>index 9b98d34dd04..94cc52f870d 100644
>--- a/include/hw/virtio/vhost.h
>+++ b/include/hw/virtio/vhost.h
>@@ -178,6 +178,31 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
> int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
>                            VhostBackendType backend_type, Error **errp);
>
>+/**
>+ * vhost_dev_set_owner() - take ownership of a vhost device
>+ * @hdev: the common vhost_dev structure
>+ *
>+ * Issue VHOST_SET_OWNER on a device that has already been set up, e.g. to
>+ * complete a CPR handoff on the destination, or to take the device back on
>+ * the source after a failed CPR.
>+ *
>+ * Return: 0 on success, -ENOSYS if the backend has no such op, negative
>+ * errno on failure.
>+ */
>+int vhost_dev_set_owner(struct vhost_dev *hdev);
>+
>+/**
>+ * vhost_dev_reset_owner() - release ownership of a vhost device
>+ * @hdev: the common vhost_dev structure
>+ *
>+ * Issue VHOST_RESET_OWNER so that another process can take the device over
>+ * with vhost_dev_set_owner(), e.g. on the CPR source once the VM is stopped.
>+ *
>+ * Return: 0 on success, -ENOSYS if the backend has no such op, negative
>+ * errno on failure.
>+ */
>+int vhost_dev_reset_owner(struct vhost_dev *hdev);
>+
> /**
>  * vhost_dev_cleanup() - tear down and cleanup vhost interface
>  * @hdev: the common vhost_dev structure
>
>-- 
>2.47.1
>


