Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D83BCCD8C85
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 15:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJZbX-000701-WC; Thu, 13 Nov 2025 10:51:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vJZbW-0006yl-36
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 10:51:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vJZbU-0002gH-5t
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 10:51:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763049078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qoPmiEZow0NsTzKvPxRL9fPhztwpsWf+/PvpHIEw2Ic=;
 b=ch/ty2udfCg0pLn6Yb59+XCiYFwpwA6L3Q15t4PQ3ubl57YoJmVZYGiOCvLYC7i6QUmL/U
 ANp+t4x8kfFAe5qK1Zww/CETevrw9SIAH42Y7n6wlP0+3o/3cbtHL30UkNVxKIOj0021hT
 33Wocs6BtYYKM6Ls6DkxR4XXUlklEFE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-0HEDhVQDMpKMQDESBayORA-1; Thu, 13 Nov 2025 10:51:16 -0500
X-MC-Unique: 0HEDhVQDMpKMQDESBayORA-1
X-Mimecast-MFC-AGG-ID: 0HEDhVQDMpKMQDESBayORA_1763049075
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-88238449415so48158126d6.2
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 07:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763049075; x=1763653875; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qoPmiEZow0NsTzKvPxRL9fPhztwpsWf+/PvpHIEw2Ic=;
 b=lu6iUBgSoeMudnbjn4tCPwvsgz8vY1BZ2KHhdA2zD2sDzFhRpimvQVULe3hTsvXhVT
 pFEFTiEu76PWx2kAAnUzGo93jS3V1rO2ErvW7DO3iWOlferScpyJXzBESzYOzs/F2AXF
 AZgrxSYsu9hyNmkM6zAjr8TTQcyg2ma90jMvUfnK1t26b+XyfZGUerRXuRVgGwiGZ6l5
 c4pj+ieNAB/dw1k/+E1/xz/LeBznP6Xe2XFLQshgKIYv78Q88rjm/gxFcdVelF2pL3tD
 rDaUCqyQNetKEP4owrOtXTEcchWgELW3Vy9+vEFwfroKjnGFlDPdL3mRsIfwxgfl2R8j
 ppUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763049075; x=1763653875;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qoPmiEZow0NsTzKvPxRL9fPhztwpsWf+/PvpHIEw2Ic=;
 b=U3yz0IsV+te5XmFZ0Syev7U1+RlRdvC7kpgbsEYSfL0Ghw4vVf5+gI3ILUW7jhMkHx
 0m5l8VA6aew0KLmIZ644yjHa4Blbm+K/++SbSXaoT52NQieREkWF5o+Rklb7MFTtyhZp
 zan9dBgZI6im8R8H16APJDXGg8KDWDMKop+le/JQYMA5KipfGxl9JwEk372SQ15k4gd7
 If3d6fiD22bWvBobAFmWFQYdt3Apjghy0o7DlDXc0hIz1HP24xMjNfvlCrILR7ACz3O9
 pYM2Q8z+kFpsybF5nen7VgqmZ9oBD7/tLIOzVoc7a487hDCq7O6KBDo79Jyy9GS5PT3S
 Ihtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7V2awOvFTPSm4dRoIdNrE+1KtRPNtzXCFJ/DA43fUg/ARwE4p1ENvadwoAdwuUPihjdLs5MfTJSsv@nongnu.org
X-Gm-Message-State: AOJu0YypPs8RBB3wnd6VbUS3OKy4AHWuJSIV3+jf1XbbQ5XU89BksavZ
 9CSQpEgObQvPTHesYfxcevY5UnOnVZEzbI+WLH0R2VbbkpxMQiIiCNYnRFkiCbjRiG0h8O13YHt
 kYzwmhRwwdgUWM1pR/voMFKI/h3TQKb80/bo7V42mJ55xstkHn4tsOEy/
