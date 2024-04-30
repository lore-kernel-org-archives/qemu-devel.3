Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E243C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 21:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1umb-00027L-DO; Tue, 30 Apr 2024 17:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1s1umY-00026m-To
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 17:12:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1s1umV-0005WS-2y
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 17:12:58 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43UL0uLG006474; Tue, 30 Apr 2024 21:12:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=l5dMPkJ0y6sB4K5ubIEA21l25yATarjjN5ivSDh9wME=;
 b=g6bbTg0LT7KVzxgM6hFV8AsXVLy9IBjRqZ0MytZn+g6rJDvLt+XNjmxVeVt2Bpsgjn+a
 sqbQwpO9mXftTrY8vKnj+BddTjzExXpEnPMmlmvuXNN8trfqOcPQfxj7h1pMqt0XHp0J
 83u0Zxue6ujYxu070cOmL5/bRc6LriNedE3JSOiBZW+RtPY4pim/3j9Wwuo0dAGaQseT
 k2kNd02D1vSgKiWDvKGWH2Pmtm2NufXNOva9nvlbqlwXFqtxgVhVPUF5lOpij+/9LxGZ
 HL2libqoktzC1PElywG//k/Fe6CUx0MDI8ZtU7teqdcaX0JB5kFZutaQj3GU4kDoaBG6 bw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xu84mg15s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Apr 2024 21:12:51 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43ULCp7D027425;
 Tue, 30 Apr 2024 21:12:51 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xu84mg15q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Apr 2024 21:12:51 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43UJV2Lp027556; Tue, 30 Apr 2024 21:12:50 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xsc30fdpq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Apr 2024 21:12:50 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43ULClQ737552886
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Apr 2024 21:12:49 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5D3F858059;
 Tue, 30 Apr 2024 21:12:47 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E5C3958058;
 Tue, 30 Apr 2024 21:12:46 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 30 Apr 2024 21:12:46 +0000 (GMT)
Message-ID: <2825c9bb-a4d5-4196-b025-5f46571b3953@linux.ibm.com>
Date: Tue, 30 Apr 2024 17:12:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/2] tpm: add backend for mssim
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20240430190855.2811-1-James.Bottomley@HansenPartnership.com>
 <20240430190855.2811-3-James.Bottomley@HansenPartnership.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240430190855.2811-3-James.Bottomley@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -aELkpB5nC8njl4twdaK55YOUQOLtQsJ
