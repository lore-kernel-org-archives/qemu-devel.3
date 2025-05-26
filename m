Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFFBC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 18:11:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJcHv-0006D7-8R; Mon, 26 May 2025 14:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJcHu-0006CJ-1Y
 for qemu-devel@nongnu.org; Mon, 26 May 2025 14:11:02 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJcHs-0005f6-Aw
 for qemu-devel@nongnu.org; Mon, 26 May 2025 14:11:01 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-442f5b3c710so23848105e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 11:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748283058; x=1748887858; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4hX3H0nQ/uRGryOBXGKaAFz/GEsqKixCKRGKQGRw0Nw=;
 b=nT81NrpGXVdccROxwdR8gos0NNTFq/bs4zKeNjJOswOV67wZTP6RIL8/VlK1fOdTI2
 tlKSMolL+MvkNOjHYsqAWfYf6xcv8CJjDi5y9BpLL2XPstjylyevyxET5+TBTWCbJcNo
 gOWzW0xrVcvtOXnQaByleuTx0ZlbUlm5G3dHlvjDqgvs3pbMXUdSgG6ua4qrxvf13h9J
 ws1K139Q29fyhh816CacIkXpbEb4JkxkEEBlAlAXxKey5fcZ4nSxxNNpQMH0qBiMCerv
 1jwIzNPKGcbFkZ7iyB1Fr2x+izP+gygQrwC3OOdj6KwtnwKOThySl8LSYcGmFo9iP7zm
 b8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748283058; x=1748887858;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4hX3H0nQ/uRGryOBXGKaAFz/GEsqKixCKRGKQGRw0Nw=;
 b=DFru7ajbwvbQJnOUGtkV9TCzDpy+KVUQCFfAQY6QqdRXjMTfHEbECSIPotPizYGUqp
 /vkDDGoN3LZ0S+n655MEq9v6sRV/VTpDWAZClmkh23LTCdOcyYdfgh2feQYrDqyCwoxa
 A+TMp7fllPfSg5jOv4v+QrBcydOOsdJ72R8N9sLQokvRmxScqgbdD/oiRoUYH6tTgye5
 P2+aYqsyistC97x2zpXlK9RFAtq6qMNXff1Veycl1GcaT/swtvv3T6zLGpzOeVhRvSsp
 2W7Sz8hoaTQU6kJ83s5cnjFdC5moDX924n0yWdB8kSiOAym/jvMXTg+ZedZ2jBJ/Ka/c
 E+kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQZWKj+I25/376Rs94W0qpPELjKYAemXDGx0cREEOi3AAzmix5lOz0VwPlrwixITgaocpT7rI9Uwu3@nongnu.org
X-Gm-Message-State: AOJu0YxkuWrrugauMLATSx2cEW1HoE07RP3S1Z1EK1OGtDQKy4VScrpO
 GXg/Gx5ivcpoJs1/AsBkbsdc+gO3q/7epMOEtvg3rXun0L3NYyE3XMyymLN0qh1Apz3/bEhXwrv
 0GmzSsb0=
X-Gm-Gg: ASbGnctKrQXLCWbohawEX9rxFmYoEpFlOjwnKn6C1Mcd9CMUnd8DcSegDRL84wjWwR6
 xJV8MyNSnd9smz4o8waHaCUs3qcyW8PXGj6XuvqYjRGE2E1ot1pwsyXjh5lqF8qrhmdKH2Ouq+o
 tz3kTeLpRAHB9qem676jyrlxR93gHD5U39NkDF8DEQqqwvRfucKRoxrDDgWt9V3XyUvqC1tlW0t
 gHUBLuo4bgByvpKnYPSm2YvNS+MnFxtcNw82/x3NAug2ILVON9qENDSRqsWNH3v3z2x/u0B3Gef
 dAeB0yXvFXs2jiz+Gt1VPfS/LWxK5DPBQzGaQGEZv3UzfNvRpwTcMCYOPsnI/8Fy8fM0jGjD3Kc
 j884xjKtxtSeZvnFqnicqkYBF
