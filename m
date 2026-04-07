Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A282FF5136
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABXE-00006Y-PU; Tue, 07 Apr 2026 14:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wABTu-0004Gt-R3
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:48:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wA1gt-0006gw-3e
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 04:21:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775550101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mWpQT0dknhNKj0VsojXMSC/uWMN+igrWgr6kzYG4LPY=;
 b=eSIHCjjmpLqtJedACvY8nNDMbpewDPJR7+uj1FpRHKNpgrikldprBThZ/hhEPJtf1qmcBf
 t4SJXMt0HC2QVLjJ2SroK8AKZ0cHo+98rqcUCns3e23VWeOwc/VhVxLqPJv2EryAL5YdVG
 VdWQ9Z+YDTPvxH0VMHYBavi6dbb3cJ4=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-PZEvmoZKMxO_Fr7yAXM8xg-1; Tue, 07 Apr 2026 04:21:40 -0400
X-MC-Unique: PZEvmoZKMxO_Fr7yAXM8xg-1
X-Mimecast-MFC-AGG-ID: PZEvmoZKMxO_Fr7yAXM8xg_1775550099
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c7424d91b2dso2471164a12.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 01:21:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775550099; cv=none;
 d=google.com; s=arc-20240605;
 b=OM0ca0Uc41pWYzVPV4JRcjub+L7luqw2qnYeTn5wk9wNVyMktoqNaVQ2KujZqVhAoJ
 /sXAKe1Q75fWHBlsnAnxkJqfoHh3bX7PncIxtCmsVLi43TXJSSYSIkQF3AHLhi+1srEJ
 W4ICFUaFUd3pGnk/koshhqwngBoGVINrqoGabG5bdqHHmX9Zdb2jSqAWpROwDdB4u3Jq
 qRlxd6eKmWeesoHNRUB34tPu9r7UJlcGDBRNanDg4OadMPuMH4FXzw07WRgsjkvVmXIs
 7qpqE9dTf7JmxbaIax92YT+Fy/1I3/lq9gx4Dph5Z4ZTDUtlynii4gqLoneXHQXdev/g
 EoJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mWpQT0dknhNKj0VsojXMSC/uWMN+igrWgr6kzYG4LPY=;
 fh=I3Rojz7Rj7F7zAuh27Zv7NEdlY6RHgtmEIjZ7Qkr/EI=;
 b=YXAQF/N5C0BzfR77zwYwFucVPkyrK3z2wWrfck3FVgxw5COuRQ3a/J+RuqUsRAqoYd
 ZRLgz48IYc3WtgyHmSGyBZuyrRlB55aUyFHeQH6sAahozb+aJkAUPFi77+A5rADGGnYS
 3x1xTlMoEEl+G3QQ1a49eqE/K4TvuJHc5xyuSH/q4dkmMZuB30c+/k3AkSONIPEOqh7r
 pH45eLfegwUwLEcVUKLqE0dOPqppl0WrcMETUMX6fGTPvXsfP9C8sYLdgl5qpgNEL11X
 vR1NkWqG3/kRmFUEtpUkwlGEDBVFtOviBn/PHdMnCvlRHf00lCub+zzW8tf0vhUfAN1z
 UGkw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775550099; x=1776154899; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mWpQT0dknhNKj0VsojXMSC/uWMN+igrWgr6kzYG4LPY=;
 b=qJ3taXSfxWrsmaQaS4ZQ67Bp0RWovqemXDfDVyLatyEXpUubzNcbdO8YdVO70+ODZl
 FAJ4kIey2CiP6ddSO1hdzIUKw2/fesXvwIZUo1Zn22aS5RgpA4fJJ6EGv+NNvHPrZz1u
 MmjjSomGZI9CJnjUmFtSBld/TIeXrvDDlUWMfaPI3sh+jj5QJi/+FQwYRrT0k2kahz14
 9prUeedAZwNeQQK9bawONAR8N3EoY3Jnc7TtKhmwRBgO1A4up7AcYC6D8eDyYxzNW6w5
 WQdbFaHuykropbCduaYB2cn9KAukomVUDhavNS6juAAscN2Ppgd4O1OhQ6xuS5IrDh1g
 Pk6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775550099; x=1776154899;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mWpQT0dknhNKj0VsojXMSC/uWMN+igrWgr6kzYG4LPY=;
 b=slMh4kqQHW7X2rWMYvoBcxDYKEiQVHqIy0p4BJkIecGItZpDH0kVHQBYnaQr/L3JGo
 b7k+wDZuOLQNagYbVTH0lGRE3adw/09DyiGC36VDpE7zlVgmptR0J9YrADnBVtbS/wYA
 mrXR0nwwkyRKyjDb/DwvtaRB6rkUtQ/swX9V2yaaKugpC77Nh/drR6qflvdoqF8EVW8V
 zGRH9jCO71K3gKo5UJcJp80ABMrvpv2AQqO2pPeOVSa0rkQoHoT1rrU+8Rb/H3SUSuj9
 XxuKH/ab4ptn9l6JnxVkjOhipFTaDReCmH7FLSVJrxYoHpZ7KP4eXYvSdwA0XUMk5VFp
 9fKQ==
