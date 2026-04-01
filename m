Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23AB9D35162
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 12:00:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7uFU-0003Q5-RK; Wed, 01 Apr 2026 08:00:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <machadovilaca@gmail.com>)
 id 1w7uFA-0003P3-Tq
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 08:00:31 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <machadovilaca@gmail.com>)
 id 1w7uF7-000248-0I
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 08:00:20 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-66deafdcdc8so351408a12.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 05:00:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775044814; cv=none;
 d=google.com; s=arc-20240605;
 b=HgrHn783iK4wUnQ5RceeRhkfg0S8qiUddKKDSwPNrNKSO06PbgADKvE8yI/DNzJlVH
 /BQolKxi/Ow4juL9mhwX09Nrnt9KINeGKjSCHOcnrD1gR2FFHbse9bMYmLI3b6Y2VwVh
 F/CEBICz5+d4gl7E82lQorSd/scDj8i2aX44k4CAAsYQYBosHTEkX/czZpBwWR98vS/0
 RkXmwHve9Lr5ileI4AocPD2Jf7MWGVx5k0zZdGTVBEmEHZwZLPt2VB06l1yNWIkxS2gV
 xVevwkn5DCCClfHNlxYvj7IPsqqvNHAEeTvVYA6wvfMYffnARIPQO17KRb0Q64ICTjWB
 ZuTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BQAhi2oFGzUSpnHFrJ7Y2xr0HJ5nPi45k5iZUbAfyO0=;
 fh=g8NVejREolJtr8XAZ5BRjQ3H7V8yis+REO4OM5lxoYU=;
 b=Bp8bTIpctlEFfgQLYDUioueZ9CkWbhydIY9x9Q2mHJrc/Nc5Ty6osUPjX12ZBOkUSn
 lklKS4em5+ETpYmxgj60bs37QRayElPCDaaex3H3npoEZKUPvZNC8z3Mc0MEUJ396J0t
 hkKYETNTo2R4oxft0V+6w2t0lcPRniVefrfUTiVPg+7E2Xwr19muXzqa1qR9P8MuP3AX
 R1LWGhCMK+49ZnVjlHO7lXfS16yd8pvHN3jJHnejXCLuleFaKhaiQe5NDbMDnlx9YINo
 UzZHO8gCAjY2LBWEa7rtRez4US59y4ATMr4MI4S9z5vh/HLeOBvyK8zvs2dqeZfeF72o
 28Lw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775044814; x=1775649614; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BQAhi2oFGzUSpnHFrJ7Y2xr0HJ5nPi45k5iZUbAfyO0=;
 b=YbPMGC8IanqkOqNngdNLcNnDCHENS9M/jvvoib+MxU/4d/ophcr8bvXqy2GGMjquqS
 30Laq0sZ5XnD503Rz3QwbzX9NHoRJP6gtJslMeP8HAxJ9tKF/4k02Jcou78L02LJwFdd
 6HfnBLfB8prr27frut8g5ptRVr9L3W/D3Y4oCnJnGeclkM4T89koH/iDxIXRFUNjuWa+
 h3UQkrSuEsdZanlNbYui1WfMByyll2PIruDQDhe7dyQYsgjJH5Q8arJUdmaSx3TvZ0A2
 v71imG5VSHkQSG7v1fSUtfoavACZxtKS5cvoaXdCjR++MBCoA755WJO7VEDGtSOsOY3l
 sMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775044814; x=1775649614;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BQAhi2oFGzUSpnHFrJ7Y2xr0HJ5nPi45k5iZUbAfyO0=;
 b=TrAlKQHjeqRwFTfk2Uv3lJfTmeOYl8Gru2uhaIbG0rkwX0mczsbPTuL5AkvyNS2LHT
 TIvoeMmGKOO7GUOJPdyZfuxqolS01+P+kyahJG16XC7qPQXQEEU9ySEqjJd1e2Mg7qpw
 1sMH9RwgIktSKDRP9uUlXGcdoOfPvwomdRibvHB6avntuXucvvKh03efyTlJEXmDvmL1
 zYpHe8ga1kXBsmW8cynzobSbOjdH8acfG/g9eYX87B4X72LNO8gaB5M+1D6IQS1Gp9Gn
 NXx1HrRy3lklLm4j+bd//TUVTjgzcZmvZo5v29zv/KJq2cmFJSWUu3ACTGWjZ1eKanUK
 79xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSJYYhArF1eVhxsMQriMGox/hpKY/OTZIXE0yN6AqQUtkMkPAgda9enssSp0Ue7mYsti3oe7I19nIz@nongnu.org
X-Gm-Message-State: AOJu0YzDUcbzkeiZLn4nSRUOb/YHeZSW/52bJKOpBvtp31M0/tSFx5Yb
 ssvC77MHph2b89qBSr4OwWkN3ONNx5lBDyiRAOD6Mt2j/QnNqJltxB1qx8CRmnhtBPiLnHwvjpB
 WGh9uOJJpfQVSpYZe+fz451o8OfYkcsI=
