Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A64CD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 12:20:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSDEj-0008QN-Av; Wed, 27 May 2026 08:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wSDEh-0008Q6-G4
 for qemu-devel@nongnu.org; Wed, 27 May 2026 08:19:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wSDEf-0004MT-Ha
 for qemu-devel@nongnu.org; Wed, 27 May 2026 08:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779884382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mfiKAC+4yS7SR9O4wKIKP7PofbAP9HZLW7MgehkAa38=;
 b=RF+6m96XqRukYjwRpX1dyfVytNxAvNlkRwvyNEDO5OHOXpLES94niX1lvu1Hgn3oHCIqsX
 yEqWl2siAFMgiQ5gln5Rt4tJ5if50WeatutdJ23nOPD9WnofBbwNkS+m8vfq4lTKHhjpP9
 DtGaa0vdjeY5YvVcruknNlTAvVG94hc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-390-yXpRj2XEMNacH-PMKKc_qA-1; Wed,
 27 May 2026 08:19:39 -0400
X-MC-Unique: yXpRj2XEMNacH-PMKKc_qA-1
X-Mimecast-MFC-AGG-ID: yXpRj2XEMNacH-PMKKc_qA_1779884378
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D190519560A1; Wed, 27 May 2026 12:19:37 +0000 (UTC)
Received: from localhost (dhcp-192-180.str.redhat.com [10.33.192.180])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A4BE419560AB; Wed, 27 May 2026 12:19:36 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Christoph Schlameuss <schlameuss@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Eric Farman
 <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, Richard
 Henderson <richard.henderson@linaro.org>, Ilya Leoshkevich
 <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Hendrik Brueckner
 <brueckner@linux.ibm.com>, kvm@vger.kernel.org, Christoph Schlameuss
 <schlameuss@linux.ibm.com>, Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: Re: [PATCH v2 0/2] s390x/kvm: Add ASTFLE facility 2 for nested
 virtualization
In-Reply-To: <20260324-astfleie2-v2-0-13008712da00@linux.ibm.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260324-astfleie2-v2-0-13008712da00@linux.ibm.com>
User-Agent: Notmuch/0.39 (https://notmuchmail.org)
Date: Wed, 27 May 2026 14:19:34 +0200
Message-ID: <8733zdniy1.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Mar 24 2026, Christoph Schlameuss <schlameuss@linux.ibm.com> wrote:

> Update the kernel headers to get access to
> KVM_S390_VM_CPU_FEAT_ASTFLEIE2 and allow passing the feature through to
> guest on IBM z16 onwards.
>
> Cc: qemu-devel@nongnu.org
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Eric Farman <farman@linux.ibm.com>
> Cc: Matthew Rosato <mjrosato@linux.ibm.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Hendrik Brueckner <brueckner@linux.ibm.com>
> To: qemu-s390x@nongnu.org
> Cc: kvm@vger.kernel.org
>
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> ---
> Changes in v2:
> - Isolate the linux-header update into its own commit (thanks Thomas)
> - Correct naming of the feature (thanks Hendrik)
> - Add S390_FEAT_SIE_ASTFLEIE2 to full_GEN16_GA1 only as it depends on
>   SIEF2 (thanks Christian)
>
> ---
> Christoph Schlameuss (2):
>       linux-headers: Update to Linux v7.x with KVM_S390_VM_CPU_FEAT_ASTFLEIE2
>       s390x/kvm: Add ASTFLE facility 2 for nested virtualization
>
>  hw/s390x/sclp.c                     | 2 ++
>  include/hw/s390x/sclp.h             | 4 +++-
>  linux-headers/asm-s390/kvm.h        | 1 +
>  target/s390x/cpu_features.c         | 3 +++
>  target/s390x/cpu_features.h         | 1 +
>  target/s390x/cpu_features_def.h.inc | 3 +++
>  target/s390x/cpu_models.c           | 2 ++
>  target/s390x/gen-features.c         | 1 +
>  target/s390x/kvm/kvm.c              | 1 +
>  9 files changed, 17 insertions(+), 1 deletion(-)
> ---
> base-commit: fa4b2e31e649ba6fdb3eb2dd43952aad4a3bd675
> change-id: 20260209-astfleie2-85eec9fd9213
>
> Best regards,
> -- 
> Christoph Schlameuss <schlameuss@linux.ibm.com>

Looking through old emails: Can we respin with a proper headers update by
now, or is the kernel change still pending? (Or did I miss an update? :)


