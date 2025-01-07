Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87BAEE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 07:41:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4Cz-0006JX-BK; Tue, 07 Jan 2025 02:41:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tV4Cw-0006JO-Tm
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 02:40:58 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tV4Cu-0001Cs-RS
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 02:40:58 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-436a03197b2so56067945e9.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 23:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736235655; x=1736840455; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H8hrQkHmGhGTIu42zpzotS/QZe823Hr8cTx359mtXqc=;
 b=Md4Y0X/ctA+/N04Xu+O+62Kq/hnJsQNbhao/u/mV9whAKFQ5GkrPJwJA1KoufliSI1
 gAR49OMxKrpIawG5qFSx0orEVWMOKyXN28L98/xFMnLR9GoTVW44xekAVuoJ/wJQE9cQ
 AeGILymnD0tVMYZ/hDl8ScRdZq8YUT2W9/gOXgjO3jV1u4/fs1g9Z4Sfl9a1IbP6Hqp2
 nDTDSU9RiW7AKJNpSeP4/FknaYeH05lYrblD9RbiT8I8sQuMN6DeQWJ/ef+DHbAW+Ky6
 umExNA9wWjpidKupEyJFmX9PeThHPL2rN/cM+JSesG/cKfqkJ7d2IKX5veQWDXIKTmKl
 U/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736235655; x=1736840455;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H8hrQkHmGhGTIu42zpzotS/QZe823Hr8cTx359mtXqc=;
 b=gyoq2GyHdW+bBO33bdXP3BxeLmu9MNWM0zgpvEAnKIwborKANSjWKxNFJSydgOscwN
 P1kBYYn1uC/4UvpmrdCYeocA1pmw3SjgZBJ1umX+qzFNzMD+Z3TO2SJ1R2R8VFxU+9Ei
 QoRemwoH2dSFzGLqL1+x3GIZEhpKDSeJQvW3f4TH4vIbNeYs/yJWGTR0xwxSux8Q0lmA
 ghIqyDAohQNLhScN0lx6ocu5z6ns0SiHrotvzggtXdGNXVBAIL0ydLuQzxrhItijSukk
 7/dJA5qmgsPBD2fS9QFuk1qRnXBvykOotKRtzoitcccgst42U6R3h/MM5BOrPkXJ7h3/
 0hww==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgOR6JaubQTDu1gW3YpQwe0TM+S09Of2G2JriLQ82Vjcn5YG+gTZ3Pskf4f4KtpLDAkY8gZf4F2b2o@nongnu.org
X-Gm-Message-State: AOJu0YxL0uU8TbQcFrL+6U+7QQMnifObC9vMCjfq5RdaFg607zvnmBsW
 axAG7/z4EWMno8MQ+5nM1l+4IgfHKnfk8G8vTIDzHCN8lR7PtE+uxRh9npwNvFY=
X-Gm-Gg: ASbGncvh4kqkNG7xQXEEin4O41LM9KiMG0cpOg/sFXJOm/IhAqCmJrBq8A+PUvtl1L2
 7lJsxBfanp45CCR/yH/F0YpmnFylNEw9Lf+DNICPYMs1L0k18epJBNh7QvTWQcXIicPZ0D30Af9
 vqmXpAJ4nvZPu+p0mtto9Inu3sm5LCqo8AMaHmltIe63rqLE2yz+kkIL7yEmA2A6AmWBeZmvGP6
 dItSEJxh/CJmO9GfSQk/rDSt2/jvpOg7wChBl+jojpun5F/8g3WZ31J0HVvj3M68HiYGLpOKQrI
 k2CbuiLlZE9+fbkX5o2nwo3b
X-Google-Smtp-Source: AGHT+IEdujK5EK3oAnO9Errx0QO39Jm06vcRZU6DeZGMGJRE/l0Q7+zNCn4tPljmpNrDvEDbiwO47A==
X-Received: by 2002:a05:600c:4ecc:b0:434:a802:e9b2 with SMTP id
 5b1f17b1804b1-4366854887cmr513111965e9.4.1736235654690; 
 Mon, 06 Jan 2025 23:40:54 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436dd14dfcasm9127835e9.1.2025.01.06.23.40.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2025 23:40:53 -0800 (PST)
