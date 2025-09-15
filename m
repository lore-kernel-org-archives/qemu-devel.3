Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C114CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 23:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyIJx-0000B5-5i; Mon, 15 Sep 2025 19:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uyIJs-0000AN-JP
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 19:09:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uyIJe-0003P1-LD
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 19:09:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757977722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UmrCQY5qy1q8dffJaRkx41XnKkWEw8BoFx8icIA+RLE=;
 b=A7o5V67rfsDOzeoWISm//nA/ciy9dOitp4XMEHApGZSiJacuMxnPMEklrjdK8tbjlIA/Oh
 phcfMVZs+pGfN7O9JHQDNXqImXXGFNwnAXVVxNGP6BVuFwpHMP44fCV87kkPvyJTwoXyqi
 c7AC+aJhjirSvrKNOgWlwofp4FemIy4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-MYUsDOxOOX-Q3sIRR6qLyQ-1; Mon, 15 Sep 2025 19:08:40 -0400
X-MC-Unique: MYUsDOxOOX-Q3sIRR6qLyQ-1
X-Mimecast-MFC-AGG-ID: MYUsDOxOOX-Q3sIRR6qLyQ_1757977720
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-afe6216085aso60716466b.1
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 16:08:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757977719; x=1758582519;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UmrCQY5qy1q8dffJaRkx41XnKkWEw8BoFx8icIA+RLE=;
 b=titApYHvu8sHHA2p1i54dzgLvG3++RTUM6JJJdAwys5Ee2pLrIEI/flRIEd2Tf4bUB
 qmHINO3PYbRsl8SknCPiSEa8GytjC63L513VjqgAe3aJTPRQyQPiyJOzKZSNJbtVcAgu
 y/3XqdAMsVHmLOk12dWSFxrQWCx5zNKTp6rQqJsCtlzcGokr9SKkUElYEa9CFsq2GMpS
 cZQ35yzgjuSXrKW+YuvM+PKG9R9EMBNNTa3ts38ueKD/D0J9iz81hnm9DLnjTN1AIb0h
 r6xax/B6EGW723LO+ODxbefM1JHX9BrBQ/i4SiyvUWRuM1xFLFQg/BQXWeaPw4H+jgQ3
 VFgw==
X-Gm-Message-State: AOJu0YyKvpWwrJjrDsGzirSGZwf/Lrz5irxWEDxHzAQfHpaenivJ2A80
 qt2yNTbuv5McV2K7WhrEIgdTRUvyyVpTo93aPzwALamTZkBOJjW7iDAjV7Z2XD+3D33ydROz9r5
 QkqWi/QLh4E1E7vx45kvl76R01JHqC1essMVewOnBNw3Wte4TZ8m0A6Op
X-Gm-Gg: ASbGncvq0JQ99OLB2HskiauoCrddNUQSfsIDCs5/+C/bqvuleMYvTy0KOPO42A3QMr2
 l49tmJy7spbWebk3q84v3Pu8GHYivs/f1asggq1f5pG5UIy5ANguywc6oCEsScPAa/LFS8G6Hl2
 Eea3gG2lKQmX1EinQDAZxscFI2s1zDa+u/Duuf6JN+We6YioK3vVeEa8B0eDI5Vv0AOo12vnYjn
 4WNspmWG8+XYsEGHlIxdJzxCYCRxDOw7uplStRnqG9UH93whV4H3GfcQPkuT9NCd2z0KHoRhp2w
 /ZYu5Ug8RlH+F4/trFYiUrbwdJNg
X-Received: by 2002:a05:6402:4559:b0:62b:2899:5b31 with SMTP id
 4fb4d7f45d1cf-62ed80b6b91mr12207089a12.5.1757977719639; 
 Mon, 15 Sep 2025 16:08:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcLWBItfP7dzGQYzT5Doeuz7bgzQ62gQTnv78tBHSGy8Qf7wuwed5bTgbiOa+Pu2s4iVvP4A==
X-Received: by 2002:a05:6402:4559:b0:62b:2899:5b31 with SMTP id
 4fb4d7f45d1cf-62ed80b6b91mr12207072a12.5.1757977719291; 
 Mon, 15 Sep 2025 16:08:39 -0700 (PDT)
Received: from redhat.com ([31.187.78.47]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-62ec33ae181sm10383955a12.22.2025.09.15.16.08.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 16:08:38 -0700 (PDT)
Date: Mon, 15 Sep 2025 19:08:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Szymon Lukasz <noh4hss@gmail.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v4 00/10] virtio-console: notify about the terminal size
Message-ID: <20250915190638-mutt-send-email-mst@kernel.org>
References: <20250912-console-resize-v4-0-7925e444afc4@gmail.com>
 <ecb9a5310ec1b846124a6342232dd421778df064.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecb9a5310ec1b846124a6342232dd421778df064.camel@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Sep 16, 2025 at 01:02:02AM +0200, Filip Hejsek wrote:
> While thinking about the patches, a few questions about the virtio spec
> have popped into my head.
> 
> 1. Should the config space size also be updated (for port 0) when
> multiport is used? Based on my reading of the spec, I think yes.
> 
> 2. Can VIRTIO_CONSOLE_RESIZE be sent if VIRTIO_CONSOLE_F_SIZE is not
> negotiated? The spec does not say, which I think means it can.

But the guest can't do anything useful here.

> 3. The spec says that reading from config space fields that are
> conditional on features should be allowed even if the driver has not
> (yet) accepted the feature. Does it mean that we have to update the
> size even if the feature is not accepted (yet), or is it OK if the
> reads return 0?

This is talking about the window before FEATURES_OK (and so DRIVER_OK)
is set.  It is best to update the size. There's no interrupt to send
though.


> Thanks for any answers or opinions,
> Filip Hejsek


