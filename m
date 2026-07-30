Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D1CC55160
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 12:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpQ4y-0003iw-SD; Thu, 30 Jul 2026 08:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpQ4v-0003iY-Kr
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 08:41:38 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpQ4r-0005hk-Ni
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 08:41:36 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-81eff3ddba4so31434247b3.3
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 05:41:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785415292; cv=none;
 d=google.com; s=arc-20260327;
 b=nWrCCObJbKFKJT+5soYK9ZFDVYfweEotugNf0Tu8lngPqIyFC358ApmvDNtEWoV7zn
 G9EYfXeAzAyt6yoRdU5qpvM19K1q8FQXL7HH7TRLHOrnHTTJk3EGzzzA0J7SULDJCkjF
 1BNriKpHFkQVnSM5GRFfvKgWmyXYhLkq5LRmVEMnHo+O6pgz1AgMU8AHW58jVI6I+k/m
 NSfCPb+JWB1SeqX4khtSuLmd8p2QBlNuN0Mac4565klrOk3J1Uno+jN3IxB4MXe0dswl
 g60+9NODvzXUvVuI6eiF3wYjI2p7OEDp/F2iBbxSDqKAzZCqLpPp/Yl9FyTnu5hjZmP6
 6R1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vKRFXhqiLoxOpqsybCQzTM2w4BGpVQWtRIrpO0PPqLY=;
 fh=k9GoWKlJEBjvQDcB/yevxqKA/28VWtWL2Zg8N25pNh4=;
 b=WD1QMIxctdK0nCXBysp/j2NpIKHflmvchqyjxmRd0N1BoU/mKrqo2Fx323gWzZc1fj
 +1F0hdLih5cm4REge29aoAz2Ts4fVZtKbYS8kKGizfE7igmkfMCbibENYmB9h9Ptx5jp
 X1S7cAAhc3jCRfoSRQ795h3sDhfi2zMxkwybMHJ56RucemvIUFNSJ21Ha0b5LX9+5LFG
 VAQyR9dCuGcNC47hVJ5hhBzuguC53cszvsxczvjgTOxmmWG+BoJFkl3HSVYHmxfwj2Ov
 9mhO3nl0MP04uATsc04YpDMqZCQrfJkpT0jToO6wjIc7JJGOA43fl+Ru38VBrVJ9Iq3J
 r/4g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785415292; x=1786020092; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vKRFXhqiLoxOpqsybCQzTM2w4BGpVQWtRIrpO0PPqLY=;
 b=XimoECa4cAmoPj+IBWREtVYr5NjJXm45Hv0wDSZyCHSv5Pyx0ZSCMRMGih+a/VbeQ4
 L71cBClwmrsKd7FV+cylfXb7qds45bpadWkmat/rtMhxnQViaRZ6CZs3mxkEKr2lqiwl
 a5EfKpsFLx6NYtCM5Nf2HDkuxFs16LJGmeo1BDcBnpIBF8ghhlOpKepB6+/Jvw0jwclE
 QcAF4OFd5xjO+UgOm5DA87BXkGsVvP6iLfBUFyixuDATF+mc1ZAjtNMHfJDxFNLybPtC
 ZJddI5PSwmCgyacPMoe0mKuVFnqCrUse9IX19s9wYMYYWUQdOCfRlHHTB1MrnFxyRUfH
 NmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785415292; x=1786020092;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vKRFXhqiLoxOpqsybCQzTM2w4BGpVQWtRIrpO0PPqLY=;
 b=dwy9YfY8rGoG661dRVV1h3XspsyjDfn83K8114nv+IXt9fbeCpbdyOqXMefltPkhQo
 35M/jtASFCRHbm0Jr4SZ0Kv3dACptSkYobV6IY+sRgLlfSyUmGVW6s9HosLx5WVagLac
 RaXjHPhNxXPe1IGcFGBR2YHM3g0LwXpzcS9RdyxjN5bvp5BSVwJblU5HxdhqpI707f1S
 w0//LHgAG1Zb0NLPB8DT33JQvV6nc2DZiGFvQ2Lc6G3LtxMno6VM7OacDCmlpJgP2y+8
 3RAJ8k1XSPP4E5ZdErYvOxI1lRlXWsrCqLFlnj0qZX3RrEfAKbW8/KWYc1J7/x9iVxKE
 0c7Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrYw7SMFbVYCc9k+WvEOCohiqUDR6TleQMvEa5PlB9tuvARSMXASmhxQNsQhp1YYd1T2YisRERr2YoV@nongnu.org
X-Gm-Message-State: AOJu0YxOa18hcR6Uwf0APArnqMEGEBVcmbamF5pa5E0zkELw7rTP6Qxu
 BH7LisXC1VJ15VqsRYxYzkICd3NDmnpnTxRA+dpDRNlyM/vP9bRYlZ0RRDbl5vONM1htqa7CHuT
 sKehnUB25NAxdiEkbWXm4KFC9m3J6iYfrcdH0X1pE1g==
