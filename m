Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E048C982F1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 09:31:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8wq3-0001tV-Rg; Tue, 22 Sep 2026 05:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x8wq2-0001tA-I0
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 05:30:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x8wq0-0005hG-Nl
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 05:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790069455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LsdsMBpyhDrIED7CukXtRs6jNeZIvpm02YIIVRZFQDI=;
 b=NCEAB0Qqz2sMwYwKtZVlVBP5XEHI1KyKC7F/pH59SrMyxX/bKpgDnjfeQlNx/Bsnda//e1
 HkQAHzMuJWiK/ElrXxiUA49tkMF0SN6bZrFFsnXvrwCtApQq8WRsez5SA0QREynxuc6a2p
 K7x9zD5MYCZ5K1d+QvkFI4bbpzQuXow=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-oq_Xr43QMa-t5PuEZhXvqQ-1; Tue, 22 Sep 2026 05:30:54 -0400
X-MC-Unique: oq_Xr43QMa-t5PuEZhXvqQ-1
X-Mimecast-MFC-AGG-ID: oq_Xr43QMa-t5PuEZhXvqQ_1790069453
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4870a0fe60fso2060383f8f.2
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 02:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790069453; x=1790674253; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LsdsMBpyhDrIED7CukXtRs6jNeZIvpm02YIIVRZFQDI=;
 b=obYe+ZY8VUWrxv1yFIlKCC2phIef8UVFnzGz8g8Ipi0OsdhTRWbU8XjOBHtNNXiHGh
 o1BLFvE8pcl5qKv8eVwf0ovEz55huOc2i+v/5Fq6mKc3Q1oFVpFw+TxaApR4CzSOO0Yv
 PsYuCNUbaGWaX3Lzdd3nJNvXYqFMFSZzoSCwA3UVRqw3hwQqpC/LwkIdizVGcsk8sntn
 mbTN1bdFUAUvkex2y53dybSZbXP3jC1kcKhTccSMiReumUN4l/ICTqbNoVf2e+TjpBek
 GWM1/TnyLHQh4ukjyovMx5krvgV6pwVHqGaYc9+snAyaz4mnpnnjusNfm5TEusXI+4n8
 pECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790069453; x=1790674253;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LsdsMBpyhDrIED7CukXtRs6jNeZIvpm02YIIVRZFQDI=;
 b=hSnzKbG86CODkfi4TNE3Y6+etxRMMc1KREloATO3JFfhe0x6S+fby4WoaZyTCmKrM7
 Zwh+ZaR+3YOpnlmbTjM7mUszADopm+tLbcE82sebtKetF8979h+ChV2B/jaJt1td55Oa
 Qyp1OQpBm95rKMGdPBXNNVzQjJ9NjRhC9xcZ8rRsgXBhmR/KiDuPDCCjm7JFKvWon6Ke
 joU4DS8XxIE02lMdjxHS+xFotUE/HGuRLPPO5Ta1G6YkGlXMOKz2QMsyCKGxO/ftvSII
 cqk2y5nJcrFRpWo7fKJrejg3GRaPP2bu86Ehp695zUMtWfkd5zFxxK3AZAnwa4qJ8qAP
 PjSA==
X-Gm-Message-State: AFuF++lC1f4Nhfq5ZWgg9J7UBzSAB1FRsF2I9Bk9cei2wSpAf486GZnw
 n3LyPSontXk4GCRjdRL0TLtWjVbTlFW0NGgxo/w4CVSpD3YsnTvtyDgHlY5k0K/DLS/toD1St8Z
 +JzeHXS5o6CsN+kpmkSDLALpgbwdbeQ2KUPrvDnkxNq/3dlNInVVa6IWO
