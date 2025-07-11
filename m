Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A811EC8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 09:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua9gR-0006Yy-Jz; Fri, 11 Jul 2025 05:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ua9bF-0005lz-Lk
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 04:59:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ua9bB-0006Kr-4l
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 04:59:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752224356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ewsO3GTPWkOjioFjgLR3qUmZqRoCqWWIgim6oqucqEw=;
 b=Fujuux7htHvc4+CFI9geTuR8x52vU7S5Y1TOINphQ3WnoLqZV1VU8rPZhY/DQDn6MACFJa
 Utx+0vps8Gtr5r/23oq/X3LkSO72sSc/4IWo5Q4yNRUp0dGoraGeS0JNLWMXOzL6mASX5i
 ASSxmIyzG4JLiB/jQpvZDR09MEvUyxA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-QjKKTppMMLqbVV_WoDehAw-1; Fri, 11 Jul 2025 04:59:14 -0400
X-MC-Unique: QjKKTppMMLqbVV_WoDehAw-1
X-Mimecast-MFC-AGG-ID: QjKKTppMMLqbVV_WoDehAw_1752224353
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ae6f9b15604so64821366b.0
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 01:59:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752224353; x=1752829153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ewsO3GTPWkOjioFjgLR3qUmZqRoCqWWIgim6oqucqEw=;
 b=YkdVdGxB5mbi+duVVc5jktchu7eefdlq4rhfhX7tP5kgppSZUIeD47Cl6oZVyBB11W
 UjhCnEGcIdoIIkhcke6IQoNnJPBKTlCFrqnLBYq0F5Gr3xfsbkv5wfidSrhYs1OeKk2Q
 e7G8dMfQcj/FbI+D4JscrgmWXH56k/FYRUL+vCWq8llwuS8e2jLjCqmjYiHsswL9XySn
 c/yitLkrQrtYIIWwItqmRyUmELU3+4ehMLdfMOq1oHNrx8ZDtCKreUp+YjHVVlPkpxY0
 M+s9SymQEGkxxLIOvXY/LpKd7d2CqE/V9SXFc9R+/UtoQF5OdPNlXGqDlm+XKr9fEiGc
 JLww==
X-Gm-Message-State: AOJu0YxeDCS/snxqVHMYG7H2hjgHLMV+H1HZLiVoJMRWahH5vKhu5HoQ
 2/NAlY9iRLzoZwA5izlKqhAQJX42eJ42MhGs0qfPEL9hsFciEYaxRAL3oLcPk7q7RjslU4F2+7s
 a9k8PRGg5u+O0fXAlYKNffQu4z0A6W7W04WamqwRwec+p4P5d1+4Q2LZuH3WwFKLN
X-Gm-Gg: ASbGnctPg36EN4Ej907dfSpWJ9JRyYxX+5Q/XIS7z9dvMgtDxxHOxn3lETJe9Pnn7Cd
 l/Z5bAbxXpnoxSFkKfaBzn/wBI6LPI1wnEgAzWeb3lUW/fURtTtUespbjXevIuEM0tFtrlS0K6j
 eGaH/z23oaEvYEhree5RMHGKl8lV5yAFboOpwJ0/9qpdIFxT1Ro7NKJHa3+kVXVYe5EtrEUpGRI
 7MqFvRvmJYo9Je1cr4tK6aTK1nZwboI285fyXgupT4BLmtL+rfURVlFIapidq7Yh2T6moREVWa+
 aZ9uUqNUakgdEizWit5TKChSkufCc5VlJLPiiSDiLcl2cKmyG6vydwM0nJfUZ57YfkxOPmmh/A=
 =
X-Received: by 2002:a17:907:1b08:b0:ae1:f1e3:ccea with SMTP id
 a640c23a62f3a-ae6fbf40993mr262445866b.7.1752224352831; 
 Fri, 11 Jul 2025 01:59:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPZAh847t1jxjp4K7F22c/Pxycp24P4AXBfzBj0pBEgQeKNCoyMU6zRKjhkjpGz39mRieFfA==
X-Received: by 2002:a17:907:1b08:b0:ae1:f1e3:ccea with SMTP id
 a640c23a62f3a-ae6fbf40993mr262443466b.7.1752224352367; 
 Fri, 11 Jul 2025 01:59:12 -0700 (PDT)
Received: from [10.35.88.123] (93-44-61-216.ip95.fastwebnet.it. [93.44.61.216])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae6e8264663sm261769766b.87.2025.07.11.01.59.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 01:59:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] i386/tdx: Don't mask off CPUID_EXT_PDCM
Date: Fri, 11 Jul 2025 10:58:32 +0200
Message-ID: <20250711085831.459772-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250625035710.2770679-1-xiaoyao.li@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> It gets below warning when booting TDX VMs:
> 
>   warning: TDX forcibly sets the feature: CPUID[eax=01h].ECX.pdcm [bit 15]
> 
> Because CPUID_EXT_PDCM is fixed1 for TDX, and MSR_IA32_PERF_CAPABILITIES is
> supported for TDX guest unconditioanlly.
> 
> Don't mask off CPUID_EXT_PDCM for TDX.

It makes little sense for the TDX module to do this, but I don't see
any nicer way to comply. :(

Queued, thanks.

Paolo