X-Gm-Gg: ATEYQzwR/g46oMWcdl0KwpA1r3awlytchNG/a+Hg+fnGISNH3hhlUshVKhWq/0IHGz9
 BxkBlN6fjl1Zb/SRuH4Wj90z1cBeeNnomc26aYS2YE86nSgMT8uwFovxZ2Cr4uNc/uWSrJvMqyS
 Sli6N6I4NuDQ73mw63Jn747yrBTLo76RI0Azcgd8bMIHr/x/s6vrk+MWnEr9GEy/ExCzKsuIj+J
 0Msjmzr77kMMd3e9FTFIfvq7Inysda0AALZzsUCAT16Glka/fGVxGYP1Ns18GIHGoCdj3EuD3kc
 sbyzQcSei7Q/3BRxwoTd1lfQDqvHCWL7W6FkaxWhMyTu6OvP
X-Received: by 2002:a05:6402:3717:b0:66d:d31b:e564 with SMTP id
 4fb4d7f45d1cf-66dd31be725mr1181818a12.17.1775044813524; Wed, 01 Apr 2026
 05:00:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260331110135.92883-1-machadovilaca@gmail.com>
 <871pgy3otf.fsf@pond.sub.org>
 <CAPMcbCpE3mGRhRBoMUqU7rW8jX0xv0zHSvyK+FMemAg5BNQqJg@mail.gmail.com>
In-Reply-To: <CAPMcbCpE3mGRhRBoMUqU7rW8jX0xv0zHSvyK+FMemAg5BNQqJg@mail.gmail.com>
From: =?UTF-8?B?Sm/Do28gVmlsYcOnYQ==?= <machadovilaca@gmail.com>
Date: Wed, 1 Apr 2026 13:00:01 +0100
X-Gm-Features: AQROBzDGC5jvi91EGroneRadmvgfY_OqtC-teb9g2sr0t8XUOzj9uTAQ8SR2HV8
Message-ID: <CAPM7mp1a6Ya9g34XamzFURjQggbb2gNC0MfxaFZq967MK9Qazg@mail.gmail.com>
Subject: Re: [PATCH] qga: implement 'guest-get-nvidia-smi' command
To: Markus Armbruster <armbru@redhat.com>
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Daniel_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000921342064e64d319"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=machadovilaca@gmail.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000921342064e64d319
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tested initially with guest-exec but had issues with SELinux.
I was able to create specific rules to allow virt_qemu_ga_t to access
NVIDIA devices.
But while investigating, I saw a bug discussing guest-exec being disabled
RHEL/CentOS
and whether or not Fedora should do the same. So, I decided to pursue this
alternative.


On Wed, 1 Apr 2026 at 12:50, Kostiantyn Kostiuk <kkostiuk@redhat.com> wrote=
:

