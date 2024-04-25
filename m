Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF8DC10F15
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 10:42:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwWd-0002JX-IU; Thu, 25 Apr 2024 06:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWZ-00023o-2D
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:19 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWV-0007Dm-1E
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:18 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-344047ac7e4so1079319f8f.0
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 03:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714041613; x=1714646413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=35oYYuwi+Br4xakq5nYHN4Yw6o3yTK6J3eUx77p4G0k=;
 b=DkDei1sAXB/nljgjwWmicshlqifO0Xh/ZTeZGx7XJmOBEPZqyh/r9djp4IGnRjrhl4
 We7YEEGX32gGxxRJOEDpC7GprQXLCR190zV+c96ssdv8QyZ0ziQ3SfJlPaxMqgjjt6eC
 6B/PbECG9i7/iF2odG67BCb4kU9kZmu/OyAXKMA42p5tlCORZ9HjPbiBi/OyDOGUerZ8
 8PEmL3F5Tq15LJtMpDTn1dQMlzY5L6EsMWC05ntQWq6DPtZ77jF9CAFVsqgfzNYW22dX
 LV35GICIguPKKQpNJUlsFfsCT8/f35qUmwor1SNx+yvCEEyylaWUwIJj/WIKZuHe2gn+
 L/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714041613; x=1714646413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=35oYYuwi+Br4xakq5nYHN4Yw6o3yTK6J3eUx77p4G0k=;
 b=sKT8Mn0RLo8UWoP7GWdvdtftdngDQ72TlMr3wxW9EyOS6j9BxH5t9XpCgj6141vLSn
 gcxFhSM0/2uYwEux2UFvuucyS5cpCR/SOrCHi9KuRcWgs8BsLASnqRuAAf3B/1CjWy2i
 smJmg6sCoGP+fL8aq13cgLWJbQG2y5dWTq12cmIzd7CRpEHLvEkRlV4TSktFWoa6kd4f
 yMX8dgHgTIfvVA63GyeLNisrJnuMefghRInHlf6LWr0xtWeRNPoMvKGUgxH90qsEJV2u
 +pPXBy47PI23vvH6KbfQ2DiVjZHR5z+VEq0TrvK4jPiecJhtdz5lcgkzupYiq9jGY7kI
 aiFA==
X-Gm-Message-State: AOJu0YwfGTVoT/xuR1ACYdRVLRE2jBIL/rCCqs4I2hzTW6wNUNtg7mC+
 rFHDqbZynMEUyJ+zDMzO2JAhPb/mo8IPFk8kyLA0ia7Uo6P1oyQw49nNnpUIjYWK9h+QQHsvQdY
 2
X-Google-Smtp-Source: AGHT+IGfF+KPxpkk+hJ2NRT5wQslXygN22dz7N57UWmI0wITdBFgVpe00zF52qxFfFbyWmOjbRt9FA==
X-Received: by 2002:a5d:52c8:0:b0:346:a39f:6b69 with SMTP id
 r8-20020a5d52c8000000b00346a39f6b69mr1632299wrv.24.1714041613507; 
 Thu, 25 Apr 2024 03:40:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a056000000f00b003434c764f01sm19485768wrx.107.2024.04.25.03.40.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 03:40:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/37] linux-user/flatload.c: Remove unused bFLT shared-library
 and ZFLAT code
Date: Thu, 25 Apr 2024 11:39:47 +0100
Message-Id: <20240425103958.3237225-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425103958.3237225-1-peter.maydell@linaro.org>
References: <20240425103958.3237225-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Ever since the bFLT format support was added in 2006, there has been
a chunk of code in the file guarded by CONFIG_BINFMT_SHARED_FLAT
which is supposedly for shared library support.  This is not enabled
and it's not possible to enable it, because if you do you'll run into
the "#error needs checking" in the calc_reloc() function.

Similarly, CONFIG_BINFMT_ZFLAT exists but can't be enabled because of
an "#error code needs checking" in load_flat_file().

This code is obviously unfinished and has never been used; nobody in
the intervening 18 years has complained about this or fixed it, so
just delete the dead code.  If anybody ever wants the feature they
can always pull it out of git, or (perhaps better) write it from
scratch based on the current Linux bFLT loader rather than the one of
18 years ago.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240411115313.680433-1-peter.maydell@linaro.org
---
 linux-user/flat.h     |   5 +-
 linux-user/flatload.c | 293 ++----------------------------------------
 2 files changed, 11 insertions(+), 287 deletions(-)

diff --git a/linux-user/flat.h b/linux-user/flat.h
index ed518e2013b..e374b73e268 100644
--- a/linux-user/flat.h
+++ b/linux-user/flat.h
@@ -12,11 +12,8 @@
 
 #define	FLAT_VERSION			0x00000004L
 
