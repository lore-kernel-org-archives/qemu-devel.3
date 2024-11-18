Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D65FFD44009
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 16:12:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD4MT-0005o5-GR; Mon, 18 Nov 2024 11:12:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tD4MM-0005nb-Mu
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 11:12:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tD4ML-0001Ax-0U
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 11:12:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731946334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IxotT6WZdmI31gIhATZAOCF1YXpsN6Vj81tRnaIcMgg=;
 b=Qotzm2enoh5KTU07lkmQRHF2FE6IvApph2D+BhjCnzgoscXUM5I8DGgU3Aix4hY0yKjmOk
 ws9x4ZDSCURJ/ui/vYW983sTgl4Lz5VjVjpTD+wwaNOK+PUffbYSevVzeK/svDcN1UPE2l
 ifYtKGszaF4N72TrDLwt+M5kkpcQCvA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-vMwBIlyhMmqmGMNKP4ZFMA-1; Mon, 18 Nov 2024 11:12:10 -0500
X-MC-Unique: vMwBIlyhMmqmGMNKP4ZFMA-1
X-Mimecast-MFC-AGG-ID: vMwBIlyhMmqmGMNKP4ZFMA
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38242c5b4ffso877542f8f.1
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 08:12:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731946329; x=1732551129;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IxotT6WZdmI31gIhATZAOCF1YXpsN6Vj81tRnaIcMgg=;
 b=lBck3E+v79ZqIwE2TBh4S1dcBmgZyjWQZEaXJr9bbFHUoN9LPSKpPUke/Zp+kBT0lR
 jRKxZTJ3vxca37JOkB+9v1JxVyE/LSA2G9MOvLjTtO89zlICiHWNDIoy8FHKBb+h4mbd
 xfs11PS1haCbuECjCBP0bz1dd7JUWhGjaxgFg505p8B7ib5h426hO9hYxEcrEI+Uigzr
 oaTQk721QC9lBiwN7BiqQxo91JhmevRDSpnA5q88UVhTHWM39XaE3gD4U+KnhmYdZCWu
 p7y9POtD9H2JT28yymeefFiN3oCZRk5lJbSraMshjZDUqnTqGkXQKjZwkzW6XRHDnIdi
 pKfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnFEpqUbDpYDPY8wCX5dMI/h8Trz/aHmfen/Asim9kwvPWMBhvz+2mbLHY3/vNdAMWOoRufamPxXYm@nongnu.org
X-Gm-Message-State: AOJu0YwAIUJNsB/5BHu9YCsz3NgkjP78qu3PBo8Tqfh8Mb5N/1VxijsZ
 SkieYgwHXqy3MYTMnAzwJrYVhsH58jeDSG36BI6UP5ZqYm1JmFvfTUxjl8FvZ8ncVvXhzJPw4nx
 ivcN+Yismssq34fHVLclSFINSaKhN/iP8sUthCvg1419rf6ERvJGb
X-Received: by 2002:a05:6000:2a4:b0:37c:d57d:71cd with SMTP id
 ffacd0b85a97d-38225aa5d2bmr10375383f8f.52.1731946329026; 
 Mon, 18 Nov 2024 08:12:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEou0ZjwdocPGFqvYfkY1LG8pkfMWV4syLcEsqrjC+g1gz0HaDfVkeXBpt0iZEkQV1+Mt7OQ==
X-Received: by 2002:a05:6000:2a4:b0:37c:d57d:71cd with SMTP id
 ffacd0b85a97d-38225aa5d2bmr10375365f8f.52.1731946328707; 
 Mon, 18 Nov 2024 08:12:08 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-145.web.vodafone.de.
 [109.42.48.145]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-382499cb523sm2620102f8f.4.2024.11.18.08.12.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2024 08:12:08 -0800 (PST)
Message-ID: <3b9cd004-bfbd-4bbd-a42f-482f7665c444@redhat.com>
Date: Mon, 18 Nov 2024 17:12:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] .gitlab-ci.d: Raise timeout on cross-accel build jobs to
 60m
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20241118153226.1524542-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
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
In-Reply-To: <20241118153226.1524542-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 18/11/2024 16.32, Peter Maydell wrote:
> The current 30 minute timeout on the cross_accel_build_job template
> is a bit low: sometimes if the k8s runners are running slow the
> can hit it, for example this cross-arm64-xen-only job hit the
> 30 minute timeout while still not quite finished with the compile:
> https://gitlab.com/qemu-project/qemu/-/jobs/8401277985
> 
> This is partly a "runner performance can be unpredictable" issue:
> https://gitlab.com/qemu-project/qemu/-/jobs/8391726482
> is the same job from just a day earlier and it finished in
> 16 minutes. But we already have build jobs that are higher
> timeouts than 30 minutes, so we have headroom to raise the
> timeout here to something we're less likely to hit on a slow
> runner.
> 
> Bump the cross_accel_build_job timeout to 60 mins.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   .gitlab-ci.d/crossbuild-template.yml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.gitlab-ci.d/crossbuild-template.yml b/.gitlab-ci.d/crossbuild-template.yml
> index 45a98103554..303943f818f 100644
> --- a/.gitlab-ci.d/crossbuild-template.yml
> +++ b/.gitlab-ci.d/crossbuild-template.yml
> @@ -57,7 +57,7 @@
>     extends: .base_job_template
>     stage: build
>     image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
> -  timeout: 30m
> +  timeout: 60m

IIRC the default timeout is 60 minutes, so we could also simply drop the 
line now. Anyway:

Reviewed-by: Thomas Huth <thuth@redhat.com>


