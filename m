Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55FB2E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 10:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXeLL-0007z4-9n; Tue, 14 Jan 2025 05:40:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tXeLK-0007yP-0L
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 05:40:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tXeLI-0005W1-Jk
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 05:40:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736851215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dzgw0NkTFr+hqlwoalxrRYJfEMdtKsBbAhwA3W2hAvk=;
 b=QAOGWJtVt8/xkVG4qDP8too7aV9zG1caY/N2AVnaQoSlPBdA7FXesQlk7hN5mBW5KhlGdG
 LinT/c19EPF9yWvomcfJgCDP4UHLsNgcjaszDp23gPgA6ZM+BZTSwL3MpwvnDatE7Ecwqq
 A82dPF20TbneZZWiIzjcRrCV/r3lJlQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-KcJJO_AuNxW_dLsKPaDbjA-1; Tue, 14 Jan 2025 05:40:13 -0500
X-MC-Unique: KcJJO_AuNxW_dLsKPaDbjA-1
X-Mimecast-MFC-AGG-ID: KcJJO_AuNxW_dLsKPaDbjA
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3862e986d17so2075588f8f.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 02:40:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736851211; x=1737456011;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dzgw0NkTFr+hqlwoalxrRYJfEMdtKsBbAhwA3W2hAvk=;
 b=uJsM1SgedIm15gVXqq/r/FCzIUQEnP1txaaNq4XhS49RLnVrokElqIRDvUrtpCWkcW
 B/IGe11NGBC3cWPvYZlDDovQKnZKMKbdX+xz2+NFC4DpK+gFwB13dpE15+nICl4b2u6v
 MgEYN35ZRdVq5GEbME6JFzkxXixljmSN9J78AMyem8kG5uOwBDCc5GkRRV+tbZVih6Rj
 +JGbQ280rJ0vktf2PFUb5GnfqZtcxDx6VjOxl/TJx+rHOBcqmfr6Mp/v5quNrSVm8Dmz
 5ChtnhGjV4q0w6dkSPbGQABqqny+eMr3mUhPfL5lskNjZ+oLVcFb9pChDiNUjtwmMYqa
 FbzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGR8IxHgfIhONlaRnkvF+9yC3+ftX7dTGRlwaygYuwBD1EKwTRh3SWnnyvv6ZkIvfhooeZ9cGs5rWf@nongnu.org
X-Gm-Message-State: AOJu0YwXwHG7jCeBRatbc0vLM4W4qgj7cYw7gy+CimRYV8xhU+zG90ec
 abAo4S5ikoxtc09DEOaF0dGayRIHPx3QH9iReKIVfPRfztnZJZ9dRtinyF+mJHf75RV0uLjjzzj
 BNBYPLtg8pgf4uMlC+DW97FTq3swwffCHVnCReUFpHHVacQ1oroCxZz1j+2LsuN4=
X-Gm-Gg: ASbGnctfsbUKYZQtlSRluRfLPiAApcK8zdFqB+txwaIJnStBPeDbxljXUcRNxKPd75T
 gKJADfCq6ArIATPN87MhTPLcGM4Qm5vWioBjjc1ZRhjlsNXZ5Saq5BSrE0vuYKqcNg2Fwckijpu
 EUxgjscSFHw64VTfL+tVLscQRdfvzWvaZDxZFbq2+LMmbBEZGQPFwu1WuBsWn1Sy9Nv1DPEvc3u
 jL4faXMG8yoTDYzpU2x2KhI/sroXHLzGIUTRlQjtYof5x0dzF6Vz0B7xHd0
X-Received: by 2002:a5d:5c0c:0:b0:385:fc00:f5d4 with SMTP id
 ffacd0b85a97d-38a8730acf1mr19708338f8f.29.1736851211703; 
 Tue, 14 Jan 2025 02:40:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFq4VYfgOuwV3OUGqI/UR37EbvzGyzUAfPKgaSqVJaQP7nhIUy5y+608qHBzZHgBLiEAy8FMw==
X-Received: by 2002:a5d:5c0c:0:b0:385:fc00:f5d4 with SMTP id
 ffacd0b85a97d-38a8730acf1mr19708320f8f.29.1736851211390; 
 Tue, 14 Jan 2025 02:40:11 -0800 (PST)
Received: from [192.168.10.3] ([176.206.124.70])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38bf78sm14319967f8f.48.2025.01.14.02.40.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 02:40:10 -0800 (PST)
Message-ID: <4895cc5c-32cd-4b1c-93d1-1980cece90bb@redhat.com>
Date: Tue, 14 Jan 2025 11:40:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/timer: fix int underflow
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?B?0JTQvNC40YLRgNC40Lkg0KTRgNC+0LvQvtCy?= <frolov@swemel.ru>
Cc: sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org
References: <20241106104041.624806-2-frolov@swemel.ru>
 <CAFEAcA-b+XcYEm1MASzedYchmy0TOpv2djqssJtQdu2CTw_jTw@mail.gmail.com>
 <7dd7787e-4eb3-47f9-bca6-2bfab69caf4a@swemel.ru>
 <CAFEAcA9gBph_CXnBBmrf=WfAuiLAhz=JF1ux0SZK2RGJwnK+Ug@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA9gBph_CXnBBmrf=WfAuiLAhz=JF1ux0SZK2RGJwnK+Ug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.019,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 1/14/25 11:14, Peter Maydell wrote:
>> So, to my opinion, explicit cast to "long long" is necessary
>> here to get the expected behavior.
> 
> I wasn't saying the existing code was necessarily correct,
> or that your proposed change was necessarily wrong.
> I was saying your patch didn't come with any analysis of
> what the actual hardware behaviour is, which is
> how you would determine whether the fix you propose
> is the correct one, or if it should be some other
> change instead. (Some of my response was trying to
> provide some of that analysis.)
I would say that the patch is more or less obvious in the sense that the 
intent of the code is to model a counter (which counts up by 1 and 
cannot miss a step) with a timer within a process that could be 
preempted.  You probably will not find an answer in the datasheet, other 
than by analyzing the signal diagrams, because this scenario simply 
cannot exist with a hardware counter.

However, the patch has another problem, which is that it can cause a 
stack overflow at imx_gpt_compute_next_timeout(s, event).

Paolo