X-Gm-Message-State: AOJu0YyQZt9eA4lQW5Ll73O/nVVcFz+yy361TiRA18IrkJc2xSRPCaMV
 kquGh8WA1F2ruR0rbNXyIMAqZLMNt4TSnEJh6fWtukKG+IfRDKKGcSi7xl4JUQ31YfJN60W8ajQ
 O9Gm8tlU4nj7U1imzcUS2eDZnyicBuewUXgFt8Ct617DTQ92mxU3h+vW4TwRM81W5mYDlWEWcBY
 3vKhmCw4jJ/oXAp+6oK9thD5qZlB8zGdU=
X-Gm-Gg: AeBDieswIgZG1VxQJkDlLmTzmKZgIS0wVkxhqTLjM8Rhl9lCvwBeHWa1BADhkijQQgl
 FK3gcCCXMm1AdhuP6FvzxpfHuXXJOOGW2RDuUhKzRbIl8XyEj/Yv6P6xdUS0o07WZjqoONtCWZ1
 0KZWaaNQTKVupiRBeSxK+X5HeAdWKNlbcCFDavSIgG3J4/d4a7pwl257Ve9KpjpAYONKOssDqYM
 v0LKNI9LQHFen6wekl6otaPIKeWyxMwQCegMidoHD70TQbC5rkbXQ8L1BFjtqKdyrWx42X7OXWe
 P1zf62rDD+JDDREQ2SlMhuw=
X-Received: by 2002:a05:6a20:430b:b0:398:6ea8:21d2 with SMTP id
 adf61e73a8af0-39f2ed8d9e7mr16422529637.19.1775550098727; 
 Tue, 07 Apr 2026 01:21:38 -0700 (PDT)
X-Received: by 2002:a05:6a20:430b:b0:398:6ea8:21d2 with SMTP id
 adf61e73a8af0-39f2ed8d9e7mr16422487637.19.1775550098118; Tue, 07 Apr 2026
 01:21:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260406141735.25844-1-armenon@redhat.com>
 <20260406141735.25844-5-armenon@redhat.com>
In-Reply-To: <20260406141735.25844-5-armenon@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 7 Apr 2026 12:21:25 +0400
X-Gm-Features: AQROBzBYfGFbuWJawAiQJBzQVL-Nyr2nCgb6jSxEBbj7hle34KbzndB9So58KyY
Message-ID: <CAMxuvaxDAd40uaH+fqKhNcbi3ibVUZtA7yxHHCh-HVkZF-a-Kw@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] hw/tpm: Implement TPM CRB chunking logic
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>, 
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Stefan Berger <stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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

Hi

On Mon, Apr 6, 2026 at 6:18=E2=80=AFPM Arun Menon <armenon@redhat.com> wrot=
e:
>
> From: Arun Menon <armenon@redhat.com>
>
> - Add logic to populate internal TPM command request and response
>   buffers and to toggle the control registers after each operation.
> - The chunk size is limited to CRB_CTRL_CMD_SIZE which is
>   (TPM_CRB_ADDR_SIZE - A_CRB_DATA_BUFFER). This comes out as 3968 bytes
>   (4096 - 128 or 0x1000 - 0x80), because 128 bytes are reserved for
>   control and status registers. In other words, only 3968 bytes are
>   available for the TPM data.
> - With this feature, guests can send commands larger than 3968 bytes.
> - Refer section 6.5.3.9 of [1] for implementation details.
>
> [1] https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specif=
ic-Platform-TPM-Profile-for-TPM-2p0-v1p07_rc1_121225.pdf

https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-Pla=
tform-TPM-Profile-for-TPM-2p0-v1p07_Pub.pdf

