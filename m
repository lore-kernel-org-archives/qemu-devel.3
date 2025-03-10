Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41870C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 13:47:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trdT5-0004ft-W6; Mon, 10 Mar 2025 09:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1trdS9-0004HF-8G
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 09:46:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1trdS6-0001MT-1P
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 09:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741614348;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yEM1WTc0gTqKqTL27ZzH6cIVDjKmJ0cvjGf5ZbAWNjE=;
 b=PBlTlikFIwjxkGZ7Pcgs/BU35FhZKbl2MfbBnsG07mRvT/SzO50dMk4aQNSN/AIANd+fdc
 URoWr7l+Bb8eXbIAPbHZvvORf0EyjGRiSf2ofwhrbsGQylHJLUbBREzUtKi7amDq9f9MAE
 zRQyzCfh23B3vlB8gcPKoYlXkqbHhPs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-s9HoD3CDPJGdkPehrs39Uw-1; Mon,
 10 Mar 2025 09:45:43 -0400
X-MC-Unique: s9HoD3CDPJGdkPehrs39Uw-1
X-Mimecast-MFC-AGG-ID: s9HoD3CDPJGdkPehrs39Uw_1741614341
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C32A719560A1; Mon, 10 Mar 2025 13:45:38 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.49])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E692C1956094; Mon, 10 Mar 2025 13:45:32 +0000 (UTC)
Date: Mon, 10 Mar 2025 13:45:29 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eric Blake <eblake@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: Re: [PATCH v2 2/3] cpus: Introduce SysemuCPUOps::qmp_dump_skeys()
 callback
Message-ID: <Z87s-Z0IM0613sbG@redhat.com>
References: <20250310133118.3881-1-philmd@linaro.org>
 <20250310133118.3881-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250310133118.3881-3-philmd@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Mar 10, 2025 at 02:31:17PM +0100, Philippe Mathieu-Daudé wrote:
> Allow generic CPUs to dump the architecture storage keys.
> 
> Being specific to s390x, it is only implemented there.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/hw/core/sysemu-cpu-ops.h | 6 ++++++
>  target/s390x/cpu-system.c        | 2 ++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
> index 877892373f9..d3534cba65c 100644
> --- a/include/hw/core/sysemu-cpu-ops.h
> +++ b/include/hw/core/sysemu-cpu-ops.h
> @@ -47,6 +47,12 @@ typedef struct SysemuCPUOps {
>       *       a memory access with the specified memory transaction attributes.
>       */
>      int (*asidx_from_attrs)(CPUState *cpu, MemTxAttrs attrs);
> +
> +    /**
> +     * @qmp_dump_skeys: Callback to dump guest's storage keys to @filename.
> +     */
> +    void (*qmp_dump_skeys)(const char *filename, Error **errp);

Is it right to hook this onto the CPU object ? In the next patch
the code arbitrarily picks the 1st CPU and adds a "FIXME" annotation,
but the actual impl of dump code doesn't seem to be tied to any CPU
object at all, it is getting what looks like a global singleton
object holding the keys.

IOW, should this hook be against the machine type instead, if it
is dumping global state, not tied to a specific CPU ?

> +
>      /**
>       * @get_crash_info: Callback for reporting guest crash information in
>       * GUEST_PANICKED events.
> diff --git a/target/s390x/cpu-system.c b/target/s390x/cpu-system.c
> index 9b380e343c2..ab7bb8d5cf5 100644
> --- a/target/s390x/cpu-system.c
> +++ b/target/s390x/cpu-system.c
> @@ -38,6 +38,7 @@
>  #include "system/system.h"
>  #include "system/tcg.h"
>  #include "hw/core/sysemu-cpu-ops.h"
> +#include "hw/s390x/storage-keys.h"
>  
>  bool s390_cpu_has_work(CPUState *cs)
>  {
> @@ -179,6 +180,7 @@ static const struct SysemuCPUOps s390_sysemu_ops = {
>      .get_phys_page_debug = s390_cpu_get_phys_page_debug,
>      .get_crash_info = s390_cpu_get_crash_info,
>      .write_elf64_note = s390_cpu_write_elf64_note,
> +    .qmp_dump_skeys = s390_qmp_dump_skeys,
>      .legacy_vmsd = &vmstate_s390_cpu,
>  };
>  
> -- 
> 2.47.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


