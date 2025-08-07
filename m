Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8A6C87FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 10:36:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujxyV-0005jw-Ej; Thu, 07 Aug 2025 06:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ujxyT-0005bt-K6
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 06:35:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ujxyR-0004to-TN
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 06:35:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754562948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iisVqkit1NBL3hkJo83PNfsZe3VYe39fcCf3qNauJzI=;
 b=eapfydR6rVn7B1T/7XbrAAQYksjaKW24oMxhN34USQUclu+hmnujKm8qK9+8vr62sijsXX
 Aj6aK4iea7RcyoRqqx15PKCKksXiI7iXCnflMuMP435HzuHf6fdUCdSO5LAdxnuROZqFBq
 bOLf1YoCwrwvUPQRQaECEnmuFpzkrTA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-tZn3ajMgN_mBUoHQVBx7Ag-1; Thu, 07 Aug 2025 06:35:46 -0400
X-MC-Unique: tZn3ajMgN_mBUoHQVBx7Ag-1
X-Mimecast-MFC-AGG-ID: tZn3ajMgN_mBUoHQVBx7Ag_1754562945
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-451d30992bcso7022865e9.2
 for <qemu-devel@nongnu.org>; Thu, 07 Aug 2025 03:35:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754562945; x=1755167745;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iisVqkit1NBL3hkJo83PNfsZe3VYe39fcCf3qNauJzI=;
 b=j5Yml93UNw/Jr4sKplG7R/6/1MSBGQtTZ0ohehX4ScMXNJPktTfqizKXJuCMrq4cwM
 0zwGORvOHzJCkgcdAaS+jXRriD8w62jaEDLgneWu2ciJ9ixLdSA07mpYZzuMt28GIW9q
 miJmllk781PXzzciNylqCIKo80lJcHsTz3uYv5R4wxCPMYoKPA2aye44zgjl3EHjBuEv
 fmSWg1Mvmft5L8AS/s98R8eQ2sW5Fe6dYfeT5J9EFazr9EottqmiSbd0pYxakZlijbDd
 BWCwBj4BQMwzUAt6pW4oZIk5BSILqQRJJF/6mE4LldmVcN0zNJ0tMOarJwf8ThXSanG4
 voZw==
X-Gm-Message-State: AOJu0Ywl2Dh4mpzZytZfzEldzJfWKK+ATwoKUaqfzwbb8AI+o9cVsMEq
 26XxR6uzSHn6C06IG100LYKmev2bflAmSdaaELCaVhv0N1FIDUJjqpH78vBOKPkcsysJS3FLU8P
 ItT1KbY8nic9I3ozlFVdl5gVyH3oMzi0O1auUFBEsZqkwCUoq50uQ7Q5X
X-Gm-Gg: ASbGncuxA05gqtfyx2A621vFquPQ6cX80D0BolOmBg7VkGeQM5CW15Rq9wJ/ZXRYnAO
 Y+82LTQMpS/MVDIZqR7h+7goNtpH+b9kXeY+qNjWmzljQu3goH2VDvCLieg266OSFbx/WXw0n1C
 btuxYw5ijJYVsgZj8GjIjfomDDIHSKglgsid09M6tb/FkJlnKDuU1KS9S5H+WyUSNEvfwSTnNk3
 WdCKTedv54Lgrx9LIRRgMY4H/CUEmW5WarCQ+stVuXMqSwMorRIYZxRS2cxYFd7rKXXshx/yTjs
 ABGEdE/tIyx+DNePoLOI6ZRbQ4sScgpGwS2ut9r+5YXx
X-Received: by 2002:a05:6000:40db:b0:3b7:925b:571c with SMTP id
 ffacd0b85a97d-3b8f492a9f2mr4796922f8f.57.1754562945016; 
 Thu, 07 Aug 2025 03:35:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaGH1WaXI0DfLBf+grbMJ7U38m7a5G1MgxJ7cXtxI2jYdkLNJX+Bv6hoLeuF5H+VogTDcnyg==
X-Received: by 2002:a05:6000:40db:b0:3b7:925b:571c with SMTP id
 ffacd0b85a97d-3b8f492a9f2mr4796894f8f.57.1754562944509; 
 Thu, 07 Aug 2025 03:35:44 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.253.173])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3b79c485444sm26566655f8f.66.2025.08.07.03.35.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Aug 2025 03:35:43 -0700 (PDT)
Message-ID: <46c5fbcb-9aec-4f9e-984a-b2f255210007@redhat.com>
Date: Thu, 7 Aug 2025 12:35:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] tracetool: add CHECK_TRACE_EVENT_GET_STATE
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Tanish Desai <tanishdesai37@gmail.com>
Cc: qemu-devel@nongnu.org, Mads Ynddal <mads@ynddal.dk>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20250806150539.2871-1-tanishdesai37@gmail.com>
 <20250806150539.2871-2-tanishdesai37@gmail.com> <aJOpG5XuWHYZUQ4c@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <aJOpG5XuWHYZUQ4c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 8/6/25 21:13, Daniel P. Berrangé wrote:
> It is best to have new functionality added in a separate commit
> from the removal of obsolete code.

My mistake - when Tanish and I "un-rebased" these patches from on top of 
yours, we placed the removal of the "nocheck" functions in patch 1 
instead of patch 2 where it made more sense.

> I've co-incidentally got removal of this obsolete code in the
> tracing test suite series I posted, so one will need to be
> rebased on top of the other, depending on what order Stefan
> wants to take the patches.

If the main blocker (the /dev/stdout issue) is fixed quickly, your 
patches should go in first because they aid in reviewing this one.

Tanish has started school again, so he'll probably concentrate on 
finishing what he has of the Rust work and I'll resubmit his patches later.

Paolo


