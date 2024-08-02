Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D3EC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 13:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZsPv-0006mo-Q6; Fri, 02 Aug 2024 09:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sZsPu-0006fz-4X
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:33:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sZsPr-0000GP-Nh
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:33:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722605635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PphM4JgO0cyM/LeCsv+9YANj7R4hWT+sHE411nAjkiI=;
 b=IxQLVUVC/QSkrhjEqAwFhY+Cgsa1x0opiGd3lCTyzPwfCGv4v9g+prplkNUp3BeAxvWpok
 44IvsoPdLRdnz74zQXxVKGEs3NS7gyc5brIgcdN3+47X/xSceADbFjs1DLDB4UtD5YNoiA
 pzUI4Qz12jlYFcptvLCE+ye807EwK8o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-29-n3xbxhm5MlCQMeatMPDrUA-1; Fri,
 02 Aug 2024 09:33:51 -0400
X-MC-Unique: n3xbxhm5MlCQMeatMPDrUA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 80D0E19560B1; Fri,  2 Aug 2024 13:33:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C22F19560AE; Fri,  2 Aug 2024 13:33:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3C96721E668F; Fri,  2 Aug 2024 15:33:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Josh Junon <junon@oro.sh>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Eric Blake <eblake@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  Philippe =?utf-8?Q?Mathi?=
 =?utf-8?Q?eu-Daud=C3=A9?=
 <philmd@linaro.org>,  Yanan Wang <wangyanan55@huawei.com>,  Zhao Liu
 <zhao1.liu@intel.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2] qmp: Use unsigned integers for address parameters
In-Reply-To: <20240802125132.19860-1-junon@oro.sh> (Josh Junon's message of
 "Fri, 2 Aug 2024 14:51:32 +0200")
References: <20240802125132.19860-1-junon@oro.sh>
Date: Fri, 02 Aug 2024 15:33:45 +0200
Message-ID: <87a5hv122u.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.124,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Josh Junon <junon@oro.sh> writes:

> Fixes higher-half address parsing for QMP commands
> `[p]memsave` and `dump-guest-memory`.
>
> Signed-off-by: Josh Junon <junon@oro.sh>
> ---
>  dump/dump.c       |  4 ++--
>  qapi/dump.json    |  2 +-
>  qapi/machine.json | 11 +++++++++--
>  system/cpus.c     |  8 ++++----
>  4 files changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/dump/dump.c b/dump/dump.c
> index 45e84428ae..00a1323735 100644
> --- a/dump/dump.c
> +++ b/dump/dump.c
> @@ -2063,8 +2063,8 @@ DumpQueryResult *qmp_query_dump(Error **errp)
>  
>  void qmp_dump_guest_memory(bool paging, const char *protocol,
>                             bool has_detach, bool detach,
> -                           bool has_begin, int64_t begin,
> -                           bool has_length, int64_t length,
> +                           bool has_begin, uint64_t begin,
> +                           bool has_length, uint64_t length,
>                             bool has_format, DumpGuestMemoryFormat format,
>                             Error **errp)
>  {
[...]
       dump_init(s, fd, has_format, format, paging, has_begin,
-->              begin, length, kdump_raw, errp);
       if (*errp) {
           qatomic_set(&s->status, DUMP_STATUS_FAILED);
           return;
       }

Passing @begin and @length to dump_init() converts them to int64_t.
Whether values exceeding 2^63 work is anybody's guess.

A complete fix for dump-guest-memory will be a bit of a yak shave, I'm
afraid.  Feel free fix just memsave and pmemsave.

> diff --git a/qapi/dump.json b/qapi/dump.json
> index d8145dad97..3b751c0356 100644
> --- a/qapi/dump.json
> +++ b/qapi/dump.json
> @@ -102,7 +102,7 @@
>  ##
>  { 'command': 'dump-guest-memory',
>    'data': { 'paging': 'bool', 'protocol': 'str', '*detach': 'bool',
> -            '*begin': 'int', '*length': 'int',
> +            '*begin': 'uint64', '*length': 'size',
>              '*format': 'DumpGuestMemoryFormat'} }
>  
>  ##
> diff --git a/qapi/machine.json b/qapi/machine.json
> index fcfd249e2d..fb618dc99f 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -852,7 +852,11 @@
>  #     <- { "return": {} }
>  ##
>  { 'command': 'memsave',
> -  'data': {'val': 'int', 'size': 'int', 'filename': 'str', '*cpu-index': 'int'} }
> +  'data': {
> +     'val': 'uint64',
> +     'size': 'size',
> +     'filename': 'str',
> +     '*cpu-index': 'int' } }
>  
>  ##
>  # @pmemsave:
> @@ -878,7 +882,10 @@
>  #     <- { "return": {} }
>  ##
>  { 'command': 'pmemsave',
> -  'data': {'val': 'int', 'size': 'int', 'filename': 'str'} }
> +  'data': {
> +    'val': 'uint64',
> +    'size': 'size',
> +    'filename': 'str' } }
>  
>  ##
>  # @Memdev:
> diff --git a/system/cpus.c b/system/cpus.c
> index 5e3a988a0a..128face42b 100644
> --- a/system/cpus.c
> +++ b/system/cpus.c
> @@ -792,14 +792,14 @@ int vm_stop_force_state(RunState state)
>      }
>  }
>  
> -void qmp_memsave(int64_t addr, int64_t size, const char *filename,
> +void qmp_memsave(uint64_t addr, uint64_t size, const char *filename,
>                   bool has_cpu, int64_t cpu_index, Error **errp)
>  {
>      FILE *f;
>      uint32_t l;
>      CPUState *cpu;
>      uint8_t buf[1024];
> -    int64_t orig_addr = addr, orig_size = size;
> +    uint64_t orig_addr = addr, orig_size = size;
>  
>      if (!has_cpu) {
>          cpu_index = 0;
       }
       [...]
           if (cpu_memory_rw_debug(cpu, addr, buf, l, 0) != 0) {
               error_setg(errp, "Invalid addr 0x%016" PRIx64 "/size %" PRId64

PRIu64

                                " specified", orig_addr, orig_size);
               goto exit;
           }
> @@ -840,11 +840,11 @@ exit:
>      fclose(f);
>  }
>  
> -void qmp_pmemsave(int64_t addr, int64_t size, const char *filename,
> +void qmp_pmemsave(uint64_t addr, uint64_t size, const char *filename,
>                    Error **errp)
>  {
>      FILE *f;
> -    uint32_t l;
> +    uint64_t l;

Either leave it alone here, or change it in qmp_memsave(), too.

>      uint8_t buf[1024];
>  
>      f = fopen(filename, "wb");


