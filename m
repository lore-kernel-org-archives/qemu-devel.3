Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C58C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 17:17:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf0Zj-0007Hc-5l; Fri, 16 Aug 2024 13:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sf0Zh-0007BS-FS
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:17:17 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sf0Zf-00005h-45
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:17:17 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EACE01FB5D;
 Fri, 16 Aug 2024 17:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1723828630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L9H3PG+aUx3swI3Attbv90lpGucUVS9L4+EaOebnv6k=;
 b=XDGw/qgUf72S7RKz2k6KVvateNlxuH5V0hcFQ4JOt5N43a1ft85FDveBiCnXrvZwx3uHDe
 LXlkQqd5lA1ILN0Q5bPaBIheC+PnsdwPl7yRZFoq77WBe9e0PxvN1VRgtDjaPzrRK5kl6G
 TRXpgdv7DXdtEVH8MJhq7h2zDqg6RHw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1723828630;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L9H3PG+aUx3swI3Attbv90lpGucUVS9L4+EaOebnv6k=;
 b=+rogWnGR2k/7eo8sXPDP7jlNRhrOltDOkYtnl+OR3lyJDp1EmzgEX63TRRbJYeuEBYf5k2
 Ex4t1ejeGXdmVsDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1723828629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L9H3PG+aUx3swI3Attbv90lpGucUVS9L4+EaOebnv6k=;
 b=sNAVnwPJ8t7bKKo7fXiJX54VRYkE7HUFVGZAtw+B6DIZYcSBMzpSWZYisbpD3vbYOMfNG7
 zf+SkZJ7NKVvfH6igG0vBFTxDSPBB8M13y+fsVZmR5uvLGOcrV1Z5CfqbzVZlqqLy2hot6
 pYj3UGmAPwDAimzCN/yAV7BVcPL/ceI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1723828629;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L9H3PG+aUx3swI3Attbv90lpGucUVS9L4+EaOebnv6k=;
 b=Q8/aZ6rRMYNvyhj63BGCO7utabSWgPGS3ojvh3h+qEoGUEN1afYUrilKs28M4Hp5qzhFFh
 qIOuB1tHvdCCQGAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67CA713A2F;
 Fri, 16 Aug 2024 17:17:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vDu/C5WJv2bYOAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 16 Aug 2024 17:17:09 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Yichen Wang <yichen.wang@bytedance.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, =?utf-8?Q?M?=
 =?utf-8?Q?arc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Zou, Nanhai" <nanhai.zou@intel.com>, "Ho-Ren (Jack) Chuang"
 <horenchuang@bytedance.com>, Yichen Wang <yichen.wang@bytedance.com>
Subject: Re: [PATCH v7 1/5] docs/migration: add qatzip compression feature
In-Reply-To: <20240815002124.65384-2-yichen.wang@bytedance.com>
References: <20240815002124.65384-1-yichen.wang@bytedance.com>
 <20240815002124.65384-2-yichen.wang@bytedance.com>
Date: Fri, 16 Aug 2024 14:17:06 -0300
Message-ID: <87ttfk5qwd.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.26 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.16)[-0.813]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[16]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, intel.com:url, intel.com:email,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Yichen Wang <yichen.wang@bytedance.com> writes:

> From: Yuan Liu <yuan1.liu@intel.com>
>
> add Intel QATzip compression method introduction
>
> Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Yichen Wang <yichen.wang@bytedance.com>
> ---
>  docs/devel/migration/features.rst           |   1 +
>  docs/devel/migration/qatzip-compression.rst | 165 ++++++++++++++++++++
>  2 files changed, 166 insertions(+)
>  create mode 100644 docs/devel/migration/qatzip-compression.rst
>
> diff --git a/docs/devel/migration/features.rst b/docs/devel/migration/features.rst
> index 58f8fd9e16..8f431d52f9 100644
> --- a/docs/devel/migration/features.rst
> +++ b/docs/devel/migration/features.rst
> @@ -14,3 +14,4 @@ Migration has plenty of features to support different use cases.
>     CPR
>     qpl-compression
>     uadk-compression
> +   qatzip-compression
> diff --git a/docs/devel/migration/qatzip-compression.rst b/docs/devel/migration/qatzip-compression.rst
> new file mode 100644
> index 0000000000..a7f755eb7f
> --- /dev/null
> +++ b/docs/devel/migration/qatzip-compression.rst
> @@ -0,0 +1,165 @@
> +==================
> +QATzip Compression
> +==================
> +In scenarios with limited network bandwidth, the ``QATzip`` solution can help
> +users save a lot of host CPU resources by accelerating compression and
> +decompression through the Intel QuickAssist Technology(``QAT``) hardware.
> +
> +
> +The following test was conducted using 8 multifd channels and 10Gbps network
> +bandwidth. The results show that, compared to zstd, ``QATzip`` significantly
> +saves CPU resources on the sender and reduces migration time. Compared to the
> +uncompressed solution, ``QATzip`` greatly improves the dirty page processing
> +capability, indicated by the Pages per Second metric, and also reduces the
> +total migration time.
> +
> +::
> +
> +   VM Configuration: 16 vCPU and 64G memory
> +   VM Workload: all vCPUs are idle and 54G memory is filled with Silesia data.
> +   QAT Devices: 4
> +   |-----------|--------|---------|----------|----------|------|------|
> +   |8 Channels |Total   |down     |throughput|pages per | send | recv |
> +   |           |time(ms)|time(ms) |(mbps)    |second    | cpu %| cpu% |
> +   |-----------|--------|---------|----------|----------|------|------|
> +   |qatzip     |   16630|       28|     10467|   2940235|   160|   360|
> +   |-----------|--------|---------|----------|----------|------|------|
> +   |zstd       |   20165|       24|      8579|   2391465|   810|   340|
> +   |-----------|--------|---------|----------|----------|------|------|
> +   |none       |   46063|       40|     10848|    330240|    45|    85|
> +   |-----------|--------|---------|----------|----------|------|------|
> +
> +
> +QATzip Compression Framework
> +============================
> +
> +``QATzip`` is a user space library which builds on top of the Intel QuickAssist
> +Technology user space library, to provide extended accelerated compression and
> +decompression services.

