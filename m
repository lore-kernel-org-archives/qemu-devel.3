Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C29C52D7F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 16:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sducu-0005k1-1D; Tue, 13 Aug 2024 12:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@ziepe.ca>) id 1sducs-0005jU-4X
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 12:44:02 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jgg@ziepe.ca>) id 1sducb-0008EH-O8
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 12:44:01 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5d80752933bso3905045eaf.1
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 09:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1723567423; x=1724172223; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ROqRYY1dqCAC6kog/NOEL1zLkAqrmdMPMSau7oyZjtU=;
 b=XnI8KZGKAB7PBO69qgoTVvRcexZv8fnOk+pItzdmaaR5W6MH+TKLgB0bqzQEq7pxbo
 27TwCVE78Jhb0X7j+Jjy9cRYZZiCEOC8k1wGYlHCMLVTXS9EmRPPqk0orEdl+avNXRqm
 5CF0pQIVtnwKL2xeav6Sfh/29K/2i0Js2VOOOKFV0+3uC61fpwgly+nGWa2umuayw5IF
 oz6gpUzMKtkWYItTxzxfadzaQaHVkzlDus522Rzz455mxYMgSJiIyHDtGosbC6rVr+B9
 APwTs5ej4AeLIMJdNFnyF1AiRZxLW3LS/NMNIckEGmuIisnOS6cusICjJa5p9l5y3USe
 zjrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723567423; x=1724172223;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ROqRYY1dqCAC6kog/NOEL1zLkAqrmdMPMSau7oyZjtU=;
 b=ZjTZ0p9bCFY58XUxqI1wXYIZIqHJOwUZNW6nrLFrw0Kw+C2Upp04e1fNeDTWR6KQUg
 wNsu7BGBJDpqQmhBASqqIjjZKeTnrE2kF0yLH78+UwcqtUKasRXcx4G1+3IDHPgyeO9B
 AJFgqovFIU13sZP+ysBrGp6b1NovWOZGUponITtMW1xTxo3nwcEiiAt+W1p8GSfBa8Qv
 8AtmHcah0rImL7jWSifXWA7E4J7v1xFWO8zRSh10YmhmjQtTl4XQYs7sGQC/FBdxgZht
 SSoig7OniNh2Rlni6tLFrKmG5ANCz+Xjvfau3d/cPJfh3msOTPztfZU0BjIsutY/gUiu
 dJTA==
X-Gm-Message-State: AOJu0YzfwQg/84mtrIcy5+kd0AXhBLmX1wDf4WekYibXOjiVpNzJkuCB
 IxQ+x9SVFCy2u11m8bAK0ui03s170pwrulmtLkKD01SVI7e153a2rabkr1LBOk8=
X-Google-Smtp-Source: AGHT+IEvmSCVnjpjqrFJiGnBKOZvxrmuCp6UnsBlqoXz0YHrq61kKl9NZyVY0sS6gN/GBZB3kKmjIg==
X-Received: by 2002:a05:6359:410d:b0:19e:fa9c:5ec9 with SMTP id
 e5c5f4694b2df-1b1aab4ccf6mr3925955d.9.1723567423216; 
 Tue, 13 Aug 2024 09:43:43 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bd82e2f405sm35400856d6.79.2024.08.13.09.43.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 09:43:42 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
 (envelope-from <jgg@ziepe.ca>) id 1sducX-008U9H-Jt;
 Tue, 13 Aug 2024 13:43:41 -0300
Date: Tue, 13 Aug 2024 13:43:41 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, quic_bqiang@quicinc.com,
 kvalo@kernel.org, prestwoj@gmail.com,
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
 dwmw2@infradead.org, iommu@lists.linux.dev, kernel@quicinc.com,
 johannes@sipsolutions.net, jtornosm@redhat.com
Subject: Re: [PATCH RFC/RFT] vfio/pci-quirks: Quirk for ath wireless
Message-ID: <20240813164341.GL1985367@ziepe.ca>
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
 <20240812170045.1584000-1-alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812170045.1584000-1-alex.williamson@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f; envelope-from=jgg@ziepe.ca;
 helo=mail-oo1-xc2f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Mon, Aug 12, 2024 at 11:00:40AM -0600, Alex Williamson wrote:
> These devices have an embedded interrupt controller which is programmed
> with guest physical MSI address/data, which doesn't work.  We need
> vfio-pci kernel support to provide a device feature which disables
> virtualization of the MSI capability registers.  Then we can do brute
> force testing for writes matching the MSI address, from which we can
> infer writes of the MSI data, replacing each with host physical values.
> 
> This has only been tested on ath11k (0x1103), ath12k support is
> speculative and requires testing.  Note that Windows guest drivers make
> use of multi-vector MSI which requires interrupt remapping support in
> the host.

The way it is really supposed to work, is that the guest itself
controls/knows the MSI addr/data pairs and the interrupt remapping HW
makes that delegation safe since all the interrupt processing will be
qualified by the RID.

Then the guest can make up the unique interrupts for MSI and any
internal "IMS" sources and we just let the guest directly write the
MSI/MSI-X and any IMS values however it wants.

This hackery to capture and substitute the IMS programming is neat and
will solve this one device, but there are more IMS style devices in
the pipeline than will really need a full solution.

> + * The Windows driver makes use of multi-vector MSI, where our sanity test
> + * of the MSI data value must then mask off the vector offset for comparison
> + * and add it back to the host base data value on write.

But is that really enough? If the vector offset is newly created then
that means the VM built a new interrupt that needs setup to be routed
into the VM?? Is that why you say it "requires interrupt remapping
support" because that setup is happening implicitly on x86?

It looks like Windows is acting as I said Linux should, with a
"irq_chip" and so on to get the unique interrupt source a proper
unique addr/data pair...

Jason

