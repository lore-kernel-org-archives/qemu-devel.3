Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEEBFE7C70C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 07:54:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmokr-0007Hi-93; Mon, 02 Feb 2026 02:53:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vmojl-0006Qk-Gp
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 02:52:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vmoj6-00006s-9g
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 02:52:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770018720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WdcqX46Ky+0K5tyjL3mg19yZyZWpIov6zEL9DHS21tM=;
 b=DLrvut2tDckkQbRj/jM3KG4poFMxvhU8zX8URXNcOdO2kXvG/k840ayty2P9xgGUhOxN+3
 bZTJGGvBb9VeFkoes2ZtSCFp0ev2YKhAWvT8B4KxIfVA1XNicu9UXNgyHRPKk9/fQa1bxc
 Ps/Hr1jkeHLQY7EPoYR7wG8LfFbLoHc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-TuMf2TTvOyWd8Ve3OhUNPw-1; Mon, 02 Feb 2026 02:50:33 -0500
X-MC-Unique: TuMf2TTvOyWd8Ve3OhUNPw-1
X-Mimecast-MFC-AGG-ID: TuMf2TTvOyWd8Ve3OhUNPw_1770018632
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42fd46385c0so2359961f8f.0
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 23:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770018632; x=1770623432; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WdcqX46Ky+0K5tyjL3mg19yZyZWpIov6zEL9DHS21tM=;
 b=rP5C5Pvtu33VaBCwcQEmjFDMOWmDhDFBfbdsf89OkYTkEg/qzeDF32mgI+Wq7RIXRY
 z6FYkQmrq0fdHYVUIq0K0fYB3IE8+0EzNksmL0k6D3Zxp40XjT5HL0e+a8XZdmCwQaCB
 inMkGrSuYYp13oW7Sr7Y9zk2NtIAVL260nqCFZ8Mpb9wJcDYTFaKmeN1Y8bXnywUdmk7
 pBRmghwFwl9XZQxz8S0vIB+OwHZNrThHsPZ1HtxtGop7P+CiRhxQRGJEk+L5/gcR0qsf
 XCyZeAwJqLFO7lR4XLzOSpc1nIfB2vGXV5lCyl0VpaIlGrLRVTfmENv/Bo0FYgPzGqph
 Rt0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770018632; x=1770623432;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WdcqX46Ky+0K5tyjL3mg19yZyZWpIov6zEL9DHS21tM=;
 b=UpD8Kj4hmNNwOawmaJ0LSo6yhzTpAFwhz8nVCctZ1re57uG/X7Qe4qlNBzprq9uaWx
 QbOmQH4ejZdNq/g+D+Et512R7pPSetWv9fPYORoXSzJOK9Mbb87EzS6AkPq/NIiF/WUe
 as3stl8aXSBf/g9aBNe/5XGjnAXj8E8IzNHUrsXfnFvhygQsYQqo/MCGvMJ64stb506o
 shjF9L+rfHV8ORXNVODxR/NxgAyl0vmac+kwfElFC1aF0cxY7NX2HMbARplHHI75/Dmv
 BSzy8moMTYuU1ZUHU6c7ul5B8b+kyxCq4+z0iNUq1zMWRMPJjyQm9cSkRe0KxiJq1rNA
 CsbA==
X-Gm-Message-State: AOJu0YzrPLuZ0jfUMSQz7bLBSXcC6x9NWRqSski/FwfaC8CX0TEkK4Sl
 j9oecgTAdcBRUYhGCN+sjybtgUUkTLD7rx7VQ3WT6VqPnIy7B1/yZ/Q4TbYuWNK1YnX6pfY8ghv
 Rc5KKg+Mr7103pQ40QBA0+vFUczxFj9xyH8CewLlnUoSBeinSH376KEIOVeEIwMPh
X-Gm-Gg: AZuq6aLkRN+Fc6T00t5vU3JP+VkBEOJaukmHCtjXdHFVFD72UY3MIDmg/QnaIFvItuE
 XrHgz8SOfWEzDcIt5Y0sDu3ID8azSDT8e55s3609dqSBKbuXjXyG4w798W4eqzUKDzR8aq5tDIZ
 hSFdq73f9gpRhVJ8HFpeUXZqeyzBQgeKDudnjoqYFoxnxTHm5LaH7lNl6LjYTPZMXWqcH1CQ7il
 ay92dTp+O91gI5tAAiTdJhFe6E3J97x+gX51rLRbecaqcX6+peEV9ARE5gxjMhTydrjx/I++Ygn
 lxhMOyDSFBMCVFr1ri1pSPQ2EmPZzM/O/5YU56LV66tG7BM6011ggkm46kRxhmrJaLSrBxLvoEy
 pdF5G+5f4HLcY0dDI280V9ImbCV3Cthg7ig==
X-Received: by 2002:a05:600c:1d03:b0:477:7f4a:44b4 with SMTP id
 5b1f17b1804b1-482db4567d6mr153124075e9.1.1770018631906; 
 Sun, 01 Feb 2026 23:50:31 -0800 (PST)
X-Received: by 2002:a05:600c:1d03:b0:477:7f4a:44b4 with SMTP id
 5b1f17b1804b1-482db4567d6mr153123845e9.1.1770018631474; 
 Sun, 01 Feb 2026 23:50:31 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482e2973d57sm82153325e9.18.2026.02.01.23.50.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Feb 2026 23:50:30 -0800 (PST)
Date: Mon, 2 Feb 2026 02:50:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 2/6] include/hw/virtio/virtio-access.h: remove target
 specifics define
Message-ID: <20260202024813-mutt-send-email-mst@kernel.org>
References: <20260131020100.1115203-1-pierrick.bouvier@linaro.org>
 <20260131020100.1115203-3-pierrick.bouvier@linaro.org>
 <20260131124842-mutt-send-email-mst@kernel.org>
 <095a1def-1548-4764-84d2-87ffb642bb8e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <095a1def-1548-4764-84d2-87ffb642bb8e@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sun, Feb 01, 2026 at 05:24:03PM -0800, Pierrick Bouvier wrote:
> On 1/31/26 9:48 AM, Michael S. Tsirkin wrote:
> > On Fri, Jan 30, 2026 at 06:00:56PM -0800, Pierrick Bouvier wrote:
> > > Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> > 
> > Performance impact?
> > 
> > the reason we have these is for performance ...
> > 
> 
> I would be very happy to run any benchmark that you might judge critical.
> 
> Should we run a disk read/write sequence with a virtio disk, or a download
> with a virtio interface? Any other idea?

block for sure, people who care about network perf go the vhost or
vhost user path.

So I CC'd Stefan Hajnoczi. Stefan do you feel this needs a test and what
kind of test do you suggest as the most representative of I/O overhead?

> 
> Regards,
> Pierrick