"user space library" seems to be duplicated in this sentence.

> +
> +For more ``QATzip`` introduction, please refer to `QATzip Introduction
> +<https://github.com/intel/QATzip?tab=readme-ov-file#introductionl>`_
> +
> +::
> +
> +  +----------------+
> +  | MultiFd Thread |
> +  +-------+--------+
> +          |
> +          | compress/decompress
> +  +-------+--------+
> +  | QATzip library |
> +  +-------+--------+
> +          |
> +  +-------+--------+
> +  |  QAT library   |
> +  +-------+--------+
> +          |         user space
> +  --------+---------------------
> +          |         kernel space
> +   +------+-------+
> +   |  QAT  Driver |
> +   +------+-------+
> +          |
> +   +------+-------+
> +   | QAT Devices  |
> +   +--------------+
> +
> +
> +QATzip Installation
> +-------------------
> +
> +The ``QATzip`` installation package has been integrated into some Linux
> +distributions and can be installed directly. For example, the Ubuntu Server
> +24.04 LTS system can be installed using below command
> +
> +.. code-block:: shell
> +
> +   #apt search qatzip
> +   libqatzip-dev/noble 1.2.0-0ubuntu3 amd64
> +     Intel QuickAssist user space library development files
> +
> +   libqatzip3/noble 1.2.0-0ubuntu3 amd64
> +     Intel QuickAssist user space library
> +
> +   qatzip/noble,now 1.2.0-0ubuntu3 amd64 [installed]
> +     Compression user-space tool for Intel QuickAssist Technology
> +
> +   #sudo apt install libqatzip-dev libqatzip3 qatzip
> +
> +If your system does not support the ``QATzip`` installation package, you can
> +use the source code to build and install, please refer to `QATzip source code installation
> +<https://github.com/intel/QATzip?tab=readme-ov-file#build-intel-quickassist-technology-driver>`_
> +
> +QAT Hardware Deployment
> +-----------------------
> +
> +``QAT`` supports physical functions(PFs) and virtual functions(VFs) for
> +deployment, and users can configure ``QAT`` resources for migration according
> +to actual needs. For more details about ``QAT`` deployment, please refer to
> +`Intel QuickAssist Technology Documentation
> +<https://intel.github.io/quickassist/index.html>`_
> +
> +For more ``QAT`` hardware introduction, please refer to `intel-quick-assist-technology-overview
> +<https://www.intel.com/content/www/us/en/architecture-and-technology/intel-quick-assist-technology-overview.html>`_
> +
> +How To Use QATzip Compression
> +=============================
> +
> +1 - Install ``QATzip`` library
> +
> +2 - Build ``QEMU`` with ``--enable-qatzip`` parameter
> +
> +  E.g. configure --target-list=x86_64-softmmu --enable-kvm ``--enable-qatzip``
> +
> +3 - Set ``migrate_set_parameter multifd-compression qatzip``
> +
> +4 - Set ``migrate_set_parameter multifd-qatzip-level comp_level``, the default
> +comp_level value is 1, and it supports levels from 1 to 9
> +
> +QAT Memory Requirements
> +=======================
> +
> +The user needs to reserve system memory for the QAT memory management to
> +allocate DMA memory. The size of the reserved system memory depends on the
> +number of devices used for migration and the number of multifd channels.
> +
> +Because memory usage depends on QAT configuration, please refer to `QAT Memory
> +Driver Queires

Queries

> +<https://intel.github.io/quickassist/PG/infrastructure_debugability.html?highlight=memory>`_
> +for memory usage calculation.
> +
> +.. list-table:: An example of a PF used for migration
> +  :header-rows: 1
> +
> +  * - Number of channels
> +    - Sender memory usage
> +    - Receiver memory usage
> +  * - 2
> +    - 10M
> +    - 10M
> +  * - 4
> +    - 12M
> +    - 14M
> +  * - 8
> +    - 16M
> +    - 20M
> +
> +How To Choose Between QATzip and QPL
> +====================================
> +Starting from Intel 4th Gen Intel Xeon Scalable processors, codenamed Sapphire
> +Rapids processor(``SPR``), it supports multiple build-in accelerators including
> +``QAT`` and ``IAA``, the former can accelerate ``QATzip``, and the latter is
> +used to accelerate ``QPL``.

This sentence needs some work. "Intel" seems to be duplicated, unless
there's a comma somewhere in there to define the subject of the sentence
("it supports"). s/build-in/built-in/ and the last comma before the
"and" can be dropped.

> +
> +Here are some suggestions:
> +
> +1 - If your live migration scenario is limited network bandwidth and ``QAT``
> +hardware resources exceed ``IAA``, then use the ``QATzip`` method, which
> +can save a lot of host CPU resources for compression.
> +
> +2 - If your system cannot support shared virtual memory(SVM) technology, please
> +use ``QATzip`` method because ``QPL`` performance is not good without SVM
> +support.
> +
> +3 - For other scenarios, please use the ``QPL`` method first.

These would be better without the possessives: "If the live migration",
"If the system". Also, this is a nitpick, but "please" doesn't really
fit a technical document.

