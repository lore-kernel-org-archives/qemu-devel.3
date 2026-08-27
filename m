Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D307C61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 10:46:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzXcI-0007PJ-4Y; Thu, 27 Aug 2026 06:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wzXcE-0007P5-Og
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 06:45:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wzXcC-0000Us-93
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 06:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787827547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AC3RLjCOUFMTst1pulqeCXKINUPqB/uS2qSeBSIhOcE=;
 b=FrDwcOXcB6L5UYsWxgaCG9KTl3SIo7WnXGiccon1diw8cyXsq4VGhXjHFuch5KH311i4p2
 gQvesEZwPSSZ0QFnGQqdK2pLRA1cPp7366EWUHuv5qtgzwp6k89kRwFefI1nz9lTfiaxdT
 zfk6bjYc+obiDo/uvAKujzGvVwwDXFw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-HrwbUtMvMeaLYGAwajW1-w-1; Thu, 27 Aug 2026 06:45:44 -0400
X-MC-Unique: HrwbUtMvMeaLYGAwajW1-w-1
X-Mimecast-MFC-AGG-ID: HrwbUtMvMeaLYGAwajW1-w_1787827543
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49953abe51fso12671065e9.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 03:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787827543; x=1788432343; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AC3RLjCOUFMTst1pulqeCXKINUPqB/uS2qSeBSIhOcE=;
 b=galtyZ23CPZEgfBLmNj4DCyMH0JxEtCkgu3cBt6WWL6kA2a/ab7kNzcrGppt28plJ8
 3CiKjQhwocngRAwMZWQ7pajTdNhrhwO4MKEBajSygywF0giRy5d69wBgejvSQHy6DlXF
 Z7Jj4hdTvJN4Kpo52Xt1KTsbnOV28FTdBidliMVdVrDjb9WcQ3KELAgNaSGACUNLq4Y4
 Yb4zKSBROUAS+v2NLSq2q1ugyPNjvNs+tXfSRBzbp1xWuvSpJ3PNKGXfqQxqSJkOrcAr
 bmjzoJam7sVVytLGdJ3ee3S0QPN3qAwmzDJ+Uw1NeF+n5Mkus5fjdP9JiRL9vk/mHzkW
 kY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787827543; x=1788432343;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AC3RLjCOUFMTst1pulqeCXKINUPqB/uS2qSeBSIhOcE=;
 b=nW5vHP6ZOv00a/u1sJJeDQpCC8ytieEHSKulLJkNwVEjAqcmtxEvshUXkM+8x6GwoL
 TKXsoyvbKGUVa5bLL1SJaggKU8YOeKMh8V7LNV1XjkL7aYCCarMr9iS1K7UK77NS+FiY
 U/KEFkoJlMIhaUlfpdZeQc7KXJxmBuoHYWB9LorG8TZpVw2v6inCS9dRobscDmRHhLFH
 DcxdpqcoL+frOutvWUGQeIA7NA1YT0PVOJlUrh+bvqOsZXYYskO6V7xR6Pkd+A/prBCk
 S7Be55nVhuzZg20dCmnGcc11JZ/wcDrSCNpB1kRtphsp89uCbmxm1AMQHtkvQsI8zoF6
 Rnxw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqiljlwz+qrItbFU56euuub3IvkjkXQ8VepvyHfD0CP/shsWzlfNV60b+A8yy3Jjvu/oC1FdUMj+BEM@nongnu.org
X-Gm-Message-State: AFuF++lDrB6ZXlpNSfCGIeIqFnVCTqkK0S0XM7NfhX6B9Nc+mknU/8kB
 GD8Ih8G9WUZdgKqKGV2BAxc42dklDNJylHmgk1RVD/bpvMuBKsjig/owuxY0VWGREGl3XlJ2YsM
 xfX2Ttl7JMD+Hetyh1NeAK0y/sj0VeIbqxIbqzh/+qtL2aKvNZ/cBE6NP
X-Gm-Gg: AR+sD12aB+rKl0kr4cIYCNDQLlK60iNvCAgbYmhKcsSL86yutkoSuq+IpE4SJ+TSaZ7
 fGCvX//L6QJa8Ufug89BiXgCuDQP+GMLcwxCKyeHHEXEfpwWNM62xvJPBS1iYssXNXS03/iKqVf
 +TXgp2ySJufF6sTvYwOztSy0zx405hR7TDPT3Yfy3s2X8t9i2NuiwFHMZGEotrOKEK0TMpW6pKd
 0TnAsRsF8k7CaXsdRsiIEXwE4DHJuMiz7661EbpwWIrtexG7Kmcml9N+WhSKWoH7yGy5KK6TIhY
 PQ1THofvWImHXFRPNtUdffG49fTw0yToZm75Oabz/K3fJVQAiRfJcXSFI0OfAGf4f0XymoZDGg=
 =
