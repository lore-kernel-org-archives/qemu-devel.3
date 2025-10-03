Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D08CAC5B8
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 02:00:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4V4r-0004eF-Gk; Thu, 02 Oct 2025 21:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4V4p-0004dS-4c
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 21:59:19 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4V4c-0000OP-Vs
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 21:59:14 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b48d8deaef9so204418866b.2
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 18:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759456739; x=1760061539; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ym9iib3rwJZUajKUC19f/PU/oJoIU/amsUaJSsDykk4=;
 b=NBnkYagOIlXBAQRQP8Q6MS1LMs2Pz5ypR9/K/9NF/RFLHbF3Cw6BRh89beabUU29U6
 9D+LdBWWrNxgBjniBOXtAj1A9JP8fiGihSqjI09yMu3IwtEYiZD19HUhrgF0avOMY6qw
 HUv+T8/DbY+DMHy3amEarLpprKcJvYDJZoJLuFkuth3AaKOWL6Ez9RSE3LkheKp2zAAX
 NcVzgW3eJSQ1eOqQLu2c/LUYPedIHD1Hev8WSmEniujXd1TRXS//2eeJJq6+RjkCsGeJ
 LAE1RSFzRq3n5vb99gWrV06x7SxrJSIqY9PsFo9yLUvgNJaEVGho9OXjyQO0t4PWNft0
 T3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759456739; x=1760061539;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ym9iib3rwJZUajKUC19f/PU/oJoIU/amsUaJSsDykk4=;
 b=lNOj2ZMQl0K76+hl4/SEsuKdmGaduURUHgzn3179RaJ02csmL8GbHMKwUTQHjXrhwE
 9yCAu62GjSvl/NzP/mMeLJ7I1bcEk2EDGwCvDpgHgfsetXVnlbH8g/qrW6mEaF6anqLh
 hb7lSYElltl/4YJzIcnIn6t5KV8q2X0BjGjQOfrM1DBkXCzEWSy6zs/alohD6p9otPAa
 GALxwDXvM7fot0yw7bp/Fzj+yG4icX9LF+2BQNYlozaMTXQ5qo1aA7CWxvtkopkEvmqP
 W7e0ratZQ6QHwHoE9QHAWPsBs53Q9Q0enigaOOUZYkNuMKOuXUihQCh1EoqeqARuJwJN
 o6MA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVSlSMPHrrhtFP6l3LPCC8d1mecKpc2+8mdyW7Hir7Yao4Q+ipqnmqv/iE/N8LlLv9y6vfx/2WiDZP@nongnu.org
X-Gm-Message-State: AOJu0YyN6/8+RgZCVH8wX/sZ8kefP2aJp2ZhuLXpVb5Vr7WqnYX9FdCw
 bbjZhO3lYjXBsIeQewhq6zgyUHyTLwUxJOG6arIDVqKuw05EpNADE4Z5gCxvOoANpo0GFoe/989
 QCHKM1TKW8tD9IBdGfNMpTHo1tFwlynE=
X-Gm-Gg: ASbGncv4VhMgT54uo52UUqkkaNPBMToIKKRls7ZSfI+DgdZFAPASDYhKE8COB0w1nKi
 hrbmFzBw8wWZd6Q3H3NCEzKgv4lsWabaMTmbMsDnABNWN6u7qRnoGtxxj0P0X+KweTOV+Qm4v86
 chnypYh7CH5Nel9WhpneoId+hrM6Y/x2GJiPTm1XryvqGAnbt+hsAv8DAZas8DlxPJ8W5z11Gnr
 52eBzY/3fiGa6evOEMU0EnzQ+v8phBqSAbX6US9nyijVWPl6Vurd3CataDSBjEf1yIPY6sj
X-Google-Smtp-Source: AGHT+IEKCQ1Fj7lNSGtFgvg/JcUUZKh5qFZF5T1UEC+fP3fHRk9Gw8FQxSpcgNtsTjRkWD+vE8u4VIO9QWHpgbnZyyk=
X-Received: by 2002:a17:906:f597:b0:b40:51c0:b2d2 with SMTP id
 a640c23a62f3a-b49c4393c4emr184055966b.63.1759456739183; Thu, 02 Oct 2025
 18:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250912021152.46556-1-wilfred.opensource@gmail.com>
 <20250912021152.46556-4-wilfred.opensource@gmail.com>
