Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C8DC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 10:58:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weWAM-0004Fm-T0; Tue, 30 Jun 2026 06:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1weWAL-0004Fd-Cr
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 06:58:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1weWAJ-00034g-BR
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 06:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782817085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lWMUGORVDHMTAPzxwwLX3XTRmf7QjM+bxaFfZwSWhTc=;
 b=YfW47vnr4B1brf1UcihPaWhtfhPv6Y4XZPN/zKpv0EMaavllVhQoTMdN+DPjL35hZ/KNHm
 622N8G+ifnHqjp4j4zc6qkfJ1MCMUXECnDfmviOmzN2LqjYC1wW2B1loyW5IV/NP63BJZx
 SkTawRNc9Lf40WX7nhDCE33SlprEkek=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-h8-Cy7o6OAe-Aasu_gPBiw-1; Tue, 30 Jun 2026 06:58:01 -0400
X-MC-Unique: h8-Cy7o6OAe-Aasu_gPBiw-1
X-Mimecast-MFC-AGG-ID: h8-Cy7o6OAe-Aasu_gPBiw_1782817080
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4925bf70f5bso36324125e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 03:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782817080; x=1783421880; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=lWMUGORVDHMTAPzxwwLX3XTRmf7QjM+bxaFfZwSWhTc=;
 b=OFfwCsN6FoduF7WIrtrhZNSdIXK86XyRR7cy8tNaQfWrAt3p5yEBiPNK/TfJqQHjVc
 LtbzphAvCcoWZcCTOA6Sv7SfGOwe0K4UN3ijT7pt6PcPOhiM1LF7xTgF0JCTV0ndqap3
 BFQKlh3vva6xrnhg03wKeA6DQzAqqa18rQEismyg5r9AL+chMUFogeZ1Bbnbz1vOLI1C
 YeStUQQosyleDEnK8eEGfDcy+VpDkWQToAY/DIkx48fKNaVJ8hZy3gWL7QPUfORsdi9a
 PNvHAAHPMnku+RG4Hbv/IbEBYEdo2yrheNCtT99Br/yvr3LPD3qWMF/7fPk8MNg2yHjk
 HKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782817080; x=1783421880;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lWMUGORVDHMTAPzxwwLX3XTRmf7QjM+bxaFfZwSWhTc=;
 b=rUf077es+Qj255tnJk8CkJGUw+JJMTWSWKRpAViQMoqonWbZOZcW4kUX2ftjeyQ0kM
 O74C8CrIe4MI1VJH1cv1nqCMQf611popUv+e4l9X2pB217Mj4OQlkmMLSly1286SQIea
 V2rH+vfRFVg+FVm8WbgfvEwAJpa2CFlM2CJFrLdu+88+gD8nC49xVxZNOPvOQn232IMp
 Fz4X20ZumsWNdjkH5LdcII1VwsemCzkHx/VeT/EctR9XFkM4QLBXroqfiCSw3HPMzEgs
 L+W3i30dTef6LUGxZXUeRXEjlXW359RaRz7W9ar708F5DY6FwuwJL/RV3Vk2x4c3/SIl
 R6Sg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8WXdAlyd6FWWG7a8BHy7prHSmniTmwjBI2/QXrUEGcIb5FmRs/wfDf7Im5mEuH28wxPi/nATgyrb1D@nongnu.org
X-Gm-Message-State: AOJu0YywPJabypmY1020QFOe3W7r//20rsai65V7EraY6c5mhthAfxnS
 SLEEX7ORGzKc8f1sQLQgbl6XB0BZtn7ChB3zMpnoBeddRMcBC3wJt+ke/O6arVjnMnw2wHPY01/
 QB7chcu7B8bIxq2LEVM/XGIdKM3g+hE3dlKzTomo0oME2/DxmF1cUAubc
X-Gm-Gg: AfdE7clMS0LZAarCanupCm5NomvlB8egdeGJ/CZC8m3Bt0b7BR1RP6QFBl7XoZmbT2M
 v/nEzLzr9ehNezjfsFPaar4AsUWplFk4r1dyhIKHtUyxjJdbv8r38CSqCk5PNoaaPTQgeX1zNBh
 uVDsDZZ1g7uUoXmnwpSUra5JuKH8GJdgiHEbqkHEwLVMg2JhzNXpp4b2k303qHrWO1cVAM91+M5
 ytSzWOEneVHyDq9v0lXIAE1LKmoKNwZtCwQcCxCd3/T3uv4rf5rdutTWrHoN+D0QYvuZ7gBtjzc
 jG01PPl7oXF2yb0RSz+1mpSQR0zfi8QJcnWTDbw+3Z8Eay6XmkmaGoc8frZ2IrTBUeRF1sVUWkI
 crG1GnJCoKnV6YoZlNs0zaPqO/Vr57feO5b4g5uS0dfE=
X-Received: by 2002:a05:600c:4e4f:b0:493:bdae:1a2e with SMTP id
 5b1f17b1804b1-493bdae1a49mr520135e9.22.1782817080360; 
 Tue, 30 Jun 2026 03:58:00 -0700 (PDT)
X-Received: by 2002:a05:600c:4e4f:b0:493:bdae:1a2e with SMTP id
 5b1f17b1804b1-493bdae1a49mr519435e9.22.1782817079053; 
 Tue, 30 Jun 2026 03:57:59 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-40-241-22.web.vodafone.de.
 [109.40.241.22]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47567a6f351sm6773313f8f.36.2026.06.30.03.57.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 03:57:58 -0700 (PDT)
