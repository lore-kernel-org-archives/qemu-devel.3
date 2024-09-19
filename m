Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F014CE8D4C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 05:20:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr9Zf-0000xZ-PC; Thu, 19 Sep 2024 01:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sr9Zd-0000nn-1r
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 01:19:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sr9Zb-0002pn-2K
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 01:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726723160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=76RcbHSjnpeh3n0QsnRYKdgwYM/lpxxxNq5/YBoggqM=;
 b=AfXH9f+lzuSuWvei3SrbFUhkwZ3hvFRFrOhKE+pTGjlTnvsPx7GwKNK5LhttBcZILtzdJh
 aBzMVensqtcmj6xj64HAnQoYTBNQhTEo+YdsLST3xioeJXfeBm0YHEsv+8MJ+/SSscwbM2
 XMCkn6sXnfeWsUd+70mvk4A5QzK+6hA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-HrirD_aEOfSmAMLqEWRGvA-1; Thu, 19 Sep 2024 01:19:18 -0400
X-MC-Unique: HrirD_aEOfSmAMLqEWRGvA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a8a92ab4dd0so23071366b.1
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 22:19:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726723157; x=1727327957;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=76RcbHSjnpeh3n0QsnRYKdgwYM/lpxxxNq5/YBoggqM=;
 b=cQjZnqfMMNXrHR+0jOdbmKUykVsTtYsvgbQVr302q1ZrsTS5Dgk3bjleUCSVLhkZ/Q
 J7PVBY0kpMVl2bdcEadG5p3QSGMk7+1+1aQwmkGLi+4jZY79RG5T0XU2JSTs5LguyJlU
 BKCYw4zaPX+cyDCjAFR4sch7ADjla52gqBpZd8Qa76BfzvGjChbJHPQf7FixeVbJh6fM
 FW+zy81Dd227x8N1huiHI8keyJI6h6lnH7vaYM40OAUSlNYRBUT6be5caPulbvToznqK
 eE5HUbvB33EGP2W/WO9vyVqAcGqYfAM52cDhkG3yDQnaZwL+XyyVABPBNE6AvWs5b+nE
 kz5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXm7hXQU21CrzJProlUDL4B7LuJQ7j1yNW6rJ9fbzPbcWKMOt65o8bhB8U4FfgGQqZ00+8Wt+172RO+@nongnu.org
X-Gm-Message-State: AOJu0YwDynnVL7GV1jAhsaRbtBsOL3UpzsMc3h7EQ/dc2yKZhFZGqJkP
 eB7/24MuPEZNs3LS2Bkwq126oLi/uBanLYVqgwN7wceAIjtNWaEtrvWLLh+U8laxa2iT+NUcxZX
 8SwebxeAi0wE9y0vZMNkbrlPRNyG/S2Su27jnTqeyYBWNyWvWKdGH
X-Received: by 2002:a17:907:948c:b0:a71:ddb8:9394 with SMTP id
 a640c23a62f3a-a902961794emr2317606266b.40.1726723156900; 
 Wed, 18 Sep 2024 22:19:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/AFxA/6glRQTsOUnaiYywe9SvF1tukm8Ij5rFjyj41MXU489WkCPP4m33SWX97+xOX0xJmQ==
X-Received: by 2002:a17:907:948c:b0:a71:ddb8:9394 with SMTP id
 a640c23a62f3a-a902961794emr2317604366b.40.1726723156487; 
 Wed, 18 Sep 2024 22:19:16 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-42-49-166.web.vodafone.de.
 [109.42.49.166]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612b3901sm678507666b.99.2024.09.18.22.19.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Sep 2024 22:19:15 -0700 (PDT)
Message-ID: <128f9e37-fa1d-4086-8a93-25ac6c44ee6c@redhat.com>
Date: Thu, 19 Sep 2024 07:19:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest: Add XIVE tests for the powernv10 machine
To: Mike Kowal <kowal@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com, lvivier@redhat.com,
 pbonzini@redhat.com
References: <20240916182311.30522-1-kowal@linux.ibm.com>
 <475a7b69-d0ee-4acf-88c9-64ac03864fe5@redhat.com>
 <5eca0fa0-7925-47c3-a857-34f500f98312@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <5eca0fa0-7925-47c3-a857-34f500f98312@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 18/09/2024 19.08, Mike Kowal wrote:
> 
> On 9/18/2024 10:05 AM, Thomas Huth wrote:
...
>> That also does not look like proper content for a header file. Please put 
>> it into a .c file instead.
> 
> When these test were originally written, the authors had all of the tests 
> and their functions in one .c file.  Some thought it was too large and 
> confusing and I separated the different test functions into separate .h 
> files (and including .c files is not typically done).   I suppose I could 
> have the different functions as individual qtests, opposed  to one XIVE 
> test...   And I couldn't find an example multiple qtest .c files compiled 
> and linked together into one qtest.

There are a bunch of qtests that are linked with the object files from 
multiple .c files. Have a look at tests/qtest/meson.build, look for the 
"qtests = {" around line 320. I think you could do something similar for 
your tests here, too.

  Thomas


