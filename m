Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71239CA0EEB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 23:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upat8-0001Jg-L1; Fri, 22 Aug 2025 19:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1upat5-0001Ix-7q; Fri, 22 Aug 2025 19:09:35 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1upasy-0006Gq-7s; Fri, 22 Aug 2025 19:09:33 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-323267bc0a8so3038821a91.1; 
 Fri, 22 Aug 2025 16:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755904161; x=1756508961; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=fsgqxL4kN4cjwTfi+W7uPaSwoZlXzRyJTDEuQTB78sE=;
 b=d+/X3Z4tzmhJjUIMCke3m06B4zGvG59zyRGYLMGG9QVoZZWLb1livoWLzWIELs61Zf
 ADTTZHQ5GcdUmSQBWeWo44KUJhLt0eyOyrBZwwKVf0SaCWSXRGI/a52/h8Kimih0Tcvl
 Qy/XF95UBWZ5Hfmw112DKDDeZhOe603w2LkZAx1Tc39LAcf9XTrzQOdFfs8lIYF9AjxT
 GM67WxMm8PDMyQ4vq/q5WQ0r3pNxG+NXqOOQElKSB6D55WNY1ty6aJNm2ZkwMPu/Mg4I
 f5A9ZUV0WaevYczIGRBzpkN7CgEX1SyK7hrbnuMwjffQ8HA5c6H7EkLgYz4eBEi1YbPv
 ZXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755904161; x=1756508961;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fsgqxL4kN4cjwTfi+W7uPaSwoZlXzRyJTDEuQTB78sE=;
 b=prlUZzalalTvcKMQ1vCesmOT1k36/f2Tou4WZpR5smBz4ORlmN3RFfRgeYK56dl8HH
 p2b2TBz4o1MbavC92/3H8WjUcg2H0zb0GhZ/qMxJUXGLxsPii99FRYkbbKAzu/9zQxif
 kjTGSJcCKYderToEtHCOCperP9pM54Qry802jnOQMo6aq//yE8Y8pJlqVTHKjSF+tWvQ
 Aw7iUmN/T2EbVl5U1zxe3icd5M/IX12DdC+MRWf6lm6f4YEdKnLk+K5KnJ0q3bFuf/tJ
 uiU4wNlXRJarzaAP9SeWQjRXEHpPk8Q0Oke0GS38lWc4sFzl9xyAhTmcnuVSl4cvO9uY
 Y/hA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOhyrFbwdb82+tUdWma2JpE+s8quKf+q71qarBWCH90igDKLz/lshWmP8bIWKLJQ1/CUyNfJJRFw==@nongnu.org
X-Gm-Message-State: AOJu0YwWEnmGo830I3LjhWHptHAYAoFSRN+VoSjmFo29gHKaZeSQ+ngQ
 iVVVEi5TS+aJzunYSvPoOORgXrfoGUOdwrEIKxdUsY14ZbYqrs21qoWt
X-Gm-Gg: ASbGncuMAXJy8ZCzn8hTGjiZJbPX4lLFk6dPO31lKfHATJcNrn+zqG9UHCtulqYaOPC
 TU0Dmi3wiiyfcTvxBz4FA1Qd/J6WfvAuLx5yLw08aMWBsIJ+DlFT0JOyv2OzvnCCQr+Or0O+m/J
 5R3aV7e+nKBTtFx/I8i9d638X5dhGKCHZ+M02AevD9Vwn9WXA7Ff92cXYc3NYVhFgnnX2qKo482
 +BKRFoHC+Xb96O+Rnqzy8ysu4MDxKwZ0OLnfYbRGueYAAM3IsnNFCCcLJSgxHwgEg35AMJP9/0w
 jCjzFuSS58bnYTNUjF+kbDyFQi1vEmKiBDASEX9p2aN/kxGvCoCjlAE/AYYdQ8PNzREEZdGKOxK
 7cwFwX00FKFklFLpM254YIt/cwzjgQvXdxiE=
X-Google-Smtp-Source: AGHT+IGK+dgtnBLPmx9whHPcXKTxoYUsnNvAHue2hTpGQ8ANIoQDLqbNIiH3/fvyKntulxpppkpGug==
X-Received: by 2002:a17:90b:5627:b0:31e:ec58:62e2 with SMTP id
 98e67ed59e1d1-32515eaafdcmr7371529a91.19.1755904161038; 
 Fri, 22 Aug 2025 16:09:21 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b49cb8918e7sm793002a12.6.2025.08.22.16.09.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 16:09:20 -0700 (PDT)
Date: Fri, 22 Aug 2025 16:09:18 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org
Subject: Re: [PATCH 00/10] Designware PCIe host fixes
Message-ID: <3e9ce165-9136-417e-bcac-d6f7fad0fee8@roeck-us.net>
References: <20250820211932.27302-1-shentey@gmail.com>
 <7804e625-2421-473f-9320-89fa0cc0d085@roeck-us.net>
 <D1762D97-2253-4503-9BD9-E4BF6BED1EAE@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D1762D97-2253-4503-9BD9-E4BF6BED1EAE@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=groeck7@gmail.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.067, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Thu, Aug 21, 2025 at 10:24:02AM +0000, Bernhard Beschow wrote:
> 
> 
> Am 21. August 2025 03:36:44 UTC schrieb Guenter Roeck <linux@roeck-us.net>:
> >On 8/20/25 14:19, Bernhard Beschow wrote:
> >> This series fixes the Designware PCIe host to work with cards other than
> >> virio-net-pci, e.g. e1000. It was tested on the imx8mp-evk machine.
> >> 
> >> The series is structured as follows: The first part refactors the device
> >> model to create memory regions for inbound/outbound PCI mappings on demand
> >> rather than upfront since this approach doesn't scale for adding I/O space
> >> support. The second part consists of fixing the memory mapping by adding I/O
> >> space support and fixing default inbound viewport mapping. The third part
> >> concludes the series by implementing device reset and cleaning up the imx8mp SoC
> >> implementation.
> >> 
> >> Testing done:
> >> * Boot imx8mp-evk machine with Buildroot while having an e1000 card attached.
> >> Observe that it gets an IP address via DHCP and allows for downloading an HTML
> >> file via HTTP.
> >> 
> >Crashing for me even if no PCIe card is attached. This is with the series applied
> >on top of 10.1.0-rc4 or 10.0.3. I have not tried to track down the problem.
> >
> >Guenter
> 
> Hi Guenther,
> 
> Thanks for testing this series! I can reproduce the issue with Buildroot while the functional test passes...
> 
> I guess that I was too optimistic in having resolved the issue mentioned in the last patch. Does it work for you if you omit it?
> 

It gives me hung task crashes when trying to boot from virtio-pci.
I'll need some time for debugging.

Guenter

