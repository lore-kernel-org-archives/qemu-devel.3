Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D05C3DA7E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 11:38:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYlAu-00048n-W2; Tue, 30 Jul 2024 07:37:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sYlAt-00043F-Fx
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 07:37:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sYlAs-0004FZ-1n
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 07:37:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722339469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gZK/KI1hV5sQPKkIKvFyC7alZL80TlIV+TLtWzNiP+Q=;
 b=O5Y94slxPvrfCq3BzqEDXr1IahL6wdpQQy7nYVoVecHGKSArtjNY/IbTHVgbpYl/UooAM8
 kXbivCxQqsPAGWfXKtyxz8AVNEhnGpL/KN3a4y43FTw7M1jmuA/pSO53b/6/C56F2vZVcL
 CewJOgJN1coub/X8ZYvDnrUsrmqCTho=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-3cmlr9_8NUK4rcHd--Nz1w-1; Tue, 30 Jul 2024 07:37:44 -0400
X-MC-Unique: 3cmlr9_8NUK4rcHd--Nz1w-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a7ab81eea72so394310066b.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 04:37:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722339463; x=1722944263;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gZK/KI1hV5sQPKkIKvFyC7alZL80TlIV+TLtWzNiP+Q=;
 b=FoUoK2pyT1vNyYeEoWMW/4yoreSak3JMWRbuKpFi2Sgvfu6nSrZs8K4J1XokxUaPAY
 H7tsM/L1F2EB/A66aEqWowqwICb2UN2ADQ6xhSDvqlE5oaltc6Q035Zde5RVIl0JAsYW
 hrVqDxeRff7HU0KLJ7rlK/+6ap7W0SZftkDYrp1yoXC5Oobh1BURjrnbxejjNiaO5nkr
 f5zRmkpAlEZXK+ysdwePkRToQcWWY/3HXjNQSbfdlxPg6XfI/2g+ypLbOUdHQRcaAXde
 cZwIrHIL1YD08u8voZj3itcmXvUErjwD8qiIEf9psM1JgP4h19ubg/d+iAP0Xk0oxAgy
 xoQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2fDlSCJKI4sxSb72WtG3w0I2AlvGDzFkeDgh6TNv+AdsReCithRsPIuO2y/+UqS1HnCRjsZsoySusGo98SAMRCdh3vUM=
X-Gm-Message-State: AOJu0Yz3tGe5th5JmEhytJTUW66WRLs0WWNj1URQjgkLLtG1G8TF5atJ
 Ph8Wiom8mC5FvfcGyYKdY2uhG4ITECo7lVqnEpqGO29cG8FBFquauL2TjhLGn4hFKDTRVygqPnr
 sOuTxfNzF31yHjRz6iv1PQkhvWo5zBE1JKn4rH3vHwavRZltl2YmY
X-Received: by 2002:a17:907:7da8:b0:a7d:34bf:600e with SMTP id
 a640c23a62f3a-a7d4015ff44mr735488266b.60.1722339463107; 
 Tue, 30 Jul 2024 04:37:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyp3kaxv0Atyf+rVcB8TUc1cUKurrl7VsdF2CDaLj5/dMTjWDK0Wi1l0DvH4D8NWFWgSkqsw==
X-Received: by 2002:a17:907:7da8:b0:a7d:34bf:600e with SMTP id
 a640c23a62f3a-a7d4015ff44mr735485066b.60.1722339462450; 
 Tue, 30 Jul 2024 04:37:42 -0700 (PDT)
Received: from redhat.com ([2.55.35.236]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acad911a0sm625904666b.155.2024.07.30.04.37.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 04:37:41 -0700 (PDT)
Date: Tue, 30 Jul 2024 07:37:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Yui Washizu <yui.washidu@gmail.com>
Subject: Re: [PATCH v5 0/8] virtio-net: add support for SR-IOV emulation
Message-ID: <20240730073712-mutt-send-email-mst@kernel.org>
References: <20240715-sriov-v5-0-3f5539093ffc@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715-sriov-v5-0-3f5539093ffc@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Jul 15, 2024 at 02:19:06PM +0900, Akihiko Odaki wrote:
> Based-on: <20240714-rombar-v2-0-af1504ef55de@daynix.com>
> ("[PATCH v2 0/4] hw/pci: Convert rom_bar into OnOffAuto")

OK I will revert this for now. We'll try again after the release,
there will be time to address s390.