>
> Signed-off-by: Arun Menon <armenon@redhat.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/tpm/tpm_crb.c | 148 +++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 131 insertions(+), 17 deletions(-)
>
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index d65b3e2cc1..b9f295db7a 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -17,6 +17,7 @@
>  #include "qemu/osdep.h"
>
>  #include "qemu/module.h"
> +#include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include "system/address-spaces.h"
>  #include "hw/core/qdev-properties.h"
> @@ -65,6 +66,7 @@ DECLARE_INSTANCE_CHECKER(CRBState, CRB,
>  #define CRB_INTF_CAP_CRB_CHUNK 0b1
>
>  #define CRB_CTRL_CMD_SIZE (TPM_CRB_ADDR_SIZE - A_CRB_DATA_BUFFER)
> +#define TPM_HEADER_SIZE 10
>
>  enum crb_loc_ctrl {
>      CRB_LOC_CTRL_REQUEST_ACCESS =3D BIT(0),
> @@ -80,6 +82,8 @@ enum crb_ctrl_req {
>
>  enum crb_start {
>      CRB_START_INVOKE =3D BIT(0),
> +    CRB_START_RSP_RETRY =3D BIT(1),
> +    CRB_START_NEXT_CHUNK =3D BIT(2),
>  };
>
>  enum crb_cancel {
> @@ -122,6 +126,69 @@ static uint8_t tpm_crb_get_active_locty(CRBState *s)
>      return ARRAY_FIELD_EX32(s->regs, CRB_LOC_STATE, activeLocality);
>  }
>
> +static bool tpm_crb_append_command_request(CRBState *s)
> +{
> +    /*
> +     * The linux guest writes the TPM command to the MMIO region in chun=
ks.
> +     * This function appends a chunk from the MMIO region to internal
> +     * command_buffer.
> +     */
> +    void *mem =3D memory_region_get_ram_ptr(&s->cmdmem);
> +    uint32_t to_copy =3D 0;
> +    uint32_t total_request_size =3D 0;
> +
> +    /*
> +     * The initial call extracts the total TPM command size
> +     * from its header. For the subsequent calls, the data already
> +     * appended in the command_buffer is used to calculate the total
> +     * size, as its header stays the same.
> +     */
> +    if (s->command_buffer->len =3D=3D 0) {
> +        total_request_size =3D tpm_cmd_get_size(mem);
> +        if (total_request_size < TPM_HEADER_SIZE) {
> +            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS, tpmSts, 1);
> +            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, invoke, 0);
> +            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, nextChunk, 0);
> +            tpm_crb_clear_internal_buffers(s);
> +            error_report("Command size %" PRIu32 " less than "
> +                         "TPM header size %" PRIu32,
> +                         total_request_size, (uint32_t)TPM_HEADER_SIZE);
> +            return false;
> +        }
> +    } else {
> +        total_request_size =3D tpm_cmd_get_size(s->command_buffer->data)=
;
> +    }
> +    total_request_size =3D MIN(total_request_size, s->be_buffer_size);
> +
> +    if (total_request_size > s->command_buffer->len) {
> +        uint32_t remaining =3D total_request_size - s->command_buffer->l=
en;
> +        to_copy =3D MIN(remaining, CRB_CTRL_CMD_SIZE);
> +        g_byte_array_append(s->command_buffer, (guint8 *)mem, to_copy);
> +    }
> +    return true;
> +}
> +
> +static void tpm_crb_fill_command_response(CRBState *s)
> +{
> +    /*
> +     * Response from the tpm backend will be stored in the internal
> +     * response_buffer. This function will serve that accumulated respon=
se
> +     * to the linux guest in chunks by writing it back to MMIO region.
> +     */
> +    void *mem =3D memory_region_get_ram_ptr(&s->cmdmem);
> +    uint32_t remaining =3D s->response_buffer->len - s->response_offset;
> +    uint32_t to_copy =3D MIN(CRB_CTRL_CMD_SIZE, remaining);
> +
> +    memcpy(mem, s->response_buffer->data + s->response_offset, to_copy);
> +
> +    if (to_copy < CRB_CTRL_CMD_SIZE) {
> +        memset((guint8 *)mem + to_copy, 0, CRB_CTRL_CMD_SIZE - to_copy);
> +    }
> +
> +    s->response_offset +=3D to_copy;
> +    memory_region_set_dirty(&s->cmdmem, 0, CRB_CTRL_CMD_SIZE);
> +}
> +
>  static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
>                                 uint64_t val, unsigned size)
>  {
> @@ -152,20 +219,55 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr=
 addr,
>          }
>          break;
>      case A_CRB_CTRL_START:
> -        if (val =3D=3D CRB_START_INVOKE &&
> -            !(s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE) &&
> -            tpm_crb_get_active_locty(s) =3D=3D locty) {
> -            void *mem =3D memory_region_get_ram_ptr(&s->cmdmem);
> -
> -            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, invoke, 1);
> -            s->cmd =3D (TPMBackendCmd) {
> -                .in =3D mem,
> -                .in_len =3D MIN(tpm_cmd_get_size(mem), s->be_buffer_size=
),
> -                .out =3D mem,
> -                .out_len =3D s->be_buffer_size,
> -            };
> -
> -            tpm_backend_deliver_request(s->tpmbe, &s->cmd);
> +        if (tpm_crb_get_active_locty(s) !=3D locty) {
> +            break;
> +        }
> +        if (s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE) {
> +            /*
> +             * Backend TPM is busy processing a request.
> +             */
> +            break;
> +        }
> +        if (val & CRB_START_INVOKE) {
> +            if (!(s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE)) {
> +                if (!tpm_crb_append_command_request(s)) {
> +                    break;
> +                }
> +                ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, invoke, 1);
> +                g_byte_array_set_size(s->response_buffer, s->be_buffer_s=
ize);
> +                s->cmd =3D (TPMBackendCmd) {
> +                    .in =3D s->command_buffer->data,
> +                    .in_len =3D s->command_buffer->len,
> +                    .out =3D s->response_buffer->data,
> +                    .out_len =3D s->response_buffer->len,
> +                };
> +                tpm_backend_deliver_request(s->tpmbe, &s->cmd);
> +            }
> +        } else if (val & CRB_START_NEXT_CHUNK) {
> +            /*
> +             * nextChunk is used both while sending and receiving data.
> +             * To distinguish between the two, response_buffer is checke=
d.
> +             * If it does not have data, then that means we have not yet
> +             * sent the command to the tpm backend, and therefore call
> +             * tpm_crb_append_command_request().
> +             */
> +            if (s->response_buffer->len > 0 &&
> +                s->response_offset < s->response_buffer->len) {
> +                tpm_crb_fill_command_response(s);
> +            } else {
> +                if (!tpm_crb_append_command_request(s)) {
> +                    break;
> +                }
> +            }
> +            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, nextChunk, 0);
> +        } else if (val & CRB_START_RSP_RETRY) {
> +            if (s->response_buffer->len > 0) {
> +                trace_tpm_crb_mmio_write(addr, size, val);
> +                s->response_offset =3D 0;
> +                tpm_crb_fill_command_response(s);
> +            }
> +            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, crbRspRetry, 0);
> +            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, nextChunk, 0);
>          }
>          break;
>      case A_CRB_LOC_CTRL:
> @@ -210,8 +312,21 @@ static void tpm_crb_request_completed(TPMIf *ti, int=
 ret)
