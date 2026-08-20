Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D790C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 06:22:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwwAf-0005DF-5Y; Thu, 20 Aug 2026 02:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isyanfei.xu@gmail.com>)
 id 1wwwAc-0005B9-Ea
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 02:22:34 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <isyanfei.xu@gmail.com>)
 id 1wwwAa-0004Pm-Gz
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 02:22:33 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2cee9b74ee1so13077425ad.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 23:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787206950; x=1787811750; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hIqEKYgZG4bwiPpJJkIuLCzf1mrHR04oL37uB/d3iMg=;
 b=m2TQL+PAhNPqgVomLqR4FlPBgU92xbMPHxrmUpId//rrzUdgoVBTQutBAraQivxqSj
 6HQ3+TnK+UDW+h/Mb35p7yRPr64rpUQx9LWzQh/TwRoPvlGex1Vg1h64BbkgQWPjdidr
 MhPoWuNPljjHkdqM0Uo1jASiBRflZHp16LZfzOyVyEv0IyNSRVsaDpkFshlLtucJCXvM
 MCHq/2CwmRRo9f8DAvU5Wmn+e8/iygkuOwXEWgCIEhpqTtZCtrISeTHwGXIe5eHm55gf
 YNetCCr7Yzpz19Dhhl/UQ0b0n3hv8GmAjoU//J3zswndhyutM7ChBHOab0J0jr7QQWxt
 FGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787206950; x=1787811750;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hIqEKYgZG4bwiPpJJkIuLCzf1mrHR04oL37uB/d3iMg=;
 b=psdVaVdQEmPMiUIvA4VtyVwfh1yqMbirqsplH+P6WBhYX+5Cpd/J8zReRIynCyfRhB
 sghHPs+2NpUU3bLnCuPRZt/ZizQ16Ach9FY3oFhpAd9R31dXdj5FmmkASHLoUyBy+paY
 2DN+/WtoukrlI9o7nw0PgEcLKnPK9LGsdza6TFn8wjRYSvoSpmIXBx4lON9mbdTMFfk/
 CwRUmsKqm4hBhhlTA2rX+iZXn+ZoYo56B5jxLzW7nX/V1bJO9UQdsHzvocHnnNtGALh9
 wxVIFp7TZN/rOavVI94T9wPYln/UROHwxkJ7cEyrblEyJYNoSK6Mfk/0iHIs0hOq4kbK
 9DxA==
X-Gm-Message-State: AFuF++lk5T0uoaIsWXp3y4XQlTMyzKpfZsAHYrQWucmWI/JNhH+FmB9K
 wyz9ppx68K6EPKGmymIG4vsH2BLlOZ/SAicBy+a79HlZ4FF9FRfVcJ+w
X-Gm-Gg: AR+sD11tl0J6eXivA7dxFEERt7OOM4GZYrFkYuQHIkqTFMzwuuH+hGxuacbgZAIXQDB
 n/mXtdlH1ur1Zbzyc/fyyg5pfu+gWt6Sa3O9JTZv85kwUECGvZMv+nGqD33ZHOboS4028xnqSHk
 ky7xYSiUoa+L+oJg00Y3bx0dcaQXNVQ2JhQy0cgWOAaTerVnPFncsmkFvGYpMSDgNCQl/2fPcRh
 STzde9lTXDj2L8RpaBfM1cqfqid9/9VlUzzyGH7cUuD3x8Cm57jRKvHUMHSeGY7xwVf6EIXCJWm
 9Z9RtiYoBd/0CnKQPEPqvPHJGNL1Xf3gcD2V1FOMcBpWEkES8eQsuJm6B5KjTCTuT9aI+dbvpA8
 oR/sXdF5PB4G3OjROO/ZauxT+3cumFjmsslpyazrqV2/RVGA+LYKlPIQEDaAGdPHlU72InQuGNM
 0jhMla+Jol+7XHMpK7O/SrASTZClY+nLkhjcUSfoqN4y47Ssh6NyquXtyIa4Xo3eOD7CTQxJrM9
 Q==
