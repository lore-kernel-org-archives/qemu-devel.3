Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F53EE20B1
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 14:57:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voNDb-0006pl-P1; Fri, 06 Feb 2026 09:54:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1voNDF-0006iG-Bc
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 09:53:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1voNDB-0007qo-LV
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 09:53:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770389612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=L5NdCIr0Lx2oqVWyeYzn9gmzj9X1mQan9gCtKNB/0Sg=;
 b=WOhzH9NJMWqRDrIxNgn5Hu0MoW/wWdDE+sSDHIAJJK9KWhb27/hsuaMPj99P46yziN9msZ
 P5gOWA5bd/GDRi1mamyBvF6wnPR6vj4B6NividQYKw90QFNafCYce1SSr0D90qUN2d9zir
 0y1fVxCu9oSchcXnP51CI9aIFXdm0J8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-K6enOC-RODKJdGLVb28LqQ-1; Fri, 06 Feb 2026 09:53:27 -0500
X-MC-Unique: K6enOC-RODKJdGLVb28LqQ-1
X-Mimecast-MFC-AGG-ID: K6enOC-RODKJdGLVb28LqQ_1770389606
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4362456500eso2145466f8f.3
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 06:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770389606; x=1770994406; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=L5NdCIr0Lx2oqVWyeYzn9gmzj9X1mQan9gCtKNB/0Sg=;
 b=SXPnOMUTGQes90s2Kmbu/lLTC1sKFCxTFEOzW+yOTgQfHkcAJZ5R9rB5R62qC1q6ze
 skt+e1MlZca6qEq2bTLUU7a72BfBMAQeXatiabyvsWGCsh0W0xlcwfqt3XVOiY4wlkKb
 XHxT04R9Ie/p60K2QsUDXG0YPhJUEbYzhhfftthPha++DwYI+sGW6IgyehO0cKino4pL
 MgwDP5Cf1G36pqEQJNkJ3vY2ZjI/JN9O7JR9Y8pX8TdLo5j9kXrkr8AviGR6GFu5ZESq
 C/ts1y8KQJXU0wVOYB6ahtI5h+WFiRFMEAnVhZgivB1gZ/Up66ncH+oWwbh+5XrQetBT
 lYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770389606; x=1770994406;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L5NdCIr0Lx2oqVWyeYzn9gmzj9X1mQan9gCtKNB/0Sg=;
 b=FKc8RXziuGH4R+nBKPeLg1KX8GAEIQOzRu/e4jzCXQ9gtXt4SeZWSedVus5T6M+1JF
 UWV1uH/T2HP3vVUCD6KUgMrTRKFU1axE/jnUwzwuy2sWjQ3ycTC89MPELm0MqvgzDMv7
 oYv/EipkTSlaYTHlVggYFRIS/zbSi7gPgTMKRIcti4JA+uO/pQweAIcfZHmlbyRehG+x
 7iHez6ImTrhLbmFHtKhTPPXW7whtRQl8EmBibSc2II3JwSMOdPECDuECQpibAtDhIAIS
 wEq3FoZhxbe10IzbixVCZJKmdYGxkRi6euKuKHxMvcOfzBnoSv+MpS3KzPbsz25Bq7kC
 2JiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4F+Maf+cG7DjAqLUamOSqaKDhKlLdwcrTsVw6y5tRPpRl+gg1bKz5rVOkXJ0qqR1MFkZI9lKdjbaX@nongnu.org
X-Gm-Message-State: AOJu0YzUw01uW47SFe1ORg65QfimvpQ76mWMlhFdxK4gysz5UYOfxOPA
 XlnDf2lt2MUnj8olp3qJtY3DOnm46tt0bI0GO7hrUUf8yiJzv8IHobDlDg9appZPxyw4ri4/QSX
 4j1UkTjwujXXmKvkcAtbr/UdNJlRY+nDqlZuOJ5n940OiXpmTrRMeNdSt
X-Gm-Gg: AZuq6aKZ7nYecn3PT7POgSqm57Bk31OS+lk5G1SwoSCQIlJ4SXPSGyMeIprFpnsHP1u
 9UyzEw1OxagAPIwb6ivEWmEt8e47I/+HT2O6rob+JEVxxJilzWUE92GttclkhZNcRrSce1M1rLh
 SwbWOxic2m9Dp3BjSuY1tmk2MGFG62mLNXW2rcxhNFDJtFlisGlW1WLz7tFsXoncmlfNTkTY0WE
 /hm7nL4CFfnQ6DIN0KWnK3plt/AAxUtW8sT3+Mba9N/hyO/KYrMMA6ZGxplS05PJ7hrGm1/2jZb
 LztPS63EDBVurfvc4uvCRGaPLkvuPUWfVebfkGGJC8yKj4D+N1BF/nbObeNes12vAMwZ3fzHAxB
 mfP4rBxQ=
X-Received: by 2002:a05:6000:250f:b0:432:dc23:368 with SMTP id
 ffacd0b85a97d-4362937bd17mr4448948f8f.49.1770389605692; 
 Fri, 06 Feb 2026 06:53:25 -0800 (PST)