X-Gm-Gg: AR+sD11+6jLn2I6WmlZs1UFSranoKl227EQpxYp4BIQEOFJDkqdrUU7j1alIjDjq55j
 CPQgUVoFBI+jb6PaN8ghCY3s8fdeRF4Sc644yEUohURoo0/tzmOACpkcpwxBlBro4Z3TD4txabJ
 5/diiMkPUUmUG7Nm251yAfL/rUUeN7/cGZ1dfLElN0Lwb1thoMGKqfgauQNc1m/uIFGn9Tl8Our
 ApNd6Q06Uo8zr8lXs3iiF5JgfBnX7rofI334SKOzY2bw1cufcYOSiaKkgzDOKkN+t+gA5A/ixgj
 d7CyB8mGI1Bf2KqDeninjEEObQA6rNCG3mh1CLpXNIzo+hueXE1xeAv2zjpkLsxjIc6UCI28P0d
 qKjMS0YWXjvdGZMd+CQqjhGlyBHG8fYtwBK02NsU=
X-Received: by 2002:a05:690c:6e90:b0:808:f9bb:3832 with SMTP id
 00721157ae682-81fc1e626e0mr484807b3.22.1785415292150; Thu, 30 Jul 2026
 05:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260729231325.3808993-1-titusr@google.com>
 <20260729231325.3808993-8-titusr@google.com>
In-Reply-To: <20260729231325.3808993-8-titusr@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Jul 2026 13:41:20 +0100
X-Gm-Features: AUfX_mxrkzOk3JN6XQCLNv1wBzAX5lhV4CsRs_nYeTZI5fOptDlcH_NkbouaO4A
Message-ID: <CAFEAcA84j_n6MTAmwOkvQwNCq4TEL_zyGmSUc_6b=8i2VykTBA@mail.gmail.com>
Subject: Re: [PATCH 7/8] hw/sensor: adm1266: expose vout_mode over QMP
To: Titus Rwantare <titusr@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 imaginos32@gmail.com, wuhaotsh@google.com, philmd@mailo.com, 
 fanjason@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FUZZY_MILLION=0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 30 Jul 2026 at 00:13, Titus Rwantare <titusr@google.com> wrote:
>
> The vout_mode registers can now be adjusted to allow a wider value range
> in read_vout.
> vout_mode is per pmbus page, therefore vout_mode[n] will affect
> read_vout[n].
>
> Signed-off-by: Titus Rwantare <titusr@google.com>
> ---
>  hw/sensor/adm1266.c        |  8 ++++++++
>  tests/qtest/adm1266-test.c | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+)
>
> diff --git a/hw/sensor/adm1266.c b/hw/sensor/adm1266.c
> index 80960dc1c4..1464307971 100644
> --- a/hw/sensor/adm1266.c
> +++ b/hw/sensor/adm1266.c
> @@ -271,6 +271,8 @@ static void adm1266_get(Object *obj, Visitor *v, const char *name, void *opaque,
>          sscanf(name, "vout[%u]", &index);
>          mode = (PMBusVoutMode *)&pmdev->pages[index].vout_mode;
>          value = pmbus_linear_mode2milliunits(*(uint16_t *)opaque, mode->exp);
> +    } else if (strncmp(name, "vout_mode", 9) == 0) {
> +        value = *(uint8_t *)opaque;
>      } else {
>          value = *(uint16_t *)opaque;
>      }
> @@ -293,6 +295,8 @@ static void adm1266_set(Object *obj, Visitor *v, const char *name, void *opaque,
>          sscanf(name, "vout[%u]", &index);
>          mode = (PMBusVoutMode *)&pmdev->pages[index].vout_mode;
>          *internal = pmbus_milliunits2linear_mode(value, mode->exp);
> +    } else if (strncmp(name, "vout_mode", 9) == 0) {
> +        *(uint8_t *)opaque = value;
>      } else {
>          *internal = value;
>      }

> @@ -321,6 +325,10 @@ static void adm1266_init(Object *obj)
>          object_property_add(obj, "vout[*]", "uint32",
>                              adm1266_get,
>                              adm1266_set, NULL, &pmdev->pages[i].read_vout);
> +
> +        object_property_add(obj, "vout_mode[*]", "uint32",
> +                            adm1266_get,
> +                            adm1266_set, NULL, &pmdev->pages[i].vout_mode);
>      }
>  }


Better to give the vout_mode[] property its own get/set functions
rather than using the existing ones and then having to figure
out which property is being accessed by using string comparisons.


> +static void test_vout_mode_qmp(void *obj, void *data,
> +                                    QGuestAllocator *alloc)
> +{
> +    uint16_t i2c_value, value, expected;
> +    QI2CDevice *i2cdev = (QI2CDevice *)obj;
> +    ADM1266VoutMode m;
> +    char *path;
> +
> +    /* set a different exponent per page and a different value */
> +    for (int i = 0; i < ADM1266_NUM_PAGES; i++) {
> +        expected = 1000 * (i * 2);
> +        m.mode.exp = i - 14;
> +        path = g_strdup_printf("vout_mode[%d]", i);
> +        qmp_adm1266_set(TEST_ID, path, m.raw);
> +        path = g_strdup_printf("vout[%d]", i);
> +        qmp_adm1266_set(TEST_ID, path, expected);

More string leaks in these test functions.

thanks
-- PMM

