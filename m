Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA9BD35162
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 11:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7thT-0008LE-Vi; Wed, 01 Apr 2026 07:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w7thS-0008Hs-6D
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 07:25:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w7thP-0005Nf-HT
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 07:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775042725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m+Q8I7mbA+JR1LFjcI9YyRTLuoRvxwd34nxNso5AtAE=;
 b=NFpenDMhFpzljR/cKKWk892Hq03cmngU/VBo1cRugmXQYJbp2mbRPjJAXMsh7ZL78ClbNc
 9A8L1wA9WAfyEyL23IAmdYsyPlFXLSp4WWAdOM9dYD+K55GZCXq8AE2REAHtduGYLV2IXW
 2veLRlMAlZ4bWPX4Y1/LYDKYz98/NvA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-Ypc8D4-qO7qoPRBF1RhWJw-1; Wed,
 01 Apr 2026 07:25:22 -0400
X-MC-Unique: Ypc8D4-qO7qoPRBF1RhWJw-1
X-Mimecast-MFC-AGG-ID: Ypc8D4-qO7qoPRBF1RhWJw_1775042721
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82BE91955D48; Wed,  1 Apr 2026 11:25:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D9C6D180075B; Wed,  1 Apr 2026 11:25:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 75E9B21E6A28; Wed, 01 Apr 2026 13:25:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?B?Sm/Do28gVmlsYcOnYQ==?= <machadovilaca@gmail.com>
Cc: qemu-devel@nongnu.org,  kkostiuk@redhat.com
Subject: Re: [PATCH] qga: implement 'guest-get-nvidia-smi' command
In-Reply-To: <20260331110135.92883-1-machadovilaca@gmail.com>
 (=?utf-8?Q?=22Jo=C3=A3o_Vila=C3=A7a=22's?=
 message of "Tue, 31 Mar 2026 12:01:35 +0100")
References: <20260331110135.92883-1-machadovilaca@gmail.com>
Date: Wed, 01 Apr 2026 13:25:16 +0200
Message-ID: <871pgy3otf.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

You neglected to cc: me.  We recommend to use scripts/get_maintainer.pl
to find all the maintainers, then use common sense to trim.

Jo=C3=A3o Vila=C3=A7a <machadovilaca@gmail.com> writes:

The commit message needs to explain why and how the patch is useful.

For a patch adding a command to qemu-ga, like this one, it needs to
state the command's anticipated use cases.

