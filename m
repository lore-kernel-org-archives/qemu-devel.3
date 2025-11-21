Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA2ECFA478
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 07:44:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMLoQ-0002ZJ-TP; Fri, 21 Nov 2025 02:44:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMLoP-0002YT-9g
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 02:44:09 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMLoN-000601-MH
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 02:44:09 -0500
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-47778b23f64so9579715e9.0
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 23:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763711046; x=1764315846; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aCcRlu1oj9LDiWiu3tj29WAWDFToJ6D7iDnvl75vmwY=;
 b=M1tYBvKCHBhZLs7RCqsnTSsJgi1phSD6tx2eQlD5mKoenaZbxfs0j78F6E9peYhzwr
 uUOKsp8hKraNZ/rDpyytN5wT6qs4nB/Tv4z5JSOHecuEq1VOx+mdoQk7DlOiqIiWfWYT
 05TgaUXUdz6VMckd5YbZ9eThsk0ztD+JlBTY6DuhPdgXRaGzU0OvPeK0quaOtQdi+9nz
 sX4FLvsG7Ah2IehH3ES1p4j3z1jhPTQspnRkmS3zK5Yw9s9zLQAsTiuEVl723mf16pL5
 mnTJ4+ijhg3uFMFV2CZxBzcb6CrBvicmRN4TLaovC6nq4TycxTzld76jCYTYYzuPx0Ed
 ZQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763711046; x=1764315846;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aCcRlu1oj9LDiWiu3tj29WAWDFToJ6D7iDnvl75vmwY=;
 b=L2Xd8T6rT4lqjUCZJdb1ZCCe8JCI4jcApvEqy/0oQFn+UdfLTPBnP3Apr3Z+D7KbNZ
 yNp5ZcK0pneE2vuNpQv4mzxgQ+mmO1w8kxYD+JO/4xcgoALjeBB8trXKZhuNeHQPZnSr
 WxE0ikeyxE6KKLihCLMgSzUQF4vqEUbT5wAfD/SnL6+GRw4p/UYuUNb1UBSYpVTqSREc
 e76b2HGuhTxniNFY9o1f0yn2vgxpTSKQsS07SMGyfvblTlf/52AJ66NEjRqhdp/S+0yT
 LdadMd68w0/Hj+NuIcZxJvXd4NTrUz/uMsV0BQHINCP2LLeY94dLfWzJMBogukSoVTig
 NJPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX59zpqZ3dPcMyUqJNr1t2LujSKhM2s5YKfYa8hS73oP8JrCz4owLPV58hx5qR1hDt5MJPqOt4N3LFo@nongnu.org
X-Gm-Message-State: AOJu0Yy3oXpnBtXB05DskQsJMUmjM2EjDT/2Skr8zskpx7Zv8LacmCeg
 n+YgvdlYqljvnqNQ5fZmYBZU9bP84DElw5OwbdF0KOlOXmKDdcodBKU7walklrVGhqM=
X-Gm-Gg: ASbGncs1eSXxjWXoHUtL5sjbxylbI+1Sj71buCBB6pWRFhL0XRd6EXv+P+tkkjwz/lD
 4zrzjVtqPefQ/AykYKvUBMfAc/ZNsNJPD9KFEvUwH6GSVuY6D1HZQrp90DtiFWAJKue1490VoOz
 +C6Iw++6Fb14EJdQkymhx8pI5Hg1cY6QbTIOXpASeQ2zQMeK+WUvTJolEzhucHmCP7iUR9DVH22
 N1grRWVp7TAVX5blBxM1hUse8snRzQ/soyhMtPlR29P3vYorrjVpDrQXYMGmMrJAXFdLIYE1Q7U
 GmCCHyV/5+QbfvBBxwnEovstWKSm8gSNGqyjwIYpuUK5paPntKPsWnz0oiyJKp6h/n1MuIpY2Md
 AJg77xTmg4ruXFi3jrRKM+yTDSmlB8u6PRAnyTqCidO3WRFwKz0GsgZ9GDUQu31iK7x3sdBwnmG
 /4fQgzswaPcTB1CzdLfnkgpot6j46cnTKj9vcPmZMkCVOz5c+pQ6txBQ==
X-Google-Smtp-Source: AGHT+IG7WtQ5NfE7eibaVGbAsmLcCGhbkO7yHTXWYqDSIqE5K0XQK+R5kOHmrSdHrDLdf8lduwZLgg==
X-Received: by 2002:a05:600c:19ca:b0:477:a978:3a7b with SMTP id
 5b1f17b1804b1-477c1143073mr8613835e9.22.1763711045986; 
 Thu, 20 Nov 2025 23:44:05 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf1f3e63sm29792605e9.7.2025.11.20.23.44.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Nov 2025 23:44:05 -0800 (PST)
Message-ID: <60f547f6-59d6-4e60-aeb3-f096ed1d954e@linaro.org>
Date: Fri, 21 Nov 2025 08:44:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/16] docs/about/emulation: update assets for uftrace
 plugin documentation
Content-Language: en-US
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Ed Maste <emaste@freebsd.org>, Paul Durrant <paul@xen.org>,
 David Woodhouse <dwmw2@infradead.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Thomas Huth <thuth@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20251111171724.78201-1-alex.bennee@linaro.org>
 <20251111171724.78201-7-alex.bennee@linaro.org>
 <1166954d-d478-4cff-b1af-ba3246216707@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1166954d-d478-4cff-b1af-ba3246216707@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x342.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/11/25 02:38, Akihiko Odaki wrote:
> On 2025/11/12 2:17, Alex Bennée wrote:
>> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>
>> Linaro is discontinuing its fileserver service by end of the year.
>> Migrate assets to GitHub.
> 
> I wonder why they are moved to GitHub instead of share.linaro.org. They 
> look like plain binary blobs like other files moved to share.linaro.org 
> and don't need a version control.
> 
> If they are going to be on Git, why don't you put them on https:// 
> gitlab.com/qemu-project instead? I hope creating a repository there is 
> straightforward.
> 
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> ---
>>   docs/about/emulation.rst | 20 ++++++++++----------
>>   1 file changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
>> index 92c219119e8..4a7d1f41780 100644
>> --- a/docs/about/emulation.rst
>> +++ b/docs/about/emulation.rst
>> @@ -886,24 +886,24 @@ As an example, we can trace qemu itself running 
>> git::
>>       $ uftrace dump --chrome | gzip > ~/qemu_aarch64_git_help.json.gz
>>   For convenience, you can download this trace 
>> `qemu_aarch64_git_help.json.gz
>> -<https://fileserver.linaro.org/s/N8X8fnZ5yGRZLsT/download/ 
>> qemu_aarch64_git_help.json.gz>`_.
>> +<https://github.com/pbo-linaro/qemu-assets/raw/refs/heads/master/ 
>> qemu-uftrace/qemu_aarch64_git_help.json.gz>`_.
> 
> I think it's better to point to a specific commit so that e.g., files 
> can be renamed in the future. This URL will look like:
> https://github.com/pbo-linaro/qemu-assets/blob/ 
> ec68ed241bb303128537ac662d97e38972ff7257/qemu-uftrace/aarch64_boot.json.gz

Yes please.


