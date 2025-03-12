Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B636C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 19:34:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsRpV-0004hN-OG; Wed, 12 Mar 2025 15:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1tsRpS-0004gj-FE
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 15:33:22 -0400
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1tsRpQ-0004PA-BP
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 15:33:22 -0400
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6e904f53151so2018206d6.3
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 12:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1741807995; x=1742412795; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4lSj5k8zELNyNV8ADskYGKCYpCr2239a+4acaXM4eO0=;
 b=e8hQ2x5y3QnngqfIff7t58Va3DCchQF7/32d6QdIwraJW8yNSY0bt4emvIc5nE9plm
 SZhjsAwUK0nG3HhBlYZahLP/CxwLOPoj6voUloJ4jOIjgfIq4vKC07wkt3w/1ySYKMWj
 wzHu94BlMJ0f8URYAJLFxnjnQEBlenJ8uX6wxMaA3dRnlLeuHARjWtD48ufVJ2wFk5LM
 5wlS01d3FF09AM1QtMCQIXod4Cevb785zHfcxLOnIaB7MEhxEzRSJIvkbViupz9z2IGP
 7OGBpEd1NcelSJ5RxTM9vIEZGTyzUqkKPj9/uoyiS1ahj0nNGPFTZZ15pb1LtlsFxhhF
 rd+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741807995; x=1742412795;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4lSj5k8zELNyNV8ADskYGKCYpCr2239a+4acaXM4eO0=;
 b=LXut4/+UyU64gXidDK8wGyx4cMHty6xWQEO810ToabMOV3rQ5V0v0bwjb5Vaq853up
 2IgmJsn8LLieNWbwnwVdT1v90tNpFj8H5V78wCqK6ZMv1VK2Re106b0171jqlgQZnJo1
 ChulTqHq9J03sHPLN+wzV6pgTZwg21aQ+WrugwDdSTwEU0rF396nqaTHNAckarWuhigE
 9N3LIYc3kioRBj0wjARpmGP1RWFW4KBJbNxPmkyXZLntQNm06S5GdojnP41Gk2jo/h4v
 s2igmIjwdHNwC/G0n4g3NEF/3tBS4mi7ljfuXVquaetA0LvVxtVyhpwyi5wXBUOP+9+N
 zjJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzprzynS4FZDIIzYgJV2rcRF11KSVUHiR8QF8mqYO6JrtVXuLajwmOxxafmXUx5aEvB+Bj3TPiI+qm@nongnu.org
X-Gm-Message-State: AOJu0YxfqSwl1RdGVH3jWDzjyhzQouNlZ5kiK8EGYOeDf46eayQ4o8Sl
 0phiRKqijdhRgIbtZWeDSNXIspYxLXOGIGUN8xSwS+UV+uLaezZCx3IfEW6IX6I=
X-Gm-Gg: ASbGncuJa0/wA3DcpCFXZ8CR8qQ9Et4/5IpFpPxLQmBNS3IzsKipufQYf0UCTMsDnMY
 8np8be/su2yCRa+hva8ptOtghR6Egle/oRbcZC/wHb16CgAHBADOG1iiTmL9zwKjFzG18cCQIbZ
 I5t8LDW8M6htqNVnyknP5zm2Af0utbuB6/V/NodbLaHhqXAlsvVRnXC+v4FNyMmQmI1cJNdqpt8
 aaxx+LhVbUCxNIWj0cmo7bgRIRHipDOoppyubz5UW+ilfquq6/XQAGeK1j2gmuEqabH6BzK9wG/
 Wne+o06GdFzUf0MvhhrIO2mOWtl/qh2CvXv0uImunUD3evgL53JpMAWXB4bRnr7kgSw2z7wkJqo
 0ioM2SNg/Cmu3Rs8nFApkbxkOxlA=
X-Google-Smtp-Source: AGHT+IE8Wv9W2LFd3SjqsjDb1ASTUBm3QlDnMDYoy+21dIVTqr1Ac3ElC6HUJGyQiIjvs6vR9X715A==
X-Received: by 2002:a05:6214:29ef:b0:6e8:9d00:3d71 with SMTP id
 6a1803df08f44-6e90063cdc2mr301059276d6.21.1741807995269; 
 Wed, 12 Mar 2025 12:33:15 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f7185065sm88409476d6.124.2025.03.12.12.33.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 12:33:14 -0700 (PDT)
Date: Wed, 12 Mar 2025 15:33:12 -0400
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Junjie Fu <fujunjie1@qq.com>, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org, viacheslav.dubeyko@bytedance.com,
 zhitingz@cs.utexas.edu, svetly.todorov@memverge.com
Subject: Re: CXL memory pooling emulation inqury
Message-ID: <Z9HheFFgOdGE9BcW@gourry-fedora-PF4VCD3F>
References: <20230215151854.00003e34@Huawei.com>
 <tencent_E9F3F01E0D2303378E16505CE4CF208AA908@qq.com>
 <20250312180543.00002132@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312180543.00002132@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::f36;
 envelope-from=gourry@gourry.net; helo=mail-qv1-xf36.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Mar 12, 2025 at 06:05:43PM +0000, Jonathan Cameron wrote:
> 
> Longer term I remain a little unconvinced by whether this is the best approach
> because I also want a single management path (so fake CCI etc) and that may
> need to be exposed to one of the hosts for tests purposes.  In the current
> approach commands are issued to each host directly to surface memory.
>

Lets say we implement this

  -----------         -----------
  |  Host 1 |         | Host 2  |
  |    |    |         |         |
  |    v    |   Add   |         |
  |   CCI   | ------> | Evt Log |
  -----------         -----------
                 ^ 
	    What mechanism
	   do you use here?

And how does it not just replicate QMP logic?

Not arguing against it, I just see what amounts to more code than
required to test the functionality.  QMP fits the bill so split the CCI
interface for single-host management testing and the MHSLD interface.

Why not leave the 1-node DCD with inbound CCI interface for testing and
leave QMP interface for development of a reference fabric manager
outside the scope of another host?

TL;DR:  :[ distributed systems are hard to test

> > 
> > 2.If not fully supported yet, are there any available development branches 
> > or patches that implement this functionality?
> > 
> > 3.Are there any guidelines or considerations for configuring and testing CXL memory pooling in QEMU?
> 
> There is some information in that patch series cover letter.
>

The attached series implements an MHSLD, but implementing the pooling
mechanism (i.e. fabric manager logic) is left to the imagination of the
reader.   You will want to look at Fan Ni's DCD patch set to understand
the QMP Add/Remove logic for DCD capacity.  This patch set just enables
you to manage 2+ QEMU Guests sharing a DCD State in shared memory.

So you'll have to send DCD commands individual guest QEMU via QMP, but
the underlying logic manages the shared state via locks to emulate real
MHSLD behavior.
                     QMP|---> Host 1 --------v
               [FM]-----|              [Shared State]
	             QMP|---> Host 2 --------^

This differs from a real DCD in that a real DCD is a single endpoint for
management, rather than N endpoints (1 per vm).

                                  |---> Host 1
                [FM] ---> [DCD] --|
		                  |---> Host 2

However this is an implementation detail on the FM side, so I chose to
do it this way to simplify the QEMU MHSLD implementation.  There's far
fewer interactions this way - with the downside that having one of the
hosts manage the shared state isn't possible via the current emulation.

It could probably be done, but I'm not sure what value it has since the
FM implementation difference is a matter a small amount of python.

It's been a while since I played with this patch set and I do not have a
reference pooling manager available to me any longer unfortunately. But
I'm happy to provide some guidance where I can.

~Gregory

