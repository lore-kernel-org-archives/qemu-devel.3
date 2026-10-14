Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48DEBCC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 08:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGuoy-0004tQ-Qp; Wed, 14 Oct 2026 04:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xGuox-0004t4-6c
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:58:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xGuov-0005X4-M1
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791968324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mjQRen3z9Q2qAlHKFlknHzw6RrxlkepO7fEIWDYw4Lc=;
 b=XAMYEQqCeH9f0WZ848hAvOCLHlpf3E9K2s1GTd0w6ONUqeZBtcfl/NZA52n9PxoPma4jXy
 uLjITRj11isnLD2Z8ppCPcNuwRSDkADeD1kEWSCgnsH2flsE8RGUJXKuD60kWQWIfMlRWU
 kT77V0uGqCgcwb25U06m1+1hkzh/Hbk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-FLtoau7bMUmekSNNGg1Scw-1; Wed, 14 Oct 2026 08:58:37 +0000
X-MC-Unique: FLtoau7bMUmekSNNGg1Scw-1
X-Mimecast-MFC-AGG-ID: FLtoau7bMUmekSNNGg1Scw_1791968316
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a1af80b913so13874565e9.2
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 01:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791968316; x=1792573116; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mjQRen3z9Q2qAlHKFlknHzw6RrxlkepO7fEIWDYw4Lc=;
 b=O3ne7r/ocbDaRuqcT0/LmR7JnMnzKY8vuCjOMre0sZV6l11XlpB6wAroDUdenpEHJO
 fSU/7b2AC2fSh+/WL7q/xfRYVWrrNHIWcZXeIxn8l47cBnF/bOoTUxwPEjZjLoRMTi2L
 QA7OVny8U6TtHsaPTb5/PaPGrJAlbDT2c3zRFMreABZr5BgXfQIrr/FFS0HaUSJRO/mH
 lqpES7QcwG/Oaq86UkwC5pVeFO6SE8yek2ryMfLcNcAqe1m/s0hwF6VfEm1oK3565l2Q
 qNo0hcxUDr1yOwTNsiC7lIxqqjod5GCAQj3vUNMg/8lTi8g7fCd0PHJGM0HrOG1xgRwM
 GPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791968316; x=1792573116;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mjQRen3z9Q2qAlHKFlknHzw6RrxlkepO7fEIWDYw4Lc=;
 b=k0KFLNliZ+1c2mqcRz+8PTwLd5tuVpnLcbGz/k9QDdxbysCB3BrGcICY6S/sMZbBf9
 FH5KuMV+g/0J1+lXsTbtDAirn0hGybzdNC6s/q8iWK825wxSiim8YZ3wXqQqKjilsjwE
 QEti5X0DgDuCrhKVslNvLvu8KVypxQ7KFPeN8OIaKuPux/D/9LKJOK/dMIGCyzl856XK
 +ZSnBns+uxVcuz30KIYl4h+PdljJAouFaKsPMuVaBZO7MoVkgmxDlp1BLgpbMkFtUjY4
 dttW+TQ9lhzBrz2vqVeBOOI3wFRSBdoUPDKR049A6p690itBP50pdC+fnFUljd7PgQyh
 Zg6w==
X-Gm-Message-State: AFq9FYLxv6SdSeo/XLq13SGb4921sI+tklky76Lk54Y9GRcMUhwrMkdf
 bU4KFb/rY5YDeIqtqDdSipnXcjii1c816IERUBC8Mx9JCr4Ed11Nl4BBFlqVuE5ePROQ/2QHnO3
 w0WthFkeJxiKSpNLlDafrny4+zH0BFejd5J56nWuzDZCzBmbxrGX6Ot0U
X-Gm-Gg: AYBFou3lsVlOs8Xl/Pl2xfJxIR/e+avlM928ypnrjL5TuSpzpVxVtMfnwy4et/5rVHD
 S1TNhgKFp+CU1QlZH7Yk5ufMz0Ie2KmrqpcpOsWFvPOkD3PYdja+dEutBajpFZpv+YBl86LpGHj
 6KSeX2aXsmbuCdSboEHc48VSeVsnpeHezQ3YS/tDcVRt1hz92oqeHv2wSubmLJUpa5xSM9eER7a
 SHEG/YUpRqZM3eSklANJc+0nSvbnKYKspce37CSi+2K8z6NNKWnZIpIayz51zhYEwZNXPAsxUoe
 7MY4L+fl4hFIBfay6nlxFKfTM6iBjE6JQ0rlLdrWfwdsSS9niRn+wM86D6EMNmKv1vHOvazwy90
 TFKdioQ==
