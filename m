Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B89C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 12:46:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sThZH-0005Ur-JZ; Tue, 16 Jul 2024 08:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sThZ9-0005Np-2f
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 08:46:00 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sThZ3-0003om-1a
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 08:45:58 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-70b0d0fefe3so3602856b3a.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 05:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721133951; x=1721738751;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rOuxCoACSPq1GnfkCfn7NwbtjJPC2BPJg/qz9qiakzk=;
 b=KJf8D+EE8xS8Z9jA4CQc49IxX5y4ZyS3TyuMFVSU4MARiJhkYG+RkOvFB7fMWDjfgJ
 l3O74GL4cV789Jyla3tNoQiUF5YO6j+ilWVe1l6Ojo8xtQXsoo6BtSp0hnG5UyVBY3P9
 gddS6sAAVHwksS6gCINI4cZJnDK2VDyPStCICgFCWb2dzG2aaxaG6BtYYC2rmu0M/E49
 8Jqgjz8WzCrgPpGe+vKdT3jgFGAiPg1POXCOUaR3SaEYAHTq2WpIpN67VoPpSjlRx3+t
 4j4Y+GmBoqMxir/MS3UzvBv67guuAKeHMuTBEM1JFJhAAd8F24+MIEf7I9Cuw0vCEmkB
 eHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721133951; x=1721738751;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rOuxCoACSPq1GnfkCfn7NwbtjJPC2BPJg/qz9qiakzk=;
 b=YHUaSkUNlAMpUaF2WvN+KJodPtKWPRuUMSOePVWaDjQUVUVRtKh2AeQFpf9379oSDQ
 FMfR1iusQhbLhqEZZ7GIX7PiDh54tvXyWnmhKD0Wzs2D4HGYlzAGUNXMGIgcd6YUGsjH
 aigmMDNxWYCDq3It3MDnM2HdLX7xS49iUYizEmaHd6RSQNwpLMhf7/Ik2vm+ACyLBiwD
 zMe+wujCbC8rsjByWrf5/ntWpjZoZ/w2ZW7YUHJfZoBo3CZZymsNXNH3IynxR0HkaLg7
 ZBf3ZyXzQIHO4cEF0r7iWrg/Qy3n0awynlXpU0BTp2MoZR8fiOso0FB+7EfaRNHMcm9b
 tZGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJktcu7rh7XNhHZh1+z+zr6KazYHsldBxR0t4LVY5JeSmMP6a2djkjC3Xjec8oCO2my2U67On978wLAZeSVYGtInBR58Q=
X-Gm-Message-State: AOJu0YzEIH0oGtYieLZWznEuoX+NUV9lv/PQck261X9SwjgWTv7vjpSR
 fte4ktIvQ/5aHe55E7Jx+w0GLoXXf25GttSZg0FI9T5u32NEGkHWM2pb7jQSi+o=
X-Google-Smtp-Source: AGHT+IECKw7wFrpgo0Q1tZO8NywNi3az5CXkY7ssFafMP8uZXc9nn/xviLtn1qzYNgqnWYL6t5Cc8Q==
X-Received: by 2002:a05:6a00:2eaa:b0:70a:f576:beef with SMTP id
 d2e1a72fcca58-70c1fb3c3e0mr2752390b3a.5.1721133951477; 
 Tue, 16 Jul 2024 05:45:51 -0700 (PDT)
Received: from [157.82.202.230] ([157.82.202.230])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7eb9e232sm6180370b3a.34.2024.07.16.05.45.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 05:45:51 -0700 (PDT)
Message-ID: <3a74c242-2510-4ae0-8ac7-02b6cf7dde69@daynix.com>
Date: Tue, 16 Jul 2024 21:45:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] util: Introduce qemu_get_runtime_dir()
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Fam Zheng <fam@euphon.net>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Yan Vugenfirer <yan@daynix.com>
References: <20240716-run-v4-0-5f7a29631168@daynix.com>
 <bca5bd94-d6af-450b-a023-0bbe57fdba3f@tls.msk.ru>
 <ZpZDseDnUD39cBzE@redhat.com>
 <CABgObfasdAS443K6+2hHE1chWXei_1ytyRTOi7tX+ma8hZEC6A@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CABgObfasdAS443K6+2hHE1chWXei_1ytyRTOi7tX+ma8hZEC6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::432;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On 2024/07/16 19:43, Paolo Bonzini wrote:
> On Tue, Jul 16, 2024 at 11:56 AM Daniel P. Berrangé <berrange@redhat.com> wrote:
>>
>> On Tue, Jul 16, 2024 at 11:06:57AM +0300, Michael Tokarev wrote:
>>> 16.07.2024 10:27, Akihiko Odaki wrote:
>>>> qemu_get_runtime_dir() returns a dynamically allocated directory path
>>>> that is appropriate for storing runtime files. It corresponds to "run"
>>>> directory in Unix.
>>>
>>> Since runtime dir is always used with a filename within, how about
>>>
>>>    char *qemu_get_runtime_path(const char *filename)
>>>
>>> which return RUNTIME_DIR/filename instead of just RUNTIME_DIR ?
>>
>> Yeah, I agree, every single caller of the function goes on to call
>> g_build_filename with the result. The helper should just be building
>> the filename itself.
> 
> That would mean using variable arguments and g_build_filename_valist().

We can't prepend an element to va_list. The best thing I came up with is 
a macro as follows:

#define get_runtime_path(first_element, ...) ({ \
   g_autofree char *_s = qemu_get_runtime_dir(); \
   g_build_filename(_s, first_element, ...); \
})

But it makes me wonder if we need such a macro.

Regards,
Akihiko Odaki

