Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C3FCCF9FA
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 12:06:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEnt0-000690-Sg; Fri, 31 Oct 2025 08:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vEnsp-000672-7U
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 08:05:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vEnsf-00008e-JJ
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 08:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761912312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c8kAcWZMqEwcl6TTj0kIgxd5CMc5mfU3LAltAAPioYg=;
 b=bgznzhTyBX7Ku6/GwZ7zxIaDYQZPfHJtH0UsOuR+rxlHUbrdUJCRIrFjoh6IFcNKCgRcBQ
 rQvJMYDgHHGMz8/PfRaYFRQzS4sXdoy7EAR1YyjHsh/jkhPYKMp38ueji2hzvYVkP6UZ97
 Si9Um3pNSd8GWie/leVbjAEFzw4xJEA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-Ta_LQj7QOHKcZWQDwzTkmQ-1; Fri, 31 Oct 2025 08:05:11 -0400
X-MC-Unique: Ta_LQj7QOHKcZWQDwzTkmQ-1
X-Mimecast-MFC-AGG-ID: Ta_LQj7QOHKcZWQDwzTkmQ_1761912310
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-427015f63faso1289974f8f.0
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 05:05:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761912310; x=1762517110;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c8kAcWZMqEwcl6TTj0kIgxd5CMc5mfU3LAltAAPioYg=;
 b=R9C99ZeQNGbYADMzBjhEkq54efByKOiyhUFUqjM4VShg0xrBQd06h4RjYC6GLTAJsI
 G6wLZTH8FGGoZ6jp+4gDqp1fQ4fyTau+AE9BVfGzaR4U317856PJc243VvcijDbOp4EM
 DaIuK0UKwx6fdDsGTrJwxAT4ELsdRXCQFThsllqYx7c64bR0sdF3ARVnm0egB0SiNDKU
 CabNv6o9yyxQuHElCvXRCE/KGQKzN4nQdWBKTG6WwZEmD8+aftKQ57YQTZf1/uEad94q
 41kIc7xuXuLXFmzmT3CLe3LgVnsZghqQBmUljRWYYx0AgMgmDI+Ko73RkPByYCCQ1B5h
 vbBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZCkejYjQnF8jeOI8uk1azsiNSfntjYmPhFwwObGVwQt+9HNyEVjdL/vfFoAHpQafmmAY3Xr4Ee25v@nongnu.org
X-Gm-Message-State: AOJu0YxmFF98azAa199iw/5hWCYiGokDAz6S3R6SUuE59WUgSsGjtSvC
 d4o6K4AY6BwpBQ7v7LG+mjvt4xpaSAePPzoh6h94W0R+Y7zNBi32Wboz0GSJ2psbUxMkfFlxs8q
 hhOutcr0SajNqphpT4mL988v20cZ0K1GWHKeltZFvVCA9sdDVmtgeF7Kg
X-Gm-Gg: ASbGncsAahnsjhqpNzE41FqBN9DbggjFFNd6k4j7uxV4UCHwM/lVhcleu44Ozq/AaW7
 FZwDp9rVIPyPLGCcoDvX1plROOOQgRzUhQ86rIhuHKAAaIpJkhNfMX5teglyotAzrFQctuqNNrC
 crAymeiN38DDYKwt7DuX07NoQTfsixkMsI8lGrgRVQ4qedxQEh12AJtrCt/XdCOK6DuECO++fbs
 UavlSWjRhY4IARAKpqzgKDRKVDJRMao1zKBzUlq+mdnNkjtVUlotfjGLcpGYzgSAGOfwspKB4aL
 Is6OOg15R1QCsXIOEfz+nyLooMEqSufKih0bqUswxp3KNUz6zoUWM1hkVm+J5RVRWrYrAIyKSCM
 L6bkPSrT01BwqJhDG/0HyD1xRbX8HJEcDDKR4gLg/73yIEnGcINyDEtKah5+vPCIFtUfqCn4WD5
 7N0sJRp8f39wq6crHv/GJ0zJ2Fu77N
X-Received: by 2002:a05:6000:26c9:b0:429:bc68:6c9c with SMTP id
 ffacd0b85a97d-429bd6e16c9mr2855380f8f.48.1761912309739; 
 Fri, 31 Oct 2025 05:05:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGY431jGyitSloRxPdDdrGlzcPmOXVfJ62MdyYWhQA/d8xyQG78EnsQn2DjnbbqatYdMVQA7w==
X-Received: by 2002:a05:6000:26c9:b0:429:bc68:6c9c with SMTP id
 ffacd0b85a97d-429bd6e16c9mr2855353f8f.48.1761912309318; 
 Fri, 31 Oct 2025 05:05:09 -0700 (PDT)
Received: from ?IPV6:2003:cf:d717:1f4c:b757:9963:8006:395e?
 (p200300cfd7171f4cb75799638006395e.dip0.t-ipconnect.de.
 [2003:cf:d717:1f4c:b757:9963:8006:395e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c13f32edsm3141496f8f.41.2025.10.31.05.05.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 05:05:08 -0700 (PDT)
Message-ID: <01c7bd08-1013-454f-9226-2045fb461103@redhat.com>
Date: Fri, 31 Oct 2025 13:05:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/21] fuse: Implement multi-threading
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
References: <20250701114437.207419-1-hreitz@redhat.com>
 <20250701114437.207419-19-hreitz@redhat.com> <aPoVyZSZdaY_VOs8@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <aPoVyZSZdaY_VOs8@redhat.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 23.10.25 13:47, Kevin Wolf wrote:
> Am 01.07.2025 um 13:44 hat Hanna Czenczek geschrieben:
>> FUSE allows creating multiple request queues by "cloning" /dev/fuse FDs
>> (via open("/dev/fuse") + ioctl(FUSE_DEV_IOC_CLONE)).
>>
>> We can use this to implement multi-threading.
>>
>> For configuration, we don't need any more information beyond the simple
>> array provided by the core block export interface: The FUSE kernel
>> driver feeds these FDs in a round-robin fashion, so all of them are
>> equivalent and we want to have exactly one per thread.
>> [...]
>> @@ -451,6 +553,16 @@ static void fuse_export_delete(BlockExport *blk_exp)
>>   {
>>       FuseExport *exp = container_of(blk_exp, FuseExport, common);
>>   
>> +    for (int i = 0; i < exp->num_queues; i++) {
>> +        FuseQueue *q = &exp->queues[i];
>> +
>> +        /* Queue 0's FD belongs to the FUSE session */
>> +        if (i > 0 && q->fuse_fd >= 0) {
> Why not start the loop with i = 1 instead of starting at 0 and then not
> doing anything in the first iteration?

Er, right.

> (I love the >= 0, running FUSE over stdin must be fun. :-))

Wouldn’t be too surprised if someone already did that…

Hanna

>> +            close(q->fuse_fd);
>> +        }
>> +    }
>> +    g_free(exp->queues);
>> +
>>       if (exp->fuse_session) {
>>           if (exp->mounted) {
>>               fuse_session_unmount(exp->fuse_session);
> Kevin
>


