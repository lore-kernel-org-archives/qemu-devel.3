Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36BD7C02185
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2025 20:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZFq2-0007u1-Sv; Sat, 18 Jan 2025 15:54:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tZFq0-0007tG-4b; Sat, 18 Jan 2025 15:54:36 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tZFpw-0007e2-QV; Sat, 18 Jan 2025 15:54:34 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E456B4E6001;
 Sat, 18 Jan 2025 21:54:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id ggxEBSpKRLQc; Sat, 18 Jan 2025 21:54:23 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id DC3CD4E6000; Sat, 18 Jan 2025 21:54:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D72C174577C;
 Sat, 18 Jan 2025 21:54:23 +0100 (CET)
Date: Sat, 18 Jan 2025 21:54:23 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Michael Tokarev <mjt@tls.msk.ru>
cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, 
 =?ISO-8859-15?Q?Volker_R=FCmelin?= <vr_qemu@t-online.de>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-block@nongnu.org, 
 qemu-trivial@nongnu.org
Subject: Re: [PATCH] vvfat: refresh writing long filename
In-Reply-To: <20250118182109.2695C19E94D@tsrv.corpit.ru>
Message-ID: <df622cbd-32a1-29b3-5518-fa4d5e1d7c40@eik.bme.hu>
References: <20250118182109.2695C19E94D@tsrv.corpit.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, 18 Jan 2025, Michael Tokarev wrote:
> In function create_long_filname(), the array name[8 + 3] in
> struct direntry_t is used as if it were defined as name[32].
> This is intentional and works. It's nevertheless an out of
> bounds array access. To avoid this problem, this patch adds a
> struct lfn_direntry_t with multiple name arrays. A directory
> entry for a long FAT file name is significantly different from
> a directory entry for a regular FAT file name.
>
> This change makes whole logic dealing with the long filenames
> a bit more clear (hopefully).
>
> Based on ideas by Volker R??melin.
>
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
> block/vvfat.c | 69 ++++++++++++++++++++++++++++++++-------------------
> 1 file changed, 43 insertions(+), 26 deletions(-)
>
> diff --git a/block/vvfat.c b/block/vvfat.c
> index 8ffe8b3b9b..8320733045 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -255,6 +255,17 @@ typedef struct direntry_t {
>     uint32_t size;
> } QEMU_PACKED direntry_t;
>
> +typedef struct lfn_direntry_t {
> +    uint8_t sequence;
> +    uint8_t name01[10];
> +    uint8_t attributes;
> +    uint8_t direntry_type;
> +    uint8_t sfn_checksum;
> +    uint8_t name0e[12];
> +    uint16_t begin;
> +    uint8_t name1c[4];
> +} QEMU_PACKED lfn_direntry_t;
> +
> /* this structure are used to transparently access the files */
>
> typedef struct mapping_t {
> @@ -399,11 +410,22 @@ static void init_mbr(BDRVVVFATState *s, int cyls, int heads, int secs)
>
> /* direntry functions */
>
> +static unsigned write_lfn_part(uint8_t *dest, unsigned dsize,
> +                               const gunichar2 *lptr, const gunichar2 *lend)
> +{
> +    unsigned i;
> +    for(i = 0; i < dsize / 2 && lptr + i < lend; ++i) {
> +        dest[i / 2 + 0] = lptr[i] & 0xff;
> +        dest[i / 2 + 1] = lptr[i] >> 8;

Why not uint16_t and maybe cpu_to_le (or whatever that's called) if 
needed? May be simpler than handling it byte by byte.

Regards,
BALATON Zoltan

> +    }
> +    return i; /* return number of elements actually written */
> +}
> +
> static direntry_t *create_long_filename(BDRVVVFATState *s, const char *filename)
> {
> -    int number_of_entries, i;
> +    unsigned number_of_entries, entidx;
> +    gunichar2 *lptr, *lend;
>     glong length;
> -    direntry_t *entry;
>
>     gunichar2 *longname = g_utf8_to_utf16(filename, -1, NULL, &length, NULL);
>     if (!longname) {
> @@ -411,31 +433,26 @@ static direntry_t *create_long_filename(BDRVVVFATState *s, const char *filename)
>         return NULL;
>     }
>
> -    number_of_entries = DIV_ROUND_UP(length * 2, 26);
> -
> -    for(i=0;i<number_of_entries;i++) {
> -        entry=array_get_next(&(s->directory));
> -        entry->attributes=0xf;
> -        entry->reserved[0]=0;
> -        entry->begin=0;
> -        entry->name[0]=(number_of_entries-i)|(i==0?0x40:0);
> -    }
> -    for(i=0;i<26*number_of_entries;i++) {
> -        int offset=(i%26);
> -        if(offset<10) offset=1+offset;
> -        else if(offset<22) offset=14+offset-10;
> -        else offset=28+offset-22;
> -        entry=array_get(&(s->directory),s->directory.next-1-(i/26));
> -        if (i >= 2 * length + 2) {
> -            entry->name[offset] = 0xff;
> -        } else if (i % 2 == 0) {
> -            entry->name[offset] = longname[i / 2] & 0xff;
> -        } else {
> -            entry->name[offset] = longname[i / 2] >> 8;
> -        }
> +    /*
> +     * each lfn_direntry holds 13 utf16 chars (26 bytes) of the file name,
> +     * the name is split into several directory entries.
> +     */
> +    number_of_entries = DIV_ROUND_UP(length, 13);
> +
> +    lend = longname + length; /* pointer past the end of longname */
> +    for(entidx = 0, lptr = longname; entidx < number_of_entries; entidx++) {
> +        lfn_direntry_t *entry = array_get_next(&(s->directory));
> +        entry->sequence = (number_of_entries - entidx) | (entidx == 0 ? 0x40 : 0);
> +        entry->attributes = 0xf;
> +        entry->direntry_type = 0;
> +        entry->begin = 0;
> +        /* each lftn_direntry has 3 pieces to hold parts of long file name */
> +        lptr += write_lfn_part(entry->name01, sizeof(entry->name01), lptr, lend);
> +        lptr += write_lfn_part(entry->name0e, sizeof(entry->name0e), lptr, lend);
> +        lptr += write_lfn_part(entry->name1c, sizeof(entry->name1c), lptr, lend);
>     }
>     g_free(longname);
> -    return array_get(&(s->directory),s->directory.next-number_of_entries);
> +    return array_get(&(s->directory), s->directory.next - number_of_entries);
> }
>
> static char is_free(const direntry_t* direntry)
> @@ -731,7 +748,7 @@ static inline direntry_t* create_short_and_long_name(BDRVVVFATState* s,
>         /* calculate anew, because realloc could have taken place */
>         entry_long=array_get(&(s->directory),long_index);
>         while(entry_long<entry && is_long_name(entry_long)) {
> -            entry_long->reserved[1]=chksum;
> +            ((lfn_direntry_t *)entry_long)->sfn_checksum = chksum;
>             entry_long++;
>         }
>     }
>

