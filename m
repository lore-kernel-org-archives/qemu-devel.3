Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C8BCD8C92
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 15:41:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWc5a-0001qc-0K; Mon, 08 Jun 2026 11:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wWc5X-0001pv-Ld
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 11:40:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wWc5V-0005nj-VG
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 11:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780933228;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ojAXK1QVYXmOIiQXhBpS8DoBmVZqCzVm4Y03iZQHggM=;
 b=ARFuIoGlXIJ9YxBajMeu9+m+8cVYa3U77x7lDyiR5ZFqTve1PUVj/1gvHAI+bFWvjnlQTc
 onmVfeb+WXuZnINgVvxlpQyHfa2S76DAK6qt6n4JF0k8bVza7qJJkfbCnDET+d5Vv33dfS
 PI/aEomMgHZ6KYo0zBzP9dXCAk6ff70=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-5qYlzUWKNje-CfgPR6Ok0A-1; Mon,
 08 Jun 2026 11:40:22 -0400
X-MC-Unique: 5qYlzUWKNje-CfgPR6Ok0A-1
X-Mimecast-MFC-AGG-ID: 5qYlzUWKNje-CfgPR6Ok0A_1780933221
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FF791956053; Mon,  8 Jun 2026 15:40:20 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.219])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0DA141954102; Mon,  8 Jun 2026 15:40:15 +0000 (UTC)
Date: Mon, 8 Jun 2026 16:40:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, zhao1.liu@intel.com, mst@redhat.com,
 cohuck@redhat.com, mtosatti@redhat.com,
 Tom Lendacky <thomas.lendacky@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, coconut-svsm@lists.linux.dev, joerg.roedel@amd.com
Subject: Re: [RFC PATCH 00/10] QEMU Support for KVM Planes
Message-ID: <aibiXAlJtbZdGdHl@redhat.com>
References: <20260608152109.356783-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260608152109.356783-1-joro@8bytes.org>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jun 08, 2026 at 05:20:59PM +0200, Jörg Rödel wrote:
> From: Joerg Roedel <joerg.roedel@amd.com>
> 
> Hi,
> 
> here are the required QEMU changes to make use of the KVM Planes
> interface posted here[1].
> 
> The patches are based on QEMU v11.0.0 and can be used to launch an AMD
> SEV-SNP VM with COCONUT-SVSM + a Linux guest.
> 
> To make this work a change to the QEMU command line is required to
> tell QEMU which plane to target external IRQs to. this is done with
> the new device-plane property to the machine specification, e.g:
> 
> $ qemu-system-x86_64 \
>   -enable-kvm \
>   -cpu EPYC-v4 \
>   -machine q35,confidential-guest-support=sev0,memory-backend=ram1,igvm-cfg=igvm0,kernel-irqchip=split,device-plane=2 \
>   -object memory-backend-memfd,id=ram1,size=32G,share=true \
>   -object sev-snp-guest,id=sev0,cbitpos=51,reduced-phys-bits=1 \
>   -object igvm-cfg,id=igvm0,file=$IGVM_FILE \
>   ...

How are device-plane values intended to be chosen by the user ?

Is "2" a value that can/should always be used, or is there a dependency
on the igvm file, or somethihng else ?


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


