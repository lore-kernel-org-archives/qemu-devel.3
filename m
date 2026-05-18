Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7146CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 11:51:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOwUP-0005Rl-9F; Mon, 18 May 2026 07:50:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wOwUB-0005KQ-Lk
 for qemu-devel@nongnu.org; Mon, 18 May 2026 07:50:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wOwU9-0004ez-B5
 for qemu-devel@nongnu.org; Mon, 18 May 2026 07:50:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779105011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pvDz+X0QThwR1RslfKySrYiOCS+bPvk6aaPgj/qGYBA=;
 b=LPjv1jEfr4KJPcrWLZNkvCk1V6tuQcp9alE1/BhJntwpHLxdNRiv+mtDk5fkXLyUeqyAPS
 4VxeBrrnwbgDA0/r3rAcs9HZmeyWBEpCixptKg0B2h/vNkNSKumzwONSukg2dVOU/h6f2X
 ME5/gSDtVaN9hzweH7FfM46frHx3ZqA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-SHweL3uVNTqMtxgSewMX3A-1; Mon, 18 May 2026 07:50:10 -0400
X-MC-Unique: SHweL3uVNTqMtxgSewMX3A-1
X-Mimecast-MFC-AGG-ID: SHweL3uVNTqMtxgSewMX3A_1779105009
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-44dad1b938fso1314673f8f.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 04:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779105009; x=1779709809; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=pvDz+X0QThwR1RslfKySrYiOCS+bPvk6aaPgj/qGYBA=;
 b=eBNz9/r1cdPvc7JLKt4kaFblZf01jDHtHuSPI0wKBjTnWUYtoKwlCePPtRMDaMTwzY
 NDmZ6YjGP2dtpNKcrNng4t7uDLCA4G0rKXZim85vbwBWuXvnT8UgFj31L9M/Q//2gbis
 m5/Yf3F4ikLnWvs4QEPrcXsYUEPW/qkAihxQZnm2fJENeo6f+6LI5jWFisSGXRhobvCl
 SVWkK1b/81T7qBnv/odYoRipKtCwIXMDaUo7/5B2QZWBRwCCCecP0k3Zd0/nidRlkv+w
 N6h6qRJmsbjV40fc4szpycwd7BmwRIaeULbG0uS0D5QhbOe2SC8TzzVfPWlMxY20xYli
 vgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779105009; x=1779709809;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pvDz+X0QThwR1RslfKySrYiOCS+bPvk6aaPgj/qGYBA=;
 b=LXxTHluXvJm56Ho0C7e2uMj+YxEQC7zg6RKDPjrIq6rDuaKvCeuEN6HIc9cdT7LROC
 IOwhg5VyTrhnVHPOitkq8IlwhxvpxUxfGtUC6bBoTT1biMWhTkeRN0kUolF4HzpVnH4A
 xhy1rgB5rWCTNCP0xyxrNS4ouKfBdxMwwE/f6Eh/LqGc5jdc4fr/G1t0P3L60NlB406N
 rPhEJ9eUSufRy7G/FRvUNPdrydy3UN+CSnkUZQXNfU+4jFST9xj/u9uNYnC2gOukmhbu
 7ZMnubxZT5oOoHfmRpqkFwTn+CrSyXODQZlOCj1R0j60a5XU5ZdJ/6rya1X0NNRCknRO
 k3sg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/gwMFHv0QVbDOPvaMWIN8PVKYgJ6M8UC3jWjvSp/VCwShkXz/yemvrnonybHoBuKfOMPvvPoDxfsaf@nongnu.org
X-Gm-Message-State: AOJu0YxB5xmbRw7u++6EZm5nUnKEfeKbGzzkMkSt6NBwf4QWAs6XTnuI
 kL7vAJOL4EVYL/EXTsI2mtu+f93M2mX6RckCNx1l7jIhlKscOwrSHkOkbALS4HB5eNACJPpik/y
 zRJ37LKrncUY8GU1VqyGg84thh182V/0GXd+/OxHRc4Rbf1mAVpahNgZr
