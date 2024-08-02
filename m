Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588AFC52D6F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 14:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZt7N-0005tE-Fk; Fri, 02 Aug 2024 10:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sZt7M-0005sj-7i
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 10:18:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sZt7K-0003ls-Eb
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 10:18:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722608329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cV+YDvha47zfALy1OKL95ZUaoq3M6coBDVpSDzSE4rM=;
 b=UH3rZA6c6PZ9nvsPFyBU/IPxJF45uQuIBE/oRTAYURrlzlqsDldJyIOGQZ5aRToOUBxaBp
 OCN6rTEtFNtExhvTXQKVv9CdkjaRiW/kZi9vGVDK7PZn571xdJJtsyC68JqB6YQqU8pYx7
 +5yutMASqM3LxjKo2uz+lbVNEdFebNo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-225-GTT0oPpMPPC9eTxa4Zs8qg-1; Fri,
 02 Aug 2024 10:18:45 -0400
X-MC-Unique: GTT0oPpMPPC9eTxa4Zs8qg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E72661956046; Fri,  2 Aug 2024 14:18:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 148FE1955D4B; Fri,  2 Aug 2024 14:18:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E351A21E668B; Fri,  2 Aug 2024 16:18:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Josh Junon <junon@oro.sh>
Cc: qemu-devel@nongnu.org,  Eric Blake <eblake@redhat.com>,  Markus
 Armbruster <armbru@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  Philippe =?utf-8?Q?Mathi?=
 =?utf-8?Q?eu-Daud=C3=A9?=
 <philmd@linaro.org>,  Yanan Wang <wangyanan55@huawei.com>,  Zhao Liu
 <zhao1.liu@intel.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3] qmp: Use unsigned integers for address parameters
In-Reply-To: <20240802140704.13591-1-junon@oro.sh> (Josh Junon's message of
 "Fri, 2 Aug 2024 16:07:03 +0200")
References: <20240802140704.13591-1-junon@oro.sh>
Date: Fri, 02 Aug 2024 16:18:40 +0200
Message-ID: <87r0b7xb27.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
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

Let's go back to v1's title

    qmp: Fix higher half vaddrs for [p]memsave

Josh Junon <junon@oro.sh> writes:

> Fixes higher-half address parsing for QMP commands
> `[p]memsave`.
>
> Signed-off-by: Josh Junon <junon@oro.sh>
> ---
>  qapi/machine.json | 11 +++++++++--
>  system/cpus.c     | 10 +++++-----
>  2 files changed, 14 insertions(+), 7 deletions(-)
>
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
> index 5e3a988a0a..f33e4fbff0 100644
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
> -    uint32_t l;
> +    uint64_t l;
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
                                " specified", orig_addr, orig_size);

@size is now unsigned and should be formatted with PRIu64.

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
>      uint8_t buf[1024];
>  
>      f = fopen(filename, "wb");

I can address my nitpicks in my tree, no respin necessary.

Reviewed-by: Markus Armbruster <armbru@redhat.com>


