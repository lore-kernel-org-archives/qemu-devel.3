Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC75EE6FE2B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 15:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smavq-00010j-Bl; Fri, 06 Sep 2024 11:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smavp-0000wm-8X
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 11:31:29 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smavn-0005uV-Oi
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 11:31:28 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5c24ebaa427so4957318a12.1
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 08:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725636686; x=1726241486; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ofO1vT477L8Btk/SiFmuxOSHSGfBG4Y1dGPFl2Jlusk=;
 b=XIYQT4lwEhkVzx5WIINv43OXEsb6wncgvV1iEPOinmAYh06qx7TL0kk1LN1dpGk0zB
 Bw4uf7n0tjUfSbImZxTkBIa2qc/gjWcntdOZlkwxMLKRaGxM6hCFZ01F6uyFpHbXCYRq
 34TIyo7bU+fGf1SPU7oBEB/IYRC4hakC6BWvjfLrtu9OFRbJJUQAjGtAZKQmz/2TIqUR
 j5OylNY3Gv8kTF47B9ZzGD9WqOvRsBlIpZsjxKvVll/Gl2I+WJkKKC99w7lU2MGswi0M
 2V8GWvyqXGjRe5JXRIKgIGnr0Ke9CME47M94mOsYj9W0g5TBw2y2WdVDSA+i/YJ6qaOg
 BtAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725636686; x=1726241486;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ofO1vT477L8Btk/SiFmuxOSHSGfBG4Y1dGPFl2Jlusk=;
 b=sQCqRZ1uJymmZ37TzAF3l0g0UEJwsmXhV2S6ksnVWIihR6a7Sjx6tVbHgyUi29qCoa
 fV25++qMT2qQ/R4aI8WTHy8Vbz+T7hxAYY1ExYzyjtHwkLKRPyM1MajGOdrx3dxawhHO
 p/6s/orSSB46QBk/SuI9O5wp+XkJKf5EDHIG8JRFYAr7QL+mRhDLCVr7ikmQYy+pJDzL
 OAwnYS+cvuwrnCS+uXruwxnPPqjzVKNm15cVznWlHXhEeUKDtIMA/iCNGPwEy6Ab3MqE
 B3ghJ1f5pe7oAqKZg53WjWoGJAeeI0SMqOZ82UGK9sfkr5CnDgDoUl3bjXL9fcHrPL/6
 WTLw==
X-Gm-Message-State: AOJu0YxDONfg8hwYjXFratxhAdfCeeOofh0oR9mqn9mamo5NoMk76Whn
 bZR/PmXpVdix4ynOBiOf8xpiU+rwUkRRonNt+x+tF2IU2Fhyf+PgJeIkmO37yr+dJfyMU/8mlIC
 fGcR3W/z6O3/hql5t9rK09/v1r74ZNGfs8cXULoL3TmXsVPTd
X-Google-Smtp-Source: AGHT+IF6mEJx1InsLLNT9KvTWB7DriPCNFB5pKga89hv77f1qPL7HDPPooZliNfm/PEjH3KG244e9VVU8p9n7ePqs2I=
X-Received: by 2002:a05:6402:354b:b0:5c0:c559:ad6 with SMTP id
 4fb4d7f45d1cf-5c3db974a08mr3389651a12.6.1725636686059; Fri, 06 Sep 2024
 08:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240828111552.93482-1-danny_canter@apple.com>
 <20240828111552.93482-3-danny_canter@apple.com>
In-Reply-To: <20240828111552.93482-3-danny_canter@apple.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Sep 2024 16:31:14 +0100
Message-ID: <CAFEAcA8ZbqZiaQJXwLXbbDZTDQZ8tKdZqp4qzjQe+4t=Ke0vAg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] hvf: Split up hv_vm_create logic per arch
To: Danny Canter <danny_canter@apple.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, dirty@apple.com, 
 rbolshakov@ddn.com, agraf@csgraf.de, pbonzini@redhat.com, 
 richard.henderson@linaro.org, eduardo@habkost.net, mst@redhat.com, 
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com, 
 zhao1.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 28 Aug 2024 at 12:16, Danny Canter <danny_canter@apple.com> wrote:
>
> This is preliminary work to split up hv_vm_create
> logic per platform so we can support creating VMs
> with > 64GB of RAM on Apple Silicon machines. This
> is done via ARM HVF's hv_vm_config_create() (and
> other APIs that modify this config that will be
> coming in future patches). This should have no
> behavioral difference at all as hv_vm_config_create()
> just assigns the same default values as if you just
> passed NULL to the function.
>
> Signed-off-by: Danny Canter <danny_canter@apple.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

