Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A24F7CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7DcR-0001OW-1q; Fri, 10 Oct 2025 09:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1v7DcO-0001Np-Qh
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:57:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1v7DcE-0003ft-Oc
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:57:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760104613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=K0dV9pyr8a70FDWuP2mWjgdH86WHWjV11KceYCHWSa4=;
 b=N7GQ9rShaga2iqbjVF7twrs44fjyiJAgYUkXdjHFEuX6Jei8KdEE9Fh6ugfJWuDf6ZrfWt
 nMbzxAW8ncHcuZQH/0ZP4S30ys4N7fRHykqm9SXuLy1SHxirrZ9y3LheNBmLgOdi1MK1bo
 EshcFrjhfCNTIkPERJd+CzW6tZCh4OI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-eSXzQztrMbKRgfnG6Vm3qw-1; Fri, 10 Oct 2025 09:56:52 -0400
X-MC-Unique: eSXzQztrMbKRgfnG6Vm3qw-1
X-Mimecast-MFC-AGG-ID: eSXzQztrMbKRgfnG6Vm3qw_1760104611
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3f6b44ab789so1171868f8f.3
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:56:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760104611; x=1760709411;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K0dV9pyr8a70FDWuP2mWjgdH86WHWjV11KceYCHWSa4=;
 b=IVd0qjQgL3ziAmJH1P1jH/j3pWzAiLld//OKXrYkUUu0/shx52uBgpFCE38ixzNp2z
 l21MC+QG16WEXKy7ixwPehAKXHXfp/GsVE4dA/+BR6ahMiR6GxR8w7qQeNq9LpT+2fm5
 9g7k0XLA35v7/P8E9Hm/OIeiTsTV+nuyOZNs00YeSTrGOZnYEkWonQLmR+XMbfiNrWF3
 5xpdbHUUnzkQzJEyTXvD2CcBu5NGmvygqWvQqA+AQwspGLcHeBZvh++rBZSWzbFudLHL
 I9/qR68p3HCTlMYCh+dotAqBCwpAK26rLYjE6jGXH3ru6INhtQjpiI0/YNjfCnFydpYL
 /SvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUw3YDUVNjkfPBXZQ8PJLzhkhtt1F2z5THpB1zp+UjBtn71EOcZbHQWluSnEIJyB5Zw2ZSl75Xj3rHz@nongnu.org
X-Gm-Message-State: AOJu0Yx6HRhQyfT/71tFahuz2z1ksRFiVv1CeiTpmzoTs6yoxMalMSgE
 AKFTRMheuMoMsOiCxderQTUkceM06OWVVJJA//hWVecGXOkAUIOlONBCkJkZFWiIy+Sk7/EMQ+B
 YFH+XJDn6mI6ltZNqNOLxB1SAftXqI69QJYz+m3ItVIC/WWuU9iTOm2wj
X-Gm-Gg: ASbGnctbPeXu5B64bKckzdLipV8GWLS1AKqBEBhPqTBdD1/SNWcmY4KMVuxBlqk0wXt
 mRm31g2oVJqD3WgdHbAzpj8j+/aZbopDnuaoBfJx5i+fhuqa/aMQnQjwHWWPUc3F5fHrfL1zXe2
 fd/SddUTL2TKJAJslBOShk2nPH6ItZu53dtBHg6Xyi2XhfjYiJ8iBeN3wJzYX92E+rGurS1Liu5
 tWJgbRKeUrIwj68iluxoUipLTpSGRkxxRyRxmAaWmyW+kjO/9WQRmyzdtd2HNpbcJ6r1zgeF08B
 p4iv/8W/jt1dY7B+R/EICqYdF3I+6bWZcuLAm6Hmw/3/nOEgG2S06is7iWSk9Y/IgIcymjEKVLo
 z1OU=
X-Received: by 2002:a5d:5848:0:b0:3fa:2316:c32 with SMTP id
 ffacd0b85a97d-4266e8e44c9mr7271367f8f.57.1760104611026; 
 Fri, 10 Oct 2025 06:56:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGENIRTu4x1YfWf5sEr+OkoAv5O8anisJTdon6IIG82DWjj3HDGNKjnJT1sArP3tlPxghheig==
X-Received: by 2002:a5d:5848:0:b0:3fa:2316:c32 with SMTP id
 ffacd0b85a97d-4266e8e44c9mr7271345f8f.57.1760104610559; 
 Fri, 10 Oct 2025 06:56:50 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com.
 [80.187.83.189]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e7e44sm4301361f8f.46.2025.10.10.06.56.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 06:56:50 -0700 (PDT)
Message-ID: <2fc018c3-6548-490e-a220-fb203a588138@redhat.com>
Date: Fri, 10 Oct 2025 15:56:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/16] target/s390x: Replace HOST_BIG_ENDIAN #ifdef with
 runtime if() check
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>
References: <20251010134226.72221-1-philmd@linaro.org>
 <20251010134226.72221-15-philmd@linaro.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251010134226.72221-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10.10.25 15:42, Philippe Mathieu-Daudé wrote:
> Replace compile-time #ifdef with a runtime check to ensure all code
> paths are built and tested. This reduces build-time configuration
> complexity and improves maintainability.
> 
> No functional change intended.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---


Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


