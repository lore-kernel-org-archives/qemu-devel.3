Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD6CC3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 05:42:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZOZe-0007St-Cb; Thu, 01 Aug 2024 01:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZOZL-0007Rl-Ja
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 01:41:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZOZJ-0001qD-O2
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 01:41:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722490900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NktRsDxeEC0eGyhn7hbLjpa+ogRehzlxHVdf+BeEVDI=;
 b=hac1tuCGjS3dKdnr529n0TKod9oulKLrW5cI97pjkXS2uzmf8AYnFk9A1lyE+JpbQ0qj9x
 0rSndOsbp6smCWXgYyXZo8rYKYxheOP2k70HibSI0UtbdeHFsc2g2WgXJRKFDy6Mti0L0j
 G+Nq0QDhsqmmUg/pDp/Ek74wOSfHido=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-0G31rPRrP6C464gRDThsEg-1; Thu, 01 Aug 2024 01:41:39 -0400
X-MC-Unique: 0G31rPRrP6C464gRDThsEg-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-52f02f1773fso7343717e87.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 22:41:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722490898; x=1723095698;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NktRsDxeEC0eGyhn7hbLjpa+ogRehzlxHVdf+BeEVDI=;
 b=UJVhRLh7VFAobq7w7fiGN2F0blRAfUhV6aPvxodcHMkiAN3CsAkY3cGXpi+hOJlRLO
 5SUP46ZCqOgHLh9+lh002JsyE3x4AiI/KIPZxyaTa+Fnz2bRlq+bm1RR0vbNRIDINz8/
 1AzkIhVTYbgLpsn6NCXUDTOfE/LxsIqUnqE3tXEE4U8MSVJRkE0gS0Y75LBvdHtYPV2f
 TtcIkuYkPQKlInroew7ij0MfI1kZL4uSc40Z42wGtUaaPIqXf8Rg3tEOcA03Bb/EodFa
 DHEv2Y7AocjvokaCfHI487RLlky+7o+pyC7oZTKV83DcLp+7Ps/io9QwkqD3Wx2q2vFU
 Ci8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXY2mSWQ0MtK4i9fgWVXvpLaeZKH+xPZmFnfpoiDko2TzTiqQU/HiNGekx/A1y9OzwW7bOrKw2t1Zk1NZYYhKDumiE7txA=
X-Gm-Message-State: AOJu0YyNHQMesMIy05UmGegpuugpHQ4h9gvB87ZL0L9tYRmD4oBIZq00
 vebNfMWk8dEVqOtnkFwJ2sBDXZnLGPRN4riyYqfZiSjVL5WaRfwG+zgB+g6/7C8oGIgaPgXLBkm
 kjFXxoCNEIo5x28rBzO0qf3cPzB/0m5+Gok9HLwfibsu8eOv9urxE
X-Received: by 2002:a05:6512:2c90:b0:530:ae4a:58ce with SMTP id
 2adb3069b0e04-530b619a8f6mr762581e87.11.1722490897686; 
 Wed, 31 Jul 2024 22:41:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEb7oMEF1ivDPBIyU5TmsCRvgelayVQs9m7PgG3SNmvBrexul8KscFRQ7ECv3zLmuVjTFitHQ==
X-Received: by 2002:a05:6512:2c90:b0:530:ae4a:58ce with SMTP id
 2adb3069b0e04-530b619a8f6mr762553e87.11.1722490896896; 
 Wed, 31 Jul 2024 22:41:36 -0700 (PDT)
Received: from redhat.com ([2.55.44.248]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acadbb910sm851016766b.225.2024.07.31.22.41.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 22:41:36 -0700 (PDT)
Date: Thu, 1 Aug 2024 01:41:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Xu <peterx@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 akihiko.odaki@daynix.com, jasowang@redhat.com,
 sriram.yagnaraman@est.tech, sw@weilnetz.de, qemu-devel@nongnu.org,
 yan@daynix.com, Fabiano Rosas <farosas@suse.de>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 devel@lists.libvirt.org
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
Message-ID: <20240801013925-mutt-send-email-mst@kernel.org>
References: <20230731223148.1002258-1-yuri.benditovich@daynix.com>
 <20230731223148.1002258-5-yuri.benditovich@daynix.com>
 <ZqLPLBnbfD5r6z7D@x1n>
 <20240726020656-mutt-send-email-mst@kernel.org>
 <775ff713-f7d3-4fdc-8ba0-4ebde577040d@redhat.com>
 <20240726032520-mutt-send-email-mst@kernel.org>
 <fb5fbcbd-ff55-466f-b48b-aa12adca3179@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb5fbcbd-ff55-466f-b48b-aa12adca3179@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jul 26, 2024 at 07:39:46PM +0200, Thomas Huth wrote:
> Anyway, while we're discussing solutions: We are in softfreeze already.
> Should we disable the UFO bits in the new 9.1 machine type for the time
> being to avoid that more people are running into this problem?

At the moment I'm looking at solutions for 9.2 I don't see how
we can do much for 9.1. I mean we can move it back to behave like
8.1 (IIRC), but that is not much.

-- 
MST


