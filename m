Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8E6CCF9FA
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 09:20:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vElIO-0006Zj-Dh; Fri, 31 Oct 2025 05:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vElIM-0006Xm-98
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 05:19:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vElIF-0001Ks-SO
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 05:19:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761902372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e70k88V6RPPxds5g4oO6Lmci+WeHJqMJRDQSeC10MJs=;
 b=BwcMAVDPdwuMs2IO72AGgQ4OpeeTWhEL2JSKdkhg5eLUcbG2xD5KM30j4yUhvWFh4wZgjh
 aq0KBtJUhmxxhGXp7bHaEGjyNvl3Z2a58DqFAiHCN4LkqgYFNhkn2LLZq7KiDOYoURVWRu
 TEkVpEiJXH3O2gP/8QeigHr3UK4wgn0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-E88R7poZNpivXXUW-AyXKg-1; Fri, 31 Oct 2025 05:19:31 -0400
X-MC-Unique: E88R7poZNpivXXUW-AyXKg-1
X-Mimecast-MFC-AGG-ID: E88R7poZNpivXXUW-AyXKg_1761902370
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-475ddd57999so14806585e9.1
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 02:19:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761902370; x=1762507170;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e70k88V6RPPxds5g4oO6Lmci+WeHJqMJRDQSeC10MJs=;
 b=ey2UQcbX6Rv1c1PP01Wnjo2Eg79xZ7J+8ggxNYawL6XdI3ht5ofFXrqouRCybMZcgj
 iWWh8CF6JnPqaNDU+7njPeB10w7vmzahgr8VcxGFupm+1D3d9ubgPDyoTWks/QI23X3K
 LcvooaS1MTf+/2Cn4xHbEy0Ut0wsCvA65gJ1eFkvoLn3H+979RUebFUh7KC5GWKwICJH
 xlVaxV+Acghw4vrjYkzxlaf6NhudXrgddWGwa/cRQM45nU2DYpAjs/+w7xxYKszUybGf
 US4MFcdu5YMF5AyhlSMYQpqgjUqRWDnhEEZtdpEqpPom7XdPaM41seI3Iat3+pkg8qir
 k7fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBzfXmkDXEhMyY88Hw1eEL0iw2AhtiJUZOUav7d1lX7lPVeTzjVbD4A12YTf8GWM7lGvUyoq3/66jn@nongnu.org
X-Gm-Message-State: AOJu0Yx5h2MwaJN8QmBaQcmutX9gjOqvwFyRd5pdyJMpFO06Rr/9E03Q
 QDjX9nmO/T0Ct7WlyFghFJgngYnba9eggiVDwcnatAVfb6TLHs9G0mpM2Kp4Ejgncw3g70C2O1a
 u7YmRvkTRhIC4l94EjIbHFyGwB0N8KR6cq+RiyJQBK2bPVovbc/YiZ4t7
X-Gm-Gg: ASbGncvI2z2f2jg9S1QgigongesPRIX9sH0oIDIwX0ZmLpOiYG2p97yUKMwR1YJ0VgZ
 TZGBiJpUZgrYqjijz4nqCh6YO5i4hejBzws0Am4T+Asjb0nFPR00sDaudW36Ee2E1ZRQkcDAAfQ
 pb7dbmny7SKELsobB1T0wPD0AbxW7Q8RB9r96W2l1B5GO9qpne1l//H3T71z9d2KjxTOyxXpuWE
 EgirFfx2Sbnhyigz43DaWd4IB0u6FhvCir/wMlvIxCxXZyxukKyemHkX7bPD205LQ7ECGCobvn4
 r9FHgYVt12fZ/1sRItKUoxvzR7h4PoGH8rVQrZYVACPyAil2OqpPyz4kQp6F3urbhJlqKU26U5k
 4tIgNRD3BT43YvFSmUcXNujLnpZrWEIhJzFLV/H9dyv3hcnlpqGtsKD/LGMPSMn/lGVg/W5ixFF
 P2gUNsV+pJtZ0KwSiSme1FVqQcVz5M
X-Received: by 2002:a05:600c:468e:b0:475:dd59:d8d8 with SMTP id
 5b1f17b1804b1-47730793c2amr30321415e9.8.1761902369909; 
 Fri, 31 Oct 2025 02:19:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2izMqR7jcBftRgP3Hjs+y4MXjqmsR5GbOknv+SJORnZ4ymmcmiooakcUIaSsIYmfmXC0WNQ==
X-Received: by 2002:a05:600c:468e:b0:475:dd59:d8d8 with SMTP id
 5b1f17b1804b1-47730793c2amr30321055e9.8.1761902369517; 
 Fri, 31 Oct 2025 02:19:29 -0700 (PDT)
Received: from ?IPV6:2003:cf:d717:1f4c:b757:9963:8006:395e?
 (p200300cfd7171f4cb75799638006395e.dip0.t-ipconnect.de.
 [2003:cf:d717:1f4c:b757:9963:8006:395e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4772fe402c5sm17087405e9.14.2025.10.31.02.19.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 02:19:28 -0700 (PDT)
Message-ID: <e4cd9d5d-6c09-4ed8-abf2-33146538d1b2@redhat.com>
Date: Fri, 31 Oct 2025 10:19:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/16] nvme: Kick and check completions in BDS context
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Peter Lieven <pl@dlhnet.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>
References: <20251028163343.116249-1-hreitz@redhat.com>
 <20251028163343.116249-8-hreitz@redhat.com> <aQJNdeSL9Sh_UMuf@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <aQJNdeSL9Sh_UMuf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
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

On 29.10.25 18:23, Kevin Wolf wrote:
> Am 28.10.2025 um 17:33 hat Hanna Czenczek geschrieben:
>> nvme_process_completion() must run in the main BDS context, so schedule
>> a BH for requests that aren’t there.
>>
>> The context in which we kick does not matter, but let’s just keep kick
>> and process_completion together for simplicity’s sake.
> Ok, fair, move the main BDS context for calling these functions. But
> doesn't that mean that we need to move back to the request context for
> calling the callback?
>
> In particular, I see this:
>
>      static void nvme_rw_cb_bh(void *opaque)
>      {
>          NVMeCoData *data = opaque;
>          qemu_coroutine_enter(data->co);
>      }
>
> The next patch changes some things about coroutine wakeup, but it
> doesn't touch this qemu_coroutine_enter(). So I think the coroutine is
> now running in the wrong thread.
>
> I also feel that it gets a bit confusing what is running in which
> context, so maybe we can add comments to each of the callbacks telling
> that they are running in main BDS context or request coroutine context.

Makes sense, I’ll try my best.

Hanna