X-Gm-Gg: ASbGnctgVPcM6rphHqjpEinj3ZfJce4xTptfhHb+HVbCxa4IM80RHlOw4vyY6mZ3Tz/
 aiI/Xr74E9+rsEi7AKehJ+ZHneV2z/H1bK6a7+jTtzlI9pHXKPM8P1NZcPTCOiCGksug6jVVTgk
 c99bi8S5ovOMiilrkcjCz493/w30upBEX2NC2WJzL5lGO0f2DTFFthvO997GjbpCKw466IcV/9q
 VouSNsLr6igX3OLpfsC6J6sNBsOndEpkAS/SirZWenWn3f3Mmh9N6onPLozE44bAJUIsaS6iwBV
 SSSsS2XazQR4A6oi9E1j5JTF19BvyJqd8ljsdyVc9/xQlci2wpVJEwEc4aNGkomcFeo=
X-Received: by 2002:a05:6214:e8d:b0:880:5bff:74d6 with SMTP id
 6a1803df08f44-88271a38ca7mr117099506d6.51.1763049075506; 
 Thu, 13 Nov 2025 07:51:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjZ5zdJwElwtryBctCMDxY7guTFKjF9ra2UCz2SI+QxoJiiexs9yoY3uhPZkQS74Ojsbl4tg==
X-Received: by 2002:a05:6214:e8d:b0:880:5bff:74d6 with SMTP id
 6a1803df08f44-88271a38ca7mr117098956d6.51.1763049075101; 
 Thu, 13 Nov 2025 07:51:15 -0800 (PST)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ede8815a22sm13964031cf.25.2025.11.13.07.51.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 07:51:14 -0800 (PST)
Date: Thu, 13 Nov 2025 10:51:10 -0500
From: Peter Xu <peterx@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, mst@redhat.com,
 qemu-devel@nongnu.org, farosas@suse.de, jinpu.wang@ionos.com,
 thuth@redhat.com, berrange@redhat.com
Subject: Re: [RFC PATCH] virtio-net: introduce strict peer feature check
Message-ID: <aRX-bodzFk2TuVYo@x1.local>
References: <20251107020149.3223-1-jasowang@redhat.com>
 <aRUCXvHkpfZgZCR0@x1.local>
 <CACGkMEui+A8HFpxKpaSjLTqJHPSaq0Pko18af-APYguznK6bOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEui+A8HFpxKpaSjLTqJHPSaq0Pko18af-APYguznK6bOg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Nov 13, 2025 at 08:31:14AM +0800, Jason Wang wrote:
> On Thu, Nov 13, 2025 at 5:55 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Fri, Nov 07, 2025 at 10:01:49AM +0800, Jason Wang wrote:
> > > We used to clear features silently in virtio_net_get_features() even
> > > if it is required. This complicates the live migration compatibility
> > > as the management layer may think the feature is enabled but in fact
> > > not.
> > >
> > > Let's add a strict feature check to make sure if there's a mismatch
> > > between the required feature and peer, fail the get_features()
> > > immediately instead of waiting until the migration to fail. This
> > > offload the migration compatibility completely to the management
> > > layer.
> > >
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> >
> > Jason, thanks for help looking into the problem!
> >
> > Am I right that after this patch applied, whenever a new QEMU boots with
> > the new machine types (e.g. having USO* by default ON), will fail to boot
> > on an old kernel that doesn't support USO*, but ask the users to turn off
> > USO* features explicitly in the virtio-net devices?
> >
> > Thanks,
> 
> Yes, I wonder if this can help in dealing with migration compatibility issues.

Yes I think so.

The only thing I do not know well is how much risk new qemu will start to
fail boot on old kernels.  One thing we can do here is be less aggressive
on set default-ON to new network features.

E.g. for features like USO* we can avoid turning it ON by default when
introduced, but wait for a few more releases.  Distros / Downstreams can
still be aggresive though to tweak the default if they know exactly the
kernels to be run on top will be new enough.

Thanks again for the proposal, Jason.  Anyway, from migration side, feel
free to take:

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


