Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4837BD43357
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 11:56:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9NbW-0001Fs-Mf; Fri, 08 Nov 2024 06:56:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t9NbV-0001FU-7E
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 06:56:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t9NbQ-00064r-Pw
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 06:56:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731066994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g5+zS2G6ieENEX3UjuW+69kgAap4LT5/IDTQOKv3fTI=;
 b=A92y2JnZx0ttgSJ/gjeMUvBlSu4PF1HCFwj67CFZao/N8A0IiHjWcHyJyVmzvSkhcQMddm
 03jhJ6xnYZu7TM6srnSSpgXQ/NN6SSrepa+zyHt0bL6IgH5ljv4n+GoPk7lqY/RD1VrRVx
 2qdqPt1s8wrhROU5X/C0nHP4mm651lo=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-HF0zfx1CMImUckb4klp0nw-1; Fri, 08 Nov 2024 06:56:33 -0500
X-MC-Unique: HF0zfx1CMImUckb4klp0nw-1
X-Mimecast-MFC-AGG-ID: HF0zfx1CMImUckb4klp0nw
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-53d86e159e7so498691e87.3
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 03:56:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731066992; x=1731671792;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g5+zS2G6ieENEX3UjuW+69kgAap4LT5/IDTQOKv3fTI=;
 b=TUxQxFOsC2mmS7+pQJeSuJQTD2zvuOcmF74qrsI2lsZyOYOaysxy+M5RkmAoHEJT7d
 65lN9IXC0BtoSdWJsFO7eKCOVhxFTidXrNfugIccuSV/My71b2qkJ2aedDI3u+mHJOnX
 Sv3DpGcIAIO1ZPNXRg4PJSkrUqCfLs0LjDpzr3TFr4DR3tAzXqolwxDSktIm0s9vykpB
 hAqU/Wb0/0b84FOg7tR02ap75u9GZusZVtlk74ToVW+fbOQaF9RfdZTIecLieh3Z3I5u
 aydC+mF68ANtrwF3Ijn2m+/tHLGdjEnlVILbiAW+1TKKhmsCXSgizdeRHCv6/904eE48
 uQPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyQgCYPlrBvNqsT3xL8i3/rsQehe544HWfT1wlxkY0TG0Tj4XRwTI99p68h95pMWi+z1IYLAXgCsOl@nongnu.org
X-Gm-Message-State: AOJu0YzxHIro50HwT7k8WR3K7eL2ZC8hxX4npUj4cPjVilJTimnGQ/xt
 x+xmo/Auim0ZImcm1RzFIDrfYF3yZNZ/JMsM8xuINetZyTG4eGkzCgfdoAZXyoZBhnKmb9ZgBTp
 sWs0Gbh6YXroQHSppTBfEgZPuQILIh7GsWgsskWpaRL86NOPE9As6
X-Received: by 2002:a17:906:c112:b0:a8a:6c5d:63b2 with SMTP id
 a640c23a62f3a-a9eeff0dccamr213461466b.18.1731066618886; 
 Fri, 08 Nov 2024 03:50:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF71jCWx7FbQM9FfTFOhIuHVJAQg1wATIoRyrDWPnvlInfbfpUKcIYGpoAOX+AXw4TseCi2HQ==
X-Received: by 2002:a17:906:c112:b0:a8a:6c5d:63b2 with SMTP id
 a640c23a62f3a-a9eeff0dccamr213459666b.18.1731066618497; 
 Fri, 08 Nov 2024 03:50:18 -0800 (PST)
Received: from redhat.com ([2a02:14f:179:39a6:9751:f8aa:307a:2952])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cf03b5d787sm1895241a12.2.2024.11.08.03.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 03:50:17 -0800 (PST)
Date: Fri, 8 Nov 2024 06:50:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org, eblake@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, qemu-devel@nongnu.org
Subject: Re: [PATCH] qapi: fix device-sync-config since-version
Message-ID: <20241108065004-mutt-send-email-mst@kernel.org>
References: <20241108071957.727286-1-vsementsov@yandex-team.ru>
 <87v7wydsxv.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v7wydsxv.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Nov 08, 2024 at 09:35:08AM +0100, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
> > Actually it comes in 9.2, not 9.1.
> >
> > Fixes: 3f98408e2e ("qapi: introduce device-sync-config")
> > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > ---
> >  qapi/qdev.json | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/qapi/qdev.json b/qapi/qdev.json
> > index 2a581129c9..25cbcf977b 100644
> > --- a/qapi/qdev.json
> > +++ b/qapi/qdev.json
> > @@ -182,7 +182,7 @@
> >  #
> >  # @unstable: The command is experimental.
> >  #
> > -# Since: 9.1
> > +# Since: 9.2
> >  ##
> >  { 'command': 'device-sync-config',
> >    'features': [ 'unstable' ],
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 
> Michael, can you take this through your tree?

Tagged, thanks!


