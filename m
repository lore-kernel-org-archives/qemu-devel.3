Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 587F2C55174
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2026 04:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsYm2-0004el-Vo; Sat, 08 Aug 2026 00:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wsYm1-0004e7-HQ
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 00:35:05 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wsYlz-00083B-5T
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 00:35:05 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5b15c6fb864so114885e87.1
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 21:35:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786163701; cv=none;
 d=google.com; s=arc-20260327;
 b=YILWvuwRs6cbw3pcw1IZnpu5KB9grBpL2Vd5TqxIX7298ngrXj2pwIscdgBp3hymc6
 egDr9vk36mwd5YparBZntbkA0aHRGeQG6dF1FekWrRqZHw419epfpXejDX7AJoqGjUPL
 RWi96dNKxnz3rzNAUf3uABYmCkRA6XuZld8LvhfVGaouKT1n5s3O7Hd1i1lqxh60t4mt
 Z/NCxemZs5S8rYbhSVdqjB9yxlTSNjU45vwJ6UhP63Luik7Pj6S+BNkwtNspNl5SAIAf
 U25BFyYLysaeEoKf+gXLS8qrzIhM1/7B7BOXLBmRj8Je5M1BV0UBN8IMFHa5VnBPjCAc
 qEmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SXg1U+tq/b8zAJDji0N9D0TjxjxOAEa+npzB4qdXNE8=;
 fh=G0z2JIQc2t8qrxmKLGMcsT5kIoUn1V9o9rH2YuF0L78=;
 b=AIhSVpCyOBBR/1vc/UvoGqpsBZ8myX9QcUTaEpv8obOoBPEIa9DEzePnUd0y8ZMDZj
 U6k1HI1irgKYOS55cEUpqvvu/JuVUox9IWPn6aQ7ZuALypmvVGW/FoZyP3JRXybotUi1
 3AAf3sTd8Kyq8HTqZwz9JcjKacNXqyWO3cuU18cvcLUMLyMHQZ4+GvLmHPgszCXNj9QX
 N3IzwCblemj7Wb9uMe8IscMsWt5xQ7hGWtCbGu+C1hFV7LMwFitvi63rpen9ox/Iz/Ge
 p121RmWh3R6r06Gt0YZEsaPDpbsZVT4WgWUmB45vL6BqDZSSjMKVCp28EpRNxwvbxRHk
 Dixw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786163701; x=1786768501; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SXg1U+tq/b8zAJDji0N9D0TjxjxOAEa+npzB4qdXNE8=;
 b=BKVIwJXokC4TkjOW3WTq9fd244SqbgLqM3/AB8H9l+2z1bfdsqFFyTehvqWsv0lgTa
 Nke3HCux+dpKQZKXySMVhvSZrbmQ9DcAicl6v/B4c0z5tKyiOXsEdB+c59WCt1MgXbeN
 nKCy2zdiDJoHJ79oDoWg6kQVlUx1W29eUX9pB0Oj6H2wkj50F9uxvS5WhjwzDQHRA5GH
 uB2VfT3fJMRbrphvchahQTyd5oy8fHzKb9pj0SAmPwkd1kfQ2ACEckmg/5OmjMj42jpy
 OflBHOjCe+ZHUPtrh4YPCRjfkOL72LpU/OJ1Eq4HEfRDYDvJCmROSdv7SFRtflA0kSuA
 9S9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786163701; x=1786768501;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SXg1U+tq/b8zAJDji0N9D0TjxjxOAEa+npzB4qdXNE8=;
 b=DNO7r693blb2HceaArj7phdTJmm03Z2Ac1g/aUiZ7lvv2Sz+9mEqGSp4fvXVWUM52l
 YKeLpQlFnBjMCc7L+xt2vccQ4n9+MEEGF2+n+1JxxJ+qnvakMdLnOQ4XMY3/vuLH5+7l
 i3cbPx9ursncPKAZyQlCqTScP/Q3efPsHoAchmOiMpSSMcgWxYg6tovfPGcieHE8zfzE
 rLgLZNm8S/WIUouyggfwBoMQCJvmr7DAw56Pw+kRYaMHkMKY8K4tGlAmrv0AhWqx8sd0
 97Ajh/IlIlOuOrdgN41trGPXe9YqA90SmPI4yqWR+NK34sHSt+1CV2GQNgprjGyYVCFj
 hHKg==
