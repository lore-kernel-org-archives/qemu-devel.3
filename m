Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA644E7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 15:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJDpW-0007fI-I9; Thu, 05 Dec 2024 10:31:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1tJDpU-0007cF-2u
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 10:31:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1tJDpR-0005rP-Hr
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 10:31:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733412703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M+uV3Mh7Dg3ZZoqZckn9x+cMh6Tn6HuTFd1r9dIzKgc=;
 b=LaXL+V5ViNylmJgj4nb8CUe9tp57mgsv11acHPF3IDyHDMbrzHAL9iiXLbYW8QoPumv/YA
 qDUnrAbNOxoBVklQnt3ctTKlveBOg4Of4vzxeH4imKWiBnCQIuOtKvlIpQjnr3S+YHD6u/
 Lf65K4R3sOpHOmZGn5Z1SE0F8RETd3o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-D62ZwFQ4MJyI2aZev25ueA-1; Thu, 05 Dec 2024 10:31:41 -0500
X-MC-Unique: D62ZwFQ4MJyI2aZev25ueA-1
X-Mimecast-MFC-AGG-ID: D62ZwFQ4MJyI2aZev25ueA
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-434a90febb8so6720835e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 07:31:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733412700; x=1734017500;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M+uV3Mh7Dg3ZZoqZckn9x+cMh6Tn6HuTFd1r9dIzKgc=;
 b=nY8tR6NwYLlMzg7pa7CyTUUkVVLrXfRcEiZc/7Cg6cq1FLtnWwtkMvMh4g9stmtKgC
 41DxhgXjGnMoSFpIbER/dxJkGRnItt4RxwQu6XscObicohOzKnUa4cbCg7v59wHTA1cb
 KnOzmN0zEsdbFlA4w5DBNHiZhcQMJDkyVVHrBl+0ZTdNsfe90tcaClP1wnvsL66tuYIG
 0RWgJmmeKxfODK6f6gDCBfraKRXeMy2NoAp+MZYha3LZSjmV+hmUT7WAozollDlzKKJ/
 bTrSWLjWegC2IJ6YNbhioWz5oTTxiccCF/keq6CJswdLsxDL2pCsPTcegh/J1jr6lsuf
 f5XQ==
X-Gm-Message-State: AOJu0YzGM6naNVlB2zG0v/AA4Ep8CfcyUwn/vqzmh2UmbS9pB8r+od+g
 KfVOiqT+wNr7cBs6Hu2A02bqYo5c4BcGrsIIeG8CNRakV/l/1Y8UJViIczD1+MiOQq0B5K6VeFG
 DkvwMJT9hsTTk8fznVlvAAWT61bjjsbxjmGAOcaKedS2/Ueq5f3Kc
X-Gm-Gg: ASbGnct5GofWC67SpNPoJtAhY/ujPJYvEOBya+ZYzkOpoyaxwMaW0IzFOs8jnLAq0+p
 Qzn+oF3xzX35JlcPmOrPf/GRPwWkhhsWQTNSxSDHShI/HCAblgiZksusN/yN7fsMUizLO2TJGNi
 iT/V+r7StiNZwpFtyLf21e3r4c7Pz9d5XqIlo5ycN3VmFxoIpbTJSdxpfGM6cHi1ELUaGWdrh1C
 xEY8cokr9EPfJ9l1IwW04I+uLGvITG5V38ZihOEbPWDjM6xf7cJNOYn4Mxxm0vZtufXtxxejkL0
X-Received: by 2002:a05:600c:1391:b0:434:a78f:3612 with SMTP id
 5b1f17b1804b1-434d3fae1b8mr79118765e9.15.1733412700391; 
 Thu, 05 Dec 2024 07:31:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFH7jxM/k5NNDHhNHbd67rLf5MZht7UypDxLVfmHiIdWYY/gloi5hMGkA87GLk6/q4vtaYXsQ==
X-Received: by 2002:a05:600c:1391:b0:434:a78f:3612 with SMTP id
 5b1f17b1804b1-434d3fae1b8mr79118285e9.15.1733412699997; 
 Thu, 05 Dec 2024 07:31:39 -0800 (PST)
Received: from [10.43.3.236] (nat-pool-brq-t.redhat.com. [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38622761548sm2193658f8f.110.2024.12.05.07.31.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 07:31:39 -0800 (PST)
Message-ID: <3173369a-407d-49b3-8022-d420d11ee2f3@redhat.com>
Date: Thu, 5 Dec 2024 16:31:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] qga: Don't daemonize before channel is initialized
To: Konstantin Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com
References: <cover.1730713917.git.mprivozn@redhat.com>
 <699917b7868f7fbae3c076f013850ba9f8a5cb8d.1730713917.git.mprivozn@redhat.com>
 <CAPMcbCrFyeZ0zvJbinNawwYLZjvs8BM=FOo5G1V1Gx9+ZGmyug@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>
In-Reply-To: <CAPMcbCrFyeZ0zvJbinNawwYLZjvs8BM=FOo5G1V1Gx9+ZGmyug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/4/24 10:44, Konstantin Kostiuk wrote:

> 
> The old flow:
> run_agent call run_agent_once in loop
> run_agent_once initialize channel for every run
> 
> after your changes
> you expect to initialize the channel only once
> this can cause issues on Windows during driver update
> the default configuration on Windows is QGA + VirtioSerial and in CLI --
> retry-path
> during driver update (that can happen via Windows Update) the channel
> will be closed
> so QGA must reinitialize the channel

Ah, I had no idea. Alright, so what I can do is:

1) keep channel_init() in initialize_agent() and become_daemon() after
that, and
2) make run_agent_once() call channel_init() if s->channel is NULL (and
also set it to NULL ...

> 
> Theoretically, the same can happen on Linux with a UNIX socket
> 
>  
> 
>          g_main_loop_run(s->main_loop);
> 
>          if (s->channel) {

... here.

V2 coming up.

Michal


