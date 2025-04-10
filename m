Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3075C3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 10:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2pOf-0007zj-JX; Thu, 10 Apr 2025 06:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1u2pOd-0007z8-F2
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 06:44:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1u2pOb-0004AG-Uc
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 06:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744281871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AWn2ETE+o5qWy/I+1x/Ak7ZUkU9CsqnC20EUsr51MgI=;
 b=CiJkZQR7+QQDCkzH7x9Gi9AfyYAXc11VQ+Tj5ycetZX0pvn4lYdZlV7XmOQrc+mD7UTqTQ
 ZAYK2y8fn0PPIAottB+iQ6/67DdhurbwRNpPdFmPRmoaDhSvo2bCEuZvLbO581VmfqWdww
 hVVoeuzMr6LRwB8V87nRMlUcH2zyb+E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-3FBIvw0ROkaKm3XQDUfiiw-1; Thu,
 10 Apr 2025 06:44:25 -0400
X-MC-Unique: 3FBIvw0ROkaKm3XQDUfiiw-1
X-Mimecast-MFC-AGG-ID: 3FBIvw0ROkaKm3XQDUfiiw_1744281863
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EDABF180034D; Thu, 10 Apr 2025 10:44:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.70])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0AE021808882; Thu, 10 Apr 2025 10:44:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A804618000A1; Thu, 10 Apr 2025 12:44:19 +0200 (CEST)
Date: Thu, 10 Apr 2025 12:44:19 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Dionna Amalie Glaze <dionnaglaze@google.com>, 
 Alexander Graf <graf@amazon.com>,
 =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tsirkin <mst@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [PATCH v6] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
Message-ID: <ttp3fs5hpxj52lnp32khyskt56tokgt6msqwqn3xkw7z4k5yhk@cw7zgrogplqy>
References: <kmqzqeaatk3iyrpl4tvfxtfv6gefyusxpyxtz5bollw7jlp3wk@5c4zawrzehwq>
 <d79cff63-324f-4624-aef3-b6570cdb23e2@amazon.com>
 <rtbmlitus6unzibiatblquot2bthx4dmozbxgcbovisial6qar@konful7gzrsz>
 <6d815066-9977-4683-a2d5-871dda3e5369@amazon.com>
 <fwdk2pc4rfa5o22gdfqq4cfsqged4v6hmlrtqdwltgqj2bkpl4@bicazjx5d22l>
 <CAAH4kHZhEX0kaE3r5PVOOWh1PhzZNOfyWMixDm0PbCnjfmZceA@mail.gmail.com>
 <xjdm7m65w6hmnq3ik2psbfhizypk76c3hdriujh27kcm7ex5tv@7lq3x3k7y52h>
 <CAAH4kHbFBekcmxBQcOA9K1Y+sFc2Jf56YEa4iv0M88ib7pCjgg@mail.gmail.com>
 <aex5mpxcyybat5joqgvx4ssall53ksrfz3kkkpveso3jjosi4v@bofv3pqsgim4>
 <2A385A2F-EB29-4573-8458-C5762792DC96@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2A385A2F-EB29-4573-8458-C5762792DC96@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.593,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Apr 10, 2025 at 12:01:18PM +0530, Ani Sinha wrote:
> 
> 
> > On 9 Apr 2025, at 11:51 AM, Gerd Hoffman <kraxel@redhat.com> wrote:
> > 
> >  Hi,
> > 
> >>> The chicken-and-egg problem arises if you go for hashing and want embed
> >>> the igvm file in the UKI.
> >> 
> >> I don't really see how signing the IGVM file for secure boot helps anything.
> > 
> > It doesn't help indeed.  This comes from the original idea by Alex to
> > simply add a firmware image to the UKI.  In that case the firmware is
> > covered by the signature / hash, even though it is not needed.  Quite
> > the contrary, it complicates things when we want ship db/dbx in the
> > firmware image.
> > 
> > So most likely the firmware will not be part of the main UKI.  Options
> > for alternatives are using UKI add-ons,
> 
> But add-ons are also subjected to signature verification. How does not using the main UKI help?

For the first boot using secure boot doesn't help much, the trust
in the firmware being loaded for the second boot is established via
launch measurement not secure boot signature.

For the second boot (with new firmware) you don't need the add-on any
more.

The main advantage of wrapping the igvm into a uki add-on is that we
can easily use the hwid matching support of systemd-stub when packaging
multiple firmware variants (aws, azure, gcp, qemu, ...).  Not sure this
will actually matter in practice though.

take care,
  Gersd


