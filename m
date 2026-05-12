Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6530CD37BE
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 00:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMbNx-0000EH-LG; Mon, 11 May 2026 20:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonynpavlov@gmail.com>)
 id 1wMbKr-0008KE-PP
 for qemu-devel@nongnu.org; Mon, 11 May 2026 20:50:57 -0400
Received: from mail-vs1-xe2b.google.com ([2607:f8b0:4864:20::e2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antonynpavlov@gmail.com>)
 id 1wMbKp-0005Zh-1w
 for qemu-devel@nongnu.org; Mon, 11 May 2026 20:50:56 -0400
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-6314c3818baso2124948137.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 17:50:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778547053; cv=none;
 d=google.com; s=arc-20240605;
 b=jcs5xh5DcFK/Hz0WbJ8+Ys9PwtXY7k8eaXA2e9+fFx7/oy/7RkvTX38ohyRvfMvMB+
 Y1RE9dyNP0Vw10CJ+99bpU+IDM3O289c3TaBBpzdf6IlXesESwTOPXNLjgRRN/mwI8Cm
 YCDJx2+aAv3LUjSGGq1/BAVphNyLmFC8mpEBRmh1ZlZXp1U9DJEpzVP4S9Sp3ISxQUQr
 bEDnZJ3BxsnptJNq+ZdjuC1x0TdgOySK/NmJRS6AQHJapKF0SukGzzF+0AmIxmh9FTWW
 iEKSDLrSPl3664fLqwGlMZ2ztyWU3oEgMLScY+/8A6RoBUC2y7QOxpToCZgY46cFiCjQ
 /GnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=WcGoGMYiUkjUlPRN/Opamm5gtOiOqKXrotTZLpGctVo=;
 fh=4aV1rm4a/Dkjv/LGzNzuz6EiqO6Ypsq/6FzN7byofjE=;
 b=F4jSWewsXWJ7J4Ghjc/XUvyDkH1pNb4ZEt2S3vJ3n4NwHygwyicAbpZtHqWf+OWJpo
 FNb2GPgYO8wvu+0GNOveg8WQ+poTfEJpIOkWVYXt/3kErE4sPB838xui7swtEP1+G/CL
 9Wg99RuwfytXwG8PYd+i1CJGK+CheSeO6OSinotpkzHL3SvGLGd7RwChB0ZbuBKPB785
 n38VhcpUObGBkjYJCgTZncxj+pVwFF7/qIZGQ3SOO1mybGiPIwrkUeJjbeUsDeuYFTEF
 0Unlbs6UB7hDd178vPW4M5tT8eopzNdoKaoka4F7RwLK9aPlUMR3ae6DbK4ehWxWbuEF
 5M8Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778547053; x=1779151853; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=WcGoGMYiUkjUlPRN/Opamm5gtOiOqKXrotTZLpGctVo=;
 b=cS3RccwGsGMyziqHgrqKlzBi6Y7CCAo5RKkI/eWSIL+ShpNE5VD2fhq32w2ZIHHriA
 wT8vrrfwvLBdG8C5saqLSSWciCMD87e2bwYuK9pXNwCLTDiHyVFkbDcQSZ5s5vFNoU6q
 Tjy7QSM7SbnJcBDKZuks5vpR37jfxvhdKSNRTYOURXlODLotERyLZZZzry0A0PXf+OnI
 9pXeyqKGaVdvgzX15c2U3JpCx0ccizATxY5e5DiDWBBWTvjH5a34yOJ47N3QHVenDXNn
 THG57+aJxH03RpjAkGAV9wQo03bx/QNUVnOWMEspyTBRVUuo2COYZj2qw8O662+xzv8I
 ddZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778547053; x=1779151853;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WcGoGMYiUkjUlPRN/Opamm5gtOiOqKXrotTZLpGctVo=;
 b=BoBco/y5Vo1MPobaTYuky4f8n7DxdvdLruFSoPe9eDuVtlIQQ1hHm1Xkd9rwYZVWUX
 j59kYUeKK65JJBUzhH6E5qvAK+bq5rgG7mWDiHWgCSxFR5a3FEUlvhIcaX5k20NahKBW
 bhIPD9RYtCG3qLIU0aAyv4iINOK3gmmVmTMeM6oc5ViS25OeQ1Mc0je35oRVf5Ji+x/B
 b+P4QyIPbSVTXxRBOtDPx49p0Omu2mCX6X49UIqTKEXdykStTg+hOUKBQT15ljIr2Lk+
 2La7uQIL+iRI680i0e6o6ih6uTUGNcA/p6Pa7+pxZhbUKiPDuK5AxhOu2b5DDeMwBD38
 UJzg==
X-Gm-Message-State: AOJu0YyrIYFdYUBDwcR9rgDmAdDItxyWfwuUuOD3Y9bSALbln5sXdnVd
 cBd6DLDUlfeLLPsKxEvPF+GVFYOVWLQeJ9KjkPn84e8dojqAiJrJzcI27oVB2aQvf/DVYN2S0Pg
 wMF8X7H+YCHk9WynoG/6VhQLOKY2JrrE=
X-Gm-Gg: Acq92OEZ+LTdJ78jIFPvadhySaG6wDBGAh3WffMkAKvYrDb2o+qHvFEkBr9U5XBnZra
 /rWcBKDY9WV0Nv5y+inJPC0G8G2mJ4q90bCb1GvZrHhKAfV52ziO5PbcfH1MeyAAfNi1/0aPaUh
 rs9l4PLaxo8H9COQXRC9LJRBday3sRRX3XWzc7WXtzYYAVz9FdGwf4Ng0gxelPONJzS0prsOZnN
 r1NfrlrSmxVae1opdCFbfH2dq+Qk0HI6hXcMqu800rtMtAZTGXYBs6hy4prHLuLrZ/ftTIPI/1P
 CoOpFZs=
X-Received: by 2002:a05:6102:3e10:b0:611:3bcb:aee5 with SMTP id
 ada2fe7eead31-630f8c42570mr12792497137.0.1778547052866; Mon, 11 May 2026
 17:50:52 -0700 (PDT)
MIME-Version: 1.0
From: Antony Pavlov <antonynpavlov@gmail.com>
Date: Tue, 12 May 2026 03:50:29 +0300
X-Gm-Features: AVHnY4IDtxg25AxwjAG0kPonG5ORz8ZDdFugJqkITJqw2Dhk3YDZGWxl7n7awTw
Message-ID: <CAA4bVAFS4aRjW7On7C0Y5MQH94TmLfXMwcD+8dWzKBD4JZL3Fg@mail.gmail.com>
Subject: target/riscv: rdcycleh problem
To: Alistair Francis <alistair.francis@wdc.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2b;
 envelope-from=antonynpavlov@gmail.com; helo=mail-vs1-xe2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 11 May 2026 20:54:08 -0400
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

Hi!

I use qemu-system-riscv32 v11.0.0 for running this code:

    15258:    c80025f3    rdcycleh a1
    1525c:    c0002573    rdcycle  a0
    15260:    c80027f3    rdcycleh a5
    15264:    fef59ae3    bne      a1,a5,15258

The code is recommended by riscv specification for reading 64-bit
cycle counter on 32-bit system (see
https://docs.riscv.org/reference/isa/unpriv/counters.html#7-1-1-zicntr-extension-for-base-counters-and-timers
for details).

When running on qemu-system-riscv32 both the rdcycle and the rdcycleh
instructions read low 32-bit of the cycle counter so the branch
instruction always go to 15258.

This quick and dirty patch fixes my problem:

--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1389,8 +1389,11 @@ RISCVException riscv_pmu_read_ctr(CPURISCVState
*env, target_ulong *val,
      */
     if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
         riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
-        *val = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx) -
+        uint64_t t;
+
+        t = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx) -
                                                     ctr_prev + ctr_val;
+        *val = extract64(t, start, length);
     } else {
         *val = ctr_val;
     }

Have you any suggestion?

-- 
Best regards,
  Antony Pavlov

