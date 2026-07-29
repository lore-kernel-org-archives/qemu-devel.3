Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E52C53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 09:33:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp0f0-0006d8-DX; Wed, 29 Jul 2026 05:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wp0ev-0006M2-Cf
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 05:33:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wp0eu-0007pG-0I
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 05:33:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785317583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h5ZGAi7O8dLqh6Z353nyUXQvQytJAAXxypSOhF8311U=;
 b=FZqDbrn7Lu7WpiuoIhnKrelVZtru3hwfVReVIlqsWZYbznKgfT3uHVp+zyBoaYQQQwwNUl
 JKnSd40htzZUCUyVaLwdGlJ5AB0+Jka/I69sUmMMga6PsNVR9rNucJZ9yWPXMRQOnzbJKJ
 2EZ3Czqv3Jkt3eUILw6i36sRSjhTF9s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-BvD_pzfXPsi7AZc5kNNqWw-1; Wed, 29 Jul 2026 05:32:56 -0400
X-MC-Unique: BvD_pzfXPsi7AZc5kNNqWw-1
X-Mimecast-MFC-AGG-ID: BvD_pzfXPsi7AZc5kNNqWw_1785317575
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4956c1655c3so3879725e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 02:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785317575; x=1785922375; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=h5ZGAi7O8dLqh6Z353nyUXQvQytJAAXxypSOhF8311U=;
 b=VszIr/SDwgxrWlLWEU4exrNpdinz6MF34sotyOZCwH0zyMdPoOA0IZxcs/ffH+9gGR
 hsHOsRvmIFo4YyQszaCTYRNdlMo1V7o1WwAU2txTJoFOhXQmN7ryZp89ppnh7KKkQ0nd
 qQSn6l5i1ZODikwHGoxxEbR/eWKV9o98LSM+JP2pcALIGVRw6MfIS0piEz9f3Xialo7/
 tXo0mmRnKAGpVZgS5utXDNWnmdZ23O7agS+e+POQtV+VgBUtvVwYtodVEtlxgepxnNVv
 rY4JvII35fLbhCKIFF4dlzFZjyKQUW62xWiokTytSANpCJ/9q9ZfPmQTJT9hUzCeDKab
 fbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785317575; x=1785922375;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=h5ZGAi7O8dLqh6Z353nyUXQvQytJAAXxypSOhF8311U=;
 b=jf++Cvycex7bQLQZETJXrPicaUoWYMZULAU7Y3TjXXXEuh1zfwyJdqTJSoV21gvFrj
 vu38Z4QC6WqU/A/I0uzrkWnzrLdr5qKHAtOT7cuWwZb/2BiyWk0KR/prmX0iFeQzNIiz
 6wiYINHZueA3L/NFeEB5o7qvpZIJ68eVr05nsjhbCzhN156gzMDkgLlS4cjtckwWHeLB
 eQhcctyx4d6+kiwaBpdhL/xHM+vKqmWVAT8q2g69N6frxCe4AKCvyvfRPVTv8clXwLvk
 CRsIoKaZvKlSd5yfW0/tczsOVewq/hssNkSngM3WKxy1MV4E+vuwLUjkPiL9ukgQTSII
 vOKA==
X-Gm-Message-State: AOJu0YxTGReNjeditKvcpszsQMg5N3+kZ86FY39SQwk4SoG6ETwNSal3
 uXcIXsIOLq4lgOAdZuQ8DtfJyVI2S8JLtrezDqwbeGQ53+grn8ACYU91axAbPMZXclEXEeWRXhT
 jok9MVvAnQ7vo8s8l0sFr7Pj6L073adhxsacsOh/5MkFtWLPlfItkGDdO
X-Gm-Gg: AR+sD10eXNHwAuiLxSw6Cy/0/acJ458vk+aZtZb8Pexy9gKoxpczzPFEgSjFuyulfOQ
 EQ0vHvumKGAGX/HphTXhHTVRXsvCGeylm74MXHr30N1meUU+EnVnSr3QuCoX3bEofifKcTZrcL+
 d2BIyzCefES5qmo/ALWrm1PftXT8eBFqyJWh6iPptjXHuXZ8h488IwF6bb5C0tYrCm3c79LCJHu
 kzF/kd7THt5vo0DcNxk89e2GZfxPIny+DguUBZ8ajcOv+3Z/1/gM9z9APKanca7OrlN4jyfCdPz
 F7HLUQg0Uy3BoZQ9Sk52VuofWMeobz+DVVguIYWtJpJTFuahMIAThj1B2NdlaB7j9PijDthQt2b
 rKeVAqVFYtViTmuKop7eCtkk=
