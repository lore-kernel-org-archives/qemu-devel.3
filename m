Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62FC3C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 08:16:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkJmC-0002VT-48; Wed, 13 Mar 2024 04:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rkJm8-0002Pq-Ov
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 04:15:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rkJm6-00021u-Qb
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 04:15:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710317744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4iiF09AQqMKK+vz1K8fXrb5ZKZyEsbQmkRPwfWXefcA=;
 b=GZqVWz1nSv+YRHm9sarPz0h9TiiZX6kiwKM5TW45STuk2HDLL/ihq5xpWl7wXPSeXr4DHF
 nBYPxS33hiLImfRQSZYqbyDULPNTwEQ9D1ouT/nw5fyaaYmrK32NJPoWJXCi9XIF36mGPR
 JVw5AJywl3sLqlXR8BawPA6nvq0CCpM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-8uImgTX4Omuj2Ikv2gNyVA-1; Wed, 13 Mar 2024 04:15:40 -0400
X-MC-Unique: 8uImgTX4Omuj2Ikv2gNyVA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C5B688F522;
 Wed, 13 Mar 2024 08:15:40 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E82C31C060D0;
 Wed, 13 Mar 2024 08:15:39 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id ADEB318009A3; Wed, 13 Mar 2024 09:15:38 +0100 (CET)
Date: Wed, 13 Mar 2024 09:15:38 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Tao Su <tao1.su@linux.intel.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Tom Lendacky <thomas.lendacky@amd.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 kvm@vger.kernel.org
Subject: Re: [PATCH v2 2/2] kvm: add support for guest physical bits
Message-ID: <bu2rau6gpkgbm3uagostv6fxye53nd3qx7fhdxcr5mwwvd7yln@4nesoydyg7dt>
References: <20240305105233.617131-1-kraxel@redhat.com>
 <20240305105233.617131-3-kraxel@redhat.com>
 <ZfFKJPYoE5bacb6+@linux.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfFKJPYoE5bacb6+@linux.bj.intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Mar 13, 2024 at 02:39:32PM +0800, Tao Su wrote:
> On Tue, Mar 05, 2024 at 11:52:33AM +0100, Gerd Hoffmann wrote:
> > Query kvm for supported guest physical address bits, in cpuid
> > function 80000008, eax[23:16].  Usually this is identical to host
> > physical address bits.  With NPT or EPT being used this might be
> > restricted to 48 (max 4-level paging address space size) even if
> > the host cpu supports more physical address bits.
> > 
> > When set pass this to the guest, using cpuid too.  Guest firmware
> > can use this to figure how big the usable guest physical address
> > space is, so PCI bar mapping are actually reachable.
> 
> If this patch is applied, do you have plans to implement it in
> OVMF/Seabios?

Yes.  ovmf test patches:

https://github.com/kraxel/edk2/commits/devel/guest-phys-bits/

take care,
  Gerd


