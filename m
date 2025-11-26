Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B588CD1038C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 08:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOAo6-0006L8-Na; Wed, 26 Nov 2025 03:23:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vOAo3-0006CN-UK
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 03:23:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vOAo2-0005ms-Gf
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 03:23:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764145397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cK9qgzZob7EA+KW+GuMQJ4tQbrfuFRwzIv+RTh6NZ6M=;
 b=W1l09Sce4XYkXMC0KHnabkzGBHLwGN15jGqYy02OAwiDkW7BIUVz9fqDkPAjPtgIiLcW9x
 LFUhuKEQtXgXZbfKKgDD1aDsxIMQ8DunwCPGFxf/mvXV9yT2xexx2QnE7O5YExNpCxi2v3
 O2n9tFiu79NfHfhSI19A/FIzhloqhRg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-4FNtXo_8ME2bqto1ZJI2Xg-1; Wed, 26 Nov 2025 03:23:14 -0500
X-MC-Unique: 4FNtXo_8ME2bqto1ZJI2Xg-1
X-Mimecast-MFC-AGG-ID: 4FNtXo_8ME2bqto1ZJI2Xg_1764145393
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b763acb793fso809002166b.3
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 00:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764145393; x=1764750193; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=cK9qgzZob7EA+KW+GuMQJ4tQbrfuFRwzIv+RTh6NZ6M=;
 b=WPWZ3MyQJKAzUq/vesMTShuBWg4+8FrsrjaGbv7TNnGiRubxTfj2QsDYx3osbX9s9b
 dEgcZ0VXNdrAcUqXYoJSisuxKTMFoCBDrJ08gxv/ABJg3mT2Zgy+muQ7JlGWgPL9wxAC
 536rpoYTI8xG0BQZCoPTuBuC6DZkYqATJpCegT78T//o1kPltFx5pGTilVmlKdCvw2s/
 wWNrhY3lf7WSb/rsVCv32s49+obMRMac5g0FXL2XOxECFYNrUB/8r1iTsng+VOt+ZX6U
 lPro3QX9Id+MuiOjU6crB9/71vJSS/7lWqf/X7mpf8xNC+495VFQ8E9Lr5yu/HgW5ufl
 bWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764145393; x=1764750193;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cK9qgzZob7EA+KW+GuMQJ4tQbrfuFRwzIv+RTh6NZ6M=;
 b=KgLSd8YXC8i1Hq3SaIoAkHGELCBwKRYdfWy8npQ6m4IaafvEAYI/rJtc3q2K6nG8LT
 bkKbNfKSQ5XRxBXK/i+G75tPrkvQJhFezASV0HrgVMSeKCSO3fkDdOHqr9+z886dH0t2
 Th6tAqHws0L1OKKV8NynoU6cmT+b/+My5sjBW3lHmNm1ndq/x534BgfYKe/t3514aBTh
 0R325JqIqP9C9Cck5cgx5hLErXgVa3Kyv66iQ3qAtKIoWV7Eqi1UAjBisy25BySLRmNr
 CARJ5CD13/vQqVtByodX1kQC0C5+iuJuP+y0If7SCHmxzCypwQ+HyjdFt/vrQ4YShl8f
 9P9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4C7VMDKagfLcH442zuX4w4Iooxf6qzItUsA2FQS4YUcmBEok97TOJwV/Aaz3X/8wlRnM470Hfwpr/@nongnu.org
X-Gm-Message-State: AOJu0Yw5zSa6kQNTTVzQGWxZOfVAReNSAFK8bPvKdmts4loHrfFukrxy
 cJ38GNdjjwEiU/A65Rw05cIYmmfM6b0CcIejZAx9YnAPD3btp9QzYYirlOLyobfUoDJ1qrgiZY/
 0a7x3RFTEMPW3I/sgiZyDE+xKNG7QYrdt+ftUVjIYZ39PuGDP+vgjPE6p
X-Gm-Gg: ASbGncsel8IeaTuzljbsR4Rw7HW3Tb67awajiA9yWNl1bw4UNqhaEhSuTyV1uz/lV9p
 KI1cOdNXhwuCd5Bzj7bPZ2K+bBFyNY1+bYV02dal+O3CvJfcmqycm/tG3FuEF+1zNveCX8gqHyI
 hoI6fq+PzWbxvOdDbXjE3U2+4Jk1CvUOx6pq+OvJ8L3QN19folicc2HtZ9nTLuZHJ96KjIw6cQu
 Sf+UziasuejY7E4eskTEZzlnNaVhWaOS9xr24anLEhEZtrS+VtR+HeXP6EABemJ7PyUAfBkjW2d
 L/tYlAi3/GLtTslY8fFFdKHCu+4f9SOcZd63w7XZslMP+4tfxMVkR4htk/tNVhM1WRoTMLxnxuX
 Mew95dwo=
X-Received: by 2002:a05:6402:524c:b0:640:edb3:90b5 with SMTP id
 4fb4d7f45d1cf-645eb2241a7mr5401011a12.7.1764145392927; 
 Wed, 26 Nov 2025 00:23:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4NZ4mThh9ugGt8tknRc9ecoRZ1PIaVJDBRd3hxRNTlgRnmUiNkiCpLOG7z/IOgHqS8UHJRw==
X-Received: by 2002:a05:6402:524c:b0:640:edb3:90b5 with SMTP id
 4fb4d7f45d1cf-645eb2241a7mr5400993a12.7.1764145392591; 
 Wed, 26 Nov 2025 00:23:12 -0800 (PST)
Received: from [192.168.0.5] ([47.64.115.162])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6453645f2easm17062679a12.33.2025.11.26.00.23.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Nov 2025 00:23:11 -0800 (PST)
Message-ID: <90ea99f1-8cc5-4f13-af5e-5cc1f9499609@redhat.com>
Date: Wed, 26 Nov 2025 09:23:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0 v2 08/12] target/s390x: Use big-endian variant of
 cpu_ld/st_data*()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>
References: <20251126075003.4826-1-philmd@linaro.org>
 <20251126075003.4826-9-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251126075003.4826-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 26/11/2025 08.49, Philippe Mathieu-Daudé wrote:
> We only build the S390x target using big endianness order,
> therefore the cpu_ld/st_data*() definitions expand to the
> big endian declarations. Use the explicit big-endian variants.
> 
> Mechanical change running:
> 
>    $ tgt=s390x; \
>      end=be; \
>      for op in data mmuidx_ra; do \
>        for ac in uw sw l q; do \
>          sed -i -e "s/cpu_ld${ac}_${op}/cpu_ld${ac}_${end}_${op}/" \
>                    $(git grep -l cpu_ target/${tgt}/); \
>        done;
>        for ac in w l q; do \
>          sed -i -e "s/cpu_st${ac}_${op}/cpu_st${ac}_${end}_${op}/" \
>                    $(git grep -l cpu_ target/${tgt}/); \
>        done;
>      done
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/tcg/mem_helper.c | 48 +++++++++++++++++------------------
>   target/s390x/tcg/vec_helper.c |  8 +++---
>   2 files changed, 28 insertions(+), 28 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


