Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02920F9D0CD
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 13:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCdPG-0003YS-Il; Tue, 14 Apr 2026 09:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wCdPD-0003Xy-6K
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 09:02:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wCdPA-0003K8-3S
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 09:02:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776171728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7v7RAsPiBBjIsh3V4W8l0+fXdNpFpnv7O4lfHKteAWY=;
 b=CclGarKb0IwbgYdQUXBVoLPlILXJ+8AhrN+TdyMwZ/vIE9kWLgSV0k3R53deAJXafi63zx
 Mejuh9z4iWFmin3qzibct1dYCvpxBiXHP9ABM/iFOa9VoFCZ0E6rizSc+OO9a8f/Slu/aP
 fuzrIUlA2lOSR1zC3aBicxgeeignIUE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-0ccghJb5MnelWtn-_Tw9Ug-1; Tue, 14 Apr 2026 09:02:07 -0400
X-MC-Unique: 0ccghJb5MnelWtn-_Tw9Ug-1
X-Mimecast-MFC-AGG-ID: 0ccghJb5MnelWtn-_Tw9Ug_1776171726
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43d1bfbd219so4069313f8f.0
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 06:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776171726; x=1776776526; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7v7RAsPiBBjIsh3V4W8l0+fXdNpFpnv7O4lfHKteAWY=;
 b=aUQEVISVl/Ir1L1AqZe8+knAtrbdEp/vJCJIRPKVMSEmXT7y+iRhOcWuxUcTWxLpVk
 g4/ZtRMLjkn4Vh46b2eJxK8yTVkgARuBnpwbWMyt7sfdeBvFtM1Nwi0/G0ibZ20VKQ2T
 aIVF/y3FMHHK2ZwFh0u/UTv9vQzCFKrpeAcXQyM1HyTG8gJNHyn2snrmaty5aPoA5yzK
 cQx+2qLMnkVR6tJRtpOunkiWUhFAVlsRQQVr8v9JLH4ttLEtz2PNL4779qjvMdTuibX6
 ksr2TEik4rYA/yoUFtEsOoIH0JqRZeuZGa50Onx92xwWMlmJ/xsfdw606kjDZ4t3gL6K
 HTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776171726; x=1776776526;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7v7RAsPiBBjIsh3V4W8l0+fXdNpFpnv7O4lfHKteAWY=;
 b=WvXbkjKx2G+xPBkPmOTBbEE+99yKphSX1zjxYxH3UCO/hlfPcRDskuavbM3EJ2DEiv
 0i67GEi2hqXxY9wDoYPJ5Zg/uXDKkDSalifq+KP4nG5aeKx+bYWIGsOrKxW+6gB7k2ge
 dpcfyXBIiTPqutKkAjiksic2rRMVTjr2oNYOCgBxriDv167X/DIfNEWH9xLyaQPyzrc0
 JrqCf+7chzHN7M6EAZN/mFkdJyjer1/7/93rzQ9Nag3AXtQpQiiaULoaADz5UiRFHK03
 dUEePSZG8vSBWDNWaRQiz/ocKkisn9xKeKTs8n0/VKEjBwAg+CCG6hVY9dGwy4leMiA8
 Wg+w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/WqXVgmjb9k/iC5ziYNqyuukpz59ql1ATT8Z0g8uk+mRGuz6ScS6KOr9mCSqrQImobXuOxFWahVi9u@nongnu.org
X-Gm-Message-State: AOJu0YzAWpqRGeV53pjIYrqAvtWsjPMbZyFwqtyXPABoKUsGIRFoo4sX
 j6ZWuISEQnWgWXDropvhoZbvVxRFdgv+HRiBbLh56aAIN7gPEzl+hgvhKkzienzF70nEre6kr+u
 9c6qEvKkahlAY8Spa6UCHsBavys95NnIK5Pm+A1druXRiXMs1rJg1xCKp
X-Gm-Gg: AeBDieu75t3hxTnA1zKt9NtnUyM7YB58QCicnpdZrL/YBKFe3haGJG01quiPu2QV9n6
 +cnTw3tEnkb88kHdg1cf2hHH3Zi1eCYJAfZlBN9FB0kX05Tuc1bEt3AuUSUejBe2YrYh83uGkfo
 dEsurQxLs70XzxG91D3Ph425r+AChEyHL1GVKo17lcGy8eVnIx5XjaXpVozwXp1MtguQT4ONq8n
 L6OxUHX7CNDB93KidoqpRBpiY3uh6IAf3VXyfLhQ8l0wUe4OvyDM8Z8ewjvigHHVTrgfMobTC10
 TmyXp/MmjFGtnuZIJAhpXr+jq+ZWSApxJmIGFFvANy5Ggwl8jgmbw4Od9rxDba73cSfCCrfc/xj
 ZmvCw5/q2sujkHBuNHl04jrizE75Rjr9+D1KBntK6vwE=
X-Received: by 2002:a05:6000:220b:b0:43d:70b3:7ee2 with SMTP id
 ffacd0b85a97d-43d70b3811emr14611339f8f.1.1776171726084; 
 Tue, 14 Apr 2026 06:02:06 -0700 (PDT)
X-Received: by 2002:a05:6000:220b:b0:43d:70b3:7ee2 with SMTP id
 ffacd0b85a97d-43d70b3811emr14611254f8f.1.1776171725343; 
 Tue, 14 Apr 2026 06:02:05 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e46713sm42626103f8f.21.2026.04.14.06.02.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 06:02:04 -0700 (PDT)
Date: Tue, 14 Apr 2026 09:02:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org,
 manos.pitsidianakis@linaro.org, slp@redhat.com,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 stefanha@redhat.com, stevensd@chromium.org,
 Laurent Vivier <lvivier@redhat.com>, jasowang@redhat.com,
 Peter Xu <peterx@redhat.com>, hi@alyssa.is,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, dbassey@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v14 0/7] vhost-user: Add SHMEM_MAP/UNMAP requests
Message-ID: <20260414090046-mutt-send-email-mst@kernel.org>
References: <20260304165223.2166175-1-aesteve@redhat.com>
 <aak5QkV_RxUEnV_f@sgarzare-redhat>
 <20260305032601-mutt-send-email-mst@kernel.org>
 <CAGxU2F6sEwLZXLy1TrH-s9At0YiCc9AQMC5FWdyiHCXk-dE3vA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGxU2F6sEwLZXLy1TrH-s9At0YiCc9AQMC5FWdyiHCXk-dE3vA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 14, 2026 at 01:57:28PM +0200, Stefano Garzarella wrote:
> On Thu, 5 Mar 2026 at 09:26, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Mar 05, 2026 at 09:06:20AM +0100, Stefano Garzarella wrote:
> > > On Wed, Mar 04, 2026 at 05:52:16PM +0100, Albert Esteve wrote:
> > > > Hi all,
> > >
> > > Thanks!
> > >
> > > This is now fully reviewed, Michael can we queue it?
> > >
> > > Thanks,
> > > Stefano
> >
> >
> > yes, I tagged it already.
> 
> Michael, I think we missed this series for v11.0 :-(
> 
> Can we use this for the next cycle, or Albert should repost it?
> 
> Thanks,
> Stefano

Indeed. Sorry I was less focused than usual. We can use it I think.

-- 
MST


