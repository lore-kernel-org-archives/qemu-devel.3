Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCB3CFD356
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 20:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNdZg-00071A-8O; Mon, 24 Nov 2025 15:54:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1vNdZf-00070y-2u
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 15:54:15 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1vNdZd-0001Lk-9P
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 15:54:14 -0500
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-450ccefe573so2166115b6e.3
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 12:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard.net; s=google; t=1764017651; x=1764622451; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D5OT9GeynPxz0yzBkSQzGi7hrTkfyswJq9BocslwaT4=;
 b=J+lq8JM4YGnUKTUEZ1+bzCKHT6PSqTRCjO7IIvCfnvSPO2dZbfeWSO6+TTNz6aWyYC
 ITgUWRn3cuOrVrccZEPfHb+PkOE0JMJO+/n7PLWxGcGySiuo+EiXCeQ1PccEXWsB070d
 jVTPXBrNHq1Knz+Rr02s1LAJHWH28v2QbZsJxs4lcLI66ozwgbIw10QJbw4CxVs47e8w
 7pkrjp7LfWtzF5VJojhzvbbTCkUApakLfg7DUYSPg/qVdcUpjj/ppBBvPb4reQHApKuk
 4HqWsmGzgwdgO2PVddslsuuZyTNRPkXKqCNqs8q0oLWcRYXKayqJWX7eOfACh/twmTrB
 Wljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764017651; x=1764622451;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D5OT9GeynPxz0yzBkSQzGi7hrTkfyswJq9BocslwaT4=;
 b=BFr5HME4a6wi+rJh7KnBJ1YetqtR4WSWZUn62+aN96/rkweon3SJx05odEQFAtFi81
 Y1SlDzOz5tocX3eJz8yLJn1fAOH4aJ1S3pLblZg1J/QgbfOGLYOpEGCBNi0ozEgUIe+3
 /KTjoa4LvMEeXd17RW/n/GQ9n7rh80P9F0ui5OV7rj5ymrjyN2L6tqms8AxnL/0HmcXd
 FHgcvcI+fvpxqt9DgrVyY329+uJcwvsXGFxDorjBqPNtm4syBbwSOD3icebEwOxEg+62
 MJ+k//6lxDpnyict57dWGI9XHLEN29fyZE1doBVfAcd+rcFE4U5vrzmDU6cunaDXQvx6
 UvAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2dlzynP/vNnSNTYM96yYKWxjU4DRBd56d/vckTpx7pwAA1OO0L95oD6dQrKEv7oKa5KEyk8NdV6lo@nongnu.org
X-Gm-Message-State: AOJu0YwzEi7lDjKI8xCF2cvrbGd4jfWMwwvNZY3s+ktFWXQC/IUs53Oq
 c2yeRM/jExL/bt6h+cVWh1MWlVeXGMStcdo3u6+bGEZduXkeoeB6n+uwH4KyCS1uucA=
X-Gm-Gg: ASbGncsxIKLXr87Y5VLFGnbCRiVY8TBEYylFXDvLMYkywDYtVsae6/ivuzNVgYpADpy
 ebpMVYXAn89Mi4ZZp3mPniDBMVGduM0cM5UX2KNqR0pr5MWo8C3aDU9Us2D/7bxtwn2lO1FGy2Y
 aRigWPNEJ/owFo8jvac89xbXBYEUY18OpjuKz0ISzDuG4aLBKqTOgk9oc4/nFiNUPTeY2vVBYAw
 u8Wkuw2lzRdvKPoAdQtMuC0rlGxvF0YsTuOuy6RCBdBQItIrdz8QHlGnySuB9zs3LJFv51viYC7
 Gj4F9gy93acNvljRtjqv3TrfoOX+/pp2YRHvtAcs1+6knTLawRajlM9J9LWbp2mhYcrigZKFqE1
 pKDRE5R1XM6n6PBePnjlcpAD9Z+23ZeeYed4f/+2BdfEY7czlsx65Lj+sV1vTBkDSzXxXXjVuLY
 gkU0TNPZEGSPwa4w==
X-Google-Smtp-Source: AGHT+IFPlpC9aJfPdJ6kTdj+/DR4BxOVw90B4NumaK0vMVLxlW55Fpb0MySjfI/CGkZ/sbRJf6PPqA==
X-Received: by 2002:a05:6808:1891:b0:450:5ca:5170 with SMTP id
 5614622812f47-45112b4a113mr5312502b6e.33.1764017651184; 
 Mon, 24 Nov 2025 12:54:11 -0800 (PST)
Received: from mail.minyard.net ([2001:470:b8f6:1b:a107:f956:4b48:680c])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-450fffedd51sm4063801b6e.22.2025.11.24.12.54.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 12:54:10 -0800 (PST)
Date: Mon, 24 Nov 2025 14:54:05 -0600
From: Corey Minyard <corey@minyard.net>
To: Yunpeng Yang <yunpeng.yang@nutanix.com>
Cc: "minyard@acm.org" <minyard@acm.org>, "farosas@suse.de" <farosas@suse.de>,
 "lvivier@redhat.com" <lvivier@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Jonathan Davies <jond@nutanix.com>,
 "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 0/2] hw/ipmi/ipmi_bmc_sim: Get/set fake LAN config
Message-ID: <aSTF7QFuXGhNzGce@mail.minyard.net>
References: <20251028180115.1098433-1-yunpeng.yang@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028180115.1098433-1-yunpeng.yang@nutanix.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=corey@minyard.net; helo=mail-oi1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: corey@minyard.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Oct 28, 2025 at 06:01:18PM +0000, Yunpeng Yang wrote:
> Support for a fake LAN channel is added to the device `ipmi_bmc_sim`.
> Although there is no real LAN channel, some testing processes which
> require interactions with BMC LAN channel will become easier.
> 
> There's another device `ipmi_bmc_extern` which works together with some
> external BMC simulator, e.g., `ipmi_sim`. More comprehensive BMC
> simulation can be achieved with `ipmi_bmc_extern`. However,
> `ipmi_bmc_sim` is more light-weight and is built into QEMU.

I apologize for the time on this, it slipped between the cracks.

These both look good.  I can give a:

Reviewed-by: Corey Minyard <corey@minyard.net>

or 

Acked-by: Corey Minyard <corey@minyard.net>

or I can take it into my tree if you aren't bringing it in any place
else.

One thing you should try is doing a migration between a version 1 and
version 2 device, and between two version 2 devices, just to be sure
migration still works.  Assuming you haven't done this already.

-corey

> 
> Yunpeng Yang (2):
>   hw/ipmi/ipmi_bmc_sim: Support getting fake LAN channel config
>   hw/ipmi/ipmi_bmc_sim: Support setting fake LAN channel config
> 
>  hw/ipmi/ipmi_bmc_sim.c      | 407 +++++++++++++++++++++++++++++++++++-
>  include/hw/ipmi/ipmi.h      |   1 +
>  qemu-options.hx             |  26 +++
>  tests/qtest/ipmi-kcs-test.c | 143 +++++++++++++
>  4 files changed, 567 insertions(+), 10 deletions(-)
> 
> -- 
> 2.43.7
> 