X-Gm-Gg: Acq92OGE5FpPYWWsTaOfCyjk2kukErhHIBA6kb2AQfXtS/w7S+hPW54scb5VrAO4Nwg
 BapIPgRuU95YWFz/xWxMeZbvdbwakcl/9NPLZCFQdm5EQF/1kG6EMfeS0m0KZR/NX1P/xXOnpbM
 3jPbPVjgRn0373ntnZSbdNDwVcpQF+f5yQf+A6yYXpBeOZ900iwlB8MO04VsAdnpk0zB1W27RZs
 kBC2870q1+QAUWzK+pY/Vaxo0kkNjRgefyObBEmA6SE5qErb7qYHsPcM/BHzUu69G0RM5Oh9GZg
 0oL6scRpOFY//I7IH4bHfcA0HrP4VSPy5K3fCjy0ryvN/XRBRx8q+lqoj5r7LK0PC0xkA315KZD
 jTRGFK5yBHMF5ZQpOYQ==
X-Received: by 2002:a05:6000:4007:b0:43d:1cec:4766 with SMTP id
 ffacd0b85a97d-45e5c5bf971mr23484809f8f.23.1779105008831; 
 Mon, 18 May 2026 04:50:08 -0700 (PDT)
X-Received: by 2002:a05:6000:4007:b0:43d:1cec:4766 with SMTP id
 ffacd0b85a97d-45e5c5bf971mr23484743f8f.23.1779105008406; 
 Mon, 18 May 2026 04:50:08 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.83]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a19c2dsm37931443f8f.21.2026.05.18.04.50.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 04:50:08 -0700 (PDT)
Message-ID: <b6cc3aa4-6c32-4ebf-90f9-efb7f2a9b897@redhat.com>
Date: Mon, 18 May 2026 13:50:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/vl: Free allocate memory for pid file name in case
 realpath() failed
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: f.ebner@proxmox.com, qemu-trivial@nongnu.org,
 Qemu-block <qemu-block@nongnu.org>
References: <20260515143854.2010741-1-thuth@redhat.com>
 <1aec7543-ea5a-482c-a42e-fb1cdb0e7498@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <1aec7543-ea5a-482c-a42e-fb1cdb0e7498@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 16/05/2026 12.13, Philippe Mathieu-Daudé wrote:
> On 15/5/26 16:38, Thomas Huth wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> In case realpath() fails, the code returns early in the function
>> qemu_maybe_daemonize(), without freeing the allocated memory. Add
>> a g_free() here to fix it.
>>
>> Fixes: dee2a4d4d2f ("vl: defuse PID file path resolve error")
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   system/vl.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/system/vl.c b/system/vl.c
>> index d2f4044e5d8..7e2ed898240 100644
>> --- a/system/vl.c
>> +++ b/system/vl.c
>> @@ -2670,6 +2670,7 @@ static void qemu_maybe_daemonize(const char *pid_file)
>>                   warn_report("not removing PID file on exit: cannot 
>> resolve PID "
>>                               "file path: %s: %s", pid_file, 
>> strerror(errno));
>>               }
>> +            g_free(pid_file_realpath);
>>               return;
>>           }
> 
> Don't we also need to release the other paths?
> 
>   - qemu_unlink_pidfile()
>   - pid_file_init()
>   - pid_file_cleanup()

Adding it to qemu_unlink_pidfile() makes sense here (though QEMU is 
terminating anyway afterwards, some malloc sanitizers might complain 
otherwise), so I sent a v2 for this.

pid_file_init() and pid_file_cleanup() is in the storage daemon, so this is 
a separate problem (the variable just has the same name there). Not sure 
whether it's worth the effort to free the memory there, too, since the code 
exits afterwards anyway, and the pointer is kept 'til the end?

  Thomas