X-Gm-Message-State: AOJu0YyEH83oZjQv+20PcsRPeRmBKG8AbpbG1bfX+yqX6hD+qTN9DQDf
 yj2xcKrZ59IN/uz13Y1DeVkJm84VZ+23r0YalBhYP79v/vFJ6iaEaT/ncLlVdvi3X14H7sLcmv1
 e2dbiHNeDKuz0hUS/8WaTiDExGA00M4S+74JD
X-Gm-Gg: AR+sD11HCgDX2ZWT01qSObx8w/qoQ9M+v4KilCKQuo/PpXsmJy+m0x7CAQNT1uf5Eer
 8VsJwkIvxEdHy1/E+NibbOeXKimZONYtXlj3gS+xgTC78Qg00RU7PPIFovGx+GU0PJYzQnF6pCU
 fZkE+fWWwmqweVdoAizTnQ/GksgSHb4024b0u+aj96RTj1n+NmRXsNvXbON1x99BVl9EEOI9d/Z
 CDBctYjlA7GY86L494YBeqXNCGq5+7208VmWCM8Z2XyIbaiUJBuJznLVF46c/GVcbrFTpif6PfN
 1bvUFp1bv/AyS9Cig2Kw78Tq/8OmdzjJLeNwf5frQOMpuyF9b9LyDzIYUNid5S98c+fCFAbLOvS
 8AugOr8FxxK3q
X-Received: by 2002:ac2:51c5:0:b0:5b2:a967:c0bf with SMTP id
 2adb3069b0e04-5b30b715097mr695554e87.10.1786163700380; Fri, 07 Aug 2026
 21:35:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260801023628.22665-1-aadeshveer07@gmail.com>
 <20260801023628.22665-8-aadeshveer07@gmail.com>
In-Reply-To: <20260801023628.22665-8-aadeshveer07@gmail.com>
From: Aadeshveer Singh <aadeshveer07@gmail.com>
Date: Sat, 8 Aug 2026 10:04:48 +0530
X-Gm-Features: AUfX_mw_4-o4G18gL6myCHFdFN95z5P_mVSyeaaDX5n98aeKpB_gFo2utFEDv_M
Message-ID: <CA++cPvLsRpqcqhPg4fY_uhnZqeET0OpdxDDM1i4_rGFuR_4Hag@mail.gmail.com>
Subject: Re: [PATCH v4 07/11] migration: add support for fault thread to load
 pages from disk
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com, 
 lvivier@redhat.com, ayoub@saferwall.com, pierrick.bouvier@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=aadeshveer07@gmail.com; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URG_BIZ=0.573 autolearn=no autolearn_force=no
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

A subtle concurrency bug exists in the current patch; this small patch
should fix it.

Current patch uses bitmap_test_and_clear_atomic assuming it performs
an atomic operation over a range, which as pointer out by Peter is not
the case. It performs atomic word by word operations making the
overall operation unsafe.
Therefore, keeping the same bitmap would require protection by a mutex
lock which might not be as efficient. Hence this small patch resizes
the pending_bmap to have exactly one bit per load operation(loading
the larger of host page and guest page).

