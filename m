Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 228D8CA0ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 07:49:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1unubq-0004LF-EZ; Mon, 18 Aug 2025 03:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1unubo-0004Kq-Q9
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 03:48:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1unubl-0001Us-Hy
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 03:48:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755503323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/FQx5uRvb5VqwzmCTyQFZIvU5sqLY35Ik6mczUBGVko=;
 b=hPulYae4zJcq0ZQH4Dvo9HW3oHq2yTY2a1i+khjo/OgcDBljXSim300qMFah0HDAvdHpBz
 Afszvo2aU+UCXSBDA0O8dhyppqlrO/N3nrSBuMffYL4P6Fv7blLyPvRRKS5oLMOoXrzUOL
 ZtUymiYn6sJntzpE0B8w1c1/zY6E6j8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-Jf--qMiHPOS2wqubFA7IHQ-1; Mon, 18 Aug 2025 03:48:41 -0400
X-MC-Unique: Jf--qMiHPOS2wqubFA7IHQ-1
X-Mimecast-MFC-AGG-ID: Jf--qMiHPOS2wqubFA7IHQ_1755503320
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7e86499748cso1317951585a.1
 for <qemu-devel@nongnu.org>; Mon, 18 Aug 2025 00:48:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755503320; x=1756108120;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/FQx5uRvb5VqwzmCTyQFZIvU5sqLY35Ik6mczUBGVko=;
 b=C6pkHV4lBPbeGIx07/EzsGmLuLPOFBy6+vn4okchzVWAhBeZi5i0vl66o+xnzOJLC8
 /b+g+POpuzFG6VoU3cC0QtQrlLjhgQbELea2IL0yRCnh8coRnq/nyvGQv6ilt/ojQAzR
 R0jvJ1kZaWqorUZ61qigk42E3xamgKX1KsRGNJA9lYU9gkjmCmissvCHglTDMv9WEd6U
 ks5WFTT5lZEK4Nx0AKX4XiWcq8oY04XcHo9ZVMm3WGqEYuDm1P6FQnMFwhWJ/5aPJxwn
 O1KKlCsiqw58wY7dFPaXR31aycRqI3CGVebtdHCI2X/K536vn/qdnkBNUnL78IHNgPEq
 HLaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWW27os+K9PIb8HLwobpD57cNF7MIEzmnEx68JLrJYZuiq8IU14UZMadfv6jcys2BGCYBS1mnxJotMa@nongnu.org
X-Gm-Message-State: AOJu0YxVjVt6z+gcksikWCKGklW/8eqJAJkEXnDC7rbR9J8bBhVn2Z7z
 NkLdyisAaNZh5iv+pWCCMRr7bpg7W6+/j5PV9nJ70iQ35qWv8m1bCQlhh3inEHdLmBmGk+RiKcS
 b0cRGpzyMENVGTkY7nwJ0EWllFJILR8QE8EQEHzq9Znso3D+nRur5dl0w
X-Gm-Gg: ASbGncuryjm8Qdw3GxCSOnovXgh4qtu/03H679+UeUqQLAbDXMrwinQj3Y7Vu1OOCEd
 fkJ7qrjqKTdQY5aAWklE4xOrFWd14oLnl0NLDT93Sdixut6VYnhX6C0nCQsBIdqhdEbdFUlb4yv
 Dw2FTl8hUvvWqbiFAbDkjoHWYLbsn2wIjDtEzjhiBfXc6piORo4N+wkwUs24FWNTVmLQX7vOdWi
 CGBrvsmEbbLZ+GxRJa+aPOt2exKwq/BwroS6Fe+Fo5vP3Db4FUqzMyCt4POxHNaF6WMsO7bqK+l
 cabp6rbOP+eTqAESuRvZyWUJkuV7e3p9kh6vJzVcyhEDnom/Du1tTzVI78B6kBwFVJFsgXLed39
 GP8Q=
X-Received: by 2002:ad4:5587:0:b0:70b:ae3b:4fcf with SMTP id
 6a1803df08f44-70bae3b53demr97263066d6.23.1755503320358; 
 Mon, 18 Aug 2025 00:48:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf94CipCfYBpYZ2VlEUA8z9tp+Cha9Ebb/SKAMsBRIbEGcobIdlWQeipGV2gMOJuEIziTNdw==
X-Received: by 2002:ad4:5587:0:b0:70b:ae3b:4fcf with SMTP id
 6a1803df08f44-70bae3b53demr97262886d6.23.1755503319947; 
 Mon, 18 Aug 2025 00:48:39 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-113-055.pools.arcor-ip.net.
 [47.64.113.55]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e87e1dd19esm543798385a.74.2025.08.18.00.48.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Aug 2025 00:48:39 -0700 (PDT)
Message-ID: <fe4e09ca-52bb-4af9-9a0b-49aac54d2a37@redhat.com>
Date: Mon, 18 Aug 2025 09:48:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] Add IBM PPE42 support
To: Glenn Miles <milesg@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@redhat.com, npiggin@gmail.com,
 harshpb@linux.ibm.com
References: <20250814223741.29433-1-milesg@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250814223741.29433-1-milesg@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 15/08/2025 00.37, Glenn Miles wrote:
...
> I have some code that tests the instructions that are
> specific to the PPE42.  It is a very basic test written
> in assembly.  This can be found at:
> 
> https://github.com/milesg-github/ppe42-tests
> 
> There is also a prebuilt image there in the images
> folder.
> 
> Building the image requires a forked version of an old
> version of GCC, which can be found here:
> 
> https://github.com/open-power/ppe42-gcc
> 
> Even though everything that is necessary to build the
> image is publicly available, it is not a simple task.
> This is why I think it would be best to just use the
> prebuilt image available on github instead of trying to
> build it.

With the compiler being not available in the major distros, the idea with 
the prebuilt image is better indeed.

> Also, there is currently no support for having console
> output (this is also not supported in the actual HW).
> All logging on actual hardware is done using in-memory
> trace buffers that requires a special tool for translation
> to a human readable format. Because of this, I'm thinking
> this is not a good candidate for using the QEMU
> "tests/functional" framework, which seems to rely a lot
> on console output.
> 
> I do think it would be possible to use the qtest framework
> to load the image and run it.
> 
> The existing test will cause a checkstop if it fails.
> This leads to dumping the cpu registers, which aids in
> debug.  There is currently no way to tell that the
> test completed, other than checking the NIP address,
> but this could be easily remedied by having the guest
> code write some status to a fixed memory address and
> then having the qtest code poll that memory address
> to determine that the test completed within some reasonable
> timeout period.
> 
> The one thing that I'm not sure about with using the
> qtest framework is how to retrieve the image. If anyone
> has suggestions or examples of that being done for a qtest,
> please do share!

The qtest framework does not have any support for downloading images. I 
think you're way better off using the functional framework for this. The 
console output is just optional there, so if your image does not have any 
serial console output, there are still other means of checking for success.

For example, if you can be sure that a successful test always ends up with a 
certain NIP, you could use

  output = vm.cmd('human-monitor-command', command_line='info registers')

to check the current status of the registers and check the NIP there.

And assuming that a checkstop will cause a QMP event, you could likely also 
use one of the event functions from python/qemu/machine/machine.py to check 
for a failure while waiting for the right NIP.

  HTH,
   Thomas


