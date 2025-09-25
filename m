Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E84A9CAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 10:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1j80-0008TN-Vb; Thu, 25 Sep 2025 06:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1j7s-0008RK-Pa
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:23:00 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1j7i-0001Sg-49
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:23:00 -0400
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-45f2acb5f42so3832445e9.1
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 03:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758795762; x=1759400562; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2QzDUteR+xjowiKWpoSco8ZUHq9Qb1QEzYu0uhzs3HY=;
 b=QUizS2c5n/caL5ULjjF7wYFM26M5dcjpv/SZoWQU/vgH+JG79R/JvyHlibOvXAtZ6i
 edKWnhOJT1+8ann5iqTqbcZEvKE2wGUL/BGdtRE/EAHlc+Bn6Ktku29Pm3AAIyhF3DJ6
 NWhygyuHaaqjO2roWVsV/1/9ta2gkSpwQ2BvxGjDsmvPPmv1vOEle4r+gPUN8yizfrCq
 E63hIlkcBHmU4cccxN+Vnirv0udmoLjHQuIH5JfRMuDryVhmxyR+FyXzPdpLQMLdMs3S
 BYqnSU7xkLMXKxV7kMUtlnzlWH4vEXmDKrUCnSb3NvDZVx5++WRaiypht86g8cTvOy8G
 jupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758795762; x=1759400562;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2QzDUteR+xjowiKWpoSco8ZUHq9Qb1QEzYu0uhzs3HY=;
 b=sg80ONg3ixiQe9QJOmbsGnl9j1Ce3Z6VZ7ee6+im7k2dLqV3AzmBCygnFm/F5S+doa
 LUolobUgcvdeBGK4Yzsqob3vFa9aaeDOvGHnaM0NFb3odIvP/ly60zUH5/koUsssETQf
 qb4uEpLXdWYejJDOlTNAnRZG3YdglQAJS/FM9QLWuyRiccj8UGxpkieQBARdBy4CnDq/
 b363Yud+Wda1rQWXIV84czEh+L88iuvkWB4Y9dDupxoiO5yTJMnUrl+T1A6gISslK/f0
 K5PNJ3nzKjyYPzXWCfotT/pWzpAqNMsN3NhX/4vnW81ElHFOsp7vHfr+DNNes7/a3pqK
 E4pQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRKk5ac0H7AgZK/kLV4X1UbsXYeyCutl+XyVayT5V+rRYRO5q2n95/C73WufmXjwugmF5gE7zE0rDy@nongnu.org
X-Gm-Message-State: AOJu0Yw1KYFBF5t4QSmBvmvVTFzHs026x3dC1JNAPbD7Wt8vrI9BSi2t
 JRzSTuX3ciJP+Ng0D4EMjpwJu25qMCLUk5GsoPFqVZ+4D8F3ywjk6EJHCgylONV1ZaE=
X-Gm-Gg: ASbGncvQDPmbe5XsCk5BLFqqAASQDVX6G/Ly0o8rwZfRByUOwKu0PdXWq/BtC0uJJkJ
 +kYfP7L+yT384kLa+4pAifDSspAvCn/1sJUVU/smRy86yW1R2xLFDtRpRYPSALDMCn2RSAeHdID
 xcZGF6WgQxVH5CZ+actm10TkUEGgMLNW8oa6vooPP88NQTLUSILpYzVgkEb/gWssQbXFjKho4Bk
 +u5r7F4nnuflrYi+5k80y2S8wbTQ0rO3RRaWJ2MG9zb0PSuP7uM6/UycTKYw/wgKhzUKXP4iKD0
 MG3B9LVnMAOb6fJVG1trMmZ6Uwz+fQP/L5Zq0GL5AFRRcHIjgr5YKshK3zWqQlpw58w5N8rw1q7
 ikrwpB1yBFNMcVY/v9RrsxOPKAme9qU2+35nJtkx1AbrnlFmBd0Qylwa56DokpZl7MOCCJ/Zi/A
 D5
X-Google-Smtp-Source: AGHT+IGMdaAY/75NRHc0c8phlEuXfXW71zjvHSfAhhx1pufav5/IeGe15UhNvIxOjxP9unFSsZQS6w==
X-Received: by 2002:a05:600c:8b23:b0:458:b8b0:6338 with SMTP id
 5b1f17b1804b1-46e33c4bd45mr24167315e9.6.1758795762289; 
 Thu, 25 Sep 2025 03:22:42 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc8aa0078sm2337301f8f.59.2025.09.25.03.22.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 03:22:40 -0700 (PDT)
Message-ID: <3d77f02a-5e89-432b-8be1-d76df49b90e2@linaro.org>
Date: Thu, 25 Sep 2025 12:22:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/23] util: sync error_report & qemu_log output more
 closely
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-rust@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, devel@lists.libvirt.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250925094441.1651372-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250925094441.1651372-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x341.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Daniel,