Message-ID: <a416d786-45ec-46c8-8624-6046e3b39f36@linaro.org>
Date: Tue, 7 Jan 2025 08:40:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/2] tpm: add backend for mssim
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
References: <20241212170528.30364-1-James.Bottomley@HansenPartnership.com>
 <20241212170528.30364-3-James.Bottomley@HansenPartnership.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241212170528.30364-3-James.Bottomley@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi James,

On 12/12/24 18:05, James Bottomley wrote:
> The Microsoft Simulator (mssim) is the reference emulation platform
> for the TCG TPM 2.0 specification.
> 
> https://github.com/Microsoft/ms-tpm-20-ref.git
> 
> It exports a fairly simple network socket based protocol on two
> sockets, one for command (default 2321) and one for control (default
> 2322).  This patch adds a simple backend that can speak the mssim
> protocol over the network.  It also allows the two sockets to be
> specified on the command line.  The benefits are twofold: firstly it
> gives us a backend that actually speaks a standard TPM emulation
> protocol instead of the linux specific TPM driver format of the
> current emulated TPM backend and secondly, using the microsoft
> protocol, the end point of the emulator can be anywhere on the
> network, facilitating the cloud use case where a central TPM service
> can be used over a control network.
> 
> The implementation does basic control commands like power off/on, but
> doesn't implement cancellation or startup.  The former because
> cancellation is pretty much useless on a fast operating TPM emulator
> and the latter because this emulator is designed to be used with OVMF
> which itself does TPM startup and I wanted to validate that.
> 
> To run this, simply download an emulator based on the MS specification
> (package ibmswtpm2 on openSUSE) and run it, then add these two lines
> to the qemu command and it will use the emulator.
> 
>      -tpmdev mssim,id=tpm0 \
>      -device tpm-crb,tpmdev=tpm0 \
> 
> to use a remote emulator replace the first line with
> 
>      -tpmdev "{'type':'mssim','id':'tpm0','command':{'type':inet,'host':'remote','port':'2321'}}"
> 
> tpm-tis also works as the backend.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> 
> ---
> 
> v2: convert to SocketAddr json and use qio_channel_socket_connect_sync()
> v3: gate control power off by migration state keep control socket disconnected
>      to test outside influence and add docs.
> v7: TPMmssim -> TPMMssim; doc and json fixes
>      Make command socket open each time (makes OS debugging easier)
> v11: add startup method to make sure TPM is reset on reboot
> ---
>   MAINTAINERS              |   6 +
>   backends/tpm/Kconfig     |   5 +
>   backends/tpm/meson.build |   1 +
>   backends/tpm/tpm_mssim.c | 335 +++++++++++++++++++++++++++++++++++++++
>   backends/tpm/tpm_mssim.h |  44 +++++
>   docs/specs/tpm.rst       |  39 +++++
>   qapi/tpm.json            |  31 +++-
>   system/tpm-hmp-cmds.c    |   9 ++
>   8 files changed, 466 insertions(+), 4 deletions(-)
>   create mode 100644 backends/tpm/tpm_mssim.c
>   create mode 100644 backends/tpm/tpm_mssim.h


> +static int tpm_send_ctrl(TPMMssim *t, uint32_t cmd, Error **errp)
> +{
> +    int ret, retc;
> +    Error *local_err = NULL;
> +
> +    ret = qio_channel_socket_connect_sync(t->ctrl_qc, t->opts.control, errp);
> +    if (ret != 0) {
> +        return ret;
> +    }
> +    cmd = htonl(cmd);

I'd rather not use <arpa/inet.h> here, but:

        cpu_to_be32s(&cmd);

> +    ret = qio_channel_write_all(QIO_CHANNEL(t->ctrl_qc),
> +                                (char *)&cmd, sizeof(cmd), errp);
> +    if (ret != 0) {
> +        goto out;
> +    }
> +
> +    ret = qio_channel_read_all(QIO_CHANNEL(t->ctrl_qc),
> +                               (char *)&cmd, sizeof(cmd), errp);
> +    if (ret != 0) {
> +        goto out;
> +    }
> +    if (cmd != 0) {
> +        error_setg(errp, ERROR_PREFIX
> +                   "Incorrect ACK recieved on control channel 0x%x", cmd);
> +        ret = -1;
> +    }
> + out:
> +    /*
> +     * need to close the channel here, but if that fails report it
> +     * while not letting a prior failure get overwritten
> +     */
> +    retc = qio_channel_close(QIO_CHANNEL(t->ctrl_qc), &local_err);
> +    error_propagate(errp, local_err);
> +    return retc ? retc : ret;
> +}


