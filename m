Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E4EC369A0
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 06:59:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stLyi-0006UB-58; Wed, 25 Sep 2024 02:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1stLyf-0006R1-M1
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 02:58:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1stLyd-0002St-Oj
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 02:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727247496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PMSWyGmf708gldTm//TXLVCMZF1hGvS4H9fLyJ7daFY=;
 b=eAUoJzLb4rVfmy/KYlkjjsNAy8xU1TwzsTJxDjaa48apCONuNlpP4MqrdpgLqZyPBRGtmx
 ZXwNmpy2NA7iRWfXPu9LnI2qursIwv0tLESNgwssSMTelleKZljrl9BSC1Cfej0GJjwQzh
 VFEEkoNukNsR9JFB6Ssxn30VZvWQyO8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-nwZXf5yoMxSwtP08L0pLhw-1; Wed, 25 Sep 2024 02:58:14 -0400
X-MC-Unique: nwZXf5yoMxSwtP08L0pLhw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42cb6ed7f9dso58711335e9.3
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 23:58:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727247493; x=1727852293;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PMSWyGmf708gldTm//TXLVCMZF1hGvS4H9fLyJ7daFY=;
 b=v6ck/EkXcPZl3fbOv05imF4RQ9UY+bemck10WSw+11A7fX/cPHK+mgslVW5O6jpHbb
 MApvdF+28zTshtjhOQbHkC9WgechbY98FwTv9Mj3vopEBNfb8fYZ9C5AiGrNLl6D+lSy
 CGQBPXc+Vu/ZUAIMSg9RaFF2iJWT1JSMLRDm5hwgCKa6OnauwMuZn6pRS35bfKcvMtMw
 pr/pgUvDKcliO860rDwohROPFgEf+yC0k36ZMqq6vC/O2DY7ff4DQXn7QJUNTmYV58+I
 8VdtYP7UTZrsFa9mpMnD/knC5lEN9BUXZE16AotcZuGUrCfDp4VhBkY/cr001nMHqZs4
 F1xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTJ9Ny3hKR9Lq2VdRhPiz+nqcKkNzJoEHB6j12mDG4AWcHiqMAWigKDsaCAMMJuiHzhP2v72VLvMAv@nongnu.org
X-Gm-Message-State: AOJu0Yx/k6tT37sZcP82lP/ZcEcku5dwQ125+TNFg9R1swGCsXFiQK5z
 OuHHEVoceXhy8RN18NAvoEWJDbiA+zXOeIZvvnjS9vUP+XuVToLOxsUTJlzgWHmZ6kTAAIWH6o/
 ++M0P23R3X1/uI+5IVXZJK70HXLSAXYQL7cS+CoLuCImL8r74c9PH
X-Received: by 2002:adf:f88c:0:b0:374:d07a:c136 with SMTP id
 ffacd0b85a97d-37cc24b2603mr1322331f8f.36.1727247493252; 
 Tue, 24 Sep 2024 23:58:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHB2Y2SfVXv6tAow7qONC0d6dm6/N5wVp3mmMBinfT+6jdk5xxV5MMX5YAivQWrApcJD4xESQ==
X-Received: by 2002:adf:f88c:0:b0:374:d07a:c136 with SMTP id
 ffacd0b85a97d-37cc24b2603mr1322322f8f.36.1727247492790; 
 Tue, 24 Sep 2024 23:58:12 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-48-176.web.vodafone.de.
 [109.42.48.176]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9392f4faebsm176923166b.52.2024.09.24.23.58.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Sep 2024 23:58:12 -0700 (PDT)
Message-ID: <819af4c1-c6c7-4358-aa3c-91c0d40c6d93@redhat.com>
Date: Wed, 25 Sep 2024 08:58:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: Mark "gluster" support in QEMU as deprecated
To: Peter Krempa <pkrempa@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, devel@lists.libvirt.org,
 integration@gluster.org
References: <20240924132451.47121-1-thuth@redhat.com>
 <ZvLIw9P1lsMz7Cff@angien.pipo.sk>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <ZvLIw9P1lsMz7Cff@angien.pipo.sk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.09,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 24/09/2024 16.12, Peter Krempa wrote:
> On Tue, Sep 24, 2024 at 15:24:51 +0200, Thomas Huth wrote:
>> According to https://marc.info/?l=fedora-devel-list&m=171934833215726
>> the GlusterFS development effectively ended. Thus mark it as deprecated
>> in QEMU, so we can remove it in a future release if the project does
>> not gain momentum again.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   docs/about/deprecated.rst | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>> index ed31d4b0b2..b231aa3948 100644
>> --- a/docs/about/deprecated.rst
>> +++ b/docs/about/deprecated.rst
>> @@ -395,6 +395,15 @@ Specifying the iSCSI password in plain text on the command line using the
>>   used instead, to refer to a ``--object secret...`` instance that provides
>>   a password via a file, or encrypted.
>>   
>> +``gluster`` backend (since 9.2)
>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +According to https://marc.info/?l=fedora-devel-list&m=171934833215726
>> +the GlusterFS development effectively ended. Unless the development
>> +gains momentum again, the QEMU project might remove the gluster backend
>> +in a future release.
> 
> Shouldn't also the 'gluster' enum entry of 'BlockdevDriver'
> (qapi/block-core.json) be marked as deprecated?

Thanks, that's a good idea! I'll send a v2...

  Thomas


