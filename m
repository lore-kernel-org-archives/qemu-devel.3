Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391FC109B463
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 12:58:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7YfY-0003Xg-KQ; Tue, 31 Mar 2026 08:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w7YfS-0003Tr-97
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 08:58:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w7YfP-0001iD-SF
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 08:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774961879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JQROcu2sW07u77tca6UlfaqkDL2Fz5BFENhHghxpauE=;
 b=CnDUfgx9L7NH0oV3ZmgfZsMXy1Cepfz9Y0Qmmo03dIy76f7+5rhgC+hhjHGr4AqES3lBNF
 sfiTjSW9pukS6e0Wcs6H84VGeRp6VECHgrkbjf5zH8ENx4TANPS1+qfmzkoQ02ymWTWm4U
 u/ZET4odhevsKWohMPsv61mj414z7Dg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-geeQZcsgOie0kFy3W1oSuQ-1; Tue, 31 Mar 2026 08:57:57 -0400
X-MC-Unique: geeQZcsgOie0kFy3W1oSuQ-1
X-Mimecast-MFC-AGG-ID: geeQZcsgOie0kFy3W1oSuQ_1774961877
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-89fa878662bso143475556d6.2
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 05:57:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774961877; cv=none;
 d=google.com; s=arc-20240605;
 b=HTimQu++lEDNBax7VC+G0QyYwcDwoH+uW+fzYbp+BiF8akdTb4rucTiPPzB4UOUasf
 kv3mHP7reokFldBMSYRCq4uAN4tsSyMhZcCfMlGrR41QkV6GWAbQlIOk/NKXOzv9g0Xu
 mj8/pSPfyHGUacbokevCtKKw6ajzUSgUXAUl7IuQ0gjQmSrrB+M1AUn0YPWtfCPAA49r
 /y0g4qcg3kqOVseF+K/TdZUSOS8vkedMwjW1YjyyQETM0ZkaPM7KsW3+tGCfK4tfx59O
 hJ0QXvck4739cQEUnEaxJ51IOG489k5xpK5lm5Q9wHDsJSYsqkq2+t2x2E1t8t20ys/y
 ChbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JQROcu2sW07u77tca6UlfaqkDL2Fz5BFENhHghxpauE=;
 fh=hi8r9G22XKweBTUnIs8Ro40MCh1P5W8qcYS7KAk7z6E=;
 b=kBeUFQufXnkgXNn+1f77a67S9ikusbnyfHRVkAJkbDWy0gOnZ0Uya2qCviHMtvjqeO
 /VYt52Cd6C0p0fLH7KbPXn9cXPfmFL1I+5J446Y6bGVt/T+9rwrGrXdZijsqITAASqcp
 bltN1zuFmStFi43rhW66By35S1faFwXR6BjQV84fWRlDvW0nST40MrYbpsW3ilhJ0lGi
 n6Ig6L5Fn67HjWYrai6/buGAfP7c9q8rdY2GVJHNZWoqEdml8WtBR1XC/VUactnd48zq
 gOV6UmNXCrfSZsxi7cfz4zmnupCfns5LY2E2sNQ/KO5aa/WMIrjwUy2mmob4WJlaaELD
 iuCQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774961877; x=1775566677; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JQROcu2sW07u77tca6UlfaqkDL2Fz5BFENhHghxpauE=;
 b=O3ieCSFtQc3qki4LwqmvpRO+8GYnu4gTu9Uu2uGjXfHkdfh3Zx79fEYNrgw0Rnsdma
 2Y5t2v7+JvZF+tXkeFybt7a3BArumoFxXLvZGOcbJDOCs1fyFrDpu7x+RtfVKCGAEMQG
 cn/M6gSrDfZVbZQNP4sziJRLDaVc2q943ps6+1P7nztIGTGUAtQfW+4mcMnCliraiAS/
 VcMQNdrwQdBAANirFXmA4gkbClQKDLAssMHHN6nVWm1aTeJgKHhM/OrPqdNorJAx6SF8
 T2yTFOLK5RmE2Lwt/R2s6sWgZhitP8ws8P3RdgjGwNjcPvL7hAttq5627dPfShfnCB7d
 NsSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774961877; x=1775566677;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JQROcu2sW07u77tca6UlfaqkDL2Fz5BFENhHghxpauE=;
 b=c2C+wQqOijy6VYPm6ZDy/+ttKb3tEx/9SsqADYDL4AscjgpqZL5Gb+NUMS2DDt2XMD
 1lXtNSIn60SnCcGWWAkuDPsghZPDNJNC5oXOY8vZZrq8TJNGHpuXzbPk/2eZhGE00E4/
 rIGp3Sf4Az0SJFpQ6TqeMRxL4YrrxcOofTi/m459vyVA9AeekV0umMf7Ux1Ex4lCZMns
 OPcw0+7MkD0NMafWW/VlrzcdnMO7zlJIWc1bNe0HQTOBsnMXcNglI2Lz3K5R2UKnrTV9
 w6WI4y04GEms89ji95SIM+YyAHT1zzl9OEuyA+mes2ePEZYet7+dcHKuOKGFnz3WPhyJ
 TggQ==