X-Proofpoint-ORIG-GUID: A6fgK8tObqdeYDRcntgclmQD5IRlAQH9
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_12,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404300152
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 4/30/24 15:08, James Bottomley wrote:
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
> ---
>   MAINTAINERS              |   6 +
>   backends/tpm/Kconfig     |   5 +
>   backends/tpm/meson.build |   1 +
>   backends/tpm/tpm_mssim.c | 319 +++++++++++++++++++++++++++++++++++++++
>   backends/tpm/tpm_mssim.h |  44 ++++++
>   docs/specs/tpm.rst       |  39 +++++
>   qapi/tpm.json            |  31 +++-
>   system/tpm-hmp-cmds.c    |   9 ++
>   8 files changed, 450 insertions(+), 4 deletions(-)
>   create mode 100644 backends/tpm/tpm_mssim.c
>   create mode 100644 backends/tpm/tpm_mssim.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 302b6fd00c..6bd7e82d1b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3386,10 +3386,16 @@ F: include/hw/acpi/tpm.h
>   F: include/sysemu/tpm*
>   F: qapi/tpm.json
>   F: backends/tpm/
> +X: backends/tpm/tpm_mssim.*
>   F: tests/qtest/*tpm*
>   F: docs/specs/tpm.rst
>   T: git https://github.com/stefanberger/qemu-tpm.git tpm-next
>   
> +MSSIM TPM Backend
> +M: James Bottomley <jejb@linux.ibm.com>
> +S: Maintained
> +F: backends/tpm/tpm_mssim.*
> +
>   Checkpatch
>   S: Odd Fixes
>   F: scripts/checkpatch.pl
> diff --git a/backends/tpm/Kconfig b/backends/tpm/Kconfig
> index 5d91eb89c2..d6d6fa53e9 100644
> --- a/backends/tpm/Kconfig
> +++ b/backends/tpm/Kconfig
> @@ -12,3 +12,8 @@ config TPM_EMULATOR
>       bool
>       default y
>       depends on TPM_BACKEND
> +
> +config TPM_MSSIM
> +    bool
> +    default y
> +    depends on TPM_BACKEND
> diff --git a/backends/tpm/meson.build b/backends/tpm/meson.build
> index 0bfa6c422b..c6f7c24cb1 100644
> --- a/backends/tpm/meson.build
> +++ b/backends/tpm/meson.build
> @@ -3,4 +3,5 @@ if have_tpm
>     system_ss.add(files('tpm_util.c'))
>     system_ss.add(when: 'CONFIG_TPM_PASSTHROUGH', if_true: files('tpm_passthrough.c'))
>     system_ss.add(when: 'CONFIG_TPM_EMULATOR', if_true: files('tpm_emulator.c'))
> +  system_ss.add(when: 'CONFIG_TPM_MSSIM', if_true: files('tpm_mssim.c'))
>   endif
> diff --git a/backends/tpm/tpm_mssim.c b/backends/tpm/tpm_mssim.c
> new file mode 100644
> index 0000000000..962ad340c3
> --- /dev/null
> +++ b/backends/tpm/tpm_mssim.c
> @@ -0,0 +1,319 @@
> +/*
> + * Emulator TPM driver which connects over the mssim protocol
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Copyright (c) 2022
> + * Author: James Bottomley <jejb@linux.ibm.com>
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/error-report.h"
> +#include "qemu/sockets.h"
> +
> +#include "qapi/clone-visitor.h"
> +#include "qapi/qapi-visit-tpm.h"
> +
> +#include "io/channel-socket.h"
> +
> +#include "sysemu/runstate.h"
> +#include "sysemu/tpm_backend.h"
> +#include "sysemu/tpm_util.h"
> +
> +#include "qom/object.h"
> +
> +#include "tpm_int.h"
> +#include "tpm_mssim.h"
> +
> +#define ERROR_PREFIX "TPM mssim Emulator: "
> +
> +#define TYPE_TPM_MSSIM "tpm-mssim"
> +OBJECT_DECLARE_SIMPLE_TYPE(TPMMssim, TPM_MSSIM)
> +
> +struct TPMMssim {
> +    TPMBackend parent;
> +
> +    TPMMssimOptions opts;
> +
> +    QIOChannelSocket *cmd_qc, *ctrl_qc;
> +};
> +
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
> +
> +static void tpm_mssim_instance_init(Object *obj)
> +{
> +}
> +
> +static void tpm_mssim_instance_finalize(Object *obj)
> +{
> +    TPMMssim *t = TPM_MSSIM(obj);
> +
> +    if (t->cmd_qc && !runstate_check(RUN_STATE_POSTMIGRATE)) {
> +        Error *errp = NULL;
> +        int ret;
> +
> +        ret = tpm_send_ctrl(t, TPM_SIGNAL_POWER_OFF, &errp);
> +        if (ret != 0) {
> +            error_report_err(errp);
> +        }
> +    }
> +
> +    object_unref(OBJECT(t->ctrl_qc));
> +    object_unref(OBJECT(t->cmd_qc));
> +}
> +
> +static void tpm_mssim_cancel_cmd(TPMBackend *tb)
> +{
> +        return;
> +}
> +
> +static TPMVersion tpm_mssim_get_version(TPMBackend *tb)
> +{
> +    return TPM_VERSION_2_0;
> +}
> +
> +static size_t tpm_mssim_get_buffer_size(TPMBackend *tb)
> +{
> +    /* TCG standard profile max buffer size */
> +    return 4096;
> +}
> +
> +static TpmTypeOptions *tpm_mssim_get_opts(TPMBackend *tb)
> +{
> +    TPMMssim *t = TPM_MSSIM(tb);
> +    TpmTypeOptions *opts = g_new0(TpmTypeOptions, 1);
> +
> +    opts->type = TPM_TYPE_MSSIM;
> +    QAPI_CLONE_MEMBERS(TPMMssimOptions, &opts->u.mssim, &t->opts);
> +
> +    return opts;
> +}
> +
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
> +
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
> +
> +static TPMBackend *tpm_mssim_create(TpmCreateOptions *opts)
> +{
> +    TPMBackend *be = TPM_BACKEND(object_new(TYPE_TPM_MSSIM));
> +    TPMMssim *t = TPM_MSSIM(be);
> +    int ret;
> +    Error *errp = NULL;
> +    TPMMssimOptions *mo = &opts->u.mssim;
> +
> +    if (!mo->command) {
> +            mo->command = g_new0(SocketAddress, 1);
> +            mo->command->type = SOCKET_ADDRESS_TYPE_INET;
> +            mo->command->u.inet.host = g_strdup("localhost");
> +            mo->command->u.inet.port = g_strdup("2321");
> +    }
> +    if (!mo->control) {
> +            int port;
> +
> +            mo->control = g_new0(SocketAddress, 1);
> +            mo->control->type = SOCKET_ADDRESS_TYPE_INET;
> +            mo->control->u.inet.host = g_strdup(mo->command->u.inet.host);
> +            /*
> +             * in the reference implementation, the control port is
> +             * always one above the command port
> +             */
> +            port = atoi(mo->command->u.inet.port) + 1;
> +            mo->control->u.inet.port = g_strdup_printf("%d", port);
> +    }
> +
> +    QAPI_CLONE_MEMBERS(TPMMssimOptions, &t->opts, &opts->u.mssim);
> +    t->cmd_qc = qio_channel_socket_new();
> +    t->ctrl_qc = qio_channel_socket_new();
> +
> +    if (qio_channel_socket_connect_sync(t->cmd_qc, mo->command, &errp) < 0) {
> +        goto fail;
> +    }
> +
> +    if (qio_channel_socket_connect_sync(t->ctrl_qc, mo->control, &errp) < 0) {
> +        goto fail;
> +    }
> +    qio_channel_close(QIO_CHANNEL(t->ctrl_qc), NULL);
> +    qio_channel_close(QIO_CHANNEL(t->cmd_qc), NULL);
> +
> +    if (!runstate_check(RUN_STATE_INMIGRATE)) {
> +        /*
> +         * reset the TPM using a power cycle sequence, in case someone
> +         * has previously powered it up
> +         */
> +        ret = tpm_send_ctrl(t, TPM_SIGNAL_POWER_OFF, &errp);
> +        if (ret != 0) {
> +            goto fail;
> +        }
> +
> +        ret = tpm_send_ctrl(t, TPM_SIGNAL_POWER_ON, &errp);
> +        if (ret != 0) {
> +            goto fail;
> +        }
> +
> +        ret = tpm_send_ctrl(t, TPM_SIGNAL_NV_ON, &errp);
> +        if (ret != 0) {
> +            goto fail;
> +        }
> +    }
> +
> +    return be;
> +
> + fail:
> +    object_unref(OBJECT(t->ctrl_qc));
> +    object_unref(OBJECT(t->cmd_qc));
> +    t->ctrl_qc = NULL;
> +    t->cmd_qc = NULL;
> +    error_prepend(&errp, ERROR_PREFIX);
> +    error_report_err(errp);
> +    object_unref(OBJECT(be));
> +
> +    return NULL;
> +}
> +
> +static const QemuOptDesc tpm_mssim_cmdline_opts[] = {
> +    TPM_STANDARD_CMDLINE_OPTS,
> +    {
> +        .name = "command",
> +        .type = QEMU_OPT_STRING,
> +        .help = "Command socket (default localhost:2321)",
> +    },
> +    {
> +        .name = "control",
> +        .type = QEMU_OPT_STRING,
> +        .help = "control socket (default localhost:2322)",
> +    },
> +};
> +
> +static void tpm_mssim_class_init(ObjectClass *klass, void *data)
> +{
> +    TPMBackendClass *cl = TPM_BACKEND_CLASS(klass);
> +
> +    cl->type = TPM_TYPE_MSSIM;
> +    cl->opts = tpm_mssim_cmdline_opts;
> +    cl->desc = "TPM mssim emulator backend driver";
> +    cl->create = tpm_mssim_create;
> +    cl->cancel_cmd = tpm_mssim_cancel_cmd;
> +    cl->get_tpm_version = tpm_mssim_get_version;
> +    cl->get_buffer_size = tpm_mssim_get_buffer_size;
> +    cl->get_tpm_options = tpm_mssim_get_opts;
> +    cl->handle_request = tpm_mssim_handle_request;
> +}
> +
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
> diff --git a/backends/tpm/tpm_mssim.h b/backends/tpm/tpm_mssim.h
> new file mode 100644
> index 0000000000..397474e4f6
> --- /dev/null
> +++ b/backends/tpm/tpm_mssim.h
> @@ -0,0 +1,44 @@
> +/*
> + * SPDX-License-Identifier: BSD-2-Clause
> + *
> + * The code below is copied from the Microsoft/TCG Reference implementation
> + *
> + *  https://github.com/Microsoft/ms-tpm-20-ref.git
> + *
> + * In file TPMCmd/Simulator/include/TpmTcpProtocol.h
> + */
> +
> +#define TPM_SIGNAL_POWER_ON         1
> +#define TPM_SIGNAL_POWER_OFF        2
> +#define TPM_SIGNAL_PHYS_PRES_ON     3
> +#define TPM_SIGNAL_PHYS_PRES_OFF    4
> +#define TPM_SIGNAL_HASH_START       5
> +#define TPM_SIGNAL_HASH_DATA        6
> +/* {uint32_t BufferSize, uint8_t[BufferSize] Buffer} */
> +#define TPM_SIGNAL_HASH_END         7
> +#define TPM_SEND_COMMAND            8
> +/*
> + * {uint8_t Locality, uint32_t InBufferSize, uint8_t[InBufferSize] InBuffer} ->
> + *   {uint32_t OutBufferSize, uint8_t[OutBufferSize] OutBuffer}
> + */
> +#define TPM_SIGNAL_CANCEL_ON        9
> +#define TPM_SIGNAL_CANCEL_OFF       10
> +#define TPM_SIGNAL_NV_ON            11
> +#define TPM_SIGNAL_NV_OFF           12
> +#define TPM_SIGNAL_KEY_CACHE_ON     13
> +#define TPM_SIGNAL_KEY_CACHE_OFF    14
> +
> +#define TPM_REMOTE_HANDSHAKE        15
> +#define TPM_SET_ALTERNATIVE_RESULT  16
> +
> +#define TPM_SIGNAL_RESET            17
> +#define TPM_SIGNAL_RESTART          18
> +
> +#define TPM_SESSION_END             20
> +#define TPM_STOP                    21
> +
> +#define TPM_GET_COMMAND_RESPONSE_SIZES  25
> +
> +#define TPM_ACT_GET_SIGNALED        26
> +
> +#define TPM_TEST_FAILURE_MODE       30
> diff --git a/docs/specs/tpm.rst b/docs/specs/tpm.rst
> index 68cb8cf7e6..051a5c041a 100644
> --- a/docs/specs/tpm.rst
> +++ b/docs/specs/tpm.rst
> @@ -276,6 +276,42 @@ available as a module (assuming a TPM 2 is passed through):
>     /sys/devices/LNXSYSTEM:00/LNXSYBUS:00/MSFT0101:00/tpm/tpm0/pcr-sha256/9
>     ...
>   
> +The QEMU TPM Microsoft Simulator Device
> +---------------------------------------
> +
> +The Microsoft Simulator (mssim) is the reference emulation platform
> +for the TCG TPM 2.0 specification.  It provides a reference
> +implementation for the TPM 2.0 written by Microsoft (See
> +`ms-tpm-20-ref`_ on github).  The reference implementation starts a
> +network server and listens for TPM commands on port 2321 and TPM
> +Platform control commands on port 2322, although these can be altered.
> +The QEMU mssim TPM backend talks to this implementation.  By default
> +it connects to the default ports on localhost:
> +
> +.. code-block:: console
> +
> +  qemu-system-x86_64 <qemu-options> \
> +    -tpmdev mssim,id=tpm0 \
> +    -device tpm-crb,tpmdev=tpm0
> +
> +
> +Although it can also communicate with a remote host, which must be
> +specified as a SocketAddress via json or dotted keys on the command
> +line for each of the command and control ports:
> +
> +.. code-block:: console
> +
> +  qemu-system-x86_64 <qemu-options> \
> +    -tpmdev "{'type':'mssim','id':'tpm0','command':{'type':'inet','host':'remote','port':'2321'},'control':{'type':'inet','host':'remote','port':'2322'}}" \
> +    -device tpm-crb,tpmdev=tpm0
> +
> +
> +The mssim backend supports snapshotting and migration by not resetting