-#ifdef CONFIG_BINFMT_SHARED_FLAT
-#define	MAX_SHARED_LIBS			(4)
-#else
+/* QEMU doesn't support bflt shared libraries */
 #define	MAX_SHARED_LIBS			(1)
-#endif
 
 /*
  * To make everything easier to port and manage cross platform
diff --git a/linux-user/flatload.c b/linux-user/flatload.c
index 5b62aa0a2be..04d8138d12e 100644
--- a/linux-user/flatload.c
+++ b/linux-user/flatload.c
@@ -29,8 +29,6 @@
  *	JAN/99 -- coded full program relocation (gerg@snapgear.com)
  */
 
-/* ??? ZFLAT and shared library support is currently disabled.  */
-
 /****************************************************************************/
 
 #include "qemu/osdep.h"
@@ -64,10 +62,6 @@ struct lib_info {
     short loaded;		/* Has this library been loaded? */
 };
 
-#ifdef CONFIG_BINFMT_SHARED_FLAT
-static int load_flat_shared_library(int id, struct lib_info *p);
-#endif
-
 struct linux_binprm;
 
 /****************************************************************************/
@@ -108,153 +102,6 @@ static int target_pread(int fd, abi_ulong ptr, abi_ulong len,
     unlock_user(buf, ptr, len);
     return ret;
 }
-/****************************************************************************/
-
-#ifdef CONFIG_BINFMT_ZFLAT
-
-#include <linux/zlib.h>
-
-#define LBUFSIZE	4000
-
-/* gzip flag byte */
-#define ASCII_FLAG   0x01 /* bit 0 set: file probably ASCII text */
-#define CONTINUATION 0x02 /* bit 1 set: continuation of multi-part gzip file */
-#define EXTRA_FIELD  0x04 /* bit 2 set: extra field present */
-#define ORIG_NAME    0x08 /* bit 3 set: original file name present */
-#define COMMENT      0x10 /* bit 4 set: file comment present */
-#define ENCRYPTED    0x20 /* bit 5 set: file is encrypted */
-#define RESERVED     0xC0 /* bit 6,7:   reserved */
-
-static int decompress_exec(
-	struct linux_binprm *bprm,
-	unsigned long offset,
-	char *dst,
-	long len,
-	int fd)
-{
-	unsigned char *buf;
-	z_stream strm;
-	loff_t fpos;
-	int ret, retval;
-
-	DBG_FLT("decompress_exec(offset=%x,buf=%x,len=%x)\n",(int)offset, (int)dst, (int)len);
-
-	memset(&strm, 0, sizeof(strm));
-	strm.workspace = kmalloc(zlib_inflate_workspacesize(), GFP_KERNEL);
-	if (strm.workspace == NULL) {
-		DBG_FLT("binfmt_flat: no memory for decompress workspace\n");
-		return -ENOMEM;
-	}
-	buf = kmalloc(LBUFSIZE, GFP_KERNEL);
-	if (buf == NULL) {
-		DBG_FLT("binfmt_flat: no memory for read buffer\n");
-		retval = -ENOMEM;
-		goto out_free;
-	}
-
-	/* Read in first chunk of data and parse gzip header. */
-	fpos = offset;
-	ret = bprm->file->f_op->read(bprm->file, buf, LBUFSIZE, &fpos);
-
-	strm.next_in = buf;
-	strm.avail_in = ret;
-	strm.total_in = 0;
-
-	retval = -ENOEXEC;
-
-	/* Check minimum size -- gzip header */
-	if (ret < 10) {
-		DBG_FLT("binfmt_flat: file too small?\n");
-		goto out_free_buf;
-	}
-
-	/* Check gzip magic number */
-	if ((buf[0] != 037) || ((buf[1] != 0213) && (buf[1] != 0236))) {
-		DBG_FLT("binfmt_flat: unknown compression magic?\n");
-		goto out_free_buf;
-	}
-
-	/* Check gzip method */
-	if (buf[2] != 8) {
-		DBG_FLT("binfmt_flat: unknown compression method?\n");
-		goto out_free_buf;
-	}
-	/* Check gzip flags */
-	if ((buf[3] & ENCRYPTED) || (buf[3] & CONTINUATION) ||
-	    (buf[3] & RESERVED)) {
-		DBG_FLT("binfmt_flat: unknown flags?\n");
-		goto out_free_buf;
-	}
-
-	ret = 10;
-	if (buf[3] & EXTRA_FIELD) {
-		ret += 2 + buf[10] + (buf[11] << 8);
-		if (unlikely(LBUFSIZE == ret)) {
-			DBG_FLT("binfmt_flat: buffer overflow (EXTRA)?\n");
-			goto out_free_buf;
-		}
-	}
-	if (buf[3] & ORIG_NAME) {
-		for (; ret < LBUFSIZE && (buf[ret] != 0); ret++)
-			;
-		if (unlikely(LBUFSIZE == ret)) {
-			DBG_FLT("binfmt_flat: buffer overflow (ORIG_NAME)?\n");
-			goto out_free_buf;
-		}
-	}
-	if (buf[3] & COMMENT) {
-		for (;  ret < LBUFSIZE && (buf[ret] != 0); ret++)
-			;
-		if (unlikely(LBUFSIZE == ret)) {
-			DBG_FLT("binfmt_flat: buffer overflow (COMMENT)?\n");
-			goto out_free_buf;
-		}
-	}
-
-	strm.next_in += ret;
-	strm.avail_in -= ret;
-
-	strm.next_out = dst;
-	strm.avail_out = len;
-	strm.total_out = 0;
-
-	if (zlib_inflateInit2(&strm, -MAX_WBITS) != Z_OK) {
-		DBG_FLT("binfmt_flat: zlib init failed?\n");
-		goto out_free_buf;
-	}
-
-	while ((ret = zlib_inflate(&strm, Z_NO_FLUSH)) == Z_OK) {
-		ret = bprm->file->f_op->read(bprm->file, buf, LBUFSIZE, &fpos);
-		if (ret <= 0)
-			break;
-                if (is_error(ret)) {
-			break;
-                }
-		len -= ret;
-
-		strm.next_in = buf;
-		strm.avail_in = ret;
-		strm.total_in = 0;
-	}
-
-	if (ret < 0) {
-		DBG_FLT("binfmt_flat: decompression failed (%d), %s\n",
-			ret, strm.msg);
-		goto out_zlib;
-	}
-
-	retval = 0;
-out_zlib:
-	zlib_inflateEnd(&strm);
-out_free_buf:
-	kfree(buf);
-out_free:
-	kfree(strm.workspace);
-out:
-	return retval;
-}
-
-#endif /* CONFIG_BINFMT_ZFLAT */
 
 /****************************************************************************/
 
