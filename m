Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64ABED3517A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 11:51:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7u63-00013z-Qi; Wed, 01 Apr 2026 07:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w7u60-00013U-20
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 07:50:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w7u5w-0000Ij-ON
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 07:50:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775044245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xOddCgU8dgTSj/vmtlSLIA5tiaKgTfo1teMKzYX0Ot0=;
 b=aQUv72Kv15bQVFfdSYQZgf4kflQSEe0aRjokpJkXHYa3WteEVnJJxlBG2FTTTH6I6l+6Sa
 4Ra1NKb17tTY2Sx2t5SZGGA65htwjuB7LQFYMxG04CVlUvKb5VoFUNL7l/n1uSDJ2UHzNK
 XReRanHLkWwCY20YDoDnpGrYpGLPefI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-14qY4rg4Ma2aBzWDEr0ukg-1; Wed, 01 Apr 2026 07:50:44 -0400
X-MC-Unique: 14qY4rg4Ma2aBzWDEr0ukg-1
X-Mimecast-MFC-AGG-ID: 14qY4rg4Ma2aBzWDEr0ukg_1775044243
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5094741c1c1so74710891cf.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 04:50:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775044243; cv=none;
 d=google.com; s=arc-20240605;
 b=hAHjX5QJtmu/VqYE9Po9vI7+VVI8WNDEualyIVfV3A7SXIB6edHqJ8k5ZjPHHps3Ig
 ciezSuoCFPsOXALMs4Tz3bvgffjVoU+qx78j6gM+bKgbH9a7jBal8+Zs94+KOtH+GS/p
 f4x7jTWkBBZXWxM9uxaDCibePlGQSgF0BGywaduklzbQWQukNv4/1y+5RYDfwsNiog9/
 ZHiV2iIavgmyjZeQL92y28uzTbv5UxtmNCIjz/nnAafMDjqjf2JGslcja+IxPsLP7mBv
 vMWatV/NJyX41qAJtJ8lBMU8eEM0dwrPq9yPPCk68bTAGvBDythcbqYaqnreEn46yZ/+
 1zoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xOddCgU8dgTSj/vmtlSLIA5tiaKgTfo1teMKzYX0Ot0=;
 fh=B+mGBAfrnUP1mzEcNChPQnCD0uylCPmYyVuhro1dP0A=;
 b=NIcZ27q+C3kjkcirqIRfWLwUopxIkoD/qHfRjnI63oKO6wjkEIOpv+HFRzqNeDZ3M+
 Itl14hHSaoEC1Afj+q1X4KVCosvy03AweCRPYIZyUku6lwRc1PFRhD3jIUAJA3w6IDbl
 psxQDdhGsKEw0UzwbBOFXeuUgBSEFdkZEtZFVrQyvqamVd8y4loZ1bZdorOvmFGHpNDD
 y0eiGj0pu8sedcQ3BoCI/S1nFH+T/bCvblMbWpwAAOuU2SkMCkNeR+HWHalYNV56kRaQ
 /CRtDgHFEqcNtr6JxPJQe+7IOQnBliL/50GgfKHHLAMUkBRftfre3o8V4UxYmVXqY1zT
 2xPg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775044243; x=1775649043; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xOddCgU8dgTSj/vmtlSLIA5tiaKgTfo1teMKzYX0Ot0=;
 b=nGFlPsDc6b6tPDT6ndrlxpQGf687VF/5fxrGRbTxr7hczUQcBnr9HLJriJKv5Z6s7L
 omAHW22c3v1TbWbSdUgE8cm7sW0zcfIRPUlLNLtEH8o/w+T5HUK2EMCVdaRcDH+KcuHI
 LZWHiccFGjlLvg81OqAk0dL2g0z73CFtDftmfoUBb4PXvAf0LgZT0a2sH6YFxOn9eGwq
 fHihG7IqWKTnpqsZCxR1NEF+Vj52pHN9al08Wmk4tqRJ/TBGlvag+Rxt9O1gcNLoFAWx
 5gLBKXXP3jMcyM5pL0yw4SklOxhjNhxCenx902nE7m9pfe3jeupIKVpj6u1F3Jyidj6A
 0pwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775044243; x=1775649043;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xOddCgU8dgTSj/vmtlSLIA5tiaKgTfo1teMKzYX0Ot0=;
 b=m0ZazZvEFD8Qs2yYym5CTSdBeQU6JkMgT+4wrycftr3GJMI+Jx8mTf6vVE6OJUnH7W
 0nGCJXVjFR2gpmoLkp5DUfHkemw7o2B3fSokeC+bGuYHz30CmuaTLlVUO9UIDoqwR3tI
 Nctfml2k8ULiNSJ2P+nugqtzH/jDQi6pbSVphevFOfEPIDjieV3eoEleKSgajQ3IE2Rb
 CjzZN5bSsJwrB3gPXWqEqd/1OKqUcDEyrj3TbWxryi4prhudx8b/uY1VG8mXdCDskkEa
 fYcYbxHf+QErVSu5brOWoyGcczddP+mx/ln73rQWvPAP2hEcv3n62YaEUeaCXp5uJghT
 zrxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjSP5jB1f97h1eYgMkEVFdN0J/uKOSkbitMDhpKNSkbTiaFKa5RMXpc53P2QUMGSPydPFpPtuCK+aT@nongnu.org
