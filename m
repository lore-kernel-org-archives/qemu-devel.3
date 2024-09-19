Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A242CF3945
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 14:33:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srIDg-00038r-Pa; Thu, 19 Sep 2024 10:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1srIDf-00038M-NE
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 10:33:19 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1srIDd-00034w-Pd
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 10:33:19 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2f75c205e4aso10953261fa.0
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 07:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726756395; x=1727361195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t6T74mjjFQE783c5P21hh0BDH0imALWoTL7GmM1nI28=;
 b=CNiRlpztbFj6+066OCNIJU0Ld6b9cmXeo60zA7qGiMzbGIUW9TO5UFeBPGxdHiFtSa
 MSJlBPXs+P0Agg87yxGCU/c0NEYAIh0VXRkGT6Aeml9IIVIsG95H1la3OZ7+EjlbFt5q
 3xheZvt5N/26gYuiNyzJUoHus20vvEgISQIxZd2l2h7vJ10arHgzkOL7tHo4lnXIY+Uh
 cTZE5uPtfjl5AbsfZOUEfQe9VALH8ljDS2eU76bNgzFfx2kO6SeszBeJCEVbpIro+Da6
 ZOjtfmS7cfOPeDGCubB0+SgkOrgFI5IPcLXeoLK7KsB1H9jzxgv7MhMfb2/rG9CQwicz
 5+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726756395; x=1727361195;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t6T74mjjFQE783c5P21hh0BDH0imALWoTL7GmM1nI28=;
 b=v3ifrdoX8+vxihZxxUhJZywIlv1v5TIEeV//IGgwnmXkvJxtBDfjc/TS3PJ6Uj3UQD
 RHnFGfbl2N8yPkCFmG/v8wGLkwF8k16K73B/dGPXzmfIOAz5Y9wdEDkbVivvZyxS3N1G
 y8ABTyxB7c0tAE0TuworJGmXMgpS+Sw81RAkwvwvBEMqjbY9hWhCkAIh3e8uvC4JgRkg
 Rzmr+BJbIZKefE4/BMjJyuZWSHdQwQKbPdd1/JiQGZKK4fUqtza8ATDIRp1NfW0J6Xfx
 9QIoqA6Q4XHE+MmrIyxnSwfdOs8/ZzCj50N+hziYaDLHfm7/+5cpG5G3Lc86iDO7FNjx
 9yGw==
X-Gm-Message-State: AOJu0YwDL1mFpdL+4bHmNqBYMRABy1c4+AKUqSGeP7wDKAjndbjykqKG
 dSsdlw+9fK9GXut4rFZ0nxMm9VDiW/Oyh4otwjAyg/kONOY3zFukqe34ZamoFxkMEcY2IBEkV/J
 Tk8c=
X-Google-Smtp-Source: AGHT+IGsqdSKLiUoaKXnFMoZtTE9VLJH57JM7PDsONRtyzrSn/Qx4d2DVRSk+oh/bUiypPEtk2ppTA==
X-Received: by 2002:a05:651c:1501:b0:2f7:65b0:ff29 with SMTP id
 38308e7fff4ca-2f787f431demr127328701fa.38.1726756395239; 
 Thu, 19 Sep 2024 07:33:15 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c42bb5e83asm6306451a12.40.2024.09.19.07.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 07:33:14 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0E35E5F8A7;
 Thu, 19 Sep 2024 15:33:13 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/18] tcg plugins (deprecations, mem apis, contrib plugins)
