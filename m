Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5481FC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 06:16:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfAjA-0005RC-L8; Thu, 02 Jul 2026 02:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wfAj9-0005Qc-4l
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 02:16:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wfAj7-0007us-DG
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 02:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782973004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DYVIXsStIyODfBWhUT8uaPJRtkEPNYzWO/XmAapofY4=;
 b=XAiB1H6iz6zRtF5MT2nQW0sQCvcyjxzTtY26S3FMdrvnsyoQ9ugVG2KO5Q+UohEtMBtd7D
 +6dgeR3OAjhGB3qVCckIhUgluhLL9efkK9EhdsJn8pxiXytye7LhTqnPT+BzEVQMXE56SQ
 WQW7l0PdkEo37HQzTkjVwaP0lqOFWUc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-26MefdCRM-Gf60w4sIi4ug-1; Thu, 02 Jul 2026 02:16:43 -0400
X-MC-Unique: 26MefdCRM-Gf60w4sIi4ug-1
X-Mimecast-MFC-AGG-ID: 26MefdCRM-Gf60w4sIi4ug_1782973002
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4926fa2cb17so2345625e9.1
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 23:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782973002; x=1783577802; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=DYVIXsStIyODfBWhUT8uaPJRtkEPNYzWO/XmAapofY4=;
 b=DvlLTq51jXav+kTJ0sGVSCmpG9qGSxkwajnyGNoNk2NbCVK6zurwpX9ezj+33AUt3H
 IsWvFtuBpwugVdEjB7VsaubiNwnHc7CgMtVfJ+M3lNXj5m2lP/uLrE+l272CsP4CeiBS
 LFYlZxkzfAHNTpLDh2PGQlocEYXzkOYSF46lsfdALG2p+q0yGvC7GTwxSUnkU4NPh8IO
 yrVMglnVEPLLDGeEGnbLz1+RpMqVovWufLDtrIKk4kVy2A537VuXOoa25W/RZ7EDBZQa
 Q38oxclokfzcyfIvns5AJKFs25Kbu5LNRperN8Tn9DBnez2JNJxy0g2jptY4VbD715/n
 +mIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782973002; x=1783577802;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DYVIXsStIyODfBWhUT8uaPJRtkEPNYzWO/XmAapofY4=;
 b=ZWSFj8XT7s73MdyxXvvkvcP7qeWQoWxqTP18ThEdUSC/86i7gTBbIvDqPhWaHp0vdC
 ZgMNP8f8s33NERqq7AE7dWrcR7GeYqG5Uwxx0HAf+f7e6r/tac4tEBUk3S5wvf6NCDFW
 samMZJxbnKCy3jRNRdFoLMBdiEQcwqF1hGpEhJURk/wfGOQlQ31PQPFls7f7xN7vzl96
 fmSbgkFFRcpmr1Nc9cM+8pJj/tAp/aZZ99MvMFmV7VFr+OzZchhgHa3HMcRN4WvdhZY3
 F8d9m4iOH44NqbfWHoAl/z14gQ08FODjr60YIuZyKrFbs7JMb6peVRhaOuYzIRyWH3yr
 tnzw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/OVibhy9hEPvKRumNjSA7WToi/ph/4lmm+7C9FfAj7BleZ+ns+4UtkWpXhhSaaq/7LFXuRzWf9wtuy@nongnu.org
X-Gm-Message-State: AOJu0Yx6arPsZuu0AmylE6oonavmFi/K/FY6j6PHrvn/e8wHp19CYNpA
 TG2Ly3vYLXdtUmXhFl5gQLzzKaFyJ86DNOwbc3E/HvV5UidovjQbQ7fZu6l7tcmskTCqQEno5qu
 dn+7Z/PlP+CFIPvJlScyDPAHcujs1q3YaTmbQoVlICKK6YT+iQ+JeSz3d
X-Gm-Gg: AfdE7cl1MZcIUdz0Zbqw8KPqocdoP6E6atNUkB29C2lLkNiajnfe8Oe8+15oAzgXT1X
 ZjG/Nv762nk4zZpoCNUm5WuWGUxMd0Z+l0QBlLtrfTuhkErbmmgBrdoZV94PTMNWfzPLr0q/cu5
 91s92RNXQJLao+DEDpDskYK1WVb4sUJLQv6FExmYtC4YqG/5099eOlsrCrMj9+Zkj/Eb821uQsY
 XTGosOIFQU+5kOtR8rXz06bkPOtbiREKePA0AZnlxNPHoB5p9mt4WotlRUb6Ait0bJ0D2J+XiT6
 HcZQNx6P+d3VfELtTUuHnUEEqttbWgoCgGv4ljCl+Lfzj7FT7ogkB+XjjjPfdmvaQRV9s0zV40q
 KXHOurTmI1iO3QmSIXio1mmQoXXrBdR3zneKh3o9swJ4=
X-Received: by 2002:a05:600c:8106:b0:490:b4a8:e031 with SMTP id
 5b1f17b1804b1-493c2313932mr52723055e9.4.1782973002057; 
 Wed, 01 Jul 2026 23:16:42 -0700 (PDT)
X-Received: by 2002:a05:600c:8106:b0:490:b4a8:e031 with SMTP id
 5b1f17b1804b1-493c2313932mr52722615e9.4.1782973001631; 
 Wed, 01 Jul 2026 23:16:41 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-40-241-22.web.vodafone.de.
 [109.40.241.22]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63172fesm38398615e9.0.2026.07.01.23.16.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2026 23:16:41 -0700 (PDT)
Message-ID: <28cf6717-c8a7-4968-a555-c107dfae2fb3@redhat.com>
Date: Thu, 2 Jul 2026 08:16:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/intc/loongarch_dintc: Fix OOB access in DINT MMIO
 write handler
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, berrange@redhat.com, lixianglai@loongson.cn
References: <20260701065454.1976188-1-gaosong@loongson.cn>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260701065454.1976188-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 01/07/2026 08.54, Song Gao wrote:
> Validate guest-controlled cpu_num before using it to index the cpu[] array
> or pass to async_run_on_cpu(). Without this check, a malicious guest can
> trigger a NULL pointer dereference in async_run_on_cpu() and an
> out-of-bounds array access in qemu_set_irq(), causing host crash.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3616
> Fixes: 0d148eaf5a3e ("hw/loongarch: Implement dintc set irq")
> Reported-by: Thomas Huth <thuth@redhat.com>
I think that should rather be:

Reported-by: huntr bubble

since I merely made you aware of the bug report at gitlab.

  Thomas