X-Received: by 2002:a05:600c:4f86:b0:496:c933:c276 with SMTP id
 5b1f17b1804b1-496c933c2afmr52300225e9.25.1785317575000; 
 Wed, 29 Jul 2026 02:32:55 -0700 (PDT)
X-Received: by 2002:a05:600c:4f86:b0:496:c933:c276 with SMTP id
 5b1f17b1804b1-496c933c2afmr52299645e9.25.1785317574423; 
 Wed, 29 Jul 2026 02:32:54 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49764d779e4sm41572705e9.6.2026.07.29.02.32.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 02:32:53 -0700 (PDT)
Date: Wed, 29 Jul 2026 05:32:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowangio@gmail.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 virtio-fs@lists.linux.dev, Kevin Wolf <kwolf@redhat.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Milan Zamazal <mzamazal@redhat.com>, Raphael Norwitz <rnorwitz@nvidia.com>
Subject: Re: [PATCH v5 4/6] vhost-user-blk: make inflight-migration prop
 mutable
Message-ID: <20260729051509-mutt-send-email-mst@kernel.org>
References: <20260728100841.3475774-1-dtalexundeer@yandex-team.ru>
 <20260728100841.3475774-5-dtalexundeer@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260728100841.3475774-5-dtalexundeer@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

On Tue, Jul 28, 2026 at 03:08:39PM +0500, Alexandr Moshkov wrote:
> When migrating from a QEMU version that supports inflight-migration to
> an older one that does not, there is no way to disable the feature at
> runtime — the VM must be stopped and reconfigured. This is impractical
> in production environments.
> 
> Make the inflight-migration property mutable after device realization
> so it can be toggled via qom-set without restarting the VM.
> 
> Acked-by: Raphael Norwitz <rnorwitz@nvidia.com>
> Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>



I think I am beginning to understand.


You are running qemu with inflight-migration on and want to migrate
to qemu without inflight-migration at all.


Since it is guest transparent you could retrofit it like this.

My question is why is it worth it, we do not normally support
migrating between qemu versions with different command lines.

> ---
>  hw/block/vhost-user-blk.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index e3b873af7c..650c004bde 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -619,6 +619,8 @@ static const VMStateDescription vmstate_vhost_user_blk = {
>      }
>  };
>  
> +static PropertyInfo vhost_user_blk_inflight_migration_prop;
> +
>  static const Property vhost_user_blk_properties[] = {
>      DEFINE_PROP_CHR("chardev", VHostUserBlk, chardev),
>      DEFINE_PROP_UINT16("num-queues", VHostUserBlk, num_queues,
> @@ -632,8 +634,9 @@ static const Property vhost_user_blk_properties[] = {
>                        VIRTIO_BLK_F_WRITE_ZEROES, true),
>      DEFINE_PROP_BOOL("skip-get-vring-base-on-force-shutdown", VHostUserBlk,
>                       skip_get_vring_base_on_force_shutdown, false),
> -    DEFINE_PROP_BOOL("inflight-migration", VHostUserBlk,
> -                     inflight_migration, false),
> +    DEFINE_PROP("inflight-migration", VHostUserBlk, inflight_migration,
> +                vhost_user_blk_inflight_migration_prop, bool,
> +                .set_default = true, .defval.u = false),
>  };
>  
>  static void vhost_user_blk_class_init(ObjectClass *klass, const void *data)
> @@ -665,6 +668,9 @@ static const TypeInfo vhost_user_blk_info = {
>  
>  static void virtio_register_types(void)
>  {
> +    vhost_user_blk_inflight_migration_prop = qdev_prop_bool;
> +    vhost_user_blk_inflight_migration_prop.realized_set_allowed = true;
> +
>      type_register_static(&vhost_user_blk_info);
>  }

So then,  for example, let us say I paused the VM, then set the flag,
now inflight is on but GET_BASE did not drain it?

> -- 
> 2.34.1


