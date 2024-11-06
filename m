Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B586D44D71
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 14:03:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8gd9-0000uQ-VN; Wed, 06 Nov 2024 09:03:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roman@roolebo.dev>) id 1t8gd7-0000u1-Ue
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 09:03:30 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roman@roolebo.dev>) id 1t8gd4-0001x4-1x
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 09:03:28 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7eadb7f77e8so1014544a12.1
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 06:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=roolebo.dev; s=mail; t=1730901802; x=1731506602; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=v0HAlKkfaq/u5/UBgQ6ZW+z+l42uMmUJNtIR4+F3urI=;
 b=J+ijDw7O0uMba+Ei1liU/ppVUEA5zSyBlXl768OEVj6ouPCg30JXeoZgG0+QDZO5RA
 OjXZpr7GObyOs4vyd8DpKtevWEik36ZjZlMVvYp0+2BLmA6a1hOZHUidW/th0WvQwmf0
 O+VuHNHVBhquSlO3C8vdA4LvM/a4BGQsEZA3KiR76YmUdB1CdPavK33rhUo/BimEdYqi
 mysdcrAT4g7fbgJnt43m5kjd4UfRshk7ys8L+JRrG3Y9q7loJoAEFUwPsXyMxhzndwcZ
 7ZtwmjCz1oR6aKPTBXkbekA7jn5jK07B0VG87SKHzdlv+av8r2MAQePrzI6edfy9Wwe7
 GmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730901802; x=1731506602;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v0HAlKkfaq/u5/UBgQ6ZW+z+l42uMmUJNtIR4+F3urI=;
 b=BE5iJSIT2SOn3SnXcwQZo3zVG5zGa9hpc7rAobBCUzkoSQFGVVzArx0XSChfmBotxU
 ifXc3aXzuVdkhAiEcQGVtjAba6yOsBaQL9XFmGKM1JNq1XO5zXR3ND7rSdM/sGAzSw7I
 bYlDjLnzNojbZm6x6ebXp4sEFQ3c+oGu1neXk8Ja6nKgCEdWgs9IOiasTdRasRmJlatZ
 EpKAPIOjr2MEUvWQbPc7i2SVlbhor8l3ODegPwnsD4b6QAKgI0zbxw5h180jDWj3hHlc
 FRZgWGb2iwOf2rswGUGE2/5AkIngW8+g9W0OY6hvGZ/O1Tw17v3majcdoeXbbx6t45VJ
 2lFA==
X-Gm-Message-State: AOJu0YxFaK+b0M5fSQiBfjQe8zIIasUV0vJLOZDVE0WkrSscSvX5O6fN
 o2AhNWnXz5r3r+i09VMAAdxiB0wSVhBgRed+SgSIsVMwcWn99JMpdAjC8UWsmX4=
X-Google-Smtp-Source: AGHT+IEERw75LI+MEQHa9yCXaFOOKBxg5dWYTPF8rExmM9PVvF5O6V6pDpqgt9r+04G6eTmtl7mpKA==
X-Received: by 2002:a17:90a:5205:b0:2e2:da69:e3fa with SMTP id
 98e67ed59e1d1-2e8f104fc1emr18873336a91.2.1730901802449; 
 Wed, 06 Nov 2024 06:03:22 -0800 (PST)
Received: from localhost ([2405:9800:b660:1d69:184b:7485:e878:79c4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e99a5f95e4sm1517354a91.33.2024.11.06.06.03.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 06:03:21 -0800 (PST)
Date: Wed, 6 Nov 2024 21:03:19 +0700
From: Roman Bolshakov <roman@roolebo.dev>
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: qemu-devel@nongnu.org, dirty@apple.com, rbolshakov@ddn.com,
 pbonzini@redhat.com
Subject: Re: [PATCH 3/5] i386/hvf: Fixes startup memory leak (vmcs caps)
Message-ID: <Zyt3J5GAmePOYpBx@roolebo.dev>
References: <20241105155800.5461-1-phil@philjordan.eu>
 <20241105155800.5461-4-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105155800.5461-4-phil@philjordan.eu>
Received-SPF: none client-ip=2607:f8b0:4864:20::529;
 envelope-from=roman@roolebo.dev; helo=mail-pg1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Nov 05, 2024 at 04:57:58PM +0100, Phil Dennis-Jordan wrote:
> The hvf_caps data structure only exists once as part of the hvf accelerator
> state, but it is initialised during vCPU initialisation. This change therefore
> adds a check to ensure memory for it is only allocated once.
> 

Looks good,

Reviewed-by: Roman Bolshakov <rbolshakov@ddn.com>

Regards,
Roman