On 25/9/25 11:44, Daniel P. Berrangé wrote:
> This series is a tangent that came out of discussion in
> 
>     https://lists.nongnu.org/archive/html/qemu-devel/2025-08/msg00903.html
> 
> In thinking about adding thread info to error_report, I
> came to realize we should likely make qemu_log behave
> consistently with error_report & friends. We already
> honour '-msg timestamp=on', but don't honour 'guest-name=on'
> and also don't include the binary name.
> 
> As an example of the current state, consider mixing error and
> log output today:
> 
> - Default context:
> 
>    # qemu-system-x86_64 -object tls-creds-x509,id=t0,dir=fish \
>                         -d 'trace:qcrypto*'
>    qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x55ac6d97f700 dir=fish
>    qcrypto_tls_creds_get_path TLS creds path creds=0x55ac6d97f700 filename=ca-cert.pem path=<none>
>    qemu-system-x86_64: Unable to access credentials fish/ca-cert.pem: No such file or directory
> 
> - Full context:
> 
>    # qemu-system-x86_64 -object tls-creds-x509,id=t0,dir=fish \
>                         -d 'trace:qcrypto*' \
>                         -msg guest-name=on,timestamp=on \
>                         -name "fish food"
>    2025-08-19T20:14:16.791413Z qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x55e9a3458d10 dir=fish
>    2025-08-19T20:14:16.791429Z qcrypto_tls_creds_get_path TLS creds path creds=0x55e9a3458d10 filename=ca-cert.pem path=<none>
>    2025-08-19T20:14:16.791433Z fish food qemu-system-x86_64: Unable to access credentials fish/ca-cert.pem: No such file or directory
> 
> And after this series is complete:
> 
> - Default context:
> 
>    # qemu-system-x86_64 -object tls-creds-x509,id=t0,dir=fish \
>                        -d 'trace:qcrypto*'
>    qemu-system-x86_64(1184284:main): qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x55a24ad5cb30 dir=fish
>    qemu-system-x86_64(1184284:main): qcrypto_tls_creds_get_path TLS creds path creds=0x55a24ad5cb30 filename=ca-cert.pem path=<none>
>    qemu-system-x86_64(1184284:main): Unable to access credentials fish/ca-cert.pem: No such file or directory
> 
> - Full context:
> 
>    # qemu-system-x86_64 -object tls-creds-x509,id=t0,dir=fish \
>                        -d 'trace:qcrypto*' \
>                        -msg guest-name=on,timestamp=on \
>                        -name "fish food"
>    2025-08-19T20:12:50.211823Z [fish food] qemu-system-x86_64(1168876:main): qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x5582183d8760 dir=fish
>    2025-08-19T20:12:50.211842Z [fish food] qemu-system-x86_64(1168876:main): qcrypto_tls_creds_get_path TLS creds path creds=0x5582183d8760 filename=ca-cert.pem
> +path=<none>
>    2025-08-19T20:12:50.211846Z [fish food] qemu-system-x86_64(1168876:main): Unable to access credentials fish/ca-cert.pem: No such file or directory
> 
> The main things to note:
> 
>   * error_report/warn_report/qemu_log share the same
>     output format and -msg applies to both
> 
>   * -msg debug-threads=on is now unconditionally enabled
>     and thus the param is deprecated & ignored
> 
>   * Thread ID and name are unconditionally enabled
> 
>   * Guest name is surrounded in [...] brackets
> 
>   * The default output lines are typically 15 chars
>     wider given that we always include the thread
>     ID + name now
> 
>   * This takes the liberty of assigning the new file
>     to the existing error-report.c maintainer (Markus)
>     Since splitting it off into message.c instead of
>     putting it all in error-report.c felt slightly
>     nicer.
> 
> One thing I didn't tackle is making the location
> info get reported for qemu_log. This is used to
> give context for error messages when parsing some
> CLI args, and could be interesting for log messages
> associated with those same CLI args.

Testing with this change on top ...:

-- >8 --
diff --git a/include/qemu/message.h b/include/qemu/message.h
index 2cc092c993b..97fd2a94fbd 100644
--- a/include/qemu/message.h
+++ b/include/qemu/message.h
@@ -10,2 +10,3 @@ enum QMessageFormatFlags {
      QMESSAGE_FORMAT_THREAD_INFO = (1 << 3),
+    QMESSAGE_FORMAT_VCPU_ID = (1 << 4),
  };
diff --git a/system/vl.c b/system/vl.c
index bf9f80491f2..2f43a075be9 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -149,3 +149,4 @@
      (QMESSAGE_FORMAT_PROGRAM_NAME | \
-     QMESSAGE_FORMAT_THREAD_INFO)
+     QMESSAGE_FORMAT_THREAD_INFO | \
+     QMESSAGE_FORMAT_VCPU_ID)

diff --git a/util/message.c b/util/message.c
index 7d94b9d970d..19d1331403a 100644
--- a/util/message.c
+++ b/util/message.c
@@ -6,2 +6,3 @@
  #include "monitor/monitor.h"
+#include "hw/core/cpu.h"

@@ -46,2 +47,8 @@ void qmessage_context_print(FILE *fp)
      }
+
+    if (message_format & QMESSAGE_FORMAT_VCPU_ID) {
+        if (current_cpu) {
+            fprintf(fp, "(cpuid:%d): ", current_cpu->cpu_index);
+        }
+    }
  }
---

... on a branch where I test heavy vcpu context switching.

When using tracing + stderr AND the stdio console, I sometimes get
the trace events to disappear at some point. Not sure why (or if related
to my branch) yet.

When redirecting traces to a file ('-D foo.log'), all traces are
collected (no hang).

In both cases I notice a high performance slow down (when tracing is
used).

Suspicions:
- flocking
- new formatting

Regards,

Phil.