Message-ID: <fb461d4d-167f-42c8-a02d-151e15cbe503@redhat.com>
Date: Tue, 30 Jun 2026 12:57:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Record maintainer/reviewer Git Lab handles
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20260624122936.2706393-1-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260624122936.2706393-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 24/06/2026 14.29, Daniel P. Berrangé wrote:
> When triaging GitLab issues, whether regular bugs or security
> disclosures, we need to be able to assign suitable accounts.

Thanks a lot for doing this, Daniel, very appreciated!

I already curated a local list of handles on my own in the past (most of 
them by looking the handles up via commits they made, so I'm pretty sure 
they are correct), so let me add some handles for the missing entries below...

> $ ./scripts/gitlab-map-check
> Missing GitLab handle: Akihiko Odaki

https://gitlab.com/akihiko.odaki

> Missing GitLab handle: Albert Esteve
> Missing GitLab handle: Alberto Garcia

https://gitlab.com/bertogg

> Missing GitLab handle: Alejandro Jimenez
> Missing GitLab handle: Aleksandar Rikalo
> Missing GitLab handle: Alessandro Di Federico
> Missing GitLab handle: Alexandre Iooss
> Missing GitLab handle: Alexandre Ratchov
> Missing GitLab handle: Alexey Kardashevskiy

https://gitlab.com/aik1

> Missing GitLab handle: Amit Shah
> Missing GitLab handle: Andrew Jeffery
> Missing GitLab handle: Anthony PERARD

https://gitlab.com/anthonyper

> Missing GitLab handle: Anton Johansson
> Missing GitLab handle: Antony Pavlov
> Missing GitLab handle: Ari Sundholm
> Missing GitLab handle: Artyom Tarasenko
> Missing GitLab handle: Aurelien Jarno
> Missing GitLab handle: BALATON Zoltan
> Missing GitLab handle: Ben Chaney
> Missing GitLab handle: Bernhard Beschow
> Missing GitLab handle: Bibo Mao
> Missing GitLab handle: Brad Smith
> Missing GitLab handle: Canokeys.org
> Missing GitLab handle: Chao Liu
> Missing GitLab handle: Chinmay Rath
> Missing GitLab handle: Christoph Muellner
> Missing GitLab handle: Clément Chigot
> Missing GitLab handle: Clément Mathieu--Drif
> Missing GitLab handle: Collin Walling
> Missing GitLab handle: Corey Minyard
> Missing GitLab handle: Darren Kenny
> Missing GitLab handle: Denis V. Lunev
> Missing GitLab handle: Dmitry Fleytman
> Missing GitLab handle: Dmitry Osipenko
> Missing GitLab handle: Dorjoy Chowdhury
> Missing GitLab handle: Doru Blânzeanu
> Missing GitLab handle: Edgar E. Iglesias
> Missing GitLab handle: Elena Ufimtseva
> Missing GitLab handle: Eric Auger

https://gitlab.com/eauger1

> Missing GitLab handle: Eric Farman
> Missing GitLab handle: Eugenio Pérez
> Missing GitLab handle: Farhan Ali
> Missing GitLab handle: Felipe Balbi
> Missing GitLab handle: Francisco Iglesias
> Missing GitLab handle: Frederic Konrad
> Missing GitLab handle: Gaurav Sharma
> Missing GitLab handle: Gautam Gala
> Missing GitLab handle: Gautam Menghani
> Missing GitLab handle: Giuseppe Lettieri
> Missing GitLab handle: Glenn Miles
> Missing GitLab handle: Gonglei
> Missing GitLab handle: Haixu Cui
> Missing GitLab handle: Halil Pasic
> Missing GitLab handle: Hao Wu
> Missing GitLab handle: Hari Bathini
> Missing GitLab handle: Hendrik Brueckner
> Missing GitLab handle: Hervé Poussineau
> Missing GitLab handle: Hongren (Zenithal) Zheng
> Missing GitLab handle: Huacai Chen
> Missing GitLab handle: Hyman Huang
> Missing GitLab handle: Ilya Dryomov
> Missing GitLab handle: Ilya Leoshkevich

https://gitlab.com/iii-i

> Missing GitLab handle: Ilya Maximets
> Missing GitLab handle: Jagannathan Raman
> Missing GitLab handle: Jamin Lin
> Missing GitLab handle: Jan Kiszka
> Missing GitLab handle: Jared Rossi
> Missing GitLab handle: Jason Herne
> Missing GitLab handle: Jean-Christophe Dubois
> Missing GitLab handle: Jesper Devantier
> Missing GitLab handle: Jeuk Kim
> Missing GitLab handle: Jiaxun Yang

https://gitlab.com/FlyGoat

> Missing GitLab handle: Jiri Pirko
> Missing GitLab handle: Jiri Slaby
> Missing GitLab handle: Joe Komlodi
> Missing GitLab handle: Joel Stanley
> Missing GitLab handle: John Levon
> Missing GitLab handle: Jonathan Cameron
> Missing GitLab handle: Kane Chen
> Missing GitLab handle: Kashyap Chamarthy

https://gitlab.com/kchamart

  HTH,
   Thomas



