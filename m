Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE250CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 01:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4V06-0003A9-SQ; Thu, 02 Oct 2025 21:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4V05-00039J-B5
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 21:54:25 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4Uzf-0008A6-Mx
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 21:54:10 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-637dbabdb32so3111292a12.2
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 18:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759456431; x=1760061231; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tvxhkZBggB/K9rzhG9PL6L1uJdGG2zHsSYIOjvXDCLs=;
 b=XwkvSCOZREvBvkRp3oJIfl5RQHuCYPe1ZOeXSc36QNatopgIhqZUPA7UUIQQcm55nb
 sqhdBQNAMHRO6qYzieBGOAR/jea3HydpRxt0r5UMCs9WXqI0yuH3J8l3JRHMWjN2uxbf
 6RLs0B5zIisaTQ3cYTfXbAIV/3jRcxKpDQwLIp5hA626FRLsBTi8omdm6pJVbWoiHrph
 /jjeZLJ0AxgMCD+13l+nJnFAQ0ijZA92yOuLnxfnkNa78lufCnWAMFfKRuYC1/IRh1Xd
 W3vMJTs6tr9WZTTFqhPOhk2Sq2Bmw2ewoSgs+T/SV+t35yZRhpcIAg4LoJ3937FWplH+
 Chtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759456431; x=1760061231;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tvxhkZBggB/K9rzhG9PL6L1uJdGG2zHsSYIOjvXDCLs=;
 b=e80ZD1ul7HYcWikof+Z4Eg3t6ejhdgynCwygMFC7DE+sNKNgcMgFkCDlU96jHg01Xv
 IxCU9HaBJuAXOFlXFzIIRlnMkmbEmqtMU8p9eGJWF+KB839IpRYTd8KuYLQIOlOBQqeD
 kFKMcd+RaTJFY+/enggDDVt/Of3v7jVIYohlzeZuG0zA2fCrNIQ3B0RTbQBnsVLiI3jR
 eIJ99c68ITQWpnTm1j9ZFgnjpG3dub3Xb9YNzx70VyCUpPLcks1NIqJlugexoROrFWWK
 mofzSwImeZW4qGMqeyWkvZ+qJVrS/StEBzJKdgFLCtucf5k95EWmsI30e4kF8dol0jHf
 hkDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFjfMSTdm6fdBpp5KFKljdjQNuZeWYL5Y6Ot+oIbFKGJRe44H4ngA3/Ckuacok9a8pFhLdDrFuMgwc@nongnu.org
X-Gm-Message-State: AOJu0YxXLtk2DmcYOsIVbG28iglcmwXYDu1Cw/84P9aLIM0ZJ659d2NT
 bq8n2oKZTzQqC8SvKQ8aKw7dKcaYXpDRVsBsl80GhayeWFyQtaGG2/yRnd4rNFh5AVMQbnF1vWT
 vGeRrf8m2l4I+BPccXuwHw1uuMQqTz3Y=
X-Gm-Gg: ASbGncvknRYIoKaxSCCebSzJ0DFtKTn7N69CHwgxFIaiEobDbSxA6vp7CvYls2IaEgS
 8vwIWI7E+Mb2Gy4bQvaUCNgyXUOhyN74qgjznXEb1dGLQ25tIWKirBZZFbKXLaVDxWjU51mDNUz
 AAiTZfZM6uGahQscvaYotXGE5JcFV1G6lRKzTHcMybIBvJKQJBdKcsIUbA5CZwblwak5iM+Gsz7
 MfAZGxO6Fqi/enLkoD2SgEqex7VXkbPo8sHLw7tOJUQmfInj33oKfdulJGEog==
X-Google-Smtp-Source: AGHT+IGRL9MFx36ZKViewhZT4Thhz3KFsoY4NVSwZzsQcLGuLYKbASQnEH9eXs0sRVw2nmTB2oJb84xTDhOqjfoWaWk=
X-Received: by 2002:a17:906:c14c:b0:b40:b6a9:f6f9 with SMTP id
 a640c23a62f3a-b49c1a721d2mr172966866b.19.1759456431360; Thu, 02 Oct 2025
 18:53:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250912021152.46556-1-wilfred.opensource@gmail.com>
 <20250912021152.46556-2-wilfred.opensource@gmail.com>
