Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA92CD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 06:34:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPaUz-0005dZ-P3; Wed, 20 May 2026 02:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wPaUj-0005Yl-He
 for qemu-devel@nongnu.org; Wed, 20 May 2026 02:33:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wPaUg-0005Pn-KU
 for qemu-devel@nongnu.org; Wed, 20 May 2026 02:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779258806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NZCJ+S63JuzVl3D0RlH1xdzW9l+5V5ZMeKsgFlxLwuo=;
 b=jN/KBJttWct5AYP9y2hLe82bNu0czo4pixLO6AIZxHw5NJLBKu20KeLhgNNhN2fPqGnnK6
 OX0QHh50PBKKBhYrJKIZ8YcVn2pFLLR74c5lrKGsWANB1r9UO93f72ZfblIZtW7n8x/K3O
 R0iopCSnV/trpUcDdIvWCkcTVT1QrPs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-Y8mLfFt_NC24iD3pAy03Ag-1; Wed, 20 May 2026 02:33:24 -0400
X-MC-Unique: Y8mLfFt_NC24iD3pAy03Ag-1
X-Mimecast-MFC-AGG-ID: Y8mLfFt_NC24iD3pAy03Ag_1779258803
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48fd9c22b8fso35029125e9.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 23:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779258803; x=1779863603; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=NZCJ+S63JuzVl3D0RlH1xdzW9l+5V5ZMeKsgFlxLwuo=;
 b=rAFoo/tXKlCYvfW0P9PbheoJ3zrvUHc6EUoIdatrJTrhbjaW/P7anRJOnSUmbGtLvS
 tXmDh496puFOU+X6sbTng3eh8I38bFc2cf1bBJmtNYtehErrI7WB1X6RFkdm8zq5xfrv
 o7nqa0IasgeTKnXSsZCzqdSSN982rnzV10mce9EJRzw/Vmm6htWBIRJ5TW+FgOGM5Und
 Etosc96u4yx0alwUz+nKjxcMJCvs4SHg47x/nK/B7X6AR5F43+6ZoevgUY2NpJXRJENk
 9MbjLXr299KgITj6X8EKmeosjyzvDFp/2p9AWmeb8FFZapJ0Vf66HN9fp6jp3SN+CYXL
 6rsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779258803; x=1779863603;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NZCJ+S63JuzVl3D0RlH1xdzW9l+5V5ZMeKsgFlxLwuo=;
 b=T8R/5UnLl1fgt8OvBXuo9zKcUtMWgpPzgqa+oXAwCXV7QOHT8FXCiuLu593fyX76jc
 MsJO9FcHSepCqeVIcB1g1i30qYTCuIceCHATHGitmB3R/VnP3sybEWATZary4uu8xujn
 VJS4mp1/F6yeBYmhfMNFr2amkJDyLNxEBiuNTHocC33r5q4Gs7WJpA7OEgKkacSb8c1b
 5ir18gEWCAd+vbsPJQjIKuWmuiZk00nb8ngM1FMozXbmJiLcVEkiA++PPNu1duzOxpjW
 DT6qIz+9cZG2jlp7Eh6jsjeopP3qX9EEd6fI1C+BrGFr0d33duCREH6I/3z0pfnmHGTu
 UzVg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/eNhVJVNhLec9wNPoGzuEx+U0Yzxn6AMvbb+fV1dqw5Wc6mxTyfRYU+WbDFwRXx8vkVMc1zx1Nd0ej@nongnu.org
X-Gm-Message-State: AOJu0YyC/sKP8PINla85yG6wBZlF3MiC2iRK65h74uz8ELNdfEa3HZhL
 9xlxsYWRuOdTWW+GEH8+dANpv94NPeHw71ImOtsg22E/COoCyIXk42MrMFEj0GjTvGAtUNxAndh
 qyT2SDMvHZu5zk6xKKdOC2ysi8u0SMtG280MKgpDOzPqxWd8EMJG7zKT/
X-Gm-Gg: Acq92OFbVdDhopkhkwYaseoTw6oJEcgPQAzHNruxlEbTU5Wrr2MWC+11zECTSUASopu
 km8XW/umQ5XNkpGTg1op/VEqYqhHm5YFdWppbfnyEBIwkXLaiSzlwM1mGZoo3vyeI52DvjoTNhx
 qXQe41fTyxTwEcADaAVIUgMwBe73jT8xndBDCB2tDmG5UNBGl2ggCYFh6uAz+1i96NPuNXJlb9b
 bY2xlop/KTfdXzWqBdUbkWiBtfmPgPnvuJr+W2CY7yuUzsnlhJiRdacUgvxthgGDW3F6J7fhubx
 ZliNA559Wt3dIv0og0+DvnX1TUuA19pul5udFvdWQ683ESDfzpRFdL3ez/v3+DnSng6RwjwhTCY
 2lWJL75ZjOpAHp9x0ddw=
X-Received: by 2002:a05:600c:c167:b0:48f:d410:6065 with SMTP id
 5b1f17b1804b1-48fe66138dfmr352574405e9.29.1779258803349; 
 Tue, 19 May 2026 23:33:23 -0700 (PDT)
X-Received: by 2002:a05:600c:c167:b0:48f:d410:6065 with SMTP id
 5b1f17b1804b1-48fe66138dfmr352574015e9.29.1779258803028; 
 Tue, 19 May 2026 23:33:23 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.232])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e768072sm50682746f8f.5.2026.05.19.23.33.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 23:33:22 -0700 (PDT)
Message-ID: <04d1a962-2962-49dd-874b-0ea3c28bd4f8@redhat.com>
Date: Wed, 20 May 2026 08:33:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] MAINTAINERS: Fix tcg/s390x/ path
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org
References: <20260519171240.97420-1-philmd@linaro.org>
 <20260519171240.97420-3-philmd@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260519171240.97420-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 19/05/2026 19.12, Philippe Mathieu-Daudé wrote:
> This folder was renamed in commit 3704993f545 ("tcg/s390x: Rename
> from tcg/s390").
> 
> Reported-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7749fe7f9bc..92b875ddfc1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4180,7 +4180,7 @@ F: disas/riscv*.[ch]
>   S390 TCG target
>   M: Richard Henderson <richard.henderson@linaro.org>
>   S: Maintained
> -F: tcg/s390/
> +F: tcg/s390x/
>   L: qemu-s390x@nongnu.org

Reviewed-by: Thomas Huth <thuth@redhat.com>