I don't thing snapshotting is supported because snapshooting would 
require you to be able to set the state of the vTPM from the snapshot 
you started. I would remove the claim.


Rest LGTM.

> +the TPM on start up and not powering it down on halt if the VM is in
> +migration, but the state of the Microsoft Simulator server must be
> +preserved (or the server kept running) outside of QEMU for restore to
> +be successful.
> +
>   The QEMU TPM emulator device
>   ----------------------------
>   
> @@ -549,3 +585,6 @@ the following:
>   
>   .. _SWTPM protocol:
>      https://github.com/stefanberger/swtpm/blob/master/man/man3/swtpm_ioctls.pod
> +
> +.. _ms-tpm-20-ref:
> +   https://github.com/microsoft/ms-tpm-20-ref
> diff --git a/qapi/tpm.json b/qapi/tpm.json
> index 5604553b7d..0532d3ba3d 100644
> --- a/qapi/tpm.json
> +++ b/qapi/tpm.json
> @@ -6,6 +6,8 @@
>   # = TPM (trusted platform module) devices
>   ##
>   
> +{ 'include': 'sockets.json' }
> +
>   ##
>   # @TpmModel:
>   #
> @@ -48,9 +50,11 @@
>   #
>   # @emulator: Software Emulator TPM type (since 2.11)
>   #
> +# @mssim: Microsoft TPM Emulator (since 9.0)
> +#
>   # Since: 1.5
>   ##
> -{ 'enum': 'TpmType', 'data': [ 'passthrough', 'emulator' ],
> +{ 'enum': 'TpmType', 'data': [ 'passthrough', 'emulator', 'mssim' ],
>     'if': 'CONFIG_TPM' }
>   
>   ##
> @@ -65,7 +69,7 @@
>   # Example:
>   #
>   #     -> { "execute": "query-tpm-types" }
> -#     <- { "return": [ "passthrough", "emulator" ] }
> +#     <- { "return": [ "passthrough", "emulator", "mssim" ] }
>   ##
>   { 'command': 'query-tpm-types', 'returns': ['TpmType'],
>     'if': 'CONFIG_TPM' }
> @@ -121,6 +125,22 @@
>     'data': { 'data': 'TPMEmulatorOptions' },
>     'if': 'CONFIG_TPM' }
>   
> +##
> +# @TPMMssimOptions:
> +#
> +# Information for the mssim emulator connection
> +#
> +# @command: command socket for the TPM emulator
> +#
> +# @control: control socket for the TPM emulator
> +#
> +# Since: 9.0
> +##
> +{ 'struct': 'TPMMssimOptions',
> +  'data': { '*command': 'SocketAddress',
> +            '*control': 'SocketAddress' },
> +  'if': 'CONFIG_TPM' }
> +
>   ##
>   # @TpmTypeOptions:
>   #
> @@ -132,6 +152,7 @@
>   #       passthrough type
>   #     - 'emulator' The configuration options for TPM emulator backend
>   #       type
> +#     - 'mssim' The configuration options for TPM emulator mssim type
>   #
>   # Since: 1.5
>   ##
> @@ -139,7 +160,8 @@
>     'base': { 'type': 'TpmType' },
>     'discriminator': 'type',
>     'data': { 'passthrough' : 'TPMPassthroughOptionsWrapper',
> -            'emulator': 'TPMEmulatorOptionsWrapper' },
> +            'emulator': 'TPMEmulatorOptionsWrapper',
> +            'mssim' : 'TPMMssimOptions' },
>     'if': 'CONFIG_TPM' }
>   
>   ##
> @@ -160,7 +182,8 @@
>               'id' : 'str' },
>     'discriminator': 'type',
>     'data': { 'passthrough' : 'TPMPassthroughOptions',
> -            'emulator': 'TPMEmulatorOptions' },
> +            'emulator': 'TPMEmulatorOptions',
> +            'mssim': 'TPMMssimOptions' },
>     'if': 'CONFIG_TPM' }
>   
>   ##
> diff --git a/system/tpm-hmp-cmds.c b/system/tpm-hmp-cmds.c
> index 9ed6ad6c4d..12293f86c1 100644
> --- a/system/tpm-hmp-cmds.c
> +++ b/system/tpm-hmp-cmds.c
> @@ -19,6 +19,7 @@ void hmp_info_tpm(Monitor *mon, const QDict *qdict)
>       unsigned int c = 0;
>       TPMPassthroughOptions *tpo;
>       TPMEmulatorOptions *teo;
> +    TPMMssimOptions *tmo;
>   
>       info_list = qmp_query_tpm(&err);
>       if (err) {
> @@ -52,6 +53,14 @@ void hmp_info_tpm(Monitor *mon, const QDict *qdict)
>               teo = ti->options->u.emulator.data;
>               monitor_printf(mon, ",chardev=%s", teo->chardev);
>               break;
> +        case TPM_TYPE_MSSIM:
> +            tmo = &ti->options->u.mssim;
> +            monitor_printf(mon, ",command=%s:%s,control=%s:%s",
> +                           tmo->command->u.inet.host,
> +                           tmo->command->u.inet.port,
> +                           tmo->control->u.inet.host,
> +                           tmo->control->u.inet.port);
> +            break;
>           case TPM_TYPE__MAX:
>               break;
>           }