> ---
>  qga/commands-posix.c | 64 ++++++++++++++++++++++++++++++++++++++++++++
>  qga/commands-win32.c | 64 ++++++++++++++++++++++++++++++++++++++++++++
>  qga/qapi-schema.json | 59 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 187 insertions(+)
>
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 837be51c40..631a8a9ee6 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -1415,3 +1415,67 @@ GuestLoadAverage *qmp_guest_get_load(Error **errp)
>      return ret;
>  }
>  #endif
> +
> +GuestNvidiaGpuList *qmp_guest_get_nvidia_smi(Error **errp)
> +{
> +    const gchar *argv[] =3D {
> +        "nvidia-smi",
> +        "--query-gpu=3Dindex,name,driver_version,"
> +            "temperature.gpu,utilization.gpu,utilization.memory,"
> +            "memory.total,memory.free,memory.used",
> +        "--format=3Dcsv,noheader,nounits",
> +        NULL
> +    };
> +    g_autofree gchar *stdout_buf =3D NULL;
> +    g_autofree gchar *stderr_buf =3D NULL;
> +    gint exit_status;
> +    GError *gerr =3D NULL;
> +    GuestNvidiaGpuList *head =3D NULL, **tail =3D &head;
> +
> +    if (!g_spawn_sync(NULL, (gchar **)argv, NULL,
> +                      G_SPAWN_SEARCH_PATH,
> +                      NULL, NULL,
> +                      &stdout_buf, &stderr_buf,
> +                      &exit_status, &gerr)) {

Why not ga_run_command()?  Hmm, it throws away the command's output on
success.

Kostiantyn, should ga_run_command() be rewritten on top of
g_spawn_sync()?

> +        error_setg(errp, "failed to run nvidia-smi: %s", gerr->message);
> +        g_error_free(gerr);
> +        return NULL;
> +    }
> +
> +    if (exit_status !=3D 0) {
> +        error_setg(errp, "nvidia-smi failed (exit %d): %s",
> +                   exit_status, stderr_buf ? stderr_buf : "unknown error=
");

This is wrong if @stderr_buf can contain newlines.  qapi/error.h:

 * The resulting message should be a single phrase, with no newline or
 * trailing punctuation.

However, there's similar misuse elsewhere in this file.  Oh well, carry
on.

> +        return NULL;
> +    }
> +

I figure the command's output is some form of CSV.  Can you point to its
documentation?

> +    gchar **lines =3D g_strsplit(stdout_buf, "\n", -1);
> +    for (int i =3D 0; lines[i] !=3D NULL; i++) {
> +        gchar *line =3D g_strstrip(lines[i]);
> +        if (*line =3D=3D '\0') {
> +            continue;

Silently ignore empty lines.  Okay.

> +        }
> +
> +        gchar **f =3D g_strsplit(line, ", ", 9);

If the line has more than 9 values, they are squashed into the last one.

> +        if (g_strv_length(f) < 9) {
> +            g_strfreev(f);
> +            continue;

Silently ignore lines with less than 9 values.

> +        }
> +
> +        GuestNvidiaGpu *gpu     =3D g_new0(GuestNvidiaGpu, 1);
> +        gpu->index              =3D (int)g_ascii_strtoll(f[0], NULL, 10);

If the value doesn't parse as decimal signed integer, we silently assume
zero.

If it parses, we silently ignore any text following it.

If it parses a value outside 64 bit signed range, we silently assume its
largest or smallest value.

> +        gpu->name               =3D g_strdup(g_strstrip(f[1]));
> +        gpu->driver_version     =3D g_strdup(g_strstrip(f[2]));
> +        gpu->temperature        =3D (int)g_ascii_strtoll(f[3], NULL, 10);
> +        gpu->gpu_utilization    =3D (int)g_ascii_strtoll(f[4], NULL, 10);
> +        gpu->memory_utilization =3D (int)g_ascii_strtoll(f[5], NULL, 10);
> +        gpu->memory_total       =3D (int)g_ascii_strtoll(f[6], NULL, 10);
> +        gpu->memory_free        =3D (int)g_ascii_strtoll(f[7], NULL, 10);
> +        gpu->memory_used        =3D (int)g_ascii_strtoll(f[8], NULL, 10);
> +
> +        QAPI_LIST_APPEND(tail, gpu);
> +        g_strfreev(f);
> +    }
> +    g_strfreev(lines);

Are you *sure* this is robust enough?

Please consider a bog-standard LL(1) parser.

> +
> +    return head;
> +}
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index c0bf3467bd..a78d5b71f5 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -2764,3 +2764,67 @@ GuestNetworkRouteList *qmp_guest_network_get_route=
(Error **errp)
>      g_hash_table_destroy(interface_metric_cache);
>      return head;
>  }
> +
> +GuestNvidiaGpuList *qmp_guest_get_nvidia_smi(Error **errp)
> +{
> +    const gchar *argv[] =3D {
> +        "nvidia-smi",
> +        "--query-gpu=3Dindex,name,driver_version,"
> +            "temperature.gpu,utilization.gpu,utilization.memory,"
> +            "memory.total,memory.free,memory.used",
> +        "--format=3Dcsv,noheader,nounits",
> +        NULL
> +    };
> +    g_autofree gchar *stdout_buf =3D NULL;
> +    g_autofree gchar *stderr_buf =3D NULL;
> +    gint exit_status;
> +    GError *gerr =3D NULL;
> +    GuestNvidiaGpuList *head =3D NULL, **tail =3D &head;
> +
> +    if (!g_spawn_sync(NULL, (gchar **)argv, NULL,
> +                      G_SPAWN_SEARCH_PATH,
> +                      NULL, NULL,
> +                      &stdout_buf, &stderr_buf,
> +                      &exit_status, &gerr)) {
> +        error_setg(errp, "failed to run nvidia-smi: %s", gerr->message);
> +        g_error_free(gerr);
> +        return NULL;
> +    }
> +
> +    if (exit_status !=3D 0) {
> +        error_setg(errp, "nvidia-smi failed (exit %d): %s",
> +                   exit_status, stderr_buf ? stderr_buf : "unknown error=
");
> +        return NULL;
> +    }
> +
> +    gchar **lines =3D g_strsplit(stdout_buf, "\n", -1);
> +    for (int i =3D 0; lines[i] !=3D NULL; i++) {
> +        gchar *line =3D g_strstrip(lines[i]);
> +        if (*line =3D=3D '\0') {
> +            continue;
> +        }
> +
> +        gchar **f =3D g_strsplit(line, ", ", 9);
> +        if (g_strv_length(f) < 9) {
> +            g_strfreev(f);
> +            continue;
> +        }
> +
> +        GuestNvidiaGpu *gpu     =3D g_new0(GuestNvidiaGpu, 1);
> +        gpu->index              =3D (int)g_ascii_strtoll(f[0], NULL, 10);
> +        gpu->name               =3D g_strdup(g_strstrip(f[1]));
> +        gpu->driver_version     =3D g_strdup(g_strstrip(f[2]));
> +        gpu->temperature        =3D (int)g_ascii_strtoll(f[3], NULL, 10);
> +        gpu->gpu_utilization    =3D (int)g_ascii_strtoll(f[4], NULL, 10);
> +        gpu->memory_utilization =3D (int)g_ascii_strtoll(f[5], NULL, 10);
> +        gpu->memory_total       =3D (int)g_ascii_strtoll(f[6], NULL, 10);
> +        gpu->memory_free        =3D (int)g_ascii_strtoll(f[7], NULL, 10);
> +        gpu->memory_used        =3D (int)g_ascii_strtoll(f[8], NULL, 10);
> +
> +        QAPI_LIST_APPEND(tail, gpu);
> +        g_strfreev(f);
> +    }
> +    g_strfreev(lines);
> +
> +    return head;
> +}

Duplicates the output parser.  Can you avoid that?

> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index c57bc9a02f..8abbf71131 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1876,6 +1876,65 @@
>    'if': { 'any': ['CONFIG_WIN32', 'CONFIG_GETLOADAVG'] }
>  }
>=20=20
> +##
> +# @GuestNvidiaGpu:
> +#
> +# Information about a single NVIDIA GPU as reported by nvidia-smi.
> +#
> +# @index: GPU index (0-based), stable across reboots for a given
> +#         hardware slot

