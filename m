Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F7810A1E68
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 11:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5isD-0005Wf-HA; Thu, 26 Mar 2026 07:27:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w5isC-0005WN-9L
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 07:27:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w5isA-0003BE-DA
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 07:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774524453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ylgpsnIn65PiH7fUhPOq6pqiv2Cy9LqY6Al99VFYinY=;
 b=Do0HSzVjI5BKj+KFVsIBhinDNfk72gci3PQPOo2TfKrBTn/WLaFsPO1RqiMWHQqTgT0sYs
 6P6uV1ciG6H3Pl5SeSFV0v8KaMqhZe5TYUtgHxpr79fPokBt7siBGmw5MYH68QA7JLw9tM
 0a1htuMWXILNjce4kMhUcKxRh5Z2wj0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-172-MlIerS1ONBWXKVXFrZ1SXQ-1; Thu,
 26 Mar 2026 07:27:30 -0400
X-MC-Unique: MlIerS1ONBWXKVXFrZ1SXQ-1
X-Mimecast-MFC-AGG-ID: MlIerS1ONBWXKVXFrZ1SXQ_1774524449
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 02B9119560A1; Thu, 26 Mar 2026 11:27:29 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5F0E01955D71; Thu, 26 Mar 2026 11:27:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [RFC v2 6/7] hw/tpm: Add support for VM migration with TPM CRB
 chunking
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
 Yanan Wang <wangyanan55@huawei.com>
In-Reply-To: <20260319135316.37412-7-armenon@redhat.com>
References: <20260319135316.37412-1-armenon@redhat.com>
 <20260319135316.37412-7-armenon@redhat.com>
Date: Thu, 26 Mar 2026 15:27:02 +0400
Message-Id: <177452442289.34609.7771820064527102277.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3512;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=x61lQ1HjZpayRQirw845+1xcLBQbajcuZGlArC5Rkow=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpxRgJLihto11kyt4ueU65ZZ/VgNbf2HlKwCC7T
 SH6vB9pIdSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCacUYCQAKCRDa6OEJdZac
 5RUCD/9GmhIwZLjrcgzEx8Nr/AQfcI2Nh/8JohBjSg3eXpCXUC3W0DUHsizTjCCjpgwA8miLDqS
 tm52fbWjyqUGJPAERGeCH+vObkmHlWQQLFgyj+cPEhpWkbUrWOctmThQifQnT1ygQIxIa1Zx3ok
 Chaaacrc8TyPCj+qWHXZsdn4AFuBbBxQ0qKhkvD548OhQcfMm7hFX/l6eUcAwvQRh1Tq2yQCCPx
 zyuKas2f1ieSlK0JzQau0gm2YPfmBI9MP9EwjiHmNs3Vof9sUk6jt7D7+2DLGEFvbIlvjtbCxLu
 mBQ2kHSyLKHhSgDZ0PZRhC4S5eBZvXah6jU5Xq9Yea3ea+w1g8yYncmDE9xj92zp8JcEJfH5V3j
 e+DdHwBnizL2TZ62GpRs91ZFMMmwjinsD6FIBOJZ8ECxOG1JPybMoGUAfchUWp7r25n6M4UyzKl
 eyEXaX+rHjrTh+F3NtJ6sd4ohLO9eMoVyOMWLhWnh7/P6zDUsb6Lx+3i+pb545ER9zdEepsCKeW
 YjV7P+WTg2K9FwCWU07fcp4y9DvFOjcbnf3ojJXeBeRS7IkGf+p1eHjPhnhzvBkpfghkZMqqVpl
 NbZJOD4UAjUIMphy+syJYPDpZQA26JUNsxpc6tTX0T8OcniLOWUcnkQxEPojUxIIFlG1w7yeWL7
 Panrf1GYM0a1Qng==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
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

On Thu, 19 Mar 2026 19:23:15 +0530, Arun Menon <armenon@redhat.com> wrote:

Hi

>
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 6cf0e2f404e..fcd6043c992 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -40,6 +40,7 @@
>  
>  GlobalProperty hw_compat_10_2[] = {

Let's not forget to update this to 11.0 for 11.1 :)

>
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index e61c04aee0b..9ce342fe8ac 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -33,6 +33,17 @@
>  #include "trace.h"
>  #include "qom/object.h"
>  
> +/* command and response buffers; part of VM state when migrating */
> +typedef struct TPMCRBMigState {
> +    uint32_t cmd_size;
> +    uint8_t *cmd_tmp;

Could we name them after the name of the state fields?
command_buffer_len && command_buffer_data ?

> +
> +    uint32_t rsp_size;
> +    uint8_t *rsp_tmp;

(response_buffer_len ..)

Actually, you should not need an extra MigState at all. Check how
GByteArray are handled in in ui/vdagent.c for example. (I have a doubt
that it may eventually leak if loading for a running state, where data
!= NULL though, I would have to check - we may want to use realloc for
buffers)

> @@ -347,18 +361,118 @@ static int tpm_crb_pre_save(void *opaque)
> [ ... skip 30 lines ... ]
> +    } else {
> +        s->mig.rsp_tmp = NULL;
> +        s->mig.rsp_size = 0;
> +    }
> +    s->mig.rsp_offset = (uint32_t)s->response_offset;
> +    return 0;

If you get rid of MigState, the original response_offset field will
proably have to be uint32_t too.

> [ ... skip 14 lines ... ]
> +        g_free(s->mig.cmd_tmp);
> +        s->mig.cmd_tmp = NULL;
> +        g_free(s->mig.rsp_tmp);
> +        s->mig.rsp_tmp = NULL;
> +        return false;
> +    }

Suggesting g_clear_pointer(&ptr, g_free)

> +
> +    if (s->mig.cmd_tmp) {
> +        if (s->command_buffer) {
> +            g_byte_array_unref(s->command_buffer);
> +        }

Slightly neater:
g_clear_pointer(&s->command_buffer, g_byte_array_unref);

> +        s->command_buffer = g_byte_array_new_take(s->mig.cmd_tmp,
> +                                                  s->mig.cmd_size);
> +        s->mig.cmd_tmp = NULL;
> +    } else {
> +        if (s->command_buffer) {
> +            g_byte_array_set_size(s->command_buffer, 0);
> +        }
> +    }
> +    if (s->mig.rsp_tmp) {
> +        if (s->response_buffer) {
> +            g_byte_array_unref(s->response_buffer);
> +        }

Or you could simply without condition:

g_clear_pointer(&s->command_buffer, g_byte_array_unref);
s->command_buffer = g_byte_array_new_take(s->mig.cmd_tmp, s->mig.cmd_size);

This will also reset the size to 0 if cmd_tmp is NULL and cmd_size is 0.

> +        s->response_buffer = g_byte_array_new_take(s->mig.rsp_tmp,
> +                                                   s->mig.rsp_size);
> +        s->mig.rsp_tmp = NULL;
> +    }

Missing
    s->response_offset = s->mig.rsp_offset;

> +    return true;
> +}
> +
> +static const VMStateDescription vmstate_tpm_crb_chunk = {
> +    .name = "tpm-crb/chunk",
> +    .version_id = 1,
> +    .needed = tpm_crb_chunk_needed,
> +    .pre_save = tpm_crb_chunk_pre_save,
> +    .post_load_errp = tpm_crb_chunk_post_load,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT32(mig.cmd_size, CRBState),

Could be version 0, I think.

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


