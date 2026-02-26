Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBDFAFD8FE1
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 17:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvf5X-0001Gd-JC; Thu, 26 Feb 2026 12:23:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vvf5W-0001GD-Hr
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 12:23:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vvf5V-0003GB-1j
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 12:23:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772126623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9vXdZHUB4yq1T06PtQXg7acfPst7t78RnMqwk/XQieA=;
 b=PutJCHXo/nmGzDC7Wge3QUbXFxZJ0tmAGvbL4qx9FvfP46Esm/+DSGs4QmXhKIqr/636ME
 KWVftlQXrj0U5RrmpkHfB++Ury4xkbs6z6FltLyxl+ypUVa9ld+d2jVMmrDKPlSEHlXJRG
 8dn7UHpFJAWb3Mutz2HbuXU674+yMcw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-fIhTt_2vNyq_YNNvzE78pw-1; Thu, 26 Feb 2026 12:23:41 -0500
X-MC-Unique: fIhTt_2vNyq_YNNvzE78pw-1
X-Mimecast-MFC-AGG-ID: fIhTt_2vNyq_YNNvzE78pw_1772126620
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b93665db5e3so69403266b.2
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 09:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772126620; x=1772731420; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9vXdZHUB4yq1T06PtQXg7acfPst7t78RnMqwk/XQieA=;
 b=gZ6pGmCqYQkdmccEn6RUEk3/F+jCo6Ks08V54G2IUZyM0+9uFtueD7iTH9+EpmwCGB
 RmyTyUAUGfevWrVIpGKaii1Kc7eSArqqF81+ZLIkbzkXCP2GTAeOZG+7qOHcAfyL4sAg
 Pq4GM9JQ3kqBpJpReI2ypUpPkXSwbd02CaOvdMSF5P8i3+TXPUp0uf1X2+aZ4ovv4UoJ
 vRjIjYmhu9hz/bwOVmz6BtuTSqEW5LzPwMvL66yLzJqIG362YjoBA85s/VxTXmbWLZSX
 mao3+6NnaaEf6wzOJ48TNuKtUEYL6vJDeoJexkTKORZR+DoXPcYjw+VPMDPx/XFUMhRq
 Ep9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772126620; x=1772731420;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9vXdZHUB4yq1T06PtQXg7acfPst7t78RnMqwk/XQieA=;
 b=ZHLX/cj513xEmxhaqJ0cm4LkjkClnufP4ca4D5lUgxqCnOXVFNy27UXptHTSoi/Nau
 NaHQTrDpNPI20E1mvvQKYdf0Jpl78zIx222T7gMtM6I6jvYcH5hsb1g0Mdb+QfuojWI/
 fnoYeMM3H/twsF5Ne9zeIAmOJCJ3pOnsL0YSNS5uYrhzHamZ6njm++7vo0KHq8D4SxMx
 IdCNpudMsJNMgpcslAxvStHw7ffq2/VabrkF3Ojmx0bCw1TZ0zWC+tA8s2/odlshG1jK
 QRwKKswCTztI5YEa6B7iKdflAUooC1NelmlhE7dYqekX+KZw9PoegCXev9eROJiCqnMi
 vZNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeDqK1OJYk5VFLEBmxdVs+d33xvt8kepo91Ha9X0ccAG9xbnsRKjfLtEGxnR9QNAuSZV6+lM+eLa+B@nongnu.org
X-Gm-Message-State: AOJu0YyISYvQl2dk2tWY/GEqhRZ72lRkiQDu8NXBPAXH4JxTN+2sTGM9
 EZ4MM1QmRjoFd0jT1KJu/I22xOYw5V2pS5J1FkZL09uSJLhT1VxnMA8wmFuZjnDRUmRqpHlTdJQ
 bIesreTSNL3qomtJlDTfXEcx+OipxCmGQhfDsCpUGb/9zz4efCRINVthU
X-Gm-Gg: ATEYQzy8nMQbg13c9j6FO2SK0ICXCObwOLgoDrlqbWRVTuzTZFCJXfEVvMBEuEbETKo
 XOlseLOiddVXTNT69iS/lkPySPJkSxj+vZ/AqNUQAJPaGFoHZ26uIus9S7Uxzi84PBL0kgah1as
 yOLzkHtAt5lExNtF2S+gG6IVnWtuAHuGvE1CxWMp0mGsCF8EWqg59HO05w0aivjzsIgTAyI7xMA
 jk6ymZYZmKwB/YSMnIMSVC9sE+uwTMAzwOTV9hrIQajKSI3dpXSY+O3vVbmjurxYy+WBSu4ucSg
 k/2RaZX0WH/q1nUCQ6h1UHV4M+kIBCHiEDHeBsvO+UEbHgWtDoBOyatECPJfVg/JqaaKWSFq02a
 sRH/YtE6qEw/ioroW1Qlrz60s4ua7rl62FauMmi5o4XKtB/xvavMC35IQ83e7kZBrvLNraSBXHM
 ceg0srH6e64wJ6fzhxkcH0Qss=
X-Received: by 2002:a17:907:948e:b0:b73:667e:bb29 with SMTP id
 a640c23a62f3a-b9081985f25mr1103887266b.8.1772126620367; 
 Thu, 26 Feb 2026 09:23:40 -0800 (PST)
X-Received: by 2002:a17:907:948e:b0:b73:667e:bb29 with SMTP id
 a640c23a62f3a-b9081985f25mr1103885466b.8.1772126619873; 
 Thu, 26 Feb 2026 09:23:39 -0800 (PST)
Received: from [192.168.1.84] ([93.56.161.93])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b935aec7091sm76204566b.58.2026.02.26.09.23.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Feb 2026 09:23:39 -0800 (PST)
Message-ID: <54c74ac4-3eca-483b-b56d-73c6e7d17c3f@redhat.com>
Date: Thu, 26 Feb 2026 18:23:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 35/35] migration: return EEXIST when trying to add the
 same migration blocker
To: Ani Sinha <anisinha@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Ani Sinha <ani@anisinha.ca>, Prasad Pandit <pjp@fedoraproject.org>,
 qemu-devel <qemu-devel@nongnu.org>
References: <20260225035000.385950-1-anisinha@redhat.com>
 <20260225035000.385950-36-anisinha@redhat.com> <aZ8xlrL2xQtoN9MI@x1.local>
 <C486617D-2B20-4904-A87B-81CC5FA84153@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
In-Reply-To: <C486617D-2B20-4904-A87B-81CC5FA84153@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668,
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

On 2/26/26 04:46, Ani Sinha wrote:
> 
> 
>> On 25 Feb 2026, at 10:59 PM, Peter Xu <peterx@redhat.com> wrote:
>> 
>> Hi, Ani,
>> 
>> On Wed, Feb 25, 2026 at 09:19:40AM +0530, Ani Sinha wrote:
>>> Currently the code that adds a migration blocker does not check
>>> if the same blocker already exists. Return an EEXIST error code
>>> if there is an attempt to add the same migration blocker again.
>>> This way the same migration blocker will not get added twice.
>> 
>> Could you help explain why it will inject two identical errors in
>> the first place, and why the caller cannot make sure it won't be
>> injected twice?
> 
> Likely due to a bug in the code. For example if the init function
> that adds the blocker is called again and the caller does not handle
> the second init call properly. This came up as a part of the coco
> reset work where migration blockers are added in init methods. They
> need not be added again when init methods are again called during
> the reset process. The caller can handle it of course but adding a
> check further down the call stack makes things more robust.
Since this is the last patch, is it okay to remove it at least for now? 
Can the situation actually happen?

If not and it's a programming error, even an abort() is okay.

Paolo


