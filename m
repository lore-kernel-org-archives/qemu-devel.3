Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AFA4C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 09:40:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnDsl-0003cq-OO; Wed, 26 Feb 2025 04:39:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tnDsk-0003cQ-0B
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:39:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tnDsf-0005Qc-3J
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:39:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740562742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rva37QykQj/1e4+nIISXKfs3TJ/hx0U1Ma7c4AeVUCQ=;
 b=Gs+OBpf59Jv0NrGZpnVR31anY5ybqYojy5d/Z8DX95j1oqH9CysaGo4g6/FkcUuf8cnFXz
 mKh+2/HDJTSP1MvymrJyttvSgg8kaDtaAzE9KTmid6Pp+JplTUCXXHQeh9bp1Kg1u/HkEi
 VutMO5AiZ97mRbHY0rebh760SFYrPUI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-5zjq557jMbmFiJF5vwiqvQ-1; Wed, 26 Feb 2025 04:39:00 -0500
X-MC-Unique: 5zjq557jMbmFiJF5vwiqvQ-1
X-Mimecast-MFC-AGG-ID: 5zjq557jMbmFiJF5vwiqvQ_1740562739
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43943bd1409so44715445e9.3
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 01:39:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740562739; x=1741167539;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rva37QykQj/1e4+nIISXKfs3TJ/hx0U1Ma7c4AeVUCQ=;
 b=Ho8UAP6UGs279iYNYNkxoFLfJ0VpeOd6AfnJRO/dgqXyeJiZPmHmHH1ud+/TrUHn0B
 YzA3tlMu4tHTagGRHlaKHoHt3YLgJnPAa8mucxdW+D7DBh645EXrUBsEENv2dFvrpwt9
 yPi8pWjqj5CBd/jJtQa3XpNTGvWJZB9Jap/85PMrbs7/AB1ty1Vbkjb7sctN1fWR3LLb
 anrRg8ggIdhJnpIVJAr2Ba5ub+2OZCt8v0/DoAoUfK8HOpBBWzg2/reyvpbeXV2fk3iN
 1IOUfBdiNVf/ebbHCoDYM5CsHQRt2q6e27O8A/zkeZfAtM+EBVp0pjKhLcf4DS6ksS/z
 sI4Q==
X-Gm-Message-State: AOJu0YxCNpGUj2s0qWf/zAg39JjMqQMyn9VPt50+w6+146ERmIyU2zbN
 yyb0pn05nQcFXKdkB//bVywGLzzOiNUUGnR1NnHOgRSYu4rBF56opBzy2BNYoeWf4oQQAvgHOON
 rMD5vmDrwrcplzEGzxmq1ExK48eL+obDuVA+ixNcMXs1q024IjMuK
X-Gm-Gg: ASbGncvGRzSoMiaN7YWYxT3wDfL3m46vE5WWQxuO7txlS0keI1l2PxxI7qd0Nt0JRXN
 DTLDQ8rtaJvLnIYXdrtqRihAjUWv+ua1TfnAUcsWg5kTg+jig8qxyNxACVli0/KTU4DfOnQ17Dc
 yo0yQVjs0Z6sf6xr/LFdLPnlGIsGJU1RaJn0BHVs3sJae32CO/eWluzAIgVUPQR7FA3ajMNFdDy
 siY7VaGgm0E8pYzs4yGy6b/4kospGJVuckfnyWfCMRIcg1E8vbCZqjLNC4UhAA2wk5t9QwwCqYy
 QRKU76Ob8HHwlHKsPVmHelmrbRsj8wsIjgFCeM58ICN1Wlc=
X-Received: by 2002:a05:600c:4f0d:b0:439:6118:c188 with SMTP id
 5b1f17b1804b1-43ab90155acmr20209485e9.19.1740562739489; 
 Wed, 26 Feb 2025 01:38:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfiuaZGta1ZcbCS98tHlRBMi2JVN4TX/c7UaAzVL32eV6ZuAAzX4PHeRSAS9Pm67VsxAub+A==
X-Received: by 2002:a05:600c:4f0d:b0:439:6118:c188 with SMTP id
 5b1f17b1804b1-43ab90155acmr20209265e9.19.1740562739126; 
 Wed, 26 Feb 2025 01:38:59 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-49-245.web.vodafone.de.
 [109.42.49.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba53945bsm15028185e9.23.2025.02.26.01.38.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 01:38:58 -0800 (PST)
Message-ID: <2a7c4f21-ee27-4407-8191-dd1f0547990c@redhat.com>
Date: Wed, 26 Feb 2025 10:38:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] trace/simple: Fix hang when using simpletrace with fork()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>
References: <20250226085015.1143991-1-thuth@redhat.com>
 <Z77bqqKiV7etJNCf@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <Z77bqqKiV7etJNCf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 26/02/2025 10.15, Daniel P. Berrangé wrote:
> On Wed, Feb 26, 2025 at 09:50:15AM +0100, Thomas Huth wrote:
>> When compiling QEMU with --enable-trace-backends=simple , the
>> iotest 233 is currently hanging. This happens because qemu-nbd
>> calls trace_init_backends() first - which causes simpletrace to
>> install its writer thread and the atexit() handler - before
>> calling fork(). But the simpletrace writer thread is then only
>> available in the parent process, not in the child process anymore.
>> Thus when the child process exits, its atexit handler waits forever
>> on the trace_empty_cond condition to be set by the non-existing
>> writer thread, so the process never finishes.
>>
>> Fix it by installing a pthread_atfork() handler, too, which
>> makes sure that the trace_writeout_enabled variable gets set
>> to false again in the child process, so we can use it in the
>> atexit() handler to check whether we still need to wait on the
>> writer thread or not.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   trace/simple.c | 17 ++++++++++++++++-
>>   1 file changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/trace/simple.c b/trace/simple.c
>> index c0aba00cb7f..269bbda69f1 100644
>> --- a/trace/simple.c
>> +++ b/trace/simple.c
>> @@ -380,8 +380,22 @@ void st_print_trace_file_status(void)
>>   
>>   void st_flush_trace_buffer(void)
>>   {
>> -    flush_trace_file(true);
>> +    flush_trace_file(trace_writeout_enabled);
>> +}
>> +
>> +#ifndef _WIN32
>> +static void trace_thread_atfork(void)
>> +{
>> +    /*
>> +     * If we fork, the writer thread does not exist in the child, so
>> +     * make sure to allow st_flush_trace_buffer() to clean up correctly.
>> +     */
>> +    g_mutex_lock(&trace_lock);
>> +    trace_writeout_enabled = false;
>> +    g_cond_signal(&trace_empty_cond);
>> +    g_mutex_unlock(&trace_lock);
>>   }
>> +#endif
> 
> This doesn't seem right to me. This is being run in the child and while
> it may avoid the hang when the child exits, surely it still leaves tracing
> non-functional in the child as we're lacking the thread to write out the
> trace data.

Well, you cannot write to the same file from the parent and child at the 
same time, so one of both needs to be shut up AFAIU. And the simpletrace 
code cannot now which one of the two processes should be allowed to continue 
with the logging, so we either have to disable tracing in one of the two 
processes, or think of something completely different, e.g. using 
pthread_atfork(abort, NULL, NULL) to make people aware that they are not 
allowed to start tracing before calling fork()...? But in that case we still 
need a qemu-nbd expert to fix qemu-nbd, so that it does not initialize the 
trace backend before calling fork().

  Thomas


