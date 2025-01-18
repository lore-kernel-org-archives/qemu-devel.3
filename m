Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4362FC02185
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2025 17:12:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZCLr-0005A3-Ry; Sat, 18 Jan 2025 12:11:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tZCLl-00058e-Rg; Sat, 18 Jan 2025 12:11:09 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tZCLf-0002io-Su; Sat, 18 Jan 2025 12:11:08 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AFF87DA8EA;
 Sat, 18 Jan 2025 20:10:37 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id F25BF19E900;
 Sat, 18 Jan 2025 20:10:47 +0300 (MSK)
Message-ID: <f616a4b4-2161-42c8-9f92-e3a939ba173a@tls.msk.ru>
Date: Sat, 18 Jan 2025 20:10:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vvfat: fix out of bounds array write
To: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20250105135929.6286-1-vr_qemu@t-online.de>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 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
In-Reply-To: <20250105135929.6286-1-vr_qemu@t-online.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

05.01.2025 16:59, Volker Rümelin wrote:
> In function create_long_filname(), the array name[8 + 3] in
> struct direntry_t is used as if it were defined as name[32].
> This is intentional and works. It's nevertheless an out of
> bounds array access. To avoid this problem, this patch adds a
> struct lfn_direntry_t with multiple name arrays. A directory
> entry for a long FAT file name is significantly different from
> a directory entry for a regular FAT file name.
> 
> Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>


> +static void write_long_filename(lfn_direntry_t *entry, int index, uint8_t c)
> +{
> +    if (index < ARRAY_SIZE(entry->name01)) {
> +        entry->name01[index] = c;
> +        return;
> +    }
> +    index -= ARRAY_SIZE(entry->name01);
> +    if (index < ARRAY_SIZE(entry->name0e)) {
> +        entry->name0e[index] = c;
> +        return;
> +    }
> +    index -= ARRAY_SIZE(entry->name0e);
> +    if (index < ARRAY_SIZE(entry->name1c)) {
> +        entry->name1c[index] = c;
> +    }
> +}
>


> +        entry = array_get(&s->directory, s->directory.next - i / 26 - 1);
>           if (i >= 2 * length + 2) {
> -            entry->name[offset] = 0xff;
> +            c = 0xff;
>           } else if (i % 2 == 0) {
> -            entry->name[offset] = longname[i / 2] & 0xff;
> +            c = longname[i / 2] & 0xff;
>           } else {
> -            entry->name[offset] = longname[i / 2] >> 8;
> +            c = longname[i / 2] >> 8;
>           }
> +        write_long_filename(entry, i % 26, c);

Ghrm.  This doubles the twisty "if" statement...  :(

How about this instead (untested)?

The idea is to iterate over all dentries once, and fill each part inside the
dentry structure in turn, going on by utf16 char, instead by bytes/offset.

I think it is a bit clearer...

@@ -399,11 +410,21 @@ static void init_mbr(BDRVVVFATState *s, int cyls, int heads, int secs)

  /* direntry functions */

+static unsigned write_long_filename_part(uint8_t *dest, unsigned dsize,
+                                         const gunichar2 *name, unsigned nlen)
+{
+    unsigned i;
+    for(i = 0; i < dsize / 2 && i < nlen; ++i) {
+        dest[i / 2 + 0] = name[i] & 0xff;
+        dest[i / 2 + 1] = name[i] >> 8;
+    }
+    return i;
+}
+
  static direntry_t *create_long_filename(BDRVVVFATState *s, const char *filename)
  {
-    int number_of_entries, i;
+    unsigned number_of_entries, ei, ci;
      glong length;
-    direntry_t *entry;

      gunichar2 *longname = g_utf8_to_utf16(filename, -1, NULL, &length, NULL);
      if (!longname) {
@@ -411,28 +432,21 @@ static direntry_t *create_long_filename(BDRVVVFATState *s, const char *filename)
          return NULL;
      }

-    number_of_entries = DIV_ROUND_UP(length * 2, 26);
+    /* each lfn_direntry holds 13 utf16 chars (26 bytes) */
+    number_of_entries = DIV_ROUND_UP(length, 13);

-    for(i=0;i<number_of_entries;i++) {
-        entry=array_get_next(&(s->directory));
-        entry->attributes=0xf;
-        entry->reserved[0]=0;
-        entry->begin=0;
-        entry->name[0]=(number_of_entries-i)|(i==0?0x40:0);
-    }
-    for(i=0;i<26*number_of_entries;i++) {
-        int offset=(i%26);
-        if(offset<10) offset=1+offset;
-        else if(offset<22) offset=14+offset-10;
-        else offset=28+offset-22;
-        entry=array_get(&(s->directory),s->directory.next-1-(i/26));
-        if (i >= 2 * length + 2) {
-            entry->name[offset] = 0xff;
-        } else if (i % 2 == 0) {
-            entry->name[offset] = longname[i / 2] & 0xff;
-        } else {
-            entry->name[offset] = longname[i / 2] >> 8;
-        }
+    for(ei = 0, ci = 0; i < number_of_entries; ei++) {
+        lfn_direntry_t *entry = array_get_next(&(s->directory));
+        entry->sequence = (number_of_entries - ei) | (ei == 0 ? 0x40 : 0);
+        entry->attributes = 0xf;
+        entry->direntry_type = 0;
+        entry->begin = 0;
+        ci += write_long_filename_part(entry->name01, sizeof(entry->name01),
+                                       longname + ci, length - ci);
+        ci += write_long_filename_part(entry->name0e, sizeof(entry->name0e),
+                                       longname + ci, length - ci);
+        ci += write_long_filename_part(entry->name1c, sizeof(entry->name1c),
+                                       longname + ci, length - ci);
      }
      g_free(longname);
      return array_get(&(s->directory),s->directory.next-number_of_entries);