X-Received: by 2002:a17:90b:1a8f:b0:38f:5801:dc0e with SMTP id
 98e67ed59e1d1-3958125a864mr18860351a91.15.1787206950430; 
 Wed, 19 Aug 2026 23:22:30 -0700 (PDT)
Received: from [10.3.188.167] ([61.213.176.5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395ada1deabsm425914a91.2.2026.08.19.23.22.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 23:22:29 -0700 (PDT)
Message-ID: <1313593f-9468-4779-b74e-addcdd012e8b@gmail.com>
Date: Thu, 20 Aug 2026 14:22:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] migration/rdma: Post initial receive before accepting
To: Peter Xu <peterx@redhat.com>, Yanfei Xu <yanfei.xu@bytedance.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, lizhijian@fujitsu.com,
 Jinpu Wang <jinpu.wang@cloud.ionos.com>
References: <20260817105117.3072040-1-yanfei.xu@bytedance.com>
 <20260817105117.3072040-3-yanfei.xu@bytedance.com>
 <aoYBIaisgpP6lklk@x1.local>
From: Yanfei Xu <isyanfei.xu@gmail.com>
In-Reply-To: <aoYBIaisgpP6lklk@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=isyanfei.xu@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


On 2026/8/20 03:16, Peter Xu wrote:
> On Mon, Aug 17, 2026 at 06:51:16PM +0800, Yanfei Xu wrote:
>> The source return-path thread can send READY before the destination has
>> posted its initial receive.  Since RNR retries default to zero, the send
>> can fail and abort migration.
>>
>> Post the initial receive before rdma_accept() to close this window.
>>
>> Fixes: 55cc1b5937a8 ("migration: create a dedicated connection for rdma return path")
>> Signed-off-by: Yanfei Xu<yanfei.xu@bytedance.com>
> This one looks correct to me,
>
> Reviewed-by: Peter Xu<peterx@redhat.com>
>
> Do you have way to reproduce it, or is this theory (or can be reproduced by
> adding delays)?

Yes, adding delays can reproduce it.

For example with sleep(1) and related traces, log at source side:

2026-08-20T05:55:11.471421Z qemu_rdma_exchange_get_response_start 
CONTROL: READY receiving...
2026-08-20T05:55:11.471422Z qemu_rdma_post_send_control CONTROL: sending 
QEMU FILE..
2026-08-20T05:55:11.471447Z qemu_rdma_poll_other other completion 2000 
received left 0
2026-08-20T05:55:11.471589Z qemu_rdma_poll_recv completion 0 received 
(4000) left 0
2026-08-20T05:55:11.471592Z qemu_rdma_poll_other other completion 4000 
received left 0
2026-08-20T05:55:11.471594Z qemu_rdma_exchange_get_response_start 
CONTROL: READY receiving...
2026-08-20T05:55:11.471596Z qemu_rdma_post_send_control CONTROL: sending 
QEMU FILE..
2026-08-20T05:55:11.471617Z qemu_rdma_poll_other other completion 2000 
received left 0
2026-08-20T05:55:11.705561Z qemu_rdma_close
2026-08-20T05:55:11.705587Z qemu_rdma_close
2026-08-20T05:55:11.705626Z qemu-system-x86_64: rdma migration: send 
polling control error
2026-08-20T05:55:11.707001Z qemu-system-x86_64: warning: Early error. 
Sending error.
2026-08-20T05:55:11.707031Z qemu_rdma_post_send_control CONTROL: sending 
ERROR..
2026-08-20T05:55:11.707038Z qemu-system-x86_64: warning: rdma migration: 
send polling control error
2026-08-20T05:55:11.707301Z qemu_rdma_cleanup_disconnect
2026-08-20T05:55:11.710569Z qemu_rdma_cleanup_disconnect

Regards,
Yanfei


