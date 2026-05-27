Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30BA0CD5BD5
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 12:55:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSDnH-0002mj-NX; Wed, 27 May 2026 08:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wSDnF-0002mX-86
 for qemu-devel@nongnu.org; Wed, 27 May 2026 08:55:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wSDnD-00068v-6Y
 for qemu-devel@nongnu.org; Wed, 27 May 2026 08:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779886524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GJICiy2Q3nyEeJUJ+V4JQoHzP7OLNBjqunMM0jBV0N4=;
 b=WEROdR84Ojt7cd+ZdNtzMklXUaY1pZOBu1VS+1lRswhy81wYobnR9qBgOqaGblNZBarLqW
 kvgCBNHK74vt5sDnKKYx18Zj90Yo7PWgv9LyF9ukA6eQZtvUNKjGmAU4YLe8wsbUvU2Vnf
 6JaFTEdc0k/6OZxjxk9X26OA3MnQxRM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-GjCeWyNRPRmx2b_JaZAGeQ-1; Wed, 27 May 2026 08:55:23 -0400
X-MC-Unique: GjCeWyNRPRmx2b_JaZAGeQ-1
X-Mimecast-MFC-AGG-ID: GjCeWyNRPRmx2b_JaZAGeQ_1779886522
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-45e78dd7baaso9460962f8f.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 05:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779886522; x=1780491322; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GJICiy2Q3nyEeJUJ+V4JQoHzP7OLNBjqunMM0jBV0N4=;
 b=Nr922QGlTF84GPO/RdP969kdrGezIo7yiSg8Ao8DqBrInk0agdPXuSDQl8w4z4pCbx
 225bXKMFXCxJXTiSlhxvmBvUmbX+oNbLKloq2XBMJYCEhHt1nwhitxyYxrznWUvyndHK
 dNGQvkDc5pqxhjyxw3FT67b2+w/XC7VSxtfszAOA7YEtFbsS9LVFa1PEuE4dIyOyfFQK
 hfzddG7x6l93PQhkiJ1ChbnFmZ4Ads6ZfXWRkDpuN5OcAsC1q4Ux4cGrJHceDWTyl7Lz
 8FtwDMLBR5UH3BWTVhRwnXCCcKmjfdYa4IS0Xppq8Rk342cHxFu35gu5kZllx/k2w/AQ
 txNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779886522; x=1780491322;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GJICiy2Q3nyEeJUJ+V4JQoHzP7OLNBjqunMM0jBV0N4=;
 b=YKx7Cr7z5ZX60tsqWoBFC6jxE9dgHOMb3LtFp1XcljYZNmLbDcCiX7EwCzHM5sSTzJ
 Yk4SA1yM5IxxeP3//lYsLYYAth+RPcuts5AYPNauIEN2fMdbfzKN3LvRo4myLAzitsUk
 hXrKYhMR54DLbmOECmxS2gh/WTv6GcvFsep8rpUbqs6t5YGnW0heQTdof/11v1Ugs6uz
 +rJ8kRVzNyx2frcKvRCXeYszR4TL9U1GRjBTlww0kHdXYv6E4IYPDESHD8VRNcVFakPD
 ywbiUUMo56xOdCHlwGjp1TgTzcbl8W48NMu7SOKBLrk6K/ICa2Ql8crGy1vXRLBHTCa1
 TlGg==
X-Gm-Message-State: AOJu0YywGZ6m26a49sMc+6t/dKndwOxSEtw30K36UpkPgvYh3BULfRWo
 lXFT63hXaIAuS/oUF8Y4KFInHnZ2ecjQLq9JcwBQQTToHiFHeJAh/J902O3E5VX7j0VOZCuMn2W
 ZK5Wttv/FG52mUm9XUrg7rOvuRtwbkdrOVt5CBuC2DBl49cb4dJCAaqjN
X-Gm-Gg: Acq92OFIrBMFq0h3ELS/d2oQ2KTz1ITm5WCLvnLgKTuAQc3aTT8mb33bBzFq6eiWWId
 ArknlF5EtRrbSnYMo5XT0dPeqAJFjgZvD3C7FX/+9mY7GM0L0iGSEQ3JRn5rhYOHMy1FJv2UCPC
 ToVyE9esOI4qLMNT18uTBJWSbYpx9KvPNqjvAo9c5zbDZ5sIFfY+74jw7olwZ/b05iCpY60ccNb
 ba6roiuMI5HFUcZnT1YZKq6sMqDfqPa+Q6uEDNRf8ESDBIj1bkpsH8f/xh6ZI3aJSObO0fpP1jW
 vil03QLJiidA2kvuB4y47p4GSCbvQGIaVc4K2Vfl+EUgpscNM7tVctStlt9Eaq1gka0f0lkaX90
 xxmr/jvnVDZh1HMKr5fDOmryk8TQvGF3XfAC2nog0pHs=
