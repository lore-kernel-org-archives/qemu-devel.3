Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF85FC88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 08:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6ki7-0007g1-HI; Wed, 16 Sep 2026 04:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1x6ki6-0007f8-E1
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 04:09:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1x6ki4-0007eK-08
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 04:09:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789546179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NTQL1PPnK7/mrx07cfrdOxNBbFbgD2p1z39vwD7wMko=;
 b=A0REyork+xEgPTldy1f3yK3bO2GcAI6SltH4cHWS4qUMHScmCgiPLwg2fOCgxi+NOJtURM
 Jsy6o4yuqBS2TaDUsxeM026StJtIZkF+YnQOix8eDf6H72CyXsHv2hXRmxT4OkZh8CkUXK
 7zefOB0RQH53ae1RziXLl1pWMwUb2Ro=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-1GuFjTO8PTqEGauSYcz6BA-1; Wed, 16 Sep 2026 04:09:38 -0400
X-MC-Unique: 1GuFjTO8PTqEGauSYcz6BA-1
X-Mimecast-MFC-AGG-ID: 1GuFjTO8PTqEGauSYcz6BA_1789546177
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-6a9b7c7f405so5541225a12.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 01:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789546177; x=1790150977; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NTQL1PPnK7/mrx07cfrdOxNBbFbgD2p1z39vwD7wMko=;
 b=J4PWvvzBxUPWN+2qVbtCJ5hWVxzPKy81I/JEV/U94TY1FKfF8sjvecEcO2wtFhE9lF
 6oeY9yv60fbjDcJ1rNnPDrT4mO9XTzxZ4pY/zHzZOuyCKkg8Hw2r/0pN8lPsQJFDN/4b
 Po2H0MJMqaQsR7aNHWqZjTJUwN2hsJaTNIYQTvyB9LD9/c3fth2R7D/LhEB9SCL1rwtS
 dqVwuIHTh6GaWtm0cskfyQa3vjnYv9O17zusWuo/iS1h6wOgUgDtVSDtv0ZwN5/gGRl+
 R9SxvKcLe8kjbGfrw0LqpLVwxbSBGW0zRDGJE3uQRilU4z/iug3frcBIHeGNC5x/T1kG
 vAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789546177; x=1790150977;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NTQL1PPnK7/mrx07cfrdOxNBbFbgD2p1z39vwD7wMko=;
 b=TKSJ4zBfgoNvFpztx65MfMZOakFy+2qrU2n/vBhG2drJYaYL4FFF/mchGiyjCmxPPn
 cB2SifMJLbGWe+LCusGHJ38sM6qO6McEbMOMoSG3IEiwNn4Nf7Ma28d4b70gLFs3XBaI
 bGfP0Oq0+zmON0QCZ0l3xs6QpRJ9OtoXOLp2fQXL8HjDl4TRDY+EE3tWhj92ZPCInzGW
 GyWeGkfvJvoRB2grKnysBOGufoKVBwU2vQ3ClhdibcM2lgQ2Gr/S6afIK8E61L/KB7bp
 XZiQWyGmxpFs3Sr6B9wxob9Mf/nBx03/9EbgqqExt8cOvpGdZplL/hZSA/QWd5vSdG+/
 xN2Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByCnT4IWk5pr43jISTPDkakZJe0hTT6CxT290Z0e9XZGcuLU/TS5PvQUYx5jvB1dQ+4iJhtUBmQbxOH@nongnu.org
X-Gm-Message-State: AFuF++nWq497MZMfuFXq7vHVbiwqE3g1JP+riY6etH1vw77iD/XlgCXO
 NRnoakyHfmcCunA0CYo0FKVONwjyhfWZGrZvBO+vXqUTK0UHhqrEam3KmQHJxzJ+XzOOjrQpk3t
 UEumvFIG9AHyGx7bsPcDBjefuHX3bl2xNm6SPD9P2cven6sYoJVHto4LA
