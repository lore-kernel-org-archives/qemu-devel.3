Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB8BFB3CFA
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 10:20:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w79jD-0006TD-4p; Mon, 30 Mar 2026 06:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w79jA-0006Sk-Mj
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 06:20:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w79j9-000489-2F
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 06:20:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774866009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qA6TdSH6oogS1ysRXj99x3VtUPTVoVwGh3u1zNEL/8U=;
 b=Al8fpQ8SDSvRR92XBjcGyGDGcWX8B5oxzDTmfmSVyPSnvFGzGtPgkf2kenACbX75fbdqVm
 FuoYEK5lTE9M9khqFF5401HJUQuZrVOOdtyj9mPkeHVXBm12A37BYXMEORjj9dW9L6w9ZL
 W/mKeUeVRBGuO+Hau3VcAfWSABdM4ZU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-5sw9FyBAOM61K6XZXf8DDQ-1; Mon, 30 Mar 2026 06:20:08 -0400
X-MC-Unique: 5sw9FyBAOM61K6XZXf8DDQ-1
X-Mimecast-MFC-AGG-ID: 5sw9FyBAOM61K6XZXf8DDQ_1774866007
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48722073bd2so27672585e9.0
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 03:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774866007; x=1775470807; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=qA6TdSH6oogS1ysRXj99x3VtUPTVoVwGh3u1zNEL/8U=;
 b=gGIjyUYqXqyZpkcGUJ3IiN9Ak69OwdaQrxUY+k0Ex1c5ONdHrYb1A68DgNUYEbNXEP
 VrCJDkNpPiNrIOTCAepeHdyey9FqAYXSWTx12xipXR0UIAVB++hB4PA1sUUYpXgGBz+D
 hcaPRnTJgNzCWIJUu/2eC8lPOf9OG05/rmXQTN/NO4jbaUPrtNUE3CRNeVl6uiJdXhNa
 HngkuP9qb0jZXXuTh3NlWIiUu6ICBCgRC75yQFQFq7mkGF4qTQsa2YEPDTpx65X+nymM
 ePOwjcgB18eBVoDYoXbtCNrO94Cu8D+u3WBbwXuvjXIo3BOHNP1P+EutIfBw467oVkN3
 MKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774866007; x=1775470807;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qA6TdSH6oogS1ysRXj99x3VtUPTVoVwGh3u1zNEL/8U=;
 b=Y7SP05VAAphBqmUMHJlKrfT2HxuId6hRWb+zZTd/lB8QP8KV1h79t+989FTtv0z8IM
 FKYrDpXTWuXTZQnuFAbvd1dJ8BPMYShbTptFFAnKK6FkSokZoY2uTx0cAd1VT7Ryczhm
 sfM1ibnGkzTCQSMCa0G7+0Yuf3ssuzlBEEZfCZI/uvGqcKwzSCFSow0YAtBUFlySqAuv
 /k4scvEZ6q9jdm7KKJxar5qQpH18noad3m8XBTQm3Bl1wxkCxbGNECBsQPUsAtiENpjW
 YKnwd4ErSdQ9QlrCCv4+HBlqT1rwHsmqWbZN350rkfBYUDZHhiuDQ/g1ZsgQ5hF2Vnfy
 9qDg==
X-Gm-Message-State: AOJu0YwgpEYPuXRUEWmevG+8YVjuhVu+sSbr+qEvPSK6kBM0aXybxbYk
 FCJeE2hZYf2xzh9J627v5NpluuqSdGsuKHqKaroCy+0Ck7fNyi/aHrn0sWsi7lLh38iClkf8RsW
 8EuCD7zq/WF/9T/OlYTlB5HQamxaZWC2eLTflkfa5TYj2GzUKV1XwKFmAKnp596b3
X-Gm-Gg: ATEYQzwY064quTr64Zmtj+NYtG/FxOXvC9LHJQ0SYbXIPJh9lfzyXNYSeNawT/pqz78
 cEf+t5s9r3R0hnafITd0FeyDKhO1L/sjAex3JU3vvlcA2hdTNT9XMIlDToMoPvY5WanXuaeaoWS
 uj7giC1eUYjAcflD/WM2l5YHC482wX0HLgTwA5CzJf8TnJCJ2mKV6jNQ6eQIyJkatJoZw0Y/wOs
 dVI2acLhIpUPG3YffTwMuT3oTULcnc9EH2D6vrrpboMY8I+8VJ5jWkJXDWk8y3D57pH+evMzdRy
 7je1NtY0xVqkupnRV6nXIqiCjk9Q77yRUG49mduQ/YnyQ0LPgGzH5g4QcoD+pFmhPMRttE/soib
 3T5fa5U/03Zs59C5IDw==
X-Received: by 2002:a05:600c:8b66:b0:46e:59bd:f7e2 with SMTP id
 5b1f17b1804b1-48739547940mr71222985e9.11.1774866006906; 
 Mon, 30 Mar 2026 03:20:06 -0700 (PDT)
X-Received: by 2002:a05:600c:8b66:b0:46e:59bd:f7e2 with SMTP id
 5b1f17b1804b1-48739547940mr71222495e9.11.1774866006489; 
 Mon, 30 Mar 2026 03:20:06 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.85]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48725eb5417sm106975745e9.3.2026.03.30.03.20.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 03:20:04 -0700 (PDT)
Message-ID: <386cc456-fa0d-487f-989f-971864c791e1@redhat.com>
Date: Mon, 30 Mar 2026 12:20:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/migration.py: Skip migration_with_exec()
 if socat is not available
To: Zhao Liu <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
References: <20260330053300.2721608-1-zhao1.liu@intel.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260330053300.2721608-1-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 30/03/2026 07.33, Zhao Liu wrote:
> Commit 643a171f5668 ("tests: Replace ncat with socat in migration test
> and drop ncat from containers") replaced ncat with socat, but missed to
> skip related test cases if socat is not available, which will cause test
> errors on the system without socat.
> 
> Fix this by checking socat instead of the original ncat.
> 
> Fixes: 643a171f5668 ("tests: Replace ncat with socat in migration test and drop ncat from containers")
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   tests/functional/migration.py | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/functional/migration.py b/tests/functional/migration.py
> index 2395119d6c66..144f091ba8aa 100644
> --- a/tests/functional/migration.py
> +++ b/tests/functional/migration.py
> @@ -80,8 +80,8 @@ def migration_with_unix(self):
>           self.migrate(dst_uri)
>   
>       def migration_with_exec(self):
> -        if not which('ncat'):
> -            self.skipTest('ncat is not available')
> +        if not which('socat'):
> +            self.skipTest('socat is not available')

Oops, thanks for fixing it!

Reviewed-by: Thomas Huth <thuth@redhat.com>

and queued for my next pull request.

  Thomas


