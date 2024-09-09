Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD957ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 17:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snhmo-0006mW-Sf; Mon, 09 Sep 2024 13:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1snhmm-0006kd-Cc; Mon, 09 Sep 2024 13:02:44 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1snhmj-0003WI-On; Mon, 09 Sep 2024 13:02:44 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2d87a0bfaa7so3263380a91.2; 
 Mon, 09 Sep 2024 10:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725901359; x=1726506159; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:sender
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jsQk7psHLZeXi9JkqGSxvjJf/lWFhEOuCfTBEowo7t4=;
 b=VEEw2LPRrMPfpl6wXS3j/hIY7K432O+WvVFG6OUHjLy6TGu1m9fnawl0g26D9oOuMW
 33+3eabK0jnIbWBg0c0y3dtojWGP7/X3iCudMheD3UQRdnVPvvmfhHhmYX7H3DEzS9ct
 E60pYMLR4NjKDGvDdKNtWFCluo7jlH4Km2lLBIDYVyaKOJk+inx4lioSyp/OzbKRIlQH
 G93f77kv7GNQWEKrropgrHQUu9w1dkzZvBpORf4fjj7t1NkXWm9t8ewovtXzHVPy7Xqo
 dxp4R41QsbPHlf7MyOdKzdPQpuVZvij2Vbaog2fm5IndeofPCwMYAymx6Gk0L3wfj26M
 T6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725901359; x=1726506159;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:sender
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jsQk7psHLZeXi9JkqGSxvjJf/lWFhEOuCfTBEowo7t4=;
 b=EawQpDYNnkj3TPlHEFHuvRIgppl/0Mv6tlysl8dUzHSNKI88hcefujNtQvVoH2fNWo
 fxJ1kWje6nOrEL5tO9MjI4uIM6MoFPfqElIfdwdR64ZjeFnoK/7UcaMu55M2ZwrGFZRq
 MwxpGnDg5u5BdX9MWLm37vekLGSJM7hc8hWxrussSJAkN04RfPL9fCA6l9V+8C6sITZw
 GPSISpj+nUKiTkEja+VNjzSbnr2hHfeOrUYzlTydTrxFs5AQ/vuix7+rL4do44iO7IGG
 B3OoDYJiRlf/0rDGqL43KJ4onghXBC4QtH4fWd9xtbJdk+f2BQT2WjNDrixYG3XnPUbh
 LeLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHrmnvQuogoddUj7u3kAIqKxjvmB+zSvW2jixfduxhfz8JTVvXSiXggfc1hfLGdrR1FdnxZk4KtA==@nongnu.org,
 AJvYcCXnrPILhiU3Qz8e22CtwY3WC0o0WxGxnkGb6btOE4yNv/6Ca/16kY4J4VkfRaWQl0NAxQ5hWluoWsSVsA==@nongnu.org
X-Gm-Message-State: AOJu0YwGO4DLmwzf19+P7qKrAAYSDFok4VoBnatXgmdh64mPtK3OT3Wf
 ii5NK74x4JqMUZEyNRIQgLCdEz0X+oFpiwyZukVch6u+H/57u1D+erMvSg==
X-Google-Smtp-Source: AGHT+IFQUwrixt0AM/ZMUI+ApafkidceKLZU2l1RmXvIo8nPnT7cD+lBYYE79xVCQXDm/2i20PvvqQ==
X-Received: by 2002:a17:90a:6b46:b0:2d3:cd27:c480 with SMTP id
 98e67ed59e1d1-2dad50f2233mr13896170a91.33.1725901359431; 
 Mon, 09 Sep 2024 10:02:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dadbfe471asm6953946a91.9.2024.09.09.10.02.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 10:02:38 -0700 (PDT)
Date: Mon, 9 Sep 2024 10:02:37 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH for-9.2 00/53] arm: Drop deprecated boards
Message-ID: <bea6396b-b87a-4314-808a-7d440a96ac4b@roeck-us.net>
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
 <fabedae0-d748-4a9d-b802-14d15f3cd44a@linaro.org>
 <3f4ce380-0c0b-48ad-9752-c72f5aeac754@roeck-us.net>
 <CAFEAcA_ETkWY=AaPWti8KwO0awdxWqkO4CLAwxaGVr+i4yFz-Q@mail.gmail.com>
 <6e238c93-631a-4686-9e5a-e169ce082b17@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6e238c93-631a-4686-9e5a-e169ce082b17@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=groeck7@gmail.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Sep 09, 2024 at 05:45:35PM +0200, Philippe Mathieu-Daudé wrote:
> On 9/9/24 17:02, Peter Maydell wrote:
> > On Mon, 9 Sept 2024 at 15:55, Guenter Roeck <linux@roeck-us.net> wrote:
> > > 
> > > On 9/9/24 06:40, Philippe Mathieu-Daudé wrote:
> > > > Hi,
> > > > 
> > > > On 3/9/24 18:06, Peter Maydell wrote:
> > > > > This patchset removes the various Arm machines which we deprecated
> > > > > for the 9.0 release and are therefore allowed to remove for the 9.2
> > > > > release:
> > > > >    akita, borzoi, cheetah, connex, mainstone, n800, n810,
> > > > >    spitz, terrier, tosa, verdex, z2
> > > > 
> > > > > The series includes removal of some code which while not strictly
> > > > > specific to these machines was in practice used only by them:
> > > > >    * the OneNAND flash memory device
> > > > >    * the PCMCIA subsystem
> > > > >    * the MUSB USB2.0 OTG USB controller chip (hcd-musb)
> > > > 
> > > > > thanks
> > > > > -- PMM
> > > > > 
> > > > > Peter Maydell (53):
> > > > >     hw/input: Drop ADS7846 device
> > > > >     hw/adc: Remove MAX111X device
> > > > >     hw/gpio: Remove MAX7310 device
> > > 
> > > max7310 is a gpio controller which is at least somewhat compatible
> > > to pca953x. It is used on imx6qdl-sabreauto, and also instantiated
> > > by Linux with the INT3491 ACPI ID.
> 
> Can you use the PCF8574 port expander instead? It uses more recent
> QEMU design model.
> 

Ok with me.

Guenter

