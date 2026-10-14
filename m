Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FB8CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 11:25:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGx5y-0007Zv-Pm; Wed, 14 Oct 2026 07:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xGx5x-0007Yz-2Z
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 07:24:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xGx5u-0005eI-66
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 07:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791977065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ICxmSxA7fzkIRvEOP0m142eGhzSuJSs4m8P3Cr+XBi8=;
 b=H655xoyH8xY6SGzLUoC5RQl5zQOOAl8iwM9ozzoMaFwTLmE0HyWVYzG21dxF5Z2SORe6ot
 gwNmr8y0qskO7TtbWbRjAyRsmSBJWxoM7pvUaZW18UgYCAS7tg2hlVfywxnrihY6PMC620
 UNup9sJtDJZckPgQc+8TRlNz1JdufbY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-283-1mBhQQ_JMR6L__uTmXAY1Q-1; Wed,
 14 Oct 2026 11:24:21 +0000
X-MC-Unique: 1mBhQQ_JMR6L__uTmXAY1Q-1
X-Mimecast-MFC-AGG-ID: 1mBhQQ_JMR6L__uTmXAY1Q_1791977057
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA247195606D; Wed, 14 Oct 2026 11:24:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58FE41800446; Wed, 14 Oct 2026 11:24:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EFC5F21E6A04; Wed, 14 Oct 2026 13:24:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Cc: qemu-devel@nongnu.org,  Eric Blake <eblake@redhat.com>,
 qemu-riscv@nongnu.org,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>,  Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,
 qemu-s390x@nongnu.org,  Song Gao <17746591750@163.com>,  Matthew Rosato
 <mjrosato@linux.ibm.com>,  Alistair Francis <alistair.francis@wdc.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Fabiano Rosas <farosas@suse.de>,
 Eric Farman <farman@linux.ibm.com>,  Brian Cain
 <brian.cain@oss.qualcomm.com>,  Stefan Hajnoczi <stefanha@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,  Ani Sinha <anisinha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,  =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Stafford Horne <shorne@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>,  Zhao Liu <zhao1.liu@intel.com>,
 Weiwei Li <liwei1518@gmail.com>,  David Hildenbrand <david@kernel.org>,
 Laurent Vivier <laurent@vivier.eu>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Fam Zheng <fam@euphon.net>,  "Edgar
 E. Iglesias" <edgar.iglesias@gmail.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?= <philmd@oss.qualcomm.com>,  Daniel Henrique Barboza
 <daniel.barboza@oss.qualcomm.com>,  Palmer Dabbelt <palmer@dabbelt.com>,
 qemu-arm@nongnu.org,  Chao Liu <chao.liu@processmission.com>,  Philippe
 Mathieu-Daude <philmd@mailo.com>,  Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,  Stefano Garzarella
 <sgarzare@redhat.com>
Subject: Re: [PATCH 04/34] qapi: rename SysEmuTarget to EmuTarget
In-Reply-To: <20261014093152.834-5-luoyonggang@gmail.com> (Yonggang Luo's
 message of "Wed, 14 Oct 2026 17:31:14 +0800")
References: <20261014093152.834-1-luoyonggang@gmail.com>
 <20261014093152.834-5-luoyonggang@gmail.com>
Date: Wed, 14 Oct 2026 13:24:12 +0200
Message-ID: <87ecdscyoz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

Yonggang Luo <luoyonggang@gmail.com> writes:

> As now it's also expressing user-mode targets.
>
> This changes the type name exposed by query-qmp-schema; enum values and
> serialized target values remain unchanged.

Are you sure?  query-qmp-schema masks the type names.

> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>

[...]

> diff --git a/qapi/machine.json b/qapi/machine.json
> index 9b145c635ba..07fac4f0764 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -14,7 +14,7 @@
>  { 'include': 'machine-common.json' }
>  
>  ##
> -# @SysEmuTarget:
> +# @EmuTarget:
>  #     The comprehensive enumeration of QEMU system emulation
>  #     ("softmmu") targets.  Run "./configure --help" in the project
>  #     root directory, and look for the \*-softmmu targets near the
   #     "--target-list" option.  The individual target constants are not
   #     documented here, for the time being.

Is this still correct?

> @@ -35,7 +35,7 @@
>  #
>  # Since: 3.0
>  ##
> -{ 'enum' : 'SysEmuTarget',
> +{ 'enum' : 'EmuTarget',
>    'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'hexagon', 'hppa', 'i386',
>               'loongarch64', 'm68k', 'microblaze', 'mips', 'mips64',
>               'mips64el', 'mipsel', 'or1k', 'ppc',
> @@ -95,7 +95,7 @@
>                        'qom-path'     : 'str',
>                        'thread-id'    : 'int',
>                        '*props'       : 'CpuInstanceProperties',
> -                      'target'       : 'SysEmuTarget' },
> +                      'target'       : 'EmuTarget' },
>    'discriminator' : 'target',
>    'data'          : { 's390x'        : 'CpuInfoS390' } }
>  
> @@ -281,7 +281,7 @@
>  # Since: 1.2
>  ##
>  { 'struct': 'QemuTargetInfo',
> -  'data': { 'arch': 'SysEmuTarget' } }
> +  'data': { 'arch': 'EmuTarget' } }
>  
>  ##
>  # @query-target:
> diff --git a/qapi/pragma.json b/qapi/pragma.json
> index 342cedc42e7..93a710ee937 100644
> --- a/qapi/pragma.json
> +++ b/qapi/pragma.json
> @@ -72,7 +72,7 @@
>          'SsidSizeMode',
>          'String',
>          'StringWrapper',
> -        'SysEmuTarget',
> +        'EmuTarget',
>          'ThrottleGroupProperties',
>          'VncPrimaryAuth',
>          'VncVencryptSubAuth',
> @@ -109,7 +109,7 @@
>          'QKeyCode',                 # send-key, input-sent-event
>          'QapiErrorClass',           # QMP error replies
>          'SshHostKeyCheckMode',      # blockdev-add, -blockdev
> -        'SysEmuTarget',             # query-cpu-fast, query-target
> +        'EmuTarget',                # query-cpu-fast, query-target
>          'UuidInfo',                 # query-uuid
>          'VncClientInfo',            # query-vnc, query-vnc-servers, ...
>          'X86CPURegister32'          # qom-get of x86 CPU properties

[...]


