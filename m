Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 602AFE9B258
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 14:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuszN-0004UZ-4D; Tue, 24 Feb 2026 09:02:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vusyu-0004Sq-EI
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:01:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vusys-0002Ur-Ae
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:01:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771941701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oHdccPgFuIJzbrnv3fSqEXYaHs+/vnnGup8MyCp2ThA=;
 b=cy2QWscZTZDfqeWgaOo7RCu1kHXL9pnQkf3clWn0o4YAVyo7j2Cd9x1fDEsx5ZAi3MKiKu
 kLw40mKPEzhxmEmZ2iJmaaiVKo4C9aeuwKkgo75ENhE1TgqyXOCRgWdzLh212UTuyGUHJh
 hTY6xRB22OWQ50cSVp4Lp9eC7DgwyeQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-LXC6eVQ9Mua1pTsE0ITKrg-1; Tue, 24 Feb 2026 09:01:37 -0500
X-MC-Unique: LXC6eVQ9Mua1pTsE0ITKrg-1
X-Mimecast-MFC-AGG-ID: LXC6eVQ9Mua1pTsE0ITKrg_1771941695
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4368060a5e5so5668389f8f.3
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 06:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771941695; x=1772546495; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oHdccPgFuIJzbrnv3fSqEXYaHs+/vnnGup8MyCp2ThA=;
 b=O6k2ZbiL3J8vlauAsvhQXucorRPqsFQHHpiqLEKpltCPKRDIY931Y8NIK7MymUHOO0
 x5ig75Q0t1QUXbPe4iySbAy9Z868h/WqAuPiJJizTLg1s2zUD23Zdlp7cUv768bHKMyM
 bGzFApw+0lR53+z+G8HMnbkR4njtqJEf8NDmwSEAdB8achxvZIFSLc9yUwBAPArBj9cr
 S4aU2lgNLJ16pTMqaaakOwfTYYTlscoN7iFWtJXS3ZmfHNgDOildk+7FalC7Tc+NuJWv
 Ru5KSXqx30xsQFK/vVmis8J367YKalMEx67lJXod4m6lmcZojeTxxCT14vzimUWvpuoW
 F+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771941695; x=1772546495;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oHdccPgFuIJzbrnv3fSqEXYaHs+/vnnGup8MyCp2ThA=;
 b=DhINU437vt3LOp9+O+okEWzB0N5IxBwcWbLLiCUfWlB1zatCjmYd7UR2w/HSN0jkyX
 zTNwSnLZ5egitxOW2pt0jJ2qWXg0U4Cj13Qq3WWTPiGLIvBVV2dJudPHLy71eGQmZe3E
 iYQ6lvubCUihZrJbUa4evb5COaKedM7E6ibEDVbn7oljEpPlBzNlMC97q/oZojT5F/Mw
 cnRhQii/4lzthIRbQqMh345+xbhHJcPCmR3AzYfUTpIRjF3oswfxzZQXfr5huvIKyhPZ
 7XnvrHSK/FSUVi/7kPN411d1g+QAuaAEMWgTBaB7HFfB7JN06SUVh3XarQpDgs95v3C5
 /WIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXh6IMh1zg4e5fj4DaP2JoI9guyxQbWrFG6UOpn2eZJRO16G/ifDZ4yVXwD7RT6DNQ+Sgm19tbUPX96@nongnu.org
X-Gm-Message-State: AOJu0YzHW86b05/UEYxGXAIQHdH572ZxDCLeQYS8JSdKeeraxeQv1qQC
 H5Q7HTllclg+/cH3HX1ASaKn7vFBn0gI8nWZRUeK9PhTmi/XmA6gJ1FhONZtGEp/vF/qBHf0n+Z
 fU4F/X5GD2+gMyJ6hgEJ6TzX4vRv3AeR+f0i6Em23HTNNnDU++n0+ZNQ2
