Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35DC2CD1296
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 11:16:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruVwD-0007i1-8V; Wed, 10 Apr 2024 07:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1ruVw5-0007ad-9J
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 07:16:14 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1ruVw3-0001Ac-2n
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 07:16:13 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-56e6a1edecfso3989843a12.1
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 04:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712747769; x=1713352569; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+IN7un69bqHkcPqreTU10boYRttPxsSWpC4RIALq0Tk=;
 b=SHhBf0sM2qZxdjPx8tfrEZCtrPXM+JGExdqUI+oHqRWwz5CJandFl8iNcIxcsePfJb
 8QCrKSxVgzpZRDaxLpkXrOQD/q3O70MHpPiU0/r3smSQ/qOi0yAhDG3UrU1q0CX+SdXX
 5OvN7zhhs8j3j36+LpAZrnEzcTK0aVKYrQKVgVzEDhyi/Tid+1kTeMjA8Lpa62bd+LL5
 OSiwXSrJ+xNKlQcp0Rdb+LPjO3kh4nAn8+eV68j+gcnigESoiHjrQayltAdutSyJQWeo
 GVlV605TFBbLk9tr5niC4QF48PYrLW6eSnsbKq1wqBshgT5kTF4u5MN2YVIhsP0YCkuJ
 k6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712747769; x=1713352569;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+IN7un69bqHkcPqreTU10boYRttPxsSWpC4RIALq0Tk=;
 b=TAxIn6PRlsDshYsPAYtDH1ZzsldDnkufMwSdkHJ3ceLCbx0/cvWI3FBThbO27W5k8g
 1swkoYYjWjAqoiYCSCrjqCbqMAirrbc/DYw8OvAcY9E15c76iJohYWwnnX/0Kch5DHmD
 n3PrZ+zQ+XAy9NEVbpczMrQux9HHsr1Bkq9Yzmfh6XU4/l4R9+y2K3H4rpCN5w5LOUxs
 020+JcdAqVCQ8ocNgZZ/19KPhHyhq9RvJy4/o/RUmeehbhHLLe/5WvXLiZaYFomXcQtP
 U4ZeaW86jA4fpRAcwL5Tfs/lYo2goIuyfDyKa49A7svwH19xMqmk8foRFuyg/v6x0+kD
 019Q==
X-Gm-Message-State: AOJu0YxaxW+jRItdAtJ6VedojFJaeV8qQwEUxyNl+AFo0xxInF707z6C
 6sb+B51uW87GCADEJB1hcbsSSjtdhxfdB0yBZ+ibcINOEiNAo9ltipjGcx+gs16dgEMzft9XShz
 BiSU2z3011Nnlz7Ubth79/iFxe9M=
X-Google-Smtp-Source: AGHT+IEW01CMFpOVcXIOi32Peel71hH36R4znipkhO//pqBD9Ikcs10QfxtQoTAD+2CiKEFtzpYGR32oXz94nkrl0e8=
X-Received: by 2002:a50:c313:0:b0:56e:447:1e44 with SMTP id
 a19-20020a50c313000000b0056e04471e44mr1631304edb.8.1712747768656; Wed, 10 Apr
 2024 04:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240227223501.28475-1-vikram.garhwal@amd.com>
 <20240227223501.28475-4-vikram.garhwal@amd.com>
In-Reply-To: <20240227223501.28475-4-vikram.garhwal@amd.com>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Wed, 10 Apr 2024 13:15:57 +0200
Message-ID: <CAJy5ezrmVBH1FD0oQy+hxmx5yymkp0EQr4-xO+F00M46yd7nkQ@mail.gmail.com>
Subject: Re: [QEMU][PATCH v3 3/7] softmmu: let qemu_map_ram_ptr() use
 qemu_ram_ptr_length()
To: Vikram Garhwal <vikram.garhwal@amd.com>
Cc: qemu-devel@nongnu.org, sstabellini@kernel.org, jgross@suse.com, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000573c170615bc2ad7"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x52e.google.com
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

--000000000000573c170615bc2ad7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 11:37=E2=80=AFPM Vikram Garhwal <vikram.garhwal@amd=
.com>
wrote:

> From: Juergen Gross <jgross@suse.com>
>
> qemu_map_ram_ptr() and qemu_ram_ptr_length() share quite some code, so
> modify qemu_ram_ptr_length() a little bit and use it for
> qemu_map_ram_ptr(), too.
>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
> Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>