X-Gm-Message-State: AOJu0YxRCPlxUfmshkT43QhwOqrd8Dexen2gMnPlIDH3kBMi1whgxkzU
 xkW7Bpl+MzHARdna83psg6zSTDkDNqWTtT9sAhxpqKW3+RQv+QlASemH7pPdU1PhkIyPD7Q5uC+
 Nof27vcllZf/3iEPscVH5JQ0DcYTPYoYmVSv01GNg1yQqYFuRc1lV3azHu/uZn5oCeakQ1ALxrW
 7k078TfpxJVyabrQJw1treGyvyfgNVVQ4=
X-Gm-Gg: ATEYQzxWKEB6INwnM0JOzAU68gIZMthcbVsiBQS6efns/9Auz8eZYXtywUUhYAfD4H1
 cOIX6fPZ5z3paCCwOTOpL79GUqNOtJKw/Hz21KuZlEsD1tQi6aBR6wfU8nOqWGHBDQxPAfEddZr
 Y5DfIjP9HgYzyLd8UDe0ZTBV6YYXqlbs8uBIAWut6n+HT6R/SOwUvr0A9b0hhHK98Abc+D+sNWi
 56OaiUY
X-Received: by 2002:a05:622a:1791:b0:50b:526c:541c with SMTP id
 d75a77b69052e-50d3bdcc8admr45563731cf.50.1775044243426; 
 Wed, 01 Apr 2026 04:50:43 -0700 (PDT)
X-Received: by 2002:a05:622a:1791:b0:50b:526c:541c with SMTP id
 d75a77b69052e-50d3bdcc8admr45563331cf.50.1775044242896; Wed, 01 Apr 2026
 04:50:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260331110135.92883-1-machadovilaca@gmail.com>
 <871pgy3otf.fsf@pond.sub.org>
In-Reply-To: <871pgy3otf.fsf@pond.sub.org>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Wed, 1 Apr 2026 14:50:31 +0300
X-Gm-Features: AQROBzB5Wjcu9KXcwUJXm_05O273Im6mn7ik3-VjMmQTQKgeFORjZLekxPM1QeU
Message-ID: <CAPMcbCpE3mGRhRBoMUqU7rW8jX0xv0zHSvyK+FMemAg5BNQqJg@mail.gmail.com>
Subject: Re: [PATCH] qga: implement 'guest-get-nvidia-smi' command
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?B?Sm/Do28gVmlsYcOnYQ==?= <machadovilaca@gmail.com>, 
 qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000008f0ed7064e64b135"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
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

--0000000000008f0ed7064e64b135
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 2:25=E2=80=AFPM Markus Armbruster <armbru@redhat.com=
> wrote:

