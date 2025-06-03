Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C6BC5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 15:06:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMTDU-0002vh-4q; Tue, 03 Jun 2025 11:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uMTDS-0002vN-2P
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 11:06:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uMTDL-0005CT-Lm
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 11:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748963163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1IZ/LMxFnOz6iL4qEKoCw0elTKgAlsmAe4sD2ue5a60=;
 b=DL04yp0F9henMTylZ4p1GnVkdJG2cXzP7tWuHanG45Ezh8vrgaTLepkJKT3GoO++27qMUt
 dgNoC1zgkEeaFOnknxBillvAtvIJza6srYzVaJqNrIFF63AFgWfSVSdPaTk7UoN6Il0DpN
 tskMvjcnuhsreG0O2vVCUBnYAb0KM7U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-xAJu-htKONG5QpHq62T48A-1; Tue, 03 Jun 2025 11:06:02 -0400
X-MC-Unique: xAJu-htKONG5QpHq62T48A-1
X-Mimecast-MFC-AGG-ID: xAJu-htKONG5QpHq62T48A_1748963161
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4f8fd1847so1661629f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 08:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748963161; x=1749567961;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1IZ/LMxFnOz6iL4qEKoCw0elTKgAlsmAe4sD2ue5a60=;
 b=sk+p8o5zZcCx6XDG88a7/V2t+Xspj0JQBD1jMDm+IlPp9iN1gDdLxsBvnLsLDkLnef
 +vwJ5qH+b0MK2QrX1FhrRH6zQfuMo3Z0+9oSpOjSfuOXRSC4yCxNlFp2ed5Fkzn7S+ZF
 DQMw+rW4Pg/qU8aVTEwTASlw1Dzim1kWA0uDhkaJehd7SHBD9T+VA2hgcbkGRaRPZGnd
 QHYULe2r9PTSyiljtL1ap63ySrvGJEucP7Xdxji78vnxdyoJiEzQXTxymsbG/89k5fW3
 sgGo/UvrWNWX/ZvZ13R5Qzm+aG1zwn+19m9MwxK7+3yXMgoqWUbyF8kF22mMXqMWTJ/M
 eo6w==
X-Gm-Message-State: AOJu0Yy1b/f0EjwMwTIWxLeXM018UWN28+0DYprlykEJOCy68Zo7P3u0
 wE9LVa0A1XxMlgqTHERZbp1CG7/OXWUTrXpOt17hBgCSQgq6SUT91gSgjL0sj1C2trdc3SVY4m6
 ymTDO5tGUlC3nmnzBEIcI+GMb8+uAz3J9oIgtO3o1qrkCYOax6xX4gf4q
X-Gm-Gg: ASbGncuhpDHcB8rRIZF3IjQutMB0T25xgxXodh2Pafu/AGbKMSRz7J87bdgYKZB+flq
 AJbgh/5Dpkr5bTr+TFFAsHO1YbALsBCYq5zMC2hBhxDxAx/H8VEOSTuf2kj+SgOF+Rl3iDq24xV
 UD0AiHp/5tFtR9rTrGGTGyW8AKR728SHn5r8oZTNEJss2obF7un+f5SDRXuQiyW0JH16waahcML
 xoNsyDosMfZ14yu9qmMJKT9aiSOxPPyVPwdHznv0hTWuhnyFaVW9juujwx/CP1MSATceL4dblcV
 qPf2CqiCi/JNUlHYa2cC2+5J
X-Received: by 2002:a05:6000:25ca:b0:3a3:581f:9af9 with SMTP id
 ffacd0b85a97d-3a4f7a3dab5mr14036731f8f.7.1748963160923; 
 Tue, 03 Jun 2025 08:06:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHq0XXSGu7SiGJd+x3FANEdqgdSaZCVP7iZvyozqB2WqrK3BQvVvX7C2oMIKPBeWO1vSq/4oQ==
X-Received: by 2002:a05:6000:25ca:b0:3a3:581f:9af9 with SMTP id
 ffacd0b85a97d-3a4f7a3dab5mr14036676f8f.7.1748963160406; 
 Tue, 03 Jun 2025 08:06:00 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe5b7bbsm18351391f8f.4.2025.06.03.08.05.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 08:05:59 -0700 (PDT)
Message-ID: <2b7be73c-d91f-4820-a8ad-6964a8331150@redhat.com>
Date: Tue, 3 Jun 2025 17:05:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/14] rust: qemu-api: add bindings to Error
To: Markus Armbruster <armbru@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
References: <20250530080307.2055502-1-pbonzini@redhat.com>
 <20250530080307.2055502-7-pbonzini@redhat.com> <877c1uffj3.fsf@pond.sub.org>
 <aD7AbxghCc5VYDhu@intel.com> <8734ch5d5c.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <8734ch5d5c.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/3/25 12:32, Markus Armbruster wrote:
>> Then Rust's propagate has the same behavior as C (Of course, here Rust
>> is actually using C's error_propagate, so the two are equivalent.)
> 
> *If* we want propagate semantics.  I'm not sure we do.

Yes, we do.  This function is used at the Rust-to-C boundary and should 
behave exactly like C functions would: it will get an Error ** from the 
callers and needs to propagate the just-created Error* into it.

In fact, I had found this issue already last Friday, but then didn't 
inform you because of the (long) weekend.  Apologies for that.

Paolo


