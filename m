Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8544C55165
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 12:39:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpQ2P-0002Zi-Gd; Thu, 30 Jul 2026 08:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpQ2N-0002ZH-JJ
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 08:38:59 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpQ2M-0004Ui-17
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 08:38:59 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-66893db7bccso3054363d50.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 05:38:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785415136; cv=none;
 d=google.com; s=arc-20260327;
 b=logoXqoJ9d8hhy2yoWR9L6H4meyogZn6gFOSVhvjrIJu79zq9oN7OYDVnszADlGxMC
 EB5/C0PVzqhpxGskaT0vGLLDNzEy06cY2kV+V0vbxLcPqLUs2BJi4cvMjUSKzBJ9EDoU
 CwGanzcAdAoPteD04PLKzi3osPjnePCJW3mVjOTbZ61Vaxg/S5rZdUx4bxujYTEZ04KL
 EOWJ7yJDmoSybyn8MkKtka7a5iKhHVNGoNf5ta25oGTk5oolBrbLksMbSY7LEHk4AT1F
 5b4HIbGdj0kXhBioqhiy0EmGD5FkPvYqYNV7H7Dq23HDrQAW47UOuIo/YBLXwY8EnRqZ
 3X8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gN8D8F31FDpxGH3YKhqW0xmPQi2EEj1RpT3xmV3JvTM=;
 fh=PUi/9VmY6H5x1/Z024v2clkJl9PkIVgs09EkUnNXJTA=;
 b=rFnK3bIzFJi8iaJiHu1dlsWtFvXUS1Gd5ydoLryjCiejNZMF3EGeca1Gfk8qJXiazZ
 GJvjCLNB+YetjePTgjOK88SXqyuCzzLpehRH0NEP9Q2jsJVXLZd8V17AmnNKUVeLkP5X
 nOJxfBJHgLsisznLlPyvFuRdOhpzLaNLIIQkxo0R9PgC6e+2lcAZxK7mpagreaGhmb03
 cM3cCw7Pw39f9bnqNiieTlpBkXZiLf6346pkkZtIRP1l6SMLhFLNvqDG/L7qXM/tboxY
 aS6jrQEfF3PHDFWXN4R99uG/U989sQENksIufbCumt3K/6xxx9DU6n327FWRAaPPmhTJ
 Lmug==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785415136; x=1786019936; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gN8D8F31FDpxGH3YKhqW0xmPQi2EEj1RpT3xmV3JvTM=;
 b=AxY/jdCH4Y+xxCWcON64afzdgI84JBLoE8UaXGEjCLEQ6RcBbj9ZlqKdqPhzQNfNqK
 WoijcdWU7DBlu61ELpTI6xVPcVd70HlGa4+NgRKZeDFqODXb6kFYmjY4KwFc905MHPpu
 crB61FsXsYVAIjTHO5FlDf8SvwKsutzrro8JLOk4KSX1kG81abEhD5rRCqlYOrOequn/
 qJ8jYLrpvhcMmWExaI9cQKZyZbW05McyIJjIJB7CrUAOYkBpFa1M/F2QK6bTvRtI+PZD
 tTMRMsLLobDDaGGGKI/Q4css7WNYPtFoJPGnVhBXT1ISYhgilbULp0BES5JISVpx6mw9
 m/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785415136; x=1786019936;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gN8D8F31FDpxGH3YKhqW0xmPQi2EEj1RpT3xmV3JvTM=;
 b=SgBVDH4luZRupmpdCldaL+grmNNtq9nnF4vTwisFJ468YJP0jn9xhSxueuGY0c6P5g
 eK3IPOT/P+yOKS2gW2CWaouMwF4yFO+grHJalOd2hskXU2O64GLkfdPLysC98+lqhZCl
 A1r/Dx+6SqIQeN95/+ATip4rVr2nm3OU3dTy5pxCbrJxnIfxuwxs2qHCIk/uiwBFFyuG
 CYZpQx90w+gcHd66Wr7teoNDckY222jF40a5WGiYmu0bqa7DJi5OPLf8tK/t4Ubj2uGa
 ihJZ/eAN3YUuvGiKED82RXxVKBDT9qoBBNRABtyvZwwi2ssEaq3PXnDgdAtbqD4qd01u
 /Psg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqm/l2JOaj/h2xh3xU2hSt1qMxvgzJsDvRg6F9BQkJQumr3abOsqORUt51k7feglpr+EB24qlfDYXvw@nongnu.org
X-Gm-Message-State: AOJu0Yz/HxfpiSH/x++BM+s1X5MP0MxY90hvIz74chpRvoqsFOXE3DHP
 OFpFEUuhsx9neQazamsSvR1xTaYqYgbsMw47Xr0IvpKKl1XfWstn1xfhxPfZ6k2Gbvo0DDVx4C5
 tp1GXNySZP/SMg+z11bZ59NVV9nHtYwB8vR/SN+FetQ==
X-Gm-Gg: AR+sD123tKtepdQLkDpRTtzFQVEpr1kVzonHf8S1CJmxTfkeHLMJ7THqT6evOV9BVJ2
 6b+xQwtXpmcrAESFA1bkN5b1wBwX9eul+a6Yu3v5yJY1bUuhIKxropxyuSyVYquB8lB7h97RUTD
 WuMUwzj9BUtHiEdiJSe6IUZ9sWAY2WrDM8/+dMfWM+KJrTyPp4fHi0Vo5bPW0PkMnLxMauO3/k1
 LjsalJ/bRO4xSl1r6dOnh0XE6KR8nkbVxcfHK6kW7cG0dwEZ7BY+pY6F/y9mhXKBEKjLiNgYUhD
 WSNSnQJ8W9BChlJogVubzVQZOvG3Li3HP4xjrMevkEG09clQQVmDBQbIWZSj0JMtR8CgBKJNi9X
 1Ftd78y2Jq9mnWbikGJxNVLZiUM5K
