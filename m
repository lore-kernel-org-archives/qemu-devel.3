Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 623C4109B489
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 15:58:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7bTu-0002RP-Py; Tue, 31 Mar 2026 11:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w7bTs-0002Qd-Md
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 11:58:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w7bTq-0001v2-Nx
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 11:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774972692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZWc5gZleEquAuk3OoIROSqgPJXI0Ad2MO34NFOXkp8Y=;
 b=ira4KEfKivqFRZowE7PpjFhHX2vK55PsbfcgugeiiUB/VpSqQo1ZJoew7j4ofp/D/3ddIX
 lWCBt5CTeA1zVTCXonkHpuUt3v7//OIq5wWDZNkfhJwI/hZ51bjqLJTDW8uLWxpTyfAtSG
 ZfvJC+y6RWHgks73dVRm7Ix2hsAKtcQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-zEA7lu2zP0mrd9M90YU6eg-1; Tue, 31 Mar 2026 11:58:11 -0400
X-MC-Unique: zEA7lu2zP0mrd9M90YU6eg-1
X-Mimecast-MFC-AGG-ID: zEA7lu2zP0mrd9M90YU6eg_1774972690
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43cf5b4dac8so2744391f8f.0
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 08:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774972690; x=1775577490; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZWc5gZleEquAuk3OoIROSqgPJXI0Ad2MO34NFOXkp8Y=;
 b=sA04EZiRGVK3fFWUbfTwWi6l/DX169rpXe6wIkh3AYKQTTq3E+0ecrztFHW06FNcsr
 45QFZtJ2Nr2zpGKK55rwbUT3EBBJ8IHCvFS5MgTp7PVRCvefI8RvtYKrCgovcNYQG6Xx
 Bb8efyl8DnotaBPvB0vfYFap9sTwECCSBOVZfI7Hlxtm4ucSSLLqMRutARrOABd6hWK4
 TeK5xxYJR2hQ4kUg1MHwYZVuQARGrMy2A2QEBtu7NNfbFprgYW11Tx/Nf3EKjdzmUIlh
 EZdh3LmXvHLHa7hGc4BSWTfPDvXpw3mqaTu89j0FYYMtcYCpJk59BI8tY3UDTr77wRmD
 ml3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774972690; x=1775577490;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZWc5gZleEquAuk3OoIROSqgPJXI0Ad2MO34NFOXkp8Y=;
 b=EGDuqTan/jLGnTnXNyt2eoIQTSSALwRnoibblZc/BliP15dgIV4dKk+GIrSBBEgFkg
 en/GT7b9cAU7f3GFLhoESLpkSFMa2NZLAhQfvWBnXKV0dJm+NPT6o7hRsvkXfd5KnRoa
 +IBgBLYwxxcVv927Ji6rhPLQbVMmg1fOuvNddJ4/IfYewZfBWnmafar0/Gp9mOFrVU8k
 K6Hxa4fYZMwVEUcFSZS6qLFFjeXUKsLsyR1FlHjqnGtXm8x4PeF74NLsS8aDdLjWUjUn
 /YeckkM9iTr9/fr9Z0j26W75y1LaekeVF6XWZQgY+NgaxPuxhb/LthrBs8hoVii/lPvE
 iJgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXb2wpVWHdMIgvoZraVwa3769Arv7SGEQND1HrXIUp3tKS32fnqXlX/HNLb00Ac+OQoPAJC0FrxP3zC@nongnu.org
X-Gm-Message-State: AOJu0Yx1N5l7GXFCVMllKMpGpsiotBCUHPHGJXEed8Wbcma5w34vjng2
 tmCohsG7nGb5c9Jvbq0+b36WapEe0YvWPyABCzCwOkQAIceHoFzrtl/pL/0MBlNUmQlobXiGT4K
 D1uwL+dnc84eKv9zup7C4GIVG+q+RXxvFlZB7D5B5R1gZOFXD/v116hra
X-Gm-Gg: ATEYQzztxXGa3Ywa5k+iPMeodVP/m0sWx/iZrS1S+JGve5y2i3g4tYzlrYVhhAUxgto
 XGxh0fP/Q2beoZTnwgHHGzG/s9eQLQw/V0Ode6PWoB1q8/5ATCn72xnszbsgAhbcYY84kCcCzXM
 d1aRMx/SGlqS9mlrrCrezx7T7XV6FnLHF90RZF18nPSSbP5xO4BvUnpMwz4nr9QebITOzCH1bYB
 jHwUxU5fReUg7KejF+MA4nGftRlL7sP980NVcc6xwqcVCBK6gUI0YE+fPMbdX+GUZMM0BfoUJMC
 UBRgF0ABAQoDPuCeMlZwn1P5ssnSLhPjL0AaT2WqCa8bb7k2FRVlqxA2nq9xKYo3b5eRgToick2
 rUIfg9/6XwuIluhndp9fnhrTt+YpjgRoN/1m0Byuf/ejGRntaqeEU//fYbRpQWaLF4opHQJijlN
 NqNA9DKKFOMKR7khaRBpmnQRDKRfbZUoeGGb0f5tZ8XCbS7l2Y
X-Received: by 2002:a05:6000:4285:b0:43c:ef4f:79dc with SMTP id
 ffacd0b85a97d-43d15042623mr346656f8f.8.1774972689936; 
 Tue, 31 Mar 2026 08:58:09 -0700 (PDT)
X-Received: by 2002:a05:6000:4285:b0:43c:ef4f:79dc with SMTP id
 ffacd0b85a97d-43d15042623mr346604f8f.8.1774972689483; 
 Tue, 31 Mar 2026 08:58:09 -0700 (PDT)
Received: from ?IPV6:2003:cf:d737:d0a3:d82:4779:43c9:77a3?
 (p200300cfd737d0a30d82477943c977a3.dip0.t-ipconnect.de.
 [2003:cf:d737:d0a3:d82:4779:43c9:77a3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf21f279bsm25482270f8f.16.2026.03.31.08.58.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2026 08:58:07 -0700 (PDT)
Message-ID: <f1d702ec-bf3d-41e2-aea8-1979a26da7ff@redhat.com>
Date: Tue, 31 Mar 2026 17:58:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ide: Fix potential assertion failure on VM stop for PIO
 read error
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: timao@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org
References: <20260326165124.138593-1-kwolf@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20260326165124.138593-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 26.03.26 17:51, Kevin Wolf wrote:
> ide_sector_read() as well as its callers neglect to call ide_set_retry()
> before starting I/O. If the I/O fails, this means that the retry
> information is stale. In particular, ide_handle_rw_error() has an
> assertion that s->bus->retry_unit == s->unit, which can fail if either
> there was no previous request or it came from another device on the bus.
> If the assertion weren't there, a wrong request would be retried after
> resuming the VM.
>
> Fix this by adding a ide_set_retry() call to ide_sector_read().
>
> This affects only reads because ide_transfer_start() does call
> ide_set_retry(). For writes, the data transfer comes first and the I/O
> is only started when the data has been read into s->io_buffer, so by
> that time, ide_set_retry() has been called. For reads, however, the I/O
> comes first and only then the data is transferred to the guest, so the
> call in ide_transfer_start() is too late.
>
> Buglink: https://redhat.atlassian.net/browse/RHEL-153537
> Reported-by: Tingting Mao <timao@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   hw/ide/core.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


