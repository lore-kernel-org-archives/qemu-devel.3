Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1DBDC369A2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 18:21:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3J0E-0005Xs-Qz; Fri, 11 Apr 2025 14:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1u3IzE-00051C-Et
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 14:20:25 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1u3IzB-0005wd-WA
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 14:20:20 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2cc44c72959so1409105fac.0
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 11:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1744395615; x=1745000415;
 darn=nongnu.org; 
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IRic3E9H0h1NDxZNuxMalh4Ll9zBvxVnof4d9U7N7NA=;
 b=KEjVXw18lDTog4kopqinPkT+m66T74yGsBCrNso3K9gFU219Ou+RqdeQehX6USNWoD
 HVv4A7WwWWseLKimjQqbOSAm+xWQLo2FWOD3efUUYuH6vPuVLeM08DPreRn1M68KqN/h
 cZ2p8bDqUI3FQUi6//vdsL4OjUiKNC9PPeeOSdifkiF1bRar5MWOUlDYS9719SQWw+aI
 JBo14UpGWuuyEjCllFVpWbJbD1WaOHDhyfj0w79JvpG0IfXNlahB5DL2BEbCnaS5vV2R
 1uXvID3ieSQqslsQEdSxGEAhJqskwFdSaJrifLME73DkoFX/YPufjk072Wf6ff3Zl26u
 tiLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744395615; x=1745000415;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IRic3E9H0h1NDxZNuxMalh4Ll9zBvxVnof4d9U7N7NA=;
 b=TenySaurhUd0x6LGDpCgz75j8kWumdz2QksnRqBVzgbDsrvH6PE3shOuA4m35mvzeG
 /tV7geisnycGhCXWnjFCDTFzJrFaeRoHK7iXW177g6kRz9WVJp0oZ0ctKwUATR8+L4KZ
 bU9gIDaGeb2wkZ5vU0y/1Wmb9zQTjKKyDN9BZPjgdnx0iCp/Zx1UYf7AkLIUFkBvqzGn
 QKkBMZie9sIdxU68LgX4ckCuaCfkWF1GefLgQ+/ceI03ARFBT4DnMXJghY8Tx7g+iSfo
 PUxkHp4VK5w/wazotFzs4/zoceO7Jd8LbfeOD+LTPOJQJc1DZF6C5pord3TL4W91ypcV
 K9+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6BHb+j1EavK4t5FTyI3F6gTeoCdEs1zUi9nZIEXR0VpW4h0/xt1FsiQmzvXA6XuR0YZvTFT5aTpOv@nongnu.org
X-Gm-Message-State: AOJu0Yy2LfB82relXWvwFlXywXmO1fPJR+S6kNvyfVNctd6al37CVsVx
 lPVxKEhMV/nNczfOzq9hFs5BTd4iZfx5qbQDp1h2V0mjc65MZ/2rlNIPZixWR+o=
X-Gm-Gg: ASbGnctl3G1v8sFTfk93OwY4+i0/RkRoC5S9QhbD8k9N1ZqUNBOu+X0y5EvhzOl0mbg
 qbLXMxvR2TJ8o+XYOAWyVNpVdEJcvIiTISfqb3xMlE98zzNHL6ltOV+vNGQcU6f3uRySPb2N2Tm
 ujSnZROqNcpMxukEzJ9PMdAER0dnz9P5A/3r09u1vvCIK+kh7JQFeXuRMeYCnBmQRgp0Wuv10en
 hGq8JqHsxaxhH0Elb8bbGv77ejcEZnTudyow5HxzpLz/Fie2XAbLvMxbePITz5d7wIuthmXXMVY
 SsG8xETaY6F+VzEBZNYMnzvtGnKp6+XwZZu9FQkC9BTTyu5fJdiPEb0=
X-Google-Smtp-Source: AGHT+IH7StAjeVEyARSlokCsujmWXEsLp3m7n9W7ZtEpqCPFqUFZFXhyOIWbZHUVvLbezO8kO3b7Nw==
X-Received: by 2002:a05:6871:39c7:b0:2a7:d8cb:5284 with SMTP id
 586e51a60fabf-2d0d5c51f82mr2379704fac.7.1744395615556; 
 Fri, 11 Apr 2025 11:20:15 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:2ab5:920b:5c0c:5bcf])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d0968e093dsm1232198fac.8.2025.04.11.11.20.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 11:20:14 -0700 (PDT)
Date: Fri, 11 Apr 2025 13:20:07 -0500
From: Corey Minyard <corey@minyard.net>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Corey Minyard <minyard@acm.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 0/5] ipmi: bmc-sim improvements
Message-ID: <Z_ldV8X3AXe1QDFf@mail.minyard.net>
References: <20250401140153.685523-1-npiggin@gmail.com>
 <Z-w75P6iav82W5Qr@mail.minyard.net>
 <D93LFGHCQANR.1TFR56ESHUY1H@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D93LFGHCQANR.1TFR56ESHUY1H@gmail.com>
Received-SPF: none client-ip=2001:4860:4864:20::30;
 envelope-from=corey@minyard.net; helo=mail-oa1-x30.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Fri, Apr 11, 2025 at 04:25:10PM +1000, Nicholas Piggin wrote:
> On Wed Apr 2, 2025 at 5:17 AM AEST, Corey Minyard wrote:
> > On Wed, Apr 02, 2025 at 12:01:47AM +1000, Nicholas Piggin wrote:
> >> These little things came up when looking at behaviour of IPMI with
> >> the bmc-sim implementation running the ppc powernv machine, and
> >> trying to clean up error messages and missing features.
> >
> > This all looks good to me.  Thanks to Philippe for reviewing, too.
> >
> > I can give you an
> >
> > Acked-by: Corey Minyard <cminyard@mvista.com>
> >
> > if you are working on this for your own tree, or I can take it into
> > mine.
> 
> Hey Corey,
> 
> Thanks for all the review, and sorry I missed your question...
> 
> I don't have anything further in my tree, I don't have an
> immediate need for it, it was just tidying up a few errors
> and warnings I noticed.
> 
> I'd be happy for you to take it in your tree and send it up
> when it suits you.

Ok, it's in my tree.  I had to fix up pci_ipmi_kcs.c, it defined
pci_ipmi_bt_get_fwinfo, not pci_ipmi_kcs_get_fwinfo.

-corey

> 
> Thanks,
> Nick

