Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E2BC3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 13:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzExZ-0003yl-9K; Mon, 31 Mar 2025 09:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1tzExW-0003yN-VU
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 09:13:47 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1tzExU-0003yE-Rq
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 09:13:46 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2c76a1b574cso1331215fac.2
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 06:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1743426823; x=1744031623;
 darn=nongnu.org; 
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5LHaSFU+Ae1q51MyiAEg8Azq2rrHihvuNJbZ6R6Lgcg=;
 b=03rAxElLLE2bEPa7XEeh0URPVFAY6HnzN9Vb9G6+XSrwcj5ltOKs9if/wCQVcEB4cf
 lO6z32yMM1miz3NIth6kzGmwfRTU2JBC6mLaye7g3bE7+WRwGdWbm0WJZCTN1gJAL0St
 +99j7wlXQsMSQBHUzdDkZjL9+PzSH7JGk+Kg0ay5Vgp/HV7CNY9w/Z6HKOKmadzWzJ3V
 TAHB/qrL2oNuUlU830y9+Ch1UR20wrByM+hZQztla/EPf0eUMwXSGTAqlqdjQk11XQAB
 nK/VWeUIswdE+knoFbt7xAPKgKCuQL2uiSUgqNfjPDwZC7jWsGahTdjr/cJA+rWa7u13
 LfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743426823; x=1744031623;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5LHaSFU+Ae1q51MyiAEg8Azq2rrHihvuNJbZ6R6Lgcg=;
 b=hR3g12h9C4wDND+suqASgz8qG0bIz71AhJylszYtmxSPYl0Yg5fXpOAHc0Tu94hRad
 IGlNbhqOGU3VeD/LReOXvm1FfFRwQlzzASO7bkPdv3DViX+yPiAmxzYKFVdOCOD5Wco/
 gdyFwhMbk2M2lfN+jVr6NxU00SaD1BVKnLfhVfshi9J+ZXmjllaYH10kXZwta/gXqo2K
 EsoQhSiwpovnCvfP0+Pqzf2kTR4qc0WwH1h3xHFtSoyCjV7QnCM3G2GWOEWxP7OHRPl2
 X6wkC39QurNB2dQgTq74P/SdK4wK3CP6f9ESb5HHA26PMqEt/mk2XL032/XuzfKjEJ92
 cQ3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYZmEMFWoxf59UI1ORwYvlOo3XocrFrKa3sUNa3TDUhw5rFjN2MNGgiDSp4eMuwHSWUijV4VzfPX2C@nongnu.org
X-Gm-Message-State: AOJu0YwGYegGSaetgI/uF94mUT2X8cmuPKkBU1N4Ovo+nuigfLJtzhDw
 1ORKtpGdpgIuvP4+gS1iwXxDuRUUbiaMTKAPX51lSzeqLpdTOY22xpCDPqFTvGc=
X-Gm-Gg: ASbGncsA0zhGDb7HDBCUENKUkJHFCiO1e/Anz1xTLV8OxQzITgqC7lXLHUt13XAsC6B
 R5t27xcoOn0fNxiWupek3Ox1N+B0QTysTwUtcUcfG93xYQclxhaCFh9JPf38DFgbig9UV6m2+wp
 ab78CsgG6mztD9vHFm76C/h/DBLDRcSABAjzyzHChQ34fxFMwf+4q+9lXqZIwidMy6wpmI3Ikpz
 fuxs1yRkH/gcWfihEyo+vs6eJB9oeVbX+bzIUvxlioXPUwJ7bxZS5XnFdPxKZQivvGdySnw3UmX
 oS/IJdLB5UZWvUyrZvJMjyLpWpjieS1BqoRyOXsMDUT4AnTI
X-Google-Smtp-Source: AGHT+IGpyHoGx6CD9kJBgIcb/hclmsNwTDpSJdwlMSFy2IcwWJ9iUrWgqQ5V4XY8LzzgKunjhZbuNQ==
X-Received: by 2002:a05:6871:3a0b:b0:29e:5897:e9d1 with SMTP id
 586e51a60fabf-2cbcf825a7emr4782115fac.39.1743426822947; 
 Mon, 31 Mar 2025 06:13:42 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:da64:426e:c0da:b180])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2c86a911a73sm1863149fac.48.2025.03.31.06.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 06:13:41 -0700 (PDT)
Date: Mon, 31 Mar 2025 08:13:35 -0500
From: Corey Minyard <corey@minyard.net>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Corey Minyard <minyard@acm.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/3] ipmi/bmc-sim: implement watchdog dont log flag
Message-ID: <Z-qU_5RWxK-qpGTn@mail.minyard.net>
References: <20250331125724.607355-1-npiggin@gmail.com>
 <20250331125724.607355-2-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331125724.607355-2-npiggin@gmail.com>
Received-SPF: none client-ip=2001:4860:4864:20::29;
 envelope-from=corey@minyard.net; helo=mail-oa1-x29.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: corey@minyard.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Mar 31, 2025 at 10:57:22PM +1000, Nicholas Piggin wrote:
> If the dont-log flag is set in the 'timer use' field for the
> 'set watchdog' command, a watchdog timeout will not get logged as
> a timer use expiration.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/ipmi/ipmi_bmc_sim.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
> index 6157ac71201..32161044c0b 100644
> --- a/hw/ipmi/ipmi_bmc_sim.c
> +++ b/hw/ipmi/ipmi_bmc_sim.c
> @@ -733,7 +733,12 @@ static void ipmi_sim_handle_timeout(IPMIBmcSim *ibs)
>  
>   do_full_expiry:
>      ibs->watchdog_running = 0; /* Stop the watchdog on a timeout */
> -    ibs->watchdog_expired |= (1 << IPMI_BMC_WATCHDOG_GET_USE(ibs));
> +
> +    /* Log the expiry if the don't log bit is clear */
> +    if (!IPMI_BMC_WATCHDOG_GET_DONT_LOG(ibs)) {
> +        ibs->watchdog_expired |= (1 << IPMI_BMC_WATCHDOG_GET_USE(ibs));
> +    }
> +

Are you sure this is correct?  The spec doesn't say what this means, but
I would assume this means "Don't add a system log" not "Don't set the
expiry happened bit".

>      switch (IPMI_BMC_WATCHDOG_GET_ACTION(ibs)) {
>      case IPMI_BMC_WATCHDOG_ACTION_NONE:
>          sensor_set_discrete_bit(ibs, IPMI_WATCHDOG_SENSOR, 0, 1,
> -- 
> 2.47.1
> 

