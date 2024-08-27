Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D35FFC54736
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 20:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj3G4-0007Er-KW; Tue, 27 Aug 2024 16:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sj3G2-0007DE-WF
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 16:57:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sj3Fz-0003bg-DI
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 16:57:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724792255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zlOAZ1ucvHWMwTxy2YsSKGk/n9U1bb66io97vZemYtY=;
 b=LzY06fhu8weaGoEtmPGhL4ElSuql1cFYnNd9vWy4PUNdQKPGj8G7Pj550prfz5+rhsUAjs
 9gaSF/Uj7H1s3rUBmg0BMtsdSVd0ECMtkMB+lhYWLg/hYDVbiwTMv6wXIH9VTFp3MR2WaV
 W5jOd80tNNfPscXLrBf3oOsw7AkGozI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-AXF9n53QOaKPWps4DAyf-Q-1; Tue, 27 Aug 2024 16:57:34 -0400
X-MC-Unique: AXF9n53QOaKPWps4DAyf-Q-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a8698664af8so10358266b.0
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 13:57:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724792253; x=1725397053;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zlOAZ1ucvHWMwTxy2YsSKGk/n9U1bb66io97vZemYtY=;
 b=dAqdmyfMCQrt9083GRKvH1eS3qQBfyRgXJFEZ/iTRPwWlMTB4tNaYW+caEDGpo3jeO
 ci9afmb2f0k+0Z4VClIDobcI56jiM13dMUt2zWdLsIRn1eZWBfB22C/yYIK4jycPcyPO
 Dqk2tJ2Zu9e7kgyXnxNBfNmli30LJXR3kWeCRqiBHJv3s8SeT9ZrIt5uB8l9wseRpkfC
 XcdDOJCiyz+xfzDE0Fjxh0H/B1KrpbTbZ+Ki3O0fXNK0c4qaOwnHCIqSQbQlFR0DrITm
 uc2LFSnlYpfSR4NFbg6Vd9aAPEOzD90v1S9Fb6/Sjz1zIlC466rLzO39F9KuBP9XU/f8
 LUzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMUX9H1uVmkWnvXaCVfu1HYP78St1FUX/57OfFwMPkgJGAEJtv42ZB32FP9mR1sIG4KMY+AOm0iV+L@nongnu.org
X-Gm-Message-State: AOJu0Yx/mXrR1e1ywWvNFr6joIgPGQQsZCC1+QNlo5ZZblkRsekaHHBn
 KR7P2bzjKZssrSwbgzeCKz2HMLXL311ebJp/wJzljJ20WXBUUr3b/yyAda561f1rmOaTGFcwDIQ
 YUJ83Hokf0sMaIHsTg9P1/sct09GTi8nFrTzfnZXzaGnpOgjBlrF0
X-Received: by 2002:a17:907:1c0a:b0:a7a:a4cf:4f93 with SMTP id
 a640c23a62f3a-a870aacfb3emr3589666b.32.1724792252813; 
 Tue, 27 Aug 2024 13:57:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvz8X1NRdbe71G1MI+rmGk2Z5MQfxwDUYa0pzzMRwHy3MVTTxGM73affdMmWF0lH1Fx948SQ==
X-Received: by 2002:a17:907:1c0a:b0:a7a:a4cf:4f93 with SMTP id
 a640c23a62f3a-a870aacfb3emr3585966b.32.1724792252028; 
 Tue, 27 Aug 2024 13:57:32 -0700 (PDT)
Received: from redhat.com ([2.55.185.222]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a86e548967fsm155557966b.19.2024.08.27.13.57.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 13:57:29 -0700 (PDT)
Date: Tue, 27 Aug 2024 16:57:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Gonglei <arei.gonglei@huawei.com>, qemu-devel@nongnu.org,
 yu.zhang@ionos.com, mgalaxy@akamai.com, elmar.gerdes@ionos.com,
 zhengchuan@huawei.com, berrange@redhat.com, armbru@redhat.com,
 lizhijian@fujitsu.com, pbonzini@redhat.com, xiexiangyou@huawei.com,
 linux-rdma@vger.kernel.org, lixiao91@huawei.com,
 jinpu.wang@ionos.com, Jialin Wang <wangjialin23@huawei.com>
Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
Message-ID: <20240827165643-mutt-send-email-mst@kernel.org>
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
 <Zs4z7tKWif6K4EbT@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs4z7tKWif6K4EbT@x1n>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Aug 27, 2024 at 04:15:42PM -0400, Peter Xu wrote:
> On Tue, Jun 04, 2024 at 08:14:06PM +0800, Gonglei wrote:
> > From: Jialin Wang <wangjialin23@huawei.com>
> > 
> > Hi,
> > 
> > This patch series attempts to refactor RDMA live migration by
> > introducing a new QIOChannelRDMA class based on the rsocket API.
> > 
> > The /usr/include/rdma/rsocket.h provides a higher level rsocket API
> > that is a 1-1 match of the normal kernel 'sockets' API, which hides the
> > detail of rdma protocol into rsocket and allows us to add support for
> > some modern features like multifd more easily.
> > 
> > Here is the previous discussion on refactoring RDMA live migration using
> > the rsocket API:
> > 
> > https://lore.kernel.org/qemu-devel/20240328130255.52257-1-philmd@linaro.org/
> > 
> > We have encountered some bugs when using rsocket and plan to submit them to
> > the rdma-core community.
> > 
> > In addition, the use of rsocket makes our programming more convenient,
> > but it must be noted that this method introduces multiple memory copies,
> > which can be imagined that there will be a certain performance degradation,
> > hoping that friends with RDMA network cards can help verify, thank you!
> > 
> > Jialin Wang (6):
> >   migration: remove RDMA live migration temporarily
> >   io: add QIOChannelRDMA class
> >   io/channel-rdma: support working in coroutine
> >   tests/unit: add test-io-channel-rdma.c
> >   migration: introduce new RDMA live migration
> >   migration/rdma: support multifd for RDMA migration
> 
> This series has been idle for a while; we still need to know how to move
> forward.


What exactly is the question? This got a bunch of comments,
the first thing to do would be to address them.


>  I guess I lost the latest status quo..
> 
> Any update (from anyone..) on what stage are we in?
> 
> Thanks,
> -- 
> Peter Xu


