Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93919C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 17:55:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twm0F-0003tw-PS; Mon, 24 Mar 2025 13:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1twm07-0003tZ-UG
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 13:54:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1twm06-0001ga-1E
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 13:54:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742838851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PsPMTPR5ttL+v/c92ZaF/vo63O8oc7iVfsKitfbtyew=;
 b=JUaGEKgSQG2bkdShdtD9+9nu7RmBltV+vp4m6yDW1zSi1b9TS3bkzFm6eiqryR+uX+VFSd
 lVTaojqpHirlVH1SFcKef8E/d6fKEhuAKZxQUNrihFgiMuJNkMa5iEeUH9Ct5p1d9d3qIk
 H8GKVvY+t7ZPdwNGjYdWTyd4osuaYP8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-C5IQ6ZMEOPizSZW0UwiFRA-1; Mon,
 24 Mar 2025 13:54:06 -0400
X-MC-Unique: C5IQ6ZMEOPizSZW0UwiFRA-1
X-Mimecast-MFC-AGG-ID: C5IQ6ZMEOPizSZW0UwiFRA_1742838844
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6CB4C1800260; Mon, 24 Mar 2025 17:54:03 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.27])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CABB1801747; Mon, 24 Mar 2025 17:54:02 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C79CD1800387; Mon, 24 Mar 2025 18:53:59 +0100 (CET)
Date: Mon, 24 Mar 2025 18:53:59 +0100
From: Gerd Hoffman <kraxel@redhat.com>
To: Alexander Graf <graf@amazon.com>
Cc: Ani Sinha <anisinha@redhat.com>, 
 =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [PATCH v6] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
Message-ID: <kmqzqeaatk3iyrpl4tvfxtfv6gefyusxpyxtz5bollw7jlp3wk@5c4zawrzehwq>
References: <ahtt7arm3pi7rlv6x4qepktrczgnsgaukftyee75ofn5duviho@v4wp6v7wlxbg>
 <4593a2fe-098b-488b-9d55-1adc1e970f59@amazon.com>
 <vajhincsurwwx5yfmfhamgmvo5i22hxsaaef22aaknkn24m7c6@yxuntxof4iie>
 <Z9vSeF67fNazkxBh@8bytes.org>
 <4p7orqixni5m3444l53isxe5awdwasrb5e5bu6wu4phhycqpir@z22wgnaxowsg>
 <CAK3XEhNeB29eaPxZ_1Cc7WfEzOGZZPcvTc5uC1XAdtG0uNfDRw@mail.gmail.com>
 <h2s75tkddnrmodbbr7hxugrivpbhq7cfpbmhmgqmnn5mlafedk@jhv5cobgtjkc>
 <CAK3XEhPYmBsn2-=PMR7qVQHiu0ydoh3EfJOEuunLccriSkKipg@mail.gmail.com>
 <53jhridwtejsuy4qojjr66rcjdebnyarwke4bs3m3w2afmqhe6@pab5zfyo46fx>
 <4f6a21a9-746e-45ac-88c7-dc0204480a86@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f6a21a9-746e-45ac-88c7-dc0204480a86@amazon.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Mar 24, 2025 at 05:31:30PM +0100, Alexander Graf wrote:
> 
> > > > > What does all this mean for the hypervisor interface ?

> > > > That means we'll go scratch the region list idea and depend on igvm
> > > > instead.

> > > > Which means we are back to the single firmware image.
> > > So in this model, how are we passing the hashes of kernel, initrd and cmdline?
> > > Are they going to be part of the firmware image as was previously thought?

> > Either scratch the idea of using hashes to verify kernel + initrd +
> > cmdline and use a secure boot signed UKI instead, or use IGVM firmware
> > images and add the kernel hashes page to the igvm.

> It's a nice idea to have a firmware IGVM file that contains a signature, so
> you can for example have a RHEL provided IGVM that only runs UKIs that are
> signed by Red Hat.

Yep, that is what should be possible when all this is ready.

>   - Attestable Bootable Containers. In that case, the command line contains
> a hash of the target fs-verity protected partition. Red Hat can not be the
> entity signing that UKI. It must be the user.

Well, add-ons have been created to address exactly that:  Allow the UKI
being configured without changing it, so the UKI can be signed by redhat.
You'll go add user-signed add-on for the command line.

>   - Add-ons. How do you provide a "debug add-on" and prevent it to gain any
> access to confidential data?

Not sure I understand the point you are trying to raise.  Add-ons
signatures are checked too.

> So we need some equivalent of a hash page.

Ok.  So two opaque blobs, one which is measured into the launch
measurement and one which is not?  That gives you the option to pass
around hashes (or any other data) and leave a trace in the launch
measurement should you need that.

> That can absolutely integrate more deeply into UEFI and be actual PE
> hashes rather than the icky thing the OVMF code does today.

How the measured opaque blob is actually used is not something
vmfwupdate needs to care about.

> But we need to support a way to embed the hash in the ukify.py
> generated IGVM on the fly. With add-ons, maybe even multiple ones.

I'd prefer not patch the IGVM on the fly at boot time.

take care,
  Gerd


