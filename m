Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44329C98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 14:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Ndx-0006Yr-Ao; Wed, 23 Sep 2026 10:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x9Ndv-0006YU-Fs
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 10:08:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x9Ndt-00054S-TT
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 10:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790172491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yfcqSFnXiciCOo4CRLRZgOmIJYVaYNwuxhVDpQOB0Ew=;
 b=NUhZvIKw3GwCH2dLQxs+2uMDGd8JJogGUmqGEp1XuCTPgPiwebvbCB0Hk0TjIYVDcX6i2U
 0y2Z9q4nG8ztQNmcbb+C9c44EPFz6tJEzjcYJ/Ze+R1dFltEm0zkzo9wdb6emYE3fSqyQ+
 62KK+a/QZiHNw75TJCYcyUvvl0rnf8w=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-5Zd5fJuXOraySKBfUyia6w-1; Wed, 23 Sep 2026 10:08:09 -0400
X-MC-Unique: 5Zd5fJuXOraySKBfUyia6w-1
X-Mimecast-MFC-AGG-ID: 5Zd5fJuXOraySKBfUyia6w_1790172488
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-c25edb54d22so110634566b.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 07:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790172488; x=1790777288; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yfcqSFnXiciCOo4CRLRZgOmIJYVaYNwuxhVDpQOB0Ew=;
 b=jmdy4zleoonScVmRT+ZLzqlD+iuDIOUHJ4hj7Zlk5xP5MKi/FGhX1txW5nfJbjE4NE
 xZ/Ulmdo18g/C+55WSU53upQ3YrUNsa1cVxf6F2n2JIyWtL/FdgYmFpGwFfXHfsS4Jcq
 NjQNXahnzfmYjYUKLMLGTXjcsX0n0icjFRZgHZAhrvzHnm0QRF/moj5uqiCnOVuQqoNw
 sis+IpkMk1/trq/Vks8HVe8JzIgG742DiiID8AHIJa1XFeH3Nk+WBPmXdvdXfZzD5EVg
 VcHt++NDEpn8BzmK9NMP68DB0758fKHX3VnYoM+b1uAvXx9vFAQt+MB5dThmN1X+daCO
 CDaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790172488; x=1790777288;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yfcqSFnXiciCOo4CRLRZgOmIJYVaYNwuxhVDpQOB0Ew=;
 b=AG79W48wn+zXZiBOB6oUby72lRbpBx/3H6x94Vpi38luM8u4tx+iJ5AiUpGuX4X+9h
 oFj822E4zuXxPw4OGLXgPMcyQR8E73X2g23SeObntH2dC/HCF+5Vz4eryn8E4hEJ9mQ+
 MeL9a2CczEqM/t+pQ5w/+MLXzEFJ7DbnkUE6t6WqnoU8cPe0425C27upyx6wm5aU26ty
 98fhbhHWrtHUPV4sPZC/gDuyP3YRcLzCI94mg7oawO/XcCx3Wx2GxwvpShLRJad1KDTP
 Y1zGuUPyWeTl5KRE3xEN26preNk+78EeNMi+Y4TbsUu8bZ904YvTZfUyUX6ZzNM78vMU
 RrPA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwZY7HOBPg5ek6N8E6qygwDfvQOabQn3tWOPo0JiwCcX4VRDtcI6A7cqB3qI/yES2yFKOOyJWz3JEHT@nongnu.org
X-Gm-Message-State: AFuF++kWlbIlaJGRv3f9vZpLspd6ZsZiapsEIonqK+8MKNyqhr+3X9Hl
 VYjvzoLRcTJ9JbI/bCLm8JinNQIknPaX0ZCkuy2YCCxRaiyanSIXbNY0q1ClW1oP84TdtsJ1JdM
 vlYeEcucHAEg5IVw3U4QBU4IE2nA0cY9S2krGMbW49Slc9TtK3EhOZwqp
X-Gm-Gg: AYBFou0gHw+B7GqcDcup+mRdiRDOE1YD2MKtuYyG9C0YRVZ8lbzYJPVkpYZCmFIuhQA
 IexqUkyrMDumz4EHXuVjI9ejtoAy0OcRxgASfOVNCs7xsC5v1fLZI64ny34ihA4/jH0ctL603sn
 5bfKv/H75hNQqWsxiK68eiNPiQQtPzNPXeVDvMb+12U8FFBnPRyxuCwUbW+rg1Jv4INP3ILrETX
 1sTp/Ih8dxnL3E2fl6OFHriTvEAzlg2+7c33SfQLRpX8eea+PzyakhAo7Ocf2xzFGQWikKVC82/
 r3uhPmCFYjVFMHQo3BD0opRGOHNQS1NQQf1VpILM0hcgSBUSydrCHij82I9IR2rtrBgiy6Tw
X-Received: by 2002:a05:6402:23c7:b0:6aa:9fd4:987a with SMTP id
 4fb4d7f45d1cf-6aab3b985dcmr2275809a12.20.1790172488439; 
 Wed, 23 Sep 2026 07:08:08 -0700 (PDT)
X-Received: by 2002:a05:6402:23c7:b0:6aa:9fd4:987a with SMTP id
 4fb4d7f45d1cf-6aab3b985dcmr2275792a12.20.1790172488026; 
 Wed, 23 Sep 2026 07:08:08 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.141])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aab3896ba1sm1835002a12.19.2026.09.23.07.08.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 07:08:06 -0700 (PDT)
Message-ID: <965837a0-0ddd-4796-8eca-e7f18d808471@redhat.com>
Date: Wed, 23 Sep 2026 16:08:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [qemu-web PATCH v4] blog post: some notes on the bugpocalypse
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: yodel.eldar@yodel.dev, pbonzini@redhat.com
References: <20260923132619.2835622-1-alex.bennee@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260923132619.2835622-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 23/09/2026 15.26, Alex Bennée wrote:
> As we've been going through the growing pains of AI bug bots I thought
> it might be worth addressing in a blog post. I'm mainly just trying to
> outline the challenges and maybe dissuade people from spam bombing the
> bug tracker with lots of low value bugs in the more dusty corners of
> the codebase.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Thanks, article has been pushed to the blog:

  https://www.qemu.org/2026/09/23/bugs/

  Thomas


