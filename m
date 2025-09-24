Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC9D0CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 08:29:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1KrE-0005Op-GU; Wed, 24 Sep 2025 04:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1v1Kr6-0005Ks-Pv
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 04:28:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1v1Kqz-0005Ka-C2
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 04:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758702473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CCAhc/B1AY4wqqHUBgSWdd82VL58jdTBCGlP+lMYcE8=;
 b=OfYOnvDHx5uMiXMfW8FW95/dwcq+gWr+XORplhWt/1Y2hFUumf1GzN+CLLCF9DghabWKZd
 pTPzEvKLM69yK3+35zrxDnBEZqw1ZiWU5BI7ICJqYD2g4pkyu4NAD+/Cn69PLtmxYhkdBB
 rk05p9xKiKDuyHrK9zbXDf9lP1aL10U=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-KBaKYMBjM0WxgG5pI9bibQ-1; Wed, 24 Sep 2025 04:27:52 -0400
X-MC-Unique: KBaKYMBjM0WxgG5pI9bibQ-1
X-Mimecast-MFC-AGG-ID: KBaKYMBjM0WxgG5pI9bibQ_1758702471
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b5533921eb2so3029176a12.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 01:27:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758702471; x=1759307271;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CCAhc/B1AY4wqqHUBgSWdd82VL58jdTBCGlP+lMYcE8=;
 b=TlamsUApTICuUQMFhW3GUroEFWeZMBrtRksTky5kTZudVWCfVJO6mG/feZ9zg5KPH2
 0TqWpy12ANdJGPzvczuMNE2TMhXOOgwHuUCbpEam8FJTGlOhmbSf70qQ83Dd/p8sxgOA
 P22Yq+IiockvRKieQXkFgAxza05k0O6GNEcXIMV1DpeN8RLvxmp9QYQqiNRLcpfIG5Fv
 gfr94Q+MKNDzMN9kEBGZLYJW9NCvyPIkNupZDRt1YWzXneXucYQN0ubMxzSx2Ilps+J4
 gPxJNFz/eqbg1wAM4A5Mdx5hmkv2Cuhq4pcX7Kj5GkL3MkU67GnTECEe7B3ADpwrOC+Q
 VMug==
X-Gm-Message-State: AOJu0Yxw+98UEcYPjJD95vwD5OzZ8oJqxOsNDkJWJl5lIfBHfvMfAeAK
 K4rL24AKHtetEj3tF4EOmLSkbZ+XLjo66kMtaKJ40vRtgpiF5svYpHJxIYsmIvXeEAtUggtU9ah
 tb0tbYAn1FJGIZoSWz6d22A+miWxBnlJ8QYAEz/M54fpdgNeSwjH2O2DW3bb+uVz1df6Xoh2H5K
 Cm5u1/P4E8870S9CotID4OQSPVOD2CNGg=
X-Gm-Gg: ASbGncvwI8cjtgR6NPcSIqqfbTdbHF08PjUTAiQfW3OZfERrDp45MAv2qO+dlRMSeIJ
 EhCkxq1RH5t2JZyojc7fITL5XCKWQLAp1EB8eJwnt6T7nJqnPPSayFNW96TqYgyfCVxG0yBkHu4
 0guEQmDyJhmtknpbQ4yM+v9foCcy4=
X-Received: by 2002:a17:90b:5650:b0:32b:bac7:5a41 with SMTP id
 98e67ed59e1d1-332a96ff67cmr6628890a91.37.1758702470761; 
 Wed, 24 Sep 2025 01:27:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJSkAPB6gTZ0RLdhxwqTY/9xMBImXHfqJ92KuX2svc/aWddoZpo2YCzIOtmEskWz7v6I38RgxYxKWBaGMHsbI=
X-Received: by 2002:a17:90b:5650:b0:32b:bac7:5a41 with SMTP id
 98e67ed59e1d1-332a96ff67cmr6628870a91.37.1758702470320; Wed, 24 Sep 2025
 01:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250911123656.413160-1-nikolai.barybin@virtuozzo.com>
 <20250911123656.413160-3-nikolai.barybin@virtuozzo.com>