X-Gm-Message-State: AOJu0YxvA8E3/oNK0xCqRl7FuFTzoU7SUO2hoRhcVavhG5fw7im7m8yl
 3XHqTfiBDGl/v63fc2i7drZbXshbqOMjue8yDH/xfsK0+rhG+bD99Y6wtqEBIVXV/Cq2zXgUjQj
 3D+1QvAdnyillFTmb+psnOpK7cyI/PnSIyZ1rDOf7V/vGItZBxDoVZXXIiDCUoeBfsj5NA1DasY
 bqLGBHim3VMa5XecgaXcfowotUxyh8Dlo=
X-Gm-Gg: ATEYQzx6FVA6UWmsBlXTTO71HLTjDxNeZ0nsm5p3gd+QA+RY700kpVV9S/4eC9mL5+0
 /gp/wWm+tNTH0JdrR0Bb4HUyk+HvrKEf78LvUzRG540eNmYdKvpguSWd27+gyaGrQsDS6s3abog
 kopbFiT0NkgJNYfFwuphLLjxlLhlJvdlgqStxBxUQQ0DIObi1GbjaMt5ATGUp7ATtBtQzX33qUy
 t5KyyDN
X-Received: by 2002:a05:6214:4848:b0:89a:629:2203 with SMTP id
 6a1803df08f44-89ce8cbc82amr217197086d6.11.1774961876733; 
 Tue, 31 Mar 2026 05:57:56 -0700 (PDT)
X-Received: by 2002:a05:6214:4848:b0:89a:629:2203 with SMTP id
 6a1803df08f44-89ce8cbc82amr217196646d6.11.1774961876152; Tue, 31 Mar 2026
 05:57:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260331110135.92883-1-machadovilaca@gmail.com>
In-Reply-To: <20260331110135.92883-1-machadovilaca@gmail.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Tue, 31 Mar 2026 15:57:45 +0300
X-Gm-Features: AQROBzBC47ZVvvieSuym1P2Mob-OSwSynrt7pQO0bdaVSuc4qyepP9WfUOlKVuw
Message-ID: <CAPMcbCpJsiTs95g_8v+AkNCL7LhVAK+CZM=X-y+-kbRDd41bSA@mail.gmail.com>
Subject: Re: [PATCH] qga: implement 'guest-get-nvidia-smi' command
To: =?UTF-8?B?Sm/Do28gVmlsYcOnYQ==?= <machadovilaca@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000001e413d064e5184d4"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--0000000000001e413d064e5184d4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jo=C3=A3o,

Thanks for your patch. Can you explain the use case of this command?

Best Regards,
Kostiantyn Kostiuk.


