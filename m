Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E13BBCCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 09:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8FHc-0005XV-Lw; Mon, 13 Oct 2025 05:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1v8FHW-0005X4-Ks
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 05:55:57 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1v8FHR-0000QB-KS
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 05:55:54 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-46e42fa08e4so35374095e9.3
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 02:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760349345; x=1760954145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YWXK7vYDauy0slYNRqT/3zWRydScEQRYvgw8mQT6ySs=;
 b=MBq5rTv/c6LkXsY8ugGwOZ2g1a49jNDw5BvA6IrFbqqg/m+tOzXZ/ArmbuCshWLEJ6
 ksnHTVPh/Wib501J6rIvSA9Qz5RuhMQFg00pdNcTXHypoAWgQxRAZrcsO+ciqufs6UUz
 q9wkXbXXK4Zx3jvOuZxfw4APJswPUz9Jz1mS1eKA59JjOpUpdq8OuDpl4ZkQzWF57gl8
 lou/C8lDbekB6PZrcZ5Dzs1a4er2fvN0VRDXGrgQ3IVuQIM17BZQbBsRAwUvAenYCGAW
 2Gg7qSOic2qcey8yeuwhI0sGrqGPBQ0HQUKo4jJl4JpTY0YOo5p0aVvR11QGYW26w6Ft
 O8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760349345; x=1760954145;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YWXK7vYDauy0slYNRqT/3zWRydScEQRYvgw8mQT6ySs=;
 b=N0J5MV7uhIa3Z6PeBGT2LwLD9ZuXuH83a+ou3JDa8DnKgA7D5ChuF+70DBUNMo5XK6
 Htg2jfgpim4CWV0Cg02/FaeUjCRg6dYZU4KczUBSWZWYLHW8hs1xky8X0OWgaIQ8OHxD
 y6h8Y1/Es0t3t4aWWaVtfmLMHr7Jiw6FpXa+xCOa7t0b/Ugif/m5MM8/XEDI/9JgsqUX
 XOxLNTDwNPXnbG/sbWwObTLtmz+DVwZPMDdTockO0wiYb/EAjjPLLI8SLWzsNmrmVnHc
 E5K6YNNgxrUY0t5muSzqti+hqtp8OlPCXFAMwvYkUtwDzZyL74NSj6Eyer+OlramPh05
 NZaw==
X-Gm-Message-State: AOJu0YzN+HS/rg7NfgQKzDyhnXyE6ZCQ4LY7zzscPSaZNYmaak4foZum
 CGnJTtVw5CtvaSLv1wwA1wwn/vnP+mNadEm+dgaZmcHuAr66+0QOP/3VHPutpQ==
X-Gm-Gg: ASbGncu18mQMMlKCs8zDXTBY7FyD+6G+JFZJjaQszYFuADnqAO9/H+o8wgX6/6Z3N+s
 dZOXn4gLDnOZ23OkaYc7jzbGpaBomb209FdBm3T9tRTiycwlzzmtY6TGMe7PLNsDqjWCwAIeNhb
 tMu+ktlX0NP3BUdHLCrYEJJr7M2LJJCk2M33iwzAna2XyaxS1zMuULHh1odiZDQpcuDjnknzpUC
 KV0TF3tBz347dV5Rk94rP169QU9VmT+PKt9193YJjYm3PZUu49dP6ilwwaKvcWRfUa3uvG4vSqV
 APLuWUwb40KfXACEckAZo2eCl4bmbQp8NqTo1bfEVVaBu0g7yjWeHvDnSDi2/WH/YRNA4dgfjWh
 qr2Fhshad4Wbx5pfAqWtxE8RXfZVMNaEWCJOMoZ0ya6K9norm3KtiVZGEQoM1pdbufiALSXA9mH
 chKRjX4u5Gw1BkXyf7BO9u+jEQrems2/GtTrWEQQ==
X-Google-Smtp-Source: AGHT+IG9fZby8ByAqo6n2LXALrn9JnVLZJ+k6mwJsQ/xtgubPffwHotRzGUiLXhiW32PMADwQYBIlQ==
X-Received: by 2002:a05:600c:5028:b0:46e:428a:b4c7 with SMTP id
 5b1f17b1804b1-46fa9af2ff1mr139812295e9.23.1760349344435; 
 Mon, 13 Oct 2025 02:55:44 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (p200300faaf271400a0afdc243fcb5392.dip0.t-ipconnect.de.
 [2003:fa:af27:1400:a0af:dc24:3fcb:5392])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb48a5bf9sm179028265e9.18.2025.10.13.02.55.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Oct 2025 02:55:44 -0700 (PDT)
Date: Mon, 13 Oct 2025 09:55:41 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
CC: richard.henderson@linaro.org,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: =?US-ASCII?Q?Re=3A_=5BPULL_09/13=5D_ui/pixman=3A_Consistent_err?=
 =?US-ASCII?Q?or_handling_in_qemu=5Fpixman=5Fshareable=5Ffree=28=29?=
In-Reply-To: <20250930124653.321609-10-armbru@redhat.com>
References: <20250930124653.321609-1-armbru@redhat.com>
 <20250930124653.321609-10-armbru@redhat.com>
Message-ID: <957601F2-78F5-4AD5-A6C2-CAFE49A97E84@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 30=2E September 2025 12:46:49 UTC schrieb Markus Armbruster <armbru@red=
hat=2Ecom>:
>qemu_pixman_shareable_free() wraps around either qemu_memfd_free() or
>qemu_win32_map_free()=2E  The former reports trouble as error, with
>error_report(), then succeeds=2E  The latter reports it as warning (we
>pass it &error_warn), then succeeds=2E
>
>Change the latter to report as error, too=2E
>
>Cc: Marc-Andr=C3=A9 Lureau <marcandre=2Elureau@redhat=2Ecom>
>Signed-off-by: Markus Armbruster <armbru@redhat=2Ecom>
>Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre=2Elureau@redhat=2Ecom>
>Message-ID: <20250923091000=2E3180122-10-armbru@redhat=2Ecom>
>Reviewed-by: Akihiko Odaki <odaki@rsg=2Eci=2Ei=2Eu-tokyo=2Eac=2Ejp>
>---
> ui/qemu-pixman=2Ec | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>
>diff --git a/ui/qemu-pixman=2Ec b/ui/qemu-pixman=2Ec
>index ef4e71da11=2E=2Ee46c6232cf 100644
>--- a/ui/qemu-pixman=2Ec
>+++ b/ui/qemu-pixman=2Ec
>@@ -288,7 +288,10 @@ qemu_pixman_shareable_free(qemu_pixman_shareable han=
dle,
>                            void *ptr, size_t size)
> {
> #ifdef WIN32
>-    qemu_win32_map_free(ptr, handle, &error_warn);
>+    Error *err =3D NULL;
>+
>+    qemu_win32_map_free(ptr, handle, &err);
>+    error_report_err(err);

The last line causes a crash on Windows since error_report_err() expects e=
rr to be non-NULL=2E This can be reproduced by invoking `qemu-system-x86_64=
=2Eexe` without any parameters in msys2=2E Removing the line fixes the cras=
h=2E I'm not sure how to fix this, otherwise I had went for it myself=2E

Best regards,
Bernhard

> #else
>     qemu_memfd_free(ptr, size, handle);
> #endif