In-Reply-To: <20250911123656.413160-3-nikolai.barybin@virtuozzo.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 24 Sep 2025 12:27:38 +0400
X-Gm-Features: AS18NWDiRVGhJz3GHFvQQrMA_IY_uSi9jqwIGGh2GiVnuo92yKxeue-VCQZieiY
Message-ID: <CAMxuvaysfdUSQyuzPpXMLRRxKsHjkjYV48S8L_HSWtWmn4ysXA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] dump: enhance win_dump_available to report properly
To: Nikolai Barybin <nikolai.barybin@virtuozzo.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 "Denis V . Lunev" <den@virtuozzo.com>, Ani Sinha <anisinha@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000026a2a063f87d4b5"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000026a2a063f87d4b5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Sep 11, 2025 at 4:37=E2=80=AFPM Nikolai Barybin <
nikolai.barybin@virtuozzo.com> wrote:

> QMP query-dump-guest-memory-capability reports win dump as available for
> any x86 VM, which is false.
>
> This patch implements proper query of vmcoreinfo and calculation of
> guest note size. Based on that we can surely report whether win dump
> available or not.
>
> To perform this I suggest to split dump_init() into dump_preinit() and
> dump_init_complete() to avoid exausting copypaste in
> win_dump_available().
>
> For further reference one may review this libvirt discussion:
>
> https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/thread/HJ=
3JRLWLGN3IKIC22OQ3PMZ4J3EFG5XB/#HJ3JRLWLGN3IKIC22OQ3PMZ4J3EFG5XB
> [PATCH 0/4] Allow xml-configured coredump format on VM crash
>
> Signed-off-by: Nikolai Barybin <nikolai.barybin@virtuozzo.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>

Could we split the patch for the generic dump refactoring and then the
windows specifics?