In-Reply-To: <20250912021152.46556-2-wilfred.opensource@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 3 Oct 2025 11:53:25 +1000
X-Gm-Features: AS18NWAiXNjWLEIqyIxMGw2LEq9wz3ojck8zxuPTWPyK2Peuf6MammCEmyxFJ40
Message-ID: <CAKmqyKNbo1JSyahxVEhQTdMvhXV4qyv8AymnUeHtvgWgLo4keA@mail.gmail.com>
Subject: Re: [PATCH v7 1/5] spdm-socket: add seperate send/recv functions
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
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52c.google.com
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
> This is to support uni-directional transports such as SPDM over Storage.
> As specified by the DMTF DSP0286.
>
> Also update spdm_socket_rsp() to use the new send()/receive() functions. =
For
> the case of spdm_socket_receive(), this allows us to do error checking
> in one place with the addition of spdm_socket_command_valid().
>
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  backends/spdm-socket.c       | 56 ++++++++++++++++++++++++++++--------
>  include/system/spdm-socket.h | 32 +++++++++++++++++++++
>  2 files changed, 76 insertions(+), 12 deletions(-)
>
> diff --git a/backends/spdm-socket.c b/backends/spdm-socket.c
> index 2c709c68c8..ab74a02d9c 100644
> --- a/backends/spdm-socket.c
> +++ b/backends/spdm-socket.c
> @@ -184,29 +184,61 @@ int spdm_socket_connect(uint16_t port, Error **errp=
)
>      return client_socket;
>  }
>
> -uint32_t spdm_socket_rsp(const int socket, uint32_t transport_type,
> -                         void *req, uint32_t req_len,
> -                         void *rsp, uint32_t rsp_len)
> +static bool spdm_socket_command_valid(uint32_t command)
> +{
> +    switch (command) {
> +    case SPDM_SOCKET_COMMAND_NORMAL:
> +    case SPDM_SOCKET_STORAGE_CMD_IF_SEND:
> +    case SPDM_SOCKET_STORAGE_CMD_IF_RECV:
> +    case SOCKET_SPDM_STORAGE_ACK_STATUS:
> +    case SPDM_SOCKET_COMMAND_OOB_ENCAP_KEY_UPDATE:
> +    case SPDM_SOCKET_COMMAND_CONTINUE:
> +    case SPDM_SOCKET_COMMAND_SHUTDOWN:
> +    case SPDM_SOCKET_COMMAND_UNKOWN:
> +    case SPDM_SOCKET_COMMAND_TEST:
> +        return true;
> +    default:
> +        return false;
> +    }
> +}
> +
> +uint32_t spdm_socket_receive(const int socket, uint32_t transport_type,
> +                             void *rsp, uint32_t rsp_len)
>  {
>      uint32_t command;
>      bool result;
>
> -    result =3D send_platform_data(socket, transport_type,
> -                                SPDM_SOCKET_COMMAND_NORMAL,
> -                                req, req_len);
> -    if (!result) {
> +    result =3D receive_platform_data(socket, transport_type, &command,
> +                                   (uint8_t *)rsp, &rsp_len);
> +
> +    /* we may have received some data, but check if the command is valid=
 */
> +    if (!result || !spdm_socket_command_valid(command)) {
>          return 0;
>      }
>
> -    result =3D receive_platform_data(socket, transport_type, &command,
> -                                   (uint8_t *)rsp, &rsp_len);
> +    return rsp_len;
> +}
> +
> +bool spdm_socket_send(const int socket, uint32_t socket_cmd,
> +                      uint32_t transport_type, void *req, uint32_t req_l=
en)
> +{
> +    return send_platform_data(socket, transport_type, socket_cmd, req,
> +                              req_len);
> +}
> +
> +uint32_t spdm_socket_rsp(const int socket, uint32_t transport_type,
> +                         void *req, uint32_t req_len,
> +                         void *rsp, uint32_t rsp_len)
> +{
> +    bool result;
> +
> +    result =3D spdm_socket_send(socket, SPDM_SOCKET_COMMAND_NORMAL,
> +                              transport_type, req, req_len);
>      if (!result) {
>          return 0;
>      }
>
> -    assert(command !=3D 0);
> -
> -    return rsp_len;
> +    return spdm_socket_receive(socket, transport_type, rsp, rsp_len);
>  }
>
>  void spdm_socket_close(const int socket, uint32_t transport_type)
> diff --git a/include/system/spdm-socket.h b/include/system/spdm-socket.h
> index 5d8bd9aa4e..29aa04fd52 100644
> --- a/include/system/spdm-socket.h
> +++ b/include/system/spdm-socket.h
> @@ -50,6 +50,35 @@ uint32_t spdm_socket_rsp(const int socket, uint32_t tr=
ansport_type,
>                           void *req, uint32_t req_len,
>                           void *rsp, uint32_t rsp_len);
>
> +/**
> + * spdm_socket_rsp: Receive a message from an SPDM server
> + * @socket: socket returned from spdm_socket_connect()
> + * @transport_type: SPDM_SOCKET_TRANSPORT_TYPE_* macro
> + * @rsp: response buffer
> + * @rsp_len: response buffer length
> + *
> + * Receives a message from the SPDM server and returns the number of byt=
es
> + * received or 0 on failure. This can be used to receive a message from =
the SPDM
> + * server without sending anything first.
> + */
> +uint32_t spdm_socket_receive(const int socket, uint32_t transport_type,
> +                             void *rsp, uint32_t rsp_len);
> +
> +/**
> + * spdm_socket_rsp: Sends a message to an SPDM server
> + * @socket: socket returned from spdm_socket_connect()
> + * @socket_cmd: socket command type (normal/if_recv/if_send etc...)
> + * @transport_type: SPDM_SOCKET_TRANSPORT_TYPE_* macro
> + * @req: request buffer
> + * @req_len: request buffer length
> + *
> + * Sends platform data to a SPDM server on socket, returns true on succe=
ss.
> + * The response from the server must then be fetched by using
> + * spdm_socket_receive().
> + */
> +bool spdm_socket_send(const int socket, uint32_t socket_cmd,
> +                      uint32_t transport_type, void *req, uint32_t req_l=
en);
> +
>  /**
>   * spdm_socket_close: send a shutdown command to the server
>   * @socket: socket returned from spdm_socket_connect()
> @@ -60,6 +89,9 @@ uint32_t spdm_socket_rsp(const int socket, uint32_t tra=
nsport_type,
>  void spdm_socket_close(const int socket, uint32_t transport_type);
>
>  #define SPDM_SOCKET_COMMAND_NORMAL                0x0001
> +#define SPDM_SOCKET_STORAGE_CMD_IF_SEND           0x0002
> +#define SPDM_SOCKET_STORAGE_CMD_IF_RECV           0x0003
> +#define SOCKET_SPDM_STORAGE_ACK_STATUS            0x0004
>  #define SPDM_SOCKET_COMMAND_OOB_ENCAP_KEY_UPDATE  0x8001
>  #define SPDM_SOCKET_COMMAND_CONTINUE              0xFFFD
>  #define SPDM_SOCKET_COMMAND_SHUTDOWN              0xFFFE
> --
> 2.51.0
>
>

