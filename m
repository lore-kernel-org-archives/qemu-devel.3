Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15625C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 09:01:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsHwO-00066c-44; Wed, 12 Mar 2025 04:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tsHwI-0005ws-7n
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 04:59:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tsHwG-0002MK-Km
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 04:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741769981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aF+z/VYb+VHqcPg863+KSaAwlUk+wINpe+xNacYQga8=;
 b=BLuJYj/y/YeVXndhkX8Vk44wjPA4xhAq1euM+0qzF8E3azDQildJGjSW2gnE8YUgadz/Y0
 y1FGI/LFWhXEpI8G2OWpvZd2oja45TSe34UXsygtJP8E5ZFktFA/WaOPQxdTHhyMezwbqz
 exUFmq2kISg/Rjm5CJI5l24CPm7WeDs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-N9AQLYngNMqk7EroHW5LPw-1; Wed, 12 Mar 2025 04:59:39 -0400
X-MC-Unique: N9AQLYngNMqk7EroHW5LPw-1
X-Mimecast-MFC-AGG-ID: N9AQLYngNMqk7EroHW5LPw_1741769978
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-438e180821aso31482945e9.1
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 01:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741769978; x=1742374778;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aF+z/VYb+VHqcPg863+KSaAwlUk+wINpe+xNacYQga8=;
 b=IXV5i9aiygBV5IEmHSC9r1Eb+9k4chPBGUZlJ7616E5sgq5Ii/yyCFgqRINTkhgGrx
 ppBvGW86eawGCjMyiK/i7q0aKuhshUJYldVZCynlV+hJq6X7txo0JpcMq7OCMJG9mTXs
 JCk0k66Cy7vQyoQXe/oTkBUYjJSoJwRc8XbvElx7MKiKwB6TfPpANapXAlFd3CZFX5Nb
 VWiPgSQVp+n0HeELVvVev8QGX8OYz5JhTjUVmO+0oMvabpH37h+YXDsysLsxuNTNbwts
 9AOHBiN7sGXBuzosFCT9udCNKsvLWhgnttd1Y3DEzGX3jpbhO3FeInrDDSYTeyKkkAyC
 MEyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCULUBvJ+hfPh9pIcxZGMwui7qD4wcJv1dYDEauOH6XyAKEhFME5Ll72zP1WgMHSpi4CnM1NQQnpBgvG@nongnu.org
X-Gm-Message-State: AOJu0Yw2m0/3dw7HRP2YwlTSbcgfgMJMJv9Jl06DxfkXY04WrjEDzy+V
 Z4Yr0FEJGBFrBRg3p6NWwkdfFp1TtfXytTOrN3IkHX0K25okjz7k1NlO4DkQdntoO6NIqMMD7AT
 T/4nhXWPhytWtf1XCFn1dC7n27qLYcKKGXBvpW6asE41dmwLmXNMu
X-Gm-Gg: ASbGncuW22G5fzNkTmiFnwlBRYdXUnHSAC5LIu9+DTpiqjp4Sj5/QzC1VTTcJk3ty6C
 tc20X7sJKF0g+FKyjiKtU8J1rUt0u4eKlObgNl1zsV6hJAibuYwHs2uALDYZmwFs/AytRqH62SZ
 6JYQHGcoK1oZju0jQXPKxY/RoBEtnXDP13ChMQjGoI5y4vXMUdGbWl9rOB6wggfieMhDK5/Xozt
 9GVvJ49TGDlBjaTrcbfFPlTiKGsrfgioZHl/4kxxEkNerYmbv+OBn+6h5nYxfnrDgQXD0P+lwcG
 sUHaN6XYxzbX35ye5h6j6A==
X-Received: by 2002:a05:600c:3b10:b0:43d:47e:3205 with SMTP id
 5b1f17b1804b1-43d047e37d8mr65505205e9.11.1741769977994; 
 Wed, 12 Mar 2025 01:59:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0YPekHyal6FhpQe4LRDhGlV07Ch4QZK1POunz8lxUUIrgogqgevqg9O6NzcxzZNb8MWXL/w==
X-Received: by 2002:a05:600c:3b10:b0:43d:47e:3205 with SMTP id
 5b1f17b1804b1-43d047e37d8mr65505015e9.11.1741769977570; 
 Wed, 12 Mar 2025 01:59:37 -0700 (PDT)
Received: from [192.168.10.81] ([176.206.122.167])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43d0a75a781sm14540945e9.24.2025.03.12.01.59.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 01:59:37 -0700 (PDT)
Message-ID: <4999e31e-c502-40f2-bf80-3c857aa50da7@redhat.com>
Date: Wed, 12 Mar 2025 09:59:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bad error handling in loongarch's kvm_arch_init_vcpu(), need
 advice
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
References: <87wmcumylv.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <87wmcumylv.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 3/12/25 09:39, Markus Armbruster wrote:
> scripts/coccinelle/error-use-after-free.cocci led me to
> target/loongarch/kvm/kvm.c:
> 
>          ret = kvm_cpu_check_lsx(cs, &local_err);
>          if (ret < 0) {
>              error_report_err(local_err);
> 
> Reporting an error, but continue anyway.  This is suspicious.
> 
>          }
> 
>          ret = kvm_cpu_check_lasx(cs, &local_err);
> 
> Passing non-null @local_error to kvm_cpu_check_lasx().  This is wrong.
> When kvm_cpu_check_lasx() fails and passes &local_error to error_setg(),
> error_setv()'s assertion will fail.
> 
> Two possible fixes:
> 
> 1. If continuing after kvm_cpu_check_lasx() failure is correct, we need
> to clear @local_error there.  Since it's not actually an error then, we
> should almost certainly not use error_report_err() there.  *Maybe*
> warn_report_err().
> 
> 2. If continuing is wrong, we probably need to return ret.

Indeed the correct fix is to return ret, since the Error is set whenever 
an OnOffAuto property is "on" and KVM does not support a feature.

Same for all those below.

Paolo