> ---
>  system/physmem.c | 56 ++++++++++++++++++++----------------------------
>  1 file changed, 23 insertions(+), 33 deletions(-)
>
> diff --git a/system/physmem.c b/system/physmem.c
> index 84f3022099..949dcb20ba 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -2163,43 +2163,17 @@ void qemu_ram_remap(ram_addr_t addr, ram_addr_t
> length)
>  }
>  #endif /* !_WIN32 */
>
> -/* Return a host pointer to ram allocated with qemu_ram_alloc.
> - * This should not be used for general purpose DMA.  Use address_space_m=
ap
> - * or address_space_rw instead. For local memory (e.g. video ram) that t=
he
> - * device owns, use memory_region_get_ram_ptr.
> - *
> - * Called within RCU critical section.
> - */
> -void *qemu_map_ram_ptr(RAMBlock *block, ram_addr_t addr)
> -{
> -    if (block =3D=3D NULL) {
> -        block =3D qemu_get_ram_block(addr);
> -        addr -=3D block->offset;
> -    }
> -
> -    if (xen_enabled() && block->host =3D=3D NULL) {
> -        /* We need to check if the requested address is in the RAM
> -         * because we don't want to map the entire memory in QEMU.
> -         * In that case just map until the end of the page.
> -         */
> -        if (block->offset =3D=3D 0) {
> -            return xen_map_cache(addr, 0, 0, false);
> -        }
> -
> -        block->host =3D xen_map_cache(block->offset, block->max_length, =
1,
> false);
> -    }
> -    return ramblock_ptr(block, addr);
> -}
> -
> -/* Return a host pointer to guest's ram. Similar to qemu_map_ram_ptr
> - * but takes a size argument.
> +/*
> + * Return a host pointer to guest's ram.
>   *
>   * Called within RCU critical section.
>   */
>  static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
>                                   hwaddr *size, bool lock)
>  {
> -    if (*size =3D=3D 0) {
> +    hwaddr len =3D 0;
> +
> +    if (size && *size =3D=3D 0) {
>          return NULL;
>      }
>
> @@ -2207,7 +2181,10 @@ static void *qemu_ram_ptr_length(RAMBlock *block,
> ram_addr_t addr,
>          block =3D qemu_get_ram_block(addr);
>          addr -=3D block->offset;
>      }
> -    *size =3D MIN(*size, block->max_length - addr);
> +    if (size) {
> +        *size =3D MIN(*size, block->max_length - addr);
> +        len =3D *size;
> +    }
>
>      if (xen_enabled() && block->host =3D=3D NULL) {
>          /* We need to check if the requested address is in the RAM
> @@ -2215,7 +2192,7 @@ static void *qemu_ram_ptr_length(RAMBlock *block,
> ram_addr_t addr,
>           * In that case just map the requested area.
>           */
>          if (block->offset =3D=3D 0) {
> -            return xen_map_cache(addr, *size, lock, lock);
> +            return xen_map_cache(addr, len, lock, lock);
>          }
>
>          block->host =3D xen_map_cache(block->offset, block->max_length, =
1,
> lock);
> @@ -2224,6 +2201,19 @@ static void *qemu_ram_ptr_length(RAMBlock *block,
> ram_addr_t addr,
>      return ramblock_ptr(block, addr);
>  }
>
> +/*
> + * Return a host pointer to ram allocated with qemu_ram_alloc.
> + * This should not be used for general purpose DMA.  Use address_space_m=
ap
> + * or address_space_rw instead. For local memory (e.g. video ram) that t=
he
> + * device owns, use memory_region_get_ram_ptr.
> + *
> + * Called within RCU critical section.
> + */
> +void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr)
> +{
> +    return qemu_ram_ptr_length(ram_block, addr, NULL, false);
> +}
> +
>  /* Return the offset of a hostpointer within a ramblock */
>  ram_addr_t qemu_ram_block_host_offset(RAMBlock *rb, void *host)
>  {
> --
> 2.17.1
>
>
>

--000000000000573c170615bc2ad7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 27, 2024 at 11:37=E2=80=
=AFPM Vikram Garhwal &lt;<a href=3D"mailto:vikram.garhwal@amd.com">vikram.g=
arhwal@amd.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">From: Juergen Gross &lt;<a href=3D"mailto:jgross@suse.com" ta=
rget=3D"_blank">jgross@suse.com</a>&gt;<br>
<br>
qemu_map_ram_ptr() and qemu_ram_ptr_length() share quite some code, so<br>
modify qemu_ram_ptr_length() a little bit and use it for<br>
qemu_map_ram_ptr(), too.<br>
<br>
Signed-off-by: Juergen Gross &lt;<a href=3D"mailto:jgross@suse.com" target=
=3D"_blank">jgross@suse.com</a>&gt;<br>
Signed-off-by: Vikram Garhwal &lt;<a href=3D"mailto:vikram.garhwal@amd.com"=
 target=3D"_blank">vikram.garhwal@amd.com</a>&gt;<br>
Reviewed-by: Stefano Stabellini &lt;<a href=3D"mailto:sstabellini@kernel.or=
g" target=3D"_blank">sstabellini@kernel.org</a>&gt;<br></blockquote><div><b=
r></div><div>Reviewed-by: Edgar E. Iglesias &lt;<a href=3D"mailto:edgar.igl=
esias@amd.com">edgar.iglesias@amd.com</a>&gt;<br></div><div><br></div><div>=
<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
---<br>
=C2=A0system/physmem.c | 56 ++++++++++++++++++++---------------------------=
-<br>
=C2=A01 file changed, 23 insertions(+), 33 deletions(-)<br>
<br>
diff --git a/system/physmem.c b/system/physmem.c<br>
index 84f3022099..949dcb20ba 100644<br>
--- a/system/physmem.c<br>
+++ b/system/physmem.c<br>
@@ -2163,43 +2163,17 @@ void qemu_ram_remap(ram_addr_t addr, ram_addr_t len=
gth)<br>
=C2=A0}<br>
=C2=A0#endif /* !_WIN32 */<br>
<br>
-/* Return a host pointer to ram allocated with qemu_ram_alloc.<br>
- * This should not be used for general purpose DMA.=C2=A0 Use address_spac=
e_map<br>
- * or address_space_rw instead. For local memory (e.g. video ram) that the=
<br>
- * device owns, use memory_region_get_ram_ptr.<br>
- *<br>
- * Called within RCU critical section.<br>
- */<br>
-void *qemu_map_ram_ptr(RAMBlock *block, ram_addr_t addr)<br>
-{<br>
-=C2=A0 =C2=A0 if (block =3D=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 block =3D qemu_get_ram_block(addr);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 addr -=3D block-&gt;offset;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 if (xen_enabled() &amp;&amp; block-&gt;host =3D=3D NULL) {<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* We need to check if the requested address i=
s in the RAM<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* because we don&#39;t want to map the e=
ntire memory in QEMU.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* In that case just map until the end of=
 the page.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (block-&gt;offset =3D=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return xen_map_cache(addr, 0, 0,=
 false);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 block-&gt;host =3D xen_map_cache(block-&gt;off=
set, block-&gt;max_length, 1, false);<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 return ramblock_ptr(block, addr);<br>
-}<br>
-<br>
-/* Return a host pointer to guest&#39;s ram. Similar to qemu_map_ram_ptr<b=
r>
- * but takes a size argument.<br>
+/*<br>
+ * Return a host pointer to guest&#39;s ram.<br>
=C2=A0 *<br>
=C2=A0 * Called within RCU critical section.<br>
=C2=A0 */<br>
=C2=A0static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hwaddr *size, bool lock)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 if (*size =3D=3D 0) {<br>
+=C2=A0 =C2=A0 hwaddr len =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 if (size &amp;&amp; *size =3D=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -2207,7 +2181,10 @@ static void *qemu_ram_ptr_length(RAMBlock *block, ra=
m_addr_t addr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0block =3D qemu_get_ram_block(addr);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr -=3D block-&gt;offset;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 *size =3D MIN(*size, block-&gt;max_length - addr);<br>
+=C2=A0 =C2=A0 if (size) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *size =3D MIN(*size, block-&gt;max_length - ad=
dr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D *size;<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (xen_enabled() &amp;&amp; block-&gt;host =3D=3D NULL=
) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* We need to check if the requested addr=
ess is in the RAM<br>
@@ -2215,7 +2192,7 @@ static void *qemu_ram_ptr_length(RAMBlock *block, ram=
_addr_t addr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * In that case just map the requested ar=
ea.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (block-&gt;offset =3D=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return xen_map_cache(addr, *size=
, lock, lock);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return xen_map_cache(addr, len, =
lock, lock);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0block-&gt;host =3D xen_map_cache(block-&g=
t;offset, block-&gt;max_length, 1, lock);<br>
@@ -2224,6 +2201,19 @@ static void *qemu_ram_ptr_length(RAMBlock *block, ra=
m_addr_t addr,<br>
=C2=A0 =C2=A0 =C2=A0return ramblock_ptr(block, addr);<br>
=C2=A0}<br>
<br>
+/*<br>
+ * Return a host pointer to ram allocated with qemu_ram_alloc.<br>
+ * This should not be used for general purpose DMA.=C2=A0 Use address_spac=
e_map<br>
+ * or address_space_rw instead. For local memory (e.g. video ram) that the=
<br>
+ * device owns, use memory_region_get_ram_ptr.<br>
+ *<br>
+ * Called within RCU critical section.<br>
+ */<br>
+void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr)<br>
+{<br>
+=C2=A0 =C2=A0 return qemu_ram_ptr_length(ram_block, addr, NULL, false);<br=
>
+}<br>
+<br>
=C2=A0/* Return the offset of a hostpointer within a ramblock */<br>
=C2=A0ram_addr_t qemu_ram_block_host_offset(RAMBlock *rb, void *host)<br>
=C2=A0{<br>
-- <br>
2.17.1<br>
<br>
<br>
</blockquote></div></div>

--000000000000573c170615bc2ad7--

