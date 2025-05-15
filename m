Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF46DC3DA6D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 16:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFb71-00034H-IJ; Thu, 15 May 2025 12:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFb6j-0002rK-4v
 for qemu-devel@nongnu.org; Thu, 15 May 2025 12:06:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFb6f-0000YM-EQ
 for qemu-devel@nongnu.org; Thu, 15 May 2025 12:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747325206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xeLEOoji+8IuVVlU+U74b7cKvOsX+VFZKG2Xm6Po6bM=;
 b=BA//2UPFfpS3UDT+lEPkjDlOZSkvbWxfp3GoLoRb585Akr6rPH1cbz5/PoiO5TqKRHWBxG
 vFybqSUpwMw1EorVxceDiTFf+iplkpCsDyknfpR40ZtJur4c0D07xG2pfh383vktKhFMaL
 +L0t6gBv3oOWHPDyeUZhWp5hcQ98OCY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-BGFPXEJvOYmFDUlKhQpJ3Q-1; Thu, 15 May 2025 12:06:42 -0400
X-MC-Unique: BGFPXEJvOYmFDUlKhQpJ3Q-1
X-Mimecast-MFC-AGG-ID: BGFPXEJvOYmFDUlKhQpJ3Q_1747325202
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a20257c758so747634f8f.0
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 09:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747325202; x=1747930002;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xeLEOoji+8IuVVlU+U74b7cKvOsX+VFZKG2Xm6Po6bM=;
 b=we8vevOk6R4kfHlDvRsiasb08cwVmrp1d1QisxKHtz+bsyO8Mu/scG7332dTkYZsZi
 C/WmPdVt2nSl1dy43Vi5rjUywqx4BSYgil2445Gn0q2YLNYbI7v5JLxMdx5wzFT3Pka4
 sCUAdsW4/9jG7tHb+8b3OBnZGFPMkcz+9RdyOJ1I7oyyc4/DGPZJUvC1A04lq7srQCz/
 9EawYwpCRER4CSEKFCPnWnb0LWEDLHcafVmetb++cCu0ggngmpvnpA3TsMOU3H/9rtjI
 YQxc+YfJFRKl8r6Ki+pVSA/2J/9St6goiazWDf9xwkb4Vqa744rt0lKfPqF1BOLg0Fko
 F4gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDdz4sDpA38IlhlDaU51Q+lBQrIsxVjU6wkyOdTxepcfzFy51wZcHkTphPheU20Use1z56vPiSXTkk@nongnu.org
X-Gm-Message-State: AOJu0YwucWOrF+EksukKF04TEN8oZaJ5sR74HxKcZR9TplrHFwsWbQxc
 o9gmQnAU29Vas6LfPqK79yRVwHlK4UK0UQI6JN0D0+blyWtU3Jtg9gIWnaWcDhLTb/FxJfvBq/1
 +JuJzrfszed87DE26MYgpSDIv2u4Br2qUzYog2GU9yb/wafCvh5yYB8SR
X-Gm-Gg: ASbGncsbCgvFacBx50aRHWX3spemlWtCECUT4TLUxSX+654sLUJbQDYezgWUsuBlRi9
 YinfdamtNA1mMQCuMwR3KGF5jakP4S9XkFzqs7bgZ7+CGX+ebwjdlU1I0G706qOLYp4a60wKAsf
 P9n5aInuAQpGHZuHZozW3k72MLtZxOI+j5F7o9AhmUtnYl2Ul2RKz7dZdfiFzmrpTqCz/MWHEe8
 0Cm7OR6TMOgDQgLu8b2Bu2DXnnfVkRHpDM6b/hBXZ8hRivY1jBz9ux5lG2453Kj67VoOujGkg9i
 V6OXHgfFWmD+iApOALoqdTG9NAAWY2qtIuhTLt4BtJTnYTbrEw==
X-Received: by 2002:a05:6000:2486:b0:3a3:4baa:4146 with SMTP id
 ffacd0b85a97d-3a35c825d23mr385585f8f.30.1747325201556; 
 Thu, 15 May 2025 09:06:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5+wRegvuXFuuq1qkIyjfqPNLfizUvvnDIf996L3I4KH3o3KBaBXHYvL87wzldxN0sKgBu0Q==
X-Received: by 2002:a05:6000:2486:b0:3a3:4baa:4146 with SMTP id
 ffacd0b85a97d-3a35c825d23mr385530f8f.30.1747325201028; 
 Thu, 15 May 2025 09:06:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58f2f65sm23553833f8f.55.2025.05.15.09.06.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 09:06:40 -0700 (PDT)
Message-ID: <353e8a52-b03c-438c-8236-8f5b6968acf4@redhat.com>
Date: Thu, 15 May 2025 18:06:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] scripts/checkpatch: reject license boilerplate on
 new files
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20250515135936.86760-1-berrange@redhat.com>
 <20250515135936.86760-10-berrange@redhat.com> <aCYQtA4cU2xPyvPo@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <aCYQtA4cU2xPyvPo@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/15/25 18:05, Daniel P. Berrangé wrote:
> On Thu, May 15, 2025 at 02:59:36PM +0100, Daniel P. Berrangé wrote:
>> The previous commit mandates use of SPDX-License-Identifier on common
>> source files, and encourages it on all other files.
>>
>> Some contributors are none the less still also including the license
>> boilerplate text. This is redundant and will potentially cause
>> trouble if inconsistent with the SPDX declaration.
>>
>> Match common boilerplate text blurbs and report them as invalid,
>> for newly added files.
>>
>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>> ---
>>   scripts/checkpatch.pl | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index 87050e6677..cb1942c021 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -1496,6 +1496,13 @@ sub process_end_of_file {
>>   			     "' need 'SPDX-License-Identifier'?");
>>   		}
>>   	}
>> +	if ($fileinfo->{action} eq "new" &&
>> +	    !exists $fileinfo->{facts}->{sawboilerplate}) {
> 
> /face-palm  - I forgot to remove the '!' here so the check is
> inverted and my test patch had two very similarly named files
> so didn't notice it :-(

Oh. I didn't see. No need to resend. I will fix in my tree.


Thanks,

C.




> 
>> +		ERROR("New file '" . $fileinfo->{filenew} . "' must " .
>> +		      "not have license boilerplate header text unless " .
>> +		      "this file is copied from existing code with such " .
>> +		      "text already present.");
>> +	}
>>   }
>>   
>>   sub process {
>> @@ -1798,6 +1805,15 @@ sub process {
>>   			&checkspdx($realfile, $1);
>>   		}
>>   
>> +		if ($rawline =~ /licensed under the terms of the GNU GPL/ ||
>> +		    $rawline =~ /under the terms of the GNU General Public License/ ||
>> +		    $rawline =~ /under the terms of the GNU Lesser General Public/ ||
>> +		    $rawline =~ /Permission is hereby granted, free of charge/ ||
>> +		    $rawline =~ /GNU GPL, version 2 or later/ ||
>> +		    $rawline =~ /See the COPYING file/) {
>> +			$fileinfo->{facts}->{sawboilerplate} = 1;
>> +		}
>> +
>>   		if ($rawline =~ m,(SPDX-[a-zA-Z0-9-_]+):,) {
>>   			my $tag = $1;
>>   			my @permitted = qw(
>> -- 
>> 2.49.0
>>
> 
> With regards,
> Daniel


