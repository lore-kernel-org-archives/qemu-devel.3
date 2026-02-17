Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B9AE909A4
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 14:18:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsLtI-0005Cr-8B; Tue, 17 Feb 2026 09:17:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vsLtG-0005CX-4J
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 09:17:26 -0500
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vsLtD-000370-Jp
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 09:17:24 -0500
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-64937edbc9eso3705617d50.2
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 06:17:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771337837; cv=none;
 d=google.com; s=arc-20240605;
 b=TFJqof3g421C6ogPdFkp6Qg8IK0dC8pt+j07vqXCWSwo0KsBih5cyFcLrETu3J8jcM
 PqpzrHzrLbqNMOQ+RnANWZg+aamYyq05x+OOVeQdAoKPBTGMj3tWIJjGvsaDkqWOCz5j
 93xbo4KR2upd5PeVRC5LHta/iCLZ9f1xmk+KCN3hRYmiSKa5p2+eQr3O4k2IYu/1KPr1
 uBktcqCg5na872obrGuL+W1cykOBs6brygP0GbYt+8EgWxx5TZhu3nMhSL663IaRlCZA
 NQpAVEUZscx3JpMhMdIFXfJZ8BYRB7hGMNqu7VL+JGrl4Y0r2GQdFn7GhfcZ/Hqma5ly
 +DHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PK6svMIH/bXQTALsS3qsYAQFOPFq6EV2X47VKK9l38A=;
 fh=/LzkEO+n//IwSvXfr1OiajjwF32hDb78YAXZFktNDkw=;
 b=Ln8IMkJYcF9mQJBkroutvBagzRJSAxKfk7YN42uUK10bz4scmEiAAMartCWIXAI/zB
 ZI7hk8cfMlqdi5OanR2kydmFW0HNI01MLY553sD8+f369MagpjT8vthCWddLw4aZIOpZ
 V7u/zu9oqkoT6cxdai4TZjpwVjAwo914hqoIougUXoTqwvNMxeUEg1JvCTbF+pYq5aDa
 oT5U5qEXAPoV3nsb9pr5y1PZtTk/IUrxBFYMcBJl3BmzcHnfH7qM8YhOcf35tF0EXLxP
 YmWSyllgzyvJQaL05zEJCNzDtYJNPuV0rZddUjzio1nB8S38ItxdQuIooWqHCZpo0mTo
 8Ieg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771337837; x=1771942637; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PK6svMIH/bXQTALsS3qsYAQFOPFq6EV2X47VKK9l38A=;
 b=ZdonaiVsGTVRZXhp4h1dzyQp8E3RPryGaBBPeE+Sl7jjquF6mcXjVqG2G4tmyyr4XF
 6af5fvdupJcXRq/aAIUQvutfFwruLhQ/g0+usY9gUqt1pbRX3hOYR/UFPGMX1TuUb09I
 o8SWDA4y1ZDSThQNz4IY7Qcmj6EBXZB7hMWPsmA8uuhE3d6n4hl7ine1af+E+qcCV/YG
 mDJD/mBiqYSiUwfwkzMK6NghwOQN4Q7BUyAagOXTWl00t6D8WMZrrl6YwMbisxSIvsdw
 NL2jV/ZMJcHYtl9Or9u3P23V30kZ8VQUzbZoBWGrqUxWjprCVPagw0DS08wcDAn/U0eR
 7kqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771337837; x=1771942637;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PK6svMIH/bXQTALsS3qsYAQFOPFq6EV2X47VKK9l38A=;
 b=m9UYJ5kNX6rTZIb47Usy5Qgrqj30ayKO+mH+uL1z4LcZyvzWzfUXQ3r4v1Vcu2Xe1U
 zdTQTbxou7M4CjZFkSUuCFWPkI1u7aQ8vckOTxtjtbk+IL3w4lt9szTlw92nU2hIosf4
 QHK4MBjadgrBlrTJDuup63oqxQRR+t0XCMBWZuYwG4kQRDhGo7emM2aAvY9eVZLJ7B7W
 MBnWzlEPxpKXqvo66f3atHp38a9x/eJ/0Gwy2RwZw/2G0k7JxGeirP4+rIw944klbQzV
 SijHCzPuLmw9mlnhWkR9y+YCADsfwoXC3EZIzJH9OayV0JxIQE51nVCPDjjhl5JCcaX9
 eRHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEJXV60T8P93ZFA6F1K542iiSAlXQKX6OmZfufYCBLe6BmiE76K3jXalDRA3eWSkCkTgo6TnSj5lWY@nongnu.org
X-Gm-Message-State: AOJu0Ywf/LOtgV3CJV5Ew4fvA0qCr1+ax2wFevCtHcxp5kCdAUJJhASG
 siQxUqjEQMfV2IgZtGtShrGbl9c9zl03SrVpD/pGb2HpM0JILQWQQo5rZp/Hk5dMQHckeXiqEag
 OBGXpAu3g3Ht5V3m7YwLkLvfeUl9B8rzacqZXcwwjXg==