Please format like

   # @index: GPU index (0-based), stable across reboots for a given
   #     hardware slot

> +#
> +# @name: GPU product name (e.g. "NVIDIA A100-SXM4-80GB")
> +#
> +# @driver-version: version string of the installed NVIDIA driver
> +#
> +# @temperature: GPU die temperature in degrees Celsius
> +#
> +# @gpu-utilization: GPU compute engine utilization in percent (0-100)

(0-100) feels redundant.

> +#
> +# @memory-utilization: GPU memory controller utilization in percent
> +#                      (0-100)

Likewise.

> +#
> +# @memory-total: total framebuffer memory in MiB
> +#
> +# @memory-free: free framebuffer memory in MiB
> +#
> +# @memory-used: used framebuffer memory in MiB
> +#
> +# Since: 10.1

11.1 most likely.

> +##
> +{ 'struct': 'GuestNvidiaGpu',
> +  'data': {
> +      'index':              'int',
> +      'name':               'str',
> +      'driver-version':     'str',
> +      'temperature':        'int',
> +      'gpu-utilization':    'int',
> +      'memory-utilization': 'int',
> +      'memory-total':       'int',
> +      'memory-free':        'int',
> +      'memory-used':        'int'
> +  }
> +}
> +
> +##
> +# @guest-get-nvidia-smi:
> +#
> +# Query NVIDIA GPU information via nvidia-smi inside the guest.
> +#
> +# Returns one @GuestNvidiaGpu entry per physical GPU (or MIG instance)
> +# detected by the NVIDIA driver.
> +#
> +# Errors:
> +#   - If nvidia-smi is not installed or not found in $PATH
> +#   - If nvidia-smi exits with a non-zero status (e.g. no NVIDIA
> +#     device)

We commonly mention the error kind like this:

   #   - If nvidia-smi is not installed or not found in $PATH,
   #     GenericError
   #   - If nvidia-smi exits with a non-zero status (e.g. no NVIDIA
   #     device), GenericError

> +#
> +# Since: 10.1
> +##
> +{ 'command': 'guest-get-nvidia-smi',
> +  'returns': ['GuestNvidiaGpu'] }
> +
>  ##
>  # @GuestNetworkRoute:
>  #

Why not use existing guest-exec, and leave the parsing to the client?