X-Gm-Gg: AYBFou31l4DY6VNCnWRhRMFCeVyztLdqTTYsH0LunMHX6KqdPspSggX4ylbxy8fAi87
 39ItvYrSqJPc6WZtF4j0rLDyB0IbwhY6b+CW/Op52kj/9Kqm2QQzjAXeXDHo9vJvnR/SJBovcsc
 eh6mJPfKj5/2lLyizK+yxB+ZkoZWfZk9Pqf7e5rK2Zgm12Bp/qjMtexz0lTDON62VlFEqRYmtJb
 9gykVyOA0e4Q7C7V3Q3GRhBLIf4zngSmijbkQS5y2NXLdidVN2xp38URv9DoMQRsmOwj89wvx/L
 aoPJQJsfnpzTJVUEWss7TezYH/sORq26WOHA4INOM7Q9iG2puwG/RCCxDF19d5dreU9YWQvZTCX
 yYlKKPLGJWA3W8VdEQTxDIcmqKJujo+fGeEcCk2I4pCEj2d18qI2yK853+n3S0rf3GBW54w9EpH
 GXS9FTPBjgunZ1FNzBZ9uc34xhyAk=
X-Received: by 2002:a05:6402:3215:b0:6a9:ab6a:63ff with SMTP id
 4fb4d7f45d1cf-6aa224583eemr1035543a12.30.1789546176846; 
 Wed, 16 Sep 2026 01:09:36 -0700 (PDT)
X-Received: by 2002:a05:6402:3215:b0:6a9:ab6a:63ff with SMTP id
 4fb4d7f45d1cf-6aa224583eemr1035525a12.30.1789546176493; 
 Wed, 16 Sep 2026 01:09:36 -0700 (PDT)
Received: from ?IPV6:2003:cf:d704:f6c1:9398:5dbc:cc8:753b?
 (p200300cfd704f6c193985dbc0cc8753b.dip0.t-ipconnect.de.
 [2003:cf:d704:f6c1:9398:5dbc:cc8:753b])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aa1cfe07e4sm1104706a12.2.2026.09.16.01.09.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 01:09:35 -0700 (PDT)
Message-ID: <9593b279-4e60-47fc-93a1-f8b2f132d380@redhat.com>
Date: Wed, 16 Sep 2026 10:09:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] qapi/block: Add IoAccountingOperation enum
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20260831135206.126184-1-hreitz@redhat.com>
 <20260831135206.126184-3-hreitz@redhat.com> <87fqzqpfrd.fsf@pond.sub.org>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <87fqzqpfrd.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 03.09.26 16:32, Markus Armbruster wrote:
> Hanna Czenczek <hreitz@redhat.com> writes:
>
>> This enum gives more information than IoOperationType (which is used for
>> the rerror/werror distinction) to identify operation types for block
>> accounting.
>>
>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>> ---
>>   qapi/block.json | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/qapi/block.json b/qapi/block.json
>> index 46955bbb3e3..456118eb0b4 100644
>> --- a/qapi/block.json
>> +++ b/qapi/block.json
>> @@ -603,3 +603,25 @@
>>              '*boundaries-zap': ['uint64'],
>>              '*boundaries-flush': ['uint64'] },
>>     'allow-preconfig': true }
>> +
>> +##
>> +# @IoAccountingOperation:
>> +#
>> +# A more finely grained enumeration of I/O operation types beyond what
>> +# `IoOperationType` provides (whose read/write distinction matches the
>> +# rerror/werror policy settings).
> Why is the comparison to IoOperationType useful?

Because the `IoOperationType` exists, and in my mind, it would be better 
to have a single enum for all types.

Now, to reason why a new one is introduced, the commit message here 
would be sufficient. But I felt it better to document for users also why 
there are two types.

> If making the connection between IoOperationType values and
> "rerror/werror policy setting" is useful, why isn't it made in
> IoOperationType's docs?

That is true! I should move it there.

> What settings exactly?  Could this be a link?

Probably. I will take the look.

(The block device’s rerror/werror settings.)

Hanna

>> +#
>> +# @read: Reading data
>> +#
>> +# @write: Writing data
>> +#
>> +# @flush: Flushing data to disk
>> +#
>> +# @zone-append: Appending data to a zone of a zoned block device
>> +#
>> +# @unmap: Discarding a block of data
>> +#
>> +# Since: 11.2
>> +##
>> +{ 'enum': 'IoAccountingOperation',
>> +  'data': [ 'read', 'write', 'flush', 'zone-append', 'unmap' ] }


