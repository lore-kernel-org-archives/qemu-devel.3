Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B094CCA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 10:46:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urDeA-0008NO-Ff; Wed, 27 Aug 2025 06:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1urDdv-0007zL-08
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 06:44:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1urDds-0003Jr-7z
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 06:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756291475;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=BJmP52gjCbkIE8q6dOXU2JnxD+IenvZDOxt/DfyFWmw=;
 b=DL6aO98bY9gd5b3WEYlQZf9TrOCKzhQoNnt525Dk9o/4LjU2NsiqGw3n8RzlrfrllU1kst
 EICnla/nt4Hrrgq5Rfh4JXKKtpfFFQ+Cg/gjj3r7TaOMbhqVSjS59ElTZi68L3G8P1QEga
 3D5yeMV3P7gA42ZBlZT7mUwASLZgpnA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-134-xFFKnJ9XOw2nbvoZey8RQA-1; Wed,
 27 Aug 2025 06:44:31 -0400
X-MC-Unique: xFFKnJ9XOw2nbvoZey8RQA-1
X-Mimecast-MFC-AGG-ID: xFFKnJ9XOw2nbvoZey8RQA_1756291469
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DB0D71800290; Wed, 27 Aug 2025 10:44:28 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.195])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 357201955F24; Wed, 27 Aug 2025 10:44:21 +0000 (UTC)
Date: Wed, 27 Aug 2025 11:44:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Magnus Kulke <magnus.kulke@microsoft.com>,
 Cornelia Huck <cohuck@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Thomas Huth <thuth@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Cameron Esfahani <dirty@apple.com>, Wei Liu <wei.liu@kernel.org>,
 Wei Liu <liuwe@microsoft.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 05/26] include/hw/hyperv: Add MSHV ABI header
 definitions
Message-ID: <aK7hggXfhuKQnnSz@redhat.com>
References: <20250807143951.1154713-1-magnuskulke@linux.microsoft.com>
 <20250807143951.1154713-6-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250807143951.1154713-6-magnuskulke@linux.microsoft.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Aug 07, 2025 at 04:39:30PM +0200, Magnus Kulke wrote:
> Introduce headers for the Microsoft Hypervisor (MSHV) userspace ABI,
> including IOCTLs and structures used to interface with the hypervisor.
> 
> These definitions are based on the upstream Linux MSHV interface and
> will be used by the MSHV accelerator backend in later patches.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>  include/hw/hyperv/hvgdk.h       |  19 +
>  include/hw/hyperv/hvgdk_mini.h  | 864 ++++++++++++++++++++++++++++++++
>  include/hw/hyperv/hvhdk.h       | 164 ++++++
>  include/hw/hyperv/hvhdk_mini.h  | 105 ++++
>  scripts/update-linux-headers.sh |   2 +-
>  5 files changed, 1153 insertions(+), 1 deletion(-)
>  create mode 100644 include/hw/hyperv/hvgdk.h
>  create mode 100644 include/hw/hyperv/hvgdk_mini.h
>  create mode 100644 include/hw/hyperv/hvhdk.h
>  create mode 100644 include/hw/hyperv/hvhdk_mini.h
> 
> diff --git a/include/hw/hyperv/hvgdk.h b/include/hw/hyperv/hvgdk.h
> new file mode 100644
> index 0000000000..d37c2b188d
> --- /dev/null
> +++ b/include/hw/hyperv/hvgdk.h
> @@ -0,0 +1,19 @@

> +#ifndef _HVGDK_H
> +#define _HVGDK_H

The choice of naming scheme for these #ifndef is a bit inconsistent
through this patch, and nit-picking the leading _ is reserved IIRC.


> diff --git a/include/hw/hyperv/hvgdk_mini.h b/include/hw/hyperv/hvgdk_mini.h
> new file mode 100644
> index 0000000000..83f44fd5fa
> --- /dev/null
> +++ b/include/hw/hyperv/hvgdk_mini.h


> +#ifndef HW_HYPERV_LINUX_MSHV_H
> +#define HW_HYPERV_LINUX_MSHV_H

> diff --git a/include/hw/hyperv/hvhdk.h b/include/hw/hyperv/hvhdk.h
> new file mode 100644
> index 0000000000..d22cc49742
> --- /dev/null
> +++ b/include/hw/hyperv/hvhdk.h

> +#ifndef HW_HYPERV_HVHDK_H
> +#define HW_HYPERV_HVHDK_H

> diff --git a/include/hw/hyperv/hvhdk_mini.h b/include/hw/hyperv/hvhdk_mini.h
> new file mode 100644
> index 0000000000..cffd16e0de
> --- /dev/null
> +++ b/include/hw/hyperv/hvhdk_mini.h

> +#ifndef _HVHDK_MINI_H
> +#define _HVHDK_MINI_H

Can we just make all these headers match the relative path under
'include/' as you did for the hvhdk.h file

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


