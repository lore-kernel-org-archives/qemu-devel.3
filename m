Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC980C88E64
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 03:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5x4i-0003C3-AN; Sun, 13 Sep 2026 23:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5x4P-00039v-Vy
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 23:09:29 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5x4O-00070J-CG
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 23:09:25 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cea50dc0so384764a12.2
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 20:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789355362; x=1789960162; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=I/r29TbZNq0EiOz0Gs+lxyE58j656svOLTFUR5NTOSY=;
 b=ns5WvRdhJzL0oItZbphj3GPsFkgaBS4Hyj4KARAQNgrClerToNbFy1Bs/XD+D4sxFw
 H1QjhXZ6QS7xtOYQUlAV3dsWoa67OpYB0M+0EMgPZwBvw6bpUw63v7xzAJtbsKt5X2+X
 /iHHQyAITzN4T2LuNJ1WfPxGm+COSPqv/PjWMUXcPJYHlakWy8CQwkoxhJIa4oQ8Hmig
 HY4AwgEEHZEnkD81adwQCIv2EVghdZZDZ7MsTVVeqD+qMjRfM1flAm2MRSXA4ZKDI6st
 Ttllsr4kDdQ36YVGR2hwl00pInFg/HzXq0rzg+nrBla0DLJ36C1VK8zNAvYhN14KxrFB
 EBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789355362; x=1789960162;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=I/r29TbZNq0EiOz0Gs+lxyE58j656svOLTFUR5NTOSY=;
 b=gIP5sE9O2/Sqa2G0cckh0UKGZ5xjJSD3ftaHqJf83xoiQuxqMhZP9sSavOiKJabFEr
 12BeDM4wc6yevY226XN9Gz7s8SfneZ0ASFUxE9NylbQ7Heq20ivCriJZtRm8Q8O6sztb
 s4kBlBR70LrYCYkEzVrtjY2n3kY6FUX1ad6AHIUAquBNjfnrYtMobe1pW6i/MVTlS2fu
 w4tQX5NkOSMyMU2LMVc//i43pVYTP85ZWIywxOKdkLuj68XpwnrJf71W5VTdiJd7+rpz
 W8sZZfG1/HcWf1T5q+E+j1zmhi6kxTUr50NVHVPeS99pgH/98Y1ukr5LvSnW4XEmW7Yr
 DUMg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzZsztaGZwH1h4xCBolpUrnCQcoPExQazTb2CLdUPB157ucMwxz/MNf9UWjWw8dvcPEClgDHZhzWIAR@nongnu.org
X-Gm-Message-State: AFuF++mhJyG9sjYKkZiCDhJB8l+LLQGdTscCJjor1TU/p8xln7NLYCTl
 vY1xhe2p9p98is7Z/EWP4j7H/aGnuhOYsuUts3d8tEONeHaJY1LP49he6HOOcqaS/AY=
X-Gm-Gg: AYBFou1cklspFr565jnMyWXs4oYDAT3/v+KUahjlxov/HYi5evUPKKR51z4cfvXsWWQ
 06Rt1fGhQICrHH5YNOMFM5FIetd5mtavf7rcCEXCtvZuAwOmAUz2NU671xHbCXjz03uIVsOOsit
 fQ+Z1YYuuoPC1him6nM/l2tZ4YnfwVzWILtEXMTnLWz6CQNWZ3LL/kw9aQuL7dWXNOnImUn+Kef
 B3ppPka1SpiRneezjyp4L6ynfTjv5zB026Q6TPCCqL/npfNoSRxKol/hshIcU5V36H449OcKwz9
 vIacKjeWsy83Wju/ZxwMKfw/0GE324s7GJZWcVyOcHNB/v48XWVnZ5JDuUjAfVZafi06yx0QY87
 odovURDB/Dx2NeWeWle6byB7T2XgXiwKlLQvaRoIPASTj9iw1r4fQaKK2K2XhwVt507sUg88hfp
 evlbS8naU/ZlW5L0yvDN1IMKg1Mhg+8iwRQ2cQxQX/ytR2vUJ3FFx434XBsFQvA9Vcpn/Mp7FZx
 CPb/zbB9azrdJ/erRorXNYxt4JyvVDMMiJgOX7Zq0QjC7IzWW98woIRGY8sBg==
X-Received: by 2002:a17:90b:3e4f:b0:39b:51cc:4586 with SMTP id
 98e67ed59e1d1-39dec0beda7mr1648204a91.19.1789355362461; 
 Sun, 13 Sep 2026 20:09:22 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:1665:91c0:9a80:f870?
 ([2603:800c:7900:ed00:1665:91c0:9a80:f870])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f0feaasm22090193eec.21.2026.09.13.20.09.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2026 20:09:22 -0700 (PDT)
Message-ID: <63fc8f84-22ec-4d7f-8a2f-3a2ae2a38024@linaro.org>
Date: Sun, 13 Sep 2026 17:09:19 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL 00/14] UI/display queue
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260913-ui-v1-0-7a8d89d0423a@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260913-ui-v1-0-7a8d89d0423a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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

On 9/13/26 00:41, Marc-André Lureau wrote:
> The following changes since commit d43c2d5f89db70359a7b3a7e2ad7098fcc0165ef:
> 
>    Merge tag 'for_upstream' ofhttps://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2026-09-11 12:04:42 -1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pr-v1
> 
> for you to fetch changes up to 78809254f367cec04d68afd4c90115d9cc15a2e4:
> 
>    ui/gtk: Clean up GL resources on tab detach, re-attach, and VC free (2026-09-13 14:41:12 +0400)
> 
> ----------------------------------------------------------------
> UI/display queue
> 
> - cursor data races fixes
> - qxl migration harderning
> - add org.qemu.Display1.UIInfo
> - gtk fixes
> 
> Signed-off-by: Marc-André Lureau<marcandre.lureau@redhat.com>

Applied, thanks.

r~

