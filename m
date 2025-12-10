Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3315AD3E768
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 18:46:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTPCO-00078o-EQ; Wed, 10 Dec 2025 13:46:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vTPCN-000781-2M
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 13:46:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vTPCL-0004Nj-Es
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 13:46:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765392360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+oQ1I6QcTb2Q530MNS9WgKjODm1HuNojuOGfZvZdw3o=;
 b=IQE5i7DW4BRneJr4GoOQynPhjS0MVp8N5W2zdS6nINPBwqierSMT6L95p5dGfEPCiKvnTL
 qLiOFt7uTYv4ziQygHikBhv0wobi3V74xky2pvBmgHaiTqdnfq2oolTiH0AtBGoGTPGDLX
 NoouStw0DXNDpM3ochiV4TDT9P/mh64=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-mBHWJlAiO-e7HCJqWsFHTg-1; Wed, 10 Dec 2025 13:45:58 -0500
X-MC-Unique: mBHWJlAiO-e7HCJqWsFHTg-1
X-Mimecast-MFC-AGG-ID: mBHWJlAiO-e7HCJqWsFHTg_1765392357
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-42e2e2389aeso26195f8f.1
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 10:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765392357; x=1765997157; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+oQ1I6QcTb2Q530MNS9WgKjODm1HuNojuOGfZvZdw3o=;
 b=ofiHzp/FfhnS/oQ7Tz0gnlBGOPHN+z/525Rg9J3mLFdgyhVGdfoeaC6ZWvKy8wQ7Xq
 tfnAcgjMgfA0SKPYPeCQqDXRTOo9D9NygnXhF//W46bIKFnQgHoGs/v4I8Y2B/cyJ4kA
 1bsmoAbFdryC2cfuV9tM5PFnpK4RSdekfUE8IEzlSPiAhduDo1QGROjx5yuoGXOSdxGb
 VVo+pELBg3srWs4tJANJl8bXmKGC6inrr9Ieg3TnYxYHndSioucnuhea38MkkcKR4grS
 C412PCr1lwQA+CJHK8wVYq5/3OzJGy3BW1Li+lNAG6eQlWVef9QsAICSvnUBky8//bUD
 lV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765392357; x=1765997157;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+oQ1I6QcTb2Q530MNS9WgKjODm1HuNojuOGfZvZdw3o=;
 b=UXTQinjzxs7NMEA8kO4jNvCgKeQ0zDweNoVZQRTm2iAGEBzWPtrXHys0AmRrw/YI13
 c/+PcYm2mcUfGYKlcqzLfBrYakeUt2EKhtRP7YyWNdGOdA0luzBKQf7pgDFqitpzSHnh
 UhNuHAmODJgTTd2JtuU4k7RCMQ6rRReH0I8dYLY25RFoXgRmI/4g4yOlKXQirjk7SaTW
 Nf40RmEKSw+YRWlnUBgHp3uX5zIH9/I+81QqFfAXO+i4hS3Wf2gXZz0foDI8A2m7p5fb
 jBjLrQWWLqGyiTBeuT43Zm89+Fr7LhlxG4Y7xg0GCdLXnQZbfQ72Ms+vbRqKk0Jz7JFB
 FQiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqYqZChf+w3eTnMhqo4DXc/8/OMM91+0q1XyTYTGhXmNHY+TxAw921YFOPtkh9lw5V76N3Y8qlD/QO@nongnu.org
X-Gm-Message-State: AOJu0Yxhcj7x9dTm3O8Q5WKA4Tqk0xfu8Bqrbl3IqMNDSWIAfvDjqin4
 JYKSMD897ORg9oaUB83uQBb+E4kh5ZhyS+uety5V+VkXtORzdeIo7THuwMJ37EQw3CU+Jj0ZDEB
 4CqkogiAJZv9Tw0R5UbEypSRcx5RrHD4AI8+1SgTPT+PiV4K4AreONpAd
X-Gm-Gg: AY/fxX6wDaADteQeDN1sDUPL/40UyWOPPFNq7f7IDE73T+e1IJFT7nP65C1o6Uc4pXQ
 ry9p279UQx/jwEroVyvQ9O4QWzF0dYCmokyioNYqb6paFZSQygdWiT49GuJ25e/w0+QTHJtWYZQ
 w3uDdXLT76Vr19NMTnZsZq2LR8htZHgw3w1Z41rsjiC6LFiGWiRZPhl84f51j4qV86eaBRZA/pT
 9LKunk61rG/USnZPkjhj6bXNRtxZkZTE17cr0+EjAAfOYsiToOeqSylaXGXAMeJzMt7S7wlJQwC
 DUu7x1RfwZi0GmAx7yEDidjbNaKu+EP1C7kOtK6Y0fJdjFv0xE9uZO0FpQOJKMzVnUVk61rJy7V
 qgRMkXzAmFIOpL9fC8jr382FjpnlOCfOWmwCFtJFBKUzC
X-Received: by 2002:a5d:64e7:0:b0:42b:41dc:1b5d with SMTP id
 ffacd0b85a97d-42fa39e151bmr3441004f8f.25.1765392357122; 
 Wed, 10 Dec 2025 10:45:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEsCrZPNJWfANKoSrfRZXVSh/26NtXbEq4/yO8zC3PE7Xthpsx+/ktp4n8U6hQMVCVcn6VTfA==
X-Received: by 2002:a5d:64e7:0:b0:42b:41dc:1b5d with SMTP id
 ffacd0b85a97d-42fa39e151bmr3440981f8f.25.1765392356675; 
 Wed, 10 Dec 2025 10:45:56 -0800 (PST)
Received: from [192.168.0.5] (ip-109-41-115-194.web.vodafone.de.
 [109.41.115.194]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8b8a9efsm460526f8f.33.2025.12.10.10.45.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Dec 2025 10:45:56 -0800 (PST)
Message-ID: <03e5d5b2-2f3f-451e-93af-439348469967@redhat.com>
Date: Wed, 10 Dec 2025 19:45:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: make pxerom report error
To: Liu Jaloo <liu.jaloo@gmail.com>, qemu-devel@nongnu.org
References: <CAOYM0N3YdrkhOXrpxE6rzk5DbLOF0GzEVaThAHxnHfQYLk+pzQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAOYM0N3YdrkhOXrpxE6rzk5DbLOF0GzEVaThAHxnHfQYLk+pzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 09/12/2025 19.48, Liu Jaloo wrote:
> $ cd qemu
> $ git submodule update --init roms/ipxe
> $ cd roms
> $ make pxerom
> 
> report error like this:
> 
>     In file included from tests/bigint_test.c:38:
>     tests/bigint_test.c: In function ‘bigint_test_exec’:
>     tests/bigint_test.c:232:14: error: ‘result_raw’ may be used
>     uninitialized [-Werror=maybe-uninitialized]
>        232 |         ok ( memcmp ( result_raw, expected_raw,                
>              \
>            |            

  Hi!

QEMU is just a user of the ipxe code, so if you want to get this fixed, I 
think you have to report it to the ipxe project, see https://ipxe.org/contact

  HTH,
   Thomas


