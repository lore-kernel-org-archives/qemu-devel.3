Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB67ECD992
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 18:32:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo49U-0002bt-39; Thu, 05 Feb 2026 13:32:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vo49S-0002b8-Hv
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 13:32:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vo49Q-0004PS-Vi
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 13:32:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770316344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zCdQFVMQobv52y5fn+NHt8KFjPmPwI7DfSrRgPcSsPY=;
 b=ftU+kDA+bQHarigdGBUFxzX3VsDskTDiym2jQ3DelY4G6NTM9xXTbLAqUErNIL8wOeuHBV
 4bB85hQZIGFDROnXl5sa9LGkbUsIbmm/RD3EvG/vKdX3ZWh1Tlft9S0P34D9aDJ8zahEPG
 CFkxLtEN+yIyS9pJfOCpQlF7NjtCooo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-fc0-FHekP-STLXBWCtCaXg-1; Thu, 05 Feb 2026 13:32:22 -0500
X-MC-Unique: fc0-FHekP-STLXBWCtCaXg-1
X-Mimecast-MFC-AGG-ID: fc0-FHekP-STLXBWCtCaXg_1770316342
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b8861544696so142850066b.3
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 10:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770316341; x=1770921141; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=zCdQFVMQobv52y5fn+NHt8KFjPmPwI7DfSrRgPcSsPY=;
 b=SZE/8X0TECmMMhb1LFyjTrHqdJCh3zme5cbUKb5BiJc0OqXreh92YWPoY9fveP3OYz
 tL+AS6rl5gV7WnSRvzsXIVHq55TVvX2WvlN1BaUSaHncfH9Q4Zy6hiQ71t4HL0I/e67h
 V1EzhVWtDC2gBtrLjOdl3Hn0buhsviuMRL90p+yl8222NSbIe12qI2kBg/UNL8I3Ce6A
 aLiFzr0kKEFNNMAnhdpA2JsaMY3Oa4sUTBwv7jWEJD5066dJxkBWKXlJ7F43AvSKQXZ9
 uw6x1d3ERQlUr9aU0T2RHk0Yb9tf3q7f6uAKb9vXob/j4ujR8jqbG1OzlbF2sDIpqalX
 35IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770316341; x=1770921141;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zCdQFVMQobv52y5fn+NHt8KFjPmPwI7DfSrRgPcSsPY=;
 b=urQFwcqtU1Fe4if++EiM06KW5XK40NwnyXLQ1sj0sGNRt0T7zgMxBJN8580/Cu1wwX
 dzm8TQ0QaZmTt2g8q0OVufkhhwTbb1/vGt3+1rojVfGUCy9QlWISQRbjvVU/Qw1MN+Or
 WRmmj4ReWj62mSjhDyvSMxfK/yeJRP2tg/hUxT2eV7FQErpNeSbuK3CJaMXWCv5BXuB6
 b0lSP2pLhOjZyPfMdbpSBqEkKpB9cE7nYoSECYu9+PyVOMaozNXyNgixB0FBRVPhRng1
 jrorlA/IXUtpn6mze+uBw2Y2eILqfIpHAoOaQDPD5y8RPJfiO3MThDpL5pCUst5qcLYV
 DbZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZgyUSNi9/rH2UHhuOK7KJTg74LRsK+ry2b9tZ+MehyDSEroyeUQktoeZawWjbhIMgolGlwaMPF0VB@nongnu.org
X-Gm-Message-State: AOJu0YzVanjbeObZPBzn2I6GqBv9upjO8fzdl/8cDIH9ydZp99kfDUZF
 pk3+y9XlQz9cMC8qSbXKMVVDSnwZfpk87ysp2HT7j4rKV/PD6ytnGsHKwhSlc3OBOD6cKWZfIDp
 vN/DidyAZ7zKudjwgM8dUauIZrcCWPE/uRjMyxpwhPXk0iLV4K1cw57+1
X-Gm-Gg: AZuq6aJZkYpevdyw/cki6VffA1+fVVhcsUqCIl9RkWYkl34yNUIp62cC2B6kLhDxyU0
 GFnzUJNlgvHFjF9D1Qr9t4kjI3n5cNReb4z3rwL28i4O9b78jpXyigBKWjTxls6OunXnylNSbvN
 /MPGeiIoM8paP1WiI8MbX4UE89jPCm5qQakMaQ4WoL6v0LbhfwJ3Bvfxc8xR9TWH1IPYLP0uox9
 elDCRIeARzM8nII7Kxy35Mla52iYTXrIBLFpdT4kV3v3Jj5Q0JlHej/oqf5P6X+HLFZ1Ef9rZbK
 tEOdgS/di7PRzEJyYx/u6wA4HnnPbZ5s3kBGEvZsnOS132TeCzkEZVhlh4dBb1mLH+oTUyJgITO
 /pBn30sc=
X-Received: by 2002:a17:907:e107:b0:b8e:a179:3331 with SMTP id
 a640c23a62f3a-b8ea1793b09mr359470466b.5.1770316341688; 
 Thu, 05 Feb 2026 10:32:21 -0800 (PST)
X-Received: by 2002:a17:907:e107:b0:b8e:a179:3331 with SMTP id
 a640c23a62f3a-b8ea1793b09mr359469266b.5.1770316341292; 
 Thu, 05 Feb 2026 10:32:21 -0800 (PST)
Received: from [192.168.0.9] ([47.64.115.203])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8eda7a5a31sm8852966b.24.2026.02.05.10.32.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 10:32:20 -0800 (PST)
Message-ID: <485a1392-3a21-4f5e-b9fe-ce0be5c056ce@redhat.com>
Date: Thu, 5 Feb 2026 19:32:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] target/s390x: Expand TCGv type as 64-bit target
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 Eric Farman <farman@linux.ibm.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20260204182722.44062-1-philmd@linaro.org>
 <20260204182722.44062-10-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260204182722.44062-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 04/02/2026 19.27, Philippe Mathieu-Daudé wrote:
> The s390x target is a 64-bit one, so we have these expansions
> in the "tcg/tcg-op.h" header:
> 
>   . tcg_gen_qemu_ld_tl() -> tcg_gen_qemu_ld_i64()
>   . tcg_gen_qemu_st_tl() -> tcg_gen_qemu_st_i64()
> 
> Use the expanded form which is more explicit when a target
> isn't built for different words size.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/tcg/translate.c | 54 ++++++++++++++++++------------------
>   1 file changed, 27 insertions(+), 27 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