X-Received: by 2002:a05:690e:4410:b0:668:4c8f:5d47 with SMTP id
 956f58d0204a3-6692f8747c0mr1161521d50.108.1785415135513; Thu, 30 Jul 2026
 05:38:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260729231325.3808993-1-titusr@google.com>
 <20260729231325.3808993-6-titusr@google.com>
In-Reply-To: <20260729231325.3808993-6-titusr@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Jul 2026 13:38:42 +0100
X-Gm-Features: AUfX_myq4gjGsCLp9XRmEN2r1W1HG0SpuowqB4jySfBzjmziyPSpMSebNR-ZBqA
Message-ID: <CAFEAcA9OHrycH12LcmUECOsm2Ajqnx4tgWVvrgdrHtDmT9UFbg@mail.gmail.com>
Subject: Re: [PATCH 5/8] hw/sensor: switch adm1266 to millivolts vout
To: Titus Rwantare <titusr@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 imaginos32@gmail.com, wuhaotsh@google.com, philmd@mailo.com, 
 fanjason@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FUZZY_MILLION=0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> Enables storing fractional voltages for the ADM1266 over QMP
>
> Signed-off-by: Titus Rwantare <titusr@google.com>
> ---
>  hw/sensor/adm1266.c        |  27 ++++---
>  tests/qtest/adm1266-test.c | 150 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 167 insertions(+), 10 deletions(-)
>
> diff --git a/hw/sensor/adm1266.c b/hw/sensor/adm1266.c
> index 2979557309..80960dc1c4 100644
> --- a/hw/sensor/adm1266.c
> +++ b/hw/sensor/adm1266.c
> @@ -263,32 +263,39 @@ static int adm1266_write_data(PMBusDevice *pmdev, const uint8_t *buf,
>  static void adm1266_get(Object *obj, Visitor *v, const char *name, void *opaque,
>                          Error **errp)
>  {
> -    uint16_t value;
> +    uint32_t value, index;
>      PMBusDevice *pmdev = PMBUS_DEVICE(obj);
>      PMBusVoutMode *mode = (PMBusVoutMode *)&pmdev->pages[0].vout_mode;
>
> -    if (strcmp(name, "vout") == 0) {
> -        value = pmbus_linear_mode2data(*(uint16_t *)opaque, mode->exp);
> +    if (strncmp(name, "vout[", 5) == 0) {
> +        sscanf(name, "vout[%u]", &index);

What is this doing? Why do we need to do it now when we didn't
need to call sscanf before? If we do need to use sscanf() we
should check the return result for errors.

> +        mode = (PMBusVoutMode *)&pmdev->pages[index].vout_mode;
> +        value = pmbus_linear_mode2milliunits(*(uint16_t *)opaque, mode->exp);
>      } else {
>          value = *(uint16_t *)opaque;

You've changed this to a uint32_t property, so leaving this as
a uint16_t* cast looks wrong now.

>      }
>
> -    visit_type_uint16(v, name, &value, errp);
> +    visit_type_uint32(v, name, &value, errp);
>  }
>
>  static void adm1266_set(Object *obj, Visitor *v, const char *name, void *opaque,
>                          Error **errp)
>  {
>      uint16_t *internal = opaque;
> -    uint16_t value;
> +    uint32_t value, index;
>      PMBusDevice *pmdev = PMBUS_DEVICE(obj);
> -    PMBusVoutMode *mode = (PMBusVoutMode *)&pmdev->pages[0].vout_mode;
> +    PMBusVoutMode *mode;
>
> -    if (!visit_type_uint16(v, name, &value, errp)) {
> +    if (!visit_type_uint32(v, name, &value, errp)) {
>          return;
>      }
> -
> -    *internal = pmbus_data2linear_mode(value, mode->exp);
> +    if (strncmp(name, "vout[", 5) == 0) {
> +        sscanf(name, "vout[%u]", &index);
> +        mode = (PMBusVoutMode *)&pmdev->pages[index].vout_mode;
> +        *internal = pmbus_milliunits2linear_mode(value, mode->exp);
> +    } else {
> +        *internal = value;
> +    }
>      pmbus_check_limits(pmdev);

This looks like it's changing the semantics of this property,
but there's no documentation either of what the old set of
accepted strings were or what the new set are.

We shouldn't change the semantics of existing properties
in a non-backwards compatible way, generally speaking.
If we do really need to do that then we should flag that
up clearly in the commit message with the rationale and
the description of the change and its effects.

> +static void test_vout_milliunits(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    uint16_t i2c_value, value;
> +    uint64_t i2c_milliunits;
> +    QI2CDevice *i2cdev = (QI2CDevice *)obj;
> +    char *path;
> +    ADM1266VoutMode m;
> +
> +    /* set a different value in millivolts for each page */
> +    for (int i = 0; i < ADM1266_NUM_PAGES; i++) {
> +        path = g_strdup_printf("vout[%d]", i);
> +        qmp_adm1266_set(TEST_ID, path, (1000 * (i + 1)));
> +    }

These test functions leak the strings allocated by
g_strdup_printf() (the leaks show up if you run 'make check'
under the clang leak sanitizer). I recommend adjusting the
scope of the variables so you can do
  g_autofree char *path = g_strdup_printf(....);
and have it automatically freed as it goes out of scope.

thanks
-- PMM

