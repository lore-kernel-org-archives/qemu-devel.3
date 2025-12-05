Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3798D2CE1C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 06:15:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRP6A-0003kd-PA; Fri, 05 Dec 2025 01:15:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vRP5x-0003jt-S7
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 01:15:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vRP5n-0006so-8X
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 01:15:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764915291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SQFMcZEfBQdCdtH7i2x7TKByBR2ykjhaDlkkR3lPvbw=;
 b=PV6o6GEcg5JI8EnNOUJjyXJ6LOyPMUbzB4fxPJPQ3gdivt/omJSPZeVJjFgJMsKkbs3Tc2
 VENFwH58h3XD0ngLVHgZmWDxnOr35SVWi37dfO0XL59yk67uN6+x+JOaeVOUKmn51s0I7q
 P9atECjSPk/ilvUCUxzrV07OKqt/1ww=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-WkG4hOY5MpKse-qye0VHpA-1; Fri, 05 Dec 2025 01:14:50 -0500
X-MC-Unique: WkG4hOY5MpKse-qye0VHpA-1
X-Mimecast-MFC-AGG-ID: WkG4hOY5MpKse-qye0VHpA_1764915289
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42e2d105358so1085164f8f.3
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 22:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764915289; x=1765520089; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=SQFMcZEfBQdCdtH7i2x7TKByBR2ykjhaDlkkR3lPvbw=;
 b=A1SAzKzc/Y2PTD0Ed0a75lktSk2phUOoj0PoBT2WlNI1eHJ4iLlqUMljfIpoegUtJJ
 OkUXwlT8Q+AIR8PEeySda55NfE7VZelmQNYaaFRL5p5SkvyZOm5CLfQsX0UC4YiCbLxR
 zGzd3myQzSEYFbiLcqSt9LqMlEvl5m9QHacL6Di7nRvp4yr37vFuO1dGlFm5mj/DM+zt
 EcBjt9zzG2Fi9WR4eDPiHAg3yMbDGBFMJf07O7w0gIYj9zcPqvLKNeaFv1EDK31Qfs31
 FSQsySoB6tWW3cTXC1V6/PNwstPLdh1P9XJgXpoFKL1YPIju9H1LgMsBecKwe9tLUeu9
 Zpwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764915289; x=1765520089;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SQFMcZEfBQdCdtH7i2x7TKByBR2ykjhaDlkkR3lPvbw=;
 b=lrq7jEohM+eP2COb1mxM/9oRFsfPP+FJPErZapW51L4IwYBvqzsvy46kUhpP/0KZal
 /xIG4J7xBz7Zrg77XJ+sfC9ON/M5SSUQtqmTaJI2k7wqYzo8HbkCtPgFHk86PwBOLwK0
 cXTMY2fB2QYO3HGUHWf0b0oTzDSgoOHV3/5Xb+JNvBQZe3pRzs1hjeiToP7ESqVoeyxl
 NzTVhRP4/pkSCNFl/fjU0vbTgLITm5B4VZ+EG1qbQ+gdXCjvzgqOVhwvYq3CsMlYf9IL
 YVTY+3ttbZuo21DUeMmOVvAw2hvDOXF156P813LYRtMJVFBN2r5S6RONAKQnDI7nyYkC
 O1nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCULuZNTGoUXZ9+vr+8tQm7NczyvCIYFRg+GMQlgJ0FXkcu8XgcmieZQnznyI/0hQ5XonVvymgC2aCQR@nongnu.org
X-Gm-Message-State: AOJu0Ywhu8VdfdaCnsLk4E2nkCYcEpn5cJdvbqC4g6YO7GYw5VAwt0UD
 800qjmw2nsOze1WpWheKjbrmAFpO51Uk2bhNqVzoizapTQ31DOw9drMzncAH+Eehd57iDV+tvel
 hwpC1fHB6Zuau9JStTy45iOId8vNqqyAHSmlISlSE5YiT99eDfvSGoKIR
X-Gm-Gg: ASbGncssyTpwC0AN33tJXYq8lyOrWld3PNYFv1BsCz7FQ+gqQcyuQtH1LNfZ3PK7OUQ
 KlR/aCoVvPW7SxW54RcA9D/I1m4s6OQZpfvfCupEPE8VNSM95x8aeZab0+Mv0KYWKkMCec11MXy
 y0jARSHMRzH1AzjgxJ+bJAcJH7FPoqUCpabFNxNmhVsr5NtJf9UD0YK5FbMFSXBbsH/tDNl9qOG
 ow5jdEsCczxwl4MS5Pet3Ye59VIxfIvnZdR1tUGbpaUuRiKHar02Gvz91Gc8YDKNs2ckgVuw1wg
 ZiKZWHv5khXtdz5xVNHp9KWr3QCjlirO5gvJ21LY6MEWHWImYppdBmb+v5yNFbm9ZFSUgTxJ/u5
 ZCAeZdmA=
X-Received: by 2002:a05:6000:2403:b0:42b:40df:2336 with SMTP id
 ffacd0b85a97d-42f731c2b88mr9090951f8f.39.1764915289138; 
 Thu, 04 Dec 2025 22:14:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECs0WkrPLWRs2Ag3mGUZJGxE+C3heMG00m5AFYxibiqeB+c1V65NlwNePa2vve4UecgVg2iw==
X-Received: by 2002:a05:6000:2403:b0:42b:40df:2336 with SMTP id
 ffacd0b85a97d-42f731c2b88mr9090930f8f.39.1764915288697; 
 Thu, 04 Dec 2025 22:14:48 -0800 (PST)
Received: from [192.168.0.5] ([47.64.112.197])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d2226c5sm6982167f8f.23.2025.12.04.22.14.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Dec 2025 22:14:48 -0800 (PST)
Message-ID: <e1bc8e50-e429-4c18-9b48-caa12df5eadb@redhat.com>
Date: Fri, 5 Dec 2025 07:14:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/11] tests/lcitool: add bzip2 to the minimal
 dependency list
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20251204194902.1340008-1-alex.bennee@linaro.org>
 <20251204194902.1340008-5-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251204194902.1340008-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 04/12/2025 20.48, Alex Bennée wrote:
> You cannot build any softmmu targets without it

I'd assume it's only the targets that use a bzipped edk2 image?

  by default unless you
> build with --disable-install-blobs.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/lcitool/projects/qemu-minimal.yml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tests/lcitool/projects/qemu-minimal.yml b/tests/lcitool/projects/qemu-minimal.yml
> index 6bc232a1c3e..2a1ac51d402 100644
> --- a/tests/lcitool/projects/qemu-minimal.yml
> +++ b/tests/lcitool/projects/qemu-minimal.yml
> @@ -4,6 +4,7 @@ packages:
>    - bash
>    - bc
>    - bison
> + - bzip2
>    - ccache
>    - findutils
>    - flex

Anyway:
Reviewed-by: Thomas Huth <thuth@redhat.com>


