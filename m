Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D298C10A1E7D
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 11:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5is7-0005VQ-Up; Thu, 26 Mar 2026 07:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w5is1-0005QL-Mw
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 07:27:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w5is0-0003A9-06
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 07:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774524443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=svoXzQQQPkbUen8/6/2shSvsrDG9UZjXOFDjer8+jww=;
 b=aJTIBtfoJ2j95xFyVBp2xeNY4i+C6SEsNTaT21j3Uj1hrzLAHZ4KrMbtmTfSbYCZsLDIsK
 6ZLGJbMIu2Y3phhYeYRapxE9abGLDv+QgYfNDOxWegFRYm6kUL6qgpv4DSVBfoWqhrSJ5f
 6EJINKocyoYaco0gGqD4Vn+KHPi4PmM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-u4Hj54q_M1eYR8LDvs7Ecw-1; Thu,
 26 Mar 2026 07:27:18 -0400
X-MC-Unique: u4Hj54q_M1eYR8LDvs7Ecw-1
X-Mimecast-MFC-AGG-ID: u4Hj54q_M1eYR8LDvs7Ecw_1774524437
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F17A7195607B; Thu, 26 Mar 2026 11:27:16 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 773D21955D84; Thu, 26 Mar 2026 11:27:15 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [RFC v2 4/7] hw/tpm: Implement TPM CRB chunking logic
From: marcandre.lureau@redhat.com
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, marcandre.lureau@redhat.com, 
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20260319135316.37412-5-armenon@redhat.com>
References: <20260319135316.37412-1-armenon@redhat.com>
 <20260319135316.37412-5-armenon@redhat.com>
Date: Thu, 26 Mar 2026 15:27:02 +0400
Message-Id: <177452442285.34609.12928739139262714987.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4660;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Br2MbDAm3OhsXx/TcoFWlrRN/HrXZ+QoYdBDu4tQXD4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpxRgJkJzht63uTeGdRQiIyGter5ke6VcHbQOd3
 e2YjcVl+cqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCacUYCQAKCRDa6OEJdZac
 5Q3zD/4mUp+eytUX1gD3FlLeQwFH6tvmT31KklKnnMrTv/9NrSkQCEPcj+EWRqV91CXgGAbAdxQ
 wxyZyArIq5n+vW4y9e6RqtuXqvKxNOlptfvVShkPl4kmF88Bmfx/iOLe1wmy+2yLrCjyNBgQy7v
 pT5x4oIMhaoRkd1cNT2J4IV56p8G+8IB+0oxSw8d8IelbPex9qcI1t18XEMudyUdRIgerxt9HxJ
 tgirYPNomjjKu4uKINjz7XJQbudGka0lypoYjkPBuzL9iyu+Cw3B9Kgc9TtbaunTRJ9rRPuVDRe
 aCpCD8aAzo+J6XxLyrTr0dcz3Z3SDy+D+NK/Uv0jHBQyLnnLcC5PGY982c7DAH4glntBY/llSoF
 59bQ8zrdphdg+XMwkDs2gJuLsGMT/DkBKgFE182aaXBeSijoTsKhf8AnhN4TDcspE6ScmHoRKWz
 TGzpk2kysC4prij8HJXthAawG3VD/lCzce/ztOHggsCWS0J6vXbp55EIdknsYFU+8JiETgYHEfl
 adkoKb7Kc3+ZrOBeVMopEbNjjP/yP/NcC9fC6HhaHQKHXGjoFZiTpWPt21aH5a+wc1d2YJQ8jgx
 dxR+QKH40cVCJ3JY6pNG4pq0Napc2dLMh52CpMemPlmBbqPxbTq/O+EmueHUa3DnTI/Zd/nih4C
 zyj9MB8c/drJ0yg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 19 Mar 2026 19:23:13 +0530, Arun Menon <armenon@redhat.com> wrote:

Hi,