>      if (ret !=3D 0) {
>          ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
>                           tpmSts, 1); /* fatal error */
> +        tpm_crb_clear_internal_buffers(s);
> +    } else {
> +        uint32_t actual_resp_size =3D tpm_cmd_get_size(s->response_buffe=
r->data);
> +        uint32_t total_resp_size =3D MIN(actual_resp_size, s->be_buffer_=
size);
> +        g_byte_array_set_size(s->response_buffer, total_resp_size);
> +        s->response_offset =3D 0;
>      }
> -    memory_region_set_dirty(&s->cmdmem, 0, CRB_CTRL_CMD_SIZE);
> +    /*
> +     * Send the first chunk. Subsequent chunks will be sent
> +     * on receiving nextChunk from the guest
> +     */
> +    tpm_crb_fill_command_response(s);
> +    ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, nextChunk, 0);
> +    ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, crbRspRetry, 0);
> +    g_byte_array_set_size(s->command_buffer, 0);
>  }
>
>  static enum TPMVersion tpm_crb_get_version(TPMIf *ti)
> @@ -288,8 +403,7 @@ static void tpm_crb_reset(void *dev)
>      s->regs[R_CRB_CTRL_RSP_SIZE] =3D CRB_CTRL_CMD_SIZE;
>      s->regs[R_CRB_CTRL_RSP_ADDR] =3D TPM_CRB_ADDR_BASE + A_CRB_DATA_BUFF=
ER;
>
> -    s->be_buffer_size =3D MIN(tpm_backend_get_buffer_size(s->tpmbe),
> -                            CRB_CTRL_CMD_SIZE);
> +    s->be_buffer_size =3D tpm_backend_get_buffer_size(s->tpmbe);
>
>      if (tpm_backend_startup_tpm(s->tpmbe, s->be_buffer_size) < 0) {
>          exit(1);
> --
> 2.53.0
>


