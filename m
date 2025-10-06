Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F7ACCA470
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 22:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5tFN-00045C-AG; Mon, 06 Oct 2025 17:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v5tFL-00044y-T1
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 17:59:56 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v5tFJ-0001Jg-UW
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 17:59:55 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7811a02316bso3863301b3a.3
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 14:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759787992; x=1760392792; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JetKnJr1VMFc21WPmRvZQoJjGbp+gfs1665rWAjQSTw=;
 b=bDuB8FtNZHyrtx6YcQc8P/wfB78fpJs+94pV/LM8jOAF1t+u1hC5rJ8uxFn0sL8M/T
 MiiR98O+x7rq9I/rlq+dHwbm+xOp2FxWcpOWMPJ9PVzaQgfzR27H2wf4YwN+QYBXpbxa
 W6S7P1mfrvLxkfVtnE0sGBYbBHKZUzOLuq6HoGOPm2FmRpupV91Qid9UYWHH053oD+X4
 BKpeIYuIodB/p7jymiC//KlT3+y4S3+oBSBjr/KGgm5bq/jBc/+NJ8iHJTX4/xiEbw6V
 1CNPX4XyqN9/8sfKEDQR3Ro0PD65z1DCtq4befv292mgrJckhnDuvJ7HQpNIzpJZB90B
 Lkpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759787992; x=1760392792;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JetKnJr1VMFc21WPmRvZQoJjGbp+gfs1665rWAjQSTw=;
 b=PDJo7s8nPfrhSm1GM4O1solrsd0S0pBo5yyqoNpyZy8CGhCzlWCWb8YeahW1r5DsuN
 3x/fmGUapHubvXnvK0lNMngQR/DMUfhp0XGErhdQ5uKCR6svULl5Mx6RU4KCjMUuZ4bs
 ao4Z0DzPMBxzhN1wYc/OgpwPYE0xDtGGcVALBLXLD10OgI6MtDwcvkHr3EiP1SjlGGqu
 6DEC46vnluRX/WdAxK+03cnrC/NGOdh9661WEDIzI7w23AWzT3F4yZGUpoRTXsP6bD04
 Q3d/nfK2j/gk0sg2tEYjpjqbFqbkcSNrfoTlqaLWY53RoFBAve0+vblZO0oEG3Zie9XJ
 KK+A==
X-Gm-Message-State: AOJu0YzEScPMsnWlVMVtNfNeYQDha1TDzEjViroj1xNkkyLgetolgd+U
 hVJQH9jfkf2FpGEfN/TXGFMIkmYBVlbXXrtroqzfacJwAX0iVB2YkQ5Nn3MBEQXize7keHfHUD9
 187D4o/E=
X-Gm-Gg: ASbGncuMs1g5QeH12rbxjFRcbYAl/Yaqh2Zb9P8STfPsTgktevflsiD8x/vQcSgFkiR
 9nmBv9bfwpU7HAhr76xxhDendfpliJwvxZlPtB82xl+gVPDGMFUdrPmeSkkEtSjGoN4wWYKp2WW
 YKwz9qEJne9LFT4ag4nTV7pJam2/2h9FgIldVd5oe1mhvG6/SzGhFVrc0sU1KADJwaufjuAl9tf
 BdlCUBADa3F3fNb2HaPen7Hiwj6SLl9T6WmPLTul6ZcONlV5SVhratFhB0PjpGzEkXoTHcWNyVn
 3BwSKfmIh00vJMmBlZZYgmrPT9GyPVe3wwRz6r/t3hUwR2nD5csqGluY0RM75nW8NVRPTcGGpeb
 dZr3xjXC5DNdlcglipKoy1hmew29BLySEr1OFmV+W9HM52K6DPc6qHrwigsauSlGQ
X-Google-Smtp-Source: AGHT+IFO+7cQ6wUwJ63bYPXGatx1Hv7EALC2W8vnSaO2YbOBRn7cmtjvUuvnRw1ef5EmIHDkHz53yg==
X-Received: by 2002:a05:6a00:4f85:b0:771:fa65:ae6e with SMTP id
 d2e1a72fcca58-78c98dc4dabmr18567130b3a.17.1759787992105; 
 Mon, 06 Oct 2025 14:59:52 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b01f99863sm13709501b3a.14.2025.10.06.14.59.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Oct 2025 14:59:51 -0700 (PDT)
Message-ID: <bc3f0ca1-6b03-478a-965f-0872c727001c@linaro.org>
Date: Mon, 6 Oct 2025 14:59:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/75] virtio,pci,pc: features, fixes
To: qemu-devel@nongnu.org
References: <cover.1759691708.git.mst@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 10/5/25 12:16, Michael S. Tsirkin wrote:
> The following changes since commit 81e3121bef89bcd3ccb261899e5a36246199065d:
> 
>    Merge tag 'pull-vfio-20251003' ofhttps://github.com/legoater/qemu into staging (2025-10-03 04:57:58 -0700)
> 
> are available in the Git repository at:
> 
>    https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> 
> for you to fetch changes up to e27b177339ea4d391ed7538fbdbad34518937408:
> 
>    pci: Fix wrong parameter passing to pci_device_get_iommu_bus_devfn() (2025-10-05 09:13:26 -0400)
> 
> ----------------------------------------------------------------
> virtio,pci,pc: features, fixes
> 
> users can now control VM bit in smbios.
> vhost-user-device is now user-createable.
> intel_iommu now supports PRI
> virtio-net now supports GSO over UDP tunnel
> ghes now supports error injection
> amd iommu now supports dma remapping for vfio
> 
> small fixes all over the place.
> 
> Signed-off-by: Michael S. Tsirkin<mst@redhat.com>


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

