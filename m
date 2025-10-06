Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E7BCCA471
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 14:09:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5ltL-0005Xd-TS; Mon, 06 Oct 2025 10:08:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v5ltJ-0005Vj-Ie
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 10:08:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v5ltE-0001jS-7W
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 10:08:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759759712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7mIH4Ad26SmepdPkoRL4uKQjx41I8fN3Z2q7MtS99Dg=;
 b=DK/CNQQGgdX7xf7X8Vw0YF9kHPNrWUCzJFEyE07ATxf0OEu7esw5EKW7HnEqTOh+aStI0/
 w+ZhAKIWkVyQnzXCLDMaiEXgni5E6QBKQ4sn9yXBPI5hS+vV/n5581mcIR+mxBJYAeHESg
 2hXBnPDQcf7xLkcrI9ZKMHKZTUJZWro=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-lYasgdN7PaqJ8JbWQ5hEFg-1; Mon, 06 Oct 2025 10:08:30 -0400
X-MC-Unique: lYasgdN7PaqJ8JbWQ5hEFg-1
X-Mimecast-MFC-AGG-ID: lYasgdN7PaqJ8JbWQ5hEFg_1759759709
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e38bd6680so16857295e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 07:08:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759759709; x=1760364509;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7mIH4Ad26SmepdPkoRL4uKQjx41I8fN3Z2q7MtS99Dg=;
 b=chonIkjWp6V6XfeEbwgeb/PSMqRsskFu5y9c+I0ch8qrn8wKNAs8JJ8top4GIm5y4I
 XuOWDtOu5dmyKRHxOLpuqGXXRi3KMBhE5ud64teAFFqo7kjhzwZHtNmFVx54/mpeVJJh
 bWCcvKtMUJDG/d4d9B0FWYangf/8A/ue9Tq4HKv+D0zYW2JqqWuhf1zE+90Kfg1Osfjp
 axil02Bd0NGH2TR4ERQsWbvN3ZS9N9/SR/uMzD4aDD/ehB8fYdkGKnYo94ZFFCi8Qa/L
 Ba7FTlmqGFAttFQQbo9x6vpQPfgNRikTXCtwYquczTOEEUuNXtln0rrjuUKnvkOEbwzw
 SRlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhHyGtZXeKMloJEvqAyzHcu58217felZ+NYQm2cCMAPBoKDWRXqvf49rPUZpRppRAtq15+NfIiqhiG@nongnu.org
X-Gm-Message-State: AOJu0YxypB1RvpoGxlTZk3CwjdgCLiTyDdXjC1ZDHnN0/F4GsKLl7R1Y
 BphYkfPaGbbDPXCdAvgVr9Hi35+ZAAcXpLZMyX3mXsUhv1RRUyc6sFE5E0Ii6NzTE7d3ri4JqFl
 kPXpKKKqN80fmKcSpRgqJoOkvwc6cxg3CSKK7hnpjeZPOdTVOHP3xGJcd
X-Gm-Gg: ASbGncvYSypYNbHSRHNtKKx/OS9P0Yd3yN5LvqvZYzvI/h2mjHVBizIYgnwpHYjHObQ
 AJUPFZUYzYV2EJJtyPpW8c9ka4zrLqp/52dom0i2KYypGg0wwC8RZ/xNAsmFWBc2ADMfIZac5U6
 bh80q6n+5FRyF0rgF4hTUkncV3m6ho0/6HW4CvpfuiOaIW9WvbalvsN4XrXbqMuENXRMy33rveV
 yv8WzWoasozdSQNNHjSXTHDAL1VQObRKrTAst/A5giLOHk0B5inpTMCmrSKW3QDd/rfB3sknGLl
 Pj23F1HbLpLz9a520g6U+tqFOvMc0CCwT5i67sEItaiJMNQLZj4BoWEPbMHzNhzfSmxW+DuZgsZ
 0TRkxzzpwAg==
X-Received: by 2002:a05:600d:41f3:b0:46e:3e63:9a8e with SMTP id
 5b1f17b1804b1-46e7114735amr79073425e9.26.1759759708933; 
 Mon, 06 Oct 2025 07:08:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeM0pR+VoMWLn+OJZsHAL+MKZjL7Vn6XjtWC8sZBV7cyVjohNEVIDvUBmkLZ7NFuhy4YfGZQ==
X-Received: by 2002:a05:600d:41f3:b0:46e:3e63:9a8e with SMTP id
 5b1f17b1804b1-46e7114735amr79073285e9.26.1759759708544; 
 Mon, 06 Oct 2025 07:08:28 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-056.pools.arcor-ip.net.
 [47.64.114.56]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e6b23d4c5sm200630655e9.17.2025.10.06.07.08.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Oct 2025 07:08:28 -0700 (PDT)
Message-ID: <d0906529-b6ee-40aa-947e-a2aaae7496a6@redhat.com>
Date: Mon, 6 Oct 2025 16:08:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] target/s390x: Propagate CPUS390XState to
 cpu_unmap_lowcore()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>
References: <20251002091132.65703-1-philmd@linaro.org>
 <20251002091132.65703-6-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251002091132.65703-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 02/10/2025 11.11, Philippe Mathieu-Daudé wrote:
> To be able to access the CPU state in cpu_unmap_lowcore()
> in the next commit, propagate it as argument.
> cpu_map_lowcore() already takes it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/s390x-internal.h  |  2 +-
>   target/s390x/helper.c          |  4 ++--
>   target/s390x/tcg/excp_helper.c | 10 +++++-----
>   target/s390x/tcg/misc_helper.c |  4 ++--
>   4 files changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


