Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 904EED2ECEC
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 21:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhwND-0007TA-NB; Mon, 19 Jan 2026 16:01:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vhwMp-0007L5-EU
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 16:01:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vhwMm-00008b-NA
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 16:00:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768856450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2z0zmnJxqxCNk2xk8McI2avm6KO/yJgcNXtB2CcJGUo=;
 b=gSOgEBkiDEIcqXveml9V76cCEAZ/DVcsCsP6htjTFYpyTgDXmwkjxg5rqK8XH4KGl3qlyd
 QtWXnUKlio8W/wWXB5wrXWJIV6YFwLfkDVN4XlT3glkO2Gqs590u2eWPhqkucdiX1QaHre
 WkL1ym0XL8dREafbZVw/oCzqx5qDFaw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-tQEXko0mNRuwSVxFi0SEtQ-1; Mon, 19 Jan 2026 16:00:48 -0500
X-MC-Unique: tQEXko0mNRuwSVxFi0SEtQ-1
X-Mimecast-MFC-AGG-ID: tQEXko0mNRuwSVxFi0SEtQ_1768856447
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-430f8866932so3977092f8f.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 13:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768856447; x=1769461247; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=2z0zmnJxqxCNk2xk8McI2avm6KO/yJgcNXtB2CcJGUo=;
 b=EFBeSMxXRu7K3Gya55R5SpjC651BGIQJkYJfqhsHl6c5i2h2WGxjg9Dz4Pyuizsxct
 ILdhlZrrl3F1l1VYNqEuQkAfIWu9jR+TXYnoQKD0bTZJoHaFn0o+FzInTAXcqHkns3Zk
 WZ67dwDCbVqGkpdhIQdEDIqjSwTeA6J21sxf1p/QK9pcja5Qr+mit8qj50JU0d02Ekra
 FlseMb5eiajt7+MvZC4qxiComayEBv78LZUzcg1z0ypyXtX24xqGhgr68wVCkYDFJ4kA
 D+qUHNvXQJnmG534cDSCGGtG+FvDbzQdhPhQAZH1vtAwHWutevnvzT/GMlLznllCICNP
 XoeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768856447; x=1769461247;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2z0zmnJxqxCNk2xk8McI2avm6KO/yJgcNXtB2CcJGUo=;
 b=DobL/k2k+c03WsivjER3N+Tz+TzKV0cVuA5LvOA/bkaMZI3/4WUVjkyZwgWAucB8VV
 tQixV0rCzTI78rCkpQfyslnsBrWFlSYaP5Z/mHNg3T8n3T3RlCR+NyElGxB8VcNmYr2Z
 HZGlEBa2IfJ0PrzErYsc84MW/kwuFfh3pZNuXxGn6xnZx2dyDb3HIvaHTX4XPzW3oRXT
 Nk5t8CuBH6Umo/boYRGJqoA2ZWDeYnMkNxFhTgl/j/fWguVeLFWacMz7ACLvuOAR7b9P
 LwgSm/KrKhq8piOReZ+IwQ0OlRjzlRJrNkFql/y2Mo/fAPmued3u2pSAU5sb1c2bZYei
 1RGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0xrxdjFHkWLa31smAiUIA3GztyyfehcejnClwF1h2442lzyuNNMq787HCAmpCuOhKiQt2ayLEqQ7F@nongnu.org
X-Gm-Message-State: AOJu0Yww8WZd2rp+h/5iA7M1c32VHnY+vcTDnrJSvaqhdkW5wNETedFe
 8xfu1qJL5HyQim6LZbXI+Huz75JOWK/KdbRG+1UUmMuOeDKJx3eNQqFsoAdUqQs73ALsITACOv6
 3FWG4TdNR8qYJbTMXgzrZx09gFzCUIjWoGM+2PagfmnwpatqWknpmEtQG
X-Gm-Gg: AZuq6aIUrBunRG9HO0pBJi18SlidF+SvIcNrGby/IyxVV9viRyxkYeWxsrdtmy2Soe4
 QTgMTanP3nSz3bYAhcmkYYSppmz7FjsLmHbLGh4J9UWSIehAnk4pb7S4KyWQqLtLZUIr8iMhmha
 9SBU0+r6tFVp0AFypea29undtrP6U4eZhh1O1zpSzNTI+mn3ua7qQ7TeIIg/yraYKiBbog8yRKY
 vRRrVLt5IFtxwfZfdC1PS9LSGWZ/1LbLgfKo3eTyHB8ci00wI3pdHxUYIbFARKaJwDYUMfsJuAC
 Z5USjFsM04mJdXlFhkvuKshNymbpmBeGdmyr6e3UWO6dF3Hk73yD/NAl8AsQeXVMpJnFppxKHBL
 /mqZRC3ja2t0EVSRi0A/ZiqNXR1YadRua2He6jUVRt1oadGU7nCly05AlKHuOicDoBqlStnN0nu
 Sssw1x/gn7wwDMSg==
X-Received: by 2002:a05:6000:24c6:b0:432:5b81:483 with SMTP id
 ffacd0b85a97d-43569980c46mr16972946f8f.24.1768856447445; 
 Mon, 19 Jan 2026 13:00:47 -0800 (PST)
X-Received: by 2002:a05:6000:24c6:b0:432:5b81:483 with SMTP id
 ffacd0b85a97d-43569980c46mr16972918f8f.24.1768856447080; 
 Mon, 19 Jan 2026 13:00:47 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-4356997e6cdsm26428553f8f.31.2026.01.19.13.00.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jan 2026 13:00:46 -0800 (PST)
Message-ID: <a0e46280-3c8c-4864-808e-9c728efc1971@redhat.com>
Date: Mon, 19 Jan 2026 22:00:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/8] Tracing patches
To: Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Richard Henderson <rth@twiddle.net>, John Snow <jsnow@redhat.com>
References: <20260119190823.867761-1-stefanha@redhat.com>
 <2bf9fc90-c7c6-4439-8ac8-d955950591c5@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <2bf9fc90-c7c6-4439-8ac8-d955950591c5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 1/19/26 21:53, Richard Henderson wrote:
> 
> This has lots of failures:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/12772423978
> 
>> Summary of Failures:
>> 507/512 tracetool - 
>> qemu:dtrace                                              
>> FAIL             0.03s   exit status 1
>> 508/512 tracetool - 
>> qemu:ftrace                                              
>> FAIL             0.04s   exit status 1
>> 509/512 tracetool - 
>> qemu:log                                                 
>> FAIL             0.04s   exit status 1
>> 510/512 tracetool - 
>> qemu:simple                                              
>> FAIL             0.04s   exit status 1
>> 511/512 tracetool - 
>> qemu:syslog                                              
>> FAIL             0.04s   exit status 1
>> 512/512 tracetool - 
>> qemu:ust                                                 
>> FAIL             0.03s   exit status 1
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/12772423994

Given the PR is based on an old tag ("Merge tag 'pull-tcg-20250905' of 
https://gitlab.com/rth7680/qemu into staging") it's probably conflicting 
with some changes to python/.

Stefan, drop those and I'll resubmit in some time.

Paolo