> +static void tpm_mssim_handle_request(TPMBackend *tb, TPMBackendCmd *cmd,
> +                                     Error **errp)
> +{
> +    TPMMssim *t = TPM_MSSIM(tb);
> +    uint32_t header, len;
> +    uint8_t locality = cmd->locty;
> +    struct iovec iov[4];
> +    int ret;
> +
> +    ret = qio_channel_socket_connect_sync(t->cmd_qc, t->opts.command, errp);
> +    if (ret != 0) {
> +        goto fail_msg;
> +    }
> +
> +    header = htonl(TPM_SEND_COMMAND);
> +    len = htonl(cmd->in_len);

        cpu_to_be32()

> +    iov[0].iov_base = &header;
> +    iov[0].iov_len = sizeof(header);
> +    iov[1].iov_base = &locality;
> +    iov[1].iov_len = sizeof(locality);
> +    iov[2].iov_base = &len;
> +    iov[2].iov_len = sizeof(len);
> +    iov[3].iov_base = (void *)cmd->in;
> +    iov[3].iov_len = cmd->in_len;
> +
> +    ret = qio_channel_writev_all(QIO_CHANNEL(t->cmd_qc), iov, 4, errp);
> +    if (ret != 0) {
> +        goto fail;
> +    }
> +
> +    ret = qio_channel_read_all(QIO_CHANNEL(t->cmd_qc),
> +                               (char *)&len, sizeof(len), errp);
> +    if (ret != 0) {
> +        goto fail;
> +    }
> +
> +    len = ntohl(len);

        be32_to_cpu()

> +    if (len > cmd->out_len) {
> +        error_setg(errp, "receive size is too large");
> +        goto fail;
> +    }
> +    ret = qio_channel_read_all(QIO_CHANNEL(t->cmd_qc),
> +                               (char *)cmd->out, len, errp);
> +    if (ret != 0) {
> +        goto fail;
> +    }
> +
> +    /* ACK packet */
> +    ret = qio_channel_read_all(QIO_CHANNEL(t->cmd_qc),
> +                               (char *)&header, sizeof(header), errp);
> +    if (ret != 0) {
> +        goto fail;
> +    }
> +    if (header != 0) {
> +        error_setg(errp, "incorrect ACK received on command channel 0x%x", len);
> +        goto fail;
> +    }
> +
> +    ret = qio_channel_close(QIO_CHANNEL(t->cmd_qc), errp);
> +    if (ret != 0) {
> +        goto fail_msg;
> +    }
> +
> +    return;
> +
> + fail:
> +    /* we're already failing, so don't worry if this fails too */
> +    qio_channel_close(QIO_CHANNEL(t->cmd_qc), NULL);
> + fail_msg:
> +    error_prepend(errp, ERROR_PREFIX);
> +    tpm_util_write_fatal_error_response(cmd->out, cmd->out_len);
> +}


> +static const TypeInfo tpm_mssim_info = {
> +    .name = TYPE_TPM_MSSIM,
> +    .parent = TYPE_TPM_BACKEND,
> +    .instance_size = sizeof(TPMMssim),
> +    .class_init = tpm_mssim_class_init,
> +    .instance_init = tpm_mssim_instance_init,
> +    .instance_finalize = tpm_mssim_instance_finalize,
> +};
> +
> +static void tpm_mssim_register(void)
> +{
> +    type_register_static(&tpm_mssim_info);
> +}
> +
> +type_init(tpm_mssim_register)

Preferably DEFINE_TYPES().

Otherwise (modulo Daniel comments), LGTM!

Regards,

Phil.