> ---
>  dump/dump.c     | 129 +++++++++++++++++++++++++++---------------------
>  dump/win_dump.c |  23 +++++++--
>  dump/win_dump.h |   2 +-
>  3 files changed, 95 insertions(+), 59 deletions(-)
>
> diff --git a/dump/dump.c b/dump/dump.c
> index b2f7ea7abd..ce8b43f819 100644
> --- a/dump/dump.c
> +++ b/dump/dump.c
> @@ -1780,10 +1780,7 @@ static void vmcoreinfo_update_phys_base(DumpState
> *s)
>      g_strfreev(lines);
>  }
>
> -static void dump_init(DumpState *s, int fd, bool has_format,
> -                      DumpGuestMemoryFormat format, bool paging, bool
> has_filter,
> -                      int64_t begin, int64_t length, bool kdump_raw,
> -                      Error **errp)
> +static void dump_preinit(DumpState *s, Error **errp)
>  {
>      ERRP_GUARD();
>      VMCoreInfoState *vmci =3D vmcoreinfo_find();
> @@ -1791,16 +1788,6 @@ static void dump_init(DumpState *s, int fd, bool
> has_format,
>      int nr_cpus;
>      int ret;
>
> -    s->has_format =3D has_format;
> -    s->format =3D format;
> -    s->written_size =3D 0;
> -    s->kdump_raw =3D kdump_raw;
> -
> -    /* kdump-compressed is conflict with paging and filter */
> -    if (has_format && format !=3D DUMP_GUEST_MEMORY_FORMAT_ELF) {
> -        assert(!paging && !has_filter);
> -    }
> -
>      if (runstate_is_running()) {
>          vm_stop(RUN_STATE_SAVE_VM);
>          s->resume =3D true;
> @@ -1817,41 +1804,10 @@ static void dump_init(DumpState *s, int fd, bool
> has_format,
>          nr_cpus++;
>      }
>
> -    s->fd =3D fd;
> -    if (has_filter && !length) {
> -        error_setg(errp, "parameter 'length' expects a non-zero size");
> -        goto cleanup;
> -    }
> -    s->filter_area_begin =3D begin;
> -    s->filter_area_length =3D length;
> -
> -    /* First index is 0, it's the special null name */
> -    s->string_table_buf =3D g_array_new(FALSE, TRUE, 1);
> -    /*
> -     * Allocate the null name, due to the clearing option set to true
> -     * it will be 0.
> -     */
> -    g_array_set_size(s->string_table_buf, 1);
> -
>      memory_mapping_list_init(&s->list);
> -
>      guest_phys_blocks_init(&s->guest_phys_blocks);
>      guest_phys_blocks_append(&s->guest_phys_blocks);
> -    s->total_size =3D dump_calculate_size(s);
> -#ifdef DEBUG_DUMP_GUEST_MEMORY
> -    fprintf(stderr, "DUMP: total memory to dump: %lu\n", s->total_size);
> -#endif
>
> -    /* it does not make sense to dump non-existent memory */
> -    if (!s->total_size) {
> -        error_setg(errp, "dump: no guest memory to dump");
> -        goto cleanup;
> -    }
> -
> -    /* get dump info: endian, class and architecture.
> -     * If the target architecture is not supported, cpu_get_dump_info()
> will
> -     * return -1.
> -     */
>

Why drop that comment?


>      ret =3D cpu_get_dump_info(&s->dump_info, &s->guest_phys_blocks);
>      if (ret < 0) {
>          error_setg(errp,
> @@ -1909,6 +1865,56 @@ static void dump_init(DumpState *s, int fd, bool
> has_format,
>          }
>      }
>
> +    s->nr_cpus =3D nr_cpus;
> +    return;
> +cleanup:
> +    dump_cleanup(s);
>

Is it intentional and safe to call dump_cleanup() two times from
qmp_query_dump_guest_memory_capability()? Maybe it should only be called by
the one who allocated/init it, and thus dropped from this function.


> +}
> +
> +static void dump_init_complete(DumpState *s, int fd, bool has_format,
> +                               DumpGuestMemoryFormat format, bool paging=
,
> +                               bool has_filter, int64_t begin, int64_t
> length,
> +                               bool kdump_raw, Error **errp)
> +{
> +    ERRP_GUARD();
> +
> +    s->has_format =3D has_format;
> +    s->format =3D format;
> +    s->written_size =3D 0;
> +    s->kdump_raw =3D kdump_raw;
> +
> +    /* kdump-compressed is conflict with paging and filter */
> +    if (has_format && format !=3D DUMP_GUEST_MEMORY_FORMAT_ELF) {
> +        assert(!paging && !has_filter);
> +    }
> +
> +    s->fd =3D fd;
> +    if (has_filter && !length) {
> +        error_setg(errp, "parameter 'length' expects a non-zero size");
> +        goto cleanup;
> +    }
> +    s->filter_area_begin =3D begin;
> +    s->filter_area_length =3D length;
> +
> +    /* First index is 0, it's the special null name */
> +    s->string_table_buf =3D g_array_new(FALSE, TRUE, 1);
> +    /*
> +     * Allocate the null name, due to the clearing option set to true
> +     * it will be 0.
> +     */
> +    g_array_set_size(s->string_table_buf, 1);
> +
> +    s->total_size =3D dump_calculate_size(s);
> +#ifdef DEBUG_DUMP_GUEST_MEMORY
> +    fprintf(stderr, "DUMP: total memory to dump: %lu\n", s->total_size);
> +#endif
> +
> +    /* it does not make sense to dump non-existent memory */
> +    if (!s->total_size) {
> +        error_setg(errp, "dump: no guest memory to dump");
> +        goto cleanup;
> +    }
> +
>      /* get memory mapping */
>      if (paging) {
>          qemu_get_guest_memory_mapping(&s->list, &s->guest_phys_blocks,
> errp);
> @@ -1919,8 +1925,6 @@ static void dump_init(DumpState *s, int fd, bool
> has_format,
>          qemu_get_guest_simple_memory_mapping(&s->list,
> &s->guest_phys_blocks);
>      }
>
> -    s->nr_cpus =3D nr_cpus;
> -
>      get_max_mapnr(s);
>
>      uint64_t tmp;
> @@ -2150,11 +2154,6 @@ void qmp_dump_guest_memory(bool paging, const char
> *protocol,
>      }
>  #endif
>
> -    if (has_format && format =3D=3D DUMP_GUEST_MEMORY_FORMAT_WIN_DMP
> -        && !win_dump_available(errp)) {
> -        return;
> -    }
> -
>      if (strstart(protocol, "fd:", &p)) {
>          fd =3D monitor_get_fd(monitor_cur(), p, errp);
>          if (fd =3D=3D -1) {
> @@ -2193,9 +2192,19 @@ void qmp_dump_guest_memory(bool paging, const char
> *protocol,
>
>
It may be worth adding an ERRP_GUARD since you check *errp.

Why not make dump_preinit() return a bool, true on success, like
recommended by error API docs?



>      s =3D &dump_state_global;
>      dump_state_prepare(s);
> +    dump_preinit(s, errp);
> +    if (*errp) {
> +        qatomic_set(&s->status, DUMP_STATUS_FAILED);
> +        return;
> +    }
> +
> +    if (has_format && format =3D=3D DUMP_GUEST_MEMORY_FORMAT_WIN_DMP
> +        && !win_dump_available(s, errp)) {
> +        return;
> +    }
>
> -    dump_init(s, fd, has_format, format, paging, has_begin,
> -              begin, length, kdump_raw, errp);
> +    dump_init_complete(s, fd, has_format, format, paging, has_begin,
> +                       begin, length, kdump_raw, errp);
>      if (*errp) {
>          qatomic_set(&s->status, DUMP_STATUS_FAILED);
>          return;
> @@ -2218,6 +2227,13 @@ DumpGuestMemoryCapability
> *qmp_query_dump_guest_memory_capability(Error **errp)
>                                    g_new0(DumpGuestMemoryCapability, 1);
>      DumpGuestMemoryFormatList **tail =3D &cap->formats;
>

Same for ERRP_GUARD


>
> +    DumpState *s =3D g_new0(DumpState, 1);
> +    dump_state_prepare(s);
> +    dump_preinit(s, errp);
> +    if (*errp) {
> +        goto cleanup;
> +    }
> +
>      /* elf is always available */
>      QAPI_LIST_APPEND(tail, DUMP_GUEST_MEMORY_FORMAT_ELF);
>
> @@ -2237,9 +2253,12 @@ DumpGuestMemoryCapability
> *qmp_query_dump_guest_memory_capability(Error **errp)
>      QAPI_LIST_APPEND(tail, DUMP_GUEST_MEMORY_FORMAT_KDUMP_RAW_SNAPPY);
>  #endif
>
> -    if (win_dump_available(NULL)) {
> +    if (win_dump_available(s, NULL)) {
>          QAPI_LIST_APPEND(tail, DUMP_GUEST_MEMORY_FORMAT_WIN_DMP);
>      }
>
> + cleanup:
> +    dump_cleanup(s);
> +    g_free(s);
>      return cap;
>  }
> diff --git a/dump/win_dump.c b/dump/win_dump.c
> index 3162e8bd48..d42427feb2 100644
> --- a/dump/win_dump.c
> +++ b/dump/win_dump.c
> @@ -20,8 +20,25 @@
>
>  #if defined(TARGET_X86_64)
>
> -bool win_dump_available(Error **errp)
> +static bool check_header(WinDumpHeader *h, bool *x64, Error **errp);
> +
> +bool win_dump_available(DumpState *s, Error **errp)
>  {
> +    WinDumpHeader *h =3D (void *)(s->guest_note +
> VMCOREINFO_ELF_NOTE_HDR_SIZE);
> +    Error *local_err =3D NULL;
> +    bool x64 =3D true;
> +
> +    if (s->guest_note_size !=3D VMCOREINFO_WIN_DUMP_NOTE_SIZE32 &&
> +            s->guest_note_size !=3D VMCOREINFO_WIN_DUMP_NOTE_SIZE64) {
> +        error_setg(errp, "win-dump: invalid vmcoreinfo note size");
> +        return false;
> +    }
> +
> +    if (!check_header(h, &x64, &local_err)) {
> +        error_propagate(errp, local_err);
> +        return false;
> +    }

+
>      return true;
>  }
>
> @@ -480,7 +497,7 @@ out_cr3:
>
>  #else /* !TARGET_X86_64 */
>
> -bool win_dump_available(Error **errp)
> +bool win_dump_available(DumpState *s, Error **errp)
>  {
>      error_setg(errp, "Windows dump is only available for x86-64");
>
> @@ -489,7 +506,7 @@ bool win_dump_available(Error **errp)
>
>  void create_win_dump(DumpState *s, Error **errp)
>  {
> -    win_dump_available(errp);
> +    win_dump_available(s, errp);
>  }
>
>  #endif
> diff --git a/dump/win_dump.h b/dump/win_dump.h
> index 9d6cfa47c5..62e19c2527 100644
> --- a/dump/win_dump.h
> +++ b/dump/win_dump.h
> @@ -14,7 +14,7 @@
>  #include "system/dump.h"
>
>  /* Check Windows dump availability for the current target */
> -bool win_dump_available(Error **errp);
> +bool win_dump_available(DumpState *s, Error **errp);
>
>  void create_win_dump(DumpState *s, Error **errp);
>
> --
> 2.43.5
>


Sadly we still don't have much testing for dump..

thanks

--000000000000026a2a063f87d4b5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 11, 2=
025 at 4:37=E2=80=AFPM Nikolai Barybin &lt;<a href=3D"mailto:nikolai.barybi=
n@virtuozzo.com">nikolai.barybin@virtuozzo.com</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">QMP query-dump-guest-memory-c=
apability reports win dump as available for<br>
any x86 VM, which is false.<br>
<br>
This patch implements proper query of vmcoreinfo and calculation of<br>
guest note size. Based on that we can surely report whether win dump<br>
available or not.<br>
<br>
To perform this I suggest to split dump_init() into dump_preinit() and<br>
dump_init_complete() to avoid exausting copypaste in<br>
win_dump_available().<br>
<br>
For further reference one may review this libvirt discussion:<br>
<a href=3D"https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/=
thread/HJ3JRLWLGN3IKIC22OQ3PMZ4J3EFG5XB/#HJ3JRLWLGN3IKIC22OQ3PMZ4J3EFG5XB" =
rel=3D"noreferrer" target=3D"_blank">https://lists.libvirt.org/archives/lis=
t/devel@lists.libvirt.org/thread/HJ3JRLWLGN3IKIC22OQ3PMZ4J3EFG5XB/#HJ3JRLWL=
GN3IKIC22OQ3PMZ4J3EFG5XB</a><br>
[PATCH 0/4] Allow xml-configured coredump format on VM crash<br>
<br>
Signed-off-by: Nikolai Barybin &lt;<a href=3D"mailto:nikolai.barybin@virtuo=
zzo.com" target=3D"_blank">nikolai.barybin@virtuozzo.com</a>&gt;<br>
Reviewed-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.=
com" target=3D"_blank">berrange@redhat.com</a>&gt;<br></blockquote><div><br=
></div><div>Could we split the patch for the generic dump refactoring and t=
hen the windows specifics?</div><div>=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
---<br>
=C2=A0dump/dump.c=C2=A0 =C2=A0 =C2=A0| 129 +++++++++++++++++++++++++++-----=
----------------<br>
=C2=A0dump/win_dump.c |=C2=A0 23 +++++++--<br>
=C2=A0dump/win_dump.h |=C2=A0 =C2=A02 +-<br>
=C2=A03 files changed, 95 insertions(+), 59 deletions(-)<br>
<br>
diff --git a/dump/dump.c b/dump/dump.c<br>
index b2f7ea7abd..ce8b43f819 100644<br>
--- a/dump/dump.c<br>
+++ b/dump/dump.c<br>
@@ -1780,10 +1780,7 @@ static void vmcoreinfo_update_phys_base(DumpState *s=
)<br>
=C2=A0 =C2=A0 =C2=A0g_strfreev(lines);<br>
=C2=A0}<br>
<br>
-static void dump_init(DumpState *s, int fd, bool has_format,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 DumpGuestMemoryFormat format, bool paging, bool has_filter,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 int64_t begin, int64_t length, bool kdump_raw,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 Error **errp)<br>
+static void dump_preinit(DumpState *s, Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ERRP_GUARD();<br>
=C2=A0 =C2=A0 =C2=A0VMCoreInfoState *vmci =3D vmcoreinfo_find();<br>
@@ -1791,16 +1788,6 @@ static void dump_init(DumpState *s, int fd, bool has=
_format,<br>
=C2=A0 =C2=A0 =C2=A0int nr_cpus;<br>
=C2=A0 =C2=A0 =C2=A0int ret;<br>
<br>
-=C2=A0 =C2=A0 s-&gt;has_format =3D has_format;<br>
-=C2=A0 =C2=A0 s-&gt;format =3D format;<br>
-=C2=A0 =C2=A0 s-&gt;written_size =3D 0;<br>
-=C2=A0 =C2=A0 s-&gt;kdump_raw =3D kdump_raw;<br>
-<br>
-=C2=A0 =C2=A0 /* kdump-compressed is conflict with paging and filter */<br=
>
-=C2=A0 =C2=A0 if (has_format &amp;&amp; format !=3D DUMP_GUEST_MEMORY_FORM=
AT_ELF) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(!paging &amp;&amp; !has_filter);<br>
-=C2=A0 =C2=A0 }<br>
-<br>
=C2=A0 =C2=A0 =C2=A0if (runstate_is_running()) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vm_stop(RUN_STATE_SAVE_VM);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;resume =3D true;<br>
@@ -1817,41 +1804,10 @@ static void dump_init(DumpState *s, int fd, bool ha=
s_format,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nr_cpus++;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 s-&gt;fd =3D fd;<br>
-=C2=A0 =C2=A0 if (has_filter &amp;&amp; !length) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;parameter &#39;length&#=
39; expects a non-zero size&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 s-&gt;filter_area_begin =3D begin;<br>
-=C2=A0 =C2=A0 s-&gt;filter_area_length =3D length;<br>
-<br>
-=C2=A0 =C2=A0 /* First index is 0, it&#39;s the special null name */<br>
-=C2=A0 =C2=A0 s-&gt;string_table_buf =3D g_array_new(FALSE, TRUE, 1);<br>
-=C2=A0 =C2=A0 /*<br>
-=C2=A0 =C2=A0 =C2=A0* Allocate the null name, due to the clearing option s=
et to true<br>
-=C2=A0 =C2=A0 =C2=A0* it will be 0.<br>
-=C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 g_array_set_size(s-&gt;string_table_buf, 1);<br>
-<br>
=C2=A0 =C2=A0 =C2=A0memory_mapping_list_init(&amp;s-&gt;list);<br>
-<br>
=C2=A0 =C2=A0 =C2=A0guest_phys_blocks_init(&amp;s-&gt;guest_phys_blocks);<b=
r>
=C2=A0 =C2=A0 =C2=A0guest_phys_blocks_append(&amp;s-&gt;guest_phys_blocks);=
<br>
-=C2=A0 =C2=A0 s-&gt;total_size =3D dump_calculate_size(s);<br>
-#ifdef DEBUG_DUMP_GUEST_MEMORY<br>
-=C2=A0 =C2=A0 fprintf(stderr, &quot;DUMP: total memory to dump: %lu\n&quot=
;, s-&gt;total_size);<br>
-#endif<br>
<br>
-=C2=A0 =C2=A0 /* it does not make sense to dump non-existent memory */<br>
-=C2=A0 =C2=A0 if (!s-&gt;total_size) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;dump: no guest memory t=
o dump&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 /* get dump info: endian, class and architecture.<br>
-=C2=A0 =C2=A0 =C2=A0* If the target architecture is not supported, cpu_get=
_dump_info() will<br>
-=C2=A0 =C2=A0 =C2=A0* return -1.<br>
-=C2=A0 =C2=A0 =C2=A0*/<br></blockquote><div><br></div><div>Why drop that c=
omment?</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
=C2=A0 =C2=A0 =C2=A0ret =3D cpu_get_dump_info(&amp;s-&gt;dump_info, &amp;s-=
&gt;guest_phys_blocks);<br>
=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp,<br>
@@ -1909,6 +1865,56 @@ static void dump_init(DumpState *s, int fd, bool has=
_format,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 s-&gt;nr_cpus =3D nr_cpus;<br>
+=C2=A0 =C2=A0 return;<br>
+cleanup:<br>
+=C2=A0 =C2=A0 dump_cleanup(s);<br></blockquote><div><br></div><div>Is it i=
ntentional and safe to call dump_cleanup() two times from qmp_query_dump_gu=
est_memory_capability()? Maybe it should only be called by the one who allo=
cated/init it, and thus dropped from this function.</div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
+}<br>
+<br>
+static void dump_init_complete(DumpState *s, int fd, bool has_format,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DumpGuestMemoryFormat format, bool pa=
ging,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool has_filter, int64_t begin, int64=
_t length,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool kdump_raw, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 ERRP_GUARD();<br>
+<br>
+=C2=A0 =C2=A0 s-&gt;has_format =3D has_format;<br>
+=C2=A0 =C2=A0 s-&gt;format =3D format;<br>
+=C2=A0 =C2=A0 s-&gt;written_size =3D 0;<br>
+=C2=A0 =C2=A0 s-&gt;kdump_raw =3D kdump_raw;<br>
+<br>
+=C2=A0 =C2=A0 /* kdump-compressed is conflict with paging and filter */<br=
>
+=C2=A0 =C2=A0 if (has_format &amp;&amp; format !=3D DUMP_GUEST_MEMORY_FORM=
AT_ELF) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(!paging &amp;&amp; !has_filter);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 s-&gt;fd =3D fd;<br>
+=C2=A0 =C2=A0 if (has_filter &amp;&amp; !length) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;parameter &#39;length&#=
39; expects a non-zero size&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 s-&gt;filter_area_begin =3D begin;<br>
+=C2=A0 =C2=A0 s-&gt;filter_area_length =3D length;<br>
+<br>
+=C2=A0 =C2=A0 /* First index is 0, it&#39;s the special null name */<br>
+=C2=A0 =C2=A0 s-&gt;string_table_buf =3D g_array_new(FALSE, TRUE, 1);<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Allocate the null name, due to the clearing option s=
et to true<br>
+=C2=A0 =C2=A0 =C2=A0* it will be 0.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 g_array_set_size(s-&gt;string_table_buf, 1);<br>
+<br>
+=C2=A0 =C2=A0 s-&gt;total_size =3D dump_calculate_size(s);<br>
+#ifdef DEBUG_DUMP_GUEST_MEMORY<br>
+=C2=A0 =C2=A0 fprintf(stderr, &quot;DUMP: total memory to dump: %lu\n&quot=
;, s-&gt;total_size);<br>
+#endif<br>
+<br>
+=C2=A0 =C2=A0 /* it does not make sense to dump non-existent memory */<br>
+=C2=A0 =C2=A0 if (!s-&gt;total_size) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;dump: no guest memory t=
o dump&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0/* get memory mapping */<br>
=C2=A0 =C2=A0 =C2=A0if (paging) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_get_guest_memory_mapping(&amp;s-&gt;=
list, &amp;s-&gt;guest_phys_blocks, errp);<br>
@@ -1919,8 +1925,6 @@ static void dump_init(DumpState *s, int fd, bool has_=
format,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_get_guest_simple_memory_mapping(&amp=
;s-&gt;list, &amp;s-&gt;guest_phys_blocks);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 s-&gt;nr_cpus =3D nr_cpus;<br>
-<br>
=C2=A0 =C2=A0 =C2=A0get_max_mapnr(s);<br>
<br>
=C2=A0 =C2=A0 =C2=A0uint64_t tmp;<br>
@@ -2150,11 +2154,6 @@ void qmp_dump_guest_memory(bool paging, const char *=
protocol,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#endif<br>
<br>
-=C2=A0 =C2=A0 if (has_format &amp;&amp; format =3D=3D DUMP_GUEST_MEMORY_FO=
RMAT_WIN_DMP<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; !win_dump_available(errp)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
=C2=A0 =C2=A0 =C2=A0if (strstart(protocol, &quot;fd:&quot;, &amp;p)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D monitor_get_fd(monitor_cur(), p, e=
rrp);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fd =3D=3D -1) {<br>
@@ -2193,9 +2192,19 @@ void qmp_dump_guest_memory(bool paging, const char *=
protocol,<br>
<br></blockquote><div><div><br></div><div>It may be worth adding an ERRP_GU=
ARD since you check *errp.=C2=A0</div><div><br></div><div>Why not make dump=
_preinit() return a bool, true on success, like recommended by error API do=
cs?=C2=A0</div><div><br></div>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
=C2=A0 =C2=A0 =C2=A0s =3D &amp;dump_state_global;<br>
=C2=A0 =C2=A0 =C2=A0dump_state_prepare(s);<br>
+=C2=A0 =C2=A0 dump_preinit(s, errp);<br>
+=C2=A0 =C2=A0 if (*errp) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qatomic_set(&amp;s-&gt;status, DUMP_STATUS_FAI=
LED);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (has_format &amp;&amp; format =3D=3D DUMP_GUEST_MEMORY_FO=
RMAT_WIN_DMP<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; !win_dump_available(s, errp)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 dump_init(s, fd, has_format, format, paging, has_begin,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 begin, length, kdump_raw,=
 errp);<br>
+=C2=A0 =C2=A0 dump_init_complete(s, fd, has_format, format, paging, has_be=
gin,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0begin, length, kdump_raw, errp);<br>
=C2=A0 =C2=A0 =C2=A0if (*errp) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qatomic_set(&amp;s-&gt;status, DUMP_STATU=
S_FAILED);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
@@ -2218,6 +2227,13 @@ DumpGuestMemoryCapability *qmp_query_dump_guest_memo=
ry_capability(Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_new0(DumpGuestMemoryC=
apability, 1);<br>
=C2=A0 =C2=A0 =C2=A0DumpGuestMemoryFormatList **tail =3D &amp;cap-&gt;forma=
ts;<br></blockquote><div><br></div><div>Same for ERRP_GUARD</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
+=C2=A0 =C2=A0 DumpState *s =3D g_new0(DumpState, 1);<br>
+=C2=A0 =C2=A0 dump_state_prepare(s);<br>
+=C2=A0 =C2=A0 dump_preinit(s, errp);<br>
+=C2=A0 =C2=A0 if (*errp) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0/* elf is always available */<br>
=C2=A0 =C2=A0 =C2=A0QAPI_LIST_APPEND(tail, DUMP_GUEST_MEMORY_FORMAT_ELF);<b=
r>
<br>
@@ -2237,9 +2253,12 @@ DumpGuestMemoryCapability *qmp_query_dump_guest_memo=
ry_capability(Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0QAPI_LIST_APPEND(tail, DUMP_GUEST_MEMORY_FORMAT_KDUMP_R=
AW_SNAPPY);<br>
=C2=A0#endif<br>
<br>
-=C2=A0 =C2=A0 if (win_dump_available(NULL)) {<br>
+=C2=A0 =C2=A0 if (win_dump_available(s, NULL)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QAPI_LIST_APPEND(tail, DUMP_GUEST_MEMORY_=
FORMAT_WIN_DMP);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+ cleanup:<br>
+=C2=A0 =C2=A0 dump_cleanup(s);<br>
+=C2=A0 =C2=A0 g_free(s);<br>
=C2=A0 =C2=A0 =C2=A0return cap;<br>
=C2=A0}<br>
diff --git a/dump/win_dump.c b/dump/win_dump.c<br>
index 3162e8bd48..d42427feb2 100644<br>
--- a/dump/win_dump.c<br>
+++ b/dump/win_dump.c<br>
@@ -20,8 +20,25 @@<br>
<br>
=C2=A0#if defined(TARGET_X86_64)<br>
<br>
-bool win_dump_available(Error **errp)<br>
+static bool check_header(WinDumpHeader *h, bool *x64, Error **errp);<br>
+<br>
+bool win_dump_available(DumpState *s, Error **errp)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 WinDumpHeader *h =3D (void *)(s-&gt;guest_note + VMCOREINFO_=
ELF_NOTE_HDR_SIZE);<br>
+=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
+=C2=A0 =C2=A0 bool x64 =3D true;<br>
+<br>
+=C2=A0 =C2=A0 if (s-&gt;guest_note_size !=3D VMCOREINFO_WIN_DUMP_NOTE_SIZE=
32 &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;guest_note_size !=3D VMCOR=
EINFO_WIN_DUMP_NOTE_SIZE64) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;win-dump: invalid vmcor=
einfo note size&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (!check_header(h, &amp;x64, &amp;local_err)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
+<br>
=C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0}<br>
<br>
@@ -480,7 +497,7 @@ out_cr3:<br>
<br>
=C2=A0#else /* !TARGET_X86_64 */<br>
<br>
-bool win_dump_available(Error **errp)<br>
+bool win_dump_available(DumpState *s, Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;Windows dump is only available f=
or x86-64&quot;);<br>
<br>
@@ -489,7 +506,7 @@ bool win_dump_available(Error **errp)<br>
<br>
=C2=A0void create_win_dump(DumpState *s, Error **errp)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 win_dump_available(errp);<br>
+=C2=A0 =C2=A0 win_dump_available(s, errp);<br>
=C2=A0}<br>
<br>
=C2=A0#endif<br>
diff --git a/dump/win_dump.h b/dump/win_dump.h<br>
index 9d6cfa47c5..62e19c2527 100644<br>
--- a/dump/win_dump.h<br>
+++ b/dump/win_dump.h<br>
@@ -14,7 +14,7 @@<br>
=C2=A0#include &quot;system/dump.h&quot;<br>
<br>
=C2=A0/* Check Windows dump availability for the current target */<br>
-bool win_dump_available(Error **errp);<br>
+bool win_dump_available(DumpState *s, Error **errp);<br>
<br>
=C2=A0void create_win_dump(DumpState *s, Error **errp);<br>
<br>
-- <br>
2.43.5<br>
=C2=A0</blockquote><div><br></div>Sadly we still don&#39;t have much testin=
g for dump..</div><div class=3D"gmail_quote gmail_quote_container"><div><br=
></div><div>thanks=C2=A0</div></div></div>

--000000000000026a2a063f87d4b5--