X-Received: by 2002:a05:6000:250f:b0:432:dc23:368 with SMTP id
 ffacd0b85a97d-4362937bd17mr4448918f8f.49.1770389605282; 
 Fri, 06 Feb 2026 06:53:25 -0800 (PST)
Received: from [192.168.0.9] ([47.64.115.203])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4362972fa4csm5967945f8f.26.2026.02.06.06.53.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Feb 2026 06:53:24 -0800 (PST)
Message-ID: <60a6e029-52a1-4482-9b01-702103e76ea5@redhat.com>
Date: Fri, 6 Feb 2026 15:53:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests: add run-tcg-tests-TARGET-softmmu to make check-help
To: ck <ckeong.teo17@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, philmd@linaro.org
References: <20260204014611.2267-1-ckeong.teo17@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 xsFNBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
 yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
 4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
 tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
 0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
 O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
 0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
 gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
 3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
 zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABzR5UaG9tYXMgSHV0
 aCA8dGh1dGhAcmVkaGF0LmNvbT7CwXgEEwECACIFAlVgX6oCGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEC7Z13T+cC21EbIP/ii9cvT2HHGbFRl8HqGT6+7Wkb+XLMqJBMAIGiQK
 QIP3xk1HPTsLfVG0ao4hy/oYkGNOP8+ubLnZen6Yq3zAFiMhQ44lvgigDYJo3Ve59gfe99KX
 EbtB+X95ODARkq0McR6OAsPNJ7gpEUzfkQUUJTXRDQXfG/FX303Gvk+YU0spm2tsIKPl6AmV
 1CegDljzjycyfJbk418MQmMu2T82kjrkEofUO2a24ed3VGC0/Uz//XCR2ZTo+vBoBUQl41BD
 eFFtoCSrzo3yPFS+w5fkH9NT8ChdpSlbNS32NhYQhJtr9zjWyFRf0Zk+T/1P7ECn6gTEkp5k
 ofFIA4MFBc/fXbaDRtBmPB0N9pqTFApIUI4vuFPPO0JDrII9dLwZ6lO9EKiwuVlvr1wwzsgq
 zJTPBU3qHaUO4d/8G+gD7AL/6T4zi8Jo/GmjBsnYaTzbm94lf0CjXjsOX3seMhaE6WAZOQQG
 tZHAO1kAPWpaxne+wtgMKthyPLNwelLf+xzGvrIKvLX6QuLoWMnWldu22z2ICVnLQChlR9d6
 WW8QFEpo/FK7omuS8KvvopFcOOdlbFMM8Y/8vBgVMSsK6fsYUhruny/PahprPbYGiNIhKqz7
 UvgyZVl4pBFjTaz/SbimTk210vIlkDyy1WuS8Zsn0htv4+jQPgo9rqFE4mipJjy/iboDzsFN
 BFH7eUwBEAC2nzfUeeI8dv0C4qrfCPze6NkryUflEut9WwHhfXCLjtvCjnoGqFelH/PE9NF4
 4VPSCdvD1SSmFVzu6T9qWdcwMSaC+e7G/z0/AhBfqTeosAF5XvKQlAb9ZPkdDr7YN0a1XDfa
 +NgA+JZB4ROyBZFFAwNHT+HCnyzy0v9Sh3BgJJwfpXHH2l3LfncvV8rgFv0bvdr70U+On2XH
 5bApOyW1WpIG5KPJlDdzcQTyptOJ1dnEHfwnABEfzI3dNf63rlxsGouX/NFRRRNqkdClQR3K
 gCwciaXfZ7ir7fF0u1N2UuLsWA8Ei1JrNypk+MRxhbvdQC4tyZCZ8mVDk+QOK6pyK2f4rMf/
 WmqxNTtAVmNuZIwnJdjRMMSs4W4w6N/bRvpqtykSqx7VXcgqtv6eqoDZrNuhGbekQA0sAnCJ
 VPArerAZGArm63o39me/bRUQeQVSxEBmg66yshF9HkcUPGVeC4B0TPwz+HFcVhheo6hoJjLq
 knFOPLRj+0h+ZL+D0GenyqD3CyuyeTT5dGcNU9qT74bdSr20k/CklvI7S9yoQje8BeQAHtdV
 cvO8XCLrpGuw9SgOS7OP5oI26a0548M4KldAY+kqX6XVphEw3/6U1KTf7WxW5zYLTtadjISB
 X9xsRWSU+Yqs3C7oN5TIPSoj9tXMoxZkCIHWvnqGwZ7JhwARAQABwsFfBBgBAgAJBQJR+3lM
 AhsMAAoJEC7Z13T+cC21hPAQAIsBL9MdGpdEpvXs9CYrBkd6tS9mbaSWj6XBDfA1AEdQkBOn
 ZH1Qt7HJesk+qNSnLv6+jP4VwqK5AFMrKJ6IjE7jqgzGxtcZnvSjeDGPF1h2CKZQPpTw890k
 fy18AvgFHkVk2Oylyexw3aOBsXg6ukN44vIFqPoc+YSU0+0QIdYJp/XFsgWxnFIMYwDpxSHS
 5fdDxUjsk3UBHZx+IhFjs2siVZi5wnHIqM7eK9abr2cK2weInTBwXwqVWjsXZ4tq5+jQrwDK
 cvxIcwXdUTLGxc4/Z/VRH1PZSvfQxdxMGmNTGaXVNfdFZjm4fz0mz+OUi6AHC4CZpwnsliGV
 ODqwX8Y1zic9viSTbKS01ZNp175POyWViUk9qisPZB7ypfSIVSEULrL347qY/hm9ahhqmn17
 Ng255syASv3ehvX7iwWDfzXbA0/TVaqwa1YIkec+/8miicV0zMP9siRcYQkyTqSzaTFBBmqD
 oiT+z+/E59qj/EKfyce3sbC9XLjXv3mHMrq1tKX4G7IJGnS989E/fg6crv6NHae9Ckm7+lSs
 IQu4bBP2GxiRQ+NV3iV/KU3ebMRzqIC//DCOxzQNFNJAKldPe/bKZMCxEqtVoRkuJtNdp/5a
 yXFZ6TfE1hGKrDBYAm4vrnZ4CXFSBDllL59cFFOJCkn4Xboj/aVxxJxF30bn