>
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index 5ea1a4a9706..e61c04aee0b 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -80,6 +82,8 @@ enum crb_ctrl_req {
>  
>  enum crb_start {
>      CRB_START_INVOKE = BIT(0),
> +    CRB_START_RESP_RETRY = BIT(1),

Hmm, maybe we should rename that field, since it is "Start" in the spec (it changed?).

> +    CRB_START_NEXT_CHUNK = BIT(2),
>  };

And follow the spec naming here "RspRetry" -> RSP_RETRY

> @@ -122,6 +126,68 @@ static uint8_t tpm_crb_get_active_locty(CRBState *s)
> [ ... skip 23 lines ... ]
> +            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS, tpmSts, 1);
> +            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, invoke, 0);
> +            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, nextChunk, 0);
> +            tpm_crb_clear_internal_buffers(s);
> +            error_report("Command size '%d' less than TPM header size '%d'",
> +                         total_request_size, TPM_HEADER_SIZE);

Use PRIu32 to avoid sign sign-mismatch

> [ ... skip 28 lines ... ]
> +    if (to_copy < CRB_CTRL_CMD_SIZE) {
> +        memset((guint8 *)mem + to_copy, 0, CRB_CTRL_CMD_SIZE - to_copy);
> +    }
> +
> +    s->response_offset += to_copy;
> +    memory_region_set_dirty(&s->cmdmem, 0, CRB_CTRL_CMD_SIZE);

Those lines are repeated below and could be factorized.

> @@ -152,20 +218,48 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
> [ ... skip 21 lines ... ]
> +            if (!(s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE)) {
> +                if (!tpm_crb_append_command_request(s)) {
> +                    break;
> +                }
> +                ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, invoke, 1);
> +                g_byte_array_set_size(s->response_buffer, s->be_buffer_size);

This pre-allocates the response buffer before the backend has written
anything. Since response_buffer->len > 0 now, a subsequent nextChunk
from the guest would enter tpm_crb_fill_command_response() and serve
uninitialized data.

Before this patch we would serve guest input data, which wasn't great either.


We could add a separate flag to track response readiness instead. This
will need to be migrated too.

> +                s->cmd = (TPMBackendCmd) {
> +                    .in = s->command_buffer->data,
> +                    .in_len = s->command_buffer->len,
> +                    .out = s->response_buffer->data,
> +                    .out_len = s->response_buffer->len,
> +                };
> +                tpm_backend_deliver_request(s->tpmbe, &s->cmd);
> +            }
> +        } else if (val & CRB_START_NEXT_CHUNK) {
> +            /*
> +             * nextChunk is used both while sending and receiving data.
> +             * To distinguish between the two, response_buffer is checked

Missing .

> +             * If it does not have data, then that means we have not yet
> +             * sent the command to the tpm backend, and therefore call
> +             * tpm_crb_append_command_request()
> +             */
> +            if (s->response_buffer->len > 0 &&
> +                s->response_offset < s->response_buffer->len) {
> +                    tpm_crb_fill_command_response(s);

Indentation <4

> +            } else {
> +                if (!tpm_crb_append_command_request(s)) {
> +                    break;
> +                }
> +            }
> +            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, nextChunk, 0);
> +        } else if (val & CRB_START_RESP_RETRY) {
> +            if (s->response_buffer->len > 0) {

I'd suggest adding a trace here.

> @@ -205,13 +299,36 @@ static const MemoryRegionOps tpm_crb_memory_ops = {
> [ ... skip 15 lines ... ]
> +
> +        /*
> +         * Send the first chunk. Subsequent chunks will be sent using
> +         * tpm_crb_fill_command_response()
> +         */
> +        uint32_t to_copy = MIN(CRB_CTRL_CMD_SIZE, s->response_buffer->len);

QEMU coding style: declaration not mixed with statements.

> +        memcpy(mem, s->response_buffer->data, to_copy);
> +
> +        if (to_copy < CRB_CTRL_CMD_SIZE) {
> +            memset((guint8 *)mem + to_copy, 0, CRB_CTRL_CMD_SIZE - to_copy);
> +        }
> +        s->response_offset += to_copy;
>      }
>      memory_region_set_dirty(&s->cmdmem, 0, CRB_CTRL_CMD_SIZE);

Consider factorizing

> +    ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, invoke, 0);

redundant clear

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