On Tue, Mar 31, 2026 at 2:02=E2=80=AFPM Jo=C3=A3o Vila=C3=A7a <machadovilac=
a@gmail.com> wrote:

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
> +        error_setg(errp, "failed to run nvidia-smi: %s", gerr->message);
> +        g_error_free(gerr);
> +        return NULL;
> +    }
> +
> +    if (exit_status !=3D 0) {
> +        error_setg(errp, "nvidia-smi failed (exit %d): %s",
> +                   exit_status, stderr_buf ? stderr_buf : "unknown
> error");
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
> +        gpu->index              =3D (int)g_ascii_strtoll(f[0], NULL, 10)=
;
> +        gpu->name               =3D g_strdup(g_strstrip(f[1]));
> +        gpu->driver_version     =3D g_strdup(g_strstrip(f[2]));
> +        gpu->temperature        =3D (int)g_ascii_strtoll(f[3], NULL, 10)=
;
> +        gpu->gpu_utilization    =3D (int)g_ascii_strtoll(f[4], NULL, 10)=
;
> +        gpu->memory_utilization =3D (int)g_ascii_strtoll(f[5], NULL, 10)=
;
> +        gpu->memory_total       =3D (int)g_ascii_strtoll(f[6], NULL, 10)=
;
> +        gpu->memory_free        =3D (int)g_ascii_strtoll(f[7], NULL, 10)=
;
> +        gpu->memory_used        =3D (int)g_ascii_strtoll(f[8], NULL, 10)=
;
> +
> +        QAPI_LIST_APPEND(tail, gpu);
> +        g_strfreev(f);
> +    }
> +    g_strfreev(lines);
> +
> +    return head;
> +}
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index c0bf3467bd..a78d5b71f5 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -2764,3 +2764,67 @@ GuestNetworkRouteList
> *qmp_guest_network_get_route(Error **errp)
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
> +                   exit_status, stderr_buf ? stderr_buf : "unknown
> error");
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
> +        gpu->index              =3D (int)g_ascii_strtoll(f[0], NULL, 10)=
;
> +        gpu->name               =3D g_strdup(g_strstrip(f[1]));
> +        gpu->driver_version     =3D g_strdup(g_strstrip(f[2]));
> +        gpu->temperature        =3D (int)g_ascii_strtoll(f[3], NULL, 10)=
;
> +        gpu->gpu_utilization    =3D (int)g_ascii_strtoll(f[4], NULL, 10)=
;
> +        gpu->memory_utilization =3D (int)g_ascii_strtoll(f[5], NULL, 10)=
;
> +        gpu->memory_total       =3D (int)g_ascii_strtoll(f[6], NULL, 10)=
;
> +        gpu->memory_free        =3D (int)g_ascii_strtoll(f[7], NULL, 10)=
;
> +        gpu->memory_used        =3D (int)g_ascii_strtoll(f[8], NULL, 10)=
;
> +
> +        QAPI_LIST_APPEND(tail, gpu);
> +        g_strfreev(f);
> +    }
> +    g_strfreev(lines);
> +
> +    return head;
> +}
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index c57bc9a02f..8abbf71131 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1876,6 +1876,65 @@
>    'if': { 'any': ['CONFIG_WIN32', 'CONFIG_GETLOADAVG'] }
>  }
>
> +##
> +# @GuestNvidiaGpu:
> +#
> +# Information about a single NVIDIA GPU as reported by nvidia-smi.
> +#
> +# @index: GPU index (0-based), stable across reboots for a given
> +#         hardware slot
> +#
> +# @name: GPU product name (e.g. "NVIDIA A100-SXM4-80GB")
> +#
> +# @driver-version: version string of the installed NVIDIA driver
> +#
> +# @temperature: GPU die temperature in degrees Celsius
> +#
> +# @gpu-utilization: GPU compute engine utilization in percent (0-100)
> +#
> +# @memory-utilization: GPU memory controller utilization in percent
> +#                      (0-100)
> +#
> +# @memory-total: total framebuffer memory in MiB
> +#
> +# @memory-free: free framebuffer memory in MiB
> +#
> +# @memory-used: used framebuffer memory in MiB
> +#
> +# Since: 10.1
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
> +#
> +# Since: 10.1
> +##
> +{ 'command': 'guest-get-nvidia-smi',
> +  'returns': ['GuestNvidiaGpu'] }
> +
>  ##
>  # @GuestNetworkRoute:
>  #
> --
> 2.53.0
>
>

