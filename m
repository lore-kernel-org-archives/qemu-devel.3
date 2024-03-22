Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B03C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 12:52:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rneMR-00023v-Ty; Fri, 22 Mar 2024 08:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rneMM-00022a-3p
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 08:50:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rneMK-0003Ae-Bc
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 08:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711111853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WooMsR1THrWNs3sSPXkMGo7sE9cVLAC8nCveF1oP/UU=;
 b=FNhnlqR7pKstmT8g11R/IAN57SflLpXu/jTRvlC+HIUgbzR15XDE5zsICHPWOzjIwZbb3k
 f520EN5BbN4Zh1wPS3TrBwP+0dgZISLByanNOcIngKI/1D03O1ebaAxps9rCe64/3qbF6o
 sE4x/75LTfJn1a5jRmff08CQ3PxJu3Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-BXuJwiB0NCOlqhzb0oaKrw-1; Fri, 22 Mar 2024 08:50:50 -0400
X-MC-Unique: BXuJwiB0NCOlqhzb0oaKrw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DCC8A800265;
 Fri, 22 Mar 2024 12:50:49 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B690C2022C1D;
 Fri, 22 Mar 2024 12:50:49 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8756518014AE; Fri, 22 Mar 2024 13:50:44 +0100 (CET)
Date: Fri, 22 Mar 2024 13:50:44 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-devel@nongnu.org, Tom Lendacky <thomas.lendacky@amd.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 1/2] kvm: add support for guest physical bits
Message-ID: <6gxghpqxu3756dddw7eia7hkmr4ufwhdm4pdun2iukq7fv2q4w@mt3u5ijgmhyx>
References: <20240318155336.156197-1-kraxel@redhat.com>
 <20240318155336.156197-2-kraxel@redhat.com>
 <54e8b518-2bea-4a5b-a75a-4fd45535c6fa@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54e8b518-2bea-4a5b-a75a-4fd45535c6fa@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> > +    if (cpu->host_phys_bits_limit &&
> > +        cpu->guest_phys_bits > cpu->host_phys_bits_limit) {
> > +        cpu->guest_phys_bits = cpu->host_phys_bits_limit;
> 
> host_phys_bits_limit takes effect only when cpu->host_phys_bits is set.
> 
> If users pass configuration like "-cpu
> qemu64,phys-bits=52,host-phys-bits-limit=45", the cpu->guest_phys_bits will
> be set to 45. I think this is not what we want, though the usage seems
> insane.
> 
> We can guard it as
> 
>  if (cpu->host_phys_bits && cpu->host_phys_bits_limit &&
>      cpu->guest_phys_bits > cpu->host_phys_bits_limt)
> {
> }

Yes, makes sense.

> Simpler, we can guard with cpu->phys_bits like below, because
> cpu->host_phys_bits_limit is used to guard cpu->phys_bits in
> host_cpu_realizefn()
> 
>  if (cpu->guest_phys_bits > cpu->phys_bits) {
> 	cpu->guest_phys_bits = cpu->phys_bits;
> }

I think I prefer the first version.  The logic is already difficult
enough to follow because it is spread across a bunch of files due to
the different cases we have to handle (tcg, kvm-with-host_phys_bits,
kvm-without-host_phys_bits).

It's not in any way performance-critical, so I happily trade some extra
checks for code which is easier to read.

take care,
  Gerd