In-Reply-To: <20250912021152.46556-4-wilfred.opensource@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 3 Oct 2025 11:58:32 +1000
X-Gm-Features: AS18NWBwdowVe0WZDfN4JWzamZXdcjKKPWrclIM7H0fIsLTz_bRQbncpNyBO7xQ
Message-ID: <CAKmqyKM7gkv6Mp9rYiWOiX6GaHNRH15gtc84C0dEK7N9NN+H5w@mail.gmail.com>
Subject: Re: [PATCH v7 3/5] hw/nvme: add NVMe Admin Security SPDM support
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org, 
 qemu-block@nongnu.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Wilfred Mallawa <wilfred.mallawa@wdc.com>, Klaus Jensen <k.jensen@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 12, 2025 at 12:13=E2=80=AFPM Wilfred Mallawa
<wilfred.opensource@gmail.com> wrote:
>
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
>
> Adds the NVMe Admin Security Send/Receive command support with support
> for DMTFs SPDM. The transport binding for SPDM is defined in the
> DMTF DSP0286.
>
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/nvme/ctrl.c               | 212 ++++++++++++++++++++++++++++++++++-
>  hw/nvme/nvme.h               |   5 +
>  include/block/nvme.h         |  15 +++
>  include/system/spdm-socket.h |   2 +
>  4 files changed, 233 insertions(+), 1 deletion(-)
>
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index f5ee6bf260..ad52e8f569 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -282,6 +282,8 @@ static const uint32_t nvme_cse_acs_default[256] =3D {
>      [NVME_ADM_CMD_FORMAT_NVM]       =3D NVME_CMD_EFF_CSUPP | NVME_CMD_EF=
F_LBCC,
>      [NVME_ADM_CMD_DIRECTIVE_RECV]   =3D NVME_CMD_EFF_CSUPP,
>      [NVME_ADM_CMD_DIRECTIVE_SEND]   =3D NVME_CMD_EFF_CSUPP,
> +    [NVME_ADM_CMD_SECURITY_SEND]    =3D NVME_CMD_EFF_CSUPP,
> +    [NVME_ADM_CMD_SECURITY_RECV]    =3D NVME_CMD_EFF_CSUPP,
>  };
>
>  static const uint32_t nvme_cse_iocs_nvm_default[256] =3D {
> @@ -7282,6 +7284,207 @@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, co=
nst NvmeRequest *req)
>      return NVME_SUCCESS;
>  }
>
> +static uint16_t nvme_sec_prot_spdm_send(NvmeCtrl *n, NvmeRequest *req)
> +{
> +    StorageSpdmTransportHeader hdr =3D {0};
> +    g_autofree uint8_t *sec_buf =3D NULL;
> +    uint32_t transfer_len =3D le32_to_cpu(req->cmd.cdw11);
> +    uint32_t transport_transfer_len =3D transfer_len;
> +    uint32_t dw10 =3D le32_to_cpu(req->cmd.cdw10);
> +    uint32_t recvd;
> +    uint16_t nvme_cmd_status, ret;
> +    uint8_t secp =3D extract32(dw10, 24, 8);
> +    uint16_t spsp =3D extract32(dw10, 8, 16);
> +    bool spdm_res;
> +
> +    if (transport_transfer_len > UINT32_MAX - sizeof(hdr)) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    transport_transfer_len +=3D sizeof(hdr);
> +    if (transport_transfer_len > SPDM_SOCKET_MAX_MESSAGE_BUFFER_SIZE) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    ret =3D nvme_check_mdts(n, transport_transfer_len);
> +    if (ret !=3D NVME_SUCCESS) {
> +        return ret;
> +    }
> +
> +    /* Generate the NVMe transport header */
> +    hdr.security_protocol =3D secp;
> +    hdr.security_protocol_specific =3D cpu_to_le16(spsp);
> +    hdr.length =3D cpu_to_le32(transfer_len);
> +
> +    sec_buf =3D g_try_malloc0(transport_transfer_len);
> +    if (!sec_buf) {
> +        return NVME_INTERNAL_DEV_ERROR;
> +    }
> +
> +    /* Attach the transport header */
> +    memcpy(sec_buf, &hdr, sizeof(hdr));
> +    ret =3D nvme_h2c(n, sec_buf + sizeof(hdr), transfer_len, req);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    spdm_res =3D spdm_socket_send(n->spdm_socket, SPDM_SOCKET_STORAGE_CM=
D_IF_SEND,
> +                                SPDM_SOCKET_TRANSPORT_TYPE_NVME, sec_buf=
,
> +                                transport_transfer_len);
> +    if (!spdm_res) {
> +        return NVME_DATA_TRAS_ERROR | NVME_DNR;
> +    }
> +
> +    /* The responder shall ack with message status */
> +    recvd =3D spdm_socket_receive(n->spdm_socket, SPDM_SOCKET_TRANSPORT_=
TYPE_NVME,
> +                                &nvme_cmd_status,
> +                                SPDM_SOCKET_MAX_MSG_STATUS_LEN);
> +
> +    nvme_cmd_status =3D be16_to_cpu(nvme_cmd_status);
> +
> +    if (recvd < SPDM_SOCKET_MAX_MSG_STATUS_LEN) {
> +        return NVME_DATA_TRAS_ERROR | NVME_DNR;
> +    }
> +
> +    return nvme_cmd_status;
> +}
> +
> +/* From host to controller */
> +static uint16_t nvme_security_send(NvmeCtrl *n, NvmeRequest *req)
> +{
> +    uint32_t dw10 =3D le32_to_cpu(req->cmd.cdw10);
> +    uint8_t secp =3D extract32(dw10, 24, 8);
> +
> +    switch (secp) {
> +    case NVME_SEC_PROT_DMTF_SPDM:
> +        if (n->spdm_socket < 0) {
> +            return NVME_INVALID_FIELD | NVME_DNR;
> +        }
> +        return nvme_sec_prot_spdm_send(n, req);
> +    default:
> +        /* Unsupported Security Protocol Type */
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    return NVME_INVALID_FIELD | NVME_DNR;
> +}
> +
> +static uint16_t nvme_sec_prot_spdm_receive(NvmeCtrl *n, NvmeRequest *req=
)
> +{
> +    StorageSpdmTransportHeader hdr;
> +    g_autofree uint8_t *rsp_spdm_buf =3D NULL;
> +    uint32_t dw10 =3D le32_to_cpu(req->cmd.cdw10);
> +    uint32_t alloc_len =3D le32_to_cpu(req->cmd.cdw11);
> +    uint32_t recvd, spdm_res;
> +    uint16_t nvme_cmd_status, ret;
> +    uint8_t secp =3D extract32(dw10, 24, 8);
> +    uint8_t spsp =3D extract32(dw10, 8, 16);
> +    if (!alloc_len) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    /* Generate the NVMe transport header */
> +    hdr =3D (StorageSpdmTransportHeader) {
> +        .security_protocol =3D secp,
> +        .security_protocol_specific =3D cpu_to_le16(spsp),
> +        .length =3D cpu_to_le32(alloc_len),
> +    };
> +
> +    /* Forward if_recv to the SPDM Server with SPSP0 */
> +    spdm_res =3D spdm_socket_send(n->spdm_socket, SPDM_SOCKET_STORAGE_CM=
D_IF_RECV,
> +                                SPDM_SOCKET_TRANSPORT_TYPE_NVME,
> +                                &hdr, sizeof(hdr));
> +    if (!spdm_res) {
> +        return NVME_DATA_TRAS_ERROR | NVME_DNR;
> +    }
> +
> +    /* The responder shall ack with message status */
> +    recvd =3D spdm_socket_receive(n->spdm_socket, SPDM_SOCKET_TRANSPORT_=
TYPE_NVME,
> +                                &nvme_cmd_status,
> +                                SPDM_SOCKET_MAX_MSG_STATUS_LEN);
> +    if (recvd < SPDM_SOCKET_MAX_MSG_STATUS_LEN) {
> +        return NVME_DATA_TRAS_ERROR | NVME_DNR;
> +    }
> +
> +    nvme_cmd_status =3D be16_to_cpu(nvme_cmd_status);
> +    /* An error here implies the prior if_recv from requester was spurio=
us */
> +    if (nvme_cmd_status !=3D NVME_SUCCESS) {
> +        return nvme_cmd_status;
> +    }
> +
> +    /* Clear to start receiving data from the server */
> +    rsp_spdm_buf =3D g_try_malloc0(alloc_len);
> +    if (!rsp_spdm_buf) {
> +        return NVME_INTERNAL_DEV_ERROR;
> +    }
> +
> +    recvd =3D spdm_socket_receive(n->spdm_socket,
> +                                SPDM_SOCKET_TRANSPORT_TYPE_NVME,
> +                                rsp_spdm_buf, alloc_len);
> +    if (!recvd) {
> +        return NVME_DATA_TRAS_ERROR | NVME_DNR;
> +    }
> +
> +    ret =3D nvme_c2h(n, rsp_spdm_buf, MIN(recvd, alloc_len), req);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    return NVME_SUCCESS;
> +}
> +
> +static uint16_t nvme_get_sec_prot_info(NvmeCtrl *n, NvmeRequest *req)
> +{
> +    uint32_t alloc_len =3D le32_to_cpu(req->cmd.cdw11);
> +    uint8_t resp[10] =3D {
> +        /* Support Security Protol List Length */
> +        [6] =3D 0, /* MSB */
> +        [7] =3D 2, /* LSB */
> +        /* Support Security Protocol List */
> +        [8] =3D SFSC_SECURITY_PROT_INFO,
> +        [9] =3D 0,
> +    };
> +
> +    if (n->spdm_socket >=3D 0) {
> +        resp[9] =3D NVME_SEC_PROT_DMTF_SPDM;
> +    }
> +
> +    if (alloc_len < 10) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    return nvme_c2h(n, resp, sizeof(resp), req);
> +}
> +
> +/* From controller to host */
> +static uint16_t nvme_security_receive(NvmeCtrl *n, NvmeRequest *req)
> +{
> +    uint32_t dw10 =3D le32_to_cpu(req->cmd.cdw10);
> +    uint16_t spsp =3D extract32(dw10, 8, 16);
> +    uint8_t secp =3D extract32(dw10, 24, 8);
> +
> +    switch (secp) {
> +    case SFSC_SECURITY_PROT_INFO:
> +        switch (spsp) {
> +        case 0:
> +            /* Supported security protocol list */
> +            return nvme_get_sec_prot_info(n, req);
> +        case 1:
> +            /* Certificate data */
> +            /* fallthrough */
> +        default:
> +            return NVME_INVALID_FIELD | NVME_DNR;
> +        }
> +    case NVME_SEC_PROT_DMTF_SPDM:
> +        if (n->spdm_socket < 0) {
> +            return NVME_INVALID_FIELD | NVME_DNR;
> +        }
> +        return nvme_sec_prot_spdm_receive(n, req);
> +    default:
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +}
> +
>  static uint16_t nvme_directive_send(NvmeCtrl *n, NvmeRequest *req)
>  {
>      return NVME_INVALID_FIELD | NVME_DNR;
> @@ -7389,6 +7592,10 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeRe=
quest *req)
>          return nvme_directive_send(n, req);
>      case NVME_ADM_CMD_DIRECTIVE_RECV:
>          return nvme_directive_receive(n, req);
> +    case NVME_ADM_CMD_SECURITY_SEND:
> +        return nvme_security_send(n, req);
> +    case NVME_ADM_CMD_SECURITY_RECV:
> +        return nvme_security_receive(n, req);
>      default:
>          g_assert_not_reached();
>      }
> @@ -8459,6 +8666,8 @@ static void nvme_init_state(NvmeCtrl *n)
>          sctrl->vfn =3D cpu_to_le16(i + 1);
>      }
>
> +    n->spdm_socket =3D -1;
> +
>      cap->cntlid =3D cpu_to_le16(n->cntlid);
>      cap->crt =3D NVME_CRT_VQ | NVME_CRT_VI;
>
> @@ -8824,7 +9033,8 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *=
pci_dev)
>      id->mdts =3D n->params.mdts;
>      id->ver =3D cpu_to_le32(NVME_SPEC_VER);
>
> -    oacs =3D NVME_OACS_NMS | NVME_OACS_FORMAT | NVME_OACS_DIRECTIVES;
> +    oacs =3D NVME_OACS_NMS | NVME_OACS_FORMAT | NVME_OACS_DIRECTIVES |
> +           NVME_OACS_SECURITY;
>
>      if (n->params.dbcs) {
>          oacs |=3D NVME_OACS_DBCS;
> diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
> index b5c9378ea4..67ed562e00 100644
> --- a/hw/nvme/nvme.h
> +++ b/hw/nvme/nvme.h
> @@ -461,6 +461,8 @@ static inline const char *nvme_adm_opc_str(uint8_t op=
c)
>      case NVME_ADM_CMD_DIRECTIVE_RECV:   return "NVME_ADM_CMD_DIRECTIVE_R=
ECV";
>      case NVME_ADM_CMD_DBBUF_CONFIG:     return "NVME_ADM_CMD_DBBUF_CONFI=
G";
>      case NVME_ADM_CMD_FORMAT_NVM:       return "NVME_ADM_CMD_FORMAT_NVM"=
;
> +    case NVME_ADM_CMD_SECURITY_SEND:    return "NVME_ADM_CMD_SECURITY_SE=
ND";
> +    case NVME_ADM_CMD_SECURITY_RECV:    return "NVME_ADM_CMD_SECURITY_RE=
CV";
>      default:                            return "NVME_ADM_CMD_UNKNOWN";
>      }
>  }
> @@ -648,6 +650,9 @@ typedef struct NvmeCtrl {
>      } next_pri_ctrl_cap;    /* These override pri_ctrl_cap after reset *=
/
>      uint32_t    dn; /* Disable Normal */
>      NvmeAtomic  atomic;
> +
> +    /* Socket mapping to SPDM over NVMe Security In/Out commands */
> +    int spdm_socket;
>  } NvmeCtrl;
>
>  typedef enum NvmeResetType {
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 358e516e38..9fa2ecaf28 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -1779,6 +1779,21 @@ enum NvmeDirectiveOperations {
>      NVME_DIRECTIVE_RETURN_PARAMS =3D 0x1,
>  };
>
> +typedef enum SfscSecurityProtocol {
> +    SFSC_SECURITY_PROT_INFO =3D 0x00,
> +} SfscSecurityProtocol;
> +
> +typedef enum NvmeSecurityProtocols {
> +    NVME_SEC_PROT_DMTF_SPDM    =3D 0xE8,
> +} NvmeSecurityProtocols;
> +
> +typedef enum SpdmOperationCodes {
> +    SPDM_STORAGE_DISCOVERY      =3D 0x1, /* Mandatory */
> +    SPDM_STORAGE_PENDING_INFO   =3D 0x2, /* Optional */
> +    SPDM_STORAGE_MSG            =3D 0x5, /* Mandatory */
> +    SPDM_STORAGE_SEC_MSG        =3D 0x6, /* Optional */
> +} SpdmOperationCodes;
> +
>  typedef struct QEMU_PACKED NvmeFdpConfsHdr {
>      uint16_t num_confs;
>      uint8_t  version;
> diff --git a/include/system/spdm-socket.h b/include/system/spdm-socket.h
> index 80cd7021c1..f0c8b64d1b 100644
> --- a/include/system/spdm-socket.h
> +++ b/include/system/spdm-socket.h
> @@ -112,7 +112,9 @@ typedef struct {
>
>  #define SPDM_SOCKET_TRANSPORT_TYPE_MCTP           0x01
>  #define SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE        0x02
> +#define SPDM_SOCKET_TRANSPORT_TYPE_NVME           0x04
>
>  #define SPDM_SOCKET_MAX_MESSAGE_BUFFER_SIZE       0x1200
> +#define SPDM_SOCKET_MAX_MSG_STATUS_LEN            0x02
>
>  #endif
> --
> 2.51.0
>
>

