Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91BA3C3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 15:42:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uErl4-0005hB-9n; Tue, 13 May 2025 11:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uErl2-0005gr-EQ
 for qemu-devel@nongnu.org; Tue, 13 May 2025 11:41:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uErl0-0007o2-Le
 for qemu-devel@nongnu.org; Tue, 13 May 2025 11:41:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747150885;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cmcBme9RJOCaIz52I3Nem99kp82JzzM+3hYCaD81L68=;
 b=gLDBX6ZN14TPIBkLAkA7cQdm8k7eorokC8BUcPwzob9BXdzRNsiIr4WlVdTZ6PqIk0PZwn
 oVq8ArwdchN0FJMljpTOXxnFqXCB3++Zg7fTxf3g2GNs4VgNVjDBqj2x2RAtTqSBYUYkNO
 TUJmCZPTe9B5wcOSUy/QQsxQXQejE5U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-kY9XtUMzOoagtJuJDj4qRA-1; Tue,
 13 May 2025 11:41:21 -0400
X-MC-Unique: kY9XtUMzOoagtJuJDj4qRA-1
X-Mimecast-MFC-AGG-ID: kY9XtUMzOoagtJuJDj4qRA_1747150879
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB0531956086; Tue, 13 May 2025 15:41:18 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.110])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A681E1953B82; Tue, 13 May 2025 15:41:10 +0000 (UTC)
Date: Tue, 13 May 2025 16:41:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com,
 armbru@redhat.com, abologna@redhat.com, jdenemar@redhat.com,
 agraf@csgraf.de, shahuang@redhat.com, mark.rutland@arm.com,
 philmd@linaro.org, pbonzini@redhat.com
Subject: Re: [PATCH for-10.1 v5 02/13] arm/cpu: Store aa64isar0/aa64zfr0 into
 the idregs arrays
Message-ID: <aCNoEs-jQ7IUTt8q@redhat.com>
References: <20250409144304.912325-1-cohuck@redhat.com>
 <20250409144304.912325-3-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250409144304.912325-3-cohuck@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Apr 09, 2025 at 04:42:53PM +0200, Cornelia Huck wrote:
> From: Eric Auger <eric.auger@redhat.com>
> 
> Also add kvm add accessors for storing host features into idregs.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Sebastian Ott <sebott@redhat.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  target/arm/cpu-features.h | 57 ++++++++++++++++++++-------------------
>  target/arm/cpu-sysregs.h  |  4 +++
>  target/arm/cpu.c          | 10 +++----
>  target/arm/cpu.h          |  2 --
>  target/arm/cpu64.c        |  8 +++---
>  target/arm/helper.c       |  6 +++--
>  target/arm/hvf/hvf.c      |  3 ++-
>  target/arm/kvm.c          | 30 ++++++++++++++++++---
>  target/arm/tcg/cpu64.c    | 44 ++++++++++++++++++------------
>  9 files changed, 101 insertions(+), 63 deletions(-)

> diff --git a/target/arm/cpu-sysregs.h b/target/arm/cpu-sysregs.h
> index 7877a3b06a8e..e89a1105904c 100644
> --- a/target/arm/cpu-sysregs.h
> +++ b/target/arm/cpu-sysregs.h
> @@ -39,4 +39,8 @@ extern const uint32_t id_register_sysreg[NUM_ID_IDX];
>  
>  int get_sysreg_idx(ARMSysRegs sysreg);
>  
> +#ifdef CONFIG_KVM
> +uint64_t idregs_sysreg_to_kvm_reg(ARMSysRegs sysreg);
> +#endif

This breaks the build when KVM is disabled, and/or not available
on the build target architecture

In file included from ../target/arm/cpu.h:35,
                 from /var/home/berrange/src/virt/qemu/include/hw/arm/digic.h:21,
                 from ../hw/arm/digic_boards.c:31:
/var/home/berrange/src/virt/qemu/target/arm/cpu-sysregs.h:42:8: error: attempt to use poisoned ‘CONFIG_KVM’
   42 | #ifdef CONFIG_KVM
      |        ^
In file included from /var/home/berrange/src/virt/qemu/include/exec/poison.h:7,
                 from /var/home/berrange/src/virt/qemu/include/qemu/osdep.h:38,
                 from ../hw/arm/digic_boards.c:26:
./config-poison.h:185:20: note: poisoned here
  185 | #pragma GCC poison CONFIG_KVM
      |                    ^~~~~~~~~~
ninja: build stopped: subcommand failed.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