In-Reply-To: <CAFEAcA8UGKtZLNZZVQiDryjst93AkQTKhQrBQ573+J21C-y4QA@mail.gmail.com>
 (Peter Maydell's message of "Thu, 19 Sep 2024 14:14:57 +0100")
References: <20240918210712.2336854-1-alex.bennee@linaro.org>
 <CAFEAcA8tdyELui0=jYFObZO1=O_isJ-c1e0s4ZCbMVyfsrY=9A@mail.gmail.com>
 <875xqrg549.fsf@draig.linaro.org>
 <CAFEAcA8UGKtZLNZZVQiDryjst93AkQTKhQrBQ573+J21C-y4QA@mail.gmail.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Thu, 19 Sep 2024 15:33:12 +0100
Message-ID: <87zfo3ems7.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22c.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 19 Sept 2024 at 14:11, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>> > While I'm looking at the code, this caught my eye:
>> >
>> >     case QEMU_PLUGIN_MEM_VALUE_U64:
>> >     {
>> >         uint64_t *p =3D (uint64_t *) &ri->data[offset];
>> >         uint64_t val =3D be ? htobe64(value.data.u64) : htole64(value.=
data.u64);
>> >         if (is_store) {
>> >             *p =3D val;
>> >         } else if (*p !=3D val) {
>> >             unseen_data =3D true;
>> >         }
>> >         break;
>> >     }
>> >
>> > Casting a random byte pointer to uint64_t* like that
>> > and dereferencing it isn't valid -- it can fault if
>> > it's not aligned correctly.
>>
>> Hmm in the normal case of x86 hosts we will never hit this.
>
> Not necessarily -- some x86 SIMD insns enforce alignment.
>
>> I guess we
>> could do a memcpy step and then the byteswap?
>
> That's what bswap.h does, yes.
>
>> Could it be included directly without bringing in the rest of QEMU's
>> include deps?
>
> It's technically quite close to standalone I think,
> but I think it would be a bad idea to directly include
> it because once you put QEMU's include/ on the plugin
> compile include path then that's a slippery slope to
> the plugins not actually being standalone code any more.

In this case tests/tcg/plugins are built for testing the implementation.
We could let it slide to save on just copy and pasting the whole file:

--8<---------------cut here---------------start------------->8---
modified   tests/tcg/plugins/mem.c
@@ -9,10 +9,23 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
-#include <endian.h>
 #include <stdio.h>
 #include <glib.h>
=20
+/*
+ * plugins should not include anything from QEMU aside from the
+ * API header. However the bswap.h header is sufficiently self
+ * contained that we include it here to avoid code duplication.
+ */
+#define HOST_BIG_ENDIAN (__BYTE_ORDER__ =3D=3D __ORDER_BIG_ENDIAN__)
+#define HOST_LONG_BITS (__SIZEOF_POINTER__ * 8)
+#ifndef glue
+#define xglue(x, y) x ## y
+#define glue(x, y) xglue(x, y)
+#define stringify(s) tostring(s)
+#define tostring(s) #s
+#endif
+#include <bswap.h>
 #include <qemu-plugin.h>
=20
 QEMU_PLUGIN_EXPORT int qemu_plugin_version =3D QEMU_PLUGIN_VERSION;
@@ -154,33 +167,45 @@ static void update_region_info(uint64_t region, uint6=
4_t offset,
     case QEMU_PLUGIN_MEM_VALUE_U16:
     {
         uint16_t *p =3D (uint16_t *) &ri->data[offset];
-        uint16_t val =3D be ? htobe16(value.data.u16) : htole16(value.data=
.u16);
         if (is_store) {
-            *p =3D val;
-        } else if (*p !=3D val) {
-            unseen_data =3D true;
+            if (be) {
+                stw_be_p(p, value.data.u16);
+            } else {
+                stw_le_p(p, value.data.u16);
+            }
+        } else {
+            uint16_t val =3D be ? lduw_be_p(p) : lduw_le_p(p);
+            unseen_data =3D val !=3D value.data.u16;
         }
         break;
     }
     case QEMU_PLUGIN_MEM_VALUE_U32:
     {
         uint32_t *p =3D (uint32_t *) &ri->data[offset];
-        uint32_t val =3D be ? htobe32(value.data.u32) : htole32(value.data=
.u32);
         if (is_store) {
-            *p =3D val;
-        } else if (*p !=3D val) {
-            unseen_data =3D true;
+            if (be) {
+                stl_be_p(p, value.data.u32);
+            } else {
+                stl_le_p(p, value.data.u32);
+            }
+        } else {
+            uint32_t val =3D be ? ldl_be_p(p) : ldl_le_p(p);
+            unseen_data =3D val !=3D value.data.u32;
         }
         break;
     }
     case QEMU_PLUGIN_MEM_VALUE_U64:
     {
         uint64_t *p =3D (uint64_t *) &ri->data[offset];
-        uint64_t val =3D be ? htobe64(value.data.u64) : htole64(value.data=
.u64);
         if (is_store) {
-            *p =3D val;
-        } else if (*p !=3D val) {
-            unseen_data =3D true;
+            if (be) {
+                stq_be_p(p, value.data.u64);
+            } else {
+                stq_le_p(p, value.data.u64);
+            }
+        } else {
+            uint64_t val =3D be ? ldq_be_p(p) : ldq_le_p(p);
+            unseen_data =3D val !=3D value.data.u64;
         }
         break;
--8<---------------cut here---------------end--------------->8---

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

