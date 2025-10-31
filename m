Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CCF2CCFA00
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 09:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vElHH-0005wR-Cr; Fri, 31 Oct 2025 05:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vElHB-0005vN-7s
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 05:18:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vElH1-0001FI-B5
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 05:18:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761902296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s6EXPNUXaT2p6v6v9bthKECvXz67R15cSfnJUpjFZoc=;
 b=fS51thzX6DlJcJG0KEQGXnfJPwUpq8RHsMUijFAGZJpASQtNqbz65G2bFhWnS/J8RM3MgX
 cs1tb8QGBt0CK1weznWu98YZ2SgCqmryIy3fBnpLX0J9XflmB17XmY4R3kj6z2XBLymEFE
 cVzR6rDUfErv/eOVP5fF7YyhZWhR2hs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-s3gMPbF6NcuiMuZVLC-mTQ-1; Fri, 31 Oct 2025 05:18:14 -0400
X-MC-Unique: s3gMPbF6NcuiMuZVLC-mTQ-1
X-Mimecast-MFC-AGG-ID: s3gMPbF6NcuiMuZVLC-mTQ_1761902293
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-429be5aeea2so336346f8f.2
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 02:18:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761902293; x=1762507093;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s6EXPNUXaT2p6v6v9bthKECvXz67R15cSfnJUpjFZoc=;
 b=ePXPed5t+wgN87EhmQ+HysuqBEBPHdQqXXw5lwL2ZoRxOPFLvzVNN5QwWcJpAByMcH
 c/uQN8uwxbAxTV4UEvJX2iEAfbDQJ6EIrEQE0Qp5ixrB8U8MDqVlOq37NayUiLBRyRXu
 u7Tu2mVIs0kWFjgx2RraKrR3k/2UDRfzRXnjnfw0YqCGhvGOuWb61rYj7J0drvtWf4W+
 dpawP/Yo+WpRWa1OJbIQc18osgt1NOf3AKak39DyOvLEBAwr/hqimxrDKG/pr4Rmc856
 kj0oAvC9EVoOOEj5ERKd61rrMjZEpzqWcGln6xB1nhymllnBBctStwM9Oa96k2DEq8Uv
 AWyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPcIDux4RNfaFXYJBjv2A0XsXR2b+aGX/I6A49JZjW2u3+us5ZfLiPB9wyzjfAhLlYzKWCwpIzj3Du@nongnu.org
X-Gm-Message-State: AOJu0Yzkd672XY3hfrOzxO4uedCG8GLG5EW3xaDE9RvMjhU7HmXb1FdR
 j/59guzHe6dzm/X4LJKY+0gnOtNvy+v5S24looj8FStsNA2W44oWkboDBlifgfRgYtoQ+i/xGl9
 IEzPwJQ5d3XCuY5ztxxoWCYzYvsSa21eYwtqPdkbwkQzVwQHX12l4C2bm
X-Gm-Gg: ASbGncuLRreD1N5+12V4uePZ/DKo8sKMVnG+cIh2XpuYl9fY2Rff0gmMvgsUba7ED0E
 aNhRdSipbPMSgHGwYiiVC4ucqsY0N/Y8lTADrop94aPL3Mgp3k2koRpNecStW5u9+9/lW98tPo5
 hGds62HWSl7GKiBcXEMu4t8Pw9e6csPaMCC3lkAQBb+3lRgz+jIEPx6EayKo+rERtb1GbUTen+V
 b3C8J38pqUXgT/nJ9TXTJMh6z6zNHJUQwkjoxNU7HNLJMHuR+TdTRu2q3kmXzrpcCkn//nXvj8s
 E4LqiSjAdeCJs/mUxGvFQeEKzO/SIsOkT6vc/y11z0ujkd3NhW6GmSmv95M5NiXugxBtBJY2sdM
 4/1h8szHON9WcXg8vZrcAfvgLDojNIgolT6YCwKucBt+yPa5QN4ycudunkQnLk6bBfuOhIB3dHL
 mYfeCXcqPHhELT0lGNKPxCwTPBVt0y
X-Received: by 2002:a05:6000:400b:b0:3eb:d906:e553 with SMTP id
 ffacd0b85a97d-429bd6b0fd0mr1982542f8f.55.1761902293353; 
 Fri, 31 Oct 2025 02:18:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGmos02VzuchYXfNRExLcJU/VGYn+QQFekirmsKLRWGK1Tdlum9X9Bnarv4j/T1REu5oygAg==
X-Received: by 2002:a05:6000:400b:b0:3eb:d906:e553 with SMTP id
 ffacd0b85a97d-429bd6b0fd0mr1982504f8f.55.1761902292864; 
 Fri, 31 Oct 2025 02:18:12 -0700 (PDT)
Received: from ?IPV6:2003:cf:d717:1f4c:b757:9963:8006:395e?
 (p200300cfd7171f4cb75799638006395e.dip0.t-ipconnect.de.
 [2003:cf:d717:1f4c:b757:9963:8006:395e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c110037asm2770874f8f.3.2025.10.31.02.18.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 02:18:12 -0700 (PDT)
Message-ID: <26cdc7e2-f679-4a60-acbe-4908656a3133@redhat.com>
Date: Fri, 31 Oct 2025 10:18:07 +0100
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
 <aQJRb3OnQSa7dRbV@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <aQJRb3OnQSa7dRbV@redhat.com>
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
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 29.10.25 18:39, Kevin Wolf wrote:
> Am 29.10.2025 um 18:23 hat Kevin Wolf geschrieben:
>> Am 28.10.2025 um 17:33 hat Hanna Czenczek geschrieben:
>>> nvme_process_completion() must run in the main BDS context, so schedule
>>> a BH for requests that aren’t there.
>>>
>>> The context in which we kick does not matter, but let’s just keep kick
>>> and process_completion together for simplicity’s sake.
>> Ok, fair, move the main BDS context for calling these functions. But
>> doesn't that mean that we need to move back to the request context for
>> calling the callback?
>>
>> In particular, I see this:
>>
>>      static void nvme_rw_cb_bh(void *opaque)
>>      {
>>          NVMeCoData *data = opaque;
>>          qemu_coroutine_enter(data->co);
>>      }
>>
>> The next patch changes some things about coroutine wakeup, but it
>> doesn't touch this qemu_coroutine_enter(). So I think the coroutine is
>> now running in the wrong thread.
> It actually isn't because the patch changes in which AioContext the BH
> is called. Quite confusing with all the indirections. Let's get rid of
> the BH with qemu_coroutine_enter() and just call aio_co_wake() directly.

Sure!

Hanna


