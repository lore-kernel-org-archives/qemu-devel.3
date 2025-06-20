Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A18CC71155
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 06:48:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSVXd-00033p-JF; Fri, 20 Jun 2025 02:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uSVXZ-00033T-70
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 02:47:57 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uSVXW-0003Z8-M4
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 02:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750402074; x=1781938074;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=s/tlyFKUlsV2ZQdddyx7HwUKs+VhS0FD6ld2nuptmgk=;
 b=DvRgdZGhEQ6CgpOQOy51zozU3eyAPWeiobXfK5oX67HR34M95ttmWgb7
 ak7+bTO0jUwTjd9rPL1nrdp405Ek9lzFl47pOG/HGz2E52BXW+N5atOVA
 I3JmR9QnyiZ8yQXWlfQ+usY8HeFJxqBssHXNgdGjwjEploBck8A5bHZkp
 7WUKGih5+QpSuC8KvhidCGtdM9LKAasGPLKPPzaDzqF60eeM8u0rG6Qf4
 AeO9lB5+4IOMYCJJtOm9sRrc79h8HgNCw3qHvFEk//EQbK6v80BvcXsVy
 e8GqPij1uw+6JXuro5vTwVXhR+mVWxh6VgQQ3o52d6+KOVW+mN9HeeYPm g==;
X-CSE-ConnectionGUID: chbQ5WDHQWOaI8kEefGcvA==
X-CSE-MsgGUID: hzWWTROWSrqC3ee7MravWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52800832"
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; d="scan'208";a="52800832"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2025 23:47:50 -0700
X-CSE-ConnectionGUID: D4hluaLVTFq2BFUxo8MqMA==
X-CSE-MsgGUID: j7qSvAL3Q2uLRe/z4xrorA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; d="scan'208";a="151136242"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2025 23:47:48 -0700
Message-ID: <c60001b3-12d2-4261-8b6b-a7bfaf4e71ff@intel.com>
Date: Fri, 20 Jun 2025 14:47:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] i386/tdx: handle TDG.VP.VMCALL<GetQuote>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Chenyi Qiang <chenyi.qiang@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>
References: <20250619203351.393786-1-pbonzini@redhat.com>
 <20250619203351.393786-4-pbonzini@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250619203351.393786-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

On 6/20/2025 4:33 AM, Paolo Bonzini wrote:

...

