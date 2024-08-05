Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49134C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 07:31:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sasBH-0006Pc-2p; Mon, 05 Aug 2024 03:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sasB0-0006OO-CW
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 03:30:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sasAx-0001Z9-D1
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 03:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722843038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mrj6xfA4Cg9G6eoBV/wzqsYx+7ec8BFnN8hQ5IHgs0E=;
 b=Q1qtg7Hbf4LZtuM1mg3Vz4Dak0JiB3MzZmHpyIs5Y5vJrQ5BocVbfdSaiiyvpMLK62pmoL
 WV9OlFVzTaRu89XC67v4NM1gA2zvXUavZGnavD7hvkAdwLtvcwYZszM/S4JM0zNP1V4YCr
 5gHxIt++rXv5cL0qBQmR5KP8ZyZLBZM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-4OSTEwBIMOm1UKKLcOXLCA-1; Mon, 05 Aug 2024 03:30:35 -0400
X-MC-Unique: 4OSTEwBIMOm1UKKLcOXLCA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-36841edbc32so4691619f8f.3
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 00:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722843034; x=1723447834;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mrj6xfA4Cg9G6eoBV/wzqsYx+7ec8BFnN8hQ5IHgs0E=;
 b=b8K8vqpA5lsxaFRbH741J8oGxmFucVNmKiIjinxO2cNcBZlWSwhUyav7bOcLJUsOvT
 AR9foHJYUEkngntAYY/giNXkgK9kN2Uh+KPbrlz39DAAfS51Dwibj03Xq9cZLXRJ6Qtf
 LR0b6I8D5cvZvs/OqefM/aWzVHfI/qG/QVKjZCicxRzpkWFRL/efDx/L5ORt8desCheD
 15oB4OIAJeOTCBMQFNSecsfX/IRVD016O5dm4XY2c5Y2WvdfHu2NFXUxmZiJjdzX+1hw
 Mpzeq7JPpjwF+Nv5St7wEft8wzfx7S8HQLja8ftDJ+N1ppRmdilgyzMQ0J66z4Ipd8Ny
 GiFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2fqKkrm/Ou59CKMzeg8pnk64m5lbGmi0ka5uPOQvHBNMM/mS7OJclWDvtZQ6VvPBSj6WHBrLI1J+M@nongnu.org
X-Gm-Message-State: AOJu0Yx5kyhTy6eFE0k/ks4W09JFE6k9/9HHk0ynGYaI3Y7FG6i/oBMP
 XBAk21KJtBL1krFTmoprmdyZW8r1XQok4iuLotAyO/uiyrPyldOnfcPmrO5fMJl8gTefr+zkd+v
 Jwg1EBpek53apnNxI24SJgd08ynh7Ofuckp3SJl/+ZzPbN/R2mUhY
X-Received: by 2002:a5d:4c82:0:b0:36b:b24b:d14f with SMTP id
 ffacd0b85a97d-36bbc0fca5dmr6604666f8f.36.1722843034181; 
 Mon, 05 Aug 2024 00:30:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwBSdwXQnLREeXR5DlWAkabFwdu/+N5fgr6amQsbnixd+oMCGxu4blXVpgd+9vSXQ1erU8tQ==
X-Received: by 2002:a5d:4c82:0:b0:36b:b24b:d14f with SMTP id
 ffacd0b85a97d-36bbc0fca5dmr6604631f8f.36.1722843033396; 
 Mon, 05 Aug 2024 00:30:33 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17d:dd95:f049:da1a:7ecb:6d9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf1dfc3sm8886689f8f.31.2024.08.05.00.30.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 00:30:32 -0700 (PDT)
Date: Mon, 5 Aug 2024 03:30:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Peter Xu <peterx@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 jasowang@redhat.com, sriram.yagnaraman@est.tech, sw@weilnetz.de,
 qemu-devel@nongnu.org, yan@daynix.com,
 Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
Message-ID: <20240805032937-mutt-send-email-mst@kernel.org>
References: <ZqktXwxBWjuAgGxZ@x1n> <Zqk09BGxlpdxMBMx@redhat.com>
 <Zqk6x2nd3Twz--75@x1n>
 <39a8bb8b-4191-4f41-aaf7-06df24bf3280@daynix.com>
 <ZqumIZcs1tCNTpRE@x1n>
 <b70d09a5-554a-456b-904e-59cec5836ae8@daynix.com>
 <Zqz1vvYqRuIAPnod@x1n>
 <c5ea7a57-fc52-4bb7-bc4c-f3aca8da0574@daynix.com>
 <Zq0IrhV-DgStpJtk@x1n>
 <8ad96f43-83ae-49ae-abc1-1e17ee15f24d@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ad96f43-83ae-49ae-abc1-1e17ee15f24d@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, Aug 04, 2024 at 03:49:45PM +0900, Akihiko Odaki wrote:
> I suggest disabling all offload features of virtio-net with 9.2.

Yea ... no.

> I want to keep things consistent so I want to disable all at once. This
> change will be very uncomfortable for us, who are implementing offload
> features, but I hope it will motivate us to implement a proper solution.

It's uncomfortable for users.

-- 
MST