>
>
>
>
> On Wed, Apr 1, 2026 at 2:25=E2=80=AFPM Markus Armbruster <armbru@redhat.c=
om>
> wrote:
>
>> You neglected to cc: me.  We recommend to use scripts/get_maintainer.pl
>> to find all the maintainers, then use common sense to trim.
>>
>> Jo=C3=A3o Vila=C3=A7a <machadovilaca@gmail.com> writes:
>>
>> The commit message needs to explain why and how the patch is useful.
>>
>> For a patch adding a command to qemu-ga, like this one, it needs to
>> state the command's anticipated use cases.
>>
>> > ---
>> >  qga/commands-posix.c | 64 +++++++++++++++++++++++++++++++++++++++++++=
+
>> >  qga/commands-win32.c | 64 +++++++++++++++++++++++++++++++++++++++++++=
+
>> >  qga/qapi-schema.json | 59 ++++++++++++++++++++++++++++++++++++++++
>> >  3 files changed, 187 insertions(+)
>> >
>> > diff --git a/qga/commands-posix.c b/qga/commands-posix.c
>> > index 837be51c40..631a8a9ee6 100644
>> > --- a/qga/commands-posix.c
>> > +++ b/qga/commands-posix.c
>> > @@ -1415,3 +1415,67 @@ GuestLoadAverage *qmp_guest_get_load(Error
>> **errp)
>> >      return ret;
>> >  }
>> >  #endif
>> > +
>> > +GuestNvidiaGpuList *qmp_guest_get_nvidia_smi(Error **errp)
>> > +{
>> > +    const gchar *argv[] =3D {
>> > +        "nvidia-smi",
>> > +        "--query-gpu=3Dindex,name,driver_version,"
>> > +            "temperature.gpu,utilization.gpu,utilization.memory,"
>> > +            "memory.total,memory.free,memory.used",
>> > +        "--format=3Dcsv,noheader,nounits",
>> > +        NULL
>> > +    };
>> > +    g_autofree gchar *stdout_buf =3D NULL;
>> > +    g_autofree gchar *stderr_buf =3D NULL;
>> > +    gint exit_status;
>> > +    GError *gerr =3D NULL;
>> > +    GuestNvidiaGpuList *head =3D NULL, **tail =3D &head;
>> > +
>> > +    if (!g_spawn_sync(NULL, (gchar **)argv, NULL,
>> > +                      G_SPAWN_SEARCH_PATH,
>> > +                      NULL, NULL,
>> > +                      &stdout_buf, &stderr_buf,
>> > +                      &exit_status, &gerr)) {
>>
>> Why not ga_run_command()?  Hmm, it throws away the command's output on
>> success.
>>
>> Kostiantyn, should ga_run_command() be rewritten on top of
>> g_spawn_sync()?
>>
>
> The idea of ga_run_command was different.
> Now, we can improve it if we see new use cases.
>
>
>>
>> > +        error_setg(errp, "failed to run nvidia-smi: %s",
>> gerr->message);
>> > +        g_error_free(gerr);
>> > +        return NULL;
>> > +    }
>> > +
>> > +    if (exit_status !=3D 0) {
>> > +        error_setg(errp, "nvidia-smi failed (exit %d): %s",
>> > +                   exit_status, stderr_buf ? stderr_buf : "unknown
>> error");
>>
>> This is wrong if @stderr_buf can contain newlines.  qapi/error.h:
>>
>>  * The resulting message should be a single phrase, with no newline or
>>  * trailing punctuation.
>>
>> However, there's similar misuse elsewhere in this file.  Oh well, carry
>> on.
>>
>> > +        return NULL;
>> > +    }
>> > +
>>
>> I figure the command's output is some form of CSV.  Can you point to its
>> documentation?
>>
>> > +    gchar **lines =3D g_strsplit(stdout_buf, "\n", -1);
>> > +    for (int i =3D 0; lines[i] !=3D NULL; i++) {
>> > +        gchar *line =3D g_strstrip(lines[i]);
>> > +        if (*line =3D=3D '\0') {
>> > +            continue;
>>
>> Silently ignore empty lines.  Okay.
>>
>> > +        }
>> > +
>> > +        gchar **f =3D g_strsplit(line, ", ", 9);
>>
>> If the line has more than 9 values, they are squashed into the last one.
>>
>> > +        if (g_strv_length(f) < 9) {
>> > +            g_strfreev(f);
>> > +            continue;
>>
>> Silently ignore lines with less than 9 values.
>>
>> > +        }
>> > +
>> > +        GuestNvidiaGpu *gpu     =3D g_new0(GuestNvidiaGpu, 1);
>> > +        gpu->index              =3D (int)g_ascii_strtoll(f[0], NULL, =
10);
>>
>> If the value doesn't parse as decimal signed integer, we silently assume
>> zero.
>>
>> If it parses, we silently ignore any text following it.
>>
>> If it parses a value outside 64 bit signed range, we silently assume its
>> largest or smallest value.
>>
>> > +        gpu->name               =3D g_strdup(g_strstrip(f[1]));
>> > +        gpu->driver_version     =3D g_strdup(g_strstrip(f[2]));
>> > +        gpu->temperature        =3D (int)g_ascii_strtoll(f[3], NULL, =
10);
>> > +        gpu->gpu_utilization    =3D (int)g_ascii_strtoll(f[4], NULL, =
10);
>> > +        gpu->memory_utilization =3D (int)g_ascii_strtoll(f[5], NULL, =
10);
>> > +        gpu->memory_total       =3D (int)g_ascii_strtoll(f[6], NULL, =
10);
>> > +        gpu->memory_free        =3D (int)g_ascii_strtoll(f[7], NULL, =
10);
>> > +        gpu->memory_used        =3D (int)g_ascii_strtoll(f[8], NULL, =
10);
>> > +
>> > +        QAPI_LIST_APPEND(tail, gpu);
>> > +        g_strfreev(f);
>> > +    }
>> > +    g_strfreev(lines);
>>
>> Are you *sure* this is robust enough?
>>
>> Please consider a bog-standard LL(1) parser.
>>
>> > +
>> > +    return head;
>> > +}
>> > diff --git a/qga/commands-win32.c b/qga/commands-win32.c
>> > index c0bf3467bd..a78d5b71f5 100644
>> > --- a/qga/commands-win32.c
>> > +++ b/qga/commands-win32.c
>> > @@ -2764,3 +2764,67 @@ GuestNetworkRouteList
>> *qmp_guest_network_get_route(Error **errp)
>> >      g_hash_table_destroy(interface_metric_cache);
>> >      return head;
>> >  }
>> > +
>> > +GuestNvidiaGpuList *qmp_guest_get_nvidia_smi(Error **errp)
>> > +{
>> > +    const gchar *argv[] =3D {
>> > +        "nvidia-smi",
>> > +        "--query-gpu=3Dindex,name,driver_version,"
>> > +            "temperature.gpu,utilization.gpu,utilization.memory,"
>> > +            "memory.total,memory.free,memory.used",
>> > +        "--format=3Dcsv,noheader,nounits",
>> > +        NULL
>> > +    };
>> > +    g_autofree gchar *stdout_buf =3D NULL;
>> > +    g_autofree gchar *stderr_buf =3D NULL;
>> > +    gint exit_status;
>> > +    GError *gerr =3D NULL;
>> > +    GuestNvidiaGpuList *head =3D NULL, **tail =3D &head;
>> > +
>> > +    if (!g_spawn_sync(NULL, (gchar **)argv, NULL,
>> > +                      G_SPAWN_SEARCH_PATH,
>> > +                      NULL, NULL,
>> > +                      &stdout_buf, &stderr_buf,
>> > +                      &exit_status, &gerr)) {
>> > +        error_setg(errp, "failed to run nvidia-smi: %s",
>> gerr->message);
>> > +        g_error_free(gerr);
>> > +        return NULL;
>> > +    }
>> > +
>> > +    if (exit_status !=3D 0) {
>> > +        error_setg(errp, "nvidia-smi failed (exit %d): %s",
>> > +                   exit_status, stderr_buf ? stderr_buf : "unknown
>> error");
>> > +        return NULL;
>> > +    }
>> > +
>> > +    gchar **lines =3D g_strsplit(stdout_buf, "\n", -1);
>> > +    for (int i =3D 0; lines[i] !=3D NULL; i++) {
>> > +        gchar *line =3D g_strstrip(lines[i]);
>> > +        if (*line =3D=3D '\0') {
>> > +            continue;
>> > +        }
>> > +
>> > +        gchar **f =3D g_strsplit(line, ", ", 9);
>> > +        if (g_strv_length(f) < 9) {
>> > +            g_strfreev(f);
>> > +            continue;
>> > +        }
>> > +
>> > +        GuestNvidiaGpu *gpu     =3D g_new0(GuestNvidiaGpu, 1);
>> > +        gpu->index              =3D (int)g_ascii_strtoll(f[0], NULL, =
10);
>> > +        gpu->name               =3D g_strdup(g_strstrip(f[1]));
>> > +        gpu->driver_version     =3D g_strdup(g_strstrip(f[2]));
>> > +        gpu->temperature        =3D (int)g_ascii_strtoll(f[3], NULL, =
10);
>> > +        gpu->gpu_utilization    =3D (int)g_ascii_strtoll(f[4], NULL, =
10);
>> > +        gpu->memory_utilization =3D (int)g_ascii_strtoll(f[5], NULL, =
10);
>> > +        gpu->memory_total       =3D (int)g_ascii_strtoll(f[6], NULL, =
10);
>> > +        gpu->memory_free        =3D (int)g_ascii_strtoll(f[7], NULL, =
10);
>> > +        gpu->memory_used        =3D (int)g_ascii_strtoll(f[8], NULL, =
10);
>> > +
>> > +        QAPI_LIST_APPEND(tail, gpu);
>> > +        g_strfreev(f);
>> > +    }
>> > +    g_strfreev(lines);
>> > +
>> > +    return head;
>> > +}
>>
>> Duplicates the output parser.  Can you avoid that?
>>
>
> There is an open question of who should be looking for the nvidia-smi
> command?
> In the case of Windows, we definitely know that nvidia-smi will be in
> Program Files or
> in the DriverStore, so it will be missing in PATH by default.
> If QGA should use this knowledge, then the Windows part will be different
> (except for the parsing logic)
> because we will be looking for nvidia-smi path. If no, and the user must
> update PATH manually,
> then this can be moved to commands.c
>
>
>>
>> > diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
>> > index c57bc9a02f..8abbf71131 100644
>> > --- a/qga/qapi-schema.json
>> > +++ b/qga/qapi-schema.json
>> > @@ -1876,6 +1876,65 @@
>> >    'if': { 'any': ['CONFIG_WIN32', 'CONFIG_GETLOADAVG'] }
>> >  }
>> >
>> > +##
>> > +# @GuestNvidiaGpu:
>> > +#
>> > +# Information about a single NVIDIA GPU as reported by nvidia-smi.
>> > +#
>> > +# @index: GPU index (0-based), stable across reboots for a given
>> > +#         hardware slot
>>
>> Please format like
>>
>>    # @index: GPU index (0-based), stable across reboots for a given
>>    #     hardware slot
>>
>> > +#
>> > +# @name: GPU product name (e.g. "NVIDIA A100-SXM4-80GB")
>> > +#
>> > +# @driver-version: version string of the installed NVIDIA driver
>> > +#
>> > +# @temperature: GPU die temperature in degrees Celsius
>> > +#
>> > +# @gpu-utilization: GPU compute engine utilization in percent (0-100)
>>
>> (0-100) feels redundant.
>>
>> > +#
>> > +# @memory-utilization: GPU memory controller utilization in percent
>> > +#                      (0-100)
>>
>> Likewise.
>>
>> > +#
>> > +# @memory-total: total framebuffer memory in MiB
>> > +#
>> > +# @memory-free: free framebuffer memory in MiB
>> > +#
>> > +# @memory-used: used framebuffer memory in MiB
>> > +#
>> > +# Since: 10.1
>>
>> 11.1 most likely.
>>
>> > +##
>> > +{ 'struct': 'GuestNvidiaGpu',
>> > +  'data': {
>> > +      'index':              'int',
>> > +      'name':               'str',
>> > +      'driver-version':     'str',
>> > +      'temperature':        'int',
>> > +      'gpu-utilization':    'int',
>> > +      'memory-utilization': 'int',
>> > +      'memory-total':       'int',
>> > +      'memory-free':        'int',
>> > +      'memory-used':        'int'
>> > +  }
>> > +}
>> > +
>> > +##
>> > +# @guest-get-nvidia-smi:
>> > +#
>> > +# Query NVIDIA GPU information via nvidia-smi inside the guest.
>> > +#
>> > +# Returns one @GuestNvidiaGpu entry per physical GPU (or MIG instance=
)
>> > +# detected by the NVIDIA driver.
>> > +#
>> > +# Errors:
>> > +#   - If nvidia-smi is not installed or not found in $PATH
>> > +#   - If nvidia-smi exits with a non-zero status (e.g. no NVIDIA
>> > +#     device)
>>
>> We commonly mention the error kind like this:
>>
>>    #   - If nvidia-smi is not installed or not found in $PATH,
>>    #     GenericError
>>    #   - If nvidia-smi exits with a non-zero status (e.g. no NVIDIA
>>    #     device), GenericError
>>
>> > +#
>> > +# Since: 10.1
>> > +##
>> > +{ 'command': 'guest-get-nvidia-smi',
>> > +  'returns': ['GuestNvidiaGpu'] }
>> > +
>> >  ##
>> >  # @GuestNetworkRoute:
>> >  #
>>
>> Why not use existing guest-exec, and leave the parsing to the client?
>>
>
> I agree with Daniel that guest-exec is a command that should not exist.
> For example, in RHEL/CentOS, this command is disabled by default, and
> we recommend using SSH over VSock to run any command.
> We have seen the problem several times with guest-exec. Also, we have an
> upstream patch
> for guest-exec + SELinux support to try to workaround a security issue.
> Maybe we should discuss marking guest-exec as deprecated.
>
> So, I agree with the author to add a separate command instead.
>
>
>
>
>