--0000000000001e413d064e5184d4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi=C2=A0Jo=C3=A3o,</div><div><br></div><div>Thanks fo=
r your patch. Can you explain the use case of this command?=C2=A0</div><div=
><br></div><div><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=
=3D"gmail_signature"><div dir=3D"ltr"><div>Best Regards,</div><div>Kostiant=
yn Kostiuk.</div></div></div></div><br></div><br><div class=3D"gmail_quote =
gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 31=
, 2026 at 2:02=E2=80=AFPM Jo=C3=A3o Vila=C3=A7a &lt;<a href=3D"mailto:macha=
dovilaca@gmail.com">machadovilaca@gmail.com</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">---<br>
=C2=A0qga/commands-posix.c | 64 +++++++++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A0qga/commands-win32.c | 64 +++++++++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A0qga/qapi-schema.json | 59 ++++++++++++++++++++++++++++++++++++++++<br=
>
=C2=A03 files changed, 187 insertions(+)<br>
<br>
diff --git a/qga/commands-posix.c b/qga/commands-posix.c<br>
index 837be51c40..631a8a9ee6 100644<br>
--- a/qga/commands-posix.c<br>
+++ b/qga/commands-posix.c<br>
@@ -1415,3 +1415,67 @@ GuestLoadAverage *qmp_guest_get_load(Error **errp)<b=
r>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
=C2=A0#endif<br>
+<br>
+GuestNvidiaGpuList *qmp_guest_get_nvidia_smi(Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 const gchar *argv[] =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;nvidia-smi&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;--query-gpu=3Dindex,name,driver_version,=
&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;temperature.gpu,utilizatio=
n.gpu,utilization.memory,&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;memory.total,memory.free,m=
emory.used&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;--format=3Dcsv,noheader,nounits&quot;,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL<br>
+=C2=A0 =C2=A0 };<br>
+=C2=A0 =C2=A0 g_autofree gchar *stdout_buf =3D NULL;<br>
+=C2=A0 =C2=A0 g_autofree gchar *stderr_buf =3D NULL;<br>
+=C2=A0 =C2=A0 gint exit_status;<br>
+=C2=A0 =C2=A0 GError *gerr =3D NULL;<br>
+=C2=A0 =C2=A0 GuestNvidiaGpuList *head =3D NULL, **tail =3D &amp;head;<br>
+<br>
+=C2=A0 =C2=A0 if (!g_spawn_sync(NULL, (gchar **)argv, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 G_SPAWN_SEARCH_PATH,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 NULL, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &amp;stdout_buf, &amp;stderr_buf,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &amp;exit_status, &amp;gerr)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;failed to run nvidia-sm=
i: %s&quot;, gerr-&gt;message);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_error_free(gerr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (exit_status !=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;nvidia-smi failed (exit=
 %d): %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit_=
status, stderr_buf ? stderr_buf : &quot;unknown error&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 gchar **lines =3D g_strsplit(stdout_buf, &quot;\n&quot;, -1)=
;<br>
+=C2=A0 =C2=A0 for (int i =3D 0; lines[i] !=3D NULL; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gchar *line =3D g_strstrip(lines[i]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*line =3D=3D &#39;\0&#39;) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gchar **f =3D g_strsplit(line, &quot;, &quot;,=
 9);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (g_strv_length(f) &lt; 9) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_strfreev(f);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 GuestNvidiaGpu *gpu=C2=A0 =C2=A0 =C2=A0=3D g_n=
ew0(GuestNvidiaGpu, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;index=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D (int)g_ascii_strtoll(f[0], NULL, 10);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0=3D g_strdup(g_strstrip(f[1]));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;driver_version=C2=A0 =C2=A0 =C2=A0=3D =
g_strdup(g_strstrip(f[2]));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;temperature=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =3D (int)g_ascii_strtoll(f[3], NULL, 10);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;gpu_utilization=C2=A0 =C2=A0 =3D (int)=
g_ascii_strtoll(f[4], NULL, 10);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;memory_utilization =3D (int)g_ascii_st=
rtoll(f[5], NULL, 10);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;memory_total=C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D (int)g_ascii_strtoll(f[6], NULL, 10);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;memory_free=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =3D (int)g_ascii_strtoll(f[7], NULL, 10);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;memory_used=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =3D (int)g_ascii_strtoll(f[8], NULL, 10);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPI_LIST_APPEND(tail, gpu);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_strfreev(f);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 g_strfreev(lines);<br>
+<br>
+=C2=A0 =C2=A0 return head;<br>
+}<br>
diff --git a/qga/commands-win32.c b/qga/commands-win32.c<br>
index c0bf3467bd..a78d5b71f5 100644<br>
--- a/qga/commands-win32.c<br>
+++ b/qga/commands-win32.c<br>
@@ -2764,3 +2764,67 @@ GuestNetworkRouteList *qmp_guest_network_get_route(E=
rror **errp)<br>
=C2=A0 =C2=A0 =C2=A0g_hash_table_destroy(interface_metric_cache);<br>
=C2=A0 =C2=A0 =C2=A0return head;<br>
=C2=A0}<br>
+<br>
+GuestNvidiaGpuList *qmp_guest_get_nvidia_smi(Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 const gchar *argv[] =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;nvidia-smi&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;--query-gpu=3Dindex,name,driver_version,=
&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;temperature.gpu,utilizatio=
n.gpu,utilization.memory,&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;memory.total,memory.free,m=
emory.used&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;--format=3Dcsv,noheader,nounits&quot;,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL<br>
+=C2=A0 =C2=A0 };<br>
+=C2=A0 =C2=A0 g_autofree gchar *stdout_buf =3D NULL;<br>
+=C2=A0 =C2=A0 g_autofree gchar *stderr_buf =3D NULL;<br>
+=C2=A0 =C2=A0 gint exit_status;<br>
+=C2=A0 =C2=A0 GError *gerr =3D NULL;<br>
+=C2=A0 =C2=A0 GuestNvidiaGpuList *head =3D NULL, **tail =3D &amp;head;<br>
+<br>
+=C2=A0 =C2=A0 if (!g_spawn_sync(NULL, (gchar **)argv, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 G_SPAWN_SEARCH_PATH,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 NULL, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &amp;stdout_buf, &amp;stderr_buf,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &amp;exit_status, &amp;gerr)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;failed to run nvidia-sm=
i: %s&quot;, gerr-&gt;message);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_error_free(gerr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (exit_status !=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;nvidia-smi failed (exit=
 %d): %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit_=
status, stderr_buf ? stderr_buf : &quot;unknown error&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 gchar **lines =3D g_strsplit(stdout_buf, &quot;\n&quot;, -1)=
;<br>
+=C2=A0 =C2=A0 for (int i =3D 0; lines[i] !=3D NULL; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gchar *line =3D g_strstrip(lines[i]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*line =3D=3D &#39;\0&#39;) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gchar **f =3D g_strsplit(line, &quot;, &quot;,=
 9);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (g_strv_length(f) &lt; 9) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_strfreev(f);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 GuestNvidiaGpu *gpu=C2=A0 =C2=A0 =C2=A0=3D g_n=
ew0(GuestNvidiaGpu, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;index=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D (int)g_ascii_strtoll(f[0], NULL, 10);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0=3D g_strdup(g_strstrip(f[1]));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;driver_version=C2=A0 =C2=A0 =C2=A0=3D =
g_strdup(g_strstrip(f[2]));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;temperature=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =3D (int)g_ascii_strtoll(f[3], NULL, 10);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;gpu_utilization=C2=A0 =C2=A0 =3D (int)=
g_ascii_strtoll(f[4], NULL, 10);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;memory_utilization =3D (int)g_ascii_st=
rtoll(f[5], NULL, 10);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;memory_total=C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D (int)g_ascii_strtoll(f[6], NULL, 10);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;memory_free=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =3D (int)g_ascii_strtoll(f[7], NULL, 10);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;memory_used=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =3D (int)g_ascii_strtoll(f[8], NULL, 10);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPI_LIST_APPEND(tail, gpu);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_strfreev(f);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 g_strfreev(lines);<br>
+<br>
+=C2=A0 =C2=A0 return head;<br>
+}<br>
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
index c57bc9a02f..8abbf71131 100644<br>
--- a/qga/qapi-schema.json<br>
+++ b/qga/qapi-schema.json<br>
@@ -1876,6 +1876,65 @@<br>
=C2=A0 =C2=A0&#39;if&#39;: { &#39;any&#39;: [&#39;CONFIG_WIN32&#39;, &#39;C=
ONFIG_GETLOADAVG&#39;] }<br>
=C2=A0}<br>
<br>
+##<br>
+# @GuestNvidiaGpu:<br>
+#<br>
+# Information about a single NVIDIA GPU as reported by nvidia-smi.<br>
+#<br>
+# @index: GPU index (0-based), stable across reboots for a given<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hardware slot<br>
+#<br>
+# @name: GPU product name (e.g. &quot;NVIDIA A100-SXM4-80GB&quot;)<br>
+#<br>
+# @driver-version: version string of the installed NVIDIA driver<br>
+#<br>
+# @temperature: GPU die temperature in degrees Celsius<br>
+#<br>
+# @gpu-utilization: GPU compute engine utilization in percent (0-100)<br>
+#<br>
+# @memory-utilization: GPU memory controller utilization in percent<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (0-100)<br>
+#<br>
+# @memory-total: total framebuffer memory in MiB<br>
+#<br>
+# @memory-free: free framebuffer memory in MiB<br>
+#<br>
+# @memory-used: used framebuffer memory in MiB<br>
+#<br>
+# Since: 10.1<br>
+##<br>
+{ &#39;struct&#39;: &#39;GuestNvidiaGpu&#39;,<br>
+=C2=A0 &#39;data&#39;: {<br>
+=C2=A0 =C2=A0 =C2=A0 &#39;index&#39;:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &#39;int&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 &#39;name&#39;:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;str&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 &#39;driver-version&#39;:=C2=A0 =C2=A0 =C2=A0&#39;str=
&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 &#39;temperature&#39;:=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#3=
9;int&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 &#39;gpu-utilization&#39;:=C2=A0 =C2=A0 &#39;int&#39;=
,<br>
+=C2=A0 =C2=A0 =C2=A0 &#39;memory-utilization&#39;: &#39;int&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 &#39;memory-total&#39;:=C2=A0 =C2=A0 =C2=A0 =C2=A0&#3=
9;int&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 &#39;memory-free&#39;:=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#3=
9;int&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 &#39;memory-used&#39;:=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#3=
9;int&#39;<br>
+=C2=A0 }<br>
+}<br>
+<br>
+##<br>
+# @guest-get-nvidia-smi:<br>
+#<br>
+# Query NVIDIA GPU information via nvidia-smi inside the guest.<br>
+#<br>
+# Returns one @GuestNvidiaGpu entry per physical GPU (or MIG instance)<br>
+# detected by the NVIDIA driver.<br>
+#<br>
+# Errors:<br>
+#=C2=A0 =C2=A0- If nvidia-smi is not installed or not found in $PATH<br>
+#=C2=A0 =C2=A0- If nvidia-smi exits with a non-zero status (e.g. no NVIDIA=
<br>
+#=C2=A0 =C2=A0 =C2=A0device)<br>
+#<br>
+# Since: 10.1<br>
+##<br>
+{ &#39;command&#39;: &#39;guest-get-nvidia-smi&#39;,<br>
+=C2=A0 &#39;returns&#39;: [&#39;GuestNvidiaGpu&#39;] }<br>
+<br>
=C2=A0##<br>
=C2=A0# @GuestNetworkRoute:<br>
=C2=A0#<br>
-- <br>
2.53.0<br>
<br>
</blockquote></div>

--0000000000001e413d064e5184d4--