X-Received: by 2002:a05:6000:41f0:b0:45e:9ea3:ce9a with SMTP id
 ffacd0b85a97d-45eb3688c81mr35406434f8f.8.1779886521917; 
 Wed, 27 May 2026 05:55:21 -0700 (PDT)
X-Received: by 2002:a05:6000:41f0:b0:45e:9ea3:ce9a with SMTP id
 ffacd0b85a97d-45eb3688c81mr35406378f8f.8.1779886521316; 
 Wed, 27 May 2026 05:55:21 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5a28casm8613367f8f.23.2026.05.27.05.55.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 05:55:18 -0700 (PDT)
Date: Wed, 27 May 2026 08:55:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, virtio-comment@lists.linux.dev,
 dev@lists.cloudhypervisor.org, rust-vmm@lists.opendev.org,
 Stefano Garzarella <sgarzare@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Demi Marie Obenour <demi@invisiblethingslab.com>,
 Alyssa Ross <hi@alyssa.is>, Albert Esteve <aesteve@redhat.com>,
 Mark Burton <MBURTON@qti.qualcomm.com>,
 Matti Moell <matti@qti.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Dorinda Bassey <dbassey@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Vishwanath Seshagiri <vishs@meta.com>, Rob Bradford <rbradford@meta.com>,
 Zhengyu Zhao <zhaozhengyu@bytedance.com>,
 "Jorge E. Moreira" <jemoreira@google.com>
Subject: Re: Where should the vhost-user specification live?
Message-ID: <20260527085058-mutt-send-email-mst@kernel.org>
References: <874ijtz038.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874ijtz038.fsf@draig.linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, May 27, 2026 at 10:13:47AM +0100, Alex Bennée wrote:
> 
> Hi,
> 
> Apologies for the wide cross-posting but I wanted to find as many
> interested parties as possible.
> 
> The vhost-user specification currently lives in the main qemu
> repository (docs/interop/vhost-user.rst) mainly due to historical
> reasons. QEMU was one of the first VMMs to implement vhost-user and the
> spec needed to live somewhere.
> 
> However there are now vhost-user implementations for QEMU, rust-vmm,
> cloud hypervisor and I think CrosVM. We get queries about changing or
> updating the spec on qemu-devel from time to time and I feel that given
> it is an interoperability specification we should think about hosting
> it and its discussions elsewhere.
> 
> I think broadly there are 4 options:
> 
>   *  Move into the OASIS VirtIO group as an appendix/addendum to the main
>      VirtIO spec.
> 
>      This probably brings the widest visibility to changes to those that
>      might be affected. However it does come with a certain amount of
>      bureaucracy with the OASIS process where only members can vote on
>      changes. While intimately tied to VirtIO it's concerns are more
>      focused on practical implementation details of the IPC between VMMs
>      and device backends.
> 
>   * Move to a separate project under the qemu-project space.
> 
>     QEMU hosts a number of sub-projects and mirrors so it would be easy
>     enough to split the spec into its own repo. Changes to the
>     specification could then be divorced from QEMU's release cycle and
>     at the maintainers option issues and merging strategies could be
>     configured for just the specification.
> 
>   * Create a new project just for vhost-user
> 
>     The interested parties could decide where to host (github, gitlab,
>     forgejo, whatever..) and decide to move away from mailing lists
>     altogether or create a mailing list but manage changes via the forge
>     interface.
> 
>   * Status quo
> 
>     Just keep the spec where it is and muddle through as before. Maybe
>     we could improve the contribution documentation for how and when
>     changes are discussed.
> 
> Any thoughts?
> 
> -- 
> Alex Bennée
> Virtualisation Tech Lead @ Linaro

I think what is missing here is what are the pros for any of the
proposed changed?  What are the issues we are trying to solve?
What 'queries about changing or updating the spec' were problematic?

Thanks,

-- 
MST