X-Google-Smtp-Source: AGHT+IFFgr/ne1qcBJDMbJQAu1YEVf6uq+N/Ex3btwBHU7LvVD1MvYujkqcNtnDbggk9BtKqdPocFQ==
X-Received: by 2002:a05:600c:3849:b0:439:6118:c188 with SMTP id
 5b1f17b1804b1-44c91dd166bmr82436095e9.19.1748283058397; 
 Mon, 26 May 2025 11:10:58 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f38142f1sm243665085e9.31.2025.05.26.11.10.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 11:10:57 -0700 (PDT)
Message-ID: <3a7386f9-a4ba-4268-a3fe-45c18360d878@linaro.org>
Date: Mon, 26 May 2025 20:10:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/xen: Fix trace_xs_node_read() params
To: Liam Merwick <liam.merwick@oracle.com>, dwmw@amazon.co.uk,
 anthony.perard@vates.tech, roger.pau@citrix.com,
 xen-devel@lists.xenproject.org, qemu-devel@nongnu.org
References: <20250523160134.218997-1-liam.merwick@oracle.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250523160134.218997-1-liam.merwick@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 23/5/25 18:01, Liam Merwick wrote:
> When the '--enable-trace-backends=syslog' build option is configured,
> the following compilation error is encountered.
> 
> In file included from /usr/include/sys/syslog.h:207,
>                   from /usr/include/syslog.h:1,
>                   from ./trace/trace-hw_xen.h:224,
>                   from ../hw/xen/trace.h:1,
>                   from ../hw/xen/xen-bus-helper.c:13:
> In function ‘syslog’,
>      inlined from ‘_nocheck__trace_xs_node_read’ at ../hw/xen/trace-events:41:9,
>      inlined from ‘trace_xs_node_read’ at trace/trace-hw_xen.h:903:9,
>      inlined from ‘xs_node_read’ at ../hw/xen/xen-bus-helper.c:154:5:
> /usr/include/bits/syslog.h:45:3: error: ‘%s’ directive argument is null [-Werror=format-overflow=]
>     45 |   __syslog_chk (__pri, __USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
>        |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Add a check that 'value' is not null before passing it to trace_xs_node_read().
> 
> Fixes: e6cdeee95990 ("hw/xen: Add xs_node_read() helper function")
> Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
> ---
>   hw/xen/xen-bus-helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/xen/xen-bus-helper.c b/hw/xen/xen-bus-helper.c
> index 288fad422be3..1087a585cc71 100644
> --- a/hw/xen/xen-bus-helper.c
> +++ b/hw/xen/xen-bus-helper.c
> @@ -151,7 +151,7 @@ char *xs_node_read(struct qemu_xs_handle *h, xs_transaction_t tid,
>       va_end(ap);
>   
>       value = qemu_xen_xs_read(h, tid, path, len);
> -    trace_xs_node_read(path, value);
> +    trace_xs_node_read(path, value ? value : "<null>");
>       if (!value) {
>           error_setg_errno(errp, errno, "failed to read from '%s'", path);
>       }

Alternatively, since this is an error path:

-- >8 --
diff --git a/hw/xen/xen-bus-helper.c b/hw/xen/xen-bus-helper.c
index 288fad422be..1e49e60e147 100644
--- a/hw/xen/xen-bus-helper.c
+++ b/hw/xen/xen-bus-helper.c
@@ -143,7 +143,8 @@ char *xs_node_read(struct qemu_xs_handle *h, 
xs_transaction_t tid,
                     unsigned int *len, Error **errp,
                     const char *path_fmt, ...)
  {
-    char *path, *value;
+    g_autofree char *value;
+    char *path;
      va_list ap;

      va_start(ap, path_fmt);
@@ -151,12 +152,11 @@ char *xs_node_read(struct qemu_xs_handle *h, 
xs_transaction_t tid,
      va_end(ap);

      value = qemu_xen_xs_read(h, tid, path, len);
-    trace_xs_node_read(path, value);
      if (!value) {
          error_setg_errno(errp, errno, "failed to read from '%s'", path);
+        return NULL;
      }
-
-    g_free(path);
+    trace_xs_node_read(path, value);

      return value;
  }
---

But your patch isn't wrong, so:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


