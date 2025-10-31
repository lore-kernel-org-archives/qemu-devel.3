Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97C3CCF9FA
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 09:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vElTk-00034V-AD; Fri, 31 Oct 2025 05:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vElTg-00033f-4x
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 05:31:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vElTb-0004NG-GK
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 05:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761903077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+3ignvJa2MwZhJqv7vbLBKfijqZzak6Gd1733ilbURg=;
 b=eZjJpx+NbDt/xO9QaLDdLKd1kiAJ39VBDQAehdKh+9f5M463kbbBJ3R9w7sOBpDS9gSyZx
 1hfSd45xVwm3G106scl4ZcUyV7JoOPYaZDD9tjdIviyRKFKri4YtKPzUdGlIgee7uE9Ryy
 DakcXYvGCNtGbzXqFfpjaeZLYeXkpkw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-vp6OyDBZMOahI287f6shUg-1; Fri, 31 Oct 2025 05:31:16 -0400
X-MC-Unique: vp6OyDBZMOahI287f6shUg-1
X-Mimecast-MFC-AGG-ID: vp6OyDBZMOahI287f6shUg_1761903075
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-428567f67c5so961970f8f.2
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 02:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761903074; x=1762507874;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+3ignvJa2MwZhJqv7vbLBKfijqZzak6Gd1733ilbURg=;
 b=fbtZEtnBW9VdQyCEH0MYNFcSBdGUFoohmm1OtB25CmaG4C50qDrZECWm1vD57uYC4S
 aIVaYJhsKVD5bqhFTF9tISvqEKk/qUqH2fYcVn2CpZfsXA+5KWHVkLBGlkOzcTbhbEMq
 CJI2Rrx9q40oR/R9g1fC39+VjZ9Sgfp7yJ4C3WzjvKZY8vP8KPuvMKhb0fqqy/kQmvBi
 i7bz59abhmXqkSl72Ka+jgu3bpOdxAkifZPl51KPVJMoOaJspP2EPQsSArRwcDRSWFW2
 Ct90ao7J/2Ccf+zIAwrZQ3v14xNIGZM9u3dnBl34pnTD5jto+ukF/mns5AnvKLpzCbBE
 fT1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCiGbd9eCgQn7aWdVUj+1BATsa4X4tts+hXsuh7GfzNG69GYJoViu2XRBSLR1qxal4KgpVh78t8FCJ@nongnu.org
X-Gm-Message-State: AOJu0Yzp7cHJZropAbqiwYwjTvh3Lsyiq4AKy/3tyYFqMYf/f/sXIWB+
 HF2PMJm6pCAxDo4olT8eiZy0dTy8JGMspk8FrixD9082YsYZ/XVD35UKPK0yEHRDDqBFhbcg69J
 aHJmYI6nxbDzTb9WICkEMeUpBC806LIaDbhVQNIVB+MsvEyoWy89WY3s/lFSLSo/f
X-Gm-Gg: ASbGnctB1/WYPLSmGgmgQs3MJlYI+4wLmNxWfi6whGz3LMLpVX2TVCD3Op2M21QKbj6
 LfR28fZrE9/LiNlwObohVmE/Vc4QMFeTD6yQ/23ol3OYC+tdQnEnHlHRtNMSAH7AGZLJqcZfz9i
 FuiRSAkXrHd/qZfn+BHyNZk/BTN0wNBY57t+8r1wf3hTZ+PjjMQw4KmVQ36ECBA3AqRFwTJSLwv
 fLT8F2qHBBsqq7HAJ+VuDizfUA08VIBmTv+PGXmr5IAO0ycqNiFkXWDMtdvKqyl50U62u25tVGC
 cSH6Nl3XrqHTMvh6C9KPmhfm59Ovtx6/S6xYL7mCSQ+OkrxXSie78+R1zBLHLecLD8qUuzSE4/F
 AzXg1Z7ePuOnyuMu2g50FUxB2ClhvU4nc/3X/SnYcOXBeXtDsTi9Lm12rgMKJhSiHjOq5g/6TpM
 LE2mDBqAAgebMwy2JnnK+IX7/Swao8
X-Received: by 2002:a05:6000:1846:b0:426:d80c:2759 with SMTP id
 ffacd0b85a97d-429bd696c7fmr2477915f8f.25.1761903073751; 
 Fri, 31 Oct 2025 02:31:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUtql4N47jiKx1Hg4wIRVJw0j5wY7h+s/AwPw9dcfgEpMezhEQ6le1hyjldZr4KV+ZuprQ9Q==
X-Received: by 2002:a05:6000:1846:b0:426:d80c:2759 with SMTP id
 ffacd0b85a97d-429bd696c7fmr2477874f8f.25.1761903073327; 
 Fri, 31 Oct 2025 02:31:13 -0700 (PDT)
Received: from ?IPV6:2003:cf:d717:1f4c:b757:9963:8006:395e?
 (p200300cfd7171f4cb75799638006395e.dip0.t-ipconnect.de.
 [2003:cf:d717:1f4c:b757:9963:8006:395e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c10ff4f6sm3258963f8f.4.2025.10.31.02.31.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 02:31:12 -0700 (PDT)
Message-ID: <90078c5e-7237-4226-9bf4-82a8feb36888@redhat.com>
Date: Fri, 31 Oct 2025 10:31:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/16] win32-aio: Run CB in original context
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Peter Lieven <pl@dlhnet.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>
References: <20251028163343.116249-1-hreitz@redhat.com>
 <20251028163343.116249-17-hreitz@redhat.com> <aQNyaNumB0tiCOgM@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <aQNyaNumB0tiCOgM@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
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

On 30.10.25 15:12, Kevin Wolf wrote:
> Am 28.10.2025 um 17:33 hat Hanna Czenczek geschrieben:
>> AIO callbacks must be called in the originally calling AioContext,
>> regardless of the BDS’s “main” AioContext.
>>
>> Note: I tried to test this (under wine), but failed.  Whenever I tried
>> to use multiqueue or even just an I/O thread for a virtio-blk (or
>> virtio-scsi) device, I/O stalled, both with and without this patch.
>>
>> For what it’s worth, when not using an I/O thread, I/O continued to work
>> with this patch.
>>
>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> Should we then do the opposite thing and just move every request into
> the main thread and only move back before returning to the caller?

Maybe it would be fairer to fail requests when they’re not in BDS context?

> But I'm also not against making the theoretical fix so that maybe
> someone can fix the other problem later. It just seems to be of somewhat
> limited use on its own.

True.  But as explained in patch 13, these last few patches are not 
really that useful in practice anyway…

Hanna