X-Received: by 2002:a05:600c:860b:b0:499:726a:a017 with SMTP id
 5b1f17b1804b1-499dc6e0040mr169537965e9.1.1787827543306; 
 Thu, 27 Aug 2026 03:45:43 -0700 (PDT)
X-Received: by 2002:a05:600c:860b:b0:499:726a:a017 with SMTP id
 5b1f17b1804b1-499dc6e0040mr169537245e9.1.1787827542911; 
 Thu, 27 Aug 2026 03:45:42 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dd5771a3sm56230085e9.4.2026.08.27.03.45.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 03:45:41 -0700 (PDT)
Message-ID: <e9d8c2ad-4412-4299-bb1d-34709b6e42d5@redhat.com>
Date: Thu, 27 Aug 2026 12:45:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 12/25] gdbstub: Introduce GDBFeature structure
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
References: <20231011103329.670525-1-alex.bennee@linaro.org>
 <20231011103329.670525-13-alex.bennee@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20231011103329.670525-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/10/2023 12.33, Alex Bennée wrote:
> From: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> Before this change, the information from a XML file was stored in an
> array that is not descriptive. Introduce a dedicated structure type to
> make it easier to understand and to extend with more fields.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20230912224107.29669-6-akihiko.odaki@daynix.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20231009164104.369749-13-alex.bennee@linaro.org>
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9e7dec4a58..c3cc12dc29 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2842,7 +2842,7 @@ F: include/exec/gdbstub.h
>   F: include/gdbstub/*
>   F: gdb-xml/
>   F: tests/tcg/multiarch/gdbstub/
> -F: scripts/feature_to_c.sh
> +F: scripts/feature_to_c.py
>   F: scripts/probe-gdb-support.py
>   
>   Memory API
> diff --git a/meson.build b/meson.build
> index 79aef19bdc..bd65a111aa 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3693,7 +3693,7 @@ common_all = static_library('common',
>                               dependencies: common_all.dependencies(),
>                               name_suffix: 'fa')
>   
> -feature_to_c = find_program('scripts/feature_to_c.sh')
> +feature_to_c = find_program('scripts/feature_to_c.py')
>   
>   if targetos == 'darwin'
>     entitlement = find_program('scripts/entitlement.sh')
> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
> index 16a139043f..705be2c5d7 100644
> --- a/include/exec/gdbstub.h
> +++ b/include/exec/gdbstub.h
> @@ -10,6 +10,11 @@
>   #define GDB_WATCHPOINT_READ      3
>   #define GDB_WATCHPOINT_ACCESS    4
>   
> +typedef struct GDBFeature {
> +    const char *xmlname;
> +    const char *xml;
> +} GDBFeature;
> +
>   
>   /* Get or set a register.  Returns the size of the register.  */
>   typedef int (*gdb_get_reg_cb)(CPUArchState *env, GByteArray *buf, int reg);
> @@ -48,7 +53,7 @@ void gdb_set_stop_cpu(CPUState *cpu);
>    */
>   bool gdb_has_xml(void);
>   
> -/* in gdbstub-xml.c, generated by scripts/feature_to_c.sh */
> -extern const char *const xml_builtin[][2];
> +/* in gdbstub-xml.c, generated by scripts/feature_to_c.py */
> +extern const GDBFeature gdb_static_features[];
>   
>   #endif
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index 4f3762fccf..bba2640293 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -408,11 +408,11 @@ static const char *get_feature_xml(const char *p, const char **newp,
>           }
>       }
>       /* Is it one of the encoded gdb-xml/ files? */
> -    for (int i = 0; xml_builtin[i][0]; i++) {
> -        const char *name = xml_builtin[i][0];
> +    for (int i = 0; gdb_static_features[i].xmlname; i++) {
> +        const char *name = gdb_static_features[i].xmlname;
>           if ((strncmp(name, p, len) == 0) &&
>               strlen(name) == len) {
> -            return xml_builtin[i][1];
> +            return gdb_static_features[i].xml;
>           }
>       }
>   
> diff --git a/stubs/gdbstub.c b/stubs/gdbstub.c
> index 2b7aee50d3..580e20702b 100644
> --- a/stubs/gdbstub.c
> +++ b/stubs/gdbstub.c
> @@ -1,6 +1,6 @@
>   #include "qemu/osdep.h"
> -#include "exec/gdbstub.h"       /* xml_builtin */
> +#include "exec/gdbstub.h"       /* gdb_static_features */
>   
> -const char *const xml_builtin[][2] = {
> -  { NULL, NULL }
> +const GDBFeature gdb_static_features[] = {
> +  { NULL }
>   };
> diff --git a/scripts/feature_to_c.py b/scripts/feature_to_c.py
> new file mode 100755
> index 0000000000..bcbcb83beb
> --- /dev/null
> +++ b/scripts/feature_to_c.py
> @@ -0,0 +1,48 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +import os, sys
> +
> +def writeliteral(indent, bytes):
> +    sys.stdout.write(' ' * indent)
> +    sys.stdout.write('"')
> +    quoted = True
> +
> +    for c in bytes:
> +        if not quoted:
> +            sys.stdout.write('\n')
> +            sys.stdout.write(' ' * indent)
> +            sys.stdout.write('"')
> +            quoted = True
> +
> +        if c == b'"'[0]:
> +            sys.stdout.write('\\"')
> +        elif c == b'\\'[0]:
> +            sys.stdout.write('\\\\')
> +        elif c == b'\n'[0]:
> +            sys.stdout.write('\\n"')
> +            quoted = False
> +        elif c >= 32 and c < 127:
> +            sys.stdout.write(c.to_bytes(1, 'big').decode())
> +        else:
> +            sys.stdout.write(f'\{c:03o}')

  Hi!

FWIW, this causes a warning on NetBSD:

[913/4769] Generating gdbstub/gdbstub-xml.c with a custom command (wrapped 
by meson to capture output)
/home/qemu/qemu-test.QowHuk/src/gdbstub/../scripts/feature_to_c.py:28: 
SyntaxWarning: invalid escape sequence '\{'
   sys.stdout.write(f'\{c:03o}')

I guess the backslash should simply be dropped? Or duplicated?

  Thomas


> +
> +    if quoted:
> +        sys.stdout.write('"')
> +
> +sys.stdout.write('#include "qemu/osdep.h"\n' \
> +                 '#include "exec/gdbstub.h"\n' \
> +                 '\n'
> +                 'const GDBFeature gdb_static_features[] = {\n')
> +
> +for input in sys.argv[1:]:
> +    with open(input, 'rb') as file:
> +        read = file.read()
> +
> +    sys.stdout.write('    {\n')
> +    writeliteral(8, bytes(os.path.basename(input), 'utf-8'))
> +    sys.stdout.write(',\n')
> +    writeliteral(8, read)
> +    sys.stdout.write('\n    },\n')
> +
> +sys.stdout.write('    { NULL }\n};\n')
> diff --git a/scripts/feature_to_c.sh b/scripts/feature_to_c.sh
> deleted file mode 100644
> index c1f67c8f6a..0000000000
> --- a/scripts/feature_to_c.sh
> +++ /dev/null
> @@ -1,69 +0,0 @@
> -#!/bin/sh
> -
> -# Convert text files to compilable C arrays.
> -#
> -# Copyright (C) 2007 Free Software Foundation, Inc.
> -#
> -# This file is part of GDB.
> -#
> -# This program is free software; you can redistribute it and/or modify
> -# it under the terms of the GNU General Public License as published by
> -# the Free Software Foundation; either version 2 of the License, or
> -# (at your option) any later version.
> -#
> -# This program is distributed in the hope that it will be useful,
> -# but WITHOUT ANY WARRANTY; without even the implied warranty of
> -# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> -# GNU General Public License for more details.
> -#
> -# You should have received a copy of the GNU General Public License
> -# along with this program; if not, see <http://www.gnu.org/licenses/>.
> -
> -if test -z "$1"; then
> -  echo "Usage: $0 INPUTFILE..."
> -  exit 1
> -fi
> -
> -for input; do
> -  arrayname=xml_feature_$(echo $input | sed 's,.*/,,; s/[-.]/_/g')
> -
> -  ${AWK:-awk} 'BEGIN { n = 0
> -      printf "#include \"qemu/osdep.h\"\n"
> -      print "static const char '$arrayname'[] = {"
> -      for (i = 0; i < 255; i++)
> -        _ord_[sprintf("%c", i)] = i
> -    } {
> -      split($0, line, "");
> -      printf "  "
> -      for (i = 1; i <= length($0); i++) {
> -        c = line[i]
> -        if (c == "'\''") {
> -          printf "'\''\\'\'''\'', "
> -        } else if (c == "\\") {
> -          printf "'\''\\\\'\'', "
> -        } else if (_ord_[c] >= 32 && _ord_[c] < 127) {
> -	  printf "'\''%s'\'', ", c
> -        } else {
> -          printf "'\''\\%03o'\'', ", _ord_[c]
> -        }
> -        if (i % 10 == 0)
> -          printf "\n   "
> -      }
> -      printf "'\''\\n'\'', \n"
> -    } END {
> -      print "  0 };"
> -    }' < $input
> -done
> -
> -echo
> -echo '#include "exec/gdbstub.h"'
> -echo "const char *const xml_builtin[][2] = {"
> -
> -for input; do
> -  basename=$(echo $input | sed 's,.*/,,')
> -  arrayname=xml_feature_$(echo $input | sed 's,.*/,,; s/[-.]/_/g')
> -  echo "  { \"$basename\", $arrayname },"
> -done
> -
> -echo "  { (char *)0, (char *)0 }"
> -echo "};"