X-Gm-Gg: AZuq6aJzm/Z07Z5PK37gWYC9r2XEbtq19OzdjvPpjMd/oLAA10xZuOJF8+qwGJlYSUr
 Ec2THyu0vYt2L0fgRNma4Sc/Gl81WWRYPwhDLvEeihWFnxgCaL7d1MY4akW5+imOSLC390USZss
 NyktON5tQSz/nrS/EzHwMUJR3V6mTNryDG/v7r8fbaxeqqrxkUYaMihB8BMLDSeXtj3OWaXqNR9
 w0BfHvvEjaVJLg2IF1lQyqT8LMf2mzYYDYeESAJFM6TyGoXiRwRvo/XMBq1lnfFoU/vAAjMGQX0
 fovK50HNpG/rk2l8/0l1XWcmUKXegnCNV5aYQ5amsmyWrIdDbq0TSjmFL66osYpbyZs=
X-Received: by 2002:a05:690e:4146:b0:64a:db1d:2d57 with SMTP id
 956f58d0204a3-64c21a44454mr8556848d50.2.1771337837016; Tue, 17 Feb 2026
 06:17:17 -0800 (PST)
MIME-Version: 1.0
References: <20260212174103.504520-1-corey@minyard.net>
 <20260212174103.504520-3-corey@minyard.net>
In-Reply-To: <20260212174103.504520-3-corey@minyard.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Feb 2026 14:17:05 +0000
X-Gm-Features: AZwV_QjcnJLDgfVAcSAydGWN5mF3A2hZJuGLc5cpqXOV-9s5YY5AUZwQS_wy-LU
Message-ID: <CAFEAcA-iubKC--ix8OSqEhjyvRt+RY5835mTafShbXv_ERz1bg@mail.gmail.com>
Subject: Re: [PULL 2/2] hw/ipmi/ipmi_bmc_sim: Support setting fake LAN channel
 config
To: Corey Minyard <corey@minyard.net>
Cc: Yunpeng Yang <yunpeng.yang@nutanix.com>,
 QEMU Developers <qemu-devel@nongnu.org>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Jonathan Davies <jond@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Thu, 12 Feb 2026 at 17:41, Corey Minyard <corey@minyard.net> wrote:
>
> From: Yunpeng Yang <yunpeng.yang@nutanix.com>
>
> The "Set LAN Configuration Parameters" IPMI command is added to the
> `ipmi_bmc_sim` device to support dynamically setting fake LAN channel
> configurations. With the fake LAN channel enabled, inside the guest OS,
> tools such as `ipmitool` can be used to modify the configurations.
>
> Signed-off-by: Yunpeng Yang <yunpeng.yang@nutanix.com>
> Message-ID: <20260105155648.1037077-3-yunpeng.yang@nutanix.com>
> Signed-off-by: Corey Minyard <corey@minyard.net>
> ---
>  hw/ipmi/ipmi_bmc_sim.c      | 110 +++++++++++++++++++++++++++
>  tests/qtest/ipmi-kcs-test.c | 143 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 253 insertions(+)


Hi; Coverity notices a minor nit in this commit (CID 1644838):

> +/*
> + * Request data (from cmd[2] on):
> + * bytes   meaning
> + *    1    [bits 3:0] channel number
> + *    2    parameter selector
> + * [3:N]   configuration parameter data (from cmd[4] on)
> + */
> +static void set_lan_config(IPMIBmcSim *ibs,
> +                           uint8_t *cmd, unsigned int cmd_len,
> +                           RspBuffer *rsp)
> +{
> +    uint8_t channel;
> +    uint8_t *param;  /* pointer to configuration parameter data */
> +    unsigned int param_len;
> +
> +    if (ibs->lan.channel == 0) {
> +        /* LAN channel disabled. Fail as if this command were not defined. */
> +        rsp_buffer_set_error(rsp, IPMI_CC_INVALID_CMD);
> +        return;
> +    }
> +    if (cmd_len < 5) {
> +        rsp_buffer_set_error(rsp, IPMI_CC_REQUEST_DATA_LENGTH_INVALID);
> +        return;
> +    }

Here we check cmd_len is not less than 5...


> +    channel = cmd[2] & 0xf;
> +    param = cmd + 4;
> +    param_len = cmd_len - 4;

...so here, param_len must be at least 1 (worst case is 5 - 4 == 1)...

> +
> +    if (!IPMI_BMC_CHANNEL_IS_LAN(ibs, channel)) {
> +        rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);
> +        return;
> +    }
> +
> +    switch (cmd[3]) {
> +    case IPMI_BMC_LAN_CFG_PARAM_IP_ADDR:
> +        if (param_len < NBYTES_IP) {
> +            rsp_buffer_set_error(rsp, IPMI_CC_REQUEST_DATA_LENGTH_INVALID);
> +            return;
> +        }
> +        memcpy(ibs->lan.ipaddr, param, NBYTES_IP);
> +        break;
> +
> +    case IPMI_BMC_LAN_CFG_PARAM_IP_ADDR_SOURCE:
> +        if (param_len < 1) {

...but here we check param_len < 1, which can never be true...

> +            rsp_buffer_set_error(rsp, IPMI_CC_REQUEST_DATA_LENGTH_INVALID);

...so this if() body is dead code.

> +            return;
> +        }
> +        if (!IPMI_BMC_LAN_CFG_IS_VALID_IP_SOURCE(*param)) {
> +            rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);
> +            return;
> +        }
> +        ibs->lan.ipsrc = *param;
> +        break;

Possibilities:

 * if it's valid to have a command with no parameters, then
   the initial cmd_len check should probably be "< 4"

 * should the handling for each command check that the parameter
   data is exactly the expected length, i.e. no trailing junk?

thanks
-- PMM