--000000000000921342064e64d319
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I tested initially with=C2=A0guest-exec but had issues wit=
h SELinux.<br>I was able to create specific rules to allow virt_qemu_ga_t t=
o access NVIDIA devices.<br>But while investigating, I saw a bug discussing=
 guest-exec being disabled RHEL/CentOS<br>and whether or not Fedora should =
do the same. So, I decided to pursue=C2=A0this alternative.<br><br></div><b=
r><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Wed, 1 Apr 2026 at 12:50, Kostiantyn Kostiuk &lt;<a href=
=3D"mailto:kkostiuk@redhat.com">kkostiuk@redhat.com</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div di=
r=3D"ltr"><div><br clear=3D"all"></div><div><div dir=3D"ltr" class=3D"gmail=
_signature"><div dir=3D"ltr"><br></div></div></div><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 1, 2026 =
at 2:25=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.co=
m" target=3D"_blank">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">You neglected to cc: me.=C2=A0 We rec=
ommend to use scripts/<a href=3D"http://get_maintainer.pl" rel=3D"noreferre=
r" target=3D"_blank">get_maintainer.pl</a><br>
to find all the maintainers, then use common sense to trim.<br>
<br>
Jo=C3=A3o Vila=C3=A7a &lt;<a href=3D"mailto:machadovilaca@gmail.com" target=
=3D"_blank">machadovilaca@gmail.com</a>&gt; writes:<br>
<br>
The commit message needs to explain why and how the patch is useful.<br>
<br>
For a patch adding a command to qemu-ga, like this one, it needs to<br>
state the command&#39;s anticipated use cases.<br>
<br>
&gt; ---<br>
&gt;=C2=A0 qga/commands-posix.c | 64 ++++++++++++++++++++++++++++++++++++++=
++++++<br>
&gt;=C2=A0 qga/commands-win32.c | 64 ++++++++++++++++++++++++++++++++++++++=
++++++<br>
&gt;=C2=A0 qga/qapi-schema.json | 59 ++++++++++++++++++++++++++++++++++++++=
++<br>
&gt;=C2=A0 3 files changed, 187 insertions(+)<br>
&gt;<br>
&gt; diff --git a/qga/commands-posix.c b/qga/commands-posix.c<br>
&gt; index 837be51c40..631a8a9ee6 100644<br>
&gt; --- a/qga/commands-posix.c<br>
&gt; +++ b/qga/commands-posix.c<br>
&gt; @@ -1415,3 +1415,67 @@ GuestLoadAverage *qmp_guest_get_load(Error **er=
rp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return ret;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 #endif<br>
&gt; +<br>
&gt; +GuestNvidiaGpuList *qmp_guest_get_nvidia_smi(Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 const gchar *argv[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;nvidia-smi&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;--query-gpu=3Dindex,name,driver_ver=
sion,&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;temperature.gpu,utili=
zation.gpu,utilization.memory,&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;memory.total,memory.f=
ree,memory.used&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;--format=3Dcsv,noheader,nounits&quo=
t;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +=C2=A0 =C2=A0 g_autofree gchar *stdout_buf =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 g_autofree gchar *stderr_buf =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 gint exit_status;<br>
&gt; +=C2=A0 =C2=A0 GError *gerr =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 GuestNvidiaGpuList *head =3D NULL, **tail =3D &amp;head=
;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!g_spawn_sync(NULL, (gchar **)argv, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 G_SPAWN_SEARCH_PATH,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 NULL, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 &amp;stdout_buf, &amp;stderr_buf,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 &amp;exit_status, &amp;gerr)) {<br>
<br>
Why not ga_run_command()?=C2=A0 Hmm, it throws away the command&#39;s outpu=
t on<br>
success.<br>
<br>
Kostiantyn, should ga_run_command() be rewritten on top of<br>
g_spawn_sync()?<br></blockquote><div><br></div><div>The idea of=C2=A0ga_run=
_command was different.<br></div><div>Now, we can improve it if=C2=A0we see=
 new use cases.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;failed to run nvid=
ia-smi: %s&quot;, gerr-&gt;message);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_error_free(gerr);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (exit_status !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;nvidia-smi failed =
(exit %d): %s&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
exit_status, stderr_buf ? stderr_buf : &quot;unknown error&quot;);<br>
<br>
This is wrong if @stderr_buf can contain newlines.=C2=A0 qapi/error.h:<br>
<br>
=C2=A0* The resulting message should be a single phrase, with no newline or=
<br>
=C2=A0* trailing punctuation.<br>
<br>
However, there&#39;s similar misuse elsewhere in this file.=C2=A0 Oh well, =
carry<br>
on.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
<br>
I figure the command&#39;s output is some form of CSV.=C2=A0 Can you point =
to its<br>
documentation?<br>
<br>
&gt; +=C2=A0 =C2=A0 gchar **lines =3D g_strsplit(stdout_buf, &quot;\n&quot;=
, -1);<br>
&gt; +=C2=A0 =C2=A0 for (int i =3D 0; lines[i] !=3D NULL; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 gchar *line =3D g_strstrip(lines[i]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*line =3D=3D &#39;\0&#39;) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
<br>
Silently ignore empty lines.=C2=A0 Okay.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 gchar **f =3D g_strsplit(line, &quot;, &q=
uot;, 9);<br>
<br>
If the line has more than 9 values, they are squashed into the last one.<br=
>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (g_strv_length(f) &lt; 9) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_strfreev(f);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
<br>
Silently ignore lines with less than 9 values.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 GuestNvidiaGpu *gpu=C2=A0 =C2=A0 =C2=A0=
=3D g_new0(GuestNvidiaGpu, 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;index=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =3D (int)g_ascii_strtoll(f[0], NULL, 10);<br>
<br>
If the value doesn&#39;t parse as decimal signed integer, we silently assum=
e<br>
zero.<br>
<br>
If it parses, we silently ignore any text following it.<br>
<br>
If it parses a value outside 64 bit signed range, we silently assume its<br=
>
largest or smallest value.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D g_strdup(g_strstrip(f[1]));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;driver_version=C2=A0 =C2=A0 =C2=
=A0=3D g_strdup(g_strstrip(f[2]));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;temperature=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =3D (int)g_ascii_strtoll(f[3], NULL, 10);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;gpu_utilization=C2=A0 =C2=A0 =3D =
(int)g_ascii_strtoll(f[4], NULL, 10);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;memory_utilization =3D (int)g_asc=
ii_strtoll(f[5], NULL, 10);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;memory_total=C2=A0 =C2=A0 =C2=A0 =
=C2=A0=3D (int)g_ascii_strtoll(f[6], NULL, 10);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;memory_free=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =3D (int)g_ascii_strtoll(f[7], NULL, 10);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;memory_used=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =3D (int)g_ascii_strtoll(f[8], NULL, 10);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPI_LIST_APPEND(tail, gpu);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_strfreev(f);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 g_strfreev(lines);<br>
<br>
Are you *sure* this is robust enough?<br>
<br>
Please consider a bog-standard LL(1) parser.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return head;<br>
&gt; +}<br>
&gt; diff --git a/qga/commands-win32.c b/qga/commands-win32.c<br>
&gt; index c0bf3467bd..a78d5b71f5 100644<br>
&gt; --- a/qga/commands-win32.c<br>
&gt; +++ b/qga/commands-win32.c<br>
&gt; @@ -2764,3 +2764,67 @@ GuestNetworkRouteList *qmp_guest_network_get_ro=
ute(Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_hash_table_destroy(interface_metric_cache);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return head;<br>
&gt;=C2=A0 }<br>
&gt; +<br>
&gt; +GuestNvidiaGpuList *qmp_guest_get_nvidia_smi(Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 const gchar *argv[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;nvidia-smi&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;--query-gpu=3Dindex,name,driver_ver=
sion,&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;temperature.gpu,utili=
zation.gpu,utilization.memory,&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;memory.total,memory.f=
ree,memory.used&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;--format=3Dcsv,noheader,nounits&quo=
t;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +=C2=A0 =C2=A0 g_autofree gchar *stdout_buf =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 g_autofree gchar *stderr_buf =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 gint exit_status;<br>
&gt; +=C2=A0 =C2=A0 GError *gerr =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 GuestNvidiaGpuList *head =3D NULL, **tail =3D &amp;head=
;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!g_spawn_sync(NULL, (gchar **)argv, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 G_SPAWN_SEARCH_PATH,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 NULL, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 &amp;stdout_buf, &amp;stderr_buf,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 &amp;exit_status, &amp;gerr)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;failed to run nvid=
ia-smi: %s&quot;, gerr-&gt;message);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_error_free(gerr);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (exit_status !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;nvidia-smi failed =
(exit %d): %s&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
exit_status, stderr_buf ? stderr_buf : &quot;unknown error&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 gchar **lines =3D g_strsplit(stdout_buf, &quot;\n&quot;=
, -1);<br>
&gt; +=C2=A0 =C2=A0 for (int i =3D 0; lines[i] !=3D NULL; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 gchar *line =3D g_strstrip(lines[i]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*line =3D=3D &#39;\0&#39;) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 gchar **f =3D g_strsplit(line, &quot;, &q=
uot;, 9);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (g_strv_length(f) &lt; 9) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_strfreev(f);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 GuestNvidiaGpu *gpu=C2=A0 =C2=A0 =C2=A0=
=3D g_new0(GuestNvidiaGpu, 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;index=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =3D (int)g_ascii_strtoll(f[0], NULL, 10);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D g_strdup(g_strstrip(f[1]));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;driver_version=C2=A0 =C2=A0 =C2=
=A0=3D g_strdup(g_strstrip(f[2]));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;temperature=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =3D (int)g_ascii_strtoll(f[3], NULL, 10);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;gpu_utilization=C2=A0 =C2=A0 =3D =
(int)g_ascii_strtoll(f[4], NULL, 10);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;memory_utilization =3D (int)g_asc=
ii_strtoll(f[5], NULL, 10);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;memory_total=C2=A0 =C2=A0 =C2=A0 =
=C2=A0=3D (int)g_ascii_strtoll(f[6], NULL, 10);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;memory_free=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =3D (int)g_ascii_strtoll(f[7], NULL, 10);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;memory_used=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =3D (int)g_ascii_strtoll(f[8], NULL, 10);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPI_LIST_APPEND(tail, gpu);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_strfreev(f);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 g_strfreev(lines);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return head;<br>
&gt; +}<br>
<br>
Duplicates the output parser.=C2=A0 Can you avoid that?<br></blockquote><di=
v><br></div><div>There is an open question of who should be looking for the=
=C2=A0nvidia-smi command?<br></div><div>In the case of Windows, we definite=
ly=C2=A0know that=C2=A0nvidia-smi will be in Program Files or</div><div>in =
the DriverStore, so it will be missing in PATH by default.</div><div>If QGA=
 should use this knowledge, then the Windows part will be different (except=
 for the parsing logic)</div><div>because we will be looking for=C2=A0nvidi=
a-smi path. If no, and the user=C2=A0must update PATH manually,</div><div>t=
hen this can be moved to=C2=A0commands.c</div><div>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
<br>
&gt; diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
&gt; index c57bc9a02f..8abbf71131 100644<br>
&gt; --- a/qga/qapi-schema.json<br>
&gt; +++ b/qga/qapi-schema.json<br>
&gt; @@ -1876,6 +1876,65 @@<br>
&gt;=C2=A0 =C2=A0 &#39;if&#39;: { &#39;any&#39;: [&#39;CONFIG_WIN32&#39;, &=
#39;CONFIG_GETLOADAVG&#39;] }<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +##<br>
&gt; +# @GuestNvidiaGpu:<br>
&gt; +#<br>
&gt; +# Information about a single NVIDIA GPU as reported by nvidia-smi.<br=
>
&gt; +#<br>
&gt; +# @index: GPU index (0-based), stable across reboots for a given<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hardware slot<br>
<br>
Please format like<br>
<br>
=C2=A0 =C2=A0# @index: GPU index (0-based), stable across reboots for a giv=
en<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0hardware slot<br>
<br>
&gt; +#<br>
&gt; +# @name: GPU product name (e.g. &quot;NVIDIA A100-SXM4-80GB&quot;)<br=
>
&gt; +#<br>
&gt; +# @driver-version: version string of the installed NVIDIA driver<br>
&gt; +#<br>
&gt; +# @temperature: GPU die temperature in degrees Celsius<br>
&gt; +#<br>
&gt; +# @gpu-utilization: GPU compute engine utilization in percent (0-100)=
<br>
<br>
(0-100) feels redundant.<br>
<br>
&gt; +#<br>
&gt; +# @memory-utilization: GPU memory controller utilization in percent<b=
r>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (0-100)<br>
<br>
Likewise.<br>
<br>
&gt; +#<br>
&gt; +# @memory-total: total framebuffer memory in MiB<br>
&gt; +#<br>
&gt; +# @memory-free: free framebuffer memory in MiB<br>
&gt; +#<br>
&gt; +# @memory-used: used framebuffer memory in MiB<br>
&gt; +#<br>
&gt; +# Since: 10.1<br>
<br>
11.1 most likely.<br>
<br>
&gt; +##<br>
&gt; +{ &#39;struct&#39;: &#39;GuestNvidiaGpu&#39;,<br>
&gt; +=C2=A0 &#39;data&#39;: {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &#39;index&#39;:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &#39;int&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &#39;name&#39;:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&#39;str&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &#39;driver-version&#39;:=C2=A0 =C2=A0 =C2=A0&#3=
9;str&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &#39;temperature&#39;:=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &#39;int&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &#39;gpu-utilization&#39;:=C2=A0 =C2=A0 &#39;int=
&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &#39;memory-utilization&#39;: &#39;int&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &#39;memory-total&#39;:=C2=A0 =C2=A0 =C2=A0 =C2=
=A0&#39;int&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &#39;memory-free&#39;:=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &#39;int&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &#39;memory-used&#39;:=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &#39;int&#39;<br>
&gt; +=C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +##<br>
&gt; +# @guest-get-nvidia-smi:<br>
&gt; +#<br>
&gt; +# Query NVIDIA GPU information via nvidia-smi inside the guest.<br>
&gt; +#<br>
&gt; +# Returns one @GuestNvidiaGpu entry per physical GPU (or MIG instance=
)<br>
&gt; +# detected by the NVIDIA driver.<br>
&gt; +#<br>
&gt; +# Errors:<br>
&gt; +#=C2=A0 =C2=A0- If nvidia-smi is not installed or not found in $PATH<=
br>
&gt; +#=C2=A0 =C2=A0- If nvidia-smi exits with a non-zero status (e.g. no N=
VIDIA<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0device)<br>
<br>
We commonly mention the error kind like this:<br>
<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0- If nvidia-smi is not installed or not found in=
 $PATH,<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0GenericError<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0- If nvidia-smi exits with a non-zero status (e.=
g. no NVIDIA<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0device), GenericError<br>
<br>
&gt; +#<br>
&gt; +# Since: 10.1<br>
&gt; +##<br>
&gt; +{ &#39;command&#39;: &#39;guest-get-nvidia-smi&#39;,<br>
&gt; +=C2=A0 &#39;returns&#39;: [&#39;GuestNvidiaGpu&#39;] }<br>
&gt; +<br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 # @GuestNetworkRoute:<br>
&gt;=C2=A0 #<br>
<br>
Why not use existing guest-exec, and leave the parsing to the client?<br></=
blockquote><div><br></div><div>I agree with Daniel that guest-exec is a com=
mand that should not exist.</div><div>For example, in RHEL/CentOS, this com=
mand is disabled by default, and</div><div>we recommend using=C2=A0SSH over=
 VSock to run any command.<br>We have seen the problem several times with g=
uest-exec. Also, we have an upstream patch</div><div>for guest-exec=C2=A0+ =
SELinux support to try to workaround a security issue.</div><div>Maybe we s=
hould discuss=C2=A0marking=C2=A0guest-exec as deprecated.=C2=A0</div><div><=
br></div><div>So, I agree with the author to add a separate command instead=
.<br><br><br></div><div><br></div><div>=C2=A0</div></div></div>
</blockquote></div>

--000000000000921342064e64d319--