> +static void tdx_generate_quote_cleanup(TdxGenerateQuoteTask *task)
> +{
> +    timer_del(&task->timer);
> +
> +    g_source_remove(task->watch);

It needs to be

	if (task->watch) {
		g_source_remove(task->watch);
	}

for the case that QGS is not available, thus no task->watch initilaized, 
and we will get

   qemu-system-x86_64: GLib: g_source_remove: assertion 'tag > 0' failed

> +    qio_channel_close(QIO_CHANNEL(task->sioc), NULL);
> +    object_unref(OBJECT(task->sioc));
> +
> +    task->completion(task);
> +}
> +
> +static gboolean tdx_get_quote_read(QIOChannel *ioc, GIOCondition condition,
> +                                   gpointer opaque)
> +{
...> +    if (task->receive_buf_received >= (sizeof(qgs_msg_header_t) + 
HEADER_SIZE)) {
> +        qgs_msg_header_t *hdr = (qgs_msg_header_t *)(task->receive_buf + HEADER_SIZE);
> +        if (hdr->major_version != QGS_MSG_LIB_MAJOR_VER ||
> +            hdr->minor_version != QGS_MSG_LIB_MINOR_VER) {

This check makes it fail with old QGS, which defines

QGS_MSG_LIB_MINOR_VER as 0,

so what QEMU gets is 1.0 instead of 1.1.

It is really a QGS bug that when it changes QGS_MSG_LIB_MINOR_VER from 0 
to 1, it didn't consider the compatible issue.

However, the old QGS is there. Should we relax the check here for it? or 
just let it fail with old QGS?

> +}
> +

...

> +static void tdx_quote_generator_connected(QIOTask *qio_task, gpointer opaque)
> +{
> +    TdxGenerateQuoteTask *task = opaque;
> +    Error *err = NULL;
> +    int ret;
> +
> +    ret = qio_task_propagate_error(qio_task, &err);
> +    if (ret) {
> +        error_report_err(err);
> +        task->status_code = TDX_VP_GET_QUOTE_QGS_UNAVAILABLE;

Do we need to provide more specific information here? What we got with a 
wrong QGS socket address can be, e.g.,

   qemu-system-x86_64: Failed to connect to '2:4051': Connection reset 
by peer

Which doesn't look directly related to QGS of TDX.

> +        tdx_generate_quote_cleanup(task);
> +        return;
> +    }
> +
> +    task->watch = qio_channel_add_watch(QIO_CHANNEL(task->sioc), G_IO_OUT,
> +                                        tdx_send_report, task, NULL);
> +}
> +

...

> +void tdx_handle_get_quote(X86CPU *cpu, struct kvm_run *run)

The previous version of mine, defined the return type as int, because it 
wants to stop the QEMU when it hits the failure of 
address_space_read/write. However, this patch returns 
TDG_VP_VMCALL_INVALID_OPERAND to TD guest for such cases.

Shouldn't the failure of address_space_read/write be treated as QEMU 
internal error?

> +{
> +    TdxGenerateQuoteTask *task;
> +    struct tdx_get_quote_header hdr;
> +    hwaddr buf_gpa = run->tdx.get_quote.gpa;
> +    uint64_t buf_len = run->tdx.get_quote.size;
> +
> +    QEMU_BUILD_BUG_ON(sizeof(struct tdx_get_quote_header) != TDX_GET_QUOTE_HDR_SIZE);
> +
> +    run->tdx.get_quote.ret = TDG_VP_VMCALL_INVALID_OPERAND;
> +
> +    if (buf_len == 0) {
> +        return;
> +    }
> +
> +    if (!QEMU_IS_ALIGNED(buf_gpa, 4096) || !QEMU_IS_ALIGNED(buf_len, 4096)) {
> +        run->tdx.get_quote.ret = TDG_VP_VMCALL_ALIGN_ERROR;
> +        return;
> +    }
> +
> +    if (address_space_read(&address_space_memory, buf_gpa, MEMTXATTRS_UNSPECIFIED,
> +                           &hdr, TDX_GET_QUOTE_HDR_SIZE) != MEMTX_OK) {
> +        error_report("TDX: get-quote: failed to read GetQuote header.");
> +        return;
> +    }
> +
> +    if (le64_to_cpu(hdr.structure_version) != TDX_GET_QUOTE_STRUCTURE_VERSION) {
> +        return;
> +    }
> +
> +    /* Only safe-guard check to avoid too large buffer size. */
> +    if (buf_len > TDX_GET_QUOTE_MAX_BUF_LEN ||
> +        le32_to_cpu(hdr.in_len) > buf_len - TDX_GET_QUOTE_HDR_SIZE) {
> +        return;
> +    }
> +
> +    if (!tdx_guest->qg_sock_addr) {
> +        hdr.error_code = cpu_to_le64(TDX_VP_GET_QUOTE_QGS_UNAVAILABLE);
> +        if (address_space_write(&address_space_memory, buf_gpa,
> +                                MEMTXATTRS_UNSPECIFIED,
> +                                &hdr, TDX_GET_QUOTE_HDR_SIZE) != MEMTX_OK) {
> +            error_report("TDX: failed to update GetQuote header.");
> +            return;
> +        }
> +        run->tdx.get_quote.ret = TDG_VP_VMCALL_SUCCESS;
> +        return;
> +    }
> +
> +    qemu_mutex_lock(&tdx_guest->lock);
> +    if (tdx_guest->num >= TDX_MAX_GET_QUOTE_REQUEST) {
> +        qemu_mutex_unlock(&tdx_guest->lock);
> +        run->tdx.get_quote.ret = TDG_VP_VMCALL_RETRY;
> +        return;
> +    }
> +    tdx_guest->num++;
> +    qemu_mutex_unlock(&tdx_guest->lock);
> +
> +    task = g_new(TdxGenerateQuoteTask, 1);
> +    task->buf_gpa = buf_gpa;
> +    task->payload_gpa = buf_gpa + TDX_GET_QUOTE_HDR_SIZE;
> +    task->payload_len = buf_len - TDX_GET_QUOTE_HDR_SIZE;
> +    task->hdr = hdr;
> +    task->completion = tdx_get_quote_completion;
> +
> +    task->send_data_size = le32_to_cpu(hdr.in_len);
> +    task->send_data = g_malloc(task->send_data_size);
> +    task->send_data_sent = 0;
> +
> +    if (address_space_read(&address_space_memory, task->payload_gpa,
> +                           MEMTXATTRS_UNSPECIFIED, task->send_data,
> +                           task->send_data_size) != MEMTX_OK) {
> +        goto out_free;
> +    }
> +
> +    /* Mark the buffer in-flight. */
> +    hdr.error_code = cpu_to_le64(TDX_VP_GET_QUOTE_IN_FLIGHT);
> +    if (address_space_write(&address_space_memory, buf_gpa,
> +                            MEMTXATTRS_UNSPECIFIED,
> +                            &hdr, TDX_GET_QUOTE_HDR_SIZE) != MEMTX_OK) {
> +        goto out_free;
> +    }
> +
> +    task->receive_buf = g_malloc0(task->payload_len);
> +    task->receive_buf_received = 0;
> +    task->opaque = tdx_guest;
> +
> +    object_ref(tdx_guest);
> +    tdx_generate_quote(task, tdx_guest->qg_sock_addr);
> +    run->tdx.get_quote.ret = TDG_VP_VMCALL_SUCCESS;
> +    return;
> +
> +out_free:
> +    g_free(task->send_data);
> +    g_free(task);
> +}
> +