> You neglected to cc: me.  We recommend to use scripts/get_maintainer.pl
> to find all the maintainers, then use common sense to trim.
>
> Jo=C3=A3o Vila=C3=A7a <machadovilaca@gmail.com> writes:
>
> The commit message needs to explain why and how the patch is useful.
>
> For a patch adding a command to qemu-ga, like this one, it needs to
> state the command's anticipated use cases.
>
> > ---
> >  qga/commands-posix.c | 64 ++++++++++++++++++++++++++++++++++++++++++++
> >  qga/commands-win32.c | 64 ++++++++++++++++++++++++++++++++++++++++++++
> >  qga/qapi-schema.json | 59 ++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 187 insertions(+)
> >
> > diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> > index 837be51c40..631a8a9ee6 100644
> > --- a/qga/commands-posix.c
> > +++ b/qga/commands-posix.c
> > @@ -1415,3 +1415,67 @@ GuestLoadAverage *qmp_guest_get_load(Error **err=
p)
> >      return ret;
> >  }
> >  #endif
> > +
> > +GuestNvidiaGpuList *qmp_guest_get_nvidia_smi(Error **errp)
> > +{
> > +    const gchar *argv[] =3D {
> > +        "nvidia-smi",
> > +        "--query-gpu=3Dindex,name,driver_version,"
> > +            "temperature.gpu,utilization.gpu,utilization.memory,"
> > +            "memory.total,memory.free,memory.used",
> > +        "--format=3Dcsv,noheader,nounits",
> > +        NULL
> > +    };
> > +    g_autofree gchar *stdout_buf =3D NULL;
> > +    g_autofree gchar *stderr_buf =3D NULL;
> > +    gint exit_status;
> > +    GError *gerr =3D NULL;
> > +    GuestNvidiaGpuList *head =3D NULL, **tail =3D &head;
> > +
> > +    if (!g_spawn_sync(NULL, (gchar **)argv, NULL,
> > +                      G_SPAWN_SEARCH_PATH,
> > +                      NULL, NULL,
> > +                      &stdout_buf, &stderr_buf,
> > +                      &exit_status, &gerr)) {
>
> Why not ga_run_command()?  Hmm, it throws away the command's output on
> success.
>
> Kostiantyn, should ga_run_command() be rewritten on top of
> g_spawn_sync()?
>

The idea of ga_run_command was different.
Now, we can improve it if we see new use cases.


>
> > +        error_setg(errp, "failed to run nvidia-smi: %s", gerr->message=
);
> > +        g_error_free(gerr);
> > +        return NULL;
> > +    }
> > +
> > +    if (exit_status !=3D 0) {
> > +        error_setg(errp, "nvidia-smi failed (exit %d): %s",
> > +                   exit_status, stderr_buf ? stderr_buf : "unknown
> error");
>
> This is wrong if @stderr_buf can contain newlines.  qapi/error.h:
>
>  * The resulting message should be a single phrase, with no newline or
>  * trailing punctuation.
>
> However, there's similar misuse elsewhere in this file.  Oh well, carry
> on.
>
> > +        return NULL;
> > +    }
> > +
>
> I figure the command's output is some form of CSV.  Can you point to its
> documentation?
>
> > +    gchar **lines =3D g_strsplit(stdout_buf, "\n", -1);
> > +    for (int i =3D 0; lines[i] !=3D NULL; i++) {
> > +        gchar *line =3D g_strstrip(lines[i]);
> > +        if (*line =3D=3D '\0') {
> > +            continue;
>
> Silently ignore empty lines.  Okay.
>
> > +        }
> > +
> > +        gchar **f =3D g_strsplit(line, ", ", 9);
>
> If the line has more than 9 values, they are squashed into the last one.
>
> > +        if (g_strv_length(f) < 9) {
> > +            g_strfreev(f);
> > +            continue;
>
> Silently ignore lines with less than 9 values.
>
> > +        }
> > +
> > +        GuestNvidiaGpu *gpu     =3D g_new0(GuestNvidiaGpu, 1);
> > +        gpu->index              =3D (int)g_ascii_strtoll(f[0], NULL, 1=
0);
>
> If the value doesn't parse as decimal signed integer, we silently assume
> zero.
>
> If it parses, we silently ignore any text following it.
>
> If it parses a value outside 64 bit signed range, we silently assume its
> largest or smallest value.
>
> > +        gpu->name               =3D g_strdup(g_strstrip(f[1]));
> > +        gpu->driver_version     =3D g_strdup(g_strstrip(f[2]));
> > +        gpu->temperature        =3D (int)g_ascii_strtoll(f[3], NULL, 1=
0);
> > +        gpu->gpu_utilization    =3D (int)g_ascii_strtoll(f[4], NULL, 1=
0);
> > +        gpu->memory_utilization =3D (int)g_ascii_strtoll(f[5], NULL, 1=
0);
> > +        gpu->memory_total       =3D (int)g_ascii_strtoll(f[6], NULL, 1=
0);
> > +        gpu->memory_free        =3D (int)g_ascii_strtoll(f[7], NULL, 1=
0);
> > +        gpu->memory_used        =3D (int)g_ascii_strtoll(f[8], NULL, 1=
0);
> > +
> > +        QAPI_LIST_APPEND(tail, gpu);
> > +        g_strfreev(f);
> > +    }
> > +    g_strfreev(lines);
>
> Are you *sure* this is robust enough?
>
> Please consider a bog-standard LL(1) parser.
>
> > +
> > +    return head;
> > +}
> > diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> > index c0bf3467bd..a78d5b71f5 100644
> > --- a/qga/commands-win32.c
> > +++ b/qga/commands-win32.c
> > @@ -2764,3 +2764,67 @@ GuestNetworkRouteList
> *qmp_guest_network_get_route(Error **errp)
> >      g_hash_table_destroy(interface_metric_cache);
> >      return head;
> >  }
> > +
> > +GuestNvidiaGpuList *qmp_guest_get_nvidia_smi(Error **errp)
> > +{
> > +    const gchar *argv[] =3D {
> > +        "nvidia-smi",
> > +        "--query-gpu=3Dindex,name,driver_version,"
> > +            "temperature.gpu,utilization.gpu,utilization.memory,"
> > +            "memory.total,memory.free,memory.used",
> > +        "--format=3Dcsv,noheader,nounits",
> > +        NULL
> > +    };
> > +    g_autofree gchar *stdout_buf =3D NULL;
> > +    g_autofree gchar *stderr_buf =3D NULL;
> > +    gint exit_status;
> > +    GError *gerr =3D NULL;
> > +    GuestNvidiaGpuList *head =3D NULL, **tail =3D &head;
> > +
> > +    if (!g_spawn_sync(NULL, (gchar **)argv, NULL,
> > +                      G_SPAWN_SEARCH_PATH,
> > +                      NULL, NULL,
> > +                      &stdout_buf, &stderr_buf,
> > +                      &exit_status, &gerr)) {
> > +        error_setg(errp, "failed to run nvidia-smi: %s", gerr->message=
);
> > +        g_error_free(gerr);
> > +        return NULL;
> > +    }
> > +
> > +    if (exit_status !=3D 0) {
> > +        error_setg(errp, "nvidia-smi failed (exit %d): %s",
> > +                   exit_status, stderr_buf ? stderr_buf : "unknown
> error");
> > +        return NULL;
> > +    }
> > +
> > +    gchar **lines =3D g_strsplit(stdout_buf, "\n", -1);
> > +    for (int i =3D 0; lines[i] !=3D NULL; i++) {
> > +        gchar *line =3D g_strstrip(lines[i]);
> > +        if (*line =3D=3D '\0') {
> > +            continue;
> > +        }
> > +
> > +        gchar **f =3D g_strsplit(line, ", ", 9);
> > +        if (g_strv_length(f) < 9) {
> > +            g_strfreev(f);
> > +            continue;
> > +        }
> > +
> > +        GuestNvidiaGpu *gpu     =3D g_new0(GuestNvidiaGpu, 1);
> > +        gpu->index              =3D (int)g_ascii_strtoll(f[0], NULL, 1=
0);
> > +        gpu->name               =3D g_strdup(g_strstrip(f[1]));
> > +        gpu->driver_version     =3D g_strdup(g_strstrip(f[2]));
> > +        gpu->temperature        =3D (int)g_ascii_strtoll(f[3], NULL, 1=
0);
> > +        gpu->gpu_utilization    =3D (int)g_ascii_strtoll(f[4], NULL, 1=
0);
> > +        gpu->memory_utilization =3D (int)g_ascii_strtoll(f[5], NULL, 1=
0);
> > +        gpu->memory_total       =3D (int)g_ascii_strtoll(f[6], NULL, 1=
0);
> > +        gpu->memory_free        =3D (int)g_ascii_strtoll(f[7], NULL, 1=
0);
> > +        gpu->memory_used        =3D (int)g_ascii_strtoll(f[8], NULL, 1=
0);
> > +
> > +        QAPI_LIST_APPEND(tail, gpu);
> > +        g_strfreev(f);
> > +    }
> > +    g_strfreev(lines);
> > +
> > +    return head;
> > +}
>
> Duplicates the output parser.  Can you avoid that?
>

There is an open question of who should be looking for the nvidia-smi
command?
In the case of Windows, we definitely know that nvidia-smi will be in
Program Files or
in the DriverStore, so it will be missing in PATH by default.
If QGA should use this knowledge, then the Windows part will be different
(except for the parsing logic)
because we will be looking for nvidia-smi path. If no, and the user must
update PATH manually,
then this can be moved to commands.c


>
> > diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> > index c57bc9a02f..8abbf71131 100644
> > --- a/qga/qapi-schema.json
> > +++ b/qga/qapi-schema.json
> > @@ -1876,6 +1876,65 @@
> >    'if': { 'any': ['CONFIG_WIN32', 'CONFIG_GETLOADAVG'] }
> >  }
> >
> > +##
> > +# @GuestNvidiaGpu:
> > +#
> > +# Information about a single NVIDIA GPU as reported by nvidia-smi.
> > +#
> > +# @index: GPU index (0-based), stable across reboots for a given
> > +#         hardware slot
>
> Please format like
>
>    # @index: GPU index (0-based), stable across reboots for a given
>    #     hardware slot
>
> > +#
> > +# @name: GPU product name (e.g. "NVIDIA A100-SXM4-80GB")
> > +#
> > +# @driver-version: version string of the installed NVIDIA driver
> > +#
> > +# @temperature: GPU die temperature in degrees Celsius
> > +#
> > +# @gpu-utilization: GPU compute engine utilization in percent (0-100)
>
> (0-100) feels redundant.
>
> > +#
> > +# @memory-utilization: GPU memory controller utilization in percent
> > +#                      (0-100)
>
> Likewise.
>
> > +#
> > +# @memory-total: total framebuffer memory in MiB
> > +#
> > +# @memory-free: free framebuffer memory in MiB
> > +#
> > +# @memory-used: used framebuffer memory in MiB
> > +#
> > +# Since: 10.1
>
> 11.1 most likely.
>
> > +##
> > +{ 'struct': 'GuestNvidiaGpu',
> > +  'data': {
> > +      'index':              'int',
> > +      'name':               'str',
> > +      'driver-version':     'str',
> > +      'temperature':        'int',
> > +      'gpu-utilization':    'int',
> > +      'memory-utilization': 'int',
> > +      'memory-total':       'int',
> > +      'memory-free':        'int',
> > +      'memory-used':        'int'
> > +  }
> > +}
> > +
> > +##
> > +# @guest-get-nvidia-smi:
> > +#
> > +# Query NVIDIA GPU information via nvidia-smi inside the guest.
> > +#
> > +# Returns one @GuestNvidiaGpu entry per physical GPU (or MIG instance)
> > +# detected by the NVIDIA driver.
> > +#
> > +# Errors:
> > +#   - If nvidia-smi is not installed or not found in $PATH
> > +#   - If nvidia-smi exits with a non-zero status (e.g. no NVIDIA
> > +#     device)
>
> We commonly mention the error kind like this:
>
>    #   - If nvidia-smi is not installed or not found in $PATH,
>    #     GenericError
>    #   - If nvidia-smi exits with a non-zero status (e.g. no NVIDIA
>    #     device), GenericError
>
> > +#
> > +# Since: 10.1
> > +##
> > +{ 'command': 'guest-get-nvidia-smi',
> > +  'returns': ['GuestNvidiaGpu'] }
> > +
> >  ##
> >  # @GuestNetworkRoute:
> >  #
>
> Why not use existing guest-exec, and leave the parsing to the client?
>

I agree with Daniel that guest-exec is a command that should not exist.
For example, in RHEL/CentOS, this command is disabled by default, and
we recommend using SSH over VSock to run any command.
We have seen the problem several times with guest-exec. Also, we have an
upstream patch
for guest-exec + SELinux support to try to workaround a security issue.
Maybe we should discuss marking guest-exec as deprecated.

So, I agree with the author to add a separate command instead.

--0000000000008f0ed7064e64b135
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><br clear=3D"all"></div><div><div di=
r=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><br></div></div></div>=
<br></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"=
ltr" class=3D"gmail_attr">On Wed, Apr 1, 2026 at 2:25=E2=80=AFPM Markus Arm=
bruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">You negle=
cted to cc: me.=C2=A0 We recommend to use scripts/<a href=3D"http://get_mai=
ntainer.pl" rel=3D"noreferrer" target=3D"_blank">get_maintainer.pl</a><br>
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

--0000000000008f0ed7064e64b135--


