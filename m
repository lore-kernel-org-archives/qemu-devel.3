Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E23CD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 17:30:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZXcL-0005u9-Fu; Tue, 16 Jun 2026 13:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wZXcI-0005tJ-TK
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 13:30:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wZXcD-0004DH-4O
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 13:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781631017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5y+4ESFLVcdl+cz60WZLnRjg9gpGDpYgkxlUx3ePun8=;
 b=iMRbQpncrRoA9emH/Iut2o6zr0vjcbWT582+VWZ+pardqy6Kmlr07P9G0pH6IL1GikgBoS
 DGnuR3dVShfm5UnuA5/GskDqYmFbqvu7ftmMCJHt8FugE+7lc7ClrXCy6NcBfvT8n3cYBN
 J07c8rl2MVXd3eoNUM95Y2nmYZScsMY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-7EZCuZxsO_S2SIyjp6oJFQ-1; Tue, 16 Jun 2026 13:30:14 -0400
X-MC-Unique: 7EZCuZxsO_S2SIyjp6oJFQ-1
X-Mimecast-MFC-AGG-ID: 7EZCuZxsO_S2SIyjp6oJFQ_1781631014
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490dad70f95so49356695e9.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 10:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781631013; x=1782235813; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5y+4ESFLVcdl+cz60WZLnRjg9gpGDpYgkxlUx3ePun8=;
 b=CAvNm2y1/nIM/nGTDobr5YE7C4thv1+4yFxpPDVHt9zeyU04G3X95zkjTFvYwqp4ij
 9B61D5rV9CpGiER4rsJLwdvPb69GAKe0NFqh2+XaNyXcgf04T4wKLjHOz4c2imylFhhX
 zwwbIRm2P9B8Gl3Aq9s3G0u1O+6li0mPK6zUkLqmqsWi+vh/3HaVHWAeHl/5Zbw27Kt2
 EBeL5qGiD82G7vAC1GZkXCnh8DbFnPipGzVGKbug1Wnf2Pow76F9rElnRLmJNiSyX5/x
 k/AOBTsb8DHH12h0UHOePOjMFt7M1nBh399mWalzvBj6/tjeb50WrQjbLhUH0m+82Q9H
 7qmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781631013; x=1782235813;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5y+4ESFLVcdl+cz60WZLnRjg9gpGDpYgkxlUx3ePun8=;
 b=HvP2DvItUc/yjW55pQXCU46lYBKpelbC5605HtIn00ovqJKfTTXoW+ZPehf6dg4vq6
 /k8WcRzoMT7PNvdGPyPBrrQrkdS0WjdQ9uWsSBjbDSF3OjMkVrltth7yrQr55atIXwqG
 PqZ1wmDTO1HN6IMuvKVFVsnXpZIXg5t3a5Mt+HdouVN7cNLEaeCb3bwgjo6a7lqJDEss
 v4oxh0cBW1ApfuwxwMSyQPTbtZKqgvsSZ99XS+OQKrvXACPQ7cX9RZJIvgN39UQ/Vwi8
 JgjJKbcYoPAh8HaDGYUhFlbroLJNAg9Ad8JSGgFSHhuHQrRWtz3HN6S1n8W+6Ea7mFfB
 Tnqg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+2m0FarnV6oN0PdFoW8f3CCRLiAqQDj0PU5VSjzfJG9o8seNyf1DYCDf2vhdlEjHHzkGmvFOjF5Ub1@nongnu.org
X-Gm-Message-State: AOJu0Yy+Dvtkw1oDiVo6oIpF6JmNTXr2cx6uSADA2MHg3W0EoVnviRMp
 n2wzEn9D+ZGUWlZAR9X4gbvagQCXvCTgu1fmFBPn1A4BdSKuy8P8aCPpZLCzd4z1o1csUUnE1oF
 9MOfm/v6BJ/nwgJe/ACoep8auxzr9Iw9NYVzAwC0joau96ITZthQSGOhW
X-Gm-Gg: Acq92OHwJlQNBb/2jSF/QSr+oS1Itw3zuTiOJKPlYQJQ46peGVK600FECKBQCMhK4rl
 3m44VPVwNO1bKq2L5Pdds/fhm/9Td5v2PEjcVXYXCPoPzVWnCrW4AhSK+An7YUe9FYySqIZaxWP
 r/GVNH9xhz60qcbtE2G1iU9TrRqjQ71h9o0Wy0xUYbZJ+2Zq2f3X8vc5HRPZNbsey8mciVXyyIO
 XxHSDxBWnDALkVuOUxNk42twrrd0IrflWPpEuCsXDnKaLbRkYGfkBaj0OhiIiyFaCRLR586zaoV
 2GIieSwzZCQqQDOcRSNGY281pfnHF2BBWfEFIx5VhTnwGo9aTh5CYRbSVJ4PiFV8rIUOivLxt8D
 4Zi/5sZsbkjoe164xwnlmMuG562EEMC5d91B+rAv6/MM=
X-Received: by 2002:a05:600c:821a:b0:490:a298:3859 with SMTP id
 5b1f17b1804b1-492333c9dd8mr7342425e9.24.1781631013573; 
 Tue, 16 Jun 2026 10:30:13 -0700 (PDT)
X-Received: by 2002:a05:600c:821a:b0:490:a298:3859 with SMTP id
 5b1f17b1804b1-492333c9dd8mr7341785e9.24.1781631013026; 
 Tue, 16 Jun 2026 10:30:13 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea961f18sm356116255e9.2.2026.06.16.10.30.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 10:30:12 -0700 (PDT)
Date: Tue, 16 Jun 2026 13:30:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH v2] docs/devel: relax policy on AI-generated contributions
Message-ID: <20260616132947-mutt-send-email-mst@kernel.org>
References: <20260529094619.1034458-1-pbonzini@redhat.com>
 <9ad69343-38b5-449c-8d7b-5cbde9d3b72f@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ad69343-38b5-449c-8d7b-5cbde9d3b72f@linux.ibm.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jun 16, 2026 at 07:06:23PM +0200, Christian Borntraeger wrote:
> Am 29.05.26 um 11:46 schrieb Paolo Bonzini:
> > -Exceptions do not remove the need for authors to comply with all other
> > -requirements for contribution.  In particular, the "Signed-off-by"
> > -label in a patch submission is a statement that the author takes
> > -responsibility for the entire contents of the patch, including any parts
> > -that were generated or assisted by AI tools or other tools.
> > +.. code-block:: none
> > +
> > +     AI-used-for: tests, docs
> > +     AI-used-for: code
> > +     AI-used-for: code (refactoring)
> > +     AI-used-for: code (prototype)
> > +     AI-used-for: research
> > +
> > +``AI-used-for`` should not be included for "background" usage such as
> > +autocomplete or obtaining a pre-review of the patch.
> 
> So what about using AI for security scanning? So how do we want to treat
> a patch from a human that is based on an AI report.

This is ok by the current policy, too.

> And if ok, would we then add something like
> 
> Reported-by: Claude, chatgpt whatever?

-- 
MST


