Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D54D49C64
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 07:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vliyB-0003A4-1X; Fri, 30 Jan 2026 02:31:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vlixv-00036a-Rq
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 02:30:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vlixm-0001Ci-Ew
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 02:30:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769758241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ubx0yXTbI7u7oVhWSD5pBqeoG8DTA+5jK7/Th+MqODw=;
 b=dtcsqtJVP2hEQxaOjClNbXilw4FYzCRk+QJhP3rTpiChBR7UfZuGH+3QPeYTGxdOS1ZKu3
 zDWHpyOM6iii02hrYJqpCp2BYW2yds7HTVCJPXOVcGzdbgcATgfUoHrl/J++U5LPosMLdW
 GStbrN02M3PgBweCRaKUxMtA3VOTusU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371--isr8ctIMZK91VoNhk1uow-1; Fri, 30 Jan 2026 02:30:39 -0500
X-MC-Unique: -isr8ctIMZK91VoNhk1uow-1
X-Mimecast-MFC-AGG-ID: -isr8ctIMZK91VoNhk1uow_1769758238
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-430fd96b2f5so1537812f8f.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 23:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769758238; x=1770363038; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ubx0yXTbI7u7oVhWSD5pBqeoG8DTA+5jK7/Th+MqODw=;
 b=U2CcWwQHUV83R8Ks0KMlsmAXomBCVPfs59n5OQnVeawp5qH2nrrVmp+TkSzqcmhnRx
 Fe3cVT5hhpYngyB0LqUUQfmXCJIqVldKcE+ZgOLZYxNg6B0zRH8bRNPotrNqfSbpJPVO
 Bovhl5MBFCPi35eF6qR15hgpUTWQKNBbx4BYkJvoRnDw/TpHhrB9Ln2jAIQuqS6B8v78
 NKN7cfNW8AGg/tTJnQJJ5Uh07qmf25pJLXqPvmHQx+ukETR7sSfxYZ+EVFZaigSPchhx
 dHxlnt4XBkQM9fOgkidZ2StWmBQrh7nYmWgQLgrECvcn10lBpJ3qkR/QNlj2erZNgZUz
 5FEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769758238; x=1770363038;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ubx0yXTbI7u7oVhWSD5pBqeoG8DTA+5jK7/Th+MqODw=;
 b=n6U0yItL8keLfz/7vRz4n6RRsUtDYcIp46+6Laz1cGpzJmCUzckOkIx+kLNjU1SJ1P
 G5HxzXqZgjeVAINgobAnslW3sO3JmDeH5GMuTxcieErYil6gVVEXxznsFU78jntflhub
 Pw58HP4XmqlQzCakx05IdubBMfiIwlX9rhDMMyV8mL1TuusKSbmun37n98EONpUn3y7O
 2WoqcpreTz44LsQpNvyAqB4vvUjNso8Nw6CFo5MIW/Yr1hCfUh4yhYFqrOzLeDI93cwM
 J6X+wpY5vhhGojhgzTdtS4lBTYMpicUWmMawwxRZrOAicKdvAPBk4+JEdKokuX+7cDnQ
 ORbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxLNC03HBa4L6fuha53/uuIfD51ftZtSybgAIWa5nFBEk0LXJSh05IwxuVvwnuQuBljPpARQktKp7q@nongnu.org
X-Gm-Message-State: AOJu0Yz1DLszZBVAxCQv63INjK9Uw5h6qqthtJ+m/fZ3xfhLxonZW2fl
 1v/d0bXYP67iTWBe9DcoX862BTf2hM3GIJGW3AWbFl1ntFMwFcwtLy3B3HfvIugxmSC+s1vfNEA
 TXq6NaA6lfML8jm9eaz7sX3c7lJ7o3MZ2ouQNzW+9pOiofTPTHQjd9XKd
X-Gm-Gg: AZuq6aIPUsgj/kg97VRh0zoJXRKyiSBDU9TjThUta5Vv39aiPp8ci4fwKdERaQebsqg
 o5ThdrvUlQuL74zIDEtiYXbdU84Cy5oWDpCsM/hXJmYVrsq4fKgBlay/+VIy44r+28xTy+bEKuF
 VfyZB6KJttq8iBdljlYyZ63qQmAQ29I5gQ62X6dOYqLGeElFoK3kIfF27XljJ44DiAGFThgNTqN
 EEYevFrEk207t8pPMyOXC/1W1lRiBzwFl+wPKow5mgMxQev1bahS5+c68tR6qsfCApjNgIZ1yrW
 BmLlKns4zAF2fpWuxpbQKKDOWi6IxN2hSKmvRA5JvI2uBMctaCTxYsaenvO+h7OVrEawxpbs2Tx
 Gjem59HM=
X-Received: by 2002:a05:600c:358d:b0:480:f27c:6335 with SMTP id
 5b1f17b1804b1-482db499704mr19157435e9.25.1769758237894; 
 Thu, 29 Jan 2026 23:30:37 -0800 (PST)
X-Received: by 2002:a05:600c:358d:b0:480:f27c:6335 with SMTP id
 5b1f17b1804b1-482db499704mr19156755e9.25.1769758236838; 
 Thu, 29 Jan 2026 23:30:36 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.220])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c428basm257127735e9.12.2026.01.29.23.30.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jan 2026 23:30:36 -0800 (PST)
Message-ID: <2b340849-a4cf-4903-8b04-46be979dc263@redhat.com>
Date: Fri, 30 Jan 2026 08:30:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] target/s390x: Extract s390_get_bfp_rounding_mode()
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20260129190902.196262-1-iii@linux.ibm.com>
 <20260129190902.196262-3-iii@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260129190902.196262-3-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 29/01/2026 19.57, Ilya Leoshkevich wrote:
> For DIVIDE TO INTEGER it will be helpful to pass final-quotient
> rounding mode around explicitly rather than setting it in fpu_status
> implicitly. To facilitate this, extract a function for converting the
> mask to the rounding mode.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   target/s390x/tcg/fpu_helper.c | 62 +++++++++++++++++------------------
>   1 file changed, 31 insertions(+), 31 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