X-Received: by 2002:a05:600c:1c21:b0:49c:cee0:f383 with SMTP id
 5b1f17b1804b1-4a18e4b6241mr360245605e9.16.1791968316010; 
 Wed, 14 Oct 2026 01:58:36 -0700 (PDT)
X-Received: by 2002:a05:600c:1c21:b0:49c:cee0:f383 with SMTP id
 5b1f17b1804b1-4a18e4b6241mr360245065e9.16.1791968315515; 
 Wed, 14 Oct 2026 01:58:35 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.168.237])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0aaa9f9sm10617945f8f.19.2026.10.14.01.58.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 01:58:34 -0700 (PDT)
Date: Wed, 14 Oct 2026 10:58:29 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 bchaney@akamai.com, mst@redhat.com, maciej.szmigiero@oracle.com, 
 mark.kanda@oracle.com, vsementsov@yandex-team.ru, clg@redhat.com,
 den@openvz.org, 
 dongli.zhang@oracle.com, farosas@suse.de, peterx@redhat.com,
 dwmw2@infradead.org, philmd@oss.qualcomm.com
Subject: Re: [PATCH v16 19/22] vhost-vsock: hand off device ownership across
 CPR
Message-ID: <as9DPtYRdwzqPeNS@sgarzare-redhat>
References: <20261012-up-vsock-vhost-v5-v16-0-36c38bd15ffc@virtuozzo.com>
 <20261012-up-vsock-vhost-v5-v16-19-36c38bd15ffc@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261012-up-vsock-vhost-v5-v16-19-36c38bd15ffc@virtuozzo.com>
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

On Mon, Oct 12, 2026 at 01:28:27PM +0300, Andrey Drobyshev wrote:
>The previous patches reuse the source vhost FD on the destination,
>however both source and target still call vhost_dev_init() (VHOST_SET_OWNER)
>in realize().  For cpr-transfer the destination realizes while the source
>still owns the shared FD, so its SET_OWNER would fail - ownership has to be
>handed over explicitly.
>
>Do this through the device's CPR vmstate hooks.  Namely, release device
>ownership in pre_save, reclaim in post_load, re-acquire on restart:
>
>  - .pre_save() releases ownership on the source (VHOST_RESET_OWNER) once
>    the VM is stopped, for the FD-preserving CPR modes (cpr-transfer and
>    cpr-exec).
>
>  - .realize(), for an incoming CPR, only sets up the virtio device and
>    queries the backend features by calling vhost_dev_init_backend().
>    It doesn't take device ownership and doesn't touch the VQs which
>    still-running source might use.  The full init is deferred to
>    .post_load().
>
>  - .post_load() reclaims it on the destination: the full vhost_dev_init()
>    (VHOST_SET_OWNER) on the preserved FD, plus sets the guest cid, before
>    the device is started at vm_start.  It also marks the ownership as
>    handed over ('owner_handed_over'), so that it's released if this
>    target goes away.
>
>  - .set_status() refuses to start a device whose init hasn't completed
>    yet (incoming CPR before post_load).
>
>  - .set_status() re-acquires ownership before starting the device if
>    pre_save released it and this QEMU is about to run the guest again:
>    the migration failed, or it completed and the management resumed the
>    source (e.g. cpr-transfer target died).
>
>With the handoff in place, lift the CPR blocker.
>
>Note: this requires kernel side support of VHOST_RESET_OWNER operation
>for vhost-vsock.  Otherwise CPR attempt fails in .pre_save().
>
>Suggested-by: Dongli Zhang <dongli.zhang@oracle.com>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
> hw/virtio/vhost-vsock.c         | 157 ++++++++++++++++++++++++++++++++--------
> include/hw/virtio/vhost-vsock.h |   1 -
> 2 files changed, 127 insertions(+), 31 deletions(-)

Overall LGTM:

Acked-by: Stefano Garzarella <sgarzare@redhat.com>