@@ -268,40 +115,7 @@ calc_reloc(abi_ulong r, struct lib_info *p, int curid, int internalp)
     abi_ulong text_len;
     abi_ulong start_code;
 
-#ifdef CONFIG_BINFMT_SHARED_FLAT
-#error needs checking
-    if (r == 0)
-        id = curid;	/* Relocs of 0 are always self referring */
-    else {
-        id = (r >> 24) & 0xff;	/* Find ID for this reloc */
-        r &= 0x00ffffff;	/* Trim ID off here */
-    }
-    if (id >= MAX_SHARED_LIBS) {
-        fprintf(stderr, "BINFMT_FLAT: reference 0x%x to shared library %d\n",
-                (unsigned) r, id);
-        goto failed;
-    }
-    if (curid != id) {
-        if (internalp) {
-            fprintf(stderr, "BINFMT_FLAT: reloc address 0x%x not "
-                    "in same module (%d != %d)\n",
-                    (unsigned) r, curid, id);
-            goto failed;
-        } else if (!p[id].loaded && is_error(load_flat_shared_library(id, p))) {
-            fprintf(stderr, "BINFMT_FLAT: failed to load library %d\n", id);
-            goto failed;
-        }
-        /* Check versioning information (i.e. time stamps) */
-        if (p[id].build_date && p[curid].build_date
-            && p[curid].build_date < p[id].build_date) {
-            fprintf(stderr, "BINFMT_FLAT: library %d is younger than %d\n",
-                    id, curid);
-            goto failed;
-        }
-    }
-#else
     id = 0;
-#endif
 
     start_brk = p[id].start_brk;
     start_data = p[id].start_data;
