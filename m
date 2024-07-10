Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1518DC3DA45
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 21:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRfHr-0006rq-Ai; Wed, 10 Jul 2024 17:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sRfHq-0006rM-AK
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 17:55:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sRfHo-0000BB-9p
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 17:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720648538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gIIL8AucuI+iw4GdXZojLu+XeqMF2wJyxX+MR6K8iY4=;
 b=Eno96IMThy6tfEg8NfBVO7s9ikwaCodtbu+kitJC0C2bs43H015RO5l3Fpc6LRNb5kIQkx
 IT1SG6AXmB7x1zLnuD4RGWlEeig3iNwov5AXMac0zxIHAKxVc7pYZppzEMcKkdJSMAKDuy
 mV8AhkZeVzY7XoNetLnr7HYoARk5kdg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-rxBZv3-HPjyx8Lh1Mrxcqw-1; Wed, 10 Jul 2024 17:55:33 -0400
X-MC-Unique: rxBZv3-HPjyx8Lh1Mrxcqw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-426d316a96cso1537715e9.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 14:55:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720648532; x=1721253332;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gIIL8AucuI+iw4GdXZojLu+XeqMF2wJyxX+MR6K8iY4=;
 b=rU2FEzjDDuKuylhIiAlJ6rZXtJtjMkzC7hibMr+LZ4k8z2E5OYYOJNkz8ir9Z2p0ON
 2m1fidJM+P9pjODuNsIBATegEwab/7utUCk+Vl9nCUXa0vjlc1/slc2DOhmOilkJJtTZ
 YQeb+O2s3A7L6xl4c8Bq0eGhps8QvEYYwelRINb1+ikeyxOtTlItvbk+1JZaAA82ubC/
 Boz9c5ZBq/Hzf/RmOl1VgOMu28Xbeg6CG1o2ytd0NeXybV+1sTIS20BiTrm2Rr8Bp4fN
 uOnCIl+ks6xtKnN7+h2SORY37d+wHg7xqW6uP52GoQsG0dt2DrYZC3EWBw9vDy4ZYKjj
 FxYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeMKDmu/13yao6PTSYOb7Dfz2iYSTguQ3JS2ov5LRGWbCNqVO9K/vClbp2OjhvDbR9FKHbd6D3T9vnSxyD5GxU9kQmocs=
X-Gm-Message-State: AOJu0YwedTo2Wlj+m49KxzO2OVcCwV7Wu9kmDygZhzWRQFDsbCiPZypI
 p4h5wybAC7b8LZ2DJUdyZ+bTui24hdHimur53dETU8YUZsosb2p6OX6y3b8wZyQVlM/r7CeQUz+
 9LOqtoUBvcPzPPhhofPwpGBxdnfuStNwIHmNLv+wpGX4uJVRL8REyz/bkGlWp
X-Received: by 2002:a05:600c:2d48:b0:426:5f36:247b with SMTP id
 5b1f17b1804b1-426708f0faemr43793925e9.39.1720648532021; 
 Wed, 10 Jul 2024 14:55:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQzRcam7Bsvr6lmhnil9oerUqMKYIlNKppdJp4/LDV/8lb1yRx+gKhR+h2rgFlOS0jsTHjOg==
X-Received: by 2002:a05:600c:2d48:b0:426:5f36:247b with SMTP id
 5b1f17b1804b1-426708f0faemr43793885e9.39.1720648531663; 
 Wed, 10 Jul 2024 14:55:31 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.101.29])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-427270238a6sm61730815e9.20.2024.07.10.14.55.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jul 2024 14:55:31 -0700 (PDT)
Message-ID: <35b121b4-8645-43db-a15f-4610b60f06f6@redhat.com>
Date: Wed, 10 Jul 2024 23:55:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Disassembler location
To: mrm94040@yahoo.com, qemu-devel@nongnu.org
References: <709543045.677058.1720634520917.ref@mail.yahoo.com>
 <709543045.677058.1720634520917@mail.yahoo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <709543045.677058.1720634520917@mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/10/24 20:02, Michael Morrell wrote:
> I'm working on a port to a new architecture and was noticing a
> discrepancy in where the disassembler code lives.  There is a file
> "target/<arch>/disas.c" for 4 architectures (avr, loongarch,
> openrisc, and rx), but a file "disas/<arch>.c" for 14 architectures
> (if I counted right).  It seems the 4 architectures using
> "target/<arch>/disas.c" are more recently added so I was wondering if
> that is now the preferred location.  I couldn't find information on
> this, but I wasn't sure where to look.

loongarch puts it in target/<arch>/ because it reuses some code between 
disassembler and translator.

The others are not hosts, only targets.  By putting the file in 
target/<arch>/, they do not need to add it to the "disassemblers" 
variable in meson.build---but they add it anyway. :)

All in all, if you're not in the loongarch situation I'd put it in disas/.

Paolo


