Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC112C28B2E
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 10:57:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsJlf-0001yA-Vx; Wed, 12 Mar 2025 06:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsJle-0001xp-Qx
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 06:56:54 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsJlc-0004zn-19
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 06:56:54 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3914aba1ce4so2442428f8f.2
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 03:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741777010; x=1742381810; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tV5ikHa/hqeuUpxvZXbkEG/9vcSHp1KdVgA38NjNalI=;
 b=lnaxca5vmYM5TXnecOBxMnHH1tKuI6bDVSWK30UGMqQmNYVgMsfLLG/TR7YLrnLO2i
 DcLvsxGkq7Eo9SZ9hGZVeNn0ocIhsFhkn0fj0N1M6HmhmzxkCZrvXNUqLhttlksazXlu
 d49cS0vdHkarRg0XCtZ130q7AgQDYA6lFKIU3t67utxa9bsI0NnuufxqIoJBPAdTewql
 AkbAdy+mAQPs5SLFf1g78Q3MsfJx0xp1PvANFxZI1b3KtWl9k9mm1NGgI+YYc4Sde7LM
 ONBKcm3CFLyQEOgWdNjZ0lGUILiAvxsKDLuZ/GCtaZk8vyj4H7Q7/J8lNor90kLH4NR6
 7qfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741777010; x=1742381810;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tV5ikHa/hqeuUpxvZXbkEG/9vcSHp1KdVgA38NjNalI=;
 b=cQSlTSbhxAJXiz/9lmkaoBgFqCyP8LvNuflXBqeZciDAOYaFGPced3tqufAzofcQ2/
 NaeIqGTKkdSnlwN2PDHEU2g37k25jaHfihx4bihG4q3UblH9rdTeovCYvvT1cmN89kPC
 czciNbZP/CJDSULupjKzp68zkH68q1vnEaQ16rw9NRB5pvMU5dUw6ZpLdRF9AKUKcf5/
 F30H+op+DB64jydCCD/StDViv3TeRP0PD7tWD69ayaLiOZe/7ft3GE777J1b9MnuV/l6
 1eZlEdu/ilL1ZKou3klC6Pb2hBLhFsmQPjwzzM9wxqRlD2r1IbuvoQNTyEs2pyt+WAEB
 SxDA==
X-Gm-Message-State: AOJu0YzJpUFrrru1u2TSX/xeoArYv8O0ZqGd4T/BOmgu/rssjYvWbHPj
 BoPo4rX/KrUU9uD3VbnNMfJX0RcOMeQ74C0FQUjT4SuGAPtxz+J6HY5m5L7Vm0U=
X-Gm-Gg: ASbGncvYtojZtE/65KV6iRqIz2GNPh5v+arHAjJ45/396f8NctTpZx3dGaNcxtur2Qa
 /7mG7I3EeD63pwg+eLwnX+IFYkUG+GrzKm06qfON10gtzEOEVsrhG9SxG8CUWRG+6nTftFxKuMp
 H4K61Oc6tBEJsqf/Ld+3tkPRKEOKxXuB+p3k5cEC863tdLsJVxoJeOqu+R+1ehvIrvvwDACN4kR
 gXn2ntKxy8zHLe1yjoIPnqjnwJgckYjSy8sWWiRMqr+KqEX+3PMvFkAo5hghLn80sHgxfXRuFz0
 tw5SxENW28MBocmK1kYn7wN1kUvTrgzZJ7kacTLOrXUa1rLYGcszlx6mSZtO319L8uAcYuqB6F/
 n+qGlQrfSusCKMlmW
X-Google-Smtp-Source: AGHT+IH78lNMOOj9tHNwxWRUQWsBTjT2y+rJEhcQrkW+E1Vuna+SjXsr3v9YRv4Nl2MkUvtRSj1Qzw==
X-Received: by 2002:a05:6000:1867:b0:390:f987:26a1 with SMTP id
 ffacd0b85a97d-39132d885bcmr13956309f8f.29.1741777009691; 
 Wed, 12 Mar 2025 03:56:49 -0700 (PDT)
Received: from [10.223.46.213] (99.167.185.81.rev.sfr.net. [81.185.167.99])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d0a74c6a1sm17257355e9.13.2025.03.12.03.56.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 03:56:49 -0700 (PDT)
Message-ID: <66943d63-7660-4317-9a41-0e45743397ab@linaro.org>
Date: Wed, 12 Mar 2025 11:56:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Giving your own patches your Reviewed-by
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Bibo Mao <maobibo@loongson.cn>, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <878qpamvk6.fsf@pond.sub.org> <Z9FlzR5xkTe1aOuW@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Z9FlzR5xkTe1aOuW@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 12/3/25 11:45, Daniel P. Berrangé wrote:
> On Wed, Mar 12, 2025 at 10:45:29AM +0100, Markus Armbruster wrote:
>> I stumbled over commits that carry the author's Reviewed-by.
>>
>> There may be cases where the recorded author isn't the lone author, and
>> the recorded author did some meaningful review of the patch's parts that
>> are not theirs.  Mind that we do need all authors to provide their
>> Signed-off-by.
>>
>> When the only Signed-off-by is from the recorded author, and there's
>> also their Reviewed-by, the Reviewed-by is almost certainly bogus.
>>
>> Now, accidents happen, no big deal, etc., etc.  I post this to hopefully
>> help reduce the accident rate :)
> 
> Is a commit with S-o-B and R-b from the matching author semantically any
> different from a commit with an author S-o-B and NO other 3rd party tag
> at all ?
> 
> The latter seems to be the more common case, with over a thousand examples
> of commits with no 3rd party NNN-By tags.
> 
> $ cat > no-3rd-party.pl <<EOF
> #!/usr/bin/perl
> 
> my @tags;
> my $commit;
> my $author;
> while (<>) {
>      if (/^commit ([a-z0-9]+)$/) {
> 	if (defined $commit) {
> 	    my $ok = 0;
> 	    foreach my $name (@tags) {
> 		if ($name ne $author) {
> 		    $ok = 1;
> 		    last;
> 		}
> 	    }
> 	    if (! $ok) {
> 		print ("$commit: $author\n");
> 	    }
> 	}
> 	
> 	$commit = $1;
> 	@tags = ();
>      } elsif (/^Author:\s+(.*)$/) {
> 	$author = $1;
>      } elsif (/\s+(Signed-off-by|Acked-by|Reviewed-by):\s+(.*)$/) {

By including Tested-by the list is reduced by 80, not much, still 8%.

> 	push @tags, $2;
>      }
> }
> EOF
> $ git log --no-merges --since 'two years ago'| perl no-rb.pl | wc -l
> 1296
> 
> That is 8% of all commits in 2 years seemingly having no 3rd party
> review.
> 
> Pretty much all of our core maintainers have commits exhibiting this,
> so I won't include any names.
> 
> Some of these will be just a case of forgetting to copy the R-bs
> from the list.
> 
> I suspect most are just a case of a maintainer making a pragmmatic
> judgement call to merge something having given up waiting for review,
> and not wanting to badger people into reviewing.
> 
> Most appear to be fairly trivial patches which is good. So that 8% of
> commits is probably at least an order of magnitude less lines of code
> changed in that timeframe, and the less "risky" code at that.
> 
> With regards,
> Daniel