X-Gm-Gg: ATEYQzw2901qYEq98FiZEKwweIe9h7l/1Jx5VuYhBNHAQvPtxhZYUhOfxPev4h4D5MS
 0Xwmw7TOmjxg/RDOrS0gC1MwZi6z+6N/+KIl7F63dYa+M8MQNIvJhaRZneDadISdLeIFXAcCQj4
 XP7vgspSpEevBCBaJETHCvMBKUkN5tlc+3j0x26loUV6Rxfkc7kBZaVI4JIznHh5/BPWOsUJXin
 DyhmyYIKreogEaDYdP3941ufqS87rSf6ENk/qmUdxq4jIdXxTLG+l06gZEdjH7BPv8Go2vILK4N
 uDVaLGao0lLqjITUT+4UzHWISHnFeZ80qHkLQzr8MQRelgnApCQHxLUwMkFg4BOWz5uaOLkv8+x
 M6mJPh2VN6IsNMpCZIQGumpyZzkb2+hjwnrOdoWLq3VbMzw==
X-Received: by 2002:a5d:5d0c:0:b0:439:8b42:9923 with SMTP id
 ffacd0b85a97d-4398b429b85mr2217878f8f.9.1771941695304; 
 Tue, 24 Feb 2026 06:01:35 -0800 (PST)
X-Received: by 2002:a5d:5d0c:0:b0:439:8b42:9923 with SMTP id
 ffacd0b85a97d-4398b429b85mr2217801f8f.9.1771941694731; 
 Tue, 24 Feb 2026 06:01:34 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d4c977sm28387223f8f.32.2026.02.24.06.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 06:01:34 -0800 (PST)
Date: Tue, 24 Feb 2026 09:01:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Ankit Agrawal <ankita@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>,
 Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "alex@shazbot.org" <alex@shazbot.org>,
 "anisinha@redhat.com" <anisinha@redhat.com>,
 Aniket Agashe <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Krishnakant Jaju <kjaju@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v1 1/1] hw/acpi/pci.c: preserve generic initiator
 insertion order
Message-ID: <20260224085955-mutt-send-email-mst@kernel.org>
References: <20260222020812.26475-1-ankita@nvidia.com>
 <20260223082804.0d293861@imammedo>
 <SA1PR12MB7199F0C2E1D2325B0062B004B077A@SA1PR12MB7199.namprd12.prod.outlook.com>
 <20260223104411.57a815fa@imammedo>
 <20260223111302.00000081@huawei.com> <aZ2sylCydE9Js1ec@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ2sylCydE9Js1ec@nvidia.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Feb 24, 2026 at 09:51:06AM -0400, Jason Gunthorpe wrote:
> On Mon, Feb 23, 2026 at 11:13:02AM +0000, Jonathan Cameron wrote:
> 
> > Ankit, can you give an example complete with table dumps please.
> > 
> > I'm a little unsure on where things are getting scrambled.
> > Everything should be keyed of PXM.  Sounds like we have a bug
> > somewhere but ordering shouldn't be relevant.
> 
> I understood the issue is Linux assigns the uAPI visible NUMA node
> numbers based on the ordering. The proximity/etc internal to the
> kernel (I thought) was OK?
> 
> Then the problem is that uAPI has developed meaning based on what the
> bare metal HW does and now there are SW stacks that are expecting
> these platforms to have certain NUMA IDs in the Linux uAPI. Sure you
> can argue this is bad/etc/etc but the point of QEMU is to allow
> creating VMs that closely match real HW and in this instance real HW
> produces an ACPI table with a certain ordering and the SW is sensitive
> to this ordering.
> 
> Even if there is some Linux bug mis-parsing the ACPI, then that still
> should be addressed from a qemu perspective by providing the ACPI
> construction that doesn't trigger any bug so existing VM images will
> work under qemu.
> 
> Thus qemu needs a way to reflect the ordering on the command line to
> properly emulate this system and accomodate the existing VM software...
> 
> Jason

Not arguing against this, but if there's a linux bug it is important
to fix it as a 1st step. qemu work arounds for broken guests
notwithstanding. then we can check how long the uapi has been around,
how practical bugfix backport in linux is, and decide on whether
a host side work around is worth it.

-- 
MST


