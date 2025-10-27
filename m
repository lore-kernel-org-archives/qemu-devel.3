Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E01CCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 14:39:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDOMi-00053Z-B9; Mon, 27 Oct 2025 10:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vDOMe-00052i-1W
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 10:38:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vDOMW-0007aG-Ml
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 10:38:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761575892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zkMEay15joBKD+BDxqQNHKbidhEDcyXLGXVfw9YFrgw=;
 b=RgAWTQaDOXLepzE3E3iyUflysgLHI06rj1mYMgk4D1SB+zM0JRXqapzP66q0tXVqqHtd8e
 pKt01MwInqW74yG3uNQ9qZbz7FNjibrFwnuRuS9X5SngkYLuEl/CQTW/F8XNZndhjWgJT9
 AMbrnvm9Jzn5hlu9Yh6Ryc0TDcKnElo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-T-HpZhyQMbi1BEE1YBvPlQ-1; Mon, 27 Oct 2025 10:38:10 -0400
X-MC-Unique: T-HpZhyQMbi1BEE1YBvPlQ-1
X-Mimecast-MFC-AGG-ID: T-HpZhyQMbi1BEE1YBvPlQ_1761575889
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4283bf540ceso1837576f8f.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 07:38:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761575889; x=1762180689;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zkMEay15joBKD+BDxqQNHKbidhEDcyXLGXVfw9YFrgw=;
 b=awOppKB9VY6MBNg/RNsAZ5NRQiugkP9QlrIGZDql8KvsVGTu/X/BVFYD1koOKhxnn1
 lucnNpgntie9cRhClveTqhBMpP+0Wq5C9dYgQfsnRQQ7qX748s4rGgu+iqHvrgliZwuh
 zbzKWu0HkCPkHV6pqQ3R8+0sh+eMBzwKfqyjyVt8z8uY8CCxooMenb1ooPrB4ubWd4vQ
 Uc6UF0+oVwctfwqO6SA/NGwKFVRylj7WR3R5ClDbgiqKpNyxfFwwluu4Ca3N+VXsKIQp
 OsbT/6wK/fFvD0h3LpMvn7WQ9dNCT8UdgGsQG769XSip0shoWo6otwNJo7aJKe7ZKnAv
 ywoQ==
X-Gm-Message-State: AOJu0YwbOcFLPcvA1wJXHBKEVVamPcyHl7z1i+S+agDfqnzIacdEiTxz
 3M5MeC7JnDaCKO5PnMQjKiSY6YKE6m9+ce1R34A+LSPiInUboDlJHUMTTjXstcybSXML2ljO7kX
 RK88E4GbVACzX/MzpWvUHcekZ7HqZk+weydFOQHtXWv3Mw7tl6dSjOy9e
X-Gm-Gg: ASbGncvs2BR2Reajvkfzm68Z77Rwj28FO1YyIH56NRbXK7bHs4adp7RzRqsUqGWVAW5
 S4vI4Bb6M4X+Unm0NeKjoDuoDNA6YYS+GZQpvHcueipv4ZWgCeQrSCDnWJh6erW0klvs32wI256
 UE6iVwcinmiACwnaw9XMINA/CrqTpvVkQRL8jWhj4DWY2rg0fxu62wNb8nN6oz3qUTuhr0ahu7U
 wfdy3tRL8nOKiwOgwGPxX0dJkjj0fZsfi4A9aj/t6oOz65/Zwzt/juclkgHRVjybTgoYopBGuY9
 WGRkka2OxT8Um+7k8mUOm9FCxTGxRvPMZBR0yE6Bfl0JQHabIy/iaxt3FLMr648kN+tdIjSTu9F
 oW4jjlksO2hyZbg7dcqVy5JbSw2Kdo9C6A9pHYw8=
X-Received: by 2002:a05:6000:24ca:b0:428:3fa7:77ff with SMTP id
 ffacd0b85a97d-4298a04e599mr12442501f8f.14.1761575889314; 
 Mon, 27 Oct 2025 07:38:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6UebO6e4+4nVG9vOQQ74V0KEgKeElrHoXpWqomnI2lLGfGCPZPGBNSDbu1OJcP+PC86lnng==
X-Received: by 2002:a05:6000:24ca:b0:428:3fa7:77ff with SMTP id
 ffacd0b85a97d-4298a04e599mr12442482f8f.14.1761575888940; 
 Mon, 27 Oct 2025 07:38:08 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-113-081.pools.arcor-ip.net.
 [47.64.113.81]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952d5985sm14473872f8f.25.2025.10.27.07.38.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 07:38:08 -0700 (PDT)
Message-ID: <de075ba3-b1b8-425b-9cf9-cffb7eaa481a@redhat.com>
Date: Mon, 27 Oct 2025 15:38:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 21/28] add cpu_test_interrupt()/cpu_set_interrupt() helpers
 and use them tree wide
To: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20250829125935.1526984-1-pbonzini@redhat.com>
 <20250829125935.1526984-22-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250829125935.1526984-22-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 29/08/2025 14.59, Paolo Bonzini wrote:
> From: Igor Mammedov <imammedo@redhat.com>
> 
> The helpers form load-acquire/store-release pair and ensure
> that appropriate barriers are in place in case checks happen
> outside of BQL.
> 
> Use them to replace open-coded checkers/setters across the code,
> to make sure that barriers are not missed.  Helpers also make code a
> bit more readable.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
> Link: https://lore.kernel.org/r/20250821155603.2422553-1-imammedo@redhat.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
...
> diff --git a/target/rx/helper.c b/target/rx/helper.c
> index 0640ab322b5..ce003af4219 100644
> --- a/target/rx/helper.c
> +++ b/target/rx/helper.c
> @@ -44,7 +44,7 @@ void rx_cpu_unpack_psw(CPURXState *env, uint32_t psw, int rte)
>   void rx_cpu_do_interrupt(CPUState *cs)
>   {
>       CPURXState *env = cpu_env(cs);
> -    int do_irq = cs->interrupt_request & INT_FLAGS;
> +    int do_irq = cpu_test_interrupt(cs, INT_FLAGS);
>       uint32_t save_psw;

  Hi Igor,

this patch breaks the test_linux_sash test from 
tests/functional/rx/test_gdbsim.py. cpu_test_interrupt() only returns a 
bool, but that code in target/rx/helper.c checks the individual INT_* bits 
in the do_irq variable, so this cannot work. Could you please have a look?

  Thanks,
   Thomas