@@ -425,12 +239,10 @@ static int load_flat_file(struct linux_binprm * bprm,
     if (rev == OLD_FLAT_VERSION && flat_old_ram_flag(flags))
         flags = FLAT_FLAG_RAM;
 
-#ifndef CONFIG_BINFMT_ZFLAT
     if (flags & (FLAT_FLAG_GZIP|FLAT_FLAG_GZDATA)) {
-        fprintf(stderr, "Support for ZFLAT executables is not enabled\n");
+        fprintf(stderr, "ZFLAT executables are not supported\n");
         return -ENOEXEC;
     }
-#endif
 
     /*
      * calculate the extra space we need to map in
@@ -483,17 +295,9 @@ static int load_flat_file(struct linux_binprm * bprm,
                         (int)(data_len + bss_len + stack_len), (int)datapos);
 
         fpos = ntohl(hdr->data_start);
-#ifdef CONFIG_BINFMT_ZFLAT
-        if (flags & FLAT_FLAG_GZDATA) {
-            result = decompress_exec(bprm, fpos, (char *) datapos,
-                                     data_len + (relocs * sizeof(abi_ulong)))
-        } else
-#endif
-        {
-            result = target_pread(bprm->src.fd, datapos,
-                                  data_len + (relocs * sizeof(abi_ulong)),
-                                  fpos);
-        }
+        result = target_pread(bprm->src.fd, datapos,
+                              data_len + (relocs * sizeof(abi_ulong)),
+                              fpos);
         if (result < 0) {
             fprintf(stderr, "Unable to read data+bss\n");
             return result;
@@ -515,38 +319,12 @@ static int load_flat_file(struct linux_binprm * bprm,
         datapos = realdatastart + indx_len;
         reloc = (textpos + ntohl(hdr->reloc_start) + indx_len);
 
-#ifdef CONFIG_BINFMT_ZFLAT
-#error code needs checking
-        /*
-         * load it all in and treat it like a RAM load from now on
-         */
-        if (flags & FLAT_FLAG_GZIP) {
-                result = decompress_exec(bprm, sizeof (struct flat_hdr),
-                                 (((char *) textpos) + sizeof (struct flat_hdr)),
-                                 (text_len + data_len + (relocs * sizeof(unsigned long))
-                                          - sizeof (struct flat_hdr)),
-                                 0);
-                memmove((void *) datapos, (void *) realdatastart,
-                                data_len + (relocs * sizeof(unsigned long)));
-        } else if (flags & FLAT_FLAG_GZDATA) {
-                fpos = 0;
-                result = bprm->file->f_op->read(bprm->file,
-                                (char *) textpos, text_len, &fpos);
-                if (!is_error(result)) {
-                        result = decompress_exec(bprm, text_len, (char *) datapos,
-                                         data_len + (relocs * sizeof(unsigned long)), 0);
-                }
-        }
-        else
-#endif
-        {
-            result = target_pread(bprm->src.fd, textpos,
-                                  text_len, 0);
-            if (result >= 0) {
-                result = target_pread(bprm->src.fd, datapos,
-                    data_len + (relocs * sizeof(abi_ulong)),
-                    ntohl(hdr->data_start));
-            }
+        result = target_pread(bprm->src.fd, textpos,
+                              text_len, 0);
+        if (result >= 0) {
+            result = target_pread(bprm->src.fd, datapos,
+                                  data_len + (relocs * sizeof(abi_ulong)),
+                                  ntohl(hdr->data_start));
         }
         if (result < 0) {
             fprintf(stderr, "Unable to read code+data+bss\n");
@@ -678,44 +456,6 @@ static int load_flat_file(struct linux_binprm * bprm,
 
 
 /****************************************************************************/
-#ifdef CONFIG_BINFMT_SHARED_FLAT
-
-/*
- * Load a shared library into memory.  The library gets its own data
- * segment (including bss) but not argv/argc/environ.
- */
-
-static int load_flat_shared_library(int id, struct lib_info *libs)
-{
-	struct linux_binprm bprm;
-	int res;
-	char buf[16];
-
-	/* Create the file name */
-	sprintf(buf, "/lib/lib%d.so", id);
-
-	/* Open the file up */
-	bprm.filename = buf;
-	bprm.file = open_exec(bprm.filename);
-	res = PTR_ERR(bprm.file);
-	if (IS_ERR(bprm.file))
-		return res;
-
-	res = prepare_binprm(&bprm);
-
-        if (!is_error(res)) {
-		res = load_flat_file(&bprm, libs, id, NULL);
-        }
-	if (bprm.file) {
-		allow_write_access(bprm.file);
-		fput(bprm.file);
-		bprm.file = NULL;
-	}
-	return(res);
-}
-
-#endif /* CONFIG_BINFMT_SHARED_FLAT */
-
 int load_flt_binary(struct linux_binprm *bprm, struct image_info *info)
 {
     struct lib_info libinfo[MAX_SHARED_LIBS];
@@ -793,19 +533,6 @@ int load_flt_binary(struct linux_binprm *bprm, struct image_info *info)
      */
     start_addr = libinfo[0].entry;
 
-#ifdef CONFIG_BINFMT_SHARED_FLAT
-#error here
-    for (i = MAX_SHARED_LIBS-1; i>0; i--) {
-            if (libinfo[i].loaded) {
-                    /* Push previous first to call address */
-                    --sp;
-                    if (put_user_ual(start_addr, sp))
-                        return -EFAULT;
-                    start_addr = libinfo[i].entry;
-            }
-    }
-#endif
-
     /* Stash our initial stack pointer into the mm structure */
     info->start_code = libinfo[0].start_code;
     info->end_code = libinfo[0].start_code + libinfo[0].text_len;
-- 
2.34.1


