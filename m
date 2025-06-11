Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3F9C678DC
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 13:14:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPLHB-0006jL-Ka; Wed, 11 Jun 2025 09:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uPLH9-0006iv-9y
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 09:13:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uPLH6-0006FM-Mr
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 09:13:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749647628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2su89aEIgTenxnDSOklpXrdmxCCZ2oVVDFqcS7+4ugQ=;
 b=ADbaPJurujob55EzQ4VIT0UFZhKdQJkdVFug/aWv64yPhNmMnOG6m343WpSPkPD7QUJZX7
 jJHiwDHuvJeFi/vZct8qSj1M8BKpMFzebmtOgg5XdDzn+KON4ZENKlPp3O/AlyEQgVa16o
 KpN8y8//V01Oewnmd1+sJmusX+ESIQA=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-r47qxcgZPvWELCH6kbh6PA-1; Wed, 11 Jun 2025 09:13:47 -0400
X-MC-Unique: r47qxcgZPvWELCH6kbh6PA-1
X-Mimecast-MFC-AGG-ID: r47qxcgZPvWELCH6kbh6PA_1749647627
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-2e9b1f85b2bso5945988fac.0
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 06:13:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749647626; x=1750252426;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2su89aEIgTenxnDSOklpXrdmxCCZ2oVVDFqcS7+4ugQ=;
 b=R6b69wZXs42PZAAXShGiqFrqRPwiN65qy9u119PLENKFUH8StNOTl0t/LuzXDHF95H
 dl9lER5XkfDOsCsa5+7bvmVJMSIofr18sC+O7bXK0UF8KvCmGlTOTXHg+jbk6P+KRn4V
 1cyHlp+7v7wMlOEPlfuVyrcVAZT3rUsB462R8Vm0s8NEk8QzzrKMZA4PCsyHCBM8hW6D
 7LbNY1JK0moQS97Zrk/SamoeGbYCngP6phEHu2NZL5wo39zQsa0Hog5JwGD+EcmF8ewS
 aQ9Zbgo52xrRQoS0Vwfnsq2dfppwINFjgO3jpBpwtwh5jaxFaLgkHs/dJ+oYi0Va/isc
 QAHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYb+XPSOCItmW9NfdfEgRRaio3UFvTaIDVmBKmprWQOQrL9l2Y632gUCuipHPAKni7UwEDbO0Yfq2n@nongnu.org
X-Gm-Message-State: AOJu0Yx+uMVfyWH9dpornPz/Vh8nE3M2566HSc6Cyl/1eimJQHpT/CCD
 /sJLvEmQFEAlzYdTTx0S/OkZSUvMnAOWlu/rUvjXA3/Z/+ymlYG0gcxV7kEBsyWIG2Y0VaN/Xk3
 m69WtXCcYqZJQfEptM77gEAi8SkHFsPeiO/2+Yd2OVj4s8usXR6D1VDE/QtoGFzuO
X-Gm-Gg: ASbGnctvpn5XUtwaX5EYm8tmmpURt5Lm3Pg8G2G1VLWZ2hk7vbWYc2xLU6u4z87Sx8G
 evqgac11UaIhgg1SsPbSj5Q1Vapy8yK6t68xA0AEvSKi+32W15in6FyKNtI8gkcRbuQpfZEbyfm
 HjDmOrXFuBDuqeByo1VEeluC3YyQ6wFscCvrEGbMxNd/mI8Ge3JucTHRKTv1JR2GNgGLqBRLarH
 5/bS00hDOH9A680rOxsg9e+ROSDuFzSH5hHluTME+xeo6rE/crJyh21VyYrPTaP/KEa3JQad4lx
 bknXlV336mrNCw==
X-Received: by 2002:a05:6870:8183:b0:2d6:6688:a625 with SMTP id
 586e51a60fabf-2ea97029788mr1904365fac.37.1749647626462; 
 Wed, 11 Jun 2025 06:13:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWdLqllmlYxJLpKilZ/fEDwWsVqWk8pzPebX4I6PRGw8nad+Sk/isRpDOZxtVncD0fqQpCtg==
X-Received: by 2002:a05:6214:2488:b0:6fa:d95d:d0b0 with SMTP id
 6a1803df08f44-6fb2c386dc6mr42563266d6.29.1749647615946; 
 Wed, 11 Jun 2025 06:13:35 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09ab848bsm81228186d6.4.2025.06.11.06.13.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 06:13:35 -0700 (PDT)
Date: Wed, 11 Jun 2025 09:13:32 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: Juraj Marcin <jmarcin@redhat.com>, qemu-devel@nongnu.org,
 kraxel@redhat.com,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH] ui/vnc: Update display update interval when VM state
 changes to RUNNING
Message-ID: <aEmA_NE9GWfTx97m@x1.local>
References: <20250521151616.3951178-1-jmarcin@redhat.com>
 <aEl31gjAjlt5zj-l@x1.local>
 <CAMxuvaxTKMEVHOQyjcyWFw=+LbyfbFJgMb4ZfSjkiT-VJsjAWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvaxTKMEVHOQyjcyWFw=+LbyfbFJgMb4ZfSjkiT-VJsjAWw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Jun 11, 2025 at 04:41:21PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Wed, Jun 11, 2025 at 4:34 PM Peter Xu <peterx@redhat.com> wrote:
> 
> > On Wed, May 21, 2025 at 05:16:13PM +0200, Juraj Marcin wrote:
> > > From: Juraj Marcin <jmarcin@redhat.com>
> > >
> > > If a virtual machine is paused for an extended period time, for example,
> > > due to an incoming migration, there are also no changes on the screen.
> > > VNC in such case increases the display update interval by
> > > VNC_REFRESH_INTERVAL_INC (50 ms). The update interval can then grow up
> > > to VNC_REFRESH_INTERVAL_MAX (3000 ms).
> > >
> > > When the machine resumes, it can then take up to 3 seconds for the first
> > > display update. Furthermore, the update interval is then halved with
> > > each display update with changes on the screen. If there are moving
> > > elements on the screen, such as a video, this can be perceived as
> > > freezing and stuttering for few seconds before the movement is smooth
> > > again.
> > >
> > > This patch resolves this issue, by adding a listener to VM state changes
> > > and changing the update interval when the VM state changes to RUNNING.
> > > The update_displaychangelistener() function updates the internal timer,
> > > and the display is refreshed immediately if the timer is expired.
> > >
> > > Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> >
> > [add Dan]
> >
> > Ping - anyone is willing to pick this one up?
> >
> 
> I haven't started gathering pending UI patches. Feel free to pick it up

I'm queuing it for migration if no one beats me to it. Thanks!

-- 
Peter Xu


