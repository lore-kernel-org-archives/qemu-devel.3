Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A88E6C617
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 08:10:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tINz5-0003I0-Og; Tue, 03 Dec 2024 03:10:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tINz4-0003Hs-VK
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 03:10:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tINz3-0000wZ-Ee
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 03:10:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733213410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=berU8+0BSWRrJjyWHzUStLXf1HwOYhRdSsSa59zUCuU=;
 b=FsQi7TLFtt0kk94fKwJ4Uo1OwSRiLXhA18NmHQTxIZQkLCRCpkZXnNuRjvt+hXCFAdYWzr
 Zjs4ProVRXGdFoDp7hCEGxqSA4Xawr2SKx6hoPXyme/GEpG9hw5nLHrE+DMnc9/YIW6q3z
 MkuF7Gi/GWoaAFi7cLE3HZ30ARR9Hmo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-rPeqWmCWNhmzLUR6zrqA1g-1; Tue, 03 Dec 2024 03:09:02 -0500
X-MC-Unique: rPeqWmCWNhmzLUR6zrqA1g-1
X-Mimecast-MFC-AGG-ID: rPeqWmCWNhmzLUR6zrqA1g
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-434a6483514so38347655e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 00:09:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733213341; x=1733818141;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=berU8+0BSWRrJjyWHzUStLXf1HwOYhRdSsSa59zUCuU=;
 b=dOhRl6F1OFB/SzXzOvu0IqwhLXTxdWQlisdYxDs92bkXMpoL0LZ8X+TrKi5MB4VS/4
 XCJm0tpieGOoHyNYPO3ZPKr/BLOvELMGB8BNL5rRmLpfrNL2qLWnFMPG5sfpx591rI1p
 RrxsrCy7a/NkuLxjV7e+/a0lQJ1PAiCqRUqnjRNNbGoR23zsLPJSIEkYAVx7j1F/H1ay
 Vz0H4gwWgLL4ATSZXI1Vd39/Rkr68nzgGNxgbkeyhDkQOu813Lx0G2fnlP47VLCEsLjK
 yUjCwMl7wVrfwbjpBAD1EXVL5nT7zUgvc+hDsZHmKp6oT9FvxwyYNWaik5ebwRZOe8zI
 CI+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUa/eg/8C7b+a2s/iEB4Q/CTeHM8fO+tzc1u8BfKpoTvPOoVIArOa3heib520y3iECw0GT52mbIzgWu@nongnu.org
X-Gm-Message-State: AOJu0YyBeXp4xxA0TemMlXzm4UQkXGiiE5fyI8zXwDwk6+dIMZ6R+EUf
 3GVy+h2pPSrCXJDQO+naLkIzoFw4hKHuEcuB4gniN/saahFZ9sSLGh8b3zVKv+go9qn+yx/A+5d
 61KmMsDIFC1CQbUxj2TXwiZVkYc18rvapRAG1DPsItfapfeTQZB/C
X-Gm-Gg: ASbGncuYv9KucUhEYRqYpg0qnsKRHm7AZQORVrlCPSJB5shup3q5uJRXyhhL9Z/t30a
 ftgV79k4lil/hL93ooRLUR1BbHtwjXr1AYl1bYz0fPRjFGPEpe0Z5hudhRnybMfIap2w+a8SprQ
 OXB/yiVFGCUPyP4wV2InI2dhh+ySmsS//NyEzesSFwkT9O773YU3obZEVBWWkgPfjyrxarO7xAo
 Hqy2kBm/31+TFyk0kqkf+pAIk4GbBrLbAQU60scc+LxYg==
X-Received: by 2002:a05:600c:3b8c:b0:434:a4bc:535b with SMTP id
 5b1f17b1804b1-434d09bf66dmr12013645e9.11.1733213341538; 
 Tue, 03 Dec 2024 00:09:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0bo9L2tJGNgCLRS+6HFIb7X5g8B/ywRhV0qhjtKO2hnaLySkdY0Sq1DqtfzEgDmpy4KlEAg==
X-Received: by 2002:a05:600c:3b8c:b0:434:a4bc:535b with SMTP id
 5b1f17b1804b1-434d09bf66dmr12013415e9.11.1733213341147; 
 Tue, 03 Dec 2024 00:09:01 -0800 (PST)
Received: from redhat.com ([2a06:c701:7402:1000:4d81:c2d:7e70:9636])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434b0f70d91sm178130005e9.39.2024.12.03.00.08.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 00:09:00 -0800 (PST)
Date: Tue, 3 Dec 2024 03:08:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: David Hildenbrand <david@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Martin Pitt <mpitt@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 0/3 for 9.2] hw/virtio: fix crash in virtio-balloon
 and test it
Message-ID: <20241203030839-mutt-send-email-mst@kernel.org>
References: <20241129135507.699030-1-berrange@redhat.com>
 <24ae6e7a-1cba-4898-bfbb-5f5d3e5c3256@redhat.com>
 <6bf49e96-8939-4ee3-aa4c-4ff5ae5e4e21@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6bf49e96-8939-4ee3-aa4c-4ff5ae5e4e21@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Dec 02, 2024 at 08:50:55PM +0100, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> On 2/12/24 18:05, David Hildenbrand wrote:
> > On 29.11.24 14:55, Daniel P. Berrangé wrote:
> > > See patch 1 for the background info on the problem
> > > 
> > > Changed in v2:
> > > 
> > >   * Add qtest coverage for the crash scenario
> > > 
> > > Daniel P. Berrangé (3):
> > >    hw/virtio: fix crash in processing balloon stats
> > >    tests/qtest: drop 'fuzz-' prefix from virtio-balloon test
> > >    tests/qtest: add test for querying balloon guest stats
> > > 
> > >   hw/virtio/virtio-balloon.c             | 16 +++++++-
> > >   tests/qtest/fuzz-virtio-balloon-test.c | 37 -----------------
> > >   tests/qtest/meson.build                |  2 +-
> > >   tests/qtest/virtio-balloon-test.c      | 57 ++++++++++++++++++++++++++
> > >   4 files changed, 73 insertions(+), 39 deletions(-)
> > >   delete mode 100644 tests/qtest/fuzz-virtio-balloon-test.c
> > >   create mode 100644 tests/qtest/virtio-balloon-test.c
> > > 
> > 
> > @MST, do you want to queue this or should I do it? We should get this
> > into 9.2.
> 
> I'm preparing a PR for tomorrow; I included this series
> amending:
> 
> -- >8 --
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2b1c4abed65..51e3a79b6bb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2227,6 +2227,7 @@ F: hw/virtio/virtio-balloon*.c
>  F: include/hw/virtio/virtio-balloon.h
>  F: system/balloon.c
>  F: include/sysemu/balloon.h
> +F: tests/qtest/virtio-balloon-test.c
> 
>  virtio-9p
>  M: Greg Kurz <groug@kaod.org>
> ---
> 
> Tell me if it isn't appropriate and I'll drop it.
> 
> Regards,
> 
> Phil.


Go ahead.

Series:
Acked-by: Michael S. Tsirkin <mst@redhat.com>