X-Gm-Gg: AYBFou0Rt/QrBtnp8JUQ/IWBkC1eV6tSiUHhXkFDXIAp3WjGD8b15Xf/OM+2DvHRlNf
 rB3xhil0AQ2lo1i1Dh0julVB66WLprZeyZBxUQ1WVcHK+llAymzHepg6cSTenbeUzUGtgGFVpdk
 bNgBlPB8QKc0Vv2jrclNS7c3kvLAOfXuEq/AzDAWLgF9IpGR4uv9sUd5vRBMpvYVp0VcO4+9qx0
 wro+u1ldDAMZrBVmxjIwr6A09MWJupgo65KKptJbPcko95DiwPjM4jG5pmj/9d6qFcwapIy00Yk
 xkJyGCCDpi1bM9XyihYdxFROd4aVc1sQIsqf45nR0UUr//hNXbCq9XItcctmeDThsvQzYIhluHv
 d1UR5wV7i70WkkvNR/QGb+vks9SvUvRUFxIJR6u5NrPF+mOn6bOY=
X-Received: by 2002:a05:6000:4811:b0:487:24cc:8bb3 with SMTP id
 ffacd0b85a97d-48724cc8c21mr13656621f8f.29.1790069452831; 
 Tue, 22 Sep 2026 02:30:52 -0700 (PDT)
X-Received: by 2002:a05:6000:4811:b0:487:24cc:8bb3 with SMTP id
 ffacd0b85a97d-48724cc8c21mr13656580f8f.29.1790069452284; 
 Tue, 22 Sep 2026 02:30:52 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-131.retail.telecomitalia.it.
 [82.53.134.131]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886277df46sm3674012f8f.17.2026.09.22.02.30.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 02:30:51 -0700 (PDT)
Date: Tue, 22 Sep 2026 11:30:41 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, bchaney@akamai.com, 
 mark.kanda@oracle.com, philmd@oss.qualcomm.com, vsementsov@yandex-team.ru, 
 maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, mst@redhat.com,
 clg@redhat.com, peterx@redhat.com, den@openvz.org
Subject: Re: [PATCH v7 00/16] migration/cpr: support vhost-vsock devices
Message-ID: <arJJ6K7A49p0AHGD@sgarzare-redhat>
References: <20260918-up-vsock-vhost-v5-v7-0-6ef9ef033c35@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260918-up-vsock-vhost-v5-v7-0-6ef9ef033c35@virtuozzo.com>
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

On Fri, Sep 18, 2026 at 04:46:51PM +0300, Andrey Drobyshev wrote:
>v6 -> v7:
>
>  * Patch 9:
>    - cleanup closed vhostfd here rather than in #14;
>    - add !cpr_incoming guard before saving CPR fd;
>
>  * Patch 14:
>    - remove closed vhostfd cleanup (moved to #9);
>    - lift !cpr_incoming guard before saving CPR fd - not needed with an
>      early return;
>
>  * Patches 15-16 (NEW):
>    - add qtests running cpr-transfer/cpr-exec with a vhost-vsock-pci
>      device attached;
>    - add functional test with a live guest doing host<->guest vsock
>      transfers across a series of CPR migrations.
>
>v6: https://lore.kernel.org/qemu-devel/20260915-up-vsock-vhost-v5-v6-0-4d31b2dc6afd@virtuozzo.com
>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
>Andrey Drobyshev (16):
>      migration/cpr: forbid saving duplicate CprFds into hash table
>      tests/unit: add test for duplicate keys in CPR FD table
>      migration: forbid snapshots in CPR migration modes
>      tests/qtest/migration: add test for snapshot rejection in CPR modes
>      vhost-vsock: block CPR migration modes
>      vhost: add vhost_reset_owner op
>      vhost-vsock: don't reset connections during CPR
>      vhost-vsock: fix FD leak in realize()
>      vhost-vsock: preserve vhost FD during CPR
>      vhost: factor out vhost_dev_init_backend()
>      vhost: make vhost_dev_cleanup() safe on a partially initialized device
>      vhost: add vhost_dev_set_owner() / vhost_dev_reset_owner() helpers
>      vhost: add vhost_dev_is_initialized() helper
>      vhost-vsock: hand off device ownership across CPR
>      tests/qtest/migration: add vhost-vsock tests for cpr-transfer and cpr-exec
>      tests/functional: add vhost-vsock CPR test with a live guest

I think I sent my A-b/R-b to all vhost/vsock related patches (if not 
please let me know). As for the other patches, I don't think I know 
enough about CPR.

So for vhost/vsock everything LGTM, I left just a comment more for my 
curiosity.

Thanks for the patience and the work!
Stefano