Thank you,
Aadeshveer Singh

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index e01ac628f5..0bf0f837ad 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1031,9 +1031,13 @@ static bool
postcopy_mapped_ram_load_page(MigrationIncomingState *mis,
     host_page =3D rb_offset / qemu_ram_pagesize(rb);
     page =3D rb_offset >> qemu_target_page_bits();

-    if (bitmap_test_and_clear_atomic(
-            rb->pending_bmap, host_page,
-            MAX(1, qemu_target_page_size() / qemu_ram_pagesize(rb)))) {
+    /*
+     * pending_bmap needs the index of host or guest page based on which i=
s
+     * larger. As page index is inversely proportional to page size we use=
 the
+     * minimum of both.
+     */
+    if (bitmap_test_and_clear_atomic(rb->pending_bmap, MIN(host_page, page=
),
+                                     1)) {
         if (find_next_bit(rb->file_bmap, page + guest_pages_to_load, page)=
 =3D=3D
             page + guest_pages_to_load) {
             /* It is efficient to use UFFDIO_ZERO if all pages are zero */
diff --git a/migration/ram.c b/migration/ram.c
index 734fd90e12..52a3af9245 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -269,7 +269,14 @@ static void ramblock_pending_bmap_init(void)

     RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
         assert(!rb->pending_bmap);
-        size_t size =3D rb->max_length / qemu_ram_pagesize(rb);
+        /*
+         * The pending_bmap granularity must match the maximum of
host and guest
+         * page sizes. This ensures that every load operation checks for o=
ne
+         * bit, allowing lockless thread coordination via a single-bit ato=
mic
+         * test-and-clear.
+         */
+        size_t size =3D rb->max_length /
+                      MAX(qemu_ram_pagesize(rb), qemu_target_page_size());
         rb->pending_bmap =3D bitmap_new(size);
         bitmap_set(rb->pending_bmap, 0, size);
     }

On Sat, Aug 1, 2026 at 8:07=E2=80=AFAM Aadeshveer Singh <aadeshveer07@gmail=
.com> wrote:
>
> In fast snapshot load, we would like to serve faults as soon as possible
> hence loading pages directly instead of requesting a source
>
> Add postcopy_mapped_ram_load_page() function which serves single page
> fault. It uses bitmap_test_and_clear_atomic() on pending_bmap to prevent
> multiple threads from loading same page. It loads a page or pages
> depending on size of guest pages and host pages, loading exactly the
> larger of two. If the entire page is zero postcopy_place_page_zero() is
> used for efficiency and in case some part is non zero it is part by part
> loaded on loop using new function postcopy_mapped_ram_load_guest_page()
> which loads a single guest page in a buffer which is then placed using
> postcopy_place_page(). This covers all possible cases for various page
> sizes of host and guest.
>
> Update postcopy_ram_fault_thread to call postcopy_mapped_ram_load_page
> instead of requesting source in case of fast snapshot load. to_src_file
> check is bypassed in fast snapshot load case as there is no source.
>
> Call try_mark_postcopy_blocktime_begin on every page fault to support
> postcopy-blocktime.
>
> Allocate another channel in postcopy_temp_pages_setup(like the preempt
> case), for both the fault thread and eager thread to load pages
> independently.
>
> Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
> ---
>  migration/postcopy-ram.c | 174 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 157 insertions(+), 17 deletions(-)
>
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 2e2c9fae10..1da9c4309b 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -949,6 +949,121 @@ int postcopy_wake_shared(struct PostCopyFD *pcfd,
>                         pagesize);
>  }
>
> +/*
> + * Load a single guest page from source file into the buffer.
> + * NOTE: This is not an atomic operation and should not be used to direc=
tly load
> + * pages on page faults in postcopy. It is meant to fill in buffer that =
can then
> + * be copied into the faulting location using UFFDIO_COPY.
> + */
> +static bool postcopy_mapped_ram_load_guest_page(MigrationIncomingState *=
mis,
> +                                                RAMBlock *rb,
> +                                                ram_addr_t rb_offset, vo=
id *buf,
> +                                                Error **errp)
> +{
> +    ERRP_GUARD();
> +    size_t page =3D rb_offset / qemu_target_page_size();
> +    size_t read;
> +
> +    if (test_bit(page, rb->file_bmap)) {
> +        /*
> +         * This can happen concurrently, but it's thread-safe because
> +         * qemu_get_buffer_at() is thread-safe, and the caller will be u=
sing
> +         * different temporary buffers.
> +         */
> +        read =3D
> +            qemu_get_buffer_at(mis->from_src_file, buf, qemu_target_page=
_size(),
> +                               rb->pages_offset + rb_offset, errp);
> +
> +        if (read !=3D qemu_target_page_size()) {
> +            error_prepend(errp,
> +                          "Could not read page %zu from RAM Block %s: ",=
 page,
> +                          rb->idstr);
> +            return false;
> +        }
> +    } else {
> +        memset(buf, '\0', qemu_target_page_size());
> +    }
> +    return true;
> +}
> +
> +/**
> + * postcopy_mapped_ram_load_page() - Load pages required to access host =
address.
> + * @mis: Migration Incoming State.
> + * @rb: RAMBlock from where page is loaded.
> + * @rb_offset: Offset of target page in RAMBlock.
> + * @haddr: Base of target page where to load in page.
> + * @channel: Used to identify between threads and use corresponding temp=
.
> + * @errp: Set error in case of failure
> + *
> + * Load page(s) from RAMBlock covering the faulting address. We might ne=
ed to
> + * load multiple pages in the case when host page size is greater than g=
uest
> + * page size. As userfaultfd works on granularity of host pages, we migh=
t need
> + * to load guest pages in single operation.
> + *
> + * Return: True on success.
> + */
> +static bool postcopy_mapped_ram_load_page(MigrationIncomingState *mis,
> +                                          RAMBlock *rb, ram_addr_t rb_of=
fset,
> +                                          uint64_t haddr, int channel,
> +                                          Error **errp)
> +{
> +    void *place_source =3D mis->postcopy_tmp_pages[channel].tmp_huge_pag=
e;
> +    char *buffer_ptr =3D (char *)place_source;
> +    size_t guest_pages_to_load =3D
> +        MAX(1, qemu_ram_pagesize(rb) / qemu_target_page_size());
> +    size_t host_page;
> +    size_t page;
> +
> +    /*
> +     * If guest page size is greater than host page size uffd needs to l=
oad one
> +     * guest page and multiple host pages, hence the offsets need to ali=
gned
> +     * with guest pages (which is automatically aligned with host pages)=
. In the
> +     * same case we need to check range of bits on pending_bmap(bit per =
host
> +     * page) to decide whether all the page have been loaded
> +     */
> +    rb_offset =3D ROUND_DOWN(rb_offset, qemu_target_page_size());
> +    haddr =3D ROUND_DOWN(haddr, qemu_target_page_size());
> +    host_page =3D rb_offset / qemu_ram_pagesize(rb);
> +    page =3D rb_offset >> qemu_target_page_bits();
> +
> +    if (bitmap_test_and_clear_atomic(
> +            rb->pending_bmap, host_page,
> +            MAX(1, qemu_target_page_size() / qemu_ram_pagesize(rb)))) {
> +        if (find_next_bit(rb->file_bmap, page + guest_pages_to_load, pag=
e) =3D=3D
> +            page + guest_pages_to_load) {
> +            /* It is efficient to use UFFDIO_ZERO if all pages are zero =
*/
> +            if (postcopy_place_page_zero(mis, (void *)haddr, rb)) {
> +                error_setg(errp,
> +                           "Failed to place zero page %zu from RAM Block=
 %s at "
> +                           "address %" PRIu64,
> +                           page, rb->idstr, haddr);
> +                return false;
> +            }
> +        } else {
> +            size_t load_size =3D guest_pages_to_load * qemu_target_page_=
size();
> +            size_t offset;
> +
> +            for (offset =3D 0; offset < load_size;
> +                 offset +=3D qemu_target_page_size()) {
> +                if (!postcopy_mapped_ram_load_guest_page(
> +                        mis, rb, rb_offset + offset, buffer_ptr + offset=
,
> +                        errp)) {
> +                    return false;
> +                }
> +            }
> +
> +            if (postcopy_place_page(mis, (void *)haddr, place_source, rb=
)) {
> +                error_setg(errp,
> +                           "Failed to place page %zu from RAM Block %s a=
t "
> +                           "address %" PRIu64,
> +                           page, rb->idstr, haddr);
> +                return false;
> +            }
> +        }
> +    }
> +    return true;
> +}
> +
>  /*
>   * NOTE: @tid is only used when postcopy-blocktime feature is enabled, a=
nd
>   * also optional: when zero is provided, the fault accounting will be ig=
nored.
> @@ -1310,6 +1425,7 @@ static void *postcopy_ram_fault_thread(void *opaque=
)
>      int ret;
>      size_t index;
>      RAMBlock *rb =3D NULL;
> +    Error *local_err =3D NULL;
>
>      trace_postcopy_ram_fault_thread_entry();
>      rcu_register_thread();
> @@ -1351,11 +1467,13 @@ static void *postcopy_ram_fault_thread(void *opaq=
ue)
>              break;
>          }
>
> -        if (!mis->to_src_file) {
> +        if (!migrate_mapped_ram() && !mis->to_src_file) {
>              /*
> -             * Possibly someone tells us that the return path is
> -             * broken already using the event. We should hold until
> -             * the channel is rebuilt.
> +             * Possibly someone tells us that the return path is broken =
already
> +             * using the event. We should hold until the channel is rebu=
ilt.
> +             * Fast snapshot load doesn't support pause and recover, bec=
ause
> +             * it's not necessary: we can fail right away when QEMU just=
 booted
> +             * with nothing to lose.
>               */
>              postcopy_pause_fault_thread(mis);
>          }
> @@ -1418,18 +1536,37 @@ static void *postcopy_ram_fault_thread(void *opaq=
ue)
>                                                  qemu_ram_get_idstr(rb),
>                                                  rb_offset,
>                                                  msg.arg.pagefault.feat.p=
tid);
> +
> +            if (migrate_mapped_ram()) {
> +                /* Load page directly in case of fast snapshot load */
> +
> +                uintptr_t aligned =3D (uintptr_t)ROUND_DOWN(
> +                    msg.arg.pagefault.address, qemu_ram_pagesize(rb));
> +
> +                if (try_mark_postcopy_blocktime_begin(
> +                        mis, rb, rb_offset, (uintptr_t)aligned,
> +                        msg.arg.pagefault.feat.ptid)) {
> +                    if (!postcopy_mapped_ram_load_page(
> +                            mis, rb, rb_offset, aligned, RAM_CHANNEL_POS=
TCOPY,
> +                            &local_err)) {
> +                        error_report_err(local_err);
> +                        break;
> +                    }
> +                }
> +            } else {
>  retry:
> -            /*
> -             * Send the request to the source - we want to request one
> -             * of our host page sizes (which is >=3D TPS)
> -             */
> -            ret =3D postcopy_request_page(mis, rb, rb_offset,
> -                                        msg.arg.pagefault.address,
> -                                        msg.arg.pagefault.feat.ptid);
> -            if (ret) {
> -                /* May be network failure, try to wait for recovery */
> -                postcopy_pause_fault_thread(mis);
> -                goto retry;
> +                /*
> +                 * Send the request to the source - we want to request o=
ne
> +                 * of our host page sizes (which is >=3D TPS)
> +                 */
> +                ret =3D postcopy_request_page(mis, rb, rb_offset,
> +                                            msg.arg.pagefault.address,
> +                                            msg.arg.pagefault.feat.ptid)=
;
> +                if (ret) {
> +                    /* May be network failure, try to wait for recovery =
*/
> +                    postcopy_pause_fault_thread(mis);
> +                    goto retry;
> +                }
>              }
>          }
>
> @@ -1501,8 +1638,11 @@ static int postcopy_temp_pages_setup(MigrationInco=
mingState *mis, Error **errp)
>      unsigned i, channels;
>      void *temp_page;
>
> -    if (migrate_postcopy_preempt()) {
> -        /* If preemption enabled, need extra channel for urgent requests=
 */
> +    if (migrate_postcopy_preempt() || migrate_mapped_ram()) {
> +        /*
> +         * If preemption enabled or it is fast snapshot load, need extra=
 channel
> +         * for urgent requests/faults
> +         */
>          mis->postcopy_channels =3D RAM_CHANNEL_MAX;
>      } else {
>          /* Both precopy/postcopy on the same channel */
> --
> 2.55.0
>

