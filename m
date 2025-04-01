Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D2F9C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 19:19:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzh81-00039p-Ox; Tue, 01 Apr 2025 15:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1tzh7e-00039U-DX
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 15:18:06 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1tzh7c-0006P5-4b
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 15:18:05 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-2c7e5fb8c38so3915515fac.1
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 12:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1743535081; x=1744139881;
 darn=nongnu.org; 
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/7dnWhW1NxnMLtyZwkdeWqjwokpD7PP+2M+FdflFbhM=;
 b=sW86kqhVu5+LvsmEftUdnAhMTO+GZhWywbD/KwApQjc5dNPu/JgE94Zkt6LXJP99r3
 JhYUw9EKjAd4W09TAOWGCvQbIxpivmvcHuEzaBqt68ixPR60IBpl7XAnN7Z3qikRoM/K
 luq5uhm/RDpo42oHBzh+shte+qWELqWqmf1lhE4PX7J5aVp+m5lRP6bcqGYepL9r+MjI
 y4uW4XzbrO5vbqdMul1b1jUoCrBHhx+eUHtt1ykF1jU/ZOPJgaeFmyb3Jcf1kq8CxLmM
 4gJMlY/PgpZDxZ99NjF+Y9hotvQEybyT4/L0z/2xdd1ri4QwfTG0Wa8Fe5PFA3KD/Tdh
 1QLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743535081; x=1744139881;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/7dnWhW1NxnMLtyZwkdeWqjwokpD7PP+2M+FdflFbhM=;
 b=IHAkyIjXel3h+w6NQAZjHf6bPOlsvSUzNzQCoWkIVMx9qSD4KJqy78TXiSGtyNZ/cx
 duMVMC+oI5DtiQ4rEr3xud575Sdlblil7+TAN60CaOltGHBe/bJNqE/yS1trIAiwHkk6
 zuonOT0jNaTOgclfdD1G9i9cVALfD5xW6TCT25jHiapYfUtfnerPzR/T0BUOblMZgLAe
 kaWRTZG2+Xbvdk9xIf/YucJpeASQfozlhYjX6LQrtOiaf3O4/xORIOHZew1rOq/E5dSP
 C4q3F21btmZd6xFSzGzBWkLeGwqNFN8gIOIcFAQt/A9lPyQriBRVaYhkVFUfHGOg8eoq
 MF8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFjd0PPa9bnJVqOGgGo53t4B56+Ks25RhngIrR/QAMEUKRLWI8cyyjVbXbd5KA2xHHr3rprkDAdMll@nongnu.org
X-Gm-Message-State: AOJu0Yy7qbJz4Vldsg6WvZNIes1x5lkvPec3MyZDxYm3U0dhb9nc+J2l
 mEA6InMcbaZTPfTVnliQayaYuwhYqlU1UFFn+6IrSA1CerC4NW5NgSNz8+b2D4U=
X-Gm-Gg: ASbGncsM7OT6MHE36JtQJqwZHSqhoKFTNNBKLxw6QtuzBtIqLwv5aEUNs04oROGDcuR
 yiISUh/vN4b00ES7OcgX+fRMOTcxay/4S9K2Q+OQITDW6CqQk5gYsv/MLA5yU3PCu8LAhf+9UnB
 aE1oRgj3jM0p8f8I3nq9JaIJU68zwsGcOiigMBnx0Knd2HTY6J0gjI1GbJTaMNsdlunNsKYaiig
 LY7HX4Mis2T6lPa8YqXeWu3JIJJOugWO0dnqaPSX81GFOfwOr7GCCmYjHVa3iQTDqNqf+MMT2We
 H2abLE1VGIXAzr077Gmdzp9BO8VVIPaPcL8+SJgo4ldinS32
X-Google-Smtp-Source: AGHT+IHveiQH1kjz1WP08m2q9YJWvnZicb78s7nThDc91B3luky96Ji31KHFZeGo5RWr6Oyq0JwDpA==
X-Received: by 2002:a05:6870:2885:b0:29e:559b:d694 with SMTP id
 586e51a60fabf-2cbcf813d67mr9674668fac.32.1743535081141; 
 Tue, 01 Apr 2025 12:18:01 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:706c:e036:e51a:c377])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2c86a856de7sm2465935fac.39.2025.04.01.12.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 12:17:59 -0700 (PDT)
Date: Tue, 1 Apr 2025 14:17:56 -0500
From: Corey Minyard <corey@minyard.net>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Corey Minyard <minyard@acm.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 0/5] ipmi: bmc-sim improvements
Message-ID: <Z-w75P6iav82W5Qr@mail.minyard.net>
References: <20250401140153.685523-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401140153.685523-1-npiggin@gmail.com>
Received-SPF: none client-ip=2001:4860:4864:20::35;
 envelope-from=corey@minyard.net; helo=mail-oa1-x35.google.com
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

On Wed, Apr 02, 2025 at 12:01:47AM +1000, Nicholas Piggin wrote:
> These little things came up when looking at behaviour of IPMI with
> the bmc-sim implementation running the ppc powernv machine, and
> trying to clean up error messages and missing features.

This all looks good to me.  Thanks to Philippe for reviewing, too.

I can give you an

Acked-by: Corey Minyard <cminyard@mvista.com>

if you are working on this for your own tree, or I can take it into
mine.

-corey

> 
> Since v1 (thanks to Corey for review and suggestions):
> - Added fwinfo to PCI devices
> - Report interrupt number in Get Channel Info for ISA, PCI, and
>   unknown/unassigned.
> - Fix error reporting for Get Channel Info unsupported channels.
>   Verify it is the correct error code that ipmitool looks for
>   https://github.com/ipmitool/ipmitool/blob/master/lib/ipmi_channel.c#L256C16-L256C45
> - Change _CH_ to _CHANNEL_ in some defines names.
> - Also avoid adding event logs with watchdog don't log flag.
> 
> Since v2:
> - Don't log watchog flag should not apply to watchdog expiry
>   field.
> - Moved protocol type field from class to IPMIFwInfo.
> - Rename new FwInfo member irq to irq_source.
> - Add comments about handling PCI devices to  existing callers
>   of ->fwinfo
> 
> Thanks,
> Nick
> 
> 
> Nicholas Piggin (5):
>   ipmi/pci-ipmi-bt: Rename copy-paste variables
>   ipmi: add fwinfo to pci ipmi devices
>   ipmi/bmc-sim: Add 'Get Channel Info' command
>   ipmi/bmc-sim: implement watchdog dont log flag
>   ipmi/bmc-sim: add error handling for 'Set BMC Global Enables' command
> 
>  include/hw/ipmi/ipmi.h     |  15 ++++++
>  hw/acpi/ipmi.c             |   3 +-
>  hw/ipmi/ipmi_bmc_sim.c     | 104 ++++++++++++++++++++++++++++++++-----
>  hw/ipmi/ipmi_bt.c          |   2 +
>  hw/ipmi/ipmi_kcs.c         |   1 +
>  hw/ipmi/isa_ipmi_bt.c      |   1 +
>  hw/ipmi/isa_ipmi_kcs.c     |   1 +
>  hw/ipmi/pci_ipmi_bt.c      |  50 +++++++++++-------
>  hw/ipmi/pci_ipmi_kcs.c     |  11 ++++
>  hw/smbios/smbios_type_38.c |   7 ++-
>  10 files changed, 162 insertions(+), 33 deletions(-)
> 
> -- 
> 2.47.1
> 

