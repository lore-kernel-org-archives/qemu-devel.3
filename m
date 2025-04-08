Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5DBC3600C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 08:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u24P9-0006tb-96; Tue, 08 Apr 2025 04:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1u24P6-0006tB-22
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 04:33:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1u24P3-0001TX-RG
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 04:33:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744101230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SP643omj8o/6cgJmZ8ciD7K7vxCTfLwtC0yUuvo76uo=;
 b=aC8ENB089tkGZxC7C8TuLeSq3GXkNJZNgv5KcHArUY0Gq4WZmicIcwS5eX98oqtAmIDYv+
 et9xOW6JShzthiAcdF3vmk2tr87/phH2bbIxs4NeY03E6oE5arp2GtlrfAfzZmxqP9Me/A
 yKLAWjBGUwSKBOtqhBuZxFaN5utJUBo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-501-6K-5RywJMRGM-BoR0-RVgA-1; Tue,
 08 Apr 2025 04:33:46 -0400
X-MC-Unique: 6K-5RywJMRGM-BoR0-RVgA-1
X-Mimecast-MFC-AGG-ID: 6K-5RywJMRGM-BoR0-RVgA_1744101224
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ABA9B1955BC6; Tue,  8 Apr 2025 08:33:43 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.107])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE84E180B488; Tue,  8 Apr 2025 08:33:42 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 90A451800094; Tue, 08 Apr 2025 10:33:40 +0200 (CEST)
Date: Tue, 8 Apr 2025 10:33:40 +0200
From: Gerd Hoffman <kraxel@redhat.com>
To: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: Alexander Graf <graf@amazon.com>, Ani Sinha <anisinha@redhat.com>, 
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
Message-ID: <xjdm7m65w6hmnq3ik2psbfhizypk76c3hdriujh27kcm7ex5tv@7lq3x3k7y52h>
References: <h2s75tkddnrmodbbr7hxugrivpbhq7cfpbmhmgqmnn5mlafedk@jhv5cobgtjkc>
 <CAK3XEhPYmBsn2-=PMR7qVQHiu0ydoh3EfJOEuunLccriSkKipg@mail.gmail.com>
 <53jhridwtejsuy4qojjr66rcjdebnyarwke4bs3m3w2afmqhe6@pab5zfyo46fx>
 <4f6a21a9-746e-45ac-88c7-dc0204480a86@amazon.com>
 <kmqzqeaatk3iyrpl4tvfxtfv6gefyusxpyxtz5bollw7jlp3wk@5c4zawrzehwq>
 <d79cff63-324f-4624-aef3-b6570cdb23e2@amazon.com>
 <rtbmlitus6unzibiatblquot2bthx4dmozbxgcbovisial6qar@konful7gzrsz>
 <6d815066-9977-4683-a2d5-871dda3e5369@amazon.com>
 <fwdk2pc4rfa5o22gdfqq4cfsqged4v6hmlrtqdwltgqj2bkpl4@bicazjx5d22l>
 <CAAH4kHZhEX0kaE3r5PVOOWh1PhzZNOfyWMixDm0PbCnjfmZceA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAH4kHZhEX0kaE3r5PVOOWh1PhzZNOfyWMixDm0PbCnjfmZceA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

  Hi,

> > Well.  If you want put the db into the igvm and the igvm into the uki
> > you've got a chicken-and-egg problem.  Moving the firmware from the main
> > UKI to UKI add-on would solve that.
> 
> Why is embedding a public key that will sign the IGVM in the IGVM a
> chicken-and-egg problem? It's only that if db were a list of
> acceptable measurements, which it isn't.
> I'm not sure why relying on secure boot makes any sense for
> confidential computing. I still think that tearing down the VM context
> and rebuilding it is more secure, given
> the need for an honest launch measurement/MRTD.

Current idea is to allow passing EFI signature databases for db/dbx to
the firmware getting loaded.  The signature databases must be part of
the launch measurement.  Not clear yet how exactly to handle that, one
idea is to add a special page type to the igvm spec, so a igvm parser
can easily find and update db/dbx.

So, the VM context will be rebuild, the igvm (including db/dbx) will be
measured, the firmware can verify the payload using db/dbx and standard
secure boot hash/signature.

This allows to use both signing (pass CA certificate in db) and hashing
(pass authenticode hash(es) in db) for payload verification.

The chicken-and-egg problem arises if you go for hashing and want embed
the igvm file in the UKI.

> Revocation is just not a real thing that works. Short-lived policy is.
> Policy services can be updated more simply than the UEFI variables of
> every node in the fleet.

In the model outlined above you'll go ship db/dbx in the igvm, so the
launch measurement will tell you what is allowed and what is not.  Which
in turn can be used in attestation server policies.

take care,
  Gerd


