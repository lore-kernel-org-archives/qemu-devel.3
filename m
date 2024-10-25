Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE15AD0C61D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 14:53:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Lgd-0002xZ-EL; Fri, 25 Oct 2024 10:53:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1t4LgZ-0002x8-8s
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:53:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1t4LgU-00054T-Aj
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:53:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729867981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oCATtNYUN/GH6SdVzjWLD+NRphY1brBLxdU6nbHifzE=;
 b=MI/UxZZ/yB+uCu6/Ya6CrDcdl6FjZaxDAnN3/GDmw2REIixje8YwNtZd1tC+jMRA8ZYnTc
 5NANnouD5vgejOB/LkYen8G5BJ/PWXReQP0gJDJPj8WMUXFoI9TxpXa8Xe9okHkcYxpdQZ
 F1sW4L4BClRy9eztD4Mbqt6PTqK/zTU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-149-vvtCLRQwPH6-Gn7xQefQPA-1; Fri,
 25 Oct 2024 10:51:32 -0400
X-MC-Unique: vvtCLRQwPH6-Gn7xQefQPA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA9EC19560A6; Fri, 25 Oct 2024 14:51:30 +0000 (UTC)
Received: from pinwheel (unknown [10.39.208.23])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 09383300018D; Fri, 25 Oct 2024 14:51:22 +0000 (UTC)
Date: Fri, 25 Oct 2024 16:51:19 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, cohuck@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com,
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com,
 jdenemar@redhat.com, shahuang@redhat.com, mark.rutland@arm.com,
 philmd@linaro.org, pbonzini@redhat.com
Subject: Re: [RFC 00/21] kvm/arm: Introduce a customizable aarch64 KVM host
 model
Message-ID: <ZxuwZw2plMI6dNyE@pinwheel>
References: <20241025101959.601048-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025101959.601048-1-eric.auger@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kchamart@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Oct 25, 2024 at 12:17:19PM +0200, Eric Auger wrote:

Hi Eric,

I'm new to Arm, so please bear with my questions :)

> This RFC series introduces a KVM host "custom" model.

(a) On terminology: as we know, in the x86 world, QEMU uses these
    terms[1]:

    - Host passthrough
    - Named CPU models
    - Then there's the libvirt abstraction, "host-model", that aims to
      provide the best of 'host-passthrough' + named CPU models.

    Now I see the term "host 'custom' model" here.  Most
    management-layer tools and libvirt users are familiar with the
    classic terms "host-model" or "custom".  If we now say "host
    'custom' model", it can create confusion.  I hope we can settle on
    one of the existing terms, or create a new term if need be.

    (I'll share one more thought on how layers above libvirt tend to use
    the term "custom", as a reply to patch 21/21, "arm/cpu-features:
    Document custom vcpu model".)

(b) The current CPU features doc[2] for Arm doesn't mention "host
    passthrough" at all.  It is only implied by the last part of this
    paragraph, from the section titled "A note about CPU models and
    KVM"[3]:

      "Named CPU models generally do not work with KVM. There are a few
      cases that do work [...] but mostly if KVM is enabled the 'host'
      CPU type must be used."

    Related: in your reply[4] to Dan in this series, you write: "Having
    named models is the next thing".  So named CPU models will be a
    thing in Arm, too?  Then the above statement in the Arm
    'cpu-features' will need updating :-)

[...]

> - the QEMU layer does not take care of IDREG field value consistency.
>   The kernel neither. I imagine this could be the role of the upper
>   layer to implement a vcpu profile that makes sure settings are
>   consistent. Here we come to "named" models. What should they look
>   like on ARM?

Are there reasons why they can't be similar to how x86 reports in
`qemu-system-x86 -cpu help`?  

E.g. If it's an NVIDIA "Grace A02" (Neoverse-V2) host, it can report:

    [gracehopper] $> qemu-kvm -cpu help
    Available CPUs:
      gracehopper-neoverse-v2
      cortex-a57 (deprecated)
      host
      max

Or whatever is the preferred nomenclature for ARM.  It also gives users
of both x86 and ARM deployments a consistent expectation.  

Currently on a "Grace A02" ("Neoverse-V2") machine, it reports:

    [gracehopper] $> qemu-kvm -cpu help
    Available CPUs:
      cortex-a57 (deprecated)
      host
      max

I see it's because there are no named models yet on ARM :-)

[...]

[1] https://www.qemu.org/docs/master/system/i386/cpu.html
[2] https://www.qemu.org/docs/master/system/arm/cpu-features.html
[3] https://www.qemu.org/docs/master/system/arm/cpu-features.html#a-note-about-cpu-models-and-kvm
[4] https://lists.nongnu.org/archive/html/qemu-arm/2024-10/msg00891.html


-- 
/kashyap