In-Reply-To: <20260204014611.2267-1-ckeong.teo17@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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


  Hi!

Thanks for your patch! A comment below...

On 04/02/2026 02.46, ck wrote:
...
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 7728098981..5a99f0a920 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -3,29 +3,30 @@
>   .PHONY: check-help
>   check-help:
>   	@echo "Regression testing targets:"
> -	@echo " $(MAKE) check                    Run block, qapi-schema, unit, softfloat, qtest and decodetree tests"
> -	@echo " $(MAKE) bench                    Run speed tests"
> +	@echo " $(MAKE) check                         Run block, qapi-schema, unit, softfloat, qtest and decodetree tests"
> +	@echo " $(MAKE) bench                         Run speed tests"
>   	@echo
>   	@echo "Individual test suites:"
> -	@echo " $(MAKE) check-qtest-TARGET       Run qtest tests for given target"
> -	@echo " $(MAKE) check-qtest              Run qtest tests"
> -	@echo " $(MAKE) check-functional         Run python-based functional tests"
> -	@echo " $(MAKE) check-functional-TARGET  Run functional tests for a given target"
> -	@echo " $(MAKE) check-unit               Run qobject tests"
> -	@echo " $(MAKE) check-qapi-schema        Run QAPI schema tests"
> -	@echo " $(MAKE) check-tracetool          Run tracetool generator tests"
> -	@echo " $(MAKE) check-block              Run block tests"
> +	@echo " $(MAKE) check-qtest-TARGET            Run qtest tests for given target"
> +	@echo " $(MAKE) check-qtest                   Run qtest tests"
> +	@echo " $(MAKE) check-functional              Run python-based functional tests"
> +	@echo " $(MAKE) check-functional-TARGET       Run functional tests for a given target"
> +	@echo " $(MAKE) check-unit                    Run qobject tests"
> +	@echo " $(MAKE) check-qapi-schema             Run QAPI schema tests"
> +	@echo " $(MAKE) check-tracetool               Run tracetool generator tests"
> +	@echo " $(MAKE) check-block                   Run block tests"
> +	@echo " $(MAKE) run-tcg-tests-TARGET-softmmu  Run TCG tests for a given target"
>   ifneq ($(filter $(all-check-targets), check-softfloat),)
> -	@echo " $(MAKE) check-tcg                Run TCG tests"
> -	@echo " $(MAKE) check-softfloat          Run FPU emulation tests"
> +	@echo " $(MAKE) check-tcg                     Run TCG tests"

Could you please move the new "run-tcg-tests..." line next to the check-tcg 
line, i.e. within the "ifneq" section? It's a subset of "check-tcg", i.e. 
TCG-based tests, so it does not make sense that we show this new line when 
QEMU has been configured with "--disable-tcg", but not the "check-tcg" line.

  Thanks,
   Thomas


> +	@echo " $(MAKE) check-softfloat               Run FPU emulation tests"
>   endif
>   	@echo
> -	@echo " $(MAKE) check-report.junit.xml   Generates an aggregated XML test report"
> -	@echo " $(MAKE) check-venv               Creates a Python venv for tests"
> -	@echo " $(MAKE) check-clean              Clean the tests and related data"
> +	@echo " $(MAKE) check-report.junit.xml        Generates an aggregated XML test report"
> +	@echo " $(MAKE) check-venv                    Creates a Python venv for tests"
> +	@echo " $(MAKE) check-clean                   Clean the tests and related data"
>   	@echo
>   	@echo "The following are useful for CI builds"
> -	@echo " $(MAKE) check-build              Build most test binaries"
> +	@echo " $(MAKE) check-build                   Build most test binaries"
>   	@echo
>   	@echo
>   	@echo "The variable SPEED can be set to control the gtester speed setting."


