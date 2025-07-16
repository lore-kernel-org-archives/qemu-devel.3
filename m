Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79501C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 15:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc425-0003pX-6n; Wed, 16 Jul 2025 11:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uc41w-0003le-Lj
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 11:26:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uc41s-0004df-Qq
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 11:26:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752679602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cp6W86vHw6E8rrCssFSKuLge2PazBSu7MhY5CNm4ckI=;
 b=cHHKNnHMsxE0GFpZvS5K49uJhR0hbGMQkgfj55WrIHvfEXmhavaybHKqshqm1G2L+A5xuB
 oSjcLVU4hbt7BT4+eockwBVg9MhawVGMmMxc6eboc7Fpbl1h+8O8Suz91sqswpNnwiblJ+
 uZvWcfbeB6LWrxCtEedLhGreigQ45A4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-4ZqVOHlVM8eIBkXP4wxkbA-1; Wed, 16 Jul 2025 11:26:41 -0400
X-MC-Unique: 4ZqVOHlVM8eIBkXP4wxkbA-1
X-Mimecast-MFC-AGG-ID: 4ZqVOHlVM8eIBkXP4wxkbA_1752679599
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-455ea9cb0beso42838865e9.0
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 08:26:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752679599; x=1753284399;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Cp6W86vHw6E8rrCssFSKuLge2PazBSu7MhY5CNm4ckI=;
 b=fcBA1RsCR8d+r8FFv3/mRk2Z7QFDCtEKVYhf2ht9r90I9OoMNJvVJID3IV3RfvfLV3
 k+xnpcCu2Mozec62F21Vrw1ziR2fEenp7KjoqH6yOsyB/CuDlLfLVtZ/KO7IF72UNDo1
 WGeEUx63bPql0EEkRkxum4nrEUp0xEYGdrAp9Zjk5O/z7RhhkKvGqumYC54mLEZ89Ac4
 iJX5eLre7hYKp4EEbi2JhFr0qRlrUfOgARI0oTg5FCL9MmhEyWJSJwHtZpgx/oArbf6K
 ZO+i5wOD4LIMZCION8X22GmnyBGhS2B/Vj69aRnCt2wB0Z/3WG8Y8eZi3yXpIex3Gz2O
 kB/Q==
X-Gm-Message-State: AOJu0YyyWK0ECInrJYHpUx1PhKe1WJGHtrhXUIsaz1AZPEm7kEg63MRf
 cc0+5ea2N7Fkmxgqc4iIm+qeq80wMVvLLojTckMAMYE8H3OEZ+h7I5eBEoSw3MJSUMSPOhCrND0
 YDyGnEiX5nSqwgfx5lhk/idaZBaM7w02IQm3WrV+VL3hoUEpiZvQGJmK+
X-Gm-Gg: ASbGncvEGyxtypC1vii3ZBIk0PJ9Xw5PWrT97S8eQETL1QjctFDHwkhCUIYxYV+oyaB
 hIaZDtkO289dJO5qkE77fVx4Rhfq4FFM/tUDoeCUjVAz89wh46M1wp4nf3t91hRpbQN+gJbkDTP
 81X8X2fFtEtrddHBpWX7aCuJ9n/RkBU+dpxewj1pdNUfAoAMZqY4A3vgrNWKFV9ZzP/ECT4L2r7
 2kaUb0vcbvH14NqDng1fF4OoVZe4wHI57bxwR/yXsITGJlM+Xq4RmvWWw8IfcdoiCMXGHeebG72
 xa2gEaYAJcR3UfowochA178Ieda5IMUyphg17MYyHbvqh4vJR2bYWQbzidKkAKswo/f71MVEYPa
 fAu030XCwB7I=
X-Received: by 2002:a05:600c:a305:b0:453:8bc7:5e53 with SMTP id
 5b1f17b1804b1-4562e853505mr28341965e9.0.1752679598771; 
 Wed, 16 Jul 2025 08:26:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWBeoEUw20skYSmP4OnHJlblGwQlZITR6i+JHUgqwno1dL6yvQHpPDCJaEPw5p6xbkUvdjHA==
X-Received: by 2002:a05:600c:a305:b0:453:8bc7:5e53 with SMTP id
 5b1f17b1804b1-4562e853505mr28341355e9.0.1752679598403; 
 Wed, 16 Jul 2025 08:26:38 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c?
 ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e818525sm24165975e9.16.2025.07.16.08.26.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jul 2025 08:26:37 -0700 (PDT)
Message-ID: <5b901f04-da30-4f40-8ab9-803e03e43414@redhat.com>
Date: Wed, 16 Jul 2025 17:26:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: boot failure on top of current git
To: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
References: <6c04f89b-0313-481a-9d26-1fe9e60e0616@redhat.com>
 <1331c1fe-6064-4580-8464-02dee23c1fe2@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1331c1fe-6064-4580-8464-02dee23c1fe2@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/16/25 5:22 PM, Paolo Bonzini wrote:
> On 7/16/25 16:44, Paolo Abeni wrote:
>> I'm observing boot failure for a rhel-9.7 VM. I'm using qemu git tree at
>> commit c079d3a31e.
> 
> No and I cannot reproduce it.
> 
> What host is it (processor) and kernel version?

Host CPU is AMD EPYC 7302 16-Core Processor, the running hypervisor
kernel is ~current net-next (v6.16.0-rc5 + plus net-next new features
for 6.17)

/P


