Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A16C53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 19:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp9w1-00080a-SF; Wed, 29 Jul 2026 15:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wp9w0-00080S-9f
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 15:27:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wp9vy-0006kr-A5
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 15:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785353236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ncd/epnJQ7H8eKbEeSqqYMYi4iKemDV6IXAwv8iHW4c=;
 b=hXdSNkHt+rWpAkJTVuTXJ1G9ECTwqt30DyVyXL4FDInzJ5sUKdil/xks0IzR70igujPLQN
 XPSnCBote0DdsuiJnSd8GBqWqRJYYvrSpXeHT5tMooQnwp0QoKopkO4lzkS6MWz8x8j6pl
 1AZM977/ZkaT2mF5Kd0pGtHDLKqml/4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-NoW2pkttN2qd2UNYg0YLKA-1; Wed, 29 Jul 2026 15:27:14 -0400
X-MC-Unique: NoW2pkttN2qd2UNYg0YLKA-1
X-Mimecast-MFC-AGG-ID: NoW2pkttN2qd2UNYg0YLKA_1785353234
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8e9489f62bfso15912646d6.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 12:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785353234; x=1785958034; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ncd/epnJQ7H8eKbEeSqqYMYi4iKemDV6IXAwv8iHW4c=;
 b=fsMcrfXcRuwxbApdXCrR7s6YV+hVDhWn38bjRgEPuMkIUHMVaU47DlCiDsnE4guHYH
 /MRmz0TchKhUhf4sWFtppr3FCpt+HLuv1tx/MAxcYyP7ZrhqwQlZSZqkfQwTmlsKFVTo
 k2EIqaloTzl3zDXl4ftG9c+tZ1AEFWWyEd8an8lXzeRD2zbZILnlR5rPrbPNy//Iuqpj
 VFl8nrpopjn1dutfpRNJIAcNaKMfdWy3HlPBdvLLF9jeGp6VuquBmDktUQ8Dcbqp+QQL
 RswDcW3Zb5Y4Emuix5xwPVzzL38CCQ+Hp95tX2gZRG86qAO8ZvO+DxNTNV1mDfhucUrX
 1YIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785353234; x=1785958034;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ncd/epnJQ7H8eKbEeSqqYMYi4iKemDV6IXAwv8iHW4c=;
 b=XRkOY3P0Zenmi+OHaVIJfH+v2fcHPK3uwC0DYp1mrowrFVXHVs5Vhg2W4Bu0V4ZCpJ
 1adkajdSG5vCKNegpnns6E2TX94ySlajtWU9QpFjx3BYw65+ccZlA+9ect2nrf5vORAJ
 kupzPYGTkIeP+ds8qfOaGOuoZPqk0T7v6hPdRfPUoQIG4ZaN2q8ujAGNkZDg+Vyb0vIn
 VfkINR5423aqKI3sVqOnD1FmeB46+TQSN+kXZ4UTx+8E1LzSuqJjhrDQAQzLSIlcz0/e
 tsfFKuuFZ+e0SsbPuTVGKDruM26nX3BaZYHr18OeyHjDMdFH4D4OzrE8Yjweo8MSkEgX
 M6bw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp6/50ce6/AyTfmXfI9wl8H+/BgO14cxgKOinXnBNi/kbT944T8E1vzHg/z+UDICWo/2LMVnu88JM2+@nongnu.org
X-Gm-Message-State: AOJu0YzaYI1S9yshiwNnciaCZDWTCUcwBh6y550BOv/mJSutigHTa6g6
 1+VgKUSOTo3ibL27rC6CdtM8MnivQkgUP/QT5OmIU+UwaQMCkYmaRU/i6jDrcPF0MvmByyCx9Bu
 aZ2lU9mnAbxiR9kBYA91ATdMMJFA4G9EpjRmTrMiDAFy7yeccEE/AFgfRBoMHewvd
X-Gm-Gg: AR+sD130mMt2KpUL1ANS47uzu/Fg4xriYNubMo9yIhqyBseBWzIaV4VazMDqQYVBPtD
 AnE83PbMLAlJ0oejUb9w52Nxexj96+EZ1kH31pZq/5BlR2FWizwjFdUKFVzf+blVf0akzAf8JLh
 58BftDS9xm7xWwTELJInRRm1oKybggqarzBRzMQfjUqfemI23kkvSbK8/nAhm0xMrq57s/QTcQ2
 iDZ33vIBXQelmDie4fTFrQjWZ1wvrMklkQqURmb2KEMMXZne7bLN6wcHfLdXnZSC0vIGi9lI7io
 Y5uNr6hie4kzus49z2uwhJ+YJ+ND3mq3IiC+/zPO59rjusRopGRyREL9sZMFgHc/0SRv
X-Received: by 2002:a05:6214:21ea:b0:8e9:78d7:6b98 with SMTP id
 6a1803df08f44-9083017b0eamr2285706d6.6.1785353234079; 
 Wed, 29 Jul 2026 12:27:14 -0700 (PDT)
X-Received: by 2002:a05:6214:21ea:b0:8e9:78d7:6b98 with SMTP id
 6a1803df08f44-9083017b0eamr2285376d6.6.1785353233481; 
 Wed, 29 Jul 2026 12:27:13 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9081dc6b318sm31754366d6.13.2026.07.29.12.27.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 12:27:12 -0700 (PDT)
Date: Wed, 29 Jul 2026 15:27:01 -0400
From: Peter Xu <peterx@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?utf-8?B?6rmA7Iq57KSR?= <seungjung0711@gmail.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: Re: [PATCH] vhost/migration: Fix incorrect size used in
 inflight->addr in VMSD
Message-ID: <ampUBV4wAluFGW93@x1.local>
References: <20260728153942.1891677-1-peterx@redhat.com>
 <87jyqeomqz.fsf@suse.de> <amoHbVsgzkYclCt2@x1.local>
 <878q6toopr.fsf@suse.de> <amof2Vbn_nTHR5H9@x1.local>
 <875x1xojtk.fsf@suse.de> <amo86cXLNE2uV6Ge@x1.local>
 <20260729145247-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260729145247-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

On Wed, Jul 29, 2026 at 02:57:57PM -0400, Michael S. Tsirkin wrote:
> On Wed, Jul 29, 2026 at 01:48:25PM -0400, Peter Xu wrote:
> > So to me, it's much simpler we say migration stream must be
> > trusted, and I expect dest QEMU can allocate any buffer it needs, until it
> > eats the whole system memory.  I really don't see much real risk..
> 
> It's not risk due to migration, specifically. But making qemu
> drink up terabytes from the guest would be problematic, right?
> 
> Putting qemu in a cgroup with restricted total memory
> would be one way to prevent this class of security issue,
> and a robust one.
> 
> But that, in turn, is impossible if qemu insists on allocating
> unlimited memory at the drop of a hat.

Just to clarify at least one thing.. we have two attack surfaces here and
they're very different IMHO:

(1) guest behavior caused memory allocation, or,

(2) migration stream caused memory allocation.

AFAIU, (1) is more severe. All my points only apply to (2).

> 
> However, migration is hardly the worst offender here, and I am
> not at all sure we need to start with it if we even want
> to address this limitation.

Agree.

Thanks,

-- 
Peter Xu


